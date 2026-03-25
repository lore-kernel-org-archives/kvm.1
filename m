Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A835AC01
	for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451892; cv=none; b=u9f+AaS/OD+mi8ARWzRD/d0P4beprODBnW1w9QMq6YbMVSKBo19jkKTfDPN1ZAvFS99WOaIWGzrvMvkobP2aJp07Mz37a9FjpjN3chKngG8OHQIGEk9Gs9pQ5UBWWUneaoVJvFmbYF7EqQRl4eBMHnlLRZai7clp9prWTYnzXY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451892; c=relaxed/simple;
	bh=VLYDeJlanSrUt5ozd5q4p7m0Cgj8D10/ig6NbNGIZ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8fbab89MMMauWzggHNhPcpVDST3QTbFXSdc7k5jC9fW+6g6Vme88/SCTSPmUUg3H0VexELawKKPsfFvu8L5+zBodUJ1ST/+bCGuu5CEDMhcUdHNHDtvEFFFUTgWTCYmeUKMO70Gm3xetuSkaouINf5bedPhnsgV57/EI1xR3Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcmyysMO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcmyysMO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-482f454be5bso10063605e9.0
        for <kvm@vger.kernel.org>; Wed, 25 Mar 2026 08:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774451889; x=1775056689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jek66EmZwh90Q0GbeJB2FKCf8mZ1pqgxf9FHcRMVDAM=;
        b=fcmyysMOQyQK6Y2jU06qioG2NeNPGr+7S5BK2EZ4Gp7n2RF4RB/aiEzOAKlHbEuUnw
         EU+Pm+BESzb0R0Tm4A1Vs7T+hZVaPc+IbnXR3sorsbXviuedzAiVBLlkzH5SRb24/BCb
         l1lLG899qQgdTLpskkutsGRJaccxUDNroCtoVvN09Wpa1bclg+jOPXvNU3zffho8Th2A
         NVg9Z7m8gNvU/8EThnxMy3yZSmTup8HBQnoHn12P7sj0c3lcqa2yzjXanZHqA6/ijpsJ
         ebKbd3G4JRHuw7+iArIwpGtY6UIbhPkLDhGTBmnb8SnyYLNEZ7zT5x2S7Aw3vad++dYO
         xVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451889; x=1775056689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jek66EmZwh90Q0GbeJB2FKCf8mZ1pqgxf9FHcRMVDAM=;
        b=nFBiNKkEV2fKfaucAeYyf16YnyQavrweUlnj+SLiPDXKegsG/1ZT+/T0m6/CoDAUS+
         qx3JuXZGcaUg7PWhmwj8NoN/aABaABFJPNejvDTLnorYrdUpavx3j/yde+XXYaPMXHlu
         fpJohgfOqwNrTC/82nD0pwX2BtTU+aFRGl60ZFSc3Qojukg/u+bOyad7gPd6Pej5n8vg
         Ydlhjnr85oXNN64ntV8mG2sW4TRt+lSf+EH9MI3ZaQXPMEOcCBcbVT5YHlOGIoF+hwlW
         7C0Ui+kWNgkqTj5yHtwaz+fXQa4Un/68JQggUcjwINwmFS8J64KY2gsbXpWoPZ6oR2cu
         G/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDRI6zyYRFMNHxcylX1uNnxwJKhzTZDkHpdC2Voxsr31kGNGRsW8vyPszP8X18xpfP8DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSxHnQIsFQnjR61bK4EpZwcvK1a0JPZpmRvI6gqeFZw4/b4A43
	5E2mPSjWATgrjRHLExkrPeCKO5E15jX2Fq3OIAEUEgfRl6nN6go0KXYPPb8hbTZ9xsI=
