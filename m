Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D9436167F
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406092; cv=none; b=J9Q0gt2q/TWDfeDl4Dq6uOO2VaxwL+XDQEHfXdrWQeaXeOunLWUU4MREkFjWRJUPQp49t5IyjQgsWgytrvwd2r/B2hENIybT+CFeLbQUumA4QoU/xGzbjvsfdEPhXgS8m/TfEFcZpvLGQJSPVwLhI3bzfNoKQl6kYtmLmN8zoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406092; c=relaxed/simple;
	bh=n0IlDfLZA3zlOBaP1qjNqjgmDcOOXXcpR72pX3syDlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWuZ55bRQZX9PcbLp1Dk42dcjVy8TIuxjJ2ewe8hnnW6Bqee1rAqJpd5DjpfRF5gVvu/ucySTxC/OR2GVgXZSk+5LjmRR86yu5RhjUC+Dex+ueOQClYp9Q7LdP+sQpmsg+5ulEjfldnT64wZaHoxNmvo/s2bvAl2pXsjV3euUIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQNmkxhZ; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQNmkxhZ"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340fbf9c1c6so928132eec.3
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406089; x=1791010889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PghKH5j3RM9oixqw6PWuPbRDg7jx/H6yyM1sSX/yHKE=;
        b=fQNmkxhZWbE3yao6CWJfhEC8wPX6vQenjJi08ypBB/cTVJCm8T4eMbEOwGNo2IiJp/
         1LwQ/4TG08fRHSn7pfvajOClUaEMsuD6/g8ElI1xT24+MF+54ao9vgGAovZaUo/GE7iy
         LOKo6Er57FAbHaCE/fsA6AOdK6zLsTFLK7zEexLPvrLSgocDm9KBk16KikUnuHZj13rn
         9Q8WfIsnS6qxQw4Dji3kriBQ+R5HETwIL4srLZrFC+CHenPqygIeUZG6uRhRGMtmhjs7
         0VvhjTVlDQnYHbOLL3lblWI+4yyAHHB4EqJQuEAhrw3MLFkO6cdcfG+bd7tLKa/kdxf4
         3EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406089; x=1791010889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PghKH5j3RM9oixqw6PWuPbRDg7jx/H6yyM1sSX/yHKE=;
        b=MVsMtUnj6r+SLdQd6adq1OogNoo2RF2uixLqb05Dz/2PhzJ4vZFUtJabItk5L+0H/u
         uYTt5XVO3yaNFfVLow2EJp6CoBrXM82TjyX/OFSh3kqQ+JH4NQ5CJH+YGHK7+uH9ewg+
         FPkzFqxEm5vqFbJQA3gdQHvdYDwkDIjbMsHJ7dbigtS1NafXc9VM4XqfZFOtAFVv/s9n
         GuSlKG22lLodwd82Xh8c4qF2YKPHZnyVdDztCO0Is+Q5bzdYSdtxRsC+0HAsi46NHOQV
         hGr9P5PhGfpmgrbJzCbKyxZtcWkRCMAeChoyFS6xiZWcZUpb8+QfvE4eELAcgTDj+D6K
         y1DA==
X-Forwarded-Encrypted: i=1; AKwUvBzSJVwT/KqMpveW8+w5aML3Ma/ntAN6cpB9qHuOTOpqj18/+mKxuDFgCz6ykKcZxHYQ+Ok=@vger.kernel.org
X-Gm-Message-State: AFuF++lyEMsSzXgUAANW34Lnkc34qvQaeqwZU6mdScm5ITGQespQB8tN
	JfJe3vhH3s0Mjq0++ovnFE+6ejfSP64RDJ+d9o+e9BpCv6OyfUD0EBk4
X-Gm-Gg: AYBFou2dzTpxpNxpLi8kEFzxA6EiDmIinm02iSDToUosu1uhWKWDpMXQimLrF3m9tih
	PGLTK+e26PdZ/GHAL9m92+yZjxQzb9GGWc/dNty2QtwkJVJHjh/g5Cxdx7HP+Z4NykAwj2ndm1E
	ogDNqo1m92CfaT8bgKjy43krhy3zcD4WqTlZVyox9KhUo1aV5sldTUzBBToR4R1k7PzEbIfSsyD
	8fPwJN7XexAB8uQnUysjZruG4XX+Em9SNKMsAJXkjjJ2P4QZJCTqBjjJdOai0hj01QI0k5QDAHa
	53SSIJ1Qc2EsEmwNo2xddz5BMZFFnvyqSrF7n2Yp6pY0ErSSCnNLX4PZuHkKklq7YOOlai1UzPY
	ZHaMzlwps+5fixP/5HUIzrck/2yFVIDITFQk04RCJbww0HlXK/MNFTFpGupXeeCXEVBGcf/AEOj
	nt4U6LMFH3CgGlqP0UIJmzX2XoGhk5r1X1+7ycmY9GrBheGW3qZrinGPO34VCatmAnqIqbmEs6K
	MmXhriMDGTLRrrDsrieu58IL/nRzyQ=
X-Received: by 2002:a05:7300:561c:b0:33c:343a:1045 with SMTP id 5a478bee46e88-342702bf61dmr1973310eec.10.1790406089106;
        Sat, 26 Sep 2026 00:01:29 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:28 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 06/55] target-info: replace QOM registration with a constructor list
Date: Sat, 26 Sep 2026 15:00:05 +0800
Message-ID: <20260926070057.1234-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260926070057.1234-1-luoyonggang@gmail.com>
References: <20260926070057.1234-1-luoyonggang@gmail.com>
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
index 8019d2c7196..080e30a5b0e 100644
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
index 51bc0905294..c404d222d9f 100644
--- a/meson.build
+++ b/meson.build
@@ -3776,6 +3776,9 @@ if enable_modules
   modulecommon = declare_dependency(objects: libmodulecommon.extract_all_objects(recursive: false), compile_args: '-DBUILD_DSO')
 endif
 
+qom_ss.add(files(
+  'target-info.c',
+))
 qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
@@ -3870,9 +3873,6 @@ endif
 common_ss.add(pagevary)
 system_ss.add(files('page-vary-system.c'))
 
-common_ss.add(files('target-info.c'))
-system_ss.add(files('target-info-qom.c'))
-
 if 'CONFIG_TCG' in config_all_accel
   subdir('contrib/plugins')
 endif
diff --git a/system/vl.c b/system/vl.c
index 3efa4968a20..7f1381d84ff 100644
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
@@ -2932,9 +2931,6 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
-    module_call_init(MODULE_INIT_TARGET_INFO);
-    target_info_qom_set_target();
-
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-def.c b/target-info-def.c
index fa19cabc55f..3041d64ccd2 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-def.h"
-#include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
 #include "exec/cpu-defs.h"
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

