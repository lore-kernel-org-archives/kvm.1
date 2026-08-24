Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30F41DDF2
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577110; cv=none; b=WX11UCWtpT3WcGEIjbzXP85RGaafXFyXGmX4cb5YduRa3FWQRjbG+lHqGAVW5xIJZrVeOgM5GqERvvlS97fhHg99ghjFpxhonsCG1lXwnr2HGRDHxdB6uby1cW61E3OHCUOClkq1rmZIitCW2O2wDK1TE/KBcioF+ZRDVwtO2dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577110; c=relaxed/simple;
	bh=Mef4P+6FnDZQMmLjZxhz9PWKeqiaNruzkqUpgusSsTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aLWROqyCYJI2JXL/SqsDvnK8u2wIdap6e80g6Wasyxu+3CtkuzPyz4Jaklw7KnSiw9XizGMLEzjAFI5wBaBfI2PQqCzpwEUq3IRqOGRVynrFUG3Jt/bBJVtn5x4wFry+CEWCyej9NNaj106Nxba5iqPsUM79I1UMXcr021Mxsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3tMc4Dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3tMc4Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0660C1F000E9;
	Mon, 24 Aug 2026 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787577109;
	bh=976A5+7qqZxtPvwKnIWF+yrtblBnbXOeAXcjWjiBpC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3tMc4DrKrGXVABqxNCCdg7lLf02ySi77LPVntbChEQsnIALS+3NBQ5KQGUfVhQuJ
	 1J+aq+eJTTzAKHioBEJI5lMmHd8boDsatw1DXk56gKL33ghtBz8wLuyR5Vr6z/xgI6
	 /YMM6pk9taHXWl2ae4Xp9/OIBAcp+CBtS8/h9jsfpZgD6X09kOs0Enu2VMTUb1FjWg
	 FeW5x94H/pwniusIgfM6LBJXiaqxYJjFK0wnre3KLNAjOipb5721WV2yb6PA95mnWq
	 w777TtMitOpIT8XYqZqRG7ygicfLwXOiyHbF0aC6ohK90+pDaq0BH5s0o/Pct9MZBG
	 xUYoJWg1Zfbzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO for
 emulated intercepts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260824123954.315112-3-zhang_wei@open-hieco.net>
References: <20260824123954.315112-1-zhang_wei@open-hieco.net>
 <20260824123954.315112-3-zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:11:48 +0000
Message-Id: <20260824131149.0660C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditionally setting bit 63 for `MOV CRx` intercepts violates=
 the AMD specification and causes L1 KVM to spuriously inject a #GP into 32=
-bit L2 guests.

Pre-existing issues:
- [High] Host kernel pointer leak (KASLR bypass) when emulating INVLPG with=
 a register operand.
--

--- Patch [2]: [PATCH v5 2/8] KVM: nSVM: Synthesize DecodeAssists EXITINFO =
for emulated intercepts ---
commit 8b2926ca93c673e51f89c3e65becdb72f34b66f7
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts

When the x86 emulator encounters an instruction intercepted by L1,
svm_check_intercept() synthesizes a nested VM-Exit without fresh hardware
DecodeAssist state.  Populate the architectural EXITINFO fields when
DecodeAssists is exposed to L1.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9d607b98bd067..c7c1f1527c3cf 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -4810,6 +4810,52 @@ static const struct __x86_intercept {

[ ... ]

> +	switch (info->intercept) {
> +	case x86_intercept_cr_read:
> +	case x86_intercept_cr_write:
> +		/* MOV CRx: bit 63 set, GPR number in bits 3:0. */
> +		exit_info_1 =3D BIT_ULL(63) | (info->modrm_rm & 0xf);

[Severity: Medium]
Does unconditionally setting bit 63 here violate the AMD specification for
32-bit L2 guests?

If an L2 guest running in 32-bit mode issues a MOV CRx instruction that gets
emulated by L0 (e.g. via KVM_FEP), L0 will synthesize a nested VM-Exit to L1
and unconditionally set bit 63 (CR_VALID) in EXITINFO1.

L1 KVM will see bit 63 set, assume it is a 64-bit operation, read the full
64-bit GPR (which may contain garbage in the upper 32 bits from 32-bit
execution), and pass it to kvm_set_cr4(). This would fail the reserved-bit
check, causing L1 to spuriously inject a #GP into the 32-bit L2 guest.

> +		break;
> +	case x86_intercept_clts:

[ ... ]

> +	case x86_intercept_intn:
> +		/* INTn: software interrupt number in bits 7:0. */
> +		exit_info_1 =3D info->src_val & 0xff;
> +		break;
> +	case x86_intercept_invlpg:
> +		/* INVLPG: linear address of the target page. */
> +		exit_info_1 =3D info->intercept_linear_addr;

[Severity: High]
This is a pre-existing issue, but does assigning info->intercept_linear_addr
here leak a host kernel pointer (KASLR bypass) to the L1 guest?

If an L2 guest places an INVLPG instruction with a register operand
(e.g. INVLPG %eax) across an MMIO page boundary, KVM is forced to emulate i=
t.

decode_modrm() correctly identifies it as a register operand and stores a h=
ost
kernel pointer in addr.reg.

Later, get_intercept_linear_addr() blindly reads addr.mem.ea (which aliases
addr.reg), extracting the host kernel pointer:

arch/x86/kvm/emulate.c:get_intercept_linear_addr() {
    ...
    la =3D seg_base(ctxt, ctxt->src.addr.mem.seg) + ctxt->src.addr.mem.ea;
    ...
}

By writing info->intercept_linear_addr to exit_info_1 here, the host KASLR
offset is exposed to the L1 guest in the synthesized VM-Exit.

> +		break;
> +	case x86_intercept_invlpga:
> +		/* INVLPGA: the address remains available in guest rAX. */
> +		exit_info_1 =3D 0;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	vmcb->control.exit_info_1 =3D exit_info_1;
> +	vmcb->control.exit_info_2 =3D 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824123954.3151=
12-1-zhang_wei@open-hieco.net?part=3D2
