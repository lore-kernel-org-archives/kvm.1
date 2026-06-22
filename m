Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFECA45
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782102506; cv=none; b=LapDGCoPvZTX3nbFQ/fN9EQU7mbah9BTixC/2KlKzqVKCGRoXCIqBFem3xIrvW/NuPHXcpZbEUHJxpEf4E79oW0Khzf4GVUgi9fX0VvUagmJVw6/iZOXtutOu2w4Ihsk0DGRdEH3By8fr7mXJUqshxbaSg52k5FkTSJ2KSuXHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782102506; c=relaxed/simple;
	bh=zChOAiqtVYVBl9Cr+xZaPR0utcdP8qDAEIU1qHKl4eU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ojrtk5lze0vlIP+gTRhYc+c+T/3xijPJ9gJ2JiakLxCFDLFZdzSFRTa6Vypkhl81QXK5zp8Ew8RKUtS1yCnM7d4jIF1NH7fTAdp5fFZcPwXcvBTiboWFxUYAJDVaUQ4zZBigAZFcRNykGWnlAwWyeFRYRqpkb/dDblvu0iuWMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHdLVyDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHdLVyDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4282F1F000E9;
	Mon, 22 Jun 2026 04:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782102505;
	bh=mn9iRJQAWA9jfzUPww+rcY2ixRx3rNwuUGZU1lw4JZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KHdLVyDGuY70DFT0j9soW205OMeu9qamSebrJ4T7gSEf2QoIlOsEe7+WsX6593jA1
	 per9qzGFhmu/YJ9drPyrlVwNB68erTyMHA2LrKazNGUoh43cBVfEALxlSF9sEJVM2y
	 ovLpWtF1Q1lVl6YZ0QD51dQMElgLu+Ja1ZQYS+wbMn+4/vBIOgbg1II2Dx9qAfTJ8Q
	 0293OKl3STXZT8xp8KbD3DYs6N1J5WHVKHa2FkoMKgnAZuJYlBuFiHV0/zszUPSJbd
	 Y7qMZIJVhR2+MbGLtypqaP/vq5ERhYZ/KSWJNbz4XJISq/vnMBWbVRAtZ098xg9rTC
	 24SYT0qNY/9Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/16] riscv: alternatives: Use generated instruction
 headers for patching code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins via B4 Relay" <devnull+thecharlesjenkins.gmail.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260621-riscv_insn_table-v2-2-7f0810ee2274@gmail.com>
References: <20260621-riscv_insn_table-v2-0-7f0810ee2274@gmail.com>
 <20260621-riscv_insn_table-v2-2-7f0810ee2274@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 04:28:24 +0000
Message-Id: <20260622042825.4282F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect immediate calculation for auipc unconditionally adds 409=
6, breaking alternative patching for jumps where bit 11 is 0.
- [Low] Using a jalr-specific extraction function on an auipc instruction.
--

commit 67f209569c2cc2afe918708c4cf86d391c4abcd2
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>
Subject: riscv: alternatives: Use generated instruction headers for patchin=
g code

This commit migrates the alternative patching code to use generated
instruction headers instead of hand-written composition functions.

> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
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

[Severity: High]
Does this unconditionally add 4096 to the immediate?

The original code conditionally added the offset using (imm & BIT(11)) << 1,
but the new code appears to evaluate to a constant BIT(11) << 1. If imm
has bit 11 set to 0, won't this corrupt the target jump address by 4096 byt=
es?

> +
>  	/* update instructions */
> -	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> +	riscv_insn_auipc_insert_imm(&call[0], auipc_imm);
> +	riscv_insn_jalr_insert_imm(&call[1], imm);
[ ... ]
> @@ -127,7 +138,7 @@ void riscv_alternative_fix_offsets(void *alt_ptr, uns=
igned int len,
>  				continue;
> =20
>  			/* if instruction pair is a call, it will use the ra register */
> -			if (RV_EXTRACT_RD_REG(insn) !=3D 1)
> +			if (riscv_insn_jalr_extract_xd(insn) !=3D 1)

[Severity: Low]
Since insn is verified to be an auipc instruction just above this block,
should this be using riscv_insn_auipc_extract_xd(insn) instead?

While they both extract the destination register at bits 11:7 and work
mathematically, using the jalr helper on an auipc instruction seems
to break the abstraction provided by the new headers.

>  				continue;
> =20
>  			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621-riscv_insn=
_table-v2-0-7f0810ee2274@gmail.com?part=3D2
