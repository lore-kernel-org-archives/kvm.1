Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DDD2C21DD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916094; cv=none; b=XUvKTaSQa+f+pWbeZ1KD1qeIX1aCoFfg78rSnNlveo48j2td5F6tvr3lIAc2bWBIgoGq1z3cdL6r1347axoelvNMNtj/og+TL78dpqFIIK3oohiPLH10kQN9Mkq8auz6NFML8gKuJaMy8es7fOlshKDZuktuvUgUbWAgXDHdzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916094; c=relaxed/simple;
	bh=6UuDi0tvkrNdsc4Xh+iSb+fgtUunkX5K0AwEW5htxUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0wjRy2ew4FSCuVfmOBP35H1doa999w4jyFuTU2w7FKyIuysrNdcnOPp+C6jlu2+aefOcpiI+bukNR9KeNkofT2eictEzpB6jJYFxr0GCBd4P/6vwnA3UCyPvsrAqNzX7p1Gy9nCT1o/ri0OOr2e9imUMHXkziDu8/kJoJQMFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e9Y6UnzX; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e9Y6UnzX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wg
	QaR1ey6OC1h8dpLk2btx/T3PX3QNLV1FVs1PK8GH8=; b=e9Y6UnzXZgRzKFqh9c
	xZj9TA+sUB9A9JBwq5zCvdyf5+PK/VSDHsUvla3VAHexRqNDQHDZoW0iOUag8Dsg
	Je5NLcfr9ci26IO3npZ7ySckRvK4arVPA8fW3489LA+nM+67cKne5kzvAsd8iSIA
	iyQxWuS6ByIMN2Rs6R3GClwXw=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD35mzeI0VqYpWYGg--.10116S3;
	Wed, 01 Jul 2026 22:27:48 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: kvm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [RFC PATCH 1/2] pci: translate BAR addresses for MMIO users
Date: Wed,  1 Jul 2026 22:26:53 +0800
Message-ID: <20260701142654.483659-2-tjytimi@163.com>
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
X-CM-TRANSID:_____wD35mzeI0VqYpWYGg--.10116S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfJr1kKr4kJryfuw4ktw15XFb_yoW8GF43Wo
	Z7ZFsIg345uw1jkFWv9r17tFy3X3WYgw15Can3Ja4UWa10k34UGw1xG3Z3AanxJ3yrK3Wx
	JryUKw4fAr97JF4xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRdl1DUUUUU
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8gTtZmpFI+Q+kQAA36

Add default identity PCI bus/CPU address translation helpers and use them
when registering or handling PCI MMIO regions for virtio-pci and VFIO.

Architectures with identity mappings keep the existing behaviour, while
architectures with a non-identity PCI MMIO window can override the helpers.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 include/kvm/pci.h   | 17 +++++++++++++++++
 vfio/core.c         | 25 ++++++++++++++++++-------
 vfio/pci.c          | 31 +++++++++++++++++++++----------
 virtio/pci-legacy.c |  6 ++++--
 virtio/pci-modern.c |  2 ++
 virtio/pci.c        | 25 ++++++++++++++++++-------
 6 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/include/kvm/pci.h b/include/kvm/pci.h
index 25113f6..1c60535 100644
--- a/include/kvm/pci.h
+++ b/include/kvm/pci.h
@@ -258,6 +258,23 @@ int pci__assign_irq(struct pci_device_header *pci_hdr);
 void pci__config_wr(struct kvm *kvm, union pci_config_address addr, void *data, int size);
 void pci__config_rd(struct kvm *kvm, union pci_config_address addr, void *data, int size);
 
