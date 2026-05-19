Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E836A01E
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230138; cv=none; b=lz3HnJqbv+dxsqN6h1W+FC8cL5xdCmjVXKLnCMGAp3/XiLIfCNmkCW4wc2gxODd42+oeWiXw/Drq49hYRneasvynSlouNZaCBsbnVcjAarOVyYVlzXQ0bdnSBsnIsaQJw7AgigJPLfRAXK284tslIM+LjtPj6QKtNuug4MlwP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230138; c=relaxed/simple;
	bh=MsFkLjSbybxChn74YOrTy3TDo56O9airFGxY4Pfuou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WirFGde2R35ixbk8tMcCJNvPqZ39LSh2U0PmGYrpWVaSBdFT4NuzHehjSI7seD0WU9tez2X9ITzmj1azGJMkqpV61ZZVu1uQJ7/S6RdAXR5Jbr6GNLP+fJI2X+DVPiQvNd2EHB49jgYMkXCED1jLq3yxtKvLjsotcxPQiBrxXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+CFtFdG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+CFtFdG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso65ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779230136; x=1779834936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFhMw9iBLw8MsdYqMIVTBJ2/9NopunCbmxedo6hoNMk=;
        b=p+CFtFdGJok07VHkjUFnunSBBnqeKV1pFOHZOaE14zAI/d/wMH9SC2S49iDvTc/jQb
         qqJxPmpJVHlexoSu1RWA23SGpZKAWKiFEAX9zTWqQJ8sB3biVMMC3XUeRmt4/ayQIBjo
         9qMaDZWDVG+vTz+9DL4I3Ag2Pw4wRK91/c1FlaMIB5z1Rh48xlfShPgDF2A7L97k95g2
         F+F2Q9/3xhdy9HN1H4+IC28y0kKE3h+fMoR7Ran7xo6BjQDlcON5e7ryi7/qxZ+7rLuX
         dmiYbNNilV6r/3+5xUySbnbtHdEsQWVQMS7BuN23O3TtneHQTsXJgal+nWCXcKH+shGp
         rDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230136; x=1779834936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFhMw9iBLw8MsdYqMIVTBJ2/9NopunCbmxedo6hoNMk=;
        b=MhN0DBAuofoV379DPo3ntLvMK/paenO1HZ5ZKhV0wYYOJ4x9O5Ub5b2Y6Y5IxYqc5L
         S6i1uRwLYSN9qKPi1dxCGy4l8op7U/OctoX/jUpQeZ/r2Q2vGrdtBzpbp9RhT8ZvidT4
         AsVWBMa614Ia4A5gyUlJFsMB6ZYc6P8EQtO/Tu/B9PM9F1rlYA+gwN5SbXK4lWwEcsgD
         x64MqLq1AaiDaVtW1sj3O6GEe56wIwheC+Xtyzn5SGOyE3qgwsE2dcjuyf5iLiGPmfpj
         Huek6noWtvX5sBW8F/pF/57wopSqD+biMo7k3kSS21oCwuPH0WSnUCcRfBLgisZZwElx
         5hRg==
X-Forwarded-Encrypted: i=1; AFNElJ/3fQ9lbSBdBCSWx5Qk97Nmo/kJ0AS6BaC7udauFgTTkZ/qHmJ2/RZJgVLXq7INHt0ZuIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyekeKUAaFBrlyp9OXl0khplE62FtGjLNgN4FZTHEWJft9blG0w
	Nk1pqOIMl1aJbSb0622mXSXXRfv/w6KJcC/SO5zt9IZfyak0+CzzClXjHOHYD29y4Q==
X-Gm-Gg: Acq92OHS5TZ2fp2xGqkCBNCSI6H0RZ3Q7/f9aQKhss3piFZ67ClFd8yzI8pTjTAbV1w
	4PuG48Z0F6oNGo2xSFntwQ1hEgacoKbPYDUjecTOq/d3TK447dSLCT+vHUzl4c9zgO+yI0UzbCI
	v095wJRI1Ns7oqG0uHeMNEdsd3rDCXBDik5ukr9z8rDIGZEzHzu59raV2i7b4424P7kOsk2HMOn
	MUVP3RBRGCoe9i2aT0ZNVQsZWMIrfp8s7hlm7d3Nz5wlzfnVhunwQ07hbRtO3NNbLBguPiS9MXH
	Ydk6UvfO/RfSB3jpFnVLJ+V5uDWbgb+hqRtjf4hVh4IacNlSI5wWEbvDLq5iOhokSGrYS1NqHnK
	ECfPWzFBoxzXMxtm1pJYAJmWuZKpUgd1+398Ecbn29CZtMy9+QqUiXlfvTXb9668dYy95tHe8il
	rOAhmKTIyfBi8A/tcvc8Vvnnx27300AIIJhM9ChOzlBaY7k9KnWuh1drLEZFTFNmqD+i7w
X-Received: by 2002:a17:902:ebc9:b0:2bd:6dad:7cce with SMTP id d9443c01a7336-2bdb04168abmr7873715ad.26.1779230135236;
        Tue, 19 May 2026 15:35:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f67eff284sm8465883b3a.8.2026.05.19.15.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:35:34 -0700 (PDT)
