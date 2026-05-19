Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A314DC546
	for <kvm@vger.kernel.org>; Tue, 19 May 2026 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201618; cv=none; b=O0a5DtBlxJe6jH+pDR3mtnN1FDKxF6LRYD3FhEY1JEFLwIx2Gf+x1QYtkMdym+wQe2k0pkp8VV0ng+wdG7wfm3ehqDnlPkjLgUKcV/tDr3+GGTYXZOXfd0FYcbRGcOxlgaWJnY2yuDiVs+1rgG1Qw3TraEq8+x0eXuPedLCvLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201618; c=relaxed/simple;
	bh=f4R4U5Ar4zJ/4MQD6l6HxvWkEJAg60iD6DPVV1Prcak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tExUQKlDcsLkhGwFuYJcH7KhibqGomZ67wbIkpyISZzjK4Q1CBvWGdwAC4tG63Lcne30cRysgRBb8dZruyuwq6OUmYpYK5WYLf6dtxSU5lGhQcpO4XIfXzjJ9Xr/8JgAc1HcIxemYqjVpu/TItGAmhr5YaRaddsb9BYJDPWAyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JccCbBi5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JccCbBi5"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso1425ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779201616; x=1779806416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pFrnW7yNBIXff+8j+5lqhWdfBhK7nbCJmLOYnxsRaNg=;
        b=JccCbBi5DoNxVv7/CK2Y9m5nDNPbhPZ7XY2XNna28VMaFaJ+Rlgv1PQR3ABzVLLBDy
         GtmjGnS2raFw0vm7WeeQkMhmj1Dxe9d6AnbvBi/s7g4LSyXCAKWWLK/+/bq1U/7OKG8F
         Ra4QlKK80iu6i9se2gDa4RV5fdJirnRo5IcYAWMZMb8iBt9T+0D/6vlLrI4pU7Q7b47i
         WaUsex5I7Ta22hS+eQkECBk2bu/K47sEgO1Cw88QRFo4fDqfgDQdOhlYDbLLUSms83Ph
         NPdwrO3LC8NayEsMJmtU/CpZZxYKE2GP49CeEWIest3gGOPGue1kO2dKJuFXfoKLNeHR
         9Byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201616; x=1779806416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrnW7yNBIXff+8j+5lqhWdfBhK7nbCJmLOYnxsRaNg=;
        b=WSf1+GNrixq4cVSdrxgoGYi+Mfn403SSahyNGEPNA2pvzLIyQD/2mqgmX8lMfRgg8b
         7VLz94fkh0XQnnW/g0fByXlO1u2fRolFk35WETXv9OUu29+8T8k2YT9Jf+PhRAQHlftf
         uFLtTpUIk8gdeAqXQuYba4KoZIsj0bjYA6nX17+uBcAWvUd8gAL8bLN99h09g0/kM+qX
         SObm6MzqfSVtvvjcKTZatMqVPWbC+j08zFzkHqWn0zMqGUwFjs8SzXT/Sev34n6ZUtRp
         TUbW2JFE1Fg6eqNL/7DcMYlbPYrdaz9o5WEQN4EmCo9Ae4C5MpJb5bSMzmRhebQHPiFJ
         aVJg==
X-Forwarded-Encrypted: i=1; AFNElJ+RliNPz9t9T5RGQnwsKcd6ZGWWOG3dCKmQm0a9E8aONrj+6K+iKQDrj4fVBNr+c0gILeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97DQetvGlLJk1sIiXfPmHRKO2WbhBDxkBJC3zS5q10M7UgxQl
	dkvpJrIxt+xkT/i2+XnaDw/gfA5LIFc0l31HmAMr3w6D9moN+QHN6pqNoMHWQymQ3g==
X-Gm-Gg: Acq92OHJvdC1Et1C+VtwxAoB/0VEvLkDi2bH+HjyfEk8BCrp7GmkgRJcnAtnEGzNLX9
	nutv7SOeZbf/a2KutUmLE1SyDNoZiFP7rV8tjjP6qZt/IxwySPsBuRhM0jiOxwjut2lmb8soPy0
	LBNmPv4mcgVWml+dK6RerKxmMGaETVSrMO7EdrZfBk2c/3TbEZr63Z6GCShYfN1+4IA6AxOnQgx
	OFAH/iCQnwkohi24YQgzf572kLuwO396tNAVEB8yJV9XRWvxon2tqP9U3F/EqMjFfsuvSTdEFIA
	l6PKnZYzh1GE9AwhUIk8FZ193JfJwlCJ4BokFLxz5z/WT8vEfvKQ78bt+MSbOmzk37TxMEEoFa/
	37XvSnJvnQwt3N8ArplXMuPc0iKbWDM1JwfEddxL+bvIJNfBm5HUA8Xxz5CT7A3X2SVZw7DHBio
	NQLRp0Hljo+NO7GL2knJk38vOtRBs3kBtvQRO1z+1oN5Hiy9t8Cz9VcaXtM+OHoMgGoyem
X-Received: by 2002:a17:903:46ce:b0:2bd:9e75:9e98 with SMTP id d9443c01a7336-2bdb329b484mr6449415ad.9.1779201614999;
        Tue, 19 May 2026 07:40:14 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef27sm242035275ad.8.2026.05.19.07.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:40:14 -0700 (PDT)
