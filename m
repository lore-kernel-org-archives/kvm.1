Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FF36215F
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051826; cv=none; b=TlYfi7RhXTrj8pXHJ4YIhwJQHJ4TNDslN/RCgPJxlyfbgwV5ZD19Gb4YQ5TA0u0dxufsYG5q6hPGEZ0Ho28wOle5EkzO41e5WHKSRVcvt1/SSvxK8tr5cMMj3iW3nMNpRXXpu+RE0UvLmbSLsAYeD+AycY/cDVxBfYl9RnXJ1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051826; c=relaxed/simple;
	bh=h2pcHj9oFV8Njk3sExkn4qFLcuQDW0GdsVpOdDGzDpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zlgmg0PhxhxGmNRKGuVvjZTIyiqqvwKKccZYW92hAPTMdbZHY+UzbYaIv0Yxw6Hv6lX5pzLe69UK69O2KTGCAhh9RBBpnCUEHOkbxXlXmQuk/cRqv7djvdP8nV75oqxpBMWzHMKJHO+FojNklS9ahNcuOcG6EuzcnRb6gWMySp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5sNOGvV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5sNOGvV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cZ9k2zlRVPI/Q6eV5gYzrkbNceMJYmuC0St6Zr3WMc=;
	b=P5sNOGvVjagvTKYOSDa185J+tshuJBkEaNY0PquZe+Hjgho3j/tC5CTwrI8gIrrmDhzyBx
	aV0nWdfMdaGZTJT/RpEjQO4kERDAlcnLPwYgf2e2KUtTNKJwPFKThUDPJxRN5TSnb4rV6F
	uLIPBfGLjFeBok+SANg+jIDMJYRQYFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-DRLVw6ODOo6ihC76v5Hkaw-1; Tue,
 18 Aug 2026 07:16:58 -0400
X-MC-Unique: DRLVw6ODOo6ihC76v5Hkaw-1
X-Mimecast-MFC-AGG-ID: DRLVw6ODOo6ihC76v5Hkaw_1787051817
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8A68180028A;
	Tue, 18 Aug 2026 11:16:56 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EB4C180049F;
	Tue, 18 Aug 2026 11:16:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:41 +0400
Subject: [PATCH v3 14/74] qom: convert enum properties to QAPI-aware
 registration
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-14-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=19408;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h2pcHj9oFV8Njk3sExkn4qFLcuQDW0GdsVpOdDGzDpI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD2353BQDuJlpjVNxRM8XiMll48+R69kWBq3R
 rrsqYwxs9WJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5f5tD/4o3q6pQY+uFzmNiVxdfmfV1WfyhsB+p8Re34rmBzeBA+1nCtN4tFYeEtp/0AD+CKuUgQS
 j/AgDSGfolRdh9IpymAnmvuKxgfBVeRxNNXY1v3km6kzUI8bF0+xVO/xwdb9Q7xR6VTR5xzuFZZ
 wwYNRRgq+jVa1+GNvnB57/stJvHVfYmBJ5vUhUZ64cvPA5uXNWALdkUxz07KYQ5jVu+CFsSscFs
 /wOPilThG375Sb3/gkoH5tgJr96+k6B+sD1XvNclpTSCRboyX7ukeqO3D56+b9KxGi6Z4+HwFyZ
 d3lH4chmIBZ44Y1klSAaabZKwFSWOdnuApowRKO5lqaMEFxGROVwdqyuHmV98YZsP38NtL31HhW
 J4b1rT/1km/iDMIcEp4G0VDL5eI3KEImQ6cU7YV1/ZAIZJRgS6k2FrpjHHuVBxBIw60DWfS4pPg
 tVQMfl+ZETPwyvWJmJhP+LCr4I7TdCCiyCgXS0+DY83lasu8is19jVogGVEgfrJrCu0E3COvnFM
 2wKrR/ut2LKjiBDLozUjXQoDIwOIPSA9RZQnH7RycxquB7zGIJzp0fIlZ+OnwrMAIK6PHmXB898
 5lhdfIe+GceQnuQrqchPnJ1yyyhE3mP7Mxlw77gDAIzoFANLTlNWGzgT7iwnyTiiEf//0sM507U
 OIfN4Y0gzPdOQXA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Convert all callers of object_class_property_add_enum() to use the new
object_class_property_add_qapi_enum() with the QAPI_ENUM_PROP()
macro, which provides type information via QAPITypeInfo instead of
raw lookup tables and string type names.

