Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B50385D94
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583229; cv=none; b=dMoEHxkt0rtvlYgeLN0/bTUH40ZbBHlGHD2S06we238txflPKzgNCWFMrrpMHXwqgTGFUYvwYvpPsbGhHNITw513QN1X7xcVXwOuQR8OJ6WBgf0n841cDIoT4T4IdvVa2PNA5H4dRJsUPI2MXJD46XMHvhPlqoJPQDmi90vweDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583229; c=relaxed/simple;
	bh=R5hMbnNS12FEIZNlNB/bpEoNfDKSllPhXOnCYKccGQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvH1/u1TluhP6dZ9AKc8Jji61AUPJBskNAbXqVbsL3xommmNIncgbFR7OuPHUrYpwl9pvRUQEb3T87iK6XTspY179X41DQGY/MHscpxinOEQUb7fdxuL8dZmvN3/UW8snKoBCaexykeU9z7Zve6c2zB+0N9PlcRSmSDfTJ7X42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MwQnXCOP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MwQnXCOP"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9158629a220so90026885a.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780583228; x=1781188028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
        b=MwQnXCOP+LvWok0Hr0PwjGnqYw1RtFxMu1DnDWOitZjjZ3ZBZO35+8hK2SaH+uAN0l
         H/J5FqHZwzpgauCu8aQlj5Egy3aSVT92+WLAdFxcWsuGyt9PyJt55KFID60sklr+PYTU
         6nveCpXV6KIbRtznYf2KijiN0seBclxi7oybxFalklmt6XLtZnAjEJV/rtB7eujd4msw
         iklgZVxbIwWw5B6/BwiEy8d5OHCcL3xdryqIaUWM6Yvy1Km2ZDLVwa9cp9aEuSi4bKTH
         gKuGKOcL9NSmFD1KPM/S9Oh7W97fvXAWSZtjtPCcrtZ+bxz2EXcVknPiCzydkz8mQ5Z5
         UjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583228; x=1781188028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHKibgV+RCLusPgB3KbLwXXB/tqYgf/ZSAW8CwOeGIc=;
        b=Wkl8VDRre/QXHNnBqSA3Wv4AQORs6RCLvUr14zhzL5ozjexlRChPaYApFzJoGP9WQo
         yaaYb5iGrlMJqBeWLKqKa3WL/igzqN44mvVSKcULquVgzbSDnLDMdlfT5feZ6/f7SiL8
         9JwQaAl9c2PU5Dq31VN1Cw5uOj21mDwLpZMwLprJ9/DOFxq6eDyNn6/HDEFIBnySZ3NW
         OBTQLc8K4iFGo/fPnrq6482V6+tdV4odw2IGJNKd1nip2dKFZs8kxE2bD+zm9fL1sn27
         /elLie36LMTWIaZw33N5hTSmM0/vrYbUbSb630Y7yjair9NhP/Z+maulnr1U2NQeG0+Q
         fInQ==
X-Forwarded-Encrypted: i=1; AFNElJ8G8KhlC51VBPbSE5msInMa+hU8hAMVQ6KmrndYA9hb36vGDjOsMUXM4riCE2IXG8p2D6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuRO4n06kESEgtnyuJW3UanedLtaRqlBHe+TRdA3z0hlBVsXy
	wMzn9cNWCHydeJnI3kZT10GJveWP2yLCiH6kpAc7suSqyVy3yzDuW0UxDSYK/nxib1E=
X-Gm-Gg: Acq92OFMkzEfOD29dXE2QlGdM4huQ5tNkYtLab3izKKP2M+jvoD7TZ+ZGQfdra5xF4v
	pxfPuCKequQ3m8WUL2Ntqi/Cddn6h/bl7LXPOJOEsLagDZIVuxVxflI29SRqxeH4nHN42SvkwF3
	XIyKJWb77ILnCD1ZOAwC8OBcW5uxxCHVQwLswRUUKbiasPRzKe6sUT9vHrVnC9+Qpt1tzS1W429
	+cdh80E3SzOgSb3PFiLPc/rhQwXkDsA8HcwNpSOon9vg3jJiwz/XYzUA7sWq0VOSCEmF3Y2HVcB
	b8sUigZtsi5kyQVkmWcxhmCdUs0DI/jFH0d7Ctn06L6OgOvKu6N04J/V8NgALdPubmdfRq9LN3S
	Gpk+XFAQXTeTg9MT38Uc3qjgl/gtt0qdy5HaBW0plyQJbRQi6kygDr0XScnH1fUkUekAbyiKLgo
	Aw6FXnP0fsC50lq6NxSTU7khcPewYWlEyjmn023Z4F/aAUi3pnUkIDF//vRTI5V+ysPdYccqH5V
	IGYbdatILUACpKbFhNw0KMmeYA=
X-Received: by 2002:a05:620a:6cc2:b0:90f:b39e:ec8 with SMTP id af79cd13be357-9158a6998c8mr1313811585a.17.1780583227568;
        Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3e0d55sm600410185a.43.2026.06.04.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:27:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV92I-00000008IGV-29F2;
	Thu, 04 Jun 2026 11:27:06 -0300
Date: Thu, 4 Jun 2026 11:27:06 -0300
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
Subject: Re: [PATCH v3 23/32] vfio: use iova_to_phys_length for efficient
 unmap
Message-ID: <20260604142706.GZ2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:55PM +0800, Guanghui Feng wrote:
> Use iommu_iova_to_phys_length() to get PTE page size, allowing
> traversal by actual mapping granularity instead of PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index c8151ba54de3..115d88d7003e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova = dma->iova + pos;
>  
> -		phys = iommu_iova_to_phys(domain->domain, iova);
> -		if (WARN_ON(!phys)) {
> +		/* Single page table walk returns both phys and PTE size */
> +		phys = iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
> +		if (WARN_ON(phys == PHYS_ADDR_MAX)) {
>  			pos += PAGE_SIZE;
>  			continue;
>  		}
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize = PAGE_SIZE;
>  
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * mapped_length already accounts for contiguous entries
> +		 * from iova, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len = PAGE_SIZE; pos + len < dma->size; len += PAGE_SIZE) {
> -			next = iommu_iova_to_phys(domain->domain, iova + len);
> +		len = min_t(size_t, pgsize, dma->size - pos);
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;
> +
> +			next = iommu_iova_to_phys_length(domain->domain,
> +							  iova + len,
> +							  &next_pgsize);

vfio should not be calling it twice, the core code needs to give the
best length as efficiently as it can. not open coding this in callers.

I think I've said this three times now

Jason