Date: Tue, 19 May 2026 14:40:05 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <agx2RW_jujXbsiea@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-8-skhawaja@google.com>
 <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>
 <af023TAT1m3oA9ez@google.com>
 <agtux6SrjpRYvMit@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtux6SrjpRYvMit@google.com>

On Mon, May 18, 2026 at 08:32:42PM +0000, Samiullah Khawaja wrote:
> On Fri, May 08, 2026 at 02:36:56AM +0000, Samiullah Khawaja wrote:
> > On Thu, May 07, 2026 at 02:25:14PM +0800, Baolu Lu wrote:
> > > On 4/28/26 01:56, Samiullah Khawaja wrote:
> > > > Add implementation of the device and iommu presevation in a separate
> > > > file. Also set the device and iommu preserve/unpreserve ops in the
> > > > struct iommu_ops.
> > > > 
> > > > During normal shutdown the iommu translation is disabled. Since the root
> > > > table is preserved during live update, it needs to be cleaned up and the
> > > > context entries of the unpreserved devices need to be cleared.
> > > 
> > > This is not related to preserve/unpreserve ops and could be made in a
> > > separated patch?
> > 
> > Agreed. I will move this stuff to a separate patch.
> > > 
> > > > 
> > > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > > ---
> > > > MAINTAINERS                      |   1 +
> > > > drivers/iommu/intel/Makefile     |   1 +
> > > > drivers/iommu/intel/iommu.c      |  52 +++++++++++-
> > > > drivers/iommu/intel/iommu.h      |  28 +++++++
> > > > drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
> > > > drivers/iommu/iommu.c            |  18 ++++
> > > > include/linux/iommu-liveupdate.h |  10 +++
> > > > include/linux/iommu.h            |  14 ++++
> > > > include/linux/kho/abi/iommu.h    |  18 ++++
> > > > 9 files changed, 277 insertions(+), 4 deletions(-)
> > > > create mode 100644 drivers/iommu/intel/liveupdate.c
> > > > 
> 
> [snip]
> > > 
> > > > +{
> > > > +	struct context_entry *context;
> > > > +	int ret;
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> > > > +		/*
> > > > +		 * Alloc the context tables now to make sure the iommu unit is
> > > > +		 * properly preserved. These might stay unused and wastes around
> > > > +		 * 32MB max in scalable mode.
> > > > +		 */
> > > 
> > > Instead of allocating and preserving context tables for all root entries
> > > (as noted, can waste up to 32MB), could we restrict this only to the
> > > entries possibly in use by active PCI devices?
> > 
> > I think the hotplug devices or VFs created through SR-IOV will be missed
> > that way. Lets say device A is preserved and the associated iommu is
> > also preserved. And then a new device B is hotplugged and preserved,
> > then the context table for that will be missed.
> 
> Ok I thought about it a little more and basically we have following
> things to consider when we preserve context tables,
> 
> - The devices can be hotplugged and preserved, so the context tables of
>   those need to be preserved if we don't allocate all of them first time
>   we preserve iommu, as done here.
> - New context tables can be added (after hotplug) for unpreserved
>   devices. And if we don't get another iommu preserve call after these
>   are added, those remain unpreserved, so during shutdown those entries
>   need to be removed from root table or preserved for simplicity.
> 
> To solve this we can,
> 
> 1. Either preserve the new context table when it is added for a preserved
>   iommu. This can be done in iommu_context_addr(). This is simpler and
>   no tracking needed.
> 
> 2. Or track the preserved context tables using a bitmap and then preserve
>   them incremently whenever a device is preserved. On shutdown during
>   cleanup, we can clear the entries for unpreserved context tables from
>   root table.
> 
> I am inclined towards second option. WDYT?

Thinking out loud here, I agree that shifting away from the 32MB 
pre-allocation is the right direction. I'm wondering if we can avoid the
overhead of introducing a new tracking bitmap (Option 2) altogether?

Since the IOMMU serialization is a strict dependency for device tracking,
could we move the context table preservation directly into the device 
level op: intel_iommu_preserve_device()?

Whenever a specific device is preserved on-demand:

1. It queries the parent IOMMU to fetch the allocated context table 
   backing its info->bus.

2. It calls iommu_preserve_page(context) for that table. Because KHO's
   tracking handles duplicates, this should be fine if multiple devices
   reside on the same bus...

Regarding Scalable Mode, we could just need a simple check in that path:


/* intel_iommu_preserve_device */
/* Preserve the primary/lower context table backing this bus */
context = iommu_context_addr(info->iommu, info->bus, 0, 0);
if (context)
	iommu_preserve_page(context);

/* If scalable mode is active, preserve the upper context table as well */
if (sm_supported(info->iommu)) {
	context = iommu_context_addr(info->iommu, info->bus, 0x80, 0);
	if (context)
		iommu_preserve_page(context);
}

WDYT?

> 
> I think we will have to do similar stuff for PASID also down the road to
> preserve pasid_tables in PASID directory.
> > 
> > Since we don't track the context_tables that are preserved, there is no
> > way to incremently preserve the new-ones. Let me look into the behaviour
> > of KHO, maybe we can make the preserve call idempotent and do these
> > incrementally.
> > > 
> > > > +		spin_lock(&iommu->lock);
> > > > +		context = iommu_context_addr(iommu, i, 0, 1);
> > > > +		spin_unlock(&iommu->lock);
> > > > +		if (!context) {
> > > > +			ret = -ENOMEM;
> > > > +			goto error;
> > > > +		}
> 
[snip]

Thanks,
Praan