This enables QMP introspection to report accurate QAPI type names
for enum properties. Where a separate set_description call was used,
the description is now embedded in the QAPI_ENUM_PROP initializer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 authz/list.c                             | 12 +++++++-----
 backends/hostmem.c                       | 14 ++++++++------
 crypto/secret_common.c                   | 12 +++++++-----
 crypto/tlscreds.c                        | 12 +++++++-----
 hw/i386/pc_piix.c                        | 18 ++++++++++++------
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 19 +++++++++++--------
 include/chardev/char.h                   |  8 --------
 monitor/qmp.c                            | 12 +++++++-----
 net/filter.c                             | 10 +++++++---
 target/i386/kvm/kvm.c                    | 30 +++++++++++++++++-------------
 ui/console-vc.c                          |  8 +++++++-
 ui/dbus.c                                | 18 ++++++++++++++----
 ui/input-linux.c                         | 11 +++++++----
 13 files changed, 111 insertions(+), 73 deletions(-)

diff --git a/authz/list.c b/authz/list.c
index 17aa0efd80e8..363b2ee12c98 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -22,6 +22,7 @@
 #include "authz/list.h"
 #include "trace.h"
 #include "qom/object_interfaces.h"
+#include "qapi/qapi-type-infos-authz.h"
 #include "qapi/qapi-visit-authz.h"
 #include "qemu/module.h"
 
@@ -120,11 +121,12 @@ qauthz_list_class_init(ObjectClass *oc, const void *data)
 {
     QAuthZClass *authz = QAUTHZ_CLASS(oc);
 
-    object_class_property_add_enum(oc, "policy",
-                                   "QAuthZListPolicy",
-                                   &QAuthZListPolicy_lookup,
-                                   qauthz_list_prop_get_policy,
-                                   qauthz_list_prop_set_policy);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .qapi_type = &QAuthZListPolicy_type_info,
+        .get = qauthz_list_prop_get_policy,
+        .set = qauthz_list_prop_set_policy,
+    ));
 
     object_class_property_add(oc, "rules", "QAuthZListRule",
                               qauthz_list_prop_get_rules,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 5dd5fb155c47..ce82958050e2 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -16,6 +16,7 @@
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
 #include "qom/compat-properties.h"
@@ -551,12 +552,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
-    object_class_property_add_enum(oc, "policy", "HostMemPolicy",
-        &HostMemPolicy_lookup,
-        host_memory_backend_get_policy,
-        host_memory_backend_set_policy);
-    object_class_property_set_description(oc, "policy",
-        "Set the NUMA policy");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "policy",
+        .description = "Set the NUMA policy",
+        .qapi_type = &HostMemPolicy_type_info,
+        .get = host_memory_backend_get_policy,
+        .set = host_memory_backend_set_policy,
+    ));
     object_class_property_add_bool(oc, "share",
         host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
diff --git a/crypto/secret_common.c b/crypto/secret_common.c
index a5ecb876aeba..381d23ecc8e0 100644
--- a/crypto/secret_common.c
+++ b/crypto/secret_common.c
@@ -22,6 +22,7 @@
 #include "crypto/secret_common.h"
 #include "crypto/cipher.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
 #include "qemu/module.h"
@@ -269,11 +270,12 @@ qcrypto_secret_class_init(ObjectClass *oc, const void *data)
 
     ucc->complete = qcrypto_secret_complete;
 
-    object_class_property_add_enum(oc, "format",
-                                   "QCryptoSecretFormat",
-                                   &QCryptoSecretFormat_lookup,
-                                   qcrypto_secret_prop_get_format,
-                                   qcrypto_secret_prop_set_format);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "format",
+        .qapi_type = &QCryptoSecretFormat_type_info,
+        .get = qcrypto_secret_prop_get_format,
+        .set = qcrypto_secret_prop_set_format,
+    ));
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
                                   qcrypto_secret_prop_set_keyid);
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index fb09e295a65c..54859720bf74 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-crypto.h"
 #include "qapi-types-crypto.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
@@ -221,11 +222,12 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_str(oc, "dir",
                                   qcrypto_tls_creds_prop_get_dir,
                                   qcrypto_tls_creds_prop_set_dir);
-    object_class_property_add_enum(oc, "endpoint",
-                                   "QCryptoTLSCredsEndpoint",
-                                   &QCryptoTLSCredsEndpoint_lookup,
-                                   qcrypto_tls_creds_prop_get_endpoint,
-                                   qcrypto_tls_creds_prop_set_endpoint);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endpoint",
+        .qapi_type = &QCryptoTLSCredsEndpoint_type_info,
+        .get = qcrypto_tls_creds_prop_get_endpoint,
+        .set = qcrypto_tls_creds_prop_set_endpoint,
+    ));
     object_class_property_add_str(oc, "priority",
                                   qcrypto_tls_creds_prop_get_priority,
                                   qcrypto_tls_creds_prop_set_priority);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4decd6..dac2bee88a2e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -336,6 +336,11 @@ static const QEnumLookup PCSouthBridgeOption_lookup = {
     .size = PC_SOUTH_BRIDGE_OPTION_MAX
 };
 
