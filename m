Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B363783A4
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 18:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030356; cv=none; b=CoNkRDPs8JzqWDfE/UyxkCdI/YSQpj6Bl9FANK9GmBi9dyKQePt5jfqRjVhKE5F3yGswU/MDtzfhMvKIesb0xoR0+Q+H+5nGUJXjeXTp1vbj1m+UazP9IwHDPoLa1zqwQrmUY50HJOINAMnRVgUQgIRxzOWwt38h1+wPmREBH/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030356; c=relaxed/simple;
	bh=QS1WWhfnhlxuhnsuWa2H0Rvb7wQFQVJGDESzCKXlKw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYZ2GsxVQWmfTQbpzGhPotbBNoSvBKnkiuypE/0rENyfGp6bekboJcH2YCHavUtj5Ac0/fpufqYRQGWga5Nh8HmoHlj4IGG1RnijcdAI3fUk/gZpYriCRyXolkzf0lAiZCQOAazsAKA18cc38OCEf23FaqdPDafEtXYeRgwCaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P60v6DeD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P60v6DeD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so11605ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 11:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774030354; x=1774635154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLXxR402vA3/2ADlyJ4N6o23ie2gXoPSWXjjE5PFaBA=;
        b=P60v6DeDQz86XBDoxVUqaQ84m3F7OYDbGmAH7FmPECKFN/wKzaL6U7Aa0yluRlL0cN
         rGAiEXNTX9fWlBRRBm7ZFIzhLf5KykEcjTIpuNqYGXQJzG76K9wnsY+Z47jnS6828nzv
         2/J9mY9dRbbeS8GxKR0bE3VVit0F2K3iEjEm6B797UaBwoQIZg56qi8iYWZyy2LMKfGo
         abaAj1ajhYY6ysotnyk6JKZkBqa9pvtTzMF6ysnoJyBna0jURJuV08QTRW9nD2jaZj0W
         OcaA5Pi1V4g62uWHIFt9WKICtjsXNSUCZHMvjnrKM0m/Zt1EviF8qrq+1EoykQqUPQgF
         BM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030354; x=1774635154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLXxR402vA3/2ADlyJ4N6o23ie2gXoPSWXjjE5PFaBA=;
        b=OeqRY91N/CGZtWFOr02pffNv/19EAu0LLXuWS4LLZgNJhR+VOYd3XcjkmBox0TOxXT
         1rhD2Yo2SqM86swsxqqj6mB73163tgSzpalQLRxmW5TkGqE5hz+Rt9XtqUueI1+6x7D4
         6Vx8WDDhGuupb1BnJjmAILFclafibWpOBwRTLC1gBwcSyFSDwp6Qr+V6sbosdMOSOVNh
         B4z5zKekxBYlKz02kn6cOWfeqek9NC5WQLBb+B77zC/JNKVUH0J4z5yZVg8HYv8vwNRY
         hDTfsMaSArpQAb5ti0rAGr/3E4zz7wdU2DCuqxDf3mIj+TW4Uf3zLH+H5uZ5VhJkFSYn
         AulQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIltR5UzLxo7NQUFxws/bhB1xVF3eEF5yKWrZixWd27kubrZlNWJf1Pl7m+RUvL0Lj1r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUgdHXWCGR/rKohdUH2uXJEsMt7YWw2jUWqbi0RtoRaxz2eUa
	tsGpLLLP0w8Pb1a8JV7vsq3jfAA+c3Ii9L9aDfq9E9V7pE+xt+GPjG7BiOB7BQUrnA==
X-Gm-Gg: ATEYQzynwn6w+hb0BcW+ABCl//EpjqRuwOuChtWaz54EjNDHjpmR/9SOKdbCeCAYUyE
	2JOe4HAGWTPxCUFFTH4tRrSOwECHp22veuADYwl0ngF9fQJ7CT51pEU4AC+N1Yd5Pdq2LFZI+KT
	qwpaEHv2fiQau85A9bUctU1eg2UIheKRnMDNCs21ycmROgjyKlBcqL7Qozf0h8cjDSoiSV+GpxU
	jNraLndCNs+jjrs7Um6hklWlitS8jZrPdY3SfpXN/lXQ9ntOo9VNWO8jXP9KNG9ryiI0aDJjtfW
	nBpFz+2jFtmu7Ws9SAnudi4tn4808H1UCRiKHzxufk8vyPnPa7EywQjZ6mFgr9ZBbP6qxA7UYO0
	t+zGd2BtgCzPA2stxS28/1WXK/vBbnyFc0ywm1s/R4yaqEunUkoYFqr004xEOKs9QsfALSWZmua
	y5yi02/qrygZ7GHsTE2BeL0fPigbicPzCCLMvvMHSAI+2zaZD/KgDGwhW1876B81g9/31nAW3d
