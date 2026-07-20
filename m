Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2D3B95FA
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584287; cv=none; b=G22WgpF1ccY0eCRR03qCKbd8CQTOqNQuK/a3y2CFt4XdISKvNSNk4P+yUiCiusQ75OYI1KKOl+yDn4xJbyhre/YReEEWyY5h4C1sTJz/2P9/MGsUABMGBuMUsJQFPU9Gb4RRk4Lvof0yXnRP5EtLTBcs9FTCOEUeks2Dz8E81lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584287; c=relaxed/simple;
	bh=Xbu1+An/4BaIat8EnInQJSFY0tlkbx2GTh/xw2HumjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmxUcZ0Fs0f8sS5MgItqBSdzHC4g6fRdFePa28L/ayUcEg7v+/CyHb0kYz9FJkLQRCO/fT0hDV22kJvXp+GY32dRFXQ52mGt6uOIe1/3lCJiJdZz42ADClOeD4sJzfX8xLQsyHK6RzPLZjNHnexZV7xITnXODiMRi/USwh1mwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WZbqzqXr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jxzk0Wo5; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WZbqzqXr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jxzk0Wo5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D2661D00029;
	Mon, 20 Jul 2026 17:51:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 20 Jul 2026 17:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784584283;
	 x=1784670683; bh=lSb4hrNjeB+2hgygN2dku4ofUOmWa+Pra549+ZaeHhI=; b=
	WZbqzqXrRm50A0x2wX2PCVa2y17Z/pes2V0SIBZHyVUe6H/BwYQv9h+7eXbyzAbc
	fBuRsVhCV2oLKDZSIcQc4Xnd0mDtwYa442diUVfXXPKSwjVUVjbvhlyB+yLXUNb6
	4pGiKoYuIrumZHYj8fXwTwpmMyFiZpepEbyTi4DUXhESZDMBjWCOmEMR9F2hgWKx
	gUB4vIs0LkMKIV/KCIUkG2dJL5EUthwbonMzshT38NxYQNO8+81b6DAy7mJ216Bq
	3R0wPNlMigQ02SnGP2knLGX98+gdeTALrKKHAHcN60tDgy7036Vq/y5DYyjBWRlp
	Tm56v3ODr5OIeeqndMmf5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784584283; x=
	1784670683; bh=lSb4hrNjeB+2hgygN2dku4ofUOmWa+Pra549+ZaeHhI=; b=j
	xzk0Wo5q43dL92Q9mpi6FK+4pjxOOdxvXyl/6Ov36FRqoYn+OAXzCG4U/gsP/tcH
	l56VkpGTS8xbk0a47wKDmpzDq7kajMpXKxpnE8dSeRDXP5iDKkMWv4PDMYeMEQrO
	ek+xmWH1THCryPmf75SwMgKuOm2W4WcQF3zTIrnIR4MfdhVs2iuLnSn8sGmTf1Ce
	1sMTFJ3Nbm6bSEZ4PwxL2WPn9xnZFDDBwXiDyTN27zY5cjXere/lyPTIRZlZikjc
	oWFlCoRxeBtB9DSR3bM5mNHfw9/+coNVnA78dl7HbsYjmBApEyqL37QluhaLGMpz
	c0lCgNHT5mpaswKHmSqKQ==
X-ME-Sender: <xms:WpheamZPBjGfiRIfyzmaHkAJCeWF57MZ90GBENfCbNwYVvV67EoOdQ>
    <xme:Wpheaq6crrZDwSAX7JPcOqZT275xT_vYWLX6b0S5qhxCrbBtSL20gDPbBadBSawK3
    A3YtPnxwqySLYZFpQaSi22BqH2ti1CH82UAy1vkeTV3gEltpGvw>
X-ME-Received: <xmr:WpheahDHmjLTToHtqQbErEuq4mrgTXFr7QjX5h_tg2sMOmrT40xp4pdCCmI>
X-ME-Proxy-Cause: dmFkZTF/5bnVFT4k4WGzb9nBSOCsm/xRsHIeW240QM840oN7K3JLX4g+bDJB5zYs/X2L0V
    uRdMlliCcWFCp2CNfwC4xPrhBhDyTtrVPnLBmQ+hSFGBPeojbP5wRRVYs8CfhvH4gdkx2X
    1ijpO4LcygFyu9T5faTQ2xKVg6njkE+B8I83a4uIJY8dHnqmbX1iS8lnfD3eBH2ifJ9THB
    G5zgOA/FNDGOHtrZCLIu1iTQzop5OiK12EHe6YLHtb91QUvvx6roUaegCq/5GaxjH3wycN
    D+L5/j3YiRHN7ogADMT64EE58NJOBdQ0gqSDb8Qva0yYvVAxKCCRsi73OoMpYtYPymzYW5
    nIBFl9N0iIiOXLG1Y2163EsOlvpt0oyWjmjaml11IT8O/xYSHXky2H9D/P2+nCVPh/qAtz
    NKfQLUV1gRSopFUcl6Vuv1ycELl+dS6SIEAskqk2Y6fYxCl+4efyc/2XPnRg9MlOTWjKkG
    ZVI6WZ6qemuEYosFdpMUjYk9iPaQau9pyhpBAtjt/E7mJku0yyBcIgnnGLnrEDf/1CjhWC
    /ExMkk5UHelk9/RPpRh68ehzCQt4aM56hXpmaHbKC0B/p8efVLOcll1VXWr61ZWdIJieof
    adTUSb+r0SghkYMvezjLdd+a3b2UT3NreeEbIi3gDVm6rrFBZ+mPGJGfNVKQ
