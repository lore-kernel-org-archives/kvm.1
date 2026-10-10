Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD7E373BEC
	for <kvm@vger.kernel.org>; Sat, 10 Oct 2026 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791604266; cv=none; b=ZsRRXDfpMc4yt3RZz+YSGDvpy/xQYRihVXs/IPYTodMHaXwevNUeAvpTZXCAvuKBQbsH7VT2kXwagSyAj9P8se4aMSUh3Yc2iLlixoSqv6QqeY3iyTSbs2YMmEXodD28dzlWJKjL6j++rBHUgJB+BVG7ThTQMgcvkzA0T6epuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791604266; c=relaxed/simple;
	bh=zm0JPF5TWL4gHDuhCuenInnjnMNEm6X/TEf5voqfz6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KivKbRe0kYHk9eFxjQz8GE+1eWRSHfWlqK/XrKssIrfXLmc8UeCfVRlnTPm+9dZcdn0aH31A+2iCVmJapfD81my5ACY5TjWEZjGvJVGpSxM//b+yWCoRV1rdXCB5n9IVoHRxnGJ26G1njoCG8kF4UO0vuhG2cz1FI/J11nHKx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/RyHHPY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/RyHHPY"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db33db4de9so11715ad.0
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791604264; x=1792209064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KMj1EMMi9TApMh2hvVIk1oE7hWCZue2+cChb7ImipdQ=;
        b=Z/RyHHPYUlBbFl/JtzL+trnCW8ECO5ayV85OoH7n1ROy6O16sRzjdkzMZMPNWTz2D2
         xx2NFHkAqP5teLWNJP9D9XW5EEfv93Kn/KHdT9slPbKsw2OgGyZpXkb+uZY/vBBLmGJl
         SLYdMN7fkLpmliYZwDIblngQsl5MmrtnLWm+FAew73IzF/p6OB/tUk18WWtbhcEnUbUi
         YtpQkd723F98zsIqNeBIFDNW+mo92tPxnx0CubdoeqL5lW8LpS2G+uJCk6hHsZ5gwlQa
         WWXfBGG0fqCIzfpy6oju/H6VLLd8TIj9nZu9aub2D0S2fOtrDSyXubYROoGTJ2RMbDVg
         rd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791604264; x=1792209064;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KMj1EMMi9TApMh2hvVIk1oE7hWCZue2+cChb7ImipdQ=;
        b=AQtLtjipPiaGyKhrkc8AYE1CFi8oGhtLOY02wrtD2JlmjSj08hDq6Ic7qRkNFXg67P
         1GMSUCy6Pl+DrS26DPMtlu8vWW1CMfGj3h2NBFabNTfI7yvLkngk4rCtc6p4sHUJrpHM
         4LAIAJvrCHUFfEyGlTPB/+42xq0RyQDe6KkCVr0nDLxQrUrtQAZ2uVIFOf8uimzNDUfy
         xMdYQ0fXiMNGz/yBpv6sp84jho9DYToOKtJBMYZkc5bJlBAAM1dnsH5cekm36Nm3dc6q
         qlVCKla+7hizxQe0XXcGxwLGF6BiDrGq2t9TkS63ynAAFJo30yrUlxS2u+Q/E2TMrcXw
         nbmw==
X-Forwarded-Encrypted: i=1; AKwUvBwcd/poxFMqZf6fx1ZH+wNb7VUkI2GSITEjkBx8PBLFvkoGPXkw2wawfXXPi3R1sPRALuY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJAzpAczrpOPH3fBG8y/5nFPWRl2rQ4R84/OHdkblmjf8CV+Rlk
	7Xx8RhDkDurAzruj64oJqKdTJeBizFx823RbOTsqeShShYCmKoA5jYaMxcxDM+wPpw==
