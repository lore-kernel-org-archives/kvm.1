Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5043C871E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773186530; cv=none; b=BCKwpvhYKqxVR0uqO5JAXxZQSk2550im2pBrfMs2B/LZCuJ0mIiksDP7btfrFJUFBHAiwlMqK/+XXilXSlD8zwChgoxVsJqhImy9uS2hWzgxOxaaGOKuV0pmKMSnbNDI0B1lHs7u8DIRwW3XY7YuNFQgthJVRni9L8XsIF95cUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773186530; c=relaxed/simple;
	bh=n05WuNyx4F1eCOEShaK40S0iS9nGzHIVXJDIl9v8oqA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K486WwnXJPeBZRuZr/XNSlfyfpplyn9LvrQWbbJFfkBH6FulTSsuG96FzhzNYZNioChTimUXw+Siv5ZX089NaDdwKOJeAzrJc/7+meG55JBE5KFkrScm9jpJ0/aTsoTZCwMOU1CQkR1rIFBktC2Tde+YPpNV+rcXvDazj0Ke8L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRRcLUrs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRRcLUrs"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so8420636a12.3
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773186528; x=1773791328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XKuSACzGwtmcfqQ+YK6gKCkGNw0Cl5aXLpmtLU0/pdI=;
        b=bRRcLUrs+/FcCal7pt+JwXYS3Gh0HIo4CcLbY8O2mACoSCRFaZw222cgSw87sasFxo
         7cIzpe1lP+S10ayXX6BGC5OF89fCVOlK99YT6qbDf9C6f2gen4BxROnnVpMhrx1oNuw/
         pVwbnubygRP3MVuM6MhxLKVUqykwaOyk9OKagqS+JlIzQ7PfWTfjZ6ja8tNsAq+FJw2Y
         G+LCvW2zUA4a7syOh4RuiubQm9n8p5VZGzSuTVcFC7rjXZQ5Ba0zdNqQ+ubgsY0n2PDp
         WBbtgj6pSEQK9unQBvYIbtxb0kBNUblf+JlHQhFkfgUpHNaOTqih5GTxlewtcS2fweds
         ZP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773186528; x=1773791328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKuSACzGwtmcfqQ+YK6gKCkGNw0Cl5aXLpmtLU0/pdI=;
        b=BcPCmIBLJcGGuezein/fEN0QvEtvFHor9D2f+ZQpdO4NTai+plsHAvQpMXkkVolIBD
         dtk04uEWJ2eYBIILn7BXI+YsKXBvkJ8qxpDmVFHQpdvZFLFMrI6ZIkawbhS2aY19o854
         zNXv8MvvzFGDN4l8kQFEeOmyh9P5M+KJN9q04c7t6W2dL+twxqacRs6XdOsI9GV2Ok4l
         0EAbo64u/cQjSwmGHBoaK0dn5kUmBDgILVzW6YfEQie8oTRGI+l1bPE4XJPZ7vVWJEkq
         SX//vaYt07JIKKmqjb3yTWLfr+bdYXuClleG/ykIyR2i73KddkgPhcQ29wrUIdHFzT7u
         oOaA==
X-Gm-Message-State: AOJu0YzgGqdZPvchVyDIjI3J1h63JOTbJvBxHDUuZGuoVrg9YKcRc2uc
	U3NnheZtxgmVckPo+aBlNLbEyutq6KSLUVQmSLjZxrBOWb2IJNYmqX7IWJ6CZGjF3Sutt5oaHGl
	8Rrmelg==
X-Received: from pgbfe28.prod.google.com ([2002:a05:6a02:289c:b0:c73:be03:1111])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e04:b0:398:b95c:51ed
 with SMTP id adf61e73a8af0-398c60cd73bmr327596637.35.1773186527565; Tue, 10
 Mar 2026 16:48:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 16:48:15 -0700
In-Reply-To: <20260310234829.2608037-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310234829.2608037-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310234829.2608037-8-seanjc@google.com>
Subject: [PATCH 07/21] KVM: SEV: Provide vCPU-scoped accessors for detecting
 SEV+ guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jethro Beekman <jethro@fortanix.com>, Alexander Potapenko <glider@google.com>, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>
