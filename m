Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441E37CD51
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781150; cv=none; b=OP4s9+3BUQT4T+a584F/v3QkvS2WIIP006rvQjIjOihvfod1K61YXpLlZq7dJtKT+VyvqOh1xJFsY4JsMocuzAhqFKm92JMd4RbHxvNn53y0zELu1VmAUZ5FEprj6l/7gqzCbqdEMnS35PY021ORcvU5kZf/8XxH10Io9zeBU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781150; c=relaxed/simple;
	bh=Gg0x70YeYeS/hvsK6d03WDxTrHh/HV8HIwkK82kwBL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv0yJ5Li5XCEh6jGIYSRnlDGD1WwZWqhhx884OQrGsa3jak8m42QXRuUt6dGpdl5CmADlCWpRa5wlnWsz5Oi4Cj6RPnHt3Btq9rKjR6AAcWFae7QTyVTgfmj3z8IfpsOQ8SAXMZZrRAB4SVpbiWdjgugzzXQ9OpEm1COh8A6MK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpgAX0bW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qpgAX0bW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052ec7176so9005ad.1
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773781149; x=1774385949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXz7CkkQTRz+WIdQ5aQKBGXyXXsdoAFd36PRskCjU8s=;
        b=qpgAX0bW+78vn6WG8gxjW+m62QbE19IOPzAYzGZYix1vLaGMTzxYE61M+zGuYA3Q5k
         pRVs3EvuKYGKuPEENYM32MVH9/4w5hN4AnX+dm/eTfpR2wPxDt2NfDxfA+P7bWEhVu6Q
         DM3uFLh5OhoiONjyf5wk7Ds5MrUuKgOCCtdlk96H5ZsruLXSLiuSB2gr35ibJhcA1y/S
         biok2x8+tgrAifazjDWXnZJ3kMR1YJq+WITKOokIXcKIFPhOzRgpunRMI5Lk7RXQzMm9
         QzVwO0svBALsj8V4GRS61Ub40b38Snn6bRvESfq1OmB3l0oE96aAEtPOHB4uTmIuQ4pA
         oAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773781149; x=1774385949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXz7CkkQTRz+WIdQ5aQKBGXyXXsdoAFd36PRskCjU8s=;
        b=ZngKJ6wA5LftwlV2BIHywK9vXmY2LrSjcuH7cdFsFCNsxckoNVNfzQxHG5exTMMsik
         ZwCgM0jrRL9stX3Hu9He/ftvRPpLY/X5gTTMXHPueR7dTDePUxgniZCLPQTzrdc5L47X
         BPKUiApmkvQupthXYfW8v6l71KYoEq9KoNjiPdmz+m7UYv9hrFi9B1ZApoCqkpBXMZhQ
         bD9K9wuZusWnGw/hrAXrN/5hOn22fDeBF1WHy/HZvkqdjN0+9p7wxBj5ZCNRtIlUupze
         nn29NC1EWNF3oQTXYllZzdYeZCUkhQ2zxzl9OQMNlqwLbYHD37cHo6FZQ9/a75WP2AOG
         egUg==
X-Forwarded-Encrypted: i=1; AJvYcCUSdk1qiYRH1t1rsKpXdjIzpkzOoHuWukznIEEbUex3Z2bQTVNd5V0g3YmmSq7bHyMu5pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqK6h2w9J60vaEbNR2TYcCI2jybIcExb3vzCnBFArNZZ/BaW9U
	4M192zRw4bAzyBQXTCU/GCeU7FLr8hCbEs3SLJK2MJPCVtLqjaymWnS6eE+D6OyO1g==
X-Gm-Gg: ATEYQzyF+23CTSzDpa4D4wRilm+gIU7fshaIyz0PVSnTyYWTR3nitFO/QRCcSHoyKUm
	ldVJukdUZByaCdzngoT11XgXpLb+L55DfpsPENdrhyAAa8ayYBnGfwz7ypPxIdSrcZXTzT6qF6Q
	ptq5Gzje4tfPCiDBMtxn9iiCJ72Stdoq+oI1sOIyJjQzFIDoYgmHZ/wcSHdHbdMCRA5B9sg9SMF
	Im4/JUPz7EJX7obEjl6B3ShoxlcAqWsFGK5oH2rdWLmopZBNQH/Ufoc+tmJl0KzXwDVi27TXDG0
	ORn33kQVBbc8GoSV3qIKYVA39aQ2LMOBTD3T3RYHwAg8zSWElGX9uZY3oNroYf/SJqr+mcCEpLL
	0rF3UVL1rMegvPK8yZNI/I4zfPGvq61q7h5ozKRFEAOIT/xRdzm3JWqKEqy40eTj9m0hpq+vO3V
	3UuHz8enc99QI+pQQb0PnvHwwCENhJrAnpa2uZJau78z/a7WIDtOyYcFfFAA==
X-Received: by 2002:a17:903:184:b0:2ad:6f9b:3b2e with SMTP id d9443c01a7336-2b06f8b55c8mr253645ad.23.1773781148322;
        Tue, 17 Mar 2026 13:59:08 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bee9a14sm357119b3a.53.2026.03.17.13.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 13:59:07 -0700 (PDT)
Date: Tue, 17 Mar 2026 13:59:03 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <20260317202925.GA2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-5-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> +
> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> +{
> +	struct ioptdesc *iopt;
> +
> +	if (!count)
> +		return;
> +
> +	/* If less than zero then unpreserve all pages. */
> +	if (count < 0)
> +		count = 0;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +		if (count > 0 && --count ==  0)
> +			break;
> +	}
> +}

I see you are trying to have common function for error handling in
iommu_preserve_pages() down and unpreserving in the next patch with
overloaded meaning of count. 

 < 0 means unpreserve all of the pages
 = 0 means do nothing
 > 0 unpreserve these many pages.

It seems non-intuitive to me and code also end up having multiple ifs. I
will recommend to just have this function go through all of the pages
without passing count argument. In iommu_preserve_pages() function down,
handle the error case with a "goto err" statement. If this is the way
things happen in iommu codebase feel free to ignore this suggestion.

> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
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
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);

Above two functions are also used in other two places in this file, lets
create a common function for these two operations.

> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_page);
> +
