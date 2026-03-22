Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3B37188A
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 21:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774216770; cv=none; b=fyzagkigCC9wu4/lt7VsEHf32iIs6l4aJSongSi/9QVofOv+eFT4DDuBBYZvqibC+VLoZ3ZiAclrwQ3QDxFGf/WN+1oUCENtspYwkoLtdnzmwf7rj9Ms4bzn7Z14audEQv7FO6cSdschk4xIkyXOyFPJkZarydhQ2P1EzQGuC7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774216770; c=relaxed/simple;
	bh=kwzGaVXRH7+XIgPgVtTcJ3rXYIslxzVy/e0Fsvm+53k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaZd/0D2uMnhFXVHwwIfi4ut6FMTwFF+o4wBb10mk9+xB8jaenwAnukfLWAYsXbcRXDZ5gOuAl8pst6kRkR2o3/wMFTnOZfgEmHsTOggq+Hsr/bcNgbcdkoGG1F8mIca68x+sWM3l0oJqCGt0Fz+tDZq0d/pZUrgoddKcv4oZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEW2LJsT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEW2LJsT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b052562254so134995ad.0
        for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774216767; x=1774821567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxFrSlhzykqJ/iX8G0RVMtupwqRgT4qB5zx+QO82+tg=;
        b=BEW2LJsTRlGv2b3idAJjXnj6D9RkwNX8ObkjRrEcObfR/C+DspWqTNNsVRDS3NMu9K
         Xrk8cl8Pwmj6ZKxRk+T2KbKe9czEYaVUxfMj61Gf0dfmTL2Utt1oAVcRy7IdWwc+ia0G
         uCP3jU2IinIY5mrQpwbW3mFoqe19Kq0c9vY9oTw+Bm4CMAMn7HW0/+I9IBUeZcgwpxkT
         YU6ifUhxJuJpruLQau9lTntWYNoJ9A2de5Z3PmOa/MGdtiIBUUe+HgKFD7LC/FjiZLbi
         DXIsSnhI9j1vNdut9qLrv4TIdFPjQJyXYfdxwCsOMs3EutFrYTg4QhnJT1CnbgkMrzUc
         SBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774216767; x=1774821567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxFrSlhzykqJ/iX8G0RVMtupwqRgT4qB5zx+QO82+tg=;
        b=Wp4idNDf8Fg6I6npykRekBFSP5iBF637W3lxTnxYf/Cgjm/irvUvU7XGcFp7jR9zgC
         H2zEDUrQb120iNPccr7A8bRvORaDSOH9ALaz0G7eqlixXTAaO96aoQwGKVIMXk1sMWGN
         oqBv7bAR61fmNOSoM0NT+W3LtsdptJmTblxNl8yYrdpYvOSPSZ3CD9WPWcXxB8cUMcU2
         k5NLnKcQpiKAV7i/XWpR/h/kQCnBJqI403FZwTwScFGU4D1YVD1PAy5bak0TG/A2klNl
         KdhRvC0yYp+W2o59UuC2U+4RN8I0Q0O8aikT8TJqOWiGPAyNNQo+wYFjtzMBkvEFMeIC
         kGhw==
X-Forwarded-Encrypted: i=1; AJvYcCVTT0M/9oFNFDmKPkAvEW+UZtC1czQqF0+kn1JGYSvV5rZYLq4pV6RWh1lSEUACF+xZZHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVDpQcwsVA4sRqsiHChGkkFW2sHWYaYF6gvBi30sp8eEwcDBv
	9z8ptVvUL/vjiJY6eC7CAcbCs3pP56KOfZ6rR49hROHkwMBI8H6ZXtK35ts4ND+u/w==
X-Gm-Gg: ATEYQzwxvwH77MiFGq1ZdGNDydepm+m7XA91Wmlao4Vi4OnpF0JpHveYojS0Hh91xF4
	58Xx1falJbrRbGs89Zx2Pb4FMAaZdAQUlrilqjlNpPnq4vguI5JIpqxQq5lZ0sqnE9zZ1YiuFHz
	cwXc255ZVGlX+scwGNh0T0uJFoCYhQOaIDcEl2UnMmt6IQZ5zvqv9oT3vdCh5kIP/z8ht7nP8lN
	iKMny+pLmTSmYZHnzGvIfqmRDAIRNQ04UgPw/kAdvD5ZW5cHTKjk+ecm23Kp6dq76TuFgP1p9VR
	V1BRu/ME9UhsyhIDgEu7ANr1HNnH4OV2ZkV6/p3gYGsfzhhKUZIMX8VMXsRcwBT7R7OocGS0yHM
	US9YtN99n286FlXEFnHYnw8CLFBOs4vpnhX9wKuOOVQn+LJCy9i5yRRD4FCv4ON0/70x4SVSKoX
	C7mgN0lGUaSueDnvF/5fQx3k7pKbSor7w2h1JZZuMtNox5u6kT6y+iqk+R0WIgMOLJaGHo
