Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551737D118
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774301948; cv=none; b=DULuyb4xsRGmm3kUxIieBYh83trjcO3AbsqiLW6FcN92NrMFfz0Bya8avn0kqs6N8eB74mnza2R3DmVPyjnzWU+j+1oW8NcP3Cwx5+w2G9Auf/G8ZczCZe0fUsdUIavkoKcVTORe1pGwH09V/CwPziymxTLYk9TuEB5FBW7QuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774301948; c=relaxed/simple;
	bh=o0qaudtJwkdvra1onVwfX5CiVQMZXk6eoY0Q9IzIjPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIE++yeaXXDTPR1Ul0WdUZ5nrsW9AJx5soWAqoAU2WnART1fN8jEG+Dw/ljKbOaKn1dks3OXV7uxTEbedG8T8u2dv7PvoGdTciw9IdlpSeGyjMxk7Jc+mUcXCVSqD/vFvlo5gWzMZay2AfYGCVAvwdprEbh1nu2HGf0I8YFy9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TswNKuGP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TswNKuGP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aeab6ff148so12585ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 14:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774301946; x=1774906746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rUqIg+cj5irYNTC1RJNBQG3tQF9wR23we+1oc9KaM6g=;
        b=TswNKuGPE2eqi11nqe+2gtwGn+rL37ijP8cZzPMZNJXJRbIR8ElBsoSgQo9jWjaoHI
         cqP8OOAX/S6urc5GsS8gjX1PYvuWeYmhdgPI8ip2xqSjlSAiQbHucuSp2h42RqzzfoM5
         sor4SxVF+EPuNxqktmr50zDcsIkxPctWUv4/m9TRLW8eXc+C+AGoQgU8lFO9KxzNgocW
         ZI/S/Y7PLGAfUt+4KiMeIeUvw7Q12PA4gXPIX/SngbJrtfR8DuIMJO5YJGlPOrl7c2Ul
         5xo9lXcnDH8DDbtwHXfAGexA+oa8utqieJLNcC4i8xaXe+98Iuklrz7iMyJArFDXK97j
         GhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774301946; x=1774906746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUqIg+cj5irYNTC1RJNBQG3tQF9wR23we+1oc9KaM6g=;
        b=RfuNzmyH4EvrOJDdnb159afVYN7ldMYNdg7YK4uxkdWTyTXdB1h8KKJ3PE1AEZnAX2
         Kn5Xf4g0/RfkDMYpDECYl4U4IO4FpjqKqOmpAJWiOtF7YvcMDV2WGdZAY8glQY7TXWgU
         af1jgd9cGStZ6B6jwoXarh77bF0XrgyiNNESn659DoSnznYZXXczPzZzR0WGG4/qgScc
         V9hHbIYlsbMxULLhJgRPeShJjRNIT8I7MnFWt3I5KsQWYCstNYu/Jylyhd0ar/nQoZ0j
         QegzfUE9lYSPJqDnnJiJeIOJ9INB3/ItcHE0fDyPXZAg6AyoXTsWtoVGUKFCCXr6lNHM
         GLFA==
X-Forwarded-Encrypted: i=1; AJvYcCW77V7RGelwMlTyaZHuV5wSdqtdKNIOF8FKS0ckj9VHJDMR8Fm2vWxGy78c0W1l0mTRnlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfYSTVAWVaEGbXh9mfeGpelm+nI9lrXuspSm5zfxwXxneaSqG
	JMIEV0kdyJ9HXER4HZzD8524k6rw9Ga+GQstuRCX19ul5DAeqrAC9OUwv+4d8G1NXw==
X-Gm-Gg: ATEYQzyCTwtKIzVBMQbjHlJ5bpju2ZVuXNiaQrEAoZNJrfot4OVQT6y82kEUI2No0YV
	AMRSOggX6Jdwt1f7ivt6BeCDe1cGSkjJdsPP4zPsf+PoHAkXmIddRvJHfRkbLbxmTIlGN6bksuv
	u9o8RmmY4cxVoUDcd8Bnllr43vT8FtG2dp5wggeLWi4JzSOtTKJGJBxi6T+zjCqDt2+4QLKNPm2
	wEz9Xd5UWSdVZy6S6NU1kE48WFmLaWTk8iOQOZDlyhsZRGpiKZ0UhZxQSRW37ghOp6M9sbLm7Cv
	QT61Os/t2rEMA6C66+bRY4OtWYfTPOzTsTKEycY/j+RELgW7/Nqej2EZoFAgq1BDwl3yh3exIX1
	NWGrFHn2ruhD9AnxsOgc82Ylu5AS4OUK8NKHA3hrIhkmx5dRLsX4KCigyWQ4U4ZoNlIZgauJ4Pn
	OpyETPUpWhyDMEfpiyDwD1O8dK1fgSKnqMcc83nKXvag/czq22TJNvEQ3wVt/gZw==
X-Received: by 2002:a17:902:ecc9:b0:2b0:5ba3:2416 with SMTP id d9443c01a7336-2b0a670728fmr370665ad.7.1774301944787;
        Mon, 23 Mar 2026 14:39:04 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc1ddasm10734026b3a.19.2026.03.23.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 14:39:04 -0700 (PDT)
Date: Mon, 23 Mar 2026 21:38:59 +0000
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
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <acGytNA4gn7ePQ6k@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
 <20260323203818.GA2571566.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260323203818.GA2571566.vipinsh@google.com>

On Mon, Mar 23, 2026 at 01:59:13PM -0700, Vipin Sharma wrote:
>On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +int iommufd_device_preserve(struct liveupdate_session *s,
>> +			    struct iommufd_device *idev,
>> +			    u64 *tokenp)
>> +{
>> +	struct iommufd_group *igroup = idev->igroup;
>> +	struct iommufd_hwpt_paging *hwpt_paging;
>> +	struct iommufd_hw_pagetable *hwpt;
>> +	struct iommufd_attach *attach;
>> +	int ret;
>> +
>> +	mutex_lock(&igroup->lock);
>> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>> +	if (!attach) {
>> +		ret = -ENOENT;
>> +		goto out;
>> +	}
>
>Should VFIO in its can_preserve() add this check?

Good Point. We can move this check over there.
>
>> +void iommufd_device_unpreserve(struct liveupdate_session *s,
>> +			       struct iommufd_device *idev,
>> +			       u64 token)
>
>Where is token used in this function?

Will remove.
>
