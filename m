Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156FF33936B
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577003; cv=none; b=fkmNkc88LYPShSmdxeYPBr9qbYnIbfYXFI2Cbt3o0Ol08L33espLrEahJoMy38JSodloudqZm4Iub9qhdaoPj3tkua5rXhIi1ElVglCNGniThK7YEBztqgQnBzb7xbg+vwMK1DBXGpOkgDQug8ghfnFBdsyfuPG7sjm7TeN7Kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577003; c=relaxed/simple;
	bh=7cpnZ4/+ceUOXND5CI1ohyxaSHOso6PtTWdS3LWSlE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkeAdblOKZcEpn/s5V4KaHNDxjMnecXaf7EL3WZzjAhUH9jWYQEP3kDfsbI1RQnRYK7d9eRP2y4Ii04fcfzKlUS+HMV5m+kqiMSJR7ZN/GPWQAVjUV2CPqQMwMUKzAsDlKjy5s/eRWUMw3L1OONyptVFYFDmjcvGoWb0+OPyTAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LT3w/dw9; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LT3w/dw9"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso18425ad.0
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577001; x=1787181801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=htZ7B2PCM+RfMEpW8esUs7JsYRPq+p1qH0eY16r8P3Y=;
        b=LT3w/dw9QkX8Mxh8L6NhW7z9HDvKbcOTqVmDYG2/m9KZHHhtcQS6j15y4niK+kTMrr
         m8Y6nfvHVs/VrXvu4RPNqDao6fEWPeBUeQ+GFl/O4GdomKl68mwRhp9c4n/el8eM/FuQ
         qTCTkGTbGPV28l4395o28C7pFKbqE0O8P5Fv3+Y1/Nd4owcBk7oOu/Xi2LiMpsk1AddR
         +Y6ENE40PmNbtBm02qAvwtp3jAjgCDB9WQcNxPQVB8FiFW/xZrf+gUiBgTls/BPNMKgv
         2ZNd/TimxvvqDV7+hq+C7VNQRHzED0xnw1iep3q20e60mG0/4xN7ioldZWvuGeFSR5N6
         oGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577001; x=1787181801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htZ7B2PCM+RfMEpW8esUs7JsYRPq+p1qH0eY16r8P3Y=;
        b=nw2q3HaYR5MtgS51szEzdtNgACuPR/SvbVTdZkcTaJmkRPheTVgLSfWOOX/DYY20bO
         49LgV3HpGkim2e1ayFRw3VwVl3gtwSTRlvmNJmSYhRobgpg3x7zsRatXWXFMm1XTfQ+T
         9H2JeFNeKjfTBOLEbFA4LetA6/ddr5AamlPJH2J+73un95gOblmQJO8EkqkABC2erVWH
         ceHSrUbAL/4UBuIrmK1FwYz2odeykVi76eq7JtmC9DRDH5U6VTzTlnSvXd0IEw+mKBlF
         LyXMUuKc0mOITujbrEnhVwXFOpRfQIkHpaPfKOaWZc4zJegMFyMdwwmvEUJdkJ77Y/H9
         rwfA==
X-Forwarded-Encrypted: i=1; AHgh+Rqca5+fEOZ1rT6QyFaQu+kfAQENjDSN6yAEol54XKJQ7u9tYOY9yGNFbJN4kp+q2kC34Es=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70ikHFsUbOuvMRpxgzk83WtT5DV6GfmG1nz3HEXe+yDviRpXR
	Bbsvj2BDMctkPdl2Kqys2h2LhboU+ZTFCfaps8cg3wINea7WNbwsKHh1/Ze/Dct0aw==
