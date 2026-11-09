Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263510;
	b=tSADF6rqHNdN0Qidhfg7PoAk0kWwbxVVg9mKdsaPgj682XOxbVfHV5ymgTU5nTJhXKjD
	 n8YunSVQQ22z6wUW0/3B9g4xgZKLDBCA/P2cr7jic3jH3Aer4BzD41dtIPyOlCgOsbAdq
	 6QMS2MsR/XpNJxlKhwiA6h8yNG04sf0f3eq6u3pXhuxE4V2UjcsVIy9Pfo/tAkORe65PV
	 rHWrcyvxJzbkszohplIWyt23tbKZUfPsUiqXq3fCdrSOuK18Gwg7B0tu+hZPiUAjG1MCh
	 j1SEYnoOx3cKMYfVZLZsbPuKrewf7jwGn+BhZapik2lBK29If94R9c4t69fR8t2ax8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wKgrrb+rx7HuVm9Uxl9r0pUFMwYXtZRcBhcO70ngG2o=;
	b=cXvvH5AXRkNrE9DghD9LkphCzIKKUfPDiitEZ0WwWR4488E3+PUjkFpxZ7zE9ZGJOTjk
	 kf+7mqMKhgfCcQXDA4qOmtFFwhO/So14UwFG/CiZ9kAdUrPR366MiZKM9SNBYAnEzR8hN
	 b2Uw9QEvN3kSp+6tHiYKOXeEg1ozvLN/soEw8u/rlCBR6jnzvkl0iwPZN/u7/VTPOEacn
	 zFIs+MfoOxuJ4dTgmdC1wmMOmv3xjnAahbN1Y9zBic3ERlFT3WoZo31o7Xtjbci0WM1lB
	 FHr2Cmd2z+stJqJ7n0V0bYSAvTfGWyKoxa1nGoVm5wOr88etVQWxwyh75CTzkGBZN8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B33dydlb;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEA60A2606
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AEA60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=B33dydlb
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so629401b3a.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263509; x=1794868309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKgrrb+rx7HuVm9Uxl9r0pUFMwYXtZRcBhcO70ngG2o=;
        b=B33dydlb+FIn6NSrF2kVDzRQKV9gFEzJ/tJaG7ve6EFoBr8WrWmqwrahSRT/8DYZzZ
         d7FJzwe02UFNBgfMwLL8Oayzsm+IEqW0ryLddlOF8+gsIOX+idkqAYzAk5cgvwiOnrGG
         GdwVUX/U5mq75Poh6tG73tMCNGSu2NTwn3rbMQSExonQwazWDNbRT4p869E8UP2e75VJ
         BSZQ1V8eZGkeNmWm8ldd/ion33J1ONmZ78vhGWanQimzdhqfvkssVJBtUcWRfBhKGLqq
         yk51H7gfV2+JNCBw/xqJVrbYkwGK08LMOGho1ry4jTukLijt2H0E1B/Ra7nQ//GlsOKM
         jbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263509; x=1794868309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKgrrb+rx7HuVm9Uxl9r0pUFMwYXtZRcBhcO70ngG2o=;
        b=bnV1gC+oDP7QPggYbtw4L9NAwbKW5GIN8F2YO2+4tdPoboPPVIgsllSrz5lgtiOIEQ
         djOcn8xNlJb8j81ntW+CkXL6FQfeqh0Hnc7GSX5g777tOWDR2CPAibV361B9jCVrgekv
         lTiHVIKBRJGCm60ea/bec4g2RE9GnwvvCYaF00ianCdR6t6UhW7sXLPQnYfZRaRbAW6d
         XBTB9A4VWkNWgYz10VZq15+TY72gKWHj6XWYZbUJxilihmGGu741R6QsGRQpYdY6eVe1
         HoUnqlTL8SR7kByjrtpZVtwDvd1grsnH2ixQrOu5ljWIwU545OLE3BvMe7bocKKaEexc
         gIGw==
X-Forwarded-Encrypted: i=1; AL+hErEJq+/DPh/becXXzFHv931XZRF9H+9ojGExDFOZgBa6WXqX9QA/ak3zeq0CYr0+xijeZkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/bELRmjeBoL73pmgYkl2Ek++h3KSPQuY0wGNHDkkpgz+IHneJU
	N5fVfXptw1r09qGvD0/3KFAQZzv3L2bVYZKl1JVRWSwSzA9GOCDmRe/+H/uwzEXHdBg=
X-Gm-Gg: AYBFou35nQ2I5DIfjbd+TqZquWbw4UT+GIOMN2bsve5UcsURwm6m/BzBhJq5MS34EET
	c4hv53ODqEyAvCDRece8j1bZbNubeYKkuJRcbZjOryMK3RAySvmz/XKfFSVIVPY0EAeUXNlT6d+
	WMJRSGb5Y19Ifrapqlb0sBzi7MbyrFXi9yvTq2UOhEYErUWdlg0HJPZ414hstdJgn/KX2IhkvL/
	TWQJm8HvDpZd+m1QDsueW8UP5+2X/orKXRQHGXgnPfph8+QI8EFTK3fLXgL7/b2BylbnmkeyY3x
	pYU+DP2/5hGZNPDmTdyvFTAeaV5tTprh7GpCLOOsLX2PGdiXYG2rs8+iRAKlPPkIW0b3pgiUrrz
	wPI0v1L7Q6Ny3RBUzkfko1kbPfnCAG3N75nFYi9eHUaCEZbj33eIj+qbaIvLLM8dCtyhw/cW7Za
	slH6dhYOuY9HiWvuFAUswQFlOgnj5yhVu26CbLAZ4xqlaJQ0UHlVFlvac5hDaVovOrJ05HpaA/R
	nvU5DQZ8vxbaVygmgrXYfpQU+o8vC5gLfpCfErSG7Q+CugXVmVG2c1XOILyyopfWvFEbj23/ept
	skNIVfXaHtUcUBZFo0CfvPMQPqUfgIO1sCvC9WH+FZU21+NMi3qCXw==
X-Received: by 2002:a05:6a00:3d0c:b0:89f:9ea6:1de6 with SMTP id d2e1a72fcca58-8ba86b8e457mr855357b3a.24.1794263508926;
        Mon, 09 Nov 2026 14:31:48 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:48 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 20/23] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Mon,  9 Nov 2026 16:31:07 -0600
Message-ID: <20261109223110.1619504-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index dbb5d2d6fc0c..db39d08c8831 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3338,6 +3338,8 @@ static void machvirt_init(MachineState *machine)
                                vms->fw_cfg, OBJECT(vms));
     }
 
+    kvm_arm_rme_init_gpa_space(vms->highest_gpa, vms->bus);
+
     vms->bootinfo.ram_size = machine->ram_size;
     vms->bootinfo.board_id = -1;
     vms->bootinfo.loader_start = vms->memmap[VIRT_MEM].base;
diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 0996cddf0849..3676e34c494e 100644
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
@@ -24,10 +26,31 @@
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
 struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    AddressSpace dma_as;
 };
 
 typedef struct RmeAlignedSlab {
@@ -287,3 +310,86 @@ static void rme_guest_init(Object *obj)
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
index 88cbe8d85c41..d17980cc8043 100644
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
index 9c7e7f654a0b..4dcb661e4447 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -241,4 +241,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
  */
 char *kvm_print_register_name(uint64_t regidx);
 
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
2.53.0

