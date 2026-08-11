Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5252C3268;
	Tue, 11 Aug 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408295; cv=none; b=BwN+K9b9gaxxeONRLSLAHH/e0wD6a7FgRw0k4gVKmeM3mhQIWU9ZljqkqsrMxa/1IxOUfdGkTqvD15dERLrbqYHClny+A6O9KUdSZDeFh5x5lxuMj5YzIRxwK0IFp/a7DMD7eKuFjWvjcom8fFi6UNc/kd0D7x7wxiU4Wx3HVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408295; c=relaxed/simple;
	bh=X2gDkJrhub4RLPoSLzH2T+AXO5dgvBTFjEv9Xwdg/pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4sJg5I4Iugmw2CsZaqFWSwanXoupYvrgzqoJueobhDoEV7Ft77eQYAdvTPQvqMt9UDz2Gn140Q0N/qGNQDaQBWgx/LDEPz+8z+M9tVZnw2UVq5pli9lUIdSepk2BAbag3wtfOQspdJlF7Gvfa8WNl/n4ivcaUzwTmG4TmF2n/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TMXIQaY/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TMXIQaY/"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 635C520B7168;
	Mon, 10 Aug 2026 17:31:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 635C520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786408270;
	bh=QWonNg9bBg9eBj1ISNDCL4Dgir2Ss9XqWPONSIkrtPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TMXIQaY/bWOGOMJ6s6GkJIkE06QCXvVSkYwoaqjxp8WL6GmH8YNcxVaebzP3mL6JI
	 /6Ey9GPm7PmwgyiR9cLyc97UaAWcWQJ3scYQRD7OoixxXwspE6JbA5283prXEAW2In
	 k93zaSfYIM2hXIT7Ly9XdkZG6oqm0c4FfyYfHnxY=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/4] KVM: x86: handle VBS VTL call/return via in-kernel plane switch
Date: Mon, 10 Aug 2026 17:31:14 -0700
Message-ID: <20260811003114.30107-5-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811003114.30107-1-snambakam@linux.microsoft.com>
References: <20260811003114.30107-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Service the VBS inter-plane hypercalls in-kernel, with no userspace round
trip, by switching planes:

  KVM_HC_VBS_VTL_CALL   - the normal plane (0) calls into the secure plane
                          (1).  a0 is the guest-physical address of the
                          shared calling area; deliver it to the secure
                          plane's pending VTL return (or mark it pending if
                          the secure plane is still booting) and switch.
  KVM_HC_VBS_VTL_RETURN - the secure plane (>0) hands control back to plane
                          0, announcing readiness and delivering any call
                          that arrived while it was booting.

The switch reuses the per-plane scheduling (kvm_vcpu_set_plane_runnable/
stopped + KVM_REQ_PLANE_RESCHED).
---
 arch/x86/kvm/x86.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3b21c72fc9e0..35fbe0776a3e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10562,6 +10562,65 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		vcpu->arch.complete_userspace_io = complete_hypercall;
 		return 0;
 	}
+	case KVM_HC_VBS_VTL_CALL: {
+		/*
+		 * Runtime VBS call from the normal plane (0) into the secure
+		 * plane (1), serviced in-kernel by switching planes.  a0 is the
+		 * guest-physical address of the shared calling area.  If the
+		 * secure plane is parked in its VTL return, deliver the GPA as
+		 * that return's value now; otherwise mark it pending so the
+		 * secure plane picks it up on its first return.
+		 */
+		struct kvm_vcpu_common *common = vcpu->common;
+		struct kvm_vcpu *secure;
+
+		if (vcpu->plane_level != 0)
+			break;
+
+		secure = common->vcpus[1];
+		if (!secure)
+			break;
+
+		common->vtl_call_ca = a0;
+		if (common->vtl_plane_ready) {
+			kvm_rax_write_raw(secure, a0);
+			common->vtl_call_pending = false;
+		} else {
+			common->vtl_call_pending = true;
+		}
+
+		kvm_vcpu_set_plane_runnable(secure);
+		kvm_vcpu_set_plane_stopped(vcpu);
+		ret = 0;
+		break;
+	}
+	case KVM_HC_VBS_VTL_RETURN: {
+		/*
+		 * The secure plane (>0) hands control back to plane 0.  On its
+		 * first return it announces readiness; if a call arrived while
+		 * it was still booting, deliver that calling-area GPA now and
+		 * stay in the secure plane.  Otherwise switch back to plane 0.
+		 */
+		struct kvm_vcpu_common *common = vcpu->common;
+
+		if (vcpu->plane_level == 0) {
+			ret = -KVM_EPERM;
+			break;
+		}
+
+		common->vtl_plane_ready = true;
+
+		if (common->vtl_call_pending) {
+			common->vtl_call_pending = false;
+			ret = common->vtl_call_ca;
+			break;
+		}
+
+		kvm_vcpu_set_plane_runnable(common->vcpus[0]);
+		kvm_vcpu_set_plane_stopped(vcpu);
+		ret = 0;
+		break;
+	}
 	case KVM_HC_VM_PLANES_CONFIG:
 	case KVM_HC_VM_PLANES_ACTIVATE:
 		/*
-- 
2.55.0

