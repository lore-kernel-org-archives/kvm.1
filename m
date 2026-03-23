Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BCE2DA75A
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 18:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291923; cv=none; b=XWytQWlpJRw8iWB757K/ZTFpei4CpH8t2xyTc51yccZns+gLQv21MzfNkAU1ZyNsKX5hsWDXaexGCglw/exp7Sxt/8d/KnY52phue57gbgzLO8C/yiiUeZoiHkgh3NPGiQDJR+RyeVMJx6IhuY4oYVw6Z07oJJprU+zuLVee6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291923; c=relaxed/simple;
	bh=6QaR2oqSKNEPRho9RH+KkOaiYFeaDuoiPM8PClvNLCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kilHLLUjnAOyzPE0XdzW6VCsBTfpiWt9QaSJU9WJ8yODlJGhWhIr08mfMBE3lAPg2aFLttPlN0E/fg+vyYt78xYiQ84nLHIOA2weMfMWwie5HU0HqdyM3WHMJAOZh3fIKKq3Glg3pPL/zzyYxKd8HBAFyl9aX45f+isgCicP64s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVzWSQF/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVzWSQF/"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b052ec7176so14135ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774291920; x=1774896720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g99lbUMVIyYkGv//TAIg6GhZ5xFInnNUBZAXzDDYysU=;
        b=MVzWSQF//EYTZzwu2/ftz07BmbsEX4k7uadWjJS7Y71KMSmAM+0Aujr5pFw6CDEzm/
         jic1sWe4ieULdPH52EZLo7tCw85VS67GBrh+75dna/VqEenbVSG1OxfoffQml1dgvwn9
         ZRx1lcEb/glSINOML8EtCmUvxuuYfxZe4id/1Zus0R52XsO/62ICFUNri01MMQArWIT8
         QYhUmetdpePNePg4K+ymPduWdKFM/mFmWBFvJU8Vyd/Lw6/s/Q0m82q4BckOWGZuapNI
         G8NhH7ffIKaN7y/LSzHFT/2sqXf/7znjdDAqIMxoBDthImYfdACLUi0LpmbY7ogZzFvx
         jlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291920; x=1774896720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g99lbUMVIyYkGv//TAIg6GhZ5xFInnNUBZAXzDDYysU=;
        b=IetkucB+6BbdFXDS/0KOKZYqJs3TuUO/ARlhimoF7ZlIJp7FdwLYhH5QdFtw9VVhMG
         uCxu2Sj/Vz1qHNh9FFa/h22cTvW0tcYgEV90pKxaF1kuA1MA25xvXPWQVXJPHJjDmYpB
         O5DkpKFOSJWJ1BHPkvX5pXj7ACe6WPVtf6HoPURyB/5Hmkvf4q4r9BXfd7L2YdU3UyLv
         afzS7TrUa261S6H8zKr4ssIn3iJCCW7zqtmjqBipVzUr6KNILu4nvlMSA7BF8BBp6gRa
         K5u5ckprr9bcBeFiMxYD2ZHyJicuy7vcNN0pi3u1oFJVJgeXT4BJNaZs3BI6uGQYMR/g
         mP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXgNtA3BvdmUO8emQbMF4mwJ8bY3Wpnk/RdmOrr8bFy5rIzqVGDZJtsL82ffYavnAShW9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyJdjZL37HN6C/L5KFXxqo4vNX5uh1ZXbky1BVgbxggvU3Igk
	h/dUcF/xlJWBLPLsL2GmcvC98kc0Fse5+9WdMAOA7Gx/Qrh4ul8zE0Tb/P4xVseDMA==
X-Gm-Gg: ATEYQzxLKN21eWKcGRIdcL66QAAca7NiESUe+yX7UnhmIoi3oKKcGU4gaR91grQYJKY
	ynl4jzqmwnbQDXTmG4RAwjFYNvJe1ws30Scku27qGMiIJ7fMwZ9ODEVrYKdm2oMg04pIr4HFGkY
	zVNV/nlPm5m39wQyaECeSh1VtizInHxrXXthutJ0E64WpYn7gt6D0M5MjH/dpRC/fj/ZKoU3KM+
	GcJXAHbhmGk/2nrBfvuUxzxgIVNA9ifZUbT1x4xuiPX6Mtd7drOXa3Vs6AGx0rRJqMYB/Rp26g7
	uKBepgvjAsd929tYEGIZCfRNwi5MxqcNI33EgzqNA89VVLCpHGJfKRskYRxgbauO73LLhtCYyUr
	Ei6zCvEFlRhz7tqYH6ehRCVLoOkHum4EXgGi/5YHxbp3usMClq6Ra5S/4XmUJAuYDwbppSMvSV9
	oHoAmxkxU1HKWhFIfXo6cdouVzcRlkOEJR4iAlCrBQgRfoa68Xjs4VU4OnBojIdA==
X-Received: by 2002:a17:902:f94d:b0:2b0:9a61:9d9 with SMTP id d9443c01a7336-2b0a5573ecfmr326635ad.9.1774291919398;
        Mon, 23 Mar 2026 11:51:59 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b15fbsm153483935ad.81.2026.03.23.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:51:58 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:51:55 +0000
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
Subject: Re: [PATCH 09/14] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <acGLfrpMz4JbxaqS@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-10-skhawaja@google.com>
 <acGEJhAQKKknC3n8@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acGEJhAQKKknC3n8@google.com>

