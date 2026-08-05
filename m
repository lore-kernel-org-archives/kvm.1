Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DF3C4B79;
	Wed,  5 Aug 2026 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899886; cv=none; b=HtXMqeTSQc2EK769OfSnPjR7IQB5aCHEjrMCT/1Od5esTg8Ic4xcczjEuDiK0LFuPTtUbENlZsp+ng4eBjIi0179vVlXVR6TYUtQ59Xvd/lRGUP9Sy1Nz5h3o3I+xMHJMxqkjtxEkGLwaMmPb1WMA47NFP/K6b9b0t/9q9wbasg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899886; c=relaxed/simple;
	bh=1OjaWqDNb3fJXjisI4xjXATn69NoieCfGBqXPPJ/DHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRZ7lBFQiWSUDj6mgRaufENsxc9kbmgMbjrhJq0ypAYo6hbVC2+WwomKBpVzmRkaVgwwYaoTA8ecmyYzG5F3TVkce1hQNpM886nckG+/ESFVC6tALnvktJg9+Ijppw7GYbrDN9amxrtC2iESa+y8GG0QgLi7169vSD50C7hH9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5LV1sn2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5LV1sn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785899883; x=1817435883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1OjaWqDNb3fJXjisI4xjXATn69NoieCfGBqXPPJ/DHQ=;
  b=B5LV1sn2nSfLI+8pwWUkFxNzs7qQdorikfL1J4Ro9mB0N1y1sHQQYANq
   qrC1Jro6ODjlL27W+r87oZxGzC8wJVtkXi4/K70GPC+SkjtYhEsSPI/7g
   Du4ChG/C4K7M1aAOjWYYO1XYz+hbLo4pOZdfALLln9Piw9ipuDMJ4wOhi
   qYywmhu7HKEepbjz3eftw4fwNK9QLxZ5Nv42c1AmcmquYAcLtKeXxkSML
   Qr1SSNnz4HJ750PkkBdci0ASTS5v4JbnI4m15FZjPBw1haIQ80cInIHv5
   +eK9U3LXhAaRZqxBVE9PBWUYpfDIATXOiiGg9Pb+CjIeU0OY6rwfLVQMk
   g==;
X-CSE-ConnectionGUID: Ym1hPE4pRr6t35W/nreopQ==
X-CSE-MsgGUID: qV4FsTv7RgaUzFJCghK0eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86493967"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="86493967"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 20:18:02 -0700
X-CSE-ConnectionGUID: pn76Nyi2TDmL9o89lUi6LA==
X-CSE-MsgGUID: CEH0aq8zTCSyAIMRgRP65A==
X-ExtLoop1: 1
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.33])
  by fmviesa003.fm.intel.com with ESMTP; 04 Aug 2026 20:17:58 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaoyao.li@intel.com
Subject: [PATCH 1/2] KVM: TDX: Enable Notify VM exit
Date: Wed,  5 Aug 2026 11:12:56 +0800
Message-ID: <20260805031257.1844914-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805031257.1844914-1-xiaoyao.li@intel.com>
References: <20260805031257.1844914-1-xiaoyao.li@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable Notify VM exit functionality for TDX guests.

Notify VM exit is an existing feature supported by KVM. Userspace can
enable Notify VM exit through KVM_CAP_X86_NOTIFY_VMEXIT when it's
reported as supported. However, KVM reports the support of this CAP just
based on the hardware capability but doesn't differentiate between VMX
and TDX. This leads to the issue that userspace can enable this cap for
TDX guests without getting an error, but the feature is not actually
enabled because KVM doesn't call the TDX module API to program the
relevant TD VMCS fields.

Enable Notify VM exit for TDX guests by:

  - Invoking TDX module API calls to set NOTIFY_VM_EXITING and Notify
    Window in TD VMCS. It's done in tdx_vcpu_init() where other TD VMCS
    bits are set. Since TDX vCPU cannot be reset, it only needs to be
    configured once when initializing the TDX vCPU.

  - Adding corresponding exit handler for TDX Notify VM Exit.

Note, Notify VM exit can happen when executing the IRET instruction. If
the IRET unblocks the NMI blocking state, bit 12 of the exit qualification
is set. In this case, the VMM needs to restore the "blocked by NMI" state
when it decides to re-enter the guest. For TDX, KVM cannot manage the
GUEST_INTERRUPTIBILITY_INFO and it's TDX module's responsibility to
handle it.

Fixes: 161d34609f9b ("KVM: TDX: Make TDX VM type supported")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
The enabling of Notify VM exit was missed in the initial upstreaming of
TDX base support. We suppose the patch needs to be backported to
stable kernels. So, the cc stable is added.
---
 arch/x86/kvm/vmx/tdx.c | 10 ++++++++++
 arch/x86/kvm/vmx/vmx.c | 23 +++++++++++++++--------
 arch/x86/kvm/vmx/vmx.h |  1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 545b03d9d10b..cdc0d24657ac 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2129,6 +2129,9 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 		 * - If it's not an MSMI, no need to do anything here.
 		 */
 		return 1;
+	case EXIT_REASON_NOTIFY:
+		/* NMI blocking state is handled by TDX module */
+		return __handle_notify(vcpu, false);
 	default:
 		break;
 	}
@@ -3157,6 +3160,13 @@ static int tdx_vcpu_init(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *cmd)
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
index cc75feec05da..9c5a7e5c907e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6266,20 +6266,22 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int handle_notify(struct kvm_vcpu *vcpu)
+int __handle_notify(struct kvm_vcpu *vcpu, bool handle_nmi_unblock)
 {
 	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
 	bool context_invalid = exit_qual & NOTIFY_VM_CONTEXT_INVALID;
 
 	++vcpu->stat.notify_window_exits;
 
-	/*
-	 * Notify VM exit happened while executing iret from NMI,
-	 * "blocked by NMI" bit has to be set before next VM entry.
-	 */
-	if (enable_vnmi && (exit_qual & INTR_INFO_UNBLOCK_NMI))
-		vmcs_set_bits(GUEST_INTERRUPTIBILITY_INFO,
-			      GUEST_INTR_STATE_NMI);
+	if (handle_nmi_unblock) {
+		/*
+		 * Notify VM exit happened while executing iret from NMI,
+		 * "blocked by NMI" bit has to be set before next VM entry.
+		 */
+		if (enable_vnmi && (exit_qual & INTR_INFO_UNBLOCK_NMI))
+			vmcs_set_bits(GUEST_INTERRUPTIBILITY_INFO,
+				      GUEST_INTR_STATE_NMI);
+	}
 
 	if (vcpu->kvm->arch.notify_vmexit_flags & KVM_X86_NOTIFY_VMEXIT_USER ||
 	    context_invalid) {
@@ -6292,6 +6294,11 @@ static int handle_notify(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int handle_notify(struct kvm_vcpu *vcpu)
+{
+	return __handle_notify(vcpu, true);
+}
+
 static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 {
 	return vmx_get_instr_info_reg(vmcs_read32(VMX_INSTRUCTION_INFO));
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..79431b5e9bcb 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -379,6 +379,7 @@ bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned int flags);
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu);
 
 void vmx_set_intercept_for_msr(struct kvm_vcpu *vcpu, u32 msr, int type, bool set);
+int __handle_notify(struct kvm_vcpu *vcpu, bool handle_nmi_unblock);
 
 static inline void vmx_disable_intercept_for_msr(struct kvm_vcpu *vcpu,
 						 u32 msr, int type)
-- 
2.43.0

