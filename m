Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9F635B63C
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271919; cv=none; b=qVS5zbg/LxisnPsJPptLO2UtcDEBHfGtcux81+xIcJtCBIzKJAr7KCJ5LrN3jWav1pVAfi7rI4iAOX5OAFWFKQFO6La8HN50cByUnZ03qo8Uw1K4tLxcxW+0oMoJqckSRWTwx7PwXzM1Iw5eC31maKwzQm7Jye27Dwiqqq9P21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271919; c=relaxed/simple;
	bh=ooYjiyJ6bESeHmXTkdx8VEEz9XJkeLo2Rh6zUaPq15U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j26Sxuq+UM+FJXzkC6hTV9BSNRtjz982VyN1kOpLJjy5RNRaWhSK25+3/8GiDdQQL6yMvZ4YlIaG1+yZahi83d4bhTUjLceEVtNSx8XLrJ55ldob7L8ZMlCgPw38KLOeW+5e69HxL68cnMAco4+9ZKFQTq+85PmDBvLs2sVT0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dbSa7QpQ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dbSa7QpQ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91550eceb4cso81477785a.1
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271917; x=1780876717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
        b=dbSa7QpQSCIRaTEyv4Dl2wlQd7AOtrnoXzin92ac5CGCF7lAz6V1rkhE6RuyqFX86b
         fWE2C6sey4Ar5iljgqC2iYHETLz05MxQlg3bjCHBb0xT6pieYwbckyMtAgqbD3SD43EB
         PpSqMva/IdyvHKQnT6rOmXd0dgl+KIFVgL5YkkAPCGeY7i8LJ/Rl2hy2vj/LGHQtV9bz
         82ai3qc0CMwNi9y6mcoomoJ/Ai1UhsdI/tck3KDVnTWRxN+4olAEoOgnN0oiXH3ZBU68
         PkHOgv1blrEalsYRWq2ysvKCIBr0u+15tgFRWg5jXNrZjvXacFXUh1WCjbnRFbLn1N/U
         4ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271917; x=1780876717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTfGHM2qB3g/FLyvX8FCIrm9+eNCgSr89Naia4gruos=;
        b=jwCGI2tAjCpOVLTd73gfYq7h/j2bwOSL//8imJpfwRvJ8VhqI4KvnrEbiN4wuONVWp
         z6SRBRqkZmnxC5K/eI8YQJeiAdZEAJ+i0fIhmSsU5EjOR+Xf3eBnoojWHDUDXcjH2l2G
         XK/H6XL8HS6PiXLSFjqmqQK5rWR6Q6lAgV3nldII6EvSdJQwQa2s4bg/ZUXx6Dg9pigk
         tH8VCxRhx+WGkH7Ka+zKV/xIulAsJYMLoXWKgXcn+53AMAxXisWH2JhKGQRI4CiDvi4m
         xkTst0pNC1pBOjpERulucktwifctK/wqDWTbH0HVkAcP+blr7qmukTgwNaLcrH1zyPLz
         ca/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gdGO+frecmtmC+1AOYRiwTslrtMA6OQNDnHpIaaLv9Ky4ffWnEZqGYwGq66bJ1OOTc4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbOsApTfIeW99MajsSwH96WuWjfS1iOpxRpA6XW/AQgF3PbHk
	eHGM9Hlu0NRmcRqmlDjVJIMIbhmL9QBlpFtRCb0i77dVa10sN0l5RKYY4t3I4oHHoVY=
X-Gm-Gg: Acq92OHGKaaXR7crgDbzXrU1YImXFhTuF8Fu7lX5aNahbESs2nZYSNAaquVH9NwfGoS
	bS3zqTB8Zr4tvPqjhSsOtfdYm6aOAgYZiLzu4rmI2zsf1/4XhpzlkENMGN0D3IukRYBO0D6xotb
	iaQzKiWmK24VkKJwC6HVNRAyz0JPch7NSdNPfIzj4Udw49IX0YRd4asMx78fWtoPcvish6KVn+q
	e29G9SGfGJNKViVtPEwYdcoAsdndM5jsOdg4itPbOnZFgtwY76M5+24qhhijSqE2md18RrXQNTJ
	oG/MCUOChUhRyB4llFbu8i/xg4y/O++rUHY/SSK7nuF+ssJYGyR8zHCxGnWCjiAKJnVw+PykNa7
	8rs48D0S+2lWtGJRYKty2kDpjERBTVJpF3OZAcvWOtktXdgoOHgG2EE9c3g2zOFuv0JwpaIfVw2
	KqgswCnjkXo/FlyHUZ0uTSHJ9bWPebNFUWhqM947CnJWc7mVI6Yl4wcL5Vxrwx6ptnAgn9xFKJJ
	rhzcKx7ztK68l6Z
X-Received: by 2002:a05:620a:bc8:b0:8cd:97de:bb52 with SMTP id af79cd13be357-9153d9703b8mr1495082185a.22.1780271916895;
        Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262e2a6sm837284285a.40.2026.05.31.16.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:58:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTq39-00000001Lt5-3GHA;
	Sun, 31 May 2026 20:58:35 -0300
Date: Sun, 31 May 2026 20:58:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com
Subject: Re: [PATCH 7/9] vfio/iommufd: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260531235835.GX2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-8-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:35PM +0800, Guanghui Feng wrote:
>  		/*
> -		 * This is pretty slow, it would be nice to get the page size
> -		 * back from the driver, or have the driver directly fill the
> -		 * batch.
> +		 * Use iova_to_phys_length to get both the physical address
> +		 * and the PTE page size in a single page table walk, allowing
> +		 * us to skip ahead by the contiguous region size instead of
> +		 * walking the page tables for every PAGE_SIZE step.
>  		 */
> -		phys = iommu_iova_to_phys(domain, iova) - page_offset;
> -		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
> -			return;
> -		iova += PAGE_SIZE - page_offset;
> +		phys = iommu_iova_to_phys_length(domain, iova, &pgsize) -
> +		       page_offset;
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;

It is actually a bug if it returns something < PAGE_SIZE, it should
WARN_ON and try to continue.

> @@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
>  		if (WARN_ON(!phys)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (!pgsize || pgsize < PAGE_SIZE)
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Calculate remaining contiguous bytes within this PTE from
> +		 * our position, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = pgsize - (iova & (pgsize - 1));
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;

Things should be arranged so the iommu_iova_to_phys_length() always
returns the best length, either because it called into iommupt to get
it or because it accumulated internally on an old driver.

Probably to make this work well the API should include the last
address to reach so it can stop iterating at the right point.

Jason
