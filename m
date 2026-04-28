Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06F43E9D2
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380623; cv=none; b=N50WiDEEE9UwpkvtaGcCCF1pWjYw2Uqp92dYzWIqsnWL6qV3b2qlPs/5wKJ8FwQODWcsVJdvLnhVPYwumd5Y+k8LSeJFyHOxcRNygJP/lC49D2T1LJe5yl7MALAA9tXnkRUy4rLuevuGqAqF7mCS8PawLeZaz+Yzls8mcn8j8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380623; c=relaxed/simple;
	bh=CFt6SaX8lvBwsyPzjjPQPyUBGsOZKHipwWBBIQuAwpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbKhqPDX17AOdsWaX7fBPVyvZEWBWPltdGOh8BvxlK9VuvaPBTxoPv16svWr/XQB17pWaA0njJkzEIZYUbZckBTcyBMx0dq/JZS8uxZFYDcbH483Sjgu1fI/y15BKFt4pMGB0OhkJ/uwt07tL2SE0bQgsQXa4BnH31ArfWlAVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Tr1k85tK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Tr1k85tK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb38e86cf2so1028918785a.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 05:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777380619; x=1777985419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8t5Y74JK09wcmnesHru+6hwOpLCoWPkIfn+Q28jlzBo=;
        b=Tr1k85tKMGHYfw3Kl8PagEqJxqx7qaNfrlzjDPBYLM+4OuzAl6LUk52Nhl8oaaENo4
         7exJSA+021qZP8s+B/6CizSBukWCLHTZkJ6bhc1XOng/cZbRUzLNvGaffOnt3u0vvYKp
         +hIynTh3AumpIQrokUc8bNUONA7QRNuWVBxUvc/+CZyjAGhDWlDIXXcwR5+z6EZ4sQyc
         0+7dXZF42RzF304j+s0liQdMDCYtvm/iZcHUzv02Ntv/C8wyhLHRP8hRp50hmYd09lON
         1dlnQWxCQJpl30Mbz48qFIr9RWHbn0DHeo7x6M73Q3aSDCHxEK+VK9BX8PT0MGAL3wmC
         bedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380619; x=1777985419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t5Y74JK09wcmnesHru+6hwOpLCoWPkIfn+Q28jlzBo=;
        b=BMDRtu/SHz0pQM4mQwem3boqcH+2880jw0N9UB4ut/oaNr8hLOVezJ4dqhH7NuBi43
         hHgYbsHo0m9D7h7EwhiN4oHVJDeUaT3osKy0vjow3gg02UDamxInQ9psYLw1jOx5qKCY
         j5222n3gVzEz4lMcwaQ4wrsf4alKG4nruoXVXEjbYpW7xRD6CjGPmMqAcRJRIkYz/KI2
         2cYKdQGTQv1n+dmAC3o7PIN9yGLgiylmKlc8aQ4vq7rGU4Msb3WX7Cc7b5gHlZTxBlgN
         o65zBSgBjdMDoM6A/VR3svrmHB63SgfUG1hGmm3p0IwRuwkfM7EXs9GkgBSAVlOmOWA4
         rNNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WqK08fTGD2W0VfteTZOB7SEYFKPP/XjEGHFybcwhfmiQWr3T9nlPI4UgMiDC1F6vZxoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz4nlInfqKPbDj9do75lRdWfmyXfyX2sovySy7iQwwyitK29a
	p7HRRKFodRm7vyHYcVAEBUfSg21PT4nLtZi178sFnEv61wQ74rlPJ1qyigeUs9crns/fcw5dNfp
	2BpDrtLo=
X-Gm-Gg: AeBDieuTpEN+6HY719cNHaiPogx1oYL87lkbsBfQQttDKUHHyRwDyTXP6Z9odJpXMm7
	IeVV1OxxdlW1KudFsXHN7aZUYnAOQx4aE4tedIlIVnVM/f7+fU6wkuiLwafMBO1ePhjg7iAmwFb
	9NhpSotWdtajHNxl+8l7SAv09/BGdnn/XkFZi09BtwE0CLMCyERqq+sgDPNTQ2lGK+6NhaNQ/lI
	ryvKApwd8ipbyf56T/fzzm0yOnID5WOoh2qYhq+T/PF1kK3EiIuDFgf3R1V5+pbgT9xJG11d0zR
	3p3qJDw6pUC0WN7ZDvOOI6BhcVcKetnB3kL7BgjOev6skTMz8TMUFPgCbp2IQU5NtJN2DZGQXJl
	WmhzAe+XYNQMTN78MMBzHzgnn3R/5qPT6CQw57tqvPhlvsX1wwROfvYWPFl9148Kay3OSSvDlHz
	ysmAQZWXpcvhwe2w4BhrZC1MA0KewqksxjzB96gGQBP7v/vWHaLLQAukeujfG0+y1uh3iW2KGTh
	AXL8U25qBgJszGXW+V9oEFFLQI=
X-Received: by 2002:a05:620a:4688:b0:8ed:2b66:9eb2 with SMTP id af79cd13be357-8f7d734683dmr403211385a.15.1777380619112;
        Tue, 28 Apr 2026 05:50:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f7c51af6dbsm182444485a.20.2026.04.28.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:50:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHhtH-0000000AWMo-3Ut3;
	Tue, 28 Apr 2026 09:50:15 -0300
Date: Tue, 28 Apr 2026 09:50:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
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
Message-ID: <20260428125015.GB849557@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca>
 <yq5afr4f1egv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5afr4f1egv.fsf@kernel.org>

On Tue, Apr 28, 2026 at 05:31:04PM +0530, Aneesh Kumar K.V wrote:
> > I thought we were trying to get away from struct kvm?
> >
> > https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
> >
> > Ie this should be a 'struct file *kvm_fd'
> >
> > ?
> >
> > Though I am wondering how practical it is to do this at this moment :\
> >
> 
> Should we also switch 
> 
> modified   drivers/vfio/vfio.h
> @@ -22,8 +22,8 @@ struct vfio_device_file {
>  
>  	u8 access_granted;
>  	u32 devid; /* only valid when iommufd is valid */
> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> -	struct kvm *kvm;
> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> +	struct file *kvm_file;
>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
>  };
>  
> @@ -88,7 +88,7 @@ struct vfio_group {
>  #endif
>  	enum vfio_group_type		type;
>  	struct mutex			group_lock;
> -	struct kvm			*kvm;
> +	struct file			*kvm_file;
>  	struct file			*opened_file;
>  	struct blocking_notifier_head	notifier;
>  	struct iommufd_ctx		*iommufd;

Ideally, yes everything outside kvm should just use the struct file
and there should be quite narrow places where you do some kvm
operation on it.
 
> ie,
> KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
> KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
> and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)
> 
> > Maybe ask Paolo how his series is going?

I thought the above is what Paolo's series was going after?

Jason
