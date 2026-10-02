Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706749B473
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972466; cv=none; b=jShG12yIHvzdBjByGThxg80dn/p+xMdJndepOM8nBbLXaGkrTXJEmWX5p9Ohujs1dSfUC1opE4pwXrz35n5+VAxodoa/rZ+/8yna7C47X9d1uz6Kq/aMg6/T1TvUYcTAk4nP4Qqd9C2NPkhZXda8zeNSdm7ySU8JirWpr4JnmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972466; c=relaxed/simple;
	bh=xYMlQYsLCJyxzATsphx5/KTCxDUt9mzZih8TrjfzZfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kK+PI4w3fQb+F+4iMXXcEsKBZKNgSuUr6eHViKqwZflTUTKzreV9Y9aoKHJ6jHT5TQuCasN2ug2GWTQ+BGJeSrB8gAYt4fDCrZbNyM4y5knggXTgVdI6aeij9ThYspHOFDJU0ykXCLE7e/kyhEIBBBGWJjXbvtotrIa7e8/lX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V5ZsnBys; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5ZsnBys"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e30b9f1441so7436485ad.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972464; x=1791577264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7qPKAWSfckJyJHNNtJXbCBKrySoQfPFDqXUJy/teu4w=;
        b=V5ZsnBysxiZRyBx/IAEk2w7JwTAmHL4/21qLCNjZEGkd9maLdEKBD4mkRSyiptbsv9
         PlNvBSzM6r1tbm9U4lSMvstCUFGCA0HeR5nOkz/ntrNZ1BgRxYC0JAFbnPOl59Mfg+6L
         C6rVN3VUEK600bcr6I0GJCiD6p31nd0nBBp9wzBepjpJ+TUjaNKP3TvrTu4/52TO0RmK
         4II5QsenpPdI3CSpUl73YSifjyHLvLdAL6TXiAPxbWyWvcMIf+Ycr0chpGD6/UzhRW5S
         hcjLOkdV/TXHN0CjVbPcJyMkCXywEXJgwt0IJ/69ZPjauGjFYmh6rrL5jGPaQAcJaCEF
         7kMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972464; x=1791577264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7qPKAWSfckJyJHNNtJXbCBKrySoQfPFDqXUJy/teu4w=;
        b=XyLxhlUcNetI3YdtZdrPU070W7xLFAHOIHPQU/70I+adZay2X5KdZfG//EJ/O4u/NJ
         0RREC2KXdMQuTdXQeKSmRRz1vfIPam2yPJokxwfUyyTc3U2ft5SDfKxg/0tXfUTqBdc5
         7QjGaVgq8M5yM3ME9TLU9p1wUyh/QA9SJ/v7TmV1ltrI+DTAH6wZyPbQ7CHdIY30CamD
         rqHWjDmfnid+ylacr2Z2AG04A0iUZY5KXPfdULy4PXCImBrJH/FMxBItyJL/DpYmaxNG
         TmyC4debarQo7miFzgtz42UdE8Jc7wtxaJfy3x63cfzDJ87afOyqXkfT5BudWSKBQ3YF
         TMJw==
X-Forwarded-Encrypted: i=1; AKwUvBwhpk3pEmAty1qA0V6TopnvsQit8Yg+VtBxypxphqf2wvkr9a5zMPQuoxzkh2qkkF2NWnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYL7Rl0SN5QL9tonylsqiJ6xfphi7qmYD3KBIYignJUQXFEvlnNk
	uZPz6aSCXy+Hs2Dm+RpxHQadlyMaXdof1IjnyUVcqBYRkHdO/lYBSMKf3SVmey19KBw=
X-Gm-Gg: AYBFou2LQQG+DyoQpUIP9wTDaBUuGfWKQ8qxVFwamRosxJBsPC6oMM2ycdp+BHIF+am
	dljlSE+Z/5eTa6S62IzulZluuQHE9T7eeMb2WuuApiqOSHYIOgR+rID9WJA89ReDX5f7MH/Cg6b
	v2+qfCUngYXYMebQcuuVkgNruXGwncEruDIifjjKgYfjMmhruiPTHIT4DFBr9zh+dxhJvQ9agsn
	g/q5pnDVKUCWpuj3GFrEgkii8XK3y7krklXspbmCXkYb6WEgrH4T2exmuntOiKTDRgpTSFHY3Eg
	mhXN3ZzuBA3G3akODbRgRgIUIMUx/lhCqqUKi44qhkqC3RTSWWVgeK367JCLALCtsg1eACCTMWg
	7vFOEfoSVSlmb22DyNb1KCpXZ1uvdCfDeP3wEoj1mxGb3RXG7U+smD2WVzbekZWrSG5O6ri4JtY
	EYGV5iOCYiopyIaVeEk42HhwpVpXM5Hyy1hJQStEi7qkhA+hNdaA/PlaTRmYrW412wNm0/vcP5F
	658MGUkEo3T+qgBTmAwLq/I
X-Received: by 2002:a17:902:f681:b0:2dd:ad74:ac1c with SMTP id d9443c01a7336-2e510562dfcmr4955525ad.23.1790972464350;
        Fri, 02 Oct 2026 13:21:04 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:21:03 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 19/22] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Fri,  2 Oct 2026 14:20:23 -0600
Message-ID: <20261002202026.1204110-20-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

In Arm CCA, the guest-physical address space is split in half. The top
half represents memory shared between guest and host, and the bottom
half is private to the guest. From QEMU's point of view, the two halves
are merged into a single region, and pages within this region are either
shared or private.

