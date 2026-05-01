Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDF28C035
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777671927; cv=none; b=tsOr1BxoDBeLnZKAZG3RPEHndsCwuxb3cU33ZMc/ALy7HnvzaxgwhVs9VemY5D+taIiZind2VH+nameD7P4OltBtJyWdV6B4HJZC7G8avLFpKzoc5eiWzNzNQMuMDY+Yc3co2l813bSPXur7xiliJ50B+JZAuA8mQiyOAV/RQRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777671927; c=relaxed/simple;
	bh=wONl8ymJLcFAu45GW0iEPDy4OF4pO+1gALRXgGMmCEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXSpJviCZQRyrtc/wmmRWufMCg6dAlBQOmQNXwEnsh8pvPetNtsYipY7vZJW76mad0vSboLjMoHN+aeNaNhHlYEQ+iCtsp/U53+7Q6Zfn30o2ZyT4UzDHnGPg2ilpeZJAtNQ2LyIIox1VnOderAEoxcBaIi2NL9pG27W8qhEy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZKgGaWTx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKgGaWTx"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so1017735b3a.0
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777671925; x=1778276725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EnSyBxXT0t6Az3EuJiRgBhCI9ryWONltfzcDE6vjMFY=;
        b=ZKgGaWTxKfYu93BepUC43B/BeNI2w/pUGHScvrZ2zsZoxhdKMvv4a3fP4wPgFs7S9x
         CErMgdhDA0txv19HVKk5rqNJkMNbYJCAY38mQv0ZgpUsx8L4U6UZ/f+Xhc5FO1IiuKme
         TMqR3LXUFtpmJF0z2+IK2VDx+7prsjegvBoLtn1FwtdKEQyUlQWKR5lq+JgDxh0AlMrL
         buBtlGKS2rrHdTloaTwZzaya3gggAiZDoL4jiLjK+v7IyyaarFZuaxwwCDDO2baCM7yc
         571HhtbjzpDmKUt8cPMkhn/9rqOueS5+cSZI0sMg4+PT4KKxy0tkc2xHI1KSS/HrnmAh
         YVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777671925; x=1778276725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnSyBxXT0t6Az3EuJiRgBhCI9ryWONltfzcDE6vjMFY=;
        b=S3yRDG6Oim4Uh5IuvmPPV+I+MWpzkIquzeOYmTXRdqP0v+A9aixyzYV7Yp6bWKTG2c
         2L0dZbD1rQNv86ewAhROQZ5XKgDeZsPKNB/7JglAtID+UvAT4bawOt7e4DLABynbCnma
         JLzwxPGfnGdjiD0lyGq18ZgJJLolG2tH/D5HXqC4LkAYLDQh2R4imE+FpKRKx9haHMwD
         fTxVLFI7CV6mtQnzEME6qWCUmzrl3t/+AHpDSDRklZnlCVsbyUFQcaO4adpICQwlCCR+
         /HU7uzVd3LETsYwCTs9yhulDMKqVbk86HshwcAfP7inFcBCdRfI9YsG+Pzg3kbqbYWZL
         arrw==
X-Forwarded-Encrypted: i=1; AFNElJ96AqsQpxw2Ch4iIWZpCMCthV+z5BNGJwDeXDYWqulKH9hMnZptIEmaKGxAB4AwgAGS9Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykle78jQJDCUKLmkeN0GuXFwPW3aVPwhVnBQxpOZGO9ecS30jZ
	zWNqzKOGp/ngBRy3rq0y2/dEUwVkspAUvZjtUZlG6ZiTqaFu4X+Ui1AotXhOT8TeHw==
X-Gm-Gg: AeBDieu4VSsIQB2N+hfCScs/X/qbh18I6lDemN3L4MJzgW//vs1Q3HGIxpYMpHK0U/A
	hhMGbWq1wmODASuXGjtIES3mTBxGs9hB2sY06em07ONxrxDhIHQE8dWIX+U7jgFGPzoQESqn9As
	0kM2kdf2zuvBXLDeWu4zf+HkIwlh+bvYiGmTIFcOCdcT1+XSYGl1aB5X2PKK3GtPjWc/tqhFIvc
	bQhwIzuk3wn+fyctesR6/dGl32xR6+Qgh0y1kF+HBjfrkmhCkPwLGSLUqM5/CpPFd8+zr5hwN4Z
	TvIo4RAmDSvKAUJ0zBMrj3TA6tiTw5oGzgTMcNfbTHYQCYlrpqDjsDInc30wXOEKjPD7xeI0nIi
	mWZR4lnZRBi0W2V09mbu7+SvJT88uf6xP/QKEVD2jgU0fd1v7D6Nsu0L6LRo4J/LsOqPbNl/NEp
	2GXHnVUjRB0fXhMl1Leh0soNIpTM+d8io1VQG3PgQetPAwKNkiIhrkbHu1PJodP7jFOiG+1WVxH
	qz9gg==
