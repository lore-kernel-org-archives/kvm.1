Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F72453A50;
	Wed,  5 Aug 2026 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785927849; cv=none; b=jPZrzO1XkhBNR9Ibu+BesEqp8Lq03h0EZzPFRvdw2/WZVIDUl6W0Eag3CmAUqERlLzLZQ7A1WOk0txFujE20NCgjwNVbcypbT9Sbb3wg8h58fwwwDeDD9dGRokDjNH3GkFbMWv+7QkGbtuEp/SL4TxuvUfsN5FPBH61vk3xCpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785927849; c=relaxed/simple;
	bh=+fYJcgdArIlnXh9ktpBWsb3Jl/kG4rP5Z6JxbGMNUIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXxPMorya/vVBVGOCuvjB1gGj6ytTtAewiA/FvC3mxXuC6h1q9rZZP3v74OzkUowQPZJrnBW+P2vR5rxtvqDumg+uJHCOBOGWi4j1LtszZD0Q+EASDn38mE/UepSfg7r2Eh901+zcRNqS2IEYefcVPJVu8NMF5sISeoEp/6mQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E2CTWX4t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E2CTWX4t"
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2ACAE20B716C;
	Wed,  5 Aug 2026 04:03:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2ACAE20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785927826;
	bh=sq9iQqfm/Xa43a8fE6xVfiPF9fdPsEklWW/dBFeNuZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2CTWX4tA2cg77Qcr620QOMzDuT1IlUfzNioIoTZLIlS04c+t+jFOEWTwcpmxdxKc
	 k4MRKov2QioKPoFJmayBobFDHElgPbb1zWAmzvdKjMTrHwUb18w6X4uN+ZjoIxzB+y
	 zJ6Au4CnjU3pTVf3cOzEo/wOXD8dlv0UtFjGqNkU=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 28/42] KVM: x86: add VBS VTL call/return and cross-plane set-mem-attrs hypercalls
Date: Wed,  5 Aug 2026 04:03:10 -0700
Message-ID: <20260805110324.25067-29-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110324.25067-1-snambakam@linux.microsoft.com>
References: <20260805110324.25067-1-snambakam@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the in-kernel handling for the VBS secure-plane hypercalls so the
plane switch happens without bouncing through userspace:

 - KVM_HC_VBS_VTL_CALL: the normal plane (plane 0) records the
   calling-area GPA and switches to the secure plane. While the secure
   plane is still booting the call is parked (vtl_call_pending) and
   delivered once the plane parks itself; once ready (vtl_plane_ready)
   the GPA is delivered directly via kvm_vcpu_switch_plane().

 - KVM_HC_VBS_VTL_RETURN: the secure plane parks and hands control back
   to plane 0, marking itself ready and delivering any pending call.

 - KVM_HC_VBS_SET_MEM_ATTRS: the secure plane applies cross-plane EPT
   restrictions to a lower plane via kvm_vm_set_mem_attributes()
   (rejected from plane 0).

Track the per-CPU bootstrap state (vtl_plane_ready, vtl_call_pending,
vtl_call_ca) in kvm_vcpu_common and assign the new hypercall numbers
KVM_HC_VBS_VTL_RETURN (16) and KVM_HC_VBS_SET_MEM_ATTRS (17).

Signed-off-by: Sriram Nambakam <snambakam@linux.microsoft.com>
---
 arch/x86/kvm/x86.c            | 139 +++++++++++++++++++++++++++++++++-
 include/linux/kvm_host.h      |  17 +++++
 include/uapi/linux/kvm_para.h |   2 +
 3 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eb82dde62399..3c73ab1dcfe8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10588,9 +10588,145 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		vcpu->arch.complete_userspace_io = complete_hypercall;
 		return 0;
 	}
