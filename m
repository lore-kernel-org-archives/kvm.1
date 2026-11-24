Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541166;
	b=xOA2cX1xQZC2iu3T1vuxffvAwHA0IciwZ65GJ4PmYZNeq6bB8Xb7+wpS51gZUYCLJFle
	 HnNB6srFlZ6asmeVAkbXe7ME4mgz6Pu8NPnWAe4K2qMZf4hjUsdzptXbi16mhq5p8ZrRj
	 EewQn5qTIAT0kyDj5xL4chqbhogW+W4C1USEtDXmwUF2dVsgeIgnGs1apRaw/PpDWrY1M
	 PcltrAhvHKmaO2UkhPCFmX/ztp9nSg/gMwa7gGFouI7k3GKCaDdJFJ3bbdb47wXlk7715
	 Jp4E7xVbHn0r3jujMDkyzXaLw19u8rpUJV6pw8OoysP+Tu0MK4rs4Tnd5/AZxFQkDUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pB0hPyMKD+vhgJUDCKouLHukFV8UEhyvi3gGX1fNKGI=;
	b=sRbjzXnBnQIJaXSR/F+y9HUFHtj3vdogwHgMFraHjg/rPlDyCOcZSHrIMUlp8vd9m+wI
	 y5D0KGJTXRdrRGzAGLUj+lyWtmfMIFD448dpBgTRUO9zdi4ULMYufB43WyiS8nafgthfh
	 flTDBGKnxO7iJVaxA/EvxC0cJTHkktHYqRkPvOBBeBv09JM+SQpptN5AZOfC9NH6KjW11
	 lBJozZRSLwA0FqJZKepoC0sHOuBtFDQlkCzUC3nQ/7q7wIKVbq6ZOBSFaiJct/NnjVDmc
	 yOaAx4bAd3TBNdAtHru0N1XnFQFuBGjkvtm6YVxcyRx+A6q+1fhvIV9b2MTUMwcXUFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8zCkc0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C069606A31E;
	Tue, 24 Nov 2026 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8zCkc0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5031F000C0;
	Tue, 24 Nov 2026 17:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795541166;
	bh=pB0hPyMKD+vhgJUDCKouLHukFV8UEhyvi3gGX1fNKGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8zCkc0+9DGyKOLaZmgiI/zvuJpIqGArGooiio8dDQ8y0ZQMzzF6+WSFDgEvoEi/I
	 tvKFVBR+9P8UZLZuzz4+PON5jL1tUEB8UgA8ZMNtbJ9XdZPS20a/JVrIaSRIPRH7r/
	 aQqS7FXBR36BwXPAQrkI9plVuB0zVwYPqzzEOUCAZBWSZVCSVrsarp0Fy4v/x39AJk
	 ci7/IOPmZZKkP8haGJfpEEQ97Agfnqu9KDDpVR3M8DOVqJ2Ec5eLTjhunyxtWyPQGf
	 Ci7JHCiz3jniJf95hTT1gd1WWx69Pcq2Gy/BPjo0fn0X8qvFzARV0AA2YdhURM5Nqa
	 9CDmXB4t+yAxQ==
Date: Tue, 24 Nov 2026 17:25:59 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, linux-mm@kvack.org, 
	alex@shazbot.org, alifm@linux.ibm.com, ankita@nvidia.com, dakr@kernel.org, 
	fengchengwen@huawei.com, kevin.tian@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mattev@meta.com, ritesh.list@gmail.com, xinmengs@nvidia.com
Subject: Re: [PATCH v2 2/2] vfio/pci: Align BAR mappings for huge page support
Message-ID: <awXIcSgV_YOke9yW@gremlin>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>
 <20261124135258.GK9566@ziepe.ca>
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
In-Reply-To: <20261124135258.GK9566@ziepe.ca>

On Tue, Nov 24, 2026 at 09:52:58AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 24, 2026 at 08:40:04PM +0800, Guanghui Feng wrote:
> > +unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_vdev,
> > +					      struct file *filp,
> > +					      unsigned long addr,
> > +					      unsigned long len,
> > +					      unsigned long pgoff,
> > +					      unsigned long flags)
> > +{
> > +	struct vfio_pci_core_device *vdev =
> > +		container_of(core_vdev, struct vfio_pci_core_device, vdev);
> > +	struct pci_dev *pdev = vdev->pdev;
> > +	unsigned long align, off, off_end, off_align, len_align, addr_align;
> > +	unsigned int index;
> > +	u64 bar_len;
> > +
> > +	/* Don't interfere with explicit address requests or fixed mappings */
> > +	if (addr || (flags & (MAP_FIXED | MAP_FIXED_NOREPLACE)))
> > +		goto out;
> > +
> > +	index = pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> > +	if (index >= VFIO_PCI_ROM_REGION_INDEX || !vdev->bar_mmap_supported[index])
> > +		goto out;
> > +
> > +	bar_len = pci_resource_len(pdev, index);
> > +	if (!bar_len)
> > +		goto out;
> > +
> > +	/*
> > +	 * Select the largest huge page size that the BAR physical alignment,
> > +	 * mapping length, and arch support can all satisfy.  Only PMD and PUD
> > +	 * orders are supported by vfio_pci_vmf_insert_pfn().
> > +	 */
> > +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) &&
> > +	    bar_len >= PUD_SIZE && len >= PUD_SIZE)
> > +		align = PUD_SIZE;
> > +	else if (bar_len >= PMD_SIZE && len >= PMD_SIZE)
> > +		align = PMD_SIZE;
> > +	else
> > +		goto out;
> > +
> > +	off = pgoff << PAGE_SHIFT;
> > +	off_end = off + len;
> > +	if (off_end < off)
> > +		goto out;
> > +	off_align = round_up(off, align);
> > +
> > +	/* The mapping has to span at least one fully aligned huge page */
> > +	if (off_end <= off_align || off_end - off_align < align)
> > +		goto out;
> > +
> > +	len_align = len + align;
> > +	if (len_align < len)
> > +		goto out;
> > +
> > +	/*
> > +	 * Find an area that can hold the mapping plus the slack needed to
> > +	 * shift it up to the next aligned address, then apply that shift.
> > +	 * The shift preserves the relative alignment of the file offset,
> > +	 * which is what makes the pfn alignment work out.
> > +	 */
> > +	addr_align = mm_get_unmapped_area(filp, addr, len_align, pgoff, flags);
> > +	if (!IS_ERR_VALUE(addr_align)) {
> > +		addr_align += (off - addr_align) & (align - 1);
> > +		return addr_align;
>
>
> PeterX was working on this previously and last time I was not excited
> to see all this mm logic open coded in drivers.
>
> I was hoping to see that the core mm could provide some helper scheme
> for drivers that already know what they want to map to get a vma
> alignment that is optimal for the architecutre.
>
> Peter had a design that seemed like a good exploration at least..

Well you and Matthew and I were discussing something similar previously also?

The AI fixgeddon is delaying any nice-to-haves of late, but in spirit yes, it's
appalling to have this mm code duplicated and it clearly shows a gap in the API.

>
> Jason

--
Cheers, Lorenzo
