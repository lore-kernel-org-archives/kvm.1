Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F24F85DA
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169487; cv=none; b=i1OQD/61fRD7VBF3NpRoO/MEXf3KyQ0WO4TR5bQ7YsP2KlL30wPFMgLgjxPKAT33E9TUewCGjt2tUJFLRIjmb4tjv7AJXI/ZRlxqkE7lqplKfUuJNrMEbStCLETsOGkzyNkDsrMdFzh2WA/UyOoo3cmbVfitqg/nzba1kWDAvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169487; c=relaxed/simple;
	bh=7n//5o4NI3VNdVgu5GAo9mwlvscpfslDBXU59TLDFLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRwXXTrQhuKnti2oFUkKlqAkxRdWNEAwygehtSXSZC5TXoaQT86LsTTlzs7/aRK6ywb1SGF23prGqE0PYlgwpYoSaKP7RHsOgUzz41dLXGOUYq/ZoT5W08q5ov47vaylwktvHzE7/nJXqBItf7rgiOzyvRkkKFIvxIJknGMWrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKb5U2yi; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKb5U2yi"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664b7582so517190eec.3
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790169485; x=1790774285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7lw/MEkkV81N3qqf95gz4M3o+mzY0GwXwXNmVRKHabY=;
        b=rKb5U2yiTOVWvJwORZv0FpySJ80GOiCcBv3K19Qo/P/dYAt/4x9XHJSVoQDmEdvynW
         aWajfCyz88daXq5rT+1MMtieeoPAImhNi5Q6Xrw61hXZ6EZki50cEiYPcXIdPlv+omNR
         aNFMo+LvPSrm9xx6MS2C7JU1SEhaAoV6WRL5lNNQBSlQB6b5IXWEb2Px20wN1zUouI34
         4bkj3rsmPr4TqzVQDilNvId5OO6UQhjoJc3mLDB8VAhWOB7Y9FRMlcqAWArt1lsPMvQZ
         egEDGuXHMKIU0QjBqdf3j0vyQpfBKuXKEmUxcBsJhbcwC4np3s25UNqzvOX+b3AaCTld
         djKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790169485; x=1790774285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7lw/MEkkV81N3qqf95gz4M3o+mzY0GwXwXNmVRKHabY=;
        b=MS6GPqPPlJTDDqAMCoE1/2ZxXFDh1a+lEyehpCOt487ls6wFReiySbhgrmBWzuQxPR
         c9Qlf1ml6L0SomAP8N2pnt8RNaDmD6BnaWM5bqJXFaaBtzC8jtPA3Dy/KKWEWiukre9i
         HD0ZgQQ9B0SNTjUsGiOpPWW4/xoX1Qx/3IyMGfbrqPAWR/Rs/MK25fNpXXF7AAeeOZZ7
         zDKkqpG6KqP4Sibc+xIjfsY0s+Qa2R5Zh60e6k3YF3ku65Lwh0Sm9TTVGbK66rZue5Y7
         8FwokginRIt5UrtBCLlBekZQZDZrwQDsah312ZlvT2IcZxu9mXB9vcLXiXkpQUnyP/7n
         YH5g==
X-Forwarded-Encrypted: i=1; AKwUvBwTSGqBYwJ/nencrU3rQ2Vdq7ONHMIEUzIU0b6gkinY8KUkXYCPbOxYcmM6AYtccGdfAoE=@vger.kernel.org
X-Gm-Message-State: AFuF++mKJdMarMKJlmiv89HxYIwSEWHYN+4NszE07BbkorSHETxZZuHF
	oPoH0h+0eDAb6IyJNYzVLbD5ARaemRZszlH75LGBLV/XNLmvGItKohjj
X-Gm-Gg: AYBFou2bOUE3jajmz/rH+dJnO1RDSFhbzhUaHoa5RlG4aZ59ujddnuRZh8nhiOm3Bdt
	Pm7dmzLHO11RaDPbji3NmvFaJ7jxPjwK0a7fUPmY+BJUXGwI3KJjHyOvvvGA2vHNO69oQpOPWEt
	fV/akUG77lbC8cyGYMwAwmRaPIW0VbDQVj152H4Socbsmv1FpT9qAJXvfPawtGFQqqg9YIEjI2k
	S57L7wZlyfxHVLkPT+5r+VQsyfWha9vq+JKE+5StxO0LxDt8BS4PpSjpCKc979ilsU09dJDENiz
	hA4P7yb1rA2p0B1gK9xmH285yWnikwZi8hvQnRGl6pLoxiOEGXW+aHdykmUp/IXC9nHOhtbbG9W
	PjVoB7D4a/cbWyDN7pVh1u5Kx2xKkOu4PcrzohDVx/hLixjG4udUd47E3TfJziKtmI56JaKYPJ/
	qaASwe60Ohwjl7SkZ9KlPZ5v+ZzTJGjtRMQsXVULWtgIGw3rxFKmW+fWHxdmGe7/RftsoPcj45n
	LIKwQM3TyAIveJr03qoBnzksr5yC2P0
