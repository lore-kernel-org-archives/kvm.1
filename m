Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586769;
	b=dR2A5Ud3ypzZWtXi86/57cYXi0sOVu5IelxN3igwxKtciSfD2pF087GMoR13668RQN35
	 pGx0VvpX7xNNukLIqWOIzQ928ifo3BcnmTz2kqNtfuvea6pUtDmkQEonH/CWmwbYHYz9T
	 h+1FoO/sBUnQIZ5SCnF2KJPj/F/vAYjHyFmhJ4a7SxMuaRAiZnoAsa69TNa/9LUw07Db4
	 hwVYijx5YhlLPxoFjXle/wgOPlFZPhgQVjJZUSuJldQWWehz7FdzknuNPxfTp/FJbvk/o
	 SRK9xf8J3Bbb1xKAJmwjs57HiVET/cocnuf63d6C3wWRyL1DnTcZjlN3WLXF8EXKEwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rzK8W79BHC93qD7facL7scxF4UzXbJGCDrST1Xy3FnI=;
	b=ehKnJwHYHVUMJXvGAtmCsMNDHEDS5jG22GSEwT4ZeRhgVIdPZKo58yNn3N/7TqpLJs1G
	 bdcLbXG8K8CLQeIkn/qoAwXOmWdF6QWiZ0LABGXhhct/X4zxcUHcebn6ESU69rmPBddg/
	 iD4rE6+4kEkpwaXYU3Bu9+1icZqTuj9H+VMwf+UMOSFNc1kUtvu7mqucOL6JMnnulY1Hn
	 jV6LEoHNsS0xkspGU+qXNf3Pm5Zwqimic5aBUtkxY5q3b+H2ZRaYdmeJwB7DeAfp+7OVI
	 Aav8sNF+ncDvrTcduNzdQHYVWLwvhoXVrpHu9EjR5GnRHxNL0yrK514yjCYV5s8VswQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWNqOIX9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629EA606C573
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWNqOIX9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D945D1F000C4;
	Fri, 13 Nov 2026 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586769;
	bh=rzK8W79BHC93qD7facL7scxF4UzXbJGCDrST1Xy3FnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWNqOIX9KQqZdSBgoI7huhXpZgMcg5FcTkS3slwq+Ki8FdmO08/YTupTl1aKv//1z
	 qU3iw3/zsiU7qNheaDcCJoL944WzHrHEOne1fVPLhIIjSJZS2veAKTw9yFFhfI3fB4
	 b1UWxXUZM5F1KZowlo5ddkrGb2Mirny+3XlwCvROWKQuhXZDeC8LYNRNRIJW/3oZxi
	 eZ2ut+kJ1BVh5s8UPL5sMZW9xZaWIVvV6wwACaolu31NlTYePypwJp/cgQq7ULdVJL
	 Dpd9EYcdGY5YTfy03+mj/RwQQLJInamGgGCYC7xhgC7ABfUX6AtGvgtcRXAkfJLOaG
	 KaJi47DyvE+gw==
Message-ID: <sashiko-outbox-213184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 15/15] tools/ctlv: Add ctlvctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-16-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-16-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:19:28 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] Documentation: ctlv: driver-api guide drops sections and cites
  missing tests
- [Low] tools/ctlv: uncleaned libctlv build artifacts in ctlv_clean
  target
--

commit 44c8b60bf07b7ca2b82f88cb4a596bb865f2b940
Author: Jiri Pirko <jiri@resnulli.us>

tools/ctlv: Add ctlvctl

This commit adds the ctlvctl command-line client for discovering and
querying CTLV devices, along with runtime manifest and RST documentation
generators in ctlvgen.

> diff --git a/Documentation/driver-api/ctlv.rst b/Documentation/driver-api=
/ctlv.rst
> index f6a4f9632e3a5..e8e6ecdf6ab66 100644
> --- a/Documentation/driver-api/ctlv.rst
> +++ b/Documentation/driver-api/ctlv.rst
[ ... ]
> @@ -684,20 +687,24 @@ The node is of the foo driver's own class, ``foo_cl=
ass``, registered as
>  that ``ctlv_family_inherits()`` says is not ``ctlv-example`` or a descen=
dant,
>  then calls ``ctlv_init()``.
> =20
> -Reporting an error
> -------------------
> +Tests and examples
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``Documentation/ctlv/specs/ctlv-test.yaml``
> +    Every schema kind, records, actions, queries, blobs, availability, h=
ooks,
> +    and an extension point.
> +
> +``drivers/ctlv/tests/ctlv_test.c``
> +    The ``ctlv-test`` family implementation.
> =20
> -A callback returns a negative errno, and that is what the ioctl returns.=
 Where
> -CTLV itself refuses a message it also writes error information into the
> -caller's reply buffer, naming the reason and the offset of the offending
> -TLV. A family implementation does not build that; it adds its own errno
> -and its reply.
> +``drivers/ctlv/tests/ctlv_test_child.c``
> +    A separately built inheriting family and extension-point fill.
> =20
> -Configuration
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``lib/ctlv/tests/*_kunit.c``
> +    Unit tests of the engine and of its nodes.
> =20
> -``CONFIG_CTLV``
> -    CTLV. A family implementation selects it.
> +``tools/testing/selftests/ctlv/``
> +    Raw-message, generated-binding, allocation-failure, and mutation sel=
ftests.
> =20
>  Kernel API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[Severity: Low]
Were the "Reporting an error" and "Configuration" sections added in
commit "Documentation: ctlv: Describe how to write a family" dropped here
by mistake?  Also, none of the five test paths listed under "Tests and
examples" exist in the tree at this commit.

[ ... ]

> diff --git a/tools/Makefile b/tools/Makefile
> index cb40961a740f7..d8d0003b16a5f 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
[ ... ]
> @@ -179,6 +183,9 @@ acpi_clean:
>  cpupower_clean:
>  	$(call descend,power/cpupower,clean)
> =20
> +ctlv_clean:
> +	$(call descend,ctlv/ctlvctl,clean)
> +
[ ... ]
> diff --git a/tools/ctlv/ctlvctl/Makefile b/tools/ctlv/ctlvctl/Makefile
> new file mode 100644
> index 0000000000000..dcfca390d4024
> --- /dev/null
> +++ b/tools/ctlv/ctlvctl/Makefile
[ ... ]
> +$(LIB): FORCE
> +	$(if $(LIBCTLV_OUTPUT),$(Q)mkdir -p $(LIBCTLV_OUTPUT))
> +	$(Q)$(MAKE) -C $(LIBDIR) OUTPUT=3D$(LIBCTLV_OUTPUT)
> +
> +clean:
> +	rm -f $(OUTPUT)ctlvctl $(OBJS) $(MANIFESTS)
> +	$(if $(LIBCTLV_OUTPUT),rm -rf $(LIBCTLV_OUTPUT))

[Severity: Low]
Does the clean target leave libctlv build artifacts behind when building in
tree without O=3D?  When OUTPUT and LIBCTLV_OUTPUT are empty, $(LIB) builds
objects and libctlv.a inside tools/ctlv/libctlv/, but neither ctlv_clean in
tools/Makefile nor clean in tools/ctlv/ctlvctl/Makefile cleans $(LIBDIR).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D15
