Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CFD3AEB2C
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 22:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637951; cv=none; b=vFwVtIgfXPmqdA+fVuWCn8D8ORJmLbYMXB+n37fwUqynTo/xszU+k15iTvXvpwV902LEy60RaemXKmM3seXhmQVTsbQMLKsW1RU2aW5Quip1GntVKUisYKX7oLVmk/1mebUwSb573Re0Q+YS3u00TdJKVimvmVg6Of9L2mk/iUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637951; c=relaxed/simple;
	bh=fMRTSlH+UgANPDJN9Lt3qr6qiGblq3hBcbGMMKAMZFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELM8+gZoWF1PDGeQgRjbgh8YsAEmcN3OL0quYleItdx9p4pmG+HraC4ZHhXWOyL45lj0VYHV3DR+aqy4oZ59NlCZFF60USnr7jvNnTEGjiKdqJH9pxhtSzwKvvSdw/W8PF3J/SymmJORgckLAfTRRaAFzIIUDTI7f0CBiUu4huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=GjYT+PXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfMeieMr; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="GjYT+PXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfMeieMr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF5811400040;
	Thu,  9 Jul 2026 18:59:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 18:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783637947;
	 x=1783724347; bh=pGGYzMzfZEiguc0QFv3xW0kx8v1ac1W4MWRdTkfH24w=; b=
	GjYT+PXhti31TCwEu4swXUtgtQzqL1tuMdwBvkjwG/J4f4sa8vM5zZ1q7twqaKxS
	78v1YFfduM0wNIUQdCAHri3KVuU/Sq0OZZoJHOXocKxadKKQR29jhnJB8CivuFeY
	bKRV2icNDITpMIIKL3JBKMHAyTdBd6P7XiK+q2A4bEr7m6RGSEH0poJpdbEfWfJa
	Tese5BXQEGbcDP/9A83GT4Yc14FRGgnod3WO61HgjYs8lJ24Sf2hhw5TmWnFzzRT
	RImTUlNP/rUmqEtZlYFX10qgMhaYOxGeoehNDPUMs/OF7i17zyF2695TRfcfitYd
	ENRP94WGGOwm5VuKEFxZ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783637947; x=
	1783724347; bh=pGGYzMzfZEiguc0QFv3xW0kx8v1ac1W4MWRdTkfH24w=; b=P
	fMeieMrngQEUu/P7t/uu+R2JdnO4xojpAPMcDjdxvAKguPkoIORanRMK0xJCSZwL
	4mlm74nRRBCsrIZ/m6u+5g4aHC5njBEJl2ca5T7hklywfPpnpFIFPYmsk/h/rhNb
	VAVFPkxYIczaBA5FA9FaRxKUHLwYk0sbOUM/nJB5TEZiDdKZzeegVLFb7xF7YYt9
	1s7xilWUPELTOZGm4zoiRqpGgQORDhFU685ZsuH7UMWXF0+t3kzXMppmv9Kjf6ej
	IOnCMOur8akEmhMAJhlJFMJxfCNlOSdtcFpSSobEgwxd/qaH8EIrbz9Sm4hQYWes
	ltGukXTOkHMnPoGmz6uxQ==
X-ME-Sender: <xms:uydQakVjbQQ0To46wmFn5Y5foP70bOjj1QnM2GW2r0xB4Ze6I1cWIw>
    <xme:uydQaqFsAAloLeVsLT9aWXbdmTruCfCXG2auIlkiE60e2QkMo0VN-GSA4SGa5N3df
    753lGs9J-0cte2D7sZZ6y2ytcwzozChFhFeMR1dD1ZAbfCPL6IPIw>
X-ME-Received: <xmr:uydQaoejSC5QneNQzHxmjSLT1ZFLEAKdWoR11M9QPl1I4P41LDSucd_O5Rk>
X-ME-Proxy-Cause: dmFkZTGaFekSOOIdJUZP0c6+OVVyumAoamaV7n5ICD3plcDVzbFPMMbZLcQDN9JyPN+EoC
    dHBY/B0S+d6fPxiMovnnozConHaWks7rxyCjvm/vHZQOZwMOoNrWo2zgbISYSSQTk/TudC
    KJSz6Z0DmJ+0NjLAMcvjRBy6IEbHBaTiLrPdGXgHPGQiGl47prL56MYH0mEQzoPVtmebCy
    qs4cHiJehHLrzCdN1/EPHAUYDtIwXcyqNYf2l9CgghD6mpA4UQOUuik7Ondzyus+sLnBdL
    n3gZ2EGxvw6gGRmNsXlEYTeQ41/dvFcoVcPyTZ9QWuGelbnwqKb9IrhilZQtEvrgF4ege8
    da+jJ8WPNCnP3CR3Zy1FPDW1dHzrMA36jEVQA/AbX+lrARr1cREAdLFR/+lTD4s1QvWnGs
    bq8GSBmf2EE6b89Fe49ciE1Tbs27iLdbLyZKNLN4iDdNM0wQrBHuNxOLprqP7BUS2vTGbi
    ZHuhuxgIfWgMyqodYfl/kE0wBBIumtGBXKVixAKNNygXkp6OUPsc44IWFrcxchQUIGTJQp
    Vfm5SaGmNynRp1G5lPu390tjRZxIVtypANdJ12NtJdy1x/uLYdVRtoBefkez12C1I1slux
    6l+FR9mcXxmz/i53uDt5t9ToTHx3uUJLR/mu0rmHLU/dj39VK9+rk7hFRV2g
