Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201137F723
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850830; cv=none; b=mA83eyB9+eUFSObDL8PKq5NWozR7ZTDj6CY6LxvqbDvm7HijcRFFHIz6LQTgjRdi1mexbL1gkhMdrQcNUytpP/5O90JHt3BfJUpGWjXMZSuKLpxrLa3pl30gkDpEeFVWVMoWBJ8CgmVttRMbnjXtgp1IzOevFe6rzL8x4ziFfcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850830; c=relaxed/simple;
	bh=dv2HWCjTYKYRLblBx2l5sTM2aKGgr9sdlGARGZ4cJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUh9Zw421e+1uR3TwXZhVkAUayI3h8C5z4sJN/wgPkSxqkArG+pEuQlmi7guoW4hs7zNI7CXNFVH+BA/Xoen0a62OqKfwrM8c9rdUZAUFPPP7uaRZNL9ogy1wxET0h4ipz8WOErYKlkaUlYU3DKDyBHUxbD+AlZZNlnpvWcdLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QikywAiL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QikywAiL"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso35610645e9.3
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850827; x=1776455627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laXD0bHOFLR+f7DqrbhiNwPQxGkoCRCAaO6RrZRP8L8=;
        b=QikywAiLN+lOAmBpTSED8gg8pVUecLJksup4rLs/KiIjB+4Xft+Rh+8tC5CH754Q88
         wzS//9GpoogSOnECQSE9n/mCFTb9mHRTVBfuX1kfLE0TWMmbqVntpLNcUJi0UNPJmiGS
         CW3cRtmoESkf5AIuejLsZ2OFLO8zH9+PsDKi7Zu4vVuc4+yeWKlM0ElJxS1K6z18vGIc
         XVAeJlX3cgZpSkuSr8Fw1DP09h5FlFMech/crIe1im675S8s6WCR5EpwjfRwKTnuXqr8
         l2QLyjNSvYjA8F9GV9w6PZ4H2VdSabeQAXHvrkxSVQw4ycFapnPJ/ZTcTd74Iut/Xpgh
         T4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850827; x=1776455627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laXD0bHOFLR+f7DqrbhiNwPQxGkoCRCAaO6RrZRP8L8=;
        b=k1rXhf1fhvQeLGegKoE9GplhVzWB7tlfsl1DqzA3mPJX2IjPquhCumInPe3gQbBxLt
         mFq3W7xQPA7dRByMk4FCt1NdqclBu59+tpncdE+pqHXQReMFQ00DlatAyy0ZEYvxi0eX
         LAaUyfxxPbs32tVTEfo65L7VrjwNqHK3z8idxtTkltswc+VrQjNsxVnnGIP7lGQmyTfy
         yaq99XR1BuNzRzmFSMNejeyil7bLt4SmabkYD/8mqeSOJFu9FXxnZTA6XcatI2GRPd2f
         X3zUxpJrhlDKNpzDIMwbpohZP6NqCJ7s0gRJVv+Glh2LmbbRdor5rP0G6W+8z4uIWONP
         GQGw==
X-Forwarded-Encrypted: i=1; AJvYcCXpT8jseCOPRNV4a2c+mLUmDU8LdtDonTwBken31Z1pQbYPkurajE1S7xmnBuPWpFfp/lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReXElBshjrm7I/q+zgnJmGbe4mlVzgnDSvQbN3M4gMOxEqlb6
	MxpHf5IB6yc2zVy+VZ/yD3y8BOyfNxwCCzmPvJvgWYi9SMooKX+fwKV45+l3oGlTOq8=
