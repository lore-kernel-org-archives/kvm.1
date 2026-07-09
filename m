Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07203B2FFB
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625054; cv=pass; b=r2Kyanev613UE2hMDtVR7h34RpeqDPViZScDL5P1gDwV1hgBR1MlHWmabrih6Vw72AgtzftJdFy3I47HEwN9k38qVEjGlJjb3rUCB8fA4h/UqfIQA+Z3mKSWMRGSyjMWYLOn62Ebpumq5HPVbrNBVz9ZSnxabQLObso54VnCb94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625054; c=relaxed/simple;
	bh=a9Nyzp5h/11v0q9SYXSnb9FiDYrwRTPyoIvqHXqocGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3xfwT9O2h2pevmf78T8JQNCfk+REiukpIkY6DSlrsp9bes2RzoOY5Reh2kB3Owvra9iRMbNddRBd2J0+vZWRXAH2hKXZhAOz2JTL/s8XsWNp2gaF/c8+hZFPRKX7fh/si23WWxn0FeYkwcrJHdUti6d0PO4BK/+yT3xlO8OKL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V2X0R8+m; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V2X0R8+m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b0077d7053so1640e87.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 12:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783625050; cv=none;
        d=google.com; s=arc-20260327;
        b=kiyN/nd2dd7kY9Q3DnoSNDZNdZZr4W1Z5aRH9qQyM/k56NBb0wLcGC5aNMoLRZTRg8
         LgSf+a7NjIHMscXPNMUnCpPi8AiP0u5P+eKhE8U/feBmp/RWYHOQWsyk5ehkpuaMP4xa
         4ajSq0LO58RJjIJRiajtaAmaS++q2ijHA1q4PPnC1qdOdhRS5HtjG/NfteEY59qe5oQ7
         1TzJ7uDe/kNxcOOKjXaxHIgRHgMWO3Esel/8G9CLa6dwr8VLSC4LSkbGf6GXyjbaaIY9
         IECak4ChSSPjti/IPcWn90GskVQwVfTAMUWFPPixwZH2fFgkiX3QuaxbDzvzsbhztEwy
         Zhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I25j4NEeSKak63Qb+HSetEoQ8CJw2iYRk1TEpKrwxTw=;
        fh=fItrUtV5UsY1KSNx1ZNnzv3miYMbODbRRQWQ18AP5Zc=;
        b=WYEvnfmizHr4wi6hnmNGrxjh0TIeYg0R/KJf4FnwA/tNs2qnfWBnTQyl22NsyigAbP
         2+GESfXMXY4XpRo17PBgwHS410gboT4ZNPmn/saqBWm/yqcHKfuGxU74a2Cs1aptdLgI
         xpumewSsyPpSygjogdEf/D6bvrF3JSx4bDqkJzbRgnrXtWYTXX+wCwvz9nzHAlZR3xS5
         kAyvPVT2evVNe2Ruhvf3YNFlk1Irp2xMDrdrP5MDFlRLwY83dUUlbnZUUL+68+02pHnj
         TlxhUPM4Sb7XaA4ysQkmKTkEHI3IXe9MRUumeeg1wBFdvt0EjBBdPTkoec/1TPTlh1iZ
         X2+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783625050; x=1784229850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I25j4NEeSKak63Qb+HSetEoQ8CJw2iYRk1TEpKrwxTw=;
        b=V2X0R8+mE8tSt86bo1vNpLK6vQGiPZpznHrxPpL//t9QpLc17lZszAdqs2kyGUjt31
         xS61F9COAkh8tBymyuFh6pUTtM1UeZW+ydLRCBmeiEDMRqv5BVD0yK8AYWFgWs5V8R5Y
         H3XdPULZNtKVuLxJ4pv+wu33IwNteXV9ey5b4ao9KnqTUHSatMyNGJn5bo8DPTLNOK7j
         2oj/yd3Psl3cNzk1IOJQFgZfpv0aid1drWG4FhwrlRkd6WaeJvRfgV6984ZzAuC8pCAt
         qSq2ZJPbZ8Nc2WNxmZclR/lym5o57W8EXrTUg+84CSuG0qjfY8JYxNkppcy9uuw4c/Sh
         qLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625050; x=1784229850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I25j4NEeSKak63Qb+HSetEoQ8CJw2iYRk1TEpKrwxTw=;
        b=TwgDvGtZ6njbf97JmFw7JPFRKPW9ajW8jwHU5exWHqtdfZV7fWgJeuvU1cS7+HKh9l
         MlJDXgWFKTbA1nnRmPOCrvKsyagR+7yB203i/JZAhSmR5K4p6VMCZLFplee6jmnQCbsB
         YSZ8tqz01hjHRe3wdR/4iCh5A5ZCgUkMhdodoUOEwTSYz2UlUj98A6/q3pElBUOCUIKd
         uSRuFRjh+m/j59TXoin0rvgLwJfKEiu7JvBK3jODkqKJndd2kdcvAclYNgqAd064wxI1
         ronYOXa7XWWAOtbXGILLScmP4ET7218jV0SFRoxADrTLNVd2cG0fwXaJ5XtZLGvcvQV2
         HsQw==
