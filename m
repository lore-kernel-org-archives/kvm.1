Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039654D2EE6
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533849; cv=none; b=gdK4y7OJGP5cg1WkQgTEvae8e6Klc5bI9RAtzBntROU4L41D+l6SRyleBOVyDAoojeN3/B/eAcxVUnv7bdo1q5mFY1UOmybmLam1PqSr5d5jzM8YoP+rS4/913tujZne9sLAXCNYIjHQO9pAQdX2seeLLHIJcbfJclwmNsI4JMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533849; c=relaxed/simple;
	bh=OicPgjnrqDPLO3PrCx45/s1FF7/nTgJfea0D9L2qSMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZuMsKCdwhzTaeASbLFFJzKTzYVZzdk8X1UfuNLcfMK0GJ4nKoG8xQdnbtcz9LmFt48z4Zow6OEmZQgVdLvIKE/IzqhgMSzm9HugVwN2FZODKuJ5w944mZ5Nmlo/FMWj4DS5c83CuOE7FOnWgpI5DotjNMOzn6YyihVzqqFbgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wfvLf8OZ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wfvLf8OZ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ee990e8597so8326381eec.1
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778533847; x=1779138647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJUZ+9h7cLwAojaR2mrUsKXNC1lI0aWmSJMdNn306BU=;
        b=wfvLf8OZByRE1gKDoIEeaOAaNUlVfsFaXi81se45zNgzEZ5xsDb9+tNkShZKNBpUl8
         mnC4aiT76WjH0e3z8AyRTcxunZ0hd6V12r/NLaC84Lryt1rGdEw5TNn1wiKW1SprL3UQ
         /aUW+UOjUP5hZadvNgsrfWkGGPRVFtZmQikJJiZA1evw1MWkUg8jF4fG5DU/XAuU7IOd
         UipidrDciAR1UvgoRXNZxrzr82qZz0wPbEi+UWcDeFFVCKTQvz9sNvgQ+f4F25tgDFBA
         5VjpYwvBh0DtAwKRmmoJi/I8iesEpIvZRY81VQhTZAWZULkb5eb3aN9LF5xa4APwQ/te
         gFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533847; x=1779138647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJUZ+9h7cLwAojaR2mrUsKXNC1lI0aWmSJMdNn306BU=;
        b=LBjOGy7Qy0qROjytD98frCLnhGm+3i/iqdSADmpiqdRSGZqnOgM4amuDuOpibpty5N
         penPvewbhlcxBP6c+jHzaMJpNFHStBe9vxQqi/H879dD8uzOQQZfz/Phdafd1RnKBDM4
         pWCtL1kM0ooKJzcVxd4/Di4z9wGPsfa7Fm+IPMf7xmmLP4CCg6KIx1+75lQyr4hz0vm+
         GwEVtOmQfpj5EK/FObRetQP/MiDBaYWxe3HwZu+6K8Vr2mPUqfzo3biPD1jbolSojSIw
         F5zg+UPaIvUkCyB85jhornWBOWfFG9yt3/1w6mid70wJMKHgQiQ1zVABW/uOwtViqP7T
         cWUw==
X-Forwarded-Encrypted: i=1; AFNElJ/PFti/XgJorSZ6MGW6mER4A6GiycTN1HyI+TcOxRoqzNnmK6ZaxjHCh0hjqvCisMjCms8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8e199FkP8UsyU+I9FXJz051na0hkVS3mKru+oxisd8ueM2oz+
	vm6Wsc+Ft8UEDHkF4S81nXjOKtBaoIByoqs9L0kZ774WrQbguaS7BE0mQddKIhHjvQ==
X-Gm-Gg: Acq92OGWUDuryJhoe/h1WHnuVZiQNkkbzK9Wbt/Deq+OBKT+LDEJ9qOHBX/V2yzGMLK
	IXAd4Oup2kyVrd8UdNHeeHWhk7DvE0F4eT615L1jFSX+UAuQGCTPtpWNxZaipWjgd97OajrQatv
	VqVNYYN+TsiW8AapFRRSzVzTpInCWkszo7AmXH3H+Cg7yeito6/VPhwNYOdMnlDaU4rRjSS+Ru9
	DQOzwxaxwRBmRone23NQb7438PGAIeGLXf8YT9g5O1IZ/T6TuBC5DZtJ7/z8U+LDeEPd9uFYEmB
	g9kl8AyixZ2zi1WnyFVdjTWSD5d907lJT0FMxz32WRk5F6TY2TZtrUCeK84mIttrGqDyaUNhUgz
	N8/EbBVhRy7MInXgHGweEhLyRYwQEVH1F+BDGVez0RSCuj+ZjBf4zIHkREHCtQ60rFg7206sY0U
	4D3zIvxOL4y+iOMxFFgw74ffVQsZM6MIiuait30i14cApFE1r9Kso8vu04uC+Ep+0fAF+zZU051
	+v8492beVw=
X-Received: by 2002:a05:7301:400b:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-2ffd51cd78bmr154725eec.7.1778533846490;
        Mon, 11 May 2026 14:10:46 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm13584757eec.0.2026.05.11.14.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 14:10:46 -0700 (PDT)
