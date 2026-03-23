Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CE3B2FF4
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274322; cv=none; b=Zc4qb+AHVUMZCv6v98BurJVL7CpYFi3k3lyvOop7JyePtAXLvzzInDwV3A5akrVxJYwZESzgBln2ipNA7Z9qRAIc9Jwx+vABtVMi84IxReBknhOmURj8G8o6iFFjzfutOAkW3jEf4157kne6osiS4ohNuaxeYPAVdkHMGdVf0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274322; c=relaxed/simple;
	bh=hIDWKLt7x6YTzw/8KMtcBb3BYscwl7jYlemQacmaG5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TMtYOdKB6Kh0QBkvo0F1hnRz4ewyh5nGaVpQLbnYPoMwBAgbnGKbc/QNdVJaGlHuSzM05Asp7dqns7a6w+ud5/a1UkFO218QA8CJ7H8TJj7r9Eks8De6iqqLfCVZxDuC9aDNq9jpAOw1VOS2cjMpXoxsGnc2AQuMVfTt0IVv2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nDlUuqEn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nDlUuqEn"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5719F20B7136;
	Mon, 23 Mar 2026 06:58:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5719F20B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274321;
	bh=5f5lBzYNJXSQHl9L3phyPddlzD4DT+ukgAveanWx3Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDlUuqEn44ECZzdbgOTVV2eqEPp/xykd4mfUDlDV/yjrXhWX3yYgXkpvBQ3IviHMK
	 T6Iffl179PzLwnbtL3ewwffHUrLKt8rKTrgAmTrbztCUfWOfXbo1SSVrlujNQI0aTz
	 pXYZ///WQnWppFBugbcCKUqZMcp5wyv0OedoeusQ=
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
Subject: [RFC 06/32] accel/accel-irq: add generic commit_route_changes
Date: Mon, 23 Mar 2026 14:57:46 +0100
Message-Id: <20260323135812.383509-7-magnuskulke@linux.microsoft.com>
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

A generic accel_irqchip_commit_route_changes() fn has been introduced for
usage in the MSHV accelerator. The respective kvm_ fn can be removed
since we handle the commit op in a generic way.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c     | 10 +++-------
 hw/misc/ivshmem-pci.c |  2 +-
 hw/vfio/pci.c         |  4 ++--
 include/system/kvm.h  |  8 --------
 target/i386/kvm/kvm.c |  2 +-
 5 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 3815f6727c..7e71b52555 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -45,13 +45,9 @@ int accel_irqchip_update_msi_route(int vector, MSIMessage msg, PCIDevice *dev)
 
 void accel_irqchip_commit_route_changes(AccelRouteChange *c)
 {
-#ifdef CONFIG_MSHV_IS_POSSIBLE
-    if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
-    }
-#endif
-    if (kvm_enabled()) {
-        kvm_irqchip_commit_route_changes(c);
+    if (c->changes) {
+        accel_irqchip_commit_routes();
+        c->changes = 0;
     }
 }
 
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index fa23562886..536475e9de 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -436,7 +436,7 @@ static void ivshmem_add_kvm_msi_virq(IVShmemState *s, int vector,
         error_setg(errp, "kvm_irqchip_add_msi_route failed");
         return;
     }
-    kvm_irqchip_commit_route_changes(&c);
+    accel_irqchip_commit_route_changes(&c);
 
     s->msi_vectors[vector].virq = ret;
     s->msi_vectors[vector].pdev = pdev;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6768523147..d1807888d5 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -695,7 +695,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
             } else {
                 vfio_route_change = accel_irqchip_begin_route_changes();
                 vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
-                kvm_irqchip_commit_route_changes(&vfio_route_change);
+                accel_irqchip_commit_route_changes(&vfio_route_change);
                 vfio_connect_kvm_msi_virq(vector, nr);
             }
         }
@@ -804,7 +804,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
     assert(vdev->defer_kvm_irq_routing);
     vdev->defer_kvm_irq_routing = false;
 
-    kvm_irqchip_commit_route_changes(&vfio_route_change);
+    accel_irqchip_commit_route_changes(&vfio_route_change);
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         vfio_connect_kvm_msi_virq(&vdev->msi_vectors[i], i);
diff --git a/include/system/kvm.h b/include/system/kvm.h
index fec24d2135..cdd1856ac5 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -476,14 +476,6 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
                                  PCIDevice *dev);
 void kvm_irqchip_commit_routes(KVMState *s);
 
-static inline void kvm_irqchip_commit_route_changes(AccelRouteChange *c)
-{
-    if (c->changes) {
-        kvm_irqchip_commit_routes(KVM_STATE(c->accel));
-        c->changes = 0;
-    }
-}
-
 int kvm_irqchip_get_virq(KVMState *s);
 void kvm_irqchip_release_virq(KVMState *s, int virq);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index dc7c495f9c..b132e986f9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6692,7 +6692,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
                 exit(1);
             }
         }
-        kvm_irqchip_commit_route_changes(&c);
+        accel_irqchip_commit_route_changes(&c);
     }
 }
 
-- 
2.34.1

