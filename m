Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D59F3F7AA6
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 18:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300839; cv=none; b=Q8M/ZjlK19980MSZsB5Mv53/jKILW+coaWB2jJt/gTYDLTJPNZ5aWR9yX6XmHtneH5pHEv2gyJpLL4qt8U0YVcrzUrkB/9l7kASagu0MQ6YV0wzxkUL5xEz3i6HaB0f61W+PEvfPCjummRDl//WiXMeflL5xydbw/lxlv6X4M/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300839; c=relaxed/simple;
	bh=WlGqgjyBORkJfksIFZslOeTBEP3DJ5gkhKNzkH/Egug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAX4LqTfGlDk9dE7Fnbye+ifnhE3iqhuJ5ueKtFiRFGmY2yg7ZkNb83NhqfjQ3d/PcD5weAe6y6dgMHiMumyUoqHGFjkPZruJV436SS6boqHiT30RE9h9bW7wUxdgDDSoe5FrHpgawQ+yRmlcaGg0ChK/Svcdgz2acnr1vLIXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P6ii/3KS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P6ii/3KS"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so545ad.0
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300837; x=1779905637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FjVopLxhAIzTAf2Kz8X5x4L6V6oaH+XHeIW8ypuJnu8=;
        b=P6ii/3KS5+sglVC2M5Pmax4dyMAFp7JyGX7E+yCiEdV8gs1flnmFCkp6YoSNEPVl3D
         H/6Fh4a8OzlHupVNE68ZF++BItdx0kDBo7NpRJkaRQqVQi7qVP3vExOiNOH8AugQBWpR
         lGFBBkFABRjzqa5fP75ilMm2KmTPLoqchlK82CNe+bZTUnLQqtBI0/yRBpEVnBzDYb9y
         zPr/wXCLl1qfqfbrZVf9PiYDgpu8qrhDQKBoDzg5W23FUFMsw9n2R6VodEf+m1pvGt5l
         0R8f4UebZcZrnwUnAIxQrT+isoIPUA3FIWFScwE2SCY+j9L3qHIjrTZTW0bMbSgom09d
         uW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300837; x=1779905637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjVopLxhAIzTAf2Kz8X5x4L6V6oaH+XHeIW8ypuJnu8=;
        b=NKwnlfr9O1L6TtBuPj0ptW5R8v2kKl9zeL0Oej6N6NE8QFxA+WI/HT0UeQ0u9DzV6r
         +6BQeEaaTogxdkV4nWW3yY+NHj2hRiCIJ9/nVi+q1DzxMnlX/STsdGE5DLsgijO+iNSA
         +kPfQRM3OfgRDfB2fATxYV9xzgF6NFPiOobf5IdlnD1OHkvNyEFDs+tMaajISCUmanqu
         oruoSZUQln8Z3Bwwt3fxi1wg2qEIRKc0UT+FXQUydJNj5Ah9i8nHLN7hG6AW0nOZ3hhL
         Wd26vGB9xJAGKcjcl7Hx/oZCKWk8Tq9fXM6Z4fY5qwq/vuQ+WV+APJYY9UvX8vs6ncPg
         JDeA==
X-Forwarded-Encrypted: i=1; AFNElJ+wDR7RtW7fc5FP3VOTQIuPiG9d+0AZz5Oix/lRjKlHyrweaj11Q7xkYjM331shQUq3yfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeIuacXcE5/mBzPEM/lmTIQ230Zt8FGrrbl6/n9iIG5z89ZuU
	kcT/EhFB1WVfliowEZaq/iPEzg1AsplOI0Wr4sN3EyszodLECwQa5UsKNnb44mzSZQ==
X-Gm-Gg: Acq92OFEnU7SpOfSBIjQpHF9bEukYbu0JfHDJ6Yp1gO0X6cJSE9Ka42AYRI+yCQggA5
	hteJd4oo/B00Xrl1vYW7TXVmWvICK5D09JSMO2kzn9MoR7sM+hZ3tfFikbNU0cejr2LdOeHtw10
	nhhKDAXiZDFkK3xdWj7QJyUBRcF0SwieeopaMbZSqXo2dTfAkSCArGdSt74p53DuLDg7PiRLh00
	Wd7+MJMJfOm1UfDNZzutLt1ZqwIk82pz8R6W5KL+NNRCu3Q2sxZ1NiaROWr4BL5J76wKDOn1XE1
	QAqyTIBsjQZMlXbnuW2OtvmROal2H4usA4aiI0il3QXplRtelWVsSuQkZs5gekNSZ3a6mucWeVj
	b2UwNqN/I5jBf15fz0E68tRoLuhMLb8joXY9Pd5gvzwH0DR9hD9pmu6c+y65f24TtJ19MSo5uoK
	6tEdgOw4RzcTErhl6keGa1IAPwSTFMw7u4JMNvv1UQCokFvdqIw6waiHpT1hcK9QdNWSYn1g==
