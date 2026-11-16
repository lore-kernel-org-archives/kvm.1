Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814192;
	b=C2M/WWNhqtp41csx35LTLLfV84XmiIoVooQhbhQ0nbV4S8FrSzYyUG+DjL4XjSAQ4wBb
	 PRG+IBamuKxCFXhKA+FPNmWo1Xvppjk470OFZUSoujgLqIxgGVJvlz480e6EBLsFMkZS6
	 zKCJ/HYLnmlp7XDQqGE2IyxKfb2AdOsIAz1BKMAO49vyrgmT5Lpm9UEf8r+uaRXHX+LFR
	 RDpNq/FGJbkROHAlFatPuq3P9uYnED7f58alxhWXo5cxbpAenWgyUE+IgwFt+9YpxNSu5
	 xHlgD7FAoSQNopYDOWsWg6RZFgQ24Dx4a7eoty3gGfxh/g4X7UpWWNT7+2YrS/MlWiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NntZ5837bbbHK1Nd/FO5bMvYPGMR7q3LNRYR35b2TDc=;
	b=QS9iXL3KEgSXHgChbHxQspqC3vcmhioRvF5XNdAlQKGWwiA3XQhkeJqbpgCBKC11W4N7
	 GkffziU7wQZsuWuvEoxKJd+gTmtG/38w0bM5QtkNPy8oEfjs4Xgn/E3c/YdO9OL7kQCL7
	 rPAsunoZBVnMWCjsHLtzNy9if0iDCg+B54HDuMxZmSRFnDyvxGqtxwgTUTw2g5Vpg7RFT
	 4zTi5kufLE6QfgMhLQmJLFlVRO3xDUEtKeJbPmQd1Ygw/uYE9jevxrOgl7kDYUK4jkNUg
	 3crEXOSpV7YAjgjLPVxXXPX6J12kteKv5+F3c4QWeaBJDH3HW1/F7KMkLL6K7jAFUmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOhv5TS6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9C606A323
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOhv5TS6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5BA1F000C4;
	Mon, 16 Nov 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794814191;
	bh=NntZ5837bbbHK1Nd/FO5bMvYPGMR7q3LNRYR35b2TDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YOhv5TS6CiSYQ4gPJXjDQc0xni/qzRj1i1pHHhpRiOoK82hGfnxJG34PStd9pfXBL
	 W9Fq50o6pqP2jfjwjchfPL/QPA/Q21xqhd1zVQsQ4ZVXqCpNF3n6DHryBgK6dELuTo
	 7dkQxoeWDq5VZBhw9X3B5HxQQYYzJs2rq6uQ5rnrSqgh1QWlmQyMavBZTrJTBYWZV8
	 hWEvwIbngh345iIJAPfUBMoR9dVC/tvU3igSB7NZuNs49wqHQ7cucd5h9czzdm5D1z
	 HYmN3iMZ/TTRBebzb1W00wHDN/x99iu4O11krCHlcW+VGSlkuYOSABoV5a6qLUDBKW
	 sHt+anHPqopBg==
Message-ID: <sashiko-outbox-216429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: VMX: Disallow 16-bit busy TSS (type 3) for TR in
 IA-32e mode
Reply-To: sashiko-reviews@lists.linux.dev
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <1794812900.6AFAABE3.003.4jSf8g6LZ4z562g@fangwg01>
References: <1794812900.6AFAABE3.003.4jSf8g6LZ4z562g@fangwg01>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 07:29:50 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] KVM: VMX: invalid Signed-off-by trailer using handle instead of
  real name
- [High] KVM: VMX: stale EFER in prepare_vmcs02() via tr_valid() hits
  KVM_BUG_ON()
--

commit b3cbe60df7c397383ce043a8a068896cca8bff45
Author: zhangdaolong <dlzhangak@isoftstone.com>

