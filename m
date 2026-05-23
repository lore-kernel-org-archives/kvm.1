Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3325B093
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779542516; cv=none; b=jO18U80UyvGHc53kNWvnLB6gE0exEILUkWkYVVs/smAcGamtjtQa6NsDmjir25v3umlc2rO3UUk+gMpma1JP/AEQVEhv0DaO2Sz+/Nhq4oYYtQRmaiy9f0B0EqKY0w2bprXJdOUVILcwk8KfEnTHpCUGD8R6/keXrEsLr7J2GAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779542516; c=relaxed/simple;
	bh=mVpavoyb7l6uQQyd2XffEa1v5GKCirvC2OQyuHu/WoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2QwCSaXyfDFo/6FeXSRA3Eyczl9cwtzPYxOUo4KOgchVizxOA0dBUEg3/cyoEX3gT0D2JaUST2ZZfyHdghoqpLJLUI1wGmagH39Pus3kdfrYSlfsQTMiEvqFbFeGUbGR74uR/GKYJsA9uTZ0npcYj6XjdMEEi2V56FCgNf9RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xxg3tiqh; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xxg3tiqh"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-514ae601e01so85785691cf.1
        for <kvm@vger.kernel.org>; Sat, 23 May 2026 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779542512; x=1780147312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRo5ik7HMyePlqAnBOmFqKyPpDT1cZy71Z1vsu5Dc6A=;
        b=Xxg3tiqh/o10p9grWN8xlGLTCHbiYwdthKIAvtUw91N4QiOhp8Uk3rEIJaIO5Q1A+K
         F2TCrF3UD6rWquLJ0WrDEcuywqZDsO4cdlGpI74HWSVdfu2cKKScAkaH5WUujM6o2VTO
         ujZOYjmgyvP70L50HRgi8O6SyGJEAKyowIdh1wRV/+edUCXFLdG8JVanS2/dIBarcPbi
         JUn0ArbqRfl0TBsfk1EBYA1zZqKPXR3VGW3QUkUp4f3399sPWRudX5vK51lizA0KL6Yz
         2WUE45uUISCAr3HJn2PsmypjLVWu05r7NVdrOuCXp29PulLUOFGh9/zpcZYz0tProgDd
         vINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779542512; x=1780147312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRo5ik7HMyePlqAnBOmFqKyPpDT1cZy71Z1vsu5Dc6A=;
        b=O8pgGRAULcnnByZS7SVliOANocu4KmMpCXYC9mR3KoIDJKWJwV9sKccxwfeu0D+qVl
         G/mf8S8feCsndf2rRHa+qGybNqE0ePAeqnU00G258yPuHVgDEB7gNeXgy9M9qRGPGbjy
         cChjO7w/3zShc/16BJAzRx1w93/Rz8OFL7Vd6kDw7LGpqSr2l8AIt9i1Ug6PvRtsM3xS
         W/EVaz2EU9acXGMoAigomQeIgBRqA504Cd8osfuYnbAflaD8Y0T6DUbQprF9Urxl4Ao8
         /8OpTGnFt0k6T/YsRw3+NCEDJUULrvf0fq8f75d2RuuPzcH+2hvIJZjYrDrfflJwiFmQ
         1r7w==
X-Forwarded-Encrypted: i=1; AFNElJ9D7sT8IPFz6PnBLFiOpqN1Zewx7Rbjv7LJnP6sjvHBi+dbfXbgk3yOCrZH/ChmupDqqUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLDpsG8a/xd+ZEG3RSDjLSiBpT8YDbGopP0c60D3GO60PZfB62
	yxiJodrZcV+U4uVPjbVbHSX5rHAzgp2XHXikKOTmCuKAUIAEhIQT8Q8ef1D+3r/EO0I=
