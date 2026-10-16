Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06154D17AA
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162715; cv=none; b=la6Wr6ZK2XQi4C/o52Y6hj4Ob0mf7jA8Un0DWl8UxpEc5RFdPI3ab+06szA7ogKdOtVH55wx0OPIIa0O5E3t1OC3N6NNfGoRABYVRM7vo5rHIhD52h7YCMPA5KAG1YoCc90ymUc32uW3GZRUPtjERLqdHDbNgwscGadVXNo0ef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162715; c=relaxed/simple;
	bh=mTMdRDasmuA/EDAmwz9LCUnoHW7nOhtRiIxjXAgYEZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5n3cas1ep8oIvtz4nUEYJbjqY7G5HzBcWVOIam1c4ZBs+XO59FcWzwPZhi+cwQvCuYX58oEUEUPRgtcbEYNZqyih7Cg4xJJsbSpYtTpeK4wm320rO0FNgXZ3Yqdqn2sWKsddsIm4RuqC2H25XGq8YTYvZT8Iqslt/6JV2zTdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f6XH/Tne; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f6XH/Tne"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5351e6a2230so58049241cf.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792162712; x=1792767512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kgwhKXvrsbFVEHtBB9HsyIrs9QabB8/6eZ9haqu9k4=;
        b=f6XH/TneIg1GeUlGm5hqkxJlh0bVk/ERdxoJsT3M10i3E8o/E/xSI500gAZZ8xWyBw
         Y/P8R1CexisHx3rKpY9dV/008tBWL+RLJ4N79CR2NXhcqmMO+TEjryIOa1e6qZWEE+02
         WGzCWKLJpkJIFVXow3BvalYICWmyqk+3+lh2q6w8arZtL54T5hR2iFWpcCVgpHmmBEET
         bFEG4CNo+h1GtqlswzQ5L+MzMSRVDCcgOfaMqWxZVDSzujNxpoZqu4xqPAkejml1OzyX
         VVvJTKbZp/8zgI6fTxGdh0uAj+EZlALRaqo6mVUBZG5wf+uujL3X6Zfb+4REMexGtx5z
         gfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162712; x=1792767512;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kgwhKXvrsbFVEHtBB9HsyIrs9QabB8/6eZ9haqu9k4=;
        b=nNVc/63luHGny+jk8o+Mlw7twJhlrhtSLAzQOtxiUZ9sF5fg39oxrclFMUGvrqbMsG
         cwPYCk7kJWWES6v2ILg9ROwt4Q2+MTDKLti+hDJOJPFb9NPSlX/tRwaz/vUQxWf3PktW
         ZdtDZWLHqf+MYugdOyAHommhGxfERbuozqaWX6JJy+hETdAOZyZHKIGl2efYh6M4LzQp
         zzQ0K5Er2AXNZJJPhPMam/o1kbmdTuHXC0Jq6axejYywvCngsTDo46SlSscEbeXrr3Rw
         fT095D4xMYt3laq0BVvevUUNlEvvG46Tbbo2FNSELtcFPWN9rbTJtX3oQ550FEXBnpYa
         ZzOg==
X-Forwarded-Encrypted: i=1; AKwUvBzPnx+pOYeF92wrpqO82VmvHVHVOYM+duplwFR2mX17sBZGKEnMKaL6/zGPvzsdbtMQVRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEHOuTq0Xmh9IchwWZxB24UXhuc8cMWSv6pggciweey6rKV1Xx
	6JP9nwL58rlZGQTy9XauR6BwWs8/lPm5YyKqeI7tY0oxg79wGwW2yXuABxTNc+8tt/0=
X-Gm-Gg: AYBFou3/e3NZwGNlk9Np25W4gJo+RrG2CDaswHQ4zbUVSAP/OBsuq3Bdp9FsF5Yx22F
	BJ0UNv2BFngDofdmCJAc1BoHfxBDEnDw8WropoYwyzGmHaKgdJSMLdTVGgdq7GwGl9O2zXVPiaL
	Sk/e5W4PefTknXerWHasBJHo+X9JQdSbOC5RvaB3hhNS2CGGX1tx2rZVpkkAs3L4IzLuvT8jWon
	X32dzhPqLz0q7ZfBNKLhbEr1js+1TeU7BNHwxmgHIIYxc0K4knPQai2RjmcHhr0Si41sUjwSeJ0
	zpafrDFnIZO+HiaO60fbOraDb5zq1P57nFScb9YVF5nfbqzK6AnQugMuoROpf1VfEGvtIysOUqQ
	WU9ytQYkTEMw8xGzb7rZSQ975JD9OPylmk2SGw4+dwQaKrnXjQiUma10s4+Fx/hitlKDTzICrxF
	8DXVpDKzqwmw7juPn5eI+/pMhRvf2hm6SMNIf4TbsJLM0zUckiwaus0inwe/7VmroZr0SiNpbAA
	dSFIjgXhIVDhq2iEYa25H69vQuz5qthdRBqQx/ZAIOEW5pTfjZth0ib
