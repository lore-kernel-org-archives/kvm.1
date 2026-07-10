Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7E30674E
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721215; cv=none; b=Wdb8mz4PRF6rokY1UwZM7f3z4hSSkgjKFzZfQtV800E60YMiSEI58LpHOaHHbfhfS25RcvEq4s/3I5zBQHvxZH4KOHbSlS1mOTkF+M1qT321VoBUgmmofhQJPR2P/j2t33tcj7NjulWcUoukFbP/ryogdPVty5JzoF9HUCkF6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721215; c=relaxed/simple;
	bh=jsVQzkioRSLN2d9kRY421N6xZ4da3YTmA54HIOg25AM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W6suFlkNyD8zLK8ELQbgHEq2zC2sreXXRbIh6o5F5CmM72e/H3GwrPT36cOftoukf8+wrkeLVOz8HMHm6ShgJqrYP34OVNQ+u7sEyqQH5E8247HmVebiVjfYOxHK7BhmNWH0ywcYEQ0itwCIICaT1ptfrarzsCWkFcH4OzgO9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8k7J5qc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8k7J5qc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c860544c077so393992a12.3
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783721210; x=1784326010; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O5+xgnrzOMBdXqacb4txyXlwUxflXxozadFsGyCU5lw=;
        b=I8k7J5qcq6qbXdDfxS3e4qwEgnqhMZG7GXpdShPwhHAxQTCCyO92cBePUebBAgLaXC
         WhzJc5dMf2bEBVjjZL+1EbmZKv7+xvB+lzgGO9nc9X5k54mpBBPvOcFKZBmfOkwgl+8I
         ZfAkBXKNzvwg30YOfGQPv3aokglGW5lohtoyif7Q7Op6KaZjWXnrrLSvAQJ0oRk7H/F/
         6l3icFIjB50ol1zsorYEZKbqsfl8uJ6G/aDNG79o2EPv2bLlfrE04pxSPz7PfsSSlTy6
         7WzCuyP5k+PjPkTZS7NVzMEeCCOeFcuKmUw5Ojh2BaTgffu7HGcDSgNlq0HXHU3ZVrTD
         XrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721210; x=1784326010;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O5+xgnrzOMBdXqacb4txyXlwUxflXxozadFsGyCU5lw=;
        b=lA4NxCxbgKXbeOKzNtRJO0gFhn8amrA992FtYrMI2uVJbw5LXgy+x5MbNZa3amB6Cu
         hGpb0P1d2tkOUMOOJwKJqPQiI3xYEKNJmf93xbGi+MfWBv7nadGfb71+nuIe19OOHDYG
         LUL8UrSsHmPK31TktOoUhyFK2ymXp5hoF42jhVledI4x+zr1rNrEiErxeDx4i/3XJLYU
         BRFGGEq3V/e7D/r5EDv5z8OZrly8n1dH9XXdqtp5BykHAdxODN1J5x0cCnThpQc65ZM+
         Kw7LR3z3snXo0wK4Tka71zoBRczn9++IhcZ2KBv4RnTCLeKqPVmyxdYrbctYi6UsH45o
         QFvg==
X-Forwarded-Encrypted: i=1; AHgh+Roh3R9C5H/BxbSJX3dvcc6wWtZNQbeJdKjAcVjaGk5NPHcUnAQ5h4WwkWIr0OsLc0xgwFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ReqdPrwAUN550MgTKGx4eatlR/c1N0fwOs2ZcFbc75M6Q6xC
	g73Ux0/+MB83b0Vkwf3atfBh89wkmydkEWZ2sGUyI2DFiHuiliZuba44jQE43Agi0Ce3wyZhRjt
	GCEKLpbb2
X-Received: from pghx11.prod.google.com ([2002:a63:f70b:0:b0:c82:7761:9936])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6817:b0:3c0:9c1b:d0ba
 with SMTP id adf61e73a8af0-3c110a12332mr820314637.69.1783721209572; Fri, 10
 Jul 2026 15:06:49 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:06:45 +0000
In-Reply-To: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783721208; l=16242;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=jsVQzkioRSLN2d9kRY421N6xZ4da3YTmA54HIOg25AM=; b=+4ZKpbbOkexXOvJRuPv2c1mN+StKLlAWSj/RcOGgxi0HyniYrcsvEUp4oPa/vdajkWLrjSZk5
 /EbJe3yBfowBBGBStP7LXOY5c3Rf6/edP29iWsZ5GJx++aep/HLHs0S
X-Mailer: b4 0.14.3
Message-ID: <20260710-igb_v3_b4-v4-1-56e7e2576cc1@google.com>
Subject: [PATCH v4 1/9] vfio: selftests: igb: Add driver for IGB QEMU device
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="utf-8"

Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
(IGB). IGB is fully virtualized in QEMU [1] which makes it easy to run
VFIO selftests without needing any specific hardware.

