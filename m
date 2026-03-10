Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978413C870E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182754; cv=none; b=ZyfxM6Pq8hqsVpK0x7jFWGLqGkn43n30CyWTvNQlOxn+/M/APJkXQ5yXa0wp764wV6wbtHUwQJJ/6OZsn5GMejGimv+5MskjAYWqjdS5R89214v8AOvWh3TXWpqyxNSY0V/5FDgrmfQzgdq5M3RfFmo6Fv6hWEdF/kDVMXtMCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182754; c=relaxed/simple;
	bh=hwdW/TN+96vYflyIkm7Tl7f92iwPXejir/ZHS9EJPwg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rY8oyRUF4kuN3DfUlLylf5uLDgEhYn4TvzKOiOD8xe3mBOMKNKevcPehZYpGcimpeXvm6lEAZiAmI4+QQb4B5rPpx1jFNv1FshN0FhLfF+eURN3fY5xWclGALPsDQLbLLq6PXgeJkAyf1fo5CuKZbe88crgVsB7IQAWbT5n3jII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=odWs0FJa; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odWs0FJa"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae50386da7so2157335ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773182751; x=1773787551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aTqkjsqGILp5wYzsgkTXS8JbmjOMnXqIqMrcmBq0m48=;
        b=odWs0FJaPmiEfiLG7WLbrve6hB7ZqsXk4fsjjlZmmO8P+UBivjwkD3eCzNMXS/y424
         Qb+53k12LZujyPP8MYTfm8wQ9I/NhxbQZvcX8LgZiUA1Og1gPT+gJgffN1XeSUanemoQ
         fwmenXUDXZZZjq9CfCXf8iLQIMb2B+apCtLqjwT4zQWaQWCvPEQ3WuzoHMGwqDJRWDgJ
         5PHf6HTPhtMNZ1c7Wle7HPDk37ncb+kJLUTNjoOJtq22fEkonnbnCLJrpHyluIayssO3
         tR1mclncIMMFBCNapkg7wEmgUUjisYMB/WRwdqJibbk5HtDYwbp4SgUEH/zFFDxd3vv2
         MQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182751; x=1773787551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTqkjsqGILp5wYzsgkTXS8JbmjOMnXqIqMrcmBq0m48=;
        b=DZ+Q1UGK3CYuV6MpSHRS/USqU0KTIJ/298ovwm1CtRry0b5kgphz/haz3bLTDFGBqa
         Vp8IwVLKhfwf2e6nlp78JsCH1VUSuUQZzcpt2+gCI5fk84gqwqziZpV0ziont4+RCpfC
         8M8JwYRYkzty+ZkS5COkv3+O5tJs9KjtHZMaQM+Ys3Iu7eensTHrDII33he8gve8WdYD
         xqaTZK+A12XnBWyY1rk/AEx1Zs+fk3t+ua+beS7haNn0O5MlQD7zAY3OuxKqk+j6WSto
         YBlEmk6RcIb0gQmjvNjCr5QfGfeICpB68wm/LsN45iWj7AnRdYcYGLlNWL8q5Ql+qy42
         76Rw==
X-Gm-Message-State: AOJu0YyEr0myLLjASol+1kK/N+wfvpaov7ebz6tnpCR0ovyTS/TFb86X
	N3GetNnEzJtXgxxza61sYpHAYkLAAVeIACNF1iyI6zwDL8oMTCfXA4ynHGYv5LGfJukuifytr4r
	jzGNgVA==
