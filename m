Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644854;
	b=G9sec3UUIrbjoWVL3H2HHq/6ihW/eBTCygH2t5ioaQHUT5Or+AP6Zm4KyqivvgrI+rTs
	 yS4LQiBzB9JFuNFaf5TTaUYpJuQIwEw2mt0flJMAH6KI+vME5yA5aQkGNaV9hbF7h+CzY
	 WSBe03SXy6yNhZO3dKcqtfxNBA28/SaanVEgSXS97J4CSTvC4bCUojQP5rSvYpOXDDqWL
	 zRj6gSFFQnakHmfh3i2/tT+b2NHMgjz8GC8dfcfVSaLeCucnEBl0N0qOtEUB0bGGWxkg6
	 5bHxW7JkrPtcAzg/1Pu7XS2tXEwqJ5+PF4zHHafGvrdKmt1a/bG7WmEfT47GPCxO/zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SCJfazg0W6gykNDKfMJlboCEpsDR+rIE5jy8OqATsg8=;
	b=NcQhbSh4vEmTIPSePs+CqIwBW45fmXuANTwHHFj2r4DfHq364ie1g0/N3QjLRqCY1JG7
	 28+Cy/dlzkW7mj4U/6BsEJ9reSz0qIR2gleaIT0Gucj2tcfjeEpIgLJoILfPta5I9RGw2
	 TuWMWmkODk03rcPMxg3jil75SvYTsW0tiCBT/c9qkZrsouvfcgKdnAUv/yhTisTIwFwMY
	 xEqcDCqo7PNwg1oRYgJO0WS6F5niKOdVj8xE3aMaQkmlepz+4paiHvkoXr4Be/WWvcNVv
	 ksiF+6S9SVUkL7nFzqXVFBydQgg+7eN5dLNtIbU+6d6llhzJaMloDCby/vYfOShRWzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HkyVTo//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500A606A324
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HkyVTo//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566791F00A16;
	Mon,  2 Nov 2026 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793644853;
	bh=SCJfazg0W6gykNDKfMJlboCEpsDR+rIE5jy8OqATsg8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=HkyVTo//O+zyyTFsu/L2DBG8u27f0kLcG4ZP+7bDHHCj4US6a5p5Pvq17WgXkAqYY
	 bkvEY8PHmxd4T+c6vWLv9SHKlQTjo5r55/CJF/7ZVT4mw3lxpUhdhT9McZ8qGtbtl6
	 fanmhx2NJdofnTXDM7hdYhisa9EGtf3nnLIicdMcEa/h4bU1WeDCQU5N/hI25I53Lq
	 XSpQjQo+5uWu1oyG6RIRHXuiJ71b4dsRjaiJk2RBbC1stvS5nED2FsFyrkwIdPV9Px
	 GPGhleG+b436w+85e6QHBJDdOwVtBQnp3+3QkCyBbrnN9UEXWacj3ZUXg2kHFo74CM
	 LmNre4ZjrclBw==
Message-ID: <sashiko-outbox-193956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 39/45] KVM: VMX: mark VM dead on shadow VMCS or eVMCS
 access failures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174512.8903-23-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174512.8903-23-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:40:52 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] KVM: VMX: nested_get_evmcs_page() ignores EVMPTRLD_DISABLED and hi=
ts WARN_ON
- [High] KVM: VMX: MSR_KVM_PV_EOI_EN write breaks nested_get_evmptr() and k=
ills VM
- [Medium] KVM: VMX: nested_get_evmptr() error return disables eVMCS in cal=
lers
- [Medium] KVM: VMX: nested_vmx_run() blocks vCPU after nested_cache_shadow=
_vmcs12() fails
- [Medium] KVM: VMX: __nested_vmx_vmexit() marks VM dead during vmx_leave_n=
ested()
--

commit 6832da53d677d8f33bf223e6c9407f718e6f9f02
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: VMX: mark VM dead on shadow VMCS or eVMCS access failures

This commit marks the VM dead when initializing the HVA cache or accessing
guest memory fails for shadow VMCS12, enlightened VMCS, or an enabled
Hyper-V VP assist page.

> diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
> index fa41d036acd49..746540e503e32 100644
> --- a/arch/x86/kvm/vmx/hyperv.c
> +++ b/arch/x86/kvm/vmx/hyperv.c
> @@ -18,9 +18,14 @@ u64 nested_get_evmptr(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_vcpu_hv *hv_vcpu =3D to_hv_vcpu(vcpu);
> =20
> -	if (unlikely(kvm_hv_get_assist_page(vcpu)))
> +	if (unlikely(!kvm_hv_assist_page_enabled(vcpu)))
>  		return EVMPTR_INVALID;
> =20
> +	if (unlikely(kvm_hv_get_assist_page(vcpu))) {
> +		kvm_vm_dead(vcpu->kvm);
> +		return EVMPTR_INVALID;
> +	}

[Severity: High]
Can an unprivileged L1 guest trigger a host kernel WARN_ON_ONCE and kill
the VM here without any host memory protection attributes?

HV_X64_MSR_VP_ASSIST_PAGE and MSR_KVM_PV_EOI_EN share
vcpu->arch.pv_eoi.msr_val and the vcpu->arch.pv_eoi.data cache via
kvm_lapic_set_pv_eoi():

arch/x86/kvm/hyperv.c:kvm_hv_assist_page_enabled() {
	if (!(hv_vcpu->hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
		return false;
	return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
}

arch/x86/kvm/lapic.c:kvm_lapic_set_pv_eoi() {
	if (data & KVM_MSR_ENABLED) {
		if (addr =3D=3D ghc->gpa && len <=3D ghc->len)
			new_len =3D ghc->len;
		else
			new_len =3D len;

		ret =3D kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc, addr, new_len);
		if (ret)
			return ret;
	}
}

If the guest enables HV_X64_MSR_VP_ASSIST_PAGE at one GPA (initializing
ghc->len to sizeof(struct hv_vp_assist_page)) and then writes
MSR_KVM_PV_EOI_EN with a different valid GPA and KVM_MSR_ENABLED,
kvm_lapic_set_pv_eoi() reinitializes vcpu->arch.pv_eoi.data with
new_len =3D 1 while kvm_hv_assist_page_enabled() remains true.

Alternatively, if the guest writes MSR_KVM_PV_EOI_EN with an unmapped GPA
and KVM_MSR_ENABLED, kvm_gfn_to_hva_cache_init() sets ghc->hva to
KVM_HVA_ERR_BAD and returns -EFAULT without clearing KVM_MSR_ENABLED in
vcpu->arch.pv_eoi.msr_val.

When the guest then executes VMCLEAR, VMLAUNCH, or VMRESUME,
nested_get_evmptr() -> kvm_hv_get_assist_page() ->
kvm_read_guest_offset_cached() either hits:

	if (WARN_ON_ONCE(len + offset > ghc->len))
		return -EINVAL;

or returns -EFAULT, and nested_get_evmptr() calls kvm_vm_dead(vcpu->kvm).

[Severity: Medium]
Also in nested_get_evmptr(), when kvm_hv_get_assist_page() fails, does
returning EVMPTR_INVALID still cause callers to continue the current
instruction as if enlightened VMCS were disabled before KVM_REQ_VM_DEAD is
serviced?

In handle_vmclear() -> nested_evmcs_handle_vmclear():

	if (!guest_cpu_cap_has_evmcs(vcpu) ||
	    !evmptr_is_valid(nested_get_evmptr(vcpu)))
		return false;

returning EVMPTR_INVALID causes nested_evmcs_handle_vmclear() to return
false, so handle_vmclear() falls through to the non-eVMCS path and writes
zero to vmptr + offsetof(struct vmcs12, launch_state) in guest memory.

Similarly, in nested_vmx_run() -> nested_vmx_handle_enlightened_vmptrld():

	evmcs_gpa =3D nested_get_evmptr(vcpu);
	if (!evmptr_is_valid(evmcs_gpa)) {
		nested_release_evmcs(vcpu);
		return EVMPTRLD_DISABLED;
	}

returning EVMPTR_INVALID releases the eVMCS and returns EVMPTRLD_DISABLED
instead of EVMPTRLD_ERROR, allowing nested_vmx_run() to proceed with eVMCS
disabled.

[ ... ]

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b26909dd4d79d..87c9954132c6f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -861,10 +861,13 @@ static void nested_cache_shadow_vmcs12(struct kvm_v=
cpu *vcpu,
>  	if (ghc->gpa !=3D vmcs12->vmcs_link_pointer &&
>  	    kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc,
>  				      vmcs12->vmcs_link_pointer, VMCS12_SIZE))
> -		return;
> +		goto error;
> =20
> -	kvm_read_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
> -			      VMCS12_SIZE);
> +	if (!kvm_read_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
> +				   VMCS12_SIZE))
> +		return;
> +error:
> +	kvm_vm_dead(vcpu->kvm);
>  }