X-Gm-Message-State: AOJu0Yz6ivV8qemsvcuryTHRHenCsn6WTLthUNmpaAf6HuYfbwgEVzfV
	l7noIQ2ZoopsMeaPveO7AhcmgVZhSa3ujDlDlT7ezUz0y+KVbDXKrOh+GQ5dyMhljgk3I+jSRjS
	ueGVb3n1ftpD71ZeSOyrdo1VGBq1nqmpJfaLyrh/Z3CgPqlu/VpWbpTyc0Q==
X-Gm-Gg: AfdE7cmWaj0Ig6zo+sNlp4R3tCVS7Py6EmfBZ2ydb7+koOS4cO7K4zgfQGyP3H37S/l
	XvWjbHKMAVNxSgYaFUxm7FLI+Zp56vu2H7orAzorLYLqMo5Lfjqii5lrnk6O+59oGOVIb6jfufS
	D3/F+3rblSNMFzwh9rbhPVaaDi7FUPh4dcjEmE+EfxAgaGe8cxPSAb3Oc+teX9qyzSXP1TgbCZK
	TTfW0aOQQHC0A+XxltGryaFW4XPaydaCF2CyJC/Cs7Z1TFg3buNnZbU1tRC3zgvLsoo
X-Received: by 2002:a05:6512:3b0c:b0:5ae:add8:f1ff with SMTP id
 2adb3069b0e04-5b01c83a829mr28215e87.5.1783625049189; Thu, 09 Jul 2026
 12:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-1-1272650ca614@google.com> <20260708233151.6EACE1F000E9@smtp.kernel.org>
In-Reply-To: <20260708233151.6EACE1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 9 Jul 2026 12:23:56 -0700
X-Gm-Features: AVVi8CdhEPpBm7l9s0IjnXHy9W0ADejT_RWImIR_E5Q-RZbVyB4otcxU7sZDAnk
Message-ID: <CAAdrzjsC607Ke_rpdeDq50n3BratY=vQnq0NLNt7=wSBPR_dvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] vfio: selftests: igb: Add driver for IGB QEMU device
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 4:31=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] Advanced Receive Descriptor Misconfiguration (SRRCTL)
> - [High] Unsupported MAC Loopback and Link State Deadlock
> - [High] Interrupt Delivery Failure due to Incomplete MSI-X Configuration
> - [High] Fault Recovery Failure due to PCIe Completion Timeout Resend
> - [High] Inadequate Wait Timeout for Large Memcpy Batches

It's worth noting most of these issues are specific to the physical
hardware. This first patch intends only to do the bare minimum to get
the driver tests to pass on QEMU IGB. Alex's patches add the necessary
support for the physical device. I think keeping those patches
separate makes it easy to see the differences between the QEMU device
and the physical device. I'll add comments for each issue below
stating which patch addresses it.

