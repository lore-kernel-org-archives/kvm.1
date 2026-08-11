Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877823909F;
	Tue, 11 Aug 2026 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786408294; cv=none; b=VQgwUCqnKjTv4xMIH6Y0LIsbl7TUYWab+Fs2ABAOHTQV9TcA+RlvfpuQJkqc62yZbOIdI0K4mvSVKUPGz/BHMVcx4/Mzw24kQ/XIZLJtKhRHtQYhU0PkcArhQjtoJpthzJ44phM9pDD9KY/lU/Krmdfdt9Eztv7pYN49wE0ep9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786408294; c=relaxed/simple;
	bh=PlML28fPHIWbjfqA+93921gTEAnis92hqz5OxNfAAfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHRIPyFtWjDNrl0qHS5m3vdAm3XJ5X0bRyQ9/BWhrqJvty0puR6b8l2O+zcGBxb44mVyS1CO6MtIAlLMh68QIwzj7FABH12k6tawvEIORkCx4BwyVjlwt1JsJCTlTFevEe86eQY2FrabGUsDRfxInswotOAywPfU466Jy9S6ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FfVFF13r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FfVFF13r"
Received: from fedora (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D398620B710C;
	Mon, 10 Aug 2026 17:31:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D398620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786408268;
	bh=9B9wUG3AQFjgftpZouiNukd3GodNGyEPx12NsN8Y0tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfVFF13rxdF+zfxmxqV0FvaSOktrcN9ZpA4phd/N+TFtYNU4+S2UTAXlGjb9Hqqqm
	 F4egS5PZeFNdLPJLLdMbPSG6/PkRq/viku3mftNwSlMUVUyFc33BlUdVEso86hCGSn
	 fqc1HS/dDT7w9TP/so9pQJ/Nz+HyHVkKp8pXl1og=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] KVM: x86: exit VM-plane config/activate hypercalls to userspace
Date: Mon, 10 Aug 2026 17:31:12 -0700
Message-ID: <20260811003114.30107-3-snambakam@linux.microsoft.com>
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

Handle the guest's plane-setup hypercalls by exiting to the VMM:

  KVM_HC_VM_PLANES_CONFIG    - allocate plane memory
  KVM_HC_VM_PLANES_ACTIVATE  - create and activate the plane vCPU

Both exit via KVM_EXIT_HYPERCALL (gated by KVM_CAP_EXIT_HYPERCALL, hence
added to KVM_EXIT_HYPERCALL_VALID_MASK) and are completed by userspace.
This is what brings a secure plane and its vCPU into existence; the
in-kernel VBS plane-switch handlers are added separately.
---
 arch/x86/kvm/x86.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0ace79c957bb..3b21c72fc9e0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -119,7 +119,10 @@ u64 __read_mostly efer_reserved_bits = ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
 static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 #endif
 
-#define KVM_EXIT_HYPERCALL_VALID_MASK (1 << KVM_HC_MAP_GPA_RANGE)
+#define KVM_EXIT_HYPERCALL_VALID_MASK			\
+	((1 << KVM_HC_MAP_GPA_RANGE)		|	\
+	 (1 << KVM_HC_VM_PLANES_CONFIG)		|	\
+	 (1 << KVM_HC_VM_PLANES_ACTIVATE))
 
 #define KVM_CAP_PMU_VALID_MASK KVM_PMU_CAP_DISABLE
 
@@ -10559,6 +10562,30 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		vcpu->arch.complete_userspace_io = complete_hypercall;
 		return 0;
 	}
+	case KVM_HC_VM_PLANES_CONFIG:
+	case KVM_HC_VM_PLANES_ACTIVATE:
+		/*
+		 * VM plane setup: hand off to the VMM, which allocates plane
+		 * memory (CONFIG) and creates + activates the plane vCPU
+		 * (ACTIVATE).  Serviced entirely in userspace.
+		 */
+		if (!user_exit_on_hypercall(vcpu->kvm, nr))
+			break;
+
+		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
+		vcpu->run->hypercall.nr       = nr;
+		vcpu->run->hypercall.ret      = 0;
+		vcpu->run->hypercall.args[0]  = a0;
+		vcpu->run->hypercall.args[1]  = a1;
+		vcpu->run->hypercall.args[2]  = a2;
+		vcpu->run->hypercall.args[3]  = a3;
+		vcpu->run->hypercall.flags    = 0;
+		if (op_64_bit)
+			vcpu->run->hypercall.flags |= KVM_EXIT_HYPERCALL_LONG_MODE;
+
+		WARN_ON_ONCE(vcpu->run->hypercall.flags & KVM_EXIT_HYPERCALL_MBZ);
+		vcpu->arch.complete_userspace_io = complete_hypercall;
+		return 0;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
-- 
2.55.0

