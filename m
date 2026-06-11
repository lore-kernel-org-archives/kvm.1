Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391B366570;
	Thu, 11 Jun 2026 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209964; cv=none; b=BlsQlCB1R/F752hSmWu3aM/6fl82m55Vz31xtBX4TZ3yYBcY7g4wPdewx9BVHU3Gfxks/KSzUk5d/3yf+FAwPdg4mPBY4Rsk+604lJMbZCJdZEXl1U8s0PK/1YR+Dj1vPiOYD6cZd1EHxlj2SKrPZ6H8ppmdj5Q5Awzhg+F1JQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209964; c=relaxed/simple;
	bh=J9vpJVNBoEDM8hq1yQvknsbkO8Gt5ANO+GRGOUxjVoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=keqf46Rmx8RJuwopmIXhaY13wI09tSW7bFigew6qMCOMzA7vUGxFdUCBDMBoKKTpUT0jbOXciYRtpwleDZXEkzs4Zy9mZTWhcWBGypukxHj17NOt0X4uEQuONt2HErfeyaAEjvwD/L8JkTUkmwJ0EDXWUhHdR9/9fV78gxL+FT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0jkA0L9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0jkA0L9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AF41F000E9;
	Thu, 11 Jun 2026 20:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781209963;
	bh=nnFCs/LAZMeVmfUe/41iQ53dc7VDUqMg3oAcehTfwxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m0jkA0L9loDkfSC4KPkmP0YYCmogg5E1c9lBcV6u3kiwcqtGCLKloPlIBb8xkf5pL
	 N0jRerjGZqz8T3R9U/ORGptF+bOZIj++t97NQNmoj0wNOnCgWxxS5aYZ0iixoeY9Nl
	 L3JyFrHE6WKjHhN0SRyiCQObqjUCaz1eiNoN/1sJGVVcKnsbfAoXGFAGvS5DB8RQ8U
	 fz2WPWDh6ILBW9N7hA6Yvc6uk/w7LuWyZ8gHBRSpyYCSx87PV+z6jBstEfWC5GIH/G
	 RbPLbblSpb0dSvS89l/YzTlIVu3Fp9C/BvAZL/2xzJOrow7AI7PHgqx5pbMvo7jlUV
	 kEgmL4OMAlp7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/16] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: conor+dt@kernel.org, kvm@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260611-rva23u64-hwprobe-v2-v4-14-3f01a2449488@gmail.com>
References: <20260611-rva23u64-hwprobe-v2-v4-14-3f01a2449488@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 20:32:42 +0000
Message-Id: <20260611203242.D1AF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Profile detection incorrectly relies on monolithic superset bits (=
A, C, B) instead of granular component extensions, bypassing RVA23U64 on co=
mpliant hardware.
--

commit 1bae4d63d125b54f3683da372331e97613bffe86
Author: Guodong Xu <docular.xu@gmail.com>

riscv: cpufeature: Introduce ISA bases bitmap and rva23u64 detection

This commit introduces a per-hart and host-wide bitmap for conformant ISA
profile bases, such as IMA and RVA23U64. It computes this at initialization
time by evaluating the resolved ISA bitmap against required extension sets.
This provides a cached profile state for subsequent consumers like hwprobe.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -1322,3 +1325,90 @@ void __init_or_module riscv_cpufeature_patch_func(=
struct alt_entry *begin,
> +/*
> + * Compute the set of profile bases (IMA, RVA23U64, ...) a hart
> + * conforms to, given its resolved ISA bitmap.
> + *
> + * If @isa_bitmap is NULL, the host ISA bitmap (the AND across all harts=
) is
> + * used.
> + */
> +static void riscv_set_isa_bases(unsigned long *bases, const unsigned lon=
g *isa_bitmap)
> +{
> +	const unsigned long *isa =3D isa_bitmap ? isa_bitmap : riscv_isa;
> +	DECLARE_BITMAP(ext_mask, RISCV_ISA_EXT_MAX) =3D { 0 };
> +
> +	/* IMA */
> +	__set_bit(RISCV_ISA_EXT_I, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_M, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_A, ext_mask);
> +
> +	if (!bitmap_subset(ext_mask, isa, RISCV_ISA_EXT_MAX))
> +		return;
> +
> +	set_bit(RISCV_ISA_BASE_IMA, bases);
> +
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

[Severity: High]
Does this logic correctly handle device trees that specify granular
extensions instead of monolithic supersets?

The kernel's riscv_resolve_isa() expands monolithic extensions into their
sub-extensions, but it does not synthesize monolithic extensions backwards
from their components.

If a compliant RVA23U64 platform specifies granular extensions like
zba, zbb, and zbs in its device tree rather than the legacy 'b' extension,
will this bitmap_subset() check fail because RISCV_ISA_EXT_B is not set?

This same pattern appears to affect the checks for A and C above as well.

> +	__set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-rva23u64-h=
wprobe-v2-v4-0-3f01a2449488@gmail.com?part=3D14
