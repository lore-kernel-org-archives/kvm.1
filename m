Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912113DB338
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580749; cv=none; b=RgE65klNe2EVztoU83FMvFgPovxB7mnHgGQOgB0emFzCuc0L7OVMBubLxJFi0hYAJFjc8fWy4n8nRUyq316A9QP3YOlyFLckVjF6vaGcvUJgsswBoW2SnqPEs1eNX6zfbZF3d7+a1zYgY/ugUbn1gWdDmSQr/N3qal/zWZTPsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580749; c=relaxed/simple;
	bh=SyRGQ/9CVUTbXvPLmC2d6rfZWAqfBUeosfx/J9loDVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snVH28aIm4FrqXXEICjHAhCpHaJ1o2rJW7QFoGgb9qSoJ06RDR+VWElOK38UJbzAhdnXtTTtp3OniuvfVk9mecv4KqGt9hHjW+wkZsd7Ad3oUIAFFyyuDANNgj8qZfEwIsQwkYMelmKFIGQ6KQo2m/k7XFhM+uhQocqzcSPlf8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKezTEXk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKezTEXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Qk2+qTC/ZptS126mlZBTuBUK9Xm//0eYY52so2sEX8=;
	b=UKezTEXkaL1GSKWYrb7V8yZIWPq8zZO3twm9/K6LggL9JRK0TSKFAzT7PTHS8cHBGL8Gbu
	fztqyy7O4zjFgnvAOXhDQq7I98qMmhfxJSp0lO8ArR1WKAAbjDlxJDpUUDsD2BgUlbZu69
	wSZ2JCv+3b6OnrEosQiOzUb3Tfh6dI0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-sHB9DW_8M3WnPz0-V5_KEw-1; Thu,
 04 Jun 2026 09:45:43 -0400
X-MC-Unique: sHB9DW_8M3WnPz0-V5_KEw-1
X-Mimecast-MFC-AGG-ID: sHB9DW_8M3WnPz0-V5_KEw_1780580740
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB340195609F;
	Thu,  4 Jun 2026 13:45:40 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AC7D180049F;
	Thu,  4 Jun 2026 13:45:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:58 +0400
Subject: [PATCH v5 12/12] RFC: monitor: add 'info ramblock-attributes'
 command
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-12-5768e6a0943d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8557;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SyRGQ/9CVUTbXvPLmC2d6rfZWAqfBUeosfx/J9loDVU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEys+d/G6REnNvFNdV9GPUy6EU6lmfCxV5SS
 1VqWaOGX/+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMgAKCRDa6OEJdZac
 5X3QD/43KopmhpfJ7O2wtHVsi5AGEmd4A9DFBDSptNQo0ExXfj6Y6RgUxJo+VvgETkPrWvRdyrN
 6ZeB3Fzsdo239PHHhh6WPt1F4tjEVic0JEcd1ke8AoNTR6WpyGFNECIg6zrV3sjuBTIZtT12Dy4
 +KNDTXhxmSaBg/ZBjbtXZwRzVuO3e3CUTy/x6ifUXEcxVlLAIksh1uV7+nPpU+UhfWKgcptukMM
 NlpO3cIGV6oVoNKu9YcPqQlHAA3ylXUaFoSzblN/8J3BXjIoxk+NhgBhfLsr8oawVvMfQJ9VZvl
 qhnE+utnN4xch1AcWYL/tz5i2o6cosT2KQuRmiwdr7zQp5BRSXstTMZ+nHhonYm1vJtnhZN6Ipp
 tyUTUiF/q9GmSy4gBEuIconz1dYLx1wBf2ONRp3sA6rc1tc8xEBJ2VOkCdr/ZGZQLxGTNOCAd9b
 cLfgWQIZEZZmJBzc4k6/y/fPaXrxFh3jLczA+71ycYj2YRFUY932oeXyhJDqxBDIY8of07Ei+iv
 VdQBVjdu0dWQVLb7eQaXnbo77vlH2UHgIbCiri9h94JYwW3eTZXtvoCDn92WxbQgdZmbHilGKdq
 HyEEyZ9bjUm2gVgbKPWDGzlgKOg2YF/tBgxE78feJ1U0X6dcVcBYgXpeY7KK7OTYn0mW1kn72lR
 /A4ZnGstMoJ/6Xg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a new 'info ramblock-attributes' HMP command and the corresponding
'x-query-ramblock-attributes' QMP command to display the shared/private
memory attributes for ram blocks.

The QMP command returns structured data (RamBlockAttributesInfo list
with per-range shared/populated attributes), while HMP formats it for
human consumption.

This is useful for debugging confidential guests (TDX, SNP) to inspect
which memory regions are shared vs private, and their population state
when a RamDiscardManager is present (e.g. virtio-mem).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json             | 56 ++++++++++++++++++++++++++++++++++
 include/monitor/hmp.h         |  1 +
 hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
 system/ram-block-attributes.c | 71 +++++++++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx          | 13 ++++++++
 5 files changed, 173 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b87..a1af5c61176 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1738,6 +1738,62 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
