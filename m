Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920447DD4A
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580700; cv=none; b=jm/Wb+fLe4jITZO00vlV/Ehlw7iEPCiB81Z38Bf9OGX3YAo7uVGiThfGhn2puFf0BNMtdYI1B0DT2ooCinX0eI8WlZnNHT6vY4lrEUen5Xv6FYt/xyZfN2N2+ZhD5Y/P8lJF43fiBGrTr5C2uYxZ/rjSmHWBTkO9EmpaZX2u/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580700; c=relaxed/simple;
	bh=znVW5921M7+0092ia+MeDcCo7lcpbF5fnLhhQFRfDqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QY8nlKkmxQrSzYTuw8e3fb+CgbASJXtKXQe2HmFEUR3cGAKeQwHhvmkB1J3KMTCzkM+AK0Bp0IPyL/ho9Z5xD11vArU99yhyZ7BE7dxA2CBTJ7tXg+D/tBnfePYGHphnrmC+kspSMy8fLNvRE+1EK78FrcfU1U/WYeZOLnT1Tq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B84Pu86r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B84Pu86r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xl9RCdMEAiNI/QszRDVHp8xycP9ssDJJLT37LguwrcY=;
	b=B84Pu86rcmJCPj729K3uc57x5iDV3TKc+WgFbY+V/4xazZ6FZFkcfnVjXVqSe2uKAcsU6X
	IVdEYoVl+KXZY7LFhnzFOMaV03HxAWapxslGZ/J+IzKK6XiiEWTTqbrFna/Nw7qMx2mgHm
	KQoSMySx2qwcoAqL9vg+ra7KZJPGYNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-jyPHo_ETP0iXAeVQpKdpDg-1; Thu,
 04 Jun 2026 09:44:54 -0400
X-MC-Unique: jyPHo_ETP0iXAeVQpKdpDg-1
X-Mimecast-MFC-AGG-ID: jyPHo_ETP0iXAeVQpKdpDg_1780580692
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D4B71944D2B;
	Thu,  4 Jun 2026 13:44:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 426E61955D87;
	Thu,  4 Jun 2026 13:44:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:50 +0400
Subject: [PATCH v5 04/12] system/ram-discard-manager: implement replay via
 is_populated iteration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-4-5768e6a0943d@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>, 
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=znVW5921M7+0092ia+MeDcCo7lcpbF5fnLhhQFRfDqg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEwCZfScNDE5Vpjil/kVwVsL+hRHm2fLwKlH
 OvbKXyWk8qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMAAKCRDa6OEJdZac
 5aLTD/90+rze5UF4V7k4llDujSN41MD2hldcmVC8EUhex1DIX479ntPfkHKdl7IJJZVmZ5OyPAP
 8TKsnksokw9Jfa4zNKQQhlZiRQHnB6J+blGcT7yUBGq0+gwK3qTwDauxD3WE70un2a3QxSgAYaP
 2KT70j3Vl69CfiCGNrMcsgBWGix7ZZX559QgfDCiQ/goXk/T1bpEtpmf/ZvMpoKwm82FpZTrvpJ
 bwc9Krsq0kM17lM8smI4TmcYHN4u0l4SmB2wFqm9fmuU2107d2v/E5OAjaaQERa6M5YXjuTjdP0
 0JajWufgj6u2gznVtyv/DxZaMnOwEqwEMiWOWey9VHjYfoGNzEsXDVRdAvsD7FjeIIStSgcMTul
 bxw0isQCUOKQxaMFe6tNLuxddIUHx+yiBXogdWnh1m6gVb4tYJMPTIwR3nF8skAYPIzqldKgcB0
 zGb1R9oF7zkT4v+aphWkOF36NQ3DBsEV/QlsmVuteEp4zPkz+ikN1T71IE9pIiRMDseL1bf7S7G
 SpfwoSzxf3P/9IYRt/FZZkr8VxbzLbTgAUBMCLUCAbo3cuzTlnSWR1GdemNGKWIl8hgLuUu36yH
 iaaHkgmVwEm7Jlt0UqkKV4UcmbkeC948T2UXFU9iNIZW8X+3uqZtxlF5XK3D1m6TxPq2wILJ34+
 kmNQF1xPgrW6pqQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace the source-level replay wrappers with a new
replay_by_populated_state() helper that iterates the section at
min-granularity, calls is_populated() for each chunk, and aggregates
consecutive chunks of the same state before invoking the callback.

