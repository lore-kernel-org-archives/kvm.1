Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45544313295
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774099633; cv=none; b=KlK+dggSB/QNKQ6V8ZYTYD0nC56HIfRmeOj7y6E7hSS2lzUuC1hEzMRoLffd6CZe/oODrKpqjtN59coa37ZzhWN1RmX2uMtOREXy3bZ0EDstK2uOPOI+pEh+cJruuOPqfhIcY0LDIYaOCuMLuULWs7+QHL/UCd2nNFGWLSEZ82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774099633; c=relaxed/simple;
	bh=pi5Cr+wPz3p8f6WVyTUc6OTVwoqra6jg8txqrOsu920=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As2SkKiKantbm/4S/2zV9iw3tvh3gdYP7Qct5jcqBgaepvgZ+cOsjrvxmTn34L64GM083Zgwp5cXRAcw7L7wn/OMphn91TfvSgsOrMDWBx6UA9vJ1Mna/eJ5AE3yvBBgko1Fgv+XWxKHnNAKswNRoIkUBc7dYGkCzttpiuZnuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj710Goa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj710Goa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so70005ad.0
        for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774099632; x=1774704432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1Fj4N/UpgbJKkAFov6kcwTbNCL5sZLLzanhyYdr1VI=;
        b=Kj710GoaixP/N3wv+fANH+sV5Q3JoH3FJweP30Isn9sd77wRItL2THOcHQwLRVtJqd
         yOCqKJzldP03fqZ3kByeLEBdFpTKrkD9fCCYsfK7QnuQLmP6BFQNY/IPCT2Go5u0Eac1
         XCudTdsPVyw/5Z3Suo2Nx/QWM5tC0Rzy98dUSVVvxHzjwPUxRh/ziGKGKD5AalvrcDCz
         k8rozwoMDZ8TSfCAbCy7KVfBopWHPjzX3U1zZmqYCf6ZlLt7l+MMb91uexn3eQLnXWNL
         z4OroX+/TfzY3p9ppQ1pUKgGsCrij12WyPhGtBvyaF4dKUbYyb/FniaPFQOVi552neTM
         sc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774099632; x=1774704432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1Fj4N/UpgbJKkAFov6kcwTbNCL5sZLLzanhyYdr1VI=;
        b=npYRsEvf0WzhDRWsrlr/S6BaSj05vV4i9mmq9frUdVu9X/GK73hqBah/CNBN5/ZQO8
         tCw5BlzgO5+jUQtJEC22odeK+jE4qma+8GDbNYS9hcTunJC/RRWoUJHaDatqb3UlAIDg
         UdxclreULetcKthLqGe1c94zPVYOZNdRm8FbKK9aWS3hJlFGAIrs66tqcY0BlYnBiV4O
         UftGESt3AWWM7mwwPxwMhg4QuusXFC5mvlbwKXguE6UM9z1igGAuwLRUScaFNnIT20bt
         wuWIoLtlwHtwY97NwNFu/am2Q6LABjkM/gnspI5ITR7cvZLbsBfqiR3qtNaC4/k8HSCD
         I1LA==
X-Forwarded-Encrypted: i=1; AJvYcCW+3eY+Uxmwz5cnuT4O9qhO9L8Q7TAZl7ie3UTQLFV5jKS1QN82JWfVsxqSWtDKuB0ibRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGOYPjS+PQb94RENfsS0w1GwLts5s4lRyaoT/crq0qOczRGaC
	ngJCfIejP3nNRYOLdS9zodWBR8uoNGZARE2/tlsh4eoWrAIy395YT4ElDZredYbnKg==
