Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10821CA02
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553513; cv=none; b=TfFuCYLVnnLYFd3QZiiw7skE//QWWRDmTrYeWm0Imq7hzA/ZUdhhDLTIV/uwOSM8yl+Ci37dAD+YFZQVh8mCLAwSMyPN0vQGpiEijLUR+kFAzmJeo0L2YD4hxXYywOBM258QLREdnXNxAynU8OOREsikgIUHPuNpKjb+TwHWRR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553513; c=relaxed/simple;
	bh=TFbJybSFkfg6xiiqthXLgfT3yGniE+NBCf1y0CFhLoA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZWiq71qu5l4VQ03t6Jt4qPFWznGpY6dO6eKWwaVlgSCg7YW/CzFqCDexfaus3nRQibFeHUCIWToU2iUfzxZRo6n3S6BuNHjdZRvRI+136hZm4pBsF9jpHoYPlcs0W4RIT7bIZmxA0jEfBm1sBqU6/JZ7rWCkBuLpOdsMdwsnYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqN7uVcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqN7uVcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACE1F000E9;
	Wed,  8 Jul 2026 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783553511;
	bh=k5DmYUQK1TWshEs3i8bU6xdx1mQKzDDQPzdRPpo5TeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqN7uVcqNea+52256w9tHksu6DhwlMA3emkn7B/W7NdcuvlrzZkAF3AiH0lCW3DgX
	 z1RcoAMb6/JxnvqWl0ETbTxKxfd/OEosDwr8iLzGkKD8HEyQshSXKsPb2RmBXFjHZo
	 0UV9if37Xz/0hdNGgp+RPnTlkMHddqTeO/NWeCgBjC1+PB2IOFpSwYSFkKfPvYl4Te
	 8kWf942wc/B+EJ/EjIYJTTvNiTz79akXpRvz0s1BFwlsOVPtAYD53uhRzw6YdOc1xN
	 nUsOr0VVC8TB3N55X7kGR7xslApdXy/2DPiCRWn7N7GijLTEE8mC3rIaDgvhs+7rnr
	 v/LP0a14GFGtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] vfio: selftests: igb: Add driver for IGB QEMU
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260708-igb_v3_b4-v3-1-1272650ca614@google.com>
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
 <20260708-igb_v3_b4-v3-1-1272650ca614@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 23:31:51 +0000
Message-Id: <20260708233151.6EACE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Advanced Receive Descriptor Misconfiguration (SRRCTL)
- [High] Unsupported MAC Loopback and Link State Deadlock
- [High] Interrupt Delivery Failure due to Incomplete MSI-X Configuration
- [High] Fault Recovery Failure due to PCIe Completion Timeout Resend
- [High] Inadequate Wait Timeout for Large Memcpy Batches
--

--- Patch [1]: [PATCH v3 1/9] vfio: selftests: igb: Add driver for IGB QEMU=
 device ---
commit a7e0dd62086e602fc2886d15801884902daf6cba
Author: Josh Hilke <jrhilke@google.com>

vfio: selftests: igb: Add driver for IGB QEMU device

This patch adds a VFIO selftest driver for the Intel Gigabit Ethernet
controller (IGB) to allow running VFIO selftests in QEMU without requiring
specific hardware. It utilizes the IGB loopback mode to implement the
required memcpy operations.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> new file mode 100644
> index 0000000000000..339ca88b9c555
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

[Severity: High]
Does this configuration work on unplugged physical hardware?=20

Writing to the PHY without enabling BMCR_LOOPBACK and relying on
autonegotiation will block indefinitely and time out after 1 second if no
network cable is connected.