This moves the iteration logic from individual sources into the manager,
preparing for multi-source aggregation where the manager must combine
state from multiple sources anyway.

The replay_populated/replay_discarded vtable entries in
RamDiscardSourceClass are no longer called but remain in the interface
for now; they will be removed in follow-up commits along with the
now-dead source implementations.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/ram-discard-manager.c | 85 +++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 24 deletions(-)

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 1c9ff7fda58..a907ddf3708 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -27,26 +27,65 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
     return rdsc->is_populated(rds, section);
 }
 
-static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
+/*
+ * Iterate the section at source granularity, aggregating consecutive chunks
+ * with matching populated state, and call replay_fn for each run.
+ */
+static int replay_by_populated_state(const RamDiscardManager *rdm,
+                                     const MemoryRegionSection *section,
+                                     bool replay_populated,
+                                     ReplayRamDiscardState replay_fn,
+                                     void *opaque)
 {
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    uint64_t granularity, offset, size, end, pos, run_start = 0;
+    bool in_run = false;
+    int ret = 0;
 
-    g_assert(rdsc->replay_populated);
-    return rdsc->replay_populated(rds, section, replay_fn, opaque);
-}
+    granularity = ram_discard_source_get_min_granularity(rdm->rds, rdm->mr);
+    offset = section->offset_within_region;
+    size = int128_get64(section->size);
+    end = offset + size;
+
+    /* Align iteration to granularity boundaries */
+    pos = QEMU_ALIGN_DOWN(offset, granularity);
+
+    for (; pos < end; pos += granularity) {
+        MemoryRegionSection chunk = {
+            .mr = section->mr,
+            .offset_within_region = pos,
+            .size = int128_make64(granularity),
+        };
+        bool populated = ram_discard_source_is_populated(rdm->rds, &chunk);
+
+        if (populated == replay_populated) {
+            if (!in_run) {
+                run_start = pos;
+                in_run = true;
+            }
+        } else if (in_run) {
+            MemoryRegionSection tmp = *section;
+
+            if (memory_region_section_intersect_range(&tmp, run_start,
+                                                      pos - run_start)) {
+                ret = replay_fn(&tmp, opaque);
+                if (ret) {
+                    return ret;
+                }
+            }
+            in_run = false;
+        }
+    }
 
-static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               const MemoryRegionSection *section,
-                                               ReplayRamDiscardState replay_fn,
-                                               void *opaque)
-{
-    RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_GET_CLASS(rds);
+    if (in_run) {
+        MemoryRegionSection tmp = *section;
 
-    g_assert(rdsc->replay_discarded);
-    return rdsc->replay_discarded(rds, section, replay_fn, opaque);
+        if (memory_region_section_intersect_range(&tmp, run_start,
+                                                  pos - run_start)) {
+            ret = replay_fn(&tmp, opaque);
+        }
+    }
+
+    return ret;
 }
 
 RamDiscardManager *ram_discard_manager_new(MemoryRegion *mr,
@@ -78,8 +117,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_populated(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, true, replay_fn, opaque);
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
@@ -87,8 +125,7 @@ int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
-    return ram_discard_source_replay_discarded(rdm->rds, section,
-                                               replay_fn, opaque);
+    return replay_by_populated_state(rdm, section, false, replay_fn, opaque);
 }
 
 static void ram_discard_manager_initfn(Object *obj)
@@ -182,8 +219,8 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
     rdl->section = memory_region_section_new_copy(section);
     QLIST_INSERT_HEAD(&rdm->rdl_list, rdl, next);
 
-    ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                              rdm_populate_cb, rdl);
+    ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                               rdm_populate_cb, rdl);
     if (ret) {
         error_report("%s: Replaying populated ranges failed: %s", __func__,
                      strerror(-ret));
@@ -208,8 +245,8 @@ int ram_discard_manager_replay_populated_to_listeners(RamDiscardManager *rdm)
     int ret = 0;
 
     QLIST_FOREACH(rdl, &rdm->rdl_list, next) {
-        ret = ram_discard_source_replay_populated(rdm->rds, rdl->section,
-                                                  rdm_populate_cb, rdl);
+        ret = ram_discard_manager_replay_populated(rdm, rdl->section,
+                                                   rdm_populate_cb, rdl);
         if (ret) {
             break;
         }

-- 
2.54.0

