Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EC3D6466
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839694; cv=none; b=hDzgcc4rt5rIsc+PMpVBD7zOpta2rLYg33qZnZyIVptJiRUKw4Kvm2SFr1QUoy/rWEp0PQJ69YjmoCHmO7iQFe7iErGts/2a/DkcOcY7uWsUi1OVkyQyAGn58D+uCan6hKR5mbqEgwTIsI0sfmwJUNBgf7gAu/S2LR+yhogRyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839694; c=relaxed/simple;
	bh=R7OyaEPMVCLO+oYDQ7bv5fDKbQeGGDbEGPz4seaEbPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XE6RTSwovxTWEA1/Yt8iAU6IHf7cEx9y2Wip6QIN4dMs/OSaj9KR+K/29eBZjxVmXrjh2yd0YBPMvcQ2lzseR1TQcMHonISZoa64EHsnNSCffuqCrH6ovBz23BFaG0vAnNGbY8CVBrsSpDTU2PgMdQhiZqGvmuaMbColldS068E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hre0pr6B; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hre0pr6B"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c827c880e39so5573486a12.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839677; x=1780444477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hVxPcXbZiJwpKk4fcCvLQsSxUJIXIfM5bkmphmygsM8=;
        b=hre0pr6Bxvtr8c56XICTdElZ4fRMc2/6MOnaKbLnoIVasvXvX0cuYPCKDxC24xUmKr
         zzwwPisiC0/hR6I4ox7ln8y5/8Gi+JKuP4SzFimtjX66a5719TV3wYD73L4WIZT+ipOp
         Jm+Hcq5KQrDX0RCa9y6Bi8aqgMxQs/eXpzokevKdNV6vylliVq6noUSvg8Wfan6i79zO
         H52vZbLhPshOWtQZzXwyhiIWMhLoQ0Icfxzy0w5KLrdIJjauTdEnKKEflM0fZT9w7Deo
         blxM/afRrvWWo6VZerTSqBEcrn2leRMHH0AdtRp1vk/wl7U/mLBd8DhvqG+qUuru03fa
         4GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839677; x=1780444477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVxPcXbZiJwpKk4fcCvLQsSxUJIXIfM5bkmphmygsM8=;
        b=VpCmJM078HQjfkOHU7z3zKtXgXty6FsxQ5dLYzixswm4BTqwHMrtR1eixZcuAvH34z
         635xE9K/kplz0CIthE6wErCknU8FZbT6H13k2hGGFmE2kLmZ13+nKgSmuVntcTumT9mA
         KyDmtEmmWm5m/oj4ze0rejNdr+k8FDODPjm1bLbFD2HnwRjN8mzhxHItcxX1dLaI02Ni
         sCkKgqiAs7Gs7k42ugrJblqtu5gP4S32xA+IzxI8bTuxLTHUBlmMaBXaSAqE2KcwD2uq
         EeVmN+9+kCyiyKz86t5Wjxdq/4TQxh6mzwiWqO74GV3a2OEwzLOjWS3TXMxv1lpqS/l7
         +3cA==
X-Forwarded-Encrypted: i=1; AFNElJ9uuPKvViN0CwLNvtmgecqQ7DCKCQlyWOfsYUsZvhtpOs2xxkfvq0QhCCmFb3R/KisSgXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4L/j/j7JH41nzkxrNYnKQXqxjhc/uc1bdfdaK1XZkYB9Zptu
	jv0t0GZdL08FeiW1AVd/dF1WUYlfTwAieBJkEQxG8nUtbjqM+QpJRlBlfxbsXHRGhlmtRHBowzQ
	sSj73cFXb
X-Received: from pfoa26.prod.google.com ([2002:aa7:865a:0:b0:83f:2c4a:9b48])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:349b:b0:82f:61f5:1d7
 with SMTP id d2e1a72fcca58-8415f5a6432mr20108393b3a.25.1779839676880; Tue, 26
 May 2026 16:54:36 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:08 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-2-jrhilke@google.com>
