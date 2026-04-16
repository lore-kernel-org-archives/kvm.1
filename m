Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2411025C818;
	Thu, 16 Apr 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776376092; cv=none; b=STlnC5LJhESdMfLKW3SPc/I6Cmh/NYaL3nrcSqgQpIJZT1obIdYV7G2CUUbvVIDE7bitLURP+2U9qPwBZYGy5NGPGjPJ1gXONuhG2nb616HvlkwJMaivfa2/qPeAt0/vnaQdtjrL3yv+1QlBx2hh4l/u3Lar+FFMfnbW3qyqNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776376092; c=relaxed/simple;
	bh=7MSvNbi30w9YhHI3nsocyQAM6KfWKAhFKgQIP/bKOr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3u3hvvDsxJoLnkSxkYx5sJQSbITn1WarRT/xasri3AGvfCg87udP2fy6ALom0ZfZsbl57mrhfjdNqMEgFXPNH0MFCLqZDJ5Q5X9rgmxtRUStsI7IWSn6Ry4fZW7p6kVsoDmVJOjwFcg2LNDW07PEetl0OTFGHrV7u2Uj18oP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=vcyqTl8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D72n5Lkr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="vcyqTl8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D72n5Lkr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16EBD7A02D0;
	Thu, 16 Apr 2026 17:48:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Apr 2026 17:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776376088;
	 x=1776462488; bh=ITFKWWeYzCrva/eMFhHobi/q2cECC7Q3g4NxtZSWaVo=; b=
	vcyqTl8QeksncDIFhx7/JlcmPOQf5sIptcY8PODCxcngamrUosCHqd7ZzQu2xrsB
	YoTF2nKRl6WRgNz/35e8tj6eZM0I24ScfPxtXcJwPKNj6otHT5eFd2CJiSqwfCcn
	y4of/B/OmYsZNF3betXWqfWtMFJ3XampS/+M0RxdxEwCRcFKQtbJEvBe3hWjcovz
	kmwYcJV2xS8XpCYNIpO0Vcg0RXXMbquct4J9LLOha5LduZ+QuKyb4nWHrMGRq7C9
	pxdcyYbRdON7FmSK+qPKP38DiwwKwwm22HDL3LlicSGxCuFLhFHeR3TwWf0sunyN
	v1YacXr7tHf8ibGD5TBeeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776376088; x=
	1776462488; bh=ITFKWWeYzCrva/eMFhHobi/q2cECC7Q3g4NxtZSWaVo=; b=D
	72n5LkrVd9mvIk/1Dd96/F+QTGd0ljXolxGTOr/bwrG+m2oJvUDciGc4Q1yB+kAT
	q/an+HZ6IiMdicOMzWs96Vy2zmP9r8BdbOPx+3r9rnBpQOFG94MUCO4b1PHxQvly
	kDG4gHZTFXNmNkaTq2N9ejeIAOdvQS/VtOOxk/sftbecmevBzWobCf3MDPhO/NgX
	Ol2B0fsF4FoOaG7QohO0cBeqrXz/luCbZyaIh3dVlk03vSd8foKMxlJq4eKPLLv0
	cjA0vG37snJyHcZ9D5AKJm5mVMTOK+UQ6KsGml5Zse5iHpaSqQ+hWULZtOgjDW7j
	nGtprAWXUzNJaIGcg6pkA==
X-ME-Sender: <xms:GFnhaff8DzrR6di3CUw-e4y2HA-AmAgB5_K-ie9QXeq_2GqYYF5bOA>
    <xme:GFnhaaJUVYkQaOlQ9xyeOJuHsIiWkw5BPbjDBumGOrFkNZHx6vSYs9UcWFk3ORItc
    LBTY-ZoxxjtNAdqN2t1twlxhM6gwFAKZNia2P4WDOVN_B-wU-4I>
X-ME-Received: <xmr:GFnhaczENibCW7fJPN6IqJGPKX8puEykp9RQq-v97Hl4pS1mh8e8Uk_VZA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkedtleelffetkeeiveffvdevgfduieefjeelveefkedvfeejgeelvdfhvdek
    ueffnecuffhomhgrihhnpehurhhluggvfhgvnhhsvgdrtghomhdpshgrshhhihhkohdrug
    gvvhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegr
    lhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtthho
    pehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtg
    grpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpthht
    ohepvhhivhgvkhdrkhgrshhirhgvugguhiesihhnthgvlhdrtghomhdprhgtphhtthhope
    grnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:GFnhaQvJ0t9YKDVADm_Awy6SEryh2wopGaNQ3VFtyBiXs_WQy1IsBw>
    <xmx:GFnhafB3ilYkmVLqMpoRoTjXstsuwog5RqjxbOUkhBpuqHR-Q5fxyw>
    <xmx:GFnhaSGYwmlw25OnjSqffOLrGrwNI-1phv9gnp-KVs2N8m_2wNky2Q>
    <xmx:GFnhafCkmixmmnzd_XWEYFybwE_Tcf7_9kgqVNA9D7mRZdCP8Phwfg>
    <xmx:GFnhaYqUKzNnHRgPIRg3wV105FuuYIeVdbW2_6mKbTjNtcDmPLaU2BQ2>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 17:48:07 -0400 (EDT)
