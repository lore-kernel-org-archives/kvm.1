Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD1382390
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124938; cv=none; b=YC+9+iicRVQ93DH9F4YIUygV4GCjGJ0nO6S8WVD/AhI82N0w/iv+hSbIzCAAniQ8TfE3GAh4mGyeOdbER8Em6SpUD+5HGDU/82IcE2Z4yH8ikPzN9bFh1XAQC+ZMOcrmsUtSXtxPaESpv+Ic/yu/MioqWdiGWVJ/ukcROss/eZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124938; c=relaxed/simple;
	bh=kvzoRRtRkt99R85TCv6fmYGvBN6W9hGpuH3oahXqcoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRo48qaYvTZJlkqq8eNupQktr+ZijDRb/O3b/6uhECPWbnaxyxrd86kMUhgUlR8+lWFN18LGvFGdl8p/zwPHoySailqN08tj70SwUC3tjFmyygvowNDYuX+CGDO161Y+bD0XjxSzJlackq+5mS3tVIN6pBtLcnyoCYoxrdD83MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZmLoF/i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZmLoF/i"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1675ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124936; x=1779729736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOpQmNzrJoZpllcvwCwLtMCpq7AcJeE0RS7V56u/5aU=;
        b=VZmLoF/ioIzohyqnmEms/ki5BYdASIN4DRyEFwQfgOJLp7pCRntGYFioiamGfjhyxg
         g20Jh7wpOcp/TqzVkAcgTxvijSV2GCTkL5V1hOB4SI7fa6MEWCg/JKTxPeunNfC9/4bi
         uL5DPAdaGCTDpilhBBDkabV+UkWTeumkY6bBjY0ichlN3hBTrwA2X1lTAudU+7j8Gaz3
         LKz63iHXu+MrAo+PrnXGsGWY/TCp8N3Gia/77GO1a/CT37/N6g5zgPWbkVQzko6j9i6b
         OTH1xThaOwhop6fuFT36zMgQkUaiDOFClFwpoBexk2DjkgaekALC8X0SGeEBuWYHgW84
         CbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124936; x=1779729736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOpQmNzrJoZpllcvwCwLtMCpq7AcJeE0RS7V56u/5aU=;
        b=h4BJ9MuChbEjyK2r/DJKZmjG27Uw0c37B7Wd4UhZOseU0bFyOyAihXVBRKSKoA7+g4
         7V20smE5IFIIoVH3NJPbAlkqZjIi6Mc8oJKYUldf5/syEewJkAXHmzVubwL6BeWKw4F1
         N82vegz2NoTr2o6zIwO1WaxDwD/B6qwHqxvMit8YAi6SEkTb3tr1+sHnTntTfvXCEgRP
         EWfwbclXYMLHDkC9CAajIhEFiexiF/5u8gq/rs11jsiuEFa6EMuCn7cZbWyj2xm9U/4C
         laENadFo3YW6GRbqMRleNmQOc3goWzodwBvjQQKgGRQxodTQ2NC9XY2Wq9G5Q9ONjW+Y
         7BlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uTlfzwbdRtWuLvG4TQLCGkbQLfpjIAan5RNAPdGd/t+r8w6BB8V4GqRNWbxorVVBZLPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA3N4gcoAf5zb91UiHP2mKiX2aY/LerG4vPceuBARH8V527W4
	XqewrlYOzI9yE/1XHcjUoBCbQMTM9ut+Ssih+fH3jQRbPZpA1GdfakEmdoSqE02Ndg==
