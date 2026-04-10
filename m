Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4164F3CEB94
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775830616; cv=none; b=bCRic4TPgww1d47UX/bFpbOIfjMW/0Mnihujm5zF40TTNfZ9M5V+UdpwEGY0+O8hxBLIAcRo055xgkpiHg/AqMkiirlATdquLI5hDrZWhyeLQrDpw1+5ZVuFrpikhNST4hvBmcdAMe9PeBPBxhkwM5j19uBPkErVWdQe9Z1Hxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775830616; c=relaxed/simple;
	bh=kJqjSwGVHtHlddEwLDzR5ggbE1iOYckpmNJiUUn/UZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqvZexmYPzyImna34cMxfPFjZ0/oqqM4D7MZvB59u3cuIPe+BzN2F+eeVQd10SVHEq0Kz0m00UAuMJHwZgnju4PqLfBLKRuHiXP5z4stkxny22J/GC8I57N9AaRuJl+8To4aUO34kEp+/5USiLUV2W6Ay7BigKFdWf9Sx9oDRg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IWenrcR7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IWenrcR7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d7e7f48499so210596085a.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775830614; x=1776435414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUmeZoWdB0ROYhfKB6+Zrugoi68cG/8aJYwj9uhE8lc=;
        b=IWenrcR71a2AWDDQF2JLa6sm0v6frkkIeZPiDW5a5ajaVlUVeYENXXtR8ebLJ9QGaD
         6CJuJQWaH6wZJioa5xa+NH8NVEXXJxyCTndCssk0rA+zrfm7gx97JJuBbPLOMvbOLc8m
         DLEnlsfAtiwddT+8i9Vb4kvMBhDho4oraHH0OUoBo06DW+3bg9rtXe8dILIV3xn/heal
         i2ABnHgg3c6ehiDCA60nU8cYLs21QdBLPornZ/RAgh8dC4U518lf0sPBPRrgqXZv3sTg
         gaFYjQVoX9E9cvZ7nA+VF9rgH6aSzZM5EFgPOejZAg+4NjLFu4UbTGRkX3URKXUTubfG
         3XKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775830614; x=1776435414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUmeZoWdB0ROYhfKB6+Zrugoi68cG/8aJYwj9uhE8lc=;
        b=ijf5lprUzND70yuAifjOtaYmWCJiwtmmqug4w4b1QpawGsHM3yrGNqZkCUKJ7wwfbs
         YmrIFWtDbGvlNB4RPFwF9Sfz8eama1GvTnTpf7455Obju+GyeKKP5W8Y4vVa+yVDOlEh
         tPbPpBivmgvV1EBa4LfA/VuEzmcPJKE6i4ApUs9UTRxvTGTkbc5uC3vUvvfb/SEsv7LP
         J4XwElu3iIRNRJ+VZMSrnjbNT4tHvHIExvzB8L4oVRkB9RMuOfgWSKbBMU8znQu5q8xt
         GLrntKGpGV7qN4HX8GtvOdKEBx8Mk7rFwRFOVwV2uDFxbjZ4v4//huczbmtH1J8RhBJ5
         el1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7adaJLZcoEn56rwJLW+9KpSOqiXjOy0QDSjCjA2dmSkbLH/yVbgl//k6QDzxEPOYBC3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HYGAMmMgV5ldlA3BiRgmz+mWYHN+9sEaYJckffGCbPAgmxGT
	SZi68j+CxWMkmQGq+tQyfXk5KlsXUZCw/SsGhPyXosCCQHp9CfXfU1YanPc7KjNzfu4=
X-Gm-Gg: AeBDievoTqSO9EnfrUYKvphRdj6OmJTLUTmciehDWRPLC1YoX6oAgerd/I/S6ZuoT2U
	O7AlkW9Y4WP4UM0En2kNNbyC69rs4MTsxBg1qcNPGbkcVfy6iKODf1db5Y7dDvq1zDw3d3vH+oQ
	tuLHdbtJkYSTsLjMxMKZRKiXohPYNNvxVF13hcHWuRFSN9OMocIPfFiofxUIN2p9jM5fkaJe3WY
	T7dAeP0humzKqi55jIH+0XxS6YQHRx3OHpqtDhyXnU4iq1Zuv2LsLOwizs2MECDuJYHRfdG2Tzl
	xf0xulRNxWcv0F6GrrxaWW1a0F7Ss6cpzNrVxS2P2lx8PHUZ7rBjHnmlq3Xb2ZYgan1RbYs//Uz
	QuU3U5BYOzDqK6hvbY/xudbfexiRS6tCZwVddllYBUyrrSKMrRd4dIsXCa7auJglUasYTZAzv9s
	dgTHtLlxMx2h0/m2REi3nyfhcdFLA7MKygXVpaOgpjjHIIS+Xle891ScXxgD0KrFE3XH1YxiraB
	NRUUeiJ
X-Received: by 2002:a05:620a:d85:b0:8cf:e152:592d with SMTP id af79cd13be357-8ddcdae4eb7mr475410785a.21.1775830614053;
        Fri, 10 Apr 2026 07:16:54 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9351afasm211855285a.36.2026.04.10.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:16:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBCfE-0000000EL76-3L3i;
	Fri, 10 Apr 2026 11:16:52 -0300
Date: Fri, 10 Apr 2026 11:16:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 05/14] iommupt: Implement preserve/unpreserve/restore
 callbacks
Message-ID: <20260410141652.GV2551565@ziepe.ca>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-6-skhawaja@google.com>
 <ab3CtC0vN6J975V5@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3CtC0vN6J975V5@google.com>

On Fri, Mar 20, 2026 at 09:57:08PM +0000, Pranjal Shrivastava wrote:
> > +static int __restore_tables(struct pt_range *range, void *arg,
> > +			    unsigned int level, struct pt_table_p *table)
> > +{
> > +	struct pt_state pts = pt_init(range, level, table);
> > +	int ret;
> > +
> > +	for_each_pt_level_entry(&pts) {
> > +		if (pts.type == PT_ENTRY_TABLE) {
> > +			iommu_restore_page(virt_to_phys(pts.table_lower));
> > +			ret = pt_descend(&pts, arg, __restore_tables);
> > +			if (ret)
> > +				return ret;
> 
> If pt_descend() returns an error, we immediately return ret. However, we
> have already successfully called iommu_restore_page() on pts.table_lower
> and potentially many other tables earlier in the loop or higher up in
> the tree..

It doesn't return an error, it just propogates errors from the
callbacks which this one never errors. So this is just dead code.

> > +int DOMAIN_NS(restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser)
> > +{
> > +	struct pt_iommu *iommu_table =
> > +		container_of(domain, struct pt_iommu, domain);
> > +	struct pt_common *common = common_from_iommu(iommu_table);
> > +	struct pt_range range = pt_all_range(common);
> > +
> > +	iommu_restore_page(ser->top_table);
> > +
> > +	/* Free new table */
> > +	iommu_free_pages(range.top_table);
> > +
> > +	/* Set the restored top table */
> > +	pt_top_set(common, phys_to_virt(ser->top_table), ser->top_level);
> > +
> > +	/* Restore all pages*/
> > +	range = pt_all_range(common);
> > +	return pt_walk_range(&range, __restore_tables, NULL);

This should probably be doing something with the FEAT flags and
ias/oas too or do you imagine the calling driver has to deal with
that?

Jason
