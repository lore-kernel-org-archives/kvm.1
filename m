Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFD47CA78
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077279; cv=none; b=fH6GSz2thZPGwXoFNxAIi+m2anWslF0gwXyJROWxDXo1gWE2b/MazC/0+JQwadnaUimcvC1v4AOPS5OTVUz6jR3Z4L90o5xRtXgYiYMXkYIQH7noaBWz4PLYq0ZJEqDrf+MuQW1U4DpBto7Re8AZOB4+PrmOFrCbs1P0/y4fR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077279; c=relaxed/simple;
	bh=GtHr5FR7shhcfV39TAbaIKlhkeyYJSmGMKYd9l6U2qE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QZo1ycWnPSNFP8lDQj+qIDRW253yby4DIiQbn3SqDtd+O3h52W5BfMCfIFGQ4Bwe4/b6XnIQbp6w1RVaJq0jqUiWIeM7qB1Z+y+/MuZMSkUtM8PviO/LA3w3dHUH6I2fhnmHXg9cfbd3dnQcjlzkno3Hg6hjcopUpiWslUzgCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFSAxN95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFSAxN95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB7F1F000C4;
	Thu, 15 Oct 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077278;
	bh=mvmrhqWGNI8EbrI5dyASdn2OMoH1C8oOlJnSSBvqLq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JFSAxN95z2wogGWxvRkBQByBRR/kzYp8JkNzy5cgcrE0fWsiPF1ptji9tZVz6c0V4
	 mdMJWf0dE3Gp6jT163OkoB34drpTdaY57jk1tM3UY/YLOgdoq/ecEO9XaTSCCVrUS5
	 T0VrHUuOcqSoziQoUMOsUUV4OgK/pstfidvAfWRKpnO1si8WAx+07DbWl/sOIry5Tv
	 gUBlSV0XpptoOdGf9/8KmcRhlZ132Zogxetd2sojtGVVZT9mW2aYn17RzCkBUX65bC
	 urJjVe91zIWqREUpfOvYab+DP/XlST1Bp9AvjsL3KReJQ5sqKkXZ02+pWnwQazVl4j
	 bz2KcV17qBrnQ==
Message-ID: <sashiko-outbox-173043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/20] ctlv: Prepare schema validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-8-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-8-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:14:37 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] ctlv: schema traversal ignores stub fills in reentering calculat=
ions
--

commit c53ad2ae9e8a16f911d52d764c978f30d89b6d14
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare schema validation

Add generated-schema walking, message validation and request indexing.
Use the descriptor layer for blob placement checks. Keep CONFIG_CTLV unwired
until dispatch completes the module.

> diff --git a/drivers/ctlv/schema.c b/drivers/ctlv/schema.c
> new file mode 100644
> index 0000000000000..b74f9a358bc34
> --- /dev/null
> +++ b/drivers/ctlv/schema.c

[ ... ]

> +/* Size one deepest legal leaf and every nest above it. */
> +static u64 ctlv_schema_reentering_min_len(struct ctlv_schema_length_walk=
 *walk,
> +					  const struct ctlv_schema_tree *tree)
> +{
> +	u64 leaf =3D 0;
> +	u32 index;
> +
> +	for (index =3D 1; index < tree->node_schemas_count; index++) {
> +		if (tree->node_schemas[index].kind =3D=3D CTLV_SCHEMA_NEST)
> +			continue;
> +		leaf =3D max(leaf,
> +			   ALIGN(ctlv_schema_attr_max_len(walk, tree, index, 0), CTLV_ALIGNTO=
));
> +	}

[Severity: Medium]
Does this calculation miss injected stub schemas? It iterates only over
tree->node_schemas_count, completely ignoring tree->stub_schemas.

This seems like it could miss any large leaves injected by stub fills,
underestimating the query reply buffer size (query_reply_min_len) and
potentially leading to message truncation in userspace.

> +	return (CTLV_MAX_NEST_DEPTH + 1) * sizeof(struct ctlv_attr) + leaf;
> +}
> +
> +static bool ctlv_schema_tree_reenters(const struct ctlv_schema_tree *tre=
e)
> +{
> +	u32 index;
> +
> +	for (index =3D 0; index < tree->node_schemas_count; index++)
> +		if (tree->node_schemas[index].reenters)
> +			return true;

[Severity: Medium]
Will this loop return false when reentering nodes are present only inside s=
tub
fills? Because it only checks tree->node_schemas_count, it might cause
ctlv_schema_op_sizes() to incorrectly fall back to ctlv_schema_min_len().

If that fallback occurs, ctlv_schema_min_len() would recursively descend in=
to
the reentering stub fill until its depth exceeds CTLV_MAX_DECLARED_NEST_DEP=
TH.
At that point, walk->bad becomes true and valid schemas could be incorrectly
rejected with -EINVAL.

> +	return false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D7
