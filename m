Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC66D346E74
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916090; cv=none; b=o4SoHeqS/ESs7IIuLxl9XARYTN1V0nt+gF3Yy98PSsHbb7ka8YKT8S6y3i/8DG47Ze63jQTTVdcpNXZVTxFxBySWMhV4nH8D8gASaW56OgB+1UmT064VbSpsB2YD2ZaE0A2+SFqeAYHtYokwR1HsPDh4R3FENy+MUhsHJw8lyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916090; c=relaxed/simple;
	bh=GatkKJLZAJt27Q+lgMfcNTLKEpEGoBrfnv5Afp8XcRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqBne/dNT6odkbMPsBVLbBev7NiYgyN0ne6nrFJOD28Yx6ceK55hcp9ehOY6K5vw64pCb1tVLX8Vgl7CQvcsKUZy1mjkKG5iUK8UToNHS+qOntomYylgQf9w3XxQEFgyAmNoJKtJe7yU3O+PWNnlT6M0j8yzxhycVoArODEV0tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QtcjBz+q; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QtcjBz+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=CB
	6dFu9e6b6ULYg065Bjn6P0urEN69tvXZMFRuRaD0I=; b=QtcjBz+qJW6ITH3/y0
	FoeV0/KMec++cm8KQUaI/8OFOFlVJK6VZJU0XTR9Ji1CpyVZ7asrm/dJu/j9uG9O
	eFpmF5yWWqKMRGNVatLFHY+LZ4Q4AsPY9jzuthKOYMqxgQjkFZXYMJGZDV+Qz/7F
	T7E8LPi6EQ+YyngsFmJGyvtoM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD35mzeI0VqYpWYGg--.10116S4;
	Wed, 01 Jul 2026 22:27:50 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: kvm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [RFC PATCH 2/2] riscv: allow a non-identity PCI MMIO CPU base
Date: Wed,  1 Jul 2026 22:26:54 +0800
Message-ID: <20260701142654.483659-3-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701142654.483659-1-tjytimi@163.com>
References: <20260701142654.483659-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD35mzeI0VqYpWYGg--.10116S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF1UWFy7ZFWDtF43Cr4fGrg_yoW7Xr1DpF
	s8u3yY9rWFqr17Wrs3Jr1kA3WaqanYkrW5G34j9rZ0gr1Yvr1UKrn5t342krWfWa1vvry7
	AFyxKFW3Cw1UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_6wZDUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbCzwbtZmpFI+bICgAA3q

RISC-V currently exposes an identity PCI MMIO window to the guest. Keep
that default, but add a pci-mmio-cpu-base option so the CPU physical base
in the generated FDT ranges can differ from the PCI bus base used for BAR
allocation.

Implement the PCI bus/CPU address translation hooks using the configured
window. This makes it possible to run a RISC-V guest with a non-identity
PCI MMIO range and exercises the generic PCI MMIO translation paths.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 riscv/fdt.c                         |  2 +-
 riscv/include/kvm/kvm-arch.h        |  5 ++-
 riscv/include/kvm/kvm-config-arch.h |  4 +++
 riscv/pci.c                         | 49 ++++++++++++++++++++++++++---
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/riscv/fdt.c b/riscv/fdt.c
index 2368c19..635c29d 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -431,7 +431,7 @@ static int setup_fdt(struct kvm *kvm)
 	}
 
 	/* PCI host controller */
-	pci__generate_fdt_nodes(fdt);
+	pci__generate_fdt_nodes(fdt, kvm);
 
 	_FDT(fdt_end_node(fdt));
 
diff --git a/riscv/include/kvm/kvm-arch.h b/riscv/include/kvm/kvm-arch.h
index 1bb2d32..7d20200 100644
--- a/riscv/include/kvm/kvm-arch.h
+++ b/riscv/include/kvm/kvm-arch.h
@@ -55,6 +55,7 @@
 #define VIRTIO_RING_ENDIAN	VIRTIO_ENDIAN_LE
 
 #define ARCH_HAS_PCI_EXP	1
+#define ARCH_HAS_PCI_ADDR_TRANSLATION	1
 
 struct kvm;
 
@@ -105,7 +106,9 @@ extern bool riscv_irqchip_irqfd_ready;
 void aia__create(struct kvm *kvm);
 void plic__create(struct kvm *kvm);
 
-void pci__generate_fdt_nodes(void *fdt);
+u64 pci__bus_to_cpu_addr(struct kvm *kvm, u64 addr);
+u64 pci__cpu_to_bus_addr(struct kvm *kvm, u64 addr);
+void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm);
 
 int riscv__add_irqfd(struct kvm *kvm, unsigned int gsi, int trigger_fd,
 		     int resample_fd);
