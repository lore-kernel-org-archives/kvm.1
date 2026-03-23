Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65C3B0ACD
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274344; cv=none; b=BpM3UQ9e7EQ6U/1NgpQwtwM+tP7/L7/zTQ5XIv72tJ80CtCWrZfzAdYliGVyDp2W9KSOSqnBL3jJaUyRxTBSkk9WhY1dCSDJjKXSB8PZuoevAlUOQwe9/9cG0zA4bf6Qt5pBpA2dgLtkfIRGjRO8XIVofPlF3u1a1cC+rwE7aeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274344; c=relaxed/simple;
	bh=e+o2TwnPsjSnBgFcTFm7a0T1NFZ+6HFTKInNarLuKdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9v5fT3JeSOiNwE+uXvR/QvPNVJ8eKRee6W5CkDnTDkpjbaSy6bqYXK47OoqqDHit4vPdqO157SmRanKs527lsX+zEZhVIUqhnbLn2q1sSMjIvoG+LWJQarHrgxC0GJyZktoV1qPGDWc+dIgf6v/czUfR5xYG6nfmUOW9frSFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G5MhR6qG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G5MhR6qG"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1650820B7017;
	Mon, 23 Mar 2026 06:58:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1650820B7017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274342;
	bh=apZ0c23LEobuYLV/xQNkaE00YRO3wUE05eRvWn9R9qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G5MhR6qGe8Pl+TzUfI7xQZZt0ZGF6hUb9To/EUYKelrzr4B8KKbnEz6ecpGSCCbcs
	 j5nsuXuljRYPXWE9f9tSZvwBU6ovuM/H/Zl/V570sCJ6tuyjei4rvyiDrFYkVJJl29
	 bUiV6feNjPyLCPcfxQf+ByMz25s9oJyjd1vJYCts=
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
Subject: [RFC 12/32] accel/mshv: reserve ioapic routes on s->irq_routes
Date: Mon, 23 Mar 2026 14:57:52 +0100
Message-Id: <20260323135812.383509-13-magnuskulke@linux.microsoft.com>
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

We reserve 24 ioapic routes using the new functions that operate on the
mshv apic state.

commit/add_msi_routing() fn's can be removed now.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c          | 115 ++++++--------------------------------
 accel/mshv/mshv-all.c     |   5 --
 include/system/mshv_int.h |   1 -
 3 files changed, 18 insertions(+), 103 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 9ba837f0e2..52b8ac9479 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -36,93 +36,6 @@ void mshv_init_msicontrol(void)
     msi_control->updated = false;
 }
 
-static int add_msi_routing(uint64_t addr, uint32_t data)
-{
-    struct mshv_user_irq_entry *route_entry;
-    uint32_t high_addr = addr >> 32;
-    uint32_t low_addr = addr & 0xFFFFFFFF;
-    int gsi;
-    GHashTable *gsi_routes;
-
-    trace_mshv_add_msi_routing(addr, data);
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        /* find an empty slot */
-        gsi = 0;
-        gsi_routes = msi_control->gsi_routes;
-        while (gsi < MSHV_MAX_MSI_ROUTES) {
-            route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-            if (!route_entry) {
-                break;
-            }
-            gsi++;
-        }
-        if (gsi >= MSHV_MAX_MSI_ROUTES) {
-            error_report("No empty gsi slot available");
-            return -1;
-        }
-
-        /* create new entry */
-        route_entry = g_new0(struct mshv_user_irq_entry, 1);
-        route_entry->gsi = gsi;
-        route_entry->address_hi = high_addr;
-        route_entry->address_lo = low_addr;
-        route_entry->data = data;
-
-        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), route_entry);
-        msi_control->updated = true;
-    }
-
-    return gsi;
-}
-
-static int commit_msi_routing_table(int vm_fd)
-{
-    guint len;
-    int i, ret;
-    size_t table_size;
-    struct mshv_user_irq_table *table;
-    GHashTableIter iter;
-    gpointer key, value;
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        if (!msi_control->updated) {
-            /* nothing to update */
-            return 0;
-        }
-
-        /* Calculate the size of the table */
-        len = g_hash_table_size(msi_control->gsi_routes);
-        table_size = sizeof(struct mshv_user_irq_table)
-                     + len * sizeof(struct mshv_user_irq_entry);
-        table = g_malloc0(table_size);
-
-        g_hash_table_iter_init(&iter, msi_control->gsi_routes);
-        i = 0;
-        while (g_hash_table_iter_next(&iter, &key, &value)) {
-            struct mshv_user_irq_entry *entry = value;
-            table->entries[i] = *entry;
-            i++;
-        }
-        table->nr = i;
-
-        trace_mshv_commit_msi_routing_table(vm_fd, len);
-
-        ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, table);
-        g_free(table);
-        if (ret < 0) {
-            error_report("Failed to commit msi routing table");
-            return -1;
-        }
-        msi_control->updated = false;
-    }
-    return 0;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
@@ -420,37 +333,45 @@ int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *event,
     return irqchip_update_irqfd_notifier_gsi(event, NULL, virq, false);
 }
 
-int mshv_reserve_ioapic_msi_routes(int vm_fd)
+static int mshv_reserve_ioapic_msi_routes(MshvState *s)
 {
-    int ret, gsi;
+    int ret, i;
+    int gsi = 0;
+    struct mshv_user_irq_entry blank_entry = { 0 };
 
     /*
      * Reserve GSI 0-23 for IOAPIC pins, to avoid conflicts of legacy
      * peripherals with MSI-X devices
      */
-    for (gsi = 0; gsi < IOAPIC_NUM_PINS; gsi++) {
-        ret = add_msi_routing(0, 0);
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        /* ret = add_msi_routing(0, 0); */
+        ret = irqchip_allocate_gsi(s, &gsi);
         if (ret < 0) {
-            error_report("Failed to reserve GSI %d", gsi);
+            error_report("Failed to reserve GSI %d: %s", gsi, strerror(-ret));
             return -1;
         }
+        blank_entry.gsi = gsi;
+        add_routing_entry(s, &blank_entry);
     }
 
-    ret = commit_msi_routing_table(vm_fd);
-    if (ret < 0) {
-        error_report("Failed to commit reserved IOAPIC MSI routes");
-        return -1;
-    }
+    mshv_irqchip_commit_routes(s);
 
     return 0;
 }
 
 void mshv_init_irq_routing(MshvState *s)
 {
+    int ret;
     int gsi_count = MSHV_MAX_MSI_ROUTES;
 
     s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
     s->nr_allocated_irq_routes = 0;
     s->gsi_count = gsi_count;
     s->used_gsi_bitmap = bitmap_new(gsi_count);
+
+    ret = mshv_reserve_ioapic_msi_routes(s);
+    if (ret < 0) {
+        error_report("Failed to reserve IOAPIC MSI routes");
+        abort();
+    }
 }
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 8acb080db1..08bc26713f 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -200,11 +200,6 @@ static int create_vm(int mshv_fd, int *vm_fd)
         return -1;
     }
 
-    ret = mshv_reserve_ioapic_msi_routes(*vm_fd);
-    if (ret < 0) {
-        return -1;
-    }
-
     ret = mshv_arch_post_init_vm(*vm_fd);
     if (ret < 0) {
         return -1;
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 56fda76a9c..9bc56e70cf 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -120,6 +120,5 @@ int mshv_configure_msr(const CPUState *cpu, const MshvMsrEntry *msrs,
 
 /* interrupt */
 void mshv_init_msicontrol(void);
-int mshv_reserve_ioapic_msi_routes(int vm_fd);
 
 #endif
-- 
2.34.1

