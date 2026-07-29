Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897F244163B
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364030; cv=none; b=GznPnNvO1e8z/dt4nA+5WHMD8aMWs21jQwuZNwVRk3cQDRUBGbPX1mxPLKCx3Qp1MYWixz1OlHLEGV2iL7HR+yGyZl4/25GJmrNGEJT3R/Tx4EEtVrGcjvye4bw/t+nc3q90035UIIXgrrfqR2i1S654m8BEKORL9F+BfqR19vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364030; c=relaxed/simple;
	bh=wlJIN434m1B02053gQxbQpMbv/Dy+ix9obbN9kLh4s0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SN5qi03madiCJfVlczHDnE7b+7+c+ZqDI8Y0wKLx6vBcYOxTZiKttxglHVZr/UswMHhKxccGisBd8CYe4TE2L656Z04B7T/bDmIJfS+8lO0CJAl9y+LXa5EWvTEIAAUTu0rwpGbGBMuBuW1ykuGB0RUFD7oRi2fLaZlRRGLrr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qe8RUVV0; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qe8RUVV0"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84870e7f498so1480809b3a.3
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364028; x=1785968828; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTA69v3wZkPrXlz62Ym5nIcPFGV+JV+ANqnVMXAU+r0=;
        b=Qe8RUVV0g/OdWOENDN4LO5FNb7LQ/3tfu/TKqqypJ6h2WKaQWjKW7YX5hYog6L78xK
         VsCX7NJn9+dzRUHp+cwl/97SXNeCrhY9xfZ++GtTQ8VAq03kTm2CObjZ7vl4A3hShcT5
         iWPDC0mIb6jl14/Yghfbe4BRckEsSYj4aXSyYWpF6Vb2QXCovlMl02jx3bAPiN9rPBbd
         W34pavXhL2Mfw1DpSlz3X0ov2M9AvC6BEpC0MXnkH3niWvoj4bu0ZM706MPQ5Rz9M6R2
         pbNOCAntpWylo/bBdKFyhbNqY1bsSr/jtzdQVae4YH7YApor7EyxT6GZXPNX33uTHLSM
         U0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364028; x=1785968828;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VTA69v3wZkPrXlz62Ym5nIcPFGV+JV+ANqnVMXAU+r0=;
        b=b36tV4BXlmpOZSolI+qdCuEvgJsHV5Pbc0LDwZkUy59DNg11+2lkdMufOvTHtTyqer
         8PBaELFjP6hRVZRnAcwgF9buO1erMGgxbdIQnTENmMV7nF+gCfySfPJuHACPzT9HdmVM
         QB5gg2MYSPGGcndLz0cjZH3A71ZVMiX9zikaGDhTYnFWe/dW/pK775PJSTQht+4TJtNQ
         /JSXhFRdWAS7215HwRDmh+9AExWjDXqY+BLTZkM1I/uWv4ww2nHj+6LRc/2HrD33on3l
         bh80LAjkeIKNWGJrNWkL++NNAoGGrcI09ZD16tO2bZ4hhhUQERLJOWUNBoYwvyY8221z
         vRJw==
X-Forwarded-Encrypted: i=1; AHgh+RrawtmQHzt6CZV6oPwvgcmKd4CbsM1oWme5U/n4f9jQP2dzQ1ucXiLlJHSWy2dHQrTQAeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TRwhSsPxDvTHlZE7naiUze9Tkd7bm5OQP70nBJ1xoojeUCo/
	oH+cRHdgIMK/S8ynOQDe2WmiKAkoAlLEYmjy+7O7lVl6sfpD8NdP0B/gbIwic84nnNB0Oonhq3q
	TuQeUXI3D
X-Received: from pfbhu4.prod.google.com ([2002:a05:6a00:6984:b0:84c:2a14:d041])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1495:b0:846:bc81:3e29
 with SMTP id d2e1a72fcca58-84ebc1eb713mr172397b3a.2.1785364027505; Wed, 29
 Jul 2026 15:27:07 -0700 (PDT)
Date: Wed, 29 Jul 2026 22:26:57 +0000
In-Reply-To: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729-igb_v3_b4-v8-0-3ed236272b4e@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785364025; l=8608;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=wPb+c+MbGAcpIWYwLzOo7G/LSXV29g7+OrCXOLlf1NA=; b=JmhaLwIkg3eEiRtgAhcHAmUhxL6P9oN2Vp+cuhfEzx+GYByefvm1LD2Vg3Y/q6sBKLjwM/DAH
 lcLo9DbKd3hAAtohtHB6Pruwj1fZsWyFv1YE2m85Olo92GFgwazviwd