X-Received: by 2002:a17:902:cf45:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b08b40a7b1mr217595ad.4.1774030353862;
        Fri, 20 Mar 2026 11:12:33 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd36b169esm1069896a91.12.2026.03.20.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:12:33 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:12:28 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
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
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2KDEatYbSZJVfC@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
 <af4h6wh75qdvgu27td43ndlxdyb5drq2pf7tssdsln3q5gce6f@6su7ylrgomhz>
 <ab2Dkn605sRbpK5S@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab2Dkn605sRbpK5S@google.com>

On Fri, Mar 20, 2026 at 05:27:46PM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 03, 2026 at 06:41:26PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 03, 2026 at 04:42:02PM +0000, Ankit Soni wrote:
>> > On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > > IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
>> > > the proper preservation and restoration of ioptdesc add helper
>> > > functions.
>> > >
>> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > > ---
>> > >  drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
>> > >  drivers/iommu/iommu-pages.h | 30 +++++++++++++++
>> > >  2 files changed, 104 insertions(+)
>> > >
>> > > diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
>> > > index 3bab175d8557..588a8f19b196 100644
>> > > --- a/drivers/iommu/iommu-pages.c
>> > > +++ b/drivers/iommu/iommu-pages.c
>> > > @@ -6,6 +6,7 @@
>> > >  #include "iommu-pages.h"
>> > >  #include <linux/dma-mapping.h>
>> > >  #include <linux/gfp.h>
>> > > +#include <linux/kexec_handover.h>
>> > >  #include <linux/mm.h>
>> > >
>> > >  #define IOPTDESC_MATCH(pg_elm, elm)                    \
>> > > @@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
>> > >
>> > > +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
>> > > +void iommu_unpreserve_page(void *virt)
>> > > +{
>> > > +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
>> > > +
>> > > +int iommu_preserve_page(void *virt)
>> > > +{
>> > > +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_preserve_page);
>> > > +
>> > > +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
>> > > +{
>> > > +	struct ioptdesc *iopt;
>> > > +
>> > > +	if (!count)
>> > > +		return;
>> > > +
>> > > +	/* If less than zero then unpreserve all pages. */
>> > > +	if (count < 0)
>> > > +		count = 0;
>> > > +
>> > > +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
>> > > +		kho_unpreserve_folio(ioptdesc_folio(iopt));
>> > > +		if (count > 0 && --count ==  0)
>> > > +			break;
>> > > +	}
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> > > +
>> > > +void iommu_restore_page(u64 phys)
>> > > +{
>> > > +	struct ioptdesc *iopt;
>> > > +	struct folio *folio;
>> > > +	unsigned long pgcnt;
>> > > +	unsigned int order;
>> > > +
>> > > +	folio = kho_restore_folio(phys);
>> > > +	BUG_ON(!folio);
>> > > +
>> > > +	iopt = folio_ioptdesc(folio);
>> >
>> > iopt->incoherent = false; should be here?
>> >
>>
>> Yes this should be set here. I will update this.
>
>I'm wondering if we are silently losing state here. What if the
>preserved page was actually incoherent in the previous kernel?
>I understand we likely need to initialize it to false here because we
>don't have a dev pointer for DMA sync operations at this low level (though
>x86 uses clflush).
>
>But when is it set back to "incoherent" again? I don't see that
>happening during the driver re-attach phase?

This can be done during restore_domain as the domain has a reference to
the dev when it is recreated. I will updated the walker and add this in
the next revision.
>
>Should we at least mention that this API intentionally overwrites the
>preserved coherency state and that these pages must explicitly be marked
>incoherent again later by the driver based on its preserved HW state OR
>by the IOMMUFD re-attach?

Agreed. I will add a Note about this.
>
>> > > +
>> > > +	order = folio_order(folio);
>> > > +	pgcnt = 1UL << order;
>> > > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
>> > > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
>> > > +}
>> > > +EXPORT_SYMBOL_GPL(iommu_restore_page);
>
>[------ snip >8 -------]
>
>Thanks,
>Praan

Thanks,
Sami
