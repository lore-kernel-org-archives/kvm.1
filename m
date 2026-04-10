Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AE348453
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775851001; cv=none; b=sMb38R6Aee1gt19vO/R/92IAOd5R5jU/EB9opYuUKTnEco3SXIFHzwLBippcAkkBaDKGcTwIAcR0grmAKuPI3MqGRqZJMEWzezEG7+cVAvaBi8NHi0kzgim1gwYgGKbhSZb3xVLvoneC02kywUzsx3xbc/CBoC8m0WcUfkiyyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775851001; c=relaxed/simple;
	bh=O2UbyZqs4KrGQ1jrbrdOCAFvD6ObnVVMmMDKboKLzcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFFmMXs7nJU31J6miYreN2V12+Lz4E+4ianAQMEr4ura+skPbp4U5ZWIp/8Ud+FJG4kiUChi3+wqE1Btw/nBjdychha0vOx7Ik44TRJ8Snj9rGSSdYJtpcORuLfmMJxQV+64iHy0frWQMjWGwI7cFA8sUJNeWh1e9DeNN9h/FeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ceZ2nsHj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceZ2nsHj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so26372315e9.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850998; x=1776455798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnjRe5b33HAs4SIsako+kOOSPGazNPDfUbCOKtysLcw=;
        b=ceZ2nsHj2BKJQAM9ZPVhCLvBdwB6a9ituLu2gbwjNPbhQ4OFDm6aT90spFJ1+o7yk4
         yBHS3Zkvq74HRVzswvoBgk9rMYDsmFOEsidrqp/P4bHm3g8ZD6OdckUjA84l7QIQB7f2
         8smUGuqmVJyAwSsjVvBpx/Rn9pgSRXWFOrW6ztIpe0a9OvSEQ9KAwUr6hA1yTGq07TUD
         mOeYiKKL9evHv5AQViFRpL35dmN8XwfsGddFMPNTj5/WO2HjOPM2omvMs9ju5Sjiz5yZ
         uV2K5/ZpdOuzhBUGTbBKE86v3WBiwwukGbdM9eAccWR4mng6+pVMFhBJcLq53PnmSgBx
         r7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850998; x=1776455798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TnjRe5b33HAs4SIsako+kOOSPGazNPDfUbCOKtysLcw=;
        b=asuLoa5oU5++OeFhuDxrJzBkMJbDQlXt5jsqU4T4J1S03x8LCGRyHUpF0yL5BgFx/X
         KXfJ4iCPkc1zyVyKtDwtSz8hEqn1MTiriFiY/PjK/pTYC8uacOpBVNb+StzAtMmFsTDj
         YQjQsQlqgsWy0bXE/uf9JhgQc1EiUQ0kEYRYyTMe7fPcL1mVdT6tnEXqzmkUyMoGWcDW
         Uxun+K400In2hn/KvZqDzuBonIVa2PYUrA0iU7X0YhtQ3lvnQGSVGkmO3RpNbRZY5VZi
         fsdbI658L0AZrZvkcPZhWRhZZGFpRVTwGjLw5mpv5D7dr/FuGKt8okfrBq9QCvyfHkIJ
         EiaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2yszVUnSUhD/vcc+LK93RYjXeYXnwaFkn3OPGINmDrn+zhffPVT7Xuti5wD726yESM9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSuWmaKXUDKD6pVysuTPTP5we98wZ75Ul6tgepezAbWnwQQ45v
	T0kFier8MJh1REkjjXI2drJ5BECXyJFMbWTp+xyJAJu95siDum6AqWVk8KpAeq7kyDg=
X-Gm-Gg: AeBDiet2cjyQ4/+qo7lNBA9F9Uup5piCaHxpZJYv4IU5YhhJdLS+eKurtY3u+qEWqYv
	HR3J2k82WmW0aY6Jj8eclOpSpPRLL0T02ZH2ppbMMvCozekrBfhkNxUqyGP41qcEQvs7BXWfec2
	KW8m5Yw66HeUwbHArsixErPed0XHoBXKzzxvkJKHISlCKd5V5QPgHSmishpGN9IUzuG6K0hDMYV
	xJZKM6G4J+YShP08CWyZ0XLB7KDFy7COiFVqs9AUSk1U8/bqDGhPKBFiS6WuGh+OlYOYUR7jWPR
	xhSQEVitVZ7kne0eRenv0BqckKuZbfVLaDvleTQdE+kn2/ON7MAWaTQ26R8tlcQgbwsGegwLdE1
	wBGYrk/WjEBUWOmCJSYNd6ul0vEjZh9NjICpoPc2EheTi6KrgfzW+gLkc2boxPMD3cK6B0Lz1mO
	8bGQM+4njbrU+bbdNZVFu7EMRPTdLfmFN9hNXSihzR1ZQjxIVEg2/P0Jr3ptYYT6mKgiVsNgEt
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-488d685b577mr50873375e9.21.1775850998436;
        Fri, 10 Apr 2026 12:56:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f1f9sm124274295e9.1.2026.04.10.12.56.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:37 -0700 (PDT)
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
Subject: [PATCH v2 27/27] monitor: Merge hmp-target.c code within hmp-cmds.c
Date: Fri, 10 Apr 2026 21:53:21 +0200
Message-ID: <20260410195323.17937-28-philmd@linaro.org>
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

