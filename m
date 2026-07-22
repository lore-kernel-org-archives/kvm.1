Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE9B30ACF0
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679348; cv=none; b=bAUKjmysou+QwH+Oy4p4d4W7Z4Dyd1alH2Ha21Ne6jeRB3Wx0i1Wr1ZJhuNqO9M0RHxfWWmpjitpb66ZPfyhc4mciHouaGXT7Qbepl0F1YAZnb8FJZp/IrLfwpZPumfldO/DRMi1bOJmEHkwZtyjeY1DWSAU77ig5S1q+AxvJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679348; c=relaxed/simple;
	bh=jTtHVqRUbIZnPNC0wsBlFw8Ojc92HvjTzXQklUzrLcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwP+T1kl4JEYI7h7Y+9ZAIFCOHGPiU+DRWlTYps+2U4eWCggEWBpwjXZXq/wO/8/E1zludoKRPNC4PoBD/8CyzJaKRNgNUyUMlLjW/v/P4Wiz5BgMSN397V3o0mnDZn4w3N9OvR1KupeUy3o9ZPswol6btsGT1qQ7VNlopodW04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqweJjmN; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqweJjmN"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so5366088a91.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679340; x=1785284140; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h440Bt12cqzEoynODVhXCA/nTddru9+uYmkcNbY8bXI=;
        b=eqweJjmNt233AHH97OUr4XWOFDFtdKnov6UugFPKY9EHX3WjhXEDF+6nFSxL+N6D/l
         GOFJdtq5hLljAqWjz323DXxWS7sD8XqAj7dK4Yhwl+q+0gGzrvBvv+s8jm9D3Mnc58Cz
         qw1lQHldlIwePkNAaWQfKC3W2rvreU0nS42+axeSLi0YLGobcPglF2g4jZu5/yIe4Yhq
         aZc3ZJmQUf36LdzYwO41Otbsde3SlKxFThS0x4cPcTrvONxsbYw6j8m1+bQRJnFuA3iM
         xUkqsqd1ZFPoAiCG6xdpCosGIbT5lsIE6asTCWNIlgjKvsv9vdv9+hdBBsiTrPVGKXUf
         Dm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679340; x=1785284140;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h440Bt12cqzEoynODVhXCA/nTddru9+uYmkcNbY8bXI=;
        b=GG9g2O7LH/dReQzTCPiBybdNNSjjjqSgnk9fK3A/iuG75n8dKesLxlOEveyAWCGnbf
         t17F6mDY8G7IHA3u4eJVeqOfSMnVjAqsUcVy7iGScSs0XJ14GzoIUxlo/EUfSVUUfDy7
         fduYlITV50QK4Lss/cQbHB35Ri3+GtWgTkzhRc88jvqj2yH7vzzhiqNrwpCGP+N9dfGV
         ybW3eZEW/FE/e4L/DV8TwUmwGyvwGTUyNzw16RvdoAYdMx/4IAphfFXe6ir31jO2EetU
         ORScrPnZ6ueSOGpQ/DrzGtuKudw93Iqbf55qYnEzek6bEF+GRO52Ikm54Q5WSQc3tn+8
         z1Mg==
X-Forwarded-Encrypted: i=1; AHgh+RqBo+wP16FWXCHu2ojeAK6gxHVJM+hJQy9LnB66Aw6a76RY5dyEzC11oR3mpWimeNMFrXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaB/w+qhoYxHA0Pf6KweSKISvz/uz/rnN6PfJbvGiF1kuMKpZp
	2pYegoEltzx2fZQu5R1Wtwl0izH8UIUIcIFiPFV2kzmBO4VTip9APEAFSgr7MD19DFjYoDoIPmz
	jbAGLIyec
