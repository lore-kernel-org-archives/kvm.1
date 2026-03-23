Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2537B032
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 22:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303659; cv=none; b=V/vQmaEwsamkHHfE0RCkG/riDE0YLNilW7+p4apXjK64k9ZmgtYEEUscD/5KTjeEs2Yg7cvg0wphJ5K604hHSkemYPE7Cc1F3IPAumOwOHDNT4DpWTAFwC/fqvT1jDpzNzb2KpOByEO3I/hRjR5/nXSTZR7ufmiPhtMbwWgXp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303659; c=relaxed/simple;
	bh=+5NvPwxkd+9i5GiKKfiHltHB6kQ8dritqed/r7e5gEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLVh+W+6/TeViSDt+buobZ41HOrsg5qNuA3DK8NvL7qfJB3Xxvl40pToHRhpqDLPSKhzDc2RB44NTPLgH8GeNDZw5CyUFw2GuFt41wDPn5LeTf6cFB4kRweTSmYusOXf9K3XPKIBtD0EsZBTuWFompUjIBtAsGeVNnO2R5AbWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjnmsVBn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjnmsVBn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so35305ad.0
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774303657; x=1774908457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exBHGWHqN/Fcx1Fk+ursFGf32PtT/7vVoLt/cnZyELU=;
        b=LjnmsVBnJwZ2aw9PaeRTDBlW6IQkHvKbtyqhL1Ghqdvfx/oDSdRVCRSMjstWY6ST+4
         eVyp5eH2bknrQw05qfOP3Qha0cNZwIrfSEe50nh1ApGkmH07tl7Km3q/kvAckLCsSOov
         VM5UtwM9oBWLe25jxFcBaL03BUUtN79cX+jeJ4VPvQp8vrQuXut4+1PcjMYrf8/nyvLj
         t3EyL3S1CzzA5rVTH70CCFJ/mLdWCGwqa/SVhPaB3dVZyCpJsHg0pmzVlVl/Cx1PqBOH
         fUbu40tcZa3PMGW1vbyNezS/ToBrjJ3N5JZ5X8KLiuXflubQYFV265SLJaOhhu91o6KC
         dyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303657; x=1774908457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exBHGWHqN/Fcx1Fk+ursFGf32PtT/7vVoLt/cnZyELU=;
        b=l5dVfYy7e6SnwmwOzNE80sf5Iny7m6k5PeOeB2PPwMB2UO2wSDAE4PFeAKBAtdLdQB
         UK1JaozJPt9KTeD5y3Nq3Z0gCQmlAroRGPiGl8DmmeLueObRA/cgigZUC1sXDx1n1ctI
         qUMTU4aYnKBig37Snox0VxbYHDCRA3636U+TmaxRaYqmNWTp9tnnSpj4BmQwAsCulGdh
         AQw2s+E8oKidQPV9eWkmhnxYrQ1vDGdqhmLCf5ASTB8Kwn0SZ/KUOkceo/nKcAy8nBkz
         iFjX9pYl7bujS3L9xbfhVL4wN6uKXuN5PRA4wHqOaELyjBAXKP8IMtN466byXXLXvwkD
         QfvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+g9GmBMNDDGFGG/lrOwxjif8zZKF5+8+Jz+i9Yi8yOGRE7RId9EO0QluOKjSWpRdv9fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXaM/3c5BIvTmt4KGUhIJ0Q3X3w0QNjLnmffx6YVq5ysgqa/N
	D6GmW8m2BreIKWImH8eZBLXzC6ExPk/Eo7GvObbuC9S5mIRbtcLuEVZ3KT13HKb2pw==
X-Gm-Gg: ATEYQzyNIP5DA3MfOHQovQFSn/YbG50hyt0rDfVUMxFO3UzrYoGcGM5qQbX/GHSnGqY
	moSDCUIS9n6/j65VeTNtR5oSG+bP7Pb+Ez09sx6HoY4XqCvP77qynNZacXqLUMlQWe+x7CAIf28
	qIwMfr86bjCwBJR+QgPt1/gElSrkQSB8yXexIzwBlJHg/qOwp1Li5ffd5D5J0b1O8RGkMpQKK1D
	1jWz3ER7XvUhT6ofLSIXR8NPK9As9stRmBPH8fkfOI3E9M1LNFrZRpmL4a2jto1vmMDiEzjEVfT
	h5BEtFidWXHFkgq61zI6ZzB6i4XZGnft6tJdUW6ndolUUwbWvotVJ72Cr24kDpRE1lMrDrBEMIH
	ep53MWBw5/g/Ic14ka7KVlsyYvhDOZUCKG5ckcW8XwQ5RCj3W/CqkZVAQ9uS2d21jGHcOHuTRC3
	37tdUsjqP5scqTJJMs1+nyoBX9AnW6Wceir/AYG/HC5los9IT/LIp28DbPunsjog==
X-Received: by 2002:a17:902:ce0a:b0:2b0:4613:2e35 with SMTP id d9443c01a7336-2b0a532cbf5mr1341715ad.0.1774303656096;
        Mon, 23 Mar 2026 15:07:36 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0835551c3sm117347225ad.35.2026.03.23.15.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 15:07:35 -0700 (PDT)
Date: Mon, 23 Mar 2026 22:07:31 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 13/14] vfio/pci: Preserve the iommufd state of the vfio
 cdev
Message-ID: <acG3M41Ho96FyJ8V@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-14-skhawaja@google.com>
 <20260323210111.GB2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323210111.GB2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 02:17:29PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:47PM +0000, Samiullah Khawaja wrote:
>> If the vfio cdev is attached to an iommufd, preserve the state of the
>> attached iommufd also. Basically preserve the iommu state of the device
>> and also the attached domain. The token returned by the preservation API
>> will be used to restore/rebind to the iommufd state after liveupdate.
>
>Lets add token when it is used in restore/rebind patches in future.

Agreed.
>
>> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
>> @@ -49,15 +51,32 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
>>  	if (vfio_pci_is_intel_display(pdev))
>>  		return -EINVAL;
>>
>> +#if CONFIG_IOMMU_LIVEUPDATE
>> +	/* If iommufd is attached, preserve the underlying domain */
>> +	if (device->iommufd_attached) {
>> +		int err = iommufd_device_preserve(args->session,
>> +						  device->iommufd_device,
>> +						  &token);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +#endif
>> +
>>  	ser = kho_alloc_preserve(sizeof(*ser));
>> -	if (IS_ERR(ser))
>> +	if (IS_ERR(ser)) {
>> +		if (device->iommufd_attached)
>> +			iommufd_device_unpreserve(args->session,
>> +						  device->iommufd_device, token);
>> +
>>  		return PTR_ERR(ser);
>> +	}
>
>driver/vfio/pci/iommufd.c has all of the code which interacts with
>iommufd in VFIO, I think we should follow the convention and add a
>function there which can be called from here.

I am assuming you meant driver/vfio/iommufd.c as
drivers/vfio/pci/iommufd.c doens't exist.

I see iommufd_ctx and other iommufd_ functions being used directly in
various places outside drivers/vfio/iommufd.c, so there is not a hard
split I think. This will introduce unnecessary indirection I think.
>
>> diff --git a/include/linux/kho/abi/vfio_pci.h b/include/linux/kho/abi/vfio_pci.h
>> +/**
>> + * struct vfio_iommufd_ser - Serialized state of the attached iommufd.
>> + *
>> + * @token: The token of the bound iommufd state.
>> + */
>> +struct vfio_iommufd_ser {
>> +	u32 token;
>
>This is u32, whereas the token above is u64.

Will update.
>
>

Thanks,
Sami
