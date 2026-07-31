Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B9443311;
	Fri, 31 Jul 2026 18:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521714; cv=none; b=eWQjWYvwFOr+RiJU8kT/b/0Hbd8ehPEqsMbzunFNwh5MQ3eH9zPFrj5YNtFlVJBI6WhV/czm6HviiVdb7Ge/ggwGTMaa9Im63rZVryTIvkXwUeS96eqbVJPJ5ZZjVMTCg6tFToa475vEOXJvgbf5RJUWtIgEvI94EO+9YGpolwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521714; c=relaxed/simple;
	bh=2Moq2AK3SSG6Wgcc8ZmuFd3ydbPumPydyOFkSk499Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIT3VQbI0gbgRZmYWrUB+7+JnxG4Pi4MDC/XpsB4QK1tZoXd7wUauNoE68Jp8EvMA1BFCcMGCToxbMqdJ6EetvAcrIQClcfqJVnZJdzpwr+srZMqraEocMfDPQaSGgPeLbS+Vh5v6x0sddQfPm9gkvZ3EJhMcA6YbD2VoGbr7dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=B/yr5I5R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgGrR0Eo; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="B/yr5I5R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgGrR0Eo"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 035F6EC01DE;
	Fri, 31 Jul 2026 14:15:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jul 2026 14:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785521705;
	 x=1785608105; bh=wara+qW6sdFZ1836AKS1NURRQzyRNvWsCNqprbx89LU=; b=
	B/yr5I5RdkPIc7eQcKq0a3PQYmFEKJGIRzbjq121GMHj42j4nkFeRutF0zr2TKDK
	vGsnTIIs7T+6WJf/ULywOPqxPPh18caNwN/x8vfZyvBwh3u2MnCtBBEUc0MWEPwW
	UOPV10MaD3rXc/f72ef4y8eQnR6H3PiCFE1Z6zI0rCDgqrxGXObdxyx/NV9++uSE
	0vuY1zU3s1RAV0veBYIBPPgZCew4phIDJLAey8+2EL7CGPR/OcM1MbYgWrJHk5Z8
	UUemhvGQgs0A44cKH5dYArIb+N0O3ZoE8cWVZSEjeA+dS9TrardZmPXKnk53l6pD
	bMjkYjhIZZspI586e7NLbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785521705; x=
	1785608105; bh=wara+qW6sdFZ1836AKS1NURRQzyRNvWsCNqprbx89LU=; b=f
	gGrR0EomkameyvTMqUiajdv35srWPd8LsK2D1lugcVteupJDSZF0gpyNYL1zFZFg
	41MTzi/5K3Ar5NSuvkwVOmiTleG2TJq6npLdnsiEZGwEr4138v91wuA0foDKpWeM
	//Lo4mymZ6Pf1L1Qb7FJ0INBldWP609+js9pChLU5ut4FBQP1mnswpvjjohI4g0e
	6XIJZcs1H0u8+xSsJ/BraEFrXVd7QYbGU0nLSbxdnAsIuy8IzK4wXTIm7Na3in13
	hqdke5mLlPYGecaIg153XajlpMEKyx/L9X9swvVVZ6yqcJqYehQByro077khbZXp
	pzNfavWj47Z6sE4P9suaA==
X-ME-Sender: <xms:KeZsauk98lbigP5olN3hAvfd-YfEP8fi4BhlhlD-FbPu_tuOsOmQAA>
    <xme:KeZsamRoMduIwqH6mp0ni6-hs6zbnOBugh-Rre6CFYuObY3prl0kUbGxcynR-KQ1V
    mJlcPszO9TGcjmpO9ERZAjOJ_JxYkP7OOvOWHuSFZv8oScBg4uk_w>
