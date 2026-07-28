Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE604734D3
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266842; cv=none; b=kiwQdsNLRJsSB3zaqU2kl1x21nymZTl2Rt+Npm2JqdwZoqowBkV2oF4R0LQtgAd8QOSKUKMbpENNC+vELRlgoNdzLSunNpOsXkV4+lNmLUhadmjhJFzbdDKRLlyf/Ig+EB+CqRJKZDiFBtUO5ARPERbZjfIXQCcFHpbw+xjmM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266842; c=relaxed/simple;
	bh=6NBJ1j5PYHEP10H3V0hTPKXbzQ3LuNxD6Kn1Blx0c7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tudpWJZZ8u4T2GhO/fpIFBR5XzuH1z1K9OSkCxdJGhf3mIbdhuO5LGJzj70w7k8dCXfH9lnXCZr9FAoPogW5zaz/n4/FoleLo7b5NConG2Cp283Ngf3BdENS0KSZqtfceh0nIdwsyvxB+Jt1XbHQcimk9LiZBfKasX3UsMERuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=coichdLP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="coichdLP"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so210906a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266840; x=1785871640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYPotfW6kht+UmRZFPn5+m79E9+yzPHwQhZ3Fc3kQx8=;
        b=coichdLPNV2pkc8h5S3ayhsOIGSZR4Je6fuLVAFZTv6abbWOjKT1xCi3wQpIcU1pqs
         je3fGlnC4GYR0aplCTOxzQYXCjrdFlT6pEpxadSGW/wWpO1oiSp8R2srrEXI8ItVPE2B
         ZKiZVK9Ibpm6kOKSf6n7zYWkEYFn47xuhsjpcF5wGJ3LK63k1A7omfKfsPC98Wc417pU
         drcc8qwNxZVORB9Iwpr+P5dcISVZ/RpmxLrUyrpanlOlZ/1ONYgtIy72f4Y5+TEYoDXW
         +Hnv6WdXSFhRqzKWKSBChsniX81I8AufllaHbj3DFC7kVXgrQZZzbhyZLj5yNdmc6qkS
         1biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266840; x=1785871640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HYPotfW6kht+UmRZFPn5+m79E9+yzPHwQhZ3Fc3kQx8=;
        b=gykezq5OpqvfdP1imfHp8Krzw0EEaAadoT7XbItFCSoOYujRdVvtg1IJn+3G84i1Op
         Mw0T816zD6lbsL/9P3N5eFpdFdBdzY4k0CVXICJ8ODejsklj95JCLrTt0VriBXNzJjpF
         Zf66ZUqEBfrHksyM1zrtk0GSjlPLsqaGJclPAcZchvCUIpFn22xW0EJPTDRQo4epzctN
         jns4MABsOgqkpIg7u2ALGXYurEBV6GS/vVdKNh8VqFjjSIWT37r4tUWx6BO1PiOK7IwR
         N96iJi6MaTL1gM9YX+HoyjE7Q7S1uUaCsPf/SY9VKuEcJ2tBvZAHXhj1K0KEQLx8+t4V
         wqLA==
X-Forwarded-Encrypted: i=1; AHgh+RpowtfLFMUzsC20FezJ6lk58RoFQxYsuF70PlDW7weXbSAkhkZ99mEmfNTOUsm308bmdrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1QJoNhUzBx59nsRSl5l3HlkGFcuZdkyuunH4jOLB9fFRbMtBy
	fdzRmhNXCrFFFNNEMg5O5OIoV/cVJX2YL+JK9rpCP5UBgLl+9XrPuzNUL3vJZDIOINc=
X-Gm-Gg: AR+sD10lflqwHpVToi50P2bbQIpg1RQeuEViTrBiU51thRx3uCv3zwKxEDlFWLtTU5R
	cTnNK3JwPF4HPl7S9pulSSznO0Mm0e9xyLbDuJ9HHFL5oBNwTRM6zeVBwNnGvrd2xCvMZ0NP49H
	TAI/5uqm9A0giRssavz0PmMLCntiY+ExGJvFVR5B+QAsbBM5j1QunX7Nl+A+gblbALLAnZU6f1O
	7oiPHUu7js+n76H76i4zVhP2NyomsMUcbj6y5aq+0BaaNSdH9V2HWYWxlWyhmgNpUdQzlCgR5bY
	RbbrJLVw/QIbgGGRrNWGL60v2GBPyUkpM7WJprJSJO5qEVpkKGMubnyrHNeImEZbB8b+VxPky1j
	xgqvVQY/KX6jqqG2tNRxcjm/JgjbMg9ckw3HGvCXTOikW+HSR7CB2oXdpv1pHmgz3YDRvrmhflZ
	UXWrCT+knx7zIhwe2hDHb3Ki/QWYMs
X-Received: by 2002:a17:90b:584f:b0:38e:7297:a92e with SMTP id 98e67ed59e1d1-38f6a26e75dmr3724141a91.9.1785266840446;
        Tue, 28 Jul 2026 12:27:20 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:19 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 21/24] target/arm/kvm-rme: Add DMA remapping for the shared memory region
Date: Tue, 28 Jul 2026 13:26:27 -0600
Message-ID: <20260728192630.240375-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
index ae663d051ac3..5b1608c23462 100644
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
index 335ad60d0f3b..7b83de2f956b 100644
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
@@ -35,6 +54,10 @@ struct RmeGuest {
     ConfidentialGuestSupport parent_obj;
     Notifier rom_load_notifier;
     GSList *ram_regions;
+    uint8_t ipa_bits;
+
+    RealmDmaRegion *dma_region;
+    AddressSpace dma_as;
 };
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
@@ -205,3 +228,86 @@ static void rme_guest_init(Object *obj)
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

