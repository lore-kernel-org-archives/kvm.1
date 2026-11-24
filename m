Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486097;
	b=g2rJmop6EsHYbVcTU420ouhGJqQNiagYT0MQF8lWunfBCufNiC31+G12AUms+U+YUS5H
	 qeZ76Vlw4W0Kz5q5J5GJGV8T4hv2oHAJUNSTZPBfhu7kCWaRYy9lAFm+RdfpqdLdtledH
	 RXmernlJiCAy4rtNWQBNizIk8eZ6RdZ/boZBh49tOZXJx3yJLmiNAZ5dSq/CsAme7d3Hj
	 MsyLqbZvMkzTcjlZYLQ/Sroty6Gjvvzy3ClXJli9zXEHjSSJ+rhc5sfkZgCJ5caIIoWnR
	 0MExqyvupu3ZRWthXY+5G0XzQ2G9sEhYUaLLYAsTZWc5rb0WOdRQtebw+w3eG9xWB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486097;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=NchLoveV8GAmEVcdvt/HbGTy1HBhpZqGtds5PtZR8P4=;
	b=c+kAy8xkuTwcTs1pRkq5kFhmPmO4+koekMX6SsDqVVL20cGraheBDzsQBB1oN+3/xoTY
	 vmpoOzlxHzqmoNpGP2VHUVBT6PZLnSLKhCV+OdBVPMrxWRHObSPThAVTb9oi/qcZ5/Di8
	 fQw/oyr5/CWSkKgPM+Y3JirwERn8sed2T55c4T4SIp231wFz1SJrMzeCDLpU1htBmiuOi
	 YRIgRXzWFObYftK/fZAhhQiKHB+iwm6XTDmZ8ac97kYeJtsE6rWiCe1ebIBSjoCa0gQpV
	 d8G+IQREHQnP0/lBjNScljccsEKJPbWWCclvf7IWeVpmJ/3r/P3pdS/4O4Zn6+7skfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aF8rVkBE;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E8606A322
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 02:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 834E8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aF8rVkBE
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8bfe396acb4so2661159b3a.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 18:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795486096; x=1796090896; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NchLoveV8GAmEVcdvt/HbGTy1HBhpZqGtds5PtZR8P4=;
        b=aF8rVkBEsLL/S2vc1JQUsQZCtHz2f7i5dsPRbLIJeReolLMMHSXUmuRr2PB3kSLaoT
         sYU8EBF29IyThtUbCKfQ7ZFC407yKUih/Jd3whX/F+Yir4YZxC9Y8rfB4rWclfEJVCUf
         e5cHK8scbIGfHYQSnxoIYuwmznchUhf+u0fmKYCiZWK1Rv18w1ZnpeidfeK5m6pe+IwL
         mlwfCRckXsUsSlHmQP5w/R2OYv6nes3PqKkvNQxVRzw1RJM/GP32FtwvGH8ibrTFn9bJ
         IjMjoUQAlIwZqlYf5oBjQQO7CNUPTFaDxRp3dBH0rASBvyrJfj2OT9kh867rSt6HH49H
         ZCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486096; x=1796090896;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NchLoveV8GAmEVcdvt/HbGTy1HBhpZqGtds5PtZR8P4=;
        b=1Zf147JuTfLfEwsXll9gri0JF9wec26hoOZG1SBGTwyKaXwyrZVurC5ZYo8zEWBhim
         sj5GQocUvvdceaN0zILWSe4fwYX8iOuhwdWfnZLSSyZ3k1gRAMdSGZkBc8PU5XCnxPp5
         JhhQ6aZkKw23X+BSmcbGjtALW90LC8HjFU2J3We87zQj8+YSOcYbj3P65IgfLqZ6GqQv
         64n5K6TATicH6ElUsc+pE7YkGEYqyGKTDg/1TZyZqWeJno4zVxvBf8xKSzyMtSrz3qq2
         S6qnp4Ls+YFlq8qkXisBnvSduFUdMjpQFu0jPVa4leTXdxBdeZB1iEDsz5kPQWw2HOvY
         66Hw==
X-Gm-Message-State: APuU4Z8+lf8X/4SWuD8i758lMpwejgjMdvLCTEzoWtBbpY36saAr8XaE
	0mHeiAncebrvNVjVqvL+AhiDHv3PtJFVaGLVg5fi5+/HtClK7u4NNfrePddCokTJZN0EUuunu0u
	Aa4PZtjp3
X-Received: from pggo21-n1.prod.google.com ([2002:a05:6a02:8295:10b0:cdd:9f2e:53df])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1014:b0:3e2:729c:9bcb
 with SMTP id adf61e73a8af0-4014ed47ab8mr13500344637.65.1795486095299; Mon, 23
 Nov 2026 18:08:15 -0800 (PST)
Date: Tue, 24 Nov 2026 02:08:14 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124020814.1679635-1-jrhilke@google.com>
Subject: [PATCH] vfio: selftests: Add NVMe driver
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a VFIO selftest driver for NVMe controllers. It binds to any PCI
function with the NVMe PCI class code 01:08:02, so vfio_pci_driver_test
can run on the NVMe SSDs that are common in servers, and on the nvme
device that QEMU emulates.

