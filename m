Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF53E5A18
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839719; cv=none; b=sIGSiQCxxZ9bKTOZ+ymW+cuBNVMFjexhl9jL2jxBVjLXo/k+LjFp/tbqYa5l+o0lJFqC/Gypc0qWGkuaocVMD14c3Swo4YCR6I/h4yP6YZKvsKj0x0EDNmFCYuowE73D7JVrCxF/WCYghlzCwitl5ZmvYHF+x+K/oh7Drm8Ho2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839719; c=relaxed/simple;
	bh=dCwcMGWuT8LT22tzJmEmBRL8NuaCW7IeR3TIV0ZGRHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cq0lNSlaraKdMAbdybwJj/vbX/SayrmQ+pWRRRYOXLoeHctLQO/PggTRqBSB/FacpXZmNFObXFPJV/RertvPlHr5hjyavvgIJMfAHciwBA6lFyTrDn+i2vP0WnBUOaIiD6s5nPBGARudOBQmcxsIvgLNCdhekpZBBD37+37R9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZyso6G8; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZyso6G8"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b7aba0af02so106095805ad.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839696; x=1780444496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C52KEosjKCLt8SgE+F+wyIxStpUJz+xLZYf52QpY+no=;
        b=eZyso6G8+4w/AIpmQimrJvCgDOrnYk3DZR++HrofqL1flts5zUBjbrvyf2e4qnSS+A
         CpwZYIsx4/s6Y2zvuKU855jEygpEPPaMVjb03LjFCZ3GwEARJjtbhKdHBHfXkZ6ui09H
         MHP/zVcgTTo7rLm+JD47AL1yhDD1E1OgGv1LorQIxKbnDoEYve5qRbTERzU8xUJnUROo
         V8R7KgHJmszs9qU933dvLHcj8tUBA/jKKYlJb5+vYAkH2HKHPcgFoEG/PmfQ0LF8kyuN
         helm1ctb/qN8AOfGMNM0ZW8GWjabma+NEJBdasczpIWGeaUpFMjReTX7k8STo54YcTKh
         S+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839696; x=1780444496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C52KEosjKCLt8SgE+F+wyIxStpUJz+xLZYf52QpY+no=;
        b=QlJIQ7LqI6QSXfrXMzFufzL3ueD4BGDoRXBNQDOve3Gv5cXwcAZ2Pvc9V/iTgWHpvG
         PEE8PjSQFZ/3nYo8md3JDaKEGGGINSJt579bvMVtbPtRTW0Oo+cqsZ+umFovVyQP/M4D
         X9Si2bBRRNawwqUsnUz+xTmlUjZvOGLA4fmNS0YHeHR1yf7sIOja6pIcrw4GYJgWMHfI
         it53h6KxUEwc65oETETzLDn3fkx4bepFVX/njFEkl++UF26e5Ym7k0fFrcrqFyUOVkxg
         LQoK6KxffQ55LqXniLjW9G06abfuWaFkga99ITdIG66W6xtfRJ8asFAsuzF+CpbP9pyr
         yZEw==
X-Forwarded-Encrypted: i=1; AFNElJ/yBlx9SH76SNpN1IqHDNREcMkt4CYHEBCFr7+Bv3k4DaOQUd05NCZEbrJNZZ25Lw/jT7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jOjnyh7Qh6AdFFQlE4qytubV+KSoNxEeih01KDl+oV2F98o2
	xUsUJBNdr3qrA0jluA6lZKyjoNPzcsRrOx+pmAFOp4VOO9cN+k6QqKdwgVsWnNGQ7yi5xlc7oSX
	yyHuVflFn
X-Received: from plbju5.prod.google.com ([2002:a17:903:4285:b0:2bc:b04b:d296])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b85:b0:2ba:bfc:7699
 with SMTP id d9443c01a7336-2beb05908eamr231730335ad.17.1779839695816; Tue, 26
 May 2026 16:54:55 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:17 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-11-jrhilke@google.com>
Subject: [PATCH v2 10/10] selftests/vfio: igb: Use offical IGB headers in
 selftest driver
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Include the offical Intel network driver header files in
tools/testing/selftests/vfio/lib/drivers/igb/igb.c and refactor the
driver to directly utilize standard E1000_ prefixed registers and macros
found from those headers.

