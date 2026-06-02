Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CDE3537F9;
	Tue,  2 Jun 2026 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443472; cv=none; b=Im3jbKRSEncMkNREUUunpQTTd2o6Stj6H0xKSZyYhBY0V1N/d09N/B2UmGkRJhHFbwpSgGtztMjejtykI9OzQQNmhRbIA1fgOZbpal/YEgOz7nlAQ6wx5PxZuDArYumpTkzVsjml3GbC0HNFFORt3xsPOb1sGz1AeGZT36adiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443472; c=relaxed/simple;
	bh=FvLyoq8L3waDZsYWmLWNd0lmEIBP62d7OL4V29mipeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RFS+kzj3QwrAr3aZjmEMIxTv5YLXX1/ykL/LD/3vZinIa/HEsfX1/mhkMQnuVOzCB0ATQVmSMVwxRPM+ToKQp0AV21vcm0Oxd/9yrqfh/tS3/jqaC9McBXAhfvFdYiFf5NLJv2YUti7zjwwWy4WVzQzBwjGcrfa4jow+VnGrZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqVSkcKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqVSkcKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03631F00893;
	Tue,  2 Jun 2026 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780443471;
	bh=cFRAo9OvZOwKDqI7rDC8lSG0HdrudwWmKTk9EgSkbFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqVSkcKIP8T6hcTIcaSV4zCedKWmYMmvFkRq3s8hjo7eO23md4PJ9a231bLfVZg+M
	 XBAOon1TZNo+48OgxyNeDZkFYZBmZv5NLi/YiVZcQqBCZOQe9joqCf7xEe9ClLp6Dm
	 cER9tWT0ln1JGTRFFX5eGQVqI4Z/OeaalWRSWNA75o5yGkWWUna66IZNJuhaYbr2Ly
	 /Wz+OaulT6Zs3INzdilr6RBjSt68GovDGY2grjYzgscKzJq7I94BfDHNcSVI+ynrO0
	 HdWiVI74a4z55S9ISa3xaMSgRuSugbAOfD7TI2Xcrx5NCC2P/1gWYf6MLdromK10HE
	 K4m613RwFGc6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/15] riscv: cpufeature: Introduce ISA bases bitmap
 and rva23u64 detection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, kvm@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-13-5529a7b28384@gmail.com>
References: <20260603-rva23u64-hwprobe-v2-v3-13-5529a7b28384@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:37:50 +0000
Message-Id: <20260602233750.B03631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Detection of the RVA23U64 profile fails on compliant platforms b=
ecause it strictly requires the unratified `RISCV_ISA_EXT_B` bundle instead=
 of the formally ratified bitmanip extensions (`Zba`, `Zbb`, `Zbs`).
--

commit 6676802d36b9823a1e8e9c6f39247c2722210748
Author: Guodong Xu <docular.xu@gmail.com>
riscv: cpufeature: Introduce ISA bases bitmap and rva23u64 detection

This commit introduces a per-hart and host-wide bitmap of conformant ISA
profile bases, computed at init time. It also registers the initialization
as a subsys_initcall to ensure prerequisite user pmlen checks are complete
before evaluating RVA23U64 conformity.

> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 79ff431768139..15b708da98a1c 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c

[ ... ]

> @@ -1321,3 +1324,90 @@ void __init_or_module riscv_cpufeature_patch_func(=
struct alt_entry *begin,
> +static void riscv_set_isa_bases(unsigned long *bases, const unsigned lon=
g *isa_bitmap)
> +{

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
Will this cause RVA23U64 detection to fail on compliant hardware?

The RVA23U64 profile mandates the Zba, Zbb, and Zbs extensions.
However, the single-letter B extension was never formally ratified, so
compliant device trees typically advertise the individual bitmanip
extensions (zba, zbb, zbs) instead of the umbrella b bundle.

Since riscv_resolve_isa() does not perform reverse mapping to synthesize
the RISCV_ISA_EXT_B bit when its subsets are present, the subsequent
bitmap_subset() check in riscv_set_isa_bases() will fail. This would
prevent the kernel from detecting and exposing the RVA23U64 base profile.

Should this require the individual Zba, Zbb, and Zbs extensions instead
of RISCV_ISA_EXT_B?

> +	__set_bit(RISCV_ISA_EXT_ZICSR, ext_mask);
> +	__set_bit(RISCV_ISA_EXT_ZICNTR, ext_mask);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u64-h=
wprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D13
