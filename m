Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670147798A
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169626; cv=none; b=POhzzq3UwTcLigXw5YD0tXyH8aopT1bYknPSm+qePFL+bcmZ5/z/sK5+nbLL/b4weM0lKdU30rxGP0qVRTZVvrS8u6/iFMNki8NdJsCsL8YRr2tnXnChc3jxBbgsJSnZgs5rlLovk5UKTSHL13URx559h+dWvFJKCtthLQXaQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169626; c=relaxed/simple;
	bh=GrYsfDcKE0H0p3m5ZLWrRin+m5OJc9l0m5Z/SxjnjIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AY6/h1IicimxYC959YN7aZbodGDzBi2jcaoNu13O6TVnpglARKUyQnom0k+iHDXugl/eJ0MnWImX/JD3IpUyCxZJxCNun4Nh2d+hGpRBsSJIWqdZLkfRH/es8gX1xX6Isgr2n5Ntwa29xzsxt+NiZ//ceR2uzK9Pfm1L7CqrfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aggXg7AC; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aggXg7AC"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1438f55921fso338808c88.1
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169609; x=1790774409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0NEODEUKGZurnafAxCJE2mvY+onJpkfc8axTrsuyg4=;
        b=aggXg7ACXEnF2YOJjSD3iTa0w2zPgj8i/m1pS9YOECysxtTaI5MluapQXGarPxqlYB
         qWEa+o1ypOOytcGiAmoy9TlXyRN1pkFfolK51VQpPTaACnBxHfs2pWKvd/8Z8tflPaCs
         6o62nVhjfV6oKmWOekaTnZsbcE4wON1mI19FM1KPQ5/S5YVfhga+YCZo3c82hFBh2FwY
         iyU00HivlDNSCl4q04fwPuQlq9mPROSEMJAVhpNuMvnLhEA+Dr7HPYvKCVUj4ZQeyTdN
         QhtFUamPpmANF/94/1jtl9Pd6nMhAT0r//2u79PzXNJ21pgZcONnu3UwhEFn/ArcTWjC
         IxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169609; x=1790774409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0NEODEUKGZurnafAxCJE2mvY+onJpkfc8axTrsuyg4=;
        b=j34TocSOqVYDx478pDeVCIEdiTLlSdrt3lLZ3xEvjSHXcCrdOUgRPI8mg1QUYgsjSa
         jMh4bVOyNkpY5uNmCd3q/S7o2UiVhoPk15U23LviygZ8eKNdtTZslWJZnxhZ1exEbbD5
         kIm/XDaNeZrIt08NchZGtbHCbwwHPDNgT8WH1Z135M2G3KG06a/PFO1SzzwkvY3ryIhl
         CcR70frQepM3s+ECzKrNrFWpWqUNQwcWKUq3HA56VkY0O2ydZdTRpWLZ738Gxv038r+7
         dw8XgxYdZAxlECF6dL/C2WXb0YaCsmK6JBJFjYFBkG1eRwO2kjjLP/gap0FtYA9ipqyY
         OcxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzwWEAXBUt6gaNCxgXl6u+9nGXPtNWp+2RoA/pQrQqnUVMH3TQleBqpIk/p6ViJ6QPcmME=@vger.kernel.org
X-Gm-Message-State: AFuF++mb7YppCoBOmRvMxUyl2pSwERLa3hSUj5lEiwyhJC7mED68axVG
	zwMOwvO1tO3CDImakyfkfwNsk+RGb79Xs2YvawUb3TjB4ZkK02iNpK72
X-Gm-Gg: AYBFou3pMgdNEim7xhL7EKhuxfNnAXYayjXw6ei/81EW/1i8GcR6EpIhYieCljZa2rD
	6+HsgnRCoUnDFUGGz8tj7zrVWb+e4Ew6+GJXFojrzQUmhhEweEGxWqDLFK7WApPAyEOeeeym12M
	XrgoqyayR7GmsoEwrjP8KapoIdr4WRWfv0rsLFYXZelPWJLB94y+h8Y5IpZsigqXUZTX+tW4vyU
	vh2mqEmpOjOdVTcJHwmHHeXC+jLowJNjU3tgpbTxY6hxUBIgREnN2GntEjSHipOIg6MJVRcCmot
	kt/jKgm6yCW0ZFHhNb5Ni2GfhToRyzcA2GaMu7UZfEw9oQHS74uqUjt/31YHi+jfKCyJOOjupGZ
	gG56RiYGwALQUyCtR9kkt8dbKKeV8qKKkVy0YAxGrnV7cmBDn0eZoPpWZSwPAI7Ezuevvan949Q
	Wb2QUpK1m5Gs6Omf5rWz1kRZMwa699aYrjd5pme8A2b4BYnUtKIXpgCPUS5qpEM/eAxbdubxGGq
	q02NwvqU8t6Pn/B+3iIWDFUa/XkKhY=