X-Received: by 2002:a17:902:db0e:b0:271:9873:80d9 with SMTP id d9443c01a7336-2b08c423d84mr2869845ad.7.1774216766168;
        Sun, 22 Mar 2026 14:59:26 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8186efsm6033978a12.13.2026.03.22.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 14:59:25 -0700 (PDT)
Date: Sun, 22 Mar 2026 21:59:16 +0000
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
Subject: Re: [PATCH 08/14] iommu: Restore and reattach preserved domains to
 devices
Message-ID: <acBmNM_NIVamBrpm@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-9-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:42PM +0000, Samiullah Khawaja wrote:
> Restore the preserved domains by restoring the page tables using restore
> IOMMU domain op. Reattach the preserved domain to the device during
> default domain setup. While attaching, reuse the domain ID that was used
> in the previous kernel. The context entry setup is not needed as that is
> preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c  | 40 ++++++++++++++++++------------
>  drivers/iommu/intel/iommu.h  |  3 ++-
>  drivers/iommu/intel/nested.c |  2 +-
>  drivers/iommu/iommu.c        | 47 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/liveupdate.c   | 31 ++++++++++++++++++++++++
>  include/linux/iommu-lu.h     |  8 ++++++
>  6 files changed, 112 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8acb7f8a7627..83faad53f247 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1029,7 +1029,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>  	return true;
>  }
>  
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did)
>  {
>  	struct iommu_domain_info *info, *curr;
>  	int num, ret = -ENOSPC;
> @@ -1049,8 +1050,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>  		return 0;
>  	}
>  
> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
> +	if (restore_did >= 0)

I just looked at the code and saw the comment for IDA_START_DID [1] and
I realized we probably shouldn't allow domain_ids 0 or 1 here, as they
are reserved?

It seems that DID 0 essentially acts as a blocking domain, and DID 1 is
used for identity / FLPT_DEFAULT_DID (comparing it to S1DSS in Arm)

If a corrupted KHO image passes restore_did = 0, this check evaluates to 
true. The driver will bypass the IDA, assign DID 0, and program it into 
the context entries. Wouldn't we accidentally attach the device to a
blocking mode where the VT-d hardware just silently drops/faults all DMA?

Should this check be:
if (restore_did >= IDA_START_DID) ?

