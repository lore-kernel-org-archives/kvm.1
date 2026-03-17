Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888C33FE33
	for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777516; cv=none; b=tqujdr7Au/oJM3qTjr5XqKT2J48Zb7Ym4j+wIQ6xWlXYEcoccPQwn5JTuAMshqLN7y+OZmiYXD+/cLloCE+RdhRuDQHeqgOwfQb9PesJvOB3F+5Yyw6dimh240dD17+MmSO0XFSM5z677Mfvp16oN0BkNzqjtsf2SQIApME7gi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777516; c=relaxed/simple;
	bh=Em1QtASA5TH07zcECtpWPgvHshvsZNJWmZ9ueO3nYN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+0LKYHvaLaNEVb21prD+h+GrBcSywcsPYlnBb9hAiKSBFy0LFe3mly/RSctlwFs/V8D+1wnEs8oQhMJO26rtHZWr0vGHLgWOWwPR1GoZPNV56H1umkVgeSyd+ti0tgXGTmhRq7XkVnsH8ptlsDGYVIKbCVwgPSlvO6/sNFtHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jvQX1wp4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvQX1wp4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so21315ad.0
        for <kvm@vger.kernel.org>; Tue, 17 Mar 2026 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773777513; x=1774382313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mqE2obtkRpw6myQ7zxklIkr4seRv7kY/t0f7tkzViTI=;
        b=jvQX1wp4q19JHHKGOqTZ+74fzyYRHaGXIfPXf6zqOMvKJEyPSgXldcLsXvvB+Ftjub
         iRfArnnbtBsBhtaeWDxWozAYMcyVVgj4+FJ19zdg4swQA3fnFXGPRcz8CPdLPx/0h/nS
         q2a42qsCXRuH9hvTE+ZIPjHzXRW0BUSg8fPzL7oHPFEMRXwRSvWDbRx+Ap1LmoU4HFtJ
         Bt4296AGfNxljfJN8tvUzL8B23mcR50A4dC9irasYW6fRiZy/AiHda8zt1YaKLqM+Bc8
         RKVg8YyTmAf3VUsiK0aCTkTb2JtLw+RK+51SlAayQaoaEXBNWx+y9a9B6/TKC8C7cOPA
         vcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773777513; x=1774382313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqE2obtkRpw6myQ7zxklIkr4seRv7kY/t0f7tkzViTI=;
        b=UFZ3lDUYbECcsYnxkmW7BdGse40IdQ8fc5gCB4s977gcrHHk8ZapuCekacGlQUTRNh
         SkD8tfpxy8RGSlZsRIqo/KzEQTroQdFZhGFcVJjaPdMjk01ZHByKHyq+ndQGLbK49pMe
         dnpacsgi2kmHiRrpz0cSrzHCZlmdXL3esSqFs7pehcZrJl0LOsAcxl0WUDJJAzTsFd7O
         G4o5mfrzXS8vuLt8Znp0yfKkOlLF0b44+CFf01nM7fvxG/gE3uUoZ2XnTx/9AReWwO8g
         dhZwrle+xDT6oLVa5PwtIXat9SPfG8oscs7CjCduUHo0BZR9hPQhDUiFCYhukseEYtkR
         bBwA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHEkiVr0xNDurbe+4yTo3K7BUzdWgOBmbb/biL4tgYFv2BAYokm5mwQ4ipDzoulkxAcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymTs68gBnFLsHRszfP7F/OzT1vANgEcYV1jHS1otT4ATn7Qois
	ccQ1D/i1/VWPRKnE9zAJ3t98YVxSsYlBbxrMtYHuaJxi48bgw9dXTIB6iaty3rex9A==
X-Gm-Gg: ATEYQzzh4bJ2ZTneYBjE+VrXsM/OKPMJMDQq2vFYuDwGm/fFep8EsoSm7Tzx28iL++o
	3pw32fAVnUQiIcWcBZxubpQh8KTZDgO2IenrITKjYgmbEhDqbI9CvayYFoirtDIYcm0IpfWPbzu
	mrjnUIF1Nb1Z8I+SqIb5xg5RXpK9QlhFqcocvZ8pyizr5ro2pFb9zN4kxojXGrucElGJ2qu6tXh
	te6iKi5UhJcYFOLhoCF5rQXGUZp0kDtLTYKKvznOw08vDEBrYuMtlh+6X30I0MCpzk3sNaKn4wB
	oOMW7R8vJqiBvvbfpqe2hpGha6Kf5i9hHZrQbVwpTFK26Rvm0RoC0UJwgCzmG7qbgGo5ezj/KLm
	lQk8kzKxUHDtB2KzpHpqwYbGJSE89z7iiKF26k5+XqOAOi8n0s8XbgSlLmuT7zJZqgYdbBB2jkh
	JxG+++e6Ah8S6ec+VcXEOS5hjaV3+CM1bWWBb3VYtoa1K3WamZPiZjy5uiaGU2
