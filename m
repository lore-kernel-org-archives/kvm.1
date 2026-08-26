Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DF392836
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764383; cv=none; b=mJlA7Lbe4fcsI3YoZuTulRqhptmrEUTmL9EDnt8dL/1TCGlMRx77T2IXSzfF//dDnoX6Q574XTEtz/4k39zJ2Hu6b/A+r5W55CNXK1arHS/V+m81E5itQU7mOo35ARa1ftmEQYTSBlDVj9iy1SXnTklaO8Y5K/R9AgytQvHdvmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764383; c=relaxed/simple;
	bh=+uDr5cwVaTDiUyoRvqw+6+bOi/G/sFwFQqXd7puX1sw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSW27+W2ZiMP2IJ7RWi4/cd8DSsrNXf5ynvzlmFi1KrqFlDKpuHywz9Ymx4nSPhmjda739HZO82qwrnVyIfbfR8XIG9wlU5qdko2GrJDYNzbqHHRs4q7VAwE6N/nBAU7i9FE6lras/SvULQFqu5/Z6EQnz8oqI8jOhh5P+N7Gzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tcdvAP88; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tcdvAP88"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce14a21faso1453485ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787764370; x=1788369170; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L6siIiM1cF+ZrS/MrgVIwhxh+wLPXtr92wLuqHkS8k0=;
        b=tcdvAP88URuxrOV9h1bEC5nXW5zuLrceEpTlzUbIYs4XMUE/u4I/6URhyzboZs+FqH
         IYvTUzyg+uJo5OZKKdgeUN1MG7/9aFUnj/r6z4xBbL6x+LAz16IfPXNu83GlhzTBkins
         4calXw6ycRI18+EwnXvgvrhDQDwFnWyKCz5qYKL1ByCA54FmdDq/GRKERT7/3AUIEgkt
         FfdXNkt5Je2mi8CsUIpJLWKxdFyKOoxhTG+RwvA/3x3ZhBvvZoPg+7ytIaj9z4TTnTzd
         u0TX2oKsUnLMIyDjhpXmzkD6VjWMbgFE9tfPJt4sqoV1mnwSqDFZ8f92btILEBq48RSE
         fX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764370; x=1788369170;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L6siIiM1cF+ZrS/MrgVIwhxh+wLPXtr92wLuqHkS8k0=;
        b=DLpPHp0EBdDBfXmC5mZlvniUHPW+QHTIbTn+mWzaJx2rPqkPzz7c04RLoaEeB+DVP/
         PEd3iVufsOTn3brHqm1ymGBTaGmlrRO1+gE8lb6olWLel0OsJhnBhw6xZOq8gHMoTweU
         HASZWsjs8yxpqi9YpIrgyUms4tKNDAyQxeWOsILRJIgyn/nwYPOdCftysIZuEVGSKmUY
         0GDNTOhzc0wZIUorcSBXMbRzRdFJfgVJ3etKmi2AjLGGgsxjWl69ilNvsbJ9dLznN9Bv
         I0BbQHtlhxfpFnr3l1TqtmlDSVPfJupoe3JPKoQ2ZPtEUTD29ntcl+IPXRu3muxwpA8o
         geyQ==
X-Gm-Message-State: AFuF++mTDxGX1ZzAHX0UH7H7eQHG8qfuD6b2X0gPf48RwKupk9+VejXF
	rxy5cAJpzMLbUjIC5I6QpQSfSFcRcyLZhDvlVW1kS7XfHAYLLFiHWv5Vg4FsPD8jmrDOdvKJcSE
	Vaf9wfA==
X-Received: from plbke13.prod.google.com ([2002:a17:903:340d:b0:2cc:c59c:76ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d491:b0:2cf:b9f9:18bb
 with SMTP id d9443c01a7336-2d726114a0bmr5694605ad.4.1787764369805; Wed, 26
 Aug 2026 10:12:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 10:12:39 -0700
In-Reply-To: <20260826171246.777729-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826171246.777729-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826171246.777729-2-seanjc@google.com>
Subject: [PATCH v2 1/8] KVM: VMX: Move the shared "IRQs off" exit handler(s)
 to common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
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
index 4c52ab8d0786..274200b0a307 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/entry-common.h>
 #include <linux/moduleparam.h>
 
 #include "x86_ops.h"
@@ -876,6 +877,74 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
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
@@ -1000,7 +1069,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
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
2.55.0.887.g758fc8c411-goog

