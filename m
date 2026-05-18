Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C6138F927
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 19:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134058; cv=pass; b=ANuxdrq8K+Dsz9Eom0JZ13YMVzkHYyWmEr5QgWKBk5EXn58PEFogzemlP8SjW5Hh8XVU2mXXu320fkbUBWoL27JqOj/n6qQXGAH6iXkxLWQ5D5KISjmrjJt3LRnwo5+WzzusagQV6cr/69P4zlkah/y/NJ/z97Nq66BcxJHp8ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134058; c=relaxed/simple;
	bh=Uq9MBwJQalTfomORvywrRbIp/ZxIkuY7Xba1Qi+P0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyewQHsmFauDR+CSAx5IF/B5ZHaly1fVDKMqptwF6z5V/bakPTskhLuh6orZWdbgqLA7ZuRnOxlHWULg4f2m+y/5hwpfzA8+7t4d1P9nkUNCCUdCHzaKqkLGuyiouuezRfpKdvV+A6vC0iqsuJv59ibhBNBLYuBOMgCnC1536Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGLE4gpN; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGLE4gpN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d864c23bdso4411cf.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134056; cv=none;
        d=google.com; s=arc-20240605;
        b=jjNJbCAuDrNYGAoc/2AmigJJ+W76buz+eHD7kFxj3q46ZTJSeTiqzDLksYQD4EEhId
         aJ4wYY9/oU1mrY8oKB/9IdndL0zCLmjEoytC1Hv8sWCxOBb/Kl8L7Eq4qkL+d1mOzah/
         m6DeDiyoT+18KqsysydBNIlJ+GtiuznGzjzwDWA2iJ4Gw3H0nSN/MiHt2E9TusClT4Lp
         LK7fcXJ+Yrwznr2uvBJx3qtkaye1yuli6jupJ81cZlWUrnDUijLAFgmrbxItZytYNi6w
         I7yAZMvg8jIHIEURRVQXcJjkAvpD1PQ5anVmQRP7TspaJ0UjVCNulPiC3ahOIxCKG2RR
         /5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U4QjA58b8gb0A6ZiizVLT64uU57BjxHGT9ukovXQO7A=;
        fh=bCXiWUIJgdxlITgtSUGKFzy2AtoQ6TLMbFy8659VYxg=;
        b=gmV+qCuLolYUZGCecZkPHM7tgHGaqEpohhEbdc4ElEPIH9hZtzOujodLFdtI0B1vUw
         3k9xCgNpW0UprUj10ms3u6UL8WG4RYM/W99RArky0x8mCrPw+XiwOyamqmT6HUd0Zn34
         ce5WfMwFalQ3iQbyI1G+53XLVdx0F2ZY8Ren8SqroE7asWSsbnjhAauJb/L42YkB7/Lz
         RcMJwWquHO7Bo9xUiV/ODdHzzncCKz0Biegknvaa+4lfehj9z7M1FLSF1J6MXch0I21v
         q4sPStMg60uovhcbKIk1nCssqCBbAPOrxQ5mWwHIyJTgg9IDU0PQySGhzhQnhTPLw4Ap
         pkjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779134056; x=1779738856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4QjA58b8gb0A6ZiizVLT64uU57BjxHGT9ukovXQO7A=;
        b=jGLE4gpNIT1REGvxublB3UkRFg5nutyvAoZXviy7Df58WmhyTUmNZ2WjBJQ/5BKcch
         YCjDSyaa1OggpjVO485wHs5Zg5yt3tSUhnUCnFgzRXSWepSd9xWzGKmTG4oO/P6E4mGu
         rJGSSqmQGfHc3xyBqAAFNvln0MZFw9Fj7mBhKJT9plROamRcPbj3kADKZNPW+FGcXGqy
         knwAa78+usxDpfJyKg/nl0KaOgwaAYNiXVnw8yXf+XU/HbcyYg+nMEHeGKwPb72QrP3y
         4qIrZOSfpq+pEbfV5issxg5LxEVW5bW/t7SJpE/mpD/gQoWi0yOLtt1HPhGavvseyapx
         3uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134056; x=1779738856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4QjA58b8gb0A6ZiizVLT64uU57BjxHGT9ukovXQO7A=;
        b=lypcMQz4wRoG2SJ4BzBinrX+wROVR6mHfaypN4P2Q/32I0957EcYlC6NufSjg7YeGS
         Q7LTiwZttfsj0nuXrw8q/4T8O5E0hyunK90o9FtCWDEQPwU5ch6E4p9eTvT1/lHBYqmK
         1kwkEM34oloy4r2fKel6Jnmipa8DJqXYXTw1XS+l16HLD3gE3Ek7TkfMyg1WXw6AvPO9
         UZD3RqEhjq530qg+g6He+NSVbKm3apukPM4gYDeHeAnOV/ZSePUyp6oCyAmNsXkejFHP
         1DJQ7ESzhi2pAkbINEe5nwxg0mOZyEZ+69fz5sw1S4C/r1o5p0dSDpCXB3hBEpyPhaTy
         +keA==
