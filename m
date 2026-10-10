Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF3D3BCD05
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602297; cv=none; b=iaLR+uW3JQuFWPLZihO42K/QZc/b4jaZN4Z7h17Pp/LicDcUxtcY6INJPheZUeHpAlg3rQeevkAlIPsWt5V5mLXdYADTVHZQtvCoAHfs4GViXQRwqwKdCNROgfDGhgFUI7bsZBT2Vf72U+BDfdIZAtf8J7Au5Tt/p69OYQ5E+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602297; c=relaxed/simple;
	bh=Q3Vg1yA9geODvj3ocRmt5LLHOG9WIK/bk89Xu2ISBDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB/6iZVi7VowqTFtYacORcn8ynVmuuxT8SGZ0fwjljmjNVRfC0ofm2XDg7jcNJQxdt+rcUOL1YPe8kdTvQIBizamVzPzInEDUdrpu8TuIegpbe7MmUfmnLBTW3MDoencKDV4nxglg8gpC8o+BHbsa3ufwtNRHsQdDgxCe75haFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcQlDtv1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcQlDtv1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db33db4de9so11135ad.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 20:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791602296; x=1792207096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W8TSuOKAYLfNd5Z9H+xLlnGLDWUhgC3yxJkhYP5eP5c=;
        b=rcQlDtv1Sq9QUj4K4O212UWAJYpfsVl3QF3DOTTYD8jZL6IRcLYj0qJkIHTZY4mLN6
         d8Cgy368+Umh5/ALIgjb59h8YJPpMzOKd8qcshcDZaFjM5oCezYxqI11dtbpeFdSXBx1
         2Ri0+vBo23bYeA2SUvhEK9pVQoz6whjbyfqdMRyc/vuIq2yRsOKNthsz7Ij+FdNOKb+v
         LAQkBW7DHpiUzTBpuJfnwvOUBz/UiBh2I3wPtrs0HHX3Ry9zxofvFN5cgjbd/Ld/HVcL
         zhFljWdrS6ogPUSNkUlMDGyvm7Owh94UM+u48zFAuRwQv2Jof73Kyn8rnlARlIbAYyPH
         v5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602296; x=1792207096;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8TSuOKAYLfNd5Z9H+xLlnGLDWUhgC3yxJkhYP5eP5c=;
        b=Y5y4jusp2jBQYuxQc68BNq+OCjvCx7z6I+F4/yqXBL/VWpfArIedDKB5htHhC1LHUp
         epOQlTYoVxpCzL7vS9M9xMy+i49vRpHHFOU9hkONSPlbxjoh+uWuHV9JtRRcGjWlK4Yb
         vHGqj6wG1UYHhL9KBh0daDd4tKuH+MmnmPGQpoyDk5YepP1PfoqD0GmraZQ6rcv2ibTc
         kI6VhgCR3akzfTPFTyhQR82t6qq1Zi+Qtu2PiXHUY2GoFK22qT/ikQg/uVp2uMfvjnD+
         hJCeUifNVLhKIV5kT1NecYIgc3pfDD5fMIrbyyvMJRPVO3KuzoAmMQMDS6wVUCBjODKY
         BmUA==
X-Forwarded-Encrypted: i=1; AKwUvBzzz28OdnrdmCqd0VxqTwMpmqgpFLTXt24p3QAo7CPJfLJMQQGTN5n/hXUrvxOUgrc9ep0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEOmUJx7BLdyuJG4gzUnbfAww/gswkDdjtE/umadOtbQL8Rg0E
	grS8YyraVrmRTsdPVUyFbHYsc/PfE1NiD41E697dhB/pT//Nm3c/cFAoQXpCUW7J6A==
