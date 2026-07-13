Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D151433E87
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950670; cv=none; b=nOLggktFgz/YqukFBvrUVWlZBtDltnNkxZinDFtUVljeTU6jhZso9e5LTNkId/8I60f3fy27sjNJ5rIw4xS6Wvuh4sFvVG4mmBVaCdsNYu2YXjN0NLTHBUwxXhLqeIXel0lZhz+FZYA6VE7liStxg/66zXKYbPtNSIX0pM7Wyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950670; c=relaxed/simple;
	bh=X6mGqtie9TPM4oUFmUe6eZolVSw7vutqPLNRxqVuRw0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eOYpljFw+sAwebX8tLwqDhAcTtFj1xmUSkEgh4Xh0fDl7jtODyOEZxEH/+6Whu2WqaKxGDoFGQYiWEetrcOPLvsPKL6oO+PDTafMhqznOlEKv9j9Zfj9eV2Eh0s5009dh/oPWBB168HFGA4gZH4r//D9K7spGmrjmK4k6Bv2J2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVsn547y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVsn547y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA951F00A3A;
	Mon, 13 Jul 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950669;
	bh=zXw7nUR9UZfM/QsWcJTbJ3YojZHjJw9R2Mk1BGgIBWY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVsn547yW5jvKYFZfiMWzzD5Ik7uEADWNxkHaANNrvP/GRosjgoPOonoQkysJQn1H
	 QjOECqhtfYuWM4wuflxnvb+ZIO0t4eSnIT1KKr1wmtVzWapFB68s+UtD4+o6rj14nu
	 APjw+c0DZUD+uq553dEADrydrKUnPkzu7JYCT28ecaECFEl2N1l4EknVpeMelFdH0a
	 hOf386Yy/2hGNpz2BSuzQhNr5jC06tk87XKhvyAaevsH1rZt5Tf6ibDKwSjotL2D9D
	 0nExvRBMlYCJJjJXSXTw3G6lg1oEKaUK3rbRHFRsRokIgjbzkJKQK7p/HuL3SICe+A
	 zYQoHDBlv5KHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] x86/tdx: Fix zero-extension for 32-bit port I/O
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713133753.223947-4-kirill@shutemov.name>
References: <20260713133753.223947-1-kirill@shutemov.name>
 <20260713133753.223947-4-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 13:51:08 +0000
Message-Id: <20260713135109.1DA951F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The TDX #VE handler for the CPUID instruction fails to zero the up=
per 32 bits of the destination registers, exposing the guest to potentially=
 malicious or garbage data from the VMM.
- [High] The TDX #VE handler for MMIO reads fails to zero the upper 32 bits=
 of the destination register for 32-bit MOVZX and MOVSX instructions.
- [High] The TDX #VE handler for MSR writes corrupts the MSR data sent to t=
he VMM if the guest's RAX register contains non-zero upper 32 bits.
--

--- Patch [3]: [PATCH v6 3/3] x86/tdx: Fix zero-extension for 32-bit port I=
/O ---
commit 54fa9007fcfc0403e17720722b833050a2d55438
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/tdx: Fix zero-extension for 32-bit port I/O

This commit updates handle_in() to use insn_assign_reg() for 32-bit port IN
instructions. This ensures proper partial-register-write semantics where
4-byte forms correctly zero-extend to the full 64-bit register.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index b8bbd715fb624..f904a636d449b 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -703,11 +703,9 @@ static bool handle_in(struct pt_regs *regs, int size=
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
> =20
>  	return success;
>  }

[Severity: High]
This is a pre-existing issue, but since you are fixing zero-extension issues
in this file, I noticed another zero-extension problem in handle_mmio() for
32-bit destination registers.

If a guest executes an instruction like MOVZX EAX, BYTE PTR [mem], the #VE
handler calculates extend_size:

arch/x86/coco/tdx/tdx.c:handle_mmio() {
	...
	case INSN_MMIO_READ_ZERO_EXTEND:
		/* Zero extend based on operand size */
		extend_size =3D insn.opnd_bytes;
		break;
	...
}

If insn.opnd_bytes is 4, doesn't this cause the subsequent memset to only
clear the lower 4 bytes of regs->ax, leaving the upper 32 bits containing
stale data and violating x86-64 architecture rules?


[Severity: High]
This isn't a bug introduced by this patch, but does handle_cpuid() have a
similar problem with zero-extending registers?

When a guest executes CPUID, it traps to the #VE handler. handle_cpuid()
copies the VMM hypercall results directly into the registers:

arch/x86/coco/tdx/tdx.c:handle_cpuid() {
	...
	regs->ax =3D args.r12;
	regs->bx =3D args.r13;
	regs->cx =3D args.r14;
	regs->dx =3D args.r15;
	...
}

Could an untrusted VMM inject non-zero data into the upper 32 bits of these
registers and violate x86-64 CPUID semantics since they are not being
zero-extended?


[Severity: High]
This is also a pre-existing issue, but could write_msr() corrupt the MSR
data sent to the VMM if the guest's RAX register contains non-zero upper
32 bits?

The payload for WRMSR is constructed like this:

arch/x86/coco/tdx/tdx.c:write_msr() {
	...
	struct tdx_module_args args =3D {
		...
		.r13 =3D (u64)regs->dx << 32 | regs->ax,
	};
	...
}

Since WRMSR ignores the upper 32 bits of RAX, the architecture permits
garbage in them. Because regs->ax is not cast to a 32-bit integer before
the bitwise-OR, won't any set bits in its upper 32 bits bleed into the
EDX portion of the payload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713133753.2239=
47-1-kirill@shutemov.name?part=3D3
