Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD914AD20
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580707; cv=none; b=DgHDXsqsOiSijC3JS/ggHyfSVaOAX1Mh6zbFIPiifdJtY0yby9R5HbEH4YfCEZwg0QEabQKqQmDheCPezWDgU1k3xM/POpJHyMTlfThFYl16LcOVgq4cV2IWMJxbV6SbBYmVAj3A0FLsxMWpSTOe5Zvz+qoL4Ltv7l2MPQVmQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580707; c=relaxed/simple;
	bh=OJfVRBp7kCu62VvYNEMbvrRpWVFwhQJwSIkKTdgTM0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAKIyk0DL4bD7L41H0u3vpi8KjdEUZNMnHaMMC2CiTNMo+w6gdaKW/KX/mbPd0Cn2mMN/n8vRUP+6j20E1zhUz0XNqZSzoKTbyS8pcrnGLsRc1gIsw1NivxIH9AV9b4vCGFkGBBRDyuD0VHCgYauUGeWqigCgRZAAUUoq8d3beE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctpDd6V/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctpDd6V/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AsFFSlmcPgz7P59Jq1uN1IgQFXLbNpyWVcPlkHq1ipM=;
	b=ctpDd6V/DLuWWsl+IkSr4rWg2XNZJlXbMvMAxlzySRAIsrFDAZ48dRjkFzAY4BfAZ2LTc0
	00zF8VF2DNSCFQnMiGGXjI6BFDjvpn4ixEJEShUHEMNXy9ngS6pLe28hyh2IGo5WMqwNRN
	79yEsAhw5ZFFl49i0Li2dtqOO7wEOqA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-qfCjTpTzMWKKvnSxi9D55Q-1; Thu,
 04 Jun 2026 09:45:00 -0400
X-MC-Unique: qfCjTpTzMWKKvnSxi9D55Q-1
X-Mimecast-MFC-AGG-ID: qfCjTpTzMWKKvnSxi9D55Q_1780580698
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BC6A1800347;
	Thu,  4 Jun 2026 13:44:58 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D5C51955BC0;
	Thu,  4 Jun 2026 13:44:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:51 +0400
Subject: [PATCH v5 05/12] virtio-mem: remove
 replay_populated/replay_discarded implementation
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-5-5768e6a0943d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5923;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OJfVRBp7kCu62VvYNEMbvrRpWVFwhQJwSIkKTdgTM0k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYExU3XsLYMtzB6g9a2modKeMvbuSi/RhKIEJ
 xPm44PSgLuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMQAKCRDa6OEJdZac
 5QyDEAC1IKVU66N5vpwBNfqfKEeFtZnWip/EZlk8WqJ/wNXONiL0142IWp0g0BdMvjvSaigqrx1
 MbcSao7FUjT055+E3UraMDXM8sm5KYWxByptwmw1nNbXjxwamOLFOefoKfpKRA+c9FSxLpDapUJ
 cd9W7FSxtNZU/S+5hNg4jGM14pCfiqvusB6cPNbYGIvS1Dmz0TsdwPmeDDUwobjnU188jldAEWP
 9mIQkxutRAtoktRXGU1YC4MILVaMyYAvyTKX1MIQkRf5jKpMu80tkeh3hizGv7RcfpL+NhmC8MN
 EZLznrnEmlCIG6/f1ZuzWQ5WHZWLXTT/ruswsS3hun9WBPxE307BODeAqhE8PNKhNMolyZR0uM5
 ONARGWMNe/qcEAJ+UO3rFK/kzGlwQVgYESnGX8WCJpCKf2tC4txFKSmILPfYChC3oD5e2hAFeIP
 w1b0knitK+Lr/snJMVVPU2Mo2osjItNbsvr3o4Fb0Ei0n+PPAy2dkhos4p3l6XsJodNJNQUdnjQ
 4Zj2Gmb+ZtzukUhmb29NejpefK86U7VbwbaBBzrlC1ReRqbIdZFiJmZGVDgl7EVQx64lUMiGxRC
 L4zaM3CV2jLpCira/9mk15V3HwLHW5vNi6bUsso3UiG+R17O9d+4zhhiPeXhGKDHdu4y9bUxN/p
 yb8Qp7FxxawblhQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The replay iteration logic has been moved into the RamDiscardManager,
which now iterates at source granularity using is_populated(). The
source-level replay_populated/replay_discarded methods and their
helpers are no longer called.