[Severity: Medium]
What happens in nested_vmx_run() when nested_cache_shadow_vmcs12() (or
nested_get_evmptr() when vmx->nested.current_vmptr is valid) marks the VM
dead and vmcs12->guest_activity_state is GUEST_ACTIVITY_HLT or
GUEST_ACTIVITY_WAIT_SIPI?

In arch/x86/kvm/vmx/nested.c:nested_vmx_run():

	nested_cache_shadow_vmcs12(vcpu, vmcs12);

	switch (vmcs12->guest_activity_state) {
	case GUEST_ACTIVITY_HLT:
		if (!(vmcs12->vm_entry_intr_info_field & INTR_INFO_VALID_MASK) &&
		    !nested_cpu_has(vmcs12, CPU_BASED_NMI_WINDOW_EXITING) &&
		    !(nested_cpu_has(vmcs12, CPU_BASED_INTR_WINDOW_EXITING) &&
		      (vmcs12->guest_rflags & X86_EFLAGS_IF))) {
			vcpu->arch.nested_run_pending =3D 0;
			return kvm_emulate_halt_noskip(vcpu);
		}
		break;
	case GUEST_ACTIVITY_WAIT_SIPI:
		vcpu->arch.nested_run_pending =3D 0;
		kvm_set_mp_state(vcpu, KVM_MP_STATE_INIT_RECEIVED);
		break;

Because nested_cache_shadow_vmcs12() does not return an error to abort
nested_vmx_run(), the vCPU transitions to KVM_MP_STATE_HALTED or
KVM_MP_STATE_INIT_RECEIVED and returns 1.

On the next iteration of vcpu_run():

	if (kvm_vcpu_running(vcpu)) {
		r =3D vcpu_enter_guest(vcpu);
	} else {
		r =3D vcpu_block(vcpu);
	}

vcpu_run() calls vcpu_block() instead of vcpu_enter_guest(), where
KVM_REQ_VM_DEAD is checked, so could the vCPU block on a dead VM (or exit
with KVM_EXIT_HLT when the LAPIC is in userspace) and later flush the
uncached shadow_vmcs12 back to guest memory on wakeup?

> @@ -880,10 +883,13 @@ static void nested_flush_cached_shadow_vmcs12(struc=
t kvm_vcpu *vcpu,
>  	if (ghc->gpa !=3D vmcs12->vmcs_link_pointer &&
>  	    kvm_gfn_to_hva_cache_init(vcpu->kvm, ghc,
>  				      vmcs12->vmcs_link_pointer, VMCS12_SIZE))
> -		return;
> +		goto error;
> =20
> -	kvm_write_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
> -			       VMCS12_SIZE);
> +	if (!kvm_write_guest_cached(vcpu->kvm, ghc, get_shadow_vmcs12(vcpu),
> +				    VMCS12_SIZE))
> +		return;
> +error:
> +	kvm_vm_dead(vcpu->kvm);
>  }
> =20
>  /*
> @@ -5093,7 +5099,8 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32=
 vm_exit_reason,
>  		 * do that when something is forcing L2->L1 exit prior to
>  		 * the first L2 run.
>  		 */
> -		(void)nested_get_evmcs_page(vcpu);
> +		if (!nested_get_evmcs_page(vcpu))
> +			kvm_vm_dead(vcpu->kvm);
>  #endif
>  	}

