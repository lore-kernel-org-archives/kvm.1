Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4B407CD0;
	Thu,  3 Sep 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788433268; cv=none; b=Dmrw+Eq9xPlqjHpeppUf0lTrroZsIedv97O5141zHlHBKRs50RTMNBKmiOhrlVE1JxEeswHhvULHuIQ+SRJVVt3RWKWK4HZkLvQ/JL9he9Rs16WUvvdM5L4jAGEv9n0uLIaO7lnITpyzP23UpL3reC/vP6JR3XMY3F3DOtj+TLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788433268; c=relaxed/simple;
	bh=r7A1kvKO2SQv4yeh3/zQcOd3vYkhr2SYhg3DzKbXOSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDTpFHbHSg5Wto/iugf6UfYlVgYYDKyThZwUqmIuvs8dcna8gg5bo3TOC0Vz1kGmSdu/L5tqpnBUBJ3gPagOEM4X/Owp4RzLxv6FQyyUn7D+5V17YF4T/EJvGj1cZUpMf02295UHykKBkSHPnaFGgtIjVtiSzbAEhKeyUsxp2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqrYkZ3N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqrYkZ3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5BF1F00A3D;
	Thu,  3 Sep 2026 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788433266;
	bh=6Co2h1oEZ5U60JdWzSyZd4v6op5yvcq3/jaM5LDdEc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bqrYkZ3Nuw2gSLzszRw4YSlg6dKKxUPWaMlOky6DmbP60AtoxI9haiEb1BEG/cUys
	 MvSnMfLyNr3Jj3oymkmI6cfhHLYT/xh/xcNKZ7brcdjrBsLRHdnI/AnQOH1r+xLkz9
	 9Z9PN8+DTluhqg5FdNjDMXPjsBnsWXJ/0DgOH2RGHOsgfJE6iSj0O7+pvc8c/0x/EK
	 kAgFpz6gkk/nRJq6iE6AN1oiahgO3kGq5rdGF1UMAGrQNpMDp0x8Up5hbK3KVO7pBj
	 kmTMZYsllTsJO5w4moTUr95uHfcT60BBs0GdrKAw/iJ3FStM6xyZqGQHFtN8pANR96
	 +SrxWQ7wdg4fw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 2563F1980045;
	Thu,  3 Sep 2026 07:01:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Sep 2026 07:01:03 -0400
X-ME-Sender: <xms:a1OZagmAG7j6VJirCeLTtNlue7pwBrkSTkNDG1L0AHAced1WMB_iYw>
    <xme:a1OZal99lOxvPIW37ltyjZ5CDjkygiX2gs8yEhLn4ZOK61JRm_Ex_nA1PIcBtSxuC
    gGJ2AbfiYNgFRCa6BQlPNk3mES0ezTXT0fvA4UC-UPSzZkAkuKMmvAu>
X-ME-Received: <xmr:a1OZalJtouO_vCEz8ZS-MbtcARM_QkhQ0eOZ4xO5UDT6heGIXk1ork5aMv4>
X-ME-Proxy-Cause: dmFkZTEA/cNC+NRqgQfaBumMDDx1mWc7P9YPky+3YOsSOYpGncfsqXqvxUA1lnV3kGc/D3
    nfOMOv5iJRrDNZEb09Wp6Ci+GCE7RpVSA3F2mIFsP6RdaiwnBx7IJnP6HoupX2jLRKa/TZ
    RHWVjGVFVcLQ5umGIm9LqN16c9sxkd4fbfAJ17Y8BO62MwR1mfEbTKE7OTpRbSAE423FhH
    1wZe6iEVIVXmzj+nEyY0eFv9NPWvKwGpH42i1EBHMQ0Fnlu5vhtmpgFMcKf9mV/vkNiR5F
    Md8PLn6dXbf8r4GlIyIfgffW2VSbl74YFgeMWBBcvk9pbvm2hbOekd/flPpcE186mETXH9
    E4In0uv/GYYJZvZDaU87LNCpRSOgxbnjGmiHkdURa4yWx4pWsx3RNmU0uHfWRqliWUrUtY
    ncCmY2Pzw2TWJ8CmI3cAt2ndDzmWrLoHqWurpNRuXeDqZPrvLdEjIlNknECYBWGkhGPExm
    09kXZb9OR2/tSNt6VDH6lcw28H/Q/IVMHwhal4Ar7k7lWmko7M5X/Pz4rwFOOSW1aE7dRw
    D0K0U1LmhVL/cxL7LiW10qwOSENDvOZ7owE28K1RnfodxvrrRipHVJu8sNYI1QxKw5QMeX
    13tglXTgeAO2W3uXGKKGA3z9yzuzluKWopB1RFC/JLCz8GpCM99Cs0XgRpUw
X-ME-Proxy: <xmx:a1OZamnNkI7bJ4yHxV_1gbYtdW6lYGZCTdWuQcI8ngcYBYFEuGljGA>
    <xmx:a1OZaifrBgq1pS-hD0AD94xwucHAvw-8_JaecTlb_XtKV0Y8oX1L5Q>
    <xmx:a1OZanWSnlogF2uZ8z_IOgPQc2LYK-7F_M3Kyj-M3TgL_DrKtcsz7g>
    <xmx:a1OZap4goxnawmH5a9t5G5-czWl6DZSL8SdM9LBCIq6RjG987MFPyw>
    <xmx:a1OZaq7H_dHtDDbxfvlsULJW5edviCU_LhOJl498HowvdcN2H7WFxPAo>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 07:00:58 -0400 (EDT)
