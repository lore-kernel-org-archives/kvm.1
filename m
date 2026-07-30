Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95136A34F
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449562; cv=pass; b=IvFL2Ujm6fuJiO2oVMuWKyUvcoy4CcwUwbHDB1WjqZ81+wZrFwaXqlqd5VE0fzXnRvSX5ol/WP1Wf+9B6BuScxNgtUOdZbtMStbl/EZWgLqQmBTyWjp2KbgCE9NNeaP1lCbDablhWkU5BDRa6MyYquJda3tB9W919n0tg71UAvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449562; c=relaxed/simple;
	bh=wjlGwHmokdNiyJnYF+/+JleV0THfo9QsGxp+bI0tazQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q15CFi4eJNjeMP9T8NGHLxDKHrG9YFrQ1ruPmrWgIvODZsHrPMA4yqJLNragh//T4Am/DACaKO2yKeaPJzA8ZMSMsl4H7a4ck0t/Bg96O+ctUkKvcRSMu6e2JowESeocNS4RgEwm/IiOQROlV/0O5DNS0+39H8FhXUT49A4St/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5AtIsQK; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5AtIsQK"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b2a8173142so1294e87.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785449558; cv=none;
        d=google.com; s=arc-20260327;
        b=SmiXpjMJBvXzjR/PeQJLeq0kJJTA81TCtxrQOfIWwdQTVLX0TJ8bR8Q7xLe4hzl30O
         bSzakHrsUf+rnXZ8BmYh5ZBjVbBSQ0xETRz3ynDRycfBRA/9+wj+s4XH23vnt69rcdxC
         zbxy22tZa9HHu4eSIetttGq5woF8+6EdrChCkqmk5g/yeGXz+3c950f5kQoSRgWazv4i
         z+UcrcAELNmyyZulNSnV6bXmoOIaX0doQRyEVDObbQBeEw3aNMQQ5zxmohcn+FzONK2d
         2P1vAZh3JqLcvDyRcn5s+Jp+ieKh4X7h1pbxu+s0s5gYnnc6qQ+IUqTOJiMQKK8SKINW
         AQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+aYsrEoLB8meyk6x4RqHKI0F2zpIBkilrTUObaO4PaI=;
        fh=OeLK2WmB9X8YVNLXJR1Fo0INXvbE2/nAs+Dupe9P2v4=;
        b=jhdOLKyirqh8p/RFvStHZ/7/uqq0R/oqUsd7763EVJkTqcyO0sWIKMN2NaD7trY0uE
         eow27Le44RuoqhwIyF0XdiJHaUemUofSoqWFtmS8N0OqCqfHL+xG1pfAmaFkYP5bwsr5
         iMDUdj6OwCuER6MDg6duLww1UCHmI0bEJlxFSNqs1sBXRtfW4WzGakmAPSKhXdua08G8
         0u2uNn42UTwPgbDDG/Em9MopRxayq7K/QZ+tPxsukbENXlI+WPSk1R3Lcv+Jo3t5fEXr
         6btwEQBsY2gQ1LQbxIp387b787SSZkSA2hg5yFs/uBxsbEV7P5vqVB89Ld1HGigtbL/9
         XNCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785449558; x=1786054358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+aYsrEoLB8meyk6x4RqHKI0F2zpIBkilrTUObaO4PaI=;
        b=B5AtIsQK1sdfEjxv8rPUeub/sXlyBmf1Hu0+gZinm6YNbCxOLYkKhLTdRr/uEP0TP7
         g6hKX9qLOuaYSLsj2M55b//WNP+wHpGbTIw1J+Qmta7MPxKUDuZ0bIZqrm/U4BaKpnDP
         ZwMFHh2q3yl4zE6q0jC3ib0b6x78RSjJ5qfP8M/3z0vLI6jF2QOADN4g3jCTVIiMLx4v
         1gSpN5sca7IBduNq9qVfCnVfMQTexiSKVEPPc021AGdi1NkkQ00eEuIwfWo9nhywTAPm
         QH3aYDvakkIZd2C9qK1asQUw1LcglEB+NUCqjrDJz251gm19cZ2oHJF4Y+1mVFezVPUN
         xHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449558; x=1786054358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aYsrEoLB8meyk6x4RqHKI0F2zpIBkilrTUObaO4PaI=;
        b=eCD+lvj5H/zfjk7UvH2dmqojbe7NXNvtUQAEw6i1nDx4lLVDmRQC+VtGP3XaS9xz9A
         alzaSytnNIZ1P112rkHT1INGIkWaizftJaEjhoJgPkDzA1PSMZ9Qb96ZSPurqLDShCe3
         Wo9lutP2FPtRsuolMNwZuMHrDVsIFAMlG8mEUo2U0Om6xLH2FB/QgyztusmvRwZPAwbA
         nInGFB5v9znr17QiFT+ZRqLpun7CpCSQIGm3I3g88AbF2MWThmVIFF5bZeTX2H9uX/fY
         Jfxv3mf/fmQXCXwoT++XG2OfF14zeJLDqYd9dIi/AUhObe//wYw8bIaBmaPS7Hd3pT/1
         f0Jg==