X-Received: by 2002:a17:903:2288:b0:2ba:6518:e4d8 with SMTP id d9443c01a7336-2be9f43b2edmr335725ad.20.1779300836839;
        Wed, 20 May 2026 11:13:56 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cb327d3sm376037a91.3.2026.05.20.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:13:56 -0700 (PDT)
Date: Wed, 20 May 2026 18:13:52 +0000
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
Subject: Re: [PATCH v2 11/16] iommu/vt-d: preserve PASID table of preserved
 device
Message-ID: <ag32IV5JwCtQ2CSj@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-12-skhawaja@google.com>
 <agzlrsK1p7hf6DJE@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agzlrsK1p7hf6DJE@google.com>

On Tue, May 19, 2026 at 10:35:26PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:28PM +0000, Samiullah Khawaja wrote:
>> In scalable mode the PASID table is used to fetch the io page tables.
>> Preserve and restore the PASID table of the preserved devices.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c      |   5 +-
>>  drivers/iommu/intel/iommu.h      |  12 +++
>>  drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++++
>>  drivers/iommu/intel/pasid.c      |   7 +-
>>  drivers/iommu/intel/pasid.h      |   9 ++
>>  include/linux/kho/abi/iommu.h    |  13 +++
>>  6 files changed, 184 insertions(+), 3 deletions(-)
>>

[snip]
>> +
>> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
>> +{
>> +	int ret = 0;
>> +
>> +	switch (op) {
>> +	case PASID_LU_OP_PRESERVE:
>> +		ret = iommu_preserve_page(table);
>
>Nit: This is making me consider renaming the helper as
>`iommu_preserve_folio`. I almost thought why are we preserving a single
>page.

Interestingly the iommu pages API uses plural of page in API name as
each iopt_desc can be backed by multiple pages:

iommu_free_pages()
iommu_alloc_pages_*()

So I will rename these to:

iommu_preserve_pages()
iommu_preserve_pages_list(list)
iommu_unpreserve_pages()
iommu_unpreserve_pages_list(list)
iommu_restore_pages()
>
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
>
>[snip]
>
>> +
>> +void pasid_cleanup_preserved_table(struct device *dev)
>> +{
>> +	struct pasid_table *pasid_table;
>> +	struct pasid_dir_entry *dir;
>> +	struct pasid_entry *table;
>> +	size_t dir_size;
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
>> +	/* Clear everything except the first entry in table. */
>> +	memset(&table[1], 0, SZ_4K - sizeof(*table));
>
>Nit: Is the first entry always 4K or could it change based on PAGE_SIZE?

VT-d uses 4k always, but for clarity I will change this to
VTD_PAGE_SIZE.
>
>> +
>> +	/* Use the folio order to calculate the size of Pasid Directory */
>> +	dir_size = (1 << (folio_order(virt_to_folio(dir)) + PAGE_SHIFT));
>> +
>> +	/* Clear everything except the first entry in directory */
>> +	memset(&dir[1], 0, dir_size - sizeof(struct pasid_dir_entry));
>> +
>> +	clflush_cache_range(&table[0], SZ_4K);
>> +	clflush_cache_range(&dir[0], dir_size);
>> +}
>> +
>
>[...]
>
>> +void *intel_pasid_try_restore_table(struct device *dev, u64 max_pasid)
>> +{
>> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
>> +
>> +	if (!ser)
>> +		return NULL;
>> +
>> +	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
>> +				  PASID_LU_OP_RESTORE));
>> +	if (WARN_ON_ONCE(ser->intel.max_pasid != max_pasid)) {
>
>I'm wondering if this could be slightly relaxed to:
>if (ser->intel.max_pasid < max_pasid) to ensure it's a minimum
>requirement rather than an exact match?

Makes sense. I will update this.
>
>> +		pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
>> +				   PASID_LU_OP_FREE);
>> +		return NULL;
>> +	}
>> +
>> +	return phys_to_virt(ser->intel.pasid_table);
>> +}
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 89541b74ab8c..5cac8e95f73b 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -60,8 +60,11 @@ int intel_pasid_alloc_table(struct device *dev)
>>
>>  	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>>  	order = size ? get_order(size) : 0;
>> -	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>> -					1 << (order + PAGE_SHIFT));
>> +
>> +	dir = intel_pasid_try_restore_table(dev, 1 << (order + PAGE_SHIFT + 3));
>> +	if (!dir)
>> +		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
>> +						1 << (order + PAGE_SHIFT));
>>  	if (!dir) {
>>  		kfree(pasid_table);
>>  		return -ENOMEM;
>
>Thanks,
>Praan

Sami
