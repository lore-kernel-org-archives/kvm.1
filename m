Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5156F3403E3
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406118; cv=none; b=FNevvC1qUKk8SxNEzH8knSLiHIPubxv7EaCFcoepMZNHACJuyeP0XkTGkQRVbTxmW4c3OsXFMF5ky3dqwDoJmXNNYw8jUhwf8Y7VhW+xZSw0jYcijmDxFGsQlcsPR0ZzkSZ8QuYC4+7L2IzlTFYm6ICZCRECmGcm2wQ3YG93KMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406118; c=relaxed/simple;
	bh=MfLWEE/y2kko4TfyFbb3sa9M7OcJdIJt79crgcm3xSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrz6P4GzEHmVmH7cxGpUTUxZDv4m+R1CcXz4ZN+rZa76F18957FrqGgiSusVBAE8DB3bqbfZ9NLlT6CguFsv5LcYhe6nRp3KSX3RuZzLC0T3rTuqrMJOYuuOTkgQnUy34qT+jmkfJWFqkUQ2Lt1bu6WEJ4Tl2hzYXQBrwE8NzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NL4lu0GV; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL4lu0GV"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-328664dbe2dso802510eec.0
        for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406116; x=1791010916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TItkDrTDA9lyGwsZNCUzVvUjl8bw4SoMg1hmQulH2LY=;
        b=NL4lu0GVv633MnLPYH+3eoGUcjMN/61xM85F03oWalZbYsDQH3pkun9sfwKMLt9e5P
         mC3fF9KghPiOMz9CxC2MXqE6EuDntb69cgHaK/CJOXlLJWTKwqT+E3c3af5yP9Hbf5QV
         1maCj9YU8GHuGNTC7ShWPm6zMALyun/JWUt206FQ0mi/G6Col/m9wK4ZT1y39C/JQY+y
         M5L2JNmQVYam/mOVSvgQ4b25udNXvloMeGVhh9jIA7yM4oWMUibGNHLYE4+8vPnFc+3T
         pQwbuZhAAp6oOEla7Fq9q6ZtEusfuid7mGthWJcOBkJ9rKiLkxe9o4yi4e2GN0LcM3u3
         fwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406116; x=1791010916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TItkDrTDA9lyGwsZNCUzVvUjl8bw4SoMg1hmQulH2LY=;
        b=fKavS7ZurXfX1MASJ+NtTNuPq+2hUBi65EU6dVHLR+j2qG+ZYiYj+K4Kk+nIK31yYu
         MCbJMhHyScDKUqMphi8dg5uJHOYDJGn1i0CcHy2MtDoEZin4IOTIafDM5YnplvcXaKeu
         q1XPsZLSKQvk9GvjCCouuk1rv6MEhByDKgh3hKdschwyEWN0rKBjePARfAE0rvEoNE/d
         0oCq38fBUHNNrplw5/e/VhZlb4HxL244u144FHCwGttIYK8sFs5+JXpe0Kf1bM/fLezG
         dIgXHWuL0yzBQDeUNUxZIvsdvoHBknI75EgyQ6I3nH2ded5esn1SZlYe0op++oE+P/48
         OOGA==
X-Forwarded-Encrypted: i=1; AKwUvBzhUdOtL123BcwnoR7atZPzy65+ypmiO1gwUxNt2YnjGZkecGCu6m+D0jX2z7UWnOMlqI8=@vger.kernel.org
X-Gm-Message-State: AFuF++k9NcAVAXgX03X7GJzbrlZYSXBikd5sMkr7e3nrW43W7mPra37e
	b3K6WW7OQiM47aTyS9qjL/zidyGu1fRy0JQG5KxqPKXmm5oE7SaadTR9
X-Gm-Gg: AYBFou0D+TOr3asv2RdJwLSnmCzjmcSrXGfeZoGxqvJAcmfu9eFv2DsP9gQJyN/dReU
	Y7puEQE946s9ce8ADYbLX3AaChEv16GSfutA30dO56L18bxbPrHOLk1GZUtmTjBPPqu1j/vziEs
	NYvqw/2oGB4TDTuW0hGZo3Wba5LO2vpmi00pd3JOQVZt7dKJ1KhZ7D6+99fVKWdLpYplNExLYZX
	YMeVxv2SIUjcqGHGQghJq2ImXgs61hV9vSrKhilOr1CaxjfTWXI0wgCzz5BkpTJCjHaFG8jwSOs
	29roSVsmAdzOnahlVN0mArm1kwijelrVn1Iw1shw5gqsAv5bPdCh6r/PKD9nGKrr0STjkEv9av0
	wjL9YbW2fZUJ2YCc6duoxf/G2UPmTt9lnRztunGTl9LGqFsKGvGBESQmn38yqynV/ac3ziwHqi6
	JLth3dxVsQkGwSKG7jlURPTvyS8SqF6NOIm31Ps6fGy+QzlcromdQeI067vTtaVDSjDBJ4FyIBY
	sFqCV2+NV28rbjpMb487xT1DL2HoUY=
