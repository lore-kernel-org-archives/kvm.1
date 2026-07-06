Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47C3E3D90
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369819; cv=none; b=V3cUIR7grM/sSNqjsbMxZeOyELx9ncSez1nJsR4dSdTyVjO1saOYUwBRriJodj+/MCeg72VcLrftaNf0FvFHb3ww8fMk/xLot66Us8Qwud4ekGvfrzmhJlaaZzelCHtgPKDN+qQETp/7y8H6yY61S4h/gw8Ruv6gFTBeC37xzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369819; c=relaxed/simple;
	bh=PkGKVAUXBcrtS4vmy4F8Fp4420sU84x6gnlXH5iad/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLUpwrVU/1/BunrLfJwsF5d5z0m8hhMsOcrnNoBcDaKXhvKWZnXZkvo7hhCVnBWsfeIAE3N44FualV2La8I4rDDKuhpYmhlWyMJCY8eNCAM7CKbIn3x/H6w02JeQA8zLm8OzvMhuPFtncfyEn/w9sFpA3opr/5hfD2duaIWExHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kaPg9g/T; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kaPg9g/T"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847aebc56b6so2709086b3a.3
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783369817; x=1783974617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xntCCT1TCea4fhJTx32PiqxGr8BPBKrcALKzZ790Js0=;
        b=kaPg9g/T26fC5qgpxFTmMv3SPDxCP1DpPOZjDECS334GKANspqs+NdsWBG7hib6BBR
         aI/lk9XYRZ25DO/4xG50LuyDMwq+iNwO8yt3Uik6z3R0HLUecNjiqsGt0bhHOd7l087W
         2dy/r4LcMRMNLy58oCo5OpaD6xRkSsreCv6Eq0tpX27ibeVqbe5URPkVTMHWQyxmWH1d
         c858NTch8k7iqDJ9yMFSpo5LQ3etBtUYkBUamEVPEFeL6VpKKlBNA+hzlrYJebOnuCo5
         1W8Nt053aRHdMkasg/C3Igej5Lht4BwSTgehXOJOca7dgX0t/rmdqio4yIHu5gGAjFTG
         WwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783369817; x=1783974617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xntCCT1TCea4fhJTx32PiqxGr8BPBKrcALKzZ790Js0=;
        b=UkEIg4+BqXt4omFMyHSc4WJa/asru+VtvDLYOl0WyvHx2po0lRG/VBF4q9VXMTGzJZ
         3VMy4xyORz5qJB6pu2qK7vM6NkpOJHBRBgVR7UuAN74NPi+Cz63csvVm+Oz0yDZjrgx1
         6elEZApLlhIaWlhdGF0gF0KP1lRBsB81879n1XNpGS4dVUhhusoTcbXE4xXG8tD8EJNH
         TJgSEm+tQYV2paJ4fdwIsm+9PpGjeqZ0hbVPH1l5SDq75jwZSBHSc0FiXlkSM7zxLM0o
         kCy01Fm+7XKO/uYtSa3iQTaE09jQBFnIJf5PByMzL/ZeUpdT36iGUJHGzmo8br8Z38dr
         gQ0A==
X-Forwarded-Encrypted: i=1; AHgh+Rqr9+uhgJcZQPrSx+j4nQ0CjJhxMYD2teTCufdZzGdoxmyEGEa+0EN21kV6XoJJDKMT+7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+Js5RWWv1Ac5y/R8LZimpL8tmvCtsx2XSaX5StDu8+BrRShC
	B5my/drWJvoNC38ORNG2nYvI4Dl3VESvTHWP7GFQrJceUieAISEMMplDtuIqAbkACJzL54P7oTI
	PpwqYGA==
X-Gm-Gg: AfdE7cnvwhQVMoqIkGDo6HsPX0rXBeHQ7CLNM6U7u4cidRDuhqoz/8UYtNDXsywmv2M
	JuDGOF1q0d2APiuwifXCu1i2NwdtHXDxLYapmP8b3VtZH8lOSApjKCPHXgt2IKEqQSWHKmgrs3H
	irKEHWAbIsh27QOmyV8Ka+9DEduwn/cCgL/pOMye9KM4EbiWd4cbgXRVAVD6m9JF4Xnz55R7Hoj
	ZvLurxxRxuLI8NNTnadgHRi3SxGjQ2WVt1+/HzhksMW1afuk9nzlRYx1Wq3VyV5zdMf/HbmxCQB
	t7T5iceaX4fdGgwNk5a+jQ4j64K8n1dSPdqk+B0x4N98zEbnwVjLi2rUXKJ25KHdZU1oAp12iFY
	QQTTg1GLOu00lPh6L52YFbWDND5+FkQdTv2Sk70xzN4bD3zbdnCMUU1ju/INjvSizZNthAIl/E/
	cXvE398tc6SSjt3T6TBbQpGY0xKCcNUHlgj6OFjBNnyGoeQjqNJ40=
