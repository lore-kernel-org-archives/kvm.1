Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3D3E5568
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 19:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921606; cv=none; b=LXceaCniMwYdwjcsmoyoAP2hhmEQPur73tmlu3+/VNMoZhcheymCL3Jb6QJLB0CZJvu/PZu3MOhpgqreUCGvKXVDXxdtUKLakeDhxNhvZ1f7CcHUu8h7kuVj2mFvxrfbKXFGyShSaABglLWvAqOOsZ31PBoESHAUYWB/crho/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921606; c=relaxed/simple;
	bh=xSEaTTVUVlwKE9SMgvY/jxSjdT4lw2aY23m0oR9BIGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIrvb52DHqy5m31lmRzLSW44GGpd6YFM6xwPMQSTxyMr8usOSKA9h2Kq/N+7cqhoL4d7JHfD/1RH4JOGQ9iIgr+I/fESRfZq8jX2zQzJ/54XuCk/bNhKJQeVf49MbdE9GuQLVDM9Y4Pn8RdgQxORlHl1oyuVjpvJw0zJOtn2sjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJlZuLFF; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJlZuLFF"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso295ad.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 12:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777921604; x=1778526404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6F35o67JJ+BgMKb1KLJGbh+gKAaYW0m1XJ+eMW24qM=;
        b=EJlZuLFFdUNKnf+E3u8Qb8uhuOdQNSGqrPoqurdqyZsZ1Q4FQL6JlTk5SAbVZkuQ4O
         74Bk5BQTstvd8l3FKxIBL1Vhc+C6tGcTEHXbp4seZPKeZ5MAORlCmhxv8RJOcjCdM3tR
         qjfu4CsUjZRVcKArbbbCjVRWjCAjzpITsgQDgA7Aui0AQ5faAt4AItcl4lYx0VUMlFgA
         5q/jLmpdIpEckXvEB7PapgZaktnve5ATX9chcyX9JuCMwS+4pZ3XoHfNx1kLCvVJBCZT
         ITQh3bGQxQGRDxETIiUS3HEsm08uvpFmUKkKhZBbsRKacJ4WcJTlasPv39UQxtNIkmeJ
         LSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777921604; x=1778526404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6F35o67JJ+BgMKb1KLJGbh+gKAaYW0m1XJ+eMW24qM=;
        b=giIU+ymgu0MgD5kLBn9959meuaZ+4sE3nQHR4A45zHNHts+8Mf6HIzq0UICIzaCRjC
         eqE0qcbG1oMXpnZ3eun00abpX9VfxqGS/BCaKM4PDDStdP89WkSayKZMseepMrMlmH1t
         3SsXWerwEP0bcEoisF90RjKYVN01O6S+hSpSfAjtFneszMV334TZgs9lWsEuxF2fydd5
         q56Vu6UfjlTP3fN+cqGuFCrq6ucQ+OcBPh+9DeEJLJalxJcK2D4a/x5ZhikeGZ2s0DD1
         km0BZdoiqwO9V7VxC4Vp/K5z0tiqEsRsUAX8f1PvhVzEeao2oiBe0yan/hifEnIbKtkN
         7d7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9hiOnZlzgPJhnvh3MMSKhZFvoXFM4ToL8zZjrLflARd8UPFuA38NIEdAKvWUga7PwhIYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWl3FFhaRct1lbK5/sdarikiarea9xKi0Kct2PHSopt4X2Fx8
	YnaDeMn2ORZ2KPXkpTQhbqHqilELm4GL12rYOJzbKIzb/vDRb5SSFUh/9OHChkXhZw==
