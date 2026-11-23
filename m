Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457952;
	b=AI8KMawlBV7EDFTTipjeoQjcFkcHtfUHC1egsXk53DQ0S71TIPNpvFCL9FnqzfXz8d+d
	 VhfFXt09s9KB5xoppHd02je3Vn/5izZKnJ8G/aDImJTm4ILN1+IoAloH52QzACcFfTOSx
	 9bKlFRgipRaIXUCLYz2318sVT4P/qtoi5MajdxCivVsOqqSyyDks/K6Zc2VbD94ElG3LF
	 YCBaqmHF7i4+soL7Pg1pV2W7gUzpj6Ec6FDDjOADTqo1057MKVKk6cStYKhRPi+JQ2VuQ
	 KRXIReRizwUiMtSYrDhXMnMAbollUmDEU87zENxO0W1KpIo60cvN83YShYRB4BBtKcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457952;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PiDR7HMQHKt2K0TK+R/UfymKDEOmp8ekjpQEWJGGcY4=;
	b=Z3xA+J/jvgfdSTpuqj0xQsRs5HEe1E99v5FK7O3EVinyipjue4bJKq/0PmgNO6FwnHVm
	 CG2vr1xvEy+x/nLbZ0+JmztSLbjY1IcpYmsZEfKCHcYiZdK81NYojHe8RD5JIRa9QmzxD
	 nx4zAoTMVKAkMDD7jWiO+x9obTErg2qAXoiRxTCUcRhVQwBnMm8DyH1u/cz3rc5E3H3WT
	 1SIcEvLBGVqbIqIBPRI5/1259N37JtQAgRhpIgqmgno5qaTu0gacls2QBq2R+R/2oWARJ
	 56b4qkI+rQv8ms40yST73Tqqeu8PlDf0AlDurs8dDrtwXWrjFfwyTLenLfJIvJRXxHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3MibbUz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E535606A32D
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W3MibbUz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16041F000D4;
	Mon, 23 Nov 2026 18:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795457952;
	bh=PiDR7HMQHKt2K0TK+R/UfymKDEOmp8ekjpQEWJGGcY4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=W3MibbUzBBmykluJbmcxBkUuUD88FkGe5Jpq7gWJrsLjm/zBcywr3r03bN8Prg3VS
	 y8l325vJ/j3/Zu+VSM8xoYPgJr1H+9kWSV15eYKAmcihaSLQ7ASpfun4RY8SC+aFE8
	 i+VRYjlD0I/M7EGb2/2ryctWe0AkEPLn+Y4P/OAUtv2UpTDnEuniI9JNJA01SlWOQW
	 uuRq/Ya38tSRkwYbuGNZO/3xlToIfh45wBPB1zn5ZOFW9/ChuWQY/SX9jGldf5T301
	 5922XXE3fNABmgxVWSdcXhU4I7wNybhjsQSK+NlgHWHCWGfqOrqsrI6DAkXua7V8Ja
	 oOqrzT5I7dRDg==
Message-ID: <sashiko-outbox-229799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] KVM: x86: nVMX: fix races in delivery of nested
 posted interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261123175512.80438-6-mlevitsk@redhat.com>
References: <20261123175512.80438-1-mlevitsk@redhat.com>
 <20261123175512.80438-6-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:19:11 +0000
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
- [High] KVM: nVMX: unhandled error and unmapped state in
  __nested_vmx_vmexit() PI completion
--

commit daa28df8cd412bbb1c1a76b22827fb7d30241474
Author: Maxim Levitsky <mlevitsk@redhat.com>

KVM: x86: nVMX: fix races in delivery of nested posted interrupts

This commit synchronizes nested posted interrupt delivery with nested
VM-Exit using atomic operations on vcpu->arch.nested_guest_state and
processes pending nested posted interrupts in __nested_vmx_vmexit().

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 61f50175ecb79..845825c018bf5 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
[ ... ]
> @@ -5122,7 +5128,13 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u3=
2 vm_exit_reason,
>  	if (enable_ept && is_pae_paging(vcpu))
>  		vmx_ept_load_pdptrs(vcpu);
> =20
> -	leave_guest_mode(vcpu);
> +	old_nested_state =3D leave_guest_mode(vcpu);
> +
> +	/* pairs with implicit memory barrier in vmx_deliver_nested_posted_inte=
rrupt */
> +	smp_mb__after_atomic();
> +
> +	if (old_nested_state & KVM_NESTED_PI_PENDING)
> +		__vmx_complete_nested_posted_interrupt(vcpu);
> =20
>  	if (nested_cpu_has_preemption_timer(vmcs12))
>  		hrtimer_cancel(&to_vmx(vcpu)->nested.preemption_timer);

[Severity: High]
What happens when __vmx_complete_nested_posted_interrupt() fails or runs
before vmcs12 pages are mapped?

If L1 configures an unbacked or MMIO GPA for posted_intr_desc_addr or
virtual_apic_page_addr, vmx->nested.pi_desc or virtual_apic_map.hva is NULL.
__vmx_complete_nested_posted_interrupt() then calls
kvm_handle_memory_failure(), setting vcpu->run->exit_reason to
KVM_EXIT_INTERNAL_ERROR and returning -ENXIO.  Because __nested_vmx_vmexit()
ignores the return value, callers such as nested_vmx_reflect_vmexit() and
vmx_check_nested_events() continue running L1 in-kernel instead of exiting
to userspace, while non-KVM_RUN callers via vmx_leave_nested() clobber
vcpu->run->exit_reason.

In addition, when entering L2 with from_vmentry =3D=3D false (KVM_SET_NESTE=
D_STATE
or RSM), nested_vmx_enter_non_root_mode() defers nested_get_vmcs12_pages()
via KVM_REQ_GET_NESTED_STATE_PAGES while publishing KVM_NESTED_PI_ACTIVE in
vcpu->arch.nested_guest_state.  If a nested posted interrupt arrives and an
L2->L1 exit happens before the first L2 entry, __nested_vmx_vmexit() clears
KVM_REQ_GET_NESTED_STATE_PAGES without mapping pi_desc, so
__vmx_complete_nested_posted_interrupt() drops the interrupt and triggers a
spurious KVM_EXIT_INTERNAL_ERROR.

Finally, running __vmx_complete_nested_posted_interrupt() when vmx->fail is
true clears pi_desc->on and writes max_irr into vmcs02 GUEST_INTR_STATUS,
which is then lost because sync_vmcs02_to_vmcs12() is skipped on vmx->fail.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123175512.8043=
8-1-mlevitsk@redhat.com?part=3D5
