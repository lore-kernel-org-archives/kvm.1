Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9DC47DF8A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110043; cv=none; b=i3X0wOS+YnLKS1avaMoc2KyQOsBMKzJaPDSsLmxKWtQrKLlyCYCQqq739cqK8M3+C+u8LtTMTuxUHSXovozWYBbQdHEvVV1vaeUHFBCrKgp5ULVT2wD8+MJihLtgI2j39r8iCME/MSbI46Ct84yRZcCI2byD3u0tSfkbl+9p+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110043; c=relaxed/simple;
	bh=btSIhGMvdP0aU851la5oG7im9lsPLy+PBN4yq1F8bgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5n6EMc5Azr5rlZuiHwNZMfChArBMMrelr8NYlIttX4mc+WZPLAvqU78wN2W7orTx6+L/rrC5B/wUqlDJpspf1aks09pDLJBaDfxHpEiokaEkwyJa0CJK/gy9s7HbqIT0ZkECNeXCT/xJKr6PTXr1LGNqAEZkECxK9xmXbl4mrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GS8gVnJC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GS8gVnJC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b46da8c48eso905ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779110039; x=1779714839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8z6jY/uEBmrxhBdQT2bu54FMFgYLzRCWsXgjpGmf3I=;
        b=GS8gVnJC0KW7xQRR8/elOb+VjPnei2vxk3DQo0rZBwaokELrPKF0Dz0sQi5o6EKfvT
         DuJASQmnMgiOyvOb8aNOeN72vRsBuPkLkG4aPSMCqp5+wh687GMExlBeBzc0jkL1casy
         RbD9puanmbRbRjmXDiz9sS5UzJYxNUj6da7J0wPyv70S38o1q0I+o+KJRgEMkwwXj+de
         BHqYorcITBmt6enE08PtF3F3T4pvksN1HWfkH+FYKbGy6l4VbeGUPfZj0onSXUYMTh9+
         HQsZnja3gVOUoQzTgMoGFpGwDFgX//M9CGZu9zlGiv38bc+YnJ7TAm4uBaVThZcEoToF
         7kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110039; x=1779714839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8z6jY/uEBmrxhBdQT2bu54FMFgYLzRCWsXgjpGmf3I=;
        b=g1hw8l1CMrcS/BqZLxy5re1pAuLuvOzmbWYMvl8H36GOVw/cNFEdC6hpDubqtf4y2O
         6tPj3IAqtGiBWGBl5xyZYQDp9z6MT+qRZ7cV0vRlNnRPssUxmqi2ympMkFnMA7r2A1s0
         kKbnyj1IILnVpsZUQK3jOEzHnDRKGKlCrcY4OUFu6p7eKdXGypf9Pxqx2HIiX362VBcv
         oNhcYMflNSsHYIjvHsJc7tL0eHq6t4iMNBBVmrCqi8tytdptDNdzJFegz9lPJOWADI4s
         r9IkAcFAwV7t1sHQTiS6dfJHSu/4Uv4+psYissM3oPRqKCMsGgUPFE5MkNnXWqumBR4C
         sY9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8uC7h64PU9xxIXfMo77RaMnBdXV03TkTo8kREfRd9PKh70+9LXZYLzoGgmfL86AIreReQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSLfhYIY4YqlHFTI4TRE8mVMKULtnnOdYUlYzUyi0OXlQPHZl
	PAj0G5nifZ6h+j3m9wKRk+RzmfHWwE/6WEqHwISfdh9n3C+AB3zY9ZBuH05Bm8UfLA==
X-Gm-Gg: Acq92OH7n2C5QYpss6tjrscR3pLTFNSwK8TctEQXpIwLFRV2ZCvx5OT2eSwE9Sutiud
	7pItAExWkv0v0CQU+q0+62kzrQiKGjVe3MVu1K21KGP6zsre0pcgafGTx8cmOPx5CiQE7ueVWFH
	mhhsIoVe26x5b4UdQBe1/pVSTiclAkIZ32nH0sffI0X5w4cjIVsgMShw4i/l5jjKdJz4qJDHXXT
	zfAra1Ij+Zj/CwqhMQGL3PZ2la6s67OZeQeE0gRHaQt17q1d+YOWo9zHbHi6dMM6XhBdEz4qKzz
	5fzgQNNf/4+v41v8gE2yGM0hGhUyHTijb3oL71GuTdDZ4UiJR1k7lqYWvcD3mdkqyQwEkAI9BIb
	tWGWf7zzpr6CkY8jXoeMCTT5RzQ5aRfwLsERgvZHimPelG4XAP/ai4QjSTPNxHe/ZuywrlNLlbu
	9wUEUAzGHHN23Gq3XlSortHkUzK7tPcZnn0USCusaVZvBNXc0xjTXZYAlFMk0fozVQRpK6
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id d9443c01a7336-2bdb03a2b85mr3036825ad.12.1779110038827;
        Mon, 18 May 2026 06:13:58 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977c494sm14213643b3a.21.2026.05.18.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:13:58 -0700 (PDT)
