Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F5472796
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346476; cv=none; b=tau+9UP6XCcXJk2l9ykPTfqMTB+iYy5zRPDY+TkWnmZa9xUXcWQnrjha8JarAx7V9mOq+jUaX87zAzGtaKkE4mTCt0W+j4uilbkMzpIos6L7wHQrsG6iFve1qONHOL7eSS8C4WO3Mnh318RcTpeGNEwKzxWP8rhXtgYmc46axts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346476; c=relaxed/simple;
	bh=a1vULeOR9W+2MJcJhpfReDq5fGG5A/0KdvKVe6DS2/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Em2DYkEwpTUaZ453rNdsQRN4JQmOZi+b3FTQtetonpCGmcxeifPXxfSg4ynt28myDhkLOZ35KwEgtw6rDh6pyidHQ6wnZEToard/P18HoT/CIMDKmxvXbfmtyafgqJZuOrJll1ljKNK4yuWI3EvjqdVhoPT5/7OT5QTvQC5lCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJ4DuF0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJ4DuF0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53951F00A3A;
	Wed,  2 Sep 2026 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346475;
	bh=toiCPx/Xo3CxoxeFdRWkRsbGBlbaJnbbv6UdXivnwDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cJ4DuF0xNel9voHgbF7jEGIo6ASgi+vWwKwvv7GPgZi5ugPe1WRKwICeSVz1+1qhB
	 O2QvkB5C4rpIWKSqfe+uzT6THlHsudHhtXLkcStaAoTdZagjswkXt7vqCTFhFinDXb
	 4dd7L+Cjs50oHI0KuqdnLYsH9YqdPFQgDsuHCoIKd6oQAx2ThuHxBTvXnvs5Aaou/x
	 uXj6m2PzxUYwXBmpvdSPZC8ksvXJRSALxRdprqVB9SvQRUzP/yU157F/403AzU8v0B
	 o96cZBlMB16fPH2A3l2J8T4v/R1R5z4PbdBhuzv2MD4ocBSkohiE2i9kpOzOow2sEg
	 HTwygDlO8H7DA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id 819FD198005C;
	Wed,  2 Sep 2026 06:54:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 06:54:30 -0400
X-ME-Sender: <xms:YgCYarXBvjvZGqPEtJ_y73RXDYypiATMN4F4hljLdpW9z6Ne1whWAQ>
    <xme:YgCYapv7p1ifq_V19ZZx_TLDwEkw6wB7DiL-mD5O7Tg6MdHk9KmiOMoLY85KEYx2l
    OkmEp6XU01Ho0hcvdzMN5lN6g15ovu7u5IV3Bn5tHlHztVMBgy5QJI>
X-ME-Received: <xmr:YgCYat4UqdISDI2sgAmbeEOGPepGlpyWlHK8r40159UtVyXbY3gptW6CA2s>
X-ME-Proxy-Cause: dmFkZTGyzMkWjg7IQnEoIuXNQDp6x76pYUr/rcWepSAosl6HnZGHMGZrOsuoHHWZ2rorFR
    zigkDOWu1PcgQYHXoVRDHrqDSZRPr+5W4Vg0KX2Li1EjI8OOqXrM6xWmq9bsPUuLwKI17R
    j+EumYXVk6yj2jr9bKHQGhGz+CQ1JYJPM0pE+aq29uv+Rb2waUhGeanqn55pH7ar0s5w3y
    JJsNPTDmEs9Sw0IgYXtyurhLAvBXoprebD+atHmZhq3GEi6lE8ND0Ffm8P/3qksPTNP7g7
    DH1Tr8GiUcpyGdivOsuUqfCGwxdfY5r6Sk6gY5ajvKl4Q4HANcgM2hcvNwcVp6lCDSFUJd
    WcrkC1qw+Wp4Dpmcvp2SeQ4tDHgJfSU3J8A7Ao2bGeBPxEd/v8mvtT5M2F+YKBGRxp74lk
    3E0AjxjyL+n4qePADWK0VQuFnAY9bGF/jyEC8rVztUz/JIWn9ls4pJd8bNOWKA0xLPMk5X
    Fxn3GdaNZFu2GZXRybqiVA5Mp8l6C2WCvHTGbuP9wGbXYkFK2xbmqYEiClq4IXBYlO9Lg2
    Oi/8gwZH1fsTrFpxGg1STby8abZb1JOuuFyZ9iO4cagnlwKABSgao8wBhS7NhcVxLiC3FF
    AS+dMGOfEdyog41YR0Myj0kT+ddpqc9FBMJfGGKV8zsoLh+QSfxUoZ+903Mw
