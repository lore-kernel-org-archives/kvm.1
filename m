Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BE30E84B
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556445; cv=none; b=mH8OIa1GD4iSwjQHh3FyrMoO5jxW/dJWZ2+wH/aQndbyc5N7V14JTbVN5g06thOqCZYsimRKzILSv2zk9fEHCpaip18AOpUAQWlgMUHSIiTdDixoIaqO1D+mCOSd9ojj5mB+wQL3ltSZ5pCo8gvYyHTDPL9tBb4StVvVI+eZAck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556445; c=relaxed/simple;
	bh=wGKMW1lWJzr5i7VJtB1p09tLyXvqtcFpwwHEOXxTkbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuuBFjkOSoceI/Jj7+cweCNOUhZrBCIMuPPkQo0xe7Bm6uejwuDrj5jgjd61oLV/GmaO+c+Nd7quAMK0+4Z1RIVgzZHEzqL6V2UCz0vu8UDfu5rh//CcfqcLWJjZzuUQXavOOccJNC6tREKGHlUOHIlazH+BTPuDdgBt9TmiZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=W3z133pD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="W3z133pD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780556431; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N/wmenlWZj0voABROW3OovXPJqUV5xK6krbUpzP9YSY=;
	b=W3z133pDJqawZW3zKE6qVhqCdy7+m3Ps1/RQLzLYgZxgc8mTQBCdBZsbQESwiHLg0sKX6Vb2XQvH8ImtmK8gcDC/8bsrmLJj5e/r/P6g8clji5h2r2tKlVQbwm61syuJ8ItDmLMTCWRquUJpSA6ZoRfTcVP58XAK1JF9ZQgmHLk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guobin@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X49Tjcr_1780556430;
Received: from localhost(mailfrom:guobin@linux.alibaba.com fp:SMTPD_---0X49Tjcr_1780556430 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Jun 2026 15:00:31 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Hyman Huang <infra.ai.cloud@bitdeer.com>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] accel/kvm: event-driven wakeup for dirty ring reaper thread
Date: Thu,  4 Jun 2026 15:00:29 +0800
Message-ID: <20260604070029.34982-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reaper polls with sleep(1) (TODO in the code) and only notices
dirty-limit teardown at the next 1s tick.

Replace the sleep with qemu_poll_ns() on an EventNotifier, kicked
from dirtylimit_state_finalize() after dirtylimit_state has been
cleared.  The kick must follow the NULL assignment: kicking earlier
wakes the reaper while dirtylimit_in_service() still returns true,
so it just loops back to wait.  A 1s fallback timeout remains as a
liveness backstop.

20 set-/cancel-vcpu-dirty-limit cycles via QMP, |reaper-wake -
cancel-ack| measured with strace on the reaper TID:

    before: median 255 ms, max 502 ms
    after:  median 0.6 ms, max  27 ms

kvm_dirty_ring_reaper_init() returns int again (was made void in
commit 43a5e377f4) to propagate event_notifier_init() failure.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
Changes in v2:
- Fix compilation error: kvm_init() has no Error **errp parameter, so
  kvm_dirty_ring_reaper_init() now uses error_report() directly and
  no longer accepts an errp argument.
- Remove the kick from kvm_cpu_exec() KVM_EXIT_DIRTY_RING_FULL handler:
  it already reaps synchronously (all vCPUs or the ring-full one), so
  a background reaper kick would only be redundant or a no-op.
- Move kick site from dirtylimit_change(false) to
  dirtylimit_state_finalize() after dirtylimit_state = NULL, ensuring
  the reaper actually proceeds past the dirtylimit_in_service() check.

 accel/kvm/kvm-all.c      | 42 ++++++++++++++++++++++++++++++++++------
 accel/stubs/kvm-stub.c   |  4 ++++
 include/system/kvm.h     |  7 +++++++
 include/system/kvm_int.h |  3 +++
 system/dirtylimit.c      |  2 ++
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 96f90ebb24..be005832bc 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1754,6 +1754,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     } while (size);
 }
 
