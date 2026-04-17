Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D229827E
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423401; cv=none; b=gg8uDvj18sTWl1MYwV5le4wTX8khL97daLX7nbBxA5qyYw4ZST/1R06SpfZqbfoF1SNfm+m/VaHnKoRrDxN8vSDdh9iOtwNvzLU3+v+64QsZMGX/WEnQKV7SD499Vf5WCELHT6SDvjpbojXePyw8CXuwU/fCO/1gf+dZndtXSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423401; c=relaxed/simple;
	bh=/ArB1AgdmAOLrhuNHWdAcYqcYVq9nGDwKlT+dSwUV08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vw/K+4SbP562lHrXP/hSgN7M0anLnN1veuQN0dTBvBFTZZn0fDma6RORYifWgZ4n0uk8IHcMFaP/bszP9143siEuzW71tg8rAocWonZZ1yz/1lcjXeliS9CTohTG7qo4TXac0epBFlAddE9G3w3KEZCsB/Jo1gKTaCjN+Ovokrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RIZwG9bh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RIZwG9bh"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D32D20B7135;
	Fri, 17 Apr 2026 03:56:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D32D20B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423399;
	bh=gdJ6bc0jDPbL1vpVuF0aTcfrjU8S2va52X+iE755j4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIZwG9bhgESNWloKmcgz7NfweWpVExJR0h8Tjc9jy1Xo+J+wu3KEP7mmiFJbSGQQc
	 nxGKDWZfGCBup1rLIAC4XCBdMcGAfyXQwA4Fc3ssINOOwnOrCkBcUOnB1VJRwI2kwV
	 qu9Pk5SWrToUFroAJiiK4JP2hw4VDssS8tASS31E=
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
Subject: [PATCH 04/34] accel/accel-irq: add AccelRouteChange abstraction
Date: Fri, 17 Apr 2026 12:55:48 +0200
Message-Id: <20260417105618.3621-5-magnuskulke@linux.microsoft.com>
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

The accelerated irqchip routines use a record of changes to batch
changes when programming routes.

Currently this mechanism is coupled to the KVM accelerator, this change
introduces an abstraction that replaces KVMRouteChange and keeps a
pointer to an abstract AccelState instead of the concrete type,
converting the state where necessary.

This is done to further align the irqchip programming in the MSHV
accelerator with the existing KVM code in QEMU. Subsequent commits will
introduce AccelRouteChange to the MSHV accelerator code.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c           |  4 ++--
 accel/kvm/kvm-all.c         |  6 +++---
 accel/stubs/kvm-stub.c      |  2 +-
 hw/misc/ivshmem-pci.c       |  2 +-
 hw/vfio/pci.c               |  2 +-
 hw/virtio/virtio-pci.c      |  3 +--
 include/accel/accel-route.h | 17 +++++++++++++++++
 include/system/accel-irq.h  |  5 +++--
 include/system/kvm.h        | 21 ++++++++++-----------
 include/system/mshv.h       |  1 +
 target/i386/kvm/kvm.c       |  2 +-
 11 files changed, 41 insertions(+), 24 deletions(-)
 create mode 100644 include/accel/accel-route.h

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 7f864e35c4..0aa04c033d 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -16,7 +16,7 @@
 #include "system/mshv.h"
 #include "system/accel-irq.h"
 
-int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
@@ -42,7 +42,7 @@ int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void accel_irqchip_commit_route_changes(KVMRouteChange *c)
+void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b..4e4234beff 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2359,11 +2359,11 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
     return kvm_vm_ioctl(s, KVM_SIGNAL_MSI, &msi);
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     struct kvm_irq_routing_entry kroute = {};
     int virq;
