Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3C46A5E9
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648237; cv=none; b=iQcTD3tguZRTSpE2A1I6KLolyp8ECnyD8yFQIt4Gi9DzwV6hQmMzOp2wsEvUgN1kLkQDdv/yv2EetWN88ko3NQNT8v659T43hXVl1/IArrGokZjUD32/C++Zj8Zj9i8F3IpsGO+ixvwdAZ5kDmgVqHufI+CJhO8p/oZsboz9uDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648237; c=relaxed/simple;
	bh=3h1rSQsYexBOx23WaKjk3w8lBfhkSbXmrqt7V6zjP3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QhEZc6MbMgFN2eec9S/gN5CFGC37J9UCvfuFt8H60qsar1HP3FCirOr6x1eB8IDguvzct4TZt5k3s71baAhvmzf56kog4qbF9fQfX0QPPK+K63zHildGXYaySs6nesBoVg36VX1HOSxmxcvyCg1kMr+JDZSV6LQdhhjSNrjynSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FGh/nwsF; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FGh/nwsF"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cab041eced3so14070888a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784648234; x=1785253034; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5hI0BMY86SS4kS3z8zw9Ya7aSpSDYzk3HgQEpLEHcbE=;
        b=FGh/nwsFFCf3JOZt5wTYpNmzKlG49FSGP2vO9Zg+RJWpbfKTWw0CPrUyrrhvhArgFA
         HjoBv8eD0CNW6aPyYNxqF1QxfgwI9MW3z9eOhupRzw1a3/KbE/BSEsQ8mSVLFQgL8iBC
         k4LcUI/maLmBM2RLfIBMoK+P73kyyncIh5gj+71KO88LcBOC4CdGEOHZ3jJGWn/Ti6CZ
         GKPcOJn9FUqx/fvYtrVvsutiAc7Uu3OocP9h0tB7Mqp/ymhoolmn5sRyWEJDcDwuvVZy
         /WhScxuo2MR1tsrnfs0798Dp4WdaOvGxUUtEKkmgubqAaHRPzEm8uEwEZCasapat1+GL
         wQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784648234; x=1785253034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5hI0BMY86SS4kS3z8zw9Ya7aSpSDYzk3HgQEpLEHcbE=;
        b=QmI+B2hRslT/VyJOdldo2eLjFWdyrFFaTjHrvMcc0b1TTqxVnEf0D262QI2mXWiBmO
         Fx/z61rnKr2+3fwIyhB62Can5VfFcEUoTXT7nbo0YiRwFdnnj+P1IC2Bj9IeTnRPfLxM
         2aOfaLFERB1Clo8BWDaF7+2AukRoTxnvJ/gaUEZqIw+XSTcdcRpTbedNU/ERpRT8Y/dT
         61P6CLW/CVcGzmKlUhqnNFVs748l6sBo+Sg43V97MiQNkSfNHdrn5zLC5HFvt4TRQF8u
         OKlB/EqR2nuINhr9PwOiF34NZDt+aDu92/ZJr7iIYY64ZiiZlTRcEegZWgiMA/fNlDOD
         dTTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rokvru2EQYrO6AA4987qmFrFvJyDHATU95R5PstHO8HcHufcYyAm/wmhSSfVNM/nZEf0KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMx7xcMG6swq7oOWujSHi6pbAynlVExy85NOUa/tHhgJs14Nmj
	MT5+iVPhWFTnF9mS8RErNDYX5WW5CxE5CEGKgOYq3KTDr7uDkcffn0Ncjd/reDWy5qkmaZ5iyJG
	9KuiSYw==