> +	VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
> +
> +	for (i =3D 0; i < timeout_ms; i++) {
> +		if (igb_read_phy(igb, MII_BMSR, &phy_status) =3D=3D 0) {
> +			success =3D !!(phy_status & BMSR_ANEGCOMPLETE);

[ ... ]

> +static void igb_init(struct vfio_pci_device *device)
> +{
> +	struct igb *igb =3D to_igb_state(device);
> +	u64 iova_tx, iova_rx;
> +	u32 ctrl, rctl;
> +	u16 cmd_reg;
> +	int retries;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
> +
> +	/* Set up rings and calculate IOVAs */
> +	igb->bar0 =3D device->bars[0].vaddr;
> +
> +	iova_tx =3D to_iova(device, igb->tx_ring);
> +	iova_rx =3D to_iova(device, igb->rx_ring);

[Severity: High]
Could an unmapped IOVA access permanently lock up the physical device here?

VFIO selftests intentionally submit descriptors targeting unmapped IOVAs to
test IOMMU fault handling. By default, 82576 hardware sets the
E1000_GCR_CMPL_TMOUT_RESEND bit, which instructs the DMA engine to
indefinitely retry upon PCIe Completion Timeout or Unsupported Request from
the IOMMU, flooding the system with PCIe AER errors.

Should the initialization sequence clear this bit in the E1000_GCR register
before starting DMA operations so the device can gracefully recover?

> +	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_R=
ST);
> +	/*
> +	 * Must wait at least 1 millisecond after setting the reset bit before
> +	 * checking if this device is ready to be used (82576 datasheet section
> +	 * 4.2.1.6.1).
> +	 */

[ ... ]

> +	/* Configure TX and RX descriptor rings */
> +	igb_write32(igb, E1000_TDBAL(0), (u32)iova_tx);
> +	igb_write32(igb, E1000_TDBAH(0), (u32)(iova_tx >> 32));
> +	igb_write32(igb, E1000_TDLEN(0), RING_SIZE * sizeof(struct igb_tx_desc)=
);
> +	igb_write32(igb, E1000_TDH(0), 0);
> +	igb_write32(igb, E1000_TDT(0), 0);
> +	igb_write32(igb, E1000_TXDCTL(0), E1000_TXDCTL_QUEUE_ENABLE);
> +
> +	igb_write32(igb, E1000_RDBAL(0), (u32)iova_rx);

[Severity: High]
Will the hardware use the correct descriptor format without configuring
E1000_SRRCTL?

The driver's struct igb_rx_desc expects the Advanced One-Buffer format, but
without writing E1000_SRRCTL_DESCTYPE_ADV_ONEBUF to E1000_SRRCTL during
igb_init(), the 82576 hardware defaults to the legacy format.

This causes the hardware to write the status byte to offset 4 instead of
offset 8, making igb_memcpy_wait() poll an unpopulated offset and causing
the test to fail with an indefinite timeout on physical hardware.

> +	igb_write32(igb, E1000_RDBAH(0), (u32)(iova_rx >> 32));
> +	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc)=
);
> +	igb_write32(igb, E1000_RDH(0), 0);
> +	igb_write32(igb, E1000_RDT(0), 0);
> +	igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
> +
> +	/* Wait for TX and RX queues to be enabled */
> +	retries =3D 2000;
> +	while (retries-- > 0) {
> +		if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
> +		    (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
> +			break;
> +		usleep(10);
> +	}
> +
> +	/* Enable Receiver and Transmitter */
> +	rctl =3D E1000_RCTL_EN |       /* Receiver Enable */
> +	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
> +	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
> +	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> +	igb_write32(igb, E1000_RCTL, rctl);

[Severity: High]
Is it expected that internal MAC loopback is not actually implemented on
real 82576 hardware?

The datasheet (Section 3.5.6.2) indicates E1000_RCTL_LBM_MAC has no physical
effect on the 82576. Additionally, the MAC link is never forced up via
E1000_CTRL_SLU here. This will stall the descriptor engine when running on
real hardware without a live network connection.

> +	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
> +
> +	/* Enable MSI-X with 1 vector for the test */
> +	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
> +
> +	/* Enable auto-masking of interrupts to avoid storms without a real ISR=
 */
> +	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME);
> +
> +	/* Enable interrupts on vector 0 */
> +	igb_write32(igb, E1000_EIMS, 1);
> +
> +	/* Map vector 0 to interrupt cause 0 and mark it valid */
> +	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);

[Severity: High]
Will the hardware successfully deliver MSI-X interrupts with this configura=
tion?

The RX queue is mapped to MSI-X vector 0 using E1000_IVAR0, but the
E1000_GPIE_MSIX_MODE bit isn't set in E1000_GPIE. This leaves the 82576
operating in legacy interrupt mode, causing it to ignore IVAR routing.

Also, while E1000_GPIE_EIAME (Auto-Mask Enable) is set, the E1000_EIAM
and E1000_EIAC registers appear to be left unprogrammed.

> +
> +	/* Initialize driver state and capability limits */
> +	igb->tx_tail =3D 0;

[ ... ]

> +static int igb_memcpy_wait(struct vfio_pci_device *device)
> +{
> +	struct igb *igb =3D to_igb_state(device);
> +	struct igb_rx_desc *rx;
> +	u32 status =3D 0;
> +	u32 prev_tail;
> +	int retries;
> +
> +	prev_tail =3D (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> +	rx =3D &igb->rx_ring[prev_tail];
> +
> +	retries =3D 100;
> +	while (retries-- > 0) {
> +		status =3D le32_to_cpu(READ_ONCE(rx->wb.status_error));
> +		if (status & 1)
> +			break;
> +		usleep(10);
> +	}

[Severity: High]
Is a 1 millisecond total wait timeout sufficient for full-size batch copies?

This lockless polling loop executes 100 iterations of 10 microseconds each,
yielding a strict 1ms timeout limit. However, the driver initializes
max_memcpy_count to 4095 and max_memcpy_size to 1024 bytes. Transmitting
~4 MB of data across a 1 Gbps loopback interface physically requires at lea=
st
~33.5 milliseconds, which will cause large memcpy batches to consistently
time out before completion.

> +
> +	igb_irq_clear(igb);
> +
> +	igb_irq_enable(igb);
> +
> +	return (status & 1) ? 0 : -ETIMEDOUT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-igb_v3_b4-=
v3-0-1272650ca614@google.com?part=3D1