X-Received: by 2002:a05:6a00:1d8d:b0:82a:7734:8c6a with SMTP id d2e1a72fcca58-8352d371a37mr648847b3a.48.1777671924329;
        Fri, 01 May 2026 14:45:24 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0049sm4007877b3a.33.2026.05.01.14.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 14:45:23 -0700 (PDT)
Date: Fri, 1 May 2026 21:45:19 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <afUe71D8JfgmA0BG@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-3-skhawaja@google.com>

On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> alloc/free helper functions to allocate memory for the IOMMU Live update
> FLB object and the serialization structs for device, domain and iommu.
> 
> During retrieve, walk through the preserved obj array headers and
> restore each folio. Also recreate the FLB obj.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

> +static void *iommu_liveupdate_restore_array(u64 array_phys)
> +{
> +	struct iommu_array_hdr_ser *array_hdr;
> +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
> +
> +	while (array_phys) {
> +		/*
> +		 * Failure to restore preserved IOMMU state is considered fatal.
> +		 *
> +		 * This is because the IOMMU translations for preserved IOMMUs
> +		 * were kept enabled in the previous kernel and the preserved
> +		 * devices have their IOMMU domains still present. Not being
> +		 * able to restore means that the memory mapped into preserved
> +		 * domains might be already corrupted by the preserved devices.
> +		 *
> +		 * There is no way to confirm the integrity of the memory that
> +		 * was mapped. BUG_ON is the safest option at this point.
> +		 */
> +		BUG_ON(!kho_restore_folio(array_phys));
> +		array_hdr = phys_to_virt(array_phys);
> +		array_phys = array_hdr->next_array_phys;
> +	}
> +
> +	return vaddr;
> +}

> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_flb_obj *obj;
> +	struct iommu_flb_ser *ser;
> +
> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;

Should this be considered fatal for the same reason
iommu_liveupdate_restore_array() is considered fatal? If anything in
iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
described in iommu_liveupdate_restore_array() is possible.

> +
> +	/* Data must be present and valid from the previous kernel */
> +	BUG_ON(!kho_restore_folio(argp->data));
> +
> +	mutex_init(&obj->lock);
> +	ser = phys_to_virt(argp->data);
> +	obj->ser = ser;
> +
> +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
> +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
> +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
> +	argp->obj = obj;
> +	return 0;
> +}
> +
> +static struct liveupdate_flb_ops iommu_flb_ops = {
> +	.preserve = iommu_liveupdate_flb_preserve,
> +	.unpreserve = iommu_liveupdate_flb_unpreserve,
> +	.finish = iommu_liveupdate_flb_finish,
> +	.retrieve = iommu_liveupdate_flb_retrieve,

nit: I think it's helpful to put these in the order they are expected to
be called.

  .preserve = iommu_liveupdate_flb_preserve,
  .unpreserve = iommu_liveupdate_flb_unpreserve,
  .retrieve = iommu_liveupdate_flb_retrieve,
  .finish = iommu_liveupdate_flb_finish,

> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
> new file mode 100644
> index 000000000000..37b967820f14

> +enum iommu_type_ser {
> +	IOMMU_INVALID,
> +};

Please document this enum.

> +
> +/**
> + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
> + * @ref_count: Reference count for the object
> + * @deleted: Flag indicating if the object is deleted
> + * @incoming: Flag indicating if the object was preserved in previous kernel
> + */
> +struct iommu_hdr_ser {
> +	u32 ref_count;
> +	u32 deleted:1;
> +	u32 incoming:1;

Are C bitfields safe to use in Live Update ABI?

> +} __packed;

> +/**
> + * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
> + *			  preserved state in FLB
> + * @lock: Mutex protecting the object
> + * @ser: Pointer to the serialized state in FLB
> + * @curr_iommu_array: Pointer to the current array of IOMMU instances
> + * @curr_domain_array: Pointer to the current array of domains
> + * @curr_device_array: Pointer to the current array of devices
> + */
> +struct iommu_flb_obj {
> +	/* @lock: Protects the serialized objects during concurrent preservation */
> +	struct mutex lock;
> +	struct iommu_flb_ser *ser;
> +
> +	struct iommu_hw_array_ser *curr_iommu_array;
> +	struct iommu_domain_array_ser *curr_domain_array;
> +	struct iommu_device_array_ser *curr_device_array;
> +} __packed;

This struct is not ABI so it should not be __packed nor defined in this
file. I haven't read the whole series yet but this definition can
probably go in drivers/iommu/liveupdate.c.
