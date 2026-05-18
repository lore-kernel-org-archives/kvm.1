Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E28C382390
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123980; cv=none; b=byNUq2cN761UrJ7n3sZqHGf3j2ttp2yM7JS6FtB1wkiKD4gK/W2vO1H58BoNENWtLnhz5R32/DT7rK0ghP7GJBVqm6QbU47NG9ES/3X0t1UR2hl5vNVG7SAYrm6JQjlYa+K0ZJWlHiVqb7GCePU0c2o0mBkU76AaP9opE8mLBAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123980; c=relaxed/simple;
	bh=t9OxCZoF6YbRVKylmH+0HlyPwlgHH9K8/ORJEjD0asQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQddxLg7lTw1O7mJcRPa46ZluRuwiE4IGVxZLjQ3rEHy/ohvzgWHg+3e1+nY0vchpRfTK0jjxNZDvt9g8cu/mdRSSxrV1/fd5273FpWEhN+bWHmmJHQIVXVsJDFPp3eczGc/dek2KGniTZbIbv2vgNZijsFi0fOA20O/XGgfYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G6zuTYc/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G6zuTYc/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba180a022dso455ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779123978; x=1779728778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkqatbApjTcUOlv+bi7ee5TYL+ejmFz/3nd+bMkwd8c=;
        b=G6zuTYc/FtnON0JY02TCs4XR9U267YypH7Z1jT04n6GNM+98bGeIUXzEvbVNconrjl
         N2Q6lWET2HAJAJen+s1Vq9R5gzoD/V/g0JxmFGt/Kx10JZvLGdRhqYtXPBmx8QReli4z
         AW6EeZAk5MH5aDnxTTDxjvlVxUsMQf+epPnrYbb2Felzl7yZ5/GE5xWt0umrAyoPcoVj
         4dNOGdMiR5Y/YmLiMjG3bxBXzhsE/iO2Smvrd6+pR4yvYtAWh8tCo2469oWmbdPnMVdB
         TOLj/RoVq7U77VAHiEoOt2d2p1wAz1luhSH6yA/27N3EHdzwY/YUf9Z99Ma+OCI9NoB5
         zyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123978; x=1779728778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkqatbApjTcUOlv+bi7ee5TYL+ejmFz/3nd+bMkwd8c=;
        b=bA7YuSR0j18zGiBLtwY2diijXNZ2Ky34/80IVuSreySTU2GkfjcI7U9lq2vGjZG+O8
         gwokG6ZT+2yxH3BQAG+qWtw0JwO95U6YXxxcvOzzpySwmsSVEoLNvmN3jFzWzcGaWaGM
         9ctCtV3XisHEr/wuhjsVuaIq8PEDXKyRbTh2yrfooTZhTz5KyY4b4sStahCu4tuPeeRp
         5NT3/87t3hjcOdhsAmpW6T9WZkOKtjOA8mk0VB48GK9K1U+Tac3mERHqs6P5rtgRvidW
         29G7grEOwbNqP9G6AYsyhlHSXy1lnXU0qjERydEh3gadT5qvHC6bBbBCKjh8QILIcEXL
         BI/A==
X-Forwarded-Encrypted: i=1; AFNElJ8wPIaV8/8F5NSz4h+3lIp1pSzak7JG8YirBt+hHTSfzKJKGkz4Eh3n65mKp2pWAU1giWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IhnkUwJkL41DbAeLbzi1DIjHTz1ELZmpa/VCWYUSvgvOFLbm
	yGN7onh+An99K3TahiknmWyB/vyq1i0Tm34BW7oBHy/mY9maMqxIGI3TG+u2FETs8A==
X-Gm-Gg: Acq92OFPTqbEHWQh0kqBbfLKfeoorZt5qLGVMuEQyzu5J1CPUs8D57Z3IfNv9mgeEZ4
	6RjIeK4BOPOr64Lu/8L6UVEAdh0AaoPffbp8FCCBoYdn9SM1tLdBaRN9O829uMkpqF5Lvm5HIVd
	bWU0/dC9rBo+A7y5k4AuigjMpmHzVJgYrgYgI2PFJ6w6iXYymGeOEw9Q16u7drK3xRBYsyovum3
	I5K9FnAQshTShnPXtye/k9r+PI8NgfzWw0ULagbxjGr6AIvm2KX6Pq7BVnXwp7TBNXUZpo+NNDt
	aUI8rKwSVM09svOXWZE1ywLfyrzvWBQY2dfGDYEXbeiX/TmuLxZmXvpUtP0jcEHwt7RIHLMdro0
	lyekubvymk4CRqqT5/5yHPzxVASB48W+xPir262ThzbZGPNtyLhJISIUwFXZbcTXxNLXlhYWBrJ
	1PdiKwklS1oMVBbms7WFBMycVFAEj0r7VV/kcvj7R8RTk+1cdCKdh2RJd8f+260nC0PWBpLQ==