NVMe has no memory-to-memory copy command, so the driver implements a
memcpy through the logical blocks at the start of the first active
namespace. memcpy_start() writes @src to the logical blocks from LBA 0,
waits for the write, and then queues @count reads of the same blocks into
@dst. The driver must wait for the write because the controller can run
the commands of a queue in any order. All @count reads are in flight when
memcpy_start() returns. The driver spreads the reads over up to 16 such
queues, because one queue holds only as many commands as the controller
allows, 2047 on the QEMU device. The memcpy commands go on I/O queues
that have interrupts disabled. send_msi() sends a flush on one more I/O
queue that has interrupts enabled.

The driver overwrites the first max_memcpy_size bytes of the namespace.
Do not use a device that holds data you want to keep.

On some controllers, a DMA error from the unmapped-IOVA tests leaves the
submission queue in an error state that only a Function Level Reset
clears. After a failed memcpy, the driver disables the controller, resets
the function with VFIO_DEVICE_RESET, and initializes the controller
again.

The driver needs a controller that supports the NVM command set, 4 KiB
memory pages, at least two I/O queue pairs, and MSI-X, along with
a namespace that has no metadata and a logical block size of at most 4 KiB.
Controllers that need one of the quirks in drivers/nvme/host/pci.c are
not supported.

The driver uses the definitions in include/linux/nvme.h through a
symbolic link, like the other drivers do with their kernel headers.

Users can verify the driver in QEMU with these commands, after they
build the kernel and the VFIO selftests:

truncate -s 64M /tmp/nvme.img
vng \
--run arch/x86/boot/bzImage \
--user root \
--disable-microvm \
--memory 4G \
--cpus 4 \
--qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
--qemu-opts="-device intel-iommu,intremap=on,caching-mode=on" \
--qemu-opts="-drive file=/tmp/nvme.img,if=none,id=nvm,format=raw" \
--qemu-opts="-device nvme,serial=deadbeef,drive=nvm,addr=10.0" \
--append "console=ttyS0 intel_iommu=on" \
--exec "modprobe vfio-pci && \
  ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:10.0 && \
  ./tools/testing/selftests/vfio/scripts/run.sh \
  ./tools/testing/selftests/vfio/vfio_pci_driver_test"

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Testing:
- Built VFIO and KVM selftests on x86_64 (dynamic and static) and VFIO selftests on arm64 (static).
- QEMU nvme (x86_64): vfio_pci_driver_test 35/35 passed (default and nsid=2); msix_qsize=1 and max_ioqpairs=1 failed at their expected assertions.
- Samsung PM175x VF (x86_64): vfio_pci_device_test 5/5, vfio_pci_driver_test 35/35, and KVM irq_test passed.
- Samsung PM174X VF (arm64): vfio_pci_device_test 5/5 and vfio_pci_driver_test 35/35 passed.

 Documentation/driver-api/vfio-selftests.rst   |   4 +
 .../selftests/vfio/lib/drivers/nvme/nvme.c    | 745 ++++++++++++++++++
 .../selftests/vfio/lib/drivers/nvme/nvme.h    |   1 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 .../selftests/vfio/lib/vfio_pci_driver.c      |   2 +
 5 files changed, 753 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/nvme/nvme.h

diff --git a/Documentation/driver-api/vfio-selftests.rst b/Documentation/driver-api/vfio-selftests.rst
index 9d39a22519d6..b26040c48d5d 100644
--- a/Documentation/driver-api/vfio-selftests.rst
+++ b/Documentation/driver-api/vfio-selftests.rst
@@ -39,10 +39,14 @@ includes driver support for the following devices:
 - Intel IOAT (I/O Acceleration Technology) DMA engines
 - Intel DSA (Data Streaming Accelerator)
 - NVIDIA Falcon engines (found in many NVIDIA GPUs, e.g., GTX 1080 or RTX 2080)
+- NVMe controllers
 
 Note that using Intel DSA devices requires setting the module parameter
 ``vfio_pci.disable_denylist=Y`` to allow ``vfio-pci`` to bind to DSA devices.
 
+Note that the NVMe driver overwrites the start of the first active namespace.
+Do not use an NVMe device that holds data you want to keep.
+
 Setting up Devices
 ------------------
 
