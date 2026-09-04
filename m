Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF4A37BE9F
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483855; cv=none; b=qeNfFdvtshtaEgpuvpqOaJPcMvZpd0z/cn3IEDDrgjROcXZC6cyD5sCJUO5hsVSbb8nyGellpagq/TwBrgMUdL9P2SqS2v4BhUSO9DXSJDP7is44PYjWnr44gJSSVyWY/MZrhGdEwkSDEO7ikJa028HGmYYMLYS8w/AsFspp6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483855; c=relaxed/simple;
	bh=VGPXQlZM3zYiIjJXKmP0J/C4KEUGfs1eAU33XXQJ8go=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jUfVr1B9tX4oBPLwddCtUeQGtVKktjktJ9/Fdhx2YrLozVdCvnWHakgAQnMY9cwGSpjuf+JrumMveEJFL0I3Pt0/n/kTGQj5djTylq1+7Bxiann940L09RA4T6UESkHRP41ObDSZxlTyI+I+rmPY0l/VqtB6/wpNY7yoH8FjZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lcc9GkQF; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcc9GkQF"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49aa4525b82so615970b6e.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483845; x=1789088645; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JtCM8hZGo3q10xA4m4kRoLqc4XCX1WLO1DlU2VIpNIU=;
        b=lcc9GkQFgHmomyfkwJR5Yx3btNmqtJyryRvSYL6DFbca5FAGiuwgREMggu/qs+Anq9
         kjVIp+M0qF2h5bDV/rxRBlw/PAo2p33M0ccLk5qz8H0H7j4A0piOxLWDvTtMvXynJgLi
         sC1mpc1/n5dUTLLxHkeC2YD8oXd8sRyoAfSrShH2HjEcPS+jVMZaQ4p+Zyvx9qNolWJW
         DCN2yR/Ckdu3qXa58Darq3u3tH52YWkufJA4NVPV/8yvUrRzYI73z+lfLWAKHytDDhdd
         h75nGF6ZKJ0SQxZIss/VAbXw9tgXgZYnlCiaLg0LVVh9U5QwAurCLq1XeOCp4anN23yF
         amBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483845; x=1789088645;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JtCM8hZGo3q10xA4m4kRoLqc4XCX1WLO1DlU2VIpNIU=;
        b=O2uNpv3wji0tiYXNYuFN/u2TiQvptKpC22xlsTiL2IlvUcc0w2GGfprIttE25MIhdr
         MTDi78iZblr5H9G0yUjlafol1/HkbVmKMnRqKpC5dPsbdKYUKfUwiVsK9lW2c9OLbGgl
         g2HxeMM0CmDgF+z9zd+xMk5CgH5GEAXR/p0pI++uE9ZjzNHjjkF/j45szt5CJCciKgJ2
         teG118imU/Gq1ik33+4mdz1LWtcgg1LL2J4ksnf7eYCftcGWVLLdYFHQt7GuNhVVPchT
         O9Q7dkBUwyrqwFXkH1twBmILWhi6lB0mzCQm1Uhph2cQF2VFqxtyNjhLshHKz1Zkvmxs
         lRDw==
X-Gm-Message-State: AFuF++krXGJd/gJgYoquyh0ZAFfw6DphdQ3+BS5kby8ueRQPrIiFhr20
	c+xwdd17VITkaXlitbHQEfSBqdSHLXMYFwdfduDvgfRRiKmEpTgYDznkARIcK3FjAx8q51MMSd3
	GxFTUng==
