Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411F35B63C
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780271514; cv=none; b=ITCaiXI7WEVRHaGAR1PomSQJA4UdHJMj8VGNR3LtVl0iakd1LZsEZeb6zX3WHwh7DJDq4i2PCkelRbbFDlHezZqRKVVcg+xVM32srCCaC8f31r5Jx53toXEIjv/+Zvp4Cyp6l4qyQMtEXH2AR5n/J2BYpbCe2KHowHZYzcj+9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780271514; c=relaxed/simple;
	bh=vZPmrTp86MbPzKorp7nUexYwkpoU7a/NNFPpiXKZRk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt7R952tdwaO3hmyoCsnqPksEQsg2rYNgDXFI5/L7xiEW7s63Ys+Zk/XewY3DiAr5ZQDfUkUWs6n6G+C3O/K0KIejv6nhS2jxZ7hceNapYyftBNpwhfs6CraHX8gw8vVmiHix0KMw1y/3IFMLD6KJmkdKL5J0hpVY6dIYnH9Hh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Fnlf4ZCm; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Fnlf4ZCm"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-914b03e42b2so1200900785a.0
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 16:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780271511; x=1780876311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
        b=Fnlf4ZCm2UukdbJ7WNpGo0A0yW7Npk87rwKL0VGMpBGnIApxYLtL8QqqV4hNVSzyCW
         M9y42dI/gD2bUo+FQhbzHCpxNqHlL8fSQZI97xIpRT4/fmD1bUeAE5PGr5bA7Olw9+d7
         9eStj3xrew4cMILG3e+1elSjtAN3GUDfpY/PfrEY4YcmAutANUps1iDCV6DFMpQB4RHZ
         1eknFPeAr1J5ATNAAnavOjIY4QtS9KGy5lc+lxPHKEkQMNdNeo7S5A306pp99h+aOOMz
         FvyuG60UNBT1oMJWsvbhQeUs06Qb046zmq63p3UxexU3480Q6+Xs4/TlL1AYwv4HHALH
         ACsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780271511; x=1780876311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT2+faPEqgvyyrZj7GkiI+MQEalHKPFUv4mZyF5by/U=;
        b=MbdS9Tfv+Va4DVyqNW3a84tkR7p52iU6ZAQDG9YlvrZyVBSf57lJPW+QuztLO6IfVt
         50HrX4Z8ESYlKCWJFOtO9Bv2VYtR4QUQrnvwy7kJwarFXyHel+xoc0oODyrXXMfyyWbw
         yS257nNiTWmu8WH4TRB6l5fyw5hGaulLOLJyOmjlaiRCuoi6G1AoTmuuebGHxbwijo1v
         x9zYO7BVG4JA8pmMNQVJ0aVJLmc3QKu9iF78v1wdcZWrYyh0IiGt7lA/yS9NaSxwbsoR
         3aT8dEpFikwcYmuRvPGJ8NtmvGpGPz5nXnyRbzyUbqXvESGTfECP/34YrIXqoJT/Q5R+
         qdGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XBub8majCTJIkKRN1dOHZzQ0FG0nvb0SFbejBk+6fPVKBafG860ioWWKXZ3L0fLw8TzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkfnMaxihIgkInzXxoVDd6rzBIB5zx1If1EPkHQZxelNt0jEK
	KDbHH9A7JMR5WYMxM8gCRpNSz4pD2Xf/JWSSrYU3RblmOpPPApe9vmJb1Ao3VRrWEjc=
X-Gm-Gg: Acq92OETjlZ2SLbybptSxvs2jBi23iUJTF74DBe1GaPsh5adG6wLeDcalC7jAJYlqKa
	EatBOeAD6KxkQ2lr5aRXKDIW5ECFux9M7Z5Odj7CN0eRveMFg7dDt+Hjy+98GsHiRN/rbgxY6Qx
	k0hvuMHcZgHDoBp7acnH2dO0Jt5CW6gQjRgMMMqXLx9TPMLxrmp8YQUO4ayTyg2RS+JIbQep2fc
	MHWdPM8hmqVtvbVDgRtzV6Y4StAiVGfJi7k7rcmkzFG5Dgkn7E7lClxTSVBwt8LrzbsWlnUsIaV
	+VSO8r3d7ONEV1ne4IKfHiTGUaU70yGCD00jn8DriuFNx+AoL+EGW6n7JgraNpU4Tff+K4W/JpE
	70zNtGAEz1E61I/ANQJIaWVRWuaoqrTtcyrrQbO/YnADDkYee/OZ6VQ3xujqczsdUKXPI2DUIEy
	oUkvGjB1zDtQGbDW1R0McjJ8FGDjDgzvT1u9GTzGJoMcdsLgc6ZH7BFgpGNmr7MwEnqEgNeplf5
	ZsPbUjT3aXggKsF
X-Received: by 2002:a05:620a:439b:b0:913:7bc8:79b9 with SMTP id af79cd13be357-9153d9b617bmr1323643185a.22.1780271510817;
        Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91532473bb9sm854276585a.11.2026.05.31.16.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:51:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wTpwa-00000001LoH-3dmS;
	Sun, 31 May 2026 20:51:48 -0300
Date: Sun, 31 May 2026 20:51:48 -0300
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
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260531235148.GV2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>

On Sun, May 31, 2026 at 05:36:29PM +0800, Guanghui Feng wrote:
> Add iova_to_phys_length callback to struct iommu_domain_ops alongside
> the existing iova_to_phys. The new callback returns both the physical
> address and the PTE mapping page size in a single page table walk.
> 
> Add iommu_iova_to_phys_length() core function that:
> - Checks ops->iova_to_phys_length first (preferred path)
> - Falls back to ops->iova_to_phys for unmigrated drivers
> 
> This enables callers like VFIO to efficiently traverse IOVA space
> by actual mapping granularity instead of fixed PAGE_SIZE steps.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Acked-by: Shiqiang Zhang <shiyu.zsq@linux.alibaba.com>
> Acked-by: Simon Guo <wei.guo.simon@linux.alibaba.com>
> ---
>  drivers/iommu/iommu.c | 34 ++++++++++++++++++++++++++++++++--
>  include/linux/iommu.h |  9 +++++++++
>  2 files changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a0..43323229a1df 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *domain, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
>  
> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of the
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or 0 if no translation.
> + */

When introducing the new function I would like to fix this 0 error as
well, it should return PHYS_MAX for error

> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY)
>  		return iova;
>  
>  	if (domain->type == IOMMU_DOMAIN_BLOCKED)
>  		return 0;

Any domain that doesn't have an op should fail, blocked is one example

>  
> -	return domain->ops->iova_to_phys(domain, iova);
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova,
> +							mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (domain->ops->iova_to_phys)
> +		return domain->ops->iova_to_phys(domain, iova);

If it falls back it should return something sensible for the length.

I suggest you approach the patch plan a little differently, the first
patches should implement the new function and an iommput
implementation

Arrange things so the normal iova_to_phys calls the new function if it
is available and discards the length.

Then convert callers that can take advantage of it. Have the fallback
path also compute the length by iterating internally.

Finally one patch per driver implementing the new op, this could even
be a second series.

Don't remove iova_to_phys(), it is fine for things that don't need the
length.

Jason
