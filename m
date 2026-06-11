Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB81F5821
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162638; cv=none; b=lfZ4XLEr4sYVk6ZIEYtC4KUuylGDDAtMcA4Uiqhqhp1A0BKW6o5qe6Qa+DNxUqvv0BlU/q9LcbjWAp7FRpCi5C4Sr+5ZF8RJ/AruXfX2R1l36D6DYmRprwEoxB/muNpX90d8w2os1vTyoCTfam9j3gD8uBeTc/zZOLuxbwvqUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162638; c=relaxed/simple;
	bh=+TuMv/ELGdVJRpszAAUj/bwg+XvQHvHbSPOG4nbU0t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZYqZNj/WnWm1xeXtF6aFedb8vEumxzBTBqQ6wI2eHnj/tv9v7o1gnI0owJSBo6zqnwu/VKkwiz30TLl2coQdCQoe65fWL38+cUhDE2ZWcndK7dilU9A2qPRDPuTkz5Qzwssz5NLNn1awBK3hYZ7b75Z114Yz1TPwhtl3vNtGYR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=l3MckvaR reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="l3MckvaR"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6ZnFN023462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 15:35:59 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3u8QwhLa+X7Oh5rryZcKTj0YlBRGjYHqyTP8c2+QAnA=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1781159760; v=1;
        b=l3MckvaR+jjB+gxr4qMCvp0L4HDZC7yXAakbX0+Hf6h+bX1npV2VIT3hGCaWQnec
         6azY+OdaWeTxSM/bLJzfaCtkpnZeYFzPTyJqf8p1/JnaHwWarTCqRZE4TfPWyHXk
         67xYNTe6V9EnbW3t2qdDswyGtIHXaG6kVISnymqUEjg6L68EyshP7OT+iXTNpw0k
         jzquwB9O4VIryFX5y8y3Ibf/tiiRrURCUMMrgt5XJ9j2ui0BDIuaZmm7TdUHrsqx
         LlWIqVgf3waBxgJ6tjpBKdWH8dRM96gsiTf6iBq9Zp/9gimanF3XL4Sd14AtMI6L
         yBa84PPAiDNLNwMxwuZkxg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 15:35:50 +0900
Subject: [PATCH 3/3] migration/ram: Abort on unsupported migratable RAM
 changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ram-v1-3-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=9885;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=+TuMv/ELGdVJRpszAAUj/bwg+XvQHvHbSPOG4nbU0t8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ZWuO+MtKV+dtUsMla1ZbMW7amT33K7Nbh7Xc+UJLsI7
 8y1tns7SlkYxLgYZMUUWVKKdnNrRNd+KkyIb4GZw8oEMoSBi1MAJlKzmuF/vTTnxG7WhVrMVW5K
 mS/XOeT++JzFNUV3cq5fv++dRo4SRoZeo7n35FndvdiffJJJu/PEJbFaW7vTeUnkS4N37zWlZ/E
 CAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

ram_mig_ram_block_resized() already aborts migration when migratable RAM
is resized. Extend the same handling to other unsupported changes to the
migratable RAMBlock set, such as removing a migratable RAMBlock, changing
a RAMBlock's migratable state, or setting a RAMBlock's idstr.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/migration/misc.h |   2 +-
 migration/ram.c          | 117 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 102 insertions(+), 17 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 3159a5e53c3c..91015524a83d 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -40,7 +40,7 @@ void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
 
 void qemu_guest_free_page_hint(void *addr, size_t len);
-bool migrate_ram_is_ignored(RAMBlock *block);
+bool migrate_ram_is_ignored(const RAMBlock *block);
 
 /* migration/block.c */
 
diff --git a/migration/ram.c b/migration/ram.c
index 6bc7f705d31a..eb761644520f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -224,7 +224,7 @@ static bool postcopy_preempt_active(void)
     return migrate_postcopy_preempt() && migration_in_postcopy();
 }
 
