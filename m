Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F115945041B;
	Wed, 19 Aug 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133265; cv=none; b=bB1yTs4pK3CPsp+l89BAs21YNGlAfa666HDVg7SA+KYuhhKh7PEsQCBlHvH9xFw/Rm8Z9vJTRIM73wucnoYCUCz6HccSeBNvfljTLpCE76g4ODP5JL6BRn5nCkltvFYO2bOFZF16clYLVVs8qCK7rZ0SywvmyO3x3v6XbAsQVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133265; c=relaxed/simple;
	bh=8dXk8T96SEGXh0tSYxF32Ot0xtSPFjRMIOB8kBupyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMjZn0I0TGljkPcQG9TlCPjEX78467q0/PlRqI2c1VobrX79eeZ1+1JHXyq7u8syzIHTJMGhI6dkzA2pHzG0wPkbvms3kF9L8HmHATvNrJkVS8788OU9E5GIFtwy3K+Q9Cx00NHl6YwYZ43F78qCgScMGpIjgyRMTH93t9voRbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfTzEoUZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfTzEoUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787133261; x=1818669261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8dXk8T96SEGXh0tSYxF32Ot0xtSPFjRMIOB8kBupyuY=;
  b=nfTzEoUZK1+xXfMfVQilkFzkPCfvtGniBhW1/3UmabrF6ZvUkgnncoVt
   JZjunhqgaceifZAiYY9WGZFBRYzlz1mKNNG9WMWTmLk3Lx2ZOIbrOIcvG
   pAzJfjdBnbMENgxCLctHTRsSBP6DYnsgOm7/NazP73AqZRHeSQ90xrzo5
   oKaRkO8hSQBCMn/HXdo5BcL1f/ARc/78zJbFfeD43FJTrNRGpwKs0qFuT
   50MjeR/ABcHS7tdsj8gdAe/Ncade/yFcjrFoDJKRe9T0oTKXn/lSGZM0N
   sDvnRuns6Csg1bDk31Ldcl5/wcckWy3QQSbPGLz5kfB0EsI5OxxFNuOUZ
   w==;
X-CSE-ConnectionGUID: 1yBnZNvGR2K8DFyaMCCoHQ==
X-CSE-MsgGUID: jYh77S7VRN6Gxk/0toYHXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87514806"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87514806"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 02:54:15 -0700
X-CSE-ConnectionGUID: R/bnebrLQD6gWBxXp2/zhQ==
X-CSE-MsgGUID: VmK28p59QfiLHmiyGPVL2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303708831"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 02:54:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	nik.borisov@suse.com
Subject: [PATCH v4 1/9] KVM: TDX: Enable Notify VM exit
Date: Wed, 19 Aug 2026 17:48:55 +0800
Message-ID: <20260819094903.3060020-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819094903.3060020-1-xiaoyao.li@intel.com>
References: <20260819094903.3060020-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Notify VM exit functionality for TDX guests.

Notify VM exit is an existing feature supported by KVM.  Userspace can
enable Notify VM exit through KVM_CAP_X86_NOTIFY_VMEXIT when it's
reported as supported.  However, KVM reports the support of this CAP just
based on the hardware capability but doesn't differentiate between VMX
and TDX.  This leads to the issue that userspace can enable this cap for
TDX guests without getting an error, but the feature is not actually
enabled because KVM doesn't call the TDX module API to program the
relevant TD VMCS fields.

Enable Notify VM exit for TDX guests by:

  - Invoking TDX module API calls to set NOTIFY_VM_EXITING and Notify
    Window in TD VMCS.  It's done in tdx_vcpu_init() where other TD VMCS
    bits are set.  Since TDX vCPU cannot be reset, it only needs to be
    configured once when initializing the TDX vCPU.

  - Adding corresponding exit handler for TDX Notify VM Exit.

Notify VM exit can happen when executing the IRET instruction.  If the
IRET unblocks the NMI blocking state, bit 12 of the exit qualification
is set.  In this case, the VMM needs to restore the "blocked by NMI" state
when it decides to re-enter the guest.  For TDX, KVM cannot manage the
GUEST_INTERRUPTIBILITY_INFO and it's TDX module's responsibility to
handle it.  Extract the common part without NMI blocking handling into a
helper in common.h so that it can be shared between VMX and TDX.