X-Received: from pjbrr3.prod.google.com ([2002:a17:90b:2b43:b0:37d:95c5:815d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5784:b0:38d:ecfe:41aa
 with SMTP id 98e67ed59e1d1-38e4b5a08aemr19226835a91.43.1784648234079; Tue, 21
 Jul 2026 08:37:14 -0700 (PDT)
Date: Tue, 21 Jul 2026 08:37:13 -0700
In-Reply-To: <al8wZQwqC9IhlBZc@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <al8wZQwqC9IhlBZc@192.168.1.215>
Message-ID: <al-SKXoha-dqz047@google.com>
Subject: Re: [PATCH v3] KVM: x86: Mark nested RSM-created VM-Enter as untrusted
From: Sean Christopherson <seanjc@google.com>
To: Hao Zhang <hao_zhang_kdev@163.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 21, 2026, Hao Zhang wrote:
> From: Hao Zhang <zhanghao1@kylinos.cn>
> 
> RSM can restore state that indicates the vCPU was running L2 when SMI
> arrived.  KVM then re-enters nested guest mode and marks nested_run_pending
> so that the next KVM_RUN completes the pending nested transition.
> 
> Unlike a normal nested VMLAUNCH/VMRESUME, the state restored by RSM comes
> from SMRAM.  Userspace can modify SMRAM before RSM.  The resulting L2 state
> may require invalid-guest-state emulation.  If KVM trusts that pending run,
> VMX can synthesize EXIT_REASON_INVALID_STATE before hardware VM-Entry
> completes the pending run and trip the nested_run_pending invariant.
> 
> Do not treat an RSM-created pending nested run as KVM-trusted state.  Mark
> the run as KVM_NESTED_RUN_PENDING_UNTRUSTED for both VMX and SVM, matching
> the existing userspace-modified-state handling in kvm_x86_vcpu_pre_run().
> 
> Keep the VMX BUG check for trusted pending nested VM-Enters, but allow
> untrusted pending state to reach the existing invalid-L2-state handling.
> If that handling synthesizes a nested VM-Exit back to L1, retain the
> pending state while synchronizing VMCS02 to VMCS12, and consume it before
> restoring L1 state so that the flag does not leak into L1 and block event
> injection.
> 
> Fixes: 2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_required")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
> ---
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cc75feec05da..cf5c3f78ebfc 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6715,12 +6715,14 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
>  		return 0;
>  
>  	/*
> -	 * KVM should never reach this point with a pending nested VM-Enter.
> -	 * More specifically, short-circuiting VM-Entry to emulate L2 due to
> -	 * invalid guest state should never happen as that means KVM knowingly
> -	 * allowed a nested VM-Enter with an invalid vmcs12.  More below.
> -	 */
> -	if (KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->kvm))
> +	 * KVM should never reach this point with a trusted pending nested
> +	 * VM-Enter.  Short-circuiting VM-Entry to emulate L2 due to invalid
> +	 * guest state after a normal nested VM-Enter would mean KVM knowingly
> +	 * allowed an invalid vmcs12.  Pending VM-Enters restored from untrusted
> +	 * state are handled below.
> +	 */
> +	if (KVM_BUG_ON(vcpu->arch.nested_run_pending == KVM_NESTED_RUN_PENDING,
> +		       vcpu->kvm))

Ugh, I missed that my suggestion would require adjusting this KVM_BUG_ON().
That's not the end of the world, but it's not great either because it further
degrades the sanity checks provided by nested_run_pending.

And while Sashiko was hallucinating wildly with respect to a "mailicious L2
modifying SMRAM", Sashiko did have a point about leaving nested_run_pending set
beyond the emulated RSM.  KVM really should check for the impossible state after
loading vCPU state from SMRAM in emulator_leave_smm(), so that forcibly leaving
nested mode to synthesize TRIPLE_FAULT into L1 naturally Just Works.

The only reason I didn't suggest that is because I didn't want to add another
SMM-specific kvm_x86_ops hook, but I think we can avoid that and (arguably)
improve other paths at the same time.

Rather than provide a generic .vcpu_pre_run() hook, which is somewhat confusing
because SVM has it's own pre_svm_run(), what if we provide separate hooks for
unhandleable_emulation_required() and vcpu_needs_initialization()?  That bleeds
some vendor specific details into common x86, but in many ways, that's a _good_
thing in this case because I think it's helpful to highlight the need for
additional initialization for CoCo vCPUs.

Do you happen to have a reproducer I can test?  Either way, I'll try to add a
testcase to tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c to
cover the SMRAM => RSM path.

Not tested yet, it needs to be chunked into ~3 patches, and there probably needs
to be a comment or two, but I'm thinking this:

---
 arch/x86/include/asm/kvm-x86-ops.h |  3 ++-
 arch/x86/include/asm/kvm_host.h    |  4 +++-
 arch/x86/kvm/smm.c                 |  4 ++++
 arch/x86/kvm/svm/sev.c             |  5 +++++
 arch/x86/kvm/svm/svm.c             | 12 +-----------
 arch/x86/kvm/svm/svm.h             |  1 +
 arch/x86/kvm/vmx/main.c            | 19 +++++++++++++++----
 arch/x86/kvm/vmx/nested.c          |  6 +++++-
 arch/x86/kvm/vmx/tdx.c             |  9 +++------
 arch/x86/kvm/vmx/vmx.c             | 12 +-----------
 arch/x86/kvm/vmx/x86_ops.h         |  3 ++-
 arch/x86/kvm/x86.c                 | 10 +++++++++-
 12 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 736129db272a..53b368a63b81 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -63,11 +63,12 @@ KVM_X86_OP_OPTIONAL(flush_remote_tlbs_range)
 #endif
 KVM_X86_OP(flush_tlb_gva)
 KVM_X86_OP(flush_tlb_guest)
-KVM_X86_OP(vcpu_pre_run)
+KVM_X86_OP_OPTIONAL_RET0(vcpu_needs_initialization)
 KVM_X86_OP(vcpu_run)
 KVM_X86_OP(handle_exit)
 KVM_X86_OP(skip_emulated_instruction)
 KVM_X86_OP_OPTIONAL(update_emulated_instruction)
+KVM_X86_OP_OPTIONAL_RET0(unhandleable_emulation_required)
 KVM_X86_OP(set_interrupt_shadow)
 KVM_X86_OP(get_interrupt_shadow)
 KVM_X86_OP(patch_hypercall)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 58f156ae31e7..e190fcee0c4f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1584,13 +1584,15 @@ struct kvm_x86_ops {
 	 */
 	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu);
 
-	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
+	bool (*vcpu_needs_initialization)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
 						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
 		enum exit_fastpath_completion exit_fastpath);
 	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
 	void (*update_emulated_instruction)(struct kvm_vcpu *vcpu);