X-Gm-Gg: AYBFou11phylC2DtPP1xM1WAf/kS63dAN5LAI+K5Rvn5xgEQdM4MAX6po7TnDax8k3l
	FZzHQMfeeUjUvQmnKCdUHBPU09CwgbMQAxQqoMlVGetI2+mEOBTrP8C6iVUDOVfvhh6YVxAa+yA
	GjIgjbrshtTrnweOTfmGBmM4Gr3+72omQR/Pgj1Qb6r8PR0UwA23N+qQg5LDnciz5+GOpn9j4ZE
	zP/0epB3p0Hq3Yr/S3/JAANOni+nHLnzjiY1uJBV4mNevWoKphOvJOtHyBV+DRSdHHXeSU4enwi
	LAI539DFry8qfxgEGwmo7JplG6+i0faAb5lGRCU1PufY1TgUmVqlMoTtY75calgoU0bbv+bWsDP
	WQHcLQmG0+0MqInr/CeuadYQfkKsFcZEVrrX9WsQzNYpjfCrhru8B20H4q9kIOpMfhoYYacgMUP
	4U8XLEF32pjVKjw2GnErhJAuUsC6mZW898megGb1ZrnRZblixwR8jxrDIPQq9ahy7fEbG+HleE/
	ffqoDrj4JawujiVyvXDduM9RHABl6vTJYskblvtPfBlVGHq9PHaPPqDbhBTM59g6go=
X-Received: by 2002:a17:903:324c:b0:2e7:e742:8bb5 with SMTP id d9443c01a7336-2e87e2d3f9fmr648295ad.14.1791602294963;
        Fri, 09 Oct 2026 20:18:14 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3371f748sm3950221a91.1.2026.10.09.20.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:18:14 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:18:11 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 02/18] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <asmj6ErFqQMJe0_u@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-3-skhawaja@google.com>
 <asWEtTcNJSbrY579@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asWEtTcNJSbrY579@nvidia.com>

On Tue, Oct 06, 2026 at 04:31:01PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:18AM +0000, Samiullah Khawaja wrote:
>> +struct iommu_flb_obj {
>> +	struct mutex lock;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	struct iommu_hw_array_ser *curr_iommu_array;
>> +	struct iommu_domain_array_ser *curr_domain_array;
>> +	struct iommu_device_array_ser *curr_device_array;
>> +};
>
>IIUIC, there should be one pair of obj + ser in the entire system:
>  - old kernel has one outgoing obj + ser
>  - new kernel has one incoming obj + ser
>right?
>
>If so, things in iommu_flb_obj (except ser) are all transient, and
>there is no need to preserve them across the two kernels.

The contents of iommu_flb_obj are not preserved. Only the contents of
iommu_flb_ser are preserved. Other "curr_" structs in iommu_flb_obj are
only there for quick access to add new iommus, domains and devices.
>
>It also feels redundant to have this iommu_flb_obj structure. Why
>not link liveupdate_flb_op_args directly to the ser? Then, things
>in iommu_flb_obj could be global?

The liveupdate_flb_op_args is linked directly to the ser, but it only
contains the physical address for the next kernel. Basically LUO
provides following mechanism to handle FLBs:

- data: ser structure for the next kernel.
- obj: Live object that can be used in the current or next kernel for
   easy access or staging.

For example here, iommu_flb_obj has pointers to the end of the array
linked list of each type.

Also note LUO keeps separate incoming and outgoing data and obj for each
FLB. In the new kernel both can exist at the same time, as the incoming
one stays until finish and preserving for the next live update creates
the outgoing one. So keeping these in the obj avoids managing two sets
of globals and their lifetime in the iommu code.
>
>> +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_flb_obj *obj;
>> +	struct iommu_flb_ser *ser;
>> +	void *mem;
>> +
>> +	/* obj exists only in the current kernel to track preserved state */
>> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
>> +	if (!obj)
>> +		return -ENOMEM;
>> +
>> +	mutex_init(&obj->lock);
>> +
>> +	/* mem is allocated via KHO and will survive the kexec */
>> +	mem = kho_alloc_preserve(sizeof(*ser));
>> +	if (IS_ERR(mem))
>> +		goto err_free_obj;
>> +
>> +	ser = mem;
>> +	obj->ser = ser;
>> +	ser->version = IOMMU_LUO_FLB_VERSION;
>
>As version is per ser, ...