Delete tools/testing/selftests/vfio/lib/drivers/igb/registers.h as it
only contains duplicate code found in the offical IGB header files.

Assisted-by: Gemini:gemini-3.1-pro-preview
Suggested-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>

# Conflicts:
#	tools/testing/selftests/vfio/lib/drivers/igb/igb.c
---
 .../selftests/vfio/lib/drivers/igb/igb.c      | 159 +++++++++---------
 .../vfio/lib/drivers/igb/registers.h          | 127 --------------
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 3 files changed, 83 insertions(+), 204 deletions(-)
 delete mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/registers.h

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 5568b463c2f2..74b423954554 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -5,14 +5,19 @@
 #include <linux/io.h>
 #include <linux/pci_regs.h>
 #include <linux/pci_ids.h>
+#include <linux/mii.h>
 #include <libvfio/vfio_pci_device.h>
 
-#include "registers.h"
+#include "e1000_regs.h"
+#include "e1000_defines.h"
+#include "e1000_82575.h"
 
 #define PCI_DEVICE_ID_INTEL_82576 0x10C9
 #define IGB_MAX_CHUNK_SIZE 1024
 #define MSIX_VECTOR 0
 #define RING_SIZE 4096 /* Number of descriptors in ring */
+#define IGB_ETH_OVERHEAD_SZ 18
+#define IGB_JUMBO_FRAME_SIZE (IGB_MAX_CHUNK_SIZE + IGB_ETH_OVERHEAD_SZ)
 
 struct igb_tx_desc {
 	union {
@@ -76,23 +81,23 @@ static int igb_write_phy(struct igb *igb, u32 offset, u16 data)
 	int i;
 
 	mdic = (((u32)data) |
-		(offset << IGB_MDIC_REG_SHIFT) |
-		(1 << IGB_MDIC_PHY_SHIFT) |
-		IGB_MDIC_OP_WRITE);
+		(offset << E1000_MDIC_REG_SHIFT) |
+		(1 << E1000_MDIC_PHY_SHIFT) |
+		E1000_MDIC_OP_WRITE);
 
-	igb_write32(igb, IGB_MDIC, mdic);
+	igb_write32(igb, E1000_MDIC, mdic);
 
 	for (i = 0; i < 1000; i++) {
 		usleep(50);
-		mdic = igb_read32(igb, IGB_MDIC);
-		if (mdic & IGB_MDIC_READY)
+		mdic = igb_read32(igb, E1000_MDIC);
+		if (mdic & E1000_MDIC_READY)
 			break;
 	}
 
-	if (!(mdic & IGB_MDIC_READY))
+	if (!(mdic & E1000_MDIC_READY))
 		return -1;
 
-	if (mdic & IGB_MDIC_ERROR)
+	if (mdic & E1000_MDIC_ERROR)
 		return -1;
 
 	return 0;
@@ -125,14 +130,14 @@ static int igb_setup_loopback(struct igb *igb)
 	 * below clears the autoneg-enable bit, so this is effectively a
 	 * no-op there.
 	 */
-	(void)igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
-			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_AN_RESTART);
+	(void)igb_write_phy(igb, MII_BMCR,
+			    BMCR_ANENABLE | BMCR_ANRESTART);
 
 	/* PHY control: loopback + 1Gb/s full duplex, autoneg disabled. */
-	ret = igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
-			    IGB_PHY_CTRL_LOOPBACK |
-			    IGB_PHY_CTRL_SPEED_1000 |
-			    IGB_PHY_CTRL_FULL_DUPLEX);
+	ret = igb_write_phy(igb, MII_BMCR,
+			    BMCR_LOOPBACK |
+			    BMCR_SPEED1000 |
+			    BMCR_FULLDPLX);
 	if (ret)
 		return ret;
 
@@ -148,14 +153,14 @@ static int igb_setup_loopback(struct igb *igb)
 	 * the link state the descriptor engine does not run, since the chip
 	 * normally waits for a real negotiated link.
 	 */
