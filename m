Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB23401A18
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359043; cv=none; b=Q09AIJsrctGAp24Dh9sLik1UHXIK1ZPGiBv/xirN/iwwJICE7ZXHc8aoaxVMXix5sd6W677HsyE0fxSzzvKj7qPFvKyrzKLH98I0Qlxy9ckMQSiGHW+rqm27N9UfmgpsBtYTV8blMrfCAIIFmc0kKjwMFX6xIJsfHBEXMQJEVuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359043; c=relaxed/simple;
	bh=UDK7FEv64ae416CkslzAkPQ3Hq5fF52mMbLi4Ue4AXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLqDHPLZ9O9TA9mdDuMTGdcOX8tg9LZLqjr8gtFQUpIsvSJJg5Kp5b9iPIdGqtpDBUYQfpYONxGg20m2utS2ltuUGjaJG/gK05EDiCTCBpm6fnIRvY0HJeUgM6tKSWYtE02eWbcE6bTWp+UUMwnMrqhTsg8O00spP09Ol0jJ1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VbX4Ciiy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VbX4Ciiy"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aea4ebb048so23375ad.1
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773359041; x=1773963841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8kh9O+g+NKGrrcQ5cE1Hz8CHaA6+0CqrxLZopdoYf4=;
        b=VbX4CiiykxeRE3u+ZCurLeshnP/oFwIYRNVmGZP7ykFLnN3NXHxiycJ7Q/Rej36WZX
         FL5GO+5Sj6eHj4fjYWvDLFg/NNxEJB7TXOExAZ7kS63lLkCMelX+J6JLxOx3Qzm6a2u6
         o63jGuBoCMwV3YWcsfK1QdSbAIRVfqGZPuJ5EqF3pQGMokHaoXE4xVYB2WrwoSToKw0b
         ts1X5CX91FxwYYPf0Cz2v0WpaRMPsHwcMBiVTng5XFJBErb6apFxRHN8zA+qpJm8SLAj
         fUXkbbdE1+CHzG1Q9ojdPQUq+fpmbnXnTpvZwe/gyUKoQ0KReGGMdr3ltSBxCShP4ypm
         GIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359041; x=1773963841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8kh9O+g+NKGrrcQ5cE1Hz8CHaA6+0CqrxLZopdoYf4=;
        b=tK8/tYxD6dlFxMHbFTp3Pfsz8ry2MfSaQtb+GsVmWV9/T3Jvr0DrRXIxQznTZiOmod
         m+U4CzngJmlTa2jdi9N/YkxGdOFymsuPB3N20XUO29h+HT/jP4P/JeJtyJsFH9z7pe+L
         XpwFrogVD96Rbm4vcp+MyRgRw1NevVv2Dk2nIdi9ElK0OAZ/7EhNRVPmdzS+o6ZoftnD
         oSGxqObbTnnIutfo/O61CN6Kul57lOHImm2xzCFEGHfjzQakWQFR8CTSFFvq2ykmsRLZ
         YQDST0YMTRkJV9N9CWcJM+MnHzD4ytidNx7Hix6yUWZAUdNlWvH55pT3CmNzMl+md6O0
         sGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkejwI4+AX7aoslM2imovHMFTpjMNQCHVX6FCkpjMsnie2WW1Tiwm2rsAZpS9lxrz93VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDYHrGPIzgBc8tbW/o8FpOmt+V8kSOaW8aWYvBxTF0kjSo9rTW
	4AM5feUftYDhysyCiy3m/8OQKzIXlx5BG9zMlJ2Fs5S9CECN3sh608QbefNn+gpXOQ==
X-Gm-Gg: ATEYQzxwgio2Pmx9mLU2CWUYAEBGbNcqn26KPsfNKhUI6VdNbzb2JLHsP7afhdyXeTg
	FylUrcSZmzq6gIwwrzcohPnl8Yg63/Qh3c4k6OEXeZUj1S/gGXuaCqQrVtHnsgGj4D0gr1X9YXO
	H/gr8Vlb8QMUcsKQr2katOoNBvaQC8fTGGgPlN0Ws6l/I1NtJovHz9wU3xr5uurRgVq3V6GiBpi
	0a+0CAL+sG0Dr1fNRPmLhjrRxann+flyHWtC1BtvD1IwQrbea9+cg6AJF2Kac5rG9u7IdSJmCpt
	i02caOT6RrtEq7EFoEe4UqaW6augxW4ivR0MRpI+H5Sysnfyrqukjct540jJ8nVCKbMgyodoytz
	lGXilOBIEoOZRf52GcMKx8RfMljwgLBCQ8XdZZWX8mp26PWACKR9neVRdQu58eirxwAetbZvzRg
	9oiRZWYI2QpS4ohgkKQTiY7G2KWR5dATRvHrh533Pp37PWyN8yNlAC4G7mGvPHkyVRaDHY
