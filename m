Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CB49DBB6
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076774; cv=none; b=amn6D4EQwyBWw2qzasmvHaJg9FosilNx6JP8gEK/2hlNnzvVGaX/S9Jt7VdIOBfO8U9UPcbrTxouWLPQPVk8FkaxDfenhYLRdbIAbl03hr2L9tPnTDqDUY/gJ5rwR2Ek7Q+GTMevp6RaqaoaSH7yPq6ADPhfYkdHZRrlA2+M7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076774; c=relaxed/simple;
	bh=LFmuohjWHYIX5AJbT47R04S8G91bBf3hQBMsE7CCbVs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=n93lR31Y1oP7QkqiL7snDJmmxzy5yzdW90VirAx5s0Ck52ZhBsYNiIF/3acMBSNoROVX4IOyfsG5L85ghweAn6PyNEGdz5LmrCZr/fnPfREp+5TJSIDy52kglYG4+epYWsDoqddP0BH95StFxmyPvnKLQECH/uY0ujod3iZ6ss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Buao3YY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Buao3YY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951B61F000C4;
	Thu, 15 Oct 2026 15:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076772;
	bh=Af5yHoEjM5XX02Lq5e3UsZErocWPsUEWBnk2TY3cUbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Buao3YY9mVCzy00WhI9in06Q7/AZege3Jimwv160NEKv81QTYAbdrYcBwxHhLUy2j
	 yJX3M2jgyZStclRxqfRkJ66HCa1+Sqfyp5Lx9DHX2Y31Oqqdx4lGsf1XqGRDyxgMb/
	 HkM80XQ2ooEQNg3xAMoOigbYVlPyGwBfNW/IEWuTEMdwJcWy1dSc7iviJGkapDqLsD
	 64rqp4Waqlw6UtmQWZ+i5WRKSj/iya8czfIyG1XG6fNoAfhX05HOmn1MypSuUDem8f
	 cvs1MSVA8HYaGZFf33caBSWWl6A2ws+Emezwix8KeqpH4gt9j47xylLrS4uMuV8m4C
	 +eDc57/sd+G7g==
Message-ID: <sashiko-outbox-173035@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/20] ctlv: Prepare message input handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-6-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-6-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:06:12 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ctlv: infinite loop in ctlv_attr_next on out-of-bounds error path
--

commit 5ae11d979c8fbb4e21430610d57f8866b9d74025
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare message input handling
   =20
This commit introduces wire walking, request indexing, and validated input
accessors for CTLV generated family readers. It keeps CONFIG_CTLV unwired
until module dispatch is complete.

> diff --git a/drivers/ctlv/message.c b/drivers/ctlv/message.c
> new file mode 100644
> index 0000000000000..7e5742ba8f708
> --- /dev/null
> +++ b/drivers/ctlv/message.c

[ ... ]

> +void ctlv_attr_next(struct ctlv_cursor *cursor)
> +{
> +	const struct ctlv_message_input_slot *slot;
> +	const struct ctlv_message_input_scope *scope;
> +	const struct ctlv_node_schema *node;
> +	const struct ctlv_attr *next;
> +	u32 next_nest;
> +	u32 next_offset;
> +
> +	slot =3D ctlv_message_cursor_index(cursor);
> +	if (!slot || WARN_ON_ONCE(!cursor->attr))
> +		return;
> +	next =3D (const void *)((const u8 *)cursor->attr +
> +			      ALIGN((size_t)cursor->attr->len, CTLV_ALIGNTO));
> +	next_offset =3D ctlv_message_offset(cursor->msg, next);
> +	if (next_offset =3D=3D slot->end_offset) {
> +		cursor->attr =3D NULL;
> +		cursor->index_nest_scope =3D CTLV_MESSAGE_INPUT_INDEX_NONE;
> +		return;
> +	}
> +	if (WARN_ON_ONCE(next_offset > slot->end_offset))
> +		return;

[Severity: High]
Does this error path fail to invalidate the cursor, leading to an
inescapable infinite loop during attribute iteration?

In ctlv_attr_next(), if the computed next_offset exceeds slot->end_offset,
the function triggers a WARN_ON_ONCE and returns early. Because it returns
without clearing cursor->attr (unlike the successful termination path which
explicitly sets it to NULL), the cursor's state remains exactly as it was.

When using iterator macros like CTLV_IN_FOR_EACH, the loop continues as long
as ctlv_attr_ok() returns true. Since the cursor state is unmodified, it
evaluates as valid, causing the loop to re-process the exact same state and
hit the error path again, resulting in a hard CPU lockup.

Should the error path explicitly set cursor->attr =3D NULL before returning
to safely terminate the iteration?

> +	cursor->attr =3D next;
> +	node =3D &cursor->tree->node_schemas[cursor->node];
> +	if (node->kind =3D=3D CTLV_SCHEMA_NEST) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D5
