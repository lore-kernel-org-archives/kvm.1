Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFE382390
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124847; cv=none; b=H4PpSkIymy9SBNj+QfUDV6Rb7rh1UFgVW2YJb46xWBAc+BrpCp7pkK92Irbpf5bLsTmtiXweP4GI2j/vfVnEkggJddl/Bm5l1IIBC+fPusdGYicf/GFoEj7aiLkE+KNbHKrU9QoqR8iQ0opTxkq/bgyLFaDNYpWPtXfZ+VsVt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124847; c=relaxed/simple;
	bh=dj6sO1dq24qPoPg8t/jjU62zkoEGx+WZ2bGv3+pLqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXE3IWrbWEeYVR1hKftiFqVAa3PynoRXOptQCCgiObj0LCw7gDLKocgWQ3Gl/RqfMqV7ZfNQ0YUm3KgzzmHsgWxu8iJ6frKpi/92rxQkVPG6jUzXJ8TfCrlN2+mQZZPXq/sl9yV+r6aiSh0vrzCLQx3x++1vgmHZk7HOkRLoc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H57uDpav; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H57uDpav"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1385ad.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124845; x=1779729645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wacrkWwKLVRP9x12vc+54brUCUoi0SSZqKwPJxVr82E=;
        b=H57uDpav90R/HDZlCXbI/iK4j/NMjkoccn2Pqy+GNNnf5DEI0KgfDi3zw9Ysr4k1lN
         +RL7HYpShgEZbH1v59JjhlyizYBisSJgr1S3mVgSRKbKh2vDQiaG/fGzsiCFXRVAsN5r
         2kTfWXJdiMdKKmHfhWrEkKzq4Mb2etuD6UXxfPsxEg4L0Pd7iOKFtOFXTcJ8k3DaOSQx
         XVaF7kg4flVpLxgulgZbhvCUQIg8LvpbPcRZ7D0cbmeeqJTf07VC9XhEDayef27ny6tO
         LYyB+LZGPoJmtdI6/nJEgflvNhGyuzkHZgZJNOdTZSNEFcLoBWT6w4bOLFsRiVfWSyFJ
         JmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124845; x=1779729645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wacrkWwKLVRP9x12vc+54brUCUoi0SSZqKwPJxVr82E=;
        b=tDgBeVAtbskLieWdlZVgJU2lusHBPESeSRohK+uFCcdurZk1suUMz94moiN7BEINj6
         VTC3WBu9c19RWvERWStkIPLmTY3pRG5GXcSqCGAUeEFB4JTBN15Jqi5ETYJZ256HAkGM
         PndfdJwfCKoWeXXDw0DK7DfnKaVPsTRbekhw4VZzYfC7xIx+260HaNiebho5qA+fkhbq
         eOnSUvYFV2PU1kwsmA2PvO2Sm1bfhOQWTTOL9VCc5Xc/EbNBHvCSrvY23Zp+p+ldYbkx
         1pvMUtjYtUmRIyJpT3UvDSuIPZ/yZ9GdiDxwC8QTbmgi1cHqkyv3X9cp5CEMMXeLqrlh
         NF7w==
X-Forwarded-Encrypted: i=1; AFNElJ+Qf4NvSvWB/ZCsKveoIK5nZTK/KVamglm17/lDSS5/Dmh+Po+hd5zQKCrSZWPLSWJ38HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+Lh2OQTZzBQeC33H8D688SCVS2kEh06y0yVZ3QE6NjVoZXqP
	2jWz1uS9evyQRZ+qpN24R8EBum5v2oEyXl9vGONEnB958RFFy8hCm7cOAZ+Vl4E+bg==
