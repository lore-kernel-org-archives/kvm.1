Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8AE37DAC2;
	Wed, 17 Jun 2026 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721253; cv=none; b=lHoplXi2bKe+H9xQDF18Tzte0fY3IYRawyC8bJpBfRgZU+MMXn4NVu75ZeWScSPnxZamtcEtizxrn1E6Y7Hsv0Vok/UqH748EPXfJ3LUwi25fhNEFmw8skgDjTWIz0S9Lp2hLXBvWP6Qj/HH4f9JT+w0CO9PyHgU0NNyHxjTUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721253; c=relaxed/simple;
	bh=Ku8l8ZziIN9e1UfzJXLr93qHnpdazGN/wtk/HGa0om8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf3sAYyrtGHRE0lm12ZVSOSeEz3fnOKxrMi3ArFJaG7EWTebpZfWBhQ0gKFZMdjmnGFkv1ov0K5ssxS4YSR20zRFMGCvKUSGEKpUBAPI9H6c1bE77U2WqkOUP2kb79LIYM+HexbqxlyxKLx0lZCb0Wil76grjStTKj9D9lH6Ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rLMLw3YE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rLMLw3YE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k2GzHzkNl51kx/TX95UyoFQNPNRSdhNZlHgf3FbcUJc=; b=rLMLw3YEoEOEr4GC3HjqsVN3af
	ogDDH3MXIW5LxCe18UNZxkZbGgFXjecx3HxK5Ce7kp75qLNsTleOWoIkQsuIcQxL0BshPFQfLIBfP
	RQS6aJelEiko5Deu5BohD05WYoQyhnBegQGWhcc+FgEmGOOBAPgx+dsj1TtwFIm3LrHTYOdonbRPa
	pon9W6r06R2BzJB4L6Euv3bMJZBkTGKQebWT/h+23YSJoxkVHil433iE4OuTE9ptbcld4/f3eUzys
	raN3Ro3ag4Q7zuazH0AHrYBQpuN8lC39+9ZaCK1zTkeOkLbXZ7dCVZ0rk75B+ZAs0Rn8Os7y2Emhd
	UWr2TBYQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZv5T-0000000D6IK-05Yq;
	Wed, 17 Jun 2026 18:34:07 +0000
Date: Wed, 17 Jun 2026 19:34:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajLontmFa1oRXeoK@casper.infradead.org>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKtdCN0AlbmBnAj@x1.local>

[why on earth was stable@ cc'd?  adding/removing various other email
addresses]

On Wed, Jun 17, 2026 at 10:21:40AM -0400, Peter Xu wrote:
> On Tue, Jun 16, 2026 at 04:30:54PM -0600, Alex Williamson wrote:
> > On Tue, 16 Jun 2026 14:01:29 -0400
> > Anthony Pighin <anthony.pighin@nokia.com> wrote:
> > 
> > > VFIO PCI devices support PMD-sized page table entries for BAR mappings
> > > via their huge_fault handler (vfio_pci_mmap_huge_fault).  However, the
> > > VFIO device file_operations never provided a get_unmapped_area callback
> > > to request PMD-aligned virtual address placement from the mmap address
> > > allocator.
> > > 
> > > Before commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > > get_unmapped_area"), this was masked by a bug introduced in commit
> > > ed48e87c7df3 ("thp: add thp_get_unmapped_area_vmflags()") which
> > > inadvertently applied THP alignment to all file-backed mappings,
> > > regardless of whether they provided a get_unmapped_area callback.
> > > 
> > > When commit 34d7cf637c43 ("mm: don't try THP alignment for FS without
> > > get_unmapped_area") correctly restricted THP alignment to anonymous
> > > mappings and files that explicitly opt in via get_unmapped_area, VFIO BAR
> > > mappings lost their PMD-aligned placement.  Since the huge_fault handler
> > > requires both the VMA start address and the physical PFN to be
> > > PMD-aligned, unaligned VMAs force a fallback to 4KB page faults.
> > > 
> > > For example, a 2GiB BAR results in 524,288 individual page faults
> > > instead of 1,024 PMD-sized faults, increasing the VFIO_IOMMU_MAP_DMA
> > > pinning time by orders of magnitude -- a regression directly visible to
> > > KVM guests during PCI device initialization.
> > > 
> > > Fix this by providing a get_unmapped_area callback in vfio_device_fops,
> > > following the same pattern used by ext4, xfs, btrfs, fuse, and other
> > > subsystems that benefit from THP-aligned placement.
> > 
> > The trouble is that PMD alignment isn't right either, your 1024 PMD
> > faults on a 2GiB BAR would be 2 faults on x86_64 with PUD mappings.
> > QEMU has forced the alignment to make it optimal for some time[1], so
> > there are userspace VMM options.  Seems like you were previously
> > getting lucky.
> > 
> > Peter Xu was working on a more comprehensive solution[2] late last
> > year, but it seems there was an objection to the
> > file_operations.get_mapping_order() proposal before Plumbers and the
> > thread hasn't rekindled.
> > 
> > Gentle bump to Peter and Willy that maybe we could resurrect that
> > effort.  Thanks,
> 
> Yes, since QEMU doesn't need it, it was low priority on my list (also due
> to much more downstream works recently, and a lot of things happened).
> 
> I can definitely try again.

I don't see this as being something that drivers should be involved with
at all.  The MM should be able to get this right without any hints from
the file-provider.  Yes, that means I also want to get rid of the setting
of get_unmapped_area in ext4/xfs/other filesystems.

Looking at generic_get_unmapped_area_topdown(), I think we can do this by
making an additional call to vm_unmapped_area() before the existing two,
setting info.align_mask and info.align_offset appropriately.

Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
then >= PUD_SIZE), but we should also take CONTPTE architectures into
account.  And maybe there's a CONTPMD architecture we should also consider?

Anyway, that's my initial thoughts.  Perhaps others have feedback.
