Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585966;
	b=KuRC1OuXwBMG9vaT4AhX5pwLrhRlkYGUuIIFmli4vzHWjeDZADsl3DZgi4E8shq6ZysE
	 XyQilltE19q2W7XFQu+tugrWmyG9OcomvtMcXo46kUFdAUt3moPz0cRIBW8TYF3K8RI4+
	 kSXRCO2X7Wesf1l1wl6lbi+UnoRRKlO5TmB5oOHR2ndKkEkgNze/Xt+256Y/d+pcK4LVA
	 oUmPRFpUKPQM3WbmASHW4mmZJJr+weEFOMtizvyYBDWbEDWqPtZw/ot79ub+s8nM2Yvnf
	 siH8jwK+R/Sym4PPfFH+gMaBTDVk82SSDDd7L1WxyRyADlrq0ie/efldI7XPQbH51kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aVD2LWCOcUXT9B9g53aQmj6qQW+Woj+F7+6pHsKdL0I=;
	b=PyYV6dU70D8kFDtDsDHT8cS29EimE1MDgnPonNY92scMXuf1qLohM4ucBfaropFgJ/Eg
	 +in9xe09WhbABOdOAsEp17wMFXrfbOlpYotfk0Hsgf08Ej7gPFqNCVw76d1h077oZZbnB
	 VNEn9XGdMshlIOeCS5ow/2scuCXlvxKgFCHZwpitHBKfAxu3RwVZk10sPYaMBvEKY7hdu
	 rGE4C2GcGnv4cdXzqepQJSeHTg2tCrs/aTo044FqbvKI/fO1FmWuHJTpOtpJgRBqXwIS0
	 eOpughGV78SydnRuoRnFAOkgsVQCAq4LBVq9hK4A9b3fAi1npZ6tmPoT/wfWX963ltA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwpwP6d5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84448606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iwpwP6d5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5851F000C0;
	Wed, 25 Nov 2026 05:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795585966;
	bh=aVD2LWCOcUXT9B9g53aQmj6qQW+Woj+F7+6pHsKdL0I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iwpwP6d5tZQDXfvH8NdWEitjwfx4anzdVEuwjGVSb2X10Cp2qwDga6VuqYfbFY8+p
	 U2mbeXpIkbqJMarPt0ja0nxXgeLmXnJeNQMk1eprQh1FJuEPV944QikdfjOqimWvBf
	 gekmB5E1Otab8e0X9gOf6gqOA5Z+OAPb7lK4YudF1x9JKAKbOJbyswWNQi+t+0+BW0
	 lUoePAHvvCy3OmiBOWhrFvh7Ruvmgx7wn3KLkoeZRN9rjyO4ubvbBl6Kv3fSnlrhia
	 GzrmP65xoTQL/+3pgvFHnowuZMhPEF6dpKxFTzMU2E68gkiujerqalJ3gz7iOzH55H
	 syEKZ7QRBFn+A==
Message-ID: <sashiko-outbox-232632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/5] KVM: x86: nVMX: fix races in delivery of nested
 posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261125052139.362046-6-mlevitsk@redhat.com>
References: <20261125052139.362046-1-mlevitsk@redhat.com>
 <20261125052139.362046-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 05:52:45 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] KVM: nVMX: delayed KVM_NESTED_PI_ACTIVE misdelivers PI to
  halted/restored L2
- [High] KVM: nVMX: gating KVM_NESTED_PI_ACTIVE on pi_desc breaks
  deferred error exit
- [Medium] KVM: nVMX: __nested_vmx_vmexit() processes nested PI on
  failed VM-Entry
--

commit aef7be5a3f3ba4f7dee7a4841c7b946e8a11d349
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: x86: nVMX: fix races in delivery of nested posted interrupts

