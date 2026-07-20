Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598B418A48
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581924; cv=pass; b=KLf7MkwEWUGMl4k2rj1RjfPFn0Qa+aOQcAu6FFg6e1OTXO5xjoFEEVqJAo1fA1stp8P1kyqyqqL3+JfhQmwQefkciCdgzxKWIjpOxzzWXd2lDrXOavsg5hb06aSRIvPG1N0BS9ybCw+P9vsJmcYvSZ2fOGbU8DogZE09Q/kt5qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581924; c=relaxed/simple;
	bh=lRocIA7DUpH9mZLq9zVZ9/zMYmsv5z7zJPYY+w3Jc7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSqNfl930vzSES+Ey3ZWRkvnOPii7t817uVABktzWUi1TkZvKGhXOFI5RliRcNNwH0Y5TOhJMVGi62QUUP7ZIKvcacXOoCC4me8Qb3caG8FZG+TJESMC4sB9q/un0q8c7y6kR0FrUqx17CGjU9HdUOSpH7fGFbq5M2/L5lX3024=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AfibysRR; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfibysRR"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aeb6bdeaeaso33690e87.0
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 14:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784581915; cv=none;
        d=google.com; s=arc-20260327;
        b=XCwx0hKgtU9fTVgjQe2Te6aOLlIFZutuuN41evE0jVDBO8C+vWHn2NWccZgmchdHnC
         f9jbbgxC8nRogUqxO293DS2ex7jMmMLbtGN73IPTA5SyiUoIqaD0nsSfQ1Dgdo2Fl8eJ
         iK2NOhNmoSHAo2xFfzIrcUDqG+6Y3I6h2YmjsXU5OiahYzpChdHM3h9xnUzIMXLJzXwT
         HnuVz8NK4L5uYFcZhB4FVEOxAMZXuYACLVk7K34tv9wYU3RDM1OE3CBahIa6CIcINAVR
         O+ga6o25aDZar3vs7gCLQ9uyj2gUznVtiGYVqF9wqlAR5lATIv+jenS3YZJk85zLkzNj
         QDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2NT7/9aVJQ0lE1aVT0nFHov8n+tz4I5xjcivzPKn3zU=;
        fh=d01QbNwzqaSih/pzyx2m5I3zgPwaQbtOCqNOl9ej+AA=;
        b=VSpJ9vEd6l6lKPy998wE/MaouZ1rUdXMyJIqJkjZIXHGv4zVMrB8GFNuVc/Or2gf/s
         zWQy7guFXdVnL7WPKLb/seDuHQGAI+DtYt0jrknAnQe/8wHMuta7fCOzstVaCXov3qJU
         qJB7EE74lEHL6meqjUD98zAE7eRAKxrgQqO2X7eY9gmgqYcwo0GbA1JJDnNirscgo0hR
         W/I/kRagah5iuuT1fN6GC4SALyiYlbdP4CUelaGZEs822pfcOcagzHg/oNkPLf7gzIAB
         VFtmNSlBLW8kIvOCMuWiZ6xkdNxeFSPVQK/5ItpYh6AAhTNvUVfLSRhzpfCB5KfoC74+
         T5Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784581915; x=1785186715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2NT7/9aVJQ0lE1aVT0nFHov8n+tz4I5xjcivzPKn3zU=;
        b=AfibysRRaXnkdKLqgS+8deLHLoLlpUEzjiO09TCX8cfG8SyW3K7PYhCfmE7VyVyiUM
         J2jX6blRKB/7PLNZvemyhUh4fAGQOdZ9YDr7g2Tf58hw9K0goXgQCF6AFAQLcIviuEwW
         I53gecvUcNGIVEZ5EExjdxgs0mS0sBtbJ7X641VaeOvh9IlWJPIGYsem6cFd6hgfBr9a
         glK9wq1il9fUiC3I5NBRRvUfHn9y+JREX+pKpPy9sdlxtPA4283WdmqajX6XLrs+DdI9
         /EmdB9u+MbMj7QfwOMyE2/71aC3OEGnhmoGyuW80r7GjfoG66HCIs6Utp7lkhjaUQ3hQ
         d4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581915; x=1785186715;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2NT7/9aVJQ0lE1aVT0nFHov8n+tz4I5xjcivzPKn3zU=;
        b=CvQIw5cMjsYtbdaAnCqiZGbxcvuvSmrSnhJjVlF6Fkj2zYVkVSBT0meBAyVDCJPbAV
         h4AzrmtNEwZ7vWKgFbRQVHENEb6twaKd5CjEpwT7Mb+fSxOipnKsS0AdC3Kh3TNepKoI
         MDd2Fn08ILPBIjwZVeeClzO9oujfJcZ43zsBjdm5KV8hlQUDAXG/Ae4nihtncRUVs6O3
         +y2N/4w5wb6WnqrPyj8y6yBgrJrCrvY8dB4TlpmTEpMX/fJ9GjPAGG5j1gfLwhj/fyl0
         Y3R6u/K5FN4beAYNbOsaY2z5jIAmT5QKIBVm+7pbgweuUiG0Dsg7xc+NxOlPEVuWAIcV
         b4Ug==
