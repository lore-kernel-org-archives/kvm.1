Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DC34D93B
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306013; cv=none; b=mgBsRJ0qyuXFXvNvKOAj05M0eFR4pAotrf5neMR+uxsTWau1wxGaSEsLFqpPKLcMsiwhNIqQ7pdBeo6GC2IS0h4eUB0gc68x0WXymBocD0B+Igl2H99hZCAqtFAsYQ7OqiKkibeLUVcf79sprzkWL/2HmeRUYvz12uc6n/JlY0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306013; c=relaxed/simple;
	bh=T6+dg6Wz1c1tvS/wGPJZQCCsqwKCWSRMJIBbb0pbADU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfdC2izbj1eP6BjMkSUmSDme29AfbthJzA6QEQk+e3oRFw3CYuU/GKe+AsMzi1wYvAKIsqbRAr7NHHF6wJYIWi0rmvvMEvTUXdHV5wBV2L6caS/scIVaa5EOHVgW5KmH82rudb6BEa22L0WiW7Y+usjx/yTPl0V2s2DxtqNVPAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cx2gF+0Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cx2gF+0Y"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso2725ad.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 12:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779306011; x=1779910811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wje9r1zoBXXds3UzxCMoNq04XN47Olzurqr21FFgTU=;
        b=cx2gF+0YrKSbvs1N8iWDypXFD94cs1XbNOZVC8MgS6KDBY52l3wc1V9/SzFY1WONG0
         FshG+I1pRHuyvB6R/g+YzXI9w/PIG1ycq+L7ytWorRPiBuNacBNWXWl7bOqQLTCy/6yB
         DWyWbw277M+0IJqqn/VVYStMDHl9sih2AROE+KaPFWhU28qly9dp+CsQo4kdlonR3oL6
         KzEDrbIwUbuXs8sDFJN1CWf7Dec5TRwu9AwIBPndLJVtzSvk+keSi0WH7ppQOXoc5ZRL
         Oog/NWTT3pU8fsCeElu8nbKJ0GNgapnJ0OS46TWRDZYsadYtazb9Pcx38tSlXp+0sLap
         VEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306011; x=1779910811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wje9r1zoBXXds3UzxCMoNq04XN47Olzurqr21FFgTU=;
        b=FX3T3YbRQ0HXewi01c5Rpk434PzVhs6yu6+LXyTTa3odZUFlcIEk8NpfOqPeT1BL8K
         CPwoLy7d+Y1pF7eJ6UR8oJijr5Z5Fkfy7dbEg3lBQX/otVzJKss7rqR6oEs9mih2TWit
         KaW00QAY/YAUbpAdBK4zd/4Eij9LDXEWZ9S+4kXWv4MYcVsvThAoNhwq/AIKzxtFkpGL
         afabK6Qi3WuFLM1qIiJOnK49KzR7CcrqubpQdVImrpZvsFCBD6mnjr1UCo7Nkbq3Ca+N
         tU5JC45PnChwMakKoKYosflIsyLqSNJIQXQ4EnWbwEuATd0Gluosbwb9lQgN5oxCTiMF
         kl5A==
X-Forwarded-Encrypted: i=1; AFNElJ8kqwrpa+tbJA5K9A5jdRDhp6ox5DXeOPuVxD0UnsvnMDwcXIfwr/mx65wmp8e1h5IDXrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThSf6RrxKPHCrWHMe6n84Q8NtrwuTbf1g3XX5gADhxkltd8E7
	YIzWA4OPsm3toPNkYu7JPIr6+YJz5jE3UwgN92MGfPe/Bwj/OQYCL2iKgYsEwROLnw==
X-Gm-Gg: Acq92OHY10ncKPW9wB2SiGtBkDnW2kpMUb5/GHnwc6xw04La7C+QORL7PqkqN2RDjG4
	FhOHjpu5ReyZaK6uPVFZ/B79pMDw0O/t9o5hRqSwcaaPWt2Tau0pYKNalOImYtsUJVOwm/b/TKf
	GJbIDRPJpjXQ7JQ2rmOZEJtTaZZ5UBZwaajiG191oLh653md9CDR/AhDBn6a/bVx01HBoAwBNnc
	w5Bw0fPiVl77IxS+fZ2kPQ9bwYKkhxYiIv1LhIhqO1ZYhDPKGypR2/l7XzyOOjPAMdE+IIFEvfL
	ODQ2KAQ3hw2ryz1RlauoerTO4f6monw2JdCknSEQiIfHFkoe9/jVep2kwIx5OCJrRslA0WJUBOE
	XawYseWE+kMHzDMmYjkyoxTOUSXFlANpeBtyGWxUfueuctByG+rXXNGlVrhLP7tyrGiUND4ohv5
	eADKZ7vNlxWUr7zZGz5qXVbGtq7aJqg46mdJREu6vgHpydswFFSEII3WSLNzHeGxEQ+TJm2va/8
	vWAgtKV