diff --git a/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c b/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c
new file mode 100644
index 000000000000..6f82e0ddf309
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.c
@@ -0,0 +1,745 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <asm/barrier.h>
+#include <linux/align.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/pci_ids.h>
+#include <linux/pci_regs.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#include <libvfio.h>
+
+/* nvme.h needs uuid_t from libuuid and struct_group(). */
+#include <uuid/uuid.h>
+
+#ifndef struct_group
+#define struct_group(NAME, MEMBERS...)	\
+	__struct_group(/* no tag */, NAME, /* no attrs */, MEMBERS)
+#endif
+
+#include "nvme.h"
+
+#define NVME_ADMIN_QID			0
+#define NVME_MSI_QID			1
+#define NVME_MAX_POLL_QUEUES		16
+#define NVME_IO_MSIX_VEC		1
+#define NVME_ADMIN_QUEUE_DEPTH		64
+
+/* A queue of depth N holds N - 1 commands. msiq has one in flight. */
+#define NVME_MSI_QUEUE_DEPTH		2
+
+/*
+ * Ring entries for all polled queues together. This bounds max_memcpy_count so
+ * tests that churn through many memcpys, such as memcpy_storm, finish within
+ * their timeouts on slow controllers.
+ */
+#define NVME_POLL_TOTAL_ENTRIES		8192
+
+/* Rings for the polled queues, plus page alignment of each ring. */
+#define NVME_POLL_RINGS_SIZE		(NVME_POLL_TOTAL_ENTRIES *		\
+					 (sizeof(struct nvme_command) +		\
+					  sizeof(struct nvme_completion)) +	\
+					 NVME_MAX_POLL_QUEUES * 2 * SZ_4K)
+
+#define NVME_PRP_LIST_ENTRIES		(SZ_4K / sizeof(__le64))
+
+/* The driver builds one PRP list page, which covers 2 MiB at any offset. */
+#define NVME_MAX_XFER_SIZE		SZ_2M
+#define NVME_MIN_LBA_SHIFT		9
+#define NVME_MAX_LBA_SHIFT		12
+#define NVME_TIMEOUT_MS			5000ULL
+#define NVME_CAP_TIMEOUT_UNIT_MS	500ULL
+#define NVME_POLL_INTERVAL_US		1000
+
+struct nvme_queue {
+	/* Byte offsets of the submission and completion rings in the region. */
+	u64 sq_offset;
+	u64 cq_offset;
+
+	/* Number of entries in each ring. */
+	u32 depth;
+
+	/* Commands submitted whose completions are not yet consumed. */
+	u32 inflight;
+
+	/* Queue identifier, which also selects the doorbell registers. */
+	u16 qid;
+
+	u16 sq_tail;
+	u16 cq_head;
+
+	/* Expected phase tag of the next completion entry. */
+	u16 cq_phase;
+};
+
+struct nvme_state {
+	struct nvme_queue adminq;
+	/*
+	 * I/O queue whose completions raise device->driver.msi. It carries
+	 * only the flush command of nvme_send_msi().
+	 */
+	struct nvme_queue msiq;
+	/*
+	 * I/O queues whose completions raise no interrupt. They carry all
+	 * memcpy commands. Their rings start at poll_rings.
+	 */
+	struct nvme_queue pollq[NVME_MAX_POLL_QUEUES];
+	u32 nr_pollqs;
+
+	/* Doorbell register stride in bytes, derived from CAP.DSTRD. */
+	u32 db_stride;
+
+	/* The namespace that the memcpy commands use. */
+	u32 nsid;
+
+	/* Power-of-two shift for converting bytes to logical blocks. */
+	u32 lba_shift;
+
+	/* Result of the write in nvme_memcpy_start(). */
+	int memcpy_err;
+
+	/* DMA buffers addressed by the byte offsets held in adminq and msiq. */
+	struct nvme_command admin_sq[NVME_ADMIN_QUEUE_DEPTH] __aligned(SZ_4K);
+	struct nvme_completion admin_cq[NVME_ADMIN_QUEUE_DEPTH] __aligned(SZ_4K);
+	struct nvme_command msi_sq[NVME_MSI_QUEUE_DEPTH] __aligned(SZ_4K);
+	struct nvme_completion msi_cq[NVME_MSI_QUEUE_DEPTH] __aligned(SZ_4K);
+
+	/* Identify data, written by the device. */
+	struct nvme_id_ctrl id_ctrl __aligned(SZ_4K);
+	struct nvme_id_ns id_ns __aligned(SZ_4K);
+	__le32 ns_list[NVME_IDENTIFY_DATA_SIZE / sizeof(__le32)] __aligned(SZ_4K);
+	/*
+	 * PRP lists for @src and @dst of the current memcpy. Every command of a
+	 * memcpy uses the same two buffers, so the queued commands share them.
+	 */
+	__le64 prp_src[NVME_PRP_LIST_ENTRIES] __aligned(SZ_4K);
+	__le64 prp_dst[NVME_PRP_LIST_ENTRIES] __aligned(SZ_4K);
+	u8 poll_rings[] __aligned(SZ_4K);
+};
+
+static inline struct nvme_state *to_nvme_state(struct vfio_pci_device *device)
+{
+	return device->driver.region.vaddr;
+}
+
+static inline struct nvme_command *nvme_sq(struct vfio_pci_device *device,
+					   struct nvme_queue *q)
+{
+	return device->driver.region.vaddr + q->sq_offset;
+}
+
+static inline struct nvme_completion *nvme_cq(struct vfio_pci_device *device,
+					      struct nvme_queue *q)
+{
+	return device->driver.region.vaddr + q->cq_offset;
+}
+
+/* Offset of the SQ tail doorbell of @qid, or the CQ head doorbell if @cq. */
+static u64 nvme_db_offset(struct nvme_state *state, u16 qid, bool cq)
+{
+	return NVME_REG_DBS + (2 * qid + cq) * state->db_stride;
+}
+
+static void nvme_ring_sq_db(struct vfio_pci_device *device,
+			    struct nvme_queue *q)
+{
+	struct nvme_state *state = to_nvme_state(device);
+
+	/* Make the commands visible to the device before the doorbell. */
+	dma_wmb();
+	writel(q->sq_tail,
+	       device->bars[0].vaddr + nvme_db_offset(state, q->qid, false));
+}
+
+static void nvme_ring_cq_db(struct vfio_pci_device *device,
+			    struct nvme_queue *q)
+{
+	struct nvme_state *state = to_nvme_state(device);
+
+	/* Finish reading the completion before releasing the slot. */
+	dma_rmb();
+	writel(q->cq_head,
+	       device->bars[0].vaddr + nvme_db_offset(state, q->qid, true));
+}
+
+static void nvme_queue_init(struct vfio_pci_device *device,
+			    struct nvme_queue *q, u16 qid, u32 depth,
+			    u64 sq_offset, u64 cq_offset)
+{
+	q->sq_offset = sq_offset;
+	q->cq_offset = cq_offset;
+	q->depth = depth;
+	q->inflight = 0;
+	q->qid = qid;
+	q->sq_tail = 0;
+	q->cq_head = 0;
+	q->cq_phase = 1;
+
+	memset(nvme_sq(device, q), 0, depth * sizeof(struct nvme_command));
+	memset(nvme_cq(device, q), 0, depth * sizeof(struct nvme_completion));
+}
+
+static void nvme_sq_push(struct vfio_pci_device *device, struct nvme_queue *q,
+			 const struct nvme_command *cmd)
+{
+	struct nvme_command *sq = nvme_sq(device, q);
+
+	memcpy(&sq[q->sq_tail], cmd, sizeof(*cmd));
+	sq[q->sq_tail].common.command_id = q->sq_tail;
+	q->sq_tail = (q->sq_tail + 1) % q->depth;
+	q->inflight++;
+}
+
+static void nvme_sq_submit(struct vfio_pci_device *device, struct nvme_queue *q,
+			   const struct nvme_command *cmd)
+{
+	nvme_sq_push(device, q, cmd);
+	nvme_ring_sq_db(device, q);
+}
+
+/* Consume the next completion on @q if the device has posted it. */
+static bool nvme_cq_consume(struct vfio_pci_device *device, struct nvme_queue *q,
+			    struct nvme_completion *cqe)
+{
+	struct nvme_completion *entry = &nvme_cq(device, q)[q->cq_head];
+
+	if ((le16_to_cpu(READ_ONCE(entry->status)) & 1) != q->cq_phase)
+		return false;
+
+	/* Do not read the completion before the phase tag is observed. */
+	dma_rmb();
+	memcpy(cqe, entry, sizeof(*cqe));
+
+	/* The controller inverts the phase tag on each pass through the ring. */
+	q->cq_head = (q->cq_head + 1) % q->depth;
+	if (q->cq_head == 0)
+		q->cq_phase ^= 1;
+	q->inflight--;
+
+	return true;
+}
+
+static int nvme_cq_wait(struct vfio_pci_device *device, struct nvme_queue *q,
+			struct nvme_completion *cqe)
+{
+	int timeout_ms = NVME_TIMEOUT_MS;
+
+	while (!nvme_cq_consume(device, q, cqe)) {
+		if (timeout_ms-- == 0)
+			return -ETIMEDOUT;
+		usleep(NVME_POLL_INTERVAL_US);
+	}
+
+	nvme_ring_cq_db(device, q);
+
+	return 0;
+}
+
+/* Return the Status Code Type and Status Code of @cqe. */
+static u16 nvme_status(const struct nvme_completion *cqe)
+{
+	return (le16_to_cpu(cqe->status) >> 1) & NVME_SCT_SC_MASK;
+}
+
+/*
+ * The driver overwrites the first max_memcpy_size bytes of the namespace. Do
+ * not use a device that holds data you want to keep.
+ */
+static int nvme_probe(struct vfio_pci_device *device)
+{
+	u32 class_code;
+
+	class_code = vfio_pci_config_readl(device, PCI_CLASS_REVISION) >> 8;
+
+	return class_code == PCI_CLASS_STORAGE_EXPRESS ? 0 : -EINVAL;
+}
+
+static u32 nvme_submit_admin_cmd(struct vfio_pci_device *device,
+				 struct nvme_command *cmd)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	struct nvme_completion cqe = {};
+	int ret;
+
+	nvme_sq_submit(device, &state->adminq, cmd);
+	ret = nvme_cq_wait(device, &state->adminq, &cqe);
+	VFIO_ASSERT_EQ(ret, 0, "Admin command 0x%x timed out",
+		       cmd->common.opcode);
+	VFIO_ASSERT_EQ(nvme_status(&cqe), 0,
+		       "Admin command 0x%x failed with status 0x%x",
+		       cmd->common.opcode, nvme_status(&cqe));
+
+	return le32_to_cpu(cqe.result.u32);
+}
+
+/* Return the number of I/O queue pairs that the controller allocated. */
+static u32 nvme_set_num_queues(struct vfio_pci_device *device, u16 nr_queues)
+{
+	struct nvme_command cmd = {};
+	u32 nr_sqs, nr_cqs;
+	u32 result;
+
+	cmd.features.opcode = nvme_admin_set_features;
+	cmd.features.fid = cpu_to_le32(NVME_FEAT_NUM_QUEUES);
+	cmd.features.dword11 = cpu_to_le32((u32)(nr_queues - 1) << 16 |
+					   (nr_queues - 1));
+
+	/* Dword 0 holds zero-based counts: SQs in bits 15:0, CQs in bits 31:16. */
+	result = nvme_submit_admin_cmd(device, &cmd);
+	nr_sqs = (result & 0xffff) + 1;
+	nr_cqs = (result >> 16) + 1;
+
+	/* A queue pair needs one SQ and one CQ. */
+	return min(nr_sqs, nr_cqs);
+}
+
+static void nvme_identify(struct vfio_pci_device *device, u32 nsid, u8 cns,
+			  void *buf)
+{
+	struct nvme_command cmd = {};
+
+	cmd.identify.opcode = nvme_admin_identify;
+	cmd.identify.nsid = cpu_to_le32(nsid);
+	cmd.identify.dptr.prp1 = cpu_to_le64(to_iova(device, buf));
+	cmd.identify.cns = cns;
+
+	nvme_submit_admin_cmd(device, &cmd);
+}
+
+static void nvme_enable_irqs(struct vfio_pci_device *device)
+{
+	/*
+	 * Admin completions always use vector 0. Require at least two MSI-X
+	 * vectors so I/O completions use vector 1 and admin commands never
+	 * signal the eventfd that the tests check.
+	 */
+	VFIO_ASSERT_GE(device->msix_info.count, 2,
+		       "Device must support at least 2 MSI-X vectors");
+
+	device->driver.msi = NVME_IO_MSIX_VEC;
+	vfio_pci_msix_enable(device, 0, NVME_IO_MSIX_VEC + 1);
+}
+
+/*
+ * Poll CSTS.RDY until it equals @rdy. The controller sets RDY after CC.EN
+ * changes from 0 to 1, and clears it after CC.EN changes from 1 to 0. Wait for
+ * the CAP.TO worst case in 500 ms units, and at least 5 seconds.
+ */
+static int nvme_wait_rdy(struct vfio_pci_device *device, bool rdy)
+{
+	void *bar0 = device->bars[0].vaddr;
+	int timeout_ms;
+	u32 csts;
+	u64 cap;
+
+	cap = readq(bar0 + NVME_REG_CAP);
+	timeout_ms = max(NVME_TIMEOUT_MS,
+			 NVME_CAP_TIMEOUT(cap) * NVME_CAP_TIMEOUT_UNIT_MS);
+
+	for (;;) {
+		csts = readl(bar0 + NVME_REG_CSTS);
+		/* A function that does not respond returns all ones. */
+		if (csts == ~0U)
+			return -ENODEV;
+		if (rdy && (csts & NVME_CSTS_CFS))
+			return -EIO;
+		if (!!(csts & NVME_CSTS_RDY) == rdy)
+			return 0;
+		if (timeout_ms-- == 0)
+			return -ETIMEDOUT;
+		usleep(NVME_POLL_INTERVAL_US);
+	}
+}
+
+static int nvme_disable_ctrl(struct vfio_pci_device *device)
+{
+	void *bar0 = device->bars[0].vaddr;
+	u32 cc;
+
+	cc = readl(bar0 + NVME_REG_CC);
+	if (cc & NVME_CC_ENABLE)
+		writel(cc & ~NVME_CC_ENABLE, bar0 + NVME_REG_CC);
+
+	return nvme_wait_rdy(device, false);
+}
+
+static void nvme_enable_ctrl(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	void *bar0 = device->bars[0].vaddr;
+	u32 aqa, cc;
+	u64 cap;
+	int ret;
+
+	VFIO_ASSERT_NOT_NULL(bar0);
+
+	vfio_pci_cmd_set(device, PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
+			 PCI_COMMAND_INTX_DISABLE);
+
+	ret = nvme_disable_ctrl(device);
+	VFIO_ASSERT_EQ(ret, 0, "Controller did not disable (CSTS 0x%x)",
+		       readl(bar0 + NVME_REG_CSTS));
+
+	cap = readq(bar0 + NVME_REG_CAP);
+	VFIO_ASSERT_TRUE(NVME_CAP_CSS(cap) & NVME_CAP_CSS_NVM,
+			 "Controller does not support the NVM command set");
+	VFIO_ASSERT_EQ(NVME_CAP_MPSMIN(cap), 0,
+		       "Controller does not support 4 KiB memory pages");
+	state->db_stride = 4 << NVME_CAP_STRIDE(cap);
+
+	nvme_queue_init(device, &state->adminq, NVME_ADMIN_QID,
+			NVME_ADMIN_QUEUE_DEPTH,
+			offsetof(struct nvme_state, admin_sq),
+			offsetof(struct nvme_state, admin_cq));
+	nvme_queue_init(device, &state->msiq, NVME_MSI_QID, NVME_MSI_QUEUE_DEPTH,
+			offsetof(struct nvme_state, msi_sq),
+			offsetof(struct nvme_state, msi_cq));
+
+	/*
+	 * No command creates the admin queue. Its depth and ring addresses go
+	 * into controller registers instead.
+	 */
+	aqa = (NVME_ADMIN_QUEUE_DEPTH - 1) << 16 | (NVME_ADMIN_QUEUE_DEPTH - 1);
+	writel(aqa, bar0 + NVME_REG_AQA);
+	writeq(to_iova(device, state->admin_sq), bar0 + NVME_REG_ASQ);
+	writeq(to_iova(device, state->admin_cq), bar0 + NVME_REG_ACQ);
+
+	/*
+	 * Configure the NVM command set, 4 KiB memory pages, round-robin
+	 * arbitration, and 64-byte SQ and 16-byte CQ entries. The PRP math in
+	 * nvme_set_prp() depends on 4 KiB pages. Then enable the controller.
+	 */
+	cc = NVME_CC_CSS_NVM | NVME_CC_AMS_RR | NVME_CC_IOSQES | NVME_CC_IOCQES;
+	writel(cc, bar0 + NVME_REG_CC);
+	writel(cc | NVME_CC_ENABLE, bar0 + NVME_REG_CC);
+
+	ret = nvme_wait_rdy(device, true);
+	VFIO_ASSERT_EQ(ret, 0, "Controller did not become ready (CSTS 0x%x)",
+		       readl(bar0 + NVME_REG_CSTS));
+}
+
+static void nvme_create_io_queue(struct vfio_pci_device *device,
+				 struct nvme_queue *q, bool ien)
+{
+	u16 flags = NVME_QUEUE_PHYS_CONTIG;
+	struct nvme_command cmd = {};
+
+	if (ien)
+		flags |= NVME_CQ_IRQ_ENABLED;
+
+	cmd.create_cq.opcode = nvme_admin_create_cq;
+	cmd.create_cq.prp1 = cpu_to_le64(to_iova(device, nvme_cq(device, q)));
+	cmd.create_cq.cqid = cpu_to_le16(q->qid);
+	cmd.create_cq.qsize = cpu_to_le16(q->depth - 1);
+	cmd.create_cq.cq_flags = cpu_to_le16(flags);
+	cmd.create_cq.irq_vector = cpu_to_le16(ien ? device->driver.msi : 0);
+	nvme_submit_admin_cmd(device, &cmd);
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.create_sq.opcode = nvme_admin_create_sq;
+	cmd.create_sq.prp1 = cpu_to_le64(to_iova(device, nvme_sq(device, q)));
+	cmd.create_sq.sqid = cpu_to_le16(q->qid);
+	cmd.create_sq.qsize = cpu_to_le16(q->depth - 1);
+	cmd.create_sq.sq_flags = cpu_to_le16(NVME_QUEUE_PHYS_CONTIG);
+	cmd.create_sq.cqid = cpu_to_le16(q->qid);
+	nvme_submit_admin_cmd(device, &cmd);
+}
+
+/*
+ * Split the region from poll_rings to its end evenly between the polled
+ * queues. Each queue gets the largest depth that fits, up to the CAP.MQES
+ * limit.
+ */
+static void nvme_init_pollqs(struct vfio_pci_device *device)
+{
+	u64 offset = offsetof(struct nvme_state, poll_rings);
+	struct nvme_state *state = to_nvme_state(device);
+	u64 bytes, sq_bytes, cq_bytes, cap;
+	u32 depth, i;
+
+	cap = readq(device->bars[0].vaddr + NVME_REG_CAP);
+	bytes = (device->driver.region.size - offset) / state->nr_pollqs;
+	VFIO_ASSERT_GT(bytes, 2 * SZ_4K);
+	depth = min_t(u64, NVME_CAP_MQES(cap) + 1, (bytes - 2 * SZ_4K) /
+		      (sizeof(struct nvme_command) +
+		       sizeof(struct nvme_completion)));
+	VFIO_ASSERT_GT(depth, 1);
+
+	sq_bytes = ALIGN((u64)depth * sizeof(struct nvme_command), SZ_4K);
+	cq_bytes = ALIGN((u64)depth * sizeof(struct nvme_completion), SZ_4K);
+
+	for (i = 0; i < state->nr_pollqs; i++) {
+		nvme_queue_init(device, &state->pollq[i], NVME_MSI_QID + 1 + i,
+				depth, offset, offset + sq_bytes);
+		offset += sq_bytes + cq_bytes;
+	}
+}
+
+static void nvme_create_io_queues(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	u32 granted, i;
+	u32 last_qid;
+	u64 db_end;
+
+	granted = nvme_set_num_queues(device, 1 + NVME_MAX_POLL_QUEUES);
+	VFIO_ASSERT_GE(granted, 2,
+		       "Controller granted %u I/O queue pairs, need at least 2 (1 MSI + 1 polled)",
+		       granted);
+	state->nr_pollqs = min_t(u32, granted - 1, NVME_MAX_POLL_QUEUES);
+
+	/* The CQ head doorbell of the last queue is the highest one. */
+	last_qid = NVME_MSI_QID + state->nr_pollqs;
+	db_end = nvme_db_offset(state, last_qid, true) + sizeof(u32);
+	VFIO_ASSERT_LE(db_end, device->bars[0].info.size);
+
+	nvme_init_pollqs(device);
+
+	nvme_create_io_queue(device, &state->msiq, true);
+	for (i = 0; i < state->nr_pollqs; i++)
+		nvme_create_io_queue(device, &state->pollq[i], false);
+}
+
+/* Use the first active namespace for the memcpy commands. */
+static void nvme_find_nsid(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+
+	/* The list holds the active NSIDs above 0, in increasing order. */
+	nvme_identify(device, 0, NVME_ID_CNS_NS_ACTIVE_LIST, state->ns_list);
+	state->nsid = le32_to_cpu(state->ns_list[0]);
+	VFIO_ASSERT_NE(state->nsid, 0, "Controller has no active namespace");
+}
+
+/*
+ * Record the logical block size of the namespace. The LBA Format that FLBAS
+ * selects reports it as a power-of-two shift.
+ */
+static void nvme_set_ns_geometry(struct nvme_state *state)
+{
+	struct nvme_lbaf *lbaf;
+
+	lbaf = &state->id_ns.lbaf[nvme_lbaf_index(state->id_ns.flbas)];
+
+	VFIO_ASSERT_NE(le64_to_cpu(state->id_ns.nsze), 0,
+		       "Namespace %u has size 0", state->nsid);
+	VFIO_ASSERT_EQ(le16_to_cpu(lbaf->ms), 0,
+		       "Namespace %u has metadata, format it without metadata",
+		       state->nsid);
+	VFIO_ASSERT_GE(lbaf->ds, NVME_MIN_LBA_SHIFT,
+		       "Namespace %u has an invalid LBA data size", state->nsid);
+	VFIO_ASSERT_LE(lbaf->ds, NVME_MAX_LBA_SHIFT,
+		       "Namespace %u has logical blocks larger than 4 KiB",
+		       state->nsid);
+
+	state->lba_shift = lbaf->ds;
+}
+
+static void nvme_set_limits(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	u64 max_size, nsze;
+	u8 mdts;
+
+	/*
+	 * The controller accepts at most 2^MDTS pages of CAP.MPSMIN size per
+	 * command, and MDTS 0 means no limit. CAP.MPSMIN is 0, which makes a
+	 * page 4 KiB. Both limits are powers of two of at least 4 KiB, so the
+	 * result is a whole number of logical blocks.
+	 */
+	mdts = state->id_ctrl.mdts;
+	max_size = NVME_MAX_XFER_SIZE;
+	if (mdts && mdts < 32)
+		max_size = min_t(u64, max_size, (u64)SZ_4K << mdts);
+
+	/* All memcpy operations use the logical blocks from LBA 0. */
+	nsze = le64_to_cpu(state->id_ns.nsze);
+	if (nsze < max_size >> state->lba_shift)
+		max_size = nsze << state->lba_shift;
+
+	device->driver.max_memcpy_size = max_size;
+	/* A ring of depth entries holds at most depth - 1 commands. */
+	device->driver.max_memcpy_count = state->nr_pollqs *
+					  (state->pollq[0].depth - 1);
+}
+
+static void nvme_init(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+
+	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*state));
+	memset(state, 0, sizeof(*state));
+
+	nvme_enable_irqs(device);
+	nvme_enable_ctrl(device);
+
+	nvme_identify(device, 0, NVME_ID_CNS_CTRL, &state->id_ctrl);
+	nvme_find_nsid(device);
+	nvme_identify(device, state->nsid, NVME_ID_CNS_NS, &state->id_ns);
+	nvme_set_ns_geometry(state);
+	nvme_create_io_queues(device);
+	nvme_set_limits(device);
+}
+
+static void nvme_remove(struct vfio_pci_device *device)
+{
+	nvme_disable_ctrl(device);
+	vfio_pci_cmd_clear(device, PCI_COMMAND_MASTER);
+	vfio_pci_msix_disable(device);
+}
+
+/*
+ * Return the controller to a working state after a failed command. On some
+ * controllers, a PCIe target abort, which the unmapped-IOVA tests trigger on
+ * purpose, leaves the submission queue in an error state that only a Function
+ * Level Reset clears. Disable the controller first so it stops DMA before the
+ * reset arrives.
+ */
+static void nvme_recover(struct vfio_pci_device *device)
+{
+	nvme_disable_ctrl(device);
+	vfio_pci_device_reset(device);
+	vfio_pci_msix_reenable(device, 0, device->driver.msi + 1);
+	nvme_enable_ctrl(device);
+	nvme_create_io_queues(device);
+}
+
+/*
+ * prp1 points at @buf. If the transfer reaches one more page, prp2 points at
+ * it. If it reaches more, prp2 points at @prp_list, which holds the address
+ * of each page after the first. CC.MPS is 0, which makes a page 4 KiB.
+ */
+static void nvme_set_prp(struct vfio_pci_device *device,
+			 struct nvme_command *cmd, iova_t buf, u64 size,
+			 __le64 *prp_list)
+{
+	u64 first = SZ_4K - (buf & (SZ_4K - 1));
+	u64 nr_entries, i;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(buf, 4), "PRP1 0x%lx is not dword aligned",
+			 buf);
+	cmd->rw.dptr.prp1 = cpu_to_le64(buf);
+	if (size <= first)
+		return;
+
+	nr_entries = DIV_ROUND_UP(size - first, SZ_4K);
+	VFIO_ASSERT_LE(nr_entries, NVME_PRP_LIST_ENTRIES);
+	for (i = 0; i < nr_entries; i++)
+		prp_list[i] = cpu_to_le64(buf + first + i * SZ_4K);
+
+	if (nr_entries == 1)
+		cmd->rw.dptr.prp2 = prp_list[0];
+	else
+		cmd->rw.dptr.prp2 = cpu_to_le64(to_iova(device, prp_list));
+}
+
+/*
+ * Build a read or write command covering @size bytes from LBA 0, transferring
+ * to or from @buf. @size must be a whole number of logical blocks.
+ */
+static void nvme_prep_rw_cmd(struct vfio_pci_device *device,
+			     struct nvme_command *cmd, u8 opcode,
+			     iova_t buf, u64 size, __le64 *prp_list)
+{
+	struct nvme_state *state = to_nvme_state(device);
+
+	VFIO_ASSERT_GT(size, 0);
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, 1ULL << state->lba_shift));
+
+	memset(cmd, 0, sizeof(*cmd));
+	cmd->rw.opcode = opcode;
+	cmd->rw.nsid = cpu_to_le32(state->nsid);
+	nvme_set_prp(device, cmd, buf, size, prp_list);
+	cmd->rw.length = cpu_to_le16((size >> state->lba_shift) - 1);
+}
+
+static int nvme_io_wait(struct vfio_pci_device *device, struct nvme_queue *q)
+{
+	struct nvme_completion cqe;
+	int ret;
+
+	ret = nvme_cq_wait(device, q, &cqe);
+	if (ret)
+		return ret;
+
+	return nvme_status(&cqe) ? -EIO : 0;
+}
+
+/*
+ * Copy @src to @dst through the logical blocks from LBA 0 of the namespace.
+ * A write stores @src first. Then the driver queues @count reads of those
+ * blocks into @dst, spread over the polled queues.
+ *
+ * Unlike the vfio_pci_driver_ops contract, this function does not return at
+ * once. It waits for the write to complete. The controller can run the
+ * commands of a queue in any order, and the reads must see the data of the
+ * write. All @count reads are in flight when this function returns.
+ */
+static void nvme_memcpy_start(struct vfio_pci_device *device,
+			      iova_t src, iova_t dst, u64 size, u64 count)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	struct nvme_command cmd;
+	u64 i;
+
+	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_write, src, size,
+			 state->prp_src);
+	nvme_sq_submit(device, &state->pollq[0], &cmd);
+	state->memcpy_err = nvme_io_wait(device, &state->pollq[0]);
+	if (state->memcpy_err)
+		return;
+
+	nvme_prep_rw_cmd(device, &cmd, nvme_cmd_read, dst, size,
+			 state->prp_dst);
+	for (i = 0; i < count; i++)
+		nvme_sq_push(device, &state->pollq[i % state->nr_pollqs], &cmd);
+	for (i = 0; i < min_t(u64, count, state->nr_pollqs); i++)
+		nvme_ring_sq_db(device, &state->pollq[i]);
+}
+
+static int nvme_memcpy_wait(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	int ret = state->memcpy_err;
+	u32 i;
+
+	for (i = 0; !ret && i < state->nr_pollqs; i++) {
+		while (!ret && state->pollq[i].inflight)
+			ret = nvme_io_wait(device, &state->pollq[i]);
+	}
+
+	if (ret)
+		nvme_recover(device);
+
+	return ret;
+}
+
+static void nvme_send_msi(struct vfio_pci_device *device)
+{
+	struct nvme_state *state = to_nvme_state(device);
+	struct nvme_command cmd = {};
+
+	cmd.common.opcode = nvme_cmd_flush;
+	cmd.common.nsid = cpu_to_le32(state->nsid);
+
+	nvme_sq_submit(device, &state->msiq, &cmd);
+	VFIO_ASSERT_EQ(nvme_io_wait(device, &state->msiq), 0);
+}
+
+const struct vfio_pci_driver_ops nvme_ops = {
+	.name = "nvme",
+	.region_size = sizeof(struct nvme_state) + NVME_POLL_RINGS_SIZE,
+	.probe = nvme_probe,
+	.init = nvme_init,
+	.remove = nvme_remove,
+	.memcpy_start = nvme_memcpy_start,
+	.memcpy_wait = nvme_memcpy_wait,
+	.send_msi = nvme_send_msi,
+};
diff --git a/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.h b/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.h
new file mode 120000
index 000000000000..32258e9c9311
--- /dev/null
+++ b/tools/testing/selftests/vfio/lib/drivers/nvme/nvme.h
@@ -0,0 +1 @@
+../../../../../../../include/linux/nvme.h
\ No newline at end of file
diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
index eff95828719e..9d33d29043c2 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.mk
+++ b/tools/testing/selftests/vfio/lib/libvfio.mk
@@ -18,6 +18,7 @@ endif
 LIBVFIO_C += drivers/mlx5/mlx5.c
 LIBVFIO_C += drivers/nv_falcon/nv_falcon.c
 LIBVFIO_C += drivers/igb/igb.c
+LIBVFIO_C += drivers/nvme/nvme.c
 
 LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
index b31abfe2c7ff..f54b4ac505dd 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
@@ -9,6 +9,7 @@ extern struct vfio_pci_driver_ops ioat_ops;
 extern struct vfio_pci_driver_ops mlx5st_ops;
 extern struct vfio_pci_driver_ops nv_falcon_ops;
 extern struct vfio_pci_driver_ops igb_ops;
+extern struct vfio_pci_driver_ops nvme_ops;
 
 static struct vfio_pci_driver_ops *driver_ops[] = {
 #ifdef __x86_64__
@@ -18,6 +19,7 @@ static struct vfio_pci_driver_ops *driver_ops[] = {
 	&mlx5st_ops,
 	&nv_falcon_ops,
 	&igb_ops,
+	&nvme_ops,
 };
 
 void vfio_pci_driver_probe(struct vfio_pci_device *device)
-- 
2.56.1.831.g720f3f5937-goog

