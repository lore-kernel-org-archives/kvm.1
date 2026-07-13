Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC6C432BE7
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950615; cv=none; b=EnmDo0PU2sCrpYXAEj4WSRmYiWP3/bbON+bQgU4k/uV6Nn1auxv7WRv+cj2SckigWKf2RjinR0RvkYUpJ8ocET1qIb5gR8KD3fnZotjUc9vipgfz/ECiWSgwNErFnRe+7x4caK74wSRGhxsgTXoSSojgQKtMjMeRDu5j3e674+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950615; c=relaxed/simple;
	bh=o6uNn8Jf9VR+7IPefK1cDl6ga04Y/451pLYTSkPvspI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LZ1InANVdgqibS0Yxo7h6e23bK920kL4IH4iD9DuFXRn3fN5WUBXRiIdOmeppllYnWinGmu4a1TG/Ac2WU+QhCFsDFHdx0Ta3Axz1zoC/MINUBlOuhQF7U1gvMFZrShA4JxV39wvnZ8PNMCyDir7pGx/KFMr9d1F7IAb4UR/H5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPWlvi8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPWlvi8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430931F00A3A;
	Mon, 13 Jul 2026 13:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950614;
	bh=vwX/B34BSaTbrbk7dh49dFnwBqh/E+04RPnOcek7taU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NPWlvi8Gc94Pw+uSUVCHr40y9LCoyA6udqGbZesNh6JS7+JUFNPLU3WEdoIA5IMtF
	 l5Zx5MaBIqP4LIVO8aBpYNQ4kORasEw4UT+c9jbaSoCZPJDmx4sTOvrI7gkJGM5f53
	 /sq+Qxsc8qk+N3qM91vuCIPe9eyNuyg0oMmQxAhRvXwmcpNo4NEH2CYgGkWsJfkJe0
	 dfbh1LosKfkm5SoyDkwnLtrtV6iqmF/67pZBtK58tsrMF9UWBPKwHrGlJ2Q0NRx8RG
	 9Mp/W+4phrlWJze0uRsfQCq5mcJmWvg3SJnCHP2Ty4JWoF8Pv2lSjigKB90yuD5IUg
	 PnAPy3Rr2q5tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] x86/tdx: Fix off-by-one in port I/O handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713133753.223947-2-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
 <20260713133753.223947-2-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:50:13 +0000
Message-Id: <20260713135014.430931F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Emulated 32-bit I/O reads (inl) fail to zero-extend the result int=
o the 64-bit RAX register, violating x86-64 semantics.
- [High] Guest register state is corrupted on the error/fault path of an I/=
O read.
--

--- Patch [1]: [PATCH v6 1/3] x86/tdx: Fix off-by-one in port I/O handling =
---
commit 6a0c705281bac273b6793004a9d727acc5a4f92d
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/tdx: Fix off-by-one in port I/O handling

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use a mask that
is one bit too wide for all I/O sizes. For size=3D1 (INB), this produces
GENMASK(8, 0) =3D 0x1FF (9 bits) instead of GENMASK(7, 0) =3D 0xFF (8 bits).
This commit fixes the mask calculation.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 29b6f1ed59ec5..b8bbd715fb624 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -694,7 +694,7 @@ static bool handle_in(struct pt_regs *regs, int size,=
 int port)
>  		.r13 =3D PORT_READ,
>  		.r14 =3D port,
>  	};
> -	u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does the bitwise operation in
arch/x86/coco/tdx/tdx.c:handle_in() properly zero-extend a 32-bit read?

When a guest executes a 32-bit in instruction (inl) triggering handle_in()
with size =3D=3D 4, mask is evaluated to 32 bits (0xFFFFFFFF).

arch/x86/coco/tdx/tdx.c:handle_in() {
    ...
	success =3D !__tdx_hypercall(&args);

	/* Update part of the register affected by the emulated instruction */
	regs->ax &=3D ~mask;
	if (success)
		regs->ax |=3D args.r11 & mask;
    ...
}

The bitwise operation regs->ax &=3D ~mask will clear the lower 32 bits, but=
 it
incorrectly preserves the upper 32 bits of the 64-bit register. x86-64
architectural semantics require any 32-bit write to a general-purpose
register to zero-extend to 64 bits.

Could this cause data corruption for guest software expecting RAX to be
zero-extended?

[Severity: High]
This is another pre-existing issue, but is it safe to unconditionally clear
the target bits in regs->ax on the error path?

If the VMM rejects the hypercall (__tdx_hypercall() returns a non-zero
error), handle_in() still performs regs->ax &=3D ~mask; and returns false.
The kernel then injects a #GP fault into the guest.

The guest exception handler will observe a partially modified RAX register
instead of the unmodified state from before the faulting instruction.=20

Can this violate architectural guarantees for faults by exposing corrupted
register state?

>  	bool success;
> =20
>  	/*
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713133753.2239=
47-1-kirill@shutemov.name?part=3D1
