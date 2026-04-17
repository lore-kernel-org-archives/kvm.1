Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4737F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423404; cv=none; b=D1iaQCp7lCSOvVCGPDCHjOqCG9kq7FUcsR+GzM782fNiCkjy6sAWc2bGY4tRLruXCBdVfIRAWgvd5BL5Pd3hLgSYLzh7Wppn2qIhKHUt+lYSzhog1eqx8LW5duGfnzEFKJLhDwoAT9zIz5HFpI1OgGHxkHLL4jkKqlmzZjMkFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423404; c=relaxed/simple;
	bh=C92giswQL8n6x4u0a/CttlCeOjsoSfu3rmsEl0Dh1to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LD7aWuHmyum+zNNWcj7o9e5HTUx5RyP6BvGQbq0b7Sngqt/hrUHCeDnIxsSAgsEYFMmi7fhfP1Od5Y+n5qOsZ18ZmO/XDx0kUhf2U4Xu5Oyf//zHdg0ycc2+Q5Aqqq+67b4bZ5fuUxfY/USEMpfmMIYaZCje7v9KS3MInrR66nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fEL9vQJP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fEL9vQJP"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4F46120B7129;
	Fri, 17 Apr 2026 03:56:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F46120B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423403;
	bh=UrEJXgspDcOoBFg+ngjPWDmPz3RH/NkqLVlRSZU3lZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fEL9vQJPdXVAFy2plFIi2tu6sY2Gg2yhHIhsvNjpfgw+2DhFndhyWeryD6F+hpXqg
	 IrLZd21OQwOaoLL60ZWMmRSks22RuJH5tpHNpAvCf37nXa7zqc4yKPPGPHVI/zv2c8
	 CUdoaHlJb67XPbFyNxqKmjU+lGNpW1w4rp99z0sk=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 05/34] accel/accel-irq: add generic begin_route_changes
Date: Fri, 17 Apr 2026 12:55:49 +0200
Message-Id: <20260417105618.3621-6-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A generic accel_irqchip_begin_route_change() fn has been introduced for
usage in the MSHV accelerator. It replaces the respective kvm_ fn.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c          | 21 +++++++++++++++++++++
 hw/misc/ivshmem-pci.c      |  4 ++--
 hw/vfio/pci.c              |  5 +++--
 hw/virtio/virtio-pci.c     |  2 +-
 include/system/accel-irq.h |  1 +
 include/system/kvm.h       |  8 --------
 target/i386/kvm/kvm.c      |  3 ++-
 7 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0aa04c033d..3815f6727c 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/pci/msi.h"
 
 #include "system/kvm.h"
@@ -104,3 +105,23 @@ int accel_irqchip_remove_irqfd_notifier_gsi(EventNotifier *n, int virq)
     }
     return -ENOSYS;
 }
+
+inline AccelRouteChange accel_irqchip_begin_route_changes(void)
+{
+#ifdef CONFIG_MSHV_IS_POSSIBLE
+    if (mshv_msi_via_irqfd_enabled()) {
+        return (AccelRouteChange) {
+            .accel = ACCEL(mshv_state),
+            .changes = 0,
+        };
+    }
+#endif
+    if (kvm_enabled()) {
+        return (AccelRouteChange) {
+            .accel = ACCEL(kvm_state),
+            .changes = 0,
+        };
+    }
+    error_report("can't initiate route change, no accel irqchip available");
+    abort();
+}
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index aa8f271755..fa23562886 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -26,7 +26,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "system/kvm.h"
+#include "system/accel-irq.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
@@ -430,7 +430,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
     IVSHMEM_DPRINTF("ivshmem_add_kvm_msi_virq vector:%d\n", vector);
     assert(!s->msi_vectors[vector].pdev);
 
-    c = kvm_irqchip_begin_route_changes(kvm_state);
+    c = accel_irqchip_begin_route_changes();
     ret = kvm_irqchip_add_msi_route(&c, vector, pdev);
     if (ret < 0) {
         error_setg(errp, "kvm_irqchip_add_msi_route failed");
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 79c503c8ae..35b4545482 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "qemu/range.h"
 #include "qemu/units.h"
+#include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "pci.h"
@@ -692,7 +693,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             if (vdev->defer_kvm_irq_routing) {
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
             } else {
-                vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+                vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
                 kvm_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
@@ -793,7 +794,7 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = true;
-    vfio_route_change = kvm_irqchip_begin_route_changes(kvm_state);
+    vfio_route_change = accel_irqchip_begin_route_changes();
 }
 
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5010572784..faa4a41cca 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -869,7 +869,7 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
     int ret;
 
     if (irqfd->users == 0) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
         if (ret < 0) {
             return ret;
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index a148920711..fc94c54264 100644
--- a/include/system/accel-irq.h
+++ b/include/system/accel-irq.h
@@ -25,6 +25,7 @@ static inline bool accel_irqchip_is_split(void)
     return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
 }
 
+AccelRouteChange accel_irqchip_begin_route_changes(void);
 int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector,
                                 PCIDevice *dev);
 int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ccf90b8341..fec24d2135 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -476,14 +476,6 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline AccelRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
-{
-    return (AccelRouteChange) {
-        .accel = ACCEL(s),
-        .changes = 0,
-    };
-}
-
 static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
 {
     if (c->changes) {
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 478a5573cd..03312922d5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -32,6 +32,7 @@
 #include "vmsr_energy.h"
 #include "system/system.h"
 #include "system/hw_accel.h"
+#include "system/accel-irq.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
@@ -6678,7 +6679,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.34.1