X-Gm-Message-State: AOJu0Yzq13dBFEcXp3mHJGX/Jn74gYNGvTfnMy879LzxtZZnQ9djGGUE
	1yLPbZ1MH8W2qC3gJoSBK2SDrdt0ThSKffkQnbckrQZU4bqrlPQw3BzuYcfCQe36RqXJeCfBvyK
	zwC/j0kc3Fte1VUkDvkdKwAqphJhAX2aFceeXgX0=
X-Gm-Gg: AfdE7clymGlcjRQUW0KiU0sYqcfpT6orh/1F4/mYOE8+cWDql8nC6g2YwdNdlc87fim
	yhve8AnUzQVRMqfSW2+qVAeuwcum1xJCSlW53VpFGivxTi6g5R/RKJOrL+F8sLhpuP7tNb5rM4V
	71ZEj8q4zUpM+xMdOzgeiLvGnVIthvE21Sn0X03ZhQ3LnPLNbMXnkw+k4KmQF8v4YKQ/OEblyc5
	w7O71+8rEdAwdL1NHiIWxbNaQsQjP49TkkYX8m709gRiceVW06J33DyuxsWP3IgCx6ikxpO+hG+
	hTM48ct4ONtP7jU=
X-Received: by 2002:a05:6512:ba1:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b2a31c4862mr133848e87.9.1784581914945; Mon, 20 Jul 2026
 14:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-1-91503eddb98b@google.com> <20260714212823.1EFEC1F000E9@smtp.kernel.org>
In-Reply-To: <20260714212823.1EFEC1F000E9@smtp.kernel.org>
From: Josh Hilke <jrhilke@google.com>
Date: Mon, 20 Jul 2026 14:11:42 -0700
X-Gm-Features: AUfX_myTZrVSaNYBmc6S1rniLUZmu_eudhCqnMA0Lt3-y_G8hz_4bY0LPvLAMdY
Message-ID: <CAAdrzjvT7536ZQA5y+g1D5WNNVYqu0ioc6y+rHwhB25zqkynYQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] vfio: selftests: igb: Add driver for Intel 82576 device
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 2:28=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] The selftest relies on external PHY auto-negotiation, which wi=
ll cause the test to fail on real hardware if no physical link (cable) is c=
onnected.
> - [Medium] MMIO registers are accessed before PCI memory space is enabled=
, which can crash the test if memory space is disabled.
> --
>
> --- Patch [1]: [PATCH v5 1/5] vfio: selftests: igb: Add driver for Intel =
82576 device ---
> commit b66293558b628d9af7dfd3c68ff9a1e69b1cbb0b
> Author: Josh Hilke <jrhilke@google.com>
>
> vfio: selftests: igb: Add driver for Intel 82576 device
>
> Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> (IGB), specifically targeting the 82576 device. IGB is fully
> virtualized in QEMU which makes it easy to run VFIO selftests without
> needing any specific hardware.
>
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools=
/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 0000000000000..a59b953030925
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
>
> [Severity: Medium]
> Will this cause the selftest to fail on real hardware if no physical cabl=
e is
> connected?
>
> Since this relies on external PHY auto-negotiation, it looks like the
> BMSR_ANEGCOMPLETE bit will never set without a physical link partner,
> triggering this assertion failure.

This is addressed in patch 2, "vfio: selftests: igb: Use PHY internal
loopback on 82576" by replacing the external auto-negotiation check
with an internal PHY loopback configuration that does not depend on a
physical link partner.

> [ ... ]
>
> > +static void igb_reset(struct igb *igb)
> > +{
> > +     igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_=
CTRL_RST);
> > +     /*
> > +      * Must wait at least 1 millisecond after setting the reset bit b=
efore
> > +      * checking if this device is ready to be used (82576 datasheet s=
ection
> > +      * 4.2.1.6.1).
> > +      */
> > +     usleep(2000);
> > +     VFIO_ASSERT_EQ(igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST, 0);
>
> [Severity: Medium]
> Can this assertion fail due to igb_read32() returning 0xFFFFFFFF if PCI
> memory space is disabled?

If PCI memory space is disabled, the test can't run. So we'd want this
assertion to fail in that case.

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
> > +     igb_reset(igb);
>
> [Severity: Medium]
> Is it safe to perform MMIO accesses in igb_reset() before the PCI memory
> space is enabled below?
>
> If the device was recently reset or the system does not pre-enable memory
> space, these early MMIO accesses might fail.

We don't see this failure when running the tests, because the test
fixture opens the VFIO device file which triggers a call to
vfio_pci_core_enable() which eventually calls pci_enable_resources()
which sets PCI_COMMAND_MEMORY. And this driver is only intended to run
on a VFIO-bound device.

>
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
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-igb_v3_b=
4-v5-0-91503eddb98b@google.com?part=3D1
