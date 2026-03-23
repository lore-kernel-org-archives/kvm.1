Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECF337F744
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301678; cv=none; b=AGZFxoGHXuesDE0sbtog21TkwSUnP8SzZSTvhlCEh6KG7OnmsSjrBBhHl/PoYdD+rScY9L9s5DCRvtGqntm8Kcc9QulCT7zurugv+6fLwpGIwPRau5fTbxDOJ1q/aLokJf/9ACSow24d4iukQvtHXPwk4q0QUPfYdT4KvXG32Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301678; c=relaxed/simple;
	bh=RsieRZ+VCWLZIXMh2Ozv0KLI7UIr8x0rFUR6Sii/tzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G58szz2Rj30KodyjmnOXCQh8FGfwcPwP5Rkpo2FSq2PYFlb29K6gJqwjo8L1ejBLwhsaWgfWil5GXmeB6Upj+ZE2C25tiNpXbJCmcmgXiuGZT9e/vqJ9qnn/2uwvQqO4mTx2nUAWkAB3CgIKR2iQMzavhdH9o4JyV2uRFJyN+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0GK61sr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0GK61sr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052562254so32865ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774301677; x=1774906477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVYWkdGYSoCJ0Jra5vEPuFKgbrIGxBQ8Jn3YEa+aygo=;
        b=b0GK61srwT3fMcJGI0DXQX9/hUnn5KJHftHeD+ATuFkIXV3lSfEEjP2qhOQGPqgNkC
         lDsSk6VHn4zhKcXIFJCl9uo1UqE7HdeiM1Bx2IzNHDt7EQ1B/zki90FmNJT3V4BQT8+s
         HFU88UbgdgqDE4zQ13rj5b7+I5TutXeFfVnz4IwJVaTS7e3H5UNCLNVNv3DNjjttVop4
         lr+MQ5hOB9kxfjJz7933XlPBU31zn9EdGrQiCPizXStv7rvRY43rkGFTQqJDnkHHzrWa
         XBQu5uTC+N4OZi6r7NunXgBIucSjtBAe89bVKAehFGoFXp7PnvClP3+0k7H6v8MxCWgU
         vTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301677; x=1774906477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVYWkdGYSoCJ0Jra5vEPuFKgbrIGxBQ8Jn3YEa+aygo=;
        b=T2vZzyvkW1RYxySXNGUATumG/7mk08KN7OviuHVCmQ7FSzqXJXjophAxncIWgXnmdu
         vMXB+9OdS+nq2dtxkjV89C8VjbLQ0yviFkKRupTVHqfBVNJXaKaMLOTcL8Twet2/XI4p
         2vVTGcdi63MsBvgCyZpPL8+LWAXPgIBbNTP5C9d5npyy6m+emR++qwslxG9Fs2dNgwPJ
         2AYlMiZF/hbMOJ5cE1hdpiNN3yycS9wfup0MGdeIhzoDjoyCo7ofRoAFAafWToM6oBHR
         mNErBtHY/33HaI2+7fBAxnMu2j+zTupsj5/m6abVQ6PXY5EXQmMNBNVdvaZpE8jTmiZl
         m17g==
X-Forwarded-Encrypted: i=1; AJvYcCXOtxH5o8u62KDj9E7i4RdEuWaYESO1TrnZhSVnZ/CPkZ3/Fv2zwtc4/CXdtpEcGQc6YzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5Umd9EWESFktB2R2G4H0qKIgr5cQqJNvzDPEPDva7VPAMf3F
	noLQnx1shHHpOf7WGKjg9SeE9T5e2odAc/gcs5S3xBh4pZhqjQaNWQYfgP8CaBB0gQ==
X-Gm-Gg: ATEYQzyfcKcXTvVT4hRXHrtgsypEddl2E3MHdZbwxfwWwn5j6ao84yRGLdt+sGClPJ1
	Wyn7IGSeXg8E6lUMGJVLCD71IzCo5foFhDcwnbw0R5E3BbIE/H1cHwFfIRWRd1qiX5ikVS8DDRO
	HP6DX3QKyqfRJM1yRTF5ORvgPuY5ohCxA1zSQiCWPikfB74Qeyv3p+q76hgaOBMgYYM0BGCU1pk
	E8tMvEvWvB+Skv7LxNSR+yTg41f8rxk6NUHI6lo8Moei637S+i7G3NgP/KWxB4K1HMIXtxwFg6r
	QTls0YGPdBipUS69c/80vH2GblVZtht8fhnEYfe5cfqARPIOhg3HIHaW+Ayy3hbbHVUJGkgl3y7
	A3S/2/7rdTvFR8Qq2YFFGygw76eI5bRLtl9v+KNslJUYR74+mKkpYyq3PxMZiBKUQhg/d+rBlZe
	s+eLUX/NeAg3U6gy46fUHgRMWxCbapfqlX3qBHHJwcswLPOQKmFpLIhm4aIlCpcBxh5iXnMbt8
X-Received: by 2002:a17:902:f712:b0:2ad:ab68:f2c3 with SMTP id d9443c01a7336-2b0a6737893mr333575ad.13.1774301676102;
        Mon, 23 Mar 2026 14:34:36 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c38565096sm5283490b3a.51.2026.03.23.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:34:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:34:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
Message-ID: <acGmn35-3F-kLJNf@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-12-skhawaja@google.com>
 <20260320230654.GB659132.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260320230654.GB659132.vipinsh@google.com>

On Mon, Mar 23, 2026 at 01:28:13PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:45PM +0000, Samiullah Khawaja wrote:
>> From: YiFei Zhu <zhuyifei@google.com>
>>
>> The caller is expected to mark each HWPT to be preserved with an ioctl
>> call, with a token that will be used in restore. At preserve time, each
>> HWPT's domain is then called with iommu_domain_preserve to preserve the
>
>Nit: Add () after iommu_domain_preserve, it makes easier to know this is
>a function.