X-Received: by 2002:a17:902:d488:b0:2ae:4572:50e8 with SMTP id d9443c01a7336-2b06e7db824mr758565ad.8.1773777512952;
        Tue, 17 Mar 2026 12:58:32 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b52e671sm306524b3a.3.2026.03.17.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:58:32 -0700 (PDT)
Date: Tue, 17 Mar 2026 12:58:27 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 02/14] iommu: Implement IOMMU core liveupdate skeleton
Message-ID: <20260316221854.GC1768676.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-3-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:36PM +0000, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4926a43118e6..c0632cb5b570 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -389,6 +389,9 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
>  
>  	mutex_init(&param->lock);
>  	dev->iommu = param;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	dev->iommu->device_ser = NULL;
> +#endif

This should already be NULL due to kzalloc() above.

>  	return param;
>  }
>  
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 6189ba32ff2c..83eb609b3fd7 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -11,6 +11,7 @@
>  #include <linux/liveupdate.h>
>  #include <linux/iommu-lu.h>
>  #include <linux/iommu.h>
> +#include <linux/pci.h>
>  #include <linux/errno.h>
>  
>  static void iommu_liveupdate_restore_objs(u64 next)
> @@ -175,3 +176,328 @@ int iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  	return liveupdate_unregister_flb(handler, &iommu_flb);
>  }
>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
> +
> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
> +				    void *arg)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct devices_ser *devices;
> +	int ret, i, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
> +	if (ret)
> +		return -ENOENT;
> +
> +	devices = __va(obj->ser->devices_phys);
> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
> +		if (idx >= MAX_DEVICE_SERS) {
> +			devices = __va(devices->objs.next_objs);
> +			idx = 0;
> +		}
> +
> +		if (devices->devices[idx].obj.deleted)
> +			continue;
> +
> +		ret = fn(&devices->devices[idx], arg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(iommu_for_each_preserved_device);

IMHO, with all the obj, ser, devices->devices[..], it is little harder
to follow the code. I will recommend to reconsider naming.

Also, should this function be introduced in the patch where it is
getting used? Other changes in this patch are already big and complex.
Same for iommu_get_device_preserved_data() and
iommu_get_preserved_data().

I think this patch can be split in three.
Patch 1: Preserve iommu_domain
Patch 2: Preserve pci device and iommu device
Patch 3: The helper functions I mentioned above.


> +
> +static inline bool device_ser_match(struct device_ser *match,
> +				    struct pci_dev *pdev)
> +{
> +	return match->devid == pci_dev_id(pdev) && match->pci_domain == pci_domain_nr(pdev->bus);

Nit: s/match/device_ser for readability or something similar.

> +}
> +
> +struct device_ser *iommu_get_device_preserved_data(struct device *dev)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct devices_ser *devices;
> +	int ret, i, idx;
> +
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
> +	if (ret)
> +		return NULL;
> +
> +	devices = __va(obj->ser->devices_phys);
> +	for (i = 0, idx = 0; i < obj->ser->nr_devices; ++i, ++idx) {
> +		if (idx >= MAX_DEVICE_SERS) {
> +			devices = __va(devices->objs.next_objs);
> +			idx = 0;
> +		}
> +
> +		if (devices->devices[idx].obj.deleted)
> +			continue;
> +
> +		if (device_ser_match(&devices->devices[idx], to_pci_dev(dev))) {
> +			devices->devices[idx].obj.incoming = true;
> +			return &devices->devices[idx];
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(iommu_get_device_preserved_data);
> +
> +struct iommu_ser *iommu_get_preserved_data(u64 token, enum iommu_lu_type type)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct iommus_ser *iommus;
> +	int ret, i, idx;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&obj);
> +	if (ret)
> +		return NULL;
> +
> +	iommus = __va(obj->ser->iommus_phys);
> +	for (i = 0, idx = 0; i < obj->ser->nr_iommus; ++i, ++idx) {
> +		if (idx >= MAX_IOMMU_SERS) {
> +			iommus = __va(iommus->objs.next_objs);
> +			idx = 0;
> +		}
> +
> +		if (iommus->iommus[idx].obj.deleted)
> +			continue;
> +
> +		if (iommus->iommus[idx].token == token &&
> +		    iommus->iommus[idx].type == type)
> +			return &iommus->iommus[idx];
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(iommu_get_preserved_data);
> +
> +static int reserve_obj_ser(struct iommu_objs_ser **objs_ptr, u64 max_objs)
> +{
> +	struct iommu_objs_ser *next_objs, *objs = *objs_ptr;
> +	int idx;
> +
> +	if (objs->nr_objs == max_objs) {
> +		next_objs = kho_alloc_preserve(PAGE_SIZE);
> +		if (IS_ERR(next_objs))
> +			return PTR_ERR(next_objs);
> +
> +		objs->next_objs = virt_to_phys(next_objs);
> +		objs = next_objs;
> +		*objs_ptr = objs;
> +		objs->nr_objs = 0;
> +		objs->next_objs = 0;
> +	}
> +
> +	idx = objs->nr_objs++;
> +	return idx;

I think we should rename these variables, it is difficult to comprehend
the code.

> +}
> +
> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_lu_flb_obj *flb_obj;
> +	int idx, ret;
> +
> +	if (!domain->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->iommu_domains,
> +			      MAX_IOMMU_DOMAIN_SERS);
> +	if (idx < 0)
> +		return idx;
> +
> +	domain_ser = &flb_obj->iommu_domains->iommu_domains[idx];
> +	idx = flb_obj->ser->nr_domains++;

In for loops above, nr_domains are compared with 'i', and idx is for
index inside a page. Lets not reuse idx here for nr_domains, keep it
consistent for easier understanding. May be use something more
descriptive than 'i' like global_idx and local_idx?

> +	domain_ser->obj.idx = idx;
> +	domain_ser->obj.ref_count = 1;
> +
> +	ret = domain->ops->preserve(domain, domain_ser);
> +	if (ret) {
> +		domain_ser->obj.deleted = true;
> +		return ret;
> +	}
> +
> +	domain->preserved_state = domain_ser;
> +	*ser = domain_ser;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu)
> +{
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct iommu_ser *iommu_ser;
> +	int idx, ret;

Should there be lockdep asserts in these locked version APIs?

> +
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu)
> +{
> +	struct iommu_ser *iommu_ser = iommu->outgoing_preserved_state;
> +
> +	iommu_ser->obj.ref_count--;

Should there be a null check?

> +	if (iommu_ser->obj.ref_count)
> +		return;
> +
> +	iommu->outgoing_preserved_state = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_ser);
> +	iommu_ser->obj.deleted = true;
> +}
> +
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 token)
> +{
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct device_ser *device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret, idx;
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!domain->preserved_state)
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->preserve_device ||
> +	    !iommu->iommu_dev->ops->preserve)

