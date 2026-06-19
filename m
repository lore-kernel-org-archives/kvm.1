Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9813B7B8E;
	Fri, 19 Jun 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885521; cv=none; b=qyRTOLlboysJSs5RE6uP+ZlOrlIMjd5qIbgUTa20O1o+tiBOUZxfV7+SHPQM0CzKTkUWyGQITyLHPn2sSPGZRH0F1HV2xP++ffGCJNJPCL3UqAaUA1iFZz6VSOCcya3GxzlL10nrxEBhmLbeoMFSQnIbyRbgOTq6ts7N7F5Kb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885521; c=relaxed/simple;
	bh=cM/nfnwo1mrNF7wwQizVlzPfBi+rohyNPFqeKuT1HDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJWypi+i3MOsIoXTC1fyyi7aExbCmeqC3mUZioZWGYKnLxjvEktbJXNf5HLwLXPYQ4kFv1ciWFKBfHnxVDTHXyQ4xLtf1s+bfjeDHsLOE80Ep7SyL5nB9ZqH+evYiL24+Wl+f8thHRP5evIkMT48yvoMBrEztZvRH9Lt+sRq74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J8ZZ3toM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J8ZZ3toM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pzyfc0EV0DVFxoCXoE+wDAyuQ9YJFC9tEGOxfy5XavM=; b=J8ZZ3toMwIYOXPEDK90lLyAsYu
	soePp3G/naanNY8eL5d1gaoCWf2BSEaWww9XlJ2NtwEtH3wJIUkD2Xz7WoHEKj/K0YCXIrPXRFmXy
	KQssQMTI5BrMTpJA+P4xx9U7BIHdSUZsRXa5e52ui+FrXuTFkY0GIl14piQLe7NGC/jtz+YxGjFsq
	IA7oS+DGjhq9gbC2D67cwtfJrAdSiLMfqqFgwASF5wBCWfYnDU5RYxJVJLcwQqnKzGpqIZw47V7G/
	zv+JLng5tc3D1XlW5Nw/swlNDgH5O7KkGXxrmvbogkf1Yw01EGJcWO63vZrzptSU92LXL9xmzSBVJ
	CxDMjbzg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wabos-0000000GVXZ-3IRi;
	Fri, 19 Jun 2026 16:11:51 +0000
Date: Fri, 19 Jun 2026 17:11:50 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Peter Xu <peterx@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Anthony Pighin <anthony.pighin@nokia.com>,
	linux-kernel@vger.kernel.org,
	Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org,
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajVqRiAMG23QGseC@casper.infradead.org>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <20260618152805.GF231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618152805.GF231643@ziepe.ca>

On Thu, Jun 18, 2026 at 12:28:05PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > Can't we figure this out from what the driver tells us when it invokes an
> > mmap_prepare action?
> 
> VFIO installs the pages via fault handler so there is not a naturally
> existing way to pass in the pfn?

Is there an advantage to doing it this way?  I understand why we (eg)
demand-page pagecache, that's obvious.  But I've never really understood
the advantage to taking page faults for PFNMAP areas where we don't
really do anything, just figure out which PFN needs to be installed.
It defers page table allocation, I suppose.

> > Not in favour of that, fear it'll be seen as a new go-faster stripe.  Ask
> > somebody how many free pints they want and they may veer rather towards the
> > upper bound :)
> 
> I think you need something, otherwise we will be aligning VMAs that
> never have anything larger than a 2M THP to 1GB boundaries, doesn't
> seem good.

If Lorenzo's willing to move the mmap_prepare call earlier, to before we
allocate the vma then we can do it that way ...
