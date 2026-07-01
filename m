Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319112E718F;
	Wed,  1 Jul 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915752; cv=none; b=YD69aW2cP/Fuf9iAsGum+0K0CcgSBNDP4A+k+tXRqrF5MK5rOufE5EoeEcTwaPgswwxtpxfb+3pNtDDK77B35KtTm+P8cObs0DHY17eNClOi8Wlb5e+6kXtEAgpTcJDudOD9hFJBXqX0N/aAVKgBCBtSdHO2DYWo+HxrHvBcBaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915752; c=relaxed/simple;
	bh=pUVoqaf3yR2fGL7+sy119A3Wys2CCgPBVAfgLXlvIaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=siMAdIz3+300Y9fiL0UhB/oYvXqUiUR7L6J9jx3AMTfp8uvz8KukpD9J3AWL3NM6ekHcXfLY89lBSY2iPgSjuXQs5ww1ysj30QDn0+DB8wQFNTMqPuBVGX7yJFFITrzTSiGyxSwOChnHwZ31JZcfJ/e/gKdIouU91NmDKTVU8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miYv6y+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miYv6y+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A575F1F000E9;
	Wed,  1 Jul 2026 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782915750;
	bh=8yTJxssIaLikMoxDEWEoO3zvRFqHjgS1dpCIsoBmQcU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=miYv6y+AIqSQmaZkXYkguOvOnfelmb8XgnPxKZ9u2k7qLf5FPC5jYgCGOOIEEYJtr
	 5laughCl8tLmcuisVr2bj8aUJW06Dv8A82GsF4JNNdz/SkCbuUY+dM0bki8q93/hNw
	 fp+Lq0XDY7Fz+P71WR/WTugT25cHrgKft/sXMVKGNhgvXy0BJjAnn+trBByYWId8Qe
	 8Z4ioVf5DuRHLv4NjP81g9XOgHJftdzGyTYSsg2OIqtV0EicRpFXlfR0gbSmH9tBMq
	 vI5BiLSdVkY129fTuiZcqrgWekCboVbOzyv7bw5PpBdNpbD9t0L5SmEG0WeO+Qqt1D
	 7xILLYxKgHbnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: kvm@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-15-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-15-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 14:22:29 +0000
Message-Id: <20260701142230.A575F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The RVA23U64 base detection wrongly mandates the legacy broad `B=
` extension superset instead of its required bitmanip constituent extension=
s (`Zba`, `Zbb`, `Zbs`).
--

commit e73d8757f0ce7270b4b39989368d4e83e5a355fc
Author: Guodong Xu <docular.xu@gmail.com>

riscv: cpufeature: Introduce ISA bases bitmap and rva23u64 detection

This commit introduces a per-hart and host-wide bitmap of conformant ISA
profile bases, such as IMA and RVA23U64. The bitmap is computed during
init by riscv_init_isa_bases() and registered as a subsys_initcall.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 4c3bf813af052..fa8471aef42ee 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -1304,3 +1307,90 @@ void __init_or_module riscv_cpufeature_patch_func(=
struct alt_entry *begin,
>  	}
>  }
>  #endif

[ ... ]

> +	/* RVA23U64 */
> +
> +	/* Supm with PMLEN=3D7 */
> +	if (!riscv_have_user_pmlen(7))
> +		return;
> +
> +	__set_bit(RISCV_ISA_EXT_F, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_D, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_C, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_B, ext_mask);

[Severity: Medium]
Does this incorrectly mandate the legacy broad B extension for RVA23U64?

If a RISC-V device tree advertises the RVA23U64 constituent bitmanip
extensions (e.g., zba, zbb, zbs) but omits the legacy unratified 'b'
string, it appears this check will fail because RISCV_ISA_EXT_B won't be
synthesized. Should this instead check for the individual constituent
extensions required by the profile?

> +	__set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_ZICNTR, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_ZIHPM, ext_mask);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D15
