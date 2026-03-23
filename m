Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F93659EA
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297700; cv=none; b=Nge+RAeODkDhAu456IVtulhf09sK+iPGBDDkcS8qIZKaZ+N1GBB46vjJZ6w2FqysszdS0pbVICVGNI1Sra3m7rmh29jsCA4pxk8x/hTSDhGDMIBge5vAcBdVSJOoQM+yIyFbvCnhrhVCWpV4Sh9wGhzGEDVATGxjwte6WHoTqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297700; c=relaxed/simple;
	bh=Z+0+3TcrMrU5Ujk1sHPJMlRXC0Eeq9rMNfbNi+xXmqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HELUdhoPrua4r1YES0NB+DMj4Q3b/SW3IepvKrfUax1RjE6+gBUH6w7iA/vx2zBt07IlWpVWt4e5Y+8vCvUaP3UhMzvh42Rq4+h3L2IDlG/aXb/qHH/P+Wi/dBRXUFqf1uM55WktaPxYExQ3Is4z8otVRelvN2UHR6CxYfo4jII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Km1u5fGt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km1u5fGt"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b052562254so26805ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774297699; x=1774902499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVB+M1ARpuKmS3d+ozVws2Lc23aSqaEdxwdXJm81KT0=;
        b=Km1u5fGte0H3MSGvwjiwS3SKpo0mKmwRslsHkWFUBu4zByzPjOHBNBkJWOT0CXvQLW
         5sNWfv7SAf/n0JKyKsPcZTt6sge9rKD4oYEDNa+hGPbyLOetGR06lNSdWfnrXvqRZTFH
         FE0PW6SoAaAlE+gT8XjvkzjCJpRc00E+WdcWwadHH2j1irw682GhnZZBDsgkhdmAEEh5
         sXgpMlIqmxLavxFbxxYVhKUpS9t8p5O4E2XbWFj+vBmKiCPsrzmUcJGUxR3DbOY3NexU
         kxCqyFRgKSuPNcHcDPYYJu92Cr7sF65vF1osHo1T8Vi55Sblhs4YpVMVBj9y+NXIS5Rl
         xSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774297699; x=1774902499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVB+M1ARpuKmS3d+ozVws2Lc23aSqaEdxwdXJm81KT0=;
        b=DHfU76Ix899qwsSHbjgFndS4rlEFTrPMbt1Fjp54B0cdz53sEGw6tqXCqDlK2b9Kmr
         gc+jw9PAb8uWF2Ev7otDuxSjRlNSryuxoq6Ttd8iJd7Los4+FaNQgIykAzJPq+Y1JJey
         MFb5HLJ0Nc33wOZd9A0+HCVRJVMmAQx8+FQcJlUu/P51GOWZIjiY/ncuVyLJJr1s2gB2
         QPlRIdShwBhh+vJrj2g/DiIflU/H/dUyuMv1t9GH6UY+lr+faou42TI0ZTsk7suOtQtO
         +GupFVjXjEq8JegixolJGRf6HBQLqMdIm3Q8v91HIiFjfNXnm//DClH3b6Ozkwk8ffF6
         oYMw==
X-Forwarded-Encrypted: i=1; AJvYcCW416lnyT78yus/ZmDWJvk5dqQtssh6vB6kqEax2paJ5rMFwOZxR6i1iuQczGAYndDhUiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxObySMfQa3wUm1tS4NeOcMEDOwF2lmCRlIC1T9nDKrz9YUA5
	XAa/sMbeL2WEDNXXkfv3mdboUqm4V1HcPNzk/ZKYUcE0jzEiWIpL5vA31vSsPLoTzQ==
X-Gm-Gg: ATEYQzxod0UWlcrHuKR1QnfiPfMUw5u1hzmy2AVWVQ51XrlrVWbU5tCbM0F/D+SNeIA
	O/cZNJJVF9sQvSMXsHR9Nh1gl5YmBvpEuf5CO1WAGDQHbf6bAgZkYOwAGNwLQfpPLtVXh+R1WjE
	UgDLwWM05Zf43jrzuaFgUPuA0Fkvl1EvKzksCtg0dfdNe07xbap42fNJHXvbw/U9eHWI3Kh8rtp
	PexNQW+XbZtsW07LRmvBRLkb3SHLPoq0CmoDj5pwXFh9bR9qV/zpuVPwUIGqhpWeKnFMBqpIQie
	F2zZL/YwahiyE5UVygcHOSHYGzZOV1A1zPwU3r/6tVmUkDJqDTuNzkIof4evpa8Q8vV+klDGO5n
	ymmdE1xbBWua11Q2SQAFExJENxCkNJtZOdAUu0rKUbXtzp2VD4Kuo+dMtAU2+JnmmmIaNNqDlgs
	sq0msMZVbJ3izaGCU8JCaW5THl5XbbcVQjql+Gbef8DFVtrkMhpIHaS38zR9nk