Date: Thu, 3 Sep 2026 12:00:57 +0100
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
Message-ID: <aplSf00ESix5s6Ak@thinkstation>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
 <20260821032920.256225-5-yilun.xu@linux.intel.com>
 <aohvlMO7ehqcVW96@thinkstation>
 <aowMYbHKK4b0O5P6@yilunxu-OptiPlex-7050>
 <apE8yHrGx/bfifV9@yilunxu-OptiPlex-7050>
 <apf6WFKun8z4ejG8@thinkstation>
 <aplOhHWvaxqUJDqu@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aplOhHWvaxqUJDqu@yilunxu-OptiPlex-7050>

On Thu, Sep 03, 2026 at 06:40:04PM +0800, Xu Yilun wrote:
> On Wed, Sep 02, 2026 at 11:54:25AM +0100, Kiryl Shutsemau wrote:
> > On Fri, Aug 28, 2026 at 03:46:16PM +0800, Xu Yilun wrote:
> > > > > > +	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
> > > > > > +				  &node_online_map);
> > > > > 
> > > > > Why contiguous? TDH.EXT.MEM.ADD takes a list of page addresses and the loop
> > > > > below writes every one of them out separately.
> > > > > 
> > > > > alloc_pages_bulk() fits the chunking that is already here, and a short
> > > > > return can be handled per chunk. alloc_contig_pages() isolates and migrates
> > > > > to get its range and fails TDX init outright when it cannot find one. PAMT
> > > > 
> > > > Yeah, this is not the ABI requirement, but the kernel's consideration. A
> > > > brief reasoning in the commit log: avoiding permanent memory fragmentation
> > > > and buddy allocator efficiency loss.
> > > > 
> > > > Also there is some discussion:
> > > > 
> > > > https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> > > > 
> > > > TL;DR
> > > >   - The memory will never return to the kernel.
> > > >   - There is chance that this tens of megabytes will fragment tens of
> > > >     gigabytes of memory forever.
> > > >   - The chance of fragmentation is actually low since at boot up, but
> > > >     let the buddy allocator take care of these never-returned memory
> > > >     is not necessary and lowers its efficiency.
> > > 
> > > Hi Kiryl & David:
> > > 
> > > I see there is another suggestion that the whole memory adding process
> > > could be a little simpler if we allocate & add pages 4k by 4k [1],
> > > rather than one-time pre-allocation. The concern of this alternative is,
> > > as said above, memory fragmentation.
> > > 
> > > [1] https://lore.kernel.org/lkml/f48b83feb2ee1d3c88b5a1627cf35b4b282d3f90.camel@intel.com/
> > > 
> > > And I've realized the memory fragmentation discussion is not actually
> > > closed in previous thread [2]. We need more input.
> > > 
> > > [2] https://lore.kernel.org/all/167d9540-2d9a-4367-bc68-b96494bc4044@intel.com/
> > > 
> > > Let me give a brief overview of the problem:
> > > 
> > > Intel TDX (Trust Domain Extensions) is a feature for confidential
> > > computing. A secure firmware called "TDX module" runs in an isolated
> > > environment to provide services about security.
> > > 
> > > In Linux, the host initializes TDX module at boot up time
> > > (subsys_initcall()). During the initialization, the host must donate
> > > tens of mega bytes physical memory (35M ~ 110M in the forseeable
> > > future) to the TDX module. These memory will *never be revoked* cause
> > > the TDX Module initialization is a one way path.
> > > 
> > > The TDX Module doesn't require this memory be physically contiguous. But
> > > the kernel side concern is if we do PAGE_SIZE allocation, it may
> > > permanently fragment memory regions, stop them from allocating 2M huge
> > > pages. In worst case, ~50G (110M * 512) memory regions affacted.
> > > 
> > > So is the physically contiguous allocation really a better choice here?
> > > We appreciate inputs from mm folks. Thanks!
> > 
> > What matters for fragmentation is not contiguity, it is how many
> > pageblocks are left partially occupied by unmovable pages that are never
> > freed.
> > 
> > So you can ask one pageblock at a time with
> > 
> > 	page = alloc_pages(GFP_KERNEL | __GFP_NOWARN, order);
> > 
> > with fallback to lower order if you must.
> > 
> > It also fits the ABI: pageblock_order is 9 on x86, i.e. 512 pages, which
> > is exactly TDX_HPA_LIST_MAX_NR_PAGES. One allocation is one full HPA list
> > is one TDH.EXT.MEM.ADD, so the allocation loop and the chunking loop
> > become the same loop.
> > 
> > But alloc_contig_pages() might be a good enough approximation for
> > per-pageblock allocation if we do it during the boot when fragmentation
> > is low.
> 
> IIUC, you mean alloc_contig_pages() also gives good de-fragmentation
> that we need. But it would be slightly easier to fail cause it requires
> extra contiguity that we don't need.

alloc_contig_pages() can be more expensive than needed (or fail) since
you ask for the full allocation size to be contiguous, where you should
be okay with a set of pageblocks regardless where they are relative to
each other.

> Multiple alloc_pages(order-9) meets our requirement exactly but the
> falling back to lower order may create more fragments. And we can do
> this because of the ABI definition - an HPA_LIST could happen to hold
> an entire pageblock.
> 
> If I have to choose, I prefer alloc_contig_pages(). It doesn't have to
> depend on HPA_LIST ABI details.

As I said before, as long as you do it once during the boot, it should
be good enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
