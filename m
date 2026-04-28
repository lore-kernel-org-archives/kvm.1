Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA12A3AD513
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383485; cv=none; b=bkN0Ww8bQJF/EMLyWjoThv0VFrE/O5X/lHpGbOIoeZoyXSKNAHUsxCRksEik7inFi+nfCqTv5C0NvRWvrxdvZt2HTfxP97NZcdt2kouzj5f3aAWBkuhRGlEpuynYmilk1ks1zKWNRpM0OycRrzLlfMCE4EpspjaI3lXT+k3Hr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383485; c=relaxed/simple;
	bh=fZyMs6ThguauJIy48ic57lQ7RORMc9Mh6i8joTX9Hr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSJB7I3S5WMkm0dVZOOCNSeBC7feQo91qXGqPtdVh0w6SNyPPhmG5iZnGu1oT1YdM3JCV5pXd714UYACypyWYmEnPzHilIwr6sItmDYmlbmn3Z0J/gXN/X2gTRVZEBF1PWd8DZR/V+xG26HIvbL6Zse5ddGMP5le/wZlAn/W0ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GboBkd8K; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GboBkd8K"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8dbbc6c16b2so1442441285a.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383482; x=1777988282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHmUngA0Beg9PMjrunFUFdxSHW2GXtc2kWTAdD0BnF4=;
        b=GboBkd8K0nVybK22XBEF2gkuuaa0h7mQCZx4WWhb/QaQMCED/ilKPEQFu1sFU8RZHP
         wcVVPEEkQAnNDtfz4aE1isM2SHwhiX/gCFvMcIpHG3fz3pANPE9tqUZ1oGAnSaLifsNB
         /yGGi/CK4MgbNZc3Byh0y0BDsDz9H9hQTnpEQ9RoH61Pgo6KiyWVYRHH/RdKH2EqcB9r
         FhUF8XJe2XDdRUwXH72FGbqqYYHXBZZD0UlLqH1Rp0oQAVaAOu8NzF9VfFc/v6LzzTjM
         0k+hyL7b8BdMgSOigzCrsg1lX6SIgTHPIrUoQtxigpih5uXC4DuZT1w6r4JrjiDGSlRD
         nVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383482; x=1777988282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHmUngA0Beg9PMjrunFUFdxSHW2GXtc2kWTAdD0BnF4=;
        b=NXwV9Z6DUBolgoVtZ2T2hncATqfoCR9Eeivo7CYJcEtRHGNVRjUkEtD29N/NNGtLDK
         BnBG2owesDb9WAYxDKISj1CX4OoK78O+AsVWdYbCjgpB8orldR+cghWul/IIb20Qf0X2
         5zF3oV2E1BDKcrMOozTb1JGrGqEd7Wzt5KdEx5uGdu8QDqYFc7eiU2jBAd31XghX9li9
         e20f8rvC6KVvIXmdLAbMP+QPxM2WVGoiWyP16zYK1/ZXO2bm+SHOUux83vtTfJkW/AFG
         FPaQUlPVcdBfv/XaF8nUHjn1t75lKm58SwPp4C8CcYtCox5YbMouMUJrYdQOMUWi/nyu
         9DUw==
X-Forwarded-Encrypted: i=1; AFNElJ9OGgqJ+Hnf0592Y4ZN1NeIXQmPReF8LKxrULEkMSgYuMdY0S7d5q+TnSjo/gKS6Nbhpqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7tHVXN1UCESH0s+qom0Ztd9vwiuvh3uil9WkEJ4B6MftRGBw
	39NSaHt2tNqV7mKf+A74OP/zRzIaDiEFM+r/6py7AkTI1CVCRVMrqhYEZLGzFUgOipE=
X-Gm-Gg: AeBDiesRH1cWHGjy1K5mJ4jA/+fftpXl1/iuCvyDtYkwxfCUhIdN88F8JMPT94I6CVX
	Bdq0gTyETj8SNTkzkduKnYfv+YqB1KC3jp0KNd5kiqd7G6KdATwZfnjA0eeWRXufRriZ5agXJLa
	ZSKvVtw4sN0oC41yAEoL14wUoyWvsQtWR1YbhZ7aboJ5cMgZb0rEu7eu19kjXKgIIeMqfi0U8/e
	9P9tcMoYo7eZIt3JZo6Cgb51jLzVi5BIBK5aRJz3vdWjpuBn0IoqmfB3arc+dt6vOIpHoxF8gYZ
	n2Fi88ERBVZDbMXkYvcI6y2Y7sYeVK2NmzI9Vu2E9NT9fO+FwASCvUWczNb6AK1R9s/FX/DLzZQ
	myh8SnAZo2H9iFtbT5GzHyq4nOg7XOPT1sshmSFoWJqGVo+0pYkigNM6aaZdWl71XFpCRo+AUPF
	LANvvIx9G4AuYpmhik1zmuELkHYUla8OHPSx2EiqSIC9Yl50dYAi1jgXYozRn7Z62ffxy4aeYod
	C7I8+qQWTvttZo7
X-Received: by 2002:a05:620a:178c:b0:8cd:aa61:ad8f with SMTP id af79cd13be357-8f7d5d6dc38mr357079385a.14.1777383481817;
        Tue, 28 Apr 2026 06:38:01 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c4dbcfbdsm203538685a.12.2026.04.28.06.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:38:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHidU-0000000Aj1L-1JSZ;
	Tue, 28 Apr 2026 10:38:00 -0300
Date: Tue, 28 Apr 2026 10:38:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] iommu/riscv: Add dirty tracking support for
 second-stage domains
Message-ID: <20260428133800.GG849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-9-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-9-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:56PM +0800, fangyu.yu@linux.alibaba.com wrote:

> @@ -1247,6 +1247,84 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	return 0;
>  }
>  
> +/*
> + * Enable or disable hardware A/D bit updates (GADE) in the device context for
> + * all devices attached to a second-stage domain. When dirty tracking is
> + * enabled the IOMMU hardware will set the dirty bit in PTEs on write access,
> + * making them visible to read_and_clear_dirty().
> + */
> +static int riscv_iommu_set_dirty_tracking(struct iommu_domain *iommu_domain,
> +					  bool enable)
> +{
> +	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
> +	struct riscv_iommu_bond *bond;
> +	struct riscv_iommu_device *iommu, *prev;
> +	struct riscv_iommu_dc *dc;
> +	struct iommu_fwspec *fwspec;
> +	struct riscv_iommu_command cmd;
> +	u64 tc;
> +	int i;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		iommu = dev_to_iommu(bond->dev);
> +		fwspec = dev_iommu_fwspec_get(bond->dev);
> +
> +		for (i = 0; i < fwspec->num_ids; i++) {
> +			dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> +			tc = READ_ONCE(dc->tc);
> +			if (!(tc & RISCV_IOMMU_DC_TC_V))
> +				continue;
> +
> +			if (enable)
> +				tc |= RISCV_IOMMU_DC_TC_GADE;
> +			else
> +				tc &= ~RISCV_IOMMU_DC_TC_GADE;
> +			WRITE_ONCE(dc->tc, tc);

I'm pretty sure you don't need to do this. Just preset GADE when ever
a S2 domain is attached, rely on the pre-set D to avoid any HW cost
and you are fine. No need to change it dynamically unless something is
reall weird about riscv.

Jason
