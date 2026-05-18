Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C6381AEB
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129876; cv=none; b=ja12GBjnHQKSyiWXFz4dwPBwxGp7QqBikjB8fRn8vMRnoAfL3vM/dKCW+Jt2mneYniELgCGTCPDjh6164//GSU4X3c0s0FqAhY4Z2eadpH/nUl8407vb6a/qad9UUFQn1xjXLl0YfWC8BU1HmpNDXdCJA65iOhrtU719+wG/0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129876; c=relaxed/simple;
	bh=Ic1nHyDVe0+lHF29JSEClWUQfaRhDT14d/5L38QtIwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8u6kJOgsvfOY4CcMI3V5JxdKSxiX5omb4Rqpu914Y+h29FaEvMy0xIfvhDIXPtqz+kRPho5JJyocBHV6TE9/pGmogcuDxvXaU9b9qxM3ysTh7WyjTl3+AoN/fha27dIAMD7ZMAfiuq+GZtywl1srEkndEv/8vX+b10XYGYcqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToESO5bl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToESO5bl"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1165ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779129875; x=1779734675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=42Co3FfgxAP6Wa+6cQjpccW4rhzcESaNN3XiEoxLDQM=;
        b=ToESO5blk2mYRU+9/j/uXmG7Z6NVPh7IQWcuBCP0fOydoq9Jred8KAOuK9yymTyqK7
         3YT4XOFOvAiNCR+Jry6IFzmU6xwpf9Anesf1xNApzs41On7Ds4RlHVbEeQL6MJxlmizq
         UnHa4np1OZ8m2cZme+D/LchUHQVZkuilqAs0zSU6DBdajhRejOCFZ5VE5rFkzPT6fDiV
         SLLKihKtOEc0/J4pmpykcZHLYF8VPHYcVXb7g3GCNVns4GUv7AolPk/vTri4085bkmYx
         VHsbV33xzHBJlSchG2KFm3DAqLDG7FKCJK2VDYyZHFkeoXgWgzXDt6VldPXG4WrcJCJ3
         pO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129875; x=1779734675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42Co3FfgxAP6Wa+6cQjpccW4rhzcESaNN3XiEoxLDQM=;
        b=hBwHWl2WIVasVeBSKxozCSpelbfhHdGtVOjQ0oH/w8Sqlli//JxTxrOPSwL0qllSxs
         ehc1+oPJfkLF01Snaan9241YJGrCqtfzfRUpj6rwBzUFh743fIpdSEsCyO4i419y9ryR
         Pko1khZ2VeRJSLuSJrUKuQW//mqOVLldymVz2g2t3+4xbXzb5POz0coTKdeqQ9F8bYq+
         yD71zYGENsyZwc9WHpOTg3Nv/viv5BKTJsaiKAFPcyBhT07l4EupQspUGCTumXFU3gSW
         LIEvbW/0lxNDa+ifBVrTmDaEqY7zmYVlrS8MPw0GCk6NjE2U+rm488OMOcoxZwfLICeX
         mtOA==
X-Forwarded-Encrypted: i=1; AFNElJ/TKFCGr+O9m7/73V3VFTNg6obnwJhJzs9jfHpoKQYtPo0OEbtbkInO3z3VYcVyAiU+nd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmSqABgH4YPeRJUvfS4Hsz4lCFRnl/bfnSA3H+PIFb96/Q9btI
	1DkU5XKM5+bMZF7UuNOEax9qG0roKsn4ZlyKnVUB/Gv5Yt5sNb4kJ+vBg9tqRTeakA==
X-Gm-Gg: Acq92OGtA10VQYonOKKr5uMr1ZYrCiog8dqJrhr3JXRHb6kRELbvLlc81M8U65rN0gN
	HJGh4IEz+emTA/QRnGcF8rmzu2TsfM6D7H1NIpU4DSHo1/6vG8bhzFPQJe9WFcURJ0RpoAqUXbC
	/MyRd+0Q2W7Rm76bCQPPrWNvp2w293xwE4M6eezMeYeJUhtyM7sdQh1b8gRJm8f7lYl1RIxdZ1a
	ccL/ZEB6EUZOfI2HoiY6/o0vKDNfSdbaewIsJL3O9sI4e44KccVLjDhnb2r/Tgf6wDkf7mMgEBp
	OBGc7PvUREgYupWZD5myVVMZkSlFBaIGDW/ilvkfN3MQIjnUK3Kor4rQffjlJ0hdrylAAsS4omv
	8jZOaQkReGnFlNwOTMmZbZ7XaOrmHXVBHYrUqmXu6c+dj975/5qVIv9SGIk979dI088hKuT4y6M
	Q4vqQwyLds+EARQ/8AYzrmObdKywzu0eW/lpn3eeF2V7asgNy7oCqGbZQGtvPcAv6SG9V9+U6dg
	m4jcMoZ
X-Received: by 2002:a17:902:cf0d:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bdb329b56bmr3672775ad.17.1779129874166;
        Mon, 18 May 2026 11:44:34 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe64a9sm158941345ad.53.2026.05.18.11.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:44:33 -0700 (PDT)
Date: Mon, 18 May 2026 18:44:30 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
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
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agtcSw4s0M2ArWI4@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <agsaY9714WS1N4Zu@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsaY9714WS1N4Zu@google.com>

