Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56C414A05
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574150; cv=none; b=sscoipjEyYT+ZsnAjxYfDz0tGAK3wBTBJ3opAwKpf+sxc7cbByB97VPA9mlw/H+fO8TYQ7drfMUi0PKpgT8bmpQswk5fpOtaWsPcafMGKmX7m9pZPOqHo7I4aII40Lq4Cs44/fZSeXaLyZKGAEV1LkG8L7+pDGkydXtE75+8HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574150; c=relaxed/simple;
	bh=uNLw/k438s7sFqIB+EzJBcfLEikhWYd1Gigs9ZHB/LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He1WoRlcYlOOgZSY+67ygclLrkrMVezcujc3wTEBpsX9HH1vfo+vnXKGFsF8QTm8lK5snP7nG6UYAaPvcQtU+7CbPS2VOkgMvXRAEZ9zVY5T2yak5pyI4enhsdEEtexH82ULE/wKZ9WlE30mZO7eV0Y5Ie4RRyNAjjYJscWzNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di0zh2WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di0zh2WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E261F000E9;
	Mon, 24 Aug 2026 12:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787574148;
	bh=U4ezcEfzz8/VZAfx0lIO8z3qz9ZuZUIZNaSDQ0OhLnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Di0zh2WXZitDlfyg/+0kczZLLJxLhZ7tTHr81LnmeaAAmquIVMp6w7nfDlMvDHB4Y
	 OchWpoQV+foDIacg127pBuZiVEWHdS3/v5zH/D4hXwbtsRz1TUyDJOz8n9bIGaIqUb
	 tzeLQ59qPdFCXWEpy7VtKs/YnuiwmFU32aSoM6q6Dcmv7yiUP8XFNj8eJRzhGzNMAm
	 JZONuQ17CRYBPi/j+v49GyxZcka/KTGja2mkMNCQ8BpJsdnAnE0/hYKETkV8curaJ1
	 kXm4Y0qmwAo2EzUCrpjUDejrZ+s33k/D+SvvxDrNybUscVZnCNk9tswEjZu29HRkS5
	 bp3pLZUZmgmTA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id E51C71980054;
	Mon, 24 Aug 2026 08:22:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 08:22:26 -0400
X-ME-Sender: <xms:fzeMat42oWgFkouRDmGereVYqNy8PlgF2krb8L4OtKbqhSQqJXb9Ow>
    <xme:fzeMaqJxlNtapXJKCpfkqL-UP_GX1a7q7z5qIO6KVEybEI-6ERaRVxdH9MQGPvoVe
    ckFTT3CeX7sSOS7I_B0yM8HT1uSA8QZWaUy0R2beEJ17qppvSL1z3Ls>
X-ME-Received: <xmr:fzeMagqDBFiPbA5AdpME4vMbGVzn20mihakYWU-UOZ1t4P69WVnzaFcGhyI>
X-ME-Proxy-Cause: dmFkZTFzPBghhjTvSaY9wFP1PFYc4aiefDq2IW4FK2nSs+6DIoFgMWGYDZ0c4PJUwCoON+
    f9ZrncXFWH95IKzJOWcb7dM648VH80AIaVAvThSk1wXtVdj4ozD1FDK2rXTcscUnfcAws7
    Quy0mOR4o9MEiO6OnKnCleR0xJ2uHXwDP9WsjMqZiNyNPj9KsXikTuQYBvCa0m9ddVwobX
    DPLEITv/KnknNp16u2CRLD+GXeQaFpEOQ5JhDfLLOA/fuJ2W5lCda/7SkhqF0KsrlMCZTD
    FoDRtgpB5PVbQs+nEHnXmJcR0UofeCr2KdhKBw212TK9qun9hyZ/6cdjwzcIXLrEGoCcSn
    vErvdhcgCAWvASY83vOSwYT1boU9IfeEWc+n0YCjwM0GzNkSYcyf7QoKJaFc41iXvtVcFT
    tVEVYjti5ndJK3qyds0iR45s3KQORpeLJ8FmX21e6bmdOoph11qh5n+6ZLx47aQ6pTV2d+
    Mah6a13qaSXfbzGPkD2PXpbGRSj7Ab4nkNPCiMhAxkj5xif5izE2iJpMdbZv1DB+Wu01Gk
    CORUn1ZSgTneEJO/vJt361PDcPs/UiHhzfAJpZ47UQ4AquwJsnyT9lKXWuWElbctW7uN7V
    G+t2qjv55Qy5gBPDOE8DD0zO0LXo6Q9Iqn8ckifhGyHJo+P3Ztpqjfes1K5g
