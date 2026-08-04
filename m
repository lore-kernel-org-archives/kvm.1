Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5438887D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 00:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804265; cv=none; b=HLRyoz1pTx3MdCjCEN8a41/LUKxVcw5CdlZhRTMb205Qo06KkB8PGbuOtAx5+mYG8rdvkoAaH1f0Q2CoIUE4d391yabHJBc8UtwcZHVEo49BIhm/fjo5f8zNBDHYSCVimSILsXnOcxznzf9doRMcZ8dDJEYOY6H12CNzQ9jGdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804265; c=relaxed/simple;
	bh=YORiretLk4V5ATTNGHm9EsBVW20CqCqKRMNR0q9otYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KrlhLPPfh8pM2A25up0WfWvvkBC+88CYLo4VQ+jxJsfuecKx7KuZ5yuppdh8ijRNbKhq/EKwwvqv+cqYpZ6F403EyhxOWFK4Hj3Xo3cf4PTPVnZVlDHdDrldPnh5ewUrBN1kJKeo8PcR04uEIjIWDlwcNHvCFls+TJwakxR+UEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBFU4kp6; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBFU4kp6"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8486c3411c8so5630662b3a.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785804263; x=1786409063; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYLjFz0HT+nr4nWGRixSwZ6A+HG/32q1iC0/YyJz0Zc=;
        b=bBFU4kp6O2XqY7to510ihZuytIQH7Jneh84sggQFeUMCX9A3iO+ZxJK5e8mAfDelae
         eotAwrHxuuqo9BptI9VH3+B0w1gQPvb+JwlEBBcyhUpLVPbTH5QcDTlu6NhktfeFM259
         i6UbmqaMtN9b0ocUUlKyb2cxM1xcQ5MHbVoO9mY9SDvSk+/5tAp4oQKTzbgABsNC2hNp
         JTO+OSBDixnFojNCWOCYDLFh/MNoStqhGmqqnYNWEeyplrS/AqrJt0z2Z9HZOdqoI8R7
         j/rfX7YhkAOOTPkyPK1HR/Cz5h7L8nAW4vRu8FnRC3n46o451HUz5cc88YWAF8+KJDpD
         mJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804263; x=1786409063;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GYLjFz0HT+nr4nWGRixSwZ6A+HG/32q1iC0/YyJz0Zc=;
        b=IbA3WMObXFCqhObphA57307FV8yBptROiOGPm65cKGVprJckod0cw0ms6GBg4XSAGf
         x+nleKXV28p3C9meMLSwtcgbFfqFZ4WdscEfFIDPz2jkXx3dqSb69DV0RIo0uP7JDhWf
         XhJvUzMLLYvBqoZwHxzv2vX8yAyh9NSZTgys4PcauRg9BhD4VolAPprYGhcydUlXY/RV
         TuTnJTQErLEVqZ2Tny8DyguGIEYs6Y87rVTo9zcvlWyh8mVHhUQNXYJi3MIQfxSN9noe
         WJpp2w9MfqAo1cD6h/fs7EddF27q4WzMXfMJuty81cJeYOHRLaiQ/NDcNwzvfqqBOhfu
         SRFw==
X-Forwarded-Encrypted: i=1; AHgh+RrTz6VXiWxyo98Pzva/KcMfLCp2/IO1VuG4hib/uWGBBYgLTbpfs20ofvHPgrnZ6POoLKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyq2OBU7Vvaftc6cCZSdZdmIAakT9Mpp34Qm8BotIaKRm3DdAO
	85f48HNnx1PFB1rlhemckhz8N9aqvY5jUB2Ss/zMvLOoQfukZjYNqjf+xgPkoJQb0DYvR3KbK25
	X08EiTQ==
X-Received: from pfbhj17.prod.google.com ([2002:a05:6a00:8711:b0:848:2b3a:8a03])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b56:b0:84e:538:476d
 with SMTP id d2e1a72fcca58-84ee4909223mr10308281b3a.50.1785804263080; Mon, 03
 Aug 2026 17:44:23 -0700 (PDT)
