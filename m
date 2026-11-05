Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902869;
	b=H7WnNtEl/FOhXCC8/SOtwrXI8vGqSCUivcksSrRuZNaBtB8MoUq84PNv9KOgyam7CMF7
	 Bc8jKHsyVJto+6LYX0kHOvkb2PW/zwr+3HGxK9wzOR6bYcRJy1gMVlHCAcuUhMUuvj4ln
	 If3BzNkpxEiAP2iaI1GaL5/6BmzpRQtp8oG3hJtNBhHFfgRrXrVIEK9VoktxsOVVGqnuZ
	 tEo1rqoOG4tifTWsg8VO2wjWluwVJz3ZYjblEjBdc4XXdOHdaq1mAtBQyPrbNOeOvvbQi
	 9jFb09gZ8CHzG5+4ekb/xq9Y/D8Sx+n4hLKcCzo1Dhl4tfbXvPt0d5XlO1jVfeQ0MNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
	b=z6JSc11jTMe1x4fQI5+aA6lQfoGL/5crka+1NfNUDQ0EJFNoXapxu8PRiMKxqhlrNCGV
	 IJDJAoybj6T2gS7hvvdlnnE9yJdJJdqWMwWXW7C/TkHoopm4VfP5RFPLC4P65uOkng7EK
	 ZHuWQHqQVpzhBh0tJ4PJqyGfEwBkEpVmyr5i6drbD+meoD5VF8mv+GJ3TTqSTmcjp0GWK
	 z8KaWEk5xA9Z3uoU6U9aH3jW+VIQ3vvr5jyKv+d0zMF5O9Gk8EwsU7VGutMXhFmQsGrPz
	 HnSHmHZagE9O3DvzGk9N3s3IsLf53B9XZnWUGOIZD+j5H5rDBgM/I5j4Aw9inDTb37g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ire535yI;
	arc=none smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E2606A32E
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 18:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C30E2606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ire535yI
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c3b6e8225dso1406163137.2
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 10:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793902867; x=1794507667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=ire535yI4zQnLBCiIAurI9xJYsUwvc7Sip6NA8XOlKY8BmMk6D3rtdebYXDlLnb+ZP
         aEGddu2E8npnG7M4/+0EgOwpXWB5SDN4kgpIxamJ2Uy2NDnYvTWgObc3vELT08wtz/xF
         3xeWBALg5snzMuspxTmvkiNsDCe5u5k7BqFrm+FvEdrW+9g4YmpiWSs7IIKmBLSXprfT
         B76tw8MYCHnKMka4LW2C5MZT3rGdLaEtriq6m+jRXouhgJYmsUSLWxCwDQA/9gbJdM1n
         NRjQE5XtPnpZDvStPl0FX//pa+XdJ0rYFA3eynPysioKRTlm1rN1Vx2zxk6ZZNMhX2vJ
         yV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902867; x=1794507667;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jskhMrN6L8/ity8GI6Per+nZ8wI0zDQt0quVEnFZ+Iw=;
        b=KCNgIdbciDQMx4Q4xKqViV0uaTlCUHra2z4I0eQlxFhbfPnEZoJ5kBCLYmhjf+t9ML
         MePrJbO88UE1ULhCNMCRT67zhp9y0mE67Aso3R4R/qTl4IOsfIa+tWvmQHPccvDvSVq0
         N0uoEk1zqChUeg5SHX6s6ao4yazuZI/K8fqHrBxhDMkEBFHUk93MWWpx1wc2GH3HrVyp
         G7/VJW07KamQ89y9zKZumPjVKVIUB5w1ArExxVOX2G4PAuC/BdzhLyXB0m24SFiOQ0It
         JqIXGF+XyYfukmsSFVFQaWwAHoBmRlDFLvoJnZoQnrJlkAKHCkbC3R09iQx6upyNipNo
         yIsw==
