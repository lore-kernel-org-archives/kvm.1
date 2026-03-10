Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF137D13E
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179245; cv=none; b=f9lRrZHNc8fR9F+vppecXud76ceGWOWbVQJD06moQEO2++EJBUlEvaRIcdQjLQEJ3wJvbzpOW0dNB3/WWeOBQGqI4BhcjQ3RletHxlTWqZHcUTSs4giCogwfDmJxTmNRJoYuJO6morAO9mpc0AZA9qbqgeBi753Rju5ECwA5yU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179245; c=relaxed/simple;
	bh=mQuTQCXgyBXZGtOv+LuZDeRQk0twCEJR67xLMDOKk44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te9yoZmyXuaud+LNtrkkKfR6rQ56+tjgfxOc9DiGE6VU28y2RELgyGgILE8oKL2b3oM5ni4I8DsBKBGySSCYg3ua3d7pdBfN8FHWfWPexEOb1pwB2DuZSoWhP7li9o/n8Npd5Llwue79sGgRk6HY2to/jrsXWby2crCu371hnO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LdirLuc3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LdirLuc3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae3f822163so40515ad.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773179243; x=1773784043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JdVc8T+6UNGh/VsXP1dXf3PthPQA075yGDRasc1aV+I=;
        b=LdirLuc3hgtswf8m7+qGTVLVSquOW0aVec52It6MP7TcBpv9MjUb4KtMCJE0c5woIJ
         R08Tl8KmybFjTOZf3iaFq8QaWxkT2ZhH83A84kgVCdPwtaGej16VbaIl06tq+smLIxt3
         OGBBUd681d/fMUANbr/bvkE6nYs5B3cyuCVG7fy7bOdw1eABZ9zWN5NhB6Yc3bPTJcuI
         4j5eNO9tMlDvlEorbZL2kmBAKPzsYk9terZYrni9qdXEvbaa4+l5N1Sef7h52b5P/VMj
         SE0mkeaJ0gf1xHTmYWAFYcJ76L7oewav0oeaeoOpJiI54v9WRq/tJC43827FdKFRVO/K
         BMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179243; x=1773784043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdVc8T+6UNGh/VsXP1dXf3PthPQA075yGDRasc1aV+I=;
        b=pkHvS//RNmdHEqohZW3WntlzAVhZL52NsNjzMuTcXEO1a0dCOIJdIIFG6O+D4Rf9JG
         m9U3F0e/K/MKW65qeydhtFhgm5SWbqbYmkJMcg+y3QpuGNA9YtFWfRA7ZQrcfOmtiIZ4
         zF8qKG6dIjqTu64InWbzzjryOfgb0HJ4ksFhwbBPNtAa1Y9TiJ0HGxaZIkx7PEajEL1N
         K2jMHMMtrIuMGOpTkyBeq4aO3VQhTBMuD/MSAxuFxFAuYSIE/gmUn/qB0fHU6V2oyl3n
         mgEKJeyUFNM3AilvgnGVwRp6JS6UxVERmnQlSn1yijTT4opLfnJsxD8cZ/gbCoP/BLPh
         cK9g==
X-Forwarded-Encrypted: i=1; AJvYcCV9pGuexfPWr5KLCtfipmZL/Di1h4xGRmWdYhZ1yhgdJbQJcgkCniVNeMNZKn+JA0CaA4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzOScO0pvfhExwajGolm4UP0NsqLIVWyLTGTd0x2hTZLPOyxK
	dEh91JUGdwhF/oPEcOPTUqPSqhRwI3k2wJCuypnzm8qghpz2Jfw0SpSFT6zxPUAFEQ==
X-Gm-Gg: ATEYQzz7IV7kOueUettrzacoJXQUun+8AaRNrRZr/XJNHfaFyBnX54akR76ZlyCnbll
	LPOlV2Yubhd3RBpuXTx0rSAHDE+Vpp6hXS8rmFqfnXRPy+oG5N2MeFG9URyqkqgEuV3jY2MN7Ka
	PyqrZBfjD6/FbQnVjEryVXPWvZ9MGpWp7BrrA1tdOx+A2LP8b/U2g7j/fxCDBblI1EFZQBg/Uy6
	YACs7+H8oWII/q9rfmd2iMbeGTDTD8uh3lELeGZGIs6eAlngyKwx809EhASo40OZTo4EuJu1VrK
	hmOL9+KfQWJ9Iq8c7YbEMYjH/R9JqFw5ej6xukiGwe2KDj3dvSFCKUgR8LdDxyfi29g8ENPYeE9
	/mCQY9INclgkfu7TEC0tGIqQESYXjGUjDBwlRDm8aiKudJ+sn+wXLXL9DxjeNT5O3J7zCSUzGgt
	XCxYDLaGGLzZNkZv4B/MceZcdGDfIua4ko/bKJ2P4M86rsqATeW+OsSos97wkNEg==