Content-Type: text/plain; charset="UTF-8"

Provide vCPU-scoped accessors for detecting if the vCPU belongs to an SEV,
SEV-ES, or SEV-SNP VM, partly to dedup a small amount of code, but mostly
to better document which usages are "safe".  Generally speaking, using the
VM-scoped sev_guest() and friends outside of kvm->lock is unsafe, as they
can get both false positives and false negatives.

But for vCPUs, the accessors are guaranteed to provide a stable result as
KVM disallows initialization SEV+ state after vCPUs are created.  I.e.
operating on a vCPU guarantees the VM can't "become" an SEV+ VM, and that
it can't revert back to a "normal" VM.

This will also allow dropping the stubs for the VM-scoped accessors, as
it's relatively easy to eliminate usage of the accessors from common SVM
once the vCPU-scoped checks are out of the way.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 49 +++++++++++++-------------
 arch/x86/kvm/svm/svm.c | 80 +++++++++++++++++++++---------------------
 arch/x86/kvm/svm/svm.h | 17 +++++++++
 3 files changed, 82 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 1bdcc5bef7c3..35033dc79390 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3271,7 +3271,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm;
 
-	if (!sev_es_guest(vcpu->kvm))
+	if (!is_sev_es_guest(vcpu))
 		return;
 
 	svm = to_svm(vcpu);
@@ -3281,7 +3281,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	 * a guest-owned page. Transition the page to hypervisor state before
 	 * releasing it back to the system.
 	 */