+	bool (*unhandleable_emulation_required)(struct kvm_vcpu *vcpu);
+
 	void (*set_interrupt_shadow)(struct kvm_vcpu *vcpu, int mask);
 	u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
 	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index a446487bdd5c..656a38dad7e7 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -649,6 +649,10 @@ int emulator_leave_smm(struct x86_emulate_ctxt *ctxt)
 #endif
 		ret = rsm_load_state_32(ctxt, &smram.smram32);
 
+	if (ret == X86EMUL_CONTINUE &&
+	    kvm_x86_call(unhandleable_emulation_required)(vcpu))
+		ret = X86EMUL_UNHANDLEABLE;
+
 	/*
 	 * If RSM fails and triggers shutdown, architecturally the shutdown
 	 * occurs *before* the transition to guest mode.  But due to KVM's
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 82b983484af2..9e416eafcc6b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3533,6 +3533,11 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__sev_es_unmap_ghcb(svm);
 }
 
+bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
+{
+	return to_kvm_sev_info(vcpu->kvm)->need_init;
+}
+
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 91286d46d13a..9088ee520766 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4384,16 +4384,6 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 	svm_complete_interrupts(vcpu);
 }
 
-static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
-{
-#ifdef CONFIG_KVM_AMD_SEV
-	if (to_kvm_sev_info(vcpu->kvm)->need_init)
-		return -EINVAL;
-#endif
-
-	return 1;
-}
-
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5370,7 +5360,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.flush_tlb_gva = svm_flush_tlb_gva,
 	.flush_tlb_guest = svm_flush_tlb_guest,
 
-	.vcpu_pre_run = svm_vcpu_pre_run,
 	.vcpu_run = svm_vcpu_run,
 	.handle_exit = svm_handle_exit,
 	.skip_emulated_instruction = svm_skip_emulated_instruction,
@@ -5428,6 +5417,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
+	.vcpu_needs_initialization = sev_vcpu_needs_initialization,
 	.dev_get_attr = sev_dev_get_attr,
 	.mem_enc_ioctl = sev_mem_enc_ioctl,
 	.mem_enc_register_region = sev_mem_enc_register_region,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index af25e4b56212..1217234b952f 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -979,6 +979,7 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 
 #ifdef CONFIG_KVM_AMD_SEV
+bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp);
 int sev_mem_enc_register_region(struct kvm *kvm,
 				struct kvm_enc_region *range);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 04f986e3d439..7c2b67c88b48 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -140,12 +140,12 @@ static void vt_vcpu_put(struct kvm_vcpu *vcpu)
 	vmx_vcpu_put(vcpu);
 }
 
-static int vt_vcpu_pre_run(struct kvm_vcpu *vcpu)
+static bool vt_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu))
-		return tdx_vcpu_pre_run(vcpu);
+		return tdx_vcpu_needs_initialization(vcpu);
 
-	return vmx_vcpu_pre_run(vcpu);
+	return false;
 }
 
 static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
@@ -165,6 +165,16 @@ static int vt_handle_exit(struct kvm_vcpu *vcpu,
 	return vmx_handle_exit(vcpu, fastpath);
 }
 
+static bool vt_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu)) {
+		WARN_ON_ONCE(to_vt(vcpu)->emulation_required);
+		return false;
+	}
+
+	return vmx_unhandleable_emulation_required(vcpu);
+}
+
 static int vt_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	if (unlikely(is_td_vcpu(vcpu)))
@@ -939,11 +949,12 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.flush_tlb_gva = vt_op(flush_tlb_gva),
 	.flush_tlb_guest = vt_op(flush_tlb_guest),
 
-	.vcpu_pre_run = vt_op(vcpu_pre_run),
+	.vcpu_needs_initialization = vt_op_tdx_only(vcpu_needs_initialization),
 	.vcpu_run = vt_op(vcpu_run),
 	.handle_exit = vt_op(handle_exit),
 	.skip_emulated_instruction = vmx_skip_emulated_instruction,
 	.update_emulated_instruction = vmx_update_emulated_instruction,
+	.unhandleable_emulation_required = vt_op(unhandleable_emulation_required),
 	.set_interrupt_shadow = vt_op(set_interrupt_shadow),
 	.get_interrupt_shadow = vt_op(get_interrupt_shadow),
 	.patch_hypercall = vt_op(patch_hypercall),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b5460de4b1a7..61e0c4cbc5b1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -354,9 +354,13 @@ static void free_nested(struct kvm_vcpu *vcpu)
 	vmx->nested.current_vmptr = INVALID_GPA;
 	if (enable_shadow_vmcs) {
 		vmx_disable_shadow_vmcs(vmx);
-		vmcs_clear(vmx->vmcs01.shadow_vmcs);
+
+		preempt_disable();
+		if (vmx->vmcs01.launched)
+			vmcs_clear(vmx->vmcs01.shadow_vmcs);
 		free_vmcs(vmx->vmcs01.shadow_vmcs);
 		vmx->vmcs01.shadow_vmcs = NULL;
+		preempt_enable();
 	}
 	kfree(vmx->nested.cached_vmcs12);
 	vmx->nested.cached_vmcs12 = NULL;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d1af0a752e97..b272c20586a7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -897,13 +897,10 @@ void tdx_vcpu_free(struct kvm_vcpu *vcpu)
 	tdx->state = VCPU_TD_STATE_UNINITIALIZED;
 }
 
-int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu)
+bool tdx_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(to_tdx(vcpu)->state != VCPU_TD_STATE_INITIALIZED ||
-		     to_kvm_tdx(vcpu->kvm)->state != TD_STATE_RUNNABLE))
-		return -EINVAL;
-
-	return 1;
+	return to_tdx(vcpu)->state != VCPU_TD_STATE_INITIALIZED ||
+	       to_kvm_tdx(vcpu->kvm)->state != TD_STATE_RUNNABLE;
 }
 
 static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..76160adf8297 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6035,7 +6035,7 @@ static int handle_nmi_window(struct kvm_vcpu *vcpu)
  * with unsrestricted guest mode disabled) and KVM can't faithfully emulate the
  * current vCPU state.
  */