hmp-target.c doesn't contain any target-specific code anymore.
Merge it within hmp-cmds.c (which is already built once).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS          |  1 -
 monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
 monitor/hmp-target.c | 73 --------------------------------------------
 monitor/meson.build  |  3 --
 4 files changed, 40 insertions(+), 77 deletions(-)
 delete mode 100644 monitor/hmp-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dcd24a8a89..d184e25ddd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3414,7 +3414,6 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
 S: Maintained
 F: monitor/monitor-internal.h
-F: monitor/hmp-target.c
 F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e81632f5551..409a1a9c701 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "exec/gdbstub.h"
@@ -22,19 +23,58 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
+#include "block/block-hmp-cmds.h"
 #include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "net/slirp.h"
+#include "system/device_tree.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
 #include "disas/disas.h"
 
+/* Please update hmp-commands.hx when adding or changing commands */
+static HMPCommand hmp_info_cmds[] = {
+#include "hmp-commands-info.h"
+    { NULL, NULL, },
+};
+
+/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
+static HMPCommand hmp_cmds[] = {
+#include "hmp-commands.h"
+    { NULL, NULL, },
+};
+
+HMPCommand *hmp_cmds_for_target(bool info_command)
+{
+    return info_command ? hmp_info_cmds : hmp_cmds;
+}
+
+static int
+compare_mon_cmd(const void *a, const void *b)
+{
+    return strcmp(((const HMPCommand *)a)->name,
+            ((const HMPCommand *)b)->name);
+}
+
+static void __attribute__((__constructor__)) sortcmdlist(void)
+{
+    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
+          sizeof(*hmp_cmds),
+          compare_mon_cmd);
+    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
+          sizeof(*hmp_info_cmds),
+          compare_mon_cmd);
+}
+
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
     if (err) {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
deleted file mode 100644
index 4968d511101..00000000000
--- a/monitor/hmp-target.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * QEMU monitor, target-dependent part
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/base-arch-defs.h"
-#include "monitor-internal.h"
-#include "monitor/qdev.h"
-#include "net/slirp.h"
-#include "system/device_tree.h"
-#include "monitor/hmp.h"
-#include "monitor/hmp-completion.h"
-#include "block/block-hmp-cmds.h"
-#include "qapi/qapi-commands-control.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-machine.h"
-
-/* Make devices configuration available for use in hmp-commands*.hx templates */
-#include CONFIG_DEVICES
-
-/* Please update hmp-commands.hx when adding or changing commands */
-static HMPCommand hmp_info_cmds[] = {
-#include "hmp-commands-info.h"
-    { NULL, NULL, },
-};
-
-/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-static HMPCommand hmp_cmds[] = {
-#include "hmp-commands.h"
-    { NULL, NULL, },
-};
-
-HMPCommand *hmp_cmds_for_target(bool info_command)
-{
-    return info_command ? hmp_info_cmds : hmp_cmds;
-}
-
-static int
-compare_mon_cmd(const void *a, const void *b)
-{
-    return strcmp(((const HMPCommand *)a)->name,
-            ((const HMPCommand *)b)->name);
-}
-
-static void __attribute__((__constructor__)) sortcmdlist(void)
-{
-    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
-          sizeof(*hmp_cmds),
-          compare_mon_cmd);
-    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
-          sizeof(*hmp_info_cmds),
-          compare_mon_cmd);
-}
diff --git a/monitor/meson.build b/monitor/meson.build
index 585251804e4..4c58dd148c0 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -7,6 +7,3 @@ system_ss.add(files(
   'qemu-config-qmp.c',
   'qmp-cmds.c',
 ))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c')])
-- 
2.53.0