X-Received: by 2002:a05:6a00:298a:b0:847:8449:2bb6 with SMTP id d2e1a72fcca58-84826c1dfa3mr2151292b3a.4.1783369816187;
        Mon, 06 Jul 2026 13:30:16 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d85c04sm4513063b3a.50.2026.07.06.13.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:30:15 -0700 (PDT)
Date: Mon, 6 Jul 2026 20:30:11 +0000
From: David Matlack <dmatlack@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 01/10] selftests/vfio: igb: Add driver for IGB QEMU
 device
Message-ID: <akwQUzGJBJhzdAss@google.com>
References: <20260526235417.2058313-2-jrhilke@google.com>
 <20260527003237.8405E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527003237.8405E1F000E9@smtp.kernel.org>

On 2026-05-27 12:32 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 12 potential issue(s) to consider:
> - [High] Silent failures during device initialization leave the driver in an invalid state.
> - [High] PCI_COMMAND_MEMORY enablement is skipped if PCI_COMMAND_MASTER is already set.
> - [High] Device reset is asynchronous but not awaited, and MSI-X is disabled before the device is quiesced.
> - [High] `igb_memcpy_start` fails to increment `src` and `dst` pointers for multiple chunks.
> - [Medium] Missing SRRCTL configuration causes incorrect Rx descriptor write-back offset on real hardware.
> - [Medium] Missing Transmit FCS (Frame Check Sequence) insertion causes payload truncation.
> - [Medium] Lockless polling of DMA memory without READ_ONCE() or a volatile cast.
> - [Medium] Incorrect MDI Error bit offset in MDIC register definition.
> - [Medium] Missing read/write memory barriers around DMA descriptor and doorbell accesses.
> - [Medium] Missing endianness conversion macros when populating hardware descriptors.
> - [Medium] Unsafe hardware reset logic uses a sleep instead of polling the reset completion bit.
> - [Medium] Incorrect bit definition for IGB_GPIE_EIAME silently disables auto-masking functionality.
> --
> 
> commit f2aa2cf5b25f70be67a7ce0a012a1bdb1dba535c
> Author: Josh Hilke <jrhilke@google.com>
> 
> selftests/vfio: igb: Add driver for IGB QEMU device
>     
> Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
> (IGB). IGB is fully virtualized in QEMU [1] which makes it easy to run
> VFIO selftests without needing any specific hardware.
> 
> [1] https://www.qemu.org/docs/master/system/devices/igb.html
> [2] https://github.com/arighi/virtme-ng
> 
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> > new file mode 100644
> > index 0000000000000..064ca7c05da02
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
> [ ... ]
> > +static void igb_init(struct vfio_pci_device *device)
> > +{
> [ ... ]
> > +	/* Reset device and disable all interrupts */
> > +	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
> > +	usleep(20000);
> 
> [Severity: Medium]
> Could this unsafe hardware reset logic cause issues by sleeping instead of
> polling the reset completion bit? Accessing device registers while a reset is
> propagating internally could trigger PCIe bus hangs.

Please fix this. At minimum the sleep needs to be documented if that is
relying on duration mandated by the hardware spec.

> 
> > +	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
> > +
> > +	/* Signal that the driver is loaded */
> > +	ctrl = igb_read32(igb, IGB_CTRL_EXT);
> > +	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
> > +	ctrl &= ~IGB_CTRL_EXT_LINK_MODE_MASK;
> > +	igb_write32(igb, IGB_CTRL_EXT, ctrl);
> > +
> > +	/* Enable PCI Bus Master. */
> > +	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
> > +	if (!(cmd_reg & PCI_COMMAND_MASTER)) {
> > +		cmd_reg |= (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> > +		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> > +	}
> 
> [Severity: High]
> Does this logic inadvertently skip enabling PCI_COMMAND_MEMORY if
> PCI_COMMAND_MASTER is already set? If the Bus Master bit is already enabled
> by firmware or VFIO but Memory Space is disabled, the block is skipped, which
> would leave Memory Space disabled and cause subsequent MMIO accesses to
> trigger bus faults.

Please fix this.

> 
> > +
> > +	/* Trigger autonegotiation. This enables IGB to transmit data. */
> > +	if (igb_phy_setup_autoneg(igb))
> > +		return;
> 
> [Severity: High]
> Does this early return result in a silent failure during device initialization?
> If it fails, crucial setup steps are skipped, leaving variables like
> max_memcpy_size uninitialized. The test framework will proceed to use the
> partially configured device, leading to undefined behavior or crashes.
> Could it explicitly assert failure via VFIO_ASSERT() instead?

Please fix this. IMO igb_phy_setup_autoneg() should use VFIO_ASSERT()
instead of returning an int.
> 
> > +
> > +	/* Configure TX and RX descriptor rings */
> > +	igb_write32(igb, IGB_TDBAL0, (u32)iova_tx);
> > +	igb_write32(igb, IGB_TDBAH0, (u32)(iova_tx >> 32));
> > +	igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_desc));
> > +	igb_write32(igb, IGB_TDH0, 0);
> > +	igb_write32(igb, IGB_TDT0, 0);
> > +	igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
> > +
> > +	igb_write32(igb, IGB_RDBAL0, (u32)iova_rx);
> 
> [Severity: Medium]
> Is the SRRCTL configuration missing here? The driver expects the hardware to
> use Advanced Receive Descriptors and polls for the DD bit at byte offset 8,
> but fails to configure the SRRCTL register. Real hardware defaults to Legacy
> Receive Descriptors (DD bit at offset 4), causing polling timeouts.
> 
> I noticed this is fixed in a later commit in the series: "selftests/vfio: igb:
> Use advanced TX and RX descriptors".
> 
> [ ... ]
> > +static void igb_remove(struct vfio_pci_device *device)
> > +{
> > +	struct igb *igb = to_igb_state(device);
> > +
> > +	vfio_pci_msix_disable(device);
> > +	igb_write32(igb, IGB_RCTL, 0);
> > +	igb_write32(igb, IGB_TCTL, 0);
> > +	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
> > +}
> 
> [Severity: High]
> Is it safe to disable MSI-X before the device is quiesced, and trigger an
> asynchronous device reset without awaiting its completion?
> 
> Calling vfio_pci_msix_disable() before masking interrupts and triggering a
> hardware reset risks rogue interrupts during teardown. Returning immediately
> after setting IGB_CTRL_RST might create a race condition where the VFIO
> framework destroys IOMMU mappings while the device is still resetting,
> potentially leading to a DMA use-after-free.

