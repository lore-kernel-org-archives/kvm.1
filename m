Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADC381B03
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274319; cv=none; b=FZhm8GynwaSJ/9Ge5tvHdzeFKBC/yyhDWVOL9pkRklIRl2aSmB1pPCc92CuM9LEJYB1WI+w9x0e8LHMxpwtWS+oct6HBGrzCt+TPzNz3FYKSZXYp+nfupGxafoDlw3hJV/1XA3Gjozmz27LKPBS1/+xuMsPy9mJfijwHSagnfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274319; c=relaxed/simple;
	bh=Rh//DqOy/cQMvHcWs2YijzXzWxb7b3bdf1+RBdrl568=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ztdq8CVqZADYgyOOJNtbj4SmU7nX1L21nY3wPbTD85h2AxH7m2EAVSfeEjw9k1bbG98wWkr5UcupMa2sW5hkbSWFIoWsaSEvY60BOcPJU/vJ8krUTcBVuDB7OFY8swKkU0cCbqDeLLle90MlEPd2ybdAExL9ofWdPOkDvgosHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G66Phg8Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G66Phg8Z"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA6F320B7135;
	Mon, 23 Mar 2026 06:58:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA6F320B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274317;
	bh=ZUck8KRzAIHOJZRjiz7XUC9sA5Upd2lSR/QGThC5/Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G66Phg8ZIRSknyuAf6SxTBhuI7Pa5PEEyhu4NG/DulcV27GFe6HTGv6wcij1P98mk
	 vA5QBuFi2l6cojr9xpbtuo6jIBPhFiYk6A2H6Ciu+/LZjrsJsVXlfbyhla9BEkzzMP
	 SqsxJcmqAq2f7SVl87GjNXfYTHwHOs07dSnros5U=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Magnus Kulke <magnuskulke@linux.microsoft.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 05/32] accel/accel-irq: add generic begin_route_changes
Date: Mon, 23 Mar 2026 14:57:45 +0100
Message-Id: <20260323135812.383509-6-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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
index e48f4add4e..6768523147 100644
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
index 9cc41758d7..dc7c495f9c 100644
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
@@ -6680,7 +6681,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = accel_irqchip_begin_route_changes();
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.34.1

