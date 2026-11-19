Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115536;
	b=tToeL3saoyIaDQJU96rnSaaXA2P76qZOCLpnyxcJwvy4/p+mwh7lNWIjHZLosknkYV43
	 EfUxS1j0qCtlse8DNsLgk5ge/bz+AAucFe2NJTgFzBxjceu3mZ2bJXu0N2zYNxsupp31q
	 Iar9Y7SfbP2MTBXaXUI0/4HbDPHrHAKwadTvwXNZakupvc50RpHeAKZA2FD6UvRcjlZ0R
	 jF0gtOFJjUVQVNRtG+tt8/sfnkO9oKlvswONRkONMAMhVq9PDUhg16rk45n4gMoODYvT4
	 IrN7CwXVFIIy8U1dcFiezLC2lwKXyJSE1No+T57WLBxx9ldzKFJim6WTiIoBh+Pview==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115536;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RiqxkmQuEZYfA18XobgUQCGHM3oSQgwCG6zG/cEs7cI=;
	b=RX6pCkknNCufgb2/lG0vZMKwgEQ66OlAROicLYwLIUgjbuF546lq9gMbTpqFirnThN8d
	 Hp7xT84Ho/jTo1PaPXNqbTvk1rRnezKy07XhdozcAjlkyUx25/nD32ZFIEYroH7Fl/Qdd
	 OSL1pPyPpN95b0jxq39Jatt2CGSYdcHsP6PwLtfqj/KAk0I5I/UEvfMbExz1oeSnEd9ku
	 yYLYgpMAC0MEvqPHWbmWJvt+3gjJa7thA2Sv+Afugrs4nZfmD7FSZSF33+sXfPDIOZ1vl
	 CalQskwYXwQhcyx9ItawTra4b18ulnyNzogHZi7Px4ntZlr3FZ0E77QqonOPGIW00RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyJLrELC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10543606A330
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VyJLrELC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE611F000CA;
	Thu, 19 Nov 2026 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115535;
	bh=RiqxkmQuEZYfA18XobgUQCGHM3oSQgwCG6zG/cEs7cI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=VyJLrELCdO+Ob/QDDcZ3thaodvhQ/nQMITkHbHtgbkJgxiHuWil5Nr8sopr5YFqTC
	 72MJB0LpbpjeLbYxHP2QRE0MguONxzeSatlchw4Juol2o8SZzTHilseCxqrzTtz3Qx
	 +UvdlmUGAER3GTgvOUzRRnQB0z+Z8jhaxMAZUMn8jxSUUFAhKtMb6W7LvkAu9ALqHz
	 GuCfq7FHfitzEXURAO6kS+cJ2As4eF1BBAL/qe+InKcKsAXCbXS6eZWm9xC5KNUbrz
	 bmbnnZXnj9wrFA+L5wYF2xsed52mkXvOz+xyFY16bU8T3JVsaqn78klZerNKSx83gt
	 CmcbHxDqIaCbA==
Message-ID: <sashiko-outbox-223837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] vfio/type1: Track GUP vs PFNMAP in DMA map/unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Lewis" <aaronlewis@google.com>, kvm@vger.kernel.org
In-Reply-To: <20261119185659.889654-3-aaronlewis@google.com>
References: <20261119185659.889654-1-aaronlewis@google.com>
 <20261119185659.889654-3-aaronlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:12:15 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] vfio/type1: page pin leak in vfio_pin_pages_remote() [1]
--

commit 7c0ecb4964283632e7393bd0af979809631123dd
Author: Aaron Lewis <aaronlewis@google.com>

vfio/type1: Track GUP vs PFNMAP in DMA map/unmap

This commit replaces has_rsvd and has_non_rsvd in struct vfio_dma with
has_pfnmap and has_gup_pinned to track whether pages were pinned via GUP
or mapped via PFNMAP in vaddr_get_pfns(), and clears these flags when the
DMA range is unpinned.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index 7bad0508dd214..ee40ba942fd5e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
[ ... ]
> @@ -685,7 +700,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dm=
a, unsigned long vaddr,
>  	unsigned long pfn;
>  	struct mm_struct *mm =3D current->mm;
>  	long ret, pinned =3D 0, lock_acct =3D 0;
> -	bool rsvd;
> +	bool pfnmap =3D false;
>  	dma_addr_t iova =3D vaddr - dma->vaddr + dma->iova;
> =20
>  	/* This code path is only user initiated */
> @@ -696,7 +711,6 @@ static long vfio_pin_pages_remote(struct vfio_dma *dm=
a, unsigned long vaddr,
>  		/* Leftover pages in batch from an earlier call. */
>  		*pfn_base =3D page_to_pfn(batch->pages[batch->offset]);
>  		pfn =3D *pfn_base;
> -		rsvd =3D is_invalid_reserved_pfn(*pfn_base);
>  	} else {
>  		*pfn_base =3D 0;
>  	}
> @@ -721,12 +735,18 @@ static long vfio_pin_pages_remote(struct vfio_dma *=
dma, unsigned long vaddr,
> =20
>  			if (!*pfn_base) {
>  				*pfn_base =3D pfn;
> -				rsvd =3D is_invalid_reserved_pfn(*pfn_base);
> +				pfnmap =3D vfio_batch_is_pfnmap(batch);
> +			} else if (pfnmap !=3D vfio_batch_is_pfnmap(batch)) {
> +				/*
> +				 * Handle PFNMAP and GUP pages separately; any
> +				 * GUP pages remain in batch for the next call.
> +				 */
> +				goto out;
>  			}

[Severity: Critical]
This problem wasn't introduced by this patch, but can this overwrite
*pfn_base and leak page pins [1] when the first page frame mapped in
the loop is PFN 0?

*pfn_base is initialized to 0 to indicate that no base frame has been set
yet. If the initial vaddr_get_pfns() call returns PFN 0, *pfn_base remains
0, so on the next batch refill if (!*pfn_base) evaluates to true again and
overwrites *pfn_base and pfnmap with the next batch's values. The
contiguity check (pfn !=3D *pfn_base + pinned) then fails and returns the
overwritten *pfn_base to the caller, mapping the wrong physical pages into
the IOMMU, leaking the pin on PFN 0, and unpinning the wrong PFN range on
unmap. Checking !pinned instead of !*pfn_base would avoid treating PFN 0 as
uninitialized.

[1] https://sashiko.dev/#/bug/linux-8352e900-d371-44e3-bf35-a0a7fd55ac4b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119185659.8896=
54-1-aaronlewis@google.com?part=3D2
