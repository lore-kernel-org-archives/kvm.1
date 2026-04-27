Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A82F691D
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298496; cv=none; b=HEKPfCcjdrfs+1BfzT48s8g3vuRW5Z0jAuZKEutjD5U1bjPwKlLJJ0wV++WT6GgYqWPEchltLKDwptEZ7sodEb9ynNXhbPKyFiCBRygHRL6veRH626KDZxwlwSxXQ6r8xWlMrgFxBgfJhiDHRBYterNx2U6rviWe3W1VvQmUZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298496; c=relaxed/simple;
	bh=5PI/ao4ytbR9mycyoVEGfWKOdOA/DliBZUhadzk03gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7/60OOXgJZDtSK9oOFSmvEDHq9od7C2qWD/mvzg+LmZhnlIlruON+RYRt94n8idfzaHbrcsHWqYYowh7LC3OwG/BPCU5TzTH1VVOD55bKWtx5l4RBaAdF8OlYbgsY6OH/hDCg4GOUbEGQ+RedoUXxetIyozUvdo3BApQFGy1UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fElUAz5B; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fElUAz5B"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d55b97f358so6783193a34.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777298494; x=1777903294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgUNKfNY8+yoJgK0OqFgiPxqaEoZN1l+NcbbBxRWsEs=;
        b=fElUAz5BnqQZ6ToEbtEQJXOub18+xracuyZewpo/pswHMs8OCN9L6YInUJ7KesvvPS
         VOrBxWIo3TUnEh7QiyVjYhyQ2CXU0kH4BH0pCTI4hQ7WC+kYpLodrRm3fAJ5J/X6x117
         w/t5MP4fUrmpzOZ4NzPz2rZQwlkF0ElCOBdclmjmLhGP4Mr+UAIr2usDo329vM/lrbbH
         cN8oH+nT3WT4akZ6pL+Okay7tptohrJHM1DzYQeYy+BOyB4uVrM83P4T3Sb53xMQJbAD
         O6ZUIFtsDqIj02xeBwCKNwAa6Z9Cyii49uX9zCo5PymhLHgKBb0158ngf9CwBy6tgAv3
         B7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298494; x=1777903294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgUNKfNY8+yoJgK0OqFgiPxqaEoZN1l+NcbbBxRWsEs=;
        b=pqFfOgkcLvknFoj4dwk/xGkv6W/flIn4B7klNPI51yfHw6XOuXXBGFEFpmwzMdCog+
         gjI0Z1kj+VS8Y8TO8iw86tw1zcY98eJ4hEsO2Lb+FXaTn7LQn1YAX2Ez6eCeNGCWJ0eJ
         HKy0ay/lTnnqpG8+hRePvvZDFv8gw1yZQng/b5O+iaCkUU7V5EsVNzPXDvWofkRO79ME
         5Sdhb//gJvEvUgOJ0U9vEuQVmSli6GUCqJcEzzT3Rc5Fnp57AJ5Shtw8Xu8ez1uDjcd3
         gqnzfvFrzi/DOpyLWdeSd41bDIaAbiuJ6d8idWaScovoFz3ZxiRQi/hAMN2yQFVx82HQ
         KHug==
X-Forwarded-Encrypted: i=1; AFNElJ//i3mCH3kKKbTkNR3ju9YQIFHR+yCPxiNSLkCpKrEvscsAz1qvYl6CWkywAGQcb8q+62A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkSDko1hm0xSlZrjOjmM7RV6o1HsaLIjyVrXc+5Q1ipVPcys/
	IUVHxPXdLyOYhy96hFPQamSAtb3veDvWwkbuQ4vZkUrM9pAY1h+J6kV9GkRFExjicX8=
X-Gm-Gg: AeBDiet9/BuCISKH/JnDRWYlMylyWfNW2j4NJB8I1b+iUy2j0j3t3NhJpKhZ2zy1XOO
	9lzuXAt1p2qxC4Er/DybQRfxyjJvM8HjvvKYOE86rqLRVMi98/+ivjjR28HTuTbbQ7p3GGUEzDv
	is3g2BErpsjBfViPTLQZ0B3wN4MaODx51DIdtT6Opnppzp/UolwTOFrUqwtKf0iOXn2FdnEkvHG
	VJ6LaAG0sHmULPqBU4/q0pOsAWQQWTacbT9UISBRrSZ5TQzUSt2GB4Hj96dbeACsiNF7KkkgF72
	zieEcoSmZQJAic5JPoPlHNqYtIXzdRS79fZWO7g7/e3l9F0RjyYf8fm+ozczSZG7y3TxBCpHxKp
	jgwX/Xdf9drLghPd4A4MPjpyCNLUs7yhwuCo2AuJGDeBkwmLcx8Q7ZG8dI3h5Mb6+nkVQkFAdXN
	tEvZTGo9qY3rKsnqGKJjKjGp1G3jY3UPOwvDzJlt/YFEIP670QHuLfE/baQTnOg25kE/gnleDn0
	EUg+gVHuv9bJmLI70FpZgHVxl0=
X-Received: by 2002:a05:6820:1904:b0:685:3561:8926 with SMTP id 006d021491bc7-69462f07de2mr22724093eaf.45.1777298493949;
        Mon, 27 Apr 2026 07:01:33 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e61c191basm249642351cf.16.2026.04.27.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:01:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHMWh-00000003XIx-3yuA;
	Mon, 27 Apr 2026 11:01:31 -0300
Date: Mon, 27 Apr 2026 11:01:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260427140131.GC740385@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <f5f2bd86-4cde-4efe-b824-d9f1c82357ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5f2bd86-4cde-4efe-b824-d9f1c82357ac@linux.intel.com>

On Mon, Apr 27, 2026 at 05:07:52PM +0800, Baolu Lu wrote:
> iommufd_device_unbind() is an asynchronous teardown operation. Is it
> possible for idev->kvm to persist or be accessed within the iommufd
> subsystem after iommufd_device_unbind() has returned? Should we add the
> change below to prevent this potential UAF case?
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 170a7005f0bc..dac39cb5e7cc 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -333,6 +333,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, "IOMMUFD");
>   */
>  void iommufd_device_unbind(struct iommufd_device *idev)
>  {
> +       idev->kvm = NULL;
>         iommufd_object_destroy_user(idev->ictx, &idev->obj);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");

iommufd_object_destroy_user() frees the memory of idev, it is not
useful to null before free.

Jason
