Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A562D8379
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582849; cv=pass; b=Rgk3hPCLOdkb2xfSZT9FG9XDu6ulUz30fZJ7VDj5P4FU996lyL7gRnMSX7fMCx6w4uE/8L1jyF2559HpmpnIyNK8YpMKPFkSoTeRfsbc98d+1pwSlTTY1JqZNhRLTbj2ayKyOTovww6z1gSRg60/A5F3JTZwBGuvuxjOXSYTLpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582849; c=relaxed/simple;
	bh=iuBz6ODbxctIQcEz9hRVx17UzGZhYMd+1SN8l/Iffi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn5KNaTXv/gg6VOHSlYhtdbRZkCuTz4md8RZdOq/hY0xNoQYC/CrIN4lLUwztrDBdGZjNxlhN6Gdjwm/hvFMUkH2I9KkpyA1L3IFauFGMwwS/K4OKhJNtiCKCWPAr5GNc497nnDR7zD5maVySSFyMPYROAsBOTnC0lOhW4od+mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVoF/3dC; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVoF/3dC"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b020a70f9bso18390e87.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 14:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784582844; cv=none;
        d=google.com; s=arc-20260327;
        b=nP5VVaToocjca6srXIY8QZBd54FVCqBakWZEg3p4n6sTzwKLKfXhezyT7sr4KX3OdU
         d3mF67w0H7oTtxh1Ot7PfbVipLzUpQfF5hWhMdP+89brNZbUIVEJuNyIJsBrJTvXCryb
         5TUeTA0QN16SEiNsFj5/mdtasKFhkEBQqIpin53g9t4ZeMyR/DN9HBpVhGOCiJzqe6XC
         ns2ygNQDUKkuGq491Z/IeUxinZXCCak97nrYvJepb/qSYTjagwgHMO4b9Ix9JVSpGivu
         iE0MBkEoxhRishlOlofeYkju8Jfw3lXT24f80dXTswucEttkt3NNaTOPTP6UP4n2eaBM
         GFCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M8U0zaKrWazb9iq+MM5NRDtbR/DvHa80gVd/ybVUHLY=;
        fh=QlUXu5ScCU3oQ/wPVaDn0x8Qs/lOFTTH1bYHPua1hnA=;
        b=Bz9gYCxJFTt/xTTz/T0KINAy1WTY1AhbxEXU6cbEr7zi5NHEf68EZTeYvf1KZu8nZu
         H4kvjG4lxriRfDP4oM2FOcxdtlb8ecL4+xwCeta70tSMg0p/gKbTtUEHlO2UB+y4Vg7P
         /LaPxiFD1+paTDRdz06Pr4n5SZ2pSIQfimZ0TqwckDoL4Lo/Azqho0sSW++6k6d5NtIC
         ucBhqNxHMTTp/ZEm1/79hnPYC7PjAzL/v0Z3rl5sX2HEW+GPqihNqOvbyV0onj8m/71S
         +DcLepyXnpi1z/9bPC1RT6uILHt+nLw+7v40URrlX/OFwYOksDM1Ld05zj7LREVy8fJD
         Sj1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784582844; x=1785187644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8U0zaKrWazb9iq+MM5NRDtbR/DvHa80gVd/ybVUHLY=;
        b=sVoF/3dC9AN/OpKKk+LPk1sOLqK2h1cCNWcOEnsHvHITo3gtYiHFxOph83MAUdP9bJ
         1ZtdS3SaSTZJRiqcBhIDUYRpSN4WlvoiTpJhz2Zzzw20/IozTsaCJdxQEk1JOSxbIsA9
         ucwE5x+ZiZmxQnz4+j0Jl6hMXnwO/VB41oIkEoOFotRvFwwOL7bp7HN24Hkt+BS5lHx2
         4I5xY2BpMXySbWrpbbzGwEPysP1ZFJy/X0EXR0MPUEAyeKB/5IQrjgS7kCCxaKvHH6OO
         3l1fc3benSNnCZ42w/SfMoJ4hMdOvTTMI2f02JGV/UD2U4ZyuVmXvJkvm/W/BoBcC8Mu
         WGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784582844; x=1785187644;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8U0zaKrWazb9iq+MM5NRDtbR/DvHa80gVd/ybVUHLY=;
        b=GSiCx4lT86YdF7h6nhihYM425+QGz54zN64rJfGddjWW4DFpC2LvZP6Xc6IfE25qgj
         jXMnlb1G+xv96ULNQ3SgjB3nLwmFdPHoVl9+icN8P4uQPKjQ2U64W6AhTazSP+U4t4oA
         5MvXQ7if7wxu67TAPpwy8vVItkZMVHZ96Eu00kH5/l6GOMS8PTpl8vEZHcEZ48qGCkv3
         Mq1c/ne2gLwj9QsMOKu65UKYYOYf7wzHnPFb4cYgI/BpzHvhOsxaNsRoFeNoGqFhXOK8
         nEGPRSu6qvZfYozGa+OTV/JV+AwV7bdIcAKREq0o4XArE5jbaKJTVCLDy2CLFbxwjAl+
         /yCA==
