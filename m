Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528609;
	b=smPMPGeJsG2ScjKoVPoMQdAqehrdETxctLo7WzsedG4TLI30lP6OCuSCWqC4qjQaSHVV
	 kv0ptfADbLAjGdz3sYKFS53y2KGeNNLz2cRpOTYmxOgnTkUS3hNYZCgN0QFEmN0A3e46t
	 sgsKWCFSbwsMjhIOc1wMiUAp+o3WxxyKkx0XBpJnw1ThHfCdCrQlLjl60cz286nI9ZgGw
	 TEhQ5Y5/45DkUPh31g2jcyUCG0+L1crKobNAJ7dz/aWe2EmWguV/A3X2JFUb4Q06p6au+
	 5jLV0eS6u32+0gegRBzjAtUskk3OBFyLKRd1rHQqhLPDkwGldRPnlFwOMxDpXz9W8cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D2xCJBVpSw1nB5ZWg1UhF5TouYk92HYoESeVIkTjJmc=;
	b=3BrZnhmK1/ymuJiHlomAM6rOgN5w5OV1PeFA7KKmUcQrTuLuSf9K0iagLmcKgjnjGRre
	 fcYsdZZHcy0FDIiFJjrts6XeU9RKiO6GmewB8aMBbrY6pMK35b4Ohc9l9Dkhn1WsJvGL5
	 UVH5D9z6ChoWCuagY5W+7DnShdv19JYARkumX/2vIvcs/iH+8tQBWSEyCT7fpcwJ/ta5h
	 ben3+dIMmWAVQS+20wZwlDfW9xdkK39OKlpl/gDXAMZPpJx4cyNEkXi0ye3Pt8bQItHzk
	 aich+UwFq8Qr8f+iu1pltFmlXHM0QgafMfUjWmNmAmQSWSwsiobdKSfRXxqEvOBq4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlC88KHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD20606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlC88KHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75371F000CF;
	Tue, 24 Nov 2026 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528609;
	bh=D2xCJBVpSw1nB5ZWg1UhF5TouYk92HYoESeVIkTjJmc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TlC88KHSjkTz7DR5n+bkzgMMeTVCQ6ql3EWNeYs5v6oB2xW/qFgdcyCBdD8tw0AVR
	 gWqAMtUZqFHkPGqs38V8P31z/OADchiB2kxsShB1/tt+i2BqiLe4XB/3UBzvKYTqz0
	 rG9qG5wv3EZEuIU1n10R1kh29jhMb1tcT9hzXMrXXm8OZQ/1sJKfDDmQOGSxxdY+xC
	 K3wZdW1HpYs1lzLUNr9BWBHzvyGtoiB0w7emsKci00YMDI4ibG3NeVigoZU3sIbXFn
	 +cDY+olpleBiTXCFgOorGT6SKFozVXe6xyg7oTLD8NquejHEN38dAByAxzwUHRj28B
	 Z5tviUSHPXrcg==
Message-ID: <sashiko-outbox-231274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Allow NMI injection while NMI-blocked if
 vmcs12 doesn't use virtual NMIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Andreas" <manuel.andreas@tum.de>, kvm@vger.kernel.org
In-Reply-To: <20261124133704.5563-1-manuel.andreas@tum.de>
References: <20261124133704.5563-1-manuel.andreas@tum.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:56:48 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: nVMX: premature GUEST_INTR_STATE_NMI clear in
  prepare_vmcs02_early()
--

commit 0a8a662b2bf25c4df8703f3943666ec724f2d386
Author: Manuel Andreas <manuel.andreas@tum.de>

KVM: nVMX: Allow NMI injection while NMI-blocked if vmcs12 doesn't use virt=
ual NMIs

