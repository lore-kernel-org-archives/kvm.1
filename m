Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565413546F7;
	Tue,  2 Jun 2026 23:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780442941; cv=none; b=ZUZzIwyMP8cEKZHf9PAz6eLvM2LZeJs28d/SLF1pHDiWq2FWl2ETUn1I5rQ3wIyJFO0m5rZC1RyLCDla+wJYNS58trQ/bwb3o8rBbj3jOo/wQu8Zv3f6b6o4YbjHOGTzZslPeqVnnZkBA8fwGWQhvH6VYK8pw4zxZhBX+vGnwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780442941; c=relaxed/simple;
	bh=HPCgznwU0BnZa1k47ivud+DyztT8h3edZuOSK4t1230=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cFWYzsd9Mw8E8dRtYWBOEK8mrOTautaHrGcAYPD6TMAdffP43hLH1kJNvny9UGSJvNE4KMjKAxHu9es3bF0U/Av669raxUq+HFCPLcT4yFxzq5bhoRj3rm150VlTGcBNNDVxNTyyxKj7TDbtdSZ68JSLqG+Vzo/nNI/RsPBGabc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k33/sOon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k33/sOon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494A1F00893;
	Tue,  2 Jun 2026 23:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780442940;
	bh=/gEklwQWl+3IXwwljYsrsa2dGe6IptnquNobDsEXTkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k33/sOon1+5WenMtWdLHdBcfVfp4uKGLIrGQCXRsJrYzAMQznHbj8EmTOMarGhhqB
	 y5IMf5uB/SNC1EwTb1DGf/70v3Ptg8U1I1hkYIm8lFapBZJ2jvuV8QXskFP/yz8MMV
	 Z1+KxkX6zhK6jp/aUpJimelM+/dUOevWc77vXL/nbPhLeGjToV8plPdudrq0Fbzl5W
	 7viJhcTDJfkCCQ34Sbnz8zKof4WLjHDXEqmneHsfGGqByXxt0mr2FyHVarQhHXcj8j
	 D/OTxgqrV3rZpBTeP3YS/mijnUW7VhAeYOPxecHVi+L26gxTog+7ZmZFmbxxevzEvo
	 IRSfjpVbif6iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/15] dt-bindings: riscv: Add Zic64b extension
 description
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: devicetree@vger.kernel.org, kvm@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260603-rva23u64-hwprobe-v2-v3-7-5529a7b28384@gmail.com>
References: <20260603-rva23u64-hwprobe-v2-v3-7-5529a7b28384@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 23:28:58 +0000
Message-Id: <20260602232859.3494A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new `zic64b` extension is inserted out of alphabetical order, v=
iolating the explicit sorting rule defined in the file. The file requires m=
ulti-letter standard extensions to be sorted alphanumerically (see the comm=
ent `# multi-letter extensions, sorted alphanumerically`). Alphabetically, =
`zic64b` should be placed before `ziccamoa` (since '6' comes before 'c' in =
ASCII). However, the patch inserts it between `zkt` and `zicbom`. While it =
is correctly sorted relative to `zicbom` ('6' < 'b'), it propagates the pre=
-existing error of the cache-block extensions being incorrectly placed afte=
r the `Zk*` extensions, resulting in `zic64b` being placed at the wrong glo=
bal alphanumeric position.
--

commit a825e53560db8497b83c2f594f48fa677434d00f
Author: Guodong Xu <docular.xu@gmail.com>

dt-bindings: riscv: Add Zic64b extension description

This commit adds the Zic64b extension to the RISC-V ISA extensions binding.
It defines the description for the extension and updates the schema to
enforce a block size of 64 for cbom, cbop, and cboz when Zic64b is present.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 2b0a8a93bb214..ec1c9473d4256 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -590,6 +590,12 @@ properties:
>              in version 1.0 of RISC-V Cryptography Extensions Volume I
>              specification.
> =20
> +        - const: zic64b
> +          description:
> +            The standard Zic64b extension for 64-byte naturally aligned =
cache
> +            blocks, as ratified in RISC-V Profiles Version 1.0, with com=
mit
> +            b1d806605f87 ("Updated to ratified state.")

[Severity: Low]
This isn't a bug, but should this new entry be placed higher up in the list?

The properties block requires multi-letter extensions to be sorted
alphanumerically. Because '6' comes before 'c', would it be more accurate to
place zic64b before ziccamoa?

Does it make sense to place zic64b in its strictly correct alphanumeric
position, rather than continuing the out-of-order grouping of the existing
cache-block extensions like zicbom?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-rva23u64-h=
wprobe-v2-v3-0-5529a7b28384@gmail.com?part=3D7