Note, KVM uses "pre-production" terminology for the feature formally called
Notify VM-Exit.  All public versions of the SDM refer to the feature as
Instruction Timeout.  This will be remedied in the near future, for now,
use KVM's terminology for consistency.

Note, #2, there is no enumeration bit for Notify VM exit by TDX module
because all TDX modules support it, and allow to set the corresponding
TD VMCS fields as long as the hardware supports the feature.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Changes in v4:
- rename __vmx_handle_notify() to __vt_handle_notify(), to better
  reflect it is a shared helper for both VMX and TDX.

Changes in v3:
- Collect R-b tag from Rick.

Changes in v2:
- Mention the feature name mismatch between KVM and SDM in changelog and
  leave the renaming to future, since this patch is targeted for stable
- Extract the common handling into a helper, and put the helper in
  common.h instead of refactorin the existing handle_notify() in vmx.h
- Add a note to clarify the feature is always supported by TDX module,
  to make Sashiko happy.
---
 arch/x86/kvm/vmx/common.h | 19 +++++++++++++++++++
 arch/x86/kvm/vmx/tdx.c    | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 08005676702c..7fce1bbabc78 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -4,6 +4,7 @@
 
 #include <linux/kvm_host.h>
 #include <asm/posted_intr.h>
+#include <asm/vmx.h>
 
 #include "mmu.h"
 
@@ -183,6 +184,24 @@ static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
 	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
 }
 
+static inline int __vt_handle_notify(struct kvm_vcpu *vcpu,
+				     unsigned long exit_qual)
+{
+	bool context_invalid = exit_qual & NOTIFY_VM_CONTEXT_INVALID;
+
+	++vcpu->stat.notify_window_exits;
+
+	if (vcpu->kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_USER ||
+	    context_invalid) {
+		vcpu->run->exit_reason = KVM_EXIT_NOTIFY;
+		vcpu->run->notify.flags = context_invalid ?
+					  KVM_NOTIFY_CONTEXT_INVALID : 0;
+		return 0;
+	}
+
+	return 1;
+}
+
 noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..d557840687d2 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2126,6 +2126,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 		 * - If it's not an MSMI, no need to do anything here.
 		 */
 		return 1;
+	case EXIT_REASON_NOTIFY:
+		/* NMI blocking state is handled by TDX module */
+		return __vt_handle_notify(vcpu, vmx_get_exit_qual(vcpu));
 	default:
 		break;
 	}
@@ -3154,6 +3157,13 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
 	td_vmcs_write64(tdx, POSTED_INTR_DESC_ADDR, __pa(&tdx->vt.pi_desc));
 	td_vmcs_setbit32(tdx, PIN_BASED_VM_EXEC_CONTROL, PIN_BASED_POSTED_INTR);
 
+	if (kvm_notify_vmexit_enabled(vcpu->kvm)) {
+		td_vmcs_setbit32(tdx, SECONDARY_VM_EXEC_CONTROL,
+				 SECONDARY_EXEC_NOTIFY_VM_EXITING);
+		td_vmcs_write32(tdx, NOTIFY_WINDOW,
+				vcpu->kvm->arch.notify_window);
+	}
+
 	tdx->state = VCPU_TD_STATE_INITIALIZED;
 
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..35ac9ddffaf4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6279,9 +6279,6 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
-	bool context_invalid = exit_qual & NOTIFY_VM_CONTEXT_INVALID;
-
-	++vcpu->stat.notify_window_exits;
 
 	/*
 	 * Notify VM exit happened while executing iret from NMI,
@@ -6291,15 +6288,7 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 		vmcs_set_bits(GUEST_INTERRUPTIBILITY_INFO,
 			      GUEST_INTR_STATE_NMI);
 
-	if (vcpu->kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_USER ||
-	    context_invalid) {
-		vcpu->run->exit_reason = KVM_EXIT_NOTIFY;
-		vcpu->run->notify.flags = context_invalid ?
-					  KVM_NOTIFY_CONTEXT_INVALID : 0;
-		return 0;
-	}
-
-	return 1;
+	return __vt_handle_notify(vcpu, exit_qual);
 }
 
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
-- 
2.43.0