X-Gm-Gg: AYBFou3Q4g1zkZssRgMgM0jY+7XhJ6cOBfrp7cQZXricd+0MOFxmbJbTnXIqfbj9+vw
	br3bG9ft8j1S+c/BkIOve5Bp9INMSIuVgjxD1+exL9RLCnqrKeEqbegQRt/K7KE+00M1gmXoX68
	95tmuHT8Wg3QO2H4ieioAWs9hr8ivzw8F9hy0X+qxD/2tnSRt9o5zg9dMjnfW3RndxJFqsmKNoU
	wLuzWKumMpO4PcbCRz2TW7ThJqYyy+Biu8x1OQZAFcTVlGUU1REbdAtY8gBycRFZAuUAFqCekwD
	rq/q6dwjH/G1VGHKLZpCcIb7WGp6WPxGalDAcd5vU+0ziak80Ase491rVD53KsOOkzsY487HD7I
	YjCyeNhs/DHT1ycZkBMfuQrEn4RnobYfbcvlPScvwPrmz7BQ20904BrR4AAnJ55qHQ05XTOnD1b
	m8noAq+y7LPKy9p1qvj1eRob338MDHLGlJd3Q6AIxo5CcSysjsUhKxPp/piuquvXWXiv1xA/5JP
	Vl9xnni0ahPCCCx/AveGzV9U4CEkEm93GZlT6laSohZTyOofaT4LC6PCT6nqLjN5Fg=
X-Received: by 2002:a17:903:324c:b0:2e7:e742:8bb5 with SMTP id d9443c01a7336-2e87e2d3f9fmr689975ad.14.1791604263655;
        Fri, 09 Oct 2026 20:51:03 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da0596f9sm1943872a12.31.2026.10.09.20.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:51:02 -0700 (PDT)
Date: Sat, 10 Oct 2026 03:51:00 +0000
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
Subject: Re: [PATCH v5 11/18] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <asmwxf1UqQYeDZ7b@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-12-skhawaja@google.com>
 <asahH/NfWZGdvIsE@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <asahH/NfWZGdvIsE@nvidia.com>