X-Received: from plblc16.prod.google.com ([2002:a17:902:fa90:b0:2ae:574d:ed3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:f8d:b0:2ae:3a77:a1f6
 with SMTP id d9443c01a7336-2aeaeb36d71mr2657625ad.6.1773182750961; Tue, 10
 Mar 2026 15:45:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 15:45:45 -0700
In-Reply-To: <20260310224546.2582118-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310224546.2582118-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310224546.2582118-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: x86: Move nested_run_pending to kvm_vcpu_arch
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Yosry Ahmed <yosry@kernel.org>

Move nested_run_pending field present in both svm_nested_state and
nested_vmx to the common kvm_vcpu_arch. This allows for common code to
use without plumbing it through per-vendor helpers.

nested_run_pending remains zero-initialized, as the entire kvm_vcpu
struct is, and all further accesses are done through vcpu->arch instead
of svm->nested or vmx->nested.

No functional change intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
[sean: expand the commend in the field declaration]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  9 +++++++
 arch/x86/kvm/svm/nested.c       | 18 ++++++-------
 arch/x86/kvm/svm/svm.c          | 16 ++++++------
 arch/x86/kvm/svm/svm.h          |  4 ---
 arch/x86/kvm/vmx/nested.c       | 46 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.c          | 16 ++++++------
 arch/x86/kvm/vmx/vmx.h          |  3 ---
 7 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c94556fefb75..a1bf0aaedad8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1099,6 +1099,15 @@ struct kvm_vcpu_arch {
 	 */
 	bool pdptrs_from_userspace;
 
+	/*
+	 * Set if an emulated nested VM-Enter to L2 is pending completion.  KVM
+	 * must not synthesize a VM-Exit to L1 before entering L2, as VM-Exits
+	 * can only occur at instruction boundaries.  The only exception is
+	 * VMX's "notify" exits, which exist in large part to break the CPU out
+	 * of infinite ucode loops, but can corrupt vCPU state in the process!
+	 */
+	bool nested_run_pending;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 	hpa_t hv_root_tdp;
 #endif
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b191c6cab57d..782d6a34d173 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -914,7 +914,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	 * the CPU and/or KVM and should be used regardless of L1's support.
 	 */
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
-	    !svm->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcb02->control.next_rip = vmcb12_ctrl->next_rip;
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
@@ -926,7 +926,7 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm)
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
 		svm->soft_int_injected = true;
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
-		    !svm->nested.nested_run_pending)
+		    !vcpu->arch.nested_run_pending)
 			svm->soft_int_next_rip = vmcb12_ctrl->next_rip;
 	}
 
