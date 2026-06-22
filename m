Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E971A3160
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102913; cv=none; b=XuKc4nNP3rnmW3C7d6fwXzP2mVw+1UDpdlEdIxBZUA5pBSDlNlit2TY3KdR0NIqNkPpVfeK6EaEgaAdjXyrAOA73sCeHoDdUtyGtE2qSDJSrHzbmhWPCuB3kWcn22UMUC4YOXQYmxJUIdNn/Kx0SXPYP9kXTmM1LqaN/oaYb8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102913; c=relaxed/simple;
	bh=f7yngOaiql8bxXoC7M1MccPtsIq0ZKDTathvBns/JtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LNczsGzf9vTsuWtRDFor7qj5XihDBSjRdeNwkxNKyYkE821djoGcQpbdeHFxjS4EB+AUUdwLu6KfMCmmd1vkgWv7SWJ5sng82OCPz1Qa4ncMpEwMXxBsVvcFSqePoiWvhFnS8bF9mbQJiYtNxadmctNZeY8k+bJhaKkY81N4v2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5nkgW4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5nkgW4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8736B1F000E9;
	Mon, 22 Jun 2026 04:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102911;
	bh=/bxcoorH509VmAgc0fwLwTKA0GvZ0K3ZuQClb1Q0bxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5nkgW4YYNtyP6UBxfJFqQotWAKKaLu3AuaybzcrrvTvvusRF5sRLp7bMAMU9V4dd
	 0xeD5dqL34CzblHvj5whnq7lD2vLef4ug+TWcvkztaxlmCjXjEcOh8RnrgtPnivizg
	 tzpCY/zkxNyx1vjsbYzj0PsJrc7lsbo2/OewYiKijo/mWKA9pjAVwreJd8xYt2xSWS
	 b33W8a+Gfw+eLj8mskaXE0UXQLbpk4FymhnLbNbUPsyxEDZzF65IJ2oPFic+CfsQXb
	 zC9mBFDEcGowp5wXoBsxXBd2CYMU1KgI7Oa58P2GIl+4O0ACfzfRoJxlJw0+DE692M
	 NoPCjKO0Nfukw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/16] riscv: cfi: Use generated instruction headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-6-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-6-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:35:11 +0000
Message-Id: <20260622043511.8736B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Incorrect target address calculation for auipc+jalr pairs duri=
ng alternative patching.

Pre-existing issues:
- [High] KCFI failure handler extracts the actual type instead of the expec=
ted type, leading to a misleading log and a potential arbitrary kernel memo=
ry leak.
--

commit fc627870b9c3f0a09b99b862169f28fa7f3bcda2
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: cfi: Use generated instruction headers
   =20
Migrate the code that is decoding cfi instructions to use the generated
instruction headers. This is part of a broader series that updates
instruction decoding and patching across alternative, kprobe, kgdb, and
cfi subsystems to use the newly generated instruction tables.

> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> index 7642704c7f184..b26a90eb65cca 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
[ ... ]
> @@ -78,14 +79,24 @@ static void riscv_alternative_fix_auipc_jalr(void *pt=
r, u32 auipc_insn,
>  					     u32 jalr_insn, int patch_offset)
>  {
>  	u32 call[2] =3D { auipc_insn, jalr_insn };
> +	u32 auipc_imm;
>  	s32 imm;
> =20
>  	/* get and adjust new target address */
> -	imm =3D riscv_insn_extract_utype_itype_imm(auipc_insn, jalr_insn);
> +	imm =3D riscv_insn_auipc_extract_imm(auipc_insn) + riscv_insn_jalr_extr=
act_imm(jalr_insn);
>  	imm -=3D patch_offset;
> =20
> +	/*
> +	 * When the 32-bit immediate is split across auipc and jalr, the
> +	 * constructed immediates need to be treated as individually sign
> +	 * extended numbers. Add the sign bit of the lower 12 bits to the upper
> +	 * 20 bits to undo the bleeding of the sign.
> +	 */
> +	auipc_imm =3D imm + (BIT(11) << 1);

[Severity: Critical]
Does this calculation unconditionally add 4096 to the immediate?

Since BIT(11) << 1 evaluates to a constant 4096 (0x1000), it looks like
this regression adds 4096 regardless of whether bit 11 is actually set
in the immediate.

For any jump where bit 11 of the offset is 0, won't the auipc instruction
be patched with a value that is 0x1000 too large, causing the execution to
jump to an unintended address?

> +
>  	/* update instructions */
> -	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> +	riscv_insn_auipc_insert_imm(&call[0], auipc_imm);
> +	riscv_insn_jalr_insert_imm(&call[1], imm);
> =20
>  	/* patch the call place again */
>  	patch_text_nosync(ptr, call, sizeof(u32) * 2);

> diff --git a/arch/riscv/kernel/cfi.c b/arch/riscv/kernel/cfi.c
> index 6ec9dbd7292ee..e38d5f863747a 100644
> --- a/arch/riscv/kernel/cfi.c
> +++ b/arch/riscv/kernel/cfi.c
> @@ -40,16 +40,16 @@ static bool decode_cfi_insn(struct pt_regs *regs, uns=
igned long *target,
>  	if (!riscv_insn_is_beq(insn))
>  		return false;
> =20
> -	*type =3D (u32)regs_ptr[RV_EXTRACT_RS1_REG(insn)];
> +	*type =3D (u32)regs_ptr[riscv_insn_beq_extract_xs1(insn)];

[Severity: High]
This is a pre-existing issue, but does this extract the actual type
instead of the expected type?

The compiler sequence for indirect call checks places the actual type in
t1 (rs1) and the expected type in t2 (rs2). By extracting xs1 here, the
KCFI failure handler appears to retrieve the actual type loaded from memory.

Since the actual type is read from -4(<reg>) where <reg> could be an
attacker-controlled function pointer, could this allow leaking arbitrary
kernel memory if CONFIG_CFI_PERMISSIVE is enabled and the warning is printed
to dmesg?

Should this extract xs2 instead to get the expected type?

> =20
>  	if (get_kernel_nofault(insn, (void *)regs->epc) ||
>  	    get_kernel_nofault(insn, (void *)regs->epc + GET_INSN_LENGTH(insn)))
>  		return false;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D6