-bool migrate_ram_is_ignored(RAMBlock *block)
+bool migrate_ram_is_ignored(const RAMBlock *block)
 {
     MigMode mode = migrate_mode();
     return !qemu_ram_is_migratable(block) ||
@@ -364,6 +364,12 @@ struct RAMSrcPageRequest {
     QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
 };
 
+typedef enum RAMStateStage {
+    RAM_STATE_STAGE_ITERATING,
+    RAM_STATE_STAGE_COMPLETING,
+    RAM_STATE_STAGE_COMPLETED,
+} RAMStateStage;
+
 /* State of RAM for migration */
 struct RAMState {
     /*
@@ -398,8 +404,8 @@ struct RAMState {
     uint64_t xbzrle_bytes_prev;
     /* Are we really using XBZRLE (e.g., after the first round). */
     bool xbzrle_started;
-    /* Are we on the last stage of migration */
-    bool last_stage;
+    /* Migration stage */
+    RAMStateStage stage;
 
     /* total handled target pages at the beginning of period */
     uint64_t target_page_count_prev;
@@ -635,7 +641,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
 
     if (!cache_is_cached(XBZRLE.cache, current_addr, generation)) {
         xbzrle_counters.cache_miss++;
-        if (!rs->last_stage) {
+        if (rs->stage == RAM_STATE_STAGE_ITERATING) {
             if (cache_insert(XBZRLE.cache, current_addr, *current_data,
                              generation) == -1) {
                 return -1;
@@ -674,7 +680,7 @@ static int save_xbzrle_page(RAMState *rs, PageSearchStatus *pss,
      * Update the cache contents, so that it corresponds to the data
      * sent, in all cases except where we skip the page.
      */
-    if (!rs->last_stage && encoded_len != 0) {
+    if (rs->stage == RAM_STATE_STAGE_ITERATING && encoded_len != 0) {
         memcpy(prev_cached_page, XBZRLE.current_buf, TARGET_PAGE_SIZE);
         /*
          * In the case where we couldn't compress, ensure that the caller
@@ -840,7 +846,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
      *
      * Do the same for postcopy due to the same reason.
      */
-    if (!rs->last_stage && !migration_in_postcopy()) {
+    if (rs->stage == RAM_STATE_STAGE_ITERATING &&
+        !migration_in_postcopy()) {
         /*
          * Clear dirty bitmap if needed.  This _must_ be called before we
          * send any of the page in the chunk because we need to make sure
@@ -1316,7 +1323,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
     if (rs->xbzrle_started && !migration_in_postcopy()) {
         pages = save_xbzrle_page(rs, pss, &p, current_addr,
                                  block, offset);
-        if (!rs->last_stage) {
+        if (rs->stage == RAM_STATE_STAGE_ITERATING) {
             /* Can't send this cached data async, since the cache page
              * might get updated before it gets to the wire
              */
@@ -2920,6 +2927,8 @@ static void ram_state_resume_prepare(RAMState *rs, QEMUFile *out)
     RAMBlock *block;
     uint64_t pages = 0;
 
+    rs->stage = RAM_STATE_STAGE_ITERATING;
+
     /*
      * Postcopy is not using xbzrle/compression, so no need for that.
      * Also, since source are already halted, we don't need to care
@@ -3373,7 +3382,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     trace_ram_save_complete(rs->migration_dirty_pages, 0);
 
-    rs->last_stage = !migration_in_colo_state();
+    if (!migration_in_colo_state()) {
+        rs->stage = RAM_STATE_STAGE_COMPLETING;
+    }
 
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
@@ -3383,7 +3394,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-            return ret;
+            goto err;
         }
 
         /* try transferring iterative blocks of memory */
@@ -3400,7 +3411,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             }
             if (pages < 0) {
                 qemu_mutex_unlock(&rs->bitmap_mutex);
-                return pages;
+                ret = pages;
+                goto err;
             }
         }
         qemu_mutex_unlock(&rs->bitmap_mutex);
@@ -3408,7 +3420,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
-            return ret;
+            goto err;
         }
     }
 
@@ -3419,7 +3431,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
          */
         ret = multifd_ram_flush_and_sync(f);
         if (ret < 0) {
-            return ret;
+            goto err;
         }
     }
 
@@ -3428,10 +3440,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
         if (qemu_file_get_error(f)) {
             Error *local_err = NULL;
-            int err = qemu_file_get_error_obj(f, &local_err);
+            ret = -qemu_file_get_error_obj(f, &local_err);
 
             error_reportf_err(local_err, "Failed to write bitmap to file: ");
-            return -err;
+            goto err;
         }
     }
 
@@ -3439,7 +3451,14 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     trace_ram_save_complete(rs->migration_dirty_pages, 1);
 
-    return qemu_fflush(f);
+    ret = qemu_fflush(f);
+
+err:
+    if (!migration_in_colo_state()) {
+        rs->stage = RAM_STATE_STAGE_COMPLETED;
+    }
+
+    return ret;
 }
 
 static void ram_state_pending(void *opaque, MigPendingData *pending,
@@ -4699,6 +4718,68 @@ static SaveVMHandlers savevm_ram_handlers = {
     .save_postcopy_prepare = ram_save_postcopy_prepare,
 };
 
+static bool ram_migration_is_running(void)
+{
+    return ram_state && ram_state->stage != RAM_STATE_STAGE_COMPLETED;
+}
+
+static void ram_mig_ram_block_set_migratable(RAMBlockNotifier *n,
+                                             const RAMBlock *rb)
+{
+    Error *err = NULL;
+
+    if (!ram_migration_is_running()) {
+        return;
+    }
+
+    error_setg(&err, "RAM block '%s' set migratable during precopy.",
+               rb->idstr);
+    migrate_error_propagate(migrate_get_current(), err);
+    migration_cancel();
+}
+
+static void ram_mig_ram_block_unset_migratable(RAMBlockNotifier *n,
+                                               const RAMBlock *rb)
+{
+    Error *err = NULL;
+
+    if (!ram_migration_is_running()) {
+        return;
+    }
+
+    error_setg(&err, "RAM block '%s' unset migratable during precopy.",
+               rb->idstr);
+    migrate_error_propagate(migrate_get_current(), err);
+    migration_cancel();
+}
+
+static void ram_mig_ram_block_set_idstr(RAMBlockNotifier *n, const RAMBlock *rb)
+{
+    Error *err = NULL;
+
+    if (!ram_migration_is_running() || migrate_ram_is_ignored(rb)) {
+        return;
+    }
+
+    error_setg(&err, "RAM block idstr set during precopy.");
+    migrate_error_propagate(migrate_get_current(), err);
+    migration_cancel();
+}
+
+static void ram_mig_ram_block_removed(RAMBlockNotifier *n, const RAMBlock *rb,
+                                      void *host, size_t size, size_t max_size)
+{
+    Error *err = NULL;
+
+    if (!rb || !ram_migration_is_running() || migrate_ram_is_ignored(rb)) {
+        return;
+    }
+
+    error_setg(&err, "RAM block '%s' removed during precopy.", rb->idstr);
+    migrate_error_propagate(migrate_get_current(), err);
+    migration_cancel();
+}
+
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, RAMBlock *rb,
                                       size_t new_size)
 {
@@ -4710,7 +4791,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, RAMBlock *rb,
         return;
     }
 
-    if (migration_is_running()) {
+    if (ram_migration_is_running()) {
         /*
          * Precopy code on the source cannot deal with the size of RAM blocks
          * changing at random points in time - especially after sending the
@@ -4754,6 +4835,10 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, RAMBlock *rb,
 }
 
 static RAMBlockNotifier ram_mig_ram_notifier = {
+    .ram_block_removed = ram_mig_ram_block_removed,
+    .ram_block_set_migratable = ram_mig_ram_block_set_migratable,
+    .ram_block_unset_migratable = ram_mig_ram_block_unset_migratable,
+    .ram_block_set_idstr = ram_mig_ram_block_set_idstr,
     .ram_block_resized = ram_mig_ram_block_resized,
 };
 

-- 
2.54.0

