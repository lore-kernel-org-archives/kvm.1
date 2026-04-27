Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7E2F531F;
	Mon, 27 Apr 2026 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300613; cv=none; b=JP2B96Ft6ZDeQQOalxqCsqXnX7bFFqdToMsl8Tbicz9yriorYrBiXPpejsyA27FVRqcPqJif5J1Nf3XSnydM/dqIJJsizkfwrqiwl6e8GbsgbWJaAjG1QoWORIwEHibLwKEI7ZVZUUZPfAoETQRoCvRN3k08PRWpwmt5QfFPbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300613; c=relaxed/simple;
	bh=9DRxDffdXvFA9S8m3u8VvuWFoR3YyyqhTaGBfq5zhlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqTVf1zMMQYCAeFsTgISoRSfX0JyHjPnu0UTcj74jeUwmakl4bxTjebHzcN5vXM7iiFcTYCE6TpHveKjzcanPG1aPX2EQbe+ZDS6I8wdjCZFPflDRUhNPOEDNPLOtqoSve92u+Im63rBc29eLUMKOm8t/AwpZWIdQpcu7RFsdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=uekKU/XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ujpzMDM7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="uekKU/XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ujpzMDM7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2FF497A01E1;
	Mon, 27 Apr 2026 10:36:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 27 Apr 2026 10:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777300607;
	 x=1777387007; bh=j3Ga1b+UElSKHH4tx3q9I//plz4ie3nieWxtnW8dRLw=; b=
	uekKU/XQxj+fxDGaTUUCOJQMpbQSQa7hGgrgLQNRW5U40DjbcGKjWBpIZ3KdicKd
	y7pEuUf3jkDqW4rYl4eVc8TWnDGK7QRNlBdCdmflEN292mkasG3BIVP4886b1EjD
	7kCyY1RRL++bkkWZzOKmccVZYEkEXiDo2M3HkTwd9MVALGTY0yBRRQO9JoH124x7
	JYKhQYDR0ESyBMCuCliTUTlvObzsatBYr49m1yWj579bxuX6JJAQEosk2Hxw49Mp
	F44VDP/DNkHXpFL4Lbru9vr3fW968M48FB6N0cwWwfrHS4KjxgI2sHJlpJx5pVNV
	WWL0i4jp+oi7xVrwyqJVkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777300607; x=
	1777387007; bh=j3Ga1b+UElSKHH4tx3q9I//plz4ie3nieWxtnW8dRLw=; b=u
	jpzMDM7Of+yzDMJp7gBp7/QTT3XcoPpk0DHZsa5dQA3Iro8hqx6tE3WcjJIxrKJE
	zmHDfM4LhB01TQQODBHq9B+mCCAY3XRYWYQL8ALxh3/1yxoA1H/s53et2LcTVzfI
	YdP7sAGiloJ8fItlS9jCbzM8zwQRobNEJrDOtxNyspD9+syAjTfzUlsY36x8p0ee
	UIXeiFfgj+TN7yEuiduaMPQtVE4U4x2/ITHXSPox5mM3XCnICGK8ypbNWJD2LE1H
	9FRa212dvlxjrj/wBF69f+ct3hrJ2xgYiKrz3fKXxvpD4oACITnZB3yNy/jmX6EN
	+dRkY/+/4Ug9zRJKHGAXA==
X-ME-Sender: <xms:f3TvaRbiCYf8jFfQsS7mqKVkONIjBIKARj4rhOy8R2IzyyPKq_sCSQ>
    <xme:f3TvaWzxDzS4RFBeIbKiuigKKKPlR3ntJC5EW1INUSk5Z-D2SkngckJKqUUVPnA-W
    WgCYvUh0usdHkUlvbSASAc0K5jQRawStYYMHWey4HZ1sRQ_RqUS>