X-Gm-Gg: AeBDieuCCFLx8MIbiNsIMs7zjzC0htdMwuMNtrRkY2lGAy20BdbysLG9SmcuT+JXMKg
	R41OVefIG4+J55g7FCdPfJ98PKEbzN/WEVuoUA86rQJ9YWonypBhvwGBmXjOC3tfustF4cGF2ke
	Funlr/rU/kr5IirCUntHAspsL9nPGZW1WXl+1dCUbJbjsPRQAiIzIgYaIOONPn9iPq/gSrsJOt3
	V5hU7rxiUfVRrd9mEH+IpU+dIPVplHvOnKkZoWHZIDyNrkpq9hc060XXzr9rAu7CroeUOBVOE96
	63u3+SKhk5XCdDr/kUK9fNy8aidfRvA3kcGUcyGm9lxT0k/mCjh8vp9YSw00Gsgc1dCbMaqyvMW
	uqEq4Rdk6PwBnhG+0a/HOHlW9sj7TBFlJrkxgxGZy/3p/pT6uYBUjU9/BhmcCLd01UxYGdSQbM4
	h4QFplX7jarJYNfraOK/Zu2cCSHI7Max7dpy+Oz6K8LFDLJkkCq7OzqFx2Z4iR9dblCSBtHUAxM
	V7DTHpgGT4=
X-Received: by 2002:a17:902:f645:b0:2b9:e831:5e5c with SMTP id d9443c01a7336-2ba4f6fc12dmr829715ad.4.1777921603289;
        Mon, 04 May 2026 12:06:43 -0700 (PDT)
Received: from google.com (195.236.83.34.bc.googleusercontent.com. [34.83.236.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa8bd20sm114957035ad.14.2026.05.04.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:06:42 -0700 (PDT)
Date: Mon, 4 May 2026 19:06:37 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <afjnVR0OCGMN0XNf@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <afUscSeXKnNAJ0ZF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUscSeXKnNAJ0ZF@google.com>

On Fri, May 01, 2026 at 10:42:57PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
>
>Can you make this comment more specific about what is being preserved?
>Saying it preserves a device is vague and maybe even misleading. It's
>more about  about preserving a device's attachment to a specific domain
>correct?

There is attachment ID, but the preservation of device can have IOMMU
driver specific things, so in core I mostly mention "preseve device
specific state". In later patches in this series, we save PASID table
using the same callback. I will add more details in the commit message.
>
>> by the IOMMU drivers that support preservation of devices that have
>> their IOMMU domains preserved. During device preservation the state of
>> the associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index f71f14518248..765d042e22e3 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>
>> +static struct iommu_device_ser *alloc_iommu_device_ser(struct iommu_flb_obj *flb)
>
>It is unforunate that struct iommu_device_ser has nothing to do with
>struct iommu_device. The former represents an a PCI device, while the
>latter represents an IOMMU.

Yes, I went through various iterations of trying to name it in a
different way but keeping the "iommu_" prefix and the "device" state
naturally falls into this. Not sure if iommu_pci_device_ser is suitable?
>
>> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
>> index 6019cfc27428..279c7ab04f09 100644
>> --- a/include/linux/iommu-liveupdate.h
>> +++ b/include/linux/iommu-liveupdate.h
>
>>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>>  void iommu_domain_unpreserve(struct iommu_domain *domain);
>> +int iommu_preserve_device(struct iommu_domain *domain,
>> +			  struct device *dev, u64 *preserved_state);
>> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
>
>The naming scheme is inconsistent... Maybe it can be:
>
>  iommu_preserve_domain()
>  iommu_unpreserve_domain()
>  iommu_preserve_device() or iommu_preserve_device_attachment()
>  iommu_unpreserve_device() or iommu_unpreserve_device_attachment()

Agreed, but I am trying to follow the already existing naming scheme
for domains that is used for APIs in iommu.c

iommu_domain_free()
iommu_domain_init()
iommu_domain_preserve()

But I think this is rare, I will update to this as you mentioned above:

iommu_preserve_domain()
iommu_unpreserve_domain()
iommu_preserve_device()
iommu_unpreserve_device()
>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3853a3946733..1c424b32c5fc 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
>> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
>> +#endif
>
>Maybe we can make these names a little more specific:
>
>  preserve_device_attachment()
>  unpreserve_device_attachment()

Attachment is too specific. See my comment above.
>  preserve_iommu()
>  unpreserve_iommu()

These are part of iommu_ops and having preserve_iommu() instead of
preserve() is redundant I think. Note ops like capable(), hw_info() in
the same struct.
>
>?