On Mon, Mar 23, 2026 at 06:19:18PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:43PM +0000, Samiullah Khawaja wrote:
>> In scalable mode the PASID table is used to fetch the io page tables.
>> Preserve and restore the PASID table of the preserved devices.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      |   4 +-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 130 +++++++++++++++++++++++++++++++
>>  drivers/iommu/intel/pasid.c      |   7 +-
>>  drivers/iommu/intel/pasid.h      |   9 +++
>>  include/linux/kho/abi/iommu.h    |   8 ++
>>  6 files changed, 160 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 83faad53f247..2d0dae57f5a2 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -2944,8 +2944,10 @@ static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)
>>  		if (info->iommu != iommu)
>>  			continue;
>>
>> -		if (dev_iommu_preserved_state(&pdev->dev))
>> +		if (dev_iommu_preserved_state(&pdev->dev)) {
>> +			pasid_cleanup_preserved_table(&pdev->dev);
>>  			continue;
>> +		}
>>
>>  		domain_context_clear(info);
>>  	}
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 057bd6035d85..d24d6aeaacc0 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -1286,6 +1286,7 @@ int intel_iommu_preserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser
>>  void intel_iommu_unpreserve(struct iommu_device *iommu, struct iommu_ser *iommu_ser);
>>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  					       struct iommu_ser *iommu_ser);
>> +void pasid_cleanup_preserved_table(struct device *dev);
>>  #else
>>  static inline int intel_iommu_preserve_device(struct device *dev, struct device_ser *device_ser)
>>  {
>> @@ -1309,6 +1310,10 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>>  							     struct iommu_ser *iommu_ser)
>>  {
>>  }
>> +
>> +static inline void pasid_cleanup_preserved_table(struct device *dev)
>> +{
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>> index 6dcb5783d1db..53bb5fe3a764 100644
>> --- a/drivers/iommu/intel/liveupdate.c
>> +++ b/drivers/iommu/intel/liveupdate.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/pci.h>
>>
>>  #include "iommu.h"
>> +#include "pasid.h"
>>  #include "../iommu-pages.h"
>>
>>  static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)
>> @@ -113,9 +114,89 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  		iommu->reg_phys, iommu_ser->intel.root_table);
>>  }
>>
>> +enum pasid_lu_op {
>> +	PASID_LU_OP_PRESERVE = 1,
>> +	PASID_LU_OP_UNPRESERVE,
>> +	PASID_LU_OP_RESTORE,
>> +	PASID_LU_OP_FREE,
>> +};
>> +
>> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (op) {
>> +	case PASID_LU_OP_PRESERVE:
>> +		ret = iommu_preserve_page(table);
>> +		break;
>> +	case PASID_LU_OP_UNPRESERVE:
>> +		iommu_unpreserve_page(table);
>> +		break;
>> +	case PASID_LU_OP_RESTORE:
>> +		iommu_restore_page(virt_to_phys(table));
>> +		break;
>> +	case PASID_LU_OP_FREE:
>> +		iommu_free_pages(table);
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int pasid_lu_handle_pd(struct pasid_dir_entry *dir, enum pasid_lu_op op)
>> +{
>> +	struct pasid_entry *table;
>> +	int ret;
>> +
>> +	/* Only preserve first table for NO_PASID. */
>> +	table = get_pasid_table_from_pde(&dir[0]);
>> +	if (!table)
>> +		return -EINVAL;
>> +
>> +	ret = pasid_lu_do_op(table, op);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = pasid_lu_do_op(dir, op);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
>> +	if (op == PASID_LU_OP_PRESERVE)
>> +		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
>> +
>> +	return ret;
>> +}
>> +
>> +void pasid_cleanup_preserved_table(struct device *dev)
>> +{
>> +	struct pasid_table *pasid_table;
>> +	struct pasid_dir_entry *dir;
>> +	struct pasid_entry *table;
>> +
>> +	pasid_table = intel_pasid_get_table(dev);
>> +	if (!pasid_table)
>> +		return;
>> +
>> +	dir = pasid_table->table;
>> +	table = get_pasid_table_from_pde(&dir[0]);
>> +	if (!table)
>> +		return;
>> +
>> +	/* Cleanup everything except the first entry. */
>> +	memset(&table[1], 0, SZ_4K - sizeof(*table));
>> +	memset(&dir[1], 0, SZ_4K - sizeof(struct pasid_dir_entry));
>
>(Not too familiar with Intel IOMMU / VT-d)
>We seem to hardcode SZ_4K when clearing the directory entries. But in
>intel_pasid_alloc_table(), the allocation size seems to depend on
>max_pasid which could be larger than one page (order > 0)?
>
>If the directory is multi-page, won't we leave the trailing pages
>and full of stale PDE pointers that the HW could still walk?

Agreed. It should cleanup based on max_pasid. Will update.
>
>> +
>> +	clflush_cache_range(&table[0], SZ_4K);
>> +	clflush_cache_range(&dir[0], SZ_4K);
>> +}
>> +
>
>[ ------ >8 ------ ]
>
>Thanks,
>Praan
