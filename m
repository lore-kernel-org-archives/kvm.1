Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8F47DD44
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580693; cv=none; b=ADOS1/wmIgFrfeWw7HHyRjXM0rcmpkSdTAKwcOmberLfaJfLaZGcqfaeQud4dNGh5asBPc91d6/6fLioSQSDY8Pb+rj4htPzsmPPm5+zzrq/Pv4T5L+4GAzjLQye4hPAXOEjY7gJU2Nx0/wdTN7lO1DRamNAbue/Ck3iLtJEbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580693; c=relaxed/simple;
	bh=hsOVg7tfNvdNlKdVvwQtTFjqhtsx5tPExed/hVKen5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2uvVAieAQ+r1ER+ecdP4jbhvTpP2yPHWaEmRHXmaB+DnKqIrxwb6Tm8fGhrj09YkiRSRe5HcJrf2rAuFWCEqlW0yNnBeXRTkGrnedrliV8d1UlsR6l4AV888q4+8HeXHfNyNp4vF0v0PFZubGRPuaGBIDHnhLnXbY0rlnhiiCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVs8xne1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVs8xne1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780580691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UWN+04UBMj15nlZKWF5kruPALXdBmOnKOzox9aoPUg=;
	b=eVs8xne11T2IHk27ggrgljh2MPStl9qBeI8F/PSyTEE7VTU3x55O+ku5aQ118OuONu7dPE
	rhtqIsr5p1xmw8AJ0W/Yv+3LT+6ocoQ5Oo2dim+0yWLlSuXKe6mrKCxOsXB2+bomVVfk1s
	E9sSs6v9gmJUeVaLbj6icug0Va1il14=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-4NHMaoLeO_2EQx76GK54oQ-1; Thu,
 04 Jun 2026 09:44:47 -0400
X-MC-Unique: 4NHMaoLeO_2EQx76GK54oQ-1
X-Mimecast-MFC-AGG-ID: 4NHMaoLeO_2EQx76GK54oQ_1780580686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6EAF1956096;
	Thu,  4 Jun 2026 13:44:45 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D0F51955BC1;
	Thu,  4 Jun 2026 13:44:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 04 Jun 2026 17:43:49 +0400
Subject: [PATCH v5 03/12] system/memory: constify section arguments
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=16962;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hsOVg7tfNvdNlKdVvwQtTFjqhtsx5tPExed/hVKen5Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIYEwupYJ9cbC8oOsNO7ZY4Axfu/K2L1+WY3rS
 BNTPe439L+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiGBMAAKCRDa6OEJdZac
 5Q8DD/994m8iedVQiISyS/qyCX7CSHhrAfQ97UVoVDDvPVhuOo4LjcDkDzCa5vBNGzRBMjoTaDV
 EBzuyHOoLB7n4e/ckuqePeH7p3tzM4WDc00YkopyQ6/TTURuMiTcptS4z1bKc22LCpEUkcTTI2z
 DKNG6VOjwifDWqIh9T9x0NLILaiHwTlfXLIF3Fnh5h3aOGTMR5Px++uveteckg3B71v6h/e5D6P
 OFS79xYDrERPWzpvTA487+BnFHnU31ZTVdXQVwvLZxsS8tYUpyWgAuy3HvDJ2NKRsXB1O6BFuOL
 DGcKFRB8MNOQYgmrBoTBNGUGQpzCxwiLITAiQB508jqubVu3XJn81VTeBo5FcZWJ56tI+F4NOKr
 QMK7GaJNkzw34HQs8Eck+xJcW+nUeh1IS3R/i7COmpyDkEcP55N33+efxkbIuuH0y8UMp5teIWd
 Iwh05F2wAt5zdpvCVrsKUSZ7EaxJRyPAOKDRthOixabQ5f/W+1Cs76PZhvl6NUNPRayiyYx4var
 9XXds0ggy9OjLQX8yAdYVuleXGqH+lwegyd4lVal1u1dxfS/JEpTJ0b20XspNtEPDhjLFp7auv5
 i9erQfvK3uaOZ4Guk1JNdYRqR5DQ771fm3Y656saZZ2aWIzfhjGXWcvKUgEpWEL1GAY80kVJYVI
 2ghrUshzeOO7CSw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The sections shouldn't be modified.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/vfio/vfio-container.h     |  2 +-
 include/hw/vfio/vfio-cpr.h           |  2 +-
 include/system/ram-discard-manager.h | 14 +++++++-------
 hw/vfio/cpr-legacy.c                 |  4 ++--
 hw/vfio/listener.c                   | 10 +++++-----
 hw/virtio/virtio-mem.c               | 10 +++++-----
 migration/ram.c                      |  6 +++---
 system/memory_mapping.c              |  4 ++--
 system/ram-block-attributes.c        |  8 ++++----
 system/ram-discard-manager.c         | 10 +++++-----
 10 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index a7d5c5ed679..b2e7f4312c3 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -277,7 +277,7 @@ struct VFIOIOMMUClass {
 };
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainer *bcontainer, MemoryRegionSection *section);
+    VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
 void vfio_container_region_add(VFIOContainer *bcontainer,
                                MemoryRegionSection *section, bool cpr_remap);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 4606da500a7..ecabe0c747d 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -69,7 +69,7 @@ void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
 bool vfio_cpr_ram_discard_replay_populated(
-    struct VFIOContainer *bcontainer, MemoryRegionSection *section);
+    struct VFIOContainer *bcontainer, const MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
                              int nr, int fd);
