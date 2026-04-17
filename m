Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77963612D7;
	Fri, 17 Apr 2026 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776465119; cv=none; b=eSR+FaFZ3cYejF/SofLrZxXowgyFyF9UtAsb16aI8qmeTXxFVhbGvvLJ+XJj6Lofu+tckI93ijS0/RHJ/rcFUDMYcwul4cfP0FBwtSzklJrBECt5cySS4nqY1yHN7+1LrZPeVKtSnCm0CPKf7gG4RDcmodNo1PeMaP8iBtoplew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776465119; c=relaxed/simple;
	bh=+jDvHTwb/PPyB8ZCopu8GPvccxdiytlykQmJxIUqK+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NrltCttcMyZv7iNhvTpLNG6PWaqPY1sgt2IHf5GKpM0A4pXypP19qtY3j0v39sXxFEo3s28qmoiRvrKFJotxnA0jmkK2zD3yy5Jvy/xmbnSlPOwmK8QS3HF3COV3GOf87aWifU5B8Ed0nt8wVb0De6UxDwDJ4g7xh7SPG25VKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Y9EuN/rt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YOpcwd0b; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Y9EuN/rt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YOpcwd0b"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 973F91D00037;
	Fri, 17 Apr 2026 18:31:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 17 Apr 2026 18:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776465115;
	 x=1776551515; bh=vi8C+0i5Wa+dc998Nzwp+jJSjD+oBo8RYKlZQD6krmM=; b=
	Y9EuN/rtJwLRZMreziqang3B9SbQvCsv+n//UvupUQhAI8t8hcqq5qPS2QYHzboX
	qBVTjAlWWkIHIA1R2Iwh6v+016q4qxu6wHLPk4YrOWlILaGy0k4OhvoGFL/hnorv
	Ptdgy0rAvhgEg8h4ocWxx+FmaCTys6v/w6JDvyYHIZ/k0nvmKDaLa47ZHPF5a8ma
	BW2lbNdhDXIiFGZhKYZ6UTv5Bm6Up8d9jtCsuppC8N6Y3ReU38tfWzFHwQsxogOs
	HVwxdjjmMn9HdlfVXMPO+VvzD5hYm6bx31iLBsa8UX4nIeZd4f2NWabxddLegRUN
	IToYeEMKDDx/11O5pkyZnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776465115; x=
	1776551515; bh=vi8C+0i5Wa+dc998Nzwp+jJSjD+oBo8RYKlZQD6krmM=; b=Y
	Opcwd0bNOfm41AIZiyxj7frs6hH2EOPWtEsMs75NVssf/VA2gijdOozoqwUO1bJy
	LKt0TvJCVm5dqiQcvl70fPxEdFRuITQsO1mLrnhgkjv0P8i+V/D82KgmbqOn1A93
	NqEM83dteonWYCra4z1Rs63mmzDB22o5hhnaQPRtsCBLUxk+e/qoqKDeLLT2bp7s
	juTcxjdqY6XrDkSChV6toyQVOz3pYv+qvxj6GaZe5cSA7WGTBHeP0rfEly7JIpHZ
	dgg02cXfSSDnNhsgCTYTvXZViAviyQmp055gauRBWiUxVG6AjimdT8qno6BYPmS9
	0Y/KTAn0q1pm3ydQk3FIg==
X-ME-Sender: <xms:2rTiaSU85ZiGLzffQ-vsHm26iC3fxbnNSLPyRuT4foEbTIuajTe2uQ>
    <xme:2rTiaUlRwm7m2W1J1_3t8DEHb_1ADm9s9cS--lxkl70sBwkXu6ZCGCTjQHW9WQ_aT
    ZrBR_8UBL_7mKOfpCos5qaXWapS7rbm_9GFN_d40aUe9mqzti1wsQ>
X-ME-Received: <xmr:2rTiaROb0I5ezoyXNM8NN2h20m-all8I9NPuw7K7GXgqxJTWC3A1sEyrg0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehuddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtth
    hopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdr
    tggrpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpdhrtghpth
    htohepvhhivhgvkhdrkhgrshhirhgvugguhiesihhnthgvlhdrtghomhdprhgtphhtthho
    pegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepkhhvmhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgiesshhhrgiisghothdrohhrgh
X-ME-Proxy: <xmx:2rTiacIpG2xgEtJbvqte6s7Sg8l0SUl18jxtf10kkeY_y1T9tHMmYA>
    <xmx:2rTiab3VZ7MFg3KvXAK_LlLfb4Q2NuE-IDeZ60yZTStZDX94Pgi2JQ>
    <xmx:2rTiaYVV8v_NXISvosRuK42oYa9vikbhxMqoXIj_1TTlKD6KNe-cnQ>
    <xmx:2rTiaVMr7tZdvF6prJ9K-dXOhAbcrZD24kN7LKcibDNpq_Cbft_Eng>
    <xmx:27TiaaxIxlxqcP9IpdbB4KtInra8eCsvO0yhQnb3cvsxPy43AphPcnHs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 18:31:53 -0400 (EDT)
Date: Fri, 17 Apr 2026 16:31:51 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <mattev@meta.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin
 Tian <kevin.tian@intel.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, alex@shazbot.org, schnelle@linux.ibm.com
Subject: Re: [PATCH] vfio/pci: Don't export DMABUFs for unmappable BARs
Message-ID: <20260417163151.18ac44bf@shazbot.org>
In-Reply-To: <9a8b39c0-5c0b-4f32-88b4-225f16e8f3c6@meta.com>
References: <20260415181623.1021090-1-mattev@meta.com>
	<20260416081138.GE361495@unreal>
	<2ea075f9-c80c-41e9-9f93-9b0a2858f68f@meta.com>
	<20260416131417.GF361495@unreal>
	<ed5d615f-5ba5-4045-ac45-79f06fd07a05@meta.com>
	<20260416154806.0c5cb10d@shazbot.org>
	<9a8b39c0-5c0b-4f32-88b4-225f16e8f3c6@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 15:25:07 +0100
Matt Evans <mattev@meta.com> wrote:
> On 16/04/2026 22:48, Alex Williamson wrote:
> > On Thu, 16 Apr 2026 19:03:40 +0100
> > Matt Evans <mattev@meta.com> wrote:
> >> On 16/04/2026 14:14, Leon Romanovsky wrote:  
> >>> On Thu, Apr 16, 2026 at 02:05:30PM +0100, Matt Evans wrote:  
> >>
> >> I don't understand your question, really sorry!  Can you rephrase it
> >> please?  I want to make sure I answer it fully.
> >>
> >> Although mmap() fails for BARs that are unmappable (for whatever
> >> reason), a DMABUF export for the same ones could in some slim cases
> >> succeed -- because the checks aren't identical.  If export succeeds, it
> >> could potentially allow P2P (or CPU via a future DMABUF mmap()) access
> >> to something possibly unmappable, no?
> >>
> >> For the checks that vfio_pci_probe_mmaps() does (leading to
> >> bar_mmap_supported[] = false), most have corresponding-but-different
> >> checks reachable from DMABUF export:
> >>
> >> If a BAR is:		Then DMABUF export...:
> >>
> >>    size < pagesize	vfio_pci_core_fill_phys_vec() catches it
> >>    Not IORESOURCE_MEM	pcim_p2pdma_provider() rejects it
> >>    non_mappable_bars	... nothing?  Export allowed
> >>
> >> As a quick test, if I hack in non_mappable_bars=1 for my function, it
> >> appears exporting a DMABUF from it works.
> >>
> >> We could add another check for non_mappable_bars, but my thinking was
> >> that we don't want to keep adding to an independent set of DMABUF
> >> checks, especially if a future quirk/etc. could create another scenario
> >> where BARs aren't mappable.  I.e. we should reject DMABUF export in
> >> exactly the same scenarios as mmap() would be rejected, symmetrically,
> >> by testing bar_mmap_supported[].
> >>
> >> Hope that goes some way to answering the Q, hopefully I haven't missed
> >> something!  
> > 
> > That's the concern as I see it as well, it's a choice whether to
> > attempt to support sub-PAGE_SIZE mappings, but if a device is reporting
> > non_mappable_bars are we're exporting those BARs through dma-buf for
> > mmap, that's a problem.  Should pcim_p2pdma_provider() test this flag
> rather than vfio_pci_dmabuf though?  Thanks,  
> 
> Do you mean "test this flag" to say 'non_mappable_bars' rather than the 
> 'vdev->bar_mmap_supported[]' flag?  (I think the former, as the latter 
> isn't as easily available down there, sorry if that's not what you 
> intended.)

