Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECB7083C;
	Thu, 18 Jun 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794566; cv=none; b=hz88xKXLSkJiDmRHylMD6PA/BeyYUTp+rgo+qQRhbwqZXnjb/kTossAk92HF4JG0dsBOOrW8NY9AcK2CVkt9EZc89XG+t4enI7Mdh1oKaEEECNLwYv4royXTPBsLZfENl7M/x7kvYgHwi6Q+5JBe1W3ZVdoyFQ+E0Ybe3q3DZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794566; c=relaxed/simple;
	bh=FRKyMNUgLFRc+iq6t9ed7yDPF6jq4u7MeN0Yh+y7uIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm910uvFx71UOKigPJoMFeDjFC5OvD7Qlt0fyos7PqVDKYwoOx7AwmMe8Hmc3lg2oshVoAw+JtOj9WhLNG0y6BFJCpbQPFna2RcIKYH0KXl+5Z5Mv6fqQMgZJBDi7ljMo9grHW6f3aPHYWxJrkk6k1E71wCaRcTLtP9s3J+uk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiS9zC0m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiS9zC0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08AB1F00ADE;
	Thu, 18 Jun 2026 14:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781794565;
	bh=ZLkvsKDIpeWJXlgIYVB32lBoMRPSa8FWaCkX6ep+JFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CiS9zC0mrDh/0aoZXVQlorcFy6xmC+PCNOp3WuHTuz7cdZdKqY8RZ2otrmhx7ilt+
	 kIrAL0YoWayGg6SSJqFJT5f9Eh9oIGcnNdzHpBQRnl3c2/WfZ4LM2vuIKOqqAkGEUj
	 NDJB8DUpQA1lkobsFnslqkvEOy5zMLrgKRnbLff158C2wJTlH5xul1+y5iKpcdNTsB
	 3DWE5fktuj4CP0/jGg2sBuK9UbsvmLZlxxdebJLeUn/4j34uChqgRK32ids1MtFfv8
	 EOZygVeh0uzawE5mlLvgEiXlA5R2HqcRssivaz80PI4lZ5SltFiuNK9pFN01ztFZSP
	 G3sDreBjx60xA==
Date: Thu, 18 Jun 2026 15:55:58 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, Anthony Pighin <anthony.pighin@nokia.com>, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, "Liam R. Howlett" <liam@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH] vfio: Request THP-aligned mmap for device fds
Message-ID: <ajQDVAu9b-LX8gUQ@lucifer>
References: <20260616180129.160016-1-anthony.pighin@nokia.com>
 <20260616163054.77fdb61a@shazbot.org>
 <ajKtdCN0AlbmBnAj@x1.local>
 <ajLontmFa1oRXeoK@casper.infradead.org>
 <20260617192928.GB231643@ziepe.ca>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617192928.GB231643@ziepe.ca>

+cc Ryan for contPMD

On Wed, Jun 17, 2026 at 04:29:28PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 17, 2026 at 07:34:06PM +0100, Matthew Wilcox wrote:
>
> > I don't see this as being something that drivers should be involved with
> > at all.  The MM should be able to get this right without any hints from
> > the file-provider.  Yes, that means I also want to get rid of the setting
> > of get_unmapped_area in ext4/xfs/other filesystems.
> >
> > Looking at generic_get_unmapped_area_topdown(), I think we can do this by
> > making an additional call to vm_unmapped_area() before the existing two,
> > setting info.align_mask and info.align_offset appropriately.
> >
> > Now, what's "appropriately"?  I think it's based on length (>= PMD_SIZE,
> > then >= PUD_SIZE), but we should also take CONTPTE architectures into
> > account.
>
> The info.align_mask and info.align_offset do need information from the
> driver based on what it intends to map into the VMA that is being
> created.
>
> Filesystems probably have quite different requirements than drivers
> using remap_pfn() or vmf_insert_pfn() that have locked down pfn's.

I think part of the problem here is that we don't differentiate between
drivers and filesystems, and what might be sensible for one is perhaps not
sensible for another.

We're too generic really.

With mmap_prepare we have a lot of flexibility as to what we do. That
callback is idempotent and as limited as possible, and actions like remap
are achieved through calling a kernel function like mmap-action_remap().

With that interface, drivers are declarative more than imperative, and
_they can tell us stuff_ :)

That seems pertinent here.

And I'm more than happy to have features that _require_ mmap_prepare.

>
> A pfn driver often has a single already known physical range that it
> will use for the VMA and that range should drive the alignment
> decision of the VMA.
>
> vfio in particular has common use cases where you want to mmap from
> weird offsets, but we still want to achieve a VMA starting point that
> has pa % PUD_SIZE == va % PUD_SIZE. It is impossible to do this if the
> thing building info does not know pa.
>
> I do think it makes sense that no file provider should be computing
> the VA area itself, I think I made that case when Peter was last
> working on this. Now that we have Lorenzo's mmap changes maybe we
> should be talking about supporting VFIO by having a callback to obtain
> the starting pfn for the VMA. Usable only by drivers like VFIO that
> are working with the pfn functions.

Can't we figure this out from what the driver tells us when it invokes an
mmap_prepare action?

In general I have zero trust in drivers, the right basis for dealing with
them is that they will do the most insane thing possible (and you're
pleasantly surprised if they don't :)

Callbacks are problematic, they're not neutral (context/lock state/etc.)
and you can't necessarily make assumptions in calling code after a callback
is called that you could before.

Can't we figure it out from the PFN the driver tells mmap_prepare about?

>
> The starting pfn and VMA size is enough for the mm to setup info
> suitably.

seems so? :)

>
> Maybe other users would prefer a 'max order' callback and then the mm
> would assume the VMA will be popoulated with pgoff aligned folios up
> to that highest order?

Not in favour of that, fear it'll be seen as a new go-faster stripe.  Ask
somebody how many free pints they want and they may veer rather towards the
upper bound :)

>
> > And maybe there's a CONTPMD architecture we should also consider?
>
> ARM HW supports "CONTPMD" but I suppose it is not implemented..

Maybe Ryan has thoughts?

>
> Jason

Thanks, Lorenzo