X-Received: from pjwt15.prod.google.com ([2002:a17:90a:d14f:b0:38e:74f4:7e63])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2151:b0:38e:4e61:c9e
 with SMTP id 98e67ed59e1d1-38ea3730563mr943006a91.21.1784679339966; Tue, 21
 Jul 2026 17:15:39 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:36 +0000
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=19492;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=jTtHVqRUbIZnPNC0wsBlFw8Ojc92HvjTzXQklUzrLcA=; b=+FFMhVBCU0xpDXMNMfThmMwjh00uYhAWnmPqfY0B9eMW/0pxTNlZsiWlAtEkGW5R3Q965fLrx
 6GO7RfPdwtAC9I3MSsAY3jeK3DYIGf6SQ2hEUVpwsFBtOyt0CZ/4HqM
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-1-0be1d29918d4@google.com>
Subject: [PATCH v6 1/6] vfio: selftests: igb: Add driver for Intel 82576 device
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
(IGB), specifically targeting the 82576 device. IGB is fully
virtualized in QEMU which makes it easy to run VFIO selftests without
needing any specific hardware.

The driver uses advanced descriptors for transmit and receive,
configuring SRRCTL.DESCTYPE to the advanced one-buffer layout for
receive and advanced data descriptor fields in igb_memcpy_start() for
transmit.

It also programs the full MSI-X routing sequence:
- GPIE.Multiple_MSIX to route causes through IVAR.
- GPIE.EIAME to apply EIAM on MSI-X assertion.
- EIAC to enable auto-clear of EICR for vector 0.
- EIAM to enable auto-mask of EIMS for vector 0 on MSI-X assertion.
- IVAR to map RX cause 0 to MSI-X vector 0.

Write-to-clear is used for EICR as required when EIAC is enabled.

To support real 82576 hardware which processes the descriptor ring at
line rate, the memcpy completion timeout in igb_memcpy_wait() is set
to 200 ms (200 retries of 1ms). At 1 Gb/s (~125 MB/s) the worst valid
memcpy (~4 MB) takes ~32 ms on the wire, plus overhead (~3%) and latency.
A 200 ms timeout leaves comfortable headroom for host scheduling jitter
while keeping intentional invalid-DMA tests bounded.

Additionally, DMA re-send on PCIe completion timeout is disabled by
clearing GCR.Completion_Timeout_Resend (datasheet section 8.6.1, bit 16).
The mix_and_match test intentionally submits descriptors targeting
unmapped IOVAs; with the default value, the device retries the failed
read indefinitely, which keeps PCIe AER and IOMMU error handling busy
and interferes with reset recovery.

