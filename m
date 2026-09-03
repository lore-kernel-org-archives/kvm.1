Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EABE4FECD5
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464229; cv=none; b=BT1QlMaEF9MNonUq9U9+WO8Du0ZVU5gtziuFY+zm8f4hl3L8jXHxfzM4fHF9lGbkyM51KRG5YDthSImMKBcNYD0gTuIIc6dkwkfSbixXSXprzb1TjoZnlrWVdfxyduGWjf1GUk/EZywWJv14hCwW+gtMtCe2e0ZKz28SIIKQzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464229; c=relaxed/simple;
	bh=wKYxy+eOM9XrWN3fL2f8AQDWflnBFtggeHyyQKaA4Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKVc6JR+ZSepaw3IWsyyo1NXoPCNqOaLf5DryDaz8YY3nQ1WaDc1Gm+Cv36m/JUJsPYpZO3HBMmX86D85DQi3Up1SBdgLc9igyBUem1dr/dNJ81niAMX0JIdRYdc0D02Lg1uxTVHsuG0PtOyV5mvJ05n/+W8qHfMwxZCy+BGyWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2zXDdFP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2zXDdFP"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cbee846deecso461027a12.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464211; x=1789069011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pkg0GmhggtDiv6+ieSF/bEGnhsOlgxQcXDTKuc0WSSw=;
        b=J2zXDdFP2v3DJkaFTKbgjy8agPvo/FYS07m9KJPJbgQRU9Vl1kedvrXJEjv5x++1qd
         NlUXe8VKREZIyu4uj8eCW8HSdlCeBMv2/oCYVo64czDvNMtIz9funRoERugmyKozR5i8
         bxyIbvCjMrI9HGnsEo+aniy8Nfkle9YpZWRIg7ct5qRVR/yGk7yXnKHMAjWAZfNGn9TD
         JSBZAZkCWpyFfkOEV2EvfPBPQHPp4A2XO5iSDjidTn056VByU/61p1w972qs3t4izdnu
         sIORmUqf/39L6mHdjZfip9w5AVg8hqwnGNNBJ8h3oTgSp4XM8ePgoH2ridfg9jfkwFLm
         AYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464211; x=1789069011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pkg0GmhggtDiv6+ieSF/bEGnhsOlgxQcXDTKuc0WSSw=;
        b=gmLTwD++XNEb9FwDkU3hNB+o6BthhG8UQtqwMDhmQlG09rnWZgdHkAdH16AOviClyr
         IOxORUukiJugYhYMKiMgg2iH030RVP9mUOTMVjt9wXrWMC6JKTNZGdDX8UVasVKPHctF
         YHNVDLH/9m+uaVROdSM39FD0tGT9K2xeVI+qqvqIHSNowEwtly5wph8an+jsMEFsVGuA
         Rq8ZOwSLFq2FJ4bpeqCTvKXamHQd+Vg3VjOYKfMppkrbqTFkyu6fvEmcvgAgz8JTS4JB
         4zQrW+YnodcCsmMswr0s03BqTSyk/7bm0TU/ZdvPhBk29rtEJ+m8ZCG0mp1PnOI/JO/o
         nSRg==
X-Forwarded-Encrypted: i=1; AKwUvBy4BkaYoAug/Eu2/Mu4CsgdidG31jHDBQ+Jzf1yJ96CJIO5cjqzP2Q+Fn+HZB9/snpZilg=@vger.kernel.org
X-Gm-Message-State: AFuF++lg516AjZIVspTWxRWMY9arLZEuUrdiHdbpaDBskV5NMoQOH7wd
	UDF/XSfs9VLg5TE0JQHc5BJrGAO/K20wvr0YBJ2bLSIUXeG3IeBhaQBn3CAv3TtWsdc=
X-Gm-Gg: AYBFou0gQKRLnl5fW/tq6NWX5XXyyF6GhCPhqAzQg70kFKuAHkxZ7I6Dt9FW8yLp4Hf
	WhMDMZB/JZLZqavw7jNo8SGedZqTmx9GiEfXogr/ustpr1w0SypzAeyNPMJd2Wl9f/LTjnokJtE
	88M6rRcPYyRTvAnkqJd5f2p9XJzJebCENYSxEqNYL9r6VQhepHiOpVdRC/eKLEM/duXA7ZhtFRq
	XkqSEDC1cc3GdnRqUMIZeYZqPxMTca5gQ9l8oYIBYwS9k8LkLg+VPNPmUHW6b6mqRi/e4Uof/G5
	KipcyMZgu3oIyqmcE2HSE2i3up6OWDwLnb1By0NipbT9/6LqtCFElnxkO07jcS1ovCECwjmWy8r
	RwP2dgySxzfEcc4CqGa5IVPOI3FUXUJnFy4E1xSW7EACqcxAvxnzalnLH7Wi/45XP56Dpx9+8vD
	gARYayCWL4WEYWWrykRMhZwUlbaL5ehUDc/5eKUmE/sUal80OdPIBFWG3ofe4kQ/KOvhYwizhX1
	7UGDtTshmR2KwE=
X-Received: by 2002:a17:90b:570b:b0:398:deed:6e1d with SMTP id 98e67ed59e1d1-39b260de5bbmr1362788a91.5.1788464210804;
        Thu, 03 Sep 2026 12:36:50 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:50 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Thu,  3 Sep 2026 13:36:08 -0600
Message-ID: <20260903193611.1058589-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index b1f425f8935c..47f91774e71b 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3327,6 +3327,8 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_init_gpa_space(vms->highest_gpa, vms->bus);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index c082a5d8f3d1..4adfe37a7e8d 100644
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
@@ -26,6 +28,23 @@ OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
 
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
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    AddressSpace dma_as;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -228,3 +251,86 @@ static void rme_guest_init(Object *obj)
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

