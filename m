Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2703CFF6C
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298352; cv=none; b=lcsbchBDtuS1AdzYIhBx6+lGx3lCBc9GTFDhoL5bu66eqnmhO30WICXEfl+SHuVksB7O2ZF2zNPotE0PQqmWKZmTRw9fOByKFdLCBZbpEkHBAn9CRD/3T9gwCcEZOyZWxT84a9qAvKlWzPlC5IymFTB/qNSgx8dSpIvLa22qbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298352; c=relaxed/simple;
	bh=pC7LNCoqLHqtSu4IvN5L+bojdwlxNMiMUpCfRrWXA80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxj1FR3YpZe/37iODjrO2pW+kOCwaeHBYrJ+DSyT9r+pwcBpkclBAxkU4Fk55ulFLLy0o1FSZBfkCsVbdt3CAs0U0N2HTc3WikpbKgEhtN0jmzTQp4haYXVvnTvsFMTbNgEiRwWnxNY8gZ6gpa1i1WO5RmHHgYAyHQYAlJAveKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mmw9P0Fy; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mmw9P0Fy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8ec9f099fc6so831556085a.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 06:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298348; x=1777903148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0ud/a/8Bcj3BJq0RBIUY01Jvn+6rT7JhYkFAFghx3g=;
        b=mmw9P0Fy7whzWRUSpgXrGuSXZ8UI5N7QGyCPe1+nFv6UmThdsaZMAnxYZ6mAgye33C
         62nbTKHL+GnHJyjz6ocjFmbqGqKoILtl28Yd9TkplM9CiDSex0wkVBKtIdD4oEOi74OV
         JwCp6+W8pArpYQc4qUG8lSbjOvJynVY8UpaH4EC8n5/ccXG56RYp2FrZII/SODOAE57u
         r/kdirav4AZpmHMJcU6k6yqUVX23gBDVlZYDqhmVWKj0IL3dPSqdwjhrYzTylfk0f9wc
         F/OuuCj6WuZ+eCriiS8qQFjLOfJ/noNKL8ppmdd2Bvh6gFh4GamUtVOI+YvOYfCy4p0h
         8zaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298348; x=1777903148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0ud/a/8Bcj3BJq0RBIUY01Jvn+6rT7JhYkFAFghx3g=;
        b=JDqS3NXLgCCEeiXiaztjSr6CZuB7ZEsit9KnhFYQKzopx2UAAisKIRScPRBjfq5Fyg
         wBUqJb9ZkUU7R1D4tbAZNIYy1K/w9LlsRH47VHIuVkd0JQtku9U5s+Vnxbj8Kvz6MA7z
         k1NuPS2JAd9x7YXE+jL03LDg3Z3A/cCXBZ32xQMwPpFUi8sfuXQ/VRT2SucOvsYnGwf0
         mBVAFjeNBffAHq96QmXzzMXCHgiWN/4robarEtT5UObcqYLPlf/40RnEcZEjtdepV003
         GCf1mtzy/hmyMRF39qE5np8YkJPL49xlkwdDeVLql1J9dyRvUvR86buA3OeymdI4KH8U
         ChBw==
X-Forwarded-Encrypted: i=1; AFNElJ/yMOELnefU14jc9HPCVSvoPeS+JkEN2jxkc0fBTZEShjBr3OqjPxwnp/1T/Ai+tkThqmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3FNRXyCJrK4tpt35V3EEnHxj8AfshhaK4WMkfF9YaJEmVaHK
	xAuVyRZ4nYLAVQxQQgFEfgyVWuGVpIo00UvSb0YRsjTnBYqgVdnmP0RZI9tTM92qLhI=
X-Gm-Gg: AeBDieua0u1lXDSPoZL/+pNjeCpPpRSoqIGRelv875PppkjBRLImNTuJHrCMYFhHiPO
	/daMN1bUT7Y5P/6FD407c6ccne4N0Kj6ADUdN4k0wIchmQbJJncFQKEveHYGjaRBG25R+xBFbVh
	xLSkpw3b+CGfP2l9feHSQZ0mdcVphcHiejbd5Ui9cL7WHx/qVVr5TOhiaF4DnUcdG1ZmVtLTMd7
	IW+CZ/GycuM1e4QkInJzQMw08XZdu+N98pz/y82KOTrQXR6ggA6qm3reil9Km/AQGlhffG927Tu
	t7UrY6a0QYaZH9ubiULw+BcHsWTFxiZQqcCMLcjsvjcYifJHF4RmLn17jZinDzc6WpQ3NWSuekf
	MhZRxbbCpuwYbS2sGDhWWCjskcX4adadj67pjqZi1VEdz25N0mmL2lM4YaYswT4/JxUwAGTtOIK
	dHTmFvgV1TEVdX0PFHVQrR5XmuDUUtGxNSDrfBEK0q1ez57KkQY15cGKh6XiY+SjAMQRJXjiiZh
	Jxq1xPPQCyOSEuMFwH+IY//YBA=
X-Received: by 2002:a05:620a:2a03:b0:8cf:dd93:acb3 with SMTP id af79cd13be357-8e79295ec07mr6190424085a.56.1777298348210;
        Mon, 27 Apr 2026 06:59:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d5fe8f3csm2690335485a.2.2026.04.27.06.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 06:59:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMUM-00000003Vhg-452w;
	Mon, 27 Apr 2026 10:59:06 -0300
Date: Mon, 27 Apr 2026 10:59:06 -0300
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
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260427135906.GB740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427061005.901854-2-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:40:02AM +0530, Aneesh Kumar K.V (Arm) wrote:
> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> Add a struct kvm * to iommufd_device_bind() fn and associate it
> with idev if bind is successful.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: fix build error in iommufd_test_mock_domain()]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/device.c          | 5 ++++-
>  drivers/iommu/iommufd/iommufd_private.h | 2 ++
>  drivers/iommu/iommufd/selftest.c        | 2 +-
>  drivers/vfio/iommufd.c                  | 2 +-
>  include/linux/iommufd.h                 | 4 +++-
>  5 files changed, 11 insertions(+), 4 deletions(-)

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 344d620cdecc..453fbceb9219 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * iommufd_device_bind - Bind a physical device to an iommu fd
>   * @ictx: iommufd file descriptor
>   * @dev: Pointer to a physical device struct
> + * @kvm: Pointer to struct kvm if device belongs to a KVM VM
>   * @id: Output ID number to return to userspace for this device
>   *
>   * A successful bind establishes an ownership over the device and returns
> @@ -216,7 +217,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   * The caller must undo this with iommufd_device_unbind()
>   */
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> -					   struct device *dev, u32 *id)
> +					   struct device *dev, struct kvm *kvm,
> +					   u32 *id)

I thought we were trying to get away from struct kvm?

https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/

Ie this should be a 'struct file *kvm_fd'

?

Though I am wondering how practical it is to do this at this moment :\

Maybe ask Paolo how his series is going?

>  {
>  	struct iommufd_device *idev;
>  	struct iommufd_group *igroup;
> @@ -266,6 +268,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
>  	if (!iommufd_selftest_is_mock_dev(dev))
>  		iommufd_ctx_get(ictx);
>  	idev->dev = dev;
> +	idev->kvm = kvm;

If we do that then I'd take a file refcount here ^^^

And then put it back when the idev is freed

That makes the lifecycle robust.

Jason