+/*
+ * PCI BARs contain bus addresses, whereas KVM MMIO exits and ioctls such as
+ * KVM_IOEVENTFD and KVM_SET_USER_MEMORY_REGION operate on CPU physical
+ * addresses.
+ */
+#ifndef ARCH_HAS_PCI_ADDR_TRANSLATION
+static inline u64 pci__bus_to_cpu_addr(struct kvm *kvm, u64 addr)
+{
+	return addr;
+}
+
+static inline u64 pci__cpu_to_bus_addr(struct kvm *kvm, u64 addr)
+{
+	return addr;
+}
+#endif
+
 void *pci_find_cap(struct pci_device_header *hdr, u8 cap_type);
 
 int pci__register_bar_regions(struct kvm *kvm, struct pci_device_header *pci_hdr,
diff --git a/vfio/core.c b/vfio/core.c
index fbe0098..e3d8f5b 100644
--- a/vfio/core.c
+++ b/vfio/core.c
@@ -165,11 +165,13 @@ static void vfio_mmio_access(struct kvm_cpu *vcpu, u64 addr, u8 *data, u32 len,
 			     u8 is_write, void *ptr)
 {
 	u64 val;
+	u32 offset;
 	ssize_t nr;
 	struct vfio_region *region = ptr;
 	struct vfio_device *vdev = region->vdev;
 
-	u32 offset = addr - region->guest_phys_addr;
+	addr = pci__cpu_to_bus_addr(vcpu->kvm, addr);
+	offset = addr - region->guest_phys_addr;
 
 	if (len < 1 || len > 8)
 		goto err_report;
@@ -204,6 +206,8 @@ err_report:
 static int vfio_setup_trap_region(struct kvm *kvm, struct vfio_device *vdev,
 				  struct vfio_region *region)
 {
+	u64 pci_region_cpu_addr;
+
 	if (region->is_ioport) {
 		int port;
 
@@ -215,7 +219,8 @@ static int vfio_setup_trap_region(struct kvm *kvm, struct vfio_device *vdev,
 		return 0;
 	}
 
-	return kvm__register_mmio(kvm, region->guest_phys_addr,
+	pci_region_cpu_addr = pci__bus_to_cpu_addr(kvm, region->guest_phys_addr);
+	return kvm__register_mmio(kvm, pci_region_cpu_addr,
 				  region->info.size, false, vfio_mmio_access,
 				  region);
 }
@@ -227,16 +232,19 @@ int vfio_map_region(struct kvm *kvm, struct vfio_device *vdev,
 	int ret, prot = 0;
 	/* KVM needs page-aligned regions */
 	u64 map_size = ALIGN(region->info.size, PAGE_SIZE);
+	u64 pci_region_cpu_addr;
 
 	if (!(region->info.flags & VFIO_REGION_INFO_FLAG_MMAP))
 		return vfio_setup_trap_region(kvm, vdev, region);
 
+	pci_region_cpu_addr = pci__bus_to_cpu_addr(kvm, region->guest_phys_addr);
+
 	/*
 	 * KVM_SET_USER_MEMORY_REGION will fail because the guest physical
 	 * address isn't page aligned, let's emulate the region ourselves.
 	 */
-	if (region->guest_phys_addr & (PAGE_SIZE - 1))
-		return kvm__register_mmio(kvm, region->guest_phys_addr,
+	if (pci_region_cpu_addr & (PAGE_SIZE - 1))
+		return kvm__register_mmio(kvm, pci_region_cpu_addr,
 					  region->info.size, false,
 					  vfio_mmio_access, region);
 
@@ -255,7 +263,7 @@ int vfio_map_region(struct kvm *kvm, struct vfio_device *vdev,
 	}
 	region->host_addr = base;
 
-	ret = kvm__register_dev_mem(kvm, region->guest_phys_addr, map_size,
+	ret = kvm__register_dev_mem(kvm, pci_region_cpu_addr, map_size,
 				    region->host_addr);
 	if (ret) {
 		vfio_dev_err(vdev, "failed to register region with KVM");
@@ -268,17 +276,20 @@ int vfio_map_region(struct kvm *kvm, struct vfio_device *vdev,
 void vfio_unmap_region(struct kvm *kvm, struct vfio_region *region)
 {
 	u64 map_size;
+	u64 pci_region_cpu_addr;
 
 	if (region->host_addr) {
+		pci_region_cpu_addr = pci__bus_to_cpu_addr(kvm, region->guest_phys_addr);
 		map_size = ALIGN(region->info.size, PAGE_SIZE);
-		kvm__destroy_mem(kvm, region->guest_phys_addr, map_size,
+		kvm__destroy_mem(kvm, pci_region_cpu_addr, map_size,
 				 region->host_addr);
 		munmap(region->host_addr, region->info.size);
 		region->host_addr = NULL;
 	} else if (region->is_ioport) {
 		kvm__deregister_pio(kvm, region->port_base);
 	} else {
-		kvm__deregister_mmio(kvm, region->guest_phys_addr);
+		pci_region_cpu_addr = pci__bus_to_cpu_addr(kvm, region->guest_phys_addr);
+		kvm__deregister_mmio(kvm, pci_region_cpu_addr);
 	}
 }
 
diff --git a/vfio/pci.c b/vfio/pci.c
index 0bcd60e..93bbbd9 100644
--- a/vfio/pci.c
+++ b/vfio/pci.c
@@ -268,8 +268,11 @@ static void vfio_pci_msix_pba_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 {
 	struct vfio_pci_device *pdev = ptr;
 	struct vfio_pci_msix_pba *pba = &pdev->msix_pba;
-	u64 offset = addr - pba->guest_phys_addr;
 	struct vfio_device *vdev = container_of(pdev, struct vfio_device, pci);
+	u64 offset;
+
+	addr = pci__cpu_to_bus_addr(vcpu->kvm, addr);
+	offset = addr - pba->guest_phys_addr;
 
 	if (offset >= pba->size) {
 		vfio_dev_err(vdev, "access outside of the MSIX PBA");
@@ -294,15 +297,19 @@ static void vfio_pci_msix_table_access(struct kvm_cpu *vcpu, u64 addr, u8 *data,
 	struct vfio_pci_msi_entry *entry;
 	struct vfio_pci_device *pdev = ptr;
 	struct vfio_device *vdev = container_of(pdev, struct vfio_device, pci);
+	u64 offset;
+	size_t vector;
+	off_t field;
 
-	u64 offset = addr - pdev->msix_table.guest_phys_addr;
+	addr = pci__cpu_to_bus_addr(kvm, addr);
+	offset = addr - pdev->msix_table.guest_phys_addr;
 	if (offset >= pdev->msix_table.size) {
 		vfio_dev_err(vdev, "access outside of the MSI-X table");
 		return;
 	}
 
-	size_t vector = offset / PCI_MSIX_ENTRY_SIZE;
-	off_t field = offset % PCI_MSIX_ENTRY_SIZE;
+	vector = offset / PCI_MSIX_ENTRY_SIZE;
+	field = offset % PCI_MSIX_ENTRY_SIZE;
 
 	/*
 	 * PCI spec says that software must use aligned 4 or 8 bytes accesses
@@ -502,6 +509,7 @@ static int vfio_pci_bar_activate(struct kvm *kvm,
 	struct vfio_pci_msix_table *table = &pdev->msix_table;
 	struct vfio_region *region;
 	u32 bar_addr;
+	u64 msix_region_cpu_addr;
 	bool has_msix;
 	int ret;
 
@@ -518,8 +526,8 @@ static int vfio_pci_bar_activate(struct kvm *kvm,
 
 	if (has_msix && (u32)bar_num == table->bar) {
 		table->guest_phys_addr = region->guest_phys_addr;
-		ret = kvm__register_mmio(kvm, table->guest_phys_addr,
-					 table->size, false,
+		msix_region_cpu_addr = pci__bus_to_cpu_addr(kvm, table->guest_phys_addr);
+		ret = kvm__register_mmio(kvm, msix_region_cpu_addr, table->size, false,
 					 vfio_pci_msix_table_access, pdev);
 		/*
 		 * The MSIX table and the PBA structure can share the same BAR,
@@ -536,8 +544,8 @@ static int vfio_pci_bar_activate(struct kvm *kvm,
 			pba->guest_phys_addr = table->guest_phys_addr + pba->bar_offset;
 		else
 			pba->guest_phys_addr = region->guest_phys_addr;
-		ret = kvm__register_mmio(kvm, pba->guest_phys_addr,
-					 pba->size, false,
+		msix_region_cpu_addr = pci__bus_to_cpu_addr(kvm, pba->guest_phys_addr);
+		ret = kvm__register_mmio(kvm, msix_region_cpu_addr, pba->size, false,
 					 vfio_pci_msix_pba_access, pdev);
 		goto out;
 	}
@@ -556,6 +564,7 @@ static int vfio_pci_bar_deactivate(struct kvm *kvm,
 	struct vfio_pci_msix_pba *pba = &pdev->msix_pba;
 	struct vfio_pci_msix_table *table = &pdev->msix_table;
 	struct vfio_region *region;
+	u64 msix_region_cpu_addr;
 	bool has_msix, success;
 	int ret;
 
@@ -565,7 +574,8 @@ static int vfio_pci_bar_deactivate(struct kvm *kvm,
 	has_msix = pdev->irq_modes & VFIO_PCI_IRQ_MODE_MSIX;
 
 	if (has_msix && (u32)bar_num == table->bar) {
-		success = kvm__deregister_mmio(kvm, table->guest_phys_addr);
+		msix_region_cpu_addr = pci__bus_to_cpu_addr(kvm, table->guest_phys_addr);
+		success = kvm__deregister_mmio(kvm, msix_region_cpu_addr);
 		/* kvm__deregister_mmio fails when the region is not found. */
 		ret = (success ? 0 : -ENOENT);
 		/* See vfio_pci_bar_activate(). */
@@ -574,7 +584,8 @@ static int vfio_pci_bar_deactivate(struct kvm *kvm,
 	}
 
 	if (has_msix && (u32)bar_num == pba->bar) {
-		success = kvm__deregister_mmio(kvm, pba->guest_phys_addr);
+		msix_region_cpu_addr = pci__bus_to_cpu_addr(kvm, pba->guest_phys_addr);
+		success = kvm__deregister_mmio(kvm, msix_region_cpu_addr);
 		ret = (success ? 0 : -ENOENT);
 		goto out;
 	}
diff --git a/virtio/pci-legacy.c b/virtio/pci-legacy.c
index 02a8f8c..670b097 100644
--- a/virtio/pci-legacy.c
+++ b/virtio/pci-legacy.c
@@ -192,10 +192,12 @@ void virtio_pci_legacy__io_mmio_callback(struct kvm_cpu *vcpu, u64 addr,
 	u32 base_addr;
 
 	if (addr >= ioport_addr &&
-	    addr < ioport_addr + pci__bar_size(&vpci->pci_hdr, 0))
+	    addr < ioport_addr + pci__bar_size(&vpci->pci_hdr, 0)) {
 		base_addr = ioport_addr;
-	else
+	} else {
+		addr = pci__cpu_to_bus_addr(vcpu->kvm, addr);
 		base_addr = virtio_pci__mmio_addr(vpci);
+	}
 
 	if (!is_write)
 		virtio_pci__data_in(vcpu, vdev, addr - base_addr, data, len);
diff --git a/virtio/pci-modern.c b/virtio/pci-modern.c
index 888afa5..3a3e63f 100644
--- a/virtio/pci-modern.c
+++ b/virtio/pci-modern.c
@@ -306,6 +306,8 @@ void virtio_pci_modern__io_mmio_callback(struct kvm_cpu *vcpu, u64 addr,
 	struct virtio_pci *vpci = vdev->virtio;
 	u32 mmio_addr = virtio_pci__mmio_addr(vpci);
 
+	addr = pci__cpu_to_bus_addr(vcpu->kvm, addr);
+
 	virtio_pci_access(vcpu, vdev, addr - mmio_addr, data, len, is_write);
 }
 
diff --git a/virtio/pci.c b/virtio/pci.c
index 8a34cec..17c6ee3 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -62,6 +62,7 @@ int virtio_pci__init_ioeventfd(struct kvm *kvm, struct virtio_device *vdev,
 	struct virtio_pci *vpci = vdev->virtio;
 	u32 mmio_addr = virtio_pci__mmio_addr(vpci);
 	u16 port_addr = virtio_pci__port_addr(vpci);
+	u64 pci_mmio_cpu_addr = pci__bus_to_cpu_addr(kvm, mmio_addr);
 	off_t offset = vpci->doorbell_offset;
 	int r, flags = 0;
 	int pio_fd, mmio_fd;
@@ -94,7 +95,7 @@ int virtio_pci__init_ioeventfd(struct kvm *kvm, struct virtio_device *vdev,
 		return r;
 
 	/* mmio */
-	ioevent.io_addr	= mmio_addr + offset;
+	ioevent.io_addr	= pci_mmio_cpu_addr + offset;
 	ioevent.io_len	= sizeof(u16);
 	ioevent.fd	= mmio_fd = eventfd(0, 0);
 	r = ioeventfd__add_event(&ioevent, flags);
@@ -129,12 +130,13 @@ void virtio_pci_exit_vq(struct kvm *kvm, struct virtio_device *vdev, int vq)
 	struct virtio_pci *vpci = vdev->virtio;
 	u32 mmio_addr = virtio_pci__mmio_addr(vpci);
 	u16 port_addr = virtio_pci__port_addr(vpci);
+	u64 pci_mmio_cpu_addr = pci__bus_to_cpu_addr(kvm, mmio_addr);
 	off_t offset = vpci->doorbell_offset;
 
 	virtio_pci__del_msix_route(vpci, vpci->gsis[vq]);
 	vpci->gsis[vq] = 0;
 	vpci->vq_vector[vq] = VIRTIO_MSI_NO_VECTOR;
-	ioeventfd__del_event(mmio_addr + offset, vq);
+	ioeventfd__del_event(pci_mmio_cpu_addr + offset, vq);
 	ioeventfd__del_event(port_addr + offset, vq);
 	virtio_exit_vq(kvm, vdev, vpci->dev, vq);
 }
@@ -175,6 +177,8 @@ static void virtio_pci__msix_mmio_callback(struct kvm_cpu *vcpu,
 	int vecnum;
 	size_t offset;
 
+	addr = pci__cpu_to_bus_addr(vcpu->kvm, addr);
+
 	BUILD_BUG_ON(VIRTIO_NR_MSIX > (sizeof(vpci->msix_pba) * 8));
 
 	pba_offset = vpci->pci_hdr.msix.pba_offset & ~PCI_MSIX_TABLE_BIR;
@@ -280,6 +284,7 @@ static int virtio_pci__bar_activate(struct kvm *kvm,
 	struct virtio_device *vdev = data;
 	mmio_handler_fn mmio_fn;
 	u32 bar_addr, bar_size;
+	u64 pci_bar_cpu_addr;
 	int r = -EINVAL;
 
 	if (vdev->legacy)
@@ -297,11 +302,13 @@ static int virtio_pci__bar_activate(struct kvm *kvm,
 		r = kvm__register_pio(kvm, bar_addr, bar_size, mmio_fn, vdev);
 		break;
 	case 1:
-		r =  kvm__register_mmio(kvm, bar_addr, bar_size, false, mmio_fn,
+		pci_bar_cpu_addr = pci__bus_to_cpu_addr(kvm, bar_addr);
+		r =  kvm__register_mmio(kvm, pci_bar_cpu_addr, bar_size, false, mmio_fn,
 					vdev);
 		break;
 	case 2:
-		r =  kvm__register_mmio(kvm, bar_addr, bar_size, false,
+		pci_bar_cpu_addr = pci__bus_to_cpu_addr(kvm, bar_addr);
+		r =  kvm__register_mmio(kvm, pci_bar_cpu_addr, bar_size, false,
 					virtio_pci__msix_mmio_callback, vdev);
 		break;
 	}
@@ -314,6 +321,7 @@ static int virtio_pci__bar_deactivate(struct kvm *kvm,
 				      int bar_num, void *data)
 {
 	u32 bar_addr;
+	u64 pci_bar_cpu_addr;
 	bool success;
 	int r = -EINVAL;
 
@@ -327,7 +335,8 @@ static int virtio_pci__bar_deactivate(struct kvm *kvm,
 		break;
 	case 1:
 	case 2:
-		success = kvm__deregister_mmio(kvm, bar_addr);
+		pci_bar_cpu_addr = pci__bus_to_cpu_addr(kvm, bar_addr);
+		success = kvm__deregister_mmio(kvm, pci_bar_cpu_addr);
 		/* kvm__deregister_mmio fails when the region is not found. */
 		r = (success ? 0 : -ENOENT);
 		break;
@@ -446,10 +455,12 @@ int virtio_pci__reset(struct kvm *kvm, struct virtio_device *vdev)
 int virtio_pci__exit(struct kvm *kvm, struct virtio_device *vdev)
 {
 	struct virtio_pci *vpci = vdev->virtio;
+	u64 pci_mmio_cpu_addr = pci__bus_to_cpu_addr(kvm, virtio_pci__mmio_addr(vpci));
+	u64 pci_msix_cpu_addr = pci__bus_to_cpu_addr(kvm, virtio_pci__msix_io_addr(vpci));
 
 	virtio_pci__reset(kvm, vdev);
-	kvm__deregister_mmio(kvm, virtio_pci__mmio_addr(vpci));
-	kvm__deregister_mmio(kvm, virtio_pci__msix_io_addr(vpci));
+	kvm__deregister_mmio(kvm, pci_mmio_cpu_addr);
+	kvm__deregister_mmio(kvm, pci_msix_cpu_addr);
 	kvm__deregister_pio(kvm, virtio_pci__port_addr(vpci));
 
 	return 0;
-- 
2.43.0