X-Gm-Gg: Acq92OF2ySLaw8XCp8e4M2LKFGOPkzZTSO0/v8ylBAKfWlBbSKDXC26gwzc1veNonF8
	BuqAOq2IEtuOH+TnhcynTWGiwkciIx3WkZvj4DvZ/TfolMYeZnTuEM1CfrQReaLCTi0duoiqVrA
	GTt60vSMeuY9UZbnrNtzkKd2Cjxrv2ZrO1sqbOMEPF7zUh/yhrFI4qu5hQDpbcFBOhWWsk1JicX
	oXWJDPVPBo8cDm2IGYHr+KclGcSI819v5HDF7jQhPju/7R+wYlBP0294OpoCNKfmXni3ZbWchkm
	RZjrXqazH9EMXcrXlXd2VFSkkXZ3JXQjcrNW3GZ4Gl/lGZTccVsjpNITQr6FxS6Wk54oW3IFeQW
	esfE08GhBCMqXG6jbdoNDcT5msDpnfBR0z0itbW0Wi6tGTciEo6gYII5vW9hG4lDTI2Zl6W6rfu
	+Rakl+SbWAR0Kw9+i5qzHr2uvKKJvXWLKDNBaR0GXygHFwiVJmzcCvNE6PiNN4eP5CFAJCHPLtZ
	sLwJVMD
X-Received: by 2002:a17:903:228e:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2bdb03a197bmr3385745ad.10.1779124935806;
        Mon, 18 May 2026 10:22:15 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b779sm15315177b3a.23.2026.05.18.10.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:22:15 -0700 (PDT)
Date: Mon, 18 May 2026 17:22:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 05/16] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <agtKjY_D2S6I_DVd@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-6-skhawaja@google.com>
 <agsg1esRdKwV3dxB@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsg1esRdKwV3dxB@google.com>

On Mon, May 18, 2026 at 02:23:17PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:22PM +0000, Samiullah Khawaja wrote:
>> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> the proper preservation and restoration of ioptdesc add helper
>> functions.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/iommu-pages.c | 108 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>>  2 files changed, 134 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
>> index 3bab175d8557..b1ffeb930e6d 100644
>> --- a/drivers/iommu/iommu-pages.c
>> +++ b/drivers/iommu/iommu-pages.c
>> @@ -6,6 +6,7 @@
>>  #include "iommu-pages.h"
>>  #include <linux/dma-mapping.h>
>>  #include <linux/gfp.h>
>> +#include <linux/kexec_handover.h>
>>  #include <linux/mm.h>
>>
>
>[snip]
>
>> +
>> +/**
>> + * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
>> + * @list: List of pages to unpreserve
>> + */
>> +void iommu_unpreserve_pages(struct iommu_pages_list *list)
>> +{
>> +	struct ioptdesc *iopt;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
>> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> +
>> +/**
>> + * iommu_restore_page - Restore a page that was preserved in KHO
>> + * @phys: Physical address of a page
>> + */
>> +void iommu_restore_page(u64 phys)
>> +{
>> +	struct ioptdesc *iopt;
>> +	struct folio *folio;
>> +	unsigned long pgcnt;
>> +	unsigned int order;
>> +
>> +	folio = kho_restore_folio(phys);
>> +	BUG_ON(!folio);
>> +
>> +	iopt = folio_ioptdesc(folio);
>> +
>> +	/*
>> +	 * For the restored pages incoherent is set to false as these are not
>> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
>> +	 * is not needed as these are not going to be written to by the new
>> +	 * kernel.
>> +	 */
>
>Looks good.
>
>> +	iopt->incoherent = false;
>> +
>> +	order = folio_order(folio);
>> +	pgcnt = 1UL << order;
>> +	iommu_folio_update_stats(folio, pgcnt);
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_restore_page);
>> +
>> +/**
>> + * iommu_preserve_pages - Preserve pages during kexec handover
>> + * @list: List of pages to preserve
>> + *
>> + * Returns 0 on success, negative error on failure
>> + */
>> +int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	struct ioptdesc *iopt;
>> +	int ret;
>> +
>> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
>> +		if (ret)
>> +			goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
>> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> +
>
>Looks good.
>
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
>> +#endif
>> +
>
>[snip]
>
>> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>
>Nit: This is inconsistent from the signature in it's counter part in
>IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)

Oh. I will update this in next revision
>
>Let's remove `int count` from the arguments to avoid broken builds.
>
>> +{
>> +}
>> +
>> +static inline void iommu_restore_page(u64 phys)
>> +{
>> +}
>> +#endif
>> +
>
>With that stub argument fixed,
>Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks Pranjal.
>
>Thanks,
>Praan
