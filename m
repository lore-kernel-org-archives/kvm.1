Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB56305047
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033015; cv=none; b=oli+/y5zU6fA2haUN2Vtor7LqUwmZ0cb1RkCxOCOuwfPvGGE7DU7SPfrEva5Y3roYFKMg6hHO9gwApNuqzd1ovWnYijkEQDUpEwh7qqpmTZ4LmIh7/1D2oNyiIjM6fZZRh+BhrofJesEKXCMa7CFy9jm/19wL9/peObB3gqrjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033015; c=relaxed/simple;
	bh=Q5uRXNQyxitxk6w+eL0zYDDaRm1GUZUbF3kikSQDSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIg+CraudG8BbW9NX1IeaUeZ3vFn36sICF+z0fJVomUbNugdiY7RhF3LXgmvjizUhu95IVHQLovJmdoe9jHrpAyspsl82wVJwM9fY0kokaCIFRuKWQI8WUWlNXoAK6NfDrECcsa7Qvg3BRpVHaYnkdAEhryABSbbkVA7sdQM7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFMh7Qo5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFMh7Qo5"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052562254so16965ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774033013; x=1774637813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzX6nj4ei+Q5c66+o1zUOgOGvSVephsLWbWHR4XH47E=;
        b=PFMh7Qo5jSVP9yUVTD6l2nCcITMneOuG7Mk/81TF5TQ3jW4crC5xTfemZ2oA3XRl05
         YaFGrFB8oBPVPn3jK6qIeiK+0IK6GaHnDKx9p6pNKwyTWDUhijUs9jdqxQUhtiDBLRsR
         V/jFLPxBg0S9W1wd2rnNVv32MuQArqffeqahu+elxQHqILTSEi22a1WXeYAPACII3ZSa
         Tndw88NyqEhEHEg1Tvpo4fVmjCGLc1YTM7o8yWBtGDNCxeRv7p7APfT0ak7kvupv90ZL
         N8Mmn2s7AVvA5rcA94ZvxsDUert032zdawjzcI0RJXxwbfiQjFtcr9MIOOixEm3p6goE
         cTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033013; x=1774637813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzX6nj4ei+Q5c66+o1zUOgOGvSVephsLWbWHR4XH47E=;
        b=gpdvf3zyb7vx4G7FEwC2VB/gXAqsfVd7bMR/J4Wi9k6sAk8kUycKLx3/JNBB5n5R+H
         CEUpmGQoHSrBAvs0d4PfsolJCbDNuwdWzSV/Pu4Lc4P0iUx0tir9Zb6x0PQFUOKi/DcD
         E6lWTXyTpJUvg1OI1lXPPVa9t9fCJcOlaqWkoq7ErLoF5pd5MLBkf8moslcgRjCmcVcm
         glY36/bakaJx2kh1QuRgBE2M4fYgZ3A/V2QIZTpinL1kFTQ2ra5s8RElxEykDBBZkd4u
         /xvd9OAuXhO0wVmz0HoJglj9wkO0xJsX2+LwDaSERkjkprcXMJACL/nmDku1uoXWtG7+
         X7LA==
X-Forwarded-Encrypted: i=1; AJvYcCV4/rr76dMg0RZE+HQod+jhHendp4am598hCAJ6fAkqSp8kjv8tkcgkf4bg6hBtnsqsjoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx64vcK+ym+tBRMiDSops1E1CA3E33ht51b9a26Xm60XeJmCml
	B/i0yb9RZ7Zg9gpTpux0yo2Cr8/dHMFfGA79SsvvgLRerBikiaeEHPiQ6CkltpYjeA==
X-Gm-Gg: ATEYQzx0XDFo1D0HF0F5YIvyrNk9D79mzfADUiw+xfKskHezvqoOiCFp+1Xhvc349Ku
	43z6B7u922V54hImW9yU1uIa7p4ir8MPm+HikKGhE+aCVge6PGhIYh8qMczyPv77uf5plkMQlnP
	jXEkuCTkxENnFvFdbMtdADIadSWpt8j18t1HULP+PvOeIjff9XMFawVymv4Y2uKWTFAE9gb8qXh
	T6bNaoQdJqdGUldOznRarx3P9+E3dN78Yt53DsHIFMNZJ89EWKd9AzrNmRCOHhktkoEvwCgCQQM
	7nqyyJaoIRJYxa5cKoAj/uAlmSQyn/4bbJBuPnKqrzMJDwo7VK1MGnkPWk6x65jS8HrCSl+9Cpl
	xBX96+hC18eHrzGMpOFHnDe2QCenIyjzkOcEbOYOaamw//Bi24ZE72x0Uxo6Bp+xvn446/mlAV+
	U7qYUVkrEM+z1WUmA267/WD8HaO0QwRLw8JEQdgUgVqowP9ClRQa79zH/RZ7wP6Q==
X-Received: by 2002:a17:902:cf45:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b08b40a7b1mr321455ad.4.1774033013040;
        Fri, 20 Mar 2026 11:56:53 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8186efsm2341998a12.13.2026.03.20.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:56:52 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:56:48 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2SoJqbwyL4luaw@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
 <ab0pBc2-Yr7qo-2G@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab0pBc2-Yr7qo-2G@google.com>

On Fri, Mar 20, 2026 at 11:01:25AM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
>> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > +
>
>[------- snip >8 --------]
>
>> > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> > +
>> > +void iommu_restore_page(u64 phys)
>> > +{
>> > +	struct ioptdesc *iopt;
>> > +	struct folio *folio;
>> > +	unsigned long pgcnt;
>> > +	unsigned int order;
>> > +
>> > +	folio = kho_restore_folio(phys);
>> > +	BUG_ON(!folio);
>> > +
>> > +	iopt = folio_ioptdesc(folio);
>> > +
>> > +	order = folio_order(folio);
>> > +	pgcnt = 1UL << order;
>> > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
>> > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
>>
>> Above two functions are also used in other two places in this file, lets
>> create a common function for these two operations.
>>
>
>I was thinking about this, out of the 2 other places one is
>`__iommu_free_desc` where we are supposed to subtract pgcnt.. but I
>think we can follow the -pgcnt pattern we have currently and add a
>helper `iommu_folio_update_stats(folio, pgcnt)` where we can pass -pgcnt
>to subtract nr_pages? Something like:
>
>+static inline void iommu_folio_update_stats(struct folio *folio, long nr_pages)
>+{
>+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
>+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
>+}
>
>@@ -86,8 +91,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
> 	if (IOMMU_PAGES_USE_DMA_API)
> 		WARN_ON_ONCE(iopt->incoherent);
>
>-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
>-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
>+	iommu_folio_update_stats(folio, -(long)pgcnt);
> 	folio_put(folio);
> }
>
>But I'm unsure if passing -(long)pgcnt is a good idea?

mod_node_page_state() takes last argument as "long" and I can see other
examples of passing -folio_nr_pages(folio) directly into it. So we can
just keep it as following:

iommu_folio_update_stats(folio, -pgcnt);

I think it is a good cleanup. I will update this in the next revision.
>
>> > +}
>> > +EXPORT_SYMBOL_GPL(iommu_restore_page);
>> > +
>
>Thanks,
>Praan
