Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FC637F735
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423419; cv=none; b=dxjij776OLgLDcOCmOmtaVeHd6KUeh1GvDZGoWN77YJWrZHembWjJptqqTsc4M0Awhp+AfJDsgMys1e3rO+jTfg2JXPJV9owAmChAblcGf9cPy8MrmajphiPxgIyQNuaBFTo9rAPlU12WlOq6Uqt1iSMeGkeKn1SjQkDmkn9nvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423419; c=relaxed/simple;
	bh=J1CwPZ/wUXJvjWN9XuTV+Tg43ITh1+qU7fnu1nxdf+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/VW0PBtDf5fuZ6NDU93H8tq2FTqqyOpYTrbxc6//gEUP1zF+1lRTPfu1uiKITVm95vIYyWyU4pMuhfTHJ40gnK09Z40KMrv3gr0+PcpJNgxfn+u2wl/1Qt+ETOaoDujeBj4xdHNL/LABxcEHPiIkDBN8PFQuDxkM7UnoSrFmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gCBXmQvV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gCBXmQvV"
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de [80.134.214.32])
	by linux.microsoft.com (Postfix) with ESMTPSA id 156D420B7129;
	Fri, 17 Apr 2026 03:56:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 156D420B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776423418;
	bh=DLb4Xz56FicxDJh1EcJd2k8Rmdkqnc0+6TN1HYuGNCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCBXmQvVr3L4PFi/hA7EDj5O5SVDdAG6iO8x2ch2HwvQenlAEbQGpydTAeypfFRLV
	 ydjK97GH0PCrWzeo7ws8b7c7I18URh7R4C2cAyOjUdqZSfNo83Zn/iw0Z24QLi61Ip
	 ZetVWgkXVnjQM2wI3uxxFjDUvQjJpQDvor9Fbs3s=
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
Subject: [PATCH 09/34] accel/mshv: update s->irq_routes in update_msi_route
Date: Fri, 17 Apr 2026 12:55:53 +0200
Message-Id: <20260417105618.3621-10-magnuskulke@linux.microsoft.com>
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
is requested to be updated with a new dest/vector.

The old set_msi_routing() fn is redundant and can be removed.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c | 87 +++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 49 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 9d6bdde27a..b5a047b367 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -36,52 +36,6 @@ void mshv_init_msicontrol(void)
     msi_control->updated = false;
 }
 
-static int set_msi_routing(uint32_t gsi, uint64_t addr, uint32_t data)
-{
-    struct mshv_user_irq_entry *entry;
-    uint32_t high_addr = addr >> 32;
-    uint32_t low_addr = addr & 0xFFFFFFFF;
-    GHashTable *gsi_routes;
-
-    trace_mshv_set_msi_routing(gsi, addr, data);
-
-    if (gsi >= MSHV_MAX_MSI_ROUTES) {
-        error_report("gsi >= MSHV_MAX_MSI_ROUTES");
-        return -1;
-    }
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        gsi_routes = msi_control->gsi_routes;
-        entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-
-        if (entry
-            && entry->address_hi == high_addr
-            && entry->address_lo == low_addr
-            && entry->data == data)
-        {
-            /* nothing to update */
-            return 0;
-        }
-
-        /* free old entry */
-        g_free(entry);
-
-        /* create new entry */
-        entry = g_new0(struct mshv_user_irq_entry, 1);
-        entry->gsi = gsi;
-        entry->address_hi = high_addr;
-        entry->address_lo = low_addr;
-        entry->data = data;
-
-        g_hash_table_insert(gsi_routes, GINT_TO_POINTER(gsi), entry);
-        msi_control->updated = true;
-    }
-
-    return 0;
-}
-
 static int add_msi_routing(uint64_t addr, uint32_t data)
 {
     struct mshv_user_irq_entry *route_entry;
@@ -370,16 +324,51 @@ void mshv_irqchip_release_virq(int virq)
     remove_msi_routing(virq);
 }
 
+static int update_routing_entry(MshvState *s,
+                                struct mshv_user_irq_entry *new_entry)
+{
+    struct mshv_user_irq_entry *entry;
+    int n;
+
+    for (n = 0; n < s->irq_routes->nr; n++) {
+        entry = &s->irq_routes->entries[n];
+        if (entry->gsi != new_entry->gsi) {
+            continue;
+        }
+
+        if (!memcmp(entry, new_entry, sizeof *entry)) {
+            return 0;
+        }
+
+        *entry = *new_entry;
+
+        return 0;
+    }
+
+    return -ESRCH;
+}
+
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
 {
+    uint32_t addr_hi = msg.address >> 32;
+    uint32_t addr_lo = msg.address & 0xFFFFFFFF;
+    uint32_t data = le32_to_cpu(msg.data);
+    struct mshv_user_irq_entry entry = {
+        .gsi = virq,
+        .address_hi = addr_hi,
+        .address_lo = addr_lo,
+        .data = data,
+    };
     int ret;
 
-    ret = set_msi_routing(virq, msg.address, le32_to_cpu(msg.data));
+    ret = update_routing_entry(mshv_state, &entry);
     if (ret < 0) {
-        error_report("Failed to set msi routing");
-        return -1;
+        error_report("Failed to set msi routing for gsi %d", virq);
+        abort();
     }
 
+    trace_mshv_set_msi_routing(virq, msg.address, data);
+
     return 0;
 }
 
-- 
2.34.1