X-Gm-Gg: AeBDietpKjDkgUT0YfLDfM05B1WWcjwBvRyn0j4rkVFgvAANnJSJYib2bsLWc5irXBL
	/mcGN0zqpg6Ug4JqGOjdPDjNbEl24jtsxoQjUvSR0iMi417+TpnrUVrmJclqTt+Nex2QU4mpGJK
	Ej+EwSl8ZO1kWSk6AynWpR9L/zoiQ9HXP0xZSEtTgNHu5s7t9AiITujdFFA+8dxH2XD2iFeAQPP
	Ez2mzzFIMEY9AXfL/AzHH+11Dn2/VoxzYOmR6w2CHB1EwlPjBSqiMwKKoJw+BxqNlLMuLq9marB
	eYkQY0veMHSD24YSg9NHpqoZWuy2bX9WrNPhlNx1fEe5SL2Dl+JBCk/7+pbespQ265DKgcJV2dk
	iDW9M7Y0axB4SVRy036JQatXMJemh+ux1eZLdaHKMsjw6wm3/018nbBc0EgyuJ6kcybfH9avvts
	cGu5CjYsDgd5hdkRowW0xtYoakHENJeOHoFYk3ZO52ew+ow9iDuCl9iVjD9844qqv6ubSDs0XR
X-Received: by 2002:a05:600c:a411:b0:488:af48:af11 with SMTP id 5b1f17b1804b1-488d67c749emr47503115e9.1.1775850827230;
        Fri, 10 Apr 2026 12:53:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d681ea59sm28031745e9.14.2026.04.10.12.53.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:53:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-riscv@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/27] monitor: Reduce target-specific methods further
Date: Fri, 10 Apr 2026 21:52:57 +0200
Message-ID: <20260410195323.17937-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

get_monitor_def() doesn't use any target-specific declaration
anymore, move it to hmp.c to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 monitor/monitor-internal.h |  1 -
 monitor/hmp-target.c       | 39 -------------------------------------
 monitor/hmp.c              | 40 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index feca111ae31..3ecd394ecf6 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -181,7 +181,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index b9b79e8e927..c840ae5f0a2 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -23,7 +23,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/target-info.h"
 #include "monitor-internal.h"
 #include "monitor/qdev.h"
 #include "net/slirp.h"
@@ -61,44 +60,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
     return info_command ? hmp_info_cmds : hmp_cmds;
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
-{
-    const MonitorDef *md = target_monitor_defs();
-    CPUState *cs = mon_get_cpu(mon);
-    void *ptr;
-    uint64_t tmp = 0;
-    int ret;
-
-    if (cs == NULL || md == NULL) {
-        return -1;
-    }
-
-    for(; md->name != NULL; md++) {
-        if (hmp_compare_cmd(name, md->name)) {
-            if (md->get_value) {
-                int64_t val = md->get_value(mon, md, md->offset);
-                *pval = target_long_bits() == 32 ? (int32_t)val : val;
-            } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
-                ptr = (uint8_t *)env + md->offset;
-                *pval = *(int32_t *)ptr;
-            }
-            return 0;
-        }
-    }
-
-    ret = target_get_monitor_def(cs, name, &tmp);
-    if (!ret) {
-        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
-    }
-
-    return ret;
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 0e5913fabb1..20ba1e62988 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -355,6 +355,8 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -1595,3 +1597,41 @@ void monitor_register_hmp_info_hrt(const char *name,
     }
     g_assert_not_reached();
 }
+
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+{
+    const MonitorDef *md = target_monitor_defs();
+    CPUState *cs = mon_get_cpu(mon);
+    void *ptr;
+    uint64_t tmp = 0;
+    int ret;
+
+    if (cs == NULL || md == NULL) {
+        return -1;
+    }
+
+    for (; md->name != NULL; md++) {
+        if (hmp_compare_cmd(name, md->name)) {
+            if (md->get_value) {
+                int64_t val = md->get_value(mon, md, md->offset);
+                *pval = target_long_bits() == 32 ? (int32_t)val : val;
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                ptr = (uint8_t *)env + md->offset;
+                *pval = *(int32_t *)ptr;
+            }
+            return 0;
+        }
+    }
+
+    ret = target_get_monitor_def(cs, name, &tmp);
+    if (!ret) {
+        *pval = target_long_bits() == 32 ? (int32_t)tmp : tmp;
+    }
+
+    return ret;
+}
-- 
2.53.0