-	ctrl = igb_read32(igb, IGB_CTRL);
-	ctrl &= ~IGB_CTRL_SPD_SEL;
-	ctrl |= IGB_CTRL_FRCSPD |
-		IGB_CTRL_FRCDPX |
-		IGB_CTRL_SPD_1000 |
-		IGB_CTRL_FD |
-		IGB_CTRL_SLU;
-	igb_write32(igb, IGB_CTRL, ctrl);
+	ctrl = igb_read32(igb, E1000_CTRL);
+	ctrl &= ~E1000_CTRL_SPD_SEL;
+	ctrl |= E1000_CTRL_FRCSPD |
+		E1000_CTRL_FRCDPX |
+		E1000_CTRL_SPD_1000 |
+		E1000_CTRL_FD |
+		E1000_CTRL_SLU;
+	igb_write32(igb, E1000_CTRL, ctrl);
 
 	/*
 	 * Settling delay matching the kernel ethtool selftest's msleep(500)
@@ -189,15 +194,14 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	u16 cmd_reg;
 	int retries;
 
-
-
 	iova_tx = to_iova(device, igb->tx_ring);
 	iova_rx = to_iova(device, igb->rx_ring);
+
 	/* Signal that the driver is loaded */
-	ctrl = igb_read32(igb, IGB_CTRL_EXT);
-	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
-	ctrl &= ~IGB_CTRL_EXT_LINK_MODE_MASK;
-	igb_write32(igb, IGB_CTRL_EXT, ctrl);
+	ctrl = igb_read32(igb, E1000_CTRL_EXT);
+	ctrl |= E1000_CTRL_EXT_DRV_LOAD;
+	ctrl &= ~E1000_CTRL_EXT_LINK_MODE_MASK;
+	igb_write32(igb, E1000_CTRL_EXT, ctrl);
 
 	/* Enable PCI Bus Master. */
 	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
@@ -214,27 +218,27 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	 * retrying the failed read indefinitely, which keeps PCIe AER and
 	 * IOMMU error handling busy and interferes with reset recovery.
 	 */
-	ctrl = igb_read32(igb, IGB_GCR);
-	ctrl &= ~IGB_GCR_CMPL_TMOUT_RESEND;
-	igb_write32(igb, IGB_GCR, ctrl);
+	ctrl = igb_read32(igb, E1000_GCR);
+	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, E1000_GCR, ctrl);
 
 	/* Configure PHY internal loopback for testing. */
 	if (igb_setup_loopback(igb))
 		return;
 
 	/* Configure TX and RX descriptor rings */
-	igb_write32(igb, IGB_TDBAL0, (u32)iova_tx);
-	igb_write32(igb, IGB_TDBAH0, (u32)(iova_tx >> 32));
-	igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_desc));
-	igb_write32(igb, IGB_TDH0, 0);
-	igb_write32(igb, IGB_TDT0, 0);
-	igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
-
-	igb_write32(igb, IGB_RDBAL0, (u32)iova_rx);
-	igb_write32(igb, IGB_RDBAH0, (u32)(iova_rx >> 32));
-	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
-	igb_write32(igb, IGB_RDH0, 0);
-	igb_write32(igb, IGB_RDT0, 0);
+	igb_write32(igb, E1000_TDBAL(0), (u32)iova_tx);
+	igb_write32(igb, E1000_TDBAH(0), (u32)(iova_tx >> 32));
+	igb_write32(igb, E1000_TDLEN(0), RING_SIZE * sizeof(struct igb_tx_desc));
+	igb_write32(igb, E1000_TDH(0), 0);
+	igb_write32(igb, E1000_TDT(0), 0);
+	igb_write32(igb, E1000_TXDCTL(0), E1000_TXDCTL_QUEUE_ENABLE);
+
+	igb_write32(igb, E1000_RDBAL(0), (u32)iova_rx);
+	igb_write32(igb, E1000_RDBAH(0), (u32)(iova_rx >> 32));
+	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc));
+	igb_write32(igb, E1000_RDH(0), 0);
+	igb_write32(igb, E1000_RDT(0), 0);
 
 	/*
 	 * Select the advanced one-buffer descriptor format.  Per 82576
@@ -244,15 +248,15 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
 	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
 	 */
-	igb_write32(igb, IGB_SRRCTL0, IGB_SRRCTL_DESCTYPE_ADV_ONEBUF);
+	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
 