On Wed, Oct 07, 2026 at 12:44:31PM -0700, Nicolin Chen wrote:
>On Mon, Sep 21, 2026 at 12:48:27AM +0000, Samiullah Khawaja wrote:
>> @@ -694,7 +700,8 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>  	}
>>
>>  	for_each_group_device(group, gdev2) {
>> -		if (dev_iommu_preserved_state(gdev2->dev)) {
>> +		if (dev_iommu_preserved_state(gdev2->dev) ||
>> +		    dev_iommu_restored_state(gdev2->dev)) {
>>  			ret = -EBUSY;
>>  			goto err_free_gdev;
>
>Maybe it should -EBUSY on a group that already has a device so it
>wouldn't end up with a multi-device group.

Agreed. This should make sure that a preserved device does not get added
into a group that already has a device. Will update.
>
>> @@ -2211,6 +2242,7 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>  	ret = domain->ops->attach_dev(domain, dev, old);
>>  	if (ret)
>>  		return ret;
>> +
>>  	dev->iommu->attach_deferred = 0;
>>  	trace_attach_device_to_domain(dev);
>>  	return 0;
>
>Unnecessary change.

Will remove.
>
>> @@ -3175,6 +3207,62 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>>
>> +static struct device *__iommu_group_restored_device(struct iommu_group *group)
>> +{
>> +	struct group_device *gdev;
>> +
>> +	lockdep_assert_held(&group->mutex);
>> +	for_each_group_device(group, gdev) {
>> +		if (!dev_is_pci(gdev->dev))
>> +			continue;
>> +
>> +		if (dev_iommu_restored_state(gdev->dev))
>> +			return gdev->dev;
>
>list_first_entry instead of for_each_group_device since there's a
>singleton enforcement.

Agreed. Will Update.
>
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int __iommu_group_restore_domain(struct iommu_group *group)
>> +{
>> +	struct iommu_device_ser *device_ser;
>> +	struct iommu_domain *domain;
>> +	struct device *dev;
>> +	void *owner;
>> +	int ret;
>> +
>> +	lockdep_assert_held(&group->mutex);
>> +	if (group->domain)
>> +		return -EBUSY;
>> +
>> +	dev = __iommu_group_restored_device(group);
>> +	device_ser = dev_iommu_restored_state(dev);
>> +	if (!device_ser)
>> +		return -ENOENT;
>> +
>> +	ret = __iommu_group_alloc_blocking_domain(group);
>> +	if (ret)
>> +		return ret;
>> +
>> +	domain = iommu_restore_domain(dev, device_ser, &owner);
>> +	if (WARN_ON(IS_ERR(domain)))
>> +		return PTR_ERR(domain);
>> +
>> +	/* The restored domain is attached with the restored device. */
>> +	ret = __iommu_group_set_domain(group, domain);
>> +	if (ret)
>> +		return ret;
>
>If (ret), how about the restored domain by iommu_restore_domain()?

The restored domain is not leaked and it remains restored and associated
with the preserved device in FLB and will be reused later if there is
another rescan.
>
>> +	/*
>> +	 * Ownership of groups with preserved devices is set during boot. These
>> +	 * will be reclaimed later by the entity (iommufd) that preserved them.
>> +	 */
>> +	WARN_ON(group->owner);
>> +	group->owner = owner;
>> +	group->owner_cnt = 1;
>> +	return ret;
>> +}
>> +
>>  /**
>>   * iommu_setup_default_domain - Set the default_domain for the group
>>   * @group: Group to change
>> @@ -3233,6 +3321,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>
>>  	/* We must set default_domain early for __iommu_device_set_domain */
>>  	group->default_domain = dom;
>> +
>> +	/* Preserved devices need to be attached to the restore domain */
>> +	if (__iommu_group_restored_device(group)) {
>> +		ret = __iommu_group_restore_domain(group);
>
>__iommu_group_restored_device is called twice: here (outside) and
>inside __iommu_group_restore_domain.
>
>Perhaps change to:
>	dev = __iommu_group_restored_device(group);
>	if (dev)  {
>		ret = __iommu_device_restore_domain(dev);
>	...
>?

I will have to get the group again inside the
__iommu_device_restore_domain(), but I think that is fine. Will update
this.
>
>> +void iommu_init_device_preserved_data(struct device *dev)
>> +{
>> +	struct iommu_device_ser *device_ser = NULL;
>
>"= NULL" doesn't seem necessary.

Will remove.
>
>> +	struct iommu_device_array_ser *array;
>> +	struct iommu_flb_obj *flb_obj;
>> +	int ret, idx;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
>> +	if (ret)
>> +		return;
>> +
>> +	mutex_lock(&flb_obj->lock);
>> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
>> +	iommu_liveupdate_for_each_arr(array) {
>> +		iommu_liveupdate_for_each_obj(array, device_ser, idx) {
>> +			if (match_device_ser(device_ser, to_pci_dev(dev))) {
>> +				device_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +	device_ser = NULL;
>> +out:
>> +	WRITE_ONCE(dev->iommu->device_ser, device_ser);
>
>dev->iommu->device_ser is NULL after kzalloc.
>
>So, maybe drop "device_ser = NULL" and move WRITE_ONCE() into the
>loop (under match_device_ser)?

Will update.
>
>> +	mutex_unlock(&flb_obj->lock);
>> +	liveupdate_flb_put_incoming(&iommu_flb);
>
>Hmm, you might want to check the lifecycle of this flb thing.
>
>dev->iommu->device_ser points to something inside the flb, which
>might be freed somewhere?

The lifecycle is bound to the FD that is preserved into LUO. The
incoming FLB is only freed when that FD is finished, and the device_ser
will be cleared before finish. That logic is not part of phase 1, as it
doesn't do the iommufd restore. In phase 1, iommufd's can_finish()
always returns false, so the FLB is never freed.
>
>> +struct iommu_domain *iommu_restore_domain(struct device *dev,
>[...]
>> +	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
>> +	if (domain_ser->restored_domain) {
>> +		*owner = ser;
>> +		domain = domain_ser->restored_domain;
>> +		goto out;
>> +	}
>> +
>> +	domain_ser->hdr.flags |=  IOMMU_SER_FLAG_INCOMING;
>
>Drop the extra space before "IOMMU".

Will update.
>
>> +/**
>> + * dev_iommu_restore_did() - Get restored domain ID for a device
>> + * @dev: Target device
>> + * @domain: Target domain
>> + *
>> + * Fetches the domain ID preserved for @dev and @domain across Live Update.
>> + *
>> + * Return: Domain ID or -1 on error.
>> + */
>> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
>
>"did" is an intel thing..
>
>> +{
>> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
>> +
>> +	if (ser && iommu_domain_restored_state(domain))
>> +		return ser->domain_iommu_ser.attachment_id;
>
>... so, it could be just dev_iommu_restored_attachment_id()?

Yes, this looks good. I will update it.
>
>Nicolin

Thanks,
Sami
