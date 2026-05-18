Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12833032B
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112560; cv=none; b=fPLXq3PxJ+SGLUv26HpV4uC7JLUHygEaB3u44fEt5PRCo19bPwVOGJhrtfi76NOVU5f7N01fMaPnXOkJOZonJuuZYsBcG1RsXtN4TQKeQVrhH8o1CTnGGB8y/4OH1yIqx7vo5I2/IJYTIGuSMq+JfoFtAKDmsADyq1fKeehsHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112560; c=relaxed/simple;
	bh=z0YAAFadfH2XhcgzCUpbz1tgJixrxEta51A0Zjz3Ce0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxHCMQrOdqOnqwlpNK+hxJ1SA3q1XlKkM/nPmp+hTHtmw3FvDGPJkXVF9n7qU24mghO6SxuNUKpVLat4FBmfxK+iCYaAEZwHT+3K2PBEGEgT9wiN5O6OkbEfgJdzxtSO0VHOk2VNNtt0eWnH6jWCqjo/J38n3Np5jh2sqfQ2dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppZ3R1zX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppZ3R1zX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba180a022dso255ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779112558; x=1779717358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BpxsdrpOF4S4sGgcNrBSUgvtEzER354ji9FqhPoZM3I=;
        b=ppZ3R1zXPAlvl2aDH2YzC62ZNxvr6TNoNVe03o9WzPauM+f/X2aTC7lLZaI3opoLog
         W0lDFcgTDuwX+/mt75SlgdawHw+wToDgm7WttAp5D2mvI6teBsgYmMsvV16tgHjQ2Ysb
         i2sxifc9SGRwFdGxZCKOmas3k+4g01V6doJPWTFdR14wu1jGC8wQ7lWiUQlqW5+/4eVc
         3dW37iFdZ9hYFb2qVM5TPLVwKvquqgYyke/o+HG9hsURkGl3WB/TTsP6fPZcCVWwfQ/h
         PK6+dGEDM7LVMI/i0g5F7lTV/Z5joqJU6OGkBmfVIGgL3MEdX6paIpx5lc0uG6iq/I5r
         vZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112558; x=1779717358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpxsdrpOF4S4sGgcNrBSUgvtEzER354ji9FqhPoZM3I=;
        b=giAYT2DZK6dhnaDH/vLpGvow7qtd1PoojlsQSqvl5LUxw+eGC5BZC3w7riEY2p6D1f
         bpgSCOYA9FeJCFat8aPrHXDyPaHZV4kEgTMu10qpPJD8vIVDR4OUmb+tpFOUKHx/dIwO
         0Zay6r/0opatwnUjaWOFZG8jioyFeKg9dtEkW3OK4mWm7Qjail49uz05kkOvL4kfQo5a
         vjqQhKqn5ARRRDGC1/SzCe9YhepBLJX2QzhPBF+/ixsqcDTAqpLODz80TSclCOKOviIK
         cqXDraHQXwPgskX06a5aDdgyotAdDyTAUe2VP2cMOY/6/bidFC+y4VNinrD0ajsxT5KC
         WPVg==
X-Forwarded-Encrypted: i=1; AFNElJ+YvTOXFCe2bF14ph+vr6GLCl/1tG4gncSrn2gWb7C8CTDB+tLjRNklqSqS36OwxtZWm6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEgEquTCowvy7IJDcTyozqWOajlhvqt/ZLNJLPcW4kEM9Aq2E
	Haxe27hXTsKdD5Xldkc2/iisHpA6Uvc8zaUnfEFDcF+P5IscZK0anRMlQD+SoSYf/A==
X-Gm-Gg: Acq92OG+YDc3RALGpZYNxtntQUqx7ar8FCU6A6hoZQZoR6U7wS+Vyss1EHCYzi8CfBQ
	B46Uf7Dc8DkDKa9vovBK/PbEDc0+vgN7ys44uoNz+iNy9SdA34wh93xPWGzak0wUY4k8Cgo/7+n
	LmdCBbG2j7takG7810X62UbuDK2yn5FYaTO002/mf2ha1UCHJnKzRFFtnsUPX79DIqqopYX9Vj8
	BszOKqqh7FRLYso8BoXHYNa0gznsp6zgainYmoCJtvxbhcEPoGw6XAbAmBUvxOvaV23/kUWJu8O
	MB9vuPi1njvr40J1rQyeSohoZQUZQqvDnl1qmKpGSjH2fbEzmHHBbKi5VOCivcxikukeQj/eKt7
	3XFZpcdka9AtLe0o2642ZXXOO+0exhHdpw1QW/T2G7LvfCS7Ug4XPWjbtiL3j6mcCviZfBWf6yp
	NWPK6PpOTR4NFDGfwDvk326gqxKPgiM+ix8uyDNA2zJfk4nSdOMB/OlTG8ODqGYvNnsLNv