diff --git a/include/system/ram-discard-manager.h b/include/system/ram-discard-manager.h
index da55658169f..b188e09a30f 100644
--- a/include/system/ram-discard-manager.h
+++ b/include/system/ram-discard-manager.h
@@ -26,9 +26,9 @@ DECLARE_OBJ_CHECKERS(RamDiscardSource, RamDiscardSourceClass,
 
 typedef struct RamDiscardListener RamDiscardListener;
 typedef int (*NotifyRamPopulate)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
+                                 const MemoryRegionSection *section);
 typedef void (*NotifyRamDiscard)(RamDiscardListener *rdl,
-                                 MemoryRegionSection *section);
+                                 const MemoryRegionSection *section);
 
 struct RamDiscardListener {
     /*
@@ -86,7 +86,7 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
  *
  * Returns 0 on success, or a negative error if failed.
  */
-typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
+typedef int (*ReplayRamDiscardState)(const MemoryRegionSection *section,
                                      void *opaque);
 
 /*
@@ -151,7 +151,7 @@ struct RamDiscardSourceClass {
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_populated)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
+                            const MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
 
     /**
@@ -168,7 +168,7 @@ struct RamDiscardSourceClass {
      * Returns 0 on success, or a negative error if any notification failed.
      */
     int (*replay_discarded)(const RamDiscardSource *rds,
-                            MemoryRegionSection *section,
+                            const MemoryRegionSection *section,
                             ReplayRamDiscardState replay_fn, void *opaque);
 };
 
@@ -237,7 +237,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
  * Returns 0 on success, or a negative error if any notification failed.
  */
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
@@ -255,7 +255,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
  * Returns 0 on success, or a negative error if any notification failed.
  */
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque);
 
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index c431d899731..2d40d8baeaf 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -226,7 +226,7 @@ void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
-static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+static int vfio_cpr_rdm_remap(const MemoryRegionSection *section, void *opaque)
 {
     RamDiscardListener *rdl = opaque;
 
@@ -242,7 +242,7 @@ static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
 bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
-                                           MemoryRegionSection *section)
+                                           const MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl =
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 0b72a2cf5e5..fbff1344448 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -201,7 +201,7 @@ out:
 }
 
 static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -219,7 +219,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
 }
 
 static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+                                            const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -461,7 +461,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 }
 
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
-    VFIOContainer *bcontainer, MemoryRegionSection *section)
+    VFIOContainer *bcontainer, const MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl;
 
@@ -1143,8 +1143,8 @@ out:
     }
 }
 
