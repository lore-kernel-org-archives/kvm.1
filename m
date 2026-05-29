Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D2C3D902E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055482; cv=none; b=DSkpZDwD3xpo/hafYpT3Xgmban6Y0bqlN4cjlJTwndA4IK1MH67onPgNde981sq+HoSNa1Q/gZkRhBFSg/HZbsJ747LFMIc7/OnpD8FtmCDUu3gpzL6zQW0ChXzVYQRqgrDEt/5DMQIEPaOI3i/njJsdOg/VHxEAj9+UYqwgchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055482; c=relaxed/simple;
	bh=54vAzaIEYqsXM3xuiGWXl2HbeuhzM33ptPMT3OM8+FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFW8MD4SCcp8lyeANgG+GIsNKVe0Yo4hQtp9zQ+hv+oWqfAHQJQQ48+hKjC4AB/F+0UnyjtZT/KlcieDjdxz/9Za/TIpcQt58yAobd4wttooJeeawCwBeTenDWFXzUpgjgkPmq56Uuka8XUOjjoW1yoeDMVsgdgybhfpsq9F9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nnHv6LJe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nnHv6LJe"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccea53f35cso4449446d6.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780055478; x=1780660278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MawsOr5g5TsZEGLcgJS401SzBvbOX6ouP0Fchc3e/Ro=;
        b=nnHv6LJehQFeXHR9/Y2SMmJ+oPZJtGjG1k2lSfSoHTdL2aGHgg7pUNGXXsIfwkqrK8
         G4dp2tNvwBJDcI/lnIBco2+/1mFZpHVpxOB0UwMrpU8SjvLS9zMCXiac/ucr+5A7YFNM
         lSfdag8WR4FEhslRDpS1ToPHA1f03nwF6WrVsWKrb1PgXpi2f2PR1heL5TAV3KGih3Ai
         MQ8NICS2yk2T3oCIe3sZDmnahfkp230bEU3ND0xjsyZkZeuaVVttthwmEoEfghV/goHZ
         aU01gJ15/kNGQnAWlV77Wk7wLOCP0Q2PKekVcbDa6uiHLHONsTKTMPh3jYgwQCBFLWbQ
         z4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780055478; x=1780660278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MawsOr5g5TsZEGLcgJS401SzBvbOX6ouP0Fchc3e/Ro=;
        b=PsviqCK7AtcbGLTXYb/EGQPRWoqs03zNvgDAOTx9DSrI8YTrIVNC/ofHTHOLJTvrWn
         33UezD+snGIa+6vVaUjsdhoPiBGFwRDLabERogmJg8tzFuaFkDnQVjKferO4ODArIpOp
         Mb3tv95RPQIzjvtSTo4041Z1UzMA8c1uWCQSAY3eOrLQgy+orU9Lfd1HaMpNE2P8EFiV
         0JY0Bam2Rhpvm8My3sFxrtE0+6LpTO0VlbUrtQzsEOk1X5epEJrr7kSJYfFhO0SR5eZW
         aYnqNIfJ26NdZ/i3149j2AVfwZ8az6aZj8ocbHMpBCu/bQ2Jmy5t9VWQuU06pzxCg+UT
         bICA==
X-Forwarded-Encrypted: i=1; AFNElJ+Q96WauY2IZI1viontewoPy0libimJs43a0mKZw7lIEsmkWuB9nyIGndOXkeiLj5uO85o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsqDzuKUD8ExS3kXIcLx7NbP43zh+Wo4YkkI/rO6vC1wytcgf
	4ItE/clAtatjnUp4N8NincYLFdKquL+SG8Vf0Ag9d7rIAbrwuJ7ophft3jkDzp/76Yc=
X-Gm-Gg: Acq92OGnSKv8J/UqJPr6z6ehc2MrOpsw9No81TjxAEJ+Le2MJ74i1nmewVwIa/K/hxy
	d2t+2wqEzIUMXcnGDfL4uq1qA7cftC6KI1sWfPz1qFPqPe5/25bRjyuzPYIp/DOb248yCcOwvPZ
	v12Hck+D7pPBVaei2sn2u0guAESE46oGlcE1Pu6eW7oB2V6OF/0v1Nlr66hqfXL0pRYnI0vRmyY
	9F3O5lmolxNZtPapU6PvNO7Iftl8UGh8WjAEzp1ple8hFCJRzHW3Iez/1VC8C9uLeTavwrU8aLQ
	61Lq4q33EnMgHtm1mq4/NWYkPp6AwMlNGWcZSlP/LZIsBwZXoRuw7DRMoi3PAkjml6nMYN2VP3q
	6+PV2V9k/mI4GcgmIc1NiIeGYqmUYNHzqUiYcByFrxWCiP1vWtwJe/RKqB+EOO7WyxKcJ8h8KHW
	VAMnpae/RCFgSJ4OKbYKjnaxgpsKIhaZulKVC/vEDE1yuLOHsvCIFKYQj3BccBtIZMJK7mFYQ2w
	y/ztPxiST1m3Va8
X-Received: by 2002:a05:6214:3d08:b0:8cc:e14:9594 with SMTP id 6a1803df08f44-8cce829b0admr31409816d6.33.1780055478649;
        Fri, 29 May 2026 04:51:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea0451c7sm12666566d6.6.2026.05.29.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 04:51:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSvkC-00000000SKF-3RtJ;
	Fri, 29 May 2026 08:51:16 -0300
Date: Fri, 29 May 2026 08:51:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	alex@shazbot.org, kevin.tian@intel.com, skhawaja@google.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH] Optimize VFIO and IOMMU mapping traversal
Message-ID: <20260529115116.GR2487554@ziepe.ca>
References: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>

On Fri, May 29, 2026 at 03:09:32PM +0800, Guanghui Feng wrote:
> In VFIO, vfio_unmap_unpin requires performing iommu unmap and mm
> unpin on the address space. However, VFIO doesn't record the PHY
> address corresponding to iova, but instead obtains the iova-PHY
> mapping through iommu_iommu_iova_to_phys.
> 
> In IOMMU, under conditions such as address alignment, it prioritizes
> mapping iova-PHY based on bigpages. Therefore, during the
> vfio_unmap_unpin process, traversal can be performed at the
> granularity of the IOMMU map, reducing the number of
> iommu_iova_to_phys queries and significantly improving conversion
> efficiency.
> 
> Therefore, an iommu_iova_to_pgsize implementation is added to the
> IOMMU driver to return the pagesize used for the iova mapping.

This is the wrong API, what we need here is an iova_to_phys variation
that returns a size so physically contiguous IOPTEs can be joined.

>  drivers/iommu/amd/iommu.c           |  2 ++
>  drivers/iommu/generic_pt/iommu_pt.h | 53 +++++++++++++++++++++++++++++
>  drivers/iommu/intel/iommu.c         |  2 ++
>  drivers/iommu/iommu.c               | 25 ++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c     | 17 +++++++--

If you care about performance use iommufd, and patches like this have
to update iommfd too.

>  static const struct iommu_domain_ops amdv1_ops = {
>  	IOMMU_PT_DOMAIN_OPS(amdv1),
> +	IOMMU_PT_PGSIZE_OPS(amdv1),
>  	.iotlb_sync_map = amd_iommu_iotlb_sync_map,
>  	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
>  	.iotlb_sync = amd_iommu_iotlb_sync,

It should be routed through the private ops structure, and even if not
no reason to make another macro.

This would also need to be split into a patch adding the core API
function and then updating callers.

Jason