X-Forwarded-Encrypted: i=1; AFNElJ8enD7/qilu3DrJo8cdDr9dK1GMGngH7RfFDbsy66nge63SAKzmX6rSMxQlXdwdZHx68rw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lAtQcoRdmQeCsGT4OKO/xZuFAeR1AlsqrKZzn4YlY2XvvWOB
	xyX482oXllRDTEe0RcWYhnh5e9C2+4RWeEopU8AQ5QgvA8qVujnMAE29cy9O6Q5kxUTBc9GrNLq
	fL7EIRLjwEyMuyR0PcwKlpjWYGqu0Agz7rVPXTiA=
X-Gm-Gg: Acq92OFQw87SUcNUvFgCeg0RFn4iUW66CP5C62PURJ5AZiu1TPaf40ESHhmpWzuQnrC
	yqS5/Cb2qSpIJF8CWV1Zkj9BFxP49klDSxwRSXKcMH1s3A1XmEqaXkXGORlrEzc2Hqin2Mgq3NV
	VnvZZtA8bH2NIWC1lo38PfskDspuyinvorceYHaHRwgZkLLqEGDUzpo+SdU/wkL17LEKz3haVX3
	8FTV1Hm7yHjxVd0TDS9A0Mwxpog0Ez0ZCAfIdsSlX9lC55kY1x9SEEYt0uz4aM0hRA5cKJ/f7gH
	0zGwW+Zb7SuziSEOuphbXlLbihcCUklWQocVEuNEaG2KT4zaqQ==
X-Received: by 2002:ac8:5d0d:0:b0:50e:5eba:cadd with SMTP id
 d75a77b69052e-5167937dc29mr2608291cf.2.1779134054898; Mon, 18 May 2026
 12:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515220330.565792-1-alex.williamson@nvidia.com>
In-Reply-To: <20260515220330.565792-1-alex.williamson@nvidia.com>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 18 May 2026 12:54:03 -0700
X-Gm-Features: AVHnY4Iao2s9jKR35-OKwsWLS-a7bWVtC8RYDeK73Uc-mboJYGAh0c2wAfbdfWs
Message-ID: <CAAdrzjvQB1NM=mM-0QYs907DRT_2c07xmBko2+uhZ2XvMTfwTA@mail.gmail.com>
Subject: Re: [PATCH 0/8] selftests/vfio: igb: 82576 hardware compatibility
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>, 
	David Matlack <dmatlack@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 3:04=E2=80=AFPM Alex Williamson
<alex.williamson@nvidia.com> wrote:
>
> This series is based on Josh Hilke's initial igb selftest driver
> posted as:
>
>   https://lore.kernel.org/all/20260511211839.2781731-1-jrhilke@google.com=
/
>
> That posting validated the driver against QEMU's emulated igb only; it
> has not been tested on physical 82576 hardware.  Real 82576 silicon
> rejects several of the shortcuts the submitted driver relies on (MAC
> loopback, legacy TX descriptors, read-to-clear EICR, autoneg-based
> link bring-up, and an unbounded fault-recovery story), and adding
> real-hardware coverage is the goal here.
>
> Two of the patches add accommodations specifically for QEMU's emulated
> igb (which does not implement PHY-register-0 bit 14 and does not drive
> STATUS.LU from CTRL.SLU) so that Josh's "run selftests without
> hardware" workflow continues to work.  One of these (RCTL.LBM_MAC)
> deviates from datasheet 8.10.1 guidance; empirically the bit has no
> observable effect on real 82576 because MAC loopback is not
> implemented (3.5.6.2).  See patch 1 for both rationales.

This is great, thanks Alex! I'll integrate your changes and David's
comments on my v1, and mail out our changes as v2.