> KVM: VMX: Disallow 16-bit busy TSS (type 3) for TR in IA-32e mode
>
> According to Intel SDM Vol. 3C, "Checks on Guest Segment Registers", the
> TR segment type must be 11 (64-bit busy TSS) when the "IA-32e mode guest"
> VM-entry control is 1, and may be 3 (16-bit busy TSS) or 11 (32-bit busy
> TSS) only when "IA-32e mode guest" is 0.
>
> Currently, tr_valid() unconditionally allows type 3 even when the guest is
> in IA-32e mode (long mode). When emulate_invalid_guest_state is enabled,
> this causes __vmx_guest_state_valid() to falsely report a valid guest sta=
te
> for a 64-bit guest with a 16-bit busy TSS, resulting in a hardware VM-Ent=
ry
> failure (EXIT_REASON_INVALID_STATE / KVM_EXIT_FAIL_ENTRY) instead of
> emulating the invalid guest state.
>
> Check is_long_mode(vcpu) in tr_valid() and reject type 3 when the vCPU is
> in IA-32e mode.
>
> Fixes: 648dfaa7df2d ("KVM: VMX: Add Guest State Validity Checks")
> Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>

[Severity: High]
Per Documentation/process/submitting-patches.rst, the Signed-off-by tag and
commit Author need a full real name (given name and family name separated by
a space) rather than a single-word handle ("zhangdaolong").

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 612ab07d4100f..901280328cee3 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -3917,7 +3917,7 @@ static bool tr_valid(struct kvm_vcpu *vcpu)
>  		return false;
>  	if (tr.selector & SEGMENT_TI_MASK)	/* TI =3D 1 */
>  		return false;
> -	if (tr.type !=3D 3 && tr.type !=3D 11) /* TODO: Check if guest is in IA=
32e mode */
> +	if (tr.type !=3D 11 && (is_long_mode(vcpu) || tr.type !=3D 3))
>  		return false;
>  	if (!tr.present)
>  		return false;

[Severity: High]
Can checking is_long_mode(vcpu) here evaluate a stale vcpu->arch.efer during
prepare_vmcs02() and leave vmx->vt.emulation_required out of sync with
vmx_guest_state_valid()?

arch/x86/kvm/vmx/nested.c:prepare_vmcs02() {
	...
	vmx_set_cr0(vcpu, vmcs12->guest_cr0);
	vmcs_writel(CR0_READ_SHADOW, nested_read_cr0(vmcs12));

	vmx_set_cr4(vcpu, vmcs12->guest_cr4);
	vmcs_writel(CR4_READ_SHADOW, nested_read_cr4(vmcs12));

	vcpu->arch.efer =3D nested_vmx_calc_efer(vmx, vmcs12);
	/* Note: may modify VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
	vmx_set_efer(vcpu, vcpu->arch.efer);

	if (CC(from_vmentry && !vmx_guest_state_valid(vcpu))) {
	...
}

vmx_set_cr0() computes vmx->vt.emulation_required =3D vmx_emulation_require=
d(vcpu)
before vcpu->arch.efer is updated to L2's EFER, and vmx_set_efer() does not
recompute it.

When a 64-bit L1 guest (EFER_LMA =3D=3D 1, CR0.PG =3D=3D 1) enters a 32-bit=
 paged
protected-mode L2 guest (VM_ENTRY_IA32E_MODE =3D=3D 0, CR0.PG =3D=3D 1) with
SECONDARY_EXEC_UNRESTRICTED_GUEST disabled and a valid 16-bit busy TSS
(tr.type =3D=3D 3), vmx_set_cr0() sees no change in CR0.PG, leaves L1's
EFER_LMA =3D=3D 1 in vcpu->arch.efer, and sets vmx->vt.emulation_required =
=3D true.
Once vcpu->arch.efer is updated to L2's EFER (EFER_LMA =3D=3D 0),
vmx_guest_state_valid() succeeds and nested VM-Enter completes with
nested_run_pending set, causing vmx_vcpu_run() to bail out on
emulation_required and hit KVM_BUG_ON(vcpu->arch.nested_run_pending, vcpu->=
kvm)
in __vmx_handle_exit().

Conversely, when prepare_vmcs02() runs with from_vmentry =3D=3D false while
EFER_LMA is 0 to load a 64-bit restricted L2 state with tr.type =3D=3D 3,
emulation_required is left false, resulting in a hardware VM-Entry failure
instead of emulating the invalid guest state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1794812900.6AFAABE3=
.003.4jSf8g6LZ4z562g@fangwg01?part=3D1