X-ME-Proxy: <xmx:fzeMag4A0JzzRhbJ1Tz-balRESF4-xqax5PoD1q4jyipVvIIoKag-w>
    <xmx:fzeMakJGydL2CBSmewJ5rB_5a4PHdK4DCHtD97r4cysLt2PFfCXU8A>
    <xmx:fzeMavhU6bO_dqWTbdsL_z1QoOyqWaxhhF8lFViO8MtSdG6NtgVlrQ>
    <xmx:fzeMauEDAc4ZFYltJDuLPiTEcYpSDBYHfs-D5-UB9hHNT0bs4JPvYQ>
    <xmx:fzeMapIUwsRfp8eHagPau7hhEu5VFUokFrqh7fPfSCdNXdMA2HPtF3xb>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 08:22:22 -0400 (EDT)
Date: Mon, 24 Aug 2026 13:22:21 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rick.p.edgecombe@intel.com, yilun.xu@intel.com, 
	xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
	kishen.maloor@intel.com, tony.lindgren@linux.intel.com, peter.fang@intel.com, 
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, chao.gao@intel.com, 
	artem.bityutskiy@linux.intel.com, kvm@vger.kernel.org
Subject: Re: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the
 extensions
Message-ID: <aow2PIy1O1Z3iiej@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>

On Mon, Aug 24, 2026 at 05:18:25PM +0800, Xu Yilun wrote:
> > > +	hpa_list = kzalloc_obj(*hpa_list);
> > > +	if (!hpa_list)
> > > +		return -ENOMEM;
> > 
> > to_hpa_list_info() expects hpa_list to be page-aligned. It happens to
> > work with kmalloc for PAGE_SIZE allocation.
> 
> The struct tdx_hpa_list definition follows the TDX ABI and is guarenteed
> to be PAGE_SIZE by:
> 
> 	static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
> 
> and kmalloc guarentees the page alignment.
> 
> 	59bb47985c1d ("mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)")
> 
> So I think it's OK, not "happen to work".
> 
> > 
> > Maybe it is better to allocate it with buddy allocator instead?
> 
> It can be, but then we need an extra variable to record the
> struct page *, which seems redundant?

__get_free_page() returns virtual address. No struct pages needed.

But, with explanation above, I am okay with kmalloc. Just add a comment.

> > > +
> > > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > > +				  &node_online_map);
> > 
> > Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> > below writes every one of them out separately.
> > 
> > alloc_pages_bulk() fits the chunking that is already here, and a short
> > return can be handled per chunk. alloc_contig_pages() isolates and migrates
> > to get its range and fails TDX init outright when it cannot find one. PAMT
> 
> Yeah, this is not the ABI requirement, but the kernel's consideration. A
> brief reasoning in the commit log: avoiding permanent memory fragmentation
> and buddy allocator efficiency loss.
> 
> Also there is some discussion:
> 
> https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> 
> TL;DR
>   - The memory will never return to the kernel.
>   - There is chance that this tens of megabytes will fragment tens of
>     gigabytes of memory forever.
>   - The chance of fragmentation is actually low since at boot up, but
>     let the buddy allocator take care of these never-returned memory
>     is not necessary and lowers its efficiency.

I think it deserves a comment.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
