Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB03AE1AD
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781263327; cv=none; b=Ts78PTjBihuXH4V73HnqA65SGvnwCv3Mx64dkBUvbe5O5iCl/J3uC407gGKPgbifdHwK0qe6GxcdxKPVhlumDdi8dL9oaMrY7jenOpO5g1KoqX+5SPuFUFVScChXJiqXwqNgDmhEjR90rcMZw9MGMchJG3+2a72lrb4qOWZN1gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781263327; c=relaxed/simple;
	bh=BHr/RcOc4A2zmWFr7wcJ0bJFFMgkE48BymLlutE9218=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pT5tM5aRxzhbFrNGoUFHHlZzwboTS2P2vFfbiIxButgfqg811bFCFe/BLaLYOWFtmUwrpOOI7ss88FBdP+sKyfwQ4NJxYZKgsgPvIl/fObGrQrT4Ko6DBcXeAdXo5g792hdaDy1LUplftOX42eeTVRIeIZI7NDyFedZ5xxImq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQr666Yf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQr666Yf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E011F000E9;
	Fri, 12 Jun 2026 11:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781263322;
	bh=K+IJO987KygZoe/avA2ASyZqyuphBXWgxOo/hQ2PSfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nQr666YfvncSNCEe7xd2t41NpFLq73loKeAEtZWldbKodtGjTQX1tTMEk9G9HHJNB
	 DQQNbekwOAYnWKuEqjd9HKzYJjKQYif8PtdFKddzhfPVCq6dTX1ZC6Uy2Rve8+oUVQ
	 H1gzcWrRDlXNTcyu7AjSBpveXrX+ZMMd4kS1z56dI+t7breroiKKFlnBuJc6e9BZMp
	 ODV3DcOvRQD/+99nC6EFriv2aEXBRtyibse0aP8Z8HT9t8YpZkJfzuKtiAgVEHPUGF
	 QiRBEzRaDAc0/g+leBODnNiURJNtOFF1FumNcdLwVp7yeR0vhgrOrLYwtfThKGbg64
	 /z+bqjoK4ywZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virt: tdx-guest: Allocate Quote buffer dynamically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Fang" <peter.fang@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612110853.3188196-3-peter.fang@intel.com>
References: <20260612110853.3188196-3-peter.fang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 11:22:02 +0000
Message-Id: <20260612112202.82E011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unbounded host-provided quote size causes guest kernel warning (an=
d potential panic) during allocation.
--

commit 918e9fdc48e5a03b41dab3a999be1a3f631327c1
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>

virt: tdx-guest: Allocate Quote buffer dynamically

This commit modifies the TDX attestation driver to allocate the Quote
buffer dynamically based on the size reported by the TDX module. It falls
back to a default 128 KB buffer if the reported size is unavailable,
supporting larger quotes needed for newer schemes.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
[ ... ]
> @@ -223,19 +223,43 @@ static void free_quote_buf(void *buf)
>  	free_pages_exact(buf, len);
>  }
> =20
> -static void *alloc_quote_buf(void)
> +static size_t get_quote_buf_size(void)
>  {
> -	size_t len =3D PAGE_ALIGN(GET_QUOTE_BUF_SIZE);
> -	unsigned int count =3D len >> PAGE_SHIFT;
> +	size_t buf_sz =3D GET_QUOTE_DEFAULT_BUF_SIZE;
> +	u32 quote_sz;
> +
> +	quote_sz =3D tdx_get_max_quote_size();
> +
> +	if (quote_sz)
> +		/* Reported size does not include GetQuote header */
> +		buf_sz =3D TDX_QUOTE_BUF_LEN(quote_sz);
> +
> +	return PAGE_ALIGN(buf_sz);
> +}
> +
> +static void *alloc_quote_buf(size_t *buflen)
> +{
> +	unsigned int count;
> +	size_t len;
>  	void *addr;
> =20
> +	len =3D get_quote_buf_size();
> +
> +	/*
> +	 * This fails if the requested size exceeds the buddy allocator's
> +	 * maximum order (order-10, 4MB).
> +	 */
>  	addr =3D alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);

[Severity: High]
If the host provides an excessively large quote_sz, could this allocation
trigger a kernel warning?

The comments indicate the buddy allocator will fail requests exceeding
its maximum order. However, passing an unbounded, host-controlled size
directly to alloc_pages_exact() without __GFP_NOWARN will trigger a
WARN_ON_ONCE_GFP in the page allocator's slow path before failing.

If a host is malicious or misconfigured, could this be used to spam the
guest's kernel log or cause a denial-of-service crash if the guest runs
with panic_on_warn=3D1?

Would it be better to explicitly check the size against a reasonable upper
bound or include the __GFP_NOWARN flag here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612110853.3188=
196-1-peter.fang@intel.com?part=3D2