X-Received: from pgdo11-n1.prod.google.com ([2002:a05:6a02:620b:10b0:cc1:5155:bdd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1509:b0:4b3:7c33:456
 with SMTP id 5614622812f47-4b96153c38bmr2134759b6e.11.1788483844866; Thu, 03
 Sep 2026 18:04:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:53 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-9-seanjc@google.com>
Subject: [PATCH v3 8/8] KVM: VMX: Rename common exit info getters prefixes
 from "vmx" to "vt"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename all common prefixes for the APIs that get exit information common to
VMX and TDX from "vmx" to "vt" to capture that they are used for both VMX
and TDX vCPUs.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h |  6 ++--
 arch/x86/kvm/vmx/main.c   | 10 +++----
 arch/x86/kvm/vmx/nested.c | 36 +++++++++++------------
 arch/x86/kvm/vmx/tdx.c    | 22 +++++++-------
 arch/x86/kvm/vmx/vmx.c    | 60 +++++++++++++++++++--------------------
 5 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index c9ca0824734a..3e68fa12aca6 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -91,12 +91,12 @@ static __always_inline struct kvm_vcpu *vt_to_vcpu(struct vcpu_vt *vt)
 	return &(container_of(vt, struct vcpu_vmx_tdx, vt)->vcpu);
 }
 
-static __always_inline union vmx_exit_reason vmx_get_exit_reason(struct kvm_vcpu *vcpu)
+static __always_inline union vmx_exit_reason vt_get_exit_reason(struct kvm_vcpu *vcpu)
 {
 	return to_vt(vcpu)->exit_reason;
 }
 
-static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
+static __always_inline unsigned long vt_get_exit_qual(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
 
@@ -107,7 +107,7 @@ static __always_inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 	return vt->exit_qualification;
 }
 
-static __always_inline u32 vmx_get_intr_info(struct kvm_vcpu *vcpu)
+static __always_inline u32 vt_get_intr_info(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt = to_vt(vcpu);
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 0151baa56598..6e0b3959d73a 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -934,12 +934,12 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 	if (to_vt(vcpu)->emulation_required)
 		return;
 
-	switch (vmx_get_exit_reason(vcpu).basic) {
+	switch (vt_get_exit_reason(vcpu).basic) {
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
-		handle_external_interrupt_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		handle_external_interrupt_irqoff(vcpu, vt_get_intr_info(vcpu));
 		break;
 	case EXIT_REASON_EXCEPTION_NMI:
-		handle_exception_irqoff(vcpu, vmx_get_intr_info(vcpu));
+		handle_exception_irqoff(vcpu, vt_get_intr_info(vcpu));
 		break;
 	case EXIT_REASON_MCE_DURING_VMENTRY:
 		kvm_machine_check();
@@ -951,8 +951,8 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 
 noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu)
 {
-	if ((u16)vmx_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
-	    !is_nmi(vmx_get_intr_info(vcpu)))
+	if ((u16)vt_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
+	    !is_nmi(vt_get_intr_info(vcpu)))
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 151873407abd..47599e7312cf 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -446,7 +446,7 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 		 * "NMI unblocking due to IRET", i.e. the bit can be propagated
 		 * as-is from the original EXIT_QUALIFICATION.
 		 */
-		exit_qualification = vmx_get_exit_qual(vcpu) & INTR_INFO_UNBLOCK_NMI;
+		exit_qualification = vt_get_exit_qual(vcpu) & INTR_INFO_UNBLOCK_NMI;
 	} else {
 		if (fault->error_code & PFERR_RSVD_MASK) {
 			vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
@@ -472,7 +472,7 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 			 * and walks the faulting GPA.
 			 */
 			if (from_hardware)
-				exit_qualification |= vmx_get_exit_qual(vcpu) & mask;
+				exit_qualification |= vt_get_exit_qual(vcpu) & mask;
 			else
 				exit_qualification |= fault->exit_qualification & mask;
 
@@ -4747,7 +4747,7 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 {
 	/* update exit information fields: */
 	vmcs12->vm_exit_reason = vm_exit_reason;
-	if (vmx_get_exit_reason(vcpu).enclave_mode)
+	if (vt_get_exit_reason(vcpu).enclave_mode)
 		vmcs12->vm_exit_reason |= VMX_EXIT_REASONS_SGX_ENCLAVE_MODE;
 	vmcs12->exit_qualification = exit_qualification;
 
@@ -5373,7 +5373,7 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer,
 	struct x86_exception e;
 	int r;
 
-	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
+	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
 				vmcs_read32(VMX_INSTRUCTION_INFO), false,
 				sizeof(*vmpointer), &gva)) {
 		*ret = 1;
@@ -5665,7 +5665,7 @@ static int handle_vmread(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
@@ -5771,7 +5771,7 @@ static int handle_vmwrite(struct kvm_vcpu *vcpu)
 {
 	struct vmcs12 *vmcs12 = is_guest_mode(vcpu) ? get_shadow_vmcs12(vcpu)
 						    : get_vmcs12(vcpu);
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct x86_exception e;
@@ -5960,7 +5960,7 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 /* Emulate the VMPTRST instruction */
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qual = vt_get_exit_qual(vcpu);
 	u32 instr_info = vmcs_read32(VMX_INSTRUCTION_INFO);
 	gpa_t current_vmptr = to_vmx(vcpu)->nested.current_vmptr;
 	struct x86_exception e;
@@ -6021,7 +6021,7 @@ static int handle_invept(struct kvm_vcpu *vcpu)
 	/* According to the Intel VMX instruction reference, the memory
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
-	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
+	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
 			vmx_instruction_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
@@ -6104,7 +6104,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 	/* according to the intel vmx instruction reference, the memory
 	 * operand is read even if it isn't needed (e.g., for type==global)
 	 */
-	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
+	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
 			vmx_instruction_info, false, sizeof(operand), &gva))
 		return 1;
 	r = kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e);
@@ -6236,8 +6236,8 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 	 * EXIT_REASON_VMFUNC as the exit reason.
 	 */
 	nested_vmx_vmexit(vcpu, vmx->vt.exit_reason.full,
-			  vmx_get_intr_info(vcpu),
-			  vmx_get_exit_qual(vcpu));
+			  vt_get_intr_info(vcpu),
+			  vt_get_exit_qual(vcpu));
 	return 1;
 }
 
@@ -6288,7 +6288,7 @@ static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
 	if (!nested_cpu_has(vmcs12, CPU_BASED_USE_IO_BITMAPS))
 		return nested_cpu_has(vmcs12, CPU_BASED_UNCOND_IO_EXITING);
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 
 	port = exit_qualification >> 16;
 	size = (exit_qualification & 7) + 1;
@@ -6314,7 +6314,7 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 
 	if (exit_reason.basic == EXIT_REASON_MSR_READ_IMM ||
 	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
-		msr_index = vmx_get_exit_qual(vcpu);
+		msr_index = vt_get_exit_qual(vcpu);
 	else
 		msr_index = kvm_ecx_read(vcpu);
 
@@ -6350,7 +6350,7 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 static bool nested_vmx_exit_handled_cr(struct kvm_vcpu *vcpu,
 	struct vmcs12 *vmcs12)
 {
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	int cr = exit_qualification & 15;
 	int reg;
 	unsigned long val;
@@ -6484,7 +6484,7 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 
 	switch ((u16)exit_reason.basic) {
 	case EXIT_REASON_EXCEPTION_NMI:
-		intr_info = vmx_get_intr_info(vcpu);
+		intr_info = vt_get_intr_info(vcpu);
 		if (is_nmi(intr_info))
 			return true;
 		else if (is_page_fault(intr_info))
@@ -6567,7 +6567,7 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 
 	switch ((u16)exit_reason.basic) {
 	case EXIT_REASON_EXCEPTION_NMI:
-		intr_info = vmx_get_intr_info(vcpu);
+		intr_info = vt_get_intr_info(vcpu);
 		if (is_nmi(intr_info))
 			return true;
 		else if (is_page_fault(intr_info))
@@ -6737,14 +6737,14 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	 * need to be synthesized by querying the in-kernel LAPIC, but external
 	 * interrupts are never reflected to L1 so it's a non-issue.
 	 */
-	exit_intr_info = vmx_get_intr_info(vcpu);
+	exit_intr_info = vt_get_intr_info(vcpu);
 	if (is_exception_with_error_code(exit_intr_info)) {
 		struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 
 		vmcs12->vm_exit_intr_error_code =
 			vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
 	}
-	exit_qual = vmx_get_exit_qual(vcpu);
+	exit_qual = vt_get_exit_qual(vcpu);
 
 reflect_vmexit:
 	nested_vmx_vmexit(vcpu, exit_reason.full, exit_intr_info, exit_qual);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a3d6f0fb5951..efbb1ac6f51e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -741,7 +741,7 @@ bool tdx_interrupt_allowed(struct kvm_vcpu *vcpu)
 	 * interrupt is always allowed unless TDX guest calls TDVMCALL with HLT,
 	 * which passes the interrupt blocked flag.
 	 */
-	return vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
+	return vt_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
 	       !to_tdx(vcpu)->vp_enter_args.r12;
 }
 
@@ -759,7 +759,7 @@ static bool tdx_protected_apic_has_interrupt(struct kvm_vcpu *vcpu)
 	 * otherwise the interrupt would have been serviced at the instruction
 	 * boundary.
 	 */
-	if (vmx_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
+	if (vt_get_exit_reason(vcpu).basic != EXIT_REASON_HLT ||
 	    to_tdx(vcpu)->vp_enter_args.r12)
 		return false;
 
@@ -981,8 +981,8 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 
 static bool tdx_failed_vmentry(struct kvm_vcpu *vcpu)
 {
-	return vmx_get_exit_reason(vcpu).failed_vmentry &&
-	       vmx_get_exit_reason(vcpu).full != -1u;
+	return vt_get_exit_reason(vcpu).failed_vmentry &&
+	       vt_get_exit_reason(vcpu).full != -1u;
 }
 
 static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
@@ -1131,7 +1131,7 @@ void tdx_inject_nmi(struct kvm_vcpu *vcpu)
 
 static int tdx_handle_exception_nmi(struct kvm_vcpu *vcpu)
 {
-	u32 intr_info = vmx_get_intr_info(vcpu);
+	u32 intr_info = vt_get_intr_info(vcpu);
 
 	/*
 	 * Machine checks are handled by handle_exception_irqoff(), or by
@@ -1903,7 +1903,7 @@ void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcpu)
 {
 	u64 eeq_type = to_tdx(vcpu)->ext_exit_qualification & TDX_EXT_EXIT_QUAL_TYPE_MASK;
-	u64 eq = vmx_get_exit_qual(vcpu);
+	u64 eq = vt_get_exit_qual(vcpu);
 
 	if (eeq_type != TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION)
 		return false;
@@ -1939,7 +1939,7 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 		/* Only private GPA triggers zero-step mitigation */
 		local_retry = true;
 	} else {
-		exit_qual = vmx_get_exit_qual(vcpu);
+		exit_qual = vt_get_exit_qual(vcpu);
 		/*
 		 * EPT violation due to instruction fetch should never be
 		 * triggered from shared memory in TDX guest.  If such EPT
@@ -2021,7 +2021,7 @@ int tdx_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 		return 1;
 	}
 
-	if (vmx_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
+	if (vt_get_exit_reason(vcpu).basic == EXIT_REASON_MSR_READ)
 		tdvmcall_set_return_val(vcpu, kvm_read_edx_eax(vcpu));
 
 	return 1;
@@ -2032,7 +2032,7 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 {
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	u64 vp_enter_ret = tdx->vp_enter_ret;
-	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
+	union vmx_exit_reason exit_reason = vt_get_exit_reason(vcpu);
 
 	if (fastpath != EXIT_FASTPATH_NONE)
 		return 1;
@@ -2142,9 +2142,9 @@ void tdx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 
 	*reason = tdx->vt.exit_reason.full;
 	if (*reason != -1u) {
-		*info1 = vmx_get_exit_qual(vcpu);
+		*info1 = vt_get_exit_qual(vcpu);
 		*info2 = tdx->ext_exit_qualification;
-		*intr_info = vmx_get_intr_info(vcpu);
+		*intr_info = vt_get_intr_info(vcpu);
 	} else {
 		*info1 = 0;
 		*info2 = 0;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2532a9b8e92e..7e35c2d03c69 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1791,7 +1791,7 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 * so that guest userspace can't DoS the guest simply by triggering
 	 * emulation (enclaves are CPL3 only).
 	 */
-	if (vmx_get_exit_reason(vcpu).enclave_mode) {
+	if (vt_get_exit_reason(vcpu).enclave_mode) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return X86EMUL_PROPAGATE_FAULT;
 	}
@@ -1806,7 +1806,7 @@ int vmx_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 
 static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
+	union vmx_exit_reason exit_reason = vt_get_exit_reason(vcpu);
 	unsigned long rip, orig_rip;
 	u32 instr_len;
 
@@ -5381,7 +5381,7 @@ bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu)
 
 static int vmx_handle_page_fault(struct kvm_vcpu *vcpu, u32 error_code)
 {
-	unsigned long cr2 = vmx_get_exit_qual(vcpu);
+	unsigned long cr2 = vt_get_exit_qual(vcpu);
 
 	if (vcpu->arch.apf.host_apf_flags)
 		goto handle_pf;
@@ -5429,7 +5429,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 	u32 vect_info;
 
 	vect_info = vmx->idt_vectoring_info;
-	intr_info = vmx_get_intr_info(vcpu);
+	intr_info = vt_get_intr_info(vcpu);
 
 	/*
 	 * Machine checks are handled by handle_exception_irqoff(), or by
@@ -5510,7 +5510,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 
 	switch (ex_no) {
 	case DB_VECTOR:
-		dr6 = vmx_get_exit_qual(vcpu);
+		dr6 = vt_get_exit_qual(vcpu);
 		if (!(vcpu->guest_debug &
 		      (KVM_GUESTDBG_SINGLESTEP | KVM_GUESTDBG_USE_HW_BP))) {
 			/*
@@ -5586,7 +5586,7 @@ static int handle_io(struct kvm_vcpu *vcpu)
 	int size, in, string;
 	unsigned port;
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 	string = (exit_qualification & 16) != 0;
 
 	++vcpu->stat.io_exits;
@@ -5675,7 +5675,7 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 	int err;
 	int ret;
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 	cr = exit_qualification & 15;
 	reg = (exit_qualification >> 8) & 15;
 	switch ((exit_qualification >> 4) & 3) {
@@ -5753,7 +5753,7 @@ static int handle_dr(struct kvm_vcpu *vcpu)
 	int dr, dr7, reg;
 	int err = 1;
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 	dr = exit_qualification & DEBUG_REG_ACCESS_NUM;
 
 	/* First, if DR does not exist, trigger UD */
@@ -5849,7 +5849,7 @@ static int handle_interrupt_window(struct kvm_vcpu *vcpu)
 
 static int handle_invlpg(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 
 	kvm_mmu_invlpg(vcpu, exit_qualification);
 	return kvm_skip_emulated_instruction(vcpu);
@@ -5858,7 +5858,7 @@ static int handle_invlpg(struct kvm_vcpu *vcpu)
 static int handle_apic_access(struct kvm_vcpu *vcpu)
 {
 	if (likely(fasteoi)) {
-		unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+		unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 		int access_type, offset;
 
 		access_type = exit_qualification & APIC_ACCESS_TYPE;
@@ -5879,7 +5879,7 @@ static int handle_apic_access(struct kvm_vcpu *vcpu)
 
 static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	int vector = exit_qualification & 0xff;
 
 	/* EOI-induced VM exit is trap-like and thus no need to adjust IP */
@@ -5889,7 +5889,7 @@ static int handle_apic_eoi_induced(struct kvm_vcpu *vcpu)
 
 static int handle_apic_write(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 
 	/*
 	 * APIC-write VM-Exit is trap-like, KVM doesn't need to advance RIP and
@@ -5917,7 +5917,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 	idt_index = (vmx->idt_vectoring_info & VECTORING_INFO_VECTOR_MASK);
 	type = (vmx->idt_vectoring_info & VECTORING_INFO_TYPE_MASK);
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 
 	reason = (u32)exit_qualification >> 30;
 	if (reason == TASK_SWITCH_GATE && idt_v) {
@@ -5963,7 +5963,7 @@ static int handle_task_switch(struct kvm_vcpu *vcpu)
 
 static int handle_ept_violation(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	gpa_t gpa;
 
 	/*
@@ -6154,7 +6154,7 @@ static int handle_invpcid(struct kvm_vcpu *vcpu)
 	/* According to the Intel instruction reference, the memory operand
 	 * is read even if it isn't needed (e.g., for type==all)
 	 */
-	if (get_vmx_mem_address(vcpu, vmx_get_exit_qual(vcpu),
+	if (get_vmx_mem_address(vcpu, vt_get_exit_qual(vcpu),
 				vmx_instruction_info, false,
 				sizeof(operand), &gva))
 		return 1;
@@ -6168,7 +6168,7 @@ static int handle_pml_full(struct kvm_vcpu *vcpu)
 
 	trace_kvm_pml_full(vcpu->vcpu_id);
 
-	exit_qualification = vmx_get_exit_qual(vcpu);
+	exit_qualification = vt_get_exit_qual(vcpu);
 
 	/*
 	 * PML buffer FULL happened while executing iret from NMI,
@@ -6272,7 +6272,7 @@ static int handle_bus_lock_vmexit(struct kvm_vcpu *vcpu)
 
 static int handle_notify(struct kvm_vcpu *vcpu)
 {
-	unsigned long exit_qual = vmx_get_exit_qual(vcpu);
+	unsigned long exit_qual = vt_get_exit_qual(vcpu);
 	bool context_invalid = exit_qual & NOTIFY_VM_CONTEXT_INVALID;
 
 	++vcpu->stat.notify_window_exits;
@@ -6303,13 +6303,13 @@ static int vmx_get_msr_imm_reg(struct kvm_vcpu *vcpu)
 
 static int handle_rdmsr_imm(struct kvm_vcpu *vcpu)
 {
-	return kvm_emulate_rdmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+	return kvm_emulate_rdmsr_imm(vcpu, vt_get_exit_qual(vcpu),
 				     vmx_get_msr_imm_reg(vcpu));
 }
 
 static int handle_wrmsr_imm(struct kvm_vcpu *vcpu)
 {
-	return kvm_emulate_wrmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+	return kvm_emulate_wrmsr_imm(vcpu, vt_get_exit_qual(vcpu),
 				     vmx_get_msr_imm_reg(vcpu));
 }
 
@@ -6386,10 +6386,10 @@ void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	*reason = vmx->vt.exit_reason.full;
-	*info1 = vmx_get_exit_qual(vcpu);
+	*info1 = vt_get_exit_qual(vcpu);
 	if (!(vmx->vt.exit_reason.failed_vmentry)) {
 		*info2 = vmx->idt_vectoring_info;
-		*intr_info = vmx_get_intr_info(vcpu);
+		*intr_info = vt_get_intr_info(vcpu);
 		if (is_exception_with_error_code(*intr_info))
 			*error_code = vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
 		else
@@ -6700,7 +6700,7 @@ void dump_vmcs(struct kvm_vcpu *vcpu)
 static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	union vmx_exit_reason exit_reason = vmx_get_exit_reason(vcpu);
+	union vmx_exit_reason exit_reason = vt_get_exit_reason(vcpu);
 	u32 vectoring_info = vmx->idt_vectoring_info;
 	u16 exit_handler_index;
 
@@ -6864,7 +6864,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * Exit to user space when bus lock detected to inform that there is
 	 * a bus lock in guest.
 	 */
-	if (vmx_get_exit_reason(vcpu).bus_lock_detected) {
+	if (vt_get_exit_reason(vcpu).bus_lock_detected) {
 		if (ret > 0)
 			vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
 
@@ -7176,7 +7176,7 @@ static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
 		if (vmx->loaded_vmcs->nmi_known_unmasked)
 			return;
 
-		exit_intr_info = vmx_get_intr_info(&vmx->vcpu);
+		exit_intr_info = vt_get_intr_info(&vmx->vcpu);
 		unblock_nmi = (exit_intr_info & INTR_INFO_UNBLOCK_NMI) != 0;
 		vector = exit_intr_info & INTR_INFO_VECTOR_MASK;
 		/*
@@ -7343,14 +7343,14 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 	 * the fastpath even, all other exits must use the slow path.
 	 */
 	if (is_guest_mode(vcpu) &&
-	    vmx_get_exit_reason(vcpu).basic != EXIT_REASON_PREEMPTION_TIMER)
+	    vt_get_exit_reason(vcpu).basic != EXIT_REASON_PREEMPTION_TIMER)
 		return EXIT_FASTPATH_NONE;
 
-	switch (vmx_get_exit_reason(vcpu).basic) {
+	switch (vt_get_exit_reason(vcpu).basic) {
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_wrmsr(vcpu);
 	case EXIT_REASON_MSR_WRITE_IMM:
-		return handle_fastpath_wrmsr_imm(vcpu, vmx_get_exit_qual(vcpu),
+		return handle_fastpath_wrmsr_imm(vcpu, vt_get_exit_qual(vcpu),
 						 vmx_get_msr_imm_reg(vcpu));
 	case EXIT_REASON_PREEMPTION_TIMER:
 		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
@@ -7392,7 +7392,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	}
 
 	vmx->vt.exit_reason.full = vmcs_read32(VM_EXIT_REASON);
-	if (likely(!vmx_get_exit_reason(vcpu).failed_vmentry))
+	if (likely(!vt_get_exit_reason(vcpu).failed_vmentry))
 		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
 	vt_handle_nmi(vcpu);
@@ -7532,7 +7532,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		 * checking.
 		 */
 		if (vcpu->arch.nested_run_pending &&
-		    !vmx_get_exit_reason(vcpu).failed_vmentry)
+		    !vt_get_exit_reason(vcpu).failed_vmentry)
 			++vcpu->stat.nested_run;
 
 		vcpu->arch.nested_run_pending = 0;
@@ -7543,7 +7543,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	trace_kvm_exit(vcpu, KVM_ISA_VMX);
 
-	if (unlikely(vmx_get_exit_reason(vcpu).failed_vmentry))
+	if (unlikely(vt_get_exit_reason(vcpu).failed_vmentry))
 		return EXIT_FASTPATH_NONE;
 
 	vmx->loaded_vmcs->launched = 1;
-- 
2.55.0.979.g7e5102b832-goog