-	igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
+	igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
 
 	/* Wait for TX and RX queues to be enabled */
 	retries = 2000;
 	while (retries-- > 0) {
-		if ((igb_read32(igb, IGB_TXDCTL0) & IGB_TXDCTL0_Q_EN) &&
-		    (igb_read32(igb, IGB_RXDCTL0) & IGB_RXDCTL0_Q_EN))
+		if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
+		    (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
 			break;
 		usleep(10);
 	}
@@ -270,13 +274,12 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	 * selftest work on both real hardware and QEMU without conditional
 	 * code paths.
 	 */
-	rctl = IGB_RCTL_EN |       /* Receiver Enable */
-	       IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
-	       IGB_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
-	       IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
-	igb_write32(igb, IGB_RCTL, rctl);
-	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
-
+	rctl = E1000_RCTL_EN |       /* Receiver Enable */
+	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
+	       E1000_RCTL_LBM_MAC |  /* MAC Loopback - for QEMU emulation only */
+	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
+	igb_write32(igb, E1000_RCTL, rctl);
+	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
 	/*
 	 * Program MSI-X interrupt routing per 82576 datasheet:
 	 *
@@ -297,15 +300,15 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
 	 * cause 0 to MSI-X vector 0 and mark the entry valid.
 	 */
-	igb_write32(igb, IGB_GPIE, IGB_GPIE_MULTIPLE_MSIX | IGB_GPIE_EIAME);
-	igb_write32(igb, IGB_EIAC, IGB_EICR_VEC0);
-	igb_write32(igb, IGB_EIAM, IGB_EICR_VEC0);
+	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
+	igb_write32(igb, E1000_EIAC, E1000_EICR_RX_QUEUE0);
+	igb_write32(igb, E1000_EIAM, E1000_EICR_RX_QUEUE0);
 
 	/* Enable interrupts on vector 0 */
-	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 
 	/* Map vector 0 to interrupt cause 0 and mark it valid */
-	igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
+	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
 
 	/* Initialize driver state and capability limits */
 	igb->tx_tail = 0;
@@ -316,6 +319,7 @@ static void igb_hw_init(struct vfio_pci_device *device)
 	device->driver.msi = MSIX_VECTOR;
 }
 
+
 static void igb_init(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -325,9 +329,9 @@ static void igb_init(struct vfio_pci_device *device)
 	igb->bar0 = device->bars[0].vaddr;
 
 	/* Reset device and disable all interrupts. */
-	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
 	usleep(20000);
-	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
+	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
 
 	/*
 	 * Enable MSI-X via VFIO before device-side register programming.
@@ -341,24 +345,26 @@ static void igb_init(struct vfio_pci_device *device)
 
 	igb_hw_init(device);
 }
+
+
 static void igb_remove(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
 
 	vfio_pci_msix_disable(device);
-	igb_write32(igb, IGB_RCTL, 0);
-	igb_write32(igb, IGB_TCTL, 0);
-	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+	igb_write32(igb, E1000_RCTL, 0);
+	igb_write32(igb, E1000_TCTL, 0);
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
 }
 
 static void igb_irq_disable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMC, IGB_EICR_VEC0);
+	igb_write32(igb, E1000_EIMC, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_enable(struct igb *igb)
 {
-	igb_write32(igb, IGB_EIMS, IGB_EICR_VEC0);
+	igb_write32(igb, E1000_EIMS, E1000_EICR_RX_QUEUE0);
 }
 
 static void igb_irq_clear(struct igb *igb)
@@ -370,7 +376,7 @@ static void igb_irq_clear(struct igb *igb)
 	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
 	 * cleared by writing 1.
 	 */
-	igb_write32(igb, IGB_EICR, 0xFFFFFFFF);
+	igb_write32(igb, E1000_EICR, 0xFFFFFFFF);
 }
 
 static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
@@ -404,23 +410,23 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 		 * in bits 15:0 of cmd_type_len.
 		 */
 		tx->read.cmd_type_len = (uint32_t)size |