X-Received: by 2002:a17:903:2ca:b0:2ae:5d57:c94f with SMTP id d9443c01a7336-2aead3e31a0mr1133255ad.16.1773179242632;
        Tue, 10 Mar 2026 14:47:22 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f703a7casm213874b3a.59.2026.03.10.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:47:22 -0700 (PDT)
Date: Tue, 10 Mar 2026 21:47:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 08/14] iommu: Restore and reattach preserved domains to
 devices
Message-ID: <abCRDTIvY9wkRw8_@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-9-skhawaja@google.com>
 <gglhu55vvyqdlunnlpas44trhcijcx3mabk75o4zcc7atvuuyd@sna3cmfaapbh>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <gglhu55vvyqdlunnlpas44trhcijcx3mabk75o4zcc7atvuuyd@sna3cmfaapbh>

On Tue, Mar 10, 2026 at 05:16:35AM +0000, Ankit Soni wrote:
>On Tue, Feb 03, 2026 at 10:09:42PM +0000, Samiullah Khawaja wrote:
>> Restore the preserved domains by restoring the page tables using restore
>> IOMMU domain op. Reattach the preserved domain to the device during
>> default domain setup. While attaching, reuse the domain ID that was used
>> in the previous kernel. The context entry setup is not needed as that is
>> preserved during liveupdate.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c  | 40 ++++++++++++++++++------------
>>  drivers/iommu/intel/iommu.h  |  3 ++-
>>  drivers/iommu/intel/nested.c |  2 +-
>>  drivers/iommu/iommu.c        | 47 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/liveupdate.c   | 31 ++++++++++++++++++++++++
>>  include/linux/iommu-lu.h     |  8 ++++++
>>  6 files changed, 112 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 8acb7f8a7627..83faad53f247 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1029,7 +1029,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>  	return true;
>>  }
>>
>> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>> +			int restore_did)
>>  {
>>  	struct iommu_domain_info *info, *curr;
>>  	int num, ret = -ENOSPC;
>> @@ -1049,8 +1050,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>  		return 0;
>>  	}
>>
>> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>> +	if (restore_did >= 0)
>> +		num = restore_did;
>> +	else
>> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>  	if (num < 0) {
>>  		pr_err("%s: No free domain ids\n", iommu->name);
>>  		goto err_unlock;
>> @@ -1321,10 +1325,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>> +	struct device_ser *device_ser = NULL;
>>  	unsigned long flags;
>>  	int ret;
>>
>> -	ret = domain_attach_iommu(domain, iommu);
>> +	device_ser = dev_iommu_restored_state(dev);
>> +
>> +	ret = domain_attach_iommu(domain, iommu,
>> +				  dev_iommu_restore_did(dev, &domain->domain));
>>  	if (ret)
>>  		return ret;
>>
>> @@ -1337,16 +1345,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  	if (dev_is_real_dma_subdevice(dev))
>>  		return 0;
>>
>> -	if (!sm_supported(iommu))
>> -		ret = domain_context_mapping(domain, dev);
>> -	else if (intel_domain_is_fs_paging(domain))
>> -		ret = domain_setup_first_level(iommu, domain, dev,
>> -					       IOMMU_NO_PASID, NULL);
>> -	else if (intel_domain_is_ss_paging(domain))
>> -		ret = domain_setup_second_level(iommu, domain, dev,
>> -						IOMMU_NO_PASID, NULL);
>> -	else if (WARN_ON(true))
>> -		ret = -EINVAL;
>> +	if (!device_ser) {
>> +		if (!sm_supported(iommu))
>> +			ret = domain_context_mapping(domain, dev);
>> +		else if (intel_domain_is_fs_paging(domain))
>> +			ret = domain_setup_first_level(iommu, domain, dev,
>> +						       IOMMU_NO_PASID, NULL);
>> +		else if (intel_domain_is_ss_paging(domain))
>> +			ret = domain_setup_second_level(iommu, domain, dev,
>> +							IOMMU_NO_PASID, NULL);
>> +		else if (WARN_ON(true))
>> +			ret = -EINVAL;
>> +	}
>>
>>  	if (ret)
>>  		goto out_block_translation;
>> @@ -3630,7 +3640,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
>>  	if (!dev_pasid)
>>  		return ERR_PTR(-ENOMEM);
>>
>> -	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>>  	if (ret)
>>  		goto out_free;
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index d7bf63aff17d..057bd6035d85 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1174,7 +1174,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>>   */
>>  #define QI_OPT_WAIT_DRAIN		BIT(0)
>>
>> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>> +			int restore_did);
>>  void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>>  void device_block_translation(struct device *dev);
>>  int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index a3fb8c193ca6..4fed9f5981e5 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>>  		return ret;
>>  	}
>>
>> -	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>>  	if (ret) {
>>  		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
>>  		return ret;
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index c0632cb5b570..8103b5372364 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/host1x_context_bus.h>
>>  #include <linux/iommu.h>
>> +#include <linux/iommu-lu.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/idr.h>
>>  #include <linux/err.h>
>> @@ -489,6 +490,10 @@ static int iommu_init_device(struct device *dev)
>>  		goto err_free;
>>  	}
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
>> +#endif
>> +
>>  	iommu_dev = ops->probe_device(dev);
>>  	if (IS_ERR(iommu_dev)) {
>>  		ret = PTR_ERR(iommu_dev);
>> @@ -2149,6 +2154,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>  	ret = domain->ops->attach_dev(domain, dev, old);
>>  	if (ret)
>>  		return ret;
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	/* The associated state can be unset once restored. */
>> +	if (dev_iommu_restored_state(dev))
>> +		WRITE_ONCE(dev->iommu->device_ser, NULL);
>> +#endif
>> +
>>  	dev->iommu->attach_deferred = 0;
>>  	trace_attach_device_to_domain(dev);
>>  	return 0;
>> @@ -3061,6 +3073,34 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>>
>> +static struct iommu_domain *__iommu_group_maybe_restore_domain(struct iommu_group *group)
>> +{
>> +	struct device_ser *device_ser;
>> +	struct iommu_domain *domain;
>> +	struct device *dev;
>> +
>> +	dev = iommu_group_first_dev(group);
>> +	if (!dev_is_pci(dev))
>> +		return NULL;
>> +
>> +	device_ser = dev_iommu_restored_state(dev);
>> +	if (!device_ser)
>> +		return NULL;
>> +
>> +	domain = iommu_restore_domain(dev, device_ser);
>> +	if (WARN_ON(IS_ERR(domain)))
>> +		return NULL;
>> +
>> +	/*
>> +	 * The group is owned by the entity (a preserved iommufd) that provided
>> +	 * this token in the previous kernel. It will be used to reclaim it
>> +	 * later.
>> +	 */
>> +	group->owner = (void *)device_ser->token;
>> +	group->owner_cnt = 1;
>> +	return domain;
>> +}
>> +
>>  /**
>>   * iommu_setup_default_domain - Set the default_domain for the group
>>   * @group: Group to change
>> @@ -3075,8 +3115,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  				      int target_type)
>>  {
>>  	struct iommu_domain *old_dom = group->default_domain;
>> +	struct iommu_domain *dom, *restored_domain;
>>  	struct group_device *gdev;
>> -	struct iommu_domain *dom;
>>  	bool direct_failed;
>>  	int req_type;
>>  	int ret;
>> @@ -3120,6 +3160,9 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  	/* We must set default_domain early for __iommu_device_set_domain */
>>  	group->default_domain = dom;
>>  	if (!group->domain) {
>> +		restored_domain = __iommu_group_maybe_restore_domain(group);
>> +		if (!restored_domain)
>> +			restored_domain = dom;
>>  		/*
>>  		 * Drivers are not allowed to fail the first domain attach.
>>  		 * The only way to recover from this is to fail attaching the
>> @@ -3127,7 +3170,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  		 * in group->default_domain so it is freed after.
>>  		 */
>>  		ret = __iommu_group_set_domain_internal(
>> -			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>> +			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>  		if (WARN_ON(ret))
>>  			goto out_free_old;
>>  	} else {
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 83eb609b3fd7..6b211436ad25 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -501,3 +501,34 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>
>>  	iommu_unpreserve_locked(iommu->iommu_dev);
>>  }
>> +
>> +struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct iommu_domain *domain;
>> +	int ret;
>> +
>> +	domain_ser = __va(ser->domain_iommu_ser.domain_phys);
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	if (domain_ser->restored_domain)
>> +		return domain_ser->restored_domain;
>> +
>> +	domain_ser->obj.incoming =  true;
>> +	domain = iommu_paging_domain_alloc(dev);
>> +	if (IS_ERR(domain))
>> +		return domain;
>> +
>> +	ret = domain->ops->restore(domain, domain_ser);
>> +	if (ret)
>
>'domain' will leak here.

Agreed. It should be cleaned here if restore fails. I will fix this in
the next revision.
>
>> +		return ERR_PTR(ret);
>> +
>> +	domain->preserved_state = domain_ser;
>> +	domain_ser->restored_domain = domain;
>> +	return domain;
>> +}
>> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
>> index 48c07514a776..4879abaf83d3 100644
>> --- a/include/linux/iommu-lu.h
>> +++ b/include/linux/iommu-lu.h
>> @@ -65,6 +65,8 @@ static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain
>>  	return -1;
>>  }
>>
>> +struct iommu_domain *iommu_restore_domain(struct device *dev,
>> +					  struct device_ser *ser);
>>  int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>  				    void *arg);
>>  struct device_ser *iommu_get_device_preserved_data(struct device *dev);
>> @@ -95,6 +97,12 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>  	return NULL;
>>  }
>>
>> +static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
>> +							struct device_ser *ser)
>> +{
>> +	return NULL;
>> +}
>> +
>>  static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>>  {
>>  	return -EOPNOTSUPP;
>> --
>> 2.53.0.rc2.204.g2597b5adb4-goog
>>

Sami
