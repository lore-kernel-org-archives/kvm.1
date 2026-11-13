Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587048;
	b=W9EyrMaE32GC5rxgEtJfhFZP7mr1lLe0cncmX/JeQJlCs88IshuMW2tUsKdBXR2hO3YO
	 Dq7pAwbh9SrFnEkfhYXyERQQLdZ8yZs89Ms1LafXIxoQ1Eb9umESwg9dBmZpiw7dyGlgh
	 Q/SwnWTrTAxC2rfkHlAs/SNfN/1SXE8Is/yi8vAoTEuCkRno1NBlxue7mlKWMGwYv1waV
	 XKsQ2WTOzg1tuFSMwjkG5Mmn9V6SeY6IHmYfiJQ3+Jxh3bfh9P5Coo+/mwCvPSHiFGB3Q
	 a04A5O8Kco8poonSEwjqs3t4Rnr3jA7x4UnSwizZwU8a820Npl422uxgpIWAapOJbyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gm4noH5u1kw7f03SqiSAwL1oRunBGvUdRmCIExG1ACQ=;
	b=nSET9tgYUjcCt0xcclb4Ex4YjRFrK8HDsSWCNPRgL+HNN+We4/HvbVvcmTAxM6UFKeQ7
	 6HOKUgQ9SiOjXQ+zyNEGWJzRmHfRBlfKIze2uAOgO7yjQCNNxQawQYBXfuPBJrzK6/bCY
	 5ZGcdN77GmEf1nepcDGStFFuR0a5iD8Pf78F1T3wCqlvmo0hYohG0AZ/FJJ0lPmh/iaYw
	 Ap2OoxUhZ2Eu1B3eRr2xdBv2SceltgQCQnbM63Czkf64HLy063a3uxIaa5aCvdtTgaNFr
	 c9aK8vNnPmzwvsRzS/aOxrPfe//bM12pCdBJ2ZvLi1t6CevFPlLlWTQxc/8NQbJ8tlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuu6+QG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB840606BABB
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etuu6+QG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0A81F000C4;
	Fri, 13 Nov 2026 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587047;
	bh=Gm4noH5u1kw7f03SqiSAwL1oRunBGvUdRmCIExG1ACQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etuu6+QG6VaRZ05Q4c8HMvzf2IJYg1LOc+SAx83FYasSKdOu6FLORKvyTeIARGVFS
	 2DSw1SdLDkArdhurV5CIk0LtFsGfYE+GgcsyvvRD0mJ35fH2h242TdZlQg3y0WHiEj
	 VJGdJ645Q69yR80TB8sxJujSFf3ZuE4gyiE2kBZcSUQJLd3FHQn4HFave9pmTfx4s2
	 6Ghmg2aFedDNinlaUG7p8Rj+Dbx0sc6W2tV2FKZ8YiuuKACGB5H0MIJKW+CC3ux5WP
	 BOfvLXgxJnuqWdvZMo+wDIN6+SxcolYp/szChrKVTk/CbBBk1vvfUub8iP3UprCNgd
	 a2YTwzzVDWrpA==
Message-ID: <sashiko-outbox-213191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 10/15] ctlv: Prepare runtime introspection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-11-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-11-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:24:07 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] ctlv: premature depth limit in ctlv_introspection_children()
  triggers WARN
--

commit 04c73a263bc43bc51c0a09b62604d548973da60c
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare runtime introspection

This commit adds runtime introspection handlers for registered families,
effective operations, and message schemas through the CTLV root family, and
introduces struct ctlv.

> diff --git a/lib/ctlv/introspection.c b/lib/ctlv/introspection.c
> new file mode 100644
> index 0000000000000..d030debe69e3c
> --- /dev/null
> +++ b/lib/ctlv/introspection.c

[ ... ]

> +/* The members of a fill inherit the optionality of its extension point.=
 */
> +static bool ctlv_introspection_children(struct ctlv_introspection_walk *=
walk, u32 depth,
> +					const struct ctlv_schema_tree *tree, u32 index,
> +					bool force_optional)
> +{
> +	const struct ctlv_node_schema *node =3D &tree->node_schemas[index];
> +	u32 i;
> +
> +	if (WARN_ON_ONCE(depth + 1 >=3D CTLV_MAX_RECORD_DEPTH)) {
> +		/* Deeper than a specification may declare, so unreachable. */
> +		walk->error =3D -EINVAL;
> +		return false;
> +	}

[ ... ]

> +/* One node, into the record that stands for it. */
> +static bool ctlv_introspection_node(struct ctlv_introspection_walk *walk=
, u32 depth,
> +				    const struct ctlv_schema_tree *tree, u32 index)
> +{
> +	const struct ctlv_node_schema *node =3D &tree->node_schemas[index];
> +	u32 reenters =3D 0;
> +
> +	if (node->reenters) {
> +		reenters =3D ctlv_introspection_reenters(walk, depth, tree, node);
> +		if (!reenters)
> +			return false;
> +	}
> +	if (!ctlv_introspection_node_fields(walk, depth, node, reenters))
> +		return false;
> +	/*
> +	 * A node that re-enters a level says so instead of listing that level's
> +	 * members again, which is what makes unbounded depth describable.
> +	 */
> +	if (!node->reenters && !ctlv_introspection_children(walk, depth, tree, =
index, false))
> +		return false;
> +	if (walk->frames[depth].open)
> +		ctlv_record_end(&walk->frames[depth].record);
> +	return true;
> +}

[ ... ]

> +int ctlv_op_schema_get_query(struct ctlv *ctlv, struct ctlv_op_ctx *ctx,
> +			     const struct ctlv_cursor *request, struct ctlv_cursor *reply)
> +{

[ ... ]

> +	/*
> +	 * One frame per level the reply may reach, too many for the stack: a
> +	 * description is one level deeper than the message it describes.
> +	 */
> +	struct ctlv_introspection_frame *frames __free(kfree) =3D
> +		kcalloc(CTLV_MAX_RECORD_DEPTH, sizeof(*frames), GFP_KERNEL);

[Severity: Medium]
Can ctlv_op_schema_get_query() trigger WARN_ON_ONCE() in
ctlv_introspection_children() and fail with -EINVAL on valid schemas near
CTLV_MAX_DECLARED_RECORD_DEPTH?

ctlv_introspection_node() calls ctlv_introspection_children() on every
non-reentering node, including scalar leaves with no children or extension
points, and ctlv_introspection_children() checks depth + 1 >=3D
CTLV_MAX_RECORD_DEPTH (8) before checking whether the node has any children.
A leaf field inside 6 nested records sits at walk depth 7, so describing it
hits the WARN_ON_ONCE() and returns -EINVAL.

In addition, CTLV_MAX_DECLARED_RECORD_DEPTH (7) counts only record levels,
whereas op-schema-get wraps both the message root (walk->frames[0]) and the
leaf fields of the deepest record in CTLV_SCHEMA_RECORD nodes.  A message at
the maximum declared record depth of 7 needs walk depth 8 (9 record levels =
in
the reply), which exceeds both the kcalloc(CTLV_MAX_RECORD_DEPTH, ...)
allocation and the CTLV_MAX_RECORD_DEPTH limit in ctlv_record_start().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D10
