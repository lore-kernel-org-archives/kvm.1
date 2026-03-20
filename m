Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40036C0CE;
	Fri, 20 Mar 2026 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041563; cv=none; b=qo7Cw2vgQgEj57yPs3vJxlT5flgkmMQcY7Jy92fjkQTVpOgz59mAOa++UfNfvzsYuzaFqgZ6eGrIZ09pQQ3wsPV5MA4CE7q5CaI8z8HvdE6gXS3d8u1zw8WPshg+WMrAOObZOeczn0DskKAPpHMyPuUDOH/xuq8NG9qu5OpS4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041563; c=relaxed/simple;
	bh=YOZ7lW6FGfjPqmt3uLpu00QggYh1d/djUSJ/Hhani9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCVI85r2jUK0kobsuYH1lT2tujv3eaMNcs5N01TJjrSgA2jhe1HvRDamC2da0be85WX9tYWTib/1PrZv9822UiYqG5ff3zRX4460NBJgyWxenNR2qsbSNYd1oSqQ/vKHgmEcLLmmWVK5wj8w/tMZFRajbhlE3atwiTGi7nbXZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=BMdmAAIU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zsW6E9iE; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="BMdmAAIU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zsW6E9iE"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F10C1140027C;
	Fri, 20 Mar 2026 17:19:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 17:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774041559;
	 x=1774127959; bh=v9MzbXrGKE8UmNQPl3m+i5rAwLb7V8D8qRDvLPMVmLQ=; b=
	BMdmAAIUT6HBPUdNm2SBHaNBv4wzPXudHc/EPeG3wMzX/tWwB7lwmRHu8W91AJzr
	rq0UaX7D75ft7x6FYiqPRT8THA9D78EmNVo6niYHpJb06naNAqdKDr++P8yLRjEr
	NgPUAtWb2GlMt1j5eEL8BxMVi8uLH+exnFQgfAl5KJ9a3SwhkJC5ez2F5//2Mnxp
	MmS2ofiNkLx0tTp5U7Ms90kM6G4vtC7Rg3kW58o1UuZ6M9r9bU44p2QAbgewdYrL
	WLInJKjh2Okbs95NFSkXHE9kPX1uPnBS2LTVjYZjaq7ie5Nip/TFuK5QutfWLWlD
	9r7lOTVjMg+CyrxXBRZtMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774041559; x=
	1774127959; bh=v9MzbXrGKE8UmNQPl3m+i5rAwLb7V8D8qRDvLPMVmLQ=; b=z
	sW6E9iEE8812j6bw1SGEeAc47GmyG3S/m7ckHL3MW7B4m8bUMA+Spnccx0oprBaJ
	VInaI94byVjRoYJ+aXpbijJYyFpCa9XtEBexlNc8F2sVWev2wB+zcZejtmveLZTb
	rnkOUyr9rnNqjxnIUmrIU9ba+tUpCs9jOEpwAlJTPp7ZppYZtPOe9g6LAW8WgpEK
	tXqHlpkBRQ/FJYf0iuZoV5HmVUNcGwHbAgAH/UnUDyIth7qeK986d84NsnlTuJd0
	p+afx9O+9fpL/RYh+2YzLzl2Ji7ZfIyZiQTjDIXoDQ2SiNT2xc+Iw2dy5jwnGi95
	BgQ/t2N4d6NfkAZVV2B+Q==
X-ME-Sender: <xms:17m9aUMsd0xJ74SZfxATv-kYOtZ2EcoFfJs5iM6l7mpsPDzBBeub0A>
    <xme:17m9aTIbuEoqghhC_s60yJrNe4_wAQ_bZ6mmI5sHI1u8qyFVq8mNQbBHP9TBvimFD
    lhDetLYafrqiQOF45fuvUGvzRdDn2oAVoWOKOv2iOfdhpSOz3gLRw>