Date: Mon, 3 Aug 2026 17:44:22 -0700
In-Reply-To: <am3Bs0DjZ5kay9NJ@v4bel>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <am3Bs0DjZ5kay9NJ@v4bel>
Message-ID: <anE15pfdYLCZtHCn@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't load L1's host state when freeing a vCPU
From: Sean Christopherson <seanjc@google.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, dwmw2@infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 01, 2026, Hyunwoo Kim wrote:
> Don't load L1's host state when kicking a vCPU out of nested guest mode as
> part of freeing the vCPU, as loading host state processes vmcs12's VM-Exit
> MSR load list, i.e. reads an (index, value) pair out of guest memory and
> feeds it to kvm_emulate_msr_write() with host_initiated=false. Letting the
> guest emulate WRMSR against VM-scope state that KVM is actively tearing
> down goes sideways in at least two ways.
> 
> Writing HV_X64_MSR_ICR sends an IPI, which for a non-shorthand,
> non-broadcast destination walks kvm->arch.apic_map to dereference the
> target's local APIC. kvm_free_lapic() neither rebuilds nor dirties the map,
> and the map is freed only after all vCPUs are destroyed, i.e. the map still
> points at the already-freed local APIC of a previously destroyed vCPU. This
> requires userspace to expose Hyper-V's CPUID to the guest. Writing
> MSR_KVM_SYSTEM_TIME_NEW activates the kvmclock gfn=>pfn cache, which leaves
> the cache's list entry, resident in the about-to-be-freed vCPU, linked into
> kvm->gpc_list; the next vCPU to manipulate the list writes through that
> entry.

Wouldn't this also require an "unclean" shutdown of the VM, because the VM would
still need live memslots in order to process the MSR load/store lists.  I wonder
if that's an avenue to a short-term stopgap "fix" as well as long-term hardening.
E.g. if KVM were to nuke memslots as part of kvm_destroy_vm(), I think that would
plug this particular hole?

> The vCPU will never run again, so nothing can observe the loaded host
> state. Simply restore KVM's MMU pointers so that they aren't left pointing
> at the nested MMU, and bail. nSVM does the same, i.e. doesn't emulate a
> VM-Exit when forcibly leaving nested mode, and performs only the equivalent
> MMU cleanup.

I don't have the links off-hand, but nSVM's behavior of not emulating VM-Exit
has also led to problems (I think we've failed to account for things that are
handled by the VM-Exit path, on multiple occassions).  That said, emulating a
VM-Exit while a vCPU is being destroyed is beyond awful, e.g. it requires
loading+putting the vCPU, which is its own gigantic can of worms.

> Bail just before the branch that splits the success and VM-Fail paths, as
> leaving guest mode, canceling the VMX-preemption timer, and switching back
> to vmcs01 are all needed by the free path. Canceling the timer is in fact
> the only reason the free path goes through an emulated VM-Exit, see commit
> b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state").

IIRC, we've accumulated more horrors since then.  I completely agree this code
is buggy and needs to be fixed, but I don't want to take a quick-and-dirty fix,
at least not without an exit strategy, which would/should force us to assess
exactly what is/isn't needed from the __nested_vmx_vmexit() flow. 

> Fixes: b4b65b5642d6 ("KVM: x86: cleanup freeing of nested state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 12 ++++++++++++
>  arch/x86/kvm/vmx/vmx.h    |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index ddf6df7bee93b2..8d58547acb1887 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -384,6 +384,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
>   */
>  void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu)
>  {
> +	to_vmx(vcpu)->nested.vcpu_is_dying = true;
> +
>  	vcpu_load(vcpu);
>  	vmx_leave_nested(vcpu);
>  	vcpu_put(vcpu);
> @@ -5173,6 +5175,16 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
>  	/* in case we halted in L2 */
>  	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
>  
> +	/*
> +	 * Don't emulate guest-controlled state, e.g. vmcs12's VM-Exit MSR load
> +	 * list, when freeing the vCPU.  Bail only after leaving guest mode,
> +	 * canceling the preemption timer, and switching back to vmcs01.
> +	 */
> +	if (vmx->nested.vcpu_is_dying) {
> +		nested_ept_uninit_mmu_context(vcpu);
> +		return;
> +	}
> +
>  	if (likely(!vmx->fail)) {
>  		if (vm_exit_reason != -1)
>  			trace_kvm_nested_vmexit_inject(vmcs12->vm_exit_reason,
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index dc8517f15bc463..2bacd3fe4c7ded 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -76,6 +76,9 @@ struct nested_vmx {
>  	gpa_t vmxon_ptr;
>  	bool pml_full;
>  
> +	/* Set when freeing the vCPU, to suppress emulation of guest state. */
> +	bool vcpu_is_dying;
> +
>  	/* The guest-physical address of the current VMCS L1 keeps for L2 */
>  	gpa_t current_vmptr;
>  	/*
> -- 
> 2.43.0
> 