Co-developed-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 475 +++++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 6 files changed, 481 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/e1000_82575.h b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_82575.h
new file mode 120000
index 000000000000..b84affdec559
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_82575.h
@@ -0,0 +1 @@
+../../../../../../../drivers/net/ethernet/intel/igb/e1000_82575.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/e1000_defines.h b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_defines.h
new file mode 120000
index 000000000000..9f97f4330086
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_defines.h
@@ -0,0 +1 @@
+../../../../../../../drivers/net/ethernet/intel/igb/e1000_defines.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/e1000_regs.h b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_regs.h
new file mode 120000
index 000000000000..c733634171bb
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/e1000_regs.h
@@ -0,0 +1 @@
+../../../../../../../drivers/net/ethernet/intel/igb/e1000_regs.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
new file mode 100644
index 000000000000..a59b95303092
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <unistd.h>
+#include <errno.h>
+#include <stdint.h>
+#include <linux/io.h>
+#include <linux/pci_regs.h>
+#include <linux/pci_ids.h>
+#include <linux/kernel.h>
+#include <linux/compiler.h>
+#include <asm/barrier.h>
+#include <linux/mii.h>
+#include <libvfio/vfio_pci_device.h>
+
+#include "e1000_regs.h"
+#include "e1000_defines.h"
+#include "e1000_82575.h"
+
+#define PCI_DEVICE_ID_INTEL_82576 0x10C9
+#define IGB_MAX_CHUNK_SIZE 1024
+#define MSIX_VECTOR 0
+#define MSIX_VECTOR_MASK (1 << MSIX_VECTOR)
+#define RING_SIZE 4096 /* Number of descriptors in ring */
+
+struct igb_tx_desc {
+	union {
+		struct {
+			u64 buffer_addr; /* Address of descriptor's data buffer */
+			u32 cmd_type_len; /* Command/Type/Length */
+			u32 olinfo_status; /* Context/Buffer info */
+		} read;
+
+		struct {
+			u64 rsvd;        /* Reserved */
+			u32 nxtseq_seed; /* Next sequence seed */
+			u32 status;      /* Descriptor status */
+		} wb;
+	};
+};
+
+struct igb_rx_desc {
+	union {
+		struct {
+			u64 pkt_addr; /* Packet buffer address */
+			u64 hdr_addr; /* Header buffer address */
+		} read;
+		struct {
+			u16 pkt_info;     /* RSS type, Packet type */
+			u16 hdr_info;     /* Split Head, buf len */
+			u32 rss;          /* RSS Hash */
+			u32 status_error; /* ext status/error */
+			u16 length;       /* Packet length */
+			u16 vlan;         /* VLAN tag */
+		} wb; /* writeback */
+	};
+};
+
+struct igb {
+	void *bar0;
+	u32 tx_tail;
+	u32 rx_tail;
+	struct igb_tx_desc tx_ring[RING_SIZE] __attribute__((aligned(128)));
+	struct igb_rx_desc rx_ring[RING_SIZE] __attribute__((aligned(128)));
+};
+
+static inline struct igb *to_igb_state(struct vfio_pci_device *device)
+{
+	return (struct igb *)device->driver.region.vaddr;
+}
+
+static inline void igb_write32(struct igb *igb, u32 reg, u32 val)
+{
+	writel(val, igb->bar0 + reg);
+}
+
+static inline u32 igb_read32(struct igb *igb, u32 reg)
+{
+	return readl(igb->bar0 + reg);
+}
+
+static int igb_write_phy(struct igb *igb, u32 offset, u16 data)
+{
+	u32 mdic;
+	int i;
+
+	/*
+	 * Write a PHY register over MDIO.
+	 *
+	 * A production driver would hold the SW/FW semaphore (SWSM.SWESMBI + the
+	 * SW_FW_SYNC PHY bit) across the MDIO transaction to serialize against the
+	 * device's management firmware.  The selftest owns the assigned function
+	 * exclusively on a dedicated test device with no active manageability
+	 * contending for the PHY, so the sync is omitted; it should be added here
+	 * if this ever needs to run on a manageability-enabled NIC.
+	 */
+	mdic = (((u32)data) |
+		(offset << E1000_MDIC_REG_SHIFT) |
+		(1 << E1000_MDIC_PHY_SHIFT) |
+		E1000_MDIC_OP_WRITE);
+
+	igb_write32(igb, E1000_MDIC, mdic);
+
+	for (i = 0; i < 1000; i++) {
+		usleep(50);
+		mdic = igb_read32(igb, E1000_MDIC);
+		if (mdic & E1000_MDIC_READY)
+			break;
+	}
+
+	if (!(mdic & E1000_MDIC_READY))
+		return -1;
+
+	if (mdic & E1000_MDIC_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static int igb_read_phy(struct igb *igb, u32 offset, u16 *data)
+{
+	u32 mdic;
+	int i;
+
+	mdic = ((offset << E1000_MDIC_REG_SHIFT) |
+		(1 << E1000_MDIC_PHY_SHIFT) |
+		E1000_MDIC_OP_READ);
+
+	igb_write32(igb, E1000_MDIC, mdic);
+
+	for (i = 0; i < 1000; i++) {
+		usleep(50);
+		mdic = igb_read32(igb, E1000_MDIC);
+		if (mdic & E1000_MDIC_READY)
+			break;
+	}
+
+	if (!(mdic & E1000_MDIC_READY))
+		return -1;
+
+	if (mdic & E1000_MDIC_ERROR)
+		return -1;
+
+	*data = (u16)mdic;
+	return 0;
+}
+
+static void igb_phy_setup_autoneg(struct igb *igb)
+{
+	int timeout_ms = 1000;
+	bool success = false;
+	u16 phy_status;
+	int ret;
+	int i;
+
+	/* Trigger auto-negotiation */
+	ret = igb_write_phy(igb, MII_BMCR,
+			    BMCR_ANENABLE | BMCR_ANRESTART);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to write PHY control register");
+
+	for (i = 0; i < timeout_ms; i++) {
+		if (igb_read_phy(igb, MII_BMSR, &phy_status) == 0) {
+			success = !!(phy_status & BMSR_ANEGCOMPLETE);
+			if (success)
+				break;
+		}
+		usleep(1000);
+	}
+
+	VFIO_ASSERT_TRUE(success, "Auto-negotiation did not complete in time");
+}
+
+static int igb_probe(struct vfio_pci_device *device)
+{
+	if (!vfio_pci_device_match(device, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82576))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void igb_reset(struct igb *igb)
+{
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
+	/*
+	 * Must wait at least 1 millisecond after setting the reset bit before
+	 * checking if this device is ready to be used (82576 datasheet section
+	 * 4.2.1.6.1).
+	 */
+	usleep(2000);
+	VFIO_ASSERT_EQ(igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST, 0);
+	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
+}
+
+static void igb_init(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+	u64 iova_tx, iova_rx;
+	u32 ctrl, rctl;
+	u16 cmd_reg;
+	int retries;
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(struct igb));
+
+	/* Set up rings and calculate IOVAs */
+	igb->bar0 = device->bars[0].vaddr;
+
+	iova_tx = to_iova(device, igb->tx_ring);
+	iova_rx = to_iova(device, igb->rx_ring);
+
+	igb_reset(igb);
+
+	/* Signal that the driver is loaded */
+	ctrl = igb_read32(igb, E1000_CTRL_EXT);
+	ctrl |= E1000_CTRL_EXT_DRV_LOAD;
+	ctrl &= ~E1000_CTRL_EXT_LINK_MODE_MASK;
+	igb_write32(igb, E1000_CTRL_EXT, ctrl);
+
+	/* Enable PCI Bus Master. */
+	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
+	if ((cmd_reg & (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) !=
+	    (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY)) {
+		cmd_reg |= (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
+	}
+
+	/* Trigger autonegotiation. This enables IGB to transmit data. */
+	igb_phy_setup_autoneg(igb);
+
+	/*
+	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
+	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
+	 * mix_and_match test intentionally submits descriptors targeting
+	 * unmapped IOVAs; with the default (set) value, the device keeps
+	 * retrying the failed read indefinitely, which keeps PCIe AER and
+	 * IOMMU error handling busy and interferes with reset recovery.
+	 */
+	ctrl = igb_read32(igb, E1000_GCR);
+	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, E1000_GCR, ctrl);
+
+	/* Configure TX and RX descriptor rings */
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
+
+	/*
+	 * Select the advanced one-buffer descriptor format.  Per 82576
+	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
+	 * value other than 000b for the 82576 to write back the special
+	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
+	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
+	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
+	 *
+	 * The direct write also zeroes SRRCTL.BSIZEPACKET, which is
+	 * intentional: per section 7.1.3.1 a zero BSIZEPACKET falls back to
+	 * the RCTL.BSIZE buffer size, whose reset default (00b) is 2048
+	 * bytes -- ample for the loopback frames here.
+	 */
+	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
+
+	igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
+
+	/* Wait for TX and RX queues to be enabled */
+	retries = 2000;
+	while (retries-- > 0) {
+		if ((igb_read32(igb, E1000_TXDCTL(0)) & E1000_TXDCTL_QUEUE_ENABLE) &&
+		    (igb_read32(igb, E1000_RXDCTL(0)) & E1000_RXDCTL_QUEUE_ENABLE))
+			break;
+		usleep(10);
+	}
+	VFIO_ASSERT_GE(retries, 0);
+
+	/* Enable Receiver and Transmitter */
+	rctl = E1000_RCTL_EN |       /* Receiver Enable */
+	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
+	       E1000_RCTL_MPE |      /* Multicast Promiscuous */
+	       E1000_RCTL_BAM |      /* Broadcast Accept Mode */
+	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
+	igb_write32(igb, E1000_RCTL, rctl);
+	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
+
+	/* Enable MSI-X with 1 vector for the test */
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	/*
+	 * Program MSI-X interrupt routing per 82576 datasheet:
+	 *
+	 * GPIE (section 7.3.2.11, Table 7-47): set Multiple_MSIX (bit 4) to
+	 * route interrupt causes through IVAR mapping, and EIAME (bit 30)
+	 * to apply EIAM on MSI-X assertion (without EIAME, EIAM only
+	 * applies on EICR read/write).
+	 *
+	 * EIAC (section 8.8.5): enable auto-clear of EICR for vector 0.
+	 * Without auto-clear the cause stays set after delivery and the
+	 * test can see spurious interrupts on the next memcpy batch.
+	 *
+	 * EIAM (section 8.8.6): enable auto-mask of EIMS for vector 0 on
+	 * MSI-X assertion (effective because EIAME is set), so a single
+	 * interrupt is delivered per memcpy batch even if the cause
+	 * re-asserts before software re-enables the mask.
+	 *
+	 * IVAR (section 7.3.1.2, register definition in 8.8.13): map RX
+	 * cause 0 to MSI-X vector 0 and mark the entry valid.
+	 */
+	igb_write32(igb, E1000_GPIE, E1000_GPIE_MSIX_MODE | E1000_GPIE_EIAME);
+	igb_write32(igb, E1000_EIAC, MSIX_VECTOR_MASK);
+	igb_write32(igb, E1000_EIAM, MSIX_VECTOR_MASK);
+
+	/* Map vector 0 to interrupt cause 0 and mark it valid */
+	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
+
+	/* Enable interrupts on vector 0 */
+	igb_write32(igb, E1000_EIMS, MSIX_VECTOR_MASK);
+
+	/* Initialize driver state and capability limits */
+	igb->tx_tail = 0;
+	igb->rx_tail = 0;
+
+	device->driver.max_memcpy_size = IGB_MAX_CHUNK_SIZE;
+	device->driver.max_memcpy_count = RING_SIZE - 1;
+	device->driver.msi = MSIX_VECTOR;
+}
+
+static void igb_remove(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	igb_write32(igb, E1000_RCTL, 0);
+	igb_write32(igb, E1000_TCTL, 0);
+	igb_reset(igb);
+
+	vfio_pci_msix_disable(device);
+}
+
+static void igb_irq_disable(struct igb *igb)
+{
+	igb_write32(igb, E1000_EIMC, MSIX_VECTOR_MASK);
+}
+
+static void igb_irq_enable(struct igb *igb)
+{
+	igb_write32(igb, E1000_EIMS, MSIX_VECTOR_MASK);
+}
+
+static void igb_irq_clear(struct igb *igb)
+{
+	/*
+	 * Use write-to-clear (datasheet 7.3.4.2).  In MSI-X mode with EIAC
+	 * programmed, section 8.8.5 explicitly states "If any bits are set
+	 * in EIAC, the EICR register should not be read", which rules out
+	 * the read-to-clear path in 7.3.4.3.  Bits not in EIAC are still
+	 * cleared by writing 1.
+	 */
+	igb_write32(igb, E1000_EICR, 0xFFFFFFFF);
+}
+
+static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
+			     iova_t dst, u64 size, u64 count)
+{
+	struct igb *igb = to_igb_state(device);
+	struct igb_rx_desc *rx;
+	struct igb_tx_desc *tx;
+	u32 i;
+
+	igb_irq_disable(igb);
+
+	for (i = 0; i < count; i++) {
+		tx = &igb->tx_ring[igb->tx_tail];
+		rx = &igb->rx_ring[igb->rx_tail];
+
+		memset(tx, 0, sizeof(struct igb_tx_desc));
+		memset(rx, 0, sizeof(struct igb_rx_desc));
+
+		rx->read.pkt_addr = cpu_to_le64(dst);
+		rx->read.hdr_addr = cpu_to_le64(0);
+
+		tx->read.buffer_addr = cpu_to_le64(src);
+		/*
+		 * Build an advanced data descriptor per 82576 datasheet
+		 * section 7.2.2.3.  DEXT marks the descriptor as advanced
+		 * (required by hardware); DTYP=data selects the data
+		 * descriptor; IFCS asks the MAC to append the Ethernet
+		 * FCS (without it the frame is dropped as malformed);
+		 * EOP marks end of packet.  DTALEN is the buffer length
+		 * in bits 15:0 of cmd_type_len.
+		 */
+		tx->read.cmd_type_len = cpu_to_le32((uint32_t)size |
+			E1000_ADVTXD_DTYP_DATA |
+			E1000_ADVTXD_DCMD_DEXT |
+			E1000_ADVTXD_DCMD_IFCS |
+			E1000_ADVTXD_DCMD_EOP);
+		/*
+		 * PAYLEN (section 7.2.2.3.11) is the total payload size
+		 * in olinfo_status[31:14].
+		 */
+		tx->read.olinfo_status =
+			cpu_to_le32((uint32_t)size << E1000_ADVTXD_PAYLEN_SHIFT);
+
+		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
+		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
+	}
+
+	igb_write32(igb, E1000_RDT(0), igb->rx_tail);
+	igb_write32(igb, E1000_TDT(0), igb->tx_tail);
+}
+
+static int igb_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+	struct igb_rx_desc *rx;
+	u32 status = 0;
+	u32 prev_tail;
+	int retries;
+
+	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
+	rx = &igb->rx_ring[prev_tail];
+
+	/*
+	 * Real 82576 hardware processes the descriptor ring at line rate.
+	 * max_memcpy_size = (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE ~= 4 MB,
+	 * split into 4095 1 KB frames.  At 1 Gb/s (~125 MB/s) the worst
+	 * valid memcpy takes ~32 ms on the wire, plus per-frame preamble,
+	 * SFD, IFG and FCS overhead (~3%) and descriptor fetch/writeback
+	 * latency.  Wait up to ~200 ms before declaring the device hung;
+	 * ~6x the line-rate floor leaves comfortable headroom for host
+	 * scheduling jitter while keeping the intentional invalid-DMA
+	 * tests bounded.
+	 */
+	retries = 200;
+	while (retries-- > 0) {
+		status = le32_to_cpu(READ_ONCE(rx->wb.status_error));
+		if (status & 1)
+			break;
+		usleep(1000);
+	}
+
+	if (status & 1)
+		/*
+		 * Ensure the test code doesn't speculatively read the DMA
+		 * destination buffer before we have verified that the
+		 * descriptor writeback is complete.
+		 */
+		rmb();
+
+	igb_irq_clear(igb);
+
+	igb_irq_enable(igb);
+
+	return (status & 1) ? 0 : -ETIMEDOUT;
+}
+
+static void igb_send_msi(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	igb_write32(igb, E1000_EICS, MSIX_VECTOR_MASK);
+}
+
+const struct vfio_pci_driver_ops igb_ops = {
+	.name = "igb",
+	.probe = igb_probe,
+	.init = igb_init,
+	.remove = igb_remove,
+	.memcpy_start = igb_memcpy_start,
+	.memcpy_wait = igb_memcpy_wait,
+	.send_msi = igb_send_msi,
+};
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index 9f47bceed16f..1f13cca04348 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -12,6 +12,7 @@ LIBVFIO_C += vfio_pci_driver.c
 ifeq ($(ARCH:x86_64=x86),x86)
 LIBVFIO_C += drivers/ioat/ioat.c
 LIBVFIO_C += drivers/dsa/dsa.c
+LIBVFIO_C += drivers/igb/igb.c
 endif
 
 LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index 6827f4a6febe..a5d0547132c4 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -5,12 +5,14 @@
 #ifdef __x86_64__
 extern struct vfio_pci_driver_ops dsa_ops;
 extern struct vfio_pci_driver_ops ioat_ops;
+extern struct vfio_pci_driver_ops igb_ops;
 #endif
 
 static struct vfio_pci_driver_ops *driver_ops[] = {
 #ifdef __x86_64__
 	&dsa_ops,
 	&ioat_ops,
+	&igb_ops,
 #endif
 };
 

-- 
2.55.0.229.g6434b31f56-goog

