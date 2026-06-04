Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3E2FFDD6
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585121; cv=none; b=D+r1Tx1WJeWQuG5HWwNZrA2m6BveJapxgzsVdcF3DS3qyo50+bWNbeG/iu0eGwQg+eMxbKxjrH28Qi8EB5rsgvmbdXQp1E7rcS/tmLS+N/4KcjxXqElKmGT8NTG/lBrOI6fgQA3TDc8uwkerC1bsO70Ej4+/+CuPqVF9K5DU8B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585121; c=relaxed/simple;
	bh=FleHIvrhzp9RGYLxqJDj5T6FLNRKa2alasCqzuljG3Q=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ARWcif1fJTKpkVuIbEgv0gM3EtVCKhHO1SVVxJDNXQwfgveFdrJFvzJfQRSpXu4bSEbAnc9mMRmFYRXp8BCOrQmAvK07XCIFxndgC6YBbGhkyaa5WQxQZso6u5PTg85+KEg6hswX4foWcvXVurqQp0eyETSRWXQvaPSDPcniBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqhrvLV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqhrvLV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176681F00893
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585120;
	bh=J5ne3Z/TMQR9ZG4Ecx4/R22FXVsKWu1v0ZfgltHZk+g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZqhrvLV3R0uZMCeQFqsSTHBWKK1Ln0JN8zEYz/srPE/pjiWZ8+iVX8KTegOUnimlH
	 gJxpzM895qGE0CHICtWaXWWcePzODSSlS0a+oPFiIKDQipT09VddItJ0+7AxfzKzjb
	 E4Q2T1UgUlDpMb4+RiOau3Am0asv4/vfqrj9AdXv261f36SLlCVnZL35kzFr62nn7Z
	 HbK6f96TloPWBR65hd/uxIA1ETE3zsWTm16FxOWc8qGR/7eQd9uKzujorRdEaFLtMj
	 4XsivjJcwAMz5kJjFWgjlLftE4/N7vbrvJnHf+0JIDLhf0zDQrPhIxUsIBG3w9FKwy
	 Jtmx4uG0IfZeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] x86/insn-eval: Add insn_assign_reg() helper
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
References: <daac026e677c10b68740b16ed8ad2556bd9583f8.1780584300.git.kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:58:39 +0000
Message-Id: <20260604145840.176681F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unaligned `unsigned long` pointer dereference leading to Undefined=
 Behavior and adjacent memory overwrite during 8-bit high-byte register emu=
lation.
--

commit a80417d075cbd125216356389da2d074bd0a780e
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/insn-eval: Add insn_assign_reg() helper

This commit lifts KVM's assign_register() into <asm/insn-eval.h> as
insn_assign_reg() so it can be used by both KVM and the TDX guest #VE
handler. It rewrites the helper to use arithmetic operations instead of
pointer punning to avoid relying on specific aliasing or endianness.

> diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn=
-eval.h
> index 4733e9064ee55..85251e718a775 100644
> --- a/arch/x86/include/asm/insn-eval.h
> +++ b/arch/x86/include/asm/insn-eval.h

[ ... ]

> @@ -46,4 +47,28 @@ enum insn_mmio_type insn_decode_mmio(struct insn *insn=
, int *bytes);
> =20
>  bool insn_is_nop(struct insn *insn);
> =20
> +/*
> + * Write @val into *@reg with x86 partial-register-write semantics: a 1-
> + * or 2-byte write leaves the upper bits of the destination untouched; a
> + * 4-byte write zero-extends to 64 bits (matching IN[BWL], MOV[BWL]
> + * etc.); an 8-byte write overwrites the full register.
> + */
> +static inline void insn_assign_reg(unsigned long *reg, u64 val, int byte=
s)
> +{
> +	switch (bytes) {
> +	case 1:
> +		*reg =3D (*reg & ~0xfful)   | (val & 0xff);
> +		break;

[Severity: High]
Does this 64-bit read-modify-write cause an unaligned access and memory
corruption when emulating high-byte registers?

In the KVM emulator, decode_register() generates a pointer offset by 1 byte
for high-byte registers like AH, CH, DH, and BH:

arch/x86/kvm/emulate.c:decode_register() {
    ...
    if (highbyte_regs && modrm_reg >=3D 4 && modrm_reg < 8)
        p =3D (unsigned char *)reg_rmw(ctxt, modrm_reg & 3) + 1;
    ...
}

When this unaligned pointer is passed to write_register_operand() and then
to insn_assign_reg(), treating it as an unsigned long pointer and performing
a 64-bit operation will result in an unaligned access.

Additionally, since the 8-byte operation starts at a +1 byte offset from
the base register in the _regs array, won't this overwrite the lowest
byte of the adjacent register in the array?

The previous implementation avoided this by casting to an 8-bit pointer
before writing:

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c8e292e9a24df..c80752e224ee0 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c

[ ... ]

> @@ -439,25 +440,6 @@ static void assign_masked(ulong *dest, ulong src, ul=
ong mask)
>  	*dest =3D (*dest & ~mask) | (src & mask);
>  }
> =20
> -static void assign_register(unsigned long *reg, u64 val, int bytes)
> -{
> -	/* The 4-byte case *is* correct: in 64-bit mode we zero-extend. */
> -	switch (bytes) {
> -	case 1:
> -		*(u8 *)reg =3D (u8)val;
> -		break;
> -	case 2:
> -		*(u16 *)reg =3D (u16)val;
> -		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780584300.gi=
t.kas@kernel.org?part=3D2