X-Received: by 2002:a05:693c:60cd:b0:33b:e306:2e27 with SMTP id 5a478bee46e88-33ea3eb055bmr2839410eec.5.1790169609054;
        Wed, 23 Sep 2026 06:20:09 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:20:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>,
	xen-devel@lists.xenproject.org,
	Chao Liu <chao.liu@processmission.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Peter Xu <peterx@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Fabiano Rosas <farosas@suse.de>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	qemu-ppc@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Bibo Mao <maobibo@loongson.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	David Hildenbrand <david@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	qemu-riscv@nongnu.org,
	kvm@vger.kernel.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Song Gao <17746591750@163.com>,
	qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 019/114] qom: inherit is_available and filter after MODULE_INIT_QOM
Date: Wed, 23 Sep 2026 21:14:53 +0800
Message-ID: <20260923131635.1894-20-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parents are not all registered at type_register time, so a type
cannot inherit is_available then.

After MODULE_INIT_QOM, and after a late DSO, inherit the callback
from the parent, drop types that fail target_info(), and report a
missing parent. Skip that filter for MODULE_INIT_PHASE_DSO_BEFORE.
The inherit walk colors each type once, so it is O(N) in the number
of types. TYPE_INTERFACE and TYPE_OBJECT use target_is_any().
type_register_static aborts if it runs outside the QOM before/after
hooks.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/target-info.h |   9 +++
 qom/object.c               | 134 +++++++++++++++++++++++++++++++++++--
 target-info.c              |   6 ++
 3 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 440da63e6cf..790fc74e9d3 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -53,6 +53,15 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_is_any:
+ * @ti: TargetInfo to inspect
+ *
+ * Returns true for every TargetInfo. Usable as TypeInfo.is_available
+ * for types that are not target-scoped (TYPE_OBJECT).
+ */
+bool target_is_any(const TargetInfo *ti);
+
 /**
  * target_is_base_arm:
  * @ti: TargetInfo to inspect
diff --git a/qom/object.c b/qom/object.c
index a3e75927e82..d0f9242ac99 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qom/compat-properties.h"
 #include "qom/object.h"
+#include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/target-info-qapi.h"
 #include "qemu/cutils.h"
@@ -40,6 +41,7 @@
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
+#include "qemu/queue.h"
 
 #define MAX_INTERFACES 32
 
@@ -81,11 +83,16 @@ struct TypeImpl
 
     int num_interfaces;
     InterfaceImpl interfaces[MAX_INTERFACES];
+
+    QTAILQ_ENTRY(TypeImpl) register_node;
 };
 
 static Type type_interface;
 
 static GHashTable *type_table;
+static QTAILQ_HEAD(, TypeImpl) type_register_list =
+    QTAILQ_HEAD_INITIALIZER(type_register_list);
+static bool type_qom_registering;
 
 static bool enumerating_types;
 
@@ -95,6 +102,21 @@ static void type_table_add(TypeImpl *ti)
     g_hash_table_insert(type_table, (void *)ti->name, ti);
 }
 
+static void type_table_remove(TypeImpl *ti)
+{
+    int i;
+
+    assert(!enumerating_types);
+    g_hash_table_remove(type_table, (void *)ti->name);
+    QTAILQ_REMOVE(&type_register_list, ti, register_node);
+    g_free((char *)ti->name);
+    g_free((char *)ti->parent);
+    for (i = 0; i < ti->num_interfaces; i++) {
+        g_free((char *)ti->interfaces[i].typename);
+    }
+    g_free(ti);
+}
+
 static TypeImpl *type_table_lookup(const char *name)
 {
     return g_hash_table_lookup(type_table, name);
@@ -171,18 +193,20 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available(target_info())) {
-        return NULL;
-    }
-
     ti = type_new(info);
 
     type_table_add(ti);
+    QTAILQ_INSERT_TAIL(&type_register_list, ti, register_node);
     return ti;
 }
 
 TypeImpl *type_register_static(const TypeInfo *info)
 {
+    if (!type_qom_registering) {
+        fprintf(stderr, "Registering '%s' outside QOM before/after\n",
+                info->name);
+        abort();
+    }
     assert(info->parent);
     return type_register_internal(info);
 }
@@ -316,6 +340,8 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
 
     iface_impl = type_new(&info);
     iface_impl->parent_type = parent_type;
+    g_assert(interface_type->is_available);
+    iface_impl->is_available = interface_type->is_available;
     type_initialize(iface_impl);
     g_free((char *)info.name);
 
@@ -1159,6 +1185,7 @@ bool object_class_is_secure(ObjectClass *klass)
 
 TypeIsAvailable *object_class_get_is_available(ObjectClass *klass)
 {
+    g_assert(klass->type->is_available);
     return klass->type->is_available;
 }
 
@@ -3297,12 +3324,109 @@ static void object_class_init(ObjectClass *klass, const void *data)
                                   NULL);
 }
 
+static bool type_qom_before(ModuleInitPhase phase, Error **errp)
+{
+    (void)errp;
+    (void)phase;
+
+    type_qom_registering = true;
+    return true;
+}
+
+enum TypeVisitColor {
+    TYPE_VISIT_GRAY = 1,
+    TYPE_VISIT_BLACK,
+};
+
+static bool type_update_is_available(TypeImpl *type, GHashTable *visit,
+                                     Error **errp)
+{
+    TypeImpl *parent;
+    gpointer color;
+
+    color = g_hash_table_lookup(visit, type);
+    if (color == GINT_TO_POINTER(TYPE_VISIT_BLACK)) {
+        return true;
+    }
+    if (color == GINT_TO_POINTER(TYPE_VISIT_GRAY)) {
+        error_setg(errp, "Type '%s' has a cyclic parent chain",
+                   type->name);
+        return false;
+    }
+
+    g_hash_table_insert(visit, type, GINT_TO_POINTER(TYPE_VISIT_GRAY));
+
+    parent = type_get_parent(type);
+    if (!parent) {
+        if (strcmp(type->name, TYPE_OBJECT) != 0 &&
+            strcmp(type->name, TYPE_INTERFACE) != 0) {
+            error_setg(errp,
+                       "Type '%s' does not inherit from %s or %s",
+                       type->name, TYPE_OBJECT, TYPE_INTERFACE);
+            return false;
+        }
+    } else {
+        if (!type_update_is_available(parent, visit, errp)) {
+            return false;
+        }
+        if (!type->is_available) {
+            type->is_available = parent->is_available;
+        }
+    }
+
+    g_hash_table_insert(visit, type, GINT_TO_POINTER(TYPE_VISIT_BLACK));
+    return true;
+}
+
+static bool type_qom_after(ModuleInitPhase phase, Error **errp)
+{
+    TypeImpl *type, *next;
+    GHashTable *visit;
+    Error *local_err = NULL;
+
+    type_qom_registering = false;
+    if (phase == MODULE_INIT_PHASE_DSO_BEFORE) {
+        return true;
+    }
+
+    visit = g_hash_table_new(NULL, NULL);
+    QTAILQ_FOREACH(type, &type_register_list, register_node) {
+        if (!type_update_is_available(type, visit, &local_err)) {
+            break;
+        }
+    }
+    g_hash_table_destroy(visit);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
+    QTAILQ_FOREACH_SAFE(type, &type_register_list, register_node, next) {
+        g_assert(type->is_available);
+        if (!type->is_available(target_info())) {
+            type_table_remove(type);
+        }
+    }
+
+    QTAILQ_FOREACH(type, &type_register_list, register_node) {
+        if (type->parent && !type_table_lookup(type->parent)) {
+            error_setg(errp, "Type '%s' is missing its parent '%s'",
+                       type->name, type->parent);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static void __attribute__((constructor)) register_types(void)
 {
     static const TypeInfo interface_info = {
         .name = TYPE_INTERFACE,
         .class_size = sizeof(InterfaceClass),
         .abstract = true,
+        .is_available = target_is_any,
     };
 
     static const TypeInfo object_info = {
@@ -3310,9 +3434,11 @@ static void __attribute__((constructor)) register_types(void)
         .instance_size = sizeof(Object),
         .class_init = object_class_init,
         .abstract = true,
+        .is_available = target_is_any,
     };
 
     type_table = g_hash_table_new(g_str_hash, g_str_equal);
     type_interface = type_register_internal(&interface_info);
     type_register_internal(&object_info);
+    register_module_hooks(MODULE_INIT_QOM, type_qom_before, type_qom_after);
 }
diff --git a/target-info.c b/target-info.c
index 36f75ece36f..a9ab4b465d3 100644
--- a/target-info.c
+++ b/target-info.c
@@ -96,6 +96,12 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_is_any(const TargetInfo *ti)
+{
+    (void)ti;
+    return true;
+}
+
 bool target_is_base_arm(const TargetInfo *ti)
 {
     switch (ti->target_arch) {
-- 
2.52.0.windows.1

