Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3015B38AC9A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130556; cv=none; b=Nt/CwIrNHQXFGJmHC8RebVqV1MgHSeXcz35kPmGwdkB6HU5vh3XKu2RG0bAkhx2DidYlUW2SEhblu18sWrrwRiVcK8PPCynJ+IUpqL6TSP70bSl1y+Y3lkHsjUUfvba+g8/Z+z/QTowYChZbUivyMf/2urPNm9ig4bhg/2KPIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130556; c=relaxed/simple;
	bh=haAsUB2P2dMZXBWY/VxFwqzdDlbH/EE+xsFbEoz18JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4COhwav4ieTGSVItgdX7iGqhAFFmgH963a2Ynj8MlyL5UDu6Vhy6afTW02TaGUHs0Oq9vuBePn9sby7WLT4emaCg+OzZ4aQSlEyEg69a5PM2w//ItDc+wCjbM7jQIK5smqxSo207vTI5V7dyh7JDDjwq0E5JmclU1pL7NrODok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLxLNpw0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLxLNpw0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so145ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130554; x=1779735354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N8E7VNGYLDNKxW/Ot3tdafHEntRbQFW1KJ60umQhURs=;
        b=qLxLNpw0rzfB24LC3wkoeSwtOCEYy24DFL9ydIBwyMHgqESR8DmoDUQEseVlmQKQ5d
         ZcAkKH+bZeJni5tlZT2bCmtgrJqRbbz2h51NaYtBw05gJE2URt1gZiBHI4i97jg+6auD
         Vo/dO/p9iwaGsl+yXswFAILi92tYf6rDZoM43WakuDElGq1L2Qi9fF0yi6SzzFy903mT
         z+4X5DTLGMgDkHEMhj9Kth4E+XYS9oEir3uMGICcl8iIqhJwPmTNCjzy/te3Ge9Yy7gE
         EEUFmNTF5zX8OQ5sqy2tmhs4OzNO9tKyi7DyR6O/gXcLdcR3w87l5BQZ88UkjbJJc9Yq
         lRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130554; x=1779735354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8E7VNGYLDNKxW/Ot3tdafHEntRbQFW1KJ60umQhURs=;
        b=JMjbGdpEcsYTj7S1UxUTtNTgnO7Rr85iXFxibegfiQE3Or1dQkMTNSmotBVY3hza5h
         LsDDQOielBR8kknRSaqxDLLUL0GpHn1n2nisUp8u0DG3yRfiO4v87QjSK4af4zqk59pI
         V7nJsNXUBjQ5Y+a9x8HKTawYGis6Sy4BBYXc0KeqijxZVCiolONMC3pptm7IY/3CBOoK
         7gVduFPLicM72GIEMhmyLkHtnEi6OKpI9vEOt5NTh7ojnYRyIN5aCIyIhksEpQNFcXsX
         TB9xmpMVET60t/2De0sN5s4nzQQSeThAdbTJ2GxwXEcc6ybzXjvli7LdJ/UEJOkiBasE
         snaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9SRegV8YIZYeqlcyVee7HKuGmFA6gMR1Jp3EHuxpvRwYrRU6BUS3CBQaFu3jd/s+P4okI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9SI5mwXsiJy5hjgikTB5yStbRTmmDgamL+9P3YhKyx3+lUc61
	U+jS+zgT2A2QoUYdIZ5OVCt0wgt3C/H8VAHp+/GsBe1QmUGashw9kGRrKx+an+PSMQ==
X-Gm-Gg: Acq92OF0iJummKTmqesBlvjQp21KC/ik1XTqxWLz3AUbHFGNV3kMtqjDuLCWZFj/D+R
	V4h1LuDgvypHaddASqXIypODhnhDY6GrBeAAhrkLxd09DCWiZtyduNJtOMte13eusRslxqDI5RN
	i9BnNslD6iqng3jpVxLtI1VWHS6WsPnYDHhUrhaF8sQ9NGbkbsyyK0LYXEebNwqg2w1ISvSdRfY
	WEHh3OEOn/zZSY+0dIycMz4glF/igGogQdXvjNdvXIRmAOeV+Y96ttYnpPhIqYAgFAPoHPtzyNi
	XGNRL2hFxM7l9/KVK383jWnz9Os1LjQWH1HPkiC7btuB62jtRrDEBQMTh2hRx4j6apyXoOnBEZi
	6ZTYXboMLo0fsS/oaaLQcU7DXXAxsFKW3V4zpNE9mDESYJBDeOIkiy5hAdgpwYqZiBg1ouDfAFB
	Yn0SmL9mlYLQ0cgJ0tV+UMVhJDcQQHFrkrdLC7eYlgoFUlz/oxRyOTIbulxqUDQUliz1mpAg==
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr3404845ad.0.1779130553814;
        Mon, 18 May 2026 11:55:53 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11c7f3sm154208605ad.70.2026.05.18.11.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:55:53 -0700 (PDT)
Date: Mon, 18 May 2026 18:55:50 +0000
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
Subject: Re: [PATCH v2 03/16] iommu: Implement IOMMU domain preservation
Message-ID: <agtenWUBOVosDCTU@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-4-skhawaja@google.com>
 <agsQE1lFGdo-b_IF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsQE1lFGdo-b_IF@google.com>

