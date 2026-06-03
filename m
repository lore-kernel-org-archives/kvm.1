Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282D2D7DD4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780449215; cv=none; b=a5Smp0n7ppzQbht58NpfJeUiGcfO5PFdIROkT+aXZAbvFLk2S1YxqYh5ub3u0Q/L2oZY8mnFTlW6gYyvxFa+iiOt2TYkAi27gYQAvXcyUcuWHvq61SvvieuXDoC0m6sA6VZobTmhpjMPCZG0dNiCCorRUNBcPrX3wXEOeWyqBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780449215; c=relaxed/simple;
	bh=fDpc5Rrx+kA7LyjzAvSZaX9/CYeYwurvx1OcubUNZ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNInywjEHDO08UOACu8NCZfa7MucBn65u4nJULYS7IOv2tXNQ6k5Tdx58Caz6EcVAtTwF1N+XN7Lk4qrDcMdBKuT2N47VqiWOeCJgQdh7h2ybztpk9GVXmEnPxrJ8Jg6EZHGFUMfY1zTCyMfPqsOcX9VeamwwrisGN9UqpPhd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jAdvurlx; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jAdvurlx"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176fc0cc72so11481471cf.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780449212; x=1781054012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
        b=jAdvurlxdGkdnRc4tOHKimJlgXi45EIpqUQfn6c9klp04/kxN2LO3Ap82X7otroE1S
         ntL9uIH3b7HF85Ux8nidq0XlTIFmjBPx6Kse/F6tSUN8dFZJ4QvIdS+D5UclDOUqlY5D
         XQiZ089pZFXSLKnvbQwdKE+b4PYaVd/a1iNLLhlG7zUtdcqNuh2/zpeYpv7A9CAvjcE1
         wM1Dg5RHpTZsvHDr3cYoo2GB1MXwmYxP0heeyFRcta5OsnXCP8xGrwhRpYmmKjfWmGMP
         1KisWityTcwSMJTGG39FjAo0kVFI/OqyWkirYLnAUNPK2HNkkULP8PzBiP/dckcSuZAb
         Egxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780449212; x=1781054012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cdnAPJ/txGMdC+542Rqoyln86KAovKwsF9QsCq4AEY=;
        b=X5OT24vk/w3BagZh9FVebQWu7T+KpTsl+5314cvtQikCxI5TWBqAsfgcV/0s5Eo4K0
         jT+uwBSeKuaOf5DEB4XgMpUsJR594q6Z8MzW0foj2HDGPnWmxUlv0qTLj58ieqw/0sSY
         TW6+34y8Qu0lflkcF7K4MjK4p4p7rCy4tmaiMcX/Ts7mtE+Pr8c3Yg7QednuU00J4GVd
         ws5BbfS3pxHRKe+cFfv8vDUlfiAp3srb2q4FFjP7kM4YBPB/oNZEdpgqV7uXl7Bhynk+
         QClTyAF22MCXRbAG5Y1RbUbBkr4G62iGTH7ybscCoT2rraE6G+QJB9I6rqryO7m24Hu+
         XqHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Nb325hump2ndnMalNZVOxnMEzvXoU7cJjAQAckjqcqQ7QZQjaO93Fn3E+azwN5YGMerU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpNzrc7iWe3+Kb0D4/dfic5jBxfsdyzth3jt7wOwXeUO9fOO2
	R1FWBnEIinP7pC5i+JmiAEZkULw2zJUz39r2srk7Y82jz0vRRVAfmFlUuCLpgpbrHbs=
X-Gm-Gg: Acq92OFJ9p0gg/idhytFC2UsHszZLv+5uyKlCQCx2ZfZwHMDa9R3TjkJDI9Kcjfy8WF
	na72rtM1cFhrHIbZ2AWRgDRYsy9YPB/TtHtpNBwg7/KTzf/qPJP+2tZTjMfXdus/ToLYHM/o9Z7
	rDtxBzLs4s9zvVfXOM6qAuNo1g51A9d2PYU5Wk2uxKg56m6LDXDX+IVCWKlHWCp9l4jkO6jySfA
	cNxlcTuX/cOZvVHB7jlFpvKRgPrBhvnzjXRSxBRiPBZp5hsdIYTIKDYBwJSfuZ+ig9nikyhe6xB
	jKsMoSESCXYpTQNMRQAtZ8PTmwKBSI5/iIA9CSa293MMyc6nip+nFpU5dl9KTO8UErZrxzwiCuK
	pIlDoKw4LFKGJuWMe1oiPcWeWADQ2/WAAdcwpu4uq2SibH/wODLt3SAN64hzKvbcBwjW22P8tG2
	8xu6DJoVt0jNZkUYOFXwraViTO9jOy2dk2TQwfPaLzqNyvdD6J6+voSy5K3QRs3Vq1ZlgoS3UdS
	9ljTO4/ikfmmAkB
X-Received: by 2002:a05:622a:5b90:b0:517:7590:228e with SMTP id d75a77b69052e-517784827b9mr21839501cf.0.1780449212162;
        Tue, 02 Jun 2026 18:13:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c54177sm13497781cf.12.2026.06.02.18.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 18:13:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUaAk-00000004yZP-2Ic0;
	Tue, 02 Jun 2026 22:13:30 -0300
Date: Tue, 2 Jun 2026 22:13:30 -0300
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
Subject: Re: [PATCH v2 10/30] iommu/ipmmu-vmsa: implement iova_to_phys_length
Message-ID: <20260603011330.GS2487554@ziepe.ca>
References: <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602104637.1219810-11-guanghuifeng@linux.alibaba.com>

On Tue, Jun 02, 2026 at 06:46:17PM +0800, Guanghui Feng wrote:
> Migrate IPMMU-VMSA to implement iova_to_phys_length, passing through
> mapped_length from io-pgtable.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9386b752dea2..a1b659ddbdb5 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *io_domain,
>  	ipmmu_flush_iotlb_all(io_domain);
>  }
>  
> -static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
> -				      dma_addr_t iova)
> +static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_domain,
> +				      dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
>  
> +	if (mapped_length)
> +		*mapped_length = 0;

Why?

Jason
