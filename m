Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E54CCDCA
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788318414; cv=none; b=vDlGqo+hKgG78TW8F/KDCO8ORVdhylL6ydn9ms1LnmGW7AdAvTc5Kfhi1pNoqRIlQnQ3KCS0/MDKUc+wxjafgI5Cl1cT7DbwDjwLaBmoFkqJMWGKNN1yYW2I8SxcnGi/a3VR/tKm7y3RtmpcVgPJzLDVBuuZyh9X/eMo1O/iDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788318414; c=relaxed/simple;
	bh=gzvIl6fOXd3Sokb1dBO3W06R7orIXYFb0EAsT4udKYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJsrnIaq8+9m3Gvtwb/eI528KgyGi0hcx3ZVbvCrKoT6GKvCAUWFhdWWyyy6I1BkrXks7/EL0qvUrRWC5RLwW70lGhiqIdhhlxaQHXhAtSlttqJ8SHhaAjSLYrVhsEthq2XgalwL3r0HZyZrMniyI0EXAt8rt/MTu61hL6pdLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYAFogvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYAFogvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68841F000E9;
	Wed,  2 Sep 2026 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788318413;
	bh=3554Q6wIrVCk6d+bSkAmuinuM2rMvoISiouu1b0FJ3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYAFogvBfqJnbJ9b0cygGhwTwIKIP/kVfFt8sNm5tLxaMIuls//jBigMafud2JTw+
	 6Kvv8TWwKmzvMdlYlDuUV/FP60euqCOvKk2l2Uy3qsxlC2jkDy/5nQo20RrUCPcDI1
	 Sb51HqRi8L7w6N5c2ongT/WgQBz9HwErNGu99SctYCpby5gEDqIfhy/MTojBJoWpZZ
	 zAlTDKlPuBUIuFQf7k2tLfwLSO0mPba6RfS8oXgLQ+Es2wna1YwQbL8AfPWfy3xtWD
	 WwXSwPaYZMkOGkTLQzi4/cpvpQvXqKAQQqs2M1fgoii46vtaR4vh9NtoXNqbFJ9FRi
	 eP2m2x59jj9Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/20] KVM: x86: Handle EGPR index and
 REX2-incompatible opcodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260902021804.718676-12-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
 <20260902021804.718676-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:06:52 +0000
Message-Id: <20260902030652.D68841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Host Denial of Service (Kernel Panic) triggered by a malicious=
 guest executing REX2-prefixed legacy SSE instructions.
- [Medium] Incomplete instruction decoding (emulation mismatch) due to miss=
ing NoRex2 flags on legacy instructions.
--

commit 1208b4a28108287a431ce4eac1464f0588e5971c
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

[Severity: Medium]
Are we missing the NoRex2 flag for legacy string instructions like ins and
outs?

These instructions do not reference extended registers and must raise #UD w=
hen
prefixed with REX2, but they appear to lack the flag here.  Without it, KVM=
's
emulator might diverge from hardware by successfully emulating instructions
that should raise #UD if a guest executes a REX2-prefixed legacy instruction
and forces emulation.

Similarly, it looks like cpuid in twobyte_table is also missing the NoRex2
flag.

>  	/* 0x70 - 0x7F */
> -	X16(D(SrcImmByte | NearBranch | IsBranch)),
> +	X16(D(SrcImmByte | NearBranch | IsBranch | NoRex2)),
>  	/* 0x80 - 0x87 */
[ ... ]
> @@ -4385,12 +4396,12 @@ static const struct opcode twobyte_table[256] =3D=
 {
>  	N, GP(ModRM | DstMem | SrcReg | Mov | Sse | Avx, &pfx_0f_2b),

[Severity: Critical]
Does the lack of NoRex2 on legacy SSE instructions expose the host to a
kernel panic?

If a malicious guest executes a legacy SSE instruction (like movups) with a
REX2 prefix that specifies an extended register index, it could force
emulation. Since the NoRex2 flag is missing here, the emulator will
decode the instruction and extract an extended register index (>=3D 16)
via rex_get_rxb().

If this out-of-bounds index is passed to kvm_read_sse_reg():

arch/x86/kvm/emulate.c:__decode_register_operand() {
    ...
    if (ctxt->d & (Avx|Sse)) {
        ...
        kvm_read_sse_reg(reg, &op->vec_val);
    ...
}

It seems this would hit the default unhandled fallback in _kvm_read_sse_reg=
()
which triggers a BUG(), leading to a host denial of service:

arch/x86/kvm/fpu.h:_kvm_read_sse_reg() {
    ...
    switch (reg) {
    case 0: asm("movdqa %%xmm0, %0" : "=3Dm"(*data)); break;
    ...
    default: BUG();
    }
}

>  	N, N, N, N,
>  	/* 0x30 - 0x3F */
> -	II(ImplicitOps | Priv, em_wrmsr, wrmsr),
> -	IIP(ImplicitOps, em_rdtsc, rdtsc, check_rdtsc),
> -	II(ImplicitOps | Priv, em_rdmsr, rdmsr),
> -	IIP(ImplicitOps, em_rdpmc, rdpmc, check_rdpmc),
> -	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack, em_sysenter),
> -	I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack, em_sysexit=
),
> +	II(ImplicitOps | Priv | NoRex2, em_wrmsr, wrmsr),
> +	IIP(ImplicitOps | NoRex2, em_rdtsc, rdtsc, check_rdtsc),
> +	II(ImplicitOps | Priv | NoRex2, em_rdmsr, rdmsr),
> +	IIP(ImplicitOps | NoRex2, em_rdpmc, rdpmc, check_rdpmc),
> +	I(ImplicitOps | EmulateOnUD | IsBranch | ShadowStack | NoRex2, em_sysen=
ter),
> +	I(ImplicitOps | Priv | EmulateOnUD | IsBranch | ShadowStack | NoRex2, e=
m_sysexit),
>  	N, N,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902021804.7186=
76-1-chang.seok.bae@intel.com?part=3D11
