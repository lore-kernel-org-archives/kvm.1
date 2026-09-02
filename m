Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692D82866
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 00:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788307782; cv=none; b=LRXwb7AsNbgBnhWMSQOwFM2oTn24lWrqTVqmGTk2GM79XSUlel8IBqXGOQRASAgy9VqeAtWLAdWnXqCE2i+K3Bq0LUEumuNxbHUy4JZdMknj8CNLOK2+atk/5FPCDIT3nLF/i1P9R90jTJ+gsUlsMO50zMMpZdhu3zmbCl4EtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788307782; c=relaxed/simple;
	bh=Uwi2ZP+TWzf+TQEGiOr7/4pum0D67/+v4qaSyQSsr3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gaGuD4vqz2DS9MeMT74YiRQF5CDn+6GWWWmw2gS3qktVcaMUwMgs/JVNF/YDREbT/dhaPMvChu+TcWktIHUlaLM5jfIwZ9k9qgpYG+1x2+ubxnNEKlvektVtomMoFK2WxLe4tZYcobZsTEyNKhGHN51LXGnyHZve75yCyC8fuGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTeVhU/0; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTeVhU/0"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d55d8cd938so6374225ad.1
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788307781; x=1788912581; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FScwLOZbXcVrXmE1MGEAJI69Oc/+RuISTFY4Ip1hoLk=;
        b=RTeVhU/0ERh3RaRVfuVwevTPHPNC38i/Jc6shh7q8Bey0q5gYtvixjmmP9PsqPcxdm
         Gv5e7pN6qkXwBJK6ToYfJu5BfbEOwCqIRnF3D76yEGoOum/K+ARBaktqaRjykxwgUH6J
         z1PVxVg4yot+DDc1lE7f2bq2eHlZCactQD/a8AOxEtgAInyZnDPKykCcUJRiVL1Q/Wj0
         vBRYFX+LS1s0UuEpxOYgkH0FMukux9auq+66ze3HPvD0EbB/03MCg9CrPziH4AjrGjd8
         1HjIUrWvvE7VMcAHFer7dAsuvnH2BYZp0EQ9I3HNR7wXET0FcGDW5ALZHfXW5gOizAs1
         JqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788307781; x=1788912581;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FScwLOZbXcVrXmE1MGEAJI69Oc/+RuISTFY4Ip1hoLk=;
        b=AKuj35nZZAxEyxFHhKjakN48vXdvd8A89hBgkE2Y3RYoDT8eNVPnu+dgLgVEG/jfSS
         uHL4gmgBuTAGMMj8B3TnO+m3YyrjgXk0YfL0X722009eF98BMXs0O6ZMTvbGNov7YijQ
         keAdvX5B12ax4qdMA1Bva7xKls9+cYM2YBp+4QzpaSF6mI1zAvPeHLh6x3a6zpxh43SQ
         yBrHpWD+c7CyV4igRP9dFzK0lyiyG4ywC1XN7alYc/M+M1EOwbK1Pt4crmQC0lcWTOJT
         9obsgKGNBA8yHvzw3iG/4SMPbPFMvLlDjt0Iu7urQ5JlOASigSZUuLH0xkxNPDrEAq0r
         OU2A==
X-Forwarded-Encrypted: i=1; AKwUvBxhOGc+JxIU6E9tqbU4B4xXhK5yjtwnldrSyHyY70yx4P0pZy5kuJLDBGKHv3MLPbu05L8=@vger.kernel.org
X-Gm-Message-State: AFuF++n0KgSJS2CtWnXJ2XqhLyI5qYD/Pqf/Kbiuvicsk6BkNNDutAvs
	ZgBUs1t6G4GqCUOULbTcURgdtaWRK6Vf/tHQrh7gLgG4YSyj6Q6gD+RDLZ4rR+9Tx2EzImRJdjU
	JuvkGhA==
X-Received: from plov15.prod.google.com ([2002:a17:902:8d8f:b0:2ce:9080:3fce])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8d:b0:2d5:e3ce:3988
 with SMTP id d9443c01a7336-2daec6b2142mr12568695ad.11.1788307780592; Tue, 01
 Sep 2026 17:09:40 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:09:39 -0700
In-Reply-To: <20260529063833.1660791-1-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <77f1f310-d789-427e-8c10-bd6ac4836add@amd.com> <20260529063833.1660791-1-nikunj@amd.com>
Message-ID: <apdpQ4eUkXODO-bI@google.com>
Subject: Re: [PATCH v7.1] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: pbonzini@redhat.com, bp@alien8.de, joao.m.martins@oracle.com, 
	kai.huang@intel.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	yosry@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, Nikunj A Dadhania wrote:
> @@ -3331,6 +3364,53 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
>  	return kvm_emulate_hypercall(vcpu);
>  }
>  
> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)

This can be static.

> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct vmcb *vmcb01 = svm->vmcb01.ptr;
> +
> +	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))

This can/should be moved to common code.

> +		return;
> +
> +	/*
> +	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
> +	 * code, but in that case another update request will be made and so
> +	 * the guest will never run with a stale PML value.
> +	 */

Ditto with this copy+pasted comment.

> +	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))

And this check.  E.g. (incomplete, needs to be split up)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0a8ef0b4ddda..73564619a61e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3377,20 +3377,12 @@ static int vmmcall_interception(struct kvm_vcpu *vcpu)
 	return kvm_emulate_hypercall(vcpu);
 }
 
-void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+static void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb01 = svm->vmcb01.ptr;
 
-	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
-		return;
-
-	/*
-	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
-	 * code, but in that case another update request will be made and so
-	 * the guest will never run with a stale PML value.
-	 */
-	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
+	if (enable)
 		vmcb01->control.misc_ctl |= SVM_MISC_ENABLE_PML;
 	else
 		vmcb01->control.misc_ctl &= ~SVM_MISC_ENABLE_PML;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0052446e04d9..828a51418d83 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8416,21 +8416,13 @@ static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit
 }
 #endif
 
-void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu, bool enable)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
-		return;
-
 	guard(vmx_vmcs01)(vcpu);
 
-	/*
-	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
-	 * code, but in that case another update request will be made and so
-	 * the guest will never run with a stale PML value.
-	 */
-	if (atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
+	if (enable)
 		secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_ENABLE_PML);
 	else
 		secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_ENABLE_PML);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 33715236afc9..4443796c4426 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8073,6 +8073,21 @@ static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 	kvm_x86_call(set_apic_access_page_addr)(vcpu);
 }
 
