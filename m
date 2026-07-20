Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F74445AF5
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571531; cv=none; b=FJf9j2hMmq+924clGM2JT/bv49ngyDVOAgLTLdyjAeyotwQdLBFnxIFNS5fjGAdoIUFZpiugv9hAML1S/JQXqsl4EX6kbppilQd4fnm7uV/HaF4X5OiohEDSmHHYsBopKsLSdWlHbsSeUwHwZgW54K21RBfEJq5tPEf7N9LeyuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571531; c=relaxed/simple;
	bh=vWAV9OaXbx2XZzkgp3QK/Tcyd82gyhkCOU2VhOTidU4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9hAceqW8SFU3HgUQMktqtgb+Po5PyQ/DTy1P9+Q0qPKVEmd4f7ljflh12n4xcpfNXdgdXYrL/+tIXYCTr7PsIWYJKVnIg9MomBhsuXxSL/5eXrbICtnNMmYCAHBtvqAh8uDuA2YSn+iUPPek7uz+f8JxCgQwIdXfNrBqKPYNWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oifAlLjN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oifAlLjN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9711F000E9;
	Mon, 20 Jul 2026 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571529;
	bh=csFtG7c9utCcznNhuIZR+4Edp7oU2YtSIsmSYb8FZg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oifAlLjNiD9/MFPVT0aeqQDvirAhZ4EPoTiQwUgcMPtjCX3U50uaRUaezpYcCh+ST
	 kuP6nBXFRCeFUD6a7Zmezubskf7hSpTLNSMRkfzqoOAutB6kp8vcSYuvnD0dhwqQa/
	 7HvGAdfVXFTE+8rHMHoMYgXSHC3NKgFWICo3FYlP5QJAjHBoq8TZAy5xEXBUzRxWjI
	 /ivr1hWqJtBYta9qU85Mi5PX2VpdVX+gzOc7sW2azLkqgGKxveN0aUiU1gVxLWSSx3
	 HKRU9F2jTSeoH/6ZOge5bFUh8pIoj16TPkyDxfvY6wwm3koPHsXG+VvXXCBBgATQG0
	 H5vr4fMLNOARA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260720171949.498680-12-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
 <20260720171949.498680-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:18:49 +0000
Message-Id: <20260720181849.6E9711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Missing `NoRex2` flags on vector instructions combined with ex=
tended register indices causes out-of-bounds access and host kernel panics =
(`BUG()`).
- [High] The `NoRex2` mechanism misses numerous REX2-incompatible legacy op=
codes and is structurally flawed for instructions within groups, allowing g=
uests to bypass `#UD` injection.

Pre-existing issues:
- [High] KVM calculates an incorrect effective address when a memory operan=
d uses an SIB byte with index=3D4 (100b) and the REX.X (or REX2.X4) bit is =
set.
--

--- Patch [11]: [PATCH v5 11/20] KVM: x86: Handle EGPR index and REX2-incom=
patible opcodes ---
commit 01ac33b49b5ac2e53b61a7aa1ed3d313429a8038
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
> @@ -1118,7 +1129,7 @@ static void decode_register_operand(struct x86_emul=
ate_ctxt *ctxt,
>  	if (ctxt->d & ModRM)
>  		reg =3D ctxt->modrm_reg;
>  	else
> -		reg =3D (ctxt->b & 7) | (ctxt->rex_bits & REX_B ? 8 : 0);
> +		reg =3D (ctxt->b & 7) | rex_get_rxb(ctxt->rex_bits, REX_B);
> =20
>  	__decode_register_operand(ctxt, op, reg);

[Severity: Critical]
Can this extended register index cause a host kernel panic?

With the newly introduced rex_get_rxb(), the register index can now reach 31
if extended bits (e.g. from a REX2 payload) are set.

For SSE/AVX vector instructions, which lack the NoRex2 flag, this index
is passed entirely unmasked to kvm_read_sse_reg() in
__decode_register_operand().

If an extended index > 15 reaches _kvm_read_sse_reg(), it triggers the
default BUG() path:

arch/x86/kvm/fpu.h:_kvm_read_sse_reg() {
    ...
    switch (reg) {
    case 0: *data =3D sse[0]; break;
    ...
    case 15: *data =3D sse[15]; break;
    default: BUG();
    }
}

Would an unprivileged guest be able to use a REX2 prefix on a vector
instruction to intentionally panic the host?

[ ... ]

> @@ -1137,9 +1148,9 @@ static int decode_modrm(struct x86_emulate_ctxt *ct=
xt,
>  	int rc =3D X86EMUL_CONTINUE;
>  	ulong modrm_ea =3D 0;
> =20
> -	ctxt->modrm_reg =3D (ctxt->rex_bits & REX_R ? 8 : 0);
> -	index_reg =3D (ctxt->rex_bits & REX_X ? 8 : 0);
> -	base_reg =3D (ctxt->rex_bits & REX_B ? 8 : 0);
> +	ctxt->modrm_reg =3D rex_get_rxb(ctxt->rex_bits, REX_R);
> +	index_reg       =3D rex_get_rxb(ctxt->rex_bits, REX_X);
> +	base_reg        =3D rex_get_rxb(ctxt->rex_bits, REX_B);

[Severity: High]
This is a pre-existing issue, but does this logic calculate an incorrect
effective address when the SIB index is 4 and REX.X (or REX2.X4) is set?

According to the Intel SDM (Vol 2A), when the SIB index field is 100b
(indicating no index register), the REX.X bit must be ignored.

However, KVM initializes index_reg with the REX.X bit (value 8, or up to 24
with REX2). When OR'd with the SIB index of 4 later in decode_modrm(),
index_reg becomes 12 (or 28).

KVM then checks:
    if (index_reg !=3D 4)
        modrm_ea +=3D reg_read(ctxt, index_reg) << scale;

Since 12 !=3D 4, wouldn't KVM mistakenly read r12 and add it to the effecti=
ve
address, causing it to read or write incorrect MMIO devices or memory?

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

[Severity: High]
Does this check fail to inject #UD for numerous REX2-incompatible opcodes?

This check evaluates the NoRex2 flag immediately after reading the first op=
code
byte, before the GroupMask evaluation loop.

If the opcode is a group descriptor (e.g. group5 in opcode_table), it does
not have the NoRex2 flag set. The group is resolved later, bypassing this #=
UD
check entirely. As a result, REX2-incompatible instructions inside groups l=
ike
far calls and far jumps cannot be properly trapped.

Additionally, ModR/M-less implicit instructions like hlt, cli, and sti appe=
ar
to be missing the NoRex2 flag entirely in opcode_table.

Will this structural flaw allow guests to bypass #UD injection for these
instructions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720171949.4986=
80-1-chang.seok.bae@intel.com?part=3D11
