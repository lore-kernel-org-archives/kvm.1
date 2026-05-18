Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963847B40D
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779114212; cv=none; b=CBLBMEvzQB4RkDIhwH64vEd460NTa3CxDHPTyI7fkoLMmMx7U/Spa8m+hyrGIrr48phV42KOOQLOlUQeF2NZ9J9ITouydgtwEw6fDiZGO3CW6fJvwwN+27JgHYGs8HtWEbb9faW5Qzqx3Kt7IgjtgwZ3yfkAt7HYbSJ3zSwIC10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779114212; c=relaxed/simple;
	bh=RK9scrGy766A6YXR54Pqoa2eq1DiOV7GVNJWPlAdn/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YraFohbRA58k+2xoFdgy9hYbRE7gSjvD7sAszq56Vz7ydrzKh13xqY5vYuZveC5f+Q9Yk9JQ1+k+2F2HBsEy1uSSrvhrGySJ9ykhqUiynRf/IhpM2WNyY3dPAEpwJrX2ZfVparMhcZTgnlo4efIpVzYl96/bFyO3ysc1aFasQWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mXEixlgj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mXEixlgj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso4335ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779114207; x=1779719007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sZbZUHjZ//GhpOMWpDa3xawAFKF5ioAagbi5BAli/g=;
        b=mXEixlgjOCyhm1lQ1kITdnwzSkv4Hn1gK/BQYIZe99JGK0SaWFF/bWjoaF1ZKIPltu
         MLd580stppW4vj6k1OszlNlDPP/wpsuDdrcLTuzulzCm9zVtWZK5gZma1B+Qiy9aUVz2
         G9ldl3hEJxdDS3Wyf/b94X9fSH36oWAUf9sfxSL0ilLd/MtK8BULUQ/2lzBuPtZYPDaA
         8BgD+RWBQbUUu5Cqhuaeica9+uwDF8M5d2SdPfYVf2m8m70lMgWqP0k9wH8+8ZDzU+zS
         GZc4E56u31Ua65lCldTfPf3oL8nl+QCJjee2PkvDAMIqaefFJn6ewmttpWkianWaR3K1
         xk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779114207; x=1779719007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sZbZUHjZ//GhpOMWpDa3xawAFKF5ioAagbi5BAli/g=;
        b=N8ZbNMuE8cbaAJEU1uBk03QPOinlNqBcIwkG7KS+dKX25yE+BgNtIQBP3AHF60d/jE
         HDrtWrWbOwT5oYFwJ+moQJbPb3k/j2T1oGV3QqIM1QmYiaIoxJ1466hDZp89BX3EHlex
         9SlnrLwcfsXPwli8r+TimLBklt2DV3YMgiwinCWRIyYiqb2TjR5Qxl66m+3ktNH7QOVu
         SoUWlSoty/zGeAqVo9VagOAHnY62fBhAUh4uiehYRdQ7fnzMvmu6K6LCoiL5JQcmu+hv
         aX+ojaTtuBFBcrTU6WJbXreX706mDCV9KDfUv/25XSvpgUqtqL4JfNijZh6HrAeb+xBw
         gGjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ehgrk5QRM/yeaBFD7l007YNUKsb0To6AElv7bcOZlGx9PWei3x9uCJE1hqWvZEaqbH2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfcEvyAsPg/8QDLLC7aPKcDAyxsSDY1f2OyV6MITVgoJbVXvX
	5OKNrFrJ3F+qWyyKAURKiO+emWQSDIW1bLBTtITSZDffh938idHYaxjWtod2+0jiq/oycL2VLS+
	0ewkCJA==
X-Gm-Gg: Acq92OGS36K3TmAJHFbW50RI9x+1PZcDHjXIpeB3w46acQnbuRPlcxJy3btmN9dqDDw
	fqPsJxNqSsdjo5mOsZvidyGSWUv165XdnyB5nonkuRzIZHmvNzXRsT1YaL5qejvyq3H3vZ+JLQ0
	etVjerVxo32Nylhm9GnDEkrqaD68czmXWbPlrLxF5tKjI1PtCuvN3l1S7ErgXQHZ92Y216oTa99
	fT7/+6HslmjjHRKT1Bzm50v5bSLmFVaPmczOUQhogs7E1dWNXXshukISwFLpkga+50LwjAjD8vu
	vrDo9EFpUuVIAduv0K+F6ShOyNpc5RtoB/GS7mjl42IXky/E8qzv50Xm+FU+SyuKmvlPWNC2b4L
	mJvBKRDWPwyvsg9v7onT2ITvZL9paPf+Z76WupeANdHJ5GfoTe84oLLrO7hi2SIp/7FT9vIk/7p
	QuhmIGTVgATgR2hnwP3hZVouK9bgLM+/GYSzn37tDwgozqX4FuxW9wkCwFazXokWASkjsJ
X-Received: by 2002:a17:903:1a2d:b0:2b8:e82d:ff7c with SMTP id d9443c01a7336-2bdb32c3f0cmr2581525ad.9.1779114206217;
        Mon, 18 May 2026 07:23:26 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm159685695ad.69.2026.05.18.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:23:25 -0700 (PDT)
Date: Mon, 18 May 2026 14:23:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 05/16] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <agsg1esRdKwV3dxB@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-6-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-6-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:22PM +0000, Samiullah Khawaja wrote:
> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> the proper preservation and restoration of ioptdesc add helper
> functions.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>  2 files changed, 134 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
> index 3bab175d8557..b1ffeb930e6d 100644
> --- a/drivers/iommu/iommu-pages.c
> +++ b/drivers/iommu/iommu-pages.c
> @@ -6,6 +6,7 @@
>  #include "iommu-pages.h"
>  #include <linux/dma-mapping.h>
>  #include <linux/gfp.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/mm.h>
>  

[snip]

> +
> +/**
> + * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
> + * @list: List of pages to unpreserve
> + */
> +void iommu_unpreserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
> +/**
> + * iommu_restore_page - Restore a page that was preserved in KHO
> + * @phys: Physical address of a page
> + */
> +void iommu_restore_page(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	BUG_ON(!folio);
> +
> +	iopt = folio_ioptdesc(folio);
> +
> +	/*
> +	 * For the restored pages incoherent is set to false as these are not
> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
> +	 * is not needed as these are not going to be written to by the new
> +	 * kernel.
> +	 */

Looks good.

> +	iopt->incoherent = false;
> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	iommu_folio_update_stats(folio, pgcnt);
> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_page);
> +
> +/**
> + * iommu_preserve_pages - Preserve pages during kexec handover
> + * @list: List of pages to preserve
> + *
> + * Returns 0 on success, negative error on failure
> + */
> +int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +	int ret;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +

Looks good.

> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
> +#endif
> +

[snip]

> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)

Nit: This is inconsistent from the signature in it's counter part in
IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)

Let's remove `int count` from the arguments to avoid broken builds.

> +{
> +}
> +
> +static inline void iommu_restore_page(u64 phys)
> +{
> +}
> +#endif
> +

With that stub argument fixed,
Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks,
Praan
