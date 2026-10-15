Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F98524AE6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076341; cv=none; b=NSfYJSeuNicVYwBcByUDJFRHWsd2GAdpOwNG+u9qV1XynVs13S5atFUtEnvDmxksgqNLoSYeoShJLzearWrW1IvuZjln4CRdFFhI64UN9AO+UnMTsdoTTiq3Oyzgd44ga6U5Z0xhK7yeiALrToXG6H24hasxFqpp8VRn2LDOFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076341; c=relaxed/simple;
	bh=DmvhX+cBUVA09kmZlLKviWT95wygZX2yDbQVrYIw1gY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dLv3CipGD3ztC1sThJVPdQvoe8SPHekGRpHQb7YRYHKPegWWUe2Y8Y1Vh5IxcpTvFNb9T34Tu/OfYvVIBnoUBnbY0NqQkpaZ+YuFn64+wynXqRZ5hOBTX0qNWOdtFZcqnA84QIwBS3AlEqntkGbU8rEv4/HzWuySPDxdmbPzKVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixtvNY1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixtvNY1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB331F000C4;
	Thu, 15 Oct 2026 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076340;
	bh=XzDpy+1ETM8QHU5MO6e7NQ+yPEeKkb1oO+LpECmjGWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ixtvNY1OmVFdAmgGaVbcVAhaXsf5IpRHBbaxKJeLCFZesWbT0S1O9gbu1jH02iJ5F
	 3ExpTSdylZBOqx6GR96DwjtoqwIlNASu7SiX84CU4I1Htrm77p/bWw4ZkPGWKoouUv
	 ih0Apfsp5WRNFcu8YKYkbNyr0zGJFeAogE5VjoRfPn3Qx1RZ95YgVltIlo3vXMGoes
	 YRXcF2TgV5Webxzm8B/z6EXI+BxqRzzV3lWcfNaYEllnIQYnM7Ad+Fat0BfFZmubd6
	 J3SiKko3zA9eEQcffKOtW0bh1v+Yxb7BlX4P2zB9rHl7huEN2zvLMHrVmqkgOnjZ1F
	 fy5H/0NkcyGlA==
Message-ID: <sashiko-outbox-173015@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/20] ctlv: Add the schema language and generator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-2-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-2-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:58:59 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] ctlvgen: ABI compatibility checker incorrectly flags widening to=
 unlimited as an error
- [Low] ctlvgen: missing validation for --mode uapi --source causes KeyError
--

commit dbbe210aabdf036fa0f92c7b8932bca4fd127ce7
Author: Jiri Pirko <jiri@nvidia.com>

ctlv: Add the schema language and generator

Define the YAML schema and append-only family registry. Add ctlvgen to
validate specifications and emit kernel and UAPI outputs.

> diff --git a/tools/ctlv/ctlvgen/cli.py b/tools/ctlv/ctlvgen/cli.py
> new file mode 100755
> index 0000000000000..c6bfafeb28525
> --- /dev/null
> +++ b/tools/ctlv/ctlvgen/cli.py

[ ... ]

> @@ -0,0 +1,172 @@
[ ... ]
> +    kinds =3D (args.header, args.source)
> +    if args.mode and not any(kinds):
> +        parser.error('--mode needs --header or --source')
> +    if any(kinds) and not args.mode:
> +        parser.error('--header and --source need --mode')

[Severity: Low]
Should the command-line parsing prevent the combination of --mode uapi
and --source here?

Right now, this combination passes validation, but the GENERATORS dictionary
only maps ('uapi', 'header'). If a user provides --mode uapi --source, it
will cause an unhandled KeyError later in _generate() when looking up the
output renderer.

> +    if args.schema_only and args.mode !=3D 'kernel':
> +        parser.error('--schema-only needs --mode kernel')

[ ... ]

> +    if args.mode =3D=3D 'kernel':
> +        renderer =3D (gen_kernel.render_header if args.header
> +                    else gen_kernel.render_source)
> +        text =3D renderer(family, family_api=3Dnot args.schema_only)
> +    else:
> +        text =3D GENERATORS[(args.mode, kind)](family)

[ ... ]

> diff --git a/tools/ctlv/ctlvgen/lib/compat.py b/tools/ctlv/ctlvgen/lib/co=
mpat.py
> new file mode 100644
> index 0000000000000..4cf93af06ea90
> --- /dev/null
> +++ b/tools/ctlv/ctlvgen/lib/compat.py

[ ... ]

> @@ -0,0 +1,821 @@
[ ... ]
> +def _compare_occurrences(problems, where, was, now):
> +    old_max =3D was['max-occurrences']
> +    new_max =3D now['max-occurrences']
> +    if old_max =3D=3D new_max:
> +        return
> +    if old_max =3D=3D spec.UNLIMITED or new_max < old_max:

[Severity: Medium]
Will this incorrectly flag a compatible widening as an ABI break?

Because spec.UNLIMITED is represented as 0, widening max-occurrences
from a finite value like 10 to unlimited means new_max is 0 and
old_max is 10. The condition new_max < old_max evaluates to true
(0 < 10), misidentifying the widened bound as a narrowed bound.

Does this check need to specifically ignore comparisons where new_max
is spec.UNLIMITED?

> +        problems.append(f'{where}: max-occurrences was narrowed from '
> +                        f'{_occurrences(old_max)} to {_occurrences(new_m=
ax)}')
> +
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D1