X-Gm-Message-State: AOJu0YzvhI5ZUeSeisYLacuiiGg3R3GO+1+IAbJHtsfyhrRTlPzpBZAE
	G0d4Jbmd5+FdjyJG7/BD6OhirDzym8oxg61MYp8hR6QwoTv+Y/SgaGp00YMB6OHDEJ+yC+pdC/Y
	+5C6KZoSB7VLarHkzmq7dt8brkWg2iIa/p9LbYyb0+HlrIBJVEWj7H9o=
X-Gm-Gg: AfdE7cngQOzWOaxMWF0ZgaUd/cRqeIWwK0eZ+uS/ko4zmzlPQzkP3atZokDg32jGvDC
	eC3XOYdqciTjA19f3A6rh9ncxGLM+HWlFgY2/DkEjsh+OnoEBbAqMZ3Y59ZNLgyWbB0k9S9gA+T
	szfmcvAv5aloyHQFNZ7wsPHAlgaT8LXG21jpf3N+Qh4yqrASC4gO3COAVjQZ9k1+71AZPUN+OOs
	8mndQLPUwz+jYMEdJMvUp3zv28dmb6Qulz3KI2suNXcl6Xf7YHRYZ9lfpc/36aVg7i48hs4WDTi
	6vzU9S1jsoDIwoY=
X-Received: by 2002:a05:6512:3b1f:b0:5b1:ca0b:25d2 with SMTP id
 2adb3069b0e04-5b2a3159c1bmr174289e87.4.1784582843798; Mon, 20 Jul 2026
 14:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-5-91503eddb98b@google.com> <20260714211204.437281F000E9@smtp.kernel.org>
In-Reply-To: <20260714211204.437281F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 20 Jul 2026 14:27:12 -0700
X-Gm-Features: AUfX_myD3e5q2EqrZATf6h1baJ9SeqS4RqB0ub2E2ay9NhrO9FU2hAXEPYHjQ5w
Message-ID: <CAAdrzjsNJfkFjwK4Nwendph60=FFhYCbXkXzTXO354roK3GoTQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-read faults
To: sashiko-reviews@lists.linux.dev, 
	Alex Williamson <alex.williamson@nvidia.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 2:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] Test flakiness due to fixed heuristic delay instead of polling=
 on EAGAIN during VFIO_DEVICE_RESET
> --
>
> --- Patch [5]: [PATCH v5 5/5] vfio: selftests: igb: Recover after DMA-rea=
d faults ---
> commit a631c99ce1be37dbbdda0314b730b2c6bd947b50
> Author: Alex Williamson <alex.williamson@nvidia.com>
>
> vfio: selftests: igb: Recover after DMA-read faults
>
> This commit adds recovery logic to the igb selftest when an intentional D=
MA
> read fault causes the device to hang. It introduces a reset and re-init
> sequence using VFIO_DEVICE_RESET, including a 10ms delay to allow kernel
> error handlers to release the device lock.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > --- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
>
> [ ... ]
>
> > @@ -500,7 +522,28 @@ static int igb_memcpy_wait(struct vfio_pci_device =
*device)
> >
> >       igb_irq_enable(igb);
> >
> > -     return (status & 1) ? 0 : -ETIMEDOUT;
> > +     if (status & 1)
> > +             return 0;
> > +
> > +     /*
> > +      * The descriptor never completed.  On real 82576 hardware this
> > +      * typically follows a DMA-read fault from one of the intentional
> > +      * unmapped-IOVA tests; the fault leaves the descriptor engine
> > +      * unable to service subsequent valid descriptors.  CTRL.RST alon=
e
> > +      * reinitializes the queue registers but leaves the engine wedged
> > +      * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
> > +      * is required.
> > +      *
> > +      * Delay before requesting reset so PCIe/IOMMU/AER error handling
> > +      * triggered by the just-observed DMA fault can release the devic=
e
> > +      * lock VFIO_DEVICE_RESET contends for.  The 10 ms value is
> > +      * heuristic.  The current memcpy still fails with -ETIMEDOUT;
> > +      * recovery only ensures the next memcpy starts from a usable sta=
te.
> > +      */
> > +     usleep(10000);
> > +     igb_error_reset_and_reinit(device);
>
> [Severity: Medium]
> Will this fixed heuristic delay cause test flakiness under heavy load?
>
> If the kernel's PCIe/IOMMU/AER error handling takes longer than 10ms to
> complete (for example, when KASAN or other heavy debugging options are
> enabled), the device lock might still be held.
>
> Looking at the kernel side in drivers/vfio/pci/vfio_pci_core.c:
> vfio_pci_ioctl_reset(), lock contention causes pci_try_reset_function() t=
o
> return -EAGAIN:
>
>         ret =3D pci_try_reset_function(vdev->pdev);
>         if (__vfio_pci_memory_enabled(vdev))
>                 vfio_pci_dma_buf_move(vdev, false);
>         up_write(&vdev->memory_lock);
>
>         return ret;
>
> Since igb_error_reset_and_reinit() calls vfio_pci_device_reset(), which
> asserts that the ioctl returns 0, would this lock contention cause an
> immediate test suite failure?
>
> Should this code explicitly poll for -EAGAIN from the ioctl instead of
> relying entirely on a fixed sleep?
>
> > +     return -ETIMEDOUT;

Alex, I'm guessing 10ms is what worked for you when testing with the
physical hardware? If it's working fine, I don't think it needs to be
changed.
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-igb_v3_b=
4-v5-0-91503eddb98b@google.com?part=3D5
