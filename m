Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D503546DC
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971974; cv=pass; b=GE7DeSmaCwGEyZFQ0tneBh8hNaEb42UPyng8nUd3D1BN31wMtVGDGrR+aLLbhxbkleNQiJ2TusrB+EJYYKZUbzHUmNc5g2jgPKwdMTQrcqQZxQHt7Vs6s0HVvl6mHOXRfOBIzTJz72/zNtjwPH8Il1EXNzeK3efxXFKCYfIebKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971974; c=relaxed/simple;
	bh=B0cMKe8c+q6VZAtfPJvsEQR9bKElmEm2xbnsBmbyRrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N34EUlYbFJf8FKHHo93m+vsAiUJUkugl7sLuql/GA64L3Z4ZW7PZEP+QpZTaHw3uQHkwNr2yXKsOHJnj1atconfAvPmaEGuimYhIVd6ccYzMuIEIYO3wmbQHej+lFPPFW3DzLmmCnmTCrwuIbHsnWuSasO0r2GJpMdXsmUY0SXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TG/Fqafo; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TG/Fqafo"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso2674e87.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 12:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783971970; cv=none;
        d=google.com; s=arc-20260327;
        b=hKrGSwPE86DCfd0DmrGZnLF8FBbrVgEwphtJBAFJBwivO+Ad0Ot0i4f1Jz/o7XQucq
         0qVlmADmHE5JKac2hEgPwIu2XyxRoleGGhpYa3N3ieZuarRe7TuINTDAj8+c9wJ/26fX
         swHU/sBE1tNIv+/uNVVDeh4Hq4IwF9PgELNjqOT7ReFuwAD5iUnMiGPgc1sJq+zl8pSL
         j4dD6ot4sXMyjIUk13XiIzPb9RdyRHB0f+gaX3b2A6JOCq7WdRVDUJns9VQ9JHXOkSLm
         hRpuXC1L0KV20HwAnTk9/LuxQVhDw9Fw+Bqhtl/ANZyABobOxYjw+R6SNgqy8E0kmV28
         AKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSqOOQONB6JQasgqDGGvjiOYMHIueBNAeX2B65ZUhc0=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=H/MtM3cxf8s2blBSPhmp85GAqZhv1CPPWAyd7MNLwKDECjyQlAKuwiJ2l4XwaiovU1
         uN2iwVh47L8gvpUfKOiZhuar/03A5cbXLpQYbrXmIv43z5TK/AQ+wHHqaHKGLljPBknc
         FNBMQBDmOZTaFdB9NSzSpGKUS86zvbUO0a4sA+axElQqnusMP6YTuGul49kphJxYO+QJ
         SuzlUblPq1L/gJa9R96j6LpK0f8XKezEOAhWLq3Sg2daU2+nF/11eqC1Wf+oo/UqZ01n
         4uSOtuOVC4aYVoObOYm93wrRYQft9h38/uhxMgVvnqH5ZfE3wNTerihCQWAnKo7k9A8F
         e0Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783971970; x=1784576770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cSqOOQONB6JQasgqDGGvjiOYMHIueBNAeX2B65ZUhc0=;
        b=TG/FqafoHs8smPmqUkYdFjdV1eiY0p5jM64Nap6ENDWvXzD4j0qJOyw+GlBt/H9MiV
         UrdAD4DgjiNTg594DpniBYuyxQSvYQTQ+7fDrtR/ye1iNWKh2Vtc0BoFTNH//ig4Jpi4
         +Hj/FLsxi0y84JOcYlRctXhzwbilw9EDcXpnikM/sJelco6++Ppm/hQ0cNFrvb0Wrgh1
         QtsIb1djisamzyk4nydeYCF973ZG8992xtV6n7ZtXaiuNYsR15DKws2CLLL/ZklF8g91
         /8j7+qHlt005gA2VPF2a4vx7T+hNtlmcDmpnQV2teldFwC9BhmRGA7pdD//2QsjtSe71
         TS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971970; x=1784576770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSqOOQONB6JQasgqDGGvjiOYMHIueBNAeX2B65ZUhc0=;
        b=IZqJiLGoj0ZO5rJIsR57okdXactuIfty8H0nrSdw/rA3yeeElNtWVLXk736P+GxDeE
         3oUJ1ac4z+6L8RV36kzsMZQPmFSmMYxHgiYwML0HkC4dA61GGF5u0tAuKOJu0JLbCvVo
         1m28EqL4Edoi4hW6DtjtN92Gsrgb6gbPJ17gYk6KGw7AsTCPtZWiOIy+vTHN5Ipu87tC
         EUaxf80RxqzaaTIANWEvFlPNABebMCcS2DMP3o5KV0/C7LEDHdTmQedkreyltfiuEt55
         aUFLJYtSwGSWoVbS+Bek7sozCGB+6YpqP1IOuuycj00IPEXDu1JcgVDNpVKkggWCuDyB
         M3Wg==