-static bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
+bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
@@ -6110,16 +6110,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
-{
-	if (vmx_unhandleable_emulation_required(vcpu)) {
-		kvm_prepare_emulation_failure_exit(vcpu);
-		return 0;
-	}
-
-	return 1;
-}
-
 /*
  * Indicate a busy-waiting vcpu in spinlock. We do not enable the PAUSE
  * exiting, so only get here on cpu with PAUSE-Loop-Exiting.
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 409858074246..8b198de510bc 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -31,6 +31,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath);
 void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu);
 int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu);
 void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu);
+bool vmx_unhandleable_emulation_required(struct kvm_vcpu *vcpu);
 int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 #ifdef CONFIG_KVM_SMM
 int vmx_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection);
@@ -137,7 +138,7 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu);
 void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void tdx_vcpu_free(struct kvm_vcpu *vcpu);
 void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
-int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu);
+bool tdx_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
 fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void tdx_vcpu_put(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1f5dc685f049..ed03e53ce72e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8853,7 +8853,15 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	    !kvm_apic_init_sipi_allowed(vcpu))
 		return -EINVAL;
 
-	return kvm_x86_call(vcpu_pre_run)(vcpu);
+	if (kvm_x86_call(vcpu_needs_initialization)(vcpu))
+		return -EINVAL;
+
+	if (kvm_x86_call(unhandleable_emulation_required)(vcpu)) {
+		kvm_prepare_emulation_failure_exit(vcpu);
+		return 0;
+	}
+
+	return 1;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)

base-commit: 6bc96b971766fbbbbdd9fb2642cedacaf02da957
-- 