iommu_preserve_locked() is already checking for preserve(), we can just
check preserve_device here.

> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	idx = reserve_obj_ser((struct iommu_objs_ser **)&flb_obj->devices,
> +			      MAX_DEVICE_SERS);
> +	if (idx < 0)
> +		return idx;
> +
> +	device_ser = &flb_obj->devices->devices[idx];
> +	idx = flb_obj->ser->nr_devices++;
> +	device_ser->obj.idx = idx;
> +	device_ser->obj.ref_count = 1;
> +
> +	ret = iommu_preserve_locked(iommu->iommu_dev);
> +	if (ret) {
> +		device_ser->obj.deleted = true;
> +		return ret;
> +	}
> +
> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
> +	device_ser->devid = pci_dev_id(pdev);
> +	device_ser->pci_domain = pci_domain_nr(pdev->bus);
> +	device_ser->token = token;
> +
> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
> +	if (ret) {
> +		device_ser->obj.deleted = true;
> +		iommu_unpreserve_locked(iommu->iommu_dev);
> +		return ret;
> +	}
> +
> +	dev->iommu->device_ser = device_ser;
> +	return 0;
> +}
> +
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct device_ser *device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> +	    !iommu->iommu_dev->ops->unpreserve)
> +		return;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (WARN_ON(ret))

Why WARN_ON here and not other places? Do we need it?

> +		return;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	device_ser = dev_iommu_preserved_state(dev);
> +	if (WARN_ON(!device_ser))

Can't we just silently ignore this?

> +		return;
> +
> +	iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
> +	dev->iommu->device_ser = NULL;
> +
> +	iommu_unpreserve_locked(iommu->iommu_dev);
> +}