X-Gm-Message-State: AOJu0Yy9TxLfGr+ZNQu01JBIDrWAjU6l0cO+0wslOTtWqU2RhJSNddES
	8x0BJwiSTSWWczekozspSPB9CVpVr9nUQ9P6vJr0phFVEFhEY0NbC89Y6C239YiL210RIrT/T0+
	f9Oy0R/DwnsVhKdlQMUxVDjMrgGBWptoH9ix6ZClLzyL4FgCqkQNxZv0zrQ==
X-Gm-Gg: AfdE7cl9ecjv6aNCEuhgUSXB/LgNqsSKdHnglMO0Sr17yiqHe0+bhuSPPZriydaMK5D
	gE/youid7+E9m9tyse6DZ69ptWsijVlzOGwVmhnnp7C28mB3s+xJHh83SwwBETUbuvMlG8JYtNz
	Mp3ew0zesQIzpRqLQY65ZxQsCf7UcTmWWb8bQ5ZQS5oJRWpL4HE4/YFGD/cveQDEo24KgdCQZ20
	SMyYJ0Q4OYHKKZEwzGXuauHam+EIoYmCxZ+jgydypBdImkga7vTt0XXlgtPAhcMk6l8
X-Received: by 2002:a05:6512:3e1e:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b155441efdmr111663e87.9.1783971969847; Mon, 13 Jul 2026
 12:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
 <20260710-igb_v3_b4-v4-1-56e7e2576cc1@google.com> <20260710221939.CFE741F000E9@smtp.kernel.org>
In-Reply-To: <20260710221939.CFE741F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 13 Jul 2026 12:45:58 -0700
X-Gm-Features: AVVi8CdJPqxj80VD1ep3bK07Co9Yt3d-AkRQfpD6HSOhcuJ7mAKiZoDAYwzJdnY
Message-ID: <CAAdrzjt7ib1ek83vF0pgppuxLE8GK623ZFDQu3aOSU=mGAm1-g@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vfio: selftests: igb: Add driver for IGB QEMU device
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 6 potential issu=
e(s) to consider:
> - [Medium] Reading EICR does not clear the interrupt cause in MSI-X mode,=
 leading to spurious interrupts.
> - [Medium] Failure to disable DMA completion timeout resend causes infini=
te retries on intentional unmapped IOVA accesses.
> - [Medium] Missing Multicast and Broadcast Promiscuous Modes will cause M=
AC loopback to drop arbitrary test packets.
> - [Medium] Unbounded hardware polling loop for device reset completion.
> - [Medium] Disabling MSI-X before quiescing the device in `igb_remove` cr=
eates a race condition causing PCIe faults.
> - [Low] Driver ignores timeouts when polling for TX/RX queue enable.
> --
>
> --- Patch [1]: [PATCH v4 1/9] vfio: selftests: igb: Add driver for IGB QE=
MU device ---
> commit 163a68c618c35adde837d2be447ecb7a92e5fdf0
> Author: Josh Hilke <jrhilke@google.com>
>
> vfio: selftests: igb: Add driver for IGB QEMU device
>
> Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> (IGB) to test VFIO features under QEMU. Uses IGB's loopback mode to
> implement the required memcpy operations.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 0000000000000..923b2341abadd
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
>
> [ ... ]
>
> > +static void igb_init(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +     u64 iova_tx, iova_rx;
> > +     u32 ctrl, rctl;
> > +     u16 cmd_reg;
> > +     int retries;
> > +
> > +     VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
> > +
> > +     /* Set up rings and calculate IOVAs */
> > +     igb->bar0 =3D device->bars[0].vaddr;
> > +
> > +     iova_tx =3D to_iova(device, igb->tx_ring);
> > +     iova_rx =3D to_iova(device, igb->rx_ring);
> > +
> > +     igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_=
CTRL_RST);
> > +     /*
> > +      * Must wait at least 1 millisecond after setting the reset bit b=
efore
> > +      * checking if this device is ready to be used (82576 datasheet s=
ection
> > +      * 4.2.1.6.1).
> > +      */
> > +     usleep(1000);
> > +     while (igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST)
> > +             usleep(10);
>
> [Severity: Medium]
> If the hardware or emulator enters a faulty state and fails to complete t=
he
> reset, will this unbounded loop hang the test process indefinitely? Shoul=
d
> this have a timeout?