> +		num = restore_did;
> +	else
> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>  	if (num < 0) {
>  		pr_err("%s: No free domain ids\n", iommu->name);
>  		goto err_unlock;
> @@ -1321,10 +1325,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
> +	struct device_ser *device_ser = NULL;
>  	unsigned long flags;
>  	int ret;
>  
> -	ret = domain_attach_iommu(domain, iommu);
> +	device_ser = dev_iommu_restored_state(dev);
> +
> +	ret = domain_attach_iommu(domain, iommu,
> +				  dev_iommu_restore_did(dev, &domain->domain));
>  	if (ret)
>  		return ret;
>  
> @@ -1337,16 +1345,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,

[ ------- >8 snip -------- ]

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c0632cb5b570..8103b5372364 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-lu.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -489,6 +490,10 @@ static int iommu_init_device(struct device *dev)
>  		goto err_free;
>  	}
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
> +#endif
> +
>  	iommu_dev = ops->probe_device(dev);
>  	if (IS_ERR(iommu_dev)) {
>  		ret = PTR_ERR(iommu_dev);
> @@ -2149,6 +2154,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>  	ret = domain->ops->attach_dev(domain, dev, old);
>  	if (ret)
>  		return ret;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/* The associated state can be unset once restored. */
> +	if (dev_iommu_restored_state(dev))
> +		WRITE_ONCE(dev->iommu->device_ser, NULL);
> +#endif
> +
>  	dev->iommu->attach_deferred = 0;
>  	trace_attach_device_to_domain(dev);
>  	return 0;
> @@ -3061,6 +3073,34 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>  
> +static struct iommu_domain *__iommu_group_maybe_restore_domain(struct iommu_group *group)
> +{
> +	struct device_ser *device_ser;
> +	struct iommu_domain *domain;
> +	struct device *dev;
> +
> +	dev = iommu_group_first_dev(group);
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	device_ser = dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		return NULL;
> +
> +	domain = iommu_restore_domain(dev, device_ser);
> +	if (WARN_ON(IS_ERR(domain)))
> +		return NULL;
> +
> +	/*
> +	 * The group is owned by the entity (a preserved iommufd) that provided
> +	 * this token in the previous kernel. It will be used to reclaim it
> +	 * later.
> +	 */
> +	group->owner = (void *)device_ser->token;

Umm.. this is a nak as it looks troubled for the following reasons:

1. The group->owner and group->owner_cnt are being updated directly
without holding group->mutex. We shouldn't bypass the lock as this
violates the group's concurrency protections and can cause APIs like
iommu_device_claim_dma_owner[2] to race or fail.

2. Stuff like this shouldn't be open-coded. Presumably, this was
open-coded because the standard API (__iommu_take_dma_ownership) forces
the IOMMU group into a blocking_domain, which conflicts with the fact 
that we just restored an active paging domain?

I think we should introduce a proper helper that acquires the lock,
safely sets the opaque owner, and manages the domain state without
forcing it into a blocking domain? Please note that the helper shouldn't
be exposed / exported, we wouldn't want any abusive calls to claim owner
without attaching to a blocked domain.

3. Please note that owner is an opaque "pointer" but we set it to a u64.
Setting an opaque void *owner directly to a user-controlled u64 token is
dangerous. If a malicious or unlucky userspace provides a token value 
that happens to perfectly match a valid kernel pointer (e.g. another
subsystem's cookie), we'll have an aliasing collision.

If that subsystem subsequently calls iommu_device_claim_dma_owner(), the
if (group->owner == owner) check will falsely pass, incorrectly granting
DMA ownership and breaking device isolation.

I understand we can't restore the original owner pointer because the
original iommufd file/context from the previous kernel no longer exists.
However, to avoid aliasing could we dynamically allocate a small wrapper
(e.g., struct iommu_lu_owner { u64 token; }) and set group->owner to the
uniquely allocated pointer?

4. In the full RFC [3], we seem to be "transferring" the ownership but
here we seem to set the owner_cnt = 1 what if it was > 1 earlier? The 
iommu_device_release_dma_owner seems to handle multiple release calls
well so this shouldn't lead to crashes but the "owning" entity could use
this count for some book keeping.. it'd be nice if we could have a
proper restore_owner API / helper here.

> +	group->owner_cnt = 1;
> +	return domain;
> +}
> +
>  /**
>   * iommu_setup_default_domain - Set the default_domain for the group
>   * @group: Group to change
> @@ -3075,8 +3115,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  				      int target_type)
>  {
>  	struct iommu_domain *old_dom = group->default_domain;
> +	struct iommu_domain *dom, *restored_domain;
>  	struct group_device *gdev;
> -	struct iommu_domain *dom;
>  	bool direct_failed;
>  	int req_type;
>  	int ret;
> @@ -3120,6 +3160,9 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  	/* We must set default_domain early for __iommu_device_set_domain */
>  	group->default_domain = dom;
>  	if (!group->domain) {
> +		restored_domain = __iommu_group_maybe_restore_domain(group);
> +		if (!restored_domain)
> +			restored_domain = dom;
>  		/*
>  		 * Drivers are not allowed to fail the first domain attach.
>  		 * The only way to recover from this is to fail attaching the
> @@ -3127,7 +3170,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  		 * in group->default_domain so it is freed after.
>  		 */
>  		ret = __iommu_group_set_domain_internal(
> -			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>  		if (WARN_ON(ret))
>  			goto out_free_old;
>  	} else {
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 83eb609b3fd7..6b211436ad25 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -501,3 +501,34 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>  
>  	iommu_unpreserve_locked(iommu->iommu_dev);
>  }
> +
> +struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	domain_ser = __va(ser->domain_iommu_ser.domain_phys);
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	guard(mutex)(&flb_obj->lock);
> +	if (domain_ser->restored_domain)
> +		return domain_ser->restored_domain;
> +
> +	domain_ser->obj.incoming =  true;
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return domain;
> +
> +	ret = domain->ops->restore(domain, domain_ser);
> +	if (ret)

did we miss free-ing domain here?

> +		return ERR_PTR(ret);
> +
> +	domain->preserved_state = domain_ser;
> +	domain_ser->restored_domain = domain;
> +	return domain;
> +}
> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
> index 48c07514a776..4879abaf83d3 100644
> --- a/include/linux/iommu-lu.h
> +++ b/include/linux/iommu-lu.h
> @@ -65,6 +65,8 @@ static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain
>  	return -1;
>  }
>  
> +struct iommu_domain *iommu_restore_domain(struct device *dev,
> +					  struct device_ser *ser);
>  int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>  				    void *arg);
>  struct device_ser *iommu_get_device_preserved_data(struct device *dev);
> @@ -95,6 +97,12 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>  	return NULL;
>  }
>  
> +static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
> +							struct device_ser *ser)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>  {
>  	return -EOPNOTSUPP;

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/iommu/intel/iommu.h#L795
[2] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/iommu/iommu.c#L3367
