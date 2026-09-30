Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA54A68BD
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765403; cv=none; b=j9xhHb46luuJGugEbha5/t1sqrIdv2BaPoBRisBX/G7zYA3m07/TqKdTL+BPBeD66NTfXZBOqQPAlSpncC0EvGgyPc+83Mc6rHUmad2Zr/iY54fyPVXX5m8gimuJyaTg09gNd3di2Cl/3taMW0xjLJbT4nJtKQnXjYlYKSdop7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765403; c=relaxed/simple;
	bh=m6JcXjyahDpZej89q20WSX8k7qDgmK2fVdEWO1lx6wE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gNZ0NMcGH2hxUTXAuMik6l1gIUyvFgpW2HtnEri3i7PC/hEvKM0mjnTfRNWSYONasiaDDCC5RAFU2JpeFTZuMi3E/4tsvNTSiCBK8kq+y9XBzQH24DkehpJ+xC3Qxn/kEnUulOLfX/vpTnVc7fCn1799uYxzxSwWcK+NsK4UQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5vu4ISX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5vu4ISX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8677A1F00893;
	Wed, 30 Sep 2026 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790765389;
	bh=i7Uokrr+vdn/xt7z0hy2y/z44WJV/YgtccTCJI+47mY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5vu4ISX9rKWPC1JwWJBROgkgg2zHpbA2hRg97YUYsVFmtGzdDGOz03q4PJ6Vd+TP
	 wk3RkGeS+Madr/KoxCh6FWMC9bU36oDroLqC25IPxM7jtr8ozjqW/QXxbWpPCaYV+X
	 O3uQPzp1pIY8s/vLfxkItqtXgO/4nve5lNABIxUoFDr2NKV+NOC5ZrqyyPAiaxPhwH
	 mY7BCMPM+Z8t7M1i65bqnCarMrDwnOgRcyhmFUQJEX9XvtgXNKzsu+QyuqVKLh1uv/
	 KrvCo5UT9ZJpOivkKi75Dm6dfqLW8RFoZ+BPSR2G81KeO9u+qVWD8t2Y19QeqkFV8Y
	 kM4payfBNx/eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] virt: tdx-guest: Make the Quote buffer size
 dynamic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Fang" <peter.fang@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260930103739.2851980-7-peter.fang@intel.com>
References: <20260930103739.2851980-1-peter.fang@intel.com>
 <20260930103739.2851980-7-peter.fang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:49:49 +0000
Message-Id: <20260930104949.8677A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virt: tdx-guest: TOCTOU on get_quote_buf_size() causes out-of-boun=
ds write
--

commit a253845d90de2f6b044b740072f71a9700cd147c
Author: Peter Fang <peter.fang@intel.com>

virt: tdx-guest: Make the Quote buffer size dynamic

This commit updates the TDX guest driver to dynamically size the Quote buff=
er
based on the TDX module's reported limits, supporting larger certificates l=
ike
PQC. It falls back to a default 128KB size if the module does not report a
limit.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index 0cf078f09a73b..11d741da3b35f 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c

[ ... ]

> @@ -209,7 +209,20 @@ static long tdx_get_report0(struct tdx_report_req __=
user *req)
>  /* Size of the header metadata plus the largest possible raw Quote. */
>  static size_t get_quote_buf_size(void)
>  {
> -	return TDX_DEFAULT_QUOTE_SIZE;
> +	size_t buf_size;
> +	u64 max_size;
> +
> +	/* Start with the default buffer size, which includes the header */
> +	buf_size =3D TDX_DEFAULT_QUOTE_SIZE;
> +
> +	/*
> +	 * Override the default when the TDX module reports a size. Add room
> +	 * for the header metadata. The size is fixed during TD runtime.
> +	 */
> +	if (!tdx_get_max_quote_size(&max_size))
> +		buf_size =3D struct_size_t(struct tdx_quote_buf, data, max_size);
> +
> +	return buf_size;
>  }

[Severity: High]
Can this dynamic evaluation cause an out-of-bounds write or buddy allocator
corruption?

If tdx_get_max_quote_size() fails transiently during initialization when
alloc_quote_buf() is called, get_quote_buf_size() will return the default
size, and alloc_pages_exact() will allocate a buffer of that size.

If a subsequent userspace request triggers tdx_report_new_locked(), and the
size query succeeds this time returning a larger size, could the driver wri=
te
past the end of the allocation?

tdx_report_new_locked() does:

    size_t quote_buf_size =3D get_quote_buf_size();
    ...
    memset(quote_buf, 0, quote_buf_size);

Similarly, free_quote_buf() recalculates the size dynamically before freein=
g:

    size_t alloc_size =3D PAGE_ALIGN(get_quote_buf_size());
    ...
    free_pages_exact(buf, alloc_size);

If the evaluated size changes between allocation and free, could this cause
free_pages_exact() to free an incorrect number of pages?

Would it be safer to cache the dynamically queried allocation size once dur=
ing
initialization to prevent transient failures from escalating into memory
corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930103739.2851=
980-1-peter.fang@intel.com?part=3D6