X-ME-Received: <xmr:KeZsatVGCnXhBxLxDIbH3j6XUVoT7PgHU2MWMgLRg6YPKp8FGiT-xMNHWOhNXA>
X-ME-Proxy-Cause: dmFkZTEptP546QCDj06/N8/lJGxmRh8V2NbF93IEPiTPkDOvRohe6SIyHZ4/4gqm/Wk8J3
    ClJGX+3QXMXXsACjvxLY98+TxILOjdB9MPhzn9KC8cSrd2Lkeh899lkLIIYY+9TnhdY4yf
    GrCpAHhc/bwj/FEy5dYhfJazSOQuIgecfAgl+7yR3uI9e60hS099jIbgoWYzssUz3Sewr7
    HPomG169a6qN/N5wfbLtDI/xFfXlL8zIOCPcVVtI2HQL6pc6fUcJMM1sC0qh0JRFp/Mp+c
    WXzl/6k/PgshKaftXZK/EEk5ZNsIA/fcWzGH1uK7CmTBLrbFpzeclfpV2YrEvjziSonRag
    btYkhDlJgunFcE66xbV3xo02tgzr5GlM4VPoqyFfNaEhL2oUxLlZVjwsYiktGWkOV+J5AA
    X1gDeJ0sRpnD38iCZTEuNPUTZGow6QYPaYygoRyTTGV2laTJwQaWwVvcjqo+m7iFdhSkcN
    Q/2hgGpBLAmCbd83sevlzopnTqHtXoNBG0vmwE6Xa9CKC2z3/diCHVLGFxvzHEm86fG8p4
    pN/BvriiX0724Y1dgN/ZoUmYFkDpyQG7AkDSd2R3XkAAAFWoIfV2IsqP8EqNPqPlv2cj1e
    C7BOhyKLR8n2JWxx+yYQ8EdXIhV/hyQ64LPox33ngl3liSvOl0qFgwj3dSgg
X-ME-Proxy: <xmx:KeZsaqJtK4seGqNF_Yk9-8nNC-G9X9NRzT3iK_oO1nNg9kTflQGd6w>
    <xmx:KeZsat1y-0b_9lxBEzrwHl_D-X04xNFbzXrgZiiDf7vm7-owzWYIxg>
    <xmx:KeZsanJ3c9z-MbQICj_cFT6-peVZpSTZVkGYPEB31y8fq3YOQzoolw>
    <xmx:KeZsaogfsO-1MhHyTWCZt7pfHbZJXeaA8gQcfGzCfruaFsFUu3vRIQ>
    <xmx:KeZsaiuJaJTYS_53Pot_ejAv9_WhdaGu4EofmurrAe7ciIy1OnZRxd0z>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 14:15:04 -0400 (EDT)
Date: Fri, 31 Jul 2026 12:15:02 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, Alex
 Williamson <alex.williamson@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v9 1/5] vfio: selftests: igb: Add driver for Intel 82576
 device
Message-ID: <20260731121502.3e5416ca@shazbot.org>
In-Reply-To: <20260730-igb_v3_b4-v9-1-9e4d8682437e@google.com>
References: <20260730-igb_v3_b4-v9-0-9e4d8682437e@google.com>
	<20260730-igb_v3_b4-v9-1-9e4d8682437e@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 23:31:29 +0000