-static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
-                                             void *opaque)
+static int vfio_ram_discard_query_dirty_bitmap(const MemoryRegionSection *section,
+                                               void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index be149ee9441..ec165503205 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -262,7 +262,7 @@ static int virtio_mem_for_each_plugged_range(VirtIOMEM *vmem, void *arg,
 typedef int (*virtio_mem_section_cb)(MemoryRegionSection *s, void *arg);
 
 static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
-                                               MemoryRegionSection *s,
+                                               const MemoryRegionSection *s,
                                                void *arg,
                                                virtio_mem_section_cb cb)
 {
@@ -294,7 +294,7 @@ static int virtio_mem_for_each_plugged_section(const VirtIOMEM *vmem,
 }
 
 static int virtio_mem_for_each_unplugged_section(const VirtIOMEM *vmem,
-                                                 MemoryRegionSection *s,
+                                                 const MemoryRegionSection *s,
                                                  void *arg,
                                                  virtio_mem_section_cb cb)
 {
@@ -1680,7 +1680,7 @@ static int virtio_mem_rds_replay_cb(MemoryRegionSection *s, void *arg)
 }
 
 static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
-                                           MemoryRegionSection *s,
+                                           const MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
@@ -1692,11 +1692,11 @@ static int virtio_mem_rds_replay_populated(const RamDiscardSource *rds,
 
     g_assert(s->mr == &vmem->memdev->mr);
     return virtio_mem_for_each_plugged_section(vmem, s, &data,
-                                            virtio_mem_rds_replay_cb);
+                                               virtio_mem_rds_replay_cb);
 }
 
 static int virtio_mem_rds_replay_discarded(const RamDiscardSource *rds,
-                                           MemoryRegionSection *s,
+                                           const MemoryRegionSection *s,
                                            ReplayRamDiscardState replay_fn,
                                            void *opaque)
 {
diff --git a/migration/ram.c b/migration/ram.c
index fc38ffbf8af..b2c7ec43b6a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -860,7 +860,7 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
     return ret;
 }
 
-static int dirty_bitmap_clear_section(MemoryRegionSection *section,
+static int dirty_bitmap_clear_section(const MemoryRegionSection *section,
                                       void *opaque)
 {
     const hwaddr offset = section->offset_within_region;
@@ -1588,7 +1588,7 @@ static inline void populate_read_range(RAMBlock *block, ram_addr_t offset,
     }
 }
 
-static inline int populate_read_section(MemoryRegionSection *section,
+static inline int populate_read_section(const MemoryRegionSection *section,
                                         void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
@@ -1663,7 +1663,7 @@ void ram_write_tracking_prepare(void)
     }
 }
 
-static inline int uffd_protect_section(MemoryRegionSection *section,
+static inline int uffd_protect_section(const MemoryRegionSection *section,
                                        void *opaque)
 {
     const hwaddr size = int128_get64(section->size);
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index da708a08ab7..cacef504f68 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -196,7 +196,7 @@ typedef struct GuestPhysListener {
 } GuestPhysListener;
 
 static void guest_phys_block_add_section(GuestPhysListener *g,
-                                         MemoryRegionSection *section)
+                                         const MemoryRegionSection *section)
 {
     const hwaddr target_start = section->offset_within_address_space;
     const hwaddr target_end = target_start + int128_get64(section->size);
@@ -248,7 +248,7 @@ static void guest_phys_block_add_section(GuestPhysListener *g,
 #endif
 }
 
-static int guest_phys_ram_populate_cb(MemoryRegionSection *section,
+static int guest_phys_ram_populate_cb(const MemoryRegionSection *section,
                                       void *opaque)
 {
     GuestPhysListener *g = opaque;
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index a72924eea7d..79c7e97d9a1 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -37,7 +37,7 @@ typedef int (*ram_block_attributes_section_cb)(MemoryRegionSection *s,
 
 static int
 ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
-                                                MemoryRegionSection *section,
+                                                const MemoryRegionSection *section,
                                                 void *arg,
                                                 ram_block_attributes_section_cb cb)
 {
@@ -78,7 +78,7 @@ ram_block_attributes_for_each_populated_section(const RamBlockAttributes *attr,
 
 static int
 ram_block_attributes_for_each_discarded_section(const RamBlockAttributes *attr,
-                                                MemoryRegionSection *section,
+                                                const MemoryRegionSection *section,
                                                 void *arg,
                                                 ram_block_attributes_section_cb cb)
 {
@@ -161,7 +161,7 @@ ram_block_attributes_rds_is_populated(const RamDiscardSource *rds,
 
 static int
 ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
-                                          MemoryRegionSection *section,
+                                          const MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
@@ -175,7 +175,7 @@ ram_block_attributes_rds_replay_populated(const RamDiscardSource *rds,
 
 static int
 ram_block_attributes_rds_replay_discarded(const RamDiscardSource *rds,
-                                          MemoryRegionSection *section,
+                                          const MemoryRegionSection *section,
                                           ReplayRamDiscardState replay_fn,
                                           void *opaque)
 {
diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 3d8c85617d7..1c9ff7fda58 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -28,7 +28,7 @@ static bool ram_discard_source_is_populated(const RamDiscardSource *rds,
 }
 
 static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
+                                               const MemoryRegionSection *section,
                                                ReplayRamDiscardState replay_fn,
                                                void *opaque)
 {
@@ -39,7 +39,7 @@ static int ram_discard_source_replay_populated(const RamDiscardSource *rds,
 }
 
 static int ram_discard_source_replay_discarded(const RamDiscardSource *rds,
-                                               MemoryRegionSection *section,
+                                               const MemoryRegionSection *section,
                                                ReplayRamDiscardState replay_fn,
                                                void *opaque)
 {
@@ -74,7 +74,7 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
 }
 
 int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
@@ -83,7 +83,7 @@ int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
 }
 
 int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
-                                         MemoryRegionSection *section,
+                                         const MemoryRegionSection *section,
                                          ReplayRamDiscardState replay_fn,
                                          void *opaque)
 {
@@ -164,7 +164,7 @@ void ram_discard_manager_notify_discard_all(RamDiscardManager *rdm)
     }
 }
 
-static int rdm_populate_cb(MemoryRegionSection *section, void *opaque)
+static int rdm_populate_cb(const MemoryRegionSection *section, void *opaque)
 {
     RamDiscardListener *rdl = opaque;
 

-- 
2.54.0

