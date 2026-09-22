Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EA83B47FF
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108388; cv=none; b=oD6C8JDtrITvgI2YRjIwnz2d8VdsNh95FBHkGImQypDhTOb5OVO/U5w9Xmx8Y+xxGgYkclNTS54nxYVbbjqC5bP5RfsJjm3tMwz7JZovt/uJc6PG5iKNwWoGFwBx6Bh6OkEoor+4erax+1KsZIa+f7EWXnI2dKeNiHpk8bhlh3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108388; c=relaxed/simple;
	bh=eKTevt0GpGNi9UNQRmH/tu4k22GUVBnqSGQEIe+cSTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWG8NoXZZduYpIEvlYNLmmWQBlX4r3YnL0s2fXuRXULFvJNDE2gYYI1Lz05dAxPngYajOTmEQNdxr01MnYK8+haRLOrqCpnxEe8htZ8dh2Z6miqGipYMm1CchSAvQcBbB2mdj2Zrq3lMRDJhdRjFhVEnNnjXfwY87P3kwSzVc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzTGHXls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzTGHXls"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790108368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0RZECvoBHybvITfeZazRxpJBGY5Us5QWdTiTh4eJGQ=;
	b=EzTGHXlsSZC5xS9Sazs69HyPGnthH0yW1EYA3iZ2J4DiovVzdcLumsu7b6/beu3bK8I3+6
	eAIW+KlZMJP00axYs1g3LxIurmv/Laftf1AWvE1pAnjqQYGQuxpuN4a3/kCx3r2qApgNZo
	8aV5uM8Rvh2nstpS7Up+Y8jv9c6Z9dU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-VNLNkaD4P-2mnLNtkrBY9Q-1; Tue,
 22 Sep 2026 16:19:24 -0400
X-MC-Unique: VNLNkaD4P-2mnLNtkrBY9Q-1
X-Mimecast-MFC-AGG-ID: VNLNkaD4P-2mnLNtkrBY9Q_1790108362
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3769C195398E;
	Tue, 22 Sep 2026 20:19:22 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 97E451956086;
	Tue, 22 Sep 2026 20:19:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:11 +0400
Subject: [PATCH 04/88] qom: auto-terminate interfaces array in
 OBJECT_DEFINE_TYPE macros
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-4-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org, 
 kvm@vger.kernel.org, qemu-s390x@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8994;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eKTevt0GpGNi9UNQRmH/tu4k22GUVBnqSGQEIe+cSTs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKugHMZS/3VcAn6w7feXTeNienazwdXDcINX
 ZeIF440SOCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirgAKCRDa6OEJdZac
 5XIWD/9OyIJMyyuZo+LCvFFlqu/g4cVR0RdIuB/+gmKWf/93TqgZNy16RbXjWcNUNzf9n8huaz8
 0yUnEuSFTz1BazDP6u1WqZybmkftuAI7eVEdGQ4KWdmvUl+NxbL1FdUxSj+xcJFSvkkCpIBFY0F
 o91bWMBpYtB7fQBziO0ZhiVwElgzOfbefzVA0o4JFsj0alZFuQtTKrBAB9DB9Miu7l1ij0GK2tY
 X+S3zY3qjqq3A0AG/u2+mmE2aYb+YZA31SWrYpRTj2b2eIKIPoa5UYzpb9Uph2EVRciaQw7Aisy
 K7hmd0+8/9wa/jXaO7FUgUFfxbH5JfD81HWzOCQqbEhfxcXANVSuuj4lAsY9Ii1FFOaOba6PWso
 8JLqL2WjuLfw9uXnL+xaVkJy9yg3t7FBQQdADt+XQpYg/21b0ucXvzweYpA9KIu1WylWbIzSkjU
 9nqXTw/o2rY9IhDijOzmtNfYs9oF7HsuYQpnRWPFVNIQiIatHqcKvNJb/zFzbbMWjmcwEIFJCWJ
 Yxe/XrdLqxTqhgf5ZQK9MjOshQw9UGJDV4c9dxC5QybYP5loB3WfFE5v4hLTPaG56XV2f0DFuQa
 +FqLwFEh3tVTWX676fkAucCe7jwRR/EahWqVEUfMZ35R86F8F0GVtHJD7W8WN+9sayDuHOVBRi5
 nDWOJixVBqFa4MQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The DO_OBJECT_DEFINE_TYPE_EXTENDED macro requires callers to manually
