Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4A37883C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074215; cv=none; b=jiXY82jAmlxpKVDstoaavHffzauQMP3Ld9SvzEeRCwj5Y19zZEZaloRf5w1QxfdTIHxplb0dXN4GnrzvAUzMZlRB4x7i+JcAlpVaEo3QDkgX90sD0EWcXkGR39zBBQxeqFILPjW/hN0fjp9n8vznTvlQg1iBKimKWFmsViZ3AS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074215; c=relaxed/simple;
	bh=uYdO0Zb0EMGnJnig6FT1XOpGRq5xI3F+BHn+7Ktj+UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hlc1/8yPrd0mJDPX2hGCXrWOjlCOVNHqI9nMVs0W3yg72HllzMkWmGgFhvzzx3mTkgYu0/2FQcV5w7rHKUs/fsfJ7pYxTQ6Q2jYfY0DrUJoWav4zoRx4uCtPhgpueqTBFHTrb+MUp5EXG0BGrFcLsemM+z0wrSXyHHwHRC5LnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbfxgCb4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbfxgCb4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2d865383so1655ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780074213; x=1780679013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvcYM9yAFt1S3eUjneK8l3ddApYMEHlD7c1/gPxFFF8=;
        b=bbfxgCb4syHnfSlErVKpjuTZJFRDGn9xRhcE6hUv9NRUuI9/V4LG+4ySnHRB5/7YTv
         IkCy7mqkVrZQAdSHzg8IqmDpDJ/v0+utz4tb2meOfqQmNPvsUhQ9Sgl9bXZ0F7PrwXzr
         4FIzqChv2AeWoapIu5zJzmYTSkuRDsgCJKOPeYsWgDilJuHzG1bZWCjlO9a3CYuIxcGO
         FAEpJGnb0xGoYedz8QEiAr6UqjFYfYj/RkEwgC911o/20m6G1Es38jc+3NArsWdMOfLG
         JOX2P82A23p2YstHHfaU41xECxIynKkiOdJd3R7jhKu2WfUqLfRPcIdAEIC/6uiG7Jp2
         Mkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074213; x=1780679013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvcYM9yAFt1S3eUjneK8l3ddApYMEHlD7c1/gPxFFF8=;
        b=kHLWvY8eDN4xT5nzD0F5D1nWkxFx/+Lvj8fQcEOdSfY7LuCj4Iigm0lqNNnOFiDFpH
         oSGdKu5omCKb1WcpU187Fo56MhvApbDVyShZKteCNBT2c7r7+xqB5S6a3j5tyJ9jaaqs
         tCItNsTuIKEEVnakngmSnQ5eHWorCRcsjq29tUL6NjrN9N7A/RSiez9hd/GV25KqU1X2
         9N2e49AfGRMx8RsNrZ9eXopKc7H1j3oWcifXDZFZsSrUaUjOsUvyCCenzBdd4ByXg6rk
         9RztfGFqOyaameokK0yvZaZtTEUHIjhCDngmsZTg39Vem0RDg9NYUJ/rBrPOlkXvesgS
         0nxg==
X-Forwarded-Encrypted: i=1; AFNElJ/dOshgeCUv0Wy3P9VT9Jsz5kDhDsRPSXTCkvkG8sQWAufnb1HlB5Ws9BRLeku22xR68Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9de8ZiP7WuPZmSeKjs01tyTPFNGPfAQXFijjgquZWikBNuOrH
	YVYDn47RRBjV2b482qSvRBulGSu3PB/piSz3w22KXW0C53vE67ufE4CKSJWL+xJmWg==
X-Gm-Gg: Acq92OHUsnk65XIrJT1/xaFrPOQ1AcCdR4LVU2H+aFQQ0uT8LtW6qlGqCLpTqVxHCbu
	uYvrcO/ohhgytWYcqq8QJ1vhww5zZjielx70plHF5JcLjDin+TgL7J2FcSaKIuEA4THQX5FZr+m
	Yd6OnaIigGB17rvJUU9uce5XJbjlKq/d5meAJuK11+/AeZj679Fzzz2BaCTVNb+ubVpuMHPlOEj
	xXm9y4NYF/DuEM4y4EdmVEIP3osQifI+/B59tNotKtHblRgucxpxd9VVPjOD8UE9zTVC0cteZj3
	IQqBEtjvP/UKAGfl0KEFlG+vwvfqRQ+CC6zKqMQHa11i+C8buYQGwrsqAqHRlONtTI+awC05Ksc
	mzVJkf1XVR2ek728QYFO83av6TFWclcQWPZjUocD6ypYmlXfVSPxyspeLBzAhEdLDuw9LW1gAvV
	bgr8eMVXaMszeleAliUkOLC9h0sIztGNi7C0Lwip7z8yl0hgLoGwcMtVtxjje4RtfIDR1Fiw==
X-Received: by 2002:a17:902:e889:b0:2ba:4749:c9a2 with SMTP id d9443c01a7336-2bf97507257mr30445ad.2.1780074212695;
        Fri, 29 May 2026 10:03:32 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a10165sm24198555ad.31.2026.05.29.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 10:03:32 -0700 (PDT)
Date: Fri, 29 May 2026 17:03:28 +0000
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
Subject: Re: [PATCH v2 10/16] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <ahnGsfuKSwgt3b_T@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-11-skhawaja@google.com>
 <zgdfgca45ealra5cckvsgeugfkuwdv6kima5f7hbun4m6lnjjo@bqxhvyoeovyz>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <zgdfgca45ealra5cckvsgeugfkuwdv6kima5f7hbun4m6lnjjo@bqxhvyoeovyz>

On Fri, May 29, 2026 at 04:43:42PM +0000, Ankit Soni wrote:
>On Mon, Apr 27, 2026 at 05:56:27PM +0000, Samiullah Khawaja wrote:
>> Restore the preserved domains by restoring the page tables using restore
>> IOMMU domain op. Reattach the preserved domain to the device during
>> default domain setup. While attaching, reuse the domain ID that was used
>> in the previous kernel. The context entry setup is not needed as that is
>> preserved during liveupdate.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
>>  drivers/iommu/intel/iommu.h      |  3 +-
>>  drivers/iommu/intel/nested.c     |  2 +-
>>  drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
>>  drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
>>  6 files changed, 224 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 4118a0861f38..b90757164cd8 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>  	return true;
>>  }
>>
>> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>> +			int restore_did)
>>  {
>>  	struct iommu_domain_info *info, *curr;
>>  	int num, ret = -ENOSPC;
>> @@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>  		return 0;
>>  	}
>>
>> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>> +	if (restore_did >= IDA_START_DID)
>> +		num = restore_did;
>> +	else
>> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>  	if (num < 0) {
>>  		pr_err("%s: No free domain ids\n", iommu->name);
>>  		goto err_unlock;
>> @@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>> +	struct device_ser *device_ser = NULL;
>
>Typo here? iommu_device_ser.
>compiles because dev_iommu_restored_state() returns void * and the
>variable is only null-checked, never dereferenced.

Agreed. Will update this.
>
>Ankit
>
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

[snip]
>>  static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>>  {
>>  	return NULL;
>> --
>> 2.54.0.545.g6539524ca2-goog
>>

Thanks,
Sami
