Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C13AE70F
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274326; cv=none; b=a64KwFu7GtT/t1lSNjL0nrUUbt1ks91gfNfXkHe+jGUv9sOLZGb3ZO3r+rGHUCXWvbOj3LJI/RHuxIFY2QxI303wVl8VmtrAI33+VjPxVMN8JGiH89KKNez8l4BiwIduogUVe834TtGZ9jjhgyRzmJhaCoKG28T3xvpQM6ZLWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274326; c=relaxed/simple;
	bh=XsEpDPM5pjoRWPDbOQifYC2xznrVvxCT4rUtOWvjW4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTXDY4YQOgrn6TRhEuFghFJ+SadGnEsIMAVnxAk1p2Ab3vR1RI1ud5MpJCj6s98nOBsloaHvW1ez2oGtuyQyQXpoHERKk68W3kCOrEF4vESd0S3Uff14jRh/unc5asSiuYrwqOey3aVgGU3vsQzCAZLiMlCqk61RR1aU/xwGF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UMugpAwP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UMugpAwP"
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
	by linux.microsoft.com (Postfix) with ESMTPSA id 108DA20B7138;
	Mon, 23 Mar 2026 06:58:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 108DA20B7138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774274324;
	bh=Q99VB31zJMe+kwy7P7q526bcuOKPTBKL3PaUmcduhVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMugpAwPlir5DpKO9i8Us7blVSXe4E05zoCjdDxYfujRpzKhOP+wMH9RrbRjxoRfl
	 +/sLmlCFC+M7Yscfn0ou5YM1nneprBNHqAFcP41oByX5dsdslcXwPesGVg76Cr/z25
	 KCR+5wXkiJV8WnAvEwOMM23oRtTMJ4oHDKwxeRG0=
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
Subject: [RFC 07/32] accel/mshv: add irq_routes to state
Date: Mon, 23 Mar 2026 14:57:47 +0100
Message-Id: <20260323135812.383509-8-magnuskulke@linux.microsoft.com>
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

This change adds fields related to irq routing to the MSHV state, following
similar fields in the KVM implementation.

So far the fields are only initialized, they will be used in subsequent
commits for bookkeeping purposes and storing uncommitted interrupt routes.

The TYPE_MSHV_ACCEL defines have been moved to the header.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c          | 10 ++++++++++
 accel/mshv/mshv-all.c     |  6 ++----
 include/system/mshv.h     |  7 +++++++
 include/system/mshv_int.h |  5 +++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 3c238c33c3..82f2022c7c 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -396,3 +396,13 @@ int mshv_reserve_ioapic_msi_routes(int vm_fd)
 
     return 0;
 }
+
+void mshv_init_irq_routing(MshvState *s)
+{
+    int gsi_count = MSHV_MAX_MSI_ROUTES;
+
+    s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
+    s->nr_allocated_irq_routes = 0;
+    s->gsi_count = gsi_count;
+    s->used_gsi_bitmap = bitmap_new(gsi_count);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 04d248fe1d..8acb080db1 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -43,10 +43,6 @@
 #include <err.h>
 #include <sys/ioctl.h>
 
-#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
-
-DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
-
 bool mshv_allowed;
 
 MshvState *mshv_state;
@@ -457,6 +453,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_state = s;
 
+    mshv_init_irq_routing(s);
+
     register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 1e96b3a606..0d1745315b 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -45,7 +45,13 @@ extern bool mshv_allowed;
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #endif
 
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
 typedef struct MshvState MshvState;
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
+                         TYPE_MSHV_ACCEL)
+
 extern MshvState *mshv_state;
 
 /* interrupt */
@@ -60,5 +66,6 @@ void mshv_irqchip_release_virq(int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
+void mshv_init_irq_routing(MshvState *s);
 
 #endif
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 70631ca6ba..56fda76a9c 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -48,6 +48,11 @@ struct MshvState {
     int nr_as;
     MshvAddressSpace *as;
     int fd;
+    /* irqchip routing */
+    struct mshv_user_irq_table *irq_routes;
+    int nr_allocated_irq_routes;
+    unsigned long *used_gsi_bitmap;
+    unsigned int gsi_count;
 };
 
 typedef struct MshvMsiControl {
-- 
2.34.1

