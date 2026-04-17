Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C9C37F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423408; cv=none; b=Ucwhe4zK3+G4s9ZQig1oT2x9QQIF+G+9UJVlso4GAXdJAUaXfuAy+e2uEhx23yQJ6CHTVijGj07RFAV6Bc29Z1Ns+CUxeXBYBLQXqogEpj3N2P4PxzWdiKymJejpkern+lUDH/lkeusFjGu2ZCxdRZTVEtHHMOa3JtReTr2zL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423408; c=relaxed/simple;
	bh=EKp8wzOu+gY8tVeMSoCQq0E2Sy9DcFbEARnr1jZgBO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsI4M6aZs7+NlwpPnUfVjs5AIXawGS7XRLWzbhzrtI5c3Rn6hiuI+vAUvuh4lEbvzbPSSZlotyPqvR2bAfE0zU8uYcLPbPdGNoNFsr++JkzYW2o7oARzlieZR1WYGHoZoa4A/lbwLUMrhmbXUKu5AxiAX5KXOE/3yRIaYG+yGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kE/Mp9sg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kE/Mp9sg"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 063B620B7128;
	Fri, 17 Apr 2026 03:56:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 063B620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423406;
	bh=/agQnXNBT1WkQmDfzU3UPBeR7shsVTN7r5KTnFUfoDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kE/Mp9sglD4u3Y+T7H/EYSbuNQFxkKd9hWWVFtf9UaBFTMOGGk8kPeFwc3cASeQVf
	 IcXb1/vF4mER7Hz+UZ3tc+VMjCU6Y24E4PfPYoU4ahASH3ixljrQ8sCaCXapsp4F90
	 MyYNNc/RfIBbZ5Tmsr/oXhEqB7MZnQIlbAyMdicg=
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
Subject: [PATCH 06/34] accel/accel-irq: add generic commit_route_changes
Date: Fri, 17 Apr 2026 12:55:50 +0200
Message-Id: <20260417105618.3621-7-magnuskulke@linux.microsoft.com>
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
index 35b4545482..fb20902412 100644
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
index 03312922d5..64cc421abe 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6690,7 +6690,7 @@ void kvm_arch_init_irq_routing(KVMState *s)
                 exit(1);
             }
         }
-        kvm_irqchip_commit_route_changes(&c);
+        accel_irqchip_commit_route_changes(&c);
     }
 }
 
-- 
2.34.1