X-Received: by 2002:a05:693c:83c3:10b0:33b:e842:c0ff with SMTP id 5a478bee46e88-33e88b2f9cemr2522418eec.0.1790169484806;
        Wed, 23 Sep 2026 06:18:04 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e97236754sm5553695eec.29.2026.09.23.06.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 06:18:03 -0700 (PDT)
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
Subject: [PATCH v3 008/114] target-info: replace QOM registration with a constructor list
Date: Wed, 23 Sep 2026 21:14:42 +0800
Message-ID: <20260923131635.1894-9-luoyonggang@gmail.com>
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

Replace MODULE_INIT_TARGET_INFO and target_info_qom_set_target with a
constructor list. target_info_init builds a TargetInfoNode;
target_info_list_add inserts it, sorted by target_arch, before main().
target_info() starts as an "unknown" TargetInfo and target_info_select
sets the current entry. target-info.c moves into libqom.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/module.h           |  1 -
 include/qemu/target-info-def.h  | 56 ++++++++++++++++++++++++++++++---
 include/qemu/target-info-init.h | 53 -------------------------------
 include/qemu/target-info-qom.h  | 30 ------------------
 include/qemu/target-info.h      | 11 +++++++
 meson.build                     |  6 ++--
 system/vl.c                     |  4 ---
 target-info-def.c               |  1 -
 target-info-qom.c               | 55 --------------------------------
 target-info.c                   | 56 ++++++++++++++++++++++++++++++++-
 tests/qtest/fuzz/fuzz.c         |  3 --
 11 files changed, 120 insertions(+), 156 deletions(-)
 delete mode 100644 include/qemu/target-info-init.h
 delete mode 100644 include/qemu/target-info-qom.h
 delete mode 100644 target-info-qom.c