X-Gm-Gg: AR+sD13bsx+BOkkMMFUsqpX3vip6xEgrkK2PBmenLCJqWVD07IVL0F217TIfq2Ix+eI
	hBb0/nArMV8sCTfvXxwpZspErum2UAcKNCzmKL5BLYzS8ck+9LQZRUK6EmIENPE5tJPRvk97T3D
	dqJp1ObsXr+NO0DxyxoUiaNXp1Iba8Dg9JuSlzH6yoOm2jpFvlLnFG7ydzN0gxJhStJbSFQrJMH
	2ebw7aNnkTuzk/w4T+IzdgOu0vOjJ0FzNBl7lsV3MxqdziiIczsCWQ3Rv10DUCujgmVpQl1PMG2
	xYwO/37D2ko2ONIJbfR1qBVWj8EgFvMUyZI0lv8Nzr31fRPjd4/1vNwoPC1I9T8pnqO07Yrhjp/
	4vcA1sT0+qS4555b/80Ul0aLddNRdiNdB0UiO7Sb+zrY0OyyjDlqMroInfSBRsyBKt71lnAlHpE
	Xgng/uvrLLQdXnSCeoD+LXIFnwB+VdxWrbZTfkQUII+cNRm0pWHTANwTeqoO+wfBUSGci5bL1c2
	qnCaUt5MbOsWv7lhQXp3mz+qsp1WNi18u4MOq7SRhPKCzynIQGCG17hefQ=
X-Received: by 2002:a17:903:37cd:b0:2c7:f0cc:dafa with SMTP id d9443c01a7336-2d389d983d6mr866935ad.5.1786577000833;
        Wed, 12 Aug 2026 16:23:20 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44ddf3sm569830a91.14.2026.08.12.16.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:23:19 -0700 (PDT)
Date: Wed, 12 Aug 2026 23:23:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v4 09/18] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <anzf_mOBEdMdyTOD@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-10-skhawaja@google.com>
 <wjt4qqbzwsiaxz7bxog6prag5qvverji5o7dvdsek6frakuptd@urudi4rsvmbk>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <wjt4qqbzwsiaxz7bxog6prag5qvverji5o7dvdsek6frakuptd@urudi4rsvmbk>