-    KVMState *s = c->s;
+    KVMState *s = KVM_STATE(c->accel);
     MSIMessage msg = {0, 0};
 
     if (pci_available && dev) {
@@ -2506,7 +2506,7 @@ int kvm_irqchip_send_msi(KVMState *s, MSIMessage msg)
     abort();
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6..32b4b07403 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -44,7 +44,7 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev)
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index c987eebb98..aa8f271755 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -424,7 +424,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
                                      Error **errp)
 {
     PCIDevice *pdev = PCI_DEVICE(s);
-    KVMRouteChange c;
+    AccelRouteChange c;
     int ret;
 
     IVSHMEM_DPRINTF("ivshmem_add_kvm_msi_virq vector:%d\n", vector);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1945751ffd..79c503c8ae 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -51,7 +51,7 @@
 #include "vfio-helpers.h"
 
 /* Protected by BQL */
-static KVMRouteChange vfio_route_change;
+static AccelRouteChange vfio_route_change;
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index bcab2d18b8..5010572784 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -869,7 +869,7 @@ static int kvm_virtio_pci_vq_vector_use(VirtIOPCIProxy *proxy,
     int ret;
 
     if (irqfd->users == 0) {
-        KVMRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
+        AccelRouteChange c = kvm_irqchip_begin_route_changes(kvm_state);
         ret = accel_irqchip_add_msi_route(&c, vector, &proxy->pci_dev);
         if (ret < 0) {
             return ret;
@@ -2695,4 +2695,3 @@ static void virtio_pci_register_types(void)
 }
 
 type_init(virtio_pci_register_types)
-
diff --git a/include/accel/accel-route.h b/include/accel/accel-route.h
new file mode 100644
index 0000000000..07fac27e2a
--- /dev/null
+++ b/include/accel/accel-route.h
@@ -0,0 +1,17 @@
+/*
+ * Accelerator MSI route change tracking
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_ROUTE_H
+#define ACCEL_ROUTE_H
+
+#include "qemu/accel.h"
+
+typedef struct AccelRouteChange {
+    AccelState *accel;
+    int changes;
+} AccelRouteChange;
+
+#endif /* ACCEL_ROUTE_H */
diff --git a/include/system/accel-irq.h b/include/system/accel-irq.h
index a2caa06f54..a148920711 100644
--- a/include/system/accel-irq.h
+++ b/include/system/accel-irq.h
@@ -25,9 +25,10 @@ static inline bool accel_irqchip_is_split(void)
     return mshv_msi_via_irqfd_enabled() || kvm_irqchip_is_split();
 }
 
-int accel_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
+int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector,
+                                PCIDevice *dev);
 int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev);
-void accel_irqchip_commit_route_changes(KVMRouteChange *c);
+void accel_irqchip_commit_route_changes(AccelRouteChange *c);
 void accel_irqchip_commit_routes(void);
 void accel_irqchip_release_virq(int virq);
 int accel_irqchip_add_irqfd_notifier_gsi(EventNotifier *n, EventNotifier *rn,
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda..ccf90b8341 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -18,6 +18,7 @@
 
 #include "exec/memattrs.h"
 #include "qemu/accel.h"
+#include "accel/accel-route.h"
 #include "qom/object.h"
 
 #ifdef COMPILING_PER_TARGET
@@ -183,11 +184,6 @@ extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
 typedef struct NotifierWithReturn NotifierWithReturn;
 
-typedef struct KVMRouteChange {
-     KVMState *s;
-     int changes;
-} KVMRouteChange;
-
 /* external API */
 
 unsigned int kvm_get_max_memslots(void);
@@ -466,7 +462,7 @@ void kvm_init_cpu_signals(CPUState *cpu);
 
 /**
  * kvm_irqchip_add_msi_route - Add MSI route for specific vector
- * @c:      KVMRouteChange instance.
+ * @c:      AccelRouteChange instance.
  * @vector: which vector to add. This can be either MSI/MSIX
  *          vector. The function will automatically detect whether
  *          MSI/MSIX is enabled, and fetch corresponding MSI
@@ -475,20 +471,23 @@ void kvm_init_cpu_signals(CPUState *cpu);
  *          as @NULL, an empty MSI message will be inited.
  * @return: virq (>=0) when success, errno (<0) when failed.
  */
-int kvm_irqchip_add_msi_route(KVMRouteChange *c, int vector, PCIDevice *dev);
+int kvm_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline KVMRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
+static inline AccelRouteChange kvm_irqchip_begin_route_changes(KVMState *s)
 {
-    return (KVMRouteChange) { .s = s, .changes = 0 };
+    return (AccelRouteChange) {
+        .accel = ACCEL(s),
+        .changes = 0,
+    };
 }
 
-static inline void kvm_irqchip_commit_route_changes(KVMRouteChange *c)
+static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
 {
     if (c->changes) {
-        kvm_irqchip_commit_routes(c->s);
+        kvm_irqchip_commit_routes(KVM_STATE(c->accel));
         c->changes = 0;
     }
 }
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 75286baf16..1e96b3a606 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -21,6 +21,7 @@
 #include "qapi/qapi-types-common.h"
 #include "system/memory.h"
 #include "accel/accel-ops.h"
+#include "accel/accel-route.h"
 
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..478a5573cd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6678,7 +6678,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
     kvm_gsi_routing_allowed = true;
 
     if (kvm_irqchip_is_split()) {
-        KVMRouteChange c = kvm_irqchip_begin_route_changes(s);
+        AccelRouteChange c = kvm_irqchip_begin_route_changes(s);
         int i;
 
         /* If the ioapic is in QEMU and the lapics are in KVM, reserve
-- 
2.34.1