X-Received: by 2002:a17:903:37d0:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2bdb041671dmr3410875ad.18.1779123977360;
        Mon, 18 May 2026 10:06:17 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09e95esm4591161a91.9.2026.05.18.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:06:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:06:12 +0000
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
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agtEPKMDWV7hh5Ce@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> alloc/free helper functions to allocate memory for the IOMMU Live update
>> FLB object and the serialization structs for device, domain and iommu.
>>
>> During retrieve, walk through the preserved obj array headers and
>> restore each folio. Also recreate the FLB obj.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> +static void *iommu_liveupdate_restore_array(u64 array_phys)
>> +{
>> +	struct iommu_array_hdr_ser *array_hdr;
>> +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
>> +
>> +	while (array_phys) {
>> +		/*
>> +		 * Failure to restore preserved IOMMU state is considered fatal.
>> +		 *
>> +		 * This is because the IOMMU translations for preserved IOMMUs
>> +		 * were kept enabled in the previous kernel and the preserved
>> +		 * devices have their IOMMU domains still present. Not being
>> +		 * able to restore means that the memory mapped into preserved
>> +		 * domains might be already corrupted by the preserved devices.
>> +		 *
>> +		 * There is no way to confirm the integrity of the memory that
>> +		 * was mapped. BUG_ON is the safest option at this point.
>> +		 */
>> +		BUG_ON(!kho_restore_folio(array_phys));
>> +		array_hdr = phys_to_virt(array_phys);
>> +		array_phys = array_hdr->next_array_phys;
>> +	}
>> +
>> +	return vaddr;
>> +}
>
>> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_flb_obj *obj;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
>> +	if (!obj)
>> +		return -ENOMEM;
>
>Should this be considered fatal for the same reason
>iommu_liveupdate_restore_array() is considered fatal? If anything in
>iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
>described in iommu_liveupdate_restore_array() is possible.

This one is a little tricky, it is not really fatal as it doesn't
represent a corruption or unexpected behaviour. I think if this fails
the probe of IOMMUs should fail and with a rescan, the user can retry
this.

I will handle this properly in the caller to make sure a retry can
happen for these.
>
>> +
>> +	/* Data must be present and valid from the previous kernel */
>> +	BUG_ON(!kho_restore_folio(argp->data));
>> +
>> +	mutex_init(&obj->lock);
>> +	ser = phys_to_virt(argp->data);
>> +	obj->ser = ser;
>> +
>> +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
>> +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
>> +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
>> +	argp->obj = obj;
>> +	return 0;
>> +}
>> +
>> +static struct liveupdate_flb_ops iommu_flb_ops = {
>> +	.preserve = iommu_liveupdate_flb_preserve,
>> +	.unpreserve = iommu_liveupdate_flb_unpreserve,
>> +	.finish = iommu_liveupdate_flb_finish,
>> +	.retrieve = iommu_liveupdate_flb_retrieve,
>
>nit: I think it's helpful to put these in the order they are expected to
>be called.
>
>  .preserve = iommu_liveupdate_flb_preserve,
>  .unpreserve = iommu_liveupdate_flb_unpreserve,
>  .retrieve = iommu_liveupdate_flb_retrieve,
>  .finish = iommu_liveupdate_flb_finish,

Agreed. I will do this.
>
>> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
>> new file mode 100644
>> index 000000000000..37b967820f14
>
>> +enum iommu_type_ser {
>> +	IOMMU_INVALID,
>> +};
>
>Please document this enum.

Agreed. Will do.
>
>> +
>> +/**
>> + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
>> + * @ref_count: Reference count for the object
>> + * @deleted: Flag indicating if the object is deleted
>> + * @incoming: Flag indicating if the object was preserved in previous kernel
>> + */
>> +struct iommu_hdr_ser {
>> +	u32 ref_count;
>> +	u32 deleted:1;
>> +	u32 incoming:1;
>
>Are C bitfields safe to use in Live Update ABI?
>
>> +} __packed;
>
>> +/**
>> + * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
>> + *			  preserved state in FLB
>> + * @lock: Mutex protecting the object
>> + * @ser: Pointer to the serialized state in FLB
>> + * @curr_iommu_array: Pointer to the current array of IOMMU instances
>> + * @curr_domain_array: Pointer to the current array of domains
>> + * @curr_device_array: Pointer to the current array of devices
>> + */
>> +struct iommu_flb_obj {
>> +	/* @lock: Protects the serialized objects during concurrent preservation */
>> +	struct mutex lock;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	struct iommu_hw_array_ser *curr_iommu_array;
>> +	struct iommu_domain_array_ser *curr_domain_array;
>> +	struct iommu_device_array_ser *curr_device_array;
>> +} __packed;
>
>This struct is not ABI so it should not be __packed nor defined in this
>file. I haven't read the whole series yet but this definition can
>probably go in drivers/iommu/liveupdate.c.

Agreed on both points. I think it can be moved to liveupdate.c. Will do.

Thanks,
Sami
