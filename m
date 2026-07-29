Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416C48663F
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329739; cv=none; b=kDb9NMdCiYa8AdZGcqhZ7qwvXhXB6+e3DwtLVWVR5Q+QfRKoy6hciuuuRuH9H72D+rTWnFI0xMcUNpVgFOE/IlE5llmd/m3mFQuNvE4ca43awZhlRjbcH3u7vFVSlohx39eR5p98Vk92Em++bAIYOHDL4/Qu3+dE5E5I2G7K9ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329739; c=relaxed/simple;
	bh=mF5ztOSGRF3qPV/WsE9z4KOxXA7BNlcG46/efrCt4es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r0cXhh87OiGDVOfEdeRailzROYZgbkI9KtE8WzehRo2+COwjfVtT/8+mRab2mWz+fktsCKcFJg6/53OKfU9rgbmMXC7a5jH+j2vtv41OWDwdH67qCtSVLmOGcnREZBdCM8IdpDQJZray+xRKJ91u0cSl2rZ8JHlIL0Y7Bl9J0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QypLY3Fl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QypLY3Fl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FD91F00AC4;
	Wed, 29 Jul 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329724;
	bh=AdfAdZtHPCGyEo7eZISZgUcnQlsawBzde5H3kKmxtdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QypLY3FlkvpEWoS9t3DfY1jkN2C559emYvBtJgWS6mYLIZyGlAE1wsWlgwfNf2vFI
	 VG9mi17w1eKcwUu0gxLAL4o3mFNZFhHS1aZO3iSLKbIMSlKA5jHlOE4bQUuc8AXPKD
	 A3sKaFBS4Cbl2y87Mkr8N75i+6NxMyuBiX/l2/R+Vm/fVyBJohvdSu05yakVWTObgt
	 mAERsxxeEp7Xygzd+IMcDptfZWFK2aGYBmHs7T9GyPNHOewWEoeIXpojBd4RzthSmG
	 06PIWmWM6nY2aQ0bHe6BR6o5kMTnaIZ3H4cb24pdJGCebS0W+2zu7uclFZ026KPRK3
	 /nJC1kRM8qLeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer
 dynamically
Reply-To: sashiko-reviews@lists.linux.dev
To: "Peter Fang" <peter.fang@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729122939.1340412-5-peter.fang@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
 <20260729122939.1340412-5-peter.fang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:55:23 +0000
Message-Id: <20260729125524.48FD91F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Untrusted VMM input `TDCS_QUOTE_MAX_SIZE` is passed directly to th=
e page allocator without bounding and without `__GFP_NOWARN`, which can tri=
gger a kernel warning (`WARN_ON_ONCE`) and panic the guest if `panic_on_war=
n` is set.

Pre-existing issues:
- [High] Pre-existing UAF/Use-After-Unload race condition if module initial=
ization fails after registering the misc device.
--

--- Patch [4]: [PATCH v3 4/4] virt: tdx-guest: Allocate Quote buffer dynami=
cally ---
commit 25802a377289c67ad6c07c5b41f81b3b9c799fbe
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.=
com>

virt: tdx-guest: Allocate Quote buffer dynamically

This commit modifies the TDX guest driver to dynamically allocate the Quote
buffer based on a size reported by the TDX module, replacing a fixed 128KB
allocation. It removes the __GFP_NOWARN flag to ensure allocation failures
produce a warning.

> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/=
tdx-guest/tdx-guest.c
> index 3d3f79ab45af0..8919b1a1154e7 100644
> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c

[ ... ]

> @@ -222,11 +222,31 @@ static void free_quote_buf(void *buf, size_t len)
>  	free_pages_exact(buf, len);
>  }
> =20
> +/* Return a buffer size large enough to hold a Quote */
> +static size_t get_quote_buf_size(void)
> +{
> +	u32 quote_size =3D tdx_get_max_quote_size();
> +
> +	/*
> +	 * Older TDX modules do not report a maximum Quote size, so use
> +	 * the default.
> +	 */
> +	if (!quote_size)
> +		return GET_QUOTE_DEFAULT_BUF_SIZE;
> +
> +	/* The reported size does not include the buffer header */
> +	return PAGE_ALIGN(TDX_QUOTE_BUF_LEN(quote_size));
> +}
> +
>  static void *alloc_quote_buf(size_t len)
>  {
>  	unsigned int count =3D len >> PAGE_SHIFT;
>  	void *addr;
> =20
> +	/*
> +	 * This fails if the requested size exceeds the buddy allocator's
> +	 * maximum order (order-10, 4MB).
> +	 */
>  	addr =3D alloc_pages_exact(len, GFP_KERNEL | __GFP_ZERO);

[Severity: High]
Does this allow an untrusted VMM to trigger a guest panic?

Since tdx_get_max_quote_size() reads the TDCS_QUOTE_MAX_SIZE metadata field,
an untrusted host could supply a value that causes get_quote_buf_size() to
return a length where get_order(size) > MAX_PAGE_ORDER.

Because the __GFP_NOWARN flag was removed, passing this unvalidated size to
alloc_pages_exact() will trigger a WARN_ON_ONCE inside the page allocator.

If the guest boots with panic_on_warn=3D1, this gives the VMM a trivial den=
ial
of service.

Should the calculated size be clamped to a safe maximum before calling
alloc_pages_exact(), or should the __GFP_NOWARN flag be retained?

>  	if (!addr)
>  		return NULL;

[ ... ]

> @@ -416,7 +436,7 @@ static int __init tdx_guest_init(void)
>  	if (ret)
>  		goto deinit_mr;
> =20
> -	quote_data_len =3D GET_QUOTE_BUF_SIZE;
> +	quote_data_len =3D get_quote_buf_size();
>  	quote_data =3D alloc_quote_buf(quote_data_len);
>  	if (!quote_data) {
>  		pr_err("Failed to allocate Quote buffer\n");

[Severity: High]
This is a pre-existing issue, but does this allocation failure path leave a
window for a use-after-free or use-after-unload race?

The tdx_guest_init() function calls misc_register() just before attempting =
to
allocate the quote buffer.

If alloc_quote_buf() fails, it will jump to the error path and call
misc_deregister().

However, misc_deregister() does not revoke active open file descriptors.
If a concurrent userspace process opens the misc device between registration
and the allocation failure, it can execute ioctls after the module
initialization fails.

This can result in accessing freed memory or executing unloaded code.

Since alloc_quote_buf() can now attempt larger allocations up to 4MB, it
seems much more likely to fail.

Should misc_register() be moved to the end of the initialization sequence to
prevent userspace from accessing a partially initialized device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729122939.1340=
412-1-peter.fang@intel.com?part=3D4
