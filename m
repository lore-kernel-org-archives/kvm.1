Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AE3DE424
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792078844; cv=none; b=Uh5kZMpmKkQwWaYH34781eyDXcxu/WGiYHIQcyOu9wxruyVUnuSRRaPnpOYq9zfwYWQb0rD7oBTbe39VJuuwrx2gNjNUFfPl0F69DVb4DBIWVZahZJ6pOobJtz1MsHWyS7HgcwAhJX6DlYeSPTyqmF+ArgyVwOk/OQTdm2fZvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792078844; c=relaxed/simple;
	bh=OTgGfS3ufLrDzU+S5/2Uf6eeBixPGijMKpAM8pLqXZY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fBfhcQ8TsZf+roO+vUnkuZ9R4oGyVFyzMPQYx4HzbPJX7r47dbkkp90Xo3GBWeoVq054ZvWaFI2yVbbsvwMbulgWXv4jE1hnkcK6ba9ToWAlYLqSjlcMgTyWrtRBVzYlNlnXOoXxwIsTTIkbTxgzVbqPlvd5fEwW97jWJaaRZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqSHhRJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqSHhRJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5161F000C4;
	Thu, 15 Oct 2026 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792078826;
	bh=LSx+NvnKiXdD/fOr4OT5jw8TlfqyPls/ihDS65ngUlM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqSHhRJdniz07RCudoN/Afj/Bmdafa4qylJk335+J+VCEFLefEn4vPx/dGOkyEqrH
	 GTOZsZJQP4UW+30wF4Rnr/jWm+7flfKq4YbmHqS134DlbuYRCAujD0kC6SS56fIj+a
	 3T46/VU9GDqAkVZobK//iA8QAXxDKFnKV/Tyarwe19FgA8xm/Xa8kjfRPSWZuP1ZDz
	 FFLVH7Mk8kycnc1hX15MWUsK/Byke6UHS2sJ5nL0IKPm6gfUnD/0TzrHmODvgLaVv4
	 wz5wdPxC+Ke/LwbrGprgFGTzFC3QO7Da3Pr/D83/pLH9gXlA0r5bcXQdytMJBia/8U
	 AoPRN0PVSWbMw==
Message-ID: <sashiko-outbox-173084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261015145053.3664509-21-jiri@resnulli.us>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-21-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:40:26 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mm: memory accounting bypass via missing __GFP_ACCOUNT in attest=
ation_tdx_evidence_get
--

commit 70d54896a73342be7665edff009c1c4b80f13008
Author: Jiri Pirko <jiri@nvidia.com>

attestation: Add the TDX family implementation

This commit connects the attestation family to the native TDX service. It
exposes TDREPORT, Quote, MRTD, and RTMR operations while preserving the
existing native interfaces.

> diff --git a/drivers/attestation/providers/tdx.c b/drivers/attestation/pr=
oviders/tdx.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/attestation/providers/tdx.c

[ ... ]

> +static int
> +attestation_tdx_evidence_get(struct attestation *att,
> +			     const struct attestation_evidence_request *request,
> +			     struct attestation_evidence_result *result)
> +{
> +	const struct attestation_evidence_object_request *object;
> +	struct attestation_tdx *tdx =3D ctlv_priv_child(att);
> +	size_t length;
> +	void *buffer;
> +	int ret;
> +
> +	if (request->objects_count !=3D 1)
> +		return -EOPNOTSUPP;
> +	object =3D &request->objects[0];
> +	buffer =3D kvmalloc(object->supported_object->max_length, GFP_KERNEL);

[Severity: Medium]
Does this allocation need the __GFP_ACCOUNT flag?

The buffer size for a TDX Quote can be up to TDX_GUEST_QUOTE_MAX_LEN
(approximately 128KB). This operation proceeds to call
tdx->ops->quote_get(), which acquires the global quote_lock mutex in the
tdx-guest driver.

If userspace issues concurrent quote requests, tasks will block on this
mutex while holding these large, unaccounted buffers. Can this allow a
container to accumulate a significant amount of kernel memory that bypasses
memcg limits, potentially leading to host out-of-memory conditions?

> +	if (!buffer)
> +		return -ENOMEM;
> +	if (object->supported_object =3D=3D &attestation_tdx_evidence_objects[0=
])
> +		ret =3D tdx->ops->report_get(tdx->parent_dev,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015145053.3664=
509-1-jiri@resnulli.us?part=3D20