X-Gm-Gg: ATEYQzwVNFn65q/XkAtX25RELnw6M7K/js20Sqmine5QRfSyP5Gf1wJWunjPVzDzZQN
	XqtJ6yNFkXdNnQwcQH24IuGwjTK6q++ELX25qynoRkLTBKayv2jZrivPRaSpNHa1DudPPJ++t2g
	hnkWvESpFvykskKy3jjzsh5fzeJFsB/UZyGrKACnAsdNaNPnucMFywUO3WWCkcxgdW9q04TQrht
	bVjyN1eNQmLV6MAdiN1yBbDPaoS7yhJeEGd+RbcaLvcSJ3lG1xfspJS0QN1F6hCJRGUiZ8rbAac
	SfKfq3PqKRKuOG1EcaTMXxqgSZk3xXE9OfDqguvmo93WGq5r2YsEKKrlpaMbl4sg3n12/FQWlf+
	2GwlQSnxBSjR7iDPjkh2/ivzV6QSfEhFHNbDhmAS5L7uNshYfsztgreulzV4LyqxV7MHfW83RNA
	4JmIAhjGy3J3lgycO0kl1mC1cm4F7jtkABYuDqUXT1TU56hDYNcU1dm5glquVXJ0r+YD6Z
X-Received: by 2002:a17:902:db0d:b0:2ae:d10c:6382 with SMTP id d9443c01a7336-2b08b4432c2mr2182545ad.20.1774099630892;
        Sat, 21 Mar 2026 06:27:10 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd26cde44sm1729954a91.4.2026.03.21.06.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 06:27:09 -0700 (PDT)
Date: Sat, 21 Mar 2026 13:27:00 +0000
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
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <ab6cpNWZetBokbG8@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
 <ab3R54-kyHGDEW9L@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3R54-kyHGDEW9L@google.com>

On Fri, Mar 20, 2026 at 11:01:59PM +0000, Pranjal Shrivastava wrote:
> On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
> > Add implementation of the device and iommu presevation in a separate
> > file. Also set the device and iommu preserve/unpreserve ops in the
> > struct iommu_ops.
> > 
> > During normal shutdown the iommu translation is disabled. Since the root
> > table is preserved during live update, it needs to be cleaned up and the
> > context entries of the unpreserved devices need to be cleared.
> > 
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  drivers/iommu/intel/Makefile     |   1 +
> >  drivers/iommu/intel/iommu.c      |  47 ++++++++++-
> >  drivers/iommu/intel/iommu.h      |  27 +++++++
> >  drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
> >  4 files changed, 205 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/iommu/intel/liveupdate.c
> > 
> > diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> > index ada651c4a01b..d38fc101bc35 100644
> > --- a/drivers/iommu/intel/Makefile
> > +++ b/drivers/iommu/intel/Makefile
> > @@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
> >  obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
> >  obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
> >  obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
> > +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 134302fbcd92..c95de93fb72f 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/dma-direct.h>
> >  #include <linux/dmi.h>
> > +#include <linux/iommu-lu.h>
> >  #include <linux/memory.h>
> >  #include <linux/pci.h>
> >  #include <linux/pci-ats.h>
> > @@ -52,6 +53,8 @@ static int rwbf_quirk;
> >  

[ ---- snip >8 ----- ]
 
> > +
> > +int intel_iommu_preserve(struct iommu_device *iommu_dev, struct iommu_ser *ser)
> > +{
> > +	struct intel_iommu *iommu;
> > +	int ret;
> > +
> > +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> > +
> > +	spin_lock(&iommu->lock);
> 
> Minor note: We call this with the session->mutex acquired which is a
> sleepable/preemptable context whereas spin_lock disables preemption and
> puts us in an atomic context. 
> 
> While iommu_context_addr() happens to be safe here because it uses
> GFP_ATOMIC & we pass alloc=0, we are heavily relying on the assumption
> that iommu_context_addr() or other helpers will never sleep or attempt
> a GFP_KERNEL allocation under the hood.
> 
> Given how easy it would be for a future refactor to accidentally
> introduce a sleeping lock inside any of the other helpers, I'd recommend
> adding an explicit comment here warning that this runs in an atomic
> context (same for unpreserve below).
> 

Thinking a little more about this, I think we shall instead add a
comment in the core API docs, mentioning that these helpers (like
iommu_preserve_page etc.) can be called from atomic context and hence
should not acquire any mutexes as we can't be certain of the context the
drivers call them in. 
 
Thanks,
Praan