X-Forwarded-Encrypted: i=1; AKwUvByHGFaIk1IttCbkmHRH2MzeYRxZQHmZbFAQ5EWzgIdgHGsyqZ9JJVR5TOagq+3M4o6w1UM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+CVtF6FR4/oL2BNt7V1xRw7G0zPoicb64nBpiRXshtTK4QJfH7
	kHsho/AwH3KEyPncyxUpFJBDGZSARmAhzceEbFWZYpp5H9vMGt8R6siyz68zxWjuvxg=
X-Gm-Gg: AYBFou0jKXxfXJmYtA9dd/JKbZRimdjwcCngfSMC9jBjz6gtNPDLlblTgDpvn1bgRgx
	HLRRHTM388Oq4zy4qm0i9f9kAHDKTZyxuhGLaIVVGF5Szf+NBh0NjdWAoW/uxfN7cvtVaFgG7Lp
	6t1zbAiXIkQOXqRJbabKQ3OjckVTX1DH2v9xBTPs8nXK9Ft/GfD0nICEeRTKGcU/snvEVW1Tuw5
	Ne1nZlnPF5EYAU5neY2HAYvTnly0ciKlvHY6oeeoW0mzNidRP8dzXzaBBdNfp+ZeD9ovYdWRXy1
	KR8PGF+bPyWWr7Fo9yL+ptLwcjxXm4Umi+ZkJAJSS2f3w+6QD0D5+/qo9TUu3DfeGsR4UjitSJ4
	QhNwEUxqRBpNg25vCaQB9KMhwbucqU+rq2hYo4lH4Mmbm3IFqZlnMlPExi3SsjHbwwaR2egnMeg
	mbZmc4yit+ALBWT2MjohcnD0jgHrhpOc9Mj76rMiGynpK7gR5NFOAoB3ip8EYU22BRJ78aqY1/0
	vh2JsKUfcx9R5AyXLup+Pr/Poslai8DccdrhNwjBqnwc4ankinVCQClkLrdk0GiqppS1d1TEhqk
	uucVE8Qkm3CXnNPF29G6B1eOvbN7sVLTi9qvT4jrSSust99bc5EDJ9I5v+F6M4xNFvw7KvHcnTF
	BP9/gnl7U8Q==
X-Received: by 2002:a05:6102:5706:b0:7cc:2712:caf2 with SMTP id ada2fe7eead31-7d2a1628b19mr348440137.23.1793902867469;
        Thu, 05 Nov 2026 10:21:07 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm5242293241.12.2026.11.05.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:21:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xP25C-00000003LsF-0vAz;
	Thu, 05 Nov 2026 14:21:06 -0400
Date: Thu, 5 Nov 2026 14:21:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261105182106.GD663069@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
 <20261104193139.GB3889730@ziepe.ca>
 <yq5afqxf97a1.fsf@kernel.org>
 <auzAivzpzSUHjEQj@nvidia.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auzAivzpzSUHjEQj@nvidia.com>

On Thu, Nov 05, 2026 at 09:44:42AM -0800, Nicolin Chen wrote:
> On Thu, Nov 05, 2026 at 10:58:06AM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> > >> By dropping the nesting parent from VIOMMU, it just simplifies the
> > >> attachment to an S1 paging hwpt, right?
> > >
> > > Yes.
> > >
> > > The VMM must always maintain a S1 paging attachment that is the
> > > identity map of the VM on all devices, same action as when there is no
> > > viommu.
> > >
> > 
> > I am currently creating an S2 paging attachment. This results in a
> > configuration with S1 disabled and S2 enabled, which is used by all
> > untrusted devices.
> 
> For validation, that would work. Yet "no viommu" should would be S1
> paging, i.e. hwpt allocated without IOMMU_HWPT_ALLOC_NEST_PARENT.

It doesn't matter, consistently using a single S2 for everything is
probably better..

The VMM should try to minimize the number of hwpts involved, ideally
just one per NUMA

Jason