Will do.
>
>> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>> +static int iommufd_save_hwpts(struct iommufd_ctx *ictx,
>> +			      struct iommufd_lu *iommufd_lu,
>> +			      struct liveupdate_session *session)
>> +{
>> +	struct iommufd_hwpt_paging *hwpt, **hwpts = NULL;
>
>We should rename hwpts to something to denote that it is a list.

Agreed. Will do.
>
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommufd_hwpt_lu *hwpt_lu;
>> +	struct iommufd_object *obj;
>> +	unsigned int nr_hwpts = 0;
>> +	unsigned long index;
>> +	unsigned int i;
>> +	int rc = 0;
>> +
>> +	if (iommufd_lu) {
>> +		hwpts = kcalloc(iommufd_lu->nr_hwpts, sizeof(*hwpts),
>> +				GFP_KERNEL);
>> +		if (!hwpts)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	xa_lock(&ictx->objects);
>> +	xa_for_each(&ictx->objects, index, obj) {
>> +		if (obj->type != IOMMUFD_OBJ_HWPT_PAGING)
>> +			continue;
>> +
>> +		hwpt = container_of(obj, struct iommufd_hwpt_paging, common.obj);
>> +		if (!hwpt->lu_preserve)
>> +			continue;
>> +
>> +		if (hwpt->ioas) {
>> +			/*
>> +			 * Obtain exclusive access to the IOAS and IOPT while we
>> +			 * set immutability
>> +			 */
>> +			mutex_lock(&hwpt->ioas->mutex);
>> +			down_write(&hwpt->ioas->iopt.domains_rwsem);
>> +			down_write(&hwpt->ioas->iopt.iova_rwsem);
>> +
>> +			hwpt->ioas->iopt.lu_map_immutable = true;
>
>It feels odd that this is not cleaned up in this function as a part of
>its error handling. Now it becomes caller resposibility to handle clean
>up for the side effect created by this function.

The immutablity is set early during preservation and it might be
required to unset it in the caller also when error occurs. I have to
rework this to not acquire a mutex lock in a spin lock, so I think this
part can also be reworked by doing it in following steps,

- Alloc memory for preservation.
- Mark immutable.
- Preserve using IOMMU core APIs.
>
>IMO, this function should clean up lu_map_immutable instread of callers
>to make sure they call cleanups. You can also try exploring XA_MARK_*
>APIs if that can help in cleaning up easily.

Agreed. 
>
>> +int iommufd_liveupdate_unregister_lufs(void)
>> +{
>> +	WARN_ON(iommu_liveupdate_unregister_flb(&iommufd_lu_handler));
>> +
>> +	return liveupdate_unregister_file_handler(&iommufd_lu_handler);
>
>This seems little insconsistent, iommu_liveupdate_unregister_flb() has
>WARN_ON and liveupdate_unregister_file_handler() does not.

The error from unregister_file_handler() is propagated to the caller,
but the error from unregister_flb() is not propagated as need to call
the unregister_file_handler().
>
>Also, refer https://lore.kernel.org/all/20260226160353.6f3371bc@shazbot.org/

Yes. This will need updates according to the new changes in LUO where
the unregister functions has void return type.
>
>> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>> @@ -775,11 +775,21 @@ static int __init iommufd_init(void)
>>  		if (ret)
>>  			goto err_misc;
>>  	}
>> +
>> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)) {
>> +		ret = iommufd_liveupdate_register_lufs();
>> +		if (ret)
>> +			goto err_vfio_misc;
>> +	}
>> +
>
>Do we need IS_ENABLED here? iommufd_private.h is providing definition
>for both values of CONFIG_IOMMU_LIVEUPDATE.
>
>Nit: What is lufs? Should we just rename to iommufd_liveupdate_register()?

Will update both.
>
>>  	ret = iommufd_test_init();
>>  	if (ret)
>> -		goto err_vfio_misc;
>> +		goto err_lufs;
>>  	return 0;
>>
>> +err_lufs:
>> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
>> +		iommufd_liveupdate_unregister_lufs();
>>  err_vfio_misc:
>>  	if (IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER))
>>  		misc_deregister(&vfio_misc_dev);
>> @@ -791,6 +801,8 @@ static int __init iommufd_init(void)
>>  static void __exit iommufd_exit(void)
>>  {
>>  	iommufd_test_exit();
>> +	if (IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE))
>> +		iommufd_liveupdate_unregister_lufs();
>
>Same as above.

Will update.
>
>> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
>> @@ -1427,6 +1429,12 @@ struct iopt_pages *iopt_alloc_file_pages(struct file *file,
>>  	pages->file = get_file(file);
>>  	pages->start = start - start_byte;
>>  	pages->type = IOPT_ADDRESS_FILE;
>> +
>> +	pages->seals = 0;
>
>This is already 0.

Will update.
>
>> +	seals = memfd_get_seals(file);
>> +	if (seals > 0)
>> +		pages->seals = seals;
>> +
>>  	return pages;
>>  }
>>
>> --- /dev/null
>> +++ b/include/linux/kho/abi/iommufd.h
>> +
>> +struct iommufd_lu {
>> +	unsigned int nr_hwpts;
>
>Should this be u32 or u64?
>
>> +	struct iommufd_hwpt_lu hwpts[];
>> +};
>> +
>
>Should this also be __packed?

Will do both u32 and packed.
>
>> +#endif /* _LINUX_KHO_ABI_IOMMUFD_H */
>> --
>> 2.53.0.rc2.204.g2597b5adb4-goog
>>