X-ME-Proxy: <xmx:uydQajJESc4_HJRxYOZIyadwrQxyPUGgihQZikx0Q58JdSj0Q1iPNA>
    <xmx:uydQalE9yDh4OaP-j491NpDkeu6zykt1vuFB6LSWvg3Iv4uy3wcR9A>
    <xmx:uydQauAidtB71Nx9NzRFipAU6gb88g0Ag8PF2S-X0PtQ2GDjt6xNsw>
    <xmx:uydQag905ZQzN_ESW3eXB62udTcaNXtnT6WpOLNDneCou0l0XCkWxg>
    <xmx:uydQajiZi_Q0o2MTCsuUsS1WpiULh-tOH_smcWQ0Yf36WU43zjWgEhNs>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 18:59:07 -0400 (EDT)
Date: Thu, 9 Jul 2026 16:59:05 -0600
From: Alex Williamson <alex@shazbot.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Josh Hilke" <jrhilke@google.com>,
 kvm@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt
 routing
Message-ID: <20260709165905.0c7a551c@shazbot.org>
In-Reply-To: <20260708233341.5238F1F000E9@smtp.kernel.org>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
	<20260708-igb_v3_b4-v3-4-1272650ca614@google.com>
	<20260708233341.5238F1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Jul 2026 23:33:40 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Commit message and implementation mismatch regarding macro definitions.
> - [Medium] Hardware Initialization Order: Unmasking interrupts before routing is configured.
> --
> 
> --- Patch [4]: [PATCH v3 4/9] vfio: selftests: igb: Program MSI-X interrupt routing ---
> commit f99b27fd1b6bc3801803a7e5be3ec664facafb7a
> Author: Alex Williamson <alex.williamson@nvidia.com>
> Subject: vfio: selftests: igb: Program MSI-X interrupt routing
> 
> This commit updates the IGB selftest driver to use the full MSI-X programming
> sequence required by the 82576 hardware instead of relying on synchronous
> QEMU workarounds. It configures auto-clear and auto-mask for vector 0 and
> changes the EICR clear mechanism from read-to-clear to write-to-clear.
> 
> > Replace the magic '1' values written to EIMS/EIMC with IGB_EICR_VEC0,
> > add the GPIE/EIAC/EIAM macros, and drop the wrong-valued IGB_GPIE_EIAME
> > macro (the new definition lives next to IGB_GPIE_MULTIPLE_MSIX).  
> 
> [Severity: Medium]
> This isn't a bug in the code, but the commit message mentions introducing
> custom macros like IGB_EICR_VEC0 and dropping IGB_GPIE_EIAME.
> 
> However, the implementation uses standard kernel definitions such as
> E1000_EICR_RX_QUEUE0 and E1000_GPIE_MSIX_MODE.
> 
> Could the commit message be updated to match the actual code?

Again the paragraph can mostly go away, the only thing left seems to be
replacing 1 with E1000_EICR_RX_QUEUE0.

> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c  
> 
> [ ... ]
> 
> > @@ -280,11 +280,32 @@ static void igb_init(struct vfio_pci_device *device)
> >  	/* Enable MSI-X with 1 vector for the test */
> >  	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> >  
> > -	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
> > -	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
> > +	/*
> > +	 * Program MSI-X interrupt routing per 82576 datasheet:
> > +	 *
> > +	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
> > +	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
> > +	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> > +	 * applies on EICR read/write).
> > +	 *
> > +	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> > +	 * Without auto-clear the cause stays set after delivery and the
> > +	 * test can see spurious interrupts on the next memcpy batch.
> > +	 *
> > +	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> > +	 * MSI-X assertion (effective because EIAME is set), so a single
> > +	 * interrupt is delivered per memcpy batch even if the cause
> > +	 * re-asserts before software re-enables the mask.
> > +	 *
> > +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> > +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> > +	 */
> > +	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
> > +	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
> > +	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
> >  
> >  	/* Enable interrupts on vector 0 */
> > -	igb_write32(igb, E1000_EIMS, 1);
> > +	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
> >  
> >  	/* Map vector 0 to interrupt cause 0 and mark it valid */
> >  	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);  
> 
> [Severity: Medium]
> Does unmasking the interrupt via E1000_EIMS before programming the routing
> in E1000_IVAR0 risk unpredictable behavior?
> 
> If an interrupt condition is met in the small window between these writes, it
> seems an interrupt could be triggered before the IVAR mapping is valid.
> 
> Should the mapping in IVAR0 be established before unmasking the interrupt?

Yes, this can change to:

  -     /* Enable interrupts on vector 0 */
  -     igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
  -
        /* Map vector 0 to interrupt cause 0 and mark it valid */
        igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
  +
  +     /* Enable interrupts on vector 0 once routing is established */
  +     igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);

Thanks,
Alex