X-Gm-Gg: Acq92OFR0JuA67Lz0LZp9FKycuSwql4Sq3rt6a8Q1D0X4YQ4+UL7ri/VJnyFxT18Dk0
	C3TAZ1Bor4jfO7dwjYSi5ttCrBJpFkRKPLs+tD0neEdtqKA9rs3bwz3aH18Ch7u1q9TIMCKADS6
	WWwW3xF0b/+9Pyt2pv7tvKzzTKV6G5U8L8kcWl7ysPwZtmcxIF13tFI78ujzkcgG5pTiL6JLuQ4
	THh2VjvBAl6Me9vcHHomW22y+NmW6jamsTzE85uLueOjSpKsI8hkvZE94wu56DhkFA3TYKZ1h8J
	OlSAx1XXAnohOJPeG49Xml/oi7lsAMi+aBb2TlRLSc6Y+Hk6LpwlZG7/WAKlqGOBVeVW3Bp5Qv/
	KFghr47hUaNthoEm02Wm2URSffl8eTjouKEDIkppd8H50obokucqAZPmvQEC9/BNKbDVcZ+V8r+
	geqzW23VDhurJlyPNQDA9BdkhMLVxf3z/iljUh2Oy/GaAJxAcfGY1w1xz7zxOe9tEjilZaefj7/
	FL7ow4V
X-Received: by 2002:a17:903:3205:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2bdb03a2d06mr3134135ad.4.1779124844385;
        Mon, 18 May 2026 10:20:44 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f196660f9sm19017886b3a.10.2026.05.18.10.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:20:43 -0700 (PDT)
Date: Mon, 18 May 2026 17:20:40 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Matlack <dmatlack@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agtHykqDImuLL6nU@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
 <agsHFbI_FQEXiZAA@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <agsHFbI_FQEXiZAA@google.com>

On Mon, May 18, 2026 at 12:33:25PM +0000, Pranjal Shrivastava wrote:
>On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
>> On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> > alloc/free helper functions to allocate memory for the IOMMU Live update
>> > FLB object and the serialization structs for device, domain and iommu.
>> >
>> > During retrieve, walk through the preserved obj array headers and
>> > restore each folio. Also recreate the FLB obj.
>> >
>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>
>> > +static void *iommu_liveupdate_restore_array(u64 array_phys)
>> > +{
>> > +	struct iommu_array_hdr_ser *array_hdr;
>> > +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
>> > +
>> > +	while (array_phys) {
>> > +		/*
>> > +		 * Failure to restore preserved IOMMU state is considered fatal.
>> > +		 *
>> > +		 * This is because the IOMMU translations for preserved IOMMUs
>> > +		 * were kept enabled in the previous kernel and the preserved
>> > +		 * devices have their IOMMU domains still present. Not being
>> > +		 * able to restore means that the memory mapped into preserved
>> > +		 * domains might be already corrupted by the preserved devices.
>> > +		 *
>> > +		 * There is no way to confirm the integrity of the memory that
>> > +		 * was mapped. BUG_ON is the safest option at this point.
>> > +		 */
>> > +		BUG_ON(!kho_restore_folio(array_phys));
>> > +		array_hdr = phys_to_virt(array_phys);
>> > +		array_phys = array_hdr->next_array_phys;
>> > +	}
>> > +
>> > +	return vaddr;
>> > +}
>>
>> > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
>> > +{
>> > +	struct iommu_flb_obj *obj;
>> > +	struct iommu_flb_ser *ser;
>> > +
>> > +	obj = kzalloc_obj(*obj, GFP_KERNEL);
>> > +	if (!obj)
>> > +		return -ENOMEM;
>>
>> Should this be considered fatal for the same reason
>> iommu_liveupdate_restore_array() is considered fatal? If anything in
>> iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
>> described in iommu_liveupdate_restore_array() is possible.
>>
>
>Righ... Nice catch. I suppose we should BUG_ON() this because
>luo_flb_file_finish_one [1] returns void. Thus, if we return -ENOMEM
>here all we get is a WARN_ON without panic.

The error is propagated by get_flb_incoming(). The finish path has a
WARN. But that is fine because finish won't be called as can_finish()
will fail if FLB retrieve fails and restore cannot be done.

I will add a comment about this here.
>
>We can't statically allocate obj in liveupdate_flb_op_args because obj
>is a void ptr. I believe we must add a BUG_ON() here.
>
>> > +
>> > +	/* Data must be present and valid from the previous kernel */
>> > +	BUG_ON(!kho_restore_folio(argp->data));
>> > +
>> > +	mutex_init(&obj->lock);
>> > +	ser = phys_to_virt(argp->data);
>> > +	obj->ser = ser;
>> > +
>> > +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
>> > +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
>> > +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
>> > +	argp->obj = obj;
>> > +	return 0;
>> > +}
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.1-rc3/source/kernel/liveupdate/luo_flb.c#L208
