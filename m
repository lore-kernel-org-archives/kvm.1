Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263FB421A0E;
	Wed,  1 Jul 2026 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913373; cv=none; b=gzlgHtdDOyWFloQM6blTxHoMwFHo+Aq80HKPPTXHUuhD560B9nHMC3LK+9I8jl5bD5hOLFW0Ui3z+OEHguRWR/GGb8vmDV2zAZmO7zRnpvNx8uN9cSWA7gO+4ozQofb+iDWlGV3sQf2IFlWlzodkJbvtVk7ervQfiu1d6G03JX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913373; c=relaxed/simple;
	bh=GipxAxlVMsHMPhHqxvirJUkROLqDoELl5JFCnjLvny0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mNFds6ekh5LBdqna12uKNmO570TTum0b9Kw7YCMZR0nF1v/SZB7gUbeAQo/n1a1ebU8z2+gnLWKGMc8GMJ9Bu2zW5XW1sPjugI8CxaDL33BHiMCDoaUL2L4TttpU8DXwdMJyAv6QUBCGFrRsQKpiirGITJfJXd6ij7HNlW1Tq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXM9n0vp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXM9n0vp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360BE1F000E9;
	Wed,  1 Jul 2026 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913371;
	bh=ZTrk6NIX6cIrrvJMfv610b713SBOYCfMAwD0W4Fhs40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cXM9n0vpR1WmmpfrVIlmDQMZ8r5OnmGHpN5QLhlnSEeramVsr1JeDs8tXZuEIcvgI
	 jQbooRAmjEN1LVKzDqr0W0UHMa1DmJo/FC4YAxcSZ7OUGDB6fg8Ny1ahfLZdyypqAT
	 vLeNycZ+5nysaPEsuhSakywiyUuo8jqWIeE88TCaJphwCDujW91YDQfgBA063Feu3v
	 qai5Limx67o+HWWq7QzjNzhpnj6Fk+gDM4SQ5Sxx6pmPnS6Qdik0bpLiqwZu1W8YQ2
	 6WGOxnPrFSzGMl5DxkJDr8ki1U7DeUVfdS/B3bL9f/FONEw+tEdeFUx/1RsVKZr221
	 MH2LGN8oDt07A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] dt-bindings: riscv: Add Zic64b extension
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: robh@kernel.org, kvm@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-9-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-9-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:42:50 +0000
Message-Id: <20260701134251.360BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete schema validation for Zic64b cache block sizes. The s=
chema correctly constrains the CMO-specific block sizes (riscv,cbom-block-s=
ize, etc.) to 64 bytes when the zic64b extension is present, but fails to c=
onstrain the standard CPU cache block size properties (d-cache-block-size, =
d-cache-line-size, i-cache-block-size, i-cache-line-size).
--

commit 31237d196ec63ec596da17f48f8410b2eee95c15
Author: Guodong Xu <docular.xu@gmail.com>

dt-bindings: riscv: Add Zic64b extension description

Zic64b mandates that cache blocks are 64 bytes in size and naturally
aligned in the address space. It is a mandatory extension of both the
RVA22 (U64/S64) and RVA23 (U64/S64) profiles, ratified with RISC-V
Profiles Version 1.0.

Document it so it can be described in the riscv,isa-extensions property,
alongside the related Zicbom/Zicbop/Zicboz cache-block extensions. Since
Zic64b fixes the cache block size at 64 bytes, also add a schema check
requiring any present cbom/cbop/cboz block size to be 64.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index f4dd34d446c02..bbd442cfbd904 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml

[ ... ]

> @@ -1142,6 +1148,20 @@ allOf:
>            not:
>              contains:
>                const: zilsd
> +  # Zic64b mandates 64-byte naturally aligned cache blocks
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zic64b
> +    then:
> +      properties:
> +        riscv,cbom-block-size:
> +          const: 64
> +        riscv,cbop-block-size:
> +          const: 64
> +        riscv,cboz-block-size:
> +          const: 64

[Severity: Medium]
Should the standard CPU cache properties like d-cache-block-size,
d-cache-line-size, i-cache-block-size, and i-cache-line-size also be
constrained to 64 here?

>    # All three Zicbo* extensions require their block size property as the=
re's no
>    # default.
>    - if:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D9