Date: Thu, 16 Apr 2026 15:48:06 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin
 Tian <kevin.tian@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Message-ID: <20260416154806.0c5cb10d@shazbot.org>
In-Reply-To: <ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
References: <20260415181623.1021090-1-mattev@meta.com>
	<20260416081138.GE361495@unreal>
	<2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
	<20260416131417.GF361495@unreal>
	<ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 19:03:40 +0100
Matt Evans <mattev@meta.com> wrote:

> Hi Leon,
> 
> On 16/04/2026 14:14, Leon Romanovsky wrote:
> > 
> > On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:  
> >> Hi Leon,
> >>
> >> On 16/04/2026 09:11, Leon Romanovsky wrote:  
> >>>> On Wed, Apr 15, 2026 at 11:16:23AM -0700, Matt Evans wrote:
> >>>> Although vfio_pci_core_feature_dma_buf() validates that both requested
> >>>> DMABUF ranges and the PCI resources being referenced are page-aligned,
> >>>> there may be reasons other than alignment that cause a BAR to be
> >>>> unmappable.
> >>>>
> >>>> Add a check for vdev->bar_mmap_supported[index], similar to the VFIO
> >>>> mmap path.
> >>>>
> >>>> Fixes: 5d74781ebc86c ("vfio/pci: Add dma-buf export support for MMIO regions")
> >>>> Signed-off-by: Matt Evans <mattev@meta.com>
> >>>> ---
> >>>>    drivers/vfio/pci/vfio_pci_dmabuf.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>>> index f87fd32e4a01..4ccaf3531e02 100644
> >>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> >>>> @@ -249,6 +249,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >>>>    	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
> >>>>    		return -ENODEV;
> >>>> +	if (!vdev->bar_mmap_supported[get_dma_buf.region_index])
> >>>> +		return -EINVAL;
> >>>> +  
> >>>
> >>> And it looks like AI has valid concern about this line too.
> >>> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260415181623.1021090-1-mattev@meta.com__;Iw!!Bt8RZUm9aw!5DxsN8cDUviPIZqEjG0pZ_VYYbl_RdmWucTGdTZ3ZzlVP_Ysb0n7ykr0eXwFXdpuqvZH2FK3$  
> >>
> >> Ah, Sashiko has a point, and I think its suggestion of checking lower down
> >> in the default .get_dmabuf_phys (vfio_pci_core_get_dmabuf_phys()) and
> >> preserving driver overrides is decent.  Will revisit.
> >>
> >> To your other question:  
> >>> I noticed this check in vfio_pci_core_mmap(). Isn't that sufficient?  
> >>
> >> The scenario in mind is doing a DMABUF-export for BARs that you haven't
> >> necessarily noticed can't be mmap()ed, and both paths should be checking.  
> > 
> > I added the validation checks that matter on the kernel side, but mmap is
> > primarily important for callers. What I am missing is an explanation of
> > why the kernel should impose this restriction on itself.  
> 
> I don't understand your question, really sorry!  Can you rephrase it 
> please?  I want to make sure I answer it fully.
> 
> Although mmap() fails for BARs that are unmappable (for whatever 
> reason), a DMABUF export for the same ones could in some slim cases 
> succeed -- because the checks aren't identical.  If export succeeds, it 
> could potentially allow P2P (or CPU via a future DMABUF mmap()) access 
> to something possibly unmappable, no?
> 
> For the checks that vfio_pci_probe_mmaps() does (leading to 
> bar_mmap_supported[] = false), most have corresponding-but-different 
> checks reachable from DMABUF export:
> 
> If a BAR is:		Then DMABUF export...:
> 
>   size < pagesize	vfio_pci_core_fill_phys_vec() catches it
>   Not IORESOURCE_MEM	pcim_p2pdma_provider() rejects it
>   non_mappable_bars	... nothing?  Export allowed
> 
> As a quick test, if I hack in non_mappable_bars=1 for my function, it 
> appears exporting a DMABUF from it works.
> 
> We could add another check for non_mappable_bars, but my thinking was 
> that we don't want to keep adding to an independent set of DMABUF 
> checks, especially if a future quirk/etc. could create another scenario 
> where BARs aren't mappable.  I.e. we should reject DMABUF export in 
> exactly the same scenarios as mmap() would be rejected, symmetrically, 
> by testing bar_mmap_supported[].
> 
> Hope that goes some way to answering the Q, hopefully I haven't missed 
> something!

That's the concern as I see it as well, it's a choice whether to
attempt to support sub-PAGE_SIZE mappings, but if a device is reporting
non_mappable_bars are we're exporting those BARs through dma-buf for
mmap, that's a problem.  Should pcim_p2pdma_provider() test this flag
rather than vfio_pci_dmabuf though?  Thanks,

Alex