@@ -1131,11 +1131,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!npt_enabled)
 		vmcb01->save.cr3 = kvm_read_cr3(vcpu);
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, true) ||
 	    !nested_svm_merge_msrpm(vcpu)) {
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		svm->nmi_l1_to_l2 = false;
 		svm->soft_int_injected = false;
 
@@ -1277,7 +1277,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	/* Exit Guest-Mode */
 	leave_guest_mode(vcpu);
 	svm->nested.vmcb12_gpa = 0;
-	WARN_ON_ONCE(svm->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
 
@@ -1487,7 +1487,7 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 
 	if (is_guest_mode(vcpu)) {
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		svm->nested.vmcb12_gpa = INVALID_GPA;
 
 		leave_guest_mode(vcpu);
@@ -1672,7 +1672,7 @@ static int svm_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = svm->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * New events (not exceptions) are only recognized at instruction
 	 * boundaries.  If an event needs reinjection, then KVM is handling a
@@ -1847,7 +1847,7 @@ static int svm_get_nested_state(struct kvm_vcpu *vcpu,
 		kvm_state.size += KVM_STATE_NESTED_SVM_VMCB_SIZE;
 		kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-		if (svm->nested.nested_run_pending)
+		if (vcpu->arch.nested_run_pending)
 			kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 	}
 
@@ -1984,7 +1984,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
 
-	svm->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	svm->nested.vmcb12_gpa = kvm_state->hdr.svm.vmcb_pa;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3407deac90bd..112731515ee3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3831,7 +3831,7 @@ static void svm_fixup_nested_rips(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!is_guest_mode(vcpu) || !svm->nested.nested_run_pending)
+	if (!is_guest_mode(vcpu) || !vcpu->arch.nested_run_pending)
 		return;
 
 	/*
@@ -3979,7 +3979,7 @@ bool svm_nmi_blocked(struct kvm_vcpu *vcpu)
 static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_nmi_blocked(vcpu))
@@ -4021,7 +4021,7 @@ static int svm_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_interrupt_blocked(vcpu))
@@ -4244,7 +4244,7 @@ static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
 	 * the soft int and will reinject it via the standard injection flow,
 	 * and so KVM needs to grab the state from the pending nested VMRUN.
 	 */
-	if (is_guest_mode(vcpu) && svm->nested.nested_run_pending)
+	if (is_guest_mode(vcpu) && vcpu->arch.nested_run_pending)
 		svm_set_nested_run_soft_int_state(vcpu);
 
 	/*
@@ -4547,11 +4547,11 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		nested_sync_control_from_vmcb02(svm);
 
 		/* Track VMRUNs that have made past consistency checking */
-		if (svm->nested.nested_run_pending &&
+		if (vcpu->arch.nested_run_pending &&
 		    !svm_is_vmrun_failure(svm->vmcb->control.exit_code))
                         ++vcpu->stat.nested_run;
 
-		svm->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 	}
 
 	svm->vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
@@ -4920,7 +4920,7 @@ bool svm_smi_blocked(struct kvm_vcpu *vcpu)
 static int svm_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (svm->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	if (svm_smi_blocked(vcpu))
@@ -5035,7 +5035,7 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 	if (ret)
 		goto unmap_save;
 
-	svm->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 
 unmap_save:
 	kvm_vcpu_unmap(vcpu, &map_save);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 9909bb7d2d31..1c98419be9d2 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -215,10 +215,6 @@ struct svm_nested_state {
 	 */
 	void *msrpm;
 
-	/* A VMRUN has started but has not yet been performed, so
-	 * we cannot inject a nested vmexit yet.  */
-	bool nested_run_pending;
-
 	/* cache for control fields of the guest */
 	struct vmcb_ctrl_area_cached ctl;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 101588914cbb..65e45cee871c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2273,7 +2273,7 @@ static void vmx_start_preemption_timer(struct kvm_vcpu *vcpu,
 
 static u64 nested_vmx_calc_efer(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 {
-	if (vmx->nested.nested_run_pending &&
+	if (vmx->vcpu.arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER))
 		return vmcs12->guest_ia32_efer;
 	else if (vmcs12->vm_entry_controls & VM_ENTRY_IA32E_MODE)
@@ -2513,7 +2513,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 	/*
 	 * Interrupt/Exception Fields
 	 */
-	if (vmx->nested.nested_run_pending) {
+	if (vmx->vcpu.arch.nested_run_pending) {
 		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
 			     vmcs12->vm_entry_intr_info_field);
 		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
@@ -2621,7 +2621,7 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
 			vmcs_write64(GUEST_PDPTR3, vmcs12->guest_pdptr3);
 		}
 
-		if (kvm_mpx_supported() && vmx->nested.nested_run_pending &&
+		if (kvm_mpx_supported() && vmx->vcpu.arch.nested_run_pending &&
 		    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS))
 			vmcs_write64(GUEST_BNDCFGS, vmcs12->guest_bndcfgs);
 	}
@@ -2718,7 +2718,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			!(evmcs->hv_clean_fields & HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP1);
 	}
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
 		kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
 		vmx_guest_debugctl_write(vcpu, vmcs12->guest_ia32_debugctl &
@@ -2728,13 +2728,13 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmx_guest_debugctl_write(vcpu, vmx->nested.pre_vmenter_debugctl);
 	}
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
 		vmcs_write_cet_state(vcpu, vmx->nested.pre_vmenter_s_cet,
 				     vmx->nested.pre_vmenter_ssp,
 				     vmx->nested.pre_vmenter_ssp_tbl);
 
-	if (kvm_mpx_supported() && (!vmx->nested.nested_run_pending ||
+	if (kvm_mpx_supported() && (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmcs_write64(GUEST_BNDCFGS, vmx->nested.pre_vmenter_bndcfgs);
 	vmx_set_rflags(vcpu, vmcs12->guest_rflags);
@@ -2747,7 +2747,7 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
-	if (vmx->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->guest_ia32_pat);
 		vcpu->arch.pat = vmcs12->guest_ia32_pat;
@@ -3349,7 +3349,7 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	 *   to bit 8 (LME) if bit 31 in the CR0 field (corresponding to
 	 *   CR0.PG) is 1.
 	 */
-	if (to_vmx(vcpu)->nested.nested_run_pending &&
+	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_EFER)) {
 		if (CC(!kvm_valid_efer(vcpu, vmcs12->guest_ia32_efer)) ||
 		    CC(ia32e != !!(vmcs12->guest_ia32_efer & EFER_LMA)) ||
@@ -3627,15 +3627,15 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 
 	kvm_service_local_tlb_flush_requests(vcpu);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.pre_vmenter_debugctl = vmx_guest_debugctl_read();
 	if (kvm_mpx_supported() &&
-	    (!vmx->nested.nested_run_pending ||
+	    (!vcpu->arch.nested_run_pending ||
 	     !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_BNDCFGS)))
 		vmx->nested.pre_vmenter_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
-	if (!vmx->nested.nested_run_pending ||
+	if (!vcpu->arch.nested_run_pending ||
 	    !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_CET_STATE))
 		vmcs_read_cet_state(vcpu, &vmx->nested.pre_vmenter_s_cet,
 				    &vmx->nested.pre_vmenter_ssp,
@@ -3844,7 +3844,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * We're finally done with prerequisite checking, and can start with
 	 * the nested entry.
 	 */
-	vmx->nested.nested_run_pending = 1;
+	vcpu->arch.nested_run_pending = 1;
 	vmx->nested.has_preemption_timer_deadline = false;
 	status = nested_vmx_enter_non_root_mode(vcpu, true);
 	if (unlikely(status != NVMX_VMENTRY_SUCCESS))
@@ -3876,12 +3876,12 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 		    !nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING) &&
 		    !(nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING) &&
 		      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
-			vmx->nested.nested_run_pending = 0;
+			vcpu->arch.nested_run_pending = 0;
 			return kvm_emulate_halt_noskip(vcpu);
 		}
 		break;
 	case GUEST_ACTIVITY_WAIT_SIPI:
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_INIT_RECEIVED);
 		break;
 	default:
@@ -3891,7 +3891,7 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	return 1;
 
 vmentry_failed:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	if (status == NVMX_VMENTRY_KVM_INTERNAL_ERROR)
 		return 0;
 	if (status == NVMX_VMENTRY_VMEXIT)
@@ -4288,7 +4288,7 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	 * previously injected event, the pending exception occurred while said
 	 * event was being delivered and thus needs to be handled.
 	 */
-	bool block_nested_exceptions = vmx->nested.nested_run_pending;
+	bool block_nested_exceptions = vcpu->arch.nested_run_pending;
 	/*
 	 * Events that don't require injection, i.e. that are virtualized by
 	 * hardware, aren't blocked by a pending VM-Enter as KVM doesn't need
@@ -4657,7 +4657,7 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
 
 	if (nested_cpu_has_preemption_timer(vmcs12) &&
 	    vmcs12->vm_exit_controls & VM_EXIT_SAVE_VMX_PREEMPTION_TIMER &&
-	    !vmx->nested.nested_run_pending)
+	    !vcpu->arch.nested_run_pending)
 		vmcs12->vmx_preemption_timer_value =
 			vmx_get_preemption_timer_value(vcpu);
 
@@ -5056,7 +5056,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	vmx->nested.mtf_pending = false;
 
 	/* trying to cancel vmlaunch/vmresume is a bug */
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 #ifdef CONFIG_KVM_HYPERV
 	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
@@ -6679,7 +6679,7 @@ bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
 	unsigned long exit_qual;
 	u32 exit_intr_info;
 
-	WARN_ON_ONCE(vmx->nested.nested_run_pending);
+	WARN_ON_ONCE(vcpu->arch.nested_run_pending);
 
 	/*
 	 * Late nested VM-Fail shares the same flow as nested VM-Exit since KVM
@@ -6775,7 +6775,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		if (is_guest_mode(vcpu)) {
 			kvm_state.flags |= KVM_STATE_NESTED_GUEST_MODE;
 
-			if (vmx->nested.nested_run_pending)
+			if (vcpu->arch.nested_run_pending)
 				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
 
 			if (vmx->nested.mtf_pending)
@@ -6850,7 +6850,7 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 void vmx_leave_nested(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu)) {
-		to_vmx(vcpu)->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
 	free_nested(vcpu);
@@ -6987,7 +6987,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	if (!(kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
 		return 0;
 
-	vmx->nested.nested_run_pending =
+	vcpu->arch.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
 	vmx->nested.mtf_pending =
@@ -7039,7 +7039,7 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	return 0;
 
 error_guest_mode:
-	vmx->nested.nested_run_pending = 0;
+	vcpu->arch.nested_run_pending = 0;
 	return ret;
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9302c16571cd..0e7e0a17bb75 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5170,7 +5170,7 @@ bool vmx_nmi_blocked(struct kvm_vcpu *vcpu)
 
 int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/* An NMI must not be injected into L2 if it's supposed to VM-Exit.  */
@@ -5197,7 +5197,7 @@ bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 
 int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 
 	/*
@@ -6009,7 +6009,7 @@ static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 	 * only reachable if userspace modifies L2 guest state after KVM has
 	 * performed the nested VM-Enter consistency checks.
 	 */
-	if (vmx->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return true;
 
 	/*
@@ -6693,7 +6693,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	 * invalid guest state should never happen as that means KVM knowingly
 	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
 	 */
-	if (KVM_BUG_ON(vmx->nested.nested_run_pending, vcpu->kvm))
+	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
 		return -EIO;
 
 	if (is_guest_mode(vcpu)) {
@@ -7621,11 +7621,11 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		 * Track VMLAUNCH/VMRESUME that have made past guest state
 		 * checking.
 		 */
-		if (vmx->nested.nested_run_pending &&
+		if (vcpu->arch.nested_run_pending &&
 		    !vmx_get_exit_reason(vcpu).failed_vmentry)
 			++vcpu->stat.nested_run;
 
-		vmx->nested.nested_run_pending = 0;
+		vcpu->arch.nested_run_pending = 0;
 	}
 
 	if (unlikely(vmx->fail))
@@ -8382,7 +8382,7 @@ void vmx_setup_mce(struct kvm_vcpu *vcpu)
 int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
 	/* we need a nested vmexit to enter SMM, postpone if run is pending */
-	if (to_vmx(vcpu)->nested.nested_run_pending)
+	if (vcpu->arch.nested_run_pending)
 		return -EBUSY;
 	return !is_smm(vcpu);
 }
@@ -8423,7 +8423,7 @@ int vmx_leave_smm(struct kvm_vcpu *vcpu, const union kvm_smram *smram)
 		if (ret)
 			return ret;
 
-		vmx->nested.nested_run_pending = 1;
+		vcpu->arch.nested_run_pending = 1;
 		vmx->nested.smm.guest_mode = false;
 	}
 	return 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 70bfe81dea54..db84e8001da5 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -138,9 +138,6 @@ struct nested_vmx {
 	 */
 	bool enlightened_vmcs_enabled;
 
-	/* L2 must run next, and mustn't decide to exit to L1. */
-	bool nested_run_pending;
-
 	/* Pending MTF VM-exit into L1.  */
 	bool mtf_pending;
 
-- 
2.53.0.473.g4a7958ca14-goog

