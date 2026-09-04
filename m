Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA30331200
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483840; cv=none; b=QkG2dAX2Zf+PJvdPMxQgjN/v9VKYJ6qMH4NarP6/k9E9VB7KhETWC1J9IUWleTYS+zbqZ8oAu3hpnXofoIAiDBz2I0OoN4bA2OZ3L2IT8IWfwJA/fG0RXkg4yl6LgoViFZi9SpvkVzag32Ds2ZGcZBPDsaHcbFydkUGzGBHJNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483840; c=relaxed/simple;
	bh=Z7WjmCyz0PA8ZuhgOlbJ2FSysCdg3wrQRYnbQ7PKCxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZgXCGoQn0VaoQuGz3yEj8G7BdXcuyj0qOSj0DPYSvsdWtVUJ0C6jlUt43/GZLJa54+aEDlIe1p3r+JFJJkNAZKYE45hFGwCUrOBoLPnggbSe7XvxC02QcRpcWTFRi7R+PqI4Mv37uUdzYK25UkXUu3SQWmwZHIxFpOQSvGaUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GvweUmHG; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvweUmHG"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c89704da8c7so667823a12.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483838; x=1789088638; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rwIVt5DW98yzoIxj1eFFQhL2958LlabcKwUulILLX+Q=;
        b=GvweUmHGUgfq0NmdYcn1V52BR5wd5eTXe9z2oRaOU70qWYVusnulXk1BUk+Ubwj1ks
         5baujFqHGbGCZHOAHKIcdbhicpUn8gDXpxifiDA7tu/1dtRaVc06fmBVhGZ9r4xiCudn
         Jrf7mt4q4/gsa0wr3loibuGLUl9Do5XLDTTxMWwH4pAv+psffL+Fca1f8Vy1syj3VTk4
         utwOFobpkEZjb0xmUQLOid3YXypnWLlQgiZB1fLCjt/ib7XhjRZiPZeR9z7oy6pdUlaX
         i4VoKDVIVg5091cmb4wl6CBTZwNu5EbsjMy19CuhY5ZlprxFlbyK3xUO3c8BnFGHBskS
         BpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483838; x=1789088638;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rwIVt5DW98yzoIxj1eFFQhL2958LlabcKwUulILLX+Q=;
        b=pUQxqYLgnBrbZjd+TA4rXWBi1P/bVtD5RKyKvy2A+poRGSiSxIn0RsCB3VlwIQnFIi
         LcGGiPnk21v2Bjm9IvtCr1lwHMkGL9aVmjUxC4k09p4y/F10NnNcV8upX3sHpnGvEqT3
         +cfFrAdqaIBAPRFV/egIWyii4xdzbzH26cY4f1j/F+ZIZrpepB1nKDGuiSfbvQlUxF30
         ifbM0PIOdlbt5Rl8lY755857P0IhxNW7AHE4D0ilfEYDM3yBryArq8nKZAp3nEprE3Gj
         74M9By0QpoW0F3S0QK+BL4ZK0Ju2gFyXIS/NgnYPh3MqsSevKbZEC6H4WrownU7zTSmH
         8hjg==
X-Gm-Message-State: AFuF++mlgnBxwSggky2Wf6KSvgp3FxCPRdU9N62+pv6KuBqM4kNCEg/Z
	uLXZY7r1sf4cYkFtebfRPYQoHQdSDg5QNzPBfrcckgiWMnK31EpTLjZwebLXvag+h8qdMluCEQD
	TMzrerQ==
X-Received: from pjtd16.prod.google.com ([2002:a17:90b:50:b0:384:f6e1:ff87])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5866:b0:398:e73e:5a13
 with SMTP id 98e67ed59e1d1-39b2613272amr3739100a91.9.1788483837661; Thu, 03
 Sep 2026 18:03:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:47 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-3-seanjc@google.com>
Subject: [PATCH v3 2/8] KVM: VMX: Move the shared "IRQs off" exit handler(s)
 to common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move vmx_handle_exit_irqoff() and its helpers to common.h / main.c to
capture that it's a common handler and to allow guarding against incorrectly
using to_vmx().

Opportunistically use a "vt" prefix instead of "vmx" to communicate that
it's a shared handler.

No functional change intended.

Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h  |  6 ++++
 arch/x86/kvm/vmx/main.c    | 71 +++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.c     | 74 --------------------------------------
 arch/x86/kvm/vmx/x86_ops.h |  1 -
 4 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 08005676702c..88f637c81353 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -74,6 +74,12 @@ static __always_inline bool is_td_vcpu(struct kvm_vcpu *vcpu) { return false; }
 
 #endif
 