+#define KVM_DIRTY_RING_REAPER_FALLBACK_NS  (1 * NANOSECONDS_PER_SECOND)
+
 static void *kvm_dirty_ring_reaper_thread(void *data)
 {
     KVMState *s = data;
@@ -1764,12 +1766,18 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     trace_kvm_dirty_ring_reaper("init");
 
     while (true) {
+        GPollFD pfd = {
+            .fd = event_notifier_get_fd(&r->reaper_notifier),
+            .events = G_IO_IN,
+        };
+
         r->reaper_state = KVM_DIRTY_RING_REAPER_WAIT;
         trace_kvm_dirty_ring_reaper("wait");
-        /*
-         * TODO: provide a smarter timeout rather than a constant?
-         */
-        sleep(1);
+
+        qemu_poll_ns(&pfd, 1, KVM_DIRTY_RING_REAPER_FALLBACK_NS);
+
+        /* Drain unconditionally so a stale event can't spin the next loop. */
+        event_notifier_test_and_clear(&r->reaper_notifier);
 
         /* keep sleeping so that dirtylimit not be interfered by reaper */
         if (dirtylimit_in_service()) {
@@ -1789,13 +1797,32 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
     g_assert_not_reached();
 }
 
-static void kvm_dirty_ring_reaper_init(KVMState *s)
+static int kvm_dirty_ring_reaper_init(KVMState *s)
 {
     struct KVMDirtyRingReaper *r = &s->reaper;
+    int ret;
+
+    ret = event_notifier_init(&r->reaper_notifier, 0);
+    if (ret < 0) {
+        error_report("Failed to initialize dirty ring reaper notifier: %s",
+                     strerror(-ret));
+        return ret;
+    }
 
     qemu_thread_create(&r->reaper_thr, "kvm-reaper",
                        kvm_dirty_ring_reaper_thread,
                        s, QEMU_THREAD_JOINABLE);
+    return 0;
+}
+
+void kvm_dirty_ring_reaper_kick(void)
+{
+    KVMState *s = kvm_state;
+
+    if (!s || !s->kvm_dirty_ring_size) {
+        return;
+    }
+    event_notifier_set(&s->reaper.reaper_notifier);
 }
 
 static int kvm_dirty_ring_init(KVMState *s)
@@ -3097,7 +3124,10 @@ static int kvm_init(AccelState *as, MachineState *ms)
     }
 
     if (s->kvm_dirty_ring_size) {
-        kvm_dirty_ring_reaper_init(s);
+        ret = kvm_dirty_ring_reaper_init(s);
+        if (ret < 0) {
+            goto err;
+        }
     }
 
     if (kvm_check_extension(kvm_state, KVM_CAP_BINARY_STATS_FD)) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c4617caac6..b878598552 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -134,6 +134,10 @@ uint32_t kvm_dirty_ring_size(void)
     return 0;
 }
 
+void kvm_dirty_ring_reaper_kick(void)
+{
+}
+
 bool kvm_hwpoisoned_mem(void)
 {
     return false;
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 5fa33eddda..e127a5eb37 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -553,6 +553,13 @@ bool kvm_dirty_ring_enabled(void);
 
 uint32_t kvm_dirty_ring_size(void);
 
+/**
+ * kvm_dirty_ring_reaper_kick - wake the background dirty ring reaper.
+ *
+ * Safe from any thread; no-op when the dirty ring is not in use.
+ */
+void kvm_dirty_ring_reaper_kick(void);
+
 void kvm_mark_guest_state_protected(void);
 
 /**
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..c14ebc927f 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -12,6 +12,7 @@
 #include "system/memory.h"
 #include "qapi/qapi-types-common.h"
 #include "qemu/accel.h"
+#include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "system/kvm.h"
 #include "accel/accel-ops.h"
@@ -100,6 +101,8 @@ struct KVMDirtyRingReaper {
     QemuThread reaper_thr;
     volatile uint64_t reaper_iteration; /* iteration number of reaper thr */
     volatile enum KVMDirtyRingReaperState reaper_state; /* reap thr state */
+    /* Wakeup channel: kicked when dirty-limit is torn down. */
+    EventNotifier reaper_notifier;
 };
 struct KVMState
 {
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index c934ceb0de..a33256ade7 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -239,6 +239,8 @@ void dirtylimit_state_finalize(void)
     g_free(dirtylimit_state);
     dirtylimit_state = NULL;
 
+    kvm_dirty_ring_reaper_kick();
+
     trace_dirtylimit_state_finalize();
 }
 
-- 
2.50.1 (Apple Git-155)

