Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F4582CF
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676249; cv=pass; b=C4LXvMAqzAEFHsmnDAIAHkXOmT+t+1xNT67mSxzHaWiLqBamCoeaY0NYzFJeVWEHFTuhkXohIWg8mX3wuyDiTdhJuHOmH6OOxGCAdDL/k4/5Iiiks2YH8m12YFqpYM3iNfz1CeoRPhZKo+Xr0uZjvKfVuOPGZj9D9Z7c34dKieA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676249; c=relaxed/simple;
	bh=7sCYlVaL2+1CZKJKEZ/isaJFx6+E0RgIqlrpWAw+f2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSg3WR3qbody7XVWCdM4mkwjIbl8dOTGrIiqa3xC0v2Bg17qrt1GXtnmwiQAKaCF5MteLhm6xX//rWC7ZHRExQlEGweecB/O+PCHMu5QEC//7cuOh5ojuRNzEiusparlhAzZx9l4UbsfLUAJmwY51g8La02AbbdIKjNcBLP3nDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aqc8KMmO; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aqc8KMmO"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a8173142so9083e87.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784676246; cv=none;
        d=google.com; s=arc-20260327;
        b=TcjWM5u71Kz1Ea6MCt1QJ/qaBfE57PuD/GMb4bHqyD7uDSBbFu1ekfbIb0hQB7u4Ds
         OQEdtYuK0NuJT2QB9P+djtLwcvX9oXmwCUdAaRkfVlJZ5QXLoHJ0ZIt+caweQ0EUzhhC
         QgU8MPEj+0xu4mGWxiyG05VWXijAkn9Je9wL79wqugGpx04+mead31qp4p/tLyXxU69e
         x8lXj6E9CuvtWr3REbEucU7vozyBl/6qq1lZ1EDKLPjq7eK03yiY5dOqTNRTgwY/z25m
         zG+BxJ5nx6kzmunL4ev6LESEsQ+raCXiPPSx+Eb6Dsi1GYxPPEPzV2rZDa0tvJLhI6Si
         KOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P63nR5J5VcgsLEKhW3G2CnQQw+ZQC3+nOPuDBqd6w98=;
        fh=thguSNjxisZsDb/3AGO5YDcx8tjYLdK7UePrCwJfOjs=;
        b=iLf4pI8LC5oejPuu9wYxCEYWmrMRBfm+yo3yOwR5xHEF8DLNw5UQk7HaTXgBntknKY
         zEX1LfFOY0uCD9r5ZMUIqcMJry0tBKn704CSF/0jgosXtFOaoDJ2gD1V4mp85lun745j
         lqVboZGud3FwYnX8nnF//0btr5TFotIhvMehsYgNJ/zX2bJDPngLBVYV6OJjpFRVNCbD
         h4QHUfHM87K1ljXWIWxNeoZ1/mlohbmE6pLxY3WDpwaqGGPOChE42jTyu6g1XTQqnScz
         SFZdofaLAg1WpY12D4rea8J9839bCKIZRndstQLHpjQ097zEkUoZl6HsuQVzyj8XTWRS
         oveA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784676246; x=1785281046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P63nR5J5VcgsLEKhW3G2CnQQw+ZQC3+nOPuDBqd6w98=;
        b=aqc8KMmO6dMf1Lg5sJU/jA6YDCGizEfRoww7iPxO3vEzMKZw+Y40nJlZZwTexXj94I
         CqCsKnX721WAOYbDyFMuGoyPNr39Oj7lg01r9vcJDmNf90F+pftLr8SWfJybPJTZWIif
         /AifFAKtOY2ABDU0XyFrbi3aaLcUDRe4rHfvDEsqGgiL+XjHpz7yZ9gekmYGptWakgaj
         +3u7L+zvFGZ3qW5AkKRz+UgzZ6y8v01liM1DC5xs2D8NBGqgN8tiy/MqvPIkc6w4lS2J
         WTjXoyvbBvDSavl+s2w0eGdbZPIB0DpKTx3Fu+I4+hT4Jv67wzLKnA4OztRTV0jFHisD
         A74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676246; x=1785281046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P63nR5J5VcgsLEKhW3G2CnQQw+ZQC3+nOPuDBqd6w98=;
        b=ZA6LNqXf1Rhcx1mhYzk/iTNEtYqSeDdFDbhQJ4b9hgCiTL3wCmb/ARWKNwW2P1X2/U
         biv5InplM9PqlMEmfdMoH9Uky+Snp1wUOV8Hk7k+B9kwATU9W2MqeLy27mLxVVUM8ekk
         +IBQDOF30x9aVnquO9mOsAzH4mswRVSZVz6SUJ1ndT3+Wenrwc8DrkNeaIIsQZUq8jk9
         2qCyMFvGB/fnZyF1VDvMl0C8JIUn9uKayZx1OYi+z9ZEIesVXo6wPl676mVBEsEY0DsH
         +6qCCGUINgPbd4gI1z/1HvPAVBbU6jClxJdvYLCoM3nrXRhyPILuH5x5UoCMHMH2/T3y
         EGhQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3bmtrEWLr1Z4VQ/z6H1bp/Y6aHJIwSx/RzM1f6TFStdDkbNEFYURkCZLtF46nBUFMkN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqwylJVSSZ01+vCFTXVAk8fE79/Dn224Fhh4etJhUm8PzS+v8t
	7lVp/Ih014ayCNvGfyBU4WP0Np6d98zTjeGCdhjxll9rUeu2yC4BeZ0TVkos97xnX9wUPo/hoVo
	I5IUQ4dQ1d7NOya9K2YK359OZxR3BGbK6SICGWD0=