Virtual devices implemented by the host are only allowed to access the
top half. For emulated MMIO, KVM strips the GPA before returning to
QEMU, so the GPA already belongs to QEMU's merged view of guest memory.
However DMA addresses cannot be stripped this way and need special
handling by the VMM.

When emulating DMA the VMM needs to translate the addresses into its
merged view. Add an IOMMU memory region on the top half, that
retargets DMA accesses to the merged sysmem.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c         |   2 +
 target/arm/kvm-rme.c  | 106 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm-stub.c |   4 ++
 target/arm/kvm_arm.h  |  10 ++++
 4 files changed, 122 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7accb9f55ec8..d915d80db50b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3320,6 +3320,8 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_init_gpa_space(vms->highest_gpa, vms->bus);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 22c8afe21505..f53927c87076 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -11,11 +11,13 @@
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
+#include "hw/pci/pci.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
+#include "qemu/units.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -24,6 +26,23 @@
 #define TYPE_RME_GUEST "rme-guest"
 OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
+/*
+ * Realms have a split guest-physical address space: the bottom half is private
+ * to the realm, and the top half is shared with the host. Within QEMU, we use a
+ * merged view of both halves. Most of RAM is private to the guest and not
+ * accessible to us, but the guest shares some pages with us.
+ *
+ * RealmDmaRegion performs remapping of top-half accesses to system memory.
+ */
+struct RealmDmaRegion {
+    IOMMUMemoryRegion parent_obj;
+};
+
+#define TYPE_REALM_DMA_REGION "realm-dma-region"
+OBJECT_DECLARE_SIMPLE_TYPE(RealmDmaRegion, REALM_DMA_REGION)
+OBJECT_DEFINE_SIMPLE_TYPE(RealmDmaRegion, realm_dma_region,
+                          REALM_DMA_REGION, IOMMU_MEMORY_REGION);
+
 typedef struct {
     hwaddr base;
     hwaddr size;
@@ -34,6 +53,10 @@ struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    AddressSpace dma_as;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -217,3 +240,86 @@ static void rme_guest_init(Object *obj)
 static void rme_guest_finalize(Object *obj)
 {
 }
+
+static AddressSpace *rme_dma_get_address_space(PCIBus *bus, void *opaque,
+                                               int devfn)
+{
+    return &rme_guest->dma_as;
+}
+
+static const PCIIOMMUOps rme_dma_ops = {
+    .get_address_space = rme_dma_get_address_space,
+};
+
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus)
+{
+    RealmDmaRegion *dma_region;
+    const unsigned int ipa_bits = 64 - clz64(highest_gpa) + 1;
+
+    if (!rme_guest) {
+        return;
+    }
+
+    assert(ipa_bits < 64);
+
+    /*
+     * Setup a DMA translation from the shared top half of the guest-physical
+     * address space to our merged view of RAM.
+     */
+    dma_region = g_new0(RealmDmaRegion, 1);
+
+    memory_region_init_iommu(dma_region, sizeof(*dma_region),
+                             TYPE_REALM_DMA_REGION, OBJECT(rme_guest),
+                             "realm-dma-region", 1ULL << ipa_bits);
+    address_space_init(&rme_guest->dma_as, MEMORY_REGION(dma_region),
+                       TYPE_REALM_DMA_REGION);
+    rme_guest->dma_region = dma_region;
+    rme_guest->ipa_bits = ipa_bits;
+
+    pci_setup_iommu(pci_bus, &rme_dma_ops, NULL);
+}
+
+static void realm_dma_region_init(Object *obj)
+{
+}
+
+static IOMMUTLBEntry realm_dma_region_translate(IOMMUMemoryRegion *mr,
+                                                hwaddr addr,
+                                                IOMMUAccessFlags flag,
+                                                int iommu_idx)
+{
+    const hwaddr address_mask = MAKE_64BIT_MASK(0, rme_guest->ipa_bits - 1);
+    IOMMUTLBEntry entry = {
+        .target_as = &address_space_memory,
+        .iova = addr,
+        .translated_addr = addr & address_mask,
+        /*
+         * Somewhat arbitrary granule for users that need one, such as
+         * address_space_get_iotlb_entry(). Should be relatively large to
+         * avoid frequent TLB misses. It can't be larger than memory region
+         * alignment (eg. address_mask) because that would mask the whole
+         * address, preventing vhost from finding the correct memory region.
+         */
+        .addr_mask = 4 * KiB - 1,
+        .perm = IOMMU_RW,
+    };
+
+    return entry;
+}
+
+static void realm_dma_region_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    /* Nothing is shared at boot */
+}
+
+static void realm_dma_region_finalize(Object *obj)
+{
+}
+
+static void realm_dma_region_class_init(ObjectClass *oc, const void *data)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(oc);
+
+    imrc->translate = realm_dma_region_translate;
+    imrc->replay = realm_dma_region_replay;
+}
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 5fde96f9b281..e5af5d20367f 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index d95381c13afa..b4a293911f71 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -250,4 +250,14 @@ char *kvm_print_register_name(uint64_t regidx);
  */
 void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
 
+/**
+ * kvm_arm_rme_setup_gpa
+ * @highest_gpa: highest address of the lower half of the guest address space
+ * @pci_bus: The main PCI bus, for which PCI queries DMA address spaces
+ *
+ * Setup the guest-physical address space for a Realm. Install a memory region
+ * and notifier to manage the shared upper half of the address space.
+ */
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus);
+
 #endif
-- 
2.43.0