X-Gm-Message-State: AOJu0YxMX1xSDaOB9bKjeLB91QRSQSXGY3tCwnhAqOKTrcezefihg8zn
	TzTohG2qGfxmv4KtiGkKpZChm/9ah1Qr/rPvm3F4oCJXP7crE8S4NRe6KxeqqU8pNl+XKZL39BE
	nUggus12DBw9ruGRLl81CKkx70pi4mF1TR94DlH0=
X-Gm-Gg: AR+sD13g+JbU8A6cWCa0nNlcofRaP4H1hvGSPd3UnO3YgyKXK57/ZfDwBur0abpZJDx
	n7BQGpw9pxZWns4U8BvXOL36szl4awe8kUdLu2O/p7125VRxDa7ZFptji4wDcYnhoqRS/4JX7dD
	YYdUYj0OkNhlS0FwL+nFJPOdWx+xGxnIQc/OAWfvzJ/zgzr1efDOmn72VIyRVDu04MEhomgHZqh
	GIssjcNpP2cMs7YMSQ266P5Vyq5wDrY00cM6C3Tnnzfel58AYxYEaR7iUU4frbMkTSpGjj2q1vw
	MiyPOyQntMoRhySAL57dhDXT+gb/cBeisX74o0/W4OAAMyNIZ9uzwlsqODcCHTFxu7hcy2aVDNi
	qBcumsWLOsw==
X-Received: by 2002:a05:6512:2315:b0:5b1:ca0b:25d2 with SMTP id
 2adb3069b0e04-5b2e04e37cemr77732e87.4.1785449558007; Thu, 30 Jul 2026
 15:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
 <20260729-igb_v3_b4-v8-1-3ed236272b4e@google.com> <20260729224554.0C22C1F000E9@smtp.kernel.org>
In-Reply-To: <20260729224554.0C22C1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Thu, 30 Jul 2026 15:12:26 -0700
X-Gm-Features: AUfX_mwFk5P9vejJ7nQfROr8g87JhPiOdle1tOwll7WR3p1mhB29QQopY5aO9MY
Message-ID: <CAAdrzjszCRNf3kkBgSLow-RrsG9whxFMS4SN1ATzGc7wKJjmoA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] vfio: selftests: igb: Add driver for Intel 82576 device
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex.williamson@nvidia.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:45=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] Hardware Testing Failure / Invalid Loopback Configuration
> - [Medium] Hardware Configuration / Frame Padding failure for short packe=
ts
> - [Low] Misleading comment about interrupt delivery during memcpy
> --
>
> --- Patch [1]: [PATCH v8 1/6] vfio: selftests: igb: Add driver for Intel =
82576 device ---
> commit e83f78e00ae490d2604290c3e38f2458c48dd9d4
> Author: Josh Hilke <jrhilke@google.com>
>
> vfio: selftests: igb: Add driver for Intel 82576 device
>
> This commit adds a VFIO selftest driver for the Intel 82576 Gigabit Ether=
net
> controller. It uses advanced descriptors and programs MSI-X routing to te=
st
> DMA loopback via QEMU's igb emulation and physical hardware.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 0000000000000..6fc6e7c0e7235
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
> [Severity: Medium]
> Will this auto-negotiation time out and fail the test via VFIO_ASSERT_TRU=
E
> when running on physical 82576 hardware without an active external link
> partner?