X-Gm-Gg: AR+sD10b/ApSJyTyZT9ti3s7rxPW9/EB+J+AuQjVJG1m+BlifyPLCoyXCf50rzIUl1O
	Ck/cg/cD/qEmI4NunRHMaf7axSgPKcd1ykIQW+mzhWRpgi4GI6BRxYSkQIPztAff85rsu7EukEL
	W6HtBNAzkeS6uE3Fd2zsi3jWynCFvotxoMzmIGDXv49xgRl0qic4xpMzMMMi8p87ivUE11JeOwV
	ANcgGPoaAqDSoe89CdDHJaqFC3F2YXcz1uMYJR5H6pGnZtYmKMzVmX75Q==
X-Received: by 2002:a05:6512:2306:b0:5b1:571f:715f with SMTP id
 2adb3069b0e04-5b2aaf90ab6mr35184e87.3.1784676245415; Tue, 21 Jul 2026
 16:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com> <20260714211204.437281F000E9@smtp.kernel.org>
 <CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
 <20260720154227.1f727abe@nvidia.com> <20260720155120.2815e269@shazbot.org> <al_4RXwK0IeV1n7D@google.com>
In-Reply-To: <al_4RXwK0IeV1n7D@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 21 Jul 2026 16:23:53 -0700
X-Gm-Features: AUfX_mxcEeAOGKigvekzUHIKnmzcVMbyEIl20KIxIb9L_apGupkAAT1xrJux0Yo
Message-ID: <CAAdrzjso3yg3cZsUAxg0NCsExfm9No=6XnvgQ_jY5Je7qJ8cNg@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read faults
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ack, will do!

On Tue, Jul 21, 2026 at 3:52=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-07-20 03:51 PM, Alex Williamson wrote:
> > On Mon, 20 Jul 2026 15:42:27 -0600
> > Alex Williamson <alex.williamson@nvidia.com> wrote:
> >
> > > On Mon, 20 Jul 2026 14:27:12 -0700
> > > Josh Hilke <jrhilke@google.com> wrote:
> > >
> > > > On Tue, Jul 14, 2026 at 2:12=E2=80=AFPM <sashiko-bot@kernel.org> wr=
ote:
> > > > >
> > > > > Thank you for your contribution! Sashiko AI review found 1 potent=
ial issue(s) to consider:
> > > > > - [Medium] Test flakiness due to fixed heuristic delay instead of=
 polling on EAGAIN during VFIO_DEVICE_RESET
> > > > > --
> > > > >
> > > > > --- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after=
 DMA-read faults ---
> > > > > commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
> > > > > Author: Alex Williamson <alex.williamson@nvidia.com>
> > > > >
> > > > > vfio: selftests: igb: Recover after DMA-read faults
> > > > >
> > > > > This commit adds recovery logic to the igb selftest when an inten=
tional DMA
> > > > > read fault causes the device to hang. It introduces a reset and r=
e-init
> > > > > sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow=
 kernel
> > > > > error handlers to release the device lock.
> > > > >
> > > > > > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c=
 b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > > > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > > > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci=