-	if (sev_snp_guest(vcpu->kvm)) {
+	if (is_sev_snp_guest(vcpu)) {
 		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
 
 		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
@@ -3482,7 +3482,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
-		if (!sev_snp_guest(vcpu->kvm))
+		if (!is_sev_snp_guest(vcpu))
 			goto vmgexit_err;
 		if (lower_32_bits(control->exit_info_1) != SVM_VMGEXIT_AP_DESTROY)
 			if (!kvm_ghcb_rax_is_valid(svm))
@@ -3496,12 +3496,12 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_VMGEXIT_TERM_REQUEST:
 		break;
 	case SVM_VMGEXIT_PSC:
-		if (!sev_snp_guest(vcpu->kvm) || !kvm_ghcb_sw_scratch_is_valid(svm))
+		if (!is_sev_snp_guest(vcpu) || !kvm_ghcb_sw_scratch_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_GUEST_REQUEST:
 	case SVM_VMGEXIT_EXT_GUEST_REQUEST:
-		if (!sev_snp_guest(vcpu->kvm) ||
+		if (!is_sev_snp_guest(vcpu) ||
 		    !PAGE_ALIGNED(control->exit_info_1) ||
 		    !PAGE_ALIGNED(control->exit_info_2) ||
 		    control->exit_info_1 == control->exit_info_2)
@@ -3575,7 +3575,8 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-	struct kvm *kvm = svm->vcpu.kvm;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
 	unsigned int asid = sev_get_asid(kvm);
 
 	/*
@@ -3583,7 +3584,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 	 * VMSA, e.g. if userspace forces the vCPU to be RUNNABLE after an SNP
 	 * AP Destroy event.
 	 */
-	if (sev_es_guest(kvm) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
+	if (is_sev_es_guest(vcpu) && !VALID_PAGE(svm->vmcb->control.vmsa_pa))
 		return -EINVAL;
 
 	/*
@@ -4129,7 +4130,7 @@ static int snp_handle_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_
 	sev_ret_code fw_err = 0;
 	int ret;
 
-	if (!sev_snp_guest(kvm))
+	if (!is_sev_snp_guest(&svm->vcpu))
 		return -EINVAL;
 
 	mutex_lock(&sev->guest_req_mutex);
@@ -4199,10 +4200,12 @@ static int snp_complete_req_certs(struct kvm_vcpu *vcpu)
 
 static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t resp_gpa)
 {
-	struct kvm *kvm = svm->vcpu.kvm;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	struct kvm *kvm = vcpu->kvm;
+
 	u8 msg_type;
 
-	if (!sev_snp_guest(kvm))
+	if (!is_sev_snp_guest(vcpu))
 		return -EINVAL;
 
 	if (kvm_read_guest(kvm, req_gpa + offsetof(struct snp_guest_msg_hdr, msg_type),
@@ -4221,7 +4224,6 @@ static int snp_handle_ext_guest_req(struct vcpu_svm *svm, gpa_t req_gpa, gpa_t r
 	 */
 	if (msg_type == SNP_MSG_REPORT_REQ) {
 		struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
-		struct kvm_vcpu *vcpu = &svm->vcpu;
 		u64 data_npages;
 		gpa_t data_gpa;
 
@@ -4338,7 +4340,7 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 				  GHCB_MSR_INFO_MASK, GHCB_MSR_INFO_POS);
 		break;
 	case GHCB_MSR_PREF_GPA_REQ:
-		if (!sev_snp_guest(vcpu->kvm))
+		if (!is_sev_snp_guest(vcpu))
 			goto out_terminate;
 
 		set_ghcb_msr_bits(svm, GHCB_MSR_PREF_GPA_NONE, GHCB_MSR_GPA_VALUE_MASK,
@@ -4349,7 +4351,7 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 	case GHCB_MSR_REG_GPA_REQ: {
 		u64 gfn;
 
-		if (!sev_snp_guest(vcpu->kvm))
+		if (!is_sev_snp_guest(vcpu))
 			goto out_terminate;
 
 		gfn = get_ghcb_msr_bits(svm, GHCB_MSR_GPA_VALUE_MASK,
@@ -4364,7 +4366,7 @@ static int sev_handle_vmgexit_msr_protocol(struct vcpu_svm *svm)
 		break;
 	}
 	case GHCB_MSR_PSC_REQ:
-		if (!sev_snp_guest(vcpu->kvm))
+		if (!is_sev_snp_guest(vcpu))
 			goto out_terminate;
 
 		ret = snp_begin_psc_msr(svm, control->ghcb_gpa);
@@ -4437,7 +4439,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	sev_es_sync_from_ghcb(svm);
 
 	/* SEV-SNP guest requires that the GHCB GPA must be registered */
-	if (sev_snp_guest(svm->vcpu.kvm) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
+	if (is_sev_snp_guest(vcpu) && !ghcb_gpa_is_registered(svm, ghcb_gpa)) {
 		vcpu_unimpl(&svm->vcpu, "vmgexit: GHCB GPA [%#llx] is not registered.\n", ghcb_gpa);
 		return -EINVAL;
 	}
@@ -4695,10 +4697,10 @@ void sev_init_vmcb(struct vcpu_svm *svm, bool init_event)
 	 */
 	clr_exception_intercept(svm, GP_VECTOR);
 
-	if (init_event && sev_snp_guest(vcpu->kvm))
+	if (init_event && is_sev_snp_guest(vcpu))
 		sev_snp_init_protected_guest_state(vcpu);
 
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		sev_es_init_vmcb(svm, init_event);
 }
 
@@ -4709,7 +4711,7 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 
 	mutex_init(&svm->sev_es.snp_vmsa_mutex);
 
-	if (!sev_es_guest(vcpu->kvm))
+	if (!is_sev_es_guest(vcpu))
 		return 0;
 
 	/*
@@ -4729,8 +4731,6 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
 {
-	struct kvm *kvm = svm->vcpu.kvm;
-
 	/*
 	 * All host state for SEV-ES guests is categorized into three swap types
 	 * based on how it is handled by hardware during a world switch:
@@ -4769,7 +4769,8 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 	 * loaded with the correct values *if* the CPU writes the MSRs.
 	 */
 	if (sev_vcpu_has_debug_swap(svm) ||
-	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
+	    (cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP) &&
+	     is_sev_snp_guest(&svm->vcpu))) {
 		hostsa->dr0_addr_mask = amd_get_dr_addr_mask(0);
 		hostsa->dr1_addr_mask = amd_get_dr_addr_mask(1);
 		hostsa->dr2_addr_mask = amd_get_dr_addr_mask(2);
@@ -5133,7 +5134,7 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	int error = 0;
 	int ret;
 
-	if (!sev_es_guest(vcpu->kvm))
+	if (!is_sev_es_guest(vcpu))
 		return NULL;
 
 	/*
@@ -5146,7 +5147,7 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 	sev = to_kvm_sev_info(vcpu->kvm);
 
 	/* Check if the SEV policy allows debugging */
-	if (sev_snp_guest(vcpu->kvm)) {
+	if (is_sev_snp_guest(vcpu)) {
 		if (!(sev->policy & SNP_POLICY_MASK_DEBUG))
 			return NULL;
 	} else {
@@ -5154,7 +5155,7 @@ struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 			return NULL;
 	}
 
-	if (sev_snp_guest(vcpu->kvm)) {
+	if (is_sev_snp_guest(vcpu)) {
 		struct sev_data_snp_dbg dbg = {0};
 
 		vmsa = snp_alloc_firmware_page(__GFP_ZERO);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 8f8bc863e214..0a1acc21b133 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -241,7 +241,7 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 			 * Never intercept #GP for SEV guests, KVM can't
 			 * decrypt guest memory to workaround the erratum.
 			 */
-			if (svm_gp_erratum_intercept && !sev_guest(vcpu->kvm))
+			if (svm_gp_erratum_intercept && !is_sev_guest(vcpu))
 				set_exception_intercept(svm, GP_VECTOR);
 		}
 	}
@@ -283,7 +283,7 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 	 * SEV-ES does not expose the next RIP. The RIP update is controlled by
 	 * the type of exit and the #VC handler in the guest.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		goto done;
 
 	if (nrips && svm->vmcb->control.next_rip != 0) {
@@ -720,7 +720,7 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTFROMIP, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTTOIP, MSR_TYPE_RW, intercept);
 
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_DEBUGCTLMSR, MSR_TYPE_RW, intercept);
 
 	svm->lbr_msrs_intercepted = intercept;
@@ -830,7 +830,7 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, !shstk_enabled);
 	}
 
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		sev_es_recalc_msr_intercepts(vcpu);
 
 	svm_recalc_pmu_msr_intercepts(vcpu);
@@ -865,7 +865,7 @@ void svm_enable_lbrv(struct kvm_vcpu *vcpu)
 
 static void __svm_disable_lbrv(struct kvm_vcpu *vcpu)
 {
-	KVM_BUG_ON(sev_es_guest(vcpu->kvm), vcpu->kvm);
+	KVM_BUG_ON(is_sev_es_guest(vcpu), vcpu->kvm);
 	to_svm(vcpu)->vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
 }
 
@@ -1207,7 +1207,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 	if (vcpu->kvm->arch.bus_lock_detection_enabled)
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
 
-	if (sev_guest(vcpu->kvm))
+	if (is_sev_guest(vcpu))
 		sev_init_vmcb(svm, init_event);
 
 	svm_hv_init_vmcb(vmcb);
@@ -1381,7 +1381,7 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, vcpu->cpu);
 
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		sev_es_unmap_ghcb(svm);
 
 	if (svm->guest_state_loaded)
@@ -1392,7 +1392,7 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 * or subsequent vmload of host save area.
 	 */
 	vmsave(sd->save_area_pa);
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		sev_es_prepare_switch_to_guest(svm, sev_es_host_save_area(sd));
 
 	if (tsc_scaling)
@@ -1405,7 +1405,7 @@ static void svm_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 	 * all CPUs support TSC_AUX virtualization).
 	 */
 	if (likely(tsc_aux_uret_slot >= 0) &&
-	    (!boot_cpu_has(X86_FEATURE_V_TSC_AUX) || !sev_es_guest(vcpu->kvm)))
+	    (!boot_cpu_has(X86_FEATURE_V_TSC_AUX) || !is_sev_es_guest(vcpu)))
 		kvm_set_user_return_msr(tsc_aux_uret_slot, svm->tsc_aux, -1ull);
 
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_BP_SPEC_REDUCE) &&
@@ -1472,7 +1472,7 @@ static bool svm_get_if_flag(struct kvm_vcpu *vcpu)
 {
 	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
 
-	return sev_es_guest(vcpu->kvm)
+	return is_sev_es_guest(vcpu)
 		? vmcb->control.int_state & SVM_GUEST_INTERRUPT_MASK
 		: kvm_get_rflags(vcpu) & X86_EFLAGS_IF;
 }
@@ -1706,7 +1706,7 @@ static void sev_post_set_cr3(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * contents of the VMSA, and future VMCB save area updates won't be
 	 * seen.
 	 */
-	if (sev_es_guest(vcpu->kvm)) {
+	if (is_sev_es_guest(vcpu)) {
 		svm->vmcb->save.cr3 = cr3;
 		vmcb_mark_dirty(svm->vmcb, VMCB_CR);
 	}
@@ -1761,7 +1761,7 @@ void svm_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
 	 * SEV-ES guests must always keep the CR intercepts cleared. CR
 	 * tracking is done using the CR write traps.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		return;
 
 	if (hcr0 == cr0) {
@@ -1872,7 +1872,7 @@ static void svm_sync_dirty_debug_regs(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (WARN_ON_ONCE(sev_es_guest(vcpu->kvm)))
+	if (WARN_ON_ONCE(is_sev_es_guest(vcpu)))
 		return;
 
 	get_debugreg(vcpu->arch.db[0], 0);
@@ -1951,7 +1951,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 		}
 	}
 
-	if (sev_snp_guest(vcpu->kvm) && (error_code & PFERR_GUEST_ENC_MASK))
+	if (is_sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
 	trace_kvm_page_fault(vcpu, gpa, error_code);
@@ -2096,7 +2096,7 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 * The VM save area for SEV-ES guests has already been encrypted so it
 	 * cannot be reinitialized, i.e. synthesizing INIT is futile.
 	 */
-	if (!sev_es_guest(vcpu->kvm)) {
+	if (!is_sev_es_guest(vcpu)) {
 		clear_page(svm->vmcb);
 #ifdef CONFIG_KVM_SMM
 		if (is_smm(vcpu))
@@ -2123,7 +2123,7 @@ static int io_interception(struct kvm_vcpu *vcpu)
 	size = (io_info & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT;
 
 	if (string) {
-		if (sev_es_guest(vcpu->kvm))
+		if (is_sev_es_guest(vcpu))
 			return sev_es_string_io(svm, size, port, in);
 		else
 			return kvm_emulate_instruction(vcpu, 0);
@@ -2455,13 +2455,13 @@ static int task_switch_interception(struct kvm_vcpu *vcpu)
 
 static void svm_clr_iret_intercept(struct vcpu_svm *svm)
 {
-	if (!sev_es_guest(svm->vcpu.kvm))
+	if (!is_sev_es_guest(&svm->vcpu))
 		svm_clr_intercept(svm, INTERCEPT_IRET);
 }
 
 static void svm_set_iret_intercept(struct vcpu_svm *svm)
 {
-	if (!sev_es_guest(svm->vcpu.kvm))
+	if (!is_sev_es_guest(&svm->vcpu))
 		svm_set_intercept(svm, INTERCEPT_IRET);
 }
 
@@ -2469,7 +2469,7 @@ static int iret_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	WARN_ON_ONCE(sev_es_guest(vcpu->kvm));
+	WARN_ON_ONCE(is_sev_es_guest(vcpu));
 
 	++vcpu->stat.nmi_window_exits;
 	svm->awaiting_iret_completion = true;
@@ -2643,7 +2643,7 @@ static int dr_interception(struct kvm_vcpu *vcpu)
 	 * SEV-ES intercepts DR7 only to disable guest debugging and the guest issues a VMGEXIT
 	 * for DR7 write only. KVM cannot change DR7 (always swapped as type 'A') so return early.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		return 1;
 
 	if (vcpu->guest_debug == 0) {
@@ -2725,7 +2725,7 @@ static int svm_get_feature_msr(u32 msr, u64 *data)
 static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 				      struct msr_data *msr_info)
 {
-	return sev_es_guest(vcpu->kvm) && vcpu->arch.guest_state_protected &&
+	return is_sev_es_guest(vcpu) && vcpu->arch.guest_state_protected &&
 	       msr_info->index != MSR_IA32_XSS &&
 	       !msr_write_intercepted(vcpu, msr_info->index);
 }
@@ -2861,7 +2861,7 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 static int svm_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	if (!err || !sev_es_guest(vcpu->kvm) || WARN_ON_ONCE(!svm->sev_es.ghcb))
+	if (!err || !is_sev_es_guest(vcpu) || WARN_ON_ONCE(!svm->sev_es.ghcb))
 		return kvm_complete_insn_gp(vcpu, err);
 
 	svm_vmgexit_inject_exception(svm, X86_TRAP_GP);
@@ -3042,7 +3042,7 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		 * required in this case because TSC_AUX is restored on #VMEXIT
 		 * from the host save area.
 		 */
-		if (boot_cpu_has(X86_FEATURE_V_TSC_AUX) && sev_es_guest(vcpu->kvm))
+		if (boot_cpu_has(X86_FEATURE_V_TSC_AUX) && is_sev_es_guest(vcpu))
 			break;
 
 		/*
@@ -3156,7 +3156,7 @@ static int pause_interception(struct kvm_vcpu *vcpu)
 	 * vcpu->arch.preempted_in_kernel can never be true.  Just
 	 * set in_kernel to false as well.
 	 */
-	in_kernel = !sev_es_guest(vcpu->kvm) && svm_get_cpl(vcpu) == 0;
+	in_kernel = !is_sev_es_guest(vcpu) && svm_get_cpl(vcpu) == 0;
 
 	grow_ple_window(vcpu);
 
@@ -3321,9 +3321,9 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 
 	guard(mutex)(&vmcb_dump_mutex);
 
-	vm_type = sev_snp_guest(vcpu->kvm) ? "SEV-SNP" :
-		  sev_es_guest(vcpu->kvm) ? "SEV-ES" :
-		  sev_guest(vcpu->kvm) ? "SEV" : "SVM";
+	vm_type = is_sev_snp_guest(vcpu) ? "SEV-SNP" :
+		  is_sev_es_guest(vcpu) ? "SEV-ES" :
+		  is_sev_guest(vcpu) ? "SEV" : "SVM";
 
 	pr_err("%s vCPU%u VMCB %p, last attempted VMRUN on CPU %d\n",
 	       vm_type, vcpu->vcpu_id, svm->current_vmcb->ptr, vcpu->arch.last_vmentry_cpu);
@@ -3368,7 +3368,7 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	pr_err("%-20s%016llx\n", "allowed_sev_features:", control->allowed_sev_features);
 	pr_err("%-20s%016llx\n", "guest_sev_features:", control->guest_sev_features);
 
-	if (sev_es_guest(vcpu->kvm)) {
+	if (is_sev_es_guest(vcpu)) {
 		save = sev_decrypt_vmsa(vcpu);
 		if (!save)
 			goto no_vmsa;
@@ -3451,7 +3451,7 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	       "excp_from:", save->last_excp_from,
 	       "excp_to:", save->last_excp_to);
 
-	if (sev_es_guest(vcpu->kvm)) {
+	if (is_sev_es_guest(vcpu)) {
 		struct sev_es_save_area *vmsa = (struct sev_es_save_area *)save;
 
 		pr_err("%-15s %016llx\n",
@@ -3512,7 +3512,7 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
 	}
 
 no_vmsa:
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		sev_free_decrypted_vmsa(vcpu, save);
 }
 
@@ -3601,7 +3601,7 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	struct kvm_run *kvm_run = vcpu->run;
 
 	/* SEV-ES guests must use the CR write traps to track CR registers. */
-	if (!sev_es_guest(vcpu->kvm)) {
+	if (!is_sev_es_guest(vcpu)) {
 		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
 			vcpu->arch.cr0 = svm->vmcb->save.cr0;
 		if (npt_enabled)
@@ -3653,7 +3653,7 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
 		svm->current_vmcb->cpu = vcpu->cpu;
         }
 
-	if (sev_guest(vcpu->kvm))
+	if (is_sev_guest(vcpu))
 		return pre_sev_run(svm, vcpu->cpu);
 
 	/* FIXME: handle wraparound of asid_generation */
@@ -3796,7 +3796,7 @@ static void svm_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 	 * SEV-ES guests must always keep the CR intercepts cleared. CR
 	 * tracking is done using the CR write traps.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		return;
 
 	if (nested_svm_virtualize_tpr(vcpu))
@@ -3985,7 +3985,7 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vcpu)
 	 * ignores SEV-ES guest writes to EFER.SVME *and* CLGI/STGI are not
 	 * supported NAEs in the GHCB protocol.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		return;
 
 	if (!gif_set(svm)) {
@@ -4273,7 +4273,7 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	amd_clear_divider();
 
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		__svm_sev_es_vcpu_run(svm, spec_ctrl_intercepted,
 				      sev_es_host_save_area(sd));
 	else
@@ -4374,7 +4374,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 	if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
 		x86_spec_ctrl_restore_host(svm->virt_spec_ctrl);
 
-	if (!sev_es_guest(vcpu->kvm)) {
+	if (!is_sev_es_guest(vcpu)) {
 		vcpu->arch.cr2 = svm->vmcb->save.cr2;
 		vcpu->arch.regs[VCPU_REGS_RAX] = svm->vmcb->save.rax;
 		vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
@@ -4524,7 +4524,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
-	if (sev_guest(vcpu->kvm))
+	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
 
@@ -4920,7 +4920,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 		return X86EMUL_UNHANDLEABLE_VECTORING;
 
 	/* Emulation is always possible when KVM has access to all guest state. */
-	if (!sev_guest(vcpu->kvm))
+	if (!is_sev_guest(vcpu))
 		return X86EMUL_CONTINUE;
 
 	/* #UD and #GP should never be intercepted for SEV guests. */
@@ -4932,7 +4932,7 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	 * Emulation is impossible for SEV-ES guests as KVM doesn't have access
 	 * to guest register state.
 	 */
-	if (sev_es_guest(vcpu->kvm))
+	if (is_sev_es_guest(vcpu))
 		return X86EMUL_RETRY_INSTR;
 
 	/*
@@ -5069,7 +5069,7 @@ static bool svm_apic_init_signal_blocked(struct kvm_vcpu *vcpu)
 
 static void svm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
 {
-	if (!sev_es_guest(vcpu->kvm))
+	if (!is_sev_es_guest(vcpu))
 		return kvm_vcpu_deliver_sipi_vector(vcpu, vector);
 
 	sev_vcpu_deliver_sipi_vector(vcpu, vector);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ebd7b36b1ceb..121138901fd6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -388,10 +388,27 @@ static __always_inline bool sev_snp_guest(struct kvm *kvm)
 	return (sev->vmsa_features & SVM_SEV_FEAT_SNP_ACTIVE) &&
 	       !WARN_ON_ONCE(!sev_es_guest(kvm));
 }
+
+static __always_inline bool is_sev_guest(struct kvm_vcpu *vcpu)
+{
+	return sev_guest(vcpu->kvm);
+}
+static __always_inline bool is_sev_es_guest(struct kvm_vcpu *vcpu)
+{
+	return sev_es_guest(vcpu->kvm);
+}
+
+static __always_inline bool is_sev_snp_guest(struct kvm_vcpu *vcpu)
+{
+	return sev_snp_guest(vcpu->kvm);
+}
 #else
 #define sev_guest(kvm) false
 #define sev_es_guest(kvm) false
 #define sev_snp_guest(kvm) false
+#define is_sev_guest(vcpu) false
+#define is_sev_es_guest(vcpu) false
+#define is_sev_snp_guest(vcpu) false
 #endif
 
 static inline bool ghcb_gpa_is_registered(struct vcpu_svm *svm, u64 val)
-- 
2.53.0.473.g4a7958ca14-goog

