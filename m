Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028663624A4
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850874; cv=none; b=T91fYkfZd030B4ukv41/az+D6ilV59n8ym9AGqK4gyrW50DTmboyGk2TS0BDgboBZrBPxOqdxc5gtYUo9HC6KHgR3ACbISQqozZra8UKm/DBFK8d7tluKrgUMsbsFW8FgnQlaNIrZCgy0UewrAfrFZz/OWbe6d1Z6pJxYW2Hv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850874; c=relaxed/simple;
	bh=/eYF/YLDlqDg2/VdK00oB7muckfhlaKszIFXFr7CgSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/oNvPpHDv4HAygO3JWH+EdolOmX/AHBhLopZja1Jpjla5U+Cok09H024oAnlzs8wFa+Oog9xaAzBY380+JdDmMWoBOzYG5JGBtlVaBjEG75yV+ASKMUHXSxXSSxVkqRtpuupPoR0e1EdCBsMViOiAxvXnoHoSzEhbw7Y7umKtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6/pZY6/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6/pZY6/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1466809f8f.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850871; x=1776455671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQcummkxUOYYVBuFGYQ78NMsb9ycB7/JcbKGuZBFsZk=;
        b=R6/pZY6/e0WDY91O7zWqhFALW8wvk8jsCObDmBDNdEra2FjAc/HkcV5L91Pc4yB7B+
         0FXzcktxHp1KpcR8jw/aRmlQMAMKAztzIWnwy76qmVvq+utAjnmgL38Ni0Ej8zTA30F2
         lxFH7CyG10+qSrUJ54XEWsvUXuD55JfplEqqK5vjPOEmAgaNVecuoANsLQNgElcaw/EQ
         iq69RkQ91V4WqMazNnX6R4L1RdGzcnNQDYXkzeUMwEEcRIlpVn92EjaHF0Wc0XlSwV1m
         ZVuZtnFbuNHIDRoQxcdpzjwyIjMnVxGTZfKOi4vEZE3SYn2Z+dxFG3U0JoqfgNaqe+9q
         W8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850871; x=1776455671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQcummkxUOYYVBuFGYQ78NMsb9ycB7/JcbKGuZBFsZk=;
        b=J4UHU0qeJ0mmheaKfaR53VIgFBjwpJICjhPPTuq0SfZ/3fpaVcQlzsfqOPdR3r/7g8
         DvBugExsEELH5Q6AFIZlXpUM7M1xkBiKsd1VN1WchaLNQlZHWttNUO2z8QZBGcXaKy4j
         1EOXMi9CI4f5aRydGwhBYSg9rRtxbN5nktLefugSigNYjl3nMNeHZ6JDaM53UbvbCaTE
         Bd+KHmm3HkYFPijqTGGCqeyIjwS4XBKpPhNa5NalElk+Jxp/ymFCyj71/LJTqsFxxZho
         BcFvm4+RPiqT1bP5YDJU45ggIMCLE04L1SsTyQJkFP0k3YDx9B6We9y1ASdReI3+/w9J
         ttYw==
X-Forwarded-Encrypted: i=1; AJvYcCUG4oD9k95XWeA3HM7/7Vs2C68oB7QLo8zTc3eJ8RSKIgleA6B01BD4d44CI1GRHI7a0DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXH3zfDnC/sQIXNisRH8IP2wU+6YAbkUmuihOl42xb+Tgp/3zy
	Muom22e1vPl4o6bX3fm+Pzw/fe3/ceWzM2+w+fBkMJ/AT3anzeOkcY3VmqLSqG+s71k=
X-Gm-Gg: AeBDiev0di7QqXkCTnI+sDLBZl10e5dd6HY0Lz7FvCOqdgrarNnP8dlnLA+f1NHItcg
	tRWosq7uGJJx5DA7Y5e6SjxfA/eGnu0S/RNoaTc6n6kC+m7/SGz04B0jM/U4kikn/3rU6zzLynG
	cwNVpbINO+sb4EOf0CLstPA3tTAK5h8QKLHMO7phLP4G06bcfGNX3m9BWOfHi7CfHO6il1WiMg7
	cgWSjbttPJF2Ss9FDpaTw9mw6zhNgUC225jAX5ZhBERE0SonxxEXCpT/Jyg5GzgdmvAvkrOBDka
	JQhe9ea7E/l9b7bP/q1LQxOg21KmSkWJHdc1oL69GmEswsKjlGBZKbxMU0gX/epiT5YZv4JzVjs
	NXN0AlMPg3eSUZNWdWYqRtUv7R2sXS8FnPDMB4/EdcGV6i6DtY56NBhmnc2Y6CaRbBN0IY6CILB
	PfoGCHXEsrKHt239ZujP+Dy/qMjFliZTUijyDZ90FiRjz/Rk/fpxR/XlourdyKIMusUQDj/Pat
X-Received: by 2002:a05:6000:1a8f:b0:43b:a21e:9c19 with SMTP id ffacd0b85a97d-43d642c080amr6854206f8f.38.1775850871272;
        Fri, 10 Apr 2026 12:54:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5d85fsm8603605f8f.36.2026.04.10.12.54.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:30 -0700 (PDT)
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
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 09/27] target/sparc: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:03 +0200
Message-ID: <20260410195323.17937-10-philmd@linaro.org>
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

Restrict sparc64_monitor_defs[] to cpu.c, register it
as SysemuCPUOps::monitor_defs hook (taking care to not
register it on 32-bit SPARC target), allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c     | 19 +++++++++++++++++++
 target/sparc/monitor.c | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a2..9c5175aca34 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -993,12 +993,31 @@ static const Property sparc_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+#ifdef TARGET_SPARC64
+#include "monitor/hmp.h"
+
+static const MonitorDef sparc64_monitor_defs[] = {
+    { "asi", offsetof(CPUSPARCState, asi) },
+    { "pstate", offsetof(CPUSPARCState, pstate) },
+    { "cansave", offsetof(CPUSPARCState, cansave) },
+    { "canrestore", offsetof(CPUSPARCState, canrestore) },
+    { "otherwin", offsetof(CPUSPARCState, otherwin) },
+    { "wstate", offsetof(CPUSPARCState, wstate) },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
+    { NULL },
+};
+#endif
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
+#if defined(TARGET_SPARC64)
+    .monitor_defs = sparc64_monitor_defs,
+#endif
 };
 #endif
 
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 99abddbf1e0..36f3d8d58e9 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -37,21 +37,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
-
-const MonitorDef monitor_defs[] = {
-#ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-#endif
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0