X-Received: by 2002:a17:902:ce89:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2be9edfbb64mr642595ad.4.1779306010201;
        Wed, 20 May 2026 12:40:10 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369e383b31bsm3906879a91.2.2026.05.20.12.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:40:09 -0700 (PDT)
Date: Wed, 20 May 2026 19:40:05 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v2 13/16] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <ag4DzYZ4ToDcyfn3@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-14-skhawaja@google.com>
 <agz5rFcl27H8yzTY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agz5rFcl27H8yzTY@google.com>

On Wed, May 20, 2026 at 12:00:44AM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:30PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> Register iommufd with the LUO framework and implement the preserve and
>> unpreserve ops to save marked HWPTs.
>>
>> To make sure mappings do not change during preserved state, add a
>> liveupdate_immutable flag to IOAS. When an HWPT is preserved, its IOAS
>> is marked immutable and any map/unmap attempts will fail with -EBUSY.
>> This is synchronized using the domains_rwsem to prevent races with
>> concurrent mapping operations.
>>
>> The preserve callback iterates over the marked HWPTs, verifies that the
>> backing memory pages are preserved, and calls iommu_domain_preserve() to
>> preserve the associated IOMMU domain.
>>
>> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>[...]
>
>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>> index 111f4d42e210..3c88aa115d08 100644
>> --- a/drivers/iommu/iommufd/iommufd_private.h
>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>> @@ -98,6 +98,9 @@ struct io_pagetable {
>>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>>  	struct rb_root_cached reserved_itree;
>>  	u8 disable_large_pages;
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	bool liveupdate_immutable;
>> +#endif
>>  	unsigned long iova_alignment;
>>  };
>>

[snip]
>> +
>> +static int iommufd_preserve_hwpt(struct iommufd_hwpt_paging *hwpt,
>> +				 struct iommufd_hwpt_ser *hwpt_ser,
>> +				 struct liveupdate_session *session)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	bool ioas_made_immutable = false;
>> +	int rc;
>> +
>> +	if (!hwpt->ioas->iopt.liveupdate_immutable) {
>> +		/*
>> +		 * Make IOAS immutable so the DMA mappings do not change while
>> +		 * the HWPT is preserved. Since one IOAS can have multiple
>> +		 * HWPTs, if an error occurs this call needs to make the IOAS
>> +		 * mutable again if it was the one that made it immutable.
>> +		 */
>> +		ioas_made_immutable = true;
>> +		ioas_set_immutable(hwpt->ioas, true);
>> +
>> +		rc = check_iopt_pages_preserved(session, hwpt);
>> +		if (rc)
>> +			goto err;
>> +	}
>
>Nit:
>I'm thinking what happens for a shared IOAS situation? Say, 2 devices,
>in the same container, behind 2 different IOMMUs, sharing the IOAS. Each
>device will have it's own HWPT (N:1 mapping for HWPT v/s IOAS)
>
>So, what happens if Device 1 succeeds with preservation but device 2
>doesn't? For example:
>
>1. Preserve Device 1:
> - It sees liveupdate_immutable is false.
> - Sets ioas_made_immutable = true on its local stack.
> - Flips IOAS to immutable.
> - Preservation succeeds.
>
>2. Preserve Device 2:
> - It sees liveupdate_immutable is already true (because Device 1 set it).
> - Sets ioas_made_immutable = false on its local stack.
> - The Failure: iommu_domain_preserve fails for Device 2.
> - The Jump: Hits goto err;
>
>Now, inside the err: label for device 2, it checks
>if (ioas_made_immutable), since it is FALSE for device 2,
>it does nothing.
>
>I agree we return an error code to the caller which finally cleans it up
>well, but I'm considering if we should make liveupdate_immutable
>refcountable? Since the error handling in iommufd_preserve_hwpt() is
>logically incomplete for shared IOAS as it only attempts to restore
>mutability if the current HWPT set immutable = true;

This is a valid scenario and as you already pointed that it is handled
by the error handling in the caller.