This commit clears GUEST_INTR_STATE_NMI in vmcs02 when L1 injects an NMI
while NMI-blocked without virtual NMIs enabled in vmcs12, avoiding a
hardware VM-Entry failure when KVM enables virtual NMIs in vmcs02.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index b252168627408..0adb671ae8c2f 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2586,14 +2586,30 @@ static void prepare_vmcs02_early(struct vcpu_vmx =
*vmx, struct loaded_vmcs *vmcs0
>  	 * Interrupt/Exception Fields
>  	 */
>  	if (vmx->vcpu.arch.nested_run_pending) {
> -		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD,
> -			     vmcs12->vm_entry_intr_info_field);
> +		u32 intr_info =3D vmcs12->vm_entry_intr_info_field;
> +		u32 interruptibility =3D vmcs12->guest_interruptibility_info;
> +
> +		/*
> +		 * vmcs02 uses virtual NMIs if KVM does (i.e. enable_vnmi=3Dtrue),
> +		 * regardless of vmcs12, in which case the CPU rejects VM-Enter
> +		 * if an NMI is being injected while blocking by NMI is set.
> +		 * Architecturally, there is no such restriction for L1 if
> +		 * vmcs12 doesn't use virtual NMIs, so clear blocking by NMI in
> +		 * vmcs02 if L1 is injecting an NMI.  Delivering the NMI blocks
> +		 * NMIs, i.e. L2 still ends up with blocking by NMI set, the same
> +		 * as it would on bare metal.  Note, nmi_known_unmasked is derived
> +		 * from vmcs12's original value and so stays false, as required.
> +		 */
> +		if ((pin_controls_get(vmx) & PIN_BASED_VIRTUAL_NMIS) &&
> +		    !nested_cpu_has_virtual_nmis(vmcs12) && is_nmi(intr_info))
> +			interruptibility &=3D ~GUEST_INTR_STATE_NMI;
> +
> +		vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, intr_info);
>  		vmcs_write32(VM_ENTRY_EXCEPTION_ERROR_CODE,
>  			     vmcs12->vm_entry_exception_error_code);
>  		vmcs_write32(VM_ENTRY_INSTRUCTION_LEN,
>  			     vmcs12->vm_entry_instruction_len);
> -		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO,
> -			     vmcs12->guest_interruptibility_info);
> +		vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, interruptibility);
>  		vmx->loaded_vmcs->nmi_known_unmasked =3D
>  			!(vmcs12->guest_interruptibility_info & GUEST_INTR_STATE_NMI);
>  	} else {

[Severity: Medium]
Can clearing GUEST_INTR_STATE_NMI in vmcs02 during prepare_vmcs02_early()
corrupt vmx->loaded_vmcs->nmi_known_unmasked and
vmcs12->guest_interruptibility_info before hardware VM-Entry delivers the
NMI?

In vmx_get_nmi_mask(), nmi_known_unmasked =3D=3D false is treated as a cache
miss that reads GUEST_INTERRUPTIBILITY_INFO from the active VMCS and
latches nmi_known_unmasked:

arch/x86/kvm/vmx/vmx.c:vmx_get_nmi_mask() {
	if (vmx->loaded_vmcs->nmi_known_unmasked)
		return false;
	masked =3D vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) & GUEST_INTR_STATE_NMI;
	vmx->loaded_vmcs->nmi_known_unmasked =3D !masked;
	return masked;
}

If vmx_get_nmi_mask() runs between prepare_vmcs02_early() and
vmx_vcpu_run() (for example via process_nmi() when servicing KVM_REQ_NMI
in vcpu_enter_guest(), or via KVM_GET_VCPU_EVENTS), it reads the cleared
GUEST_INTR_STATE_NMI bit from vmcs02, returns false, and flips
nmi_known_unmasked to true.  After hardware VM-Entry delivers the NMI and
re-sets GUEST_INTR_STATE_NMI, nmi_known_unmasked stays true, causing
subsequent vmx_get_nmi_mask() and vmx_recover_nmi_blocking() calls on L2
VM-Exits to treat NMIs as unmasked.

In addition, if sync_vmcs02_to_vmcs12() runs before the NMI is delivered
(such as on a hardware guest-state VM-Entry failure in
__nested_vmx_vmexit() or during vmx_get_nested_state()), it overwrites
vmcs12->guest_interruptibility_info with the cleared bit from vmcs02, and
if a VM-Exit occurs while vectoring the injected NMI,
__vmx_complete_interrupts() clears GUEST_INTR_STATE_NMI via
vmx_set_nmi_mask(vcpu, false), losing L1's pre-existing NMI blocking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124133704.5563=
-1-manuel.andreas@tum.de?part=3D1