I'll also update the commit message to clarify that this patch does
not support the physical hardware.

>
> --- Patch [1]: [PATCH v3 1/9] vfio: selftests: igb: Add driver for IGB QE=
MU device ---
> commit a7e0dd62086e602fc2886d15801884902daf6cba
> Author: Josh Hilke <jrhilke@google.com>
>
> vfio: selftests: igb: Add driver for IGB QEMU device
>
> This patch adds a VFIO selftest driver for the Intel Gigabit Ethernet
> controller (IGB) to allow running VFIO selftests in QEMU without requirin=
g
> specific hardware. It utilizes the IGB loopback mode to implement the
> required memcpy operations.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 0000000000000..339ca88b9c555
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
>
> [ ... ]
>
> > +static void igb_phy_setup_autoneg(struct igb *igb)
> > +{
> > +     int timeout_ms =3D 1000;
> > +     bool success =3D false;
> > +     u16 phy_status;
> > +     int ret;
> > +     int i;
> > +
> > +     /* Trigger auto-negotiation */
> > +     ret =3D igb_write_phy(igb, MII_BMCR,
> > +                         BMCR_ANENABLE | BMCR_ANRESTART);
>
> [Severity: High]
> Does this configuration work on unplugged physical hardware?
>
> Writing to the PHY without enabling BMCR_LOOPBACK and relying on
> autonegotiation will block indefinitely and time out after 1 second if no
> network cable is connected.

Fixed in patch 2 which sets up loopback for physical hardware.

>
> > +     VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
> > +
> > +     for (i =3D 0; i < timeout_ms; i++) {
> > +             if (igb_read_phy(igb, MII_BMSR, &phy_status) =3D=3D 0) {
> > +                     success =3D !!(phy_status & BMSR_ANEGCOMPLETE);
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
>
> [Severity: High]
> Could an unmapped IOVA access permanently lock up the physical device her=
e?
>
> VFIO selftests intentionally submit descriptors targeting unmapped IOVAs =
to
> test IOMMU fault handling. By default, 82576 hardware sets the
> E1000_GCR_CMPL_TMOUT_RESEND bit, which instructs the DMA engine to
> indefinitely retry upon PCIe Completion Timeout or Unsupported Request fr=
om
> the IOMMU, flooding the system with PCIe AER errors.
>
> Should the initialization sequence clear this bit in the E1000_GCR regist=
er
> before starting DMA operations so the device can gracefully recover?

Fixed in patch 6, which clears the GCR retry bit, and patch 9 which
implements FLR recovery.

>
> > +     igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_=
CTRL_RST);
> > +     /*
> > +      * Must wait at least 1 millisecond after setting the reset bit b=
efore
> > +      * checking if this device is ready to be used (82576 datasheet s=
ection
> > +      * 4.2.1.6.1).
> > +      */
>
> [ ... ]
>
> > +     /* Configure TX and RX descriptor rings */
> > +     igb_write32(igb, E1000_TDBAL(0), (u32)iova_tx);
> > +     igb_write32(igb, E1000_TDBAH(0), (u32)(iova_tx >> 32));
> > +     igb_write32(igb, E1000_TDLEN(0), RING_SIZE * sizeof(struct igb_tx=
_desc));
> > +     igb_write32(igb, E1000_TDH(0), 0);
> > +     igb_write32(igb, E1000_TDT(0), 0);
> > +     igb_write32(igb, E1000_TXDCTL(0), E1000_TXDCTL_QUEUE_ENABLE);
> > +
> > +     igb_write32(igb, E1000_RDBAL(0), (u32)iova_rx);
>
> [Severity: High]
> Will the hardware use the correct descriptor format without configuring
> E1000_SRRCTL?
>
> The driver's struct igb_rx_desc expects the Advanced One-Buffer format, b=
ut
> without writing E1000_SRRCTL_DESCTYPE_ADV_ONEBUF to E1000_SRRCTL during
> igb_init(), the 82576 hardware defaults to the legacy format.
>
> This causes the hardware to write the status byte to offset 4 instead of
> offset 8, making igb_memcpy_wait() poll an unpopulated offset and causing
> the test to fail with an indefinite timeout on physical hardware.

Fixed in patch 3 which implements advanced TX and RX descriptors.

> > +     igb_write32(igb, E1000_RDBAH(0), (u32)(iova_rx >> 32));
> > +     igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx=
_desc));
> > +     igb_write32(igb, E1000_RDH(0), 0);
> > +     igb_write32(igb, E1000_RDT(0), 0);
> > +     igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
> > +
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
> > +
> > +     /* Enable Receiver and Transmitter */
> > +     rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> > +            E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MA=
C) */
> > +            E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> > +            E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> > +     igb_write32(igb, E1000_RCTL, rctl);
>
> [Severity: High]
> Is it expected that internal MAC loopback is not actually implemented on
> real 82576 hardware?
>
> The datasheet (Section 3.5.6.2) indicates E1000_RCTL_LBM_MAC has no physi=
cal
> effect on the 82576. Additionally, the MAC link is never forced up via
> E1000_CTRL_SLU here. This will stall the descriptor engine when running o=
n
> real hardware without a live network connection.

