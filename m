Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D8286A7
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779886066; cv=none; b=UWhZ0FiR4b1k9w4nHThjcaI0r6b3nkJ7dM9/1fse10HX+tS76DCS06CswAXbHij8S+wYktYTcMu4vua9QP4A/K4dTo4frM8JJazxtFjyNmeD04HCJLW8PjSqLuBEZbrnOt65DJ2OTRmgpzCfVtmYC87lrl2DiIkHyIbVcnbXVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779886066; c=relaxed/simple;
	bh=I069BXFzKMngB0OguK3AshMu3cR9LZZIpwB5m3pubAQ=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kZOhuqQEu0e1B+JG2jx7pX7M6Sx6jra5dKqtd2oU1bUIJhV2GTVkEa5TAtUYIpiOXUGV9K6Hd8JBi5kT/0q03udgMx+B9imWUc+3UsITYGdc28IvcTLboEMkz8mut/MHZiHjQKSkast8Lyra6kHIquEFu3jXbSdViwcDNZhlNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2YLX9M9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2YLX9M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333EC1F000E9
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779886065;
	bh=lCn+Eev/RwN0YIRTv7xjseZ1RmXdlPWGNqHTYIyMUCw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=X2YLX9M9c8W2ZjOf5PCEc8OTh29H/yUDaGKTGPq7nPgw1cGnwgSeIJah6PRcwPWTz
	 Yuaf4knCQEXi8DhytGAWSksxJ1Tq9Zwqqsjr+0vekxA2MXqp7XVsRCdHXJKab3njZX
	 1WgFe3oMnknhdScLXs4fVLNhmBJDyIbIRwK08xA+ZkwkQpfFQY4XmTE5ZGVrMZLKAO
	 ELBkuD2ZGB/5pErtMqH9uxp4CzdOJ18CZ+GXMcQmBUFbO8f3neWrP1k/qdfWPQYalE
	 xnrUEBlB5Xd9gKaa4a1g4h6DtYnEDyHMNi75DuxImlIykM/KcvKVNTZhcweZHlipiy
	 EmVXWOuJHxnoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] x86/tdx: Fix off-by-one in port I/O handling
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260527120544.2903923-2-kas@kernel.org>
References: <20260527120544.2903923-2-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 12:47:44 +0000
Message-Id: <20260527124745.333EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] VMM-controlled Register Poisoning in CPUID emulation.
--

commit 8bf39531f06bffdf9286b3ddc6968088a81a8929
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

x86/tdx: Fix off-by-one in port I/O handling

This commit corrects an off-by-one error in the mask calculation for port io
handling. The previous implementation used a mask that was one bit too wide
for all io sizes, which is now corrected.

Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=3Dbxo=
wfZwxrATCBRg@mail.gmail.com/

> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 186915a17c50f..65119362f9a25 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size,=
 int port)
>  		.r13 =3D PORT_READ,
>  		.r14 =3D port,
>  	};
> -	u64 mask =3D GENMASK(BITS_PER_BYTE * size, 0);
> +	u64 mask =3D GENMASK(BITS_PER_BYTE * size - 1, 0);
>  	bool success;
> =20
>  	/*

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but can a malicious hypervisor poison the upp=
er
32 bits of the registers during cpuid emulation?

Architecturally, the cpuid instruction returns 32-bit values in eax, ebx,
ecx, and edx. In 64-bit mode, writes to these 32-bit registers must
zero-extend to their 64-bit counterparts.

Looking at handle_cpuid() in arch/x86/coco/tdx/tdx.c, the 64-bit results
fetched from the untrusted hypervisor are copied directly into the guest's
pt_regs:

arch/x86/coco/tdx/tdx.c:handle_cpuid() {
    ...
	/*
	 * As per TDX GHCI CPUID ABI, r12-r15 registers contain contents of
	 * EAX, EBX, ECX, EDX registers after the CPUID instruction execution.
	 * So copy the register contents back to pt_regs.
	 */
	regs->ax =3D args.r12;
	regs->bx =3D args.r13;
	regs->cx =3D args.r14;
	regs->dx =3D args.r15;

	return ve_instr_len(ve);
}

Since these are not cast to u32 or zero-extended, does this allow the
hypervisor to supply values with non-zero upper 32 bits and potentially lead
to out-of-bounds memory accesses or control flow hijacking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527120544.2903=
923-1-kas@kernel.org?part=3D1