diff --git a/riscv/include/kvm/kvm-config-arch.h b/riscv/include/kvm/kvm-config-arch.h
index d56f9ba..974521a 100644
--- a/riscv/include/kvm/kvm-config-arch.h
+++ b/riscv/include/kvm/kvm-config-arch.h
@@ -11,6 +11,7 @@ enum riscv__cpu_type {
 struct kvm_config_arch {
 	enum riscv__cpu_type cpu_type;
 	const char	*dump_dtb_filename;
+	u64		pci_mmio_cpu_base;
 	u64		suspend_seconds;
 	u64		custom_mvendorid;
 	u64		custom_marchid;
@@ -27,6 +28,9 @@ int riscv__cpu_type_parser(const struct option *opt, const char *arg, int unset)
 		     "Choose the cpu type (default is max).", riscv__cpu_type_parser, kvm),\
 	OPT_STRING('\0', "dump-dtb", &(cfg)->dump_dtb_filename,		\
 		   ".dtb file", "Dump generated .dtb to specified file"),\
+	OPT_U64('\0', "pci-mmio-cpu-base",				\
+		&(cfg)->pci_mmio_cpu_base,				\
+		"Set the CPU base address of the PCI MMIO window"),	\
 	OPT_U64('\0', "suspend-seconds",				\
 		&(cfg)->suspend_seconds,				\
 		"Number of seconds to suspend for system suspend (default is 5)"), \
diff --git a/riscv/pci.c b/riscv/pci.c
index fb05880..09cd09f 100644
--- a/riscv/pci.c
+++ b/riscv/pci.c
@@ -17,11 +17,50 @@ struct of_interrupt_map_entry {
 	u32				irqchip_sense;
 } __attribute__((packed));
 
-void pci__generate_fdt_nodes(void *fdt)
+struct riscv_pci_mmio_window {
+	u64				pci_mmio_bus_base;
+	u64				pci_mmio_cpu_base;
+	u64				size;
+};
+
+static struct riscv_pci_mmio_window riscv__pci_mmio_window(struct kvm *kvm)
+{
+	struct riscv_pci_mmio_window window = {
+		.pci_mmio_bus_base	= KVM_PCI_MMIO_AREA,
+		.pci_mmio_cpu_base	= KVM_PCI_MMIO_AREA,
+		.size			= RISCV_PCI_MMIO_SIZE,
+	};
+
+	if (kvm->cfg.arch.pci_mmio_cpu_base)
+		window.pci_mmio_cpu_base = kvm->cfg.arch.pci_mmio_cpu_base;
+
+	return window;
+}
+
+u64 pci__bus_to_cpu_addr(struct kvm *kvm, u64 addr)
+{
+	struct riscv_pci_mmio_window window = riscv__pci_mmio_window(kvm);
+	u64 offset;
+
+	offset = addr - window.pci_mmio_bus_base;
+	return window.pci_mmio_cpu_base + offset;
+}
+
+u64 pci__cpu_to_bus_addr(struct kvm *kvm, u64 addr)
+{
+	struct riscv_pci_mmio_window window = riscv__pci_mmio_window(kvm);
+	u64 offset;
+
+	offset = addr - window.pci_mmio_cpu_base;
+	return window.pci_mmio_bus_base + offset;
+}
+
+void pci__generate_fdt_nodes(void *fdt, struct kvm *kvm)
 {
 	struct device_header *dev_hdr;
 	struct of_interrupt_map_entry irq_map[OF_PCI_IRQ_MAP_MAX];
 	unsigned nentries = 0, nsize;
+	struct riscv_pci_mmio_window mmio_window = riscv__pci_mmio_window(kvm);
 	/* Bus range */
 	u32 bus_range[] = { cpu_to_fdt32(0), cpu_to_fdt32(1), };
 	/* Configuration Space */
@@ -41,11 +80,11 @@ void pci__generate_fdt_nodes(void *fdt)
 		{
 			.pci_addr = {
 				.hi	= cpu_to_fdt32(of_pci_b_ss(OF_PCI_SS_M32)),
-				.mid	= cpu_to_fdt32(KVM_PCI_MMIO_AREA >> 32),
-				.lo	= cpu_to_fdt32(KVM_PCI_MMIO_AREA),
+				.mid	= cpu_to_fdt32(mmio_window.pci_mmio_bus_base >> 32),
+				.lo	= cpu_to_fdt32(mmio_window.pci_mmio_bus_base),
 			},
-			.cpu_addr	= cpu_to_fdt64(KVM_PCI_MMIO_AREA),
-			.length		= cpu_to_fdt64(RISCV_PCI_MMIO_SIZE),
+			.cpu_addr	= cpu_to_fdt64(mmio_window.pci_mmio_cpu_base),
+			.length		= cpu_to_fdt64(mmio_window.size),
 		},
 	};
 
-- 
2.43.0