append a NULL sentinel to the interfaces list. Forgetting it causes
out-of-bounds reads during type registration, leading to run-time
crashes.

Append an empty initializer in the base macro so the sentinel is always
present, and drop the now-redundant manual terminators from all callers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/igvm-cfg.c           | 3 +--
 hw/acpi/pci.c                 | 6 ++----
 hw/core/reset.c               | 4 +++-
 hw/core/resetcontainer.c      | 5 ++++-
 hw/hyperv/hv-balloon.c        | 2 +-
 hw/ppc/pef.c                  | 3 +--
 hw/virtio/virtio-mem.c        | 6 +++++-
 include/qom/object.h          | 6 +++---
 system/ram-block-attributes.c | 3 +--
 target/i386/kvm/tdx.c         | 3 +--
 target/s390x/kvm/pv.c         | 3 +--
 11 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index 935ba54f54f3..8ec7d4ab6174 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -72,8 +72,7 @@ static void igvm_complete(UserCreatable *uc, Error **errp)
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
                                    { TYPE_USER_CREATABLE },
-                                   { TYPE_RESETTABLE_INTERFACE },
-                                   { NULL })
+                                   { TYPE_RESETTABLE_INTERFACE })
 
 static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index c82924be8620..5a96c0e77817 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -83,8 +83,7 @@ typedef struct AcpiGenericInitiatorClass {
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
                    ACPI_GENERIC_INITIATOR, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
+                   { TYPE_USER_CREATABLE })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
@@ -199,8 +198,7 @@ typedef struct AcpiGenericPortClass {
 
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
                    ACPI_GENERIC_PORT, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
+                   { TYPE_USER_CREATABLE })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
 
diff --git a/hw/core/reset.c b/hw/core/reset.c
index e7230b49b704..c35ac9b9c9a7 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -58,7 +58,9 @@ struct LegacyReset {
     bool skip_on_snapshot_load;
 };
 
-OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(LegacyReset, legacy_reset, LEGACY_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(LegacyReset, legacy_reset,
+                                          LEGACY_RESET, OBJECT,
+                                          { TYPE_RESETTABLE_INTERFACE })
 
 static ResettableState *legacy_reset_get_state(Object *obj)
 {
diff --git a/hw/core/resetcontainer.c b/hw/core/resetcontainer.c
index a4a6476a0363..cc46a1c62b82 100644
--- a/hw/core/resetcontainer.c
+++ b/hw/core/resetcontainer.c
@@ -24,7 +24,10 @@ struct ResettableContainer {
     GPtrArray *children;
 };
 
-OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ResettableContainer, resettable_container, RESETTABLE_CONTAINER, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(ResettableContainer,
+                                          resettable_container,
+                                          RESETTABLE_CONTAINER, OBJECT,
+                                          { TYPE_RESETTABLE_INTERFACE })
 
 void resettable_container_add(ResettableContainer *rc, Object *obj)
 {
diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index b8664a246b47..36e54c6a4c26 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -160,7 +160,7 @@ typedef struct HvBalloon {
 
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(HvBalloon, hv_balloon, \
                                           HV_BALLOON, VMBUS_DEVICE, \
-                                          { TYPE_MEMORY_DEVICE }, { })
+                                          { TYPE_MEMORY_DEVICE })
 
 #define HV_BALLOON_SET_STATE(hvb, news)             \
     do {                                            \
diff --git a/hw/ppc/pef.c b/hw/ppc/pef.c
index 39b4ce94f10b..a055774caebc 100644
--- a/hw/ppc/pef.c
+++ b/hw/ppc/pef.c
@@ -124,8 +124,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(PefGuest,
                                    pef_guest,
                                    PEF_GUEST,
                                    CONFIDENTIAL_GUEST_SUPPORT,
-                                   { TYPE_USER_CREATABLE },
-                                   { NULL })
+                                   { TYPE_USER_CREATABLE })
 
 static void pef_guest_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9c..488ee25dec53 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1681,7 +1681,11 @@ static void virtio_register_types(void)
 
 type_init(virtio_register_types)
 
-OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(VirtioMemSystemReset, virtio_mem_system_reset, VIRTIO_MEM_SYSTEM_RESET, OBJECT, { TYPE_RESETTABLE_INTERFACE }, { })
+OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(VirtioMemSystemReset,
+                                          virtio_mem_system_reset,
+                                          VIRTIO_MEM_SYSTEM_RESET,
+                                          OBJECT,
+                                          { TYPE_RESETTABLE_INTERFACE })
 
 static void virtio_mem_system_reset_init(Object *obj)
 {
diff --git a/include/qom/object.h b/include/qom/object.h
index 328521866463..24727906ec02 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -294,7 +294,7 @@ struct Object
         .class_size = CLASS_SIZE, \
         .class_init = module_obj_name##_class_init, \
         .abstract = ABSTRACT, \
-        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__ } , \
+        .interfaces = (const InterfaceInfo[]) { __VA_ARGS__, { } } , \
     }; \
     \
     static void \
@@ -365,8 +365,8 @@ struct Object
  * for the common case of a non-abstract type, with one or more implemented
  * interfaces.
  *
- * Note when passing the list of interfaces, be sure to include the final
- * NULL entry, e.g.  { TYPE_USER_CREATABLE }, { NULL }
+ * The NULL terminator is added automatically by the macro, so only
+ * the actual interfaces need to be listed, e.g.  { TYPE_USER_CREATABLE }
  */
 #define OBJECT_DEFINE_TYPE_WITH_INTERFACES(ModuleObjName, module_obj_name, \
                                            MODULE_OBJ_NAME, \
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 59ec7a28eb05..4ef70b5a4082 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -18,8 +18,7 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RamBlockAttributes,
                                           ram_block_attributes,
                                           RAM_BLOCK_ATTRIBUTES,
                                           OBJECT,
-                                          { TYPE_RAM_DISCARD_SOURCE },
-                                          { })
+                                          { TYPE_RAM_DISCARD_SOURCE })
 
 static size_t
 ram_block_attributes_get_block_size(void)
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 8294dbde3aa8..f1fa9e7ffe2b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -1559,8 +1559,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    TDX_GUEST,
                                    X86_CONFIDENTIAL_GUEST,
                                    { TYPE_USER_CREATABLE },
-                                   { TYPE_RESETTABLE_INTERFACE },
-                                   { NULL })
+                                   { TYPE_RESETTABLE_INTERFACE })
 
 static void tdx_guest_init(Object *obj)
 {
diff --git a/target/s390x/kvm/pv.c b/target/s390x/kvm/pv.c
index 3d508165f348..8d4a7b5275e1 100644
--- a/target/s390x/kvm/pv.c
+++ b/target/s390x/kvm/pv.c
@@ -402,8 +402,7 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(S390PVGuest,
                                    s390_pv_guest,
                                    S390_PV_GUEST,
                                    CONFIDENTIAL_GUEST_SUPPORT,
-                                   { TYPE_USER_CREATABLE },
-                                   { NULL })
+                                   { TYPE_USER_CREATABLE })
 
 static void s390_pv_guest_class_init(ObjectClass *oc, const void *data)
 {

-- 
2.56.0.rc0.29.g47ce80527c56

