Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE33CD8C9
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695312; cv=none; b=LtIG4aVBI2Pf1u8o/xvBHazn6roQNaDgvpFX5rSBwng/WbTJxTKexlZ+Wv5PyrfBb9jTzwlF7d9CPyG+Q6eYLeF04XcwnCL5rzZ0A2QvYa91VGK0cciMiUoK/h0gkSHeMKsPjP2t++63HeYQFxDetrjfFOv+pcmsHwVnCGT47yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695312; c=relaxed/simple;
	bh=U+vblCmjOCOxhhb5wr3L8Ad3U/OQ9jFXntC0Fk/bxfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llctxei/CXMm7wU0P2Lc5svi/2os8GbMHulikNRFFtUH4mvoXoUoEy+VjCi7zKc/5bSp3//hCfiWDQkfPQtmxzLDaquov4Mov7DajPn8/exofXV4C3ii+XaSkgohkhUVLeRe/bKppBfCcZg+zlXFoaGJW9t67lNydk7t0Xu3jl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNLv56ZF; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNLv56ZF"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso3396925ad.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695310; x=1788300110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yIKyxHY1FpDhrdAudjGG0Q+3wu/oS+95ntpmkMvDrBg=;
        b=wNLv56ZFPWLJlQrMN7UyOS/FGLrsGkbWXSM9Sbd6VlwA/fT0kHcyjukI5wPdNOYeFz
         CdS1cmfntysKs3Pe02x0cm6iLtp4jH8canzCsNk4kBOBtXq2/tWma90+eZWT8IopeM2Q
         NY2Ft4+5dO3J7tb13zKY2At3mvOtDgHUvmOW5kF4mUaRgwCIEzr/NxxCAS/4OMFSTnfF
         eG50CS1xjKoQbsydNm9fITKrRFn3TFUKdpPjWkqoTvSVAsi27SDW3YZRnF/v2E5LHe/X
         ecGzlhvMKEReSmqcYFcvA3RYjcWknb78R84px0v1k7m/LiZ6k2Ap+FJmjcC+U4a7si1G
         vQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695310; x=1788300110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yIKyxHY1FpDhrdAudjGG0Q+3wu/oS+95ntpmkMvDrBg=;
        b=fGo5TZTNTDDeWxAyhzSyOntkLxs36iOxvMhBwu9TCw6hJ3wYeKCNvjL6bdal+elGDR
         NaxrjiVhCVMNhfiMecnLZTF8Ji6Jr5iHtS1bJVtHu+FbA78WA21Zn+4nle8rdMa1Z18V
         5+si07Io3t+Tk6d3St1WWY7HnHEuTbFXoBjqyoDct+bimnORr+w/BPtH3lMeN6ZF8ALX
         CEKVdLe0F02mBrVe7HDR0NmP0XksdQvOporA1Zb/KnY9Wfw4bT96qAIwMWDhTp4EIoko
         yAvqR0/JSBARSJDZeu61cUNlh8wUrZ+5Rup8XuyECKm38k9a+Ra/F/7OaM3gkm8gyhOI
         u1aQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq67ZI/pbGLKICHlJGC/uxeaZ0u+a8JPrAv1vh1ewbyjycugMxhDp7/wckkOUc1qMAUKe0=@vger.kernel.org
X-Gm-Message-State: AFuF++mVmO/2jPdMKL0qD3Fo7hdRw5rGJQoRMSl+RfkQHTpCkS0nNbWz
	TGb8a7+TeOgKYqMaDLnCf8wCnSIAzU65VcCrpElQ8l7NYq3JPpbz036SG2EF90MqchA=
X-Gm-Gg: AR+sD13gyOYIxnea7CoEUhuvi3Kn3VC3FWAaWmLtgHGAsMj/dMiAJFCOocIV6NgJRVN
	bBCVGZHSmc3MWrNOFAIGpw0sOKhU3lLnufJHpNouOXDKwU3/kebwkifSjCNfx5x04advd9pFcUa
	xs/6bzfOLlc10Q89QpdS7RNrh9wksCHHQFtR13gLpf8bUPLFjT7Uyw6s/50CNZJFa/sSwsVWle4
	Rrac4hMJ5e8L4BXHXX7I+d97sYX+rVBz0yFhnUSyH4n6npkycVNtBakLCrx3MoVs1XSTu0t+zKL
	GRc/th3JasCTGM9JBUNIqsa+Dojz7FmR4m+ZlNX+h+lHWM+XgtoFJm7SfiDpd3OZLSxUPrc4UmS
	J/yiX4PfVT0o9Haqoj1QH+ymGxee9moo4hyVfZ6uYN61K0j521stdE5qT1rbFIQ8fGZh5ZrHF/1
	pNOlo6gLOZ+4YlnUSHyNGhakmtdMR8pjnuiTB4YCgUIvYjCKEJbtljhtZBj2/YTCTx16EO9IpI6
	Fxf22ejMJuaCP0=
X-Received: by 2002:a17:90b:2ecd:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3966d484a97mr4362369a91.14.1787695310119;
        Tue, 25 Aug 2026 15:01:50 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:48 -0700 (PDT)
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
Subject: [RFC v3 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Tue, 25 Aug 2026 16:00:58 -0600
Message-ID: <20260825220101.3443954-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
index b799e5f44432..74df4b0d60f9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3277,6 +3277,8 @@ static void machvirt_init(MachineState *machine)
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

