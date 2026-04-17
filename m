Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980B529827E
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423415; cv=none; b=eD7dW1Sa2QbT3dU2uD5jyUMjXTprdC9kS7TEduypZFpiDcrHjcn8kwQI9p1uTxOn2bUZgg74QygI6HrLmCnKveQodVQXmaKaiJ5vJUZoiHV1FuUVmudf7Mdd9zUM/5swYNILdldg/0uW7H+bh9fX/aaFUK5vo/kzGK1wZqZ+2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423415; c=relaxed/simple;
	bh=WI9x8rqXFLymMtUzxZctbKSAshqcoJGrobCzovIljKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGRluLBS9S28HIAFJKfrBxRAFN/gC+lSgag/mj+GnJWFNePSh/bVzdelGVvkxeLphknjY5E5b5avI+EYEn0uYYK+KM41QchI9hoU7o0/fZeDvMvi2iLvgB7nlZe3xXVBumVFBLHeeRVY6btOZj7eS5ngdOV4ci4CxPCbcSamrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CQmrH7ES; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CQmrH7ES"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7484C20B7128;
	Fri, 17 Apr 2026 03:56:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7484C20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423414;
	bh=VSt5BsFgnJsvC8WsZFKT0zrQ9CBJAd3GXCR4xVichT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQmrH7ESpZYR560emwa24SKtiorn51tVqfnK9QxVmDfR37zjC7Ilt/tW4rcorUNfa
	 RIn5nSqXRQHHswURMY0kQVE6CBAz7o52CFlh8yLg7ItJjG2DPoIBtXusNIrabMw45F
	 Q+8B15nRzXSpCEjMxx59rxv+tBB6h4cw7GTR2P4U=
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
Subject: [PATCH 08/34] accel/mshv: update s->irq_routes in add_msi_route
Date: Fri, 17 Apr 2026 12:55:52 +0200
Message-Id: <20260417105618.3621-9-magnuskulke@linux.microsoft.com>
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

The irq_routes field of the state is populated with native mshv irq
route entries. The allocation logic is modelled after the KVM
implementation: we will always allocate a minumum of 64 entries and use
a bitmask to find/set/clear GSIs.

The old implementation of add_msi_routes will be removed in a subsequent
commit.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c       |  2 +-
 accel/mshv/irq.c        | 87 +++++++++++++++++++++++++++++++++++++----
 accel/stubs/mshv-stub.c |  2 +-
 include/system/mshv.h   |  3 +-
 4 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 7e71b52555..5a97a345b2 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -21,7 +21,7 @@ int accel_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        return mshv_irqchip_add_msi_route(vector, dev);
+        return mshv_irqchip_add_msi_route(c, vector, dev);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 82f2022c7c..9d6bdde27a 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -278,18 +278,91 @@ static int irqchip_update_irqfd_notifier_gsi(const EventNotifier *event,
     return register_irqfd(vm_fd, fd, virq);
 }
 
+static int irqchip_allocate_gsi(MshvState *s, int *gsi)
+{
+    int next_gsi;
+
+    /* Return the lowest unused GSI in the bitmap */
+    next_gsi = find_first_zero_bit(s->used_gsi_bitmap, s->gsi_count);
+    if (next_gsi >= s->gsi_count) {
+        return -ENOSPC;
+    }
+
+    *gsi = next_gsi;
+
+    return 0;
+}
+
+static void irqchip_release_gsi(MshvState *s, int gsi)
+{
+    clear_bit(gsi, s->used_gsi_bitmap);
+}
+
+static void add_routing_entry(MshvState *s, struct mshv_user_irq_entry *entry)
+{
+    struct mshv_user_irq_entry *new;
+    int n, size;
+
+    if (s->irq_routes->nr == s->nr_allocated_irq_routes) {
+        n = s->nr_allocated_irq_routes * 2;
+        if (n < MSHV_MIN_ALLOCATED_MSI_ROUTES) {
+            n = MSHV_MIN_ALLOCATED_MSI_ROUTES;
+        }
+        size = sizeof(struct mshv_user_irq_table);
+        size += n * sizeof(*new);
+        s->irq_routes = g_realloc(s->irq_routes, size);
+        s->nr_allocated_irq_routes = n;
+    }
+
+    n = s->irq_routes->nr;
+    s->irq_routes->nr++;
+    new = &s->irq_routes->entries[n];
+
+    *new = *entry;
+
+    set_bit(entry->gsi, s->used_gsi_bitmap);
 
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+    trace_mshv_add_msi_routing(entry->address_lo | entry->address_hi,
+                               entry->data);
+}
+
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
-    MSIMessage msg = { 0, 0 };
-    int virq = 0;
+    struct mshv_user_irq_entry entry = { 0 };
+    MSIMessage msg = { 0 };
+    uint32_t data, high_addr, low_addr;
+    int gsi, ret;
+    MshvState *s = MSHV_STATE(c->accel);
+
+    if (!pci_available || !dev) {
+        return 0;
+    }
 
-    if (pci_available && dev) {
-        msg = pci_get_msi_message(dev, vector);
-        virq = add_msi_routing(msg.address, le32_to_cpu(msg.data));
+    msg = pci_get_msi_message(dev, vector);
+
+    ret = irqchip_allocate_gsi(mshv_state, &gsi);
+    if (ret < 0) {
+        error_report("Could not allocate GSI for MSI route");
+        return -1;
+    }
+    high_addr = msg.address >> 32;
+    low_addr = msg.address & 0xFFFFFFFF;
+    data = le32_to_cpu(msg.data);
+
+    entry.gsi = gsi;
+    entry.address_hi = high_addr;
+    entry.address_lo = low_addr;
+    entry.data = data;
+
+    if (s->irq_routes->nr < s->gsi_count) {
+        add_routing_entry(s, &entry);
+        c->changes++;
+    } else {
+        irqchip_release_gsi(s, gsi);
+        return -ENOSPC;
     }
 
-    return virq;
+    return gsi;
 }
 
 void mshv_irqchip_release_virq(int virq)
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index e499b199d9..998c9e2fc6 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -14,7 +14,7 @@
 
 bool mshv_allowed;
 
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev)
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
 {
     return -ENOSYS;
 }
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 0d1745315b..7f60aba308 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -33,6 +33,7 @@
 #endif
 
 #define MSHV_MAX_MSI_ROUTES 4096
+#define MSHV_MIN_ALLOCATED_MSI_ROUTES 64
 
 #define MSHV_PAGE_SHIFT 12
 
@@ -59,7 +60,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
                            uint32_t vp_index, bool logical_destination_mode,
                            bool level_triggered);
 
-int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
+int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
 void mshv_irqchip_release_virq(int virq);
-- 
2.34.1

