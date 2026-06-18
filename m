Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115B263F5E;
	Thu, 18 Jun 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798173; cv=none; b=b6k59s4ypjrqX4MthG2hnFOmY3rTJTvY+va09FZzfs2S/3jK51+m6kh/fnQ/jf+/nfO05ObkryusqFlG1gGz/o5swmXVS7vbcH4gah16RxlV1h5jVgtO4nYYhyj5fy8BgOsIXpty7I27lf+6LxKmFC7LaNCqYagrLa5N2RBK/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798173; c=relaxed/simple;
	bh=ECvNqpLLds/xR3t/zrIA8n39iFk9FOHpuZijVEn8wQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0sJ9vng5exaABHd3M1KBSrQDJgPheJLu4WAthZJI2qOit3G01mwiGx1AYwOfYGfjVbFauoeSvul9KR34Aix5Aqr+FSDwN3tw7nIFPtFWr2bo44ijVF9rCgeNBzA3zHrdXWhZbBScca57eIMfuR3Xerog/9O8muGxZh3OUU9sLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Ppr8oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Ppr8oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9B01F000E9;
	Thu, 18 Jun 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781798172;
	bh=0IPDtr0E5+xfAyCrxjr92IdLXpNLF4y4zjRjFT4Sj10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n5Ppr8oTbsOSG6YshsqBhUNoHlscayzOxfcTXj/PDj5/OnEbF0/qlDY6o7NZNha5m
	 HgjQSOS/r4R/SKtM82iyRJCAQPfrDYAnCU4z9PtxfI7+eBN932mRCKDXQNtZaAGIAx
	 UyRPSynU6cGlCR6F4R3o5pzmitLFpjFP3ZDn+cDIDqghlYynP2Y2psERaPm9qceNfy
	 4XdgjEMq/4X/fxKfNO1B2JaBSZ3+RFh40OMM4M2CB+NTaU8K68b8ic6+PxzjXsVsqb
	 NS7stYaETFJJGEWippfCuKv23o3Bnf2Mm4hOQ+uZz21mpSRU3I2Aj77ZZMQn9CtWrA
	 pGcw6v85wavEw==
Date: Thu, 18 Jun 2026 16:56:06 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajQRY7tHShCEz8vg@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
 <ajQDVAu9b-LX8gUQ@lucifer>
 <ajQI5jMJpxyNZCLN@casper.infradead.org>
 <20260618153049.GG231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618153049.GG231643@ziepe.ca>

On Thu, Jun 18, 2026 at 12:30:49PM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 04:04:06PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 18, 2026 at 03:55:58PM +0100, Lorenzo Stoakes wrote:
> > > On Wed, Jun 17, 2026 at 04:29:28PM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Jun 17, 2026 at 07:34:06PM +0100, Matthew Wilcox wrote:
> > > >
> > > > > I don't see this as being something that drivers should be involved with
> > > > > at all.  The MM should be able to get this right without any hints from
> > > > > the file-provider.  Yes, that means I also want to get rid of the setting
> > > > > of get_unmapped_area in ext4/xfs/other filesystems.
> > > > >
> > > > > Looking at generic_get_unmapped_area_topdown(), I think we can do this by
> > > > > making an additional call to vm_unmapped_area() before the existing two,
> > > > > setting info.align_mask and info.align_offset appropriately.
> > > > >
> > > > > Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
> > > > > then >= PUD_SIZE), but we should also take CONTPTE architectures into
> > > > > account.
> > > >
> > > > The info.align_mask and info.align_offset do need information from the
> > > > driver based on what it intends to map into the VMA that is being
> > > > created.
> >
> > What you're saying is that offset 0 of the opened file might correspond
> > to a PFN that is not aligned in any way?  I had assumed that when trying
> > to do the mapping of (2MB+4KiB to 64MB), that the offset specified to
> > mmap was 2MB+4KiB.  But you seem to be saying that the offset in that
> > case would be 0 and someone needs to know that it corresponds to a PFN
> > that is misaligned?
>
> I do expect that the pgoff space is usually aligned to the pfn space,
> most drivers do that or could be improved to do that. There will be
> some off cases, but maybe we don't care, and VFIO should be fine.

Some stuff has weird assumptions about pfn=0 at start of the range (DMA for
instance).

Presumably not applicable to VFIO but that's a thing we need to stop
doing... (I have some patches I deferred from a while back changing the DMA
stuff).

>
> That is certainly an easier place to start.
>
> Jason

Thanks, Lorenzo
