Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3013C555B;
	Mon, 22 Jun 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143068; cv=none; b=E6aWev+q7KLqhs/3Gc9NKoEDUTtrkV8Q9Aapdgvq9j+mMGAxXWQO7sICUqbW5j+I973Le8v5QIELbHYctjDoZZOehJqbIJcEVsWUFJW1YcDK/8MiPmqVFGNG1Fpu4D9kX053f/KSlnzIQPNwxq8MsmTomC1bCFzFKKx2SKImdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143068; c=relaxed/simple;
	bh=fdWkMEd4Nu7zsVq+F1SZFu1r9FN9YvsIiTIH1+FxItc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rID6iMyWexlChVl03w4+R3U+Hbwz+g2xzyVqAmMp2vQiit3aLe8z53qlyk8Q7GAscEtl3vGE9vlmnnempfH+9iwkK4dzMRGM+klQ8yUAtJ5v5Jf0GRXHLSDCIbVIZfVoK2K03ZT0VoDTT3gMCAkkSAeRmtvxWzg7EZ0ZjFBxIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPRA+Z0l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPRA+Z0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983001F000E9;
	Mon, 22 Jun 2026 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143065;
	bh=p5ESoRNgBLwOTBhJXSow8bOLzdmw6ZzRIPgjJzoRAI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FPRA+Z0lGhzSBNG7x40scyu5ZxhiL7xH4BQsl4PeAFpfXavbpemnvvzyVySTYGXjd
	 aimj5J9A4vRKhrNN1tUKAmdebuaMPewvpDXCak2imn+JFRSAp6Uu5+zvT4erhJIGOR
	 A3E0e4GhEcPffY12owC2uYJ4dvpIQIlFefRZiq5VsPYPt4KVsLLsV+aXM9t2Kulclh
	 qVVhqd3sRCTyrH5xF6aC+fkF8jioOlPipzE5Jwb0rgSwRIOpGYArz65BSh6K+57isL
	 novbv16+TBssOK0i5hNoCJS8DxVoSjZXS5fQPHLzylVGy4qBNssmzz8A4t6s2Ujn+O
	 nKXW/pV+wOFow==
Date: Mon, 22 Jun 2026 16:44:18 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajlX9BH4E4JncZqs@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <20260618152805.GF231643@ziepe.ca>
 <ajVqRiAMG23QGseC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajVqRiAMG23QGseC@casper.infradead.org>

On Fri, Jun 19, 2026 at 05:11:50PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 18, 2026 at 12:28:05PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > > Can't we figure this out from what the driver tells us when it invokes an
> > > mmap_prepare action?
> >
> > VFIO installs the pages via fault handler so there is not a naturally
> > existing way to pass in the pfn?
>
> Is there an advantage to doing it this way?  I understand why we (eg)
> demand-page pagecache, that's obvious.  But I've never really understood
> the advantage to taking page faults for PFNMAP areas where we don't
> really do anything, just figure out which PFN needs to be installed.
> It defers page table allocation, I suppose.
>
> > > Not in favour of that, fear it'll be seen as a new go-faster stripe.  Ask
> > > somebody how many free pints they want and they may veer rather towards the
> > > upper bound :)
> >
> > I think you need something, otherwise we will be aligning VMAs that
> > never have anything larger than a 2M THP to 1GB boundaries, doesn't
> > seem good.
>
> If Lorenzo's willing to move the mmap_prepare call earlier, to before we
> allocate the vma then we can do it that way ...

Hmm, I wonder if we could defer the get_unmapped_area stuff until later.

Taking a quick look it's actually not totally insane to do that... Let me fiddle
around with it...

Thanks, Lorenzo
