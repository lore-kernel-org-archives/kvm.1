Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3493CFF44
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721215; cv=none; b=fwUdDB01KS9CUn/RE/OzIPRolUlo+PNigrgGBrGCwlGg4bi68aBmdaqVsz/WJ1jhXZ6BLpi3YQXDfRz5umeUT+Yb9W1VKyIQw5w9/pw4P3JhisGrWpVKMq4GkaV8dxlj9zeWWYBYEdQ1IOlRzyp4ztt7fOpCaMZhPYMEh3LRgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721215; c=relaxed/simple;
	bh=7JOS48I3NEUU/p6/YNWCZsTgsMDs9hkv7k7Q3FzIzig=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CaGXXQfJH6js0L1zUXACZyQz2KA7418E0SmyZi21Ez73445x8GSvxjLDpKQXijc6+JTTeZuK9s3u0k/zpEIFx24kiL5GBkYvyFjaNfqmO7XHAFejVb/BDKDteg/NIh9iYgeF5QYAVYj2dwCzIJyVx6DXovihf8ps+oyrPASG7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WfZ5QhDX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WfZ5QhDX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84885a4fcabso551290b3a.3
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721211; x=1784326011; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SWTiX2PkmTKlxw5Cf9kZZ45LEhjcTBibm2DK4Kwk3HM=;
        b=WfZ5QhDX1aPrtK94EDSrDwSMrtoWLVrnT0CeItl8QEtoyj0nHBDEnpspgdNjcS/cA1
         9nR+AK0NhlQShizzKLbsf+g9/WWgzTblxmIH7e/UjZZRPFPIcu4mStVpM45CFmB+3iKi
         6pChEOJmkKdXprVKY9Kb0/WucXGdU2JHGEXq6lrUgF90gYS8P0BZoSBVjQu+epwPMo3K
         n1KEzap9px4vL6LaadLqTR01GFlzrTGLQkEK7ip+3eIBl3tuH9j6/ACuZMEzIpXRooNU
         G03l6m8tEvsq3ZPtfgk6RochxVT6Lk7Reu+CCnOF0uCgjsT8m8mfTEOW9q48IOyGMp+y
         L0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721211; x=1784326011;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SWTiX2PkmTKlxw5Cf9kZZ45LEhjcTBibm2DK4Kwk3HM=;
        b=Yw8cjXFOMK39vegUrofj75V40MHvGDmsD1zIWH3+yKkEztaAWzLRj3YgyWGrtcQjhw
         Ukt0tE1AjEwq7z8DXbanKTlKPrEoqi5pQ+HBdaLku33Hw30vbaUchVIqspxMN6HXtpw9
         DgoZrkZi0+omelSJ5Ssf7mx59UJVzpVFj2wEfQkupOkExNpQbYDG2uTZqzB0E+rpp0EY
         tIF6MHRi+bOfU56UUllJ3xvatqRgEhkRuTsS8D8rouLuxrETCFceHLef5Sp7YkNYWrky
         Sn4zBgqu2NInqsTh7AGZs3vsKbBQAYp1s7/PEg7HknhFABzzxwS/VtknJPa6y5y2zafy
         V+GQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+XGVTwEmPg5aHve3oEoAhtlgyJzWECsqz6OlWPxHE31frjWa/XNpem501bsSiMMxX1SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/A/VO8AbvY8R1ecFLYJ8RsONNk5yU02skCfY1DgF2A1wRcS8/
	xxnuM6kZIqyU3gG3//9nBkExZCYMQgK/h9foIf384gcRCLULnERBJnXmZx+b6DYFCkNlipova8h
	8W8u8zYAS
X-Received: from pfbln8.prod.google.com ([2002:a05:6a00:3cc8:b0:848:48a0:41e6])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c8f:b0:82d:62ed:b01d
 with SMTP id d2e1a72fcca58-848896bb05emr723565b3a.45.1783721210396; Fri, 10
 Jul 2026 15:06:50 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:46 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=8817;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=SIgpWdDVQxVOygHfKVKsfIRiQ88wk46H3v6Ry1SUnxo=; b=d3VVWv2XY5UgtBcn4wpVRWVr5NuJKHrYR0LN7oFtQKV9q/7X5kztyQ2bHy5pqNXSmWaqk5v/e
 8a2AvfpOOBhBWKsx8eU+2zSTy4Qwk8DsHP5IU4sFzrwKCNc42TExD3E
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-2-56e7e2576cc1@google.com>
Subject: [PATCH v4 2/9] vfio: selftests: igb: Use PHY internal loopback on 82576
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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 122 +++++++++++++--------
 1 file changed, 74 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 923b2341abad..cccaedf86e32 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -114,57 +114,70 @@ static int igb_write_phy(struct igb *igb, u32 offset, u16 data)
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
@@ -191,6 +204,7 @@ static void igb_init(struct vfio_pci_device *device)
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
 
+	/* Reset device and disable all interrupts */
 	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
 	/*
 	 * Must wait at least 1 millisecond after setting the reset bit before
@@ -216,8 +230,8 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
-	/* Trigger autonegotiation. This enables IGB to transmit data. */
-	igb_phy_setup_autoneg(igb);
+	/* Configure PHY internal loopback for testing. */
+	igb_setup_loopback(igb);
 
 	/* Configure TX and RX descriptor rings */
 	igb_write32(igb, E1000_TDBAL(0), (u32)iova_tx);
@@ -243,10 +257,22 @@ static void igb_init(struct vfio_pci_device *device)
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
 	rctl = E1000_RCTL_EN |       /* Receiver Enable */
 	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
-	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       E1000_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
 	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
 	igb_write32(igb, E1000_RCTL, rctl);
 	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);

-- 
2.55.0.795.g602f6c329a-goog