+	case KVM_HC_VBS_VTL_CALL:
+#ifdef CONFIG_VM_PLANES
+		/*
+		 * Runtime VBS/VTL call from the normal world (plane 0) into the
+		 * secure plane.  Serviced in-kernel by switching to the secure
+		 * plane (plane 1) — no userspace round trip.  This is
+		 * arch-neutral: it works for both Intel (VMX) and AMD (SVM), and
+		 * mirrors the SEV-SNP in-kernel VMPL switch.  a0 carries the
+		 * guest-physical address of the shared calling area.
+		 *
+		 * Two cases:
+		 *  - Secure plane already booted and parked in its dispatch loop
+		 *    (vtl_plane_ready): deliver the calling-area GPA directly in
+		 *    RAX (its pending VTL return value) and switch to it.
+		 *  - Secure plane not booted yet (bootstrap): record the call as
+		 *    pending and switch to the secure plane so it boots; it will
+		 *    pick up the pending GPA when it reaches its first VTL return.
+		 *
+		 * If there is no secure plane configured at all, fall through to
+		 * the userspace path so QEMU can service the call.
+		 */
+		if (vcpu->plane_level == 0) {
+			struct kvm_vcpu_common *common = vcpu->common;
+			struct kvm_vcpu *secure = common->vcpus[1];
+
+			if (secure) {
+				common->vtl_call_ca = a0;
+
+				if (common->vtl_plane_ready) {
+					/* Parked in vtl_return: deliver now. */
+					kvm_rax_write(secure, a0);
+					common->vtl_call_pending = false;
+				} else {
+					/* Still booting: deliver on readiness. */
+					common->vtl_call_pending = true;
+				}
+
+				if (kvm_vcpu_switch_plane(vcpu, secure) == 1) {
+					ret = 0;
+					goto out;
+				}
+				ret = -KVM_EINVAL;
+				goto out;
+			}
+		}
+#endif /* CONFIG_VM_PLANES */
+		goto vtl_userspace_exit;
+	case KVM_HC_VBS_VTL_RETURN:
+#ifdef CONFIG_VM_PLANES
+		/*
+		 * The secure plane (plane >0) hands control back to plane 0
+		 * in-kernel.  This covers three situations:
+		 *  - Bootstrap "ready": the secure plane has just booted and is
+		 *    issuing its first VTL return to announce it is parked.
+		 *  - Normal completion: it has finished servicing a VTL call;
+		 *    the result is already in the shared calling area.
+		 *  - A call that arrived while the secure plane was still booting
+		 *    is now delivered (vtl_call_pending) by returning its
+		 *    calling-area GPA in RAX and keeping the secure plane running.
+		 * a0 is an optional status carried for tracing only.
+		 */
+		if (vcpu->plane_level == 0) {
+			ret = -KVM_EPERM;
+			goto out;
+		} else {
+			struct kvm_vcpu_common *common = vcpu->common;
+
+			common->vtl_plane_ready = true;
+
+			if (common->vtl_call_pending) {
+				/*
+				 * Deliver the call that triggered the secure
+				 * plane's boot: return its calling-area GPA and
+				 * stay in the secure plane to service it.  The
+				 * GPA is delivered as this hypercall's return
+				 * value (RAX) via the normal completion path; do
+				 * not write RAX directly here, as the completion
+				 * handler would overwrite it with hypercall.ret.
+				 */
+				common->vtl_call_pending = false;
+				ret = common->vtl_call_ca;
+				goto out;
+			}
+
+			if (kvm_vcpu_switch_plane(vcpu, common->vcpus[0]) == 1) {
+				ret = 0;
+				goto out;
+			}
+		}
+#endif /* CONFIG_VM_PLANES */
+		ret = -KVM_EINVAL;
+		goto out;
+	case KVM_HC_VBS_SET_MEM_ATTRS:
+#if defined(CONFIG_VM_PLANES) && defined(CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES)
+		/*
+		 * The secure plane (plane >0) enforces EPT permissions on the
+		 * normal plane's memory.  It cannot issue the host
+		 * KVM_SET_MEMORY_ATTRIBUTES ioctl, so it asks KVM to do it via
+		 * this hypercall.  Only a higher-privilege plane may call it.
+		 *
+		 *   a0 = guest-physical address (page aligned)
+		 *   a1 = region size in bytes  (page aligned)
+		 *   a2 = access bits to retain for lower planes:
+		 *        bit0 read (implicit), bit1 write, bit2 exec
+		 *        (matches VBS_MEM_READ/WRITE/EXEC)
+		 */
+		if (vcpu->plane_level == 0) {
+			ret = -KVM_EPERM;
+			goto out;
+		}
+
+		if (!PAGE_ALIGNED(a0) || !PAGE_ALIGNED(a1) || a1 == 0 ||
+		    a0 + a1 < a0) {
+			ret = -KVM_EINVAL;
+			goto out;
+		} else {
+			unsigned long attrs = 0;
+			gfn_t start = a0 >> PAGE_SHIFT;
+			gfn_t end = (a0 + a1) >> PAGE_SHIFT;
+
+			if (!(a2 & BIT(1)))
+				attrs |= KVM_MEMORY_ATTRIBUTE_NO_WRITE;
+			if (!(a2 & BIT(2)))
+				attrs |= KVM_MEMORY_ATTRIBUTE_NO_EXEC;
+
+			if (kvm_vm_set_mem_attributes(vcpu->kvm, start, end,
+						      attrs))
+				ret = -KVM_EINVAL;
+			else
+				ret = 0;
+			goto out;
+		}
+#else
+		ret = -KVM_ENOSYS;
+		goto out;
+#endif /* CONFIG_VM_PLANES && CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 	case KVM_HC_VM_PLANES_CONFIG:
 	case KVM_HC_VM_PLANES_ACTIVATE:
-	case KVM_HC_VBS_VTL_CALL: {
+	vtl_userspace_exit:
 		ret = -KVM_ENOSYS;
 		if (!user_exit_on_hypercall(vcpu->kvm, nr))
 			break;
@@ -10609,7 +10745,6 @@ int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 		WARN_ON_ONCE(vcpu->run->hypercall.flags & KVM_EXIT_HYPERCALL_MBZ);
 		vcpu->arch.complete_userspace_io = complete_hypercall;
 		return 0;
-	}
 	default:
 		ret = -KVM_ENOSYS;
 		break;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c6cf2b6c0076..f14d78fd8cd3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -386,6 +386,23 @@ struct kvm_vcpu_common {
 
 	bool plane_switch;
 
+#ifdef CONFIG_VM_PLANES
+	/*
+	 * VBS/VTL secure-plane bootstrap state (per logical CPU).
+	 *
+	 * @vtl_plane_ready: the secure plane has booted and parked itself in
+	 *                   its dispatch loop (issued its first VTL return).
+	 * @vtl_call_pending: a normal-plane VTL call has been registered but
+	 *                    not yet delivered to the secure plane (used while
+	 *                    the secure plane is still booting).
+	 * @vtl_call_ca:      guest-physical address of the pending call's
+	 *                    shared calling area.
+	 */
+	bool vtl_plane_ready;
+	bool vtl_call_pending;
+	u64 vtl_call_ca;
+#endif
+
 	struct kvm_vcpu_arch_common arch;
 };
 
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 1703238952fb..eec4fce6b33a 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -33,6 +33,8 @@
 #define KVM_HC_VM_PLANES_CONFIG		13
 #define KVM_HC_VM_PLANES_ACTIVATE	14
 #define KVM_HC_VBS_VTL_CALL		15
+#define KVM_HC_VBS_VTL_RETURN		16
+#define KVM_HC_VBS_SET_MEM_ATTRS	17
 
 /*
  * hypercalls use architecture specific
-- 
2.55.0

