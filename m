Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD661243367;
	Sat, 11 Jul 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783759094; cv=none; b=N0/FggPgM0/zGpVfgeorqpNwujT/k/6XvHmSIasdEdPcxvF1KkzYxTFLU8jyTi1AR5XxiXAAF6CXYm2581moZSZq0rDcQsiAyucTLcFGXEHUT0dW3qVxTgDbYaXyZDu9A/YvpcA5pjrwht6d37R19Bh3rvoDQZt8b068fkeGiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783759094; c=relaxed/simple;
	bh=CyRaJPcTWVJNhdmwT9EN24t6ISjiq/A84da/xrY/4Vo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=i7CCwY3+rSh4pAOA76A6hr/3FexAFmJBo+gsiDAGP7fCfhT/LKMePt9VGWHeKgJ1bIgmC0+tVYSBGnku+fdEYcl/vSUmnnSHjZ4TbBj8wzXXwMcSi2hC2fgfD/ByCI//MHkEmNvzK7nEluRlYoAujz30Zu+T2gzO2nmVFk3vZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BY+Mmh8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY+Mmh8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667921F000E9;
	Sat, 11 Jul 2026 08:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783759093;
	bh=BzbbZ75tk0Gn1LrlFpT1UxEwPwXypDF6thZXD0DNZlY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BY+Mmh8/jRilUEL9EUyh64uk3XDuqoCgdDxAwxDMiucPAy+8WcCaH9Ro1jHnLGy01
	 gCkb5GbNgGWXVZnZkM5gZlt/9X2jol+Gy40MZGt0bmxkNEDwYrXeUTPJdgVTtO5ZVt
	 WK5gNNgBBUbW4ZOLGJCBWVON0cholPeLMi4pXA11dGIvzsTCH3D7jioxJIhvgVPsKH
	 O/N5qUHiKNciqobi+VvsWkvXEfJXdwf9ExS/NaFZKsc7r/i6rmWFiGumfqyqM7Am4a
	 H6kjsfC8N42inUSM811TIZoIVSSTFL2tj/aeVHSNAw7QeG91L8mozBqJGsWv7twIhc
	 gIu7PK9tQco7A==
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 Anthony Pighin <anthony.pighin@nokia.com>, linux-kernel@vger.kernel.org, 
 Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
 linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
 Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260630124629.GE7525@ziepe.ca>
References: <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local> <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca> <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org> <20260618153049.GG231643@ziepe.ca>
 <ajQRY7tHShCEz8vg@lucifer> <20260619131658.GA1068655@ziepe.ca>
 <ajlnTdkbmEzy_uhe@lucifer> <20260630124629.GE7525@ziepe.ca>
Date: Sat, 11 Jul 2026 09:37:59 +0100
Message-Id: <178375907930.146648.4528264473005431141.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=ljs@kernel.org;
 h=from:subject:message-id; bh=CyRaJPcTWVJNhdmwT9EN24t6ISjiq/A84da/xrY/4Vo=;
 b=kA0DAAoWz53NioHifxQByyZiAGpSAOiiJdkLwOBNYMQ01kLLPZdUye72/Ik5n7i90gLpnzNQ5
 Ih1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmpSAOgACgkQz53NioHifxTT3gD/Zw3+
 WKEGhLawmfopUhw+JxYey8s/tP1cc7qS8Hwo83YBAM2u9V8WmkkvOpEFTVv/K3q4Vb7NxE+pRuG
 uZp1xjdwG
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

On 2026-06-30 09:46 -0300, Jason Gunthorpe wrote:
> On Mon, Jun 22, 2026 at 05:54:10PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Jun 19, 2026 at 10:16:58AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jun 18, 2026 at 04:56:06PM +0100, Lorenzo Stoakes wrote:
> > > > > > What you're saying is that offset 0 of the opened file might correspond
> > > > > > to a PFN that is not aligned in any way?  I had assumed that when trying
> > > > > > to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> > > > > > mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> > > > > > case would be 0 and someone needs to know that it corresponds to a PFN
> > > > > > that is misaligned?
> > > > >
> > > > > I do expect that the pgoff space is usually aligned to the pfn space,
> > > > > most drivers do that or could be improved to do that. There will be
> > > > > some off cases, but maybe we don't care, and VFIO should be fine.
> > > >
> > > > Some stuff has weird assumptions about pfn=0 at start of the range (DMA for
> > > > instance).
> > >
> > > Do you have a pointer? I'm drawing a blank what "dma" is?
> >
> > (I am obliged to link https://xkcd.com/138/... :)
> >
> > dmabuf as in [0], where vma->vm_pgoff must be the page offset
> > into the DMA buffer.
> >
> > [0]:https://elixir.bootlin.com/linux/v7.1/source/kernel/dma/direct.c#L550
>
> That's not "dmabuf" that is the DMA API's dma_mmap() interface, very
> different thing. This could probably be reworked if it is some issue..

Yeah right that's what I mean. And I plan to do some rework around that as part
of mmap_prepare() I have some slightly bitrotting patches for this that I'll
shake down at some point...

>
> Jason
>

Cheers, Lorenzo