On Wed, Aug 12, 2026 at 06:29:18AM +0000, Ankit Soni wrote:
>On Sat, Aug 08, 2026 at 02:27:14AM +0000, Samiullah Khawaja wrote:
>> The preserved state of the device and IOMMU needs to be fetched during
>> shutdown and boot in the next kernel. Add APIs that can be used to fetch
>> the preserved state of a device and IOMMU. The APIs will only be used
>> during shutdown and after liveupdate so no locking needed.
>>
>> Reviewed-by: Pranjal Shrivastava <praan@google.com>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 122 +++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h |  45 ++++++++++++
>>  2 files changed, 167 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 7f349ae5a124..20acf123b47a 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>
>../..
>
>> @@ -262,6 +273,117 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>
>> +/*
>> + * iommu_liveupdate_flb_get_incoming() - Helper function to get FLB state
>> + * @flb_objp: Pointer to get the restored FLB object
>> + *
>> + * Return: 0 if FLB state found and restored, error if no data found
>> + */
>> +static int iommu_liveupdate_flb_get_incoming(struct iommu_flb_obj **flb_objp)
>> +{
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)flb_objp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	flb_obj = *flb_objp;
>> 	mutex_lock(&flb_obj->lock);
>> +
>> +	/*
>> +	 * FLB version mismatch is considered fatal for security reasons for
>> +	 * now.
>> +	 */
>> +	if (flb_obj->ser->version != IOMMU_LUO_FLB_VERSION)
>> +		goto err_fatal;
>> +
>> +	/*
>> +	 * Array Phys of each type should be valid if the FLB was created for
>> +	 * preservation. This is true even if no devices, iommus or domains were
>> +	 * preserved.
>> +	 */
>> +	if (!flb_obj->ser->iommu_array_phys ||
>> +	    !flb_obj->ser->device_array_phys ||
>> +	    !flb_obj->ser->iommu_domain_array_phys)
>> +		goto err_fatal;
>> +
>> +	mutex_unlock(&flb_obj->lock);
>> +	return 0;
>> +
>> +err_fatal:
>> +	panic("Failed to restore IOMMU Live Update FLB\n");
>> +}
>
>../..
>
>> +/**
>> + * iommu_get_preserved_data() - Get preserved data for an IOMMU HW
>> + * @token: Token used to preserve this IOMMU HW
>> + * @type: IOMMU type in preserved state
>> + *
>> + * Gets the preserved state of an IOMMU HW using token and the IOMMU type.
>> + *
>> + * Return: struct iommu_hw_ser on success, NULL if no preserved state found.
>> + */
>> +struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>> +{
>> +	struct iommu_hw_ser *iommu_ser = NULL;
>> +	struct iommu_hw_array_ser *array;
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret, idx;
>> +
>> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>> +	if (ret)
>> +		return NULL;
>
>Hi,

Hi,

Thanks for looking at this.
>
>Returning NULL for every failure loses a distinction the caller needs.
>"Nothing was handed over" and "something was handed over and the lookup
>failed" are different states, and this helper is the only place that can
>tell them apart.
>

My intention is to handle these details in the helper function
iommu_liveupdate_flb_get_incoming() to keep the driver code clean.
Basically to allow the caller to decide whether the state is available
or not. The various error handling cases can be covered internally, and
I based it on the errors that the liveupdate_flb_get_incoming() can
return.

>Of the errors reachable here, three mean nothing was handed over:
>
>        -EOPNOTSUPP     live update disabled or not built

This means that the is state not available so returning NULL
>        -ENODATA        no incoming handover data
>        -ENOENT         the handover carried no IOMMU FLB

Both mean that no data is available from IOMMU point of view as version
is moved into FLB state, so returning NULL.

Now down the road we might have cases where the available data has a
different version as compared to what this kernel expects. We can handle
all those things in this function and if possible hand over data to the
caller in the right format it expects. Otherwise we panic() considering
mismatch fatal. I will add these details in the documentation.

>
>An -ENOMEM out of a .retrieve() callback means the opposite, and returns
>the same NULL.

Ah yes... This needs to be handled internally also. Probably in the
.retrieve() callback as -ENOMEM when getting the FLB should be fatal.
>
>The distinction matters because callers read NULL as a cold boot and act
>on it. Both VT-d call sites in 10/18 do. init_dmars():
>
>        if (!iommu_ser)
>                init_translation_status(iommu);
>
>        if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>                iommu_disable_translation(iommu);
>                clear_translation_pre_enabled(iommu);
>                pr_warn("Translation was enabled for %s but we are not in kdump mode\n",
>                        iommu->name);
>        }
>
>and intel_iommu_add():
>
>        if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>                iommu_disable_translation(iommu);
>
>On an -ENOMEM both disable an IOMMU that the previous kernel left
>translating, underneath devices still doing DMA through it. The warning
>attributes it to a stale enable outside kdump, so the log points away from
>the actual cause.
>
>The helper already treats this class of failure as fatal a few lines
>lower. A version mismatch and a missing array pointer both reach err_fatal
>and panic(), because data was handed over and cannot be trusted. A failed
>fetch is the same class -- something was handed over and could not be read
>back -- but it returns an error that becomes NULL, and callers read that
>as a cold boot.
>
>A single failure also spreads. luo_flb_retrieve_one() caches a failed
>.retrieve() in incoming.retrieve_status and returns it directly on every
>later call, so one -ENOMEM makes the lookup return NULL for every IOMMU in
>the system, not just the one that hit it.
>
>Is returning NULL for all of them intentional? If callers are meant to
>treat every failure as "nothing was handed over", that is worth saying in
>a comment here.
>
>If not, the smallest fix is to return NULL for the absent cases only and
>an ERR_PTR for everything else:

This is what I was doing in previous version, but it gets too messy.
Moving it into the helper handles fatal errors, and versioning down the
road, cleanly.

Thanks,
Sami