Date: Mon, 18 May 2026 13:13:49 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <agsQE1lFGdo-b_IF@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-4-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:20PM +0000, Samiullah Khawaja wrote:
> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
> they support IOMMU domain preservation across liveupdate. The new IOMMU
> domain preserve, unpreserve and restore APIs call these ops to perform
> respective live update operations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h | 14 +++++
>  include/linux/iommu.h            | 13 +++++
>  3 files changed, 124 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index a26099b145c3..f71f14518248 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -13,6 +13,9 @@
>  #include <linux/iommu.h>
>  #include <linux/errno.h>
>  
> +#define iommu_max_objs_per_page(_array) \
> +	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
> +
>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>  {
>  	struct iommu_array_hdr_ser *array_hdr;
> @@ -196,3 +199,97 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  	liveupdate_unregister_flb(handler, &iommu_flb);
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
> +
> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
> +{
> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
> +	struct iommu_array_hdr_ser *next_array;
> +
> +	if (curr_array->nr_objects >= max_objs) {
> +		next_array = kho_alloc_preserve(PAGE_SIZE);
> +		if (IS_ERR(next_array))
> +			return PTR_ERR(next_array);
> +
> +		curr_array->next_array_phys = virt_to_phys(next_array);
> +		*curr_array_ptr = next_array;
> +		curr_array = next_array;
> +	}
> +
> +	return curr_array->nr_objects++;
> +}
> +
> +static struct iommu_domain_ser *alloc_iommu_domain_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_domain_array,

Nit: Such type-casts could be brittle and risk strict-aliasing warnings
based on the compiler. 

Since alloc_object_ser only updates the top-level tracking pointer, we 
can make this much cleaner by changing alloc_object_ser to take a 
void curr_array_ptr. That way, we can pass (void )&flb->curr_domain_array
cleanly without the double-pointer type-punning. Something like:

static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
{
	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
	struct iommu_array_hdr_ser *next_array;

	...
}

and we can pass it as:

idx = alloc_object_ser((void **)&flb->curr_domain_array,
		       iommu_max_objs_per_page(flb->curr_domain_array));

> +			       iommu_max_objs_per_page(flb->curr_domain_array));
> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_domain_array->objects[idx];
> +}
> +
> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret;
> +
> +	if (!domain->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	domain_ser = alloc_iommu_domain_ser(flb_obj);
> +	if (IS_ERR(domain_ser))
> +		return PTR_ERR(domain_ser);
> +
> +	ret = domain->ops->preserve(domain, domain_ser);
> +	if (ret) {
> +		domain_ser->hdr.deleted = true;

Nit: This will become domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
once we convert the bitfields in PATCH 2 to flags.

> +		return ret;
> +	}
> +
> +	domain->preserved_state = domain_ser;
> +	*ser = domain_ser;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
> +

[...]

>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -752,6 +757,11 @@ struct iommu_ops {
>   *                           specific mechanisms.
>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>   * @free: Release the domain after use.
> + * @preserve: Preserve the iommu domain for liveupdate.
> + *            Returns 0 on success, a negative errno on failure.
> + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
> + * @restore: Restore the iommu domain after liveupdate.
> + *           Returns 0 on success, a negative errno on failure.
>   */
>  struct iommu_domain_ops {
>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
> @@ -782,6 +792,9 @@ struct iommu_domain_ops {
>  				  unsigned long quirks);
>  
>  	void (*free)(struct iommu_domain *domain);
> +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
> +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);

Nit: Should we add restore in the patch we implement it?

>  };

With the above nits,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