X-Gm-Gg: ATEYQzzcLYKsUzukzQ+UmC3wwqmvzkm4fvpLeJc4SD9F8IXo/5l5ic4FRiIABwwytAp
	m7GyRmD8QJskOd8yj+muxFbVJE2VkwzkXNLh676oTMzu1r0r/ewXgHvnzolWvJrrdOkfRCVm74M
	P93rrg/hwcIWOisMNe8PBeE7/R1yv+zhJ3NF5bL77/tH3AyQysZ2aH62dbMBb0UFm4Z/eu4+eSx
	QmNwd7JMda/6FAfdTuuB0jiyK7H9id+E7hWqJs+59X+VVueTJpobRoCxmmbxi5Fayc1nsTw5z8M
	1IAxVi7yZpLe5wt4W1KyD2TYOofZ+AMIbR2MtrdgilNgv9YLYZs458qdXxjJ1t3EmxFsKcxrqhQ
	eMqO+Ppf6H3CyYEPQoTYigR0jKoj/3dCL8WFX93wPjd6n+a7QrA0WluVmP8aHp1sKI1J4XRedus
	JUJC55E3THY1A2XX0FzLGWWFug1LrdM6N7Rv/1JSUM2YYOABwSfL0Q/FxhuIS0xkneeizAdeMB
X-Received: by 2002:a05:600c:6814:b0:485:3c11:de84 with SMTP id 5b1f17b1804b1-487160a2589mr53284815e9.14.1774451888875;
        Wed, 25 Mar 2026 08:18:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871174f2cesm139339185e9.10.2026.03.25.08.18.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Mar 2026 08:18:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 5/6] qom: Restrict compat properties API to system emulation
Date: Wed, 25 Mar 2026 16:17:27 +0100
Message-ID: <20260325151728.45378-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move compat properties API definitions to their own file
unit, compile it only when system emulation is configured.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qom/compat-properties.c | 116 ++++++++++++++++++++++++++++++++++++++++
 qom/object.c            | 100 ----------------------------------
 qom/meson.build         |   3 ++
 3 files changed, 119 insertions(+), 100 deletions(-)
 create mode 100644 qom/compat-properties.c

