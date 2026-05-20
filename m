Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F483E0C70
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297894; cv=none; b=Chsm/Zqao9413X8J6RmZIYNInlmU9w7uJx/LNf4FKcZGBk1fAwiAX9yk3Ec1gRFD3+rwtxR3qmloXfqf3n8hYb5/8LxJ61u4ibhroWk+vVlmsko6F1fH6y/esjVJHbTgN41hCkH71l4BMKreW5SjXSqWdwbaAXDM45kCH7HF/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297894; c=relaxed/simple;
	bh=y3tjD6rMTxegPZ3G74BAk72u6S11iQNTtJ2D9z/46Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5KktO7do0ckqGRPM5h/TLJwLfo5KzECbWLqopywpQTK9idBtmGLRCuj0qf4hzrh0Q8HHLal/PQaIFncGPMUvKYXMQIVgcn1C9BBHiAw7SzJxdUUyhtCVhgRkwR/W7r2Zwg+L+QvCm5m7pBWD1zE/qqKLuzWjmLlNb5PVoxBC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nx1Tz9D2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nx1Tz9D2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1535ad.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779297892; x=1779902692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJhl7WJ2lQSroNNhwKFoiQuIjJsM08m4ektSy1+OM9s=;
        b=nx1Tz9D2emutkwuM+OM6P5f5s278hQIjrdF6pldisKVJVUD+C8P9Vex6RAT4GqcXBR
         vUSopWzgy8Umib49eJGTCmdaZ/x932haLx2gJ9iwzSQi7GQJJvcSuIyN1sm4STsoYsem
         0YJIR60KjJOvYO1Wc5ygE9oNUZrQXWdGk5TUmMsGMif1KebGuEChXuoR4RMsjNXxSr0a
         rMu4dFnsKR+gj/dfG2jbsEYdfY84GZ1GG6B2q4hpUUbHgd4AqCNdSB5MqtHqRa//8dqD
         YXGc//vnO4gi5id3yRmeH/jJvlnr6juZWPtdf4LBuXdOgPaeDSphS17XF6bCa5K+XJ6G
         5yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779297892; x=1779902692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJhl7WJ2lQSroNNhwKFoiQuIjJsM08m4ektSy1+OM9s=;
        b=EtGQl8LtH+AMyZkkpqZ7wNAY1sMOHhc23XQE0IjBlo/sdDuPch8Ew1T9K9OoJYeDaw
         8J/2zcp6hsaS3Y/+4sQusCTAOqtdDpRfOHMJxrEzoKwHiVLWIznKsWmOP8OyfDwoGxut
         wY1Z435q5O/uTb+fRZd5MWe627/cBhcYcl7cHZA+bP0lKycQQ5jUkbNyd9Cl60WkleBj
         Jl5UA5wmwCTNc8VvDMnBGpOrXSgTegUiOcnsAcJeZEM5s0gnbMidzHLia/4k46Ovbj4D
         OVpCB/HLJc3wIUOjyk9WlpZkfYZkGQhelN/CnUcRWjKfZwFycMPzvmXQ/awrAlO7jui6
         CauQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8n+PrVOX4rvtmsxQZrEBM86GOVgSfzaDmCMFAujygurdo9sueOD9Tm3W23w4PklIjxh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyXBxBa3ke0ouF65AaI4wXVPvU+3jYhYkiq3ANXtyDDUhhYoX
	3TRaHB4yB4PPy+uPX7nZ3fo9ey4JIUifLVpg7VEsfbxC0GMuZ35eSzoblSpMFerSwQ==
