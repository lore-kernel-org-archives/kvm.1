Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DB3F1AC0;
	Thu, 18 Jun 2026 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795055; cv=none; b=LhKBVlsfvfNd+7JFfhFB5nI/h05CI0YffidIca300213oRlITBOpjysEP3ENv1dREpAM2IncrEj/4yiDc66xTvhBap0AHrBhNVj5Aby2hvztk5VxRKKBp5PMhLXbAr3jWmab1NWBjIZ2Nnd52aVH41lHeFVa9a5hqPpz8h7kZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795055; c=relaxed/simple;
	bh=kD827D5iHR0VdTKbWeEy94VEZsfBo+L6x5LFcgECw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptj1x77R5Jsi8ssLqUgCzT3Ur1DVBavWZ213OGTPnGc/Asyl5C9hVn0dw794lPvqsrkhQTTsHsjL3H21in+/WVqUlJ0KG/O2j+QVvX9HpehpBwI2Xwac5h+lNDWMwdMGgD+EsPuqGHewmpVz2Fa1KTlkX6bEN8IN5RsljLU9cQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SF/PORqp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SF/PORqp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pj1LJnEZThUPRDCPw/ddyQud/xNuwBpvVNgUlXrrtvE=; b=SF/PORqpkg0kCgRphkeuENfFd9
	wCXnMjP8c9ILbJLdRvs6FLh3y1X2oxLMpXHhH/IsY2Sff4mcf0IpgB6qVrUhZmkUYuqlOf+0+Vf6/
	9z322tTOb9G9IWnsLzKzBgrLPajTeLfq32luz0COaSbynUe8v++U41DSM5fSz2P2gv9n8jgovrprn
	Ul5IJVBr8OHC0tyt/HuPgNbd0q9wjmP4ykVlAeXt+ZLjVNFrblsNyn5tfjlYuh1M3bxVbpOz1oXV7
	3nTcYg/jzOPlEDXZFmJNSzvWx8MaSlCskF5Hu/aJ7SGxoZW3bqubI2nLENqLyOzApaw2XQH8davpw
	hLW+UDTA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waEHm-0000000EdL2-1a1t;
	Thu, 18 Jun 2026 15:04:06 +0000
Date: Thu, 18 Jun 2026 16:04:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajQI5jMJpxyNZCLN@casper.infradead.org>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajQDVAu9b-LX8gUQ@lucifer>

On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jun 17, 2026 at 04:29:28PM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 17, 2026 at 07:34:06PM +0100, Matthew Wilcox wrote:
> >
> > > I don't see this as being something that drivers should be involved with
> > > at all.  The MM should be able to get this right without any hints from
> > > the file-provider.  Yes, that means I also want to get rid of the setting
> > > of get_unmapped_area in ext4/xfs/other filesystems.
> > >
> > > Looking at generic_get_unmapped_area_topdown(), I think we can do this by
> > > making an additional call to vm_unmapped_area() before the existing two,
> > > setting info.align_mask and info.align_offset appropriately.
> > >
> > > Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
> > > then >= PUD_SIZE), but we should also take CONTPTE architectures into
> > > account.
> >
> > The info.align_mask and info.align_offset do need information from the
> > driver based on what it intends to map into the VMA that is being
> > created.

What you're saying is that offset 0 of the opened file might correspond
to a PFN that is not aligned in any way?  I had assumed that when trying
to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
case would be 0 and someone needs to know that it corresponds to a PFN
that is misaligned?

> > Filesystems probably have quite different requirements than drivers
> > using remap_pfn() or vmf_insert_pfn() that have locked down pfn's.
> 
> I think part of the problem here is that we don't differentiate between
> drivers and filesystems, and what might be sensible for one is perhaps not
> sensible for another.
> 
> We're too generic really.
> 
> With mmap_prepare we have a lot of flexibility as to what we do. That
> callback is idempotent and as limited as possible, and actions like remap
> are achieved through calling a kernel function like mmap-action_remap().

mmap_prepare() is called too late.  We've already assigned the virtual
address range before we call __mmap_region(), and there's no attempt to
adjust 'addr' in __mmap_region() after calling mmap_prepare().