But I agree refcount makes it cleaner. I will update this.
>
>> +
>> +	hwpt_ser->token = hwpt->liveupdate_token;
>> +	hwpt_ser->reclaimed = false;
>> +
>> +	rc = iommu_domain_preserve(hwpt->common.domain, &domain_ser);
>> +	if (rc < 0)
>> +		goto err;
>> +
>> +	hwpt_ser->domain_data = virt_to_phys(domain_ser);
>> +	return 0;
>> +
>> +err:
>> +	if (ioas_made_immutable)
>> +		ioas_set_immutable(hwpt->ioas, false);
>> +
>> +	return rc;
>> +}
>
>[...]
>
>> +
>> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
>> +{
>> +	struct iommufd_ctx *ictx = iommufd_ctx_from_file(args->file);
>> +	struct iommufd_hwpt_paging *hwpt;
>> +	struct iommufd_ser *iommufd_ser;
>> +	struct iommufd_object *obj;
>> +	unsigned int nr_hwpts;
>> +	unsigned long index;
>> +	unsigned int i;
>> +	void *mem;
>> +	int rc;
>> +
>> +	if (IS_ERR(ictx))
>> +		return PTR_ERR(ictx);
>> +
>> +	mutex_lock(&ictx->liveupdate_mutex);
>> +
>> +	/* Count the number of HWPTs to preserve */
>> +	nr_hwpts = 0;
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>> +
>> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>> +		if (!hwpt->common.domain) {
>> +			rc = -EINVAL;
>> +			xa_unlock(&ictx->objects);
>> +			goto out_unlock;
>> +		}
>> +		nr_hwpts++;
>> +	}
>> +	xa_unlock(&ictx->objects);
>> +
>> +	mem = kho_alloc_preserve(struct_size(iommufd_ser,
>> +					     hwpt_array, nr_hwpts));
>> +	if (!mem) {
>> +		rc = -ENOMEM;
>> +		goto out_unlock;
>> +	}
>> +
>> +	iommufd_ser = mem;
>> +	iommufd_ser->nr_hwpts = nr_hwpts;
>
>Nit: Can there be a TOCTOU here? We first count nr_hwpts in the first
>loop, but actually preserve them in the loop below. Is it possible for a
>Guest to race with these loops and destroy a HWPT?
>
>That could cause a bug in the new kernel as it may try to restore
>nr_hwpts which is one more than the preserved HWPTs.

Agreed. The HWPT is locked in the preserve loop below, I will update the
nr_hwpts to handle this after that loop to handle this.
>
>> +
>> +	/* Preserve HWPTs */
>> +	i = 0;
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>> +
>> +		if (!iommufd_lock_obj(obj)) {
>> +			rc = -ENOENT;
>> +			xa_unlock(&ictx->objects);
>> +			goto out_unpreserve;
>> +		}
>> +
>> +		/*
>> +		 * HWPT is locked so it will not be destroyed. The xarray lock
>> +		 * can be released here before preserving the HWPT.
>> +		 */
>> +		xa_unlock(&ictx->objects);
>> +		hwpt = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>> +		rc = iommufd_preserve_hwpt(hwpt, &iommufd_ser->hwpt_array[i++], args->session);
>> +		if (rc) {
>> +			iommufd_put_object(ictx, obj);
>> +			goto out_unpreserve;
>> +		}
>> +
>> +		/* Mark as preserved */
>> +		hwpt->liveupdate_preserved = true;
>> +		xa_lock(&ictx->objects);
>> +	}
>> +	xa_unlock(&ictx->objects);
>
>[...]
>
>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>> index 9bdb2945afe1..3b0c0acb8856 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -55,6 +55,7 @@
>>  #include <linux/overflow.h>
>>  #include <linux/slab.h>
>>  #include <linux/sched/mm.h>
>> +#include <linux/memfd.h>
>>  #include <linux/vfio_pci_core.h>
>>
>>  #include "double_span.h"
>> @@ -1421,6 +1422,7 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>>
>>  {
>>  	struct iopt_pages *pages;
>> +	int seals;
>>
>>  	pages = iopt_alloc_pages(start_byte, length, writable);
>>  	if (IS_ERR(pages))
>> @@ -1428,6 +1430,11 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>>  	pages->file = get_file(file);
>>  	pages->start = start - start_byte;
>>  	pages->type = IOPT_ADDRESS_FILE;
>> +
>> +	seals = memfd_get_seals(file);
>> +	if (seals > 0)
>> +		pages->seals = seals;
>> +
>
>Can caching memfd seals create a TOCTOU issue?
>IIUC, iopt_alloc_file_pages happens at map time, However, the userspace
>is allowed to map a memfd and then apply the F_ADD_SEALS via fcntl()
>later in its setup sequence? For example a sequence like:
>
>1. VMM creates a memfd. It has 0 seals.
>2. VMM calls IOMMU_IOAS_MAP_FILE. IOMMUFD caches pages->seals = 0.
>3. VMM finishes its setup and calls:
>   fcntl(fd, F_ADD_SEALS, F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL).
>
>4.VMM initiates Live Update.
>5.check_iopt_pages_preserved looks at the cached pages->seals
>  (which is still 0), sees the seals are missing, & kills the LiveUpdate
>  with -EINVAL, even though the file is properly sealed..

This is true and it is intentionally this way to make sure that the seal
is applied during mapping otherwise user can apply the seal after
resizing the memfd and preserve IOMMU mappings that are pointing to
unpreserved pages. Consider following:

1. VMM creates a memfd and seals is zero.
2. VMM maps memfd into ioas/hwpt.
3. VMM resizes the memfd.
4. VMM seals memfd
5. VMM preserves the memfd (it only preseves the current size).
6. VMM preserves iommufd and it succeeds as memfd is sealed.

But the pages being referred by the iommu mappings are refcounted in
current kernel, but not preserved.

Check the comment in check_iopt_pages_preserved() also. I will add a
comment here also.
>
>Thus, I guess we should dynamically check seals via memfd_get_seals()
>
>>  	return pages;
>>  }
>>
>
>Thanks,
>Praan

Sami
