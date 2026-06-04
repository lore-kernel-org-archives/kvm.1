Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0A34166B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582573; cv=none; b=KyP12vbPFjH81lrnyjrYFJmwQ4z8b9NCePAolM9CA2heRlmrAfp/omyzJjkGn6pjRV2B9LiwSvfnZP6ChB/KGQFLnblVB3+I+QfA5N8aJteSOsbQnEnWbTaICQqH1Lf28tGxhBwGimMYtOwfv/l2+FAHJVd1vd0vBSABK7LcgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582573; c=relaxed/simple;
	bh=aJF1d+m4cWAoRzuU8BG1p4iKKK04toIulzONa4qjt28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+GPpTqDotnKsqj21ZzP02Tc2LpC4MnBd95hFt0Vc8J/VR9PRKxzYiOaj5F0C+kBgT2fd8rl4zkm0S3Vv5UNTB4udKDilJUsvT92QHI+wHIdmxREAHsVCf27mKMOSN6K5RzL6atksB0EVnxlTqu5MggV1ZPMd3OGjXcZyG8+9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bkP8cez7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bkP8cez7"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9156b74006aso54293285a.0
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780582572; x=1781187372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
        b=bkP8cez7qTljJ5GExcO0a9J79IItTsftIY2Cs0F2JvjTmKbWibXz7Z3QjVEWDFb7Fh
         br6tQXuPpHgls/Np906sAFQz7VLLPRw1ePZxWHHwAAquru0ZRYvS0pW12MJgQM/JzPW2
         dKoj+6tUIDiJ80w0GaEuesTUxjYd7AZE3loQ907gVxIbracPyA4ZyuaZXd077V9QD/sq
         00g0j4DYawKqd78aSDYyy2wwRrS/IhYS80RIlkCcMaahIduolUYslHngalGA4ifQDNCL
         Mre+QQSIPO4Ya0y7swi+KJ+0oYBF2cO+kXf/Tm0DOSTjC6qILdEfQXP1yd6sKOihAG/l
         8IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582572; x=1781187372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
        b=A2XHXZL+oUyNDF+MeG7o0nVKvVtksz99b/rPsxQvd0pPW/7xa/IsIje8cvZHo/ioAO
         hOE5rVLXQcHxEPXBeOatxDTxbiyezQVeUHTjfr9CCd7MQdF1gHdLJVNN8nvtzDehCfwS
         RVF5vRiO1agODtph2UZtvJiy3mw36GhxBTaruRhg2XDAK+Om1AsenxtNH1SrX5JxNBTE
         U+vkv30OCoIFn++IEFRCbeFEe2Ut/2xVmssGMQiQUel0CHmPkWBZUpUjDt96XlnnV7Bb
         rSjRQYVLYUvXP+QeTKdbjK0RP/IGAmOgyBLXmxab4YaE0YAQU72lbN0tju47ulumL54h
         tScA==
X-Forwarded-Encrypted: i=1; AFNElJ+1GeqwJrM1+YUPO6TmZNZLKWYa8k0LV2HK5eYj79x/vGpiXpvChpigK0jRvtqF2ypV29w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLI+eVY3EMWodgZe+cQLWWSon4az58PnwbyUBnPK+LMtW46sM
	MNyjNlWwghsk20mVjbratOac+Tsi1r7njKoOQUuK+KMdbrMBcGzFfEHwKjGUdWLELRw=
X-Gm-Gg: Acq92OEpiLt8mG9B7N46Gc8A6NgdBN1k8S9rukMjg/xovOE0/VaywltuFQTewKzAoWG
	WpE/fnKm6qqk/hQmwfER8eUIuvc2Q4LUv36SAtK5Za3lrXav4X0gsjy21Bd9QqHkB5zODLm5wDQ
	NsEAnEf1kbF/t2rVDTLHfA1n/pfDTJIe2IaNmqevKK5SlKPZePETgXEUO4qyOlCxF/1M24p69iJ
	rLohWwpqgbgkbQkC0gZdpGnIITEAyV119Gd8jU3UlH1IBMeFO5/U7vek4wIWp6ExCzx7DOWRxnH
	BvXe5V8yBHZejgQRectCwRMbUSbWjfh0c7UbSdaFaCovQMX/crzRS8slyI/GQkUV6XX0Czr1bR7
	Q0cwSXu0ZVI2Rhusc+GeF8XR0DCRJXjo68gunMpqw7yf5tgfmq4WZOvRid5GLn+8pD4V72BHrPY
	lUi6KKaDhNYERm5RoVt+14WperZIZ1GrtMw/6YL+sywit4vNJHzWrkdNMLX5owy4tZy9/WEauUM
	JEP3SILpB4t31G+
X-Received: by 2002:a05:620a:7081:b0:915:7b23:4afd with SMTP id af79cd13be357-9158a7292d8mr1364770885a.16.1780582571570;
        Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3b637esm580303885a.32.2026.06.04.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ri-00000008HMt-1ns6;
	Thu, 04 Jun 2026 11:16:10 -0300
Date: Thu, 4 Jun 2026 11:16:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260604141610.GX2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:33PM +0800, Guanghui Feng wrote:
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {

This should take in an ending point so the accumulation knows when to
stop, otherwise it is too hard to use.

> -	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +	phys_addr_t phys;
> +
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (mapped_length)
> +			*mapped_length = PAGE_SIZE;
>  		return iova;
> +	}
>  
> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (!domain->ops->iova_to_phys)
> +		return PHYS_ADDR_MAX;
> +
> +	phys = domain->ops->iova_to_phys(domain, iova);
> +	if (!phys)
> +		return PHYS_ADDR_MAX;

And to properly clean up the callers all the non-iommupt paths should
manually do accumulation here as well.

Basically if you call this function you get a maximal contiguous
physical range as efficiently as possible.

Jason