On Mon, May 18, 2026 at 01:13:49PM +0000, Pranjal Shrivastava wrote:
>On Mon, Apr 27, 2026 at 05:56:20PM +0000, Samiullah Khawaja wrote:
>> Add IOMMU domain ops that can be implemented by the IOMMU drivers if
>> they support IOMMU domain preservation across liveupdate. The new IOMMU
>> domain preserve, unpreserve and restore APIs call these ops to perform
>> respective live update operations.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/liveupdate.c       | 97 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 14 +++++
>>  include/linux/iommu.h            | 13 +++++
>>  3 files changed, 124 insertions(+)
>>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index a26099b145c3..f71f14518248 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -13,6 +13,9 @@
>>  #include <linux/iommu.h>
>>  #include <linux/errno.h>
>>
>> +#define iommu_max_objs_per_page(_array) \
>> +	((PAGE_SIZE - sizeof(struct iommu_array_hdr_ser)) / sizeof((_array)->objects[0]))
>> +
>>  static void *iommu_liveupdate_restore_array(u64 array_phys)
>>  {
>>  	struct iommu_array_hdr_ser *array_hdr;
>> @@ -196,3 +199,97 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>>  	liveupdate_unregister_flb(handler, &iommu_flb);
>>  }
>>  EXPORT_SYMBOL(iommu_liveupdate_unregister_flb);
>> +
>> +static int alloc_object_ser(struct iommu_array_hdr_ser **curr_array_ptr, u64 max_objs)
>> +{
>> +	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>> +	struct iommu_array_hdr_ser *next_array;
>> +
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
>> +
>> +static struct iommu_domain_ser *alloc_iommu_domain_ser(struct iommu_flb_obj *flb)
>> +{
>> +	int idx;
>> +
>> +	idx = alloc_object_ser((struct iommu_array_hdr_ser **)&flb->curr_domain_array,
>
>Nit: Such type-casts could be brittle and risk strict-aliasing warnings
>based on the compiler.
>
>Since alloc_object_ser only updates the top-level tracking pointer, we
>can make this much cleaner by changing alloc_object_ser to take a
>void curr_array_ptr. That way, we can pass (void )&flb->curr_domain_array
>cleanly without the double-pointer type-punning. Something like:
>
>static int alloc_object_ser(void **curr_array_ptr, u64 max_objs)
>{
>	struct iommu_array_hdr_ser *curr_array = *curr_array_ptr;
>	struct iommu_array_hdr_ser *next_array;
>
>	...
>}
>
>and we can pass it as:
>
>idx = alloc_object_ser((void **)&flb->curr_domain_array,
>		       iommu_max_objs_per_page(flb->curr_domain_array));
>

Agreed. I will update this (including other places).
>> +			       iommu_max_objs_per_page(flb->curr_domain_array));
>> +	if (idx < 0)
>> +		return ERR_PTR(idx);
>> +
>> +	flb->curr_domain_array->objects[idx].hdr.ref_count = 1;
>> +	return &flb->curr_domain_array->objects[idx];
>> +}
>> +
>> +int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret;
>> +
>> +	if (!domain->ops->preserve)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ret;
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	domain_ser = alloc_iommu_domain_ser(flb_obj);
>> +	if (IS_ERR(domain_ser))
>> +		return PTR_ERR(domain_ser);
>> +
>> +	ret = domain->ops->preserve(domain, domain_ser);
>> +	if (ret) {
>> +		domain_ser->hdr.deleted = true;
>
>Nit: This will become domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
>once we convert the bitfields in PATCH 2 to flags.

Agreed. I think it is being discussed that bitfields are fine in the
other thread, but I will switch it to flags for readibility anyway.
>
>> +		return ret;
>> +	}
>> +
>> +	domain->preserved_state = domain_ser;
>> +	*ser = domain_ser;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_domain_preserve);
>> +
>
>[...]
>
>>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>> @@ -752,6 +757,11 @@ struct iommu_ops {
>>   *                           specific mechanisms.
>>   * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
>>   * @free: Release the domain after use.
>> + * @preserve: Preserve the iommu domain for liveupdate.
>> + *            Returns 0 on success, a negative errno on failure.
>> + * @unpreserve: Unpreserve the iommu domain that was preserved earlier.
>> + * @restore: Restore the iommu domain after liveupdate.
>> + *           Returns 0 on success, a negative errno on failure.
>>   */
>>  struct iommu_domain_ops {
>>  	int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
>> @@ -782,6 +792,9 @@ struct iommu_domain_ops {
>>  				  unsigned long quirks);
>>
>>  	void (*free)(struct iommu_domain *domain);
>> +	int (*preserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>> +	void (*unpreserve)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>> +	int (*restore)(struct iommu_domain *domain, struct iommu_domain_ser *ser);
>
>Nit: Should we add restore in the patch we implement it?

The ops are implemented in iommupt (separate scope) and it is done after
the iommu pages patch as that is also required for it.
>
>>  };
>
>With the above nits,
>
>Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks Pranjal.
>
>Thanks,
>Praan

Sami