Date: Tue, 19 May 2026 22:35:26 +0000
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
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <agzlrsK1p7hf6DJE@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-12-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:28PM +0000, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      |   5 +-
>  drivers/iommu/intel/iommu.h      |  12 +++
>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>  drivers/iommu/intel/pasid.c      |   7 +-
>  drivers/iommu/intel/pasid.h      |   9 ++
>  include/linux/kho/abi/iommu.h    |  13 +++
>  6 files changed, 184 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index b90757164cd8..6d42051dcf7c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2951,8 +2951,10 @@ static int clear_unpreserve_context_entry_fn(struct device *dev,
>  	if (!info)
>  		return 0;
>  
> -	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev))
> +	if (dev_is_pci(dev) && dev_iommu_preserved_state(dev)) {
> +		pasid_cleanup_preserved_table(dev);
>  		return 0;
> +	}
>  
>  	domain_context_clear(info);
>  	return 0;
> @@ -4013,6 +4015,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.page_response		= intel_iommu_page_response,
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  	.preserve_device	= intel_iommu_preserve_device,
> +	.unpreserve_device	= intel_iommu_unpreserve_device,
>  	.preserve		= intel_iommu_preserve,
>  	.unpreserve		= intel_iommu_unpreserve,
>  #endif
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 8e37acf7de12..62076a1a0b4d 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1290,12 +1290,15 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  int intel_iommu_preserve_device(struct device *dev,
>  				struct iommu_device_ser *device_ser);
> +void intel_iommu_unpreserve_device(struct device *dev,
> +				   struct iommu_device_ser *device_ser);
>  int intel_iommu_preserve(struct iommu_device *iommu,
>  			 struct iommu_hw_ser *iommu_ser);
>  void intel_iommu_unpreserve(struct iommu_device *iommu,
>  			    struct iommu_hw_ser *iommu_ser);
>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  					       struct iommu_hw_ser *iommu_ser);
> +void pasid_cleanup_preserved_table(struct device *dev);
>  #else
>  static inline int intel_iommu_preserve_device(struct device *dev,
>  					      struct iommu_device_ser *device_ser)
> @@ -1303,6 +1306,11 @@ static inline int intel_iommu_preserve_device(struct device *dev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline void intel_iommu_unpreserve_device(struct device *dev,
> +						 struct iommu_device_ser *device_ser)
> +{
> +}
> +
>  static inline int intel_iommu_preserve(struct iommu_device *iommu,
>  				       struct iommu_hw_ser *iommu_ser)
>  {
> @@ -1318,6 +1326,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>  							     struct iommu_hw_ser *iommu_ser)
>  {
>  }
> +
> +static inline void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 50a63812533f..404b485e97b9 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -14,6 +14,7 @@
>  #include <linux/pci.h>
>  
>  #include "iommu.h"
> +#include "pasid.h"
>  #include "../iommu-pages.h"
>  
>  static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
> @@ -140,10 +141,96 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>  	iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
>  }
>  
> +enum pasid_lu_op {
> +	PASID_LU_OP_PRESERVE = 1,
> +	PASID_LU_OP_UNPRESERVE,
> +	PASID_LU_OP_RESTORE,
> +	PASID_LU_OP_FREE,
> +};
> +
> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
> +{
> +	int ret = 0;
> +
> +	switch (op) {
> +	case PASID_LU_OP_PRESERVE:
> +		ret = iommu_preserve_page(table);

Nit: This is making me consider renaming the helper as
`iommu_preserve_folio`. I almost thought why are we preserving a single
page. 

> +		break;
> +	case PASID_LU_OP_UNPRESERVE:
> +		iommu_unpreserve_page(table);
> +		break;
> +	case PASID_LU_OP_RESTORE:
> +		iommu_restore_page(virt_to_phys(table));
> +		break;
> +	case PASID_LU_OP_FREE:
> +		iommu_free_pages(table);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +

[snip]

> +
> +void pasid_cleanup_preserved_table(struct device *dev)
> +{
> +	struct pasid_table *pasid_table;
> +	struct pasid_dir_entry *dir;
> +	struct pasid_entry *table;
> +	size_t dir_size;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return;
> +
> +	dir = pasid_table->table;
> +	table = get_pasid_table_from_pde(&dir[0]);
> +	if (!table)
> +		return;
> +
> +	/* Clear everything except the first entry in table. */
> +	memset(&table[1], 0, SZ_4K - sizeof(*table));

Nit: Is the first entry always 4K or could it change based on PAGE_SIZE?

> +
> +	/* Use the folio order to calculate the size of Pasid Directory */
> +	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
> +
> +	/* Clear everything except the first entry in directory */
> +	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
> +
> +	clflush_cache_range(&table[0], SZ_4K);
> +	clflush_cache_range(&dir[0], dir_size);
> +}
> +

[...]

> +void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
> +{
> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
> +
> +	if (!ser)
> +		return NULL;
> +
> +	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +				  PASID_LU_OP_RESTORE));
> +	if (WARN_ON_ONCE(ser->intel.max_pasid != max_pasid)) {

I'm wondering if this could be slightly relaxed to:
if (ser->intel.max_pasid < max_pasid) to ensure it's a minimum
requirement rather than an exact match?

> +		pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +				   PASID_LU_OP_FREE);
> +		return NULL;
> +	}
> +
> +	return phys_to_virt(ser->intel.pasid_table);
> +}
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 89541b74ab8c..5cac8e95f73b 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>  
>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>  	order = size ? get_order(size) : 0;
> -	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> -					1 << (order + PAGE_SHIFT));
> +
> +	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
> +	if (!dir)
> +		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> +						1 << (order + PAGE_SHIFT));
>  	if (!dir) {
>  		kfree(pasid_table);
>  		return -ENOMEM;

Thanks,
Praan
