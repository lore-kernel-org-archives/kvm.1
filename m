Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D417B37F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423422; cv=none; b=PmeoNMUzmiTuMRc+uL1d2LfaiVrKtWwuLC6Ds8SU4UGtaAiyOPsBKj/gxlP7Rn4nYEocvwV/Sodw030xyfoCoM5PC2b6FSd0aN7LpFMvkcm1Ysl5FgPQcAs676Hn7cgoFZcmvRpmp25SB/B6NTxuUd1qd4ZhmQQb1PjURTaBvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423422; c=relaxed/simple;
	bh=GPyjxRhRZX0/AQEETNzpPh9HKPPtjvN9QFYeao1kOn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OcnV1XSvtwZ296WcPLU3gep0lh/CoPVcz0/0d1MU9klIy3ruyhvYRCrF26NbdSwOsZILkGUati5shwup/M1vtYsM78Z2R5NKCmBt+BOhenb0wasPEp/6Pe/pTNzSnnVIzBpOwv50K9TE3PjUC4E5EMsmgZ3L+sO/bENEFNhhLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UQgHl4f/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UQgHl4f/"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id B75E720B712D;
	Fri, 17 Apr 2026 03:56:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B75E720B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423421;
	bh=4H6AOTHbSt4M6umhyzila9t2EZwbHKhGHm3APiPWRFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UQgHl4f/Ib1eL/MQ79hlHeyrt7REOCCttAmgc+vSuwiDoM6R2v/Azs6mVaLEteccG
	 hbQywJuG2a7C6I31vLHfeWnDi/SYIgdntbMS1G2HF12IsnVtxdKQYyY1JDAebuvfse
	 bA9rRI7Tec/hY2n/ORB1PPwTz2S10S+FOjr0eE80=
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
Subject: [PATCH 10/34] accel/mshv: update s->irq_routes in release_virq
Date: Fri, 17 Apr 2026 12:55:54 +0200
Message-Id: <20260417105618.3621-11-magnuskulke@linux.microsoft.com>
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

The state's irq_routes field will be updated when an irqchip's gsi
is requested to be released.

The old remove_msi_routing() fn is redundant and can be removed.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c       |  2 +-
 accel/mshv/irq.c        | 43 ++++++++++++++---------------------------
 accel/stubs/mshv-stub.c |  2 +-
 include/system/mshv.h   |  2 +-
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 5a97a345b2..0cb3ef78d3 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -67,7 +67,7 @@ void accel_irqchip_release_virq(int virq)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_release_virq(virq);
+        mshv_irqchip_release_virq(mshv_state, virq);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index b5a047b367..990ce34620 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -123,33 +123,6 @@ static int commit_msi_routing_table(int vm_fd)
     return 0;
 }
 
-static int remove_msi_routing(uint32_t gsi)
-{
-    struct mshv_user_irq_entry *route_entry;
-    GHashTable *gsi_routes;
-
-    trace_mshv_remove_msi_routing(gsi);
-
-    if (gsi >= MSHV_MAX_MSI_ROUTES) {
-        error_report("Invalid GSI: %u", gsi);
-        return -1;
-    }
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        gsi_routes = msi_control->gsi_routes;
-        route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-        if (route_entry) {
-            g_hash_table_remove(gsi_routes, GINT_TO_POINTER(gsi));
-            g_free(route_entry);
-            msi_control->updated = true;
-        }
-    }
-
-    return 0;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
@@ -319,9 +292,21 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return gsi;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
-    remove_msi_routing(virq);
+    struct mshv_user_irq_entry *e;
+    int i;
+
+    for (i = 0; i < s->irq_routes->nr; i++) {
+        e = &s->irq_routes->entries[i];
+        if (e->gsi == virq) {
+            s->irq_routes->nr--;
+            *e = s->irq_routes->entries[s->irq_routes->nr];
+        }
+    }
+    irqchip_release_gsi(s, virq);
+
+    trace_mshv_remove_msi_routing(virq);
 }
 
 static int update_routing_entry(MshvState *s,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index 998c9e2fc6..dadf05511a 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -19,7 +19,7 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
 }
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 7f60aba308..2033beed70 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -63,7 +63,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
-void mshv_irqchip_release_virq(int virq);
+void mshv_irqchip_release_virq(MshvState *s, int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
-- 
2.34.1