>
>   1) selftests/vfio: igb: Use PHY internal loopback on 82576
>
>      Replace MAC-loopback-via-RCTL.LBM_MAC and PHY autonegotiation with
>      PHY internal loopback per datasheet 3.5.6.3.1.  Force the MAC link
>      state via CTRL.FRCSPD/FRCDPX/SLU since the descriptor engine
>      otherwise waits for a real negotiated link.  Keep RCTL.LBM_MAC
>      (deviates from 8.10.1 guidance but empirically inert on real
>      hardware per 3.5.6.2) and prefix the loopback setup with a
>      one-shot autoneg-restart PHY write (the next PHY write clears
>      autoneg-enable before autoneg can start, so this is a no-op on
>      real silicon); both are required by QEMU's emulation.  Drop the
>      dead igb_read_phy() and its now-unused macros.
>
>   2) selftests/vfio: igb: Use advanced TX and RX descriptors
>
>      Program SRRCTL.DESCTYPE for advanced one-buffer receive
>      descriptors (datasheet 7.1.5.2, 8.10.2) and build advanced TX data
>      descriptors with DEXT/DTYP/IFCS/EOP/PAYLEN (7.2.2.3) rather than
>      the simplified legacy format the submitted driver used.  Drop the
>      unused legacy TX descriptor macros.
>
>   3) selftests/vfio: igb: Program MSI-X interrupt routing
>
>      Configure GPIE.Multiple_MSIX and GPIE.EIAME (Table 7-47), EIAC
>      and EIAM for vector 0 (8.8.5, 8.8.6), and switch EICR clearing
>      from read-to-clear to write-to-clear (7.3.4.2 / 8.8.5 forbid
>      reading EICR while EIAC is programmed).
>
>   4) selftests/vfio: igb: Extend memcpy completion timeout for line-rate
>      hardware
>
>      The submitted 1 ms cap is well below the 32 ms line-rate floor for
>      a 4 MB transfer at 1 Gb/s.  Bump to ~200 ms (6x margin).
>
>   5) selftests/vfio: igb: Disable PCIe completion timeout retries
>
>      Clear GCR.Completion_Timeout_Resend (datasheet 8.6.1) so the
>      intentional unmapped-IOVA tests do not generate an unbounded
>      stream of retried reads on real hardware.
>
>   6) selftests/vfio: Add vfio_pci_irq_reenable() helper
>
>      New libvfio helper that re-issues VFIO_DEVICE_SET_IRQS against
>      existing eventfds, for drivers that recover from
>      VFIO_DEVICE_RESET without disturbing user-side eventfds (and any
>      fd a test fixture may have cached).
>
>   7) selftests/vfio: igb: Factor hardware programming into igb_hw_init()
>
>      Pure refactor splitting igb_init() into a one-shot outer
>      (region-size check, BAR map, CTRL.RST, IMC, vfio_pci_msix_enable)
>      and a reusable inner that programs the registers CTRL.RST clears.
>
>   8) selftests/vfio: igb: Recover after DMA-read faults
>
>      Add igb_error_reset_and_reinit() and call it from
>      igb_memcpy_wait() on completion timeout.  Datasheet 4.2.1.6.1
>      describes CTRL.RST as the recovery mechanism, but empirically
>      CTRL.RST alone leaves the descriptor engine wedged after a
>      DMA-read fault; the 82576 advertises PCIe FLR (datasheet
>      4.2.1.5.1) and VFIO_DEVICE_RESET drives it.
>
> Testing:
>
>   - Selftest builds clean at every commit (verified bisect-buildable).
>   - QEMU emulated igb via vng on a host kernel built with VFIO and
>     Intel IOMMU enabled: vfio_pci_driver_test 35/35 pass across all
>     four IOMMU mode permutations.
>   - Physical 82576 on Intel Alderlake platform: vfio_pci_driver_test
>     35/35 pass across all four IOMMU mode permutations.
>
> Assisted:
>
>   - Series developed primarily with Claude Opus 4.7 with additional
>     assistance from GPT 5.5.  Spec references spot checked and cross
>     checked against multiple models.
>
> Alex Williamson (8):
>   selftests/vfio: igb: Use PHY internal loopback on 82576
>   selftests/vfio: igb: Use advanced TX and RX descriptors
>   selftests/vfio: igb: Program MSI-X interrupt routing
>   selftests/vfio: igb: Extend memcpy completion timeout for line-rate har=
dware
>   selftests/vfio: igb: Disable PCIe completion timeout retries
>   selftests/vfio: Add vfio_pci_irq_reenable() helper
>   selftests/vfio: igb: Factor hardware programming into igb_hw_init()
>   selftests/vfio: igb: Recover after DMA-read faults
>
>  .../selftests/vfio/lib/drivers/igb/igb.c      | 318 +++++++++++++-----
>  .../vfio/lib/drivers/igb/registers.h          |  58 +++-
>  .../lib/include/libvfio/vfio_pci_device.h     |   2 +
>  .../selftests/vfio/lib/vfio_pci_device.c      |  22 ++
>  4 files changed, 302 insertions(+), 98 deletions(-)
>
> --
> 2.51.0
