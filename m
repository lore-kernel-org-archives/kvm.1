Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781544;
	b=uo4EZ8pIM+2mxVW6WsAmWYvBy9C9+dqUzG6eNTA3KJQ6+0TYFErRTzsV2kNZ/sriXc6G
	 P43rEnuSPgx8gHDcyolFuhbKFVR+vakEWpW5q1zcA5+Pwp3VXQ+1awyAfJf8y6aJn1vJZ
	 onQEuNv6auotLgESzmoVBR7izXkzcYw0tIiN2H3rGfz0iskWr2fU1DaslKr9uW6wEy4Qj
	 ML9b5oKinEwe6yea0M9upefRAGlW29FRLV2sK49xVRoI6CR022eTjdeNM2jp2QpPSPTdh
	 SJehWY3YW1/oxAdfkGJ+7CTnJ+9BqchjwYDi89mxc2AyX/pZddKMVmAHVaEkUCOCulA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781544;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kLHyl6P0EeFN2LdWj/U4/UCrNoB9kLiGKp5JeZJGIGw=;
	b=s5TFPAW5/BYE+/EjVn9R0uL01yoHixPAEPrJLp95i2Jt9+24Vofq0l4Bq+heAeYqwXeM
	 nzCNjNR+0+M8T7aTmWHbP2Ugc11eA8LhqR4uzTnktnlTnd8u6jCpPp4NfjBwWp9QBoeUe
	 9b5BhdV2gYkv4FjdlwrO30XQGFA8SiseMkEuPnszV1iRRR6kfs9v2wCi75t1wbP8g/4wO
	 CCj9RYv7AsVNuInpFIjCaKhExDdRfHHpawBhPF7wdI7F2X9Wn0ZKOgDYU9cCbzDFV1G+m
	 VhatcN+T1+GVdFiXipKHL7VNOCn1nspuTe9FdDhcQCPYgK+dhaDCHOcjC69gU7kRxwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDFaniyo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C0606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDFaniyo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C031F00898;
	Fri, 27 Nov 2026 12:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781543;
	bh=kLHyl6P0EeFN2LdWj/U4/UCrNoB9kLiGKp5JeZJGIGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kDFaniyo9DXPwNxxk5moiCvEyjboJB/YEyTwZIeqAOtKWD0H0hxPbcGGjOf7jjfXP
	 p1au5o4r3uqfc7OtDcbxQg6POFpaSCrTn03XbBH2kxQGYsgryKwM1EGX8zFojov/aX
	 TGf3ATlA+na+J8dFysXY3iDF52QfL+p/BcuaMv5nIDvqAU5/ZhTwqz5bY+2gP/vdkt
	 1Kn+xTgqDRA/vJgU+N8gbRqPZ7Yiifmf20O9vMzym66DmuAOC+mY9c7IMrPUchQaoF
	 vcdC1O2TqeN2t8tU6LWMbsi/t6wEbK6Cfz8O5339XEiQ/qVnZy7ywjYo5phlwsTkwY
	 3COz8osc+4t6A==
Message-ID: <sashiko-outbox-237331@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] iommu/dma: restore flush queue use in
 dma_iova_destroy()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Szyprowski" <m.szyprowski@samsung.com>, kvm@vger.kernel.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261127115849.2780625-5-m.szyprowski@samsung.com>
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115903eucas1p27ccc4cddb7f705d6afa5c2603597b97a@eucas1p2.samsung.com>
 <20261127115849.2780625-5-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 12:12:23 +0000
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
- [Medium] iommu/dma: unnecessary flush queue use in dma_iova_free()
--

commit 7f3e82cb1115d261e31845270a947f770830fc8e
Author: Marek Szyprowski <m.szyprowski@samsung.com>

iommu/dma: restore flush queue use in dma_iova_destroy()

This commit records whether an IOVA reservation should be released through
the IOMMU flush queue in a new DMA_IOVA_USE_FQ flag in
dma_iova_state::__size, and restores deferred IOTLB invalidation and IOVA
queuing in dma_iova_destroy() and dma_iova_free().

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99eb382a13597..0e329ecd7dfad 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[ ... ]
> @@ -1871,14 +1892,11 @@ EXPORT_SYMBOL_GPL(dma_iova_try_alloc);
>   */
>  void dma_iova_free(struct device *dev, struct dma_iova_state *state)
>  {
> -	struct iommu_domain *domain =3D iommu_get_dma_domain(dev);
> -	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> -	struct iova_domain *iovad =3D &cookie->iovad;
> -	size_t iova_start_pad =3D iova_offset(iovad, state->addr);
> -	size_t size =3D dma_iova_size(state);
> +	struct iommu_iotlb_gather iotlb_gather;
> =20
> -	iommu_dma_free_iova(domain, state->addr - iova_start_pad,
> -			iova_align(iovad, size + iova_start_pad), NULL);
> +	iommu_iotlb_gather_init(&iotlb_gather);
> +	iotlb_gather.queued =3D state->__size & DMA_IOVA_USE_FQ;
> +	__dma_iova_free(dev, state, &iotlb_gather);
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_free);
[ ... ]
> @@ -2152,14 +2187,28 @@ void dma_iova_destroy(struct device *dev, struct =
dma_iova_state *state,
>  		size_t mapped_len, enum dma_data_direction dir,
>  		unsigned long attrs)
>  {
> -	if (mapped_len)
> -		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
> +	struct iommu_iotlb_gather iotlb_gather;
> +
> +	iommu_iotlb_gather_init(&iotlb_gather);
> +	iotlb_gather.queued =3D state->__size & DMA_IOVA_USE_FQ;
> =20
>  	/*
>  	 * We can be here if the first call to dma_iova_link() failed and
>  	 * there is nothing to unlink, so let's be more clear.
>  	 */
> -	dma_iova_free(dev, state);
> +	if (mapped_len)
> +		__dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
> +				&iotlb_gather);
> +
> +	/*
> +	 * Retire the gather together with the IOVA, like __iommu_dma_unmap()
> +	 * does: either invalidate the IOTLB now, or hand the IOVA space and
> +	 * any page table pages released by the unmap over to the flush queue,
> +	 * so the IOVA cannot be reused before the deferred invalidation.
> +	 */
> +	if (!iotlb_gather.queued)
> +		iommu_iotlb_sync(iommu_get_dma_domain(dev), &iotlb_gather);
> +	__dma_iova_free(dev, state, &iotlb_gather);
>  }
>  EXPORT_SYMBOL_GPL(dma_iova_destroy);

[Severity: Medium]
Does queuing the IOVA in dma_iova_free() (and in dma_iova_destroy() when
mapped_len is 0) put already-flushed or never-mapped reservations onto the
flush queue?

When dma_iova_free() is called, either no range was ever linked or all
linked ranges were already unmapped by dma_iova_unlink(), which always
runs a synchronous iommu_iotlb_sync().  Because no deferred IOTLB
invalidation or page-table freelist is pending, passing a queued gather to
__dma_iova_free() routes the IOVA through queue_iova() instead of
free_iova_fast().  Callers such as __drm_gpusvm_unmap_pages() that call
dma_iova_unlink() followed by dma_iova_free() pay for the synchronous
IOTLB sync during unlink and then still quarantine the IOVA and arm
fq_timer for a full-domain flush_iotlb_all().

Passing a NULL gather from dma_iova_free() and only setting
iotlb_gather.queued when mapped_len is non-zero in dma_iova_destroy()
would return these IOVAs straight to free_iova_fast().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127115849.2780=
625-1-m.szyprowski@samsung.com?part=3D4