Answered below.
>
>> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_flb_obj *obj;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
>> +	if (!obj) {
>> +		/*
>> +		 * If retrieve fails, the finish path won't be called as
>> +		 * can_finish() will fail, preventing the restore.
>> +		 */
>> +		return -ENOMEM;
>> +	}
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
>
>... should we validate ser->version before restoring arrays?

Agreed. I will update this.
>
>> +/**
>> + * enum iommu_type_ser - Type of the IOMMU being preserved
>> + * @IOMMU_INVALID: Invalid type of IOMMU
>> + *
>> + * IOMMU type is stored in the IOMMU HW state to differentiate between various
>> + * IOMMU HWs.
>> + */
>> +enum iommu_type_ser {
>> +	IOMMU_INVALID,
>> +};
>
>Nit: IOMMU_* sounds too generic. Given it's ser-specific, maybe
>IOMMU_SER_TYPE_*?

Agreed. Will update in next revision.
>
>> +/**
>> + * struct iommu_domain_ser - Serialized state of an IOMMU domain
>> + * @hdr: Common object header
>> + * @top_table_phys: Physical address of the top-level page table
>> + * @top_level: Level of the top-level page table
>> + * @vasz: Virtual Address Size
>
>Since it comes directly from iommupt, why not just reuse:
>    @max_vasz_lg2: Maximum number of bits the VA can contain
>?

Agreed. Will update.
>
>> +/**
>> + * struct iommu_dev_map_ser - Serialized mapping between device, domain,
>> + *				    and IOMMU instance.
>> + * @attachment_id: ID of the attachment between device and domain.
>> + * @domain_phys: Physical address of the domain
>> + * @iommu_phys: Physical address of the IOMMU
>> + */
>> +struct iommu_dev_map_ser {
>> +	u64 attachment_id;
>> +	u64 domain_phys;
>> +	u64 iommu_phys;
>> +} __packed;
>
>Hmm, why iommu<->domain?
>
>An attachment (software) is between device and domain.
>
>A device is always behind an IOMMU IOMMU HW (fixed; hardware).
>
>Should iommu_phys be moved under iommu_device_ser directly?

Agreed. I will move iommu_phys under iommu_device_ser.

Also I will move this out as a separate structure.

struct iommu_attachment_ser {
	u64 attachment_id;
	u64 domain_phys;
	u64 device_phys;
	u64 pasid;
} __packed;

It defines the attachment between device and domain at a pasid. These
will be kept in separate array like device, domain and iommu.
>
>> +/**
>> + * struct iommu_device_ser - Serialized state of a device
>> + * @hdr: Common object header
>> + * @devid: Device ID
>> + * @pci_domain_nr: PCI domain number
>> + * @dma_owner_token: Token to identify the DMA owner of this device
>> + * @domain_iommu_ser: Domain and IOMMU mapping
>> + */
>> +struct iommu_device_ser {
>> +	struct iommu_hdr_ser hdr;
>> +	u32 devid;
>> +	u32 pci_domain_nr;
>> +	u64 dma_owner_token;
>> +	struct iommu_dev_map_ser domain_iommu_ser;
>
>I guess this single attachment_id needs to be fixed in phase 2 for
>PASID?

I will drop the domain_iommu_ser as per the explanation above.
>
>> +} __packed;
>> +
>> +/**
>> + * struct iommu_hw_ser - Serialized state of an IOMMU instance
>> + * @hdr: Common object header
>> + * @token: Unique token for the IOMMU
>
>Could be clearer:
>@token: Unique token to identify the IOMMU instance

Agreed. Will update this.
>
>Nicolin

Thanks Nicolin for looking into this.
Sami
