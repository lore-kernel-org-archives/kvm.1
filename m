Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7756538910E
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004498; cv=none; b=iW7uJZxQC+mdC/HG+lHoJDx3MVsaip+zUHNbhVBfTLOyzyo+SNpICjRZYumQA7L3HEs4x4E1bhYHdzIlv6UWcVCM+1TO/4Wtm1Hjkh99M+KOp3fzMlXFvAhx1I1erbIiRNsAHck/B504ZHzEOxHyalyBoe1zFBxLn9iCZuqQaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004498; c=relaxed/simple;
	bh=I+b2MfTUl9PUVONvxyAi7SYFGR42FhHD/i4tetAjZ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7UANucMPg0SRt6hADG9cm2SrlfKXHtt9GkvspR+a05IAxQkhT86dbjQWzaPFVmgu7BwMIVNWHxLmyk1qQl0TDS/Ia1XE+JcW5jX1XDqOh8EyxlP/jhvP9wJ9uy1Y1MefV/kknzMp2W8T7QYArh0X5paqUTy2LU/NMCmbFq9xhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPGauvzB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPGauvzB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aeab6ff148so60905ad.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774004496; x=1774609296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4IpdhMaTzIZMDXUfszWTAYV9iBNtcbdIph6j1hYbzE=;
        b=PPGauvzBvjLYgMAgPwdSLcxxluXoJTsgeduuXhNBZx7a4bFZ4bVR6cWOwvnrcAaYT9
         UPdj896D1wazYRZFjyjNKH7k254rInvN/dv3MXHi7XdQYKQO9nQVMTyVTlzhGxWEciXu
         +W65lcYB4GaVKiY7PeGCA4vOh8jF4FTwg3eZ6uVgjQi5jVpuJO6HsPAe8StXprby06N3
         C9FZoHhgue03wzNDqBUHGeeZDJhVhHCCdejAEI+d4dZzeKmLw+1c03n5XesR28iRR4vk
         1cISYigy2Xfvd8SOGC34Lhj6P0bk2X6ZdGeEl6GTFNQBN8wlunZc6gctL2eGV6zOrJsI
         yLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774004496; x=1774609296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4IpdhMaTzIZMDXUfszWTAYV9iBNtcbdIph6j1hYbzE=;
        b=s4AaYZR4zJkAh15y1pVRZMlHzAKy51Gb3Pb5Tqi68rMmJ8fVdxVP244HTSdMURm+8J
         +PnaTm5HiqNhmko1pczBYQtfvIVB91/XreRycuQiKLkNzliwz0tawSMH7cFNpxOwKhyC
         SzNPsDE4Yw3vaKBcgzFy/pjrxKFZiZ56D2AyB+RaLC1aLbsBYHS6RAHt7+WYD6uo7tp6
         XoiGSCPOUVZYDNOKFed4gecWPQ7CQsaOtcLchfsHx7gP5lTJjoUCuLkGBc8Aa8GQPTnu
         MEt/ueA3b+R9WWevMD39pmaCpwN3zkD32ZvvTN6QYrenXS2Xd0rXXaCn43UhOChB446D
         dmXw==
X-Forwarded-Encrypted: i=1; AJvYcCV2jAQGf0dmgdDjejZHeFf4C3SEpOxzeZu3kTHqhuhcxJSZxHX5b3tyepSKweMkBIl7CTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdNuB3avTAHxBkXQa7BCezwHpyZTuwOmHNykukSwbgPBY1C2y
	D/WQo5DItI0eM3Y3ma8j9oV3pk+374xrwozS0O85EGVWnBU0Kb5g5hKZl4uixmkF53R1a+IxqFc
	r0XdJsw==
X-Gm-Gg: ATEYQzzc2rXXgGJo5DAFBo0cswk9KrLRikLx50Esqpxcukrfk3qKXusIeTVhozxdsjl
	qEkwO+C6yLEKxk83VbT+aAuBA8DEYpsQ35R+oedy4DOvDVddiAsC7sfRTLx3AxhFSEXD6LQSRwQ
	LWP2R3KrQvK8xXI+mDP3PrwSVEfsRxOPuodrUAWi9MKu5/tZ0Q57Zx17FlRje8oOCN4vT65URpH
	IAZ7X8cqZIhlJ4USmCUnrZx7EEjCp5fN0cuEilCLyxRHTUXDWbYR+t3n02Wtr53uiMJgtT+rpod
	yPlmMBe0O19EgwSxdmNFUGV/cyNbtO25zyTMH0l1kLZBg5MIZqouYAbcrCml8psopPZISOhlwDb
	HrTJaQNg/dndbSQbY+xn8s80d+L3/Bs8MUUq7geI522eDOm/R0pgFElEqmf6LVZpKJNGvIdB0rW
	lHFLNavh0f5EbGj6cIgPg0dWE2E7qRtf9hX5ffQyY5V43losxlcrw7h9cGj0gY/TI767Z+
X-Received: by 2002:a17:902:f68b:b0:2b0:7a9b:82f3 with SMTP id d9443c01a7336-2b0828558dbmr2679785ad.8.1774004495106;
        Fri, 20 Mar 2026 04:01:35 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0410b1bdsm2240439b3a.57.2026.03.20.04.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:01:34 -0700 (PDT)
Date: Fri, 20 Mar 2026 11:01:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
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
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab0pBc2-Yr7qo-2G@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317202925.GA2582517.vipinsh@google.com>

On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> > +

[------- snip >8 --------]

> > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> > +
> > +void iommu_restore_page(u64 phys)
> > +{
> > +	struct ioptdesc *iopt;
> > +	struct folio *folio;
> > +	unsigned long pgcnt;
> > +	unsigned int order;
> > +
> > +	folio = kho_restore_folio(phys);
> > +	BUG_ON(!folio);
> > +
> > +	iopt = folio_ioptdesc(folio);
> > +
> > +	order = folio_order(folio);
> > +	pgcnt = 1UL << order;
> > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
> 
> Above two functions are also used in other two places in this file, lets
> create a common function for these two operations.
> 

I was thinking about this, out of the 2 other places one is 
`__iommu_free_desc` where we are supposed to subtract pgcnt.. but I
think we can follow the -pgcnt pattern we have currently and add a
helper `iommu_folio_update_stats(folio, pgcnt)` where we can pass -pgcnt
to subtract nr_pages? Something like:

+static inline void iommu_folio_update_stats(struct folio *folio, long nr_pages)
+{
+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
+}

@@ -86,8 +91,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
 	if (IOMMU_PAGES_USE_DMA_API)
 		WARN_ON_ONCE(iopt->incoherent);

-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
+	iommu_folio_update_stats(folio, -(long)pgcnt);
 	folio_put(folio);
 }

But I'm unsure if passing -(long)pgcnt is a good idea?

> > +}
> > +EXPORT_SYMBOL_GPL(iommu_restore_page);
> > +

Thanks,
Praan