X-ME-Received: <xmr:f3Tvaf-LrDBce0YILrh1y5cv2tUNImBCh7mzs6rBJyGruktuCh84-FmtyOI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkeehjeeitefffeeuieetjedtjeffvdelledvuedvffdvfeetgefhveekuedv
    fedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdp
    nhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlvg
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhm
    pdhrtghpthhtohepmhgrthhtvghvsehmvghtrgdrtghomhdprhgtphhtthhopegrmhgrsh
    htrhhosehfsgdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdhkohgvnhhighes
    rghmugdrtghomhdprhgtphhtthhopehmnhhghigruggrmhesrghmrgiiohhnrdguvgdprh
    gtphhtthhopegumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsghj
    ohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhumhhithdrshgvmhifrghlse
    hlihhnrghrohdrohhrgh
X-ME-Proxy: <xmx:f3TvaSxMrrBIFQMhK9Oob_UuUIigDC2qkQVd3R06fMyCypFEKQvfow>
    <xmx:f3TvaUsYAD2stHChwchFhVxdLQlR7HXPhlI3eOECV47EKD6RtLSCnA>
    <xmx:f3TvaR1uEEilQ8PoAz_RQ9xF-gE8R4bRF7yX5OAliqvnbDdeZ71VHw>
    <xmx:f3TvaQ7-YpmZviOmLTh2VAFMBXW9G-UQW3DwjxjzKK_xxziE3gC7Mg>
    <xmx:f3TvaVQ3cavOKXSQKYAqQMsEkKr8c9nkl_JSkq9AQ1DZXHpH92ouBKE0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 10:36:46 -0400 (EDT)
Date: Mon, 27 Apr 2026 08:36:44 -0600
From: Alex Williamson <alex@shazbot.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Matt Evans <mattev@meta.com>, Alex
 Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Mahmoud Adam <mngyadam@amazon.de>, David
 Matlack <dmatlack@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Pranjal
 Shrivastava <praan@google.com>, Alistair Popple <apopple@nvidia.com>, Vivek
 Kasireddy <vivek.kasireddy@intel.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <20260427083644.4ee174cd@shazbot.org>
In-Reply-To: <20260426105215.GA440345@unreal>
References: <20260416131815.2729131-1-mattev@meta.com>
	<20260416131815.2729131-10-mattev@meta.com>
	<20260424183153.GJ3444440@nvidia.com>
	<20260426105215.GA440345@unreal>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 13:52:15 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
> > On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:  
> > > A new field is reserved in vfio_device_feature_dma_buf.flags to
> > > request CPU-facing memory type attributes for mmap()s of the buffer.
> > > Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
> > > PTEs for the DMABUF's BAR region.
> > > 
> > > Signed-off-by: Matt Evans <mattev@meta.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
> > >  drivers/vfio/pci/vfio_pci_priv.h   |  1 +
> > >  include/uapi/linux/vfio.h          | 12 +++++++++---
> > >  3 files changed, 23 insertions(+), 5 deletions(-)  
> > 
> > Nice and simple
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >   
> > > @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
> > >  struct vfio_device_feature_dma_buf {
> > >  	__u32	region_index;
> > >  	__u32	open_flags;
> > > -	__u32   flags;
> > > -	__u32   nr_ranges;
> > > +	__u32	flags;
> > > +	/* Flags sub-field reserved for attribute enum */
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
> > > +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
> > > +	__u32	nr_ranges;  
> 
> Alex,
> 
> The TPH proposal extends the flags field in a similar way, but I suggested
> a different approach to conserve bits. At the moment, we spend three bits
> on a single feature, which feels wasteful.
> 
> What do you think?
> https://lore.kernel.org/all/20260409120415.GF86584@unreal/

I already proposed a very different interface for TPH that decouples
the dma-buf creation from setting the TPH values:

https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/

This is overall less intrusive than the TPH change proposed, but it
could still make sense to align this as an operation on the dma-buf,
that can be probed as a separate feature.  Thanks,

Alex