Yes

> Testing non_mappable_bars in pcim_p2pdma_provider() doesn't feel quite 
> right:
> 
> - IIUC non_mappable_bars is about preventing mapping to userspace, not 
> direct access/P2P/etc.  Splitting hairs a bit, but P2P to such a device 
> seems valid, so I think this check better stays within vfio-pci 
> (specifically limiting only userspace access).

Indeed the flag does specify userspace mapping in the comment, but I
think it's more than that.  The only device that currently uses it is a
device unique to s390x, where AIUI, there is no P2P DMA anyway.

Also, for "legacy" mapping of device BARs through the vfio type1
backend, the mechanics of the mapping require the BAR can be mmap'd
such that the user virtual address can then be used for the DMA
mapping.  So as far as vfio has traditionally been concerned, there's
an inherent dependency.

I could definitely see that p2p folks could balk and we need a separate
flag... or since there's exactly one device that reports this flag,
maybe we can tweak the description.

> - But non_mappable_bars is just one kind of quirk, and couldn't there 
> possibly be more?  Good to avoid duplicating quirk checks in mmap() & 
> export places (so any future maintenance updates just one place and no 
> disparities arise).

I'm not sure what this is getting at, I think non_mappable_bars is
meant to be the flag that quirks might set if for any reason we can't
directly map the BAR.  I think "userspace" mapping is a bit of a
red-herring, it's at least not mappable by the CPU, but I don't think
the flag is actually meant to define a policy only for userspace.  If
it's not mappable by the CPU... is that also enough of a restriction to
exclude it from P2P mappings?
 
> All this to say:   The existng logic in vfio_pci_probe_mmaps() is the 
> right place to decide something is suitable for userspace/direct
> mapping (mappable, non-zero sized, not IORESOURCE_IO), IMHO we just
> need to be checking it consistently.  (VFIO export is less lenient in
> terms of >= pagesize and imposes additional checks, and that's good
> as long as the checks are an overlay rather than parallel
> duplication.)

I'd actually take the opposite stance and say that vfio is not the only
consumer of pcim_p2pdma_provider() and if a device has a flag that it
shouldn't be mapped, the p2p subsystem should also honor that, not just
vfio.

> (Maybe you're also flagging that there could be other checks saying "Is 
> P2P supported for this BAR?" and they could be done in a generic 
> drivers/pci place?  I think so;  VFIO export criteria be the 
> intersection of VFIO- and provider-based checks.)

Yes (I think).  If we determine that non_mappable_bars means both CPU
and device mappings (which is compatible with its current use case),
then fixing pcim_p2pdma_provider() to honor the flag fixes all
consumers.
 
> I was thinking something like...
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c 
> b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 00cedfe3a57d..9bb8bd153e12 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -359,6 +359,9 @@ int vfio_pci_core_get_dmabuf_phys(struct 
> vfio_pci_core_device *vdev,
>          if (!*provider)
>                  return -EINVAL;
> 
> +       if (!vdev->bar_mmap_supported[region_index])
> +               return -EINVAL;
> +
>          return vfio_pci_core_fill_phys_vec(
>                  phys_vec, dma_ranges, nr_ranges,
>                  pci_resource_start(pdev, region_index),
> 
> (I.e. leverage logic in vfio_pci_probe_mmaps(), catch bad DMABUF 
> mappings this way, allows sub-drivers to override .get_dmabuf_phys.)
> 
> I'll repost that as v2 if this doesn't seem an outrageous start. :)

That's fixing the leaf driver rather than the subsystem, where
pci/p2pdma really ought to honor its own flag indicating the BAR is not
mappable.  The precedent is already there in rejecting IO BARs.  Thanks,

Alex