X-Received: by 2002:a05:7300:7b27:b0:33e:53f6:1a2f with SMTP id 5a478bee46e88-342709b2ad6mr2170020eec.2.1790406116221;
        Sat, 26 Sep 2026 00:01:56 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-34145c166cfsm10615141eec.28.2026.09.26.00.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:01:55 -0700 (PDT)
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
Subject: [PATCH v4 13/55] qom: pass TargetInfo to is_available for latter use
Date: Sat, 26 Sep 2026 15:00:12 +0800
Message-ID: <20260926070057.1234-14-luoyonggang@gmail.com>
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

Change TypeInfo.is_available to TypeIsAvailable taking const TargetInfo *.
Store the callback on TypeImpl. object_class_get_is_available() returns
that callback, or target_is_any() when the class has none.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/arm/aspeed_ast27x0-fc.c  |  2 +-
 hw/arm/aspeed_ast27x0_evb.c |  4 ++--
 hw/arm/raspi.c              |  4 ++--
 hw/arm/raspi4b.c            |  2 +-
 include/qom/object.h        | 26 +++++++++++++++++++++++---
 qom/object.c                | 14 +++++++++++++-
 6 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 73362b60d2a..8a7c6a116ac 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -234,7 +234,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 460c9ff0d2e..02a8cff1d9d 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -75,13 +75,13 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
-        .is_available  = target_aarch64,
+        .is_available  = target_is_aarch64,
     }
 };
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..22b06c6ca22 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -403,12 +403,12 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
-        .is_available   = target_aarch64,
+        .is_available   = target_is_aarch64,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 566d64572db..a1dc477f25e 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -121,7 +121,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
-    .is_available   = target_aarch64,
+    .is_available   = target_is_aarch64,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/include/qom/object.h b/include/qom/object.h
index 4c0645817a5..3791f335fdb 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -16,6 +16,7 @@
 
 #include "qapi/qapi-builtin-types.h"
 #include "qemu/module.h"
+#include "qemu/target-info.h"
 
 struct TypeImpl;
 typedef struct TypeImpl *Type;
@@ -117,6 +118,15 @@ typedef void (ObjectUnparent)(Object *obj);
  */
 typedef void (ObjectFree)(void *obj);
 
+/**
+ * typedef TypeIsAvailable:
+ * @ti: TargetInfo to test.
+ *
+ * Returns whether a type is available for @ti. Typical implementations
+ * are target_is_*().
+ */
+typedef bool (TypeIsAvailable)(const TargetInfo *ti);
+
 #define OBJECT_CLASS_CAST_CACHE 4
 
 /**
@@ -473,8 +483,10 @@ struct Object
  * @class_data: Data to pass to the @class_init,
  *   @class_base_init. This can be useful when building dynamic
  *   classes.
- * @is_available: callback invoked at registration time, to dynamically check if
- *   this type should be available or not.
+ * @is_available: Optional callback. Unset inherits the parent type's
+ *   callback in the MODULE_INIT_QOM after pass (parents are not all
+ *   registered at type_register time). After inherit the callback is
+ *   never NULL. Callers may also invoke it with a chosen TargetInfo.
  * @interfaces: The list of interfaces associated with this type.  This
  *   should point to a static array that's terminated with a zero filled
  *   element.
@@ -498,7 +510,7 @@ struct TypeInfo
     void (*class_base_init)(ObjectClass *klass, const void *data);
     const void *class_data;
 
-    bool (*is_available)(void);
+    TypeIsAvailable *is_available;
     const InterfaceInfo *interfaces;
 };
 
@@ -1087,6 +1099,14 @@ bool object_class_is_abstract(ObjectClass *klass);
  */
 bool object_class_is_secure(ObjectClass *klass);
 
+/**
+ * object_class_get_is_available:
+ * @klass: The class to obtain TypeInfo.is_available for.
+ *
+ * Returns: The class is_available callback, never %NULL.
+ */
+TypeIsAvailable *object_class_get_is_available(ObjectClass *klass);
+
 /**
  * object_class_by_name:
  * @typename: The QOM typename to obtain the class for.
diff --git a/qom/object.c b/qom/object.c
index 96498f3d001..76b0b0806b3 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -15,6 +15,7 @@
 #include "qom/compat-properties.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
+#include "qemu/target-info-qapi.h"
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include "qapi/visitor.h"
@@ -71,6 +72,8 @@ struct TypeImpl
     bool abstract;
     bool secure;
 
+    TypeIsAvailable *is_available;
+
     const char *parent;
     TypeImpl *parent_type;
 
@@ -126,6 +129,7 @@ static TypeImpl *type_new(const TypeInfo *info)
 
     ti->abstract = info->abstract;
     ti->secure = info->secure;
+    ti->is_available = info->is_available;
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -167,7 +171,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         abort();
     }
 
-    if (info->is_available && !info->is_available()) {
+    if (info->is_available && !info->is_available(target_info())) {
         return NULL;
     }
 
@@ -1153,6 +1157,14 @@ bool object_class_is_secure(ObjectClass *klass)
     return klass->type->secure;
 }
 
+TypeIsAvailable *object_class_get_is_available(ObjectClass *klass)
+{
+    if (klass->type->is_available) {
+        return klass->type->is_available;
+    }
+    return target_is_any;
+}
+
 const char *object_class_get_name(ObjectClass *klass)
 {
     return klass->type->name;
-- 
2.52.0.windows.1