X-Mailer: b4 0.14.3
Message-ID: <20260729-igb_v3_b4-v8-2-3ed236272b4e@google.com>
Subject: [PATCH v8 2/6] vfio: selftests: igb: Use PHY internal loopback on 82576
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The submitted driver waits for PHY autonegotiation and then enables MAC
loopback via RCTL.LBM_MAC.  QEMU's emulated igb tolerates this, but the
82576 datasheet rejects the MAC loopback path on real hardware:

  Section 3.5.6.1 (Loopback Support / General): "Use PHY Loopback
  instead of MAC Loopback on the 82576."

  Section 3.5.6.2 (MAC Loopback): "MAC Loopback is not used on this
  device."

  Section 3.5.6.3.1 (Setting the 82576 to PHY loopback Mode): set PHY
  control register bits 8 (duplex), 14 (loopback), clear bit 12
  (autoneg enable), set the speed via bits 6 and 13.  For 1Gb/s the
  register value is 0x4140.

  Section 8.10.1 (RCTL register): "When using the internal PHY, LBM
  should remain set to 00b and the PHY instead configured for
  loopback through the MDIO interface."

Replace igb_phy_setup_autoneg() with igb_setup_loopback() which:

  - writes PHY register 0 with LOOPBACK | SPEED_1000 | FULL_DUPLEX
  - forces the MAC into 1Gb/s full duplex via CTRL.FRCSPD, CTRL.FRCDPX,
    CTRL.SPD_1000, CTRL.FD, CTRL.SLU; without forcing the MAC link
    state, the descriptor engine does not run on real hardware

PHY internal loopback (section 3.5.6.3) wraps data at the end of the
PHY datapath before the MDI, so the physical link state and cable
speed are irrelevant.  This matches the kernel ethtool selftest path
in igb_integrated_phy_loopback()
(drivers/net/ethernet/intel/igb/igb_ethtool.c).

QEMU's igb emulation drives STATUS.LU exclusively from its autoneg-done
timer or a network-backend link-state change; the guest cannot set
STATUS.LU through CTRL.SLU.  Its receive path checks STATUS.LU
(e1000x_hw_rx_enabled in hw/net/e1000x_common.c) and drops every
loopback frame until LU is set.  Issue a one-shot autoneg-restart PHY
write at the top of igb_setup_loopback() to kick the timer; the
subsequent PHY write clears autoneg-enable, so on real hardware
autoneg never starts and the write is a no-op.

QEMU's igb also does not honor PHY register 0 bit 14 (PHY internal
loopback) and relies on RCTL.LBM_MAC to wrap TX descriptors back to
the RX queue.  Datasheet 8.10.1 advises that LBM remain 00b when
using the internal PHY, but empirically setting LBM_MAC has no
observable effect on real 82576 (MAC loopback is not implemented per
3.5.6.2), so set it alongside PHY loopback as the actual loopback
mechanism under QEMU.  With these two QEMU-only accommodations the
selftest works in both environments without environment-specific code
paths.

Remove igb_read_phy() which becomes unused.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 121 +++++++++++++--------
 1 file changed, 73 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 6fc6e7c0e723..1b30a188a864 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -115,57 +115,70 @@ static int igb_write_phy(struct igb *igb, u32 offset, u16 data)
 	return 0;
 }
 