diff --git a/qom/compat-properties.c b/qom/compat-properties.c
new file mode 100644
index 00000000000..f8d9b0036ae
--- /dev/null
+++ b/qom/compat-properties.c
@@ -0,0 +1,116 @@
+/*
+ * QEMU Object Model
+ *
+ * Copyright IBM, Corp. 2011
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/compat-properties.h"
+#include "qom/qom-qobject.h"
+#include "hw/core/qdev.h"
+
+bool object_apply_global_props(Object *obj, const GPtrArray *props,
+                               Error **errp)
+{
+    int i;
+
+    if (!props) {
+        return true;
+    }
+
+    for (i = 0; i < props->len; i++) {
+        GlobalProperty *p = g_ptr_array_index(props, i);
+        Error *err = NULL;
+
+        if (object_dynamic_cast(obj, p->driver) == NULL) {
+            continue;
+        }
+        if (p->optional && !object_property_find(obj, p->property)) {
+            continue;
+        }
+        p->used = true;
+        if (!object_property_parse(obj, p->property, p->value, &err)) {
+            error_prepend(&err, "can't apply global %s.%s=%s: ",
+                          p->driver, p->property, p->value);
+            /*
+             * If errp != NULL, propagate error and return.
+             * If errp == NULL, report a warning, but keep going
+             * with the remaining globals.
+             */
+            if (errp) {
+                error_propagate(errp, err);
+                return false;
+            } else {
+                warn_report_err(err);
+            }
+        }
+    }
+
+    return true;
+}
+
+/*
+ * Global property defaults
+ * Slot 0: accelerator's global property defaults
+ * Slot 1: machine's global property defaults
+ * Slot 2: global properties from legacy command line option
+ * Each is a GPtrArray of GlobalProperty.
+ * Applied in order, later entries override earlier ones.
+ */
+static GPtrArray *object_compat_props[3];
+
+/*
+ * Retrieve @GPtrArray for global property defined with options
+ * other than "-global".  These are generally used for syntactic
+ * sugar and legacy command line options.
+ */
+void object_register_sugar_prop(const char *driver, const char *prop,
+                                const char *value, bool optional)
+{
+    GlobalProperty *g;
+    if (!object_compat_props[2]) {
+        object_compat_props[2] = g_ptr_array_new();
+    }
+    g = g_new0(GlobalProperty, 1);
+    g->driver = g_strdup(driver);
+    g->property = g_strdup(prop);
+    g->value = g_strdup(value);
+    g->optional = optional;
+    g_ptr_array_add(object_compat_props[2], g);
+}
+
+/*
+ * Set machine's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_machine_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[1]);
+    object_compat_props[1] = compat_props;
+}
+
+/*
+ * Set accelerator's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_accelerator_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[0]);
+    object_compat_props[0] = compat_props;
+}
+
+void object_apply_compat_props(Object *obj)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
+        object_apply_global_props(obj, object_compat_props[i],
+                                  i == 2 ? &error_fatal : &error_abort);
+    }
+}
diff --git a/qom/object.c b/qom/object.c
index 838b1d2b225..f00d659ef0f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -440,106 +440,6 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
     }
 }
 
-bool object_apply_global_props(Object *obj, const GPtrArray *props,
-                               Error **errp)
-{
-    int i;
-
-    if (!props) {
-        return true;
-    }
-
-    for (i = 0; i < props->len; i++) {
-        GlobalProperty *p = g_ptr_array_index(props, i);
-        Error *err = NULL;
-
-        if (object_dynamic_cast(obj, p->driver) == NULL) {
-            continue;
-        }
-        if (p->optional && !object_property_find(obj, p->property)) {
-            continue;
-        }
-        p->used = true;
-        if (!object_property_parse(obj, p->property, p->value, &err)) {
-            error_prepend(&err, "can't apply global %s.%s=%s: ",
-                          p->driver, p->property, p->value);
-            /*
-             * If errp != NULL, propagate error and return.
-             * If errp == NULL, report a warning, but keep going
-             * with the remaining globals.
-             */
-            if (errp) {
-                error_propagate(errp, err);
-                return false;
-            } else {
-                warn_report_err(err);
-            }
-        }
-    }
-
-    return true;
-}
-
-/*
- * Global property defaults
- * Slot 0: accelerator's global property defaults
- * Slot 1: machine's global property defaults
- * Slot 2: global properties from legacy command line option
- * Each is a GPtrArray of GlobalProperty.
- * Applied in order, later entries override earlier ones.
- */
-static GPtrArray *object_compat_props[3];
-
-/*
- * Retrieve @GPtrArray for global property defined with options
- * other than "-global".  These are generally used for syntactic
- * sugar and legacy command line options.
- */
-void object_register_sugar_prop(const char *driver, const char *prop,
-                                const char *value, bool optional)
-{
-    GlobalProperty *g;
-    if (!object_compat_props[2]) {
-        object_compat_props[2] = g_ptr_array_new();
-    }
-    g = g_new0(GlobalProperty, 1);
-    g->driver = g_strdup(driver);
-    g->property = g_strdup(prop);
-    g->value = g_strdup(value);
-    g->optional = optional;
-    g_ptr_array_add(object_compat_props[2], g);
-}
-
-/*
- * Set machine's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_machine_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[1]);
-    object_compat_props[1] = compat_props;
-}
-
-/*
- * Set accelerator's global property defaults to @compat_props.
- * May be called at most once.
- */
-void object_set_accelerator_compat_props(GPtrArray *compat_props)
-{
-    assert(!object_compat_props[0]);
-    object_compat_props[0] = compat_props;
-}
-
-void object_apply_compat_props(Object *obj)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(object_compat_props); i++) {
-        object_apply_global_props(obj, object_compat_props[i],
-                                  i == 2 ? &error_fatal : &error_abort);
-    }
-}
-
 static void object_class_property_init_all(Object *obj)
 {
     ObjectPropertyIterator iter;
diff --git a/qom/meson.build b/qom/meson.build
index 81922434309..bd6f4aadd78 100644
--- a/qom/meson.build
+++ b/qom/meson.build
@@ -5,6 +5,9 @@ qom_ss.add(files(
   'object_interfaces.c',
   'qom-qobject.c',
 ))
+if have_system
+  qom_ss.add(files('compat-properties.c'))
+endif
 
 qmp_ss.add(files('qom-qmp-cmds.c'))
 system_ss.add(files('qom-hmp-cmds.c'))
-- 
2.53.0