X-Gm-Gg: Acq92OHWN+eDhZk4JCLA+OHodzBk2/UTIqypxqxu/gU/JkwfBaH3ct2FUbX6KBmLh/C
	iBA1wHDpgV86IGrM6L5f+IDpGqMIOghh5PSZvG3CyXEgFLTWSPqr46YrAXDQEST1KWSA1GRTrZL
	rruhx/S/ZBwnE8w6NMoPPmVLD3HqO3DNcnNgfgSd8Em5vJEYJg5XBowt65gWfqa/qGYabfe7AxG
	IL4PEmrm1lzPrxdoQERPUlHG0UTeFT9/BKYWY+mrl6awX05sGVwHgwqvRbmICPzniRcgzdgK9U6
	I5lklpZSgFAm8LsBwgMnNXucbW4SXOENJBmDiydkwVy9uVcv4JtkgYsdhZQN0FnsUgCaX+K5A1N
	G/XiGnqfdRdS0CNtGf16GsIn1g9QsQKAB5WomQksNDSuA3xbCnuVDte5Zy4RrrLm1bhV4nVSqcS
	HHt1welQgw120KTqMFtJynjhFXVgV34QPl6hC4GUvsIwuDHqs+pkkNF3pCfBRV5EMD7iof5A==
X-Received: by 2002:a17:903:3545:b0:2bd:6dad:7cce with SMTP id d9443c01a7336-2be9f448422mr86475ad.26.1779297891648;
        Wed, 20 May 2026 10:24:51 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm232289015ad.27.2026.05.20.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:24:51 -0700 (PDT)
Date: Wed, 20 May 2026 17:24:47 +0000
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
Subject: Re: [PATCH v2 08/16] iommu: Add APIs to get iommu and device
 preserved state
Message-ID: <ag3nD8NW9khqxMNS@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-9-skhawaja@google.com>
 <agyHS2Tmje4LWogY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agyHS2Tmje4LWogY@google.com>

On Tue, May 19, 2026 at 03:52:43PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:25PM +0000, Samiullah Khawaja wrote:
>> The preserved state of the device and IOMMU needs to be fetched during
>> shutdown and boot in the next kernel. Add APIs that can be used to fetch
>> the preserved state of a device and IOMMU. The APIs will only be used
>> during shutdown and after liveupdate so no locking needed.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 57 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 31 +++++++++++++++++
>>  2 files changed, 88 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 765d042e22e3..60ee29b0c6bd 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -17,6 +17,14 @@
>>  #define iommu_max_objs_per_page(_array) \
>>  	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>>
>> +#define iommu_liveupdate_for_each_obj(_arr, _obj, _idx)				\
>> +	for (; (_arr);								\
>> +	     (_arr) = (_arr)->hdr.next_array_phys ?				\
>> +	     phys_to_virt((_arr)->hdr.next_array_phys) : NULL)			\
>> +		for ((_idx) = 0, (_obj) = (_arr)->objects;			\
>> +		     (_idx) < (_arr)->hdr.nr_objects; (_idx)++, (_obj)++)	\
>> +			if (!(_obj)->hdr.deleted)
>> +
>
>Nit: While the usage of this macro is safe right now because we use
>goto out; to short-circuit the scan. Such naked nested loops inside an
>iterator macro can be a bit of a trap for the future.
>
>If anyone tries to reuse this macro down the road and uses a break;
>statement, it will only break the innermost object loop and continue
>scanning subsequent array blocks.
>
>We could nest two macros or it as a helper fn to prevent such bugs.

Agreed on all points. I will change this to two nested macros.
>
>
>>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>>  {
>>  	struct iommu_array_hdr_ser *array_hdr;
>> @@ -201,6 +209,55 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>>
>> +int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>> +				    void *arg)
>> +{
>> +	struct iommu_flb_obj *flb_obj;
>> +	struct iommu_device_array_ser *array;
>> +	struct iommu_device_ser *device_ser;
>> +	int ret, idx;
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return -ENOENT;
>> +
>> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
>
>Nit: phys_to_virt doesn't return an error for NULL. While we shouldn't
>be in a case where serialized ptrs are NULL. I'm wondering how painful
>catching such bugs would be.. should we check for NULL phys_addr here?
>(and at other places)


Agreed. Will update.
>
>> +	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>> +		ret = fn(device_ser, arg);
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +out:
>> +	liveupdate_flb_put_incoming(&iommu_flb);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL(iommu_for_each_preserved_device);
>> +
>
>With those two nits,
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>i

Thanks,
Sami
