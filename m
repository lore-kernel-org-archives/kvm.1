Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536A2D061D
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448920; cv=none; b=irYT7huWdttXnJIqYVQlg8/Aer9bghQT+lk9niXFzN1DH2jOe/PH2I2BCQsjghan3EkxQI8xy+aKFwiHTSaHwv852Xdn97mJNT2IgkUlf7WQxgRubmHE0PfyXQynYpCa4t9C6Q6oBjdluYTDJ6sow47ZRBXos8F0kgAdskRBQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448920; c=relaxed/simple;
	bh=Ci2pr2kYm3LPu9lpXp+7i4ynWp7NmN4d4je3ZnENWUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icp2lpoQBEYDFFl58yfldmWrCVuBA5A8ciJwFUymW0U+bDWUdieI77AAFEyqPzisVWQk0YAfB8yOprCeJn0nH3CuSVf0bH86V3cIuZt1w4V6wkoaLlG7YXHwYh4gLsoOuT8EAZKTxmVFPfNHLbiwvuqOEvP5CSCVy2WOWO70cyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XS3nvTLU; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XS3nvTLU"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915767ea2d0so168850185a.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448918; x=1781053718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
        b=XS3nvTLU+r+Bu5lFZXFIjwPkmO4HA53SB1ch+AQr330tF0e88UzeAZDivLb3+9AgnE
         tJGMpcVttcz8uBOMGGsVFw4TuW/YghGI2engKQrvFa1LyTD28Koaq9W+u9IBRDKtlfXn
         GQSWn423Ug1OXZXRPCGAaNendGa1KLcLqqA1kqq2dbppXY/HlxFCSSHHI6oAwKYOKUE9
         dGGejt8Wfx9PeoMIzrAUG7nYX5yl4/GACWWQB/EGNY4GpfVBLkbpQi3TagDgJG5cDMhY
         ExOAzpXI92mDMP7NxzwSZNmEz2BzjDxZiu5+YnSm84fju6rI47bApUsVs8rEvA1WpiSU
         H5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448918; x=1781053718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b1waI30m43a9rgbDHZrFDb+c/4Zyp2tRTfYwiyzcxw=;
        b=iqZdw4YurhKYk2ffnLKTgzwVqxE/TglasIlCQ1nBiNoLVY1m4cFpUbuF1Tj+RZv6hj
         LMWZiVH5XQdPZ+lej5zg/gXaWcUjDLx7EMIrMQXXp3WMO0txfFZXm+F2JV+8hHzVwiBA
         nOaaiR4j+FuzTtMQOQHLSVCX1dS9xWs3r+LN+Puyqqn5l68lx1laUzus5YEloTRNFZPr
         yO5aAL9MWENPWodF4mWLgg3LtAhZxdS4+4AsQeKHYNBmxnPqTc/Qo2FNnDT94VXcc4Qz
         jY0tl7RpWLXu0Vz6bnW8Ux9jrF+o3bzs0jF0GLj26+XiVyaDZInFcBTSgoAeAz+kkmZ1
         GH7g==
X-Forwarded-Encrypted: i=1; AFNElJ80LryJU0lXFuqiL6iFC25L9GBk1oM8H0ZSgNzYeoLl+DYon5ZiLbvVxDa8N7FHzY+CL6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8b4EJL/rbfSs0H9S9LP+SM9O6327jrlSyJcBWAfJrSRilfcLB
	JKTnBUzk+tD6gGPPeP6tsBfGkP7lJDpARsspEVRyI1qOApqT2lH5AkRPXlbtnirqd0Y=
X-Gm-Gg: Acq92OEgPpwmaRXG1++C2oJ0VJXvWPRlSU0Bi03CAKeuqgtiBurzYax+M1Z0FxIRwX4
	fEoOZkyPJROgk9vbTB9ZMujOjE8W/26kAsaujmXaAUU3DpU6VNTBdWguqh9tV+fGt9Sv4YOF07S
	KK0CWFV4kg2sBHI8cYaw8DveBSGOk9YanaCHx+MpOlLLOmx3fgsG78uKn1iLZjgJtOgcf0GOm+8
	cN3HpshWe8ZpawTsD3itizleHy+LKKRzwX2+Ntyqk7mfAp5R5nq8bLFXpqrhaj31Lr8KtQgPNuu
	LuZThYatkYGD1nCmQ8V6+VzwN36vI0Kt4pKZP9W9HWQMMVfuXsSF9XDYdldOGHngdxst8gYd/ly
	dvNWRPo5x+kaiWTjeTG+pq2zuy4ipI3qsHqb9QPENLBbi7Gef+9mwg2FoPhFiVqSxGkm8iav6wK
	0G/NQ3Nan+Pt5SH/wo/6acn/73nGNuo0RAjTqGUg0EDcAJqkIRFDXoYkveeazkl0XGSXQflUjOu
	OUHWIGk4EH/caTr
X-Received: by 2002:a05:620a:1722:b0:911:de69:ee21 with SMTP id af79cd13be357-9158a656dbdmr268795585a.11.1780448917995;
        Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37c50bsm99840585a.24.2026.06.02.18.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:08:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUa60-00000004yEH-2fsG;
	Tue, 02 Jun 2026 22:08:36 -0300
Date: Tue, 2 Jun 2026 22:08:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	baolu.lu@linux.intel.com, boris.brezillon@collabora.com,
	dri-devel@lists.freedesktop.org, dwmw2@infradead.org,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com,
	alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v2 01/30] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260603010836.GQ2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:08PM +0800, Guanghui Feng wrote:
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if no translation.
> + */
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;

This doesn't seem right. It needs to return a mapped_length of
something that is not zero..

> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (!domain->ops->iova_to_phys_length) {
> +		/* Fallback to legacy iova_to_phys without length info */
> +		if (domain->ops->iova_to_phys) {
> +			phys_addr_t phys = domain->ops->iova_to_phys(domain, iova);
> +			if (phys && mapped_length)
> +				*mapped_length = PAGE_SIZE;
> +			return phys ? phys : PHYS_ADDR_MAX;
> +		}

Follow success oriented flow..

Jason