Date: Mon, 11 May 2026 21:10:42 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] vfio: selftests: Add iommufd multi iommu test
Message-ID: <agJF0gY_V-ZWaNK8@google.com>
References: <20260505221518.619123-1-skhawaja@google.com>
 <20260505221518.619123-3-skhawaja@google.com>
 <af5EEN8PhVz4pTdE@google.com>
 <agI6peKFWDdn939Z@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agI6peKFWDdn939Z@google.com>

On 2026-05-11 08:53 PM, Samiullah Khawaja wrote:
> On Fri, May 08, 2026 at 08:14:08PM +0000, David Matlack wrote:
> > On 2026-05-05 10:14 PM, Samiullah Khawaja wrote:
> > > Add a test for iommufd to verify creation of multiple iommus using an
> > > already setup iommufd and switch between them.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  tools/testing/selftests/vfio/Makefile         |   1 +
> > >  .../vfio/vfio_iommufd_multi_iommu_test.c      | 203 ++++++++++++++++++
> > >  2 files changed, 204 insertions(+)
> > >  create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
> > > 
> > > diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
> > > index 0684932d91bf..24bdeaad590f 100644
> > > --- a/tools/testing/selftests/vfio/Makefile
> > > +++ b/tools/testing/selftests/vfio/Makefile
> > > @@ -8,6 +8,7 @@ else
> > >  CFLAGS = $(KHDR_INCLUDES)
> > >  TEST_GEN_PROGS += vfio_dma_mapping_test
> > >  TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
> > > +TEST_GEN_PROGS += vfio_iommufd_multi_iommu_test
> > >  TEST_GEN_PROGS += vfio_iommufd_setup_test
> > >  TEST_GEN_PROGS += vfio_pci_device_test
> > >  TEST_GEN_PROGS += vfio_pci_device_init_perf_test
> > > diff --git a/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
> > > new file mode 100644
> > > index 000000000000..7199c662637c
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
> > > @@ -0,0 +1,203 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +#include <sys/ioctl.h>
> > > +#include <sys/mman.h>
> > > +
> > > +#include <linux/sizes.h>
> > > +#include <linux/vfio.h>
> > > +
> > > +#include <libvfio.h>
> > > +
> > > +#include "kselftest_harness.h"
> > > +
> > > +static const char *device_bdf;
> > > +
> > > +#define IOMMU_DEFAULT 0
> > > +#define IOMMU_WITH_PT 1
> > > +#define IOMMU_WITHOUT_PT 2
> > > +
> > > +static void region_setup(struct iommu *iommu,
> > > +			 struct iova_allocator *iova_allocator,
> > > +			 struct dma_region *region, u64 size)
> > > +{
> > > +	const int flags = MAP_SHARED | MAP_ANONYMOUS;
> > > +	const int prot = PROT_READ | PROT_WRITE;
> > > +	void *vaddr;
> > > +
> > > +	vaddr = mmap(NULL, size, prot, flags, -1, 0);
> > > +	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
> > > +
> > > +	region->vaddr = vaddr;
> > > +	region->iova = iova_allocator_alloc(iova_allocator, size);
> > > +	region->size = size;
> > > +
> > > +	iommu_map(iommu, region);
> > > +}
> > > +
> > > +static void region_teardown(struct iommu *iommu, struct dma_region *region)
> > > +{
> > > +	iommu_unmap(iommu, region);
> > > +	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
> > > +}
> > 
> > Can you create library helpers in the library to share with
> > vfio_pci_driver_test.c?
> > 
> >  dma_region_setup()
> >  dma_region_teardown()
> 
> I thought it is ok to duplicate this as each test (in future) might have
> different mapping requirements? we might have memfd, guest_memfd,
> dma_buf with various mapping strategies for different usecases?
> 
> Or you are thinking of a basic helper that can be used by tests if they
> are not doing anything fancy?

We have 2 tests now that need the same code to setup their regions so we
might as well share it. As new and more complex use-cases arise we can
figure out how to support them (per-test logic or fancier library
support).

> > > +TEST_F(vfio_iommufd_multi_iommu_test, memcpy)
> > > +{
> > > +	struct dma_region memcpy_region1, driver_region1;
> > > +	struct dma_region memcpy_region2, driver_region2;
> > > +	struct iommu *iommu1;
> > > +	struct iommu *iommu2;
> > > +
> > > +	iommu1 = setup_variant_iommu(self->iommu, self->device->dev_id,
> > > +				     variant->start_iommu);
> > > +	if (iommu1 != self->iommu) {
> > > +		memcpy_region1 = self->memcpy_region;
> > > +		driver_region1 = self->device->driver.region;
> > > +
> > > +		iommu_map(iommu1, &memcpy_region1);
> > 
> > Can you make a helper to copy dma_region into a new iommu? It should set
> > up the new struct dma_region based on the old one, re-initialize the
> > link field, and then call iommu_map().
> 
> Can you please clarify, I didn't get it completely. so basically
> something that can be called like following?
> 
> setup_copy_dma_regions(self, iommu1, &memcpy_region1, &driver_region1);

I was thinking something like this exposed by lib/iommu.c:

void iommu_copy_mapping(struct iommu *iommu,
			struct dma_region *new_region,
			struct dma_region *existing_region)
{
	*new_region = *existing_region;
	INIT_LIST_HEAD(&new_region->link);
	iommu_map(iommu, new_region);
}

And then in the test you just do:

if (iommu1 != self->iommu)
	iommu_copy_mapping(iommu1, memcpy_region1, self->memcpy_region);
