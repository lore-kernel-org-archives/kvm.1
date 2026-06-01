Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711753A7F45
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321406; cv=none; b=N1yNbNknSQ+vtQHEgm1S+ibbS66OzGJKgW2+AqxZtYRHjddmpAHUfopA0BwSUGaD3MIyG3vkt1l7jGdITyUzJ3ACJNpuGSHWd8iipOVVYal/phEJan3hLIkLSt243sHnFZO5jLn4NBbKS+pn1dlK/p+Sz5B4snPjXk6zPRC/r/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321406; c=relaxed/simple;
	bh=6MVl9gF6JoewXnXcEZQ4a8O7c6chwzYhLEtrcH4ruBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWbk6mukG+nlX94iiAv/aUGhfcqt5HxdXBnrLzRIkM+OkvyD1/oqFdwzh5ARqFpGoZ2d24eLWKXdSHNbJ6Pe5pPHZKC7DZER0NkL/g4Q5hRHMBb7kpogAU5MukG/PwIncmDNjqGrrEfQgpFgom77aqcpfRR2tNRR/fRBSjpZbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R95N/46G; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R95N/46G"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ccef25789fso18319326d6.3
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780321404; x=1780926204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
        b=R95N/46Gokjw7bTbFd+PO3hc2CcDxa5E0d+/PfVzT6iL+FHDxyWVcxvv8E6dTsHgvi
         7XNWJTNAH6CBt8KposFqR6yh4qgZjZYsLv7t5sQUaT/YJ20TNmU9wjdLRz94xAx2JfdA
         p5YWq8iSe4V8KXM0cMrflrrNZ69dIVl008/mSXja/fgBvppflFXMJV3qcfWx+OrF7srC
         9M7u0JRCir5yweshjcivl9jPFl6fjrW7F/wGjOjYnc9wwQ+M/kEN3erEqGsUspRbDfhU
         bCZFkqcs0p4RiqyBIMztATCnGuYAw3KJaRefKbyHGq+Bn4SoQpY5Tb0IVrLKdsr398aY
         wgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321404; x=1780926204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
        b=C0mYbM8nMvlp+Uu8h4UUdeMwVpiFS4Kjh8YoDdFMnPROU84254k5XXvofzLFwMOPm1
         dvPJOKHx1Hj3o1gRIdUEqy10QK0rRaOVA1nvhr1uDANRi45zSvU6ZxA3iHmKt8+uWw0C
         xNAb1G8hT+zATQUReBpLD9uWlhdgRJ2ekIBKE3RITN+Lr6VN7+utN72vgXgfBVxc/uKU
         26Kd6RQSfInVqq6rTeLd6+nE1+Jt+N2esovFB2QOv+Ih6++L1pv7No7Ol76USLxTgt5n
         itm+rnDay5ph9evf5Oz5Omjlcro+UYR0rZxRegIT9LlZtlPMy9SVfkzkHKNa3aIfn4Tz
         cEUg==
X-Forwarded-Encrypted: i=1; AFNElJ9Dgelvux4vAXco0zSqKhwY+RQbw2nEv+O/eTLKFBM7kkDEu2TFON3rHijU0oa4+Syi/vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznyezpwqA6DrwqRYZ95R1CThVyEdHN4PVJiUTjvL/zdqisKNlB
	i7AsJSJ/pkkAFRJEsHbfz/NZUnZe6LUkwdmgNXxZXEeu3VxvQ7XAhYyaGetCSrKC+jg=
X-Gm-Gg: Acq92OFIEMFpvIldG8BfGskunQDyMd7Ue2UNZujq/THEO/6vTZrJMyxWCv8z75CyRgz
	JSxBGTKfOBdDPQpvQVBFHvt+UlZLYmQdMqsRrqfRk+a6HcYuPRnkGVwDEihBFGn2vSEhDpSQUQ5
	Ysas1JuroWReQ38nSIlCyDgTtA9dzLCricPRfaeKbJC97wRkjIPSu94bZRh9GC5JBXkfrhJywdU
	0mHyEpc+bHF+gUkCI2Go1mx86olZwHkiNt9n1mGfSHfIInMTGVjV3W4DDx3PVSTT3FtctOFE7EG
	fNUGDOODWys287VkUE8DVswvKBVJRGvgoBaV3xNIgEE+lTCFr9jBYOwKXVelWiAD8rPwo2cexvu
	5RbJ2lBwuLprG3HbhOJUkWoG5RyUWcx/vD5Jm9U/UArMXZsVOLBGYOCkguTwXDyQuOtL9VnJPLQ
	7sby/9HNtNpKik0fzQ6R7VuB0/C0etmAoL/IQAr7qVdsF9nt2vpQ0faY4sRGbsSmV3ENHWBTYnu
	lWlZJGUtTzMoqK0CsVGNmxHHYg=
X-Received: by 2002:a05:6214:2e41:b0:8cb:fd76:e904 with SMTP id 6a1803df08f44-8ccefd62159mr193200966d6.17.1780321404292;
        Mon, 01 Jun 2026 06:43:24 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042373sm94107096d6.9.2026.06.01.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU2vK-00000001iEk-2KA6;
	Mon, 01 Jun 2026 10:43:22 -0300
Date: Mon, 1 Jun 2026 10:43:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260601134322.GY2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>

On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > +/**
> > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > + * @domain: IOMMU domain to query
> > > + * @iova: IO virtual address to translate
> > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > + *
> > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > + * PTE mapping at @iova through @mapped_length.
> > > + *
> > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > + */
> > When introducing the new function I would like to fix this 0 error as
> > well, it should return PHYS_MAX for error
> 
> Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> all use a return value of 0 as an invalid state, so 0 is used as the
> representation of an invalid state to maintain compatibility.

I know, but this bad choice has already caused bugs so if we are
changing everything I would prefer we fix it.

> > > +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> > > +				       dma_addr_t iova,
> > > +				       size_t *mapped_length)
> > >   {
> > > +	if (mapped_length)
> > > +		*mapped_length = 0;
> > > +
> > >   	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> > >   		return iova;
> > >   	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> > >   		return 0;
> > Any domain that doesn't have an op should fail, blocked is one example
> 
> In accordance with the implementation of iommu_iova_to_phys, it returns a
> phy value of 0 in invalid states.

Detect the invalid states by looking at ops not domain->type

> > I suggest you approach the patch plan a little differently, the first
> > patches should implement the new function and an iommput
> > implementation
> > 
> > Arrange things so the normal iova_to_phys calls the new function if it
> > is available and discards the length.
> > 
> > Then convert callers that can take advantage of it. Have the fallback
> > path also compute the length by iterating internally.
> > 
> > Finally one patch per driver implementing the new op, this could even
> > be a second series.
> > 
> > Don't remove iova_to_phys(), it is fine for things that don't need the
> > length.
> 
> Does this mean retaining the iommu_iova_to_phys implementation but
> implementing it through domain->ops->iova_to_phys_length (mapped_length is
> NULL)?

Yes

Jason
