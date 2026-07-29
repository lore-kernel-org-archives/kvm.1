Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA51A9FA0
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365156; cv=none; b=pnlR8RR2QxVFI4+8dFokS4/WmOjSNEPsuGlkEakBXgvQVLrgts0bLMspWm2m+IyhLKBQaVW4s31cLz2uVsiEPq7MlvX59MZ0PfEPbEnOAmXBZ+LQX7gWLZ8mPBoA65Ma5d8ae3MIYMTZzpF6lKy1e91VN8seUcD/DCINMh+Jmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365156; c=relaxed/simple;
	bh=CgtZ10zeFTCspKJcr6e85mnfuhh9dlCUQyNBcQhi3FY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VYmlOsDHhazCkwmDY3Dl9sKG/1W3hA8FxsQDZnAEo82vOKo7NWKrr5G3OoRoPtFm8y+hCBei/K1T02S2y/aLdKBKnQbt7vKQHWcGWJ9Mpq5kX0PIx+AVLaycNjoINUE5Jni5K99YEV5CHc+urauxDEexLtrXHflJFUNwMMdN+is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+/sN1Dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+/sN1Dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C22C1F000E9;
	Wed, 29 Jul 2026 22:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785365154;
	bh=jMBcyEMHQ3NLmlhR/FgVPURGZyluiZuzHBL/6h1WrqQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+/sN1Dw/Y1jqxMAoAwaoIv+xCNTq4s1BMY5lQ1YLfogRv9Nasr6zk5qnBHI6nFuL
	 KCLEQpDb5oRs2/NtZKWPS8Tr9ypEDK1c89ZTjjT3A+qc3GRMmapHIqtl7pzL0F2L9q
	 Ayd4U8UAismQ49VYEH98bUi9xxCP7BJk3bLjf9B8/lmJqs57zYi6q657t9EWELWaq0
	 dVT8pCMzMPoI9nMCDx9Y0aJysc2hdWCRKsfIkNnEDdy2o4xKwscw1c9SIOPXyp+Uxd
	 0l5Ri1T1FNVJPCX0+7BZ5E7tsc+74B7a/g7/r66Bk1tqPTKZPX1nS+m5qUmjKntVX0
	 8CqftQgBlxsDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] vfio: selftests: igb: Add driver for Intel 82576
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729-igb_v3_b4-v8-1-3ed236272b4e@google.com>
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
 <20260729-igb_v3_b4-v8-1-3ed236272b4e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 22:45:53 +0000
Message-Id: <20260729224554.0C22C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Hardware Testing Failure / Invalid Loopback Configuration
- [Medium] Hardware Configuration / Frame Padding failure for short packets
- [Low] Misleading comment about interrupt delivery during memcpy
--

--- Patch [1]: [PATCH v8 1/6] vfio: selftests: igb: Add driver for Intel 82=
576 device ---
commit e83f78e00ae490d2604290c3e38f2458c48dd9d4
Author: Josh Hilke <jrhilke@google.com>

vfio: selftests: igb: Add driver for Intel 82576 device

This commit adds a VFIO selftest driver for the Intel 82576 Gigabit Ethernet
controller. It uses advanced descriptors and programs MSI-X routing to test
DMA loopback via QEMU's igb emulation and physical hardware.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> new file mode 100644
> index 0000000000000..6fc6e7c0e7235
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c

[ ... ]

> +static void igb_phy_setup_autoneg(struct igb *igb)
> +{
> +	int timeout_ms =3D 1000;
> +	bool success =3D false;
> +	u16 phy_status;
> +	int ret;
> +	int i;
> +
> +	/* Trigger auto-negotiation */
> +	ret =3D igb_write_phy(igb, MII_BMCR,
> +			    BMCR_ANENABLE | BMCR_ANRESTART);

[Severity: Medium]
Will this auto-negotiation time out and fail the test via VFIO_ASSERT_TRUE
when running on physical 82576 hardware without an active external link
partner?

> +	VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
> +
> +	for (i =3D 0; i < timeout_ms; i++) {
> +		if (igb_read_phy(igb, MII_BMSR, &phy_status) =3D=3D 0) {
> +			success =3D !!(phy_status & BMSR_ANEGCOMPLETE);
> +			if (success)
> +				break;
> +		}
> +		usleep(1000);
> +	}
> +
> +	VFIO_ASSERT_TRUE(success, "Auto-negotiation did not complete in time");
> +}

[ ... ]

> +static void igb_init(struct vfio_pci_device *device)
> +{

[ ... ]

> +	/* Enable Receiver and Transmitter */
> +	rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> +	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
> +	       E1000_RCTL_MPE |      /* Multicast Promiscuous */
> +	       E1000_RCTL_BAM |      /* Broadcast Accept Mode */
> +	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */

[Severity: Medium]
Does real 82576 hardware support MAC loopback? It appears this might cause =
DMA
loopback to fail on physical hardware even if auto-negotiation completes.

> +	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> +	igb_write32(igb, E1000_RCTL, rctl);
> +	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);

[Severity: Medium]
Is the Pad Short Packets bit (E1000_TCTL_PSP) missing from the TCTL
configuration here?

If vfio_pci_driver_memcpy() is called with a size smaller than 60 bytes,
would the hardware send a runt frame that the receiver drops (because Store
Bad Packets is disabled), causing igb_memcpy_wait() to time out with
-ETIMEDOUT?

> +
> +	/* Enable MSI-X with 1 vector for the test */
> +	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> +
> +	/*
> +	 * Program MSI-X interrupt routing per 82576 datasheet:
> +	 *
> +	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
> +	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
> +	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
> +	 * applies on EICR read/write).
> +	 *
> +	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
> +	 * Without auto-clear the cause stays set after delivery and the
> +	 * test can see spurious interrupts on the next memcpy batch.
> +	 *
> +	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
> +	 * MSI-X assertion (effective because EIAME is set), so a single
> +	 * interrupt is delivered per memcpy batch even if the cause
> +	 * re-asserts before software re-enables the mask.

[Severity: Low]
This isn't a bug, but is this comment accurate about delivering a single
interrupt per memcpy batch?

Looking at igb_memcpy_start(), it explicitly disables interrupts before the
batch:

    igb_irq_disable(igb);

and igb_memcpy_wait() polls the descriptor writeback before clearing the
cause and re-enabling interrupts:

    igb_irq_clear(igb);
    igb_irq_enable(igb);

It appears interrupts are prevented entirely during the polling loop.

> +	 *
> +	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
> +	 * cause 0 to MSI-X vector 0 and mark the entry valid.
> +	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-igb_v3_b4-=
v8-0-3ed236272b4e@google.com?part=3D1
