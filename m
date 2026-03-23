Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5EF3AF66F
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274337; cv=none; b=dMbXHrhWdYw40AjCG+i2IvUC2S55VzHx/E3hJfWsqh5VlWZujCvbUgVP8dSszMAPjznxh2JCxvnn0vcp3Z2UTRi/4lJyf/9bGEMOzQlhLs4lJePx68vWmaUtz5OgJfC4SIGStZSx/ejojXA+F2zriggAt/Mx4j3vd92E81P5DWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274337; c=relaxed/simple;
	bh=GPyjxRhRZX0/AQEETNzpPh9HKPPtjvN9QFYeao1kOn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo2Dk4w/38VHVlx47bn7lIn6CT//jy/g6YA5R7ZWhEaDJnsl2TI1VJkJSfUPFmVxFbHgOLUSJ7kyX22Xqr3roSj8EAxEL3DMtP9BbhbCIZIv+2hdsFIf+zLuublJW77NLXbC9KivhsVfu9w4Z56z4s+T6mz3spk2iRXgUif+EKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ogk3+hhN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ogk3+hhN"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 00BCF20B700D;
	Mon, 23 Mar 2026 06:58:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00BCF20B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274335;
	bh=4H6AOTHbSt4M6umhyzila9t2EZwbHKhGHm3APiPWRFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogk3+hhNAmK2F2D7EZqoy8Tq5JUjReQ2gcuNfVMHJuOvIOJBookBdOcNZ/oiD6uQ7
	 pZNAEfNs9TU0yj+qMZNmbuIkdwaGgEtUiBGw5TlBHZ4wzXEjeH84SAjov+N7uDi8UU
	 PO+qfdmZxDZsSycV4/hVnpBU/dOQU5RFCMPdnIv4=
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
Subject: [RFC 10/32] accel/mshv: update s->irq_routes in release_virq
Date: Mon, 23 Mar 2026 14:57:50 +0100
Message-Id: <20260323135812.383509-11-magnuskulke@linux.microsoft.com>
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