X-ME-Proxy: <xmx:YgCYagXs_SukH0KtqMtj0ndW_s7zzQgp7LZE5wo0QeOpwIuQcmpuvg>
    <xmx:YwCYapMbzZqFzG8qUBbzyFGqPlH03_gFXtUyvXKdkokvmWwteTkL1Q>
    <xmx:YwCYanE4Elqi6EoyImY-flnTh6H7vB6Mlc05Cs6_NFY_9DnllTiCcw>
    <xmx:YwCYauo0UVEPy1YrgD19E_eDeuVtQmap5rE78Eb6qiXIrSG80H5_Tg>
    <xmx:YwCYagq0aItg5HtoPeiTvEu_paJqAxqB2A54EUW3Lji8vBkefS-5AbRm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 06:54:26 -0400 (EDT)
Date: Wed, 2 Sep 2026 11:54:25 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: david@kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, 
	yilun.xu@intel.com, xiaoyao.li@intel.com, sohil.mehta@intel.com, 
	adrian.hunter@intel.com, kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
	peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
	chao.gao@intel.com, artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <apf6WFKun8z4ejG8@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
 <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>

On Fri, Aug 28, 2026 at 03:46:16PM +0800, Xu Yilun wrote:
> > > > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > > > +				  &node_online_map);
> > > 
> > > Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> > > below writes every one of them out separately.
> > > 
> > > alloc_pages_bulk() fits the chunking that is already here, and a short
> > > return can be handled per chunk. alloc_contig_pages() isolates and migrates
> > > to get its range and fails TDX init outright when it cannot find one. PAMT
> > 
> > Yeah, this is not the ABI requirement, but the kernel's consideration. A
> > brief reasoning in the commit log: avoiding permanent memory fragmentation
> > and buddy allocator efficiency loss.
> > 
> > Also there is some discussion:
> > 
> > https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> > 
> > TL;DR
> >   - The memory will never return to the kernel.
> >   - There is chance that this tens of megabytes will fragment tens of
> >     gigabytes of memory forever.
> >   - The chance of fragmentation is actually low since at boot up, but
> >     let the buddy allocator take care of these never-returned memory
> >     is not necessary and lowers its efficiency.
> 
> Hi Kiryl & David:
> 
> I see there is another suggestion that the whole memory adding process
> could be a little simpler if we allocate & add pages 4k by 4k [1],
> rather than one-time pre-allocation. The concern of this alternative is,
> as said above, memory fragmentation.
> 
> [1] https://lore.kernel.org/lkml/f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com/
> 
> And I've realized the memory fragmentation discussion is not actually
> closed in previous thread [2]. We need more input.
> 
> [2] https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> 
> Let me give a brief overview of the problem:
> 
> Intel TDX (Trust Domain Extensions) is a feature for confidential
> computing. A secure firmware called "TDX module" runs in an isolated
> environment to provide services about security.
> 
> In Linux, the host initializes TDX module at boot up time
> (subsys_initcall()). During the initialization, the host must donate
> tens of mega bytes physical memory (35M ~ 110M in the forseeable
> future) to the TDX module. These memory will *never be revoked* cause
> the TDX Module initialization is a one way path.
> 
> The TDX Module doesn't require this memory be physically contiguous. But
> the kernel side concern is if we do PAGE_SIZE allocation, it may
> permanently fragment memory regions, stop them from allocating 2M huge
> pages. In worst case, ~50G (110M * 512) memory regions affacted.
> 
> So is the physically contiguous allocation really a better choice here?
> We appreciate inputs from mm folks. Thanks!

What matters for fragmentation is not contiguity, it is how many
pageblocks are left partially occupied by unmovable pages that are never
freed.

So you can ask one pageblock at a time with

	page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, order);

with fallback to lower order if you must.

It also fits the ABI: pageblock_order is 9 on x86, i.e. 512 pages, which
is exactly TDX_HPA_LIST_MAX_NR_PAGES. One allocation is one full HPA list
is one TDH.EXT.MEM.ADD, so the allocation loop and the chunking loop
become the same loop.

But alloc_contig_pages() might be a good enough approximation for
per-pageblock allocation if we do it during the boot when fragmentation
is low.

My alloc_pages_bulk() suggestion is wrong. It doesn't get any control
over allocation placement. It will tap in the per-CPU cache first.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
