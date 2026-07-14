Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFC429CDB
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062681; cv=none; b=sQ8375hNUNEHH8kW0rFxHCBMzGG5N8wwN8cD3WOAvcz5rklJOpalP3pnExdZToAqletMThgOn7a1a/WaHqcFr862Og9Lpf2i2IyfA/50ioclqNiL1mo95Kzf3IEj7ijadgE1hVioOQr8J/9tvA/4tlTxXkFuGespnZKvgCgnQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062681; c=relaxed/simple;
	bh=B4u042/SjTgtOhBE2EBAykLINzboqBIe6lrmzd9jAxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PHh+oF/xMKKJI8LXDlkaE7b/Vtf2+38PpWGMMZ268mWA3U3ERkgI6KylLhtyVd9KQOtgR5JO909sO+DIaLWrn2uDHOnpaGcy92oWkfO4xwNu1Mha+LowvB0P+vFfTIto9N+Jy5+6m0sBw9EgJY1spVM9fX4nlgPeA+ssTrCyQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X6NOc7GG; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X6NOc7GG"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c890bac374eso11996655a12.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062679; x=1784667479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OS2wjQd5duZ4g5gB7oyQ3xZm2R9n83lC5yoILhltKEM=;
        b=X6NOc7GG5qzyZj2oNW3OaQZ7hvOKtbqx0ByKzDkpOKsiPIcv+XCgMYsgBRPaG5ro6Y
         1ky/1GSM3DbgHoWpgs0ackASUy9rIWlJME78yqKBPsDVtGNQp4tQhSAt/rCOCSFpl2n4
         LVTpiqk+8DECi0uyaw9a29WUH0ldhiZ+u9fh9j0YcwOUfHVNoeZBg0LyLfef+8RqtMKV
         VwJtmUSZOQYf9YwjJzhqQ9W9c+JnMs9GXbl2jcg8VJvSU1XmMiqWmGr/N7YW2dHPdAvz
         oGtwFYT6txRmuIe5wHoDl/K1ybyIGr64SGLfkd/P9sPtG716skbGD7TwzjKe2yOITPZU
         Cyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062679; x=1784667479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OS2wjQd5duZ4g5gB7oyQ3xZm2R9n83lC5yoILhltKEM=;
        b=l0xu9Tvk/Jg35V4u6ct7kIG2crcxtGJ6rAnJX3GWjUH1QbZEL5pvtCsX4tPywk9vTN
         mpHIG9sOuj0/e3wdtgylZKcdL88kGjJwxnNc3OyVuB8ADe5wmGEhXBQDIQOA9z/z8DOU
         hiPN+jjWSW1i7p8UUA/2wb62TiIpjWcRBUJJbvue3tepda44aR3IBr+Icis2AdkfgOMp
         3x7JN+n0mtp2hdaJzp5trcznJcgLvG2s7W1HnDID58ip/4waZNOf7Mlz0pfkb3LKNzvU
         Nc7dn25Pgiwki1L5dWWl5griWE7QvTQL4QoHo4hQEJINuubdCoveAw2NaPvyWsBVQI9q
         ojqw==
X-Forwarded-Encrypted: i=1; AHgh+RoHxvvRsQ+l1GgmHKA09KSJDtAEGYmCErpvXvrEY7UWuoUiV1NP1PaN++ZBOh8L5fFkhkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR20vQQxdSfF33xZC+tCFiCYHJ/eDXPm2HuWdN3D0hrcABWHxJ
	XF6QRzSAQSIUe8HwpOUWYcdczADzvHJUQQGPp1vHFTm3PwIwC4c9YPXAx+LYI/ocbTwcvcDlkQD
	stVqsKraf
X-Received: from pgiz8.prod.google.com ([2002:a63:c048:0:b0:c93:ce52:b585])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c98b:b0:3b4:8717:1c21
 with SMTP id adf61e73a8af0-3c36c34f74emr188543637.35.1784062678854; Tue, 14
 Jul 2026 13:57:58 -0700 (PDT)
Date: Tue, 14 Jul 2026 20:57:38 +0000
In-Reply-To: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784062676; l=8558;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=Y+Ca2xwY47R4Cr2nfMhVF6icv8qiADpd9DPLjZvGk1A=; b=4DQymQ6HF7PjbDpCEfXoVUVPt5GZ/SqT3fqY0S49aHmWI0nkPEU+eiS+hDYE7K4hSJoQ/kx/z
 LcHgA4gZHWzDU2Cvybo7SS9yGwsOx6aVVtCdzTzNR7tzD4Emp6vJA9i
X-Mailer: b4 0.14.3
Message-ID: <20260714-igb_v3_b4-v5-2-91503eddb98b@google.com>
Subject: [PATCH v5 2/5] vfio: selftests: igb: Use PHY internal loopback on 82576
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
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 121 +++++++++++++--------
 1 file changed, 73 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index a59b95303092..2b444be4bdfe 100644
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
@@ -221,8 +234,8 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
-	/* Trigger autonegotiation. This enables IGB to transmit data. */
-	igb_phy_setup_autoneg(igb);
+	/* Configure PHY internal loopback for testing. */
+	igb_setup_loopback(igb);
 
 	/*
 	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
@@ -277,12 +290,24 @@ static void igb_init(struct vfio_pci_device *device)
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
2.55.0.141.g00534a21ce-goog