Subject: [PATCH v2 01/10] selftests/vfio: igb: Add driver for IGB QEMU device
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a VFIO selftest driver for the Intel Gigabit Ethernet controller
(IGB). IGB is fully virtualized in QEMU [1] which makes it easy to run
VFIO selftests without needing any specific hardware.

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
 .../selftests/vfio/lib/drivers/igb/igb.c      | 360 ++++++++++++++++++
 .../vfio/lib/drivers/igb/registers.h          | 103 +++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
 4 files changed, 466 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/igb.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/igb/registers.h

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
new file mode 100644
index 000000000000..064ca7c05da0
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <unistd.h>
+#include <errno.h>
+#include <stdint.h>
+#include <linux/io.h>
+#include <linux/pci_regs.h>
+#include <linux/pci_ids.h>
+#include <libvfio/vfio_pci_device.h>
+
+#include "registers.h"
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
+	mdic = (((u32)data) |
+		(offset << IGB_MDIC_REG_SHIFT) |
+		(1 << IGB_MDIC_PHY_SHIFT) |
+		IGB_MDIC_OP_WRITE);
+
+	igb_write32(igb, IGB_MDIC, mdic);
+
+	for (i = 0; i < 1000; i++) {
+		usleep(50);
+		mdic = igb_read32(igb, IGB_MDIC);
+		if (mdic & IGB_MDIC_READY)
+			break;
+	}
+
+	if (!(mdic & IGB_MDIC_READY))
+		return -1;
+
+	if (mdic & IGB_MDIC_ERROR)
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
+	mdic = ((offset << IGB_MDIC_REG_SHIFT) |
+		(1 << IGB_MDIC_PHY_SHIFT) |
+		IGB_MDIC_OP_READ);
+
+	igb_write32(igb, IGB_MDIC, mdic);
+
+	for (i = 0; i < 1000; i++) {
+		usleep(50);
+		mdic = igb_read32(igb, IGB_MDIC);
+		if (mdic & IGB_MDIC_READY)
+			break;
+	}
+
+	if (!(mdic & IGB_MDIC_READY))
+		return -1;
+
+	if (mdic & IGB_MDIC_ERROR)
+		return -1;
+
+	*data = (u16)mdic;
+	return 0;
+}
+
+static int igb_phy_setup_autoneg(struct igb *igb)
+{
+	int timeout_ms = 1000;
+	bool success = false;
+	u16 phy_status;
+	int ret;
+	int i;
+
+	/* Trigger auto-negotiation */
+	ret = igb_write_phy(igb, IGB_PHY_CTRL_REG_OFFSET,
+			    IGB_PHY_CTRL_AN_ENABLE | IGB_PHY_CTRL_RESTART_AN);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < timeout_ms; i++) {
+		if (igb_read_phy(igb, IGB_PHY_STATUS_REG_OFFSET, &phy_status) == 0) {
+			success = !!(phy_status & IGB_PHY_STATUS_AN_COMP);
+			if (success)
+				break;
+		}
+		usleep(1000);
+	}
+
+	if (!success) {
+		printf("igb: Auto-negotiation did not complete in time\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
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
+	/* Reset device and disable all interrupts */
+	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+	usleep(20000);
+	igb_write32(igb, IGB_IMC, 0xFFFFFFFF);
+
+	/* Signal that the driver is loaded */
+	ctrl = igb_read32(igb, IGB_CTRL_EXT);
+	ctrl |= IGB_CTRL_EXT_DRV_LOAD;
+	ctrl &= ~IGB_CTRL_EXT_LINK_MODE_MASK;
+	igb_write32(igb, IGB_CTRL_EXT, ctrl);
+
+	/* Enable PCI Bus Master. */
+	cmd_reg = vfio_pci_config_readw(device, PCI_COMMAND);
+	if (!(cmd_reg & PCI_COMMAND_MASTER)) {
+		cmd_reg |= (PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
+		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
+	}
+
+	/* Trigger autonegotiation. This enables IGB to transmit data. */
+	if (igb_phy_setup_autoneg(igb))
+		return;
+
+	/* Configure TX and RX descriptor rings */
+	igb_write32(igb, IGB_TDBAL0, (u32)iova_tx);
+	igb_write32(igb, IGB_TDBAH0, (u32)(iova_tx >> 32));
+	igb_write32(igb, IGB_TDLEN0, RING_SIZE * sizeof(struct igb_tx_desc));
+	igb_write32(igb, IGB_TDH0, 0);
+	igb_write32(igb, IGB_TDT0, 0);
+	igb_write32(igb, IGB_TXDCTL0, IGB_TXDCTL0_Q_EN);
+
+	igb_write32(igb, IGB_RDBAL0, (u32)iova_rx);
+	igb_write32(igb, IGB_RDBAH0, (u32)(iova_rx >> 32));
+	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
+	igb_write32(igb, IGB_RDH0, 0);
+	igb_write32(igb, IGB_RDT0, 0);
+	igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
+
+	/* Wait for TX and RX queues to be enabled */
+	retries = 2000;
+	while (retries-- > 0) {
+		if ((igb_read32(igb, IGB_TXDCTL0) & IGB_TXDCTL0_Q_EN) &&
+		    (igb_read32(igb, IGB_RXDCTL0) & IGB_RXDCTL0_Q_EN))
+			break;
+		usleep(10);
+	}
+
+	/* Enable Receiver and Transmitter */
+	rctl = IGB_RCTL_EN |       /* Receiver Enable */
+	       IGB_RCTL_UPE |      /* Unicast Promiscuous (for dummy MAC) */
+	       IGB_RCTL_LBM_MAC |  /* MAC Loopback Mode */
+	       IGB_RCTL_SECRC;     /* Strip CRC (needed for memcmp) */
+	igb_write32(igb, IGB_RCTL, rctl);
+	igb_write32(igb, IGB_TCTL, IGB_TCTL_EN);
+
+	/* Enable MSI-X with 1 vector for the test */
+	vfio_pci_msix_enable(device, MSIX_VECTOR, 1);
+
+	/* Enable auto-masking of interrupts to avoid storms without a real ISR */
+	igb_write32(igb, IGB_GPIE, IGB_GPIE_EIAME);
+
+	/* Enable interrupts on vector 0 */
+	igb_write32(igb, IGB_EIMS, 1);
+
+	/* Map vector 0 to interrupt cause 0 and mark it valid */
+	igb_write32(igb, IGB_IVAR0, IGB_IVAR_VALID);
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
+
+static void igb_remove(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	vfio_pci_msix_disable(device);
+	igb_write32(igb, IGB_RCTL, 0);
+	igb_write32(igb, IGB_TCTL, 0);
+	igb_write32(igb, IGB_CTRL, igb_read32(igb, IGB_CTRL) | IGB_CTRL_RST);
+}
+
+static void igb_irq_disable(struct igb *igb)
+{
+	igb_write32(igb, IGB_EIMC, 1);
+}
+
+static void igb_irq_enable(struct igb *igb)
+{
+	igb_write32(igb, IGB_EIMS, 1);
+}
+
+static void igb_irq_clear(struct igb *igb)
+{
+	igb_read32(igb, IGB_EICR);
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
+		rx->read.pkt_addr = dst;
+		tx->read.buffer_addr = src;
+		tx->read.cmd_type_len = (u32)size;
+		tx->read.cmd_type_len |= (u32)(IGB_TXD_CMD_EOP) << IGB_TXD_CMD_SHIFT;
+
+		/* Set to 0 to disable offloads and avoid needing a context descriptor */
+		tx->read.olinfo_status = 0;
+
+		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
+		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
+	}
+
+	igb_write32(igb, IGB_RDT0, igb->rx_tail);
+	igb_write32(igb, IGB_TDT0, igb->tx_tail);
+}
+
+static int igb_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+	struct igb_rx_desc *rx;
+	u32 prev_tail;
+	int retries;
+
+	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
+	rx = &igb->rx_ring[prev_tail];
+
+	retries = 100;
+	while (retries-- > 0) {
+		if (rx->wb.status_error & 1)
+			break;
+		usleep(10);
+	}
+
+	igb_irq_clear(igb);
+
+	igb_irq_enable(igb);
+
+	if (rx->wb.status_error & 1)
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static void igb_send_msi(struct vfio_pci_device *device)
+{
+	struct igb *igb = to_igb_state(device);
+
+	igb_write32(igb, IGB_EICS, 1);
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
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
new file mode 100644
index 000000000000..e2756be2e9c0
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _IGB_REGISTERS_H_
+#define _IGB_REGISTERS_H_
+
+/* Register Offsets (Intel 82576EB Datasheet) */
+#define IGB_CTRL 0x00000 /* Device Control */
+#define IGB_STATUS 0x00008 /* Device Status */
+#define IGB_CTRL_EXT 0x00018 /* Extended Device Control */
+#define IGB_MDIC 0x00020 /* MDI Control */
+#define IGB_RCTL 0x00100 /* Receive Control */
+#define IGB_TCTL 0x00400 /* Transmit Control */
+#define IGB_SCTL 0x00420 /* SerDes Control */
+
+/* Interrupt Registers */
+#define IGB_IMC 0x0150C /* Interrupt Mask Clear */
+#define IGB_IVAR0 0x01700 /* Interrupt Vector Allocation Register 0 */
+
+/* Rx Ring 0 Registers */
+#define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
+#define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
+#define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
+#define IGB_RDH0 0x0C010 /* Rx Desc Head */
+#define IGB_RDT0 0x0C018 /* Rx Desc Tail */
+#define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
+
+/* Tx Ring 0 Registers */
+#define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
+#define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
+#define IGB_TDLEN0 0x0E008 /* Tx Desc Length */
+#define IGB_TDH0 0x0E010 /* Tx Desc Head */
+#define IGB_TDT0 0x0E018 /* Tx Desc Tail */
+#define IGB_TXDCTL0 0x0E028 /* Tx Desc Control */
+
+/* Control Bit Definitions */
+/* CTRL */
+#define IGB_CTRL_RST (1 << 26) /* Device Reset */
+#define IGB_CTRL_EXT_LINK_MODE_MASK (3 << 22)
+
+/* CTRL_EXT */
+#define IGB_CTRL_EXT_DRV_LOAD (1 << 28) /* Driver Loaded */
+
+/* RCTL */
+#define IGB_RCTL_EN (1 << 1) /* Receiver Enable */
+#define IGB_RCTL_UPE (1 << 3) /* Unicast Promiscuous Enabled */
+#define IGB_RCTL_LPE (1 << 5) /* Long Packet Reception Enable */
+#define IGB_RCTL_LBM_MAC (1 << 6) /* Loopback Mode - MAC */
+#define IGB_RCTL_SECRC (1 << 26) /* Strip Ethernet CRC */
+
+/* TCTL */
+#define IGB_TCTL_EN (1 << 1) /* Transmit Enable */
+
+/* SCTL */
+#define IGB_SCTL_DISABLE_SERDES_LOOPBACK (1 << 6)
+
+/* MDIC */
+#define IGB_MDIC_OP_WRITE (1 << 26)
+#define IGB_MDIC_OP_READ  (2 << 26)
+
+#define IGB_EICR 0x01580 /* Extended Interrupt Cause Read */
+
+#define IGB_RAH0 0x05404 /* Receive Address High 0 */
+#define IGB_VMOLR0 0x05AD0 /* VM Offload Layout Register 0 */
+
+#define IGB_VMOLR_LPE 0x00010000 /* Long Packet Enable */
+#define IGB_VMOLR_BAM 0x08000000 /* Broadcast Accept Mode */
+#define IGB_RAH_POOL_1 0x00040000 /* Pool 1 assignment */
+
+#define IGB_EIMS 0x01524 /* Extended Interrupt Mask Set */
+#define IGB_EICS 0x01520 /* Extended Interrupt Cause Set */
+#define IGB_EIMC 0x01528 /* Extended Interrupt Mask Clear */
+#define IGB_CTRL_GIO_MASTER_DISABLE (1 << 2) /* GIO Master Disable */
+#define IGB_STATUS_GIO_MASTER_ENABLE (1 << 19) /* GIO Master Enable */
+#define IGB_GPIE 0x01514 /* General Purpose Interrupt Enable */
+#define IGB_TXDCTL0_Q_EN (1 << 25) /* Transmit Queue Enable */
+#define IGB_RXDCTL0_Q_EN (1 << 25) /* Receive Queue Enable */
+#define IGB_MRQC 0x05818 /* Multiple Receive Queues Command */
+
+#define IGB_MDIC_PHY_SHIFT 21 /* PHY Address Shift */
+#define IGB_MDIC_REG_SHIFT 16 /* Register Address Shift */
+#define IGB_MDIC_READY (1 << 28) /* MDI Data Ready */
+#define IGB_MDIC_ERROR (1 << 29) /* MDI Error */
+
+#define IGB_PHY_CTRL_REG_OFFSET 0
+#define IGB_PHY_STATUS_REG_OFFSET 1
+#define IGB_PHY_STATUS_AN_COMP 0x0020 /* Auto-negotiation complete */
+#define IGB_PHY_CTRL_AN_ENABLE 0x1000 /* Auto-Negotiation Enable */
+#define IGB_PHY_CTRL_RESTART_AN 0x0200 /* Restart Auto-Negotiation */
+
+#define IGB_PHY_AUTONEG_ADV_REG_OFFSET 4 /* Auto-Negotiation Advertisement */
+#define IGB_PHY_1000T_CTRL_REG_OFFSET 9 /* 1000Base-T Control */
+#define IGB_CR_1000T_FD_CAPS 0x0200 /* Advertise 1000 Mbps Full Duplex */
+
+#define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
+#define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
+
+#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
+#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
+#define IGB_TXD_CMD_RS 0x08 /* Report Status */
+#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_len */
+#define IGB_TXD_CMD_LEGACY_FORMAT (1 << 20) /* Forces legacy descriptor format in QEMU */
+
+#endif /* _IGB_REGISTERS_H_ */
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
2.54.0.794.g4f17f83d09-goog

