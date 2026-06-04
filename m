Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC4F23C503
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580713; cv=none; b=pO/sVV6DfIeCfSQwbfoPz9lpQTpvvdbjyiRmn7i/qNdhWsrfrSGFY76maOmrxGdwk0PBdFHTb3mtGyNGKWpZlLOG/4SHrgnJo3ZglfoooqjuoK1AkWpDP2DB0CCjHtrba1tAzcChrYEukz6EQPe7/zWUW4CTDMmMbyZ7JFYC+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580713; c=relaxed/simple;
	bh=qRl+3gxMvyFk75I9Bv7L080thrk1YE9Z2FNe7f5N5Uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRlhffMn+zzgkEDsxOkDq61h02NlWfcSZHVF1qdyZgiO2Ob8uLNqxX6BYmJ50rKZox07gh760Eexz+TZyWyirmlyB08SGyQ6w0ZEluGaU/IJViZdRXiIcjqZCvpVpy5t/3OTdEyTymPbxwTGz4OM408JieS8MsWka3jPk/dhJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fQG2pTyG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fQG2pTyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbejgn6peDRmBduDPks63yG3w03Q38Tv7Pv8zIRvQpE=;
	b=fQG2pTyGx/1UzMNC3GAdf+BECwyDbZQ41yEj4OoNsT3jGo51I6PZJ0S/c5K62TYdGiEPuZ
	rC3yzCcAsIVWh7hDwU6q6MQPsqMu1Ui3Q1IiCXTWDwL9/UeX/XYqh95qcTLkG3JlKXBxp3
	RA82TcvNv1tEfz2qyT53ECti5foZLfg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-tVQfd-0fP9O_rDjD2G2-oQ-1; Thu,
 04 Jun 2026 09:45:07 -0400
X-MC-Unique: tVQfd-0fP9O_rDjD2G2-oQ-1
X-Mimecast-MFC-AGG-ID: tVQfd-0fP9O_rDjD2G2-oQ_1780580704
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DB11800623;
	Thu,  4 Jun 2026 13:45:03 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A85A7195608E;
	Thu,  4 Jun 2026 13:45:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:52 +0400
Subject: [PATCH v5 06/12] system/ram-discard-manager: drop replay from
 source interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-6-5768e6a0943d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10226;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qRl+3gxMvyFk75I9Bv7L080thrk1YE9Z2FNe7f5N5Uk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEx7sBa/J6S+/iE3nEPk5PnbbAFGsZ+LDNRB
 1Ub54gNP4OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMQAKCRDa6OEJdZac
 5QTRD/4vDMyjTz552zfO/WoGfhzA0Z/VKR7hzGdkbtQ+K6ksYAVSVkBwyqjNmgdE2RQC5WvIemN
 4K1EEVEY3wBcSyZDGYn2dvNMBomOc5EkqAbbCmUgznHb1MKXzgjoSw4vYz4pMfeZdae6F11b/jY
 tTgzv8Jn9qcBsOcOTP0aH33ceNsjEiraol4IuyYzt7j8lO1ZD56NzuXLIuyXs2ov4YVTFVpHdBM
 vjUTQJAGO4M7x0eg+52CSCLuVPP7/MY03yQUYasyMPvrvU82vs1mN7W0dRzpTHps1I4dUke3bp4
 ApvJj2QdjD6uzHVTRfIEMynQA2ILFPuyb0GAlD4Fm2Y7McHlSJhBLwEpGEbLBRNHb6MID5tOuXE
 +PaWyhQTTpivjST/j7SGDhxQhS4iekW4TPOo/IgBdNobtv5tuP7o29tokaxfml7YqgsuDflos00
 MsUaf86xUx4cMPGu3tyYT99g9Cd0GU0Hs+dHRV/VCCNcVwu0x6pj/mYUh94RFZppexmTjs0ZEoX
 eARL+wwXRaVko0qrOME4tWHYl34ZATdvirs7xBwWb2G35R2TG0DuRPkCiAAETnYzv0d99OeTXBE
 QvYCVdv2upv+Ollnw6kYiJ5NpJ8HBUVmfo2nZ0bXs54UDV3fyvf3Kdbo1AQ58N9gI7QzF9+0yXv
 h/2Z1aErX8LvBsQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove replay_populated and replay_discarded from RamDiscardSourceClass
now that the RamDiscardManager handles replay iteration internally via
is_populated.

Remove the now-dead replay methods, helpers, and
for_each_populated/discarded_section() from ram-block-attributes, which
was the last source still carrying this code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/system/ram-discard-manager.h |  52 +++-----------
 system/ram-block-attributes.c        | 130 -----------------------------------
 2 files changed, 10 insertions(+), 172 deletions(-)

diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
index b188e09a30f..b5dbcb4a82d 100644
--- a/include/system/ram-discard-manager.h
+++ b/include/system/ram-discard-manager.h
@@ -77,8 +77,8 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
 /**
  * typedef ReplayRamDiscardState:
  *
- * The callback handler for #RamDiscardSourceClass.replay_populated/
- * #RamDiscardSourceClass.replay_discarded to invoke on populated/discarded
+ * The callback handler used by ram_discard_manager_replay_populated() and
+ * ram_discard_manager_replay_discarded() to invoke on populated/discarded
  * parts.
  *
  * @section: the #MemoryRegionSection of populated/discarded part
@@ -134,42 +134,6 @@ struct RamDiscardSourceClass {
      */
     bool (*is_populated)(const RamDiscardSource *rds,
                          const MemoryRegionSection *section);
-
-    /**
-     * @replay_populated:
-     *
-     * Call the #ReplayRamDiscardState callback for all populated parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * In case any call fails, no further calls are made.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_populated)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
-
-    /**
-     * @replay_discarded:
-     *
-     * Call the #ReplayRamDiscardState callback for all discarded parts within
-     * the #MemoryRegionSection via the #RamDiscardSource.
-     *
-     * @rds: the #RamDiscardSource
-     * @section: the #MemoryRegionSection
-     * @replay_fn: the #ReplayRamDiscardState callback
-     * @opaque: pointer to forward to the callback
-     *
-     * Returns 0 on success, or a negative error if any notification failed.
-     */
-    int (*replay_discarded)(const RamDiscardSource *rds,
-                            const MemoryRegionSection *section,
-                            ReplayRamDiscardState replay_fn, void *opaque);
 };
 
 /**
@@ -226,8 +190,10 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_populated:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_populated callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous populated range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
@@ -244,8 +210,10 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 /**
  * ram_discard_manager_replay_discarded:
  *
- * A wrapper to call the #RamDiscardSourceClass.replay_discarded callback
- * of the #RamDiscardSource sources.
+ * Iterate the given #MemoryRegionSection at minimum granularity, calling
+ * #RamDiscardSourceClass.is_populated for each chunk, and invoke @replay_fn
+ * for each contiguous discarded range. In case any call fails, no further
+ * calls are made.
  *
  * @rdm: the #RamDiscardManager
  * @section: the #MemoryRegionSection
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 79c7e97d9a1..718c7075cec 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -32,106 +32,6 @@ ram_block_attributes_get_block_size(void)
     return qemu_real_host_page_size();
 }
 
-typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
-                                               void *arg);
-
-static int
-ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                              first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                      first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                  last_bit + 2);
-    }
-
-    return ret;
-}
-
-static int
-ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
-                                                const MemoryRegionSection *section,
-                                                void *arg,
-                                                ram_block_attributes_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    const size_t block_size = ram_block_attributes_get_block_size();
-    int ret = 0;
-
-    first_bit = section->offset_within_region / block_size;
-    first_bit = find_next_zero_bit(attr->bitmap, attr->bitmap_size,
-                                   first_bit);
-
-    while (first_bit < attr->bitmap_size) {
-        MemoryRegionSection tmp = *section;
-
-        offset = first_bit * block_size;
-        last_bit = find_next_bit(attr->bitmap, attr->bitmap_size,
-                                 first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-
-        ret = cb(&tmp, arg);
-        if (ret) {
-            error_report("%s: Failed to notify RAM discard listener: %s",
-                         __func__, strerror(-ret));
-            break;
-        }
-
-        first_bit = find_next_zero_bit(attr->bitmap,
-                                       attr->bitmap_size,
-                                       last_bit + 2);
-    }
-
-    return ret;
-}
-
-
-typedef struct RamBlockAttributesReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-} RamBlockAttributesReplayData;
-
-static int ram_block_attributes_rds_replay_cb(MemoryRegionSection *section,
-                                              void *arg)
-{
-    RamBlockAttributesReplayData *data = arg;
-
-    return data->fn(section, data->opaque);
-}
-
 /* RamDiscardSource interface implementation */
 static uint64_t
 ram_block_attributes_rds_get_min_granularity(const RamDiscardSource *rds,
@@ -159,34 +59,6 @@ ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
     return first_discarded_bit > last_bit;
 }
 
-static int
-ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_populated_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
-static int
-ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
-                                          const MemoryRegionSection *section,
-                                          ReplayRamDiscardState replay_fn,
-                                          void *opaque)
-{
-    RamBlockAttributes *attr = RAM_BLOCK_ATTRIBUTES(rds);
-    RamBlockAttributesReplayData data = { .fn = replay_fn, .opaque = opaque };
-
-    g_assert(section->mr == attr->ram_block->mr);
-    return ram_block_attributes_for_each_discarded_section(attr, section, &data,
-        ram_block_attributes_rds_replay_cb);
-}
-
 static bool
 ram_block_attributes_is_valid_range(RamBlockAttributes *attr, uint64_t offset,
                                     uint64_t size)
@@ -346,6 +218,4 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
 
     rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
     rdsc->is_populated = ram_block_attributes_rds_is_populated;
-    rdsc->replay_populated = ram_block_attributes_rds_replay_populated;
-    rdsc->replay_discarded = ram_block_attributes_rds_replay_discarded;
 }

-- 
2.54.0