_device *device)
> > > > > >
> > > > > >       igb_irq_enable(igb);
> > > > > >
> > > > > > -     return (status & 1) ? 0 : -ETIMEDOUT;
> > > > > > +     if (status & 1)
> > > > > > +             return 0;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * The descriptor never completed.  On real 82576 hardwar=
e this
> > > > > > +      * typically follows a DMA-read fault from one of the int=
entional
> > > > > > +      * unmapped-IOVA tests; the fault leaves the descriptor e=
ngine
> > > > > > +      * unable to service subsequent valid descriptors.  CTRL.=
RST alone
> > > > > > +      * reinitializes the queue registers but leaves the engin=
e wedged
> > > > > > +      * for the current process, so a broader VFIO_DEVICE_RESE=
T (FLR)
> > > > > > +      * is required.
> > > > > > +      *
> > > > > > +      * Delay before requesting reset so PCIe/IOMMU/AER error =
handling
> > > > > > +      * triggered by the just-observed DMA fault can release t=
he device
> > > > > > +      * lock VFIO_DEVICE_RESET contends for.  The 10 ms value =
is
> > > > > > +      * heuristic.  The current memcpy still fails with -ETIME=
DOUT;
> > > > > > +      * recovery only ensures the next memcpy starts from a us=
able state.
> > > > > > +      */
> > > > > > +     usleep(10000);
> > > > > > +     igb_error_reset_and_reinit(device);
> > > > >
> > > > > [Severity: Medium]
> > > > > Will this fixed heuristic delay cause test flakiness under heavy =
load?
> > > > >
> > > > > If the kernel's PCIe/IOMMU/AER error handling takes longer than 1=
0ms to
> > > > > complete (for example, when KASAN or other heavy debugging option=
s are
> > > > > enabled), the device lock might still be held.
> > > > >
> > > > > Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
> > > > > vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_func=
tion() to
> > > > > return -EAGAIN:
> > > > >
> > > > >         ret =3D pci_try_reset_function(vdev->pdev);
> > > > >         if (__vfio_pci_memory_enabled(vdev))
> > > > >                 vfio_pci_dma_buf_move(vdev, false);
> > > > >         up_write(&vdev->memory_lock);
> > > > >
> > > > >         return ret;
> > > > >
> > > > > Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(),=
 which
> > > > > asserts that the ioctl returns 0, would this lock contention caus=
e an
> > > > > immediate test suite failure?
> > > > >
> > > > > Should this code explicitly poll for -EAGAIN from the ioctl inste=
ad of
> > > > > relying entirely on a fixed sleep?
> > > > >
> > > > > > +     return -ETIMEDOUT;
> > > >
> > > > Alex, I'm guessing 10ms is what worked for you when testing with th=
e
> > > > physical hardware? If it's working fine, I don't think it needs to =
be
> > > > changed.
> > >
> > > Yes, the delay was found empirically and indeed we could make this mo=
re
> > > robust if we retried on -EAGAIN.  I'd be in favor of doing that as a
> > > follow-up.  Thanks,
> >
> > Oh, some further context, vfio_pci_device_reset() asserts the return is
> > zero, which IIRC, is why I accepted the heuristic delay rather than
> > expand the scope with a new reset callback within the framework.
>
> Let's fix vfio_pci_device_reset() to retry on -EAGAIN. Josh can you apply
> something like this on top in v6?
>
> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> index f50d450d3e94..25cac663de1d 100644
> --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> @@ -533,14 +533,7 @@ static int igb_memcpy_wait(struct vfio_pci_device *d=
evice)
>          * reinitializes the queue registers but leaves the engine wedged
>          * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
>          * is required.
> -        *
> -        * Delay before requesting reset so PCIe/IOMMU/AER error handling
> -        * triggered by the just-observed DMA fault can release the devic=
e
> -        * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> -        * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> -        * recovery only ensures the next memcpy starts from a usable sta=
te.
>          */
> -       usleep(10000);
>         igb_error_reset_and_reinit(device);
>
>         return -ETIMEDOUT;
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_de=
vice.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index 2e67afc0d580..27bdf561925f 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -41,6 +41,7 @@ struct vfio_pci_device {
>  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iom=
mu *iommu);
>  void vfio_pci_device_cleanup(struct vfio_pci_device *device);
>
> +int __vfio_pci_device_reset(struct vfio_pci_device *device);
>  void vfio_pci_device_reset(struct vfio_pci_device *device);
>
>  void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/t=
esting/selftests/vfio/lib/vfio_pci_device.c
> index 7b8394d0ac50..45704a2c9485 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -221,9 +221,23 @@ void vfio_pci_config_access(struct vfio_pci_device *=
device, bool write,
>                        write ? "write to" : "read from", config);
>  }
>
> +int __vfio_pci_device_reset(struct vfio_pci_device *device)
> +{
> +       if (ioctl(device->fd, VFIO_DEVICE_RESET))
> +               return -errno;
> +
> +       return 0;
> +}
> +
>  void vfio_pci_device_reset(struct vfio_pci_device *device)
>  {
> -       ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
> +       int r;
> +
> +       do {
> +               r =3D __vfio_pci_device_reset(device);
> +       } while (r =3D=3D -EAGAIN);
> +
> +       VFIO_ASSERT_EQ(r, 0, "ioctl(device->fd, VFIO_DEVICE_RESET) failed=
\n");
>  }
>
>  static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
>