X-Received: by 2002:a17:902:f787:b0:2a1:3cdc:7720 with SMTP id d9443c01a7336-2b0a68a1461mr106215ad.21.1774297698546;
        Mon, 23 Mar 2026 13:28:18 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm118298165ad.25.2026.03.23.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:28:17 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:28:13 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: Re: [PATCH 11/14] iommufd-lu: Persist iommu hardware pagetables for
 live update
Message-ID: <20260320230654.GB659132.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-12-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-12-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:45PM +0000, Samiullah Khawaja wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The caller is expected to mark each HWPT to be preserved with an ioctl
> call, with a token that will be used in restore. At preserve time, each
> HWPT's domain is then called with iommu_domain_preserve to preserve the

Nit: Add () after iommu_domain_preserve, it makes easier to know this is
a function.

> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> +static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
> +			      struct iommufd_lu *iommufd_lu,
> +			      struct liveupdate_session *session)
> +{
> +	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;

We should rename hwpts to something to denote that it is a list.

> +	struct iommu_domain_ser *domain_ser;
> +	struct iommufd_hwpt_lu *hwpt_lu;
> +	struct iommufd_object *obj;
> +	unsigned int nr_hwpts = 0;
> +	unsigned long index;
> +	unsigned int i;
> +	int rc = 0;
> +
> +	if (iommufd_lu) {
> +		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
> +				GFP_KERNEL);
> +		if (!hwpts)
> +			return -ENOMEM;
> +	}
> +
> +	xa_lock(&ictx->objects);
> +	xa_for_each(&ictx->objects, index, obj) {
> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
> +			continue;
> +
> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
> +		if (!hwpt->lu_preserve)
> +			continue;
> +
> +		if (hwpt->ioas) {
> +			/*
> +			 * Obtain exclusive access to the IOAS and IOPT while we
> +			 * set immutability
> +			 */
> +			mutex_lock(&hwpt->ioas->mutex);
> +			down_write(&hwpt->ioas->iopt.domains_rwsem);
> +			down_write(&hwpt->ioas->iopt.iova_rwsem);
> +
> +			hwpt->ioas->iopt.lu_map_immutable = true;

It feels odd that this is not cleaned up in this function as a part of
its error handling. Now it becomes caller resposibility to handle clean
up for the side effect created by this function. 

IMO, this function should clean up lu_map_immutable instread of callers
to make sure they call cleanups. You can also try exploring XA_MARK_*
APIs if that can help in cleaning up easily.

> +int iommufd_liveupdate_unregister_lufs(void)
> +{
> +	WARN_ON(iommu_liveupdate_unregister_flb(&iommufd_lu_handler));
> +
> +	return liveupdate_unregister_file_handler(&iommufd_lu_handler);

This seems little insconsistent, iommu_liveupdate_unregister_flb() has
WARN_ON and liveupdate_unregister_file_handler() does not.

Also, refer https://lore.kernel.org/all/20260226160353.6f3371bc@shazbot.org/

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> @@ -775,11 +775,21 @@ static int __init iommufd_init(void)
>  		if (ret)
>  			goto err_misc;
>  	}
> +
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)) {
> +		ret = iommufd_liveupdate_register_lufs();
> +		if (ret)
> +			goto err_vfio_misc;
> +	}
> +

Do we need IS_ENABLED here? iommufd_private.h is providing definition
for both values of CONFIG_IOMMU_LIVEUPDATE.

Nit: What is lufs? Should we just rename to iommufd_liveupdate_register()?

>  	ret = iommufd_test_init();
>  	if (ret)
> -		goto err_vfio_misc;
> +		goto err_lufs;
>  	return 0;
>  
> +err_lufs:
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
> +		iommufd_liveupdate_unregister_lufs();
>  err_vfio_misc:
>  	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
>  		misc_deregister(&vfio_misc_dev);
> @@ -791,6 +801,8 @@ static int __init iommufd_init(void)
>  static void __exit iommufd_exit(void)
>  {
>  	iommufd_test_exit();
> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
> +		iommufd_liveupdate_unregister_lufs();

Same as above.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> @@ -1427,6 +1429,12 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>  	pages->file = get_file(file);
>  	pages->start = start - start_byte;
>  	pages->type = IOPT_ADDRESS_FILE;
> +
> +	pages->seals = 0;

This is already 0.

> +	seals = memfd_get_seals(file);
> +	if (seals > 0)
> +		pages->seals = seals;
> +
>  	return pages;
>  }
>  
> --- /dev/null
> +++ b/include/linux/kho/abi/iommufd.h
> +
> +struct iommufd_lu {
> +	unsigned int nr_hwpts;

Should this be u32 or u64?

> +	struct iommufd_hwpt_lu hwpts[];
> +};
> +

Should this also be __packed?

> +#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