Sure, I can replace the while loop with a VFIO_ASSERT in v5.

> > +     igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
> > +
> > +     /* Signal that the driver is loaded */
> > +     ctrl =3D igb_read32(igb, E1000_CTRL_EXT);
> > +     ctrl |=3D E1000_CTRL_EXT_DRV_LOAD;
> > +     ctrl &=3D ~E1000_CTRL_EXT_LINK_MODE_MASK;
> > +     igb_write32(igb, E1000_CTRL_EXT, ctrl);
> > +
> > +     /* Enable PCI Bus Master. */
> > +     cmd_reg =3D vfio_pci_config_readw(device, PCI_COMMAND);
> > +     if ((cmd_reg & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) !=3D
> > +         (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) {
> > +             cmd_reg |=3D (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> > +             vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> > +     }
>
> [Severity: Medium]
> Since the VFIO selftest framework contains negative tests that intentiona=
lly
> submit DMA descriptors targeting unmapped IOVAs, shouldn't we disable the
> PCIe completion timeout resend behavior in the GCR register?
>
> Without disabling the E1000_GCR_CMPL_TMOUT_RESEND bit, could the 82576
> controller continuously retry failed PCIe reads indefinitely, flooding th=
e
> host with PCIe AER errors and IOMMU faults?

Fixed in patch 6 of this series.

> [ ... ]
>
> > +     /* Wait for TX and RX queues to be enabled */
> > +     retries =3D 2000;
> > +     while (retries-- > 0) {
> > +             if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEU=
E_ENABLE) &&
> > +                 (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEU=
E_ENABLE))
> > +                     break;
> > +             usleep(10);
> > +     }
>
> [Severity: Low]
> Does this code silently proceed if the retries hit zero?
>
> If the hardware queues fail to enable within the allotted time, it seems =
we
> might continue with disabled queues, leading to confusing downstream
> failures. Should there be an assertion or error handling here?

I'll add an assertion here in v5.

> > +
> > +     /* Enable Receiver and Transmitter */
> > +     rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> > +            E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MA=
C) */
> > +            E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> > +            E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> > +     igb_write32(igb, E1000_RCTL, rctl);
>
> [Severity: Medium]
> Since the driver uses the memcpy test framework which sends arbitrary mem=
ory
> data as Ethernet frames, shouldn't Multicast Promiscuous (E1000_RCTL_MPE)
> and Broadcast Accept Mode (E1000_RCTL_BAM) be enabled here?
>
> Without these flags, any test data where the first byte's least significa=
nt
> bit is 1 will be treated as a multicast/broadcast frame and dropped by th=
e
> hardware's MAC filter, causing a timeout.

I'll fix this in v5. I verified that the tests fail if I modify the
test to memcpy all 1's.

> [ ... ]
>
> > +static void igb_remove(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +
> > +     vfio_pci_msix_disable(device);
> > +     igb_write32(igb, E1000_RCTL, 0);
> > +     igb_write32(igb, E1000_TCTL, 0);
> > +     igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_=
CTRL_RST);
> > +}
>
> [Severity: Medium]
> Does disabling MSI-X before quiescing the device create a race condition?
>
> If the device attempts to DMA an MSI-X interrupt during this window (e.g.=
,
> from a delayed loopback packet), it will perform an unmapped memory write
> on the PCIe bus, which might trigger an AER or IOMMU fault.
>
> Could we disable the receiver and transmitter before calling
> vfio_pci_msix_disable()?

I'll adjust the ordering in v5.

> [ ... ]
>
> > +static void igb_irq_clear(struct igb *igb)
> > +{
> > +     igb_read32(igb, E1000_EICR);
> > +}
>
> [Severity: Medium]
> Will reading the EICR register clear the interrupt cause in MSI-X mode on
> the 82576 controller without the EIAC (Extended Interrupt Auto Clear)
> register being properly configured?
>
> It appears the hardware might leave the interrupt cause active, which cou=
ld
> trigger immediate spurious interrupts once re-enabled. Should EIAC be
> programmed during initialization?

Fixed in patch 4 ("vfio: selftests: igb: Program MSI-X interrupt routing").

> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-igb_v3_b=
4-v4-0-56e7e2576cc1@google.com?part=3D1