diff --git a/include/qemu/module.h b/include/qemu/module.h
index fccf017bf9e..9885ac9afb3 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -43,7 +43,6 @@ typedef enum {
     MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
-    MODULE_INIT_TARGET_INFO,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index ebd88463aea..25dc7c508d3 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -11,8 +11,10 @@
 
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-types-machine.h"
+#include "qemu/queue.h"
+#include "qemu/target-info.h"
 
-typedef struct TargetInfo {
+struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
     /* related to TARGET_ARCH definition */
@@ -30,13 +32,57 @@ typedef struct TargetInfo {
     unsigned page_bits_init;
     /* runtime equivalent of TARGET_PAGE_BITS_VARY definition */
     bool page_bits_vary;
-} TargetInfo;
+};
+
+typedef struct TargetInfoNode TargetInfoNode;
+typedef QLIST_HEAD(, TargetInfoNode) TargetInfoList;
+
+struct TargetInfoNode {
+    const TargetInfo *info;
+    QLIST_ENTRY(TargetInfoNode) next;
+};
+
+/**
+ * target_info_list:
+ *
+ * TargetInfo is a static list, not a QOM type. Constructors insert
+ * entries before main(), so type_init can use it.
+ *
+ * Returns: registered TargetInfoNode list head, sorted by
+ *          info->target_arch. The list is owned by target-info
+ *          and must not be modified. Iterate with
+ *          QLIST_FOREACH(..., next) and use node->info.
+ */
+const TargetInfoList *target_info_list(void);
 
 /**
- * target_info:
+ * target_info_select:
+ * @ti: TargetInfo to make current
  *
- * Returns: The TargetInfo structure definition for this target binary.
+ * Sets target_info() to @ti.
+ */
+void target_info_select(const TargetInfo *ti);
+
+/**
+ * target_info_list_add:
+ * @node: static TargetInfoNode whose info points at a const TargetInfo
+ *
+ * Inserts @node into target_info_list(), sorted by info->target_arch.
+ * Sets target_info() to the first list entry.
+ */
+void target_info_list_add(TargetInfoNode *node);
+
+/*
+ * Register @ti before main(). Linked into the executable, not a DSO.
+ * @ti is a unique identifier in this translation unit.
  */
-const TargetInfo *target_info(void);
+#define target_info_init(ti)                                            \
+    static TargetInfoNode ti##_node = {                                 \
+        .info = &(ti),                                                  \
+    };                                                                  \
+    static void __attribute__((constructor)) do_qemu_init_##ti(void)    \
+    {                                                                   \
+        target_info_list_add(&ti##_node);                               \
+    }
 
 #endif
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
deleted file mode 100644
index b7024c9faef..00000000000
--- a/include/qemu/target-info-init.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * QEMU target info initialization
- *
- * Copyright (c) Qualcomm
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- *
- * This file is included by each file defining a TargetInfo structure and is
- * responsible for registering it.
- */
-
-#ifndef QEMU_TARGET_INFO_INIT_H
-#define QEMU_TARGET_INFO_INIT_H
-
-#define DEFINE_TARGET_INFO_TYPE(info)                                       \
-static void do_qemu_init_target_info(void)                                  \
-{                                                                           \
-    type_register_static(&info);                                            \
-}                                                                           \
-module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
-
-#ifdef COMPILING_PER_TARGET
-#ifdef CONFIG_USER_ONLY
-
-/*
- * User mode does not support multiple targets in the same binary, so just
- * define target_info().
- */
-#define target_info_init(ti_var)        \
-const TargetInfo *target_info(void)     \
-{                                       \
-    return &ti_var;                     \
-}
-
-#else /* CONFIG_USER_ONLY */
-
-#include "qemu/target-info-qom.h"
-#include "qom/object.h"
-
-#define target_info_init(ti_var)                                            \
-static const TypeInfo target_info_qom_target_type_info = {                  \
-    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
-    .parent = TYPE_TARGET_INFO,                                             \
-    .instance_size = sizeof(TargetInfoQom),                                 \
-    .class_size = sizeof(TargetInfoQomClass),                               \
-    .class_data = &ti_var,                                                  \
-};                                                                          \
-DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
-
-#endif /* CONFIG_USER_ONLY */
-#endif /* COMPILING_PER_TARGET */
-
-#endif /* QEMU_TARGET_INFO_INIT_H */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
deleted file mode 100644
index 0f6772e65c3..00000000000
--- a/include/qemu/target-info-qom.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * QEMU target info QOM types
- *
- * Copyright (c) Qualcomm
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef QEMU_TARGET_INFO_QOM_H
-#define QEMU_TARGET_INFO_QOM_H
-
-#include "qemu/target-info-def.h"
-#include "qom/object.h"
-
-#define TYPE_TARGET_INFO "target-info"
-
-typedef struct TargetInfoQom {
-    Object parent_obj;
-} TargetInfoQom;
-
-typedef struct TargetInfoQomClass {
-    ObjectClass parent_class;
-    const TargetInfo *target_info;
-} TargetInfoQomClass;
-
-OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
-
-void target_info_qom_set_target(void);
-
-#endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index c09e5d2a3ec..c48973f20be 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,17 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+#include <stdbool.h>
+
+typedef struct TargetInfo TargetInfo;
+
+/**
+ * target_info:
+ *
+ * Returns: The TargetInfo structure definition for the selected target.
+ */
+const TargetInfo *target_info(void);
+
 /**
  * target_name:
  *
diff --git a/meson.build b/meson.build
index 20345860c9f..9a6a80fd0c8 100644
--- a/meson.build
+++ b/meson.build
@@ -3777,6 +3777,9 @@ if enable_modules
   modulecommon = declare_dependency(objects: libmodulecommon.extract_all_objects(recursive: false), compile_args: '-DBUILD_DSO')
 endif
 
+qom_ss.add(files(
+  'target-info.c',
+))
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
@@ -3871,9 +3874,6 @@ endif
 common_ss.add(pagevary)
 system_ss.add(files('page-vary-system.c'))
 
-common_ss.add(files('target-info.c'))
-system_ss.add(files('target-info-qom.c'))
-
 if 'CONFIG_TCG' in config_all_accel
   subdir('contrib/plugins')
 endif
diff --git a/system/vl.c b/system/vl.c
index dc883de8274..37cb4838188 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -28,7 +28,6 @@
 #include "qemu/units.h"
 #include "qemu/module.h"
 #include "qemu/target-info.h"
-#include "qemu/target-info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/core/qdev-properties.h"
@@ -2930,9 +2929,6 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-def.c b/target-info-def.c
index f167f5f2ac1..954298b56d0 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
-#include "qemu/target-info-init.h"
 #include "cpu-qom.h"
 #include "cpu-param.h"
 #include "exec/page-vary.h"
diff --git a/target-info-qom.c b/target-info-qom.c
deleted file mode 100644
index 2b38673a3f8..00000000000
--- a/target-info-qom.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * QEMU binary/target API (QOM types)
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qom/object.h"
-#include "qemu/target-info-def.h"
-#include "qemu/target-info-init.h"
-#include "qemu/target-info-qom.h"
-
-static void target_info_qom_class_init(ObjectClass *oc, const void * data)
-{
-    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
-    klass->target_info = data;
-}
-
-static const TypeInfo target_info_parent_type = {
-    .name = TYPE_TARGET_INFO,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(TargetInfoQom),
-    .class_size = sizeof(TargetInfoQomClass),
-    /* use class_base_init so children classes can set class_data accordingly */
-    .class_base_init = target_info_qom_class_init,
-    /* children classes will be concrete, which allows to easily query them
-     * without listing this parent class also */
-    .abstract = true,
-};
-
-DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
-
-static const TargetInfo *target_info_ptr;
-
-const TargetInfo *target_info(void)
-{
-    return target_info_ptr;
-}
-
-void target_info_qom_set_target(void)
-{
-    g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
-
-    size_t num_found = g_slist_length(targets);
-    if (num_found != 1) {
-        error_setg(&error_fatal, num_found == 0 ?
-                                 "no target-info is available" :
-                                 "more than one target-info is available");
-    }
-
-    target_info_ptr = TARGET_INFO_CLASS(targets->data)->target_info;
-}
diff --git a/target-info.c b/target-info.c
index 9abe72b1f55..6e66f48e1ff 100644
--- a/target-info.c
+++ b/target-info.c
@@ -10,7 +10,61 @@
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qemu/target-info-def.h"
-#include "qapi/error.h"
+#include "exec/page-vary.h"
+
+static const TargetInfo target_info_default = {
+    .target_arch = SYS_EMU_TARGET__MAX,
+    .target_name = "unknown",
+    .long_bits = 64,
+    .endianness = ENDIAN_MODE_LITTLE,
+    .page_bits_init = TARGET_PAGE_BITS_MIN,
+};
+
+static const TargetInfo *target_info_ptr = &target_info_default;
+static TargetInfoList target_infos = QLIST_HEAD_INITIALIZER(target_infos);
+
+const TargetInfo *target_info(void)
+{
+    g_assert(target_info_ptr != NULL);
+    return target_info_ptr;
+}
+
+const TargetInfoList *target_info_list(void)
+{
+    return &target_infos;
+}
+
+void target_info_select(const TargetInfo *ti)
+{
+    g_assert(ti != NULL);
+    target_info_ptr = ti;
+}
+
+void target_info_list_add(TargetInfoNode *node)
+{
+    const TargetInfo *info;
+    TargetInfoNode *cur, *prev = NULL;
+
+    g_assert(node && node->info);
+    info = node->info;
+    QLIST_FOREACH(cur, &target_infos, next) {
+        if (info->target_arch < cur->info->target_arch) {
+            QLIST_INSERT_BEFORE(cur, node, next);
+            break;
+        }
+        prev = cur;
+    }
+    if (!cur) {
+        if (prev) {
+            QLIST_INSERT_AFTER(prev, node, next);
+        } else {
+            QLIST_INSERT_HEAD(&target_infos, node, next);
+        }
+    }
+
+    /* Single-target default: the first list entry. */
+    target_info_select(QLIST_FIRST(&target_infos)->info);
+}
 
 const char *target_name(void)
 {
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index a3a131c80f8..d2355989616 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -22,7 +22,6 @@
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/rcu.h"
-#include "qemu/target-info-qom.h"
 #include "tests/qtest/libqtest.h"
 #include "tests/qtest/libqos/qgraph.h"
 #include "fuzz.h"
@@ -173,8 +172,6 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Initialize qgraph and modules */
     qos_graph_init();
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.52.0.windows.1

