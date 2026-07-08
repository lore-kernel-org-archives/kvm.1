Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505CC3115AF
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482556; cv=none; b=Gv+mOUWVp2qRNbzKFBRq/583p2bm07SKgzbndTfbcxxNIy0SdhLf6+JKkk3gqMmqFWcXZDWezFHAHNxn1W0kfCF1IEBuuD+L7ezGezY+sECpKgtU8uQv5Idw9I6ss6SNSmkn8UTY+dRkMQQR91gHvoIj0eG2ouiMAbZuxAU2XqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482556; c=relaxed/simple;
	bh=iA3/+X11bk/bXG65ddXtVmwpQcnCYqo/0UondIv7EnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tl8vyyWcFmxlxWtlvK6JT1xQw/M/HcNLyVmxjKsnhq8jMIjUSvsAgiOd4U7HIzvnco+8HrBaCe4jW765yb+u0nHFC9aWWi8zpJKASq1hYnbxL5URSfgg4FKI45MI4gkYCCJ+XENIT4Ht8zMzl8zp8RsR1VZ40+YZcziePUtwmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9VpBICn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9VpBICn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DAB1F000E9;
	Wed,  8 Jul 2026 03:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783482554;
	bh=1h0Qtsll+erOEPisfMCFdx+QayVKIUMHR8C+V9C/lGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S9VpBICnV8S9lySG+l2g0i3EryoJUgTorJ0Ov6v72R34HPmCbcry/uWovAuhKYbtT
	 yOtsCGpzrmBqxvNjqyGJSuXgMFpofmaGZgLZUP91qApUWy4/67Did7vdfgv0fncePr
	 MjhjWfTJVrO+iBCwK4oL2AI32jEdQULMMrqEAx03Nuyp7t0OxMockqDylWZFeKHf0m
	 dMn4NRWXk43KnxRYqyrHoy940FqV34Kq5UGHyZA3fLah9R3oaBEtfY3QsL0TfwokP0
	 08MMP+gn7NoQ3SwSFA8nATuecnozhbQSjc+6j9wBIxeD3Van4JPRxwVRssp1EwqtOB
	 XDD3XjZ+JSikg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/17] riscv: Use generated instruction headers for
 misaligned loads/stores
Reply-To: sashiko-reviews@lists.linux.dev
To: "Charlie Jenkins" <thecharlesjenkins@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707-riscv_insn_table-v3-8-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
 <20260707-riscv_insn_table-v3-8-3f8e5f75ba97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:49:14 +0000
Message-Id: <20260708034914.C0DAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Infinite trap loop (DoS) and lost updates on misaligned loads =
to `zero` or `f0` due to skipped `epc` advancement.
- [Critical] Uninitialized kernel stack leak and Undefined Behavior on 32-b=
it systems via instruction TOCTOU.
- [High] Silent data corruption on misaligned stores from `zero` or `f0` re=
gisters.
- [High] Loss of sign extension on signed misaligned loads causes data corr=
uption.
--

--- Patch [8]: [PATCH v3 08/17] riscv: Use generated instruction headers fo=
r misaligned loads/stores ---
commit 9243cf56f2dcd4d2a9e3d43d550df4f5779ccbf5
Author: Charlie Jenkins <thecharlesjenkins@gmail.com>

riscv: Use generated instruction headers for misaligned loads/stores

This patch migrates the misaligned loads/store code to use the generated
instruction headers. It replaces the hand-written instruction composition
functions with the new generated helpers.

> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/tra=
ps_misaligned.c
> --- a/arch/riscv/kernel/traps_misaligned.c
> +++ b/arch/riscv/kernel/traps_misaligned.c
> @@ -238,68 +217,71 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
>  	if (get_insn(regs, epc, &insn))
>  		return -1;
> =20
> -	if ((insn & INSN_MASK_LW) =3D=3D INSN_MATCH_LW) {
> +	if (riscv_insn_is_lw(insn)) {
>  		len =3D 4;
>  		shift =3D 8 * (sizeof(unsigned long) - len);
> -#if defined(CONFIG_64BIT)
> -	} else if ((insn & INSN_MASK_LD) =3D=3D INSN_MATCH_LD) {
> +		rd =3D riscv_insn_lw_extract_xd(insn);
> +	} else if (riscv_insn_is_ld(insn)) {
>  		len =3D 8;
>  		shift =3D 8 * (sizeof(unsigned long) - len);

[Severity: Critical]
Since the CONFIG_64BIT guard has been removed, what happens on 32-bit
systems if a userspace thread replaces the instruction with a 64-bit ld
before the kernel reads it? Does this result in a negative shift value
(-32) since sizeof(unsigned long) is 4 and len is 8, leading to undefined
behavior?

[ ... ]

> @@ -315,14 +297,16 @@ static int handle_scalar_misaligned_load(struct pt_=
regs *regs)
>  		memcpy(&val, (u8 *)addr, len);
>  	}
> =20
> -	if (!fp)
> -		SET_RD(insn, regs, (long)(val.data_ulong << shift) >> shift);
> -	else if (len =3D=3D 8)
> -		set_f64_rd(insn, regs, val.data_u64);
> -	else
> -		set_f32_rd(insn, regs, val.data_ulong);
> +	if (rd) {
> +		if (!fp)
> +			*(unsigned long *)((unsigned long *)regs + rd) =3D (val.data_ulong <<=
 shift) >> shift;

[Severity: High]
Does this lose sign extension for signed misaligned loads? The previous code
used a (long) cast to ensure an arithmetic right shift. Without the cast,
doesn't this perform a logical right shift and incorrectly zero-extend
negative values?

> +		else if (len =3D=3D 8)
> +			set_f64_rd(rd, regs, val.data_u64);
> +		else
> +			set_f32_rd(rd, regs, val.data_ulong);
> =20
> -	regs->epc =3D epc + INSN_LEN(insn);
> +		regs->epc =3D epc + INSN_LEN(insn);
> +	}
> =20
>  	return 0;
>  }

[Severity: Critical]
If the target register is x0 (zero) or f0, rd will be 0 and this entire
block is skipped. Does this mean regs->epc is never advanced for loads to
these zero registers, resulting in an infinite trap loop and kernel lockup?

[ ... ]

> @@ -346,71 +330,76 @@ static int handle_scalar_misaligned_store(struct pt=
_regs *regs)
>  	if (get_insn(regs, epc, &insn))
>  		return -1;
> =20
> -	val.data_ulong =3D GET_RS2(insn, regs);
> -
> -	if ((insn & INSN_MASK_SW) =3D=3D INSN_MATCH_SW) {
> +	if (riscv_insn_is_sw(insn)) {
>  		len =3D 4;
> -#if defined(CONFIG_64BIT)
> -	} else if ((insn & INSN_MASK_SD) =3D=3D INSN_MATCH_SD) {
> +		rd =3D riscv_insn_sw_extract_xs2(insn);
> +	} else if (riscv_insn_is_sd(insn)) {
>  		len =3D 8;
> -#endif

[Severity: Critical]
Similar to the load case, on a 32-bit kernel, parsing sd sets len to 8
because the CONFIG_64BIT guard was removed. Later in this function,
val.data_ulong is populated (which is 4 bytes on 32-bit), but 8 bytes are
subsequently copied. Could this leak 4 bytes of uninitialized kernel stack
memory to userspace?

[ ... ]

> -	if (user_mode(regs)) {
> -		if (copy_to_user((u8 __user *)addr, &val, len))
> -			return -1;
> -	} else {
> -		memcpy((u8 *)addr, &val, len);
> +	if (rd) {
> +		if (!fp)
> +			val.data_ulong =3D *(unsigned long *)((unsigned long *)regs + rd);
> +		else if (len =3D=3D 8)
> +			val.data_u64 =3D get_f64_rs(rd, regs);
> +		else
> +			val.data_ulong =3D get_f32_rs(rd, regs);
> +
> +		if (user_mode(regs)) {
> +			if (copy_to_user((u8 __user *)addr, &val, len))
> +				return -1;
> +		} else {
> +			memcpy((u8 *)addr, &val, len);
> +		}
>  	}
> =20
>  	regs->epc =3D epc + INSN_LEN(insn);

[Severity: High]
By gating the memory copy operations inside the if (rd) check, doesn't this
silently drop stores where the source register is x0 or f0 instead of
actually writing to the misaligned address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-riscv_insn=
_table-v3-0-3f8e5f75ba97@gmail.com?part=3D8