X-ME-Received: <xmr:17m9aW1CZTA2dmqUOG9tFORzkluiPePu5JNTwufXTs9w9hTdoEnp6AZGOD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefuddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepkeehjeeitefffeeuieetjedtje
    ffvdelledvuedvffdvfeetgefhveekuedvfedvnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmhhhonhgrphesnhhvihguihgrrdgtohhmpdhrtg
    hpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghv
    vgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhhkihhtrgesnhhvih
    guihgrrdgtohhmpdhrtghpthhtohepkhhjrghjuhesnhhvihguihgrrdgtohhmpdhrtghp
    thhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:17m9aXW8v7nAZZIfyg1ESiskYXY6qIzQ7JKinpvXVJpx_ldXKKYKxw>
    <xmx:17m9aYOfHoM1_ocwPVGRrQe3Q8ob8I--BDq_5gGmGHxT0RSV8I4aDA>
    <xmx:17m9aa1vAvXPtKEc8zBs4r50JUJOvTK1Mi-MgWqNnlE63qgbobiE2w>
    <xmx:17m9acQVpks6OLMednN5DKpqwMMDc-Tk652fiFOlzelAuRp-_lzgmw>
    <xmx:17m9af0tRABYkk6gXKD5RMRdPcU_60RRB2WNp7Gepfzs_xz5LnKsktyU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 17:19:18 -0400 (EDT)
Date: Fri, 20 Mar 2026 15:17:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <dmatlack@google.com>, <dave.jiang@intel.com>, <ankita@nvidia.com>,
 <kjaju@nvidia.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <stable@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH] vfio: selftests: Fix VLA initialisation in
 vfio_pci_irq_set()
Message-ID: <20260320151726.4db61e9f@shazbot.org>
In-Reply-To: <20260318145323.7e9831a4@nvidia.com>
References: <20260317051402.3725670-1-mhonap@nvidia.com>
	<20260318145323.7e9831a4@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 14:53:23 -0600
Alex Williamson <alwilliamson@nvidia.com> wrote:

> On Tue, 17 Mar 2026 10:44:02 +0530
> <mhonap@nvidia.com> wrote:
> 
> > From: Manish Honap <mhonap@nvidia.com>
> > 
> > C does not permit an initialiser expression on a variable-length array
> > (C99 Section 6.7.9 constraint: "The type of the entity to be initialized
> > shall not be a variable length array type").
> > 
> > vfio_pci_irq_set() declared:
> > 
> >       u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> > 
> > where `count` is a runtime function parameter, making `buf` a VLA.
> > 
> > GCC rejects this with (tried with GCC-9.4.0):
> > 
> >       error: variable-sized object may not be initialized
> > 
> > Fix by removing the `= {}` initialiser and inserting an explicit
> > memset() immediately after the declaration.  memset() on a VLA is
> > perfectly legal and achieves the same zero-initialisation on all
> > conforming C implementations.
> > 
> > Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> > 
> > This fix is self-contained: it touches only the existing vfio selftest
> > helper library and carries no dependency on any other patch.  It was
> > originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
> > RFC series [1] but belongs on the vfio list independently, as noted by
> > Dave Jiang.
> > 
> > [1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com/
> > 
> >  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > index fac4c0ecadef..3258e814f450 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -26,8 +26,10 @@
> >  static void vfio_pci_irq_set(struct vfio_pci_device *device,
> >  			     u32 index, u32 vector, u32 count, int *fds)
> >  {
> > -	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] = {};
> > +	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
> >  	struct vfio_irq_set *irq = (void *)&buf;
> > +
> > +	memset(buf, 0, sizeof(buf));
> >  	int *irq_fds = (void *)&irq->data;
> > 
> >  	irq->argsz = sizeof(buf);
> > --
> > 2.25.1
> >   
> 
> This unnecessarily split the declaration block.  Without objection,
> I'll commit this with the following change:
> 
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index d306ab81123a..fc75e04ef010 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -32,9 +32,9 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
>  {
>         u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
>         struct vfio_irq_set *irq = (void *)&buf;
> +       int *irq_fds = (void *)&irq->data;
>  
>         memset(buf, 0, sizeof(buf));
> -       int *irq_fds = (void *)&irq->data;
>  
>         irq->argsz = sizeof(buf);
>         irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;

Applied with this fix to vfio next branch for v7.1.  Thanks,

Alex


