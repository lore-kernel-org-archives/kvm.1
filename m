Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2B3D3CF4
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839693; cv=none; b=qeNkSjqxPcAPGN6m0BaXKUPHXD/oDmn6eGikmgtMIbXo6+BaMPjiy78gDMCki90SiE0j0vVbn5Ov7njAnbtOO+UUH61AjzdtM/xy0Ewr9s2NX51qqOBNKBCtMPX+45O4r8wmSAC/kx/32dlP2Qmwk3Qnf0IkyDtODuQqJx0Iy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839693; c=relaxed/simple;
	bh=MoXLI/Rx/1wcyLc6d1dn0zWurCA7BMrvOFsAQM2rwBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwMI3gvk+RCi9aBP8eEnuzFon8udUO+NQkNtl234Isw30BKZQLKJ60m4SjLB9KhNtz7MQ2PTR7JLMYxoyGRrZ+S4AaMNolYiTSJw4uZ1TwgZcxzaQ9n6GuKRPFVDj2kLkQowuggYfPru8p29MG2xgOJhia+a7ArqGFtm9DKnz4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sf5dJb+1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sf5dJb+1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso59653565ad.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839680; x=1780444480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGdsK34wBqC67IQueNKi2CBB24h5rQTseKk16b97iGw=;
        b=sf5dJb+1YBaUO7hl5UHhki3S3S8Ei91L8ywQo0qbK3FE6akW+XG8Vu8m+z9ITSLPw8
         SQCZrXJJG6ipJ+j0IARi7cJUjC0NddEKgeOeWIxeHRQy95zWMXAUu3lJMbO3sxgk+uKO
         XDiihscg2niBtD0viwqQTGYqgmRR6Ouk2VASNPC07E457cVJThw88dn//PeEactUIYzm
         4CoijYhY3LFvzOEw7HjDcwvwKPoeM2RyKkRPj+qFC6FwUuST16+ZKEitdFK5oo8prHLJ
         yaOTbWgLD/gOC271j50dEifzHWH3qQyKwgo1SPOsmBf9ltkVBzR7JuEPz079CBTdPLb1
         BHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839680; x=1780444480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGdsK34wBqC67IQueNKi2CBB24h5rQTseKk16b97iGw=;
        b=cZJP+zJuTXFw6HLzx7drKC5rmtGR2Qk16f5MUx8TpGG5i88yKyX8K0Idw9oRJMIzQm
         7zO7u2SmvLlOxttu5nxYt54y9CHwh3fKeQ4wGScOXo0z3XiktDtLBzz8hpz0p85tZFlJ
         yJrVC7itRs8PjU/4/0jIGgbLsJMAA/AuuI4TOnIlp4CWs97glMQTZmvzRIXhwUwHKluZ
         2OihQrcYN0rqQTU66k+8hwpszsbCBRwnES9ClPeVpgcMbgfRnA17iSeVutxCZAUuIvgF
         rffu+H0xe7NELzm1UrZPVLAyHEDgHgvzZRdqYqJH+HJjJ32xNplecTMvvG1k8SPrU9G4
         vHzg==
X-Forwarded-Encrypted: i=1; AFNElJ9LjyqwiGd5Fed1QehR9S78fEWaTAhwHagBJ7DALxBJMXbGqzzMivuDpcMTs+OmGXEqVf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7uQ902k7WooS8BvZIOpvVRcoHFcZx/co1EluBC3RAJbzsNZG
	LIe3O7iZub/shJ8ggSC3DJenkjNNJQ8IlBXHGf2aqgGJNyAE0unxM1NZhYtWgg0NJ0yLsqiFsKu
	e3BDnizfN
X-Received: from pgjd23.prod.google.com ([2002:a63:d657:0:b0:c80:2656:4e70])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3285:b0:3a0:adc5:52c1
 with SMTP id adf61e73a8af0-3b328c4cbf0mr22184230637.11.1779839679711; Tue, 26
 May 2026 16:54:39 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:09 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-3-jrhilke@google.com>
Subject: [PATCH v2 02/10] selftests/vfio: igb: Use PHY internal loopback on 82576
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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

The submitted driver also wrote bit 14 (link disable) to PHY register
16 (port control).  Datasheet 3.5.6.3.1 describes this as required for
10/100Mb/s but explicitly "not a must for 1G", and the kernel ethtool
selftest omits it.  It is dropped here.  Flagging the removal in case a
future regression bisects to this commit.