-			IGB_ADVTXD_DTYP_DATA |
-			IGB_ADVTXD_DCMD_DEXT |
-			IGB_ADVTXD_DCMD_IFCS |
-			IGB_ADVTXD_DCMD_EOP;
+			E1000_ADVTXD_DTYP_DATA |
+			E1000_ADVTXD_DCMD_DEXT |
+			E1000_ADVTXD_DCMD_IFCS |
+			E1000_ADVTXD_DCMD_EOP;
 		/*
 		 * PAYLEN (section 7.2.2.3.11) is the total payload size
 		 * in olinfo_status[31:14].
 		 */
 		tx->read.olinfo_status =
-			(uint32_t)size << IGB_ADVTXD_PAYLEN_SHIFT;
+			(uint32_t)size << E1000_ADVTXD_PAYLEN_SHIFT;
 
 		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
 		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
 	}
 
-	igb_write32(igb, IGB_RDT0, igb->rx_tail);
-	igb_write32(igb, IGB_TDT0, igb->tx_tail);
+	igb_write32(igb, E1000_RDT(0), igb->rx_tail);
+	igb_write32(igb, E1000_TDT(0), igb->tx_tail);
 }
 
 /*
@@ -474,7 +480,6 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 	}
 
 	igb_irq_clear(igb);
-
 	igb_irq_enable(igb);
 
 	if (rx->wb.status_error & 1)
@@ -505,7 +510,7 @@ static void igb_send_msi(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
 
-	igb_write32(igb, IGB_EICS, 1);
+	igb_write32(igb, E1000_EICS, 1);
 }
 
 const struct vfio_pci_driver_ops igb_ops = {
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
deleted file mode 100644
index 3f04bcaa44ba..000000000000
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef _IGB_REGISTERS_H_
-#define _IGB_REGISTERS_H_
-
-#include <linux/bits.h>
-
-/* Register Offsets (Intel 82576EB Datasheet) */
-#define IGB_CTRL 0x00000 /* Device Control */
-#define IGB_STATUS 0x00008 /* Device Status */
-#define IGB_CTRL_EXT 0x00018 /* Extended Device Control */
-#define IGB_MDIC 0x00020 /* MDI Control */
-#define IGB_RCTL 0x00100 /* Receive Control */
-#define IGB_TCTL 0x00400 /* Transmit Control */
-#define IGB_SCTL 0x00420 /* SerDes Control */
-
-/* Interrupt Registers */
-#define IGB_IMC 0x0150C /* Interrupt Mask Clear */
-#define IGB_IVAR0 0x01700 /* Interrupt Vector Allocation Register 0 */
-
-/* Rx Ring 0 Registers */
-#define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
-#define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
-#define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
-#define IGB_SRRCTL0 0x0C00C /* Split and Replication Receive Control Q0 */
-#define IGB_RDH0 0x0C010 /* Rx Desc Head */
-#define IGB_RDT0 0x0C018 /* Rx Desc Tail */
-#define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
-
-/* SRRCTL fields per 82576 datasheet section 8.10.2 */
-#define IGB_SRRCTL_DESCTYPE_ADV_ONEBUF (1u << 25) /* 001b: advanced one-buffer */
-
-/* Tx Ring 0 Registers */
-#define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
-#define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
-#define IGB_TDLEN0 0x0E008 /* Tx Desc Length */
-#define IGB_TDH0 0x0E010 /* Tx Desc Head */
-#define IGB_TDT0 0x0E018 /* Tx Desc Tail */
-#define IGB_TXDCTL0 0x0E028 /* Tx Desc Control */
-
-/* Control Bit Definitions */
-/* CTRL */
-#define IGB_CTRL_FD		(1 << 0)  /* Full Duplex */
-#define IGB_CTRL_SLU		(1 << 6)  /* Set Link Up */
-#define IGB_CTRL_SPD_SEL	(3 << 8) /* Speed Select Mask */
-#define IGB_CTRL_SPD_1000	(2 << 8) /* Force 1000 Mb/s */
-#define IGB_CTRL_FRCSPD		(1 << 11) /* Force Speed */
-#define IGB_CTRL_FRCDPX		(1 << 12) /* Force Duplex */
-#define IGB_CTRL_RST		(1 << 26) /* Device Reset */
-#define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
-
-/* CTRL_EXT */
-#define IGB_CTRL_EXT_DRV_LOAD (1 << 28) /* Driver Loaded */
-
-/* RCTL */
-#define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
-#define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
-#define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
-#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC (set as QEMU-only accommodation) */
-#define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
-
-/* TCTL */
-#define IGB_TCTL_EN (1 << 1) /* Transmit Enable */
-
-/* SCTL */
-#define IGB_SCTL_DISABLE_SERDES_LOOPBACK (1 << 6)
-
-/* MDIC */
-#define IGB_MDIC_OP_WRITE (1 << 26)
-#define IGB_MDIC_OP_READ  (2 << 26)
-
-#define IGB_EICR 0x01580 /* Extended Interrupt Cause Read */
-
-#define IGB_RAH0 0x05404 /* Receive Address High 0 */
-#define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
-#define IGB_GCR 0x05B00 /* PCIe Control */
-#define IGB_GCR_CMPL_TMOUT_RESEND BIT(16) /* Re-send on completion timeout */
-
-#define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
-#define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
-#define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
-
-#define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
-#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
-#define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
-#define IGB_EIAC 0x0152C /* Extended Interrupt Auto Clear */
-#define IGB_EIAM 0x01530 /* Extended Interrupt Auto Mask Enable */
-#define IGB_EICR_VEC0 BIT(0) /* MSI-X cause/vector 0 */
-#define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable */
-#define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable */
-#define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
-/* GPIE fields per 82576 datasheet section 7.3.2.11, Table 7-47 */
-#define IGB_GPIE_MULTIPLE_MSIX BIT(4)  /* Multi-vector MSI-X mode */
-#define IGB_GPIE_EIAME         BIT(30) /* Apply EIAM on MSI-X assertion */
-#define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
-#define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
-#define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
-
-#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
-#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
-#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
-#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
-
-/* PHY register 0 (Control), per 82576 datasheet section 3.5.6.3.1 */
-#define IGB_PHY_CTRL_REG_OFFSET		0
-#define IGB_PHY_CTRL_AN_RESTART		0x0200 /* bit 9 */
-#define IGB_PHY_CTRL_AN_ENABLE		0x1000 /* bit 12 */
-#define IGB_PHY_CTRL_SPEED_1000		0x0040 /* bit 6 set, bit 13 clear */
-#define IGB_PHY_CTRL_FULL_DUPLEX	0x0100 /* bit 8 */
-#define IGB_PHY_CTRL_LOOPBACK		0x4000 /* bit 14 */
-
-#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
-
-/*
- * Advanced TX Data Descriptor fields per 82576 datasheet section 7.2.2.3.
- * The cmd_type_len word holds: DTALEN[15:0], MAC[19:18], DTYP[23:20],
- * DCMD[31:24].  The olinfo_status word holds: STA[3:0], IDX[6:4],
- * POPTS[13:8], PAYLEN[31:14].
- */
-#define IGB_ADVTXD_DTYP_DATA	(0x3u << 20) /* DTYP=0011b: advanced data */
-#define IGB_ADVTXD_DCMD_EOP	(1u << 24)   /* DCMD bit 0: End of Packet */
-#define IGB_ADVTXD_DCMD_IFCS	(1u << 25)   /* DCMD bit 1: Insert FCS */
-#define IGB_ADVTXD_DCMD_RS	(1u << 27)   /* DCMD bit 3: Report Status */
-#define IGB_ADVTXD_DCMD_DEXT	(1u << 29)   /* DCMD bit 5: 1b for advanced */
-#define IGB_ADVTXD_PAYLEN_SHIFT	14           /* PAYLEN bit position */
-
-#endif /* _IGB_REGISTERS_H_ */
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 1f13cca04348..0075749e2f12 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -23,6 +23,7 @@ LIBVFIO_O_DIRS := $(shell dirname $(LIBVFIO_O) | uniq)
 $(shell mkdir -p $(LIBVFIO_O_DIRS))
 
 CFLAGS += -I$(LIBVFIO_SRCDIR)/include
+CFLAGS += -I$(top_srcdir)/drivers/net/ethernet/intel/igb
 
 $(LIBVFIO_O): $(LIBVFIO_OUTPUT)/%.o : $(LIBVFIO_SRCDIR)/%.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
-- 
2.54.0.794.g4f17f83d09-goog

