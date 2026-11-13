Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587361;
	b=wdohTpe30hfhdS4mNCfZdDk/KGrOezFVp+f747z1HYP21tpWcV3n9mNYgL93oI/i78JE
	 MV74qpSxQuDwjKNGVFtF3IkIau28qyjJNV3yB+y/NEsavUBkroRHVfhY4jd5hdG5GO8WR
	 BbZgq9rH99VbRJ8+W1VBiEmhs4w0O0R+buzCkGrcl/UC8YTNLysJRsygm3tj1Tp+zfX6k
	 pHxiStfuwCOmooQf1f8kudiGALwNVIzvBhfGZVUxhzgMNz3QlmJKiqb3OclVmvAUyWtuv
	 3f0zl2+/p8KbXZQ7rtaeGivWfQNJr/zBzDa90Arc7tn/qeblgCaxr+R/cxr0/J8mcQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=twk10zSL0lVU6qT+kkjUftM7b3g7fDF7BFDcGNkkq2I=;
	b=Hqg5E85c/ZJQ9lqFPoaye2Oe8/wE1X2Zhzc996mozZPHu7il9Y0bGbFJ64QCIaMvLPdp
	 pkYDMDLplMYe+qHqCdLe23YeF9Eky62fE0wxDrlLmvuqvG00uMGWWyp4UAGlayLSHXJfK
	 Ed+nb6+ASrTv6c1Oo7m72FVXxZq8sU/2/dR6QfqENtFJVnkL6H+YyorbR/ChTaEpd+tgJ
	 +1dxlLi2TivVwe150sJRx3fOwIBeQ5yMLkNpmDGkkpyZb3YzZUJDjXqbpTwYasSpLpwhi
	 jMaZ0zNb5aW9bJhWtqLw7/x4mDsEyzyFn+dIJDS8jc3W7k+LMu9AL8MBxwPqm+bfs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SozigEsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D147606A8A5
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SozigEsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47BB1F000C4;
	Fri, 13 Nov 2026 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587361;
	bh=twk10zSL0lVU6qT+kkjUftM7b3g7fDF7BFDcGNkkq2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SozigEsLaadFW6RXseX1VfSUYKln7Uj0RJ+ea1YFOdmSUL9n1PI+qRy3FWHjeZhyT
	 9Ahi7pdKOfivr/yMsj6BbgP3KrhFHXlTicrZRzEVmZlEbZYpAXCeLXj4euJmRe8xEK
	 n7i7EDg5wCk2PALtVCTD6D3AlMOCbz0sNAtmj2hpS5DTdFNwWUfaO0/ZX8bkDMyAiC
	 ZcjDy/htCF1xvGuqSPtpxcaO67e2GC3y4jZAqJ6pft8xF9x8b1KVefLwr3cYQGNneU
	 vRiqAtSAyy9RTDbRxAkFXCCLBI5Mig1SCLWsu2fSEVJdV1uwCUy0oHpgg7XTRxkvLU
	 L4td8+9J9dKOQ==
Message-ID: <sashiko-outbox-213196@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 11/15] ctlv: Add operation dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113155515.2510194-12-jiri@resnulli.us>
References: <20261113155515.2510194-1-jiri@resnulli.us>
 <20261113155515.2510194-12-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:29:20 +0000
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
- [Medium] ctlv: broken request rebinding and WARN_ON_ONCE in
  ctlv_ext_fill()
- [Low] ctlv: unclaimed ancestor families and bad log in ctlv_init()
--

commit d099e8b67fe7bf2eb3f3e45b3042be1ff1f88e98
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Add operation dispatch

This commit adds CTLV family resolution, instance registration, file
operations, and ioctl operation dispatch.

> diff --git a/lib/ctlv/core.c b/lib/ctlv/core.c
> new file mode 100644
> index 0000000000000..605f191de77ba
> --- /dev/null
> +++ b/lib/ctlv/core.c

[ ... ]