Remove igb_read_phy() and the PHY status macros it served, which become
unused: IGB_PHY_STATUS_REG_OFFSET, IGB_PHY_STATUS_AN_COMP.  Keep
IGB_PHY_CTRL_AN_ENABLE and IGB_PHY_CTRL_AN_RESTART for the QEMU-only
autoneg kick; add the PHY ctrl loopback and CTRL force-link macros.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 126 ++++++++++--------
 .../vfio/lib/drivers/igb/registers.h          |  26 ++--
 2 files changed, 89 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 064ca7c05da0..5bbc6fca7518 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -98,61 +98,71 @@ static int igb_write_phy(struct igb *igb, u32 offset, u16 data)
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
+static int igb_setup_loopback(struct igb *igb)
 {
-	u32 mdic;
-	int i;
-
-	mdic = ((offset << IGB_MDIC_REG_SHIFT) |
-		(1 << IGB_MDIC_PHY_SHIFT) |
-		IGB_MDIC_OP_READ);
-
-	igb_write32(igb, IGB_MDIC, mdic);
-
-	for (i = 0; i < 1000; i++) {
-		usleep(50);
-		mdic = igb_read32(igb, IGB_MDIC);
-		if (mdic & IGB_MDIC_READY)
-			break;
-	}
-
-	if (!(mdic & IGB_MDIC_READY))
-		return -1;
-
-	if (mdic & IGB_MDIC_ERROR)
-		return -1;
-
-	*data = (u16)mdic;
-	return 0;
-}
-
-static int igb_phy_setup_autoneg(struct igb *igb)
-{
-	int timeout_ms = 1000;
-	bool success = false;
-	u16 phy_status;
+	u32 ctrl;
 	int ret;
-	int i;
 
-	/* Trigger auto-negotiation */
+	/*
+	 * Kick the autoneg machinery solely to bring STATUS.LU up under
+	 * QEMU's igb emulation: QEMU only updates STATUS.LU via its
+	 * autoneg-done timer, and without LU set its receive path
+	 * (e1000x_hw_rx_enabled) drops every loopback frame.  On real
+	 * hardware autoneg cannot complete before the next PHY write
+	 * below clears the autoneg-enable bit, so this is effectively a
+	 * no-op there.
+	 */
+	(void)igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
+			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_AN_RESTART);
+
+	/* PHY control: loopback + 1Gb/s full duplex, autoneg disabled. */
 	ret = igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
-			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTART_AN);
+			    IGB_PHY_CTRL_LOOPBACK |
+			    IGB_PHY_CTRL_SPEED_1000 |
+			    IGB_PHY_CTRL_FULL_DUPLEX);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < timeout_ms; i++) {
-		if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_status) == 0) {
-			success = !!(phy_status & IGB_PHY_STATUS_AN_COMP);
-			if (success)
-				break;
-		}
-		usleep(1000);
-	}
-
-	if (!success) {
-		printf("igb: Auto-negotiation did not complete in time\n");
-		return -ETIMEDOUT;
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
+	ctrl = igb_read32(igb, IGB_CTRL);
+	ctrl &= ~IGB_CTRL_SPD_SEL;
+	ctrl |= IGB_CTRL_FRCSPD |
+		IGB_CTRL_FRCDPX |
+		IGB_CTRL_SPD_1000 |
+		IGB_CTRL_FD |
+		IGB_CTRL_SLU;
+	igb_write32(igb, IGB_CTRL, ctrl);
+
+	/*
+	 * Settling delay matching the kernel ethtool selftest's msleep(500)
+	 * at the tail of igb_integrated_phy_loopback().  Not specified by
+	 * the datasheet; empirical, and inherited from the kernel driver.
+	 */
+	usleep(500000);
 
 	return 0;
 }
@@ -199,8 +209,8 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
-	/* Trigger autonegotiation. This enables IGB to transmit data. */
-	if (igb_phy_setup_autoneg(igb))
+	/* Configure PHY internal loopback for testing. */
+	if (igb_setup_loopback(igb))
 		return;
 
 	/* Configure TX and RX descriptor rings */
@@ -227,10 +237,22 @@ static void igb_init(struct vfio_pci_device *device)
 		usleep(10);
 	}
 
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
 	rctl = IGB_RCTL_EN |       /* Receiver Enable */
 	       IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
-	       IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       IGB_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
 	       IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
 	igb_write32(igb, IGB_RCTL, rctl);
 	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index e2756be2e9c0..388862d481eb 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -34,7 +34,13 @@
 
 /* Control Bit Definitions */
 /* CTRL */
-#define IGB_CTRL_RST (1 << 26) /* Device Reset */
+#define IGB_CTRL_FD		(1 << 0)  /* Full Duplex */
+#define IGB_CTRL_SLU		(1 << 6)  /* Set Link Up */
+#define IGB_CTRL_SPD_SEL	(3 << 8) /* Speed Select Mask */
+#define IGB_CTRL_SPD_1000	(2 << 8) /* Force 1000 Mb/s */
+#define IGB_CTRL_FRCSPD		(1 << 11) /* Force Speed */
+#define IGB_CTRL_FRCDPX		(1 << 12) /* Force Duplex */
+#define IGB_CTRL_RST		(1 << 26) /* Device Reset */
 #define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
 
 /* CTRL_EXT */
@@ -44,7 +50,7 @@
 #define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
 #define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
 #define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
-#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC */
+#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC (set as QEMU-only accommodation) */
 #define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
 
 /* TCTL */
@@ -81,15 +87,13 @@
 #define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
 #define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
 
-#define IGB_PHY_CTRL_REG_OFFSET 0
-#define IGB_PHY_STATUS_REG_OFFSET 1
-#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete */
-#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
-#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation */
-
-#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Advertisement */
-#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
-#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex */
+/* PHY register 0 (Control), per 82576 datasheet section 3.5.6.3.1 */
+#define IGB_PHY_CTRL_REG_OFFSET		0
+#define IGB_PHY_CTRL_AN_RESTART		0x0200 /* bit 9 */
+#define IGB_PHY_CTRL_AN_ENABLE		0x1000 /* bit 12 */
+#define IGB_PHY_CTRL_SPEED_1000		0x0040 /* bit 6 set, bit 13 clear */
+#define IGB_PHY_CTRL_FULL_DUPLEX	0x0100 /* bit 8 */
+#define IGB_PHY_CTRL_LOOPBACK		0x4000 /* bit 14 */
 
 #define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
-- 
2.54.0.794.g4f17f83d09-goog

