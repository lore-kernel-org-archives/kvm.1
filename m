Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413053DCD8D
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464234; cv=none; b=ZPQp9CZi7HGZiaLkE/cQpfk85KDeZpLXDaWfLpetFAjqqVuJj6j0jqOaKjizKV0QNuA+7AFsWqrNmX9/Hn8yPmWrsR18S0NPpZxlwKl/tEHO5mG0VqNOos30RWqHNb+E/vPWXXTLJkid0+Qwe77we6k1Ru7LI11GJdM6b0LbNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464234; c=relaxed/simple;
	bh=gF+PAwO4ENi+A+UkeOW5SRt/tA4t8R40cYVUc+KBRSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGNN1goXv8H8W7beysO5ACZgHOtCObDugBKk2FdMNsGEmppMLOeJU4bqI0oKqUXbV+UnJJ6XxrEOCHGClhsjIvYa5cEWCi9uNusbk9GHD6zi5MOoX5Cm6FDZpDYPrp/heI0ZG2HdWajYdvgM+DANJ2By1vg1nYJ37+FjRtpxxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AZsdwz2m; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZsdwz2m"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso1112375ad.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464233; x=1784069033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEk98N3PX15q772/PbHQHTfPY1+SUtqFx9RzdGfiXt4=;
        b=AZsdwz2mTZ4wH9qMEBb3GnqPavwYXU1VKy8ljCFkTiEv+/pRUu6kFaIhMREKH7CL3E
         IrVVstZxXcnslB43HinZkd/7PqmSMAvO1r17XYEc5TISHRkKogcvNMvNWoF//yGGC+nl
         UZZxQGaPBceqgWQ96p5EPmqhWzsg43e9Dkdbgoo26iNJy6nI9ti7Pky8WJw1FNdREPyz
         K9stuXH7ePYI/lu4c91cogViBTI0laV2tJdc7LNGfmilyWuTTuWdIfhplfBFzLOLRiqr
         SV2EAX04HJT1oJzhzbBwEteoVwcORIKBdTwnvGWOFZAZcHw+2YHiUkXRHTCZU76Q+pxA
         KP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464233; x=1784069033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zEk98N3PX15q772/PbHQHTfPY1+SUtqFx9RzdGfiXt4=;
        b=mcBi8rFS1rlkmjnAjcF+97iblsq45Zck122EU+nmeJSjpKYHbDMUsd9274U3NaNJzW
         7y2Qh/D5DWNF6ojagRUn1iDyUm5DrqDc+21JbFFYMPMYGaDAxg2fFyYepJEzZtQffafY
         eNg1DRfUNWVO7jWj3j6d5IY6y6XBofuzUa+8X8wf0r7oZeiApPgkGe52iirdZfdxvPER
         p/0SKAB/e0JrG18eEd4IbqWWGj/LfotoGSBoY2TJJOhAvlNbhDBA6woQ0gmaQDlOTCzx
         HHs66S1rjgfqix/cIvx4Zka0hwSGKy4eTNO3ucaoj73GhxN37kqRVwGvgyamx2ultusG
         xnyw==
X-Forwarded-Encrypted: i=1; AHgh+Rqn4DyHyOLC0f3Mil7oKhVKbcvQklkr/HMy6ATH7yi6YKoOzqWGpDjlVoL2Invf162Romg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4QviqxyosQUH7wxV5vdSCVjX8Bj4L2HMnz7bf+daWKikf9SFa
	xoE1nZZHl/bgEzvyU5bjyIAkzCZjwHUUR5QQkhq7W/e4VL4Nvn3jJGPZMjuqg/Sho38=
X-Gm-Gg: AfdE7clxXsaYkbeuWxWEYACDtOJ0MFydkoyHsH8EZNRiZTT7RbhAgtnPAUU2K/XkO7r
	ouzCuwnWjE83D2pZ57MouNIcTivKlmspCn17Wa7UUZoo4FupprPbv38xdYbp1nYx99iNOE8U7mb
	2qcbPAiJcqeAbJO8pOZLGyE/Jpno0ZbUs4igHj7oGMlLf2X+5foA6mpoTRnQ7+KNSZiTI3bP2B8
	05qs++CLKK8DuVOON2I5MYVDCSzvq1CJ121txg4O5yoawMpQ6FWY5U/tQ+M+McJ6SMopOLttrWc
	Uj4RWyp/xsoR1ECgS05nlUN089ZPxkK3mkUqt636IHxNe+VIB4MTWxzGIco6yBZLNpTaIxsopVE
	YDpzsVCbrQYKjBIpOS/V+Bs/pwJpJiMcNRY9mXyBvMPahS8t0thcDOExYT5cAkZe0CJy5VdToP6
	/bWpVL1hRcJRIsuHQuaVNzmwi/vgzq5/WH1kEXElc=
X-Received: by 2002:a17:902:dac4:b0:2c8:1c3e:9636 with SMTP id d9443c01a7336-2ccbf07a9b2mr64568705ad.25.1783464232563;
        Tue, 07 Jul 2026 15:43:52 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:52 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 22/25] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Tue,  7 Jul 2026 16:43:03 -0600
Message-ID: <20260707224306.1202330-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
index 8b79c3ea28e5..a8d777d63cd7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3325,6 +3325,8 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_init_gpa_space(vms->highest_gpa, vms->bus);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 58669f4a50f1..7d5f37ab9230 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -11,10 +11,12 @@
 #include "hw/core/boards.h"
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
+#include "hw/pci/pci.h"
 #include "kvm_arm.h"
 #include "migration/blocker.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 #include "qom/object_interfaces.h"
 #include "system/confidential-guest-support.h"
 #include "system/kvm.h"
@@ -25,6 +27,23 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
 #define RME_PAGE_SIZE qemu_real_host_page_size()
 
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
@@ -36,6 +55,10 @@ struct RmeGuest {
     Notifier rom_load_notifier;
     RmeRamRegion init_ram;
     GSList *ram_regions;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    AddressSpace dma_as;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -227,3 +250,86 @@ int kvm_arm_rme_vm_type(void)
     }
     return 0;
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
index 790e1940fd8a..38a2b819fa5c 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -46,6 +46,10 @@ void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
 {
 }
 
+void kvm_arm_rme_init_gpa_space(hwaddr highest_gpa, PCIBus *pci_bus)
+{
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index c7dc45595159..4716785e0fc0 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -277,4 +277,14 @@ int kvm_arm_rme_vm_type(void);
  */
 void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
 
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