Remove the now-dead replay methods, the VirtIOMEMReplayData struct,
the virtio_mem_for_each_plugged/unplugged_section() helpers (only used
by the replay methods), and the virtio_mem_section_cb typedef.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/virtio/virtio-mem.c | 112 -------------------------------------------------
 1 file changed, 112 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ec165503205..2b67b2882d2 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -259,72 +259,6 @@ static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
     return ret;
 }
 
-typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void *arg);
-
-static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
-                                               const MemoryRegionSection *s,
-                                               void *arg,
-                                               virtio_mem_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    int ret = 0;
-
-    first_bit = s->offset_within_region / vmem->block_size;
-    first_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size, first_bit);
-    while (first_bit < vmem->bitmap_size) {
-        MemoryRegionSection tmp = *s;
-
-        offset = first_bit * vmem->block_size;
-        last_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
-                                      first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * vmem->block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-        ret = cb(&tmp, arg);
-        if (ret) {
-            break;
-        }
-        first_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
-                                  last_bit + 2);
-    }
-    return ret;
-}
-
-static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
-                                                 const MemoryRegionSection *s,
-                                                 void *arg,
-                                                 virtio_mem_section_cb cb)
-{
-    unsigned long first_bit, last_bit;
-    uint64_t offset, size;
-    int ret = 0;
-
-    first_bit = s->offset_within_region / vmem->block_size;
-    first_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size, first_bit);
-    while (first_bit < vmem->bitmap_size) {
-        MemoryRegionSection tmp = *s;
-
-        offset = first_bit * vmem->block_size;
-        last_bit = find_next_bit(vmem->bitmap, vmem->bitmap_size,
-                                 first_bit + 1) - 1;
-        size = (last_bit - first_bit + 1) * vmem->block_size;
-
-        if (!memory_region_section_intersect_range(&tmp, offset, size)) {
-            break;
-        }
-        ret = cb(&tmp, arg);
-        if (ret) {
-            break;
-        }
-        first_bit = find_next_zero_bit(vmem->bitmap, vmem->bitmap_size,
-                                       last_bit + 2);
-    }
-    return ret;
-}
-
 static void virtio_mem_notify_unplug(VirtIOMEM *vmem, uint64_t offset,
                                      uint64_t size)
 {
@@ -1667,50 +1601,6 @@ static bool virtio_mem_rds_is_populated(const RamDiscardSource *rds,
     return virtio_mem_is_range_plugged(vmem, start_gpa, end_gpa - start_gpa);
 }
 
-struct VirtIOMEMReplayData {
-    ReplayRamDiscardState fn;
-    void *opaque;
-};
-
-static int virtio_mem_rds_replay_cb(MemoryRegionSection *s, void *arg)
-{
-    struct VirtIOMEMReplayData *data = arg;
-
-    return data->fn(s, data->opaque);
-}
-
-static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
-                                           const MemoryRegionSection *s,
-                                           ReplayRamDiscardState replay_fn,
-                                           void *opaque)
-{
-    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
-    struct VirtIOMEMReplayData data = {
-        .fn = replay_fn,
-        .opaque = opaque,
-    };
-
-    g_assert(s->mr == &vmem->memdev->mr);
-    return virtio_mem_for_each_plugged_section(vmem, s, &data,
-                                               virtio_mem_rds_replay_cb);
-}
-
-static int virtio_mem_rds_replay_discarded(const RamDiscardSource *rds,
-                                           const MemoryRegionSection *s,
-                                           ReplayRamDiscardState replay_fn,
-                                           void *opaque)
-{
-    const VirtIOMEM *vmem = VIRTIO_MEM(rds);
-    struct VirtIOMEMReplayData data = {
-        .fn = replay_fn,
-        .opaque = opaque,
-    };
-
-    g_assert(s->mr == &vmem->memdev->mr);
-    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
-                                                 virtio_mem_rds_replay_cb);
-}
-
 static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
 {
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_OFF) {
@@ -1766,8 +1656,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
 
     rdsc->get_min_granularity = virtio_mem_rds_get_min_granularity;
     rdsc->is_populated = virtio_mem_rds_is_populated;
-    rdsc->replay_populated = virtio_mem_rds_replay_populated;
-    rdsc->replay_discarded = virtio_mem_rds_replay_discarded;
 }
 
 static const TypeInfo virtio_mem_info = {

-- 
2.54.0