I don't think this is a bug. The device should not be sending interrupts
after they are disabled in the device itself.

> 
> [ ... ]
> > +static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
> > +			     iova_t dst, u64 size, u64 count)
> > +{
> > +	struct igb *igb = to_igb_state(device);
> > +	struct igb_rx_desc *rx;
> > +	struct igb_tx_desc *tx;
> > +	u32 i;
> > +
> > +	igb_irq_disable(igb);
> > +
> > +	for (i = 0; i < count; i++) {
> > +		tx = &igb->tx_ring[igb->tx_tail];
> > +		rx = &igb->rx_ring[igb->rx_tail];
> > +
> > +		memset(tx, 0, sizeof(struct igb_tx_desc));
> > +		memset(rx, 0, sizeof(struct igb_rx_desc));
> > +
> > +		rx->read.pkt_addr = dst;
> > +		tx->read.buffer_addr = src;
> > +		tx->read.cmd_type_len = (u32)size;
> > +		tx->read.cmd_type_len |= (u32)(IGB_TXD_CMD_EOP) << IGB_TXD_CMD_SHIFT;
> 
> [Severity: High]
> Does this loop fail to increment the src and dst pointers for multiple chunks?
> When count > 1, the device repeatedly copies the first chunk of data to the
> exact same destination address, leaving the remainder of the buffer uncopied
> and causing data verification failures.

This is not a bug, that's how memcpy_start() is defined to behave.

> [Severity: Medium]
> Are endianness conversion macros missing here? Populating 64-bit addresses
> and 32-bit fields in hardware descriptors using native CPU byte order instead
> of cpu_to_le32 and cpu_to_le64 will break on big-endian host architectures.

Please fix this.

> [Severity: Medium]
> Should the Transmit FCS (Frame Check Sequence) insertion flag be present?
> The driver sets IGB_RCTL_SECRC to strip Ethernet CRC on RX but omits the
> IGB_TXD_CMD_IFCS flag on TX. On real hardware, no CRC is appended, causing
> the RX MAC to strip the last 4 bytes of the actual payload.
> 
> I noticed this is fixed in a later commit in the series: "selftests/vfio: igb:
> Use advanced TX and RX descriptors".
> 
> > +
> > +		/* Set to 0 to disable offloads and avoid needing a context descriptor */
> > +		tx->read.olinfo_status = 0;
> > +
> > +		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
> > +		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
> > +	}
> > +
> > +	igb_write32(igb, IGB_RDT0, igb->rx_tail);
> > +	igb_write32(igb, IGB_TDT0, igb->tx_tail);
> 
> [Severity: Medium]
> Are write memory barriers needed here around the DMA descriptor and doorbell
> accesses? Without a write memory barrier between populating RAM descriptors
> and ringing the TX doorbell, the hardware might fetch stale descriptors.

Can you look into this one? I would have assumed writel() would provide
the proper barriers.

> 
> > +}
> > +
> > +static int igb_memcpy_wait(struct vfio_pci_device *device)
> > +{
> > +	struct igb *igb = to_igb_state(device);
> > +	struct igb_rx_desc *rx;
> > +	u32 prev_tail;
> > +	int retries;
> > +
> > +	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
> > +	rx = &igb->rx_ring[prev_tail];
> > +
> > +	retries = 100;
> > +	while (retries-- > 0) {
> > +		if (rx->wb.status_error & 1)
> 
> [Severity: Medium]
> Could this lockless polling of DMA memory without READ_ONCE() or a volatile
> cast cause problems? The loop polls rx->wb.status_error, which allows the
> compiler to theoretically cache the value in a register. While the external
> usleep() call typically acts as an implicit compiler barrier, relying on it
> is brittle and constitutes a data race.

Please fix this one.

> 
> > +			break;
> > +		usleep(10);
> > +	}
> > +
> > +	igb_irq_clear(igb);
> > +
> > +	igb_irq_enable(igb);
> > +
> > +	if (rx->wb.status_error & 1)
> 
> [Severity: Medium]
> Is a read memory barrier missing here after polling the DMA completion status?
> Without it, there could be speculative CPU reads of the destination buffer.

Maybe just avoid this issue entirely and read rx->wb.status_error into a
variable so you can check it again after the loop.

> 
> > +		return 0;
> > +
> > +	return -ETIMEDOUT;

nit: return error ? -ETIMEDOUT : 0;

> > +}
> [ ... ]
> > diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> > new file mode 100644
> > index 0000000000000..e2756be2e9c0c
> > --- /dev/null
> > +++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
> [ ... ]
> > +#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
> > +#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
> > +#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
> > +#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
> 
> [Severity: Medium]
> Is this MDI Error bit offset correct in the MDIC register definition?
> The macro is defined as (1 << 29), but according to the datasheet, bit 29 is
> the Interrupt Enable bit, while the actual MDI Error bit is bit 30.
> 
> I noticed this is fixed in a later commit in the series: "selftests/vfio: igb:
> Use offical IGB headers in selftest driver".

Please fix this.

> 
> [ ... ]
> > +#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex */
> > +
> > +#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
> 
> [Severity: Medium]
> Does this incorrect bit definition for IGB_GPIE_EIAME silently disable
> auto-masking functionality? It is defined as 0x10, which corresponds to
> Multiple_MSIX. The actual Extended Interrupt Auto Mask Enable bit is bit 30.
> Writing 0x10 fails to enable auto-masking.
> 
> I noticed this is fixed in a later commit in the series: "selftests/vfio: igb:
> Program MSI-X interrupt routing".

Lot of bugs that get fixed later in the series. I think you want to
preserve Alex's author tag by keeping them separate, but let's not
introduce any temporary bugs.

Since we haven't merged anything yet, let's fix all the bugs in this
patch directly, and use the follow up patches for any improvements.

> 
> > +#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
> > +
> > +#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260526235417.2058313-1-jrhilke@google.com?part=1
> 
