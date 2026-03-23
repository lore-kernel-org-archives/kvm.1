Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5273E5ED7
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299560; cv=none; b=JtWobx5MJ609dU5VfCCsMN96H7WMDNSXqLtnplJa6RirxS4aRIICu9y+2dydZUDTy6KWnXxukcKM8W37DZGYCslKRzQKTkzffZW3oMexJMGw9HL/61Hj/I/P4SCEAsQg8A/bUnryrD6ckUyUclc+2syjNYo1aYHNGyldSywF2Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299560; c=relaxed/simple;
	bh=IKUYy6h7E6OacLnO0SCP+Gf6jvCT2VvxqJLPXFXcJuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VThpl+9UDXhNKqRnbqLbRgdzsn9vpFgYeBr2qda7S8MXDYjaYPelwtme7yD9Aby4S77ds8U/Iwgu1PTHeBQkoasbI+gDfc3CWrVF33gT0PE092rew62rZHWlqb/kFCs7Y10McVO7aAqnKx+7GCUiwRbCNOku6T/KcLJxP3k1o6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rru906PN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rru906PN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so9225ad.1
        for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774299558; x=1774904358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GfEbQ9zMwITLJ6hWqGMJubvK51p36l2V00YC6g9wwEI=;
        b=Rru906PNRkCWsCtlmGzoMkHOi6OAtwI/Anp0Xx0XyL3l7hOaN2/fDv0ZLP29/oZ54D
         dVSizdmFl74/ryhVhRnDfHLw43kGYPDddAROhzBa1Zgg9xayPM/zTbLuNb9leMs37kH9
         OBQ0k0KMbeuMoUgeHUYJ3p8fn60xAL+CLbG9hwnBY1o8Q6zcZV1B43+fieg+7Lnf225k
         YO+reEXxAE0Ct3jMZicS5WCDhHYac6em1X4/oEgDoDsZdmr3jQ6HDecEkTVuH4/VpRHV
         nwy1lMV5cb7GfXN4ITWwUGRH6Ac78AjA+u720IwnZnMfrrxxMtgrNtsbXVaycRHDJKH3
         gLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774299558; x=1774904358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfEbQ9zMwITLJ6hWqGMJubvK51p36l2V00YC6g9wwEI=;
        b=cDzDhSFpJvhYffkL6Wjz8EvzYJDl5TLOPKw4uZxylpscDWhbHOeYYrbIVPVYiZgcKi
         F3nEDEnuJcLbmkap79hXgwZk2cP8G28bzSSS5G1diLO9Mx1QSLXygM+9XHiNd9zVx5go
         8VD7UCrr0yj+UnVycD5PzSKdLJvouu88tHwdJf1xNTgBjWL5rjsEK+OfmFwlgEYcZc3p
         r0Q17fRuK41uGOi5QLEHdx/aPtLJL3kIK0jSnmTCmuErd0LDu0GACjLNwbtkgRNSOszO
         Gzeudw19v+voYyZumXT7Clg2A04Ia8LXonZH+8dUkeFctufp4S0KG7q3CiSf+zmV3LIF
         R7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWfvKD7dAYjz31TUIrh9XatCJNNzFkuL/qgOMxMvJGbq68q7D5EvNRGIakNONY+Ilvdpn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKIi8HFFeyvpop8U4sUTUXS1ukPrd2KNeCe/E3kc2uLnkdZ4Z
	4vPnH9YtK089JQpy+vRmz1ipBItOqargVLUOonhU3jx1OfvzkJ3cYpGwmtZkpDWtxg==
X-Gm-Gg: ATEYQzwA9duRQebSWRkS+nT4kiCdvhUnfa1iRknLC7pQUDoC9cIcgfoMWWpm3qli6YA
	W7l1gWvveK2SvyYmVT/qa5vogimmEweJwgpQlz8mI2IhwHqF50a2MN9EYmbxbOq5qcdq7yw6Tp5
	M03nyUFTpZokvGMVwEH/veARFv/ICpKM9SV79xfPM2I47wYalOkPKkC+L2prRLQih7qEeYMc2wP
	B83PvDSmLF/J9Lr7FmX3f7HVUFve7GZ4BylQcrB6skq8Qn49Y4wvvFkbf6EVSKywMxAo75IUFwP
	U/HWcR1rq0jsXyp/6VJJ+vLGoqvEi1BcY7C77s1M3xClevkAHnnox1xdkwdRJCWLETLs5bi1ZLA
	47Tf95b5MyhcZ5Iw6xb8FCRl2DVvy4lW6KQ4wGWxV/pFJ5/qQtt8Pm895q0Q/Xfcv/CeoZtvdkp
	0sYZ41N5rr6WLUbM0JhQB2Vlbm7+tEaE9pEnnemTQE99WaZP6TicOg333OtQ==
X-Received: by 2002:a17:902:e80f:b0:2ae:4453:3674 with SMTP id d9443c01a7336-2b0a53e76f6mr951935ad.4.1774299557926;
        Mon, 23 Mar 2026 13:59:17 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c015cd6b8sm101179a91.0.2026.03.23.13.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 13:59:17 -0700 (PDT)
Date: Mon, 23 Mar 2026 13:59:13 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
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
Message-ID: <20260323203818.GA2571566.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-13-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_device_preserve(struct liveupdate_session *s,
> +			    struct iommufd_device *idev,
> +			    u64 *tokenp)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +	int ret;
> +
> +	mutex_lock(&igroup->lock);
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +	if (!attach) {
> +		ret = -ENOENT;
> +		goto out;
> +	}

Should VFIO in its can_preserve() add this check?

> +void iommufd_device_unpreserve(struct liveupdate_session *s,
> +			       struct iommufd_device *idev,
> +			       u64 token)

Where is token used in this function?

