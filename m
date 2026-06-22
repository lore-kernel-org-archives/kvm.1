Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED53B7B8E;
	Mon, 22 Jun 2026 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142941; cv=none; b=UhiGIxZwY3YMfOkWS7Z/rOxuEb+6X9yJDJy/GjACuvDNn7UQ7K+d89YKpqG+f/Xz9NKtck6+tl37MGNQmnfhoo526fxRmdHLbvUAaYh7mY2yjMgHyEAWASC1BI/g/B4SS0g336vAmXRbqftrGWodVzG/A6kzbHPGQ2dhVwWzzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142941; c=relaxed/simple;
	bh=QXBzMP0iTF5JDPcGCbupnktzxlpYGrf12AoNQm5c6fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf4+FCaBvvnyHDjUCXt8eangBTZlBwEbvQFIYzJZ1kr76hhtBND4GjGM7RsDNI3g9LnafHjKgu6MrLvd2o2UjLnLO3+EQhf7ciPk/OleSx2an0FCy7c+exJQkmkyQdv2efke5Tjw9VeTv2QwaWOCJZpiXXIUqBbMz62GoSglQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ltwk5GUW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltwk5GUW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4371F00A3A;
	Mon, 22 Jun 2026 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782142940;
	bh=yHJv21RfcqXYV0YgHyAqjEAPgB65Hb7a4g1x/AwkD00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ltwk5GUWhRx19bhrpVQNuxrvfV3dfh40QSCrkheU91HyybacQU85c3GMCppUlDQTd
	 48tsMRIj4CFkV/DnoBZ0OjAieDfe5D1NwLhFxfURcGtIhYZwRmI/QtKXD1NJNpR9GG
	 HrA7oLczj4LM3R0AyLGiCvI3yl+qZTcSiaoNl7i0lk7iszDJOQeXIK9rCEa6Y0UFLp
	 FT2kHC1JeNm6z/IuYLfbtBlJN3wvLpoy6aUP6fGyUMYq4QmnJm+mF+dNjXhHDs29t+
	 caNmnwIbycjTfMwikiu6s74ishOOx+rigFzBj1TbmUg+gz8RLQZZDzAKmAW5vEHo0R
	 36XazeGrmW8qw==
Date: Mon, 22 Jun 2026 16:42:13 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajlW-Lf_tSBMccw1@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <20260618152805.GF231643@ziepe.ca>
 <ajVqRiAMG23QGseC@casper.infradead.org>
 <20260619170705.GC1068655@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619170705.GC1068655@ziepe.ca>

On Fri, Jun 19, 2026 at 02:07:05PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2026 at 05:11:50PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 18, 2026 at 12:28:05PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > > > Can't we figure this out from what the driver tells us when it invokes an
> > > > mmap_prepare action?
> > >
> > > VFIO installs the pages via fault handler so there is not a naturally
> > > existing way to pass in the pfn?
> >
> > Is there an advantage to doing it this way?  I understand why we (eg)
> > demand-page pagecache, that's obvious.  But I've never really understood
> > the advantage to taking page faults for PFNMAP areas where we don't
> > really do anything, just figure out which PFN needs to be installed.
> > It defers page table allocation, I suppose.
>
> VFIO has a model where the mapping can come and go, so it makes the
> entire VMA SIGBUS from time to time. The only way to do this currently
> is with faulting.
>
> The mm also had races around populating the mmap in the mmap callback
> and using zap on the inode, faulting avoids those too. Lorenzo may
> have fixed that with the new interface though

Well, you can't populate the mmap in .mmap_prepare, we do it for you.

I guess the issue there is an race with an rmap walker? I did add a (slightly
hideous) hack^Woption that keeps things rmap-locked until after the 'mmap
action' is complete (action->hold_rmap_lock).

So perhaps with that that issue is addressed?

I am figuring out new APIs for mmap_prepare as I carry on converting based on
what people are doing so I guess when I come to VFIO I can do the same thing
there.

>
> Jason

Thanks, Lorenzo