X-Received: by 2002:a17:902:fc4b:b0:2ae:567a:c5a6 with SMTP id d9443c01a7336-2aecd604fe6mr724505ad.15.1773359040753;
        Thu, 12 Mar 2026 16:44:00 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7ee1e3sm1146655ad.44.2026.03.12.16.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 16:43:59 -0700 (PDT)
Date: Thu, 12 Mar 2026 23:43:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <abNPuGC_sSK-tiNi@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
 <abHZdOKyLmmmHADz@google.com>
 <abLi5giBpi05_CLn@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLi5giBpi05_CLn@google.com>

On Thu, Mar 12, 2026 at 04:43:00PM +0000, Samiullah Khawaja wrote:
> On Wed, Mar 11, 2026 at 09:07:00PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> > > Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
> > > alloc/free helper functions to allocate memory for the IOMMU LU FLB
> > > object and the serialization structs for device, domain and iommu.
> > > 
> > > During retrieve, walk through the preserved objs nodes and restore each
> > > folio. Also recreate the FLB obj.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/Kconfig         |  11 +++
> > >  drivers/iommu/Makefile        |   1 +
> > >  drivers/iommu/liveupdate.c    | 177 ++++++++++++++++++++++++++++++++++
> > >  include/linux/iommu-lu.h      |  17 ++++
> > >  include/linux/kho/abi/iommu.h | 119 +++++++++++++++++++++++
> > >  5 files changed, 325 insertions(+)
> > >  create mode 100644 drivers/iommu/liveupdate.c
> > >  create mode 100644 include/linux/iommu-lu.h
> > >  create mode 100644 include/linux/kho/abi/iommu.h
> > > 
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index f86262b11416..fdcfbedee5ed 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -11,6 +11,17 @@ config IOMMUFD_DRIVER
> > >  	bool
> > >  	default n
> > > 
> > > +config IOMMU_LIVEUPDATE
> > > +	bool "IOMMU live update state preservation support"
> > > +	depends on LIVEUPDATE && IOMMUFD
> > > +	help
> > > +	  Enable support for preserving IOMMU state across a kexec live update.
> > > +
> > > +	  This allows devices managed by iommufd to maintain their DMA mappings
> > > +	  during kexec base kernel update.
> > > +
> > > +	  If unsure, say N.
> > > +
> > 
> > I'm wondering if this should be under the if IOMMU_SUPPORT below? I
> > believe this was added here because IOMMUFD isn't under IOMMU_SUPPORT,
> > but it wouldn't make sense to "preserve" IOMMU across a liveupdate if
> > IOMMU_SUPPORT is disabled? Should we probably be move it inside the
> > if IOMMU_SUPPORT block for better organization, or at least have a depends
> > on IOMMU_SUPPORT added to it? The IOMMU_LUO still depends on the
> > IOMMU_SUPPORT infrastructure to actually function.. as we add calls
> > within core functions like dev_iommu_get etc.
> 
> Agreed. I will move it under IOMMU_SUPPORT and sort out any other
> dependencies.
> > 
> > >  menuconfig IOMMU_SUPPORT
> > >  	bool "IOMMU Hardware Support"
> > >  	depends on MMU
> > > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > > index 0275821f4ef9..b3715c5a6b97 100644
> > > --- a/drivers/iommu/Makefile
> > > +++ b/drivers/iommu/Makefile
> > > @@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
> > >  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> > >  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
> > >  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
> > > +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> > >  obj-$(CONFIG_IOMMU_IOVA) += iova.o
> > >  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
> > >  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
> > > diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> > > new file mode 100644
> > > index 000000000000..6189ba32ff2c
> > > --- /dev/null
> > > +++ b/drivers/iommu/liveupdate.c
> > > @@ -0,0 +1,177 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +/*
> > > + * Copyright (C) 2025, Google LLC
> > 
> > Minor nit: 2026 OR 2025-26, here and everywhere else
> 
> Will fix in next revision.
> > 
> > > + * Author: Samiullah Khawaja <skhawaja@google.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt
> > > +
> > > +#include <linux/kexec_handover.h>
> > > +#include <linux/liveupdate.h>
> > > +#include <linux/iommu-lu.h>
> > > +#include <linux/iommu.h>
> > > +#include <linux/errno.h>
> > > +
> > > +static void iommu_liveupdate_restore_objs(u64 next)
> > > +{
> > > +	struct iommu_objs_ser *objs;
> > > +
> > > +	while (next) {
> > > +		BUG_ON(!kho_restore_folio(next));
> > 
> > Same thing about BUG_ON [1] as mentioned below in the
> > iommu_liveupdate_flb_retrieve() function, can we consider returning an
> > error which can be checked in the caller and the error can be bubbled up
> > as -ENODATA?
> 
> Please see the explanation below on the BUG_ON.

[------- snip >8 --------]

> > > +
> > > +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> > > +{
> > > +	struct iommu_lu_flb_obj *obj;
> > > +	struct iommu_lu_flb_ser *ser;
> > > +
> > > +	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);
> > 
> > Why does this have to be GFP_ATOMIC? IIUC, the retrieve path is
> > triggered by a userspace IOCTL in the new kernel. The system should be
> > able to sleep here? (unless we have a use-case to call this in IRQ-ctx?)
> > AFAICT, we call this under mutexes already, hence there's no situation
> > where we could sleep in a spinlock context?
> > 
> > GFP_ATOMIC creates a point of failure if the system is under memory
> > pressure. I believe we should be allowed to sleep for this allocation
> > because the "preserved" mappings still allow DMAs to go on and we're in
> > no hurry to restore the IOMMU state? I believe this could be GFP_KERNEL.
> > 

I guess we missed discussing this comment about s/GFP_ATOMIC/GFP_KERNEL?

> > > +	if (!obj)
> > > +		return -ENOMEM;
> > > +
> > > +	mutex_init(&obj->lock);
> > > +	BUG_ON(!kho_restore_folio(argp->data));
> > 
> > The use of BUG_ON in new code is heavily discouraged [1].
> > If KHO can't restore the folio for whatever reason, we can be treat it
> > as a corruption of the handover data. I believe crashing the kernel for
> > it would be an overkill?
> 
> The FLB restore is done during early boot and this has been discussed in
> past in KHO/LUO and IOMMU context also. But basically if this fails, the
> restoration of IOMMU state cannot be done, preserved devices would
> already have corrupted memory due to ongoing DMA as we didn't disable
> translation in the previous kernel. So logging an error and a BUG_ON at
> this point would be most appropriate.
> 
> Please see discussion here on this topic:
> https://lore.kernel.org/all/20251118153631.GB90703@nvidia.com/

I see.. so a failure here would mean an entire VM tear-down?

> > 
> > Can we consider returning a graceful failure like -ENODATA or something?
> > BUG_ON would instantly cause a kernel panic without providing no
> > opportunity for the system to log the failure or attempt a graceful
> > teardown of the 'preserved' mapping.
> 
> I will update this by adding a comment and also log an error.

Ack. Thanks

[ ---- snip >8 -----]

> > > +enum iommu_lu_type {
> > > +	IOMMU_INVALID,
> > > +	IOMMU_INTEL,
> > > +};
> > > +
> > > +struct iommu_obj_ser {
> > > +	u32 idx;
> > > +	u32 ref_count;
> > > +	u32 deleted:1;
> > > +	u32 incoming:1;
> > > +} __packed;
> > > +
> > > +struct iommu_domain_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 top_table;
> > > +	u64 top_level;
> > > +	struct iommu_domain *restored_domain;
> > > +} __packed;
> > > +
> > > +struct device_domain_iommu_ser {
> > > +	u32 did;

Nit: `did` sounds intel-specific, we can either call it something
generic or make it into a union when we support other archs in the
future.

> > > +	u64 domain_phys;
> > > +	u64 iommu_phys;
> > > +} __packed;
> > > +
> > > +struct device_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	u32 devid;
> > > +	u32 pci_domain;
> > > +	struct device_domain_iommu_ser domain_iommu_ser;
> > > +	enum iommu_lu_type type;
> > > +} __packed;
> > > +
> > > +struct iommu_intel_ser {
> > > +	u64 phys_addr;
> > > +	u64 root_table;
> > > +} __packed;
> > > +
> > > +struct iommu_ser {
> > > +	struct iommu_obj_ser obj;
> > > +	u64 token;
> > > +	enum iommu_lu_type type;
> > > +	union {
> > > +		struct iommu_intel_ser intel;
> > > +	};
> > > +} __packed;
> > > +
> > > +struct iommu_objs_ser {
> > > +	u64 next_objs;
> > > +	u64 nr_objs;
> > > +} __packed;
> > > +
> > > +struct iommus_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_ser iommus[];
> > > +} __packed;
> > > +
> > > +struct iommu_domains_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct iommu_domain_ser iommu_domains[];
> > > +} __packed;
> > > +
> > > +struct devices_ser {
> > > +	struct iommu_objs_ser objs;
> > > +	struct device_ser devices[];
> > > +} __packed;

I have a bone to pick here about the naming LOL, the names are kinda
confusing and make the code unreadable, I had to keep re-visitng this
patch while looking at the subsequent ones to understand what's going
on..

One suggestion is to add a graphic that could help understand the layout
like:

----------------------------------------------------------------------
[ PAGE START ]                                                       |
----------------------------------------------------------------------
| iommu_objs_ser (The Page Header)                                   |
|   - next_objs: 0x0000 (End of the page-chain)                      |
|   - nr_objs: 2                                                     |
----------------------------------------------------------------------
| ITEM 0: iommu_domain_ser                                           |
|   [ iommu_obj_ser (The entry header) ]                             |
|     - idx: 0                                                       |
|     - ref_count: 1                                                 |
|     - deleted: 0                                                   |
|   [ Domain Data ]                                                  |
----------------------------------------------------------------------
| ITEM 1: iommu_domain_ser                                           |
|   [ iommu_obj_ser (The Price Tag) ]                                |
|     - idx: 1                                                       |
|     - ref_count: 1                                                 |
|     - deleted: 0                                                   |
|   [ Domain Data ]                                                  |
----------------------------------------------------------------------
| ... (Empty space for more domains) ...                             |
|                                                                    |
----------------------------------------------------------------------
[ PAGE END ]                                                         |
----------------------------------------------------------------------

Additionally, a few naming suggestions here:

1. struct iommu_obj_ser -> struct iommu_ser_entry_hdr
2. struct iommu_objs_ser -> struct iommu_ser_page_hdr
3. struct iommu_domains_ser -> struct iommu_ser_domain_page

This makes things clearer:

struct iommu_ser_page_hdr {
    u64 next_page_phys;
    u64 entry_count;
} __packed;

/* The Container Page */
struct iommu_ser_domain_page {
    struct iommu_ser_page_hdr hdr;
    struct iommu_ser_domain domain_entries[];
} __packed;

