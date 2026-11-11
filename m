Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394964;
	b=cI4rzpwc1gKXeyEREr68dKajk87rND8CdSHITTWELG8AVxhbBF2IMyftyofuoLyMecsx
	 FRPjsv8EN9OfI2Xl713B3wM3++dXZj3QH2Z5e0qtm5ReLeveAXjeAssuVP+LLC11RWKOZ
	 /d8bv6tzteDBO6hKuw1ST73nKC3+RzBeJpS+Mfx59HQYnfCoxaxIo4v2caYv+orgC+W0o
	 PVOxVwL4ALpo7RUGQNSLn/tJmwf59iJ1ojEV1FueN3pUDBEZlsgzwgIjkkpq7SEpuBOxV
	 vqramx1SJoX+konE0H61J6kfSNdFFqeoUQhyFiLJZD/KZY+S6gvOzdzQ3E627JxkQMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394964;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eMsmI+/7+hjyoTexqu24HTN/smZwOt+pO64WR6k1XnE=;
	b=I0dtZGBk1It02R6fVlGKk3nZEBpLN4mChJ/NEeLLrGbDdBylLymeB+CHGwn9gMoqcFmv
	 iZQIcNM4h7KOdODGqs6xQHniKrB63DBd3MMkm7s5AzPyEXpCtUVs5+m4Fxk5WHMta0VbU
	 9yqgHLbu+XZpNVvVEDIQgh8rk13jjfRySoofKqjsIUdcj63qCMsIGncsTze62xSyhXgZe
	 odg+u4JS+SnSg2SqN60/kkiKU+QWaytXyd1wfTTvt0wFwgxUWt+bswYnm7qduO6Upt5jo
	 jX+3s0aZov5gWsSKgjdatHPS5MsgsPAu70b5LhhNZ7MMpgRbVewtwY1r2PhE8ZSjCcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4YhUDwb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kf2WDEUN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A4606A31C
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED2A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A4YhUDwb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kf2WDEUN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794394963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eMsmI+/7+hjyoTexqu24HTN/smZwOt+pO64WR6k1XnE=;
	b=A4YhUDwbgmaeeKgxR/z7zgM3THHCoU9f+qUZmoGT9SE33B+nP2P6F2CiPrfMsVMNPhqpyU
	qzUPSFEqXFju9ih/cYV7craUHnj3wv4Fh5LVDevTtmvRgq6fV14omcnlQYBmokEnFKfEtS
	KurBapqBRaimoSrX5hnEVpWD8tpLwtQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-bscFvGDzNmuZUIQy7x5hqA-1; Wed, 11 Nov 2026 06:02:41 -0500
X-MC-Unique: bscFvGDzNmuZUIQy7x5hqA-1
X-Mimecast-MFC-AGG-ID: bscFvGDzNmuZUIQy7x5hqA_1794394960
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso17243705e9.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 03:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794394960; x=1794999760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMsmI+/7+hjyoTexqu24HTN/smZwOt+pO64WR6k1XnE=;
        b=kf2WDEUNfvrisDpOtBpb13xlM6JVz8JnvTsgZY7KuJcLL9gNaYmA2NhnuEMGbiesLB
         r2tpUwacc89O/jbIZbvvhFUBM70jGySGr9uPStKIjFbEwP304TxwYbuB6FqrX9pJ6+1G
         zJ7am+EgtCltGiWOWDtVva7yTUUoJWXhrafhamjmu39a8Urt/GpIP2EDkr5QdvovAAFw
         7+oXAsImlJLsupq/TxtyGnqhCYTEH+XGcZAzwTR0odwiti3nFJMtzLSTmpIwhkCu5Gc9
         2AKFXX6yUQIbiH1LuRqUfBM7P5uLADWkt0/UknATqrAHDlEaoWQtlPQ43QtQhG0TsVVA
         BHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794394960; x=1794999760;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMsmI+/7+hjyoTexqu24HTN/smZwOt+pO64WR6k1XnE=;
        b=iwy0VGY2zHMgkw43nGwnc7LwHkS3R2SKvXhCM2s3K5UcSuaU5B+hvOib40G8+/5JB7
         gD6mbmGobo3Z1M72g9Owid1W1/BJF+VpYYb1j9wQVOOfakTl083MUp18s/KbYD+9NZIU
         3sqstDT9F6XUXTr81BRy33slroV1ovMDaHAzo6BwcKopx/mwWnMFSHRtH/F07nJUaiyY
         cHkXG36Aa8BmdJXC+TXAF01scf7/ivIgHQ+H/Z/K8sDrHz1T5JS6YFj8ABsuCrpHQwh8
         byhlMDl8VYNbWgFniasr4qXHXFPfef6/dp5jK/7WD3SW9dVZA/o1rqHuCiQPxtSIWGGz
         dC8w==