X-Received: by 2002:a17:902:ce85:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2bdb32bcb70mr2835105ad.19.1779112557249;
        Mon, 18 May 2026 06:55:57 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm158176915ad.46.2026.05.18.06.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:55:56 -0700 (PDT)
Date: Mon, 18 May 2026 13:55:47 +0000
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
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agsaY9714WS1N4Zu@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:21PM +0000, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  33 +++++++
>  include/linux/iommu.h            |  20 ++++
>  3 files changed, 215 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index f71f14518248..765d042e22e3 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -11,6 +11,7 @@
>  #include <linux/liveupdate.h>
>  #include <linux/iommu-liveupdate.h>
>  #include <linux/iommu.h>
> +#include <linux/pci.h>
>  #include <linux/errno.h>
>  
>  #define iommu_max_objs_per_page(_array) \
> @@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
>  	domain->preserved_state = NULL;
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
> +
> +static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
> +			       iommu_max_objs_per_page(flb->curr_iommu_array));

Nit: Same thing about brittle casts here, shall we make them void ** and 
cast then within alloc_object_set ?


> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_iommu_array->objects[idx];
> +}
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu,
> +				 struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int ret;
> +
> +	if (!iommu->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (iommu->outgoing_preserved_state) {
> +		iommu->outgoing_preserved_state->hdr.ref_count++;
> +		return 0;
> +	}
> +
> +	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
> +	if (IS_ERR(iommu_hw_ser))
> +		return PTR_ERR(iommu_hw_ser);
> +
> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
> +	if (ret) {
> +		iommu_hw_ser->hdr.deleted = true;
> +		return ret;
> +	}
> +
> +	iommu->outgoing_preserved_state = iommu_hw_ser;
> +	return ret;
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
> +				    struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	iommu_hw_ser->hdr.ref_count--;
> +	if (iommu_hw_ser->hdr.ref_count)

Shall we add a defensive if (WARN_ON(!iommu_hw_ser)) ? I'm aware we
check this on within iommu_unpreserve_device() but we don't seem to
check it before calling iommu_unpreserve_locked() in the error path of
iommu_preserve_device.

> +		return;
> +
> +	iommu->outgoing_preserved_state = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);

We seem to assume we'll always have unpreserve implemented? If so, we
should check it during the iommu registration itself and fail it, i.e.

inside iommu_device_register() we could add something like:

#ifdef CONFIG_IOMMU_LIVEUPDATE
if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
               dev_name(iommu->dev));
        return -EINVAL;
}
#endif

This prevents a half-baked iommu driver from ever spinning up, completely
eliminating the need to check for it inside the live-update session paths.

> +	iommu_hw_ser->hdr.deleted = true;
> +}
> +
> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
> +{
> +	int idx;
> +
> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,

Nit: Same thing about brittle casts here, shall we make them void ** and 
cast then within alloc_object_set ?

> +			       iommu_max_objs_per_page(flb->curr_device_array));
> +	if (idx < 0)
> +		return ERR_PTR(idx);
> +
> +	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
> +	return &flb->curr_device_array->objects[idx];
> +}
> +
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 *preserved_state)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_ser *device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!domain->preserved_state)
> +		return -EINVAL;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return -EINVAL;

Nice.

> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->preserve_device ||
> +	    !iommu->iommu_dev->ops->preserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	device_ser = alloc_iommu_device_ser(flb_obj);
> +	if (IS_ERR(device_ser))
> +		return PTR_ERR(device_ser);
> +
> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
> +	if (ret) {
> +		device_ser->hdr.deleted = true;
> +		return ret;
> +	}
> +
> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);

Nit: Should these be updated to use virt_to_phys as well?

> +	device_ser->devid = pci_dev_id(pdev);
> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
> +
> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
> +	if (ret) {
> +		device_ser->hdr.deleted = true;
> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +		return ret;
> +	}
> +
> +	dev->iommu->device_ser = device_ser;
> +	*preserved_state = virt_to_phys(device_ser);
> +	return 0;
> +}
> +

[...]

Thanks,
Praan

