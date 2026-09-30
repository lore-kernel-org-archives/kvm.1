Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7F30ACF1
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804857; cv=none; b=qrSt4JpH9t9XmNN24NLC+wrl1olpDdo1eZDwk3+qby32S9yCdHFdwOjzcgUYt8sXqVBYSeLI4QfdEdb8YVgRWhkgku+rY9wD0AAGvHd9PUMg8oe1Hd30ZMSWna5mDgTMrCAtevkApGYEeUBn1OsGjNMxe9778tWQKbNYEIHjPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804857; c=relaxed/simple;
	bh=0LfQfK0K5Scm7vjNWwP0JASEHps3cyoSXAMQCQQvW04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WVFHYupVznVrDghb9gqc9LQpqhIMxwN6JuqjGArHYLSIBbRQnELyeZuRLk4pNBkS63FT18v9BAidsoQN3Rl1TI79CNkTPTNBUTxwo2lha3+VA7hE+MYsCcU8EdLL51vlMPlsi3sZkad7ngLLjRvrBbUSITsfFAq/fI6lfsHNUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orRweHXg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orRweHXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC1E1F00899;
	Wed, 30 Sep 2026 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804856;
	bh=usI4fxmcjtpEa5oRW5S8BluaPw/OgzqEmpI+tYoaVxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=orRweHXgaCRsJfFAVjf/zsgV47XOXpsGC8owl931xl21N4Idaskv0jRnEkZ6cFcGU
	 YO/oeWaHs5EQS1vnuR5Psl+UR4yX04y3fq0qO7YE1zpWmY2ne2jEYPcB1UwueFz28B
	 D0KNo/qipTjq6HF9nQVrKCshGqTZkunSWgGyZCPjgldzHMSk8xXUVn6uXgvKHrmJ09
	 yhhIT7SBPjQCnCzcSzlVE4au1elsQzqvZagSZtc2UCv6JBO1WbE2G0ryKysGI7E9Fj
	 c9l2mk4A1z6qicz+lGPbNBj1jrrtPVIWIX/K588EcUjQVsW2AWErZ7ZYb4dIueeZdl
	 u5iHVnLUQfkuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930210750.1487547-12-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
 <20260930210750.1487547-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:47:35 +0000
Message-Id: <20260930214736.1FC1E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] x86/kvm: Missing NoRex2 flag on legacy instructions allows REX2-pr=
efixed execution without #UD
- [High] x86/kvm: NoRex2 check precedes opcode group expansion making it im=
possible to #UD nested instructions
--

commit a27108ff09a58dbc37193fd34a249d4d8837decb
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Handle EGPR index and REX2-incompatible opcodes

Prepare the emulator for REX2 handling by introducing the NoRex2 opcode
flag and supporting extended register indices. For the latter, factor out
common logic for calculating register IDs.

Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.c=
om

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..a1a567fd03780 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
[ ... ]
> @@ -4273,7 +4284,7 @@ static const struct opcode opcode_table[256] =3D {
>  	I2bvIP(DstDI | SrcDX | Mov | String | Unaligned, em_in, ins, check_perm=
_in), /* insb, insw/insd */
>  	I2bvIP(SrcSI | DstDX | String, em_out, outs, check_perm_out), /* outsb,=
 outsw/outsd */

[Severity: High]
Should these string instructions (ins/outs) include the NoRex2 flag?
Without it, could KVM incorrectly emulate them instead of injecting a #UD
when prefixed with REX2?

>  	/* 0x70 - 0x7F */
> -	X16(D(SrcImmByte | NearBranch | IsBranch)),
> +	X16(D(SrcImmByte | NearBranch | IsBranch | NoRex2)),
>  	/* 0x80 - 0x87 */
[ ... ]
> @@ -4297,15 +4308,15 @@ static const struct opcode opcode_table[256] =3D {
>  	II(ImplicitOps | Stack, em_pushf, pushf),

[Severity: High]
Does pushf also need the NoRex2 flag since it takes no operands and
should #UD with REX2? Legacy return instructions (ret) seem to be missing
this flag as well.

>  	II(ImplicitOps | Stack, em_popf, popf),
>  	I(ImplicitOps, em_sahf), I(ImplicitOps, em_lahf),
>  	/* 0xA0 - 0xA7 */
[ ... ]
> @@ -4335,17 +4346,17 @@ static const struct opcode opcode_table[256] =3D {
>  	/* 0xD8 - 0xDF */
>  	N, E(0, &escape_d9), N, E(0, &escape_db), N, E(0, &escape_dd), N, N,

[Severity: High]
Since x87 FPU instructions do not support REX2 prefixes, should they have
the NoRex2 flag here to ensure they raise #UD?

>  	/* 0xE0 - 0xE7 */
> -	X3(I(SrcImmByte | NearBranch | IsBranch, em_loop)),
[ ... ]
> -	I2bvIP(SrcDX | DstAcc, em_in,  in,  check_perm_in),
> -	I2bvIP(SrcAcc | DstDX, em_out, out, check_perm_out),
> +	I2bvIP(SrcDX | DstAcc | NoRex2, em_in,  in,  check_perm_in),
> +	I2bvIP(SrcAcc | DstDX | NoRex2, em_out, out, check_perm_out),
>  	/* 0xF0 - 0xF7 */
>  	N, DI(ImplicitOps, icebp), N, N,
>  	DI(ImplicitOps | Priv, hlt), D(ImplicitOps),

[Severity: High]
Does hlt need the NoRex2 flag since it takes no operands? (Similarly,
syscall in twobyte_table appears to be missing it too).

>  	G(ByteOp, group3), G(0, group3),
[ ... ]
> @@ -5001,6 +5012,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
 void *insn, int insn_len, int
>  		opcode =3D opcode_table[ctxt->b];
>  	}
> =20
> +	/*
> +	 * Instructions marked with NoRex2 ignore a legacy REX prefix, but #UD
> +	 * should be raised when prefixed with REX2.
> +	 */
> +	if (opcode.flags & NoRex2 && ctxt->rex_prefix =3D=3D REX2_PREFIX)
> +		opcode.flags =3D Undefined;
> +

[Severity: High]
Does evaluating opcode.flags & NoRex2 here occur too early?=20

Since this check precedes the while (ctxt->d & GroupMask) loop that
expands opcode groups, will nested group instructions (like monitor,
mwait, or vmcall) bypass this check and fail to raise #UD when given
a REX2 prefix?

>  	if (opcode.flags & ModRM)
>  		ctxt->modrm =3D insn_fetch(u8, ctxt);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930210750.1487=
547-1-chang.seok.bae@intel.com?part=3D11