X-ME-Proxy: <xmx:Wpheaod7ewFsXtjo5H5jRaCgD1drTu4FGyqhTdFOwZgsp253Y2Ghgg>
    <xmx:WpheaoIqPNsI32OKaIiY89ZzxE-6LH0IhTFTs8XBGKOyLzVcYmzuUQ>
    <xmx:Wphear0mGErw1031noHbigVUR7C0f9hTu7uiIJv_Vx9DK9Hxfq755g>
    <xmx:WpheaiinFSSr4gYhxjil7PUZynZoq_tTckrlh574bCwtIhGKzS9Bdw>
    <xmx:W5heasZrRh7M97CVlmiCMPH61Xl85jKHHRAAGJZnjtSaormAxjcx9q2S>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 17:51:22 -0400 (EDT)
Date: Mon, 20 Jul 2026 15:51:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, David Matlack
 <dmatlack@google.com>, alex@shazbot.org
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read
 faults
Message-ID: <20260720155120.2815e269@shazbot.org>
In-Reply-To: <20260720154227.1f727abe@nvidia.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
	<20260714-igb_v3_b4-v5-5-91503eddb98b@google.com>
	<20260714211204.437281F000E9@smtp.kernel.org>
	<CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
	<20260720154227.1f727abe@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 15:42:27 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> On Mon, 20 Jul 2026 14:27:12 -0700
> Josh Hilke <jrhilke@google.com> wrote:
>=20
> > On Tue, Jul 14, 2026 at 2:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:=
 =20
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] Test flakiness due to fixed heuristic delay instead of pol=
ling on EAGAIN during VFIO_DEVICE_RESET
> > > --
> > >
> > > --- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA=
-read faults ---
> > > commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
> > > Author: Alex Williamson <alex.williamson@nvidia.com>
> > >
> > > vfio: selftests: igb: Recover after DMA-read faults
> > >
> > > This commit adds recovery logic to the igb selftest when an intention=
al DMA
> > > read fault causes the device to hang. It introduces a reset and re-in=
it
> > > sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow ker=
nel
> > > error handlers to release the device lock.
> > >   =20
> > > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/t=
ools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c   =20
> > >
> > > [ ... ]
> > >   =20
> > > > @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_dev=
ice *device)
> > > >
> > > >       igb_irq_enable(igb);
> > > >
> > > > -     return (status & 1) ? 0 : -ETIMEDOUT;
> > > > +     if (status & 1)
> > > > +             return 0;
> > > > +
> > > > +     /*
> > > > +      * The descriptor never completed.  On real 82576 hardware th=
is
> > > > +      * typically follows a DMA-read fault from one of the intenti=
onal
> > > > +      * unmapped-IOVA tests; the fault leaves the descriptor engine
> > > > +      * unable to service subsequent valid descriptors.  CTRL.RST =
alone
> > > > +      * reinitializes the queue registers but leaves the engine we=
dged
> > > > +      * for the current process, so a broader VFIO_DEVICE_RESET (F=
LR)
> > > > +      * is required.
> > > > +      *
> > > > +      * Delay before requesting reset so PCIe/IOMMU/AER error hand=
ling
> > > > +      * triggered by the just-observed DMA fault can release the d=
evice
> > > > +      * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> > > > +      * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> > > > +      * recovery only ensures the next memcpy starts from a usable=
 state.
> > > > +      */
> > > > +     usleep(10000);
> > > > +     igb_error_reset_and_reinit(device);   =20
> > >
> > > [Severity: Medium]
> > > Will this fixed heuristic delay cause test flakiness under heavy load?
> > >
> > > If the kernel's PCIe/IOMMU/AER error handling takes longer than 10ms =
to
> > > complete (for example, when KASAN or other heavy debugging options are
> > > enabled), the device lock might still be held.
> > >
> > > Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
> > > vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_function=
() to
> > > return -EAGAIN:
> > >
> > >         ret =3D pci_try_reset_function(vdev->pdev);
> > >         if (__vfio_pci_memory_enabled(vdev))
> > >                 vfio_pci_dma_buf_move(vdev, false);
> > >         up_write(&vdev->memory_lock);
> > >
> > >         return ret;
> > >
> > > Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(), whi=
ch
> > > asserts that the ioctl returns 0, would this lock contention cause an
> > > immediate test suite failure?
> > >
> > > Should this code explicitly poll for -EAGAIN from the ioctl instead of
> > > relying entirely on a fixed sleep?
> > >   =20
> > > > +     return -ETIMEDOUT;   =20
> >=20
> > Alex, I'm guessing 10ms is what worked for you when testing with the
> > physical hardware? If it's working fine, I don't think it needs to be
> > changed. =20
>=20
> Yes, the delay was found empirically and indeed we could make this more
> robust if we retried on -EAGAIN.  I'd be in favor of doing that as a
> follow-up.  Thanks,

Oh, some further context, vfio_pci_device_reset() asserts the return is
zero, which IIRC, is why I accepted the heuristic delay rather than
expand the scope with a new reset callback within the framework.
Thanks,

Alex