Josh Hilke <jrhilke@google.com> wrote:
> +static void igb_init(struct vfio_pci_device *device)
> +{
> +	struct igb *igb = to_igb_state(device);
> +	u64 iova_tx, iova_rx;
> +	u32 ctrl, rctl;
> +	u16 cmd_reg;
> +	int retries;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
> +
> +	/* Set up rings and calculate IOVAs */
> +	igb->bar0 = device->bars[0].vaddr;
> +
> +	iova_tx = to_iova(device, igb->tx_ring);
> +	iova_rx = to_iova(device, igb->rx_ring);
> +
> +	igb_reset(igb);
> +
> +	/* Signal that the driver is loaded */
> +	ctrl = igb_read32(igb, E1000_CTRL_EXT);
> +	ctrl |= E1000_CTRL_EXT_DRV_LOAD;
> +	ctrl &= ~E1000_CTRL_EXT_LINK_MODE_MASK;
> +	igb_write32(igb, E1000_CTRL_EXT, ctrl);
> +
> +	/* Enable PCI Bus Master. */
> +	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
> +	if ((cmd_reg & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) !=
> +	    (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) {
> +		cmd_reg |= (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> +		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
> +	}
> +
> +	/* Configure PHY internal loopback for testing. */
> +	igb_setup_loopback(igb);
> +
> +	/*
> +	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
> +	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
> +	 * mix_and_match test intentionally submits descriptors targeting
> +	 * unmapped IOVAs; with the default (set) value, the device keeps
> +	 * retrying the failed read indefinitely, which keeps PCIe AER and
> +	 * IOMMU error handling busy and interferes with reset recovery.
> +	 */
> +	ctrl = igb_read32(igb, E1000_GCR);
> +	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
> +	igb_write32(igb, E1000_GCR, ctrl);
> +
> +	/* Configure TX and RX descriptor rings */
> +	igb_write32(igb, E1000_TDBAL(0), (u32)iova_tx);
> +	igb_write32(igb, E1000_TDBAH(0), (u32)(iova_tx >> 32));
> +	igb_write32(igb, E1000_TDLEN(0), RING_SIZE * sizeof(struct igb_tx_desc));
> +	igb_write32(igb, E1000_TDH(0), 0);
> +	igb_write32(igb, E1000_TDT(0), 0);
> +	igb_write32(igb, E1000_TXDCTL(0), E1000_TXDCTL_QUEUE_ENABLE);
> +
> +	igb_write32(igb, E1000_RDBAL(0), (u32)iova_rx);
> +	igb_write32(igb, E1000_RDBAH(0), (u32)(iova_rx >> 32));
> +	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc));
> +	igb_write32(igb, E1000_RDH(0), 0);
> +	igb_write32(igb, E1000_RDT(0), 0);
> +
> +	/*
> +	 * Select the advanced one-buffer descriptor format.  Per 82576
> +	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
> +	 * value other than 000b for the 82576 to write back the special
> +	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
> +	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
> +	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
> +	 *
> +	 * The direct write also zeroes SRRCTL.BSIZEPACKET, which is
> +	 * intentional: per section 7.1.3.1 a zero BSIZEPACKET falls back to
> +	 * the RCTL.BSIZE buffer size, whose reset default (00b) is 2048
> +	 * bytes -- ample for the loopback frames here.
> +	 */
> +	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
> +
> +	igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
> +
> +	/* Wait for TX and RX queues to be enabled */
> +	retries = 2000;
> +	while (retries-- > 0) {
> +		if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
> +		    (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
> +			break;
> +		usleep(10);
> +	}
> +	VFIO_ASSERT_GE(retries, 0);

I'm not sure how I missed this in the previous iteration, but this
new-ish assert exposes a latent ordering issue on real hardware.  As per
the below referenced register definitions, the per-queue enable bits are
zero until the global enable bits are set.

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 97a2f29aade3..fae523059f86 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -303,16 +303,6 @@ static void igb_hw_init(struct vfio_pci_device *device)
 
        igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
 
-       /* Wait for TX and RX queues to be enabled */
-       retries = 2000;
-       while (retries-- > 0) {
-               if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
-                   (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
-                       break;
-               usleep(10);
-       }
-       VFIO_ASSERT_GE(retries, 0);
-
        /*
         * Enable Receiver and Transmitter.  RCTL.LBM_MAC is set in addition
         * to PHY loopback as a QEMU-only accommodation: QEMU's emulated igb
@@ -335,6 +325,21 @@ static void igb_hw_init(struct vfio_pci_device *device)
        igb_write32(igb, E1000_RCTL, rctl);
        igb_write32(igb, E1000_TCTL, E1000_TCTL_EN | E1000_TCTL_PSP);
 
+       /*
+        * Wait for TX and RX queues to be enabled.  Per the RXDCTL/TXDCTL
+        * register definitions (8.10.10/8.12.13), the per-queue enable bit
+        * "remains zero" until the global RCTL.RXEN/TCTL.TXEN are set, so
+        * E1000_RCTL_EN and E1000_TCTL_EN must already be written above.
+        */
+       retries = 2000;
+       while (retries-- > 0) {
+               if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
+                   (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
+                       break;
+               usleep(10);
+       }
+       VFIO_ASSERT_GE(retries, 0);
+
        /*
         * Program MSI-X interrupt routing per 82576 datasheet:
         *

Back to 35/35 on real hardware with this.  NB, patch is against fully
applied series, so lands in igb_hw_init() but the source of the
ordering issue is in patch 1 here, where it's igb_init().  Thanks,

Alex

> +
> +	/*
> +	 * Enable Receiver and Transmitter.  RCTL.LBM_MAC is set in addition
> +	 * to PHY loopback as a QEMU-only accommodation: QEMU's emulated igb
> +	 * does not honor PHY register 0 bit 14 (PHY internal loopback) and
> +	 * relies on RCTL.LBM_MAC to wrap TX descriptors back to the RX
> +	 * queue.  Datasheet 8.10.1 (RCTL register) advises "When using the
> +	 * internal PHY, LBM should remain set to 00b", so setting LBM_MAC
> +	 * here deviates from datasheet guidance; empirically the bit has
> +	 * no observable effect on real 82576 hardware because MAC loopback
> +	 * is not implemented (datasheet 3.5.6.2).  Setting both lets the
> +	 * selftest work on both real hardware and QEMU without conditional
> +	 * code paths.
> +	 */
> +	rctl = E1000_RCTL_EN |       /* Receiver Enable */
> +	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
> +	       E1000_RCTL_MPE |      /* Multicast Promiscuous */
> +	       E1000_RCTL_BAM |      /* Broadcast Accept Mode */
> +	       E1000_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
> +	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
> +	igb_write32(igb, E1000_RCTL, rctl);
> +	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN | E1000_TCTL_PSP);