> +/**
> + * ctlv_ext_fill - Delegate an extension-point output record.
> + * @ctx: operation context
> + * @request: validated request root
> + * @record: output record selected by the generated helper
> + *
> + * Return: filling callback result, or 0 for an unfilled point.
> + */
> +int ctlv_ext_fill(struct ctlv_op_ctx *ctx, const struct ctlv_cursor *req=
uest,
> +		  struct ctlv_cursor *record)
> +{
> +	const struct ctlv_schema_tree *tree;
> +	u32 index;
> +
> +	if (WARN_ON_ONCE(!record->tree))
> +		return -EINVAL;
> +	tree =3D record->tree;
> +
> +	for (index =3D 0; index < tree->ext_schemas_count; index++) {
> +		const struct ctlv_ext_schema *ext_schema =3D &tree->ext_schemas[index];
> +		const struct ctlv_cursor *filled_request =3D request;
> +		const struct ctlv_ext_fill_schema *fill_schema;
> +		const struct ctlv_ext_ops *ext_ops;
> +		struct ctlv_cursor filled;
> +		int ret;
> +
> +		if (ext_schema->node !=3D record->node)
> +			continue;
> +		ext_ops =3D ctlv_ext_ops_find(ctx->ctlv, ext_schema);
> +		if (!ext_ops || !ext_ops->fill)
> +			continue;
> +
> +		if (request) {
> +			fill_schema =3D ctlv_schema_fill(ctx->family, ext_schema->family_id,
> +						       ext_schema->ext_id);
> +			if (WARN_ON_ONCE(!fill_schema))
> +				return -EINVAL;
> +			filled =3D *request;
> +			if (ctlv_message_input_rebind(&filled, &fill_schema->members, 0))
> +				filled_request =3D &filled;
> +			else
> +				filled_request =3D NULL;
> +		}

[Severity: Medium]
Can ctlv_ext_fill() trigger WARN_ON_ONCE(!record->hdr) in
ctlv_message_input_rebind() when userspace omits an optional request
extension record?

When a parent operation looks up the request extension-point record with
its generated helper and the optional record was omitted in the request
message, ctlv_input_field() sets request->hdr =3D NULL.  Passing that cursor
to ctlv_ext_fill() enters the if (request) branch and passes filled.hdr =3D=
=3D
NULL to ctlv_message_input_rebind():

lib/ctlv/message.c:ctlv_message_input_rebind() {
	if (WARN_ON_ONCE(!record->hdr || !record->msg || !record->msg->index))
		return false;
    ...
}

Also, the kernel-doc above says @request is the validated request root,
whereas extension fill scopes are attached to the child extension record
rather than index->records[0], so passing the request root cursor always
fails to rebind and sets filled_request =3D NULL.  Should ctlv_ext_fill()
check ctlv_cursor_ok(request) (setting filled_request =3D NULL when absent)
and document @request as the matching request extension record?

[ ... ]

> +int ctlv_init(struct ctlv *ctlv, struct device *dev,
> +	      const struct ctlv_family *family, const struct ctlv_hooks *hooks)
> +{
> +	int ret;
> +
> +	/* Nothing in common means no pair, not half of one. */
> +	if (!dev || !family || (hooks && (!hooks->pre || !hooks->post)))
> +		return -EINVAL;
> +
> +	ctlv->dev =3D dev;
> +	ctlv->hooks =3D hooks;
> +	init_rwsem(&ctlv->registration_lock);
> +	spin_lock_init(&ctlv->transition_lock);
> +
> +	/* Before anything reads the schema through this instance. */
> +	ret =3D ctlv_op_resolution_init(ctlv, family);
> +	if (ret)
> +		return ret;
> +
> +	/* Before a subsystem announces a device that could not be. */
> +	ret =3D ctlv_uevent_check(family);
> +	if (ret)
> +		return ret;
> +
> +	if (ctlv->dynamic_ops_count) {
> +		ctlv->disabled =3D bitmap_zalloc(ctlv->dynamic_ops_count, GFP_KERNEL);
> +		if (!ctlv->disabled)
> +			return -ENOMEM;
> +	}
> +
> +	ret =3D ctlv_family_claim_add(family->schema);
> +	if (ret)
> +		return ret;
> +	ctlv->family =3D family;
> +	return 0;
> +}

[Severity: Low]
Does ctlv_init() leave intermediate ancestor families unclaimed in
ctlv_family_claims?

ctlv_init() only calls ctlv_family_claim_add(family->schema) on the leaf
family, so base families that are only inherited and never instantiated on
their own are not recorded in ctlv_family_claims, allowing conflicting
ancestor names or family_ids across chains.

In addition, when ctlv_family_claim_add() hits a name collision with a
different family_id (same_name && !same_id), its pr_err() reports that
schema->family_id belongs to claim->name instead of claim->family_id.
Finally, ctlv_family_chain_check() and ctlv_family_descriptor_check() do
not check that child->schema->name[len + 1] is non-NUL after '-' or that
strlen(schema->name) fits the 63-byte limit of
CTLV_T_FAMILY_GET_FAMILIES_NAME before CTLV_OP_FAMILY_GET hits a runtime
WARN_ON_ONCE in ctlv_put_string().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113155515.2510=
194-1-jiri@resnulli.us?part=3D11
