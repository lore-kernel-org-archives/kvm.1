Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6513BC68D
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077274; cv=none; b=tuLGKCMzEu1x/LMxwz/o9gYRQogdopdj/Iy30YPBTUNzuC4K/IrJY1OnPJRqInhqaAwzMqrF2afLTh2vtSedn7IMSSfXgZE98mhIl4Z5RdKRRMuUqpV2nptRAsZd7RkuR8lJmcWkS3ZCZS/SKf0SNuKIdY7Rv0wlF7y2iymTS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077274; c=relaxed/simple;
	bh=YStIaBUo6WMROFO+Oqx77ncT43loV/IUQ7rhgWlrMWQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gn+U+qDY7Tx1IS6/mjV2RcoF6DR4PwGmqtZmLB/T4QlPaLDIBAAnbgfwxehTN0yN0FOzS0P+B//iX7mYBM5Ro/C3mw5JCxavNgWWXHDY0RfG7wYOlcKQMqbGJMV4fqgrWGjIgEZBYeZWOOcLSE6Itm2UudOlhtU0N20mOufso0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ6+Yg5f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ6+Yg5f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469271F000C4;
	Thu, 15 Oct 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077272;
	bh=Xo98vaCrLP4H/rxC/mEtWE3KfpQRtZMknJyLknlY8BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJ6+Yg5fLD66+iprTFw/RXsNGBBi+vrwBVxsg/kEFzZLc+sK/8S2/5uDpRXu6jmOo
	 RhQZF/Ax0/RKdb5zdFwIdTwSpVKBAUxbUCAIG4ybNqCxXrvjw2blc360Fve6zNujSh
	 2t3TDtGIZ9e0MMkVXONZyGpIye6GONFB4m0YJcJyX62mbUK42gPHV8yL+6S6J6Zetz
	 HP/+YTXlP+uefuuwnAzQrQ4DHwHMDmob0+w+uKMH/Bbt8Fue4Pxky7El6ndLpJ7Q4u
	 1f/mmHMXXDnXrNBeLaGxw+CIhmpxcQT2A0k54Vz/xlajxMrsr4cDjH4K4ErzZsNdnt
	 vS6YiIKAYVyug==
Message-ID: <sashiko-outbox-173042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/20] ctlv: Prepare VA blob handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-10-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-10-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:14:31 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ctlv: infinite loop in ctlv_blob_context_finish() on task mismatch
--

commit f68d871d01d9258f8b2e576464f1c447eac3313e
Author: Jiri Pirko <jiri@resnulli.us>

ctlv: Prepare VA blob handling

Add task-bound VA blob resolution and CPU read/write access for CTLV
families. The blob object can be compile-checked individually.

> diff --git a/drivers/ctlv/blob.c b/drivers/ctlv/blob.c
> new file mode 100644
> index 0000000000000..2c93da62b2010
> --- /dev/null
> +++ b/drivers/ctlv/blob.c

[ ... ]

> +int ctlv_blob_context_finish(struct ctlv_op_ctx *ctx)
> +{
> +	ctx->blobs_live =3D false;
> +	if (WARN_ON_ONCE(!list_empty(&ctx->blobs)) && !ctx->blob_error)
> +		ctx->blob_error =3D -EINVAL;
> +	while (!list_empty(&ctx->blobs)) {
> +		struct ctlv_blob *blob =3D list_first_entry(&ctx->blobs, struct ctlv_b=
lob, entry);
> +
> +		ctlv_blob_put(blob);
> +	}
> +	return ctx->blob_error;
> +}

[Severity: High]
Does this loop risk a hard lockup if ctlv_blob_context_finish() runs from a
task context different from the submitter?

If the contexts do not match, ctlv_blob_put() evaluates
WARN_ON_ONCE(!ctlv_blob_same_task(blob)) and returns -EINVAL early, bypassi=
ng
the list_del(&blob->entry) cleanup:

drivers/ctlv/blob.c:ctlv_blob_put() {
    ...
	if (WARN_ON_ONCE(!ctlv_blob_same_task(blob)))
		return -EINVAL;
    ...
	if (blob->ctx) {
		list_del(&blob->entry);
		blob->ctx =3D NULL;
	}
    ...
}

Because the return value of ctlv_blob_put() is ignored in this loop and the
blob is never removed from the list, the list remains non-empty. This will
cause the loop to continuously pop the exact same blob and fail repeatedly,
resulting in an infinite loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D9