X-Received: by 2002:a05:622a:2b06:b0:533:920d:7bf8 with SMTP id d75a77b69052e-5359fae3efdmr392482121cf.24.1792162712412;
        Fri, 16 Oct 2026 07:58:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362aa19fefsm24355711cf.23.2026.10.16.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:58:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xHjOA-00000001tOb-2Mjk;
	Fri, 16 Oct 2026 11:58:30 -0300
Date: Fri, 16 Oct 2026 11:58:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"Gao, Chao" <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] coco/tdx-host: Initialize trusted DMA on all
 capable IOMMUs
Message-ID: <20261016145830.GA448730@ziepe.ca>
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-5-baolu.lu@linux.intel.com>
 <atCPY6LzHd4y0Ywh@yilunxu-OptiPlex-7050>
 <20261015173707.GV14213@ziepe.ca>
 <5ca5f1c4-4c3c-47f1-b79c-c1fe06b20ee4@linux.intel.com>
 <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4836E2CB05E1448BB42047458C9B2@CO1PR11MB4836.namprd11.prod.outlook.com>

On Fri, Oct 16, 2026 at 07:17:31AM +0000, Tian, Kevin wrote:
> +Aneesh.
> 
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Friday, October 16, 2026 3:03 PM
> > 
> > On 10/16/2026 1:37 AM, Jason Gunthorpe wrote:
> > > On Thu, Oct 15, 2026 at 04:31:31PM +0800, Xu Yilun wrote:
> > >
> > >> An alternative could be, bringing up one IOMMU when an associated
> > >> device requests link encryption. Then a no-tdx-support iommu fails the
> > >> encryption request naturally.
> > > That is what ARM is planning to do. I think it is reasonable to
> > > trigger creation of the secure iommu when the TSM is connected to TDX.
> > >
> > > Fail connect if the iommu could not be created.
> > 
> > Yes, agreed. The Intel iommu driver could use per-device interfaces,
> > just as ARM is planning. There are some differences, though.
> > 
> > ARM's interaction with the iommu driver in viommu_init() appears to
> > consist of two steps:
> > 
> >   - arm_smmu_get_realm_params(dev, &params): get and validate the
> >     physical iommu information from the arm-smmu-v3 driver;
> >   - cca_psmmu_get(&params): activate the physical smmu for Realm use.
> > 
> > Intel differs in two ways:
> > 
> >   - ARM queries the physical iommu information from the iommu driver
> >     in the viommu_init() path. On Intel, the secure iommu must be set
> >     up during TSM connect, because it is part of establishing PCIe
> >     link encryption.
> 
> My understanding is that the psmmu is required for link encryption, so
> it's similar ordering here i.e. activated before tsm connect?

No, AFAIK? The psmmu has to be linked before creating the vdev, and in
the current spec the only way to get the measurements is through the
vdev, but I am expecting that to change.

I have no idea what brilliant idea caused the VT-d iommu HW to become
involved in DOE and link IDE configuration in the root port. That
makes very little sense from an architecture perspective.

> >   - The TDX Connect architecture places requirements on the host
> >     iommu driver while the secure IOMMU is being set up. For example,
> >     the host iommu driver must block the enhanced command (ECMD)
> >     interface while the TDH.IOMMU.SETUP SEAMCALL runs, and it must
> >     reserve the upper half of the domain ID space. These steps have
> >     to happen atomically under the iommu driver's own locks. As a
> >     result, the Intel iommu driver needs to merge the two steps above
> >     into one.
> 
> Didn't get this. Both ECMD and DID reservation are TDX specific things.
> How are they related to the two steps in the ARM sides and why calls
> for merging?
> 
> and why are they must be done atomically? they are conditions to
> execute TDH.IOMMU.SETUP, but it is perfectly fine to reserve DID
> at an early point then block ECMD later...

That's going to be a bit of a PITA, since the DIDs can be in use when
the tdx module is start potentially.

I suppose you can start out by just failing if this has happened.

But as soon as reasonably possible once the system opts into a TDX
operation the VT-d drivers should stop using the upper did space.

Otherwise you will have to implement live DID renaming, which is a
PITA in an iommu driver.

Jason

