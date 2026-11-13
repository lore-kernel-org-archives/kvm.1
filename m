Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586950;
	b=xpZTF+1rLDH0chNFWQr0g1Cnn8cd74nOpoche4X75WEk7s+uoNdmaNyYu5E7GLaEd19w
	 A2D5LRJsMrUnXCDqeBmMk/MJ7Ii0PgP0biMldTWI7Zh9qb0BE6t/HTCedTlfrHsuAkxfp
	 9XeBqTd+xeh4rNNe4T7pFGSgqs4xkReViHpGuUmp3hEPlMtp86rWY4YYP2XKTVYyuCnv6
	 R8AOBjRvO0WImL0vFy0ptwcClelmIHdhwuJt/Ow5BuLcxoCnaxXqa2OdgPZAismVulbLS
	 fJPCSOYa7268fwPNJ11gV6YegMXTn9kMJEdaRIE5b7775/Pu4I616OnAjlrsLUQrDUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586950;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3UQ5GYLn1pJD/3r94JG1h8rIur+nSQTIdcQYmn5W3J8=;
	b=4lUDbVg65G13zvaCSuDEfQVpiW7R+/tNqqT7CrDXqOEZkSWS5u3nfF0ZoHFWdnoI+qAB
	 HqAaeNUk/RpUfBrGgHZtur/GpjmihHuetKpIR9rYLSDllEJ7uAoSgkzrzPf3wgyYm/GGM
	 ZFkcQppnjDtIH/aIacsN6W+e/MtTRitCKCSiuBmRzBWwwUE+Zx3Qt/io2/lXEyaFybrGy
	 pcaqdjHF4m4eCklv6lO0peHkUKeMAmFX21BKZaTxgUh1EdEq2P3jHbNF1XGGxxFiEIBY4
	 3PrBpIz+gABn3xbbZVtsgF5u5FRWmhGLk1WkxP18Qlfrr8DUMh12/hIz8jJgK21p0iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouQGaU0M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C373606B5F6
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ouQGaU0M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60DD1F000C4;
	Fri, 13 Nov 2026 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794586950;
	bh=3UQ5GYLn1pJD/3r94JG1h8rIur+nSQTIdcQYmn5W3J8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ouQGaU0MENqSsHSALEkNFZQnBd8elOU0mK1TxKIbmwcR/JEdPFSZ7dviN6P3b6CAn
	 Y4PMA4BgnfRCyVI4ZvI25UpmJg0xg6VEjqjvXB3TFyceCztMwMxn+7B3auNyXASlaO
	 bv0KA/OOrQRW6J1PNYAZdHWOLsjT0dFxYZKUDMhRmyuOFVB4azoYUHagqVc1+pD9/7
	 6OpJCOKkHnU1RU2c238kqv/0UJAaXDczmkQ6NOJo4HMa5uf61FiJ04iaYo3bwbm1pA
	 vxmOBvI/29vWqvXBiPHe+NrmxSDFmTtT/9h5fDDEDJt4sMBkozIL1GUjTQYLPrqV1h
	 wVZuO/Th4iMBg==
Message-ID: <sashiko-outbox-213187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 07/15] ctlv: Prepare schema validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-8-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-8-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:22:29 +0000
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
- [Medium] ctlv: ctlv_schema_min_len() enforces record depth limit on
  leaf nodes
--

commit f7e5c872905b61fc69a0da34a919232ff36227be
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare schema validation

This commit adds generated-schema walking, message validation, and request
indexing for CTLV schemas.

> diff --git a/lib/ctlv/schema.c b/lib/ctlv/schema.c
> new file mode 100644
> index 0000000000000..8ff3c7c5b5fe0
> --- /dev/null
> +++ b/lib/ctlv/schema.c
> @@ -0,0 +1,1092 @@
[ ... ]
> +/* Buffer length that the largest indivisible leaf and its records need.=
 */
> +static u64 ctlv_schema_min_len(struct ctlv_schema_length_walk *walk,
> +			       const struct ctlv_schema_tree *tree, u32 index, u32 above, u32=
 depth)
> +{
> +	const struct ctlv_node_schema *node =3D &tree->node_schemas[index];
> +	bool has_children =3D false;
> +	u64 deepest =3D 0;
> +	u32 i;
> +
> +	if (depth > CTLV_MAX_DECLARED_RECORD_DEPTH) {
> +		walk->bad =3D true;
> +		return 0;
> +	}
> +
> +	for (i =3D 0; i < node->children_count; i++) {
> +		u32 child =3D node->first_child + i;
> +
> +		has_children =3D true;
> +		deepest =3D max(deepest,
> +			      ctlv_schema_min_len(walk, tree, child,
> +						  above + sizeof(struct ctlv_hdr), depth + 1));
> +	}
> +
> +	for (i =3D 0; i < tree->ext_schemas_count; i++) {
> +		const struct ctlv_ext_schema *ext_schema =3D &tree->ext_schemas[i];
> +		const struct ctlv_ext_fill_schema *fill_schema;
> +		const struct ctlv_node_schema *root;
> +		u32 member;
> +
> +		if (ext_schema->node !=3D index)
> +			continue;
> +		fill_schema =3D
> +			ctlv_schema_fill(walk->family, ext_schema->family_id, ext_schema->ext=
_id);
> +		if (!fill_schema)
> +			continue;
> +		root =3D &fill_schema->members.node_schemas[0];
> +		for (member =3D 0; member < root->children_count; member++) {
> +			has_children =3D true;
> +			deepest =3D max(deepest, ctlv_schema_min_len(walk, &fill_schema->memb=
ers,
> +								   root->first_child + member,
> +								   above + sizeof(struct ctlv_hdr),
> +								   depth + 1));
> +		}
> +	}
> +
> +	if (has_children)
> +		return deepest;
> +	/* An empty root is a message of its own header alone. */
> +	if (!index)
> +		return above + sizeof(struct ctlv_hdr);
> +	return above + ALIGN(ctlv_schema_tlv_max_len(walk, tree, index, depth),=
 CTLV_ALIGNTO);
> +}

[Severity: Medium]
Does ctlv_schema_min_len() reject valid leaf fields inside a record at
CTLV_MAX_DECLARED_RECORD_DEPTH?

Unlike ctlv_schema_children_max_len(), which is only entered for
CTLV_SCHEMA_RECORD nodes, ctlv_schema_min_len() recurses into every child
and extension fill member with depth + 1 and checks depth >
CTLV_MAX_DECLARED_RECORD_DEPTH at entry for all nodes.  When a non-reenteri=
ng
query reply has a record at depth CTLV_MAX_DECLARED_RECORD_DEPTH (7), its
leaf children are visited at depth 8, setting walk->bad =3D true and causing
ctlv_schema_op_sizes() to fail with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D7
