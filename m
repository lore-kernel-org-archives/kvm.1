Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6433D6EA;
	Mon, 22 Jun 2026 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147258; cv=none; b=XcNFWWtZ/PZw4jvbI5f/Ci9FPD1ZvblCnEuskXS3abu8j4tuQWPV0CrYH7raGuLaMx1r/RRnNR/BVfqVdcG1lP2XyFKqP/JVHp+xSbNc8utnOZL5zqPLULhVXvkDwfHY4aUTr9jo8jTQivo3VfE7JWOGHpSJMwi9hlXVWxMT128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147258; c=relaxed/simple;
	bh=ekb34tGbOLl4mmCxRRdPt5mbSzeRyctvnTkA7LWxmsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5KNE04lLhN/+vauxxUUEqSCZXgqO+/cjJiR0U2KKYxKSHrwXflpn+JoBsqWB4rmEiKTrJrJFG/lAzmqoidUjOTtiUTtkt9qjLwBgx4+Y52viDy1sLvS4F5vc8+2CozbeuTbt7OdU8pazT8a3S8y4Dh12b2X9pyaopYfu+qJ7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XN8Wesbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XN8Wesbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D951F000E9;
	Mon, 22 Jun 2026 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147257;
	bh=TQRxOVfPsF5zdei5YjlXmlodQ7Ot2nd16HyX3ZqLG9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XN8WesbbvyOworVWhVgscRDeNhSgZmydbPz/p4oR7VNlhMcua0LQgNIz4tMtc5Ju8
	 R/pPzDNePrsm9XRX7YPBAPbyMKML2pvegsX4SjD+N7+DKOynfQueNX8tSXmAHWa/B0
	 JVZbQAtfIdfxEXQl9LU+Jtfbcu2+9rSrayKmQKT8C7Gqxp8OyAdHw0STQ4dxvAMMoK
	 2fWqED/xcGupntj2tnbHAZjSPhJAK6G7U09Jc1BbcBogWDG3ZrE8F29muik4Rva2Lg
	 0nZhRDTFYFUVSvQyYnXSH9J0qy1OT2u8LX+ZnNJc0/MkyNb6gyycTj3dYincWe0QLu
	 OLL1yDR4Ytt2Q==
Date: Mon, 22 Jun 2026 17:54:10 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajlnTdkbmEzy_uhe@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org>
 <20260618153049.GG231643@ziepe.ca>
 <ajQRY7tHShCEz8vg@lucifer>
 <20260619131658.GA1068655@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619131658.GA1068655@ziepe.ca>

On Fri, Jun 19, 2026 at 10:16:58AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 04:56:06PM +0100, Lorenzo Stoakes wrote:
> > > > What you're saying is that offset 0 of the opened file might correspond
> > > > to a PFN that is not aligned in any way?  I had assumed that when trying
> > > > to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> > > > mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> > > > case would be 0 and someone needs to know that it corresponds to a PFN
> > > > that is misaligned?
> > >
> > > I do expect that the pgoff space is usually aligned to the pfn space,
> > > most drivers do that or could be improved to do that. There will be
> > > some off cases, but maybe we don't care, and VFIO should be fine.
> >
> > Some stuff has weird assumptions about pfn=0 at start of the range (DMA for
> > instance).
>
> Do you have a pointer? I'm drawing a blank what "dma" is?

(I am obliged to link https://xkcd.com/138/... :)

dmabuf as in [0], where vma->vm_pgoff must be the page offset
into the DMA buffer.

[0]:https://elixir.bootlin.com/linux/v7.1/source/kernel/dma/direct.c#L550

>
> Jason

Thanks, Lorenzo