+static void kvm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, nr_memslots_dirty_logging can be changed concurrent with this
+	 * code, but in that case another update request will be made and so
+	 * the guest will never run with a stale PML value.
+	 */
+	bool enabled = atomic_read(&vcpu->kvm->nr_memslots_dirty_logging);
+
+	if (WARN_ON_ONCE(!vcpu->kvm->arch.cpu_dirty_log_size))
+		return;
+
+	kvm_x86_call(update_cpu_dirty_logging)(vcpu, enable);
+}
+
 /*
  * Called within kvm->srcu read side.
  * Returns 1 to let vcpu_run() continue the guest execution loop without
@@ -8238,8 +8253,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (kvm_check_request(KVM_REQ_RECALC_INTERCEPTS, vcpu))
 			kvm_x86_call(recalc_intercepts)(vcpu);
 
-		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu))
-			kvm_x86_call(update_cpu_dirty_logging)(vcpu);
+
+		/*
+		 * Note, nr_memslots_dirty_logging can be changed concurrent
+		 * with this code, but in that case another update request will
+		 * be made and so the guest will never run with stale PML state.
+	 	 */
+		if (kvm_check_request(KVM_REQ_UPDATE_CPU_DIRTY_LOGGING, vcpu)
+			kvm_update_cpu_dirty_logging(vcpu);
 
 		if (kvm_check_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu)) {
 			kvm_vcpu_reset(vcpu, true);


> +		vmcb01->control.misc_ctl |= SVM_MISC_ENABLE_PML;
> +	else
> +		vmcb01->control.misc_ctl &= ~SVM_MISC_ENABLE_PML;
> +
> +	vmcb_mark_dirty(vmcb01, VMCB_NPT);
> +}
> +
> +static void svm_flush_pml_buffer(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	struct vmcb_control_area *control = &svm->vmcb->control;
> +
> +	/* Do nothing if PML buffer is empty */
> +	if (control->pml_index == PML_HEAD_INDEX)
> +		return;
> +
> +	kvm_flush_pml_buffer(vcpu, control->pml_index);
> +
> +	/* Reset the PML index */
> +	control->pml_index = PML_HEAD_INDEX;
> +}
> +
> +static int pml_full_interception(struct kvm_vcpu *vcpu)
> +{
> +	trace_kvm_pml_full(vcpu->vcpu_id);
> +
> +	/*
> +	 * PML buffer is already flushed at the beginning of svm_handle_exit().
> +	 * Nothing to do here.
> +	 */
> +	return 1;
> +}
> +
>  static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  	[SVM_EXIT_READ_CR0]			= cr_interception,
>  	[SVM_EXIT_READ_CR3]			= cr_interception,
> @@ -3407,6 +3487,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
>  #ifdef CONFIG_KVM_AMD_SEV
>  	[SVM_EXIT_VMGEXIT]			= sev_handle_vmgexit,
>  #endif
> +	[SVM_EXIT_PML_FULL]			= pml_full_interception,
>  };
>  
>  static void dump_vmcb(struct kvm_vcpu *vcpu)
> @@ -3456,8 +3537,14 @@ static void dump_vmcb(struct kvm_vcpu *vcpu)
>  	pr_err("%-20s%016llx\n", "exit_info2:", control->exit_info_2);
>  	pr_err("%-20s%08x\n", "exit_int_info:", control->exit_int_info);
>  	pr_err("%-20s%08x\n", "exit_int_info_err:", control->exit_int_info_err);
> -	pr_err("%-20s%lld\n", "misc_ctl:", control->misc_ctl);
> +	pr_err("%-20s%llx\n", "misc_ctl:", control->misc_ctl);
>  	pr_err("%-20s%016llx\n", "nested_cr3:", control->nested_cr3);
> +
> +	if (pml) {
> +		pr_err("%-20s%016llx\n", "pml_addr:", control->pml_addr);
> +		pr_err("%-20s%04x\n", "pml_index:", control->pml_index);
> +	}
> +
>  	pr_err("%-20s%016llx\n", "avic_vapic_bar:", control->avic_vapic_bar);
>  	pr_err("%-20s%016llx\n", "ghcb:", control->ghcb_gpa);
>  	pr_err("%-20s%08x\n", "event_inj:", control->event_inj);
> @@ -3635,6 +3722,13 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 __exit_code)
>  	    (u64)exit_code != __exit_code)
>  		goto unexpected_vmexit;
>  
> +	/*
> +	 * PML is never enabled when running L2, bail immediately if a PML full
> +	 * exit occurs as something is horribly wrong.
> +	 */
> +	if (unlikely(is_guest_mode(vcpu) && exit_code == SVM_EXIT_PML_FULL))
> +		goto unexpected_vmexit;
> +
>  #ifdef CONFIG_MITIGATION_RETPOLINE
>  	if (exit_code == SVM_EXIT_MSR)
>  		return msr_interception(vcpu);
> @@ -3703,6 +3797,14 @@ static int svm_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	struct kvm_run *kvm_run = vcpu->run;
>  
> +	/*
> +	 * Opportunistically flush the PML buffer on VM exit. This keeps the
> +	 * dirty bitmap current by processing logged GPAs rather than waiting for
> +	 * PML_FULL exit.
> +	 */
> +	if (vcpu->kvm->arch.cpu_dirty_log_size && !is_guest_mode(vcpu))
> +		svm_flush_pml_buffer(vcpu);
> +
>  	if (unlikely(exit_fastpath == EXIT_FASTPATH_EXIT_USERSPACE))
>  		return 0;
>  
> @@ -5310,6 +5412,9 @@ static int svm_vm_init(struct kvm *kvm)
>  			return ret;
>  	}
>  
> +	if (pml)
> +		kvm->arch.cpu_dirty_log_size = PML_LOG_NR_ENTRIES;
> +
>  	svm_srso_vm_init();
>  	return 0;
>  }
> @@ -5465,6 +5570,8 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.gmem_prepare = sev_gmem_prepare,
>  	.gmem_invalidate = sev_gmem_invalidate,
>  	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
> +
> +	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,

Please keep the ordering somewhat similar to the other declarations, i.e. don't
just put this at the end.  This seems like the least awful place:

	.handle_exit_irqoff = svm_handle_exit_irqoff,

	.update_cpu_dirty_logging = svm_update_cpu_dirty_logging,

	.deliver_interrupt = svm_deliver_interrupt,

> @@ -832,6 +833,8 @@ static inline void svm_enable_intercept_for_msr(struct kvm_vcpu *vcpu,
>  	svm_set_intercept_for_msr(vcpu, msr, type, true);
>  }
>  
> +void svm_update_cpu_dirty_logging(struct kvm_vcpu *vcpu);

And this goes away.
