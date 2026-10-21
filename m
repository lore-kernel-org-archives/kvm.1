Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557769;
	b=5jjs9AugF2i1+LnHIn1vCEK3VOThI+2AyINu9uEO6i15TxomXqQGws1m/LGhp3D9n4pz
	 j/QgbOtoITuszaBEhLGLcyF0Yfn+2AH/cnYqBHdvihBXTyXLIkCfKNR+wG3g+oOpBz1kG
	 JjkgoJinRnxoto8u/aLnytdaa3M4XSkl9ty6S9lp3xh9recKg1LkfztZNThkPSflrsCua
	 JfsRIDHl5KHPUjI0reB3ZZ0UADXoFVRiF55Ouuz7zRUnOLJDvcG0NBIlxTElDmwacsEOs
	 PItLfyAaAgKjmDdP5IPOJCvog3Yhp1ur2CwS3vTbvESHuHM8+s3wgtFzToWJbUKjONQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q8i0mZ4/LyOCzbGNHOrzZK2Lq+z0FGPKpWRhVgQ7CDY=;
	b=FrAddsGThXVJAtsnfxfOMVYwhfNk13ljvW0vWU/SlqRd0diPfMJNMLCf7QIi7UGbFUbw
	 98V17QkjvHQ0Go9cWEqBdi1si65ucn/V7T+MA83KUp5EFaxmjuuLrin39kN/h62zCN4iI
	 mzhXxpB7FygXZZm3Do8ntlIZDFWjYmf0h6N6I5gf3IWnXWbdWW0NktsyefhJWmwZGJYvi
	 AaGkPZ1p4HEv+0iFIy/ZPuNuezX0KwsvVKnMfoRpTMWDYjx65i9HqWEG4f8/rQ6eSJah2
	 SK3PMwx4GkN3b0f6ucKnmGJHWjOoG/tu6CMiFmYDSXAdpy+7m7pyNBMa8EbCwGzk4SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qn29egj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF66E606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 04:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qn29egj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE4C1F000C9;
	Wed, 21 Oct 2026 04:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557768;
	bh=q8i0mZ4/LyOCzbGNHOrzZK2Lq+z0FGPKpWRhVgQ7CDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qn29egj9N/8o5iFZLCXhd43dgGZCHDim021l3lBADDN6X04uAiEoQMu/8Ml/FcmG2
	 UNjuKoh3/AKKvHwELrJO1DddBgqnSHLpoIPu9ODVsEgrdahgscWNs20HJSyFRNBq1L
	 J299AkDq6hOd9METmChBNJhSizuEzGfhi3oI8D82MNfqf46I48RtX21yd7EML2QBUT
	 aw8mm4oydfHkN5zl7kkrQ00Pjy7asiWndNfL43UI3r+pIVaRPNdnkXD054Bx01YwYB
	 SQfRVcThZ6PzWa5d+0AGFNruKFmLmKEzOIubaJumpJgF8jb9N4xnXzvWFzQnZBjkWS
	 yBy5O2/zfZ4zw==
Message-ID: <sashiko-outbox-179791@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KVM: nVMX: Don't clobber VM-Entry instruction
 length when saving soft INTn
Reply-To: sashiko-reviews@lists.linux.dev
To: ma.mandourr@gmail.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20261021042603.608292-2-ma.mandourr@gmail.com>
References: <20261021042603.608292-1-ma.mandourr@gmail.com>
 <20261021042603.608292-2-ma.mandourr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:42:47 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: nVMX: vm_exit_instruction_len overwritten in prepare_vmcs12=
()
--

commit 24bdb8dd4aa6675d8e53850c4d0acf71d5903e75
Author: Mahmoud Abumandour <ma.mandourr@gmail.com>

KVM: nVMX: Don't clobber VM-Entry instruction length when saving soft INTn

This patch updates vmcs12_save_pending_event() so that when a nested VM-Exit
occurs while vectoring a software interrupt, vcpu->arch.event_exit_inst_len=
 is
written to vmcs12->vm_exit_instruction_len instead of
vmcs12->vm_entry_instruction_len.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 9b0bfa2f854cf..302f5b5aa5823 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4016,7 +4016,7 @@ static void vmcs12_save_pending_event(struct kvm_vc=
pu *vcpu,
> =20
>  		if (vcpu->arch.interrupt.soft) {
>  			idt_vectoring |=3D INTR_TYPE_SOFT_INTR;
> -			vmcs12->vm_entry_instruction_len =3D
> +			vmcs12->vm_exit_instruction_len =3D
>  				vcpu->arch.event_exit_inst_len;
>  		} else
>  			idt_vectoring |=3D INTR_TYPE_EXT_INTR;

[Severity: Medium]
Does writing vmcs12->vm_exit_instruction_len in vmcs12_save_pending_event()
actually take effect?

prepare_vmcs12() in arch/x86/kvm/vmx/nested.c is the sole caller of
vmcs12_save_pending_event(), and since commit c3634d25fbee ("KVM: nVMX: Lea=
ve
most VM-Exit info fields unmodified on failed VM-Entry"), it unconditionally
overwrites vmcs12->vm_exit_instruction_len with exit_insn_len right after
vmcs12_save_pending_event() returns:

arch/x86/kvm/vmx/nested.c:prepare_vmcs12() {
    ...
		vmcs12_save_pending_event(vcpu, vmcs12,
					  vm_exit_reason, exit_intr_info);

		vmcs12->vm_exit_intr_info =3D exit_intr_info;
		vmcs12->vm_exit_instruction_len =3D exit_insn_len;
		vmcs12->vmx_instruction_info =3D vmcs_read32(VMX_INSTRUCTION_INFO);
    ...
}

This also affects the existing kvm_exception_is_soft(nr) branch in
vmcs12_save_pending_event():

arch/x86/kvm/vmx/nested.c:vmcs12_save_pending_event() {
    ...
		if (kvm_exception_is_soft(nr)) {
			vmcs12->vm_exit_instruction_len =3D
				vcpu->arch.event_exit_inst_len;
			idt_vectoring |=3D INTR_TYPE_SOFT_EXCEPTION;
		} else
    ...
}

When a nested VM-Exit is synthesized while a software interrupt or software
exception is being vectored and vcpu->arch.event_exit_inst_len differs from
exit_insn_len (for instance, after vmx_cancel_injection() or after state
restore via KVM_SET_NESTED_STATE and KVM_SET_VCPU_EVENTS prior to
kvm_check_nested_events() -> nested_vmx_inject_exception_vmexit()), won't
prepare_vmcs12() clobber vmcs12->vm_exit_instruction_len with a stale or ze=
ro
exit_insn_len?

Should prepare_vmcs12() assign vmcs12->vm_exit_instruction_len =3D exit_ins=
n_len
before calling vmcs12_save_pending_event() so that soft interrupts and soft
exceptions can override it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042603.6082=
92-1-ma.mandourr@gmail.com?part=3D1
