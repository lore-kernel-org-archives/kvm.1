Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8342BC23
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064504; cv=none; b=PSAeqRdvea7oDj0S5tkCjgrhqMLXZeoTPiaXjoiR7PGOq14lF/qEidSwd8e4NkuX5HTKvmlhb8HJiR4UF/RYCqCBpDjeRksjAh6Z7Vh8jXLLMTo9CHbqueWDDzz0rZnIxWs3EOd0EiGBwPFgMK8tVDYLkVgO1NipWYkQGRaqQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064504; c=relaxed/simple;
	bh=yUFibzQr3u0oDETTmPt62Eb8lTEGrmFD1E6/2mnsIYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ws6MlWqMP9vEVsBv+kb6+8i2giMQFBoOuUbABrgK7GIsYnbRSHt/N3RNBSMO5HMU+27bfRlphArOcUAiLuO+QP6dYfcgh/m9WsTxsVCyEbv4pdc87cpMKKo9XTjdNOC+GOja69OZ55UysRhlMULrnxMYBPtpTqkIZZ8oJ+aQqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXWYyQXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXWYyQXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFEC1F000E9;
	Tue, 14 Jul 2026 21:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064503;
	bh=pQ3Eme45D7pXEvxIlD5eqvHVMQpT/liVQymzX0IfFZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXWYyQXi6kKZtDHRqgVP7JmLTsNBvZAeXWohTQ5lwP2V8laGVegCLquYRK8iWcUB+
	 yNphZGlkzZafzkDTqo5fEbBRqbH9oS239PSKykFud63aO4dhECacPkJAZJ8LtT4Z1i
	 tLi+zeLbfWKjVNOY4AbQmc8JQPlpOU7yx6Pq9Zk6KJHN8gN6KHrWBhBuiJJhWzFc23
	 UpHIwgOQDDrkAw0Xr/u7TJFIrErRSns28y7Tjn47joJ5syat+5l92Crjhx58Yo/m6S
	 OTwoVg5Eek4kIHbR7E22h4wIJf52YPDTFdfxI+7dqSp1DntAlYzQ9ID/UYMF+EhttV
	 oRtcLZ/PmHwIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] vfio: selftests: igb: Add driver for Intel 82576
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714-igb_v3_b4-v5-1-91503eddb98b@google.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
 <20260714-igb_v3_b4-v5-1-91503eddb98b@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:28:22 +0000
Message-Id: <20260714212823.1EFEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The selftest relies on external PHY auto-negotiation, which will=
 cause the test to fail on real hardware if no physical link (cable) is con=
nected.
- [Medium] MMIO registers are accessed before PCI memory space is enabled, =
which can crash the test if memory space is disabled.
--

--- Patch [1]: [PATCH v5 1/5] vfio: selftests: igb: Add driver for Intel 82=
576 device ---
commit b66293558b628d9af7dfd3c68ff9a1e69b1cbb0b
Author: Josh Hilke <jrhilke@google.com>

vfio: selftests: igb: Add driver for Intel 82576 device

Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
(IGB), specifically targeting the 82576 device. IGB is fully
virtualized in QEMU which makes it easy to run VFIO selftests without
needing any specific hardware.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/t=
esting/selftests/vfio/lib/drivers/igb/igb.c
> new file mode 100644
> index 0000000000000..a59b953030925
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

[Severity: Medium]
Will this cause the selftest to fail on real hardware if no physical cable =
is
connected?

Since this relies on external PHY auto-negotiation, it looks like the
BMSR_ANEGCOMPLETE bit will never set without a physical link partner,
triggering this assertion failure.

[ ... ]

> +static void igb_reset(struct igb *igb)
> +{
> +	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_R=
ST);
> +	/*
> +	 * Must wait at least 1 millisecond after setting the reset bit before
> +	 * checking if this device is ready to be used (82576 datasheet section
> +	 * 4.2.1.6.1).
> +	 */
> +	usleep(2000);
> +	VFIO_ASSERT_EQ(igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST, 0);

[Severity: Medium]
Can this assertion fail due to igb_read32() returning 0xFFFFFFFF if PCI
memory space is disabled?

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
> +
> +	igb_reset(igb);

[Severity: Medium]
Is it safe to perform MMIO accesses in igb_reset() before the PCI memory
space is enabled below?

If the device was recently reset or the system does not pre-enable memory
space, these early MMIO accesses might fail.

> +
> +	/* Signal that the driver is loaded */
> +	ctrl =3D igb_read32(igb, E1000_CTRL_EXT);
> +	ctrl |=3D E1000_CTRL_EXT_DRV_LOAD;
> +	ctrl &=3D ~E1000_CTRL_EXT_LINK_MODE_MASK;
> +	igb_write32(igb, E1000_CTRL_EXT, ctrl);
> +
> +	/* Enable PCI Bus Master. */
> +	cmd_reg =3D vfio_pci_config_readw(device, PCI_COMMAND);
> +	if ((cmd_reg & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) !=3D
> +	    (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) {
> +		cmd_reg |=3D (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> +		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-igb_v3_b4-=
v5-0-91503eddb98b@google.com?part=3D1