+##
+# @RamBlockAttributeRange:
+#
+# A contiguous range within a ram block with uniform attributes.
+#
+# @start: start offset in bytes within the ram block
+#
+# @length: length in bytes of the range
+#
+# @shared: true if the range is shared, false if private
+#
+# @populated: true if the entire range is fully populated across all
+#     RamDiscardManager sources; false if any sub-block is discarded.
+#     Only present when a RamDiscardManager is managing the block.
+#
+# Since: 11.1
+##
+{ 'struct': 'RamBlockAttributeRange',
+  'data': { 'start': 'uint64',
+            'length': 'uint64',
+            'shared': 'bool',
+            '*populated': 'bool' } }
+
+##
+# @RamBlockAttributesInfo:
+#
+# Shared/private memory attributes for a ram block.
+#
+# @name: the ram block identifier
+#
+# @ranges: list of attribute ranges
+#
+# Since: 11.1
+##
+{ 'struct': 'RamBlockAttributesInfo',
+  'data': { 'name': 'str',
+            'ranges': [ 'RamBlockAttributeRange' ] } }
+
+##
+# @x-query-ramblock-attributes:
+#
+# Query ram block shared/private attributes.  This is useful
+# to debug confidential guests.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: list of ram block attributes
+#
+# Since: 11.1
+##
+{ 'command': 'x-query-ramblock-attributes',
+  'returns': [ 'RamBlockAttributesInfo' ],
+  'features': [ 'unstable' ] }
+
 ##
 # @x-query-roms:
 #
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9258a049bff..c069d5de8d1 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -137,6 +137,7 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 46846f741a2..122e1a0f735 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -24,6 +24,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "system/numa.h"
+#include "system/ramblock.h"
 #include "hw/core/boards.h"
 
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
@@ -388,3 +389,34 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, err);
 }
+
+void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    g_autoptr(RamBlockAttributesInfoList) list = NULL;
+    RamBlockAttributesInfoList *it;
+
+    list = qmp_x_query_ramblock_attributes(&err);
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
+
+    for (it = list; it; it = it->next) {
+        RamBlockAttributesInfo *rba = it->value;
+        RamBlockAttributeRangeList *r;
+
+        monitor_printf(mon, "%s:\n", rba->name);
+        for (r = rba->ranges; r; r = r->next) {
+            RamBlockAttributeRange *range = r->value;
+            const char *shared = range->shared ? "shared" : "private";
+            const char *pop = range->has_populated ?
+                (range->populated ? "+populated" : "-populated") : "";
+
+            monitor_printf(mon,
+                           "  0x%016" PRIx64 "-0x%016" PRIx64 " %s%s\n",
+                           range->start,
+                           range->start + range->length - 1,
+                           shared, pop);
+        }
+    }
+}
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 59ec7a28eb0..fb657ffca35 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-commands-machine.h"
 #include "system/ramblock.h"
 #include "trace.h"
 
@@ -221,3 +222,73 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
     rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
     rdsc->is_populated = ram_block_attributes_rds_is_populated;
 }
+
+RamBlockAttributesInfoList *qmp_x_query_ramblock_attributes(Error **errp)
+{
+    RamBlockAttributesInfoList *head = NULL, **tail = &head;
+    RAMBlock *block;
+    size_t rba_block_size = ram_block_attributes_get_block_size();
+
+    RCU_READ_LOCK_GUARD();
+
+    RAMBLOCK_FOREACH(block) {
+        RamBlockAttributesInfo *rba;
+        RamBlockAttributeRangeList **range_tail;
+        RamBlockAttributes *attr = block->attributes;
+        RamDiscardManager *rdm;
+        unsigned long pos;
+
+        if (!attr) {
+            continue;
+        }
+
+        rdm = memory_region_get_ram_discard_manager(block->mr);
+        g_assert(rdm);
+
+        rba = g_new0(RamBlockAttributesInfo, 1);
+        rba->name = g_strdup(block->idstr);
+        range_tail = &rba->ranges;
+
+        pos = 0;
+        while (pos < attr->bitmap_size) {
+            bool is_shared = test_bit(pos, attr->bitmap);
+            unsigned long next;
+            uint64_t start_offset, length;
+            RamBlockAttributeRange *range;
+
+            if (is_shared) {
+                next = find_next_zero_bit(attr->bitmap,
+                                          attr->bitmap_size, pos);
+            } else {
+                next = find_next_bit(attr->bitmap,
+                                     attr->bitmap_size, pos);
+            }
+
+            start_offset = (uint64_t)pos * rba_block_size;
+            length = (uint64_t)(next - pos) * rba_block_size;
+
+            range = g_new0(RamBlockAttributeRange, 1);
+            range->start = start_offset;
+            range->length = length;
+            range->shared = is_shared;
+
+            {
+                MemoryRegionSection section = {
+                    .mr = block->mr,
+                    .offset_within_region = start_offset,
+                    .size = int128_make64(length),
+                };
+                range->has_populated = true;
+                range->populated =
+                    ram_discard_manager_is_populated(rdm, &section);
+            }
+
+            QAPI_LIST_APPEND(range_tail, range);
+            pos = next;
+        }
+
+        QAPI_LIST_APPEND(tail, rba);
+    }
+
+    return head;
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c21..f119b9cfebc 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -761,6 +761,19 @@ SRST
     Dump all the ramblocks of the system.
 ERST
 
+    {
+        .name       = "ramblock-attributes",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Display ramblock shared/private attributes",
+        .cmd        = hmp_info_ramblock_attributes,
+    },
+
+SRST
+  ``info ramblock-attributes``
+    Display the shared/private memory attributes for ram blocks.
+ERST
+
     {
         .name       = "hotpluggable-cpus",
         .args_type  = "",

-- 
2.54.0