X-Gm-Message-State: APuU4Z8oRa4xkm6aYlSDnto3kdKcxpq1OBtnO6pYMJcFZaKdN6iTwso5
	jQCamxTRL3KwYAWLaBuwbANseqK+xjxFb8ztt7C2Y9+uAkA/5z8edQx3rzcjrxsOPjOZ+3XUuoh
	4y74lfPWlv9/YvqGrXEnWD4FWDy8UOVeKrXkmPgvC/FFXQxip228SgXcxG/kwrg==
X-Gm-Gg: AYBFou0wwhxq8VvSgaKkpcZWEs/B7bPxYgrMDXQSu/15MHM+Z4Ouh71OCzTKCczHmbB
	cuJcFpUaGzCqCuwX1pMw1RURM47joTRCRYTtQ/iLQEBkBa/OyWjamRqpx0gRoaXEAEixAeSh1HB
	AeXXfYgxcZ3Oxc/oQWtoCJoRlCCxF5UNpoD3UDYEhj79/IySJz9nY4pqmwMFyejHvlsP3hZTtM3
	zBtG8T+57Ko8U8HrfkDVZfunKPD4GHk5HOVScPZP6ojCbtiWo82wVuUAIaMhvlI0/jUt2oFw37m
	uIi6SBExAklvkQzYO5pnFEd6vkI5M/9NXRo5+1oNVEF+ohQyXtRiJJm+luR2dQiIHG8VdWNxtUS
	zJOQ72t15h11PakDiN7v23bZYjTZHXQ7LESNFnPz39A==
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba0931ed6bmr34912475e9.4.1794394960289;
        Wed, 11 Nov 2026 03:02:40 -0800 (PST)
X-Received: by 2002:a05:600c:4f84:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba0931ed6bmr34911955e9.4.1794394959666;
        Wed, 11 Nov 2026 03:02:39 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2f09sm149131315e9.4.2026.11.11.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:02:38 -0800 (PST)
Date: Wed, 11 Nov 2026 06:02:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: fall back to platform ROM when
 pci_map_rom() fails
Message-ID: <20261111055054-mutt-send-email-mst@kernel.org>
References: <c5d91752c7bbd40d89f5fce5da8582f1673cdfc3.1792566536.git.mst@redhat.com>
 <20261110165221.7fb75f91@shazbot.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110165221.7fb75f91@shazbot.org>

On Tue, Nov 10, 2026 at 04:52:21PM -0700, Alex Williamson wrote:
> On Wed, 21 Oct 2026 04:20:32 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > When pci_resource_start() returns non-zero but pci_map_rom() fails
> > (ROM BAR exists but content is unreadable), the pdev->rom fallback
> > is unreachable because it's behind an else-if that only triggers
> > when pci_resource_start() is zero.
> > 
> > Try pdev->rom whenever the ROM BAR didn't produce a mapping, in both
> > the region info ioctl and the read path.
> 
> Here's the crazy thing, users actually update firmware through
> vfio-pci.  Therefore, what's an invalid ROM image on one check, may be
> a valid ROM image next round.  If we fall through to a different ROM
> provider, we might actually be presenting a changing view of the
> device.


This is out of spec anyway. The spec is pretty clear that _ROM if
present takes precedence over the ROM BAR.  I decided not to change that
if ROM BAR is valid to reduce the chance of breaking a working setup.

From ACPI 6.3, Section A.3.3 "_ROM (Get ROM Data)", page 1123:

	If _ROM is present, it is preferred over the image read through the
	standard PCI interface, in order to allow platform runtime firmware to
	provide re-configured ROM data via the method.


Would you like me to simply implement the spec? Use _ROM if there
even if pci rom bar is valid?


> I believe this is why we intentionally always report the physical ROM
> BAR when present and mapped, regardless of the contents.

No such setups should have _ROM, since rombar would then be ignored.