This is addressed in patch 2, but I'm going to squash patch 2 into
this patch to avoid introducing bugs.

> > +     VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
> > +
> > +     for (i =3D 0; i < timeout_ms; i++) {
> > +             if (igb_read_phy(igb, MII_BMSR, &phy_status) =3D=3D 0) {
> > +                     success =3D !!(phy_status & BMSR_ANEGCOMPLETE);
> > +                     if (success)
> > +                             break;
> > +             }
> > +             usleep(1000);
> > +     }
> > +
> > +     VFIO_ASSERT_TRUE(success, "Auto-negotiation did not complete in t=
ime");
> > +}
>
> [ ... ]
>
> > +static void igb_init(struct vfio_pci_device *device)
> > +{
>
> [ ... ]
>
> > +     /* Enable Receiver and Transmitter */
> > +     rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> > +            E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MA=
C) */
> > +            E1000_RCTL_MPE |      /* Multicast Promiscuous */
> > +            E1000_RCTL_BAM |      /* Broadcast Accept Mode */
> > +            E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
>
> [Severity: Medium]
> Does real 82576 hardware support MAC loopback? It appears this might caus=
e DMA
> loopback to fail on physical hardware even if auto-negotiation completes.

Addressed in patch 2.

> > +            E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> > +     igb_write32(igb, E1000_RCTL, rctl);
> > +     igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
>
> [Severity: Medium]
> Is the Pad Short Packets bit (E1000_TCTL_PSP) missing from the TCTL
> configuration here?
>
> If vfio_pci_driver_memcpy() is called with a size smaller than 60 bytes,
> would the hardware send a runt frame that the receiver drops (because Sto=
re
> Bad Packets is disabled), causing igb_memcpy_wait() to time out with
> -ETIMEDOUT?

Yes, this is a bug. Verified this by modifying the memcpy size in
vfio_pci_driver_test. I'll fix this in v9.

> > +
> > +     /* Enable MSI-X with 1 vector for the test */
> > +     vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> > +
> > +     /*
> > +      * Program MSI-X interrupt routing per 82576 datasheet:
> > +      *
> > +      * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4)=
 to
> > +      * route interrupt causes through IVAR mapping, and EIAME (bit 30=
)
> > +      * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> > +      * applies on EICR read/write).
> > +      *
> > +      * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> > +      * Without auto-clear the cause stays set after delivery and the
> > +      * test can see spurious interrupts on the next memcpy batch.
> > +      *
> > +      * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> > +      * MSI-X assertion (effective because EIAME is set), so a single
> > +      * interrupt is delivered per memcpy batch even if the cause
> > +      * re-asserts before software re-enables the mask.
>
> [Severity: Low]
> This isn't a bug, but is this comment accurate about delivering a single
> interrupt per memcpy batch?
>
> Looking at igb_memcpy_start(), it explicitly disables interrupts before t=
he
> batch:
>
>     igb_irq_disable(igb);
>
> and igb_memcpy_wait() polls the descriptor writeback before clearing the
> cause and re-enabling interrupts:
>
>     igb_irq_clear(igb);
>     igb_irq_enable(igb);
>
> It appears interrupts are prevented entirely during the polling loop.

I'll update the comment in v9.

> > +      *
> > +      * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> > +      * cause 0 to MSI-X vector 0 and mark the entry valid.
> > +      */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-igb_v3_b=
4-v8-0-3ed236272b4e@google.com?part=3D1
