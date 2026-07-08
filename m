Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AD330315
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482325; cv=none; b=PoGvLsc2IOI0t6qpOvgywpC7s8EtvR4xHb1ipBG/T4QMlKhP/IOtKkjIaeujZMeLARckP9FXTvCr3TweCweAzfxZyWfpzqdX5e2V0KbfJACvaco0VMOsIz7jubivyH2SdxUr2lwaVEg6X4CkPaYxiQVMroaVg5yvdz841kMdqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482325; c=relaxed/simple;
	bh=1BWZHgO0kIlAO/NJaZTaUVo4S4UsD4Y4YTA8g1v6YJA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E9Lwcy4lDN/ZfLycURiypxwi4EUPTjUlL1kxrrpNQhmbcuSoReNVhJK+ruc93DWbRjjgcYB/dVBtbBOXZQFFYJIspXbsjd1mXYAcZDd4MGYLwOfrE7lPPbWj49YIshJub+RxeSIcu/MatZ/Ukm9CaCglMsqUGEC0t06sYbr8iMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecNzPVnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecNzPVnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EAC1F000E9;
	Wed,  8 Jul 2026 03:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482324;
	bh=TFw4cLJ9YolKW1l5NCdrgBv1ozs1QZdYLqzw8SFsZ9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ecNzPVnf28zP0t9tnA38JnBEwVE3p45drRNplZpuPnTBRnzHZR60qNH1aPyrY8j0e
	 OXnCo9BI+myPxBN10S39BEcXHH1XISkvFArznKe7zqwFPW+w5+cuZ17DB9PxoaMthn
	 TZ5RVzOlyReW0jaWn5yIMTp4/xrShYLHAii7zpT5AQJHETNByWNqlqtswQkw1eQSlj
	 fcJFFvbJj/NitkL+nDkEwo3YntmeFpNM4C99sbN6EEKp+SoMiLFVHbdrmmCYpKeOOE
	 kCYMjtEYu8dmWA0//BCjMl+6J01j2CVUMepbsQW4Amntdx2juVjiaxMV3B4362G5M7
	 bM2a1/X49GPtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/17] riscv: alternatives: Use generated instruction
 headers for patching code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-2-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-2-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:45:23 +0000
Message-Id: <20260708034523.D6EAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The upper 20 bits of the jump offset are discarded when calcul=
ating the immediate for the `auipc` instruction, completely breaking altern=
ative patching for `auipc`+`jalr` sequences.
--

--- Patch [2]: [PATCH v3 02/17] riscv: alternatives: Use generated instruct=
ion headers for patching code ---
commit 2a83fc3ccb6ec3374819154c22898986ddd592af
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: alternatives: Use generated instruction headers for patching code

Migrate the alternatives patching code to use the generated instruction
headers instead of the hand-written instruction composition functions.

> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternat=
ive.c
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -78,14 +79,24 @@ static void riscv_alternative_fix_auipc_jalr(void *pt=
r, u32 auipc_insn,

[ ... ]

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
> +	auipc_imm =3D (imm & BIT(11)) << 1;
> +
>  	/* update instructions */
> -	riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> +	riscv_insn_auipc_insert_imm(&call[0], auipc_imm);

[Severity: Critical]
Does this code drop the upper 20 bits of the jump offset?

The original code combined the upper 20 bits with the sign-compensation bit=
=20
like this:

*utype_insn |=3D (imm & RV_U_IMM_31_12_MASK) + ((imm & BIT(11)) << 1);

It appears that auipc_imm now only contains the sign-compensation bit but=20
leaves out the base imm value. Will this cause the auipc instruction to be=
=20
patched with a 0 upper immediate (or 1 if sign extension bleeds), destroyin=
g=20
the target address for any jump offset outside the +/-4KB range?

> +	riscv_insn_jalr_insert_imm(&call[1], imm);
> =20
>  	/* patch the call place again */
>  	patch_text_nosync(ptr, call, sizeof(u32) * 2);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D2
