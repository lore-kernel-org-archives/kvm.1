Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B96337BB0
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426687; cv=none; b=cuUvvvqZ9f7YKTy4dywSMZEeWcXiYP9jUNSYR/Cavd4W0ad7m81KNWL12RnhJmBJKDJmtrGSSOVh7tgrqHC746fN7k2c7Xaqfl3COz5DL1FWA+Jgw3JddVR/Q2PzkEKjrwltaoMh8H2E7UJaMuEKwWizZ9iuDF/6GKPzEODD8PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426687; c=relaxed/simple;
	bh=0qxNb0CImZ7Y6yg+F786kCKDYDie+t88orCSqmVuTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q06mJj3KKGkPXwS1SdInvqSpYwwRYFKP2OtXX4f5UJahXA9imxDfPKmZxk+2XVYicDDpoDKSU60ezpIV/NGtn0g080b4jeWTOlpDEWjhewW2M05K7BYulwCZUqR0PJHP5WV0UQDiWTquGXxZtQTFuzBUtDEbN7PVbRO1r41A918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=aEn/Dcan; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aEn/Dcan"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cd8c6e365eso255439985a.0
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426685; x=1774031485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQGCXWZbNaSYnb2f/K2OJx848xGu9ABhmecVVHvXBkw=;
        b=aEn/Dcan9fbzdOpDqq8UJchJPC7LtsnN15ih5exltAYBYXiuVJ1fkBrsLUlf4GL2Z6
         ENqdDAJ7ZI2jSEq4eWYATlImM+WU8RCjOFM9Pz+IC1MWKD3Pfp2qkmlgk++MUtVtRf5x
         4fs9/gn0+gBqMBsgLvHjDuiKe/H5xKGkhlopTBkiZeETrAFjzzhxj8ZA8Zs75vOS+9qG
         xwBiP7icnYblODWtVEUdp4JUatgckLHlWDkn3uGei6gQDS4UcRlv6N2scjKFyav0hh5w
         Qrib41uAs7H3K70g8Hfwn4oerEX1D5xRz99Td27gP6HhlHRsTkSu/VegMsx1OVyYKqw3
         QCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426685; x=1774031485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQGCXWZbNaSYnb2f/K2OJx848xGu9ABhmecVVHvXBkw=;
        b=iTUdwFX29E3Wz5+VNv87iI5+UOrvpZBnVvof+6e6hr8w2VZhHoAiz810tjLAxKrsbG
         nZ+pULhPMTrz7BgWpHsoZXkNP53nATtATKocp6Yl+AEUlpmzt4tQaZAW5ZN7BqUShsL+
         i+RaaXYKEjA1AZMPVLf9OQcraRh40MmHiWlZNJbHlIYGsIRKo38B/2/eZErOj8C+iKG7
         cqeMesJ8LYvlk9E7g4EyLhPA53T2M0UE6Ma33/rCRYLlZ1btHRWhTBnDnWrM3ECANIf3
         Ng8oKX7XTjrRGQ/QguIN3E0Hgf5/DbLJSCXSHaaATY6NP3RRSpzMJNbe5KZk3Ggw2idA
         q1hw==
X-Forwarded-Encrypted: i=1; AJvYcCVrnTQ3LMvfrKPfmX4bdJQCLsvTGQoyWoYa3Sr9x9gFRxueQKgg3HJZqWxMNxdr2bfuS7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz37+3f0+LpPcdgDYeE6Jap+JnEbd1fBgkw5Z8i4iXdHsC7nOFT
	cnuhWnQGd4gTV5E8jjuxBPBi3/sqvwv8oVGqfTEk1/15bgmS3iVhqeHF+yguKQGzOas=
X-Gm-Gg: ATEYQzyTs49cTVpCMAehzVuwvbzBeQBN3HMjgEckozHcX7N8A+TYsS5GP4ycqdmmhiM
	qfkRS6Ld6H3HpfItcUlKhY+vpv+ryq4gpaNdO9wSmEHrhtHxqaBrG5x/A2BS+AhFJP433AngKpF
	XzoVAkWceL1ay5TK9iXptTH5Oi7dzA5rpdXeLNBF5sEdDWMEE9UBrpO2Fsxse282S5ZM2tRRtH0
	pYR7PnFxCxDs0k/Qa7bhs9iQbMymahtGSYt1h01CYN2QOgxpn+RK6EcgXz/dAthVJKglXGJCO9O
	XwsRge5Aydawfntn+iAq8BN3y2RP9gA/cWykzeajdgGIybRVtW7nw44E6TA/2yn6yhPnvEgUyPt
	UaSDTgMdtKm+I1A8qHk5OJTBv5AFONP8A1iwb2rIpu98eJDpPDPslAJPiBOeMPQU4pLSwUNPR4p
	DlHnLUc8FAdsMBevleZgB7+xV1I7O+mHKX7iM6Iy/JfprkFcUuvZvz1VmcnasTvOMJAgaxj6zf5
	eTHpRjJ
X-Received: by 2002:a05:620a:254f:b0:883:c768:200a with SMTP id af79cd13be357-8cdb5ab3617mr580862385a.32.1773426685412;
        Fri, 13 Mar 2026 11:31:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2152a41sm611787885a.43.2026.03.13.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:31:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17IB-00000007Lp5-3hF7;
	Fri, 13 Mar 2026 15:31:23 -0300
Date: Fri, 13 Mar 2026 15:31:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260313183123.GK1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-2-aneesh.kumar@kernel.org>

On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> 
> When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> VM file and stores a referenced struct file in the vIOMMU object, so
> later iommufd operations can safely resolve the owning VM.
> 
> This is preparatory plumbing for subsequent patches that bind TDI state
> to the associated KVM VM.
> 
> The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> EXPORT_SYMBOL_GPL so that iommu module can use that.

I'd want Sean to approve this..

But given we once discussed it is better to hold on to the file * than
the kvm as it leaks less kvm stuff I think this is the right approach.

>  #include <linux/types.h>
>  #include <linux/xarray.h>
> +#include <linux/file.h>
>  #include <uapi/linux/iommufd.h>
>  
>  struct device;
> @@ -58,6 +59,7 @@ struct iommufd_object {
>  	unsigned int id;
>  };
>  
> +struct kvm;

That is a weird place to put the forward declaration? How about at the
top of the file with the others?

> +/**
> + * define IOMMU_VIOMMU_KVM_FD - Flag indicating a valid KVM VM file descriptor
> + *
> + * Set this flag when allocating a viommu instance that should be associated
> + * with a specific KVM VM. If this flag is not provided,
> + * @iommu_viommu_alloc::kvm_vm_fd is ignored.
> + */
> +#define IOMMU_VIOMMU_KVM_FD	BIT(0)

BIT isn't used in this uapi header, lets not start.

Other cases are using an enum to group the flags

>  /**
>   * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
>   * @size: sizeof(struct iommu_viommu_alloc)
> - * @flags: Must be 0
> + * @flags: Supported flags (IOMMU_VIOMMU_KVM_FD)

So you can say 'see enum xyz' here

> @@ -1105,6 +1115,7 @@ struct iommu_viommu_alloc {
>  	__u32 data_len;
>  	__u32 __reserved;
>  	__aligned_u64 data_uptr;
> +	__s32 kvm_vm_fd;

Add padding to keep to 8 byte alignment


> @@ -5481,7 +5481,7 @@ bool file_is_kvm(struct file *file)
>  {
>  	return file && file->f_op == &kvm_vm_fops;
>  }
> -EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
> +EXPORT_SYMBOL_GPL(file_is_kvm);

Probably put this in its own patch 

Jason