Fixed in patch 2 which uses PHY loopback instead of MAC.

>
> > +     igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
> > +
> > +     /* Enable MSI-X with 1 vector for the test */
> > +     vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> > +
> > +     /* Enable auto-masking of interrupts to avoid storms without a re=
al ISR */
> > +     igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
> > +
> > +     /* Enable interrupts on vector 0 */
> > +     igb_write32(igb, E1000_EIMS, 1);
> > +
> > +     /* Map vector 0 to interrupt cause 0 and mark it valid */
> > +     igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
>
> [Severity: High]
> Will the hardware successfully deliver MSI-X interrupts with this configu=
ration?
>
> The RX queue is mapped to MSI-X vector 0 using E1000_IVAR0, but the
> E1000_GPIE_MSIX_MODE bit isn't set in E1000_GPIE. This leaves the 82576
> operating in legacy interrupt mode, causing it to ignore IVAR routing.
>
> Also, while E1000_GPIE_EIAME (Auto-Mask Enable) is set, the E1000_EIAM
> and E1000_EIAC registers appear to be left unprogrammed.

E1000_GPIE_MSIX_MODE does indeed need to be set in order for the
driver tests to pass in QEMU (the mix_and_match test fails without
it).  Patch 4 fixes the MSI-X configuration for the physical hardware.

> > +
> > +     /* Initialize driver state and capability limits */
> > +     igb->tx_tail =3D 0;
>
> [ ... ]
>
> > +static int igb_memcpy_wait(struct vfio_pci_device *device)
> > +{
> > +     struct igb *igb =3D to_igb_state(device);
> > +     struct igb_rx_desc *rx;
> > +     u32 status =3D 0;
> > +     u32 prev_tail;
> > +     int retries;
> > +
> > +     prev_tail =3D (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> > +     rx =3D &igb->rx_ring[prev_tail];
> > +
> > +     retries =3D 100;
> > +     while (retries-- > 0) {
> > +             status =3D le32_to_cpu(READ_ONCE(rx->wb.status_error));
> > +             if (status & 1)
> > +                     break;
> > +             usleep(10);
> > +     }
>
> [Severity: High]
> Is a 1 millisecond total wait timeout sufficient for full-size batch copi=
es?
>
> This lockless polling loop executes 100 iterations of 10 microseconds eac=
h,
> yielding a strict 1ms timeout limit. However, the driver initializes
> max_memcpy_count to 4095 and max_memcpy_size to 1024 bytes. Transmitting
> ~4 MB of data across a 1 Gbps loopback interface physically requires at l=
east
> ~33.5 milliseconds, which will cause large memcpy batches to consistently
> time out before completion.

Fixed in patch 5 which extends the timeout for the physical hardware's
line rate.