+static const QAPITypeInfo PCSouthBridgeOption_type_info = {
+    .name = "PCSouthBridgeOption",
+    .lookup = &PCSouthBridgeOption_lookup,
+};
+
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
@@ -418,12 +423,13 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_UEFI_VARS_X64);
 
-    object_class_property_add_enum(oc, "x-south-bridge", "PCSouthBridgeOption",
-                                   &PCSouthBridgeOption_lookup,
-                                   pc_get_south_bridge,
-                                   pc_set_south_bridge);
-    object_class_property_set_description(oc, "x-south-bridge",
-                                     "Use a different south bridge than PIIX3");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "x-south-bridge",
+        .description = "Use a different south bridge than PIIX3",
+        .qapi_type = &PCSouthBridgeOption_type_info,
+        .get = pc_get_south_bridge,
+        .set = pc_set_south_bridge,
+    ));
     compat_props_add(m->compat_props,
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index c5f64319009b..9a8fcc667812 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -27,6 +27,7 @@
 #include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "target/microblaze/cpu.h"
 #include "hw/core/sysbus.h"
 #include "net/net.h"
@@ -174,14 +175,16 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
 
-    prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
-                                          &EndianMode_lookup,
-                                          machine_get_endianness,
-                                          machine_set_endianness);
-    object_property_set_default_str(prop, target_big_endian() ? "big"
-                                                              : "little");
-    object_class_property_set_description(oc, "endianness",
-            "Defines whether the machine runs in big or little endian mode");
+    prop = object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "endianness",
+        .description =
+            "Defines whether the machine runs in big or little endian mode",
+        .qapi_type = &EndianMode_type_info,
+        .get = machine_get_endianness,
+        .set = machine_set_endianness,
+    ));
+    object_property_set_default_enum(prop,
+        target_big_endian() ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE);
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 7377d8e60a08..f5e53b3867a3 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -343,12 +343,4 @@ static void set_encoding(Object *obj, int value, Error **errp)  \
     cast_func(obj)->encoding = value;                           \
 }
 
-static inline void chardev_vc_add_encoding_prop(ObjectClass *oc,
-    int (*get)(Object *, Error **),
-    void (*set)(Object *, int, Error **))
-{
-    object_class_property_add_enum(oc, "encoding", "ChardevVCEncoding",
-                                   &ChardevVCEncoding_lookup, get, set);
-}
-
 #endif
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750c..728a58bfd5e9 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -30,6 +30,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-type-infos-qom.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
@@ -133,11 +134,12 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
     object_class_property_add_bool(cls, "pretty",
                                    monitor_qmp_get_pretty,
                                    monitor_qmp_set_pretty);
-    object_class_property_add_enum(cls, "close-action",
-                                   "MonitorQMPCloseAction",
-                                   &MonitorQMPCloseAction_lookup,
-                                   monitor_qmp_get_close_action,
-                                   monitor_qmp_set_close_action);
+    object_class_property_add_qapi_enum(cls, QAPI_ENUM_PROP(
+        .name = "close-action",
+        .qapi_type = &MonitorQMPCloseAction_type_info,
+        .get = monitor_qmp_get_close_action,
+        .set = monitor_qmp_set_close_action,
+    ));
 
     moncls->emit_event = monitor_qmp_emit_event;
     moncls->requires_iothread = monitor_qmp_requires_iothread;
diff --git a/net/filter.c b/net/filter.c
index 389f3b0bfefb..79883af22a54 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 
@@ -342,9 +343,12 @@ static void netfilter_class_init(ObjectClass *oc, const void *data)
 
     object_class_property_add_str(oc, "netdev",
                                   netfilter_get_netdev_id, netfilter_set_netdev_id);