+static inline bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.guest_fpu.fpstate->xfd &&
+	       !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS);
+}
+
 static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
 {
 	/* For TDX the direct mask is the shared mask. */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index ea0d825e556d..9614f43e7987 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/entry-common.h>
 #include <linux/moduleparam.h>
 
 #include "x86_ops.h"
@@ -878,6 +879,74 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 #define vt_op_tdx_only(name) NULL
 #endif /* CONFIG_KVM_INTEL_TDX */
 
+static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
+	 * MSR value is not clobbered by the host activity before the guest
+	 * has chance to consume it.
+	 *
+	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
+	 * interception may have been caused by L1 interception.  Per the SDM,
+	 * XFD_ERR is not modified for non-XFD #NM, i.e. if CR0.TS=1.
+	 *
+	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
+	 * unlike CR2 and DR6, the value is not a payload that is attached to
+	 * the #NM exception.
+	 */
+	if (is_xfd_nm_fault(vcpu))
+		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
+}
+
+static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
+{
+	/* if exit due to PF check for async PF */
+	if (is_page_fault(intr_info))
+		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
+	/* if exit due to NM, handle before interrupts are enabled */
+	else if (is_nm_fault(intr_info))
+		handle_nm_fault_irqoff(vcpu);
+	/* Handle machine checks before interrupts are enabled */
+	else if (is_machine_check(intr_info))
+		kvm_machine_check();
+}
+
+static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
+					     u32 intr_info)
+{
+	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
+
+	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
+	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
+		return;
+
+	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
+	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+	kvm_after_interrupt(vcpu);
+
+	vcpu->arch.at_instruction_boundary = true;
+}
+
+static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
+{
+	if (to_vt(vcpu)->emulation_required)
+		return;
+
+	switch (vmx_get_exit_reason(vcpu).basic) {
+	case EXIT_REASON_EXTERNAL_INTERRUPT:
+		handle_external_interrupt_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		break;
+	case EXIT_REASON_EXCEPTION_NMI:
+		handle_exception_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		break;
+	case EXIT_REASON_MCE_DURING_VMENTRY:
+		kvm_machine_check();
+		break;
+	default:
+		break;
+	}
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
@@ -1002,7 +1071,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.load_mmu_pgd = vt_op(load_mmu_pgd),
 
 	.check_intercept = vmx_check_intercept,
-	.handle_exit_irqoff = vmx_handle_exit_irqoff,
+	.handle_exit_irqoff = vt_handle_exit_irqoff,
 
 	.update_cpu_dirty_logging = vt_op(update_cpu_dirty_logging),
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 504630f0eb40..adf2bc13bed2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5379,12 +5379,6 @@ bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu)
 	       (kvm_get_rflags(vcpu) & X86_EFLAGS_AC);
 }
 
-static bool is_xfd_nm_fault(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.guest_fpu.fpstate->xfd &&
-	       !kvm_is_cr0_bit_set(vcpu, X86_CR0_TS);
-}
-
 static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 {
 	unsigned long cr2 = vmx_get_exit_qual(vcpu);
@@ -7143,74 +7137,6 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Save xfd_err to guest_fpu before interrupt is enabled, so the
-	 * MSR value is not clobbered by the host activity before the guest
-	 * has chance to consume it.
-	 *
-	 * Update the guest's XFD_ERR if and only if XFD is enabled, as the #NM
-	 * interception may have been caused by L1 interception.  Per the SDM,
-	 * XFD_ERR is not modified for non-XFD #NM, i.e. if CR0.TS=1.
-	 *
-	 * Note, XFD_ERR is updated _before_ the #NM interception check, i.e.
-	 * unlike CR2 and DR6, the value is not a payload that is attached to
-	 * the #NM exception.
-	 */
-	if (is_xfd_nm_fault(vcpu))
-		rdmsrq(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
-}
-
-static void handle_exception_irqoff(struct kvm_vcpu *vcpu, u32 intr_info)
-{
-	/* if exit due to PF check for async PF */
-	if (is_page_fault(intr_info))
-		vcpu->arch.apf.host_apf_flags = kvm_read_and_reset_apf_flags();
-	/* if exit due to NM, handle before interrupts are enabled */
-	else if (is_nm_fault(intr_info))
-		handle_nm_fault_irqoff(vcpu);
-	/* Handle machine checks before interrupts are enabled */
-	else if (is_machine_check(intr_info))
-		kvm_machine_check();
-}
-
-static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
-					     u32 intr_info)
-{
-	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
-
-	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
-	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
-		return;
-
-	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
-	kvm_after_interrupt(vcpu);
-
-	vcpu->arch.at_instruction_boundary = true;
-}
-
-void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu)
-{
-	if (to_vt(vcpu)->emulation_required)
-		return;
-
-	switch (vmx_get_exit_reason(vcpu).basic) {
-	case EXIT_REASON_EXTERNAL_INTERRUPT:
-		handle_external_interrupt_irqoff(vcpu, vmx_get_intr_info(vcpu));
-		break;
-	case EXIT_REASON_EXCEPTION_NMI:
-		handle_exception_irqoff(vcpu, vmx_get_intr_info(vcpu));
-		break;
-	case EXIT_REASON_MCE_DURING_VMENTRY:
-		kvm_machine_check();
-		break;
-	default:
-		break;
-	}
-}
-
 /*
  * The kvm parameter can be NULL (module initialization, or invocation before
  * VM creation). Be sure to check the kvm parameter before using it.
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 054fd14bb2e1..7ac02c68457f 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -27,7 +27,6 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_put(struct kvm_vcpu *vcpu);
 int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
-void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
 bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu);
-- 
2.55.0.979.g7e5102b832-goog