This initial driver only implements the bare minimum configuration
required to run successfully under QEMU's emulated IGB device, and does
not support physical hardware. Subsequent patches add support for the
physical device.

IGB does not have a default memcpy operation, and memcpy is required for
all VFIO selftest drivers. However, IGB has a "loopback" mode which is
used in this driver to implement memcpy. When IGB is in loopback mode,
it doesn't send data out to the network. Instead, it sends data from the
Tx queue directly to the Rx queue which points to the memcpy
destination, instead of sending the data out to the network.

This driver passes all of the VFIO selftests in
tools/testing/selftests/vfio/ when running in QEMU. The driver has not
been tested using a real IGB device since the main goal of writing this
driver is to run VFIO selftests in QEMU without requiring any hardware.

This command is used to test the driver. It runs
./tools/testing/selftests/vfio/vfio_pci_driver_test using virtme-ng [2],
which runs a kernel in a virtualized environment using QEMU that has a
copy-on-write snapshot the host filesystem.

vng \
  --run arch/x86/boot/bzImage \
  --user root \
  --disable-microvm \
  --memory 32G \
  --cpus 8 \
  --qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
  --qemu-opts="-device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on" \
  --qemu-opts="-netdev user,id=net0 -device igb,netdev=net0,addr=09.0" \
  --append "console=ttyS0 earlyprintk=ttyS0 intel_iommu=on iommu=pt" \
  --exec "modprobe vfio-pci && \
          ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 && \
          ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing/selftests/vfio/vfio_pci_driver_test"

Code was written entirely by AI (Gemini) by feeding it the Intel IGB
specification, the code for the real IGB driver, and the QEMU
implementation of the IGB device. It took many iterations of prompting
to get the driver to pass all of the tests, and lot's of de-slopping to
remove unnecessary code and make the code readable.

Code comments are also written by Gemini through iterative
prompting.

This patch is based on the kvm/queue branch.

[1] https://www.qemu.org/docs/master/system/devices/igb.html
[2] https://github.com/arighi/virtme-ng

Assisted-by: Gemini:gemini-3-pro-preview
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
 .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 381 +++++++++++++++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
 6 files changed, 387 insertions(+)

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
index 000000000000..923b2341abad
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -0,0 +1,381 @@
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
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
+	/*
+	 * Must wait at least 1 millisecond after setting the reset bit before
+	 * checking if this device is ready to be used (82576 datasheet section
+	 * 4.2.1.6.1).
+	 */
+	usleep(1000);
+	while (igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST)
+		usleep(10);
+	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
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
+
+	/* Enable Receiver and Transmitter */
+	rctl = E1000_RCTL_EN |       /* Receiver Enable */
+	       E1000_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
+	       E1000_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       E1000_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
+	igb_write32(igb, E1000_RCTL, rctl);
+	igb_write32(igb, E1000_TCTL, E1000_TCTL_EN);
+
+	/* Enable MSI-X with 1 vector for the test */
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
+	igb_write32(igb, E1000_GPIE, E1000_GPIE_EIAME | E1000_GPIE_MSIX_MODE);
+
+	/* Map vector 0 to interrupt cause 0 and mark it valid */
+	igb_write32(igb, E1000_IVAR0, E1000_IVAR_VALID);
+
+	/* Enable interrupts on vector 0 */
+	igb_write32(igb, E1000_EIMS, 1);
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
+	vfio_pci_msix_disable(device);
+	igb_write32(igb, E1000_RCTL, 0);
+	igb_write32(igb, E1000_TCTL, 0);
+	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
+}
+
+static void igb_irq_disable(struct igb *igb)
+{
+	igb_write32(igb, E1000_EIMC, 1);
+}
+
+static void igb_irq_enable(struct igb *igb)
+{
+	igb_write32(igb, E1000_EIMS, 1);
+}
+
+static void igb_irq_clear(struct igb *igb)
+{
+	igb_read32(igb, E1000_EICR);
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
+		tx->read.buffer_addr = cpu_to_le64(src);
+		tx->read.cmd_type_len = cpu_to_le32((u32)size | E1000_TXD_CMD_EOP | E1000_TXD_CMD_IFCS);
+
+		/* Set to 0 to disable offloads and avoid needing a context descriptor */
+		tx->read.olinfo_status = cpu_to_le32(0);
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
+	retries = 100;
+	while (retries-- > 0) {
+		status = le32_to_cpu(READ_ONCE(rx->wb.status_error));
+		if (status & 1)
+			break;
+		usleep(10);
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
+	igb_write32(igb, E1000_EICS, 1);
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
2.55.0.795.g602f6c329a-goog