-    object_class_property_add_enum(oc, "queue", "NetFilterDirection",
-                                   &NetFilterDirection_lookup,
-                                   netfilter_get_direction, netfilter_set_direction);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "queue",
+        .qapi_type = &NetFilterDirection_type_info,
+        .get = netfilter_get_direction,
+        .set = netfilter_set_direction,
+    ));
     object_class_property_add_str(oc, "status",
                                   netfilter_get_status, netfilter_set_status);
     object_class_property_add_str(oc, "position",
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..601b78df5363 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/qapi-events-run-state.h"
+#include "qapi/qapi-type-infos-common.h"
+#include "qapi/qapi-type-infos-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include <math.h>
@@ -7089,12 +7091,13 @@ static void kvm_arch_set_honor_guest_pat(Object *obj, int value, Error **errp)
 
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
-    object_class_property_add_enum(oc, "notify-vmexit", "NotifyVMexitOption",
-                                   &NotifyVmexitOption_lookup,
-                                   kvm_arch_get_notify_vmexit,
-                                   kvm_arch_set_notify_vmexit);
-    object_class_property_set_description(oc, "notify-vmexit",
-                                          "Enable notify VM exit");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "notify-vmexit",
+        .description = "Enable notify VM exit",
+        .qapi_type = &NotifyVmexitOption_type_info,
+        .get = kvm_arch_get_notify_vmexit,
+        .set = kvm_arch_set_notify_vmexit,
+    ));
 
     object_class_property_add(oc, "notify-window", "uint32",
                               kvm_arch_get_notify_window,
@@ -7127,13 +7130,14 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_set_description(oc, "xen-evtchn-max-pirq",
                                           "Maximum number of Xen PIRQs");
 
-    object_class_property_add_enum(oc, "honor-guest-pat", "OnOffAuto",
-                                   &OnOffAuto_lookup,
-                                   kvm_arch_get_honor_guest_pat,
-                                   kvm_arch_set_honor_guest_pat);
-    object_class_property_set_description(oc, "honor-guest-pat",
-                                          "Disable KVM quirk that ignores guest PAT "
-                                          "memory type settings (default: auto)");
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "honor-guest-pat",
+        .description = "Disable KVM quirk that ignores guest PAT "
+                       "memory type settings (default: auto)",
+        .qapi_type = &OnOffAuto_type_info,
+        .get = kvm_arch_get_honor_guest_pat,
+        .set = kvm_arch_set_honor_guest_pat,
+    ));
 }
 
 void kvm_set_max_apic_id(uint32_t max_apic_id)
diff --git a/ui/console-vc.c b/ui/console-vc.c
index 53d9e9d39b36..1e46eceeded2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -6,6 +6,7 @@
 
 #include "chardev/char.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
 #include "qemu/option.h"
 #include "qemu/queue.h"
 #include "qom/compat-properties.h"
@@ -318,7 +319,12 @@ static void char_vc_class_init(ObjectClass *oc, const void *data)
     cc->supports_size_opts = true;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void char_vc_init(Object *obj)
diff --git a/ui/dbus.c b/ui/dbus.c
index 7be0f8e26119..afc321514c68 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -38,6 +38,8 @@
 #include "qemu/audio.h"
 #include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-char.h"
+#include "qapi/qapi-type-infos-ui.h"
 #include "trace.h"
 
 #include "dbus.h"
@@ -508,9 +510,12 @@ dbus_display_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "p2p", get_dbus_p2p, set_dbus_p2p);
     object_class_property_add_str(oc, "addr", get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "audiodev", get_audiodev, set_audiodev);
-    object_class_property_add_enum(oc, "gl-mode",
-                                   "DisplayGLMode", &DisplayGLMode_lookup,
-                                   get_gl_mode, set_gl_mode);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "gl-mode",
+        .qapi_type = &DisplayGLMode_type_info,
+        .get = get_gl_mode,
+        .set = set_gl_mode,
+    ));
 }
 
 #define TYPE_CHARDEV_VC "chardev-vc"
@@ -602,7 +607,12 @@ dbus_vc_class_init(ObjectClass *oc, const void *data)
     cc->chr_open = dbus_vc_open;
     cc->supports_encoding_opts = true;
 
-    chardev_vc_add_encoding_prop(oc, get_encoding, set_encoding);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "encoding",
+        .qapi_type = &ChardevVCEncoding_type_info,
+        .get = get_encoding,
+        .set = set_encoding,
+    ));
 }
 
 static void
diff --git a/ui/input-linux.c b/ui/input-linux.c
index f4eee1ffd7ec..715d1f589297 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -6,6 +6,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-type-infos-common.h"
 #include "qemu/config-file.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -506,10 +507,12 @@ static void input_linux_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "repeat",
                                    input_linux_get_repeat,
                                    input_linux_set_repeat);
-    object_class_property_add_enum(oc, "grab-toggle", "GrabToggleKeys",
-                                   &GrabToggleKeys_lookup,
-                                   input_linux_get_grab_toggle,
-                                   input_linux_set_grab_toggle);
+    object_class_property_add_qapi_enum(oc, QAPI_ENUM_PROP(
+        .name = "grab-toggle",
+        .qapi_type = &GrabToggleKeys_type_info,
+        .get = input_linux_get_grab_toggle,
+        .set = input_linux_set_grab_toggle,
+    ));
 }
 
 static const TypeInfo input_linux_info = {

-- 
2.55.0.543.g5ebe2ebe4ea8

