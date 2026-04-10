Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2B38CFE1
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850860; cv=none; b=THOXL7FjizkfWY80yRY7Hde65owQta6A7nj+Bmeyn/X8Q3LVqX+M5A/0jeECtdWxStYkKMnDt1E55I0KKRKZ5Sm2vxrEnxSPp4ZdEww4PcF7MTPNCeeDvR9RaY5hndhMqbE5VrAbksmclbRjjZIYXHjbwDDOhliaZXhJTR6HOsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850860; c=relaxed/simple;
	bh=LXDhXjn+hPa2R/C8QMQjEAV1h38ohdxd9T4GTEtRsDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1ROXsl+eDsD4yVUtznLqSPb+YzmhWSdYNp3vx00c3lp6CycNsRUu+owJ0x41HZGFFv0b6pRsj6Ahuj7HxLCuU2M7+o9d+aUOgmT+bqbjdC6zikZJ/cgb+JSua/kJ7jbrKuVdlB55W0VsdP+bfONmXe0Ka7YLDF4S9LyclgHX80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QzBXsQnP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzBXsQnP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso1606356f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850857; x=1776455657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s/GIt0tTjsOfb6v9VaN6RJdqFFBKJGIkUaXvnC2hp0=;
        b=QzBXsQnPjWEPrP6k4ARyOmuiQrp8/prS5PvcyO3uT/NkG85Nghz0VRIwE5jQ2xSQel
         hoUALpM7Z5Y3OPfD4lcAkchzvjcWzGLyhLqrUOevXOTFZBCnyKhTH9c9sCKsB1htIGCB
         aO2lFn+HlmLAYo9sHANC2xIDGBbopWPpHNotsSNOZlz2vW1vdvQx0iWG6Qi6DaJbC7qs
         dj8oqGVdRCJOPQCOJYaB1mJFfC0nr2s7ykRycPKuXAjGR7bLRqUHAKmT1sqZYigSYtS6
         5Wy2rxfmGZgOucDncHhKGZaOijXPzT/vCtTuFcxJQC8ZCPQHpFQ3nrejQBZAbSeujS3V
         9oIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850857; x=1776455657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5s/GIt0tTjsOfb6v9VaN6RJdqFFBKJGIkUaXvnC2hp0=;
        b=rMgsBo+StWZbk2zAznYnXANDlB4y8KNKK1L46KVEai1XMF8Q8gUHEVP99fQmyh4wFQ
         6zJnZ0k8At6LKWPgPV5UdHhQZnW1hOwr0PNaLrD2WMBg8zDbfPY7WVofQMHDeBiycDqc
         +k/NJA0+xdxHETp7so1MMTwaV4CclLgTZVfDhn6jkAS28NPyDVvraquCHgXyLQaxk9xY
         PFxNbaTqJyXhEczir6Xelp/pFZpoX21S0zWW9VcXh4fKIox/rVQsAGLjBnn27R/HlZ0X
         j67/Ln0iWoWye2ywbmDILkn48/Z2+bWQd9rhXEnw8nuyOiuKwL+dAm6iCPoYuZIFgMs8
         Spqw==
X-Forwarded-Encrypted: i=1; AJvYcCVUI0VPl4QgbLN+59/e2mksOna4cD9mkRNr7RI7GBMzePwfij9SPzoEOPRqk/gEjpe051E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Gen7/NIweN5wQ1QDHxZ6UwsDEOw2viXCTTJr8as+RiCpo8LV
	H0tjHGqobllEcIxPFBHDf58kRxgI+RJu3P4ZhrTL1c0BQqD++/sZfq2bVxDTUEpMUnw=
X-Gm-Gg: AeBDietn8py0plXe1DqBOkDrU6fUXMHxC4Q6uGf0GQ83+zwZ9X71AGcUs1w21QnlEvK
	Fj+Rk7+cDoK0EmiePXVbdXpHR1HwPTeB5S7HfDrmG78l92vQU59Yiozg/J8waxTb7sfnnjDS/Cq
	diwj2n2Iiz68RoktG7v8toBdXIyMuk+iRfZSaO6tML28PRWDy0ujyqvDOGBELBf2InyPpSZ0MeN
	bC4MmGL0+nkbJKy9fi2gyQRYOZY0oewqYwsePr81BDE/blG1m7VYDqGA4dWEJ2CTChvT+E1LFoL
	ezMYFjK9/VbL2IhlliDNYMZupyOaAqoekRwV8hZfSVqKIAkzquJG9qL3JQb985nvv9vf3hiT4ts
	YpbyXZ5uAN5k+E+q9QevbpbOgeUkEnLRAggJhorpcrd7hSAt3bWCj79KrwW3X3JcMGHslOGs3Hq
	mt37shVnMqsq30OvozyBXz0PLcj6Cot96YNBWd8THGx3D4KZ4w2dskXvNsmiX/vzsrKMkLsBTg
X-Received: by 2002:a5d:5f92:0:b0:43b:60f7:2283 with SMTP id ffacd0b85a97d-43d64289753mr6876436f8f.22.1775850856829;
        Fri, 10 Apr 2026 12:54:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e469ddsm9737710f8f.17.2026.04.10.12.54.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:16 -0700 (PDT)
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/27] target/i386: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:01 +0200
Message-ID: <20260410195323.17937-8-philmd@linaro.org>
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

Restrict x86_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c     | 24 ++++++++++++++++++++++++
 target/i386/monitor.c | 25 -------------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c6fd1dc00eb..968414e7215 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -39,6 +39,7 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
+#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
@@ -10685,6 +10686,28 @@ static const Property x86_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
+{
+    CPUArchState *env = mon_get_cpu_env(mon);
+    return env->eip + env->segs[R_CS].base;
+}
+
+static const MonitorDef x86_monitor_defs[] = {
+#define SEG(name, seg) \
+    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
+    SEG("cs", R_CS)
+    SEG("ds", R_DS)
+    SEG("es", R_ES)
+    SEG("ss", R_SS)
+    SEG("fs", R_FS)
+    SEG("gs", R_GS)
+    { "pc", 0, monitor_get_pc, },
+    { NULL },
+#undef SEG
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10698,6 +10721,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+    .monitor_defs = x86_monitor_defs,
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index ddc666d3451..a536712c755 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -591,28 +591,3 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
                            flags);
     }
 }
-
-static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = mon_get_cpu_env(mon);
-    return env->eip + env->segs[R_CS].base;
-}
-
-const MonitorDef monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0