Similarly, something like:

4. struct devices_ser -> struct iommu_ser_device_page
5. struct iommu_lu_flb_ser -> struct iommu_flb_metadata
6. struct iommu_lu_flb_obj -> struct iommu_flb_ctx

struct iommu_flb_ctx {
	struct mutex lock;
	struct iommu_flb_metadata *cookie;

	struct iommu_ser_domain_page    *curr_domains_page;
	struct iommu_ser_iommu_ctx_page *curr_iommu_ctx_page;
	struct iommu_ser_device_page    *curr_devices_page;
} __packed;

Makes things slightly more readable.

> > > +
> > > +#define MAX_IOMMU_SERS ((PAGE_SIZE - sizeof(struct iommus_ser)) / sizeof(struct iommu_ser))

Nit: For clarity, can we consider adding another set of braces:

+#define MAX_IOMMU_SERS ((PAGE_SIZE - (sizeof(struct iommus_ser)) / sizeof(struct iommu_ser)))

> > > +#define MAX_IOMMU_DOMAIN_SERS \
> > > +		((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
> > > +#define MAX_DEVICE_SERS ((PAGE_SIZE - sizeof(struct devices_ser)) / sizeof(struct device_ser))
> > > +
> > > +struct iommu_lu_flb_ser {
> > > +	u64 iommus_phys;
> > > +	u64 nr_iommus;
> > > +	u64 iommu_domains_phys;
> > > +	u64 nr_domains;
> > > +	u64 devices_phys;
> > > +	u64 nr_devices;
> > > +} __packed;
> > > +
> > > +struct iommu_lu_flb_obj {
> > > +	struct mutex lock;
> > > +	struct iommu_lu_flb_ser *ser;
> > > +
> > > +	struct iommu_domains_ser *iommu_domains;
> > > +	struct iommus_ser *iommus;
> > > +	struct devices_ser *devices;
> > > +} __packed;
> > > +
> > 
> > Please let's add some comments describing the structs & their members
> > here like we have in memfd [2]. This should be descriptive for the user.
> > For example:
> 
> I agree. Will add comments for these and others.
> > 
> > +/**
> > + * struct iommu_lu_flb_ser - Main serialization header for IOMMU state.
> > + * @iommus_phys:        Physical address of the first page in the IOMMU unit chain.
> > + * @nr_iommus:          Total number of hardware IOMMU units preserved.
> > + * @iommu_domains_phys: [...]
> > + * @nr_domains:         [...]
> > + * @devices_phys:       [...]
> > + * @nr_devices:         [...]
> > + *
> > + * This structure acts as the root of the IOMMU state tree. It is hitching a ride
> > + * on the iommufd file descriptor's preservation flow.
> > + */
> > +struct iommu_lu_flb_ser {
> > +	u64 iommus_phys;
> > +	u64 nr_iommus;
> > +	u64 iommu_domains_phys;
> > +	u64 nr_domains;
> > +	u64 devices_phys;
> > +	u64 nr_devices;
> > +} __packed;
> > 
> > > +#endif /* _LINUX_KHO_ABI_IOMMU_H */
> > 
> > Thanks,
> > Praan
> > 
> > [1] https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug
> > [2] https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/kho/abi/memfd.h
> > 
> 
> Thanks for the review.
> 
> Sami

Thanks,
Praan 
