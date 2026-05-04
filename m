Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC13E3E5ED0
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919594; cv=none; b=RP0gyZ3toR74fOMPBAC6NrU0H/LFSrrNUsfSIkJLEV1FRIO2pXR8e4zdkvje0cc6kFLeRp4aaXahP1xah41pfxayUDfKX47inON1qJM6n3A4FdxNVEw76d1uStdVBnzU9r/kz3PCL2aATR5wCDJehPKEDduulVL6D8Eb1rxyZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919594; c=relaxed/simple;
	bh=9S6I1BVV9U+hakYrzMNgB+o+EjrvcNV62AWmq1dpHmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFsyOG99B+eNv9978NYQ1KowI7xhBg9+aVJiaGSYNA2rfYe7Geu0dtY7VOThsB+BFTPlNzi+WRRPOn7EdnbflsHgjsgk9rCgagmdkwPsRMkg6f+latIoD3n5/ILuzjqSVTZnSFXmUBmCAKHTIElsaQPrBiYdAhkXxf9PPxmPWQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZXqMoxK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZXqMoxK"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso20215ad.1
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777919592; x=1778524392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJD8nC3hNpz1bkOtzLotRv5riDST1DKSmHvRTvkrIKA=;
        b=rZXqMoxKb+hLCsxkgguFkmHYKHaJb50nh6aodXGN7ABV8ppP5AhCgxOekajKTeTqhb
         kIqrXcddxsnrRSBnitsLIVvh+bjXs6zRYKULF8q39HTtS3UJQglH8Q0Agxpza9hwlcsS
         mF5sxOJ6nDRs0bxsGBCd/jdyW3OaDLsXYuUHuHZmkblBkXbMvb/vTRu1ANc2KmCMH5Z1
         3m3hVBoC5SMegTtrbUUwg7gD5Ja4+YP2CGnKcGfHJQ2b2CHE+ujWuv41y8RCHkKDDxoh
         thxL7fhJCw3vwgndFcXwxYVmpAxzWlIbdTi3YwLukWGYPwO+520BHg/4TJq9IZNgzbLG
         vyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919592; x=1778524392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJD8nC3hNpz1bkOtzLotRv5riDST1DKSmHvRTvkrIKA=;
        b=DLv6gVWxDG00WpkkPrQLpkWOYKZ/fb/WIbFCpR5reY3Z0G730HG/jrEbhomJ/8SClu
         KGtwBTp2skhQgKJEht7aSz9QQYX+uJLQ6dBKciaAGGQcLq+5pKAWhCCLFLY5lqy5PLkG
         H+ObQul5GkVKX5fjsEaz9pwixas8O30vToTivmMu32GgEShu0W/uiS3SRRjXfs1gIQUP
         0otYdnbtsiEobvHTweXm85tur5O+VdDzZuz0XBAlP2iOfPXOm4HbAJBfXBEXfZbfaiMa
         ghdQo3z3lD8YtaBFUeMh99Qgbu6QQBQs9O+Q2CG1khQhbG0ywGXNhngpQv/pVAq8PNji
         tLrg==
X-Forwarded-Encrypted: i=1; AFNElJ93TWyeWA89T/TKJPvoC5PzlufrtirTnuf9qhYo5fU67lgTXLwXepEzrvVnxuCyt7h8h3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8xX/9zlWvPjjhilWqRoo/N1UWx8auwWwS38fKwmz3sl9pS4v
	sNEKzGgoJSaQVBeFpwlGD5ubM0QXpWl4g3yql+gteUyC7UwxAO+aFspIMMyLq/82vQ==
X-Gm-Gg: AeBDiesnzMa5rEkzGCzRSFpzmJRTtfU7oFlXzLMYc/2E8RYFmCMb3C6MdxKNdpi0CFi
	Wym2CinVNk5XPMMwwacl1cr//Dqa6JNWgr91ZawL7fpren1ARQXiXOvC2p8HwzPvgtwH+qhIe0q
	cWXM6+USXVBXwZ/WDIUfuxA0gYBr8monIm1pRTYXIZvLMWaZ3uNPVYg3Am+G9g0l0M8hzWngW9R
	6nbg3YabuZMdQfgDCi0NAcGMSerjFTWBlHou+nugoqTjrS7Coh4RfTHnFxGhoSqBDFLVxxqfDrp
	zfpcp0lwEayPHOw7++DG5Tj+XgPuFMB1gEKeYykjojM+qBjEix4/1klhRB/jp9fQ6TK04u/Op5R
	+RVrZl2U0wmoPlexpPRHYxJOQDAOVr9C/9NX+u1Z3BfbCLzFd2pNLMQkAV07mIcy2ubLjn8Rc/j
	xeO8YDDdunE/yacFAyYRKtF5mkLa3QCmOLGjMbrQyf5k6sA1AjNUWwTiLF5FRFaH5NXUslM8tw7
	MBwxVKezm0=
X-Received: by 2002:a17:903:1c7:b0:2ba:f71:57a8 with SMTP id d9443c01a7336-2ba4f7af343mr587695ad.10.1777919591414;
        Mon, 04 May 2026 11:33:11 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae3b169sm113335475ad.63.2026.05.04.11.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:33:10 -0700 (PDT)
Date: Mon, 4 May 2026 18:33:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <afjlRNfYA37ePRm0@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
 <afUkbz0IQh98siYn@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUkbz0IQh98siYn@google.com>

On Fri, May 01, 2026 at 10:08:47PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
>> they support IOMMU domain preservation across liveupdate. The new IOMMU
>> domain preserve, unpreserve and restore APIs call these ops to perform
>> respective live update operations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
>> +{
>> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>> +	struct iommu_array_hdr_ser *next_array;
>> +
>
>There's a trade-off being made in this function to leak deleted array
>elements instead of trying to reuse them that warrants a comment.

Are you referring to the "deleted" flag in the HDR of each object? Yes
we don't look for deleted objects in linked-list of arrays and reuse
them for simplicity. I will add a comment that says this.
>
>> +	if (curr_array->nr_objects >= max_objs) {
>> +		next_array = kho_alloc_preserve(PAGE_SIZE);
>> +		if (IS_ERR(next_array))
>> +			return PTR_ERR(next_array);
>> +
>> +		curr_array->next_array_phys = virt_to_phys(next_array);
>> +		*curr_array_ptr = next_array;
>> +		curr_array = next_array;
>> +	}
>> +
>> +	return curr_array->nr_objects++;
>> +}