This commit serializes nested posted interrupt delivery against nested VM
exit using atomic operations on vcpu->arch.nested_guest_state and delays
enabling nested posted interrupts until vmcs12 pages are mapped.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index eb33528619c2f..a5ef9a15e7e9c 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3440,7 +3440,18 @@ static bool nested_get_evmcs_page(struct kvm_vcpu =
*vcpu)
>  }
>  #endif
> =20
> -static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
> +static void nested_vmx_enable_posted_interrupts(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
> +
> +	WARN_ON_ONCE(vmcs12->posted_intr_nv & ~KVM_NESTED_PI_VECTOR_MASK);
> +
> +	atomic_or(KVM_NESTED_PI_ACTIVE |
> +		 (vmcs12->posted_intr_nv & KVM_NESTED_PI_VECTOR_MASK),
> +		  &vcpu->arch.nested_guest_state);
> +}
> +
> +static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu, bool from_vme=
ntry)
>  {
>  	struct vmcs12 *vmcs12 =3D get_vmcs12(vcpu);
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
> @@ -3505,6 +3516,9 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu=
 *vcpu)
>  				offset_in_page(vmcs12->posted_intr_desc_addr));
>  			vmcs_write64(POSTED_INTR_DESC_ADDR,
>  				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_=
addr));
> +
> +			if (!from_vmentry)
> +				nested_vmx_enable_posted_interrupts(vcpu);
>  		} else {
>  			/*
>  			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
> @@ -3540,7 +3554,7 @@ static bool vmx_get_nested_state_pages(struct kvm_v=
cpu *vcpu)
>  	}
>  #endif
> =20
> -	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
> +	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu, false))
>  		return false;
> =20
>  	return true;
> @@ -3671,7 +3685,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  	prepare_vmcs02_early(vmx, &vmx->vmcs01, vmcs12);
> =20
>  	if (from_vmentry) {
> -		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
> +		if (unlikely(!nested_get_vmcs12_pages(vcpu, true))) {
>  			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
>  			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
>  		}
> @@ -3701,6 +3715,9 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  			vmcs12->exit_qualification =3D failed_index;
>  			goto vmentry_fail_vmexit_guest_mode;
>  		}
> +
> +		if (nested_cpu_has_posted_intr(vmcs12) && vmx->nested.pi_desc)
> +			nested_vmx_enable_posted_interrupts(vcpu);

[Severity: High]
Does gating nested_vmx_enable_posted_interrupts() on mapping
vmx->nested.pi_desc break the deferred KVM_EXIT_INTERNAL_ERROR when
posted_intr_desc_addr cannot be mapped?

When kvm_vcpu_map() fails in nested_get_vmcs12_pages(), KVM sets
vmx->nested.pi_desc =3D NULL to defer the internal error exit until
__vmx_complete_nested_posted_interrupt() tries to access the descriptor.
Because KVM_NESTED_PI_ACTIVE is now left unset when pi_desc is NULL,
neither vmx_deliver_nested_posted_interrupt() nor
vmx_check_nested_events() recognizes vmcs12->posted_intr_nv as L2's
posted interrupt notification vector:

arch/x86/kvm/vmx/nested.c:vmx_check_nested_events() {
    ...
		if ((nested_state & KVM_NESTED_PI_ACTIVE) &&
			((nested_state & KVM_NESTED_PI_VECTOR_MASK) =3D=3D irq)) {
			vmx_complete_nested_posted_interrupt(vcpu);
			goto no_vmexit;
		}
		nested_vmx_vmexit(vcpu, EXIT_REASON_EXTERNAL_INTERRUPT,
				  INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR | irq, 0);
    ...
}

Instead of setting KVM_NESTED_PI_PENDING and exiting to userspace with
KVM_EXIT_INTERNAL_ERROR via __vmx_complete_nested_posted_interrupt(), KVM
injects a bogus EXIT_REASON_EXTERNAL_INTERRUPT VM-Exit into L1, and the
!vmx->nested.pi_desc check in __vmx_complete_nested_posted_interrupt()
becomes unreachable.

>  	} else {
>  		/*
>  		 * The MMU is not initialized to point at the right entities yet and
> @@ -3712,9 +3729,6 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  		kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
>  	}
> =20
> -	if (nested_cpu_has_posted_intr(vmcs12))
> -		atomic_or(KVM_NESTED_PI_ACTIVE | vmcs12->posted_intr_nv,
> -			  &vcpu->arch.nested_guest_state);

[Severity: High]
Does deferring nested_vmx_enable_posted_interrupts() until
KVM_REQ_GET_NESTED_STATE_PAGES misdeliver nested posted interrupts when L2
is restored in KVM_MP_STATE_HALTED?

After nested_vmx_enter_non_root_mode(vcpu, false) during
KVM_SET_NESTED_STATE (or vmx_leave_smm()), a halted L2 vCPU enters
vcpu_block() rather than vcpu_enter_guest(), so
KVM_REQ_GET_NESTED_STATE_PAGES is not serviced while blocked.  When
another vCPU sends vmcs12->posted_intr_nv to wake L2,
vmx_deliver_nested_posted_interrupt() sees KVM_NESTED_PI_ACTIVE =3D=3D 0 and
queues the vector into L1's LAPIC IRR.  vcpu_block() then runs
kvm_check_nested_events() -> vmx_check_nested_events() while
KVM_NESTED_PI_ACTIVE is still unset, failing to morph the notification
vector and instead reflecting a spurious EXIT_REASON_EXTERNAL_INTERRUPT
VM-Exit to L1.

> @@ -4025,22 +4039,15 @@ static void vmcs12_save_pending_event(struct kvm_=
vcpu *vcpu,
>  	}
>  }
> =20
> -static int vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
> +static int __vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
>  	int max_irr;
>  	void *vapic_page;
>  	u16 status;
> =20
> -	int nested_state =3D atomic_read(&vcpu->arch.nested_guest_state);
> -
> -	if (!(nested_state & KVM_NESTED_PI_PENDING))
> -		return 0;
> -
>  	if (!vmx->nested.pi_desc)
> -		goto mmio_needed;
> -
> -	atomic_andnot(KVM_NESTED_PI_PENDING, &vcpu->arch.nested_guest_state);
> +		return -ENXIO;
> =20
>  	/*
>  	 * Don't test the value of PID.ON.
> @@ -4057,7 +4064,7 @@ static int vmx_complete_nested_posted_interrupt(str=
uct kvm_vcpu *vcpu)
>  	if (max_irr > 0) {
>  		vapic_page =3D vmx->nested.virtual_apic_map.hva;
>  		if (!vapic_page)
> -			goto mmio_needed;
> +			return -ENXIO;
> =20
>  		__kvm_apic_update_irr(vmx->nested.pi_desc->pir,
>  			vapic_page, &max_irr);

[ ... ]

> @@ -5121,7 +5141,10 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u3=
2 vm_exit_reason,
>  	if (enable_ept && is_pae_paging(vcpu))
>  		vmx_ept_load_pdptrs(vcpu);
> =20
> -	leave_guest_mode(vcpu);
> +	old_nested_state =3D leave_guest_mode(vcpu);
> +
> +	if (old_nested_state & KVM_NESTED_PI_PENDING)
> +		__vmx_complete_nested_posted_interrupt(vcpu);

[Severity: Medium]
Can calling __vmx_complete_nested_posted_interrupt() unconditionally in
__nested_vmx_vmexit() lose posted interrupts when vmx->fail is set or
virtual_apic_map is unmapped?

When a hardware VM-Entry of vmcs02 fails (vmx->fail =3D=3D 1),
__nested_vmx_vmexit() skips sync_vmcs02_to_vmcs12().  Running
__vmx_complete_nested_posted_interrupt() before checking !vmx->fail
clears PID.ON and harvests PID.PIR into the virtual APIC page, but writes
the updated GUEST_INTR_STATUS.RVI to vmcs02 where it is discarded without
being synced to vmcs12.

Also, if virtual_apic_page_addr could not be mapped (which forces a
vmcs02 VM-Entry failure while leaving pi_desc mapped),
__vmx_complete_nested_posted_interrupt() clears PID.ON in guest memory
before checking !vapic_page and returns -ENXIO without harvesting PIR or
marking pi_desc_map dirty, while __nested_vmx_vmexit() ignores the return
value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125052139.3620=
46-1-mlevitsk@redhat.com?part=3D5