On Mon, May 18, 2026 at 01:55:47PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:21PM +0000, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>> by the IOMMU drivers that support preservation of devices that have
>> their IOMMU domains preserved. During device preservation the state of
>> the associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  33 +++++++
>>  include/linux/iommu.h            |  20 ++++
>>  3 files changed, 215 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index f71f14518248..765d042e22e3 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/liveupdate.h>
>>  #include <linux/iommu-liveupdate.h>
>>  #include <linux/iommu.h>
>> +#include <linux/pci.h>
>>  #include <linux/errno.h>
>>
>>  #define iommu_max_objs_per_page(_array) \
>> @@ -293,3 +294,164 @@ void iommu_domain_unpreserve(struct iommu_domain *domain)
>>  	domain->preserved_state = NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_domain_unpreserve);
>> +
>> +static struct iommu_hw_ser *alloc_iommu_hw_ser(struct iommu_flb_obj *flb)
>> +{
>> +	int idx;
>> +
>> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_iommu_array,
>> +			       iommu_max_objs_per_page(flb->curr_iommu_array));
>
>Nit: Same thing about brittle casts here, shall we make them void ** and
>cast then within alloc_object_set ?

Agreed. Will change this.
>
>
>> +	if (idx < 0)
>> +		return ERR_PTR(idx);
>> +
>> +	flb->curr_iommu_array->objects[idx].hdr.ref_count = 1;
>> +	return &flb->curr_iommu_array->objects[idx];
>> +}
>> +
>> +static int iommu_preserve_locked(struct iommu_device *iommu,
>> +				 struct iommu_flb_obj *flb_obj)
>> +{
>> +	struct iommu_hw_ser *iommu_hw_ser;
>> +	int ret;
>> +
>> +	if (!iommu->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	lockdep_assert_held(&flb_obj->lock);
>> +	if (iommu->outgoing_preserved_state) {
>> +		iommu->outgoing_preserved_state->hdr.ref_count++;
>> +		return 0;
>> +	}
>> +
>> +	iommu_hw_ser = alloc_iommu_hw_ser(flb_obj);
>> +	if (IS_ERR(iommu_hw_ser))
>> +		return PTR_ERR(iommu_hw_ser);
>> +
>> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
>> +	if (ret) {
>> +		iommu_hw_ser->hdr.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	iommu->outgoing_preserved_state = iommu_hw_ser;
>> +	return ret;
>> +}
>> +
>> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
>> +				    struct iommu_flb_obj *flb_obj)
>> +{
>> +	struct iommu_hw_ser *iommu_hw_ser = iommu->outgoing_preserved_state;
>> +
>> +	lockdep_assert_held(&flb_obj->lock);
>> +	iommu_hw_ser->hdr.ref_count--;
>> +	if (iommu_hw_ser->hdr.ref_count)
>
>Shall we add a defensive if (WARN_ON(!iommu_hw_ser)) ? I'm aware we
>check this on within iommu_unpreserve_device() but we don't seem to
>check it before calling iommu_unpreserve_locked() in the error path of
>iommu_preserve_device.

Agreed. I will add this.
>
>> +		return;
>> +
>> +	iommu->outgoing_preserved_state = NULL;
>> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);
>
>We seem to assume we'll always have unpreserve implemented? If so, we
>should check it during the iommu registration itself and fail it, i.e.
>
>inside iommu_device_register() we could add something like:
>
>#ifdef CONFIG_IOMMU_LIVEUPDATE
>if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
>    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
>        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
>               dev_name(iommu->dev));
>        return -EINVAL;
>}
>#endif
>
>This prevents a half-baked iommu driver from ever spinning up, completely
>eliminating the need to check for it inside the live-update session paths.

Replied to this in the other thread where you suggested this inline with
Baolu's comment.
>
>> +	iommu_hw_ser->hdr.deleted = true;
>> +}
>> +
>> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
>> +{
>> +	int idx;
>> +
>> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_device_array,
>
>Nit: Same thing about brittle casts here, shall we make them void ** and
>cast then within alloc_object_set ?

Will update this in next revision.
>
>> +			       iommu_max_objs_per_page(flb->curr_device_array));
>> +	if (idx < 0)
>> +		return ERR_PTR(idx);
>> +
>> +	flb->curr_device_array->objects[idx].hdr.ref_count = 1;
>> +	return &flb->curr_device_array->objects[idx];
>> +}
>> +

[snip]
>> +
>> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
>> +	if (ret) {
>> +		device_ser->hdr.deleted = true;
>> +		return ret;
>> +	}
>> +
>> +	device_ser->domain_iommu_ser.domain_phys = __pa(domain->preserved_state);
>> +	device_ser->domain_iommu_ser.iommu_phys = __pa(iommu->iommu_dev->outgoing_preserved_state);
>
>Nit: Should these be updated to use virt_to_phys as well?

Will update these.
>
>> +	device_ser->devid = pci_dev_id(pdev);
>> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
>> +
>> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
>> +	if (ret) {
>> +		device_ser->hdr.deleted = true;
>> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>> +		return ret;
>> +	}
>> +
>> +	dev->iommu->device_ser = device_ser;
>> +	*preserved_state = virt_to_phys(device_ser);
>> +	return 0;
>> +}
>> +
>
>[...]
>
>Thanks,
>Praan
>

Sami
