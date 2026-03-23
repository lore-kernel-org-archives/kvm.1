Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E493B47DE
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274330; cv=none; b=n8aTWUiMHlHlVt4vzK+JoEOlzUIvBn/1iE0HGK3LiugYtfzXUXFkpeHroj2aIDjvXAuKoeA/MDRyDAjpR6arwUF9VN8KLhl0/bVqn9NBbkcttrS3tAsEoy7Eq9W28dYawKnR/SBO4niYqa3+6k0XZmmTKX2yYQmeBQm+B4svTr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274330; c=relaxed/simple;
	bh=WI9x8rqXFLymMtUzxZctbKSAshqcoJGrobCzovIljKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FykINyOJxOuNDKxiibJTjv2RUl5OxJGdKb31vgdjfgiY8X98rqPwWXw+k1ELmit1skXMCVl5smPDJ85ubkLuqX3TixQ8H4tINl/uFaE3AocoURbUTqCHlggnOfAlw0TzPO7+DiT66mFIGNr7T+efW6quMmLBdAHoWqSC44pRNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oz74KWOR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oz74KWOR"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 940BF20B713B;
	Mon, 23 Mar 2026 06:58:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 940BF20B713B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274328;
	bh=VSt5BsFgnJsvC8WsZFKT0zrQ9CBJAd3GXCR4xVichT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oz74KWORamCB4RpfWr9zrTaZQAfh1RNHwhhpmrbmrDW+LGCg+Z6OJPn5VB0HGCLSO
	 r1ad5GomT/DuWmXPrvXhrDUwWhKS0NcrUcWpKuIhm6e6Y7wj4oWenmGk5KlMXG1PEA
	 tIcKikz8XuPXkjI8cQBcud1kj+lqrNxmdc2vr8do=
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
Subject: [RFC 08/32] accel/mshv: update s->irq_routes in add_msi_route
Date: Mon, 23 Mar 2026 14:57:48 +0100
Message-Id: <20260323135812.383509-9-magnuskulke@linux.microsoft.com>
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

