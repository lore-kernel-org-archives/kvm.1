Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81443CB8EF
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355488; cv=none; b=ejpVFwcKVMOYd1Q9nAbhVx/JC6/FeQ6KSECCWi9fFqNOt3xntfcEbN/Iy4bL1uBCXt+mzU04iotbgNNwKh7qlPx78tSWsVpcE3NpOJxFNvC8W25s79k3Q78IB+1+hhD79PP8ttbXXl9WhX5KB04SrapjTFYgvFne3Sd0HsJ0bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355488; c=relaxed/simple;
	bh=PI0rVsmyin7yFcT66R1Azg53z3uC1KsGuGpW8kIVPJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B76GlMa1h3SvxDq9jhbjawaxMhNcN69D8sZ87IJ78k7PSLRA9dYEJpxe6AeTWvU5MJXMOMUMZvExrnm6nWCQiLBcagBu7+7TLfpDsVn6aAUfEoEzt2EYTYDVhM+N62XBy06YyEdevlvgR51LWDRoLyAVNb/M2ZOLDaXKfzLIEvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrqnwKl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrqnwKl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A591F000E9;
	Wed, 29 Jul 2026 20:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355487;
	bh=JxmK9AS/arIKqzoCQFxu5XoT66Y4L6A4fe423PlB4WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrqnwKl7zurtfqBaM5CtFaEnOG4jtHteSMHGs7m36Q3XNiZmLjcLmSHaUyTLL1hFa
	 cgHFJrZ5zePKoyv9RvcPLWI3av64d/fcg7dsELAFJxYtLAVRdl9f07un4X+dWaoy1x
	 9JQBLM4xVz/2HStNOCKZ+ffFBAo7C1Ko+1NIhaDaX4mJISFgNXOy8nt31DO5e7s+a/
	 lxPfknqGaBQ+fJB48lcMqpAahViKQxL1Kw8UxcPrL/Vzih8L2cA1nSkv+2/5nhcECx
	 Mq92mPkEdoVygKT9h2MR+ppRN0pGmOVqxYbVBQHwxnK/L8Yd6Y6CG+3q1dTnT9mxAl
	 T0iDo52NPPEBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-12-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:04:46 +0000
Message-Id: <20260729200447.36A591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incomplete NoRex2 enforcement on legacy instructions and archite=
ctural flaw in flag checking prevents group instruction support.
- [Medium] Missing NoRex2 flag on legacy SIMD instructions creates a future=
 Guest-to-Host DoS (Kernel Panic) via out-of-bounds register read.
--

--- Patch [11]: [PATCH v6 11/20] KVM: x86: Handle EGPR index and REX2-incom=
patible opcodes ---
commit 60f040dc7da6f4fa4728dd8cf6193faca78101de
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Handle EGPR index and REX2-incompatible opcodes

Prepare the emulator for REX2 handling by introducing the NoRex2 opcode
flag and supporting extended register indices. For the latter, factor out
common logic for calculating register IDs.

Link: https://lore.kernel.org/1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.c=
om

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index b566ab5c75156..12a822870d08e 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c

[ ... ]

> @@ -1118,7 +1129,7 @@ static void decode_register_operand(struct x86_emul=
ate_ctxt *ctxt,
>  	if (ctxt->d & ModRM)
>  		reg =3D ctxt->modrm_reg;
>  	else
> -		reg =3D (ctxt->b & 7) | (ctxt->rex_bits & REX_B ? 8 : 0);
> +		reg =3D (ctxt->b & 7) | rex_get_rxb(ctxt->rex_bits, REX_B);
> =20
>  	__decode_register_operand(ctxt, op, reg);
>  }

[Severity: Medium]
Are legacy SSE and AVX instructions (e.g., MOVAPS at 0x0F 0x28 in
twobyte_table) missing the NoRex2 flag in the emulation tables?

If a guest executes a REX2-prefixed legacy SIMD instruction, the new
rex_get_rxb() logic would extract extended bits, producing a register
index between 16 and 31.

During operand decoding, this out-of-bounds index is passed along:

arch/x86/kvm/emulate.c:__decode_register_operand() {
    ...
    if (ctxt->d & (Avx|Sse)) {
        op->type =3D OP_XMM;
        op->bytes =3D 16;
        op->addr.xmm =3D reg;
        kvm_read_sse_reg(reg, &op->vec_val);
    ...
}

Will this pass the out-of-bounds index (16-31) to kvm_read_sse_reg()?=20

The underlying accessor _kvm_read_sse_reg() only handles indices 0-15 and
hits a default BUG() case for anything higher, which would result in a host
kernel panic.

[ ... ]

> @@ -4994,6 +5005,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt,=
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
>  	if (opcode.flags & ModRM)
>  		ctxt->modrm =3D insn_fetch(u8, ctxt);
> =20

[Severity: Medium]
Since this check is performed immediately after fetching the base opcode,
but before the while (ctxt->d & GroupMask) loop resolves nested group
instructions (such as call far in group 5), will this fail to enforce
the NoRex2 restriction on instructions nested within a group?

Should this check be evaluated against ctxt->d after the group decoding
loop instead?

Also, numerous legacy instructions (e.g., cpuid, hlt, cli, sti, pushf,
popf) appear to be missing the NoRex2 flag in the twobyte_table and
opcode_table, which might allow erroneous emulation instead of injecting
an undefined opcode exception.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D11