-static int igb_read_phy(struct igb *igb, u32 offset, u16 *data)
+/*
+ * Configure the device for PHY internal loopback per 82576 datasheet
+ * section 3.5.6.3.1.  Force the PHY to 1Gb/s full duplex with loopback
+ * enabled, then force the MAC link state to match.  Internal loopback
+ * wraps data at the end of the PHY datapath (section 3.5.6.3), so the
+ * physical link state is irrelevant.
+ *
+ * Section 3.5.6.1 directs to "Use PHY Loopback instead of MAC Loopback
+ * on the 82576", and section 3.5.6.2 states "MAC Loopback is not used
+ * on this device."  RCTL.LBM_MAC is still set elsewhere as a QEMU-only
+ * accommodation; see the RCTL programming in the caller for the
+ * rationale.
+ */
+static void igb_setup_loopback(struct igb *igb)
 {
-	u32 mdic;
-	int i;
-
-	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
-		(1 << E1000_MDIC_PHY_SHIFT) |
-		E1000_MDIC_OP_READ);
-
-	igb_write32(igb, E1000_MDIC, mdic);
-
-	for (i = 0; i < 1000; i++) {
-		usleep(50);
-		mdic = igb_read32(igb, E1000_MDIC);
-		if (mdic & E1000_MDIC_READY)
-			break;
-	}
-
-	if (!(mdic & E1000_MDIC_READY))
-		return -1;
-
-	if (mdic & E1000_MDIC_ERROR)
-		return -1;
-
-	*data = (u16)mdic;
-	return 0;
-}
-
-static void igb_phy_setup_autoneg(struct igb *igb)
-{
-	int timeout_ms = 1000;
-	bool success = false;
-	u16 phy_status;
+	u32 ctrl;
 	int ret;
-	int i;
 
-	/* Trigger auto-negotiation */
-	ret = igb_write_phy(igb, MII_BMCR,
+	/*
+	 * Kick the autoneg machinery solely to bring STATUS.LU up under
+	 * QEMU's igb emulation: QEMU only updates STATUS.LU via its
+	 * autoneg-done timer, and without LU set its receive path
+	 * (e1000x_hw_rx_enabled) drops every loopback frame.  On real
+	 * hardware autoneg cannot complete before the next PHY write
+	 * below clears the autoneg-enable bit, so this is effectively a
+	 * no-op there.
+	 */
+	(void)igb_write_phy(igb, MII_BMCR,
 			    BMCR_ANENABLE | BMCR_ANRESTART);
+
+	/* PHY control: loopback + 1Gb/s full duplex, autoneg disabled. */
+	ret = igb_write_phy(igb, MII_BMCR,
+			    BMCR_LOOPBACK |
+			    BMCR_SPEED1000 |
+			    BMCR_FULLDPLX);
 	VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
 
-	for (i = 0; i < timeout_ms; i++) {
-		if (igb_read_phy(igb, MII_BMSR, &phy_status) == 0) {
-			success = !!(phy_status & BMSR_ANEGCOMPLETE);
-			if (success)
-				break;
-		}
-		usleep(1000);
-	}
+	/*
+	 * Brief delay before forcing the MAC, mirroring the kernel ethtool
+	 * selftest in igb_integrated_phy_loopback().  Not specified by the
+	 * datasheet, but empirically required by the kernel driver.
+	 */
+	usleep(50000);
+
+	/*
+	 * Force the MAC to 1Gb/s full duplex with link up.  Without forcing
+	 * the link state the descriptor engine does not run, since the chip
+	 * normally waits for a real negotiated link.
+	 */
+	ctrl = igb_read32(igb, E1000_CTRL);
+	ctrl &= ~E1000_CTRL_SPD_SEL;
+	ctrl |= E1000_CTRL_FRCSPD |
+		E1000_CTRL_FRCDPX |
+		E1000_CTRL_SPD_1000 |
+		E1000_CTRL_FD |
+		E1000_CTRL_SLU;
+	igb_write32(igb, E1000_CTRL, ctrl);
 
-	VFIO_ASSERT_TRUE(success, "Auto-negotiation did not complete in time");
+	/*
+	 * Settling delay matching the kernel ethtool selftest's msleep(500)
+	 * at the tail of igb_integrated_phy_loopback().  Not specified by
+	 * the datasheet; empirical, and inherited from the kernel driver.
+	 */
+	usleep(500000);
 }
 
 static int igb_probe(struct vfio_pci_device *device)
@@ -243,8 +256,8 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
-	/* Trigger autonegotiation. This enables IGB to transmit data. */
-	igb_phy_setup_autoneg(igb);
+	/* Configure PHY internal loopback for testing. */
+	igb_setup_loopback(igb);
 
 	/*
 	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
@@ -299,12 +312,24 @@ static void igb_init(struct vfio_pci_device *device)
 	}
 	VFIO_ASSERT_GE(retries, 0);
 
-	/* Enable Receiver and Transmitter */
+	/*
+	 * Enable Receiver and Transmitter.  RCTL.LBM_MAC is set in addition
+	 * to PHY loopback as a QEMU-only accommodation: QEMU's emulated igb
+	 * does not honor PHY register 0 bit 14 (PHY internal loopback) and
+	 * relies on RCTL.LBM_MAC to wrap TX descriptors back to the RX
+	 * queue.  Datasheet 8.10.1 (RCTL register) advises "When using the
+	 * internal PHY, LBM should remain set to 00b", so setting LBM_MAC
+	 * here deviates from datasheet guidance; empirically the bit has
+	 * no observable effect on real 82576 hardware because MAC loopback
+	 * is not implemented (datasheet 3.5.6.2).  Setting both lets the
+	 * selftest work on both real hardware and QEMU without conditional
+	 * code paths.
+	 */
 	rctl = E1000_RCTL_EN |       /* Receiver Enable */
 	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
 	       E1000_RCTL_MPE |      /* Multicast Promiscuous */
 	       E1000_RCTL_BAM |      /* Broadcast Accept Mode */
-	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       E1000_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
 	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
 	igb_write32(igb, E1000_RCTL, rctl);
 	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);

-- 
2.55.0.508.g3f0d502094-goog

