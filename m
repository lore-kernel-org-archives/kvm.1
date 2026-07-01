Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD248BD26;
	Wed,  1 Jul 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912939; cv=none; b=GwcsJQusExiFwHXCrUjBavgd8A0Yj0H2mp9L9yDjvkU7k9cPi2yoyXPEnWsgm8Uh4b9Dp56vFKXSwbQrB+A/AxeJ2vXZub/YoMind97tX/6UQwatD3sH8gbhFTAZ3hCP8mwOo5E+zpQiFvXcJkgIw/NkgCBVYf4Hnzpi/euA70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912939; c=relaxed/simple;
	bh=oKA2/aIIdCx1Ob+N9y4UF6SYs35YBxPL3Bef+Olofuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bD8GV7p4uJvtfRzuSwKx1nMaR0V4yEfJsTq4VsIK9J12QhKj9KcpRLIHOAyOGwFU18zuyaCavHEY00Y7Te7oDgGCOdNIDmarsU8dJB36n0SuJxJS3re/kk2qlo1pB0V+hJylvCf1fpvPkQRzYXkUSwpMEewuGZVDkjqp2A6RicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eA8vzGeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eA8vzGeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480731F000E9;
	Wed,  1 Jul 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782912936;
	bh=OObo0zXZJwbEpskHy2AgbBJPVuIP4M++hFxwfUMrzmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eA8vzGeo4MPnFh2+R6PtIZlbLyFj+SGEnOw5PHWdoQsqduzwk9fEgyKaBpWK3agwR
	 QwGXs39ZI8no+D7JnvF4JwKwkcy5rUxRA0Uiq2OTgp4eEyKcJq4NlX4l7sb6ZkDEpc
	 awNJsORjTVnmqHRqiXfjcsWXp7uwrk/1ehGrepnowGzkLcm8ejY/aMNlxY4ZLKrNbY
	 iAtUnXTY8UxdQP1oH/cNMw7z0WCufQSOzUuESWQhCHn9oDTjZJ4LED6Cy37MBNEku0
	 jT6jUQ2oAoSC8Io+lqDVpQFzU4iI8qNtjJZMK7tOacAIKlyDCbW4l1asEcLlZZcdBZ
	 EInAJ9VuhRlYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] dt-bindings: riscv: Require block-size for
 Zicbom, Zicbop, and Zicboz
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guodong Xu" <docular.xu@gmail.com>
Cc: robh@kernel.org, kvm@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>
References: <20260701-rva23u64-hwprobe-v2-v5-0-2c61f94a695a@gmail.com>
 <20260701-rva23u64-hwprobe-v2-v5-8-2c61f94a695a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 13:35:35 +0000
Message-Id: <20260701133536.480731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] JSON schema 'if' blocks incorrectly match nodes missing the 'ris=
cv,isa-extensions' property, erroneously enforcing block-size requirements =
on legacy device trees.
--

commit 08f47eb689e1ffc05b399844b4f633278d53641f
Author: Guodong Xu <docular.xu@gmail.com>

dt-bindings: riscv: Require block-size for Zicbom, Zicbop, and Zicboz

This commit updates the RISC-V extensions schema to make block-size propert=
ies=20
mandatory for the Zicbom, Zicbop, and Zicboz extensions. The goal is to cat=
ch=20
missing properties during dtbs_check since these extensions do not have a=20
default cache block size.

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 5ffc40d599c02..f4dd34d446c02 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml

[ ... ]

> @@ -1142,6 +1142,32 @@ allOf:
>            not:
>              contains:
>                const: zilsd
> +  # All three Zicbo* extensions require their block size property as the=
re's no
> +  # default.
> +  - if:
> +      properties:
> +        riscv,isa-extensions:
> +          contains:
> +            const: zicbom
> +    then:
> +      required:
> +        - riscv,cbom-block-size

[Severity: Medium]
Does this JSON schema 'if' block inadvertently evaluate to true for nodes
missing the 'riscv,isa-extensions' property entirely?

In JSON schema validation, the 'properties' keyword only applies constraints
to properties that are actually present in the instance. If a device tree
node lacks 'riscv,isa-extensions' (such as legacy nodes using only the
deprecated 'riscv,isa' property), this 'if' condition will vacuously succee=
d.

Will this erroneously enforce the 'riscv,cbom-block-size' requirement on
all those legacy nodes during dtbs_check?=20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-rva23u64-h=
wprobe-v2-v5-0-2c61f94a695a@gmail.com?part=3D8