X-Gm-Gg: Acq92OG/ingle0+JWsbpr+tCCv9t9vKeIvYkthM2JBG9auFSGsC7y8e/ibqyANfQ/OS
	S6l77/AVivC+OheIaELXEOWqMCprJn+vvnLmGf8jqLv6wzSxCxQBmmCZDP/gT6wDAcOGgQAFu1a
	m8tjOVBSSgXnICVZw5eM4x57bPPfLOZGGBapgNp1UwcOFSNtraxiJLpBEZzoYv2uWZgYPZfPk6a
	jRVzK4kjPblqM4zhyM1fuVNMlHcyhyA7gfGvCpqDnx2B/wntsDcb6Cb64xWuLz0nU3W16bztaUS
	jxw+H+LL5VkBC2IP1u7B09u1qa/TyDwELF3cZn6SaQgNOitVCnkClmsy/exUGzgV3xVJZF52xgL
	kJkocJ2zh35r6DOcQACPdSQfMBvEtasad+RLtqglmYDXg+a21B9aLOsIqlCUn7zGBX/oRzm4dU8
	hzWN2e4B2eAuxU1u2IjaVSKnBOsJVzmymnK34GdFwvTA+IrPFmi/MBlyXrOrTLE0Fe7KMbxerd6
	zF/12v9wsibXX4G
X-Received: by 2002:a05:622a:4cca:b0:50b:29a6:8696 with SMTP id d75a77b69052e-516d429b5e5mr107369911cf.7.1779542512416;
        Sat, 23 May 2026 06:21:52 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cb9650sm39132141cf.22.2026.05.23.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 06:21:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQmIY-00000006Gp4-3JkH;
	Sat, 23 May 2026 10:21:50 -0300
Date: Sat, 23 May 2026 10:21:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>
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
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to
 iommufd_device
Message-ID: <20260523132150.GF7702@ziepe.ca>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-2-aneesh.kumar@kernel.org>
 <20260427135906.GB740385@ziepe.ca>
 <yq5afr4f1egv.fsf@kernel.org>
 <20260428125015.GB849557@ziepe.ca>
 <yq5atsstzxe9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5atsstzxe9.fsf@kernel.org>

On Wed, Apr 29, 2026 at 07:22:46PM +0530, Aneesh Kumar K.V wrote:
> 
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Apr 28, 2026 at 05:31:04PM +0530, Aneesh Kumar K.V wrote:
> >> > I thought we were trying to get away from struct kvm?
> >> >
> >> > https://lore.kernel.org/all/adf29Rn7q9Db0hxc@google.com/
> >> >
> >> > Ie this should be a 'struct file *kvm_fd'
> >> >
> >> > ?
> >> >
> >> > Though I am wondering how practical it is to do this at this moment :\
> >> >
> >> 
> >> Should we also switch 
> >> 
> >> modified   drivers/vfio/vfio.h
> >> @@ -22,8 +22,8 @@ struct vfio_device_file {
> >>  
> >>  	u8 access_granted;
> >>  	u32 devid; /* only valid when iommufd is valid */
> >> -	spinlock_t kvm_ref_lock; /* protect kvm field */
> >> -	struct kvm *kvm;
> >> +	spinlock_t kvm_ref_lock; /* protect kvm_file */
> >> +	struct file *kvm_file;
> >>  	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
> >>  };
> >>  
> >> @@ -88,7 +88,7 @@ struct vfio_group {
> >>  #endif
> >>  	enum vfio_group_type		type;
> >>  	struct mutex			group_lock;
> >> -	struct kvm			*kvm;
> >> +	struct file			*kvm_file;
> >>  	struct file			*opened_file;
> >>  	struct blocking_notifier_head	notifier;
> >>  	struct iommufd_ctx		*iommufd;
> >
> > Ideally, yes everything outside kvm should just use the struct file
> > and there should be quite narrow places where you do some kvm
> > operation on it.
> >  
> >> ie,
> >> KVM_CREATE_DEVICE with KVM_DEV_TYPE_VFIO still use kvm->users_count,
> >> KVM_DEV_VFIO_FILE_ADD -> will switch to get_file(kvm->_file);
> >> and VFIO_DEVICE_BIND_IOMMUFD -> will switch to get_file(df->kvm_file)
> >> 
> >> > Maybe ask Paolo how his series is going?
> >
> > I thought the above is what Paolo's series was going after?
> >
> 
> Hi Paolo,
> 
> Could you please take a look at this? I’ve tried to document the
> reference count details and hope I’ve captured everything correctly, but
> I’d appreciate your review to make sure I haven’t missed anything.

Reminder?

Jason
