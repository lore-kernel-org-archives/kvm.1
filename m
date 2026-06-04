Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0F2BE03C
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585303; cv=none; b=HRhwAEoIdDgAcRoddcupmtjSkYKW9dzjVw4yMlzXe8LrVJT/oEomZNKEk3z4Yy8/D1NDWkemLloB7NwEIsOtyvLnRsAr4m6tQkyN8fLo0QqRimAoEsD7LOar9mWuC/VRgr3hmr1xtao3EdPwiPQT0EZNwSNuzO1aJ7YSm9wGHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585303; c=relaxed/simple;
	bh=3m0SHDShFNLqOGF9vpNwbF0RIoZkqaVDhrlNn5/x0i0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wo9GjQ0hT9/aW4ciR90bYmxbXt2CEKY6jCKg3QrBeKqpQmwU2HPSR2y7E12ISw+P8RxMPRu+FmFamtR7o6dc26D1hqXypxm8E+eyuegQWPWnV7rYBMuTaVhx9pU2bcC7dOz8RbLMa2O8l2W3h28a1W2gxcA0+/fg5//71HnlSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2ZAwqgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2ZAwqgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0F01F00893
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 15:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780585301;
	bh=NFwPz7FnSARe8eOgtiFyAiPJDe9RcdPsCvvRJn+nX0c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Z2ZAwqgdYptfL1SPuB+K2ygQwje9FbFK96jDf1f3UE5dItCR0yGCQ+9CR+qk69BZa
	 km/kQRIFISr53oKjPc8CBq0rmGoa7JSLox0Bx9RDGVqR6rZiVyIhW/ClHiuy3RgTvx
	 GF7H7YGVZRSkMehLf4UQosdZaB8hitflvX4HEePjbupUCNsFtkWfI+r24XOu0C6Vx2
	 dJhWYFOrMzEjINCbhpZXnP6lLv0S8NVvSgFtKIVhnv/XcyY9Rha7vMu1QU8ScePkB/
	 lb3sdN1a9ZC1cME74LYW3LmGH6peNFaUXlaX3uDYT9/xomIBSlBvjrvELMS9EQ7aq1
	 T/CLDydkdvX3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
References: <ca503ae3de72d90956fcaf5dbc0760ec20f5a5e0.1780584300.git.kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:01:41 +0000
Message-Id: <20260604150141.8B0F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] handle_cpuid() fails to clear the upper 32 bits of RAX, RBX, RCX, =
RDX, allowing an untrusted VMM to inject garbage into guest registers.
--

commit 1a8c131a02100639d5d76e680c87ef32990b4663
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/tdx: Fix zero-extension for 32-bit port I/O

This commit fixes the zero-extension behavior for emulated 32-bit port I/O =
in
handle_in(). It uses insn_assign_reg() to correctly write the result into R=
AX
with proper partial-register-write semantics, ensuring the upper 32 bits are
zeroed for 4-byte reads.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 4d7f71d50122e..fcb9ec936d050 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,8 +693,8 @@ static bool handle_in(struct pt_regs *regs, int size,=
 int port)
>  		.r13 =3D PORT_READ,
>  		.r14 =3D port,
>  	};
> -	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
> +	u64 val;
> =20
>  	/*
>  	 * Emulate the I/O read via hypercall. More info about ABI can be found
> @@ -702,11 +702,9 @@ static bool handle_in(struct pt_regs *regs, int size=
, int port)
>  	 * "TDG.VP.VMCALL<Instruction.IO>".
>  	 */
>  	success =3D !__tdx_hypercall(&args);
> +	val =3D success ? args.r11 : 0;
> =20
> -	/* Update part of the register affected by the emulated instruction */
> -	regs->ax &=3D ~mask;
> -	if (success)
> -		regs->ax |=3D args.r11 & mask;
> +	insn_assign_reg(&regs->ax, val, size);

[Severity: High]
This isn't a bug introduced by this patch, but while you are fixing the
zero-extension semantics for handle_in(), could the same issue be present
in handle_cpuid() when emulating CPUID?

In arch/x86/coco/tdx/tdx.c:handle_cpuid():

	/*
	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
	 * So copy the register contents back to pt_regs.
	 */
	regs->ax =3D args.r12;
	regs->bx =3D args.r13;
	regs->cx =3D args.r14;
	regs->dx =3D args.r15;

Does this code fail to zero out the upper 32 bits of RAX, RBX, RCX, and RDX
in 64-bit mode?

Since CPUID should clear the upper 32 bits of these registers, does directly
assigning the 64-bit values from the untrusted hypervisor allow a malicious
VMM to inject non-zero upper bits into the guest registers?

If guest software relies on the upper 32 bits being zeroed after CPUID,
could this lead to unexpected behavior or bounds-check bypasses in 64-bit
contexts?

> =20
>  	return success;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780584300.gi=
t.kas@kernel.org?part=3D3
