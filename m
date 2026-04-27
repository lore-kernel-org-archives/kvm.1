Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF63CEBBC
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298667; cv=none; b=p+JFVv5/ierbbOEA6Y/AwBb5Zk60Q5L/JXGNVv5ysFdPE0DTuWhzngfG1OxD+wLoe7kawCSFznIk+VhW3rYqd5i/NdofeMVQfT0FkNtxZ5dT/4v530gY7dK3ob5doyYlLtgDYrrlOHRHUIx2+aZctTtyRmwQzIiTeibI7++HmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298667; c=relaxed/simple;
	bh=jEMMmfGSdoox1VvMk7/uQfRnvnb9SxPsH9ArA5SHRF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVXyPmjD0/smLrODQTWvwuceN5UutwJ/ZCkIdbXkAk+tcJxi/tQebK8udcCX7v2LQOKpZXFQQnNqkp4VkMMfTEUNs3oiC8MFZFIzyVEJLnMvJsKACHxdJzz9WrgJUxiS4fEE3jI7gda/yS5wqkAtSHbleqbLIcMo4EmLRzWADzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ma5zADWX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ma5zADWX"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso3852735b3a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298665; x=1777903465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsNytmMTjP7HFXqAqLQl9kJMS/VlfS6FjoNqX+XGHx8=;
        b=Ma5zADWX3dAk87sj4wxQGjgeZi4xTNHGURugNysPg5WLGyvawDuBRZ5VoZhHkclaNI
         gT/+lXMCb95AK+B8/q+UwYC222Bo8D1d6O4hRnEbrmo5e3JopBbgEZ3M/rjo5/VPp5gM
         kyYtvw7U/d36wNHb91lWXT4+bFoqKb8+Ce6wU+Rp1b+gQrubN51Xpg3HT4O3xTLq4LEm
         YTIDlMAwLauuWAivKhUcMKJY2w6IjDk5WBvsgVd1cAfLF39p/BV1uVISE8iaBscK3nTH
         tkzGgKv3vtwaewANOGZpr4BppDS8gZqNSNGwr8Tg1S6YJGN2ApbBD+jWWOAmJPp6Ad+m
         TESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298665; x=1777903465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xsNytmMTjP7HFXqAqLQl9kJMS/VlfS6FjoNqX+XGHx8=;
        b=rrq+DXgC2mMR+/9qpRpTL+MPoV7ce9M2lxG7IFxy8CcFvDpY619MkA0ymsiQnbhde+
         jP7MD8E1lVooO7hY3WfwG+nNUJepZn5MJRVWT0Ls8Q/uxaShOqRjy1LEt1Veb+T4oAU2
         0RnCNLIWQXOxmkRtNZHu9cVpdYA6vpMvcmPBWkJsJeeJ9FRvu1UgRNXr0k0DzGiY/0fM
         7MGvH1wL4dKKLiWXK8eW9uvpeqkwp4yUa140NWRedXBSnDuAnQYAhl3G4evbxQlDZ/gh
         nVdvZbAlrq/fIyzSwmzsE3HcArb12JdF9dgVYcYbr2RWcP9LQ/nQBzwxB62E2YK+Z77q
         B6ZA==
X-Forwarded-Encrypted: i=1; AFNElJ9mVk9rpu1EgBWq1dNd/NO14xI4zqcB9ADetaXoJLPNzhOoHi09b9kh0GIf0e1C/GqVkmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQI0CV2HhU2U/a7LE3nf7PEH396vFEaS45FD0trKuWx+YQCD8w
	lclEweInGwzigUY4NFx4aoFO1xWs3R1KpyIeMVNQAj0PVhR8IrcKK5HfCNOMfuk/ypXgPLApJGe
	o9HH+Dwc=
X-Gm-Gg: AeBDies8bElmmMXdqkX7B18ZX3e/jF6Lfo7+0b01DUgDlnDjAlEsiO35XG1l+dujCM9
	LFGmsdqBtswyfQQK4MwHlNVqcj7FrrRfdY4uf5jLwi0xfP+VKX7ryNtP2H8ROLtodF6cDnoI9QX
	QAZWzRjFaOmEplKIyDBmv4apTFuERP7vGjQzRaV5NKfu2CWzzY77MTFWfcXpObZmm+Z+tomt9RB
	vVZ9aOOkYdYiizvAcBTImYYPWJUa20bixQphADvRmoAA6oBHK1nc7Z0GHTfg5KSg5YjO4Ev5Gdj
	BPxJpXvTEPxIT8XydYZ2Z/dwjjublyee6ayJQzppj2tpHk4GL35OeebYpBlcA1k9VciKf6bUaCO
	quxh+QQQncrviBJVDZenD1qRXGBmylILuRPvAxuob4BC1lIsPeovVbDC3MN6kmysw3GoEfDsAmD
	EbgCF9U7HeFDMVPh8I6hg1DYlmKuDD80J0tFKQsq2hPSIxa0bc8dlnK9N/yPHyaubakF0chCUDT
	GHFNiTHuQCrcFQj
X-Received: by 2002:a05:6820:2d04:b0:694:a02f:75ad with SMTP id 006d021491bc7-694a02f7af1mr14826616eaf.59.1777298592445;
        Mon, 27 Apr 2026 07:03:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb92db861sm165173551cf.5.2026.04.27.07.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:03:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMYI-00000003Xlc-0XFo;
	Mon, 27 Apr 2026 11:03:10 -0300
Date: Mon, 27 Apr 2026 11:03:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v4 2/4] iommufd/viommu: Associate a kvm pointer to
 iommufd_viommu
Message-ID: <20260427140310.GD740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-3-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:03AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -68,14 +71,22 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  		goto out_put_hwpt;
>  	}
>  
> +	if (idev->kvm && !kvm_get_kvm_safe(idev->kvm)) {
> +		rc = -ENOENT;
> +		goto out_put_hwpt;
> +	}

Can we actually do this or is this circular module references if kvm
isn't built in? kvm->vfio->iommufd->kvm isn't it?

This is why I want to use file *...

Jason