[Severity: High]
When kvm_hv_get_assist_page() fails in nested_get_evmptr() while
vmx->nested.hv_evmcs_vmptr is EVMPTR_MAP_PENDING, won't
nested_get_evmcs_page() still return true and trigger a host WARN_ON?

The call chain is:

nested_get_evmcs_page()
  -> nested_vmx_handle_enlightened_vmptrld()
       -> nested_get_evmptr()

When nested_get_evmptr() fails and returns EVMPTR_INVALID,
nested_vmx_handle_enlightened_vmptrld() resets vmx->nested.hv_evmcs_vmptr
to EVMPTR_INVALID via nested_release_evmcs() and returns EVMPTRLD_DISABLED.

However, nested_get_evmcs_page() only checks for EVMPTRLD_VMFAIL and
EVMPTRLD_ERROR:

	if (guest_cpu_cap_has_evmcs(vcpu) &&
	    vmx->nested.hv_evmcs_vmptr =3D=3D EVMPTR_MAP_PENDING) {
		enum nested_evmptrld_status evmptrld_status =3D
			nested_vmx_handle_enlightened_vmptrld(vcpu, false);

		if (evmptrld_status =3D=3D EVMPTRLD_VMFAIL ||
		    evmptrld_status =3D=3D EVMPTRLD_ERROR)
			return false;

		vmx->nested.need_vmcs12_to_shadow_sync =3D true;
	}

	return true;

In __nested_vmx_vmexit(), if nested_vmx_handle_enlightened_vmptrld()
returns EVMPTRLD_DISABLED (either because reading the VP assist page
failed, or because the VP assist page or enlighten_vmentry was disabled),
nested_get_evmcs_page() returns true and bypasses the kvm_vm_dead() check.

Furthermore, in vcpu_enter_guest(), KVM_REQ_VM_DEAD is checked before
KVM_REQ_GET_NESTED_STATE_PAGES:

	if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
		return -EIO;

	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
		if (unlikely(!kvm_x86_call(get_nested_state_pages)(vcpu))) {
			r =3D 0;
			goto out;
		}
	}

When vmx_get_nested_state_pages() -> nested_get_evmcs_page() sees
EVMPTRLD_DISABLED, it sets vmx->nested.need_vmcs12_to_shadow_sync =3D true
and returns true. Execution continues into vmx_prepare_switch_to_guest() ->
nested_sync_vmcs12_to_shadow():

	if (nested_vmx_is_evmptr12_valid(vmx))
		copy_vmcs12_to_enlightened(vmx);
	else
		copy_vmcs12_to_shadow(vmx);

Because hv_evmcs_vmptr is now EVMPTR_INVALID, this falls back to
copy_vmcs12_to_shadow(vmx) and hits WARN_ON(!shadow_vmcs) when shadow VMCS
is not enabled. Should nested_get_evmcs_page() check
evmptrld_status !=3D EVMPTRLD_SUCCEEDED instead?

[Severity: Medium]
Also in __nested_vmx_vmexit(), could calling kvm_vm_dead() in
nested_get_evmcs_page() and nested_flush_cached_shadow_vmcs12() kill the VM
during host-initiated teardown via vmx_leave_nested()?

arch/x86/kvm/vmx/nested.c:vmx_leave_nested() {
	if (is_guest_mode(vcpu)) {
		vcpu->arch.nested_run_pending =3D 0;
		nested_vmx_vmexit(vcpu, -1, 0, 0);
	}
	free_nested(vcpu);
}

When vmx_leave_nested() is called (for example during vCPU reset, clearing
MSR_IA32_FEAT_CTL, SMM transitions in KVM_SET_VCPU_EVENTS, or
KVM_SET_NESTED_STATE), __nested_vmx_vmexit() runs with vm_exit_reason =3D=
=3D -1
right before free_nested() discards all nested state. If the pending eVMCS
or shadow VMCS GPA in guest memory is unmapped or not writable at that
point, should __nested_vmx_vmexit() avoid accessing guest memory and
marking the VM dead when vm_exit_reason =3D=3D -1?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D39