> QEMU, of course, has the ability to take the ROM as a file and override
> whatever is provided through the kernel interface.  This is how I had
> previously made use of a secondary GPU on a laptop, dumping the ACPI
> ROM to a file to provide directly to QEMU.

First we need a way to get the ROM from _ROM.

> 
> Does your GPU support a ROM BAR?  The v1 patch didn't have this and
> would have exposed the physical RAM BAR if present, so I'm guessing not.
> Thanks,
> 
> Alex

It has a bar but it is not accessible. _ROM overrides that, as per spec, and this
appears to be how nvidia drivers use it and expect to use it.


>  
> > Fixes: e021e6cbfb5a ("vfio/pci: Expose setup ROM at ROM bar when needed")
> > Cc: Yunxiang Li <Yunxiang.Li@amd.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > 
> > Notes (changelog):
> >     v1->v2:
> >         bound reads by the ROM image rather than the BAR once the
> >         pdev->rom fallback is selected, so reads match the reported
> >         region size (a pread spanning the image used to fail with
> >         -EINVAL past the BAR size)
> >         add Fixes: tag
> > 
> >  drivers/vfio/pci/vfio_pci_core.c |  4 +++-
> >  drivers/vfio/pci/vfio_pci_rdwr.c | 32 ++++++++++++++++++++++++--------
> >  2 files changed, 27 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 050e7542952e..630474d03e3b 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1128,7 +1128,9 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
> >  				pci_unmap_rom(pdev, io);
> >  			}
> >  			vfio_pci_memory_unlock_and_restore(vdev, cmd);
> > -		} else if (pdev->rom && pdev->romlen) {
> > +		}
> > +
> > +		if (!info->size && pdev->rom && pdev->romlen) {
> >  			info->flags = VFIO_REGION_INFO_FLAG_READ;
> >  			/* Report BAR size as power of two. */
> >  			info->size = roundup_pow_of_two(pdev->romlen);
> > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> > index 3bfbb879a005..6e47d529cbb9 100644
> > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > @@ -219,7 +219,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  	int bar = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> >  	size_t x_start = 0, x_end = 0;
> >  	resource_size_t end;
> > -	void __iomem *io;
> > +	void __iomem *io = NULL;
> > +	bool rom_is_mapped = false;
> >  	struct resource *res = &vdev->pdev->resource[bar];
> >  	ssize_t done;
> >  	enum vfio_pci_io_width max_width = VFIO_PCI_IO_WIDTH_8;
> > @@ -231,11 +232,6 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  	else
> >  		return -EINVAL;
> >  
> > -	if (pos >= end)
> > -		return -EINVAL;
> > -
> > -	count = min(count, (size_t)(end - pos));
> > -
> >  	if (bar == PCI_ROM_RESOURCE) {
> >  		/*
> >  		 * The ROM can fill less space than the BAR, so we start the
> > @@ -244,10 +240,30 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  		 */
> >  		if (pci_resource_start(pdev, bar)) {
> >  			io = pci_map_rom(pdev, &x_start);
> > -		} else {
> > +			if (io)
> > +				rom_is_mapped = true;
> > +		}
> > +
> > +		/*
> > +		 * The BAR can also exist but be unreadable, e.g. on a GPU
> > +		 * that was never POSTed.  Fall back to the ROM image stashed
> > +		 * by the boot loader; the region then follows the image size
> > +		 * rather than the BAR, so bound the access only after the
> > +		 * source of the ROM content is known.
> > +		 */
> > +		if (!io && pdev->rom && pdev->romlen) {
> > +			end = roundup_pow_of_two(pdev->romlen);
> >  			io = ioremap(pdev->rom, pdev->romlen);
> >  			x_start = pdev->romlen;
> >  		}
> > +	}
> > +
> > +	if (pos >= end)
> > +		return -EINVAL;
> > +
> > +	count = min(count, (size_t)(end - pos));
> > +
> > +	if (bar == PCI_ROM_RESOURCE) {
> >  		if (!io)
> >  			return -ENOMEM;
> >  		x_end = end;
> > @@ -283,7 +299,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
> >  		*ppos += done;
> >  
> >  	if (bar == PCI_ROM_RESOURCE) {
> > -		if (pci_resource_start(pdev, bar))
> > +		if (rom_is_mapped)
> >  			pci_unmap_rom(pdev, io);
> >  		else
> >  			iounmap(io);

