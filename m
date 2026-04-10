Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3D226D02
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850866; cv=none; b=IdfVvKjYTVjj3jSl96aoGbd/ZoU1KHakn5HNvhALRJr0kkFZLGEwot9ksaZyqcnzNysms9BOVaOrcNzDu4pFLo16bqqWlqWrcmFkkDU7B9+UEbK3m5ufQL9YKljRV5AOY89krqfe50a+xsCQLZ8v3lXPuddGQv4UnwYCIgY4uDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850866; c=relaxed/simple;
	bh=oxcS6xjGnpg7ICtx8k5H7ej/VlVnR4bV9CVneVCPRCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7S5OU0JpaUpuMavwT5WtSVp2Qa4EGcoIveRqGJDKTBkIQX7daXBZWM137nz9McECm6YLKG5Css02UwjNnUG0KdoBNTBbLN7mNeCil1B4WMA+tTw+xu1JQoJqXA8Jp0XyRcjvnQBZlmNCsCNmDeqs9iGCrF59t3DYoNHqSvGDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ShubN67s; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ShubN67s"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b0046078so24101555e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850864; x=1776455664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuoKZZrJIA/hKCIvNS2NFNqHU7220n1eLUSWyy7IvJI=;
        b=ShubN67sC+czaPIPljrL4RsGF44enG7Bf6twyISlbtA8yLrX2tbsaJ5I0jWbNhoCDN
         jffjCMbem5VWD0oh6VpQ3eGVNOYnsl7WkWlOdHsIWGiibbY3bURxIqAoI91w+vx7vukD
         u69drIQzSWn/Z1iddn3Bwwqvtg1OL951e+wQWDzJDoCqRDHP60oaKJY3yUgsnyvVmObw
         yVUFIwlYyDbUxAO3M6hWjW4G0atKRNZbcTLOkPLHrGPYQUPXQbn1SHLAivYfM5Xcb3A4
         6wBDD7OL8oKmK+GQzbHlzXPN0ScXWosMDQgfEhOZYpxfsdnPiq2JF7hoDroQfizP3vaD
         S1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850864; x=1776455664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EuoKZZrJIA/hKCIvNS2NFNqHU7220n1eLUSWyy7IvJI=;
        b=d1tkaO2VS9deyBzx8BTT8HTEfB4p5r7WlQfPSipgRF9Jdas7/EpvKToYxahmKwsCtm
         oprwYrPgIkTznbdhGZkaUsASW1/n3mGIxoSUCrLs00b5PVoipLKEb3qtj0ixD7rztDje
         hTASzhTIdFnrdKreihSkyTUmzSQUzFhArBv9oq9h0toWnFNi5Rrnq5hRvfDtvMRRCON8
         V9QVYgqvooiHqb2qhS3buxkqz/oGOP844C6Jx0phCQIcdyR5C+3pvOFhucaPdcNMICZJ
         A/vciJaID0OcPV1LtM70gW0ga+zziwTOdq0jyULKWzYt6oqfOqFluC5V+WcIPk4usT6n
         R4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMsW0YVGoM8oRbvzh2M36rhwtffOiXof3J8IofJJsViPvgHj0ZiAXbMX8TJ/Mfn2fI+TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya/ZRHfoAvsZk7HqzNStcSQIKoBm9fSFMFwKnOMBXVjgeP0O/6
	c6ATZxlaJuWs7DjVjKYti4+9KUI+x87Iwyx8uu7e9pirNstE278jMRRGjul7v4p3HmA=
X-Gm-Gg: AeBDieunk6SH2OayQUWDUQaN2LPK94c/0XSto/vEOYBIlllS/Y/RRBsDr420P2xVnNm
	Zot/0o/S1W1PsFr55ACWlKL0VBJS+NoELS7S/Iv9jamlQ5LKzsrlfJSlzyCSP/Ksg+lAkT2i9Xx
	sb+CLb8O93I1QQhwUD9qtiKLQDHY11cU+ivUwQLSshsMbGFfQOs/vStpL7wCg2vqBiCO0vXR3UP
	6GDOIAMN8NkBYsY8VxPv1EEQlXGAZy8ytyCpjO32NwtFYRU1wd/EJKsQaXl9bM/4GOzYuRv9PPm
	uPwhMIA6R61NpsQ+lPFyB6O4U6LCyCFXznU05Ql5x/EDbrQFPSo6QqY8oi4+MtGVUiDM4OwWDiQ
	u0mjWHoj5xp9cIS5slVnm1sMDyA6ukeFMeRuZtrj2zpA7zKfec9/unn6eyq2eJuMyIn4/bU5XlA
	KNWx81L8X8A7RyNNH6jSLRXQlnPEi6yNKWSpl/GdDJrWDHK8bd71Iwv1CDL4JzROagrLqGFQXS
X-Received: by 2002:a05:600c:a109:b0:488:a977:8de with SMTP id 5b1f17b1804b1-488d6839866mr43608325e9.16.1775850863956;
        Fri, 10 Apr 2026 12:54:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d683e54fsm26145515e9.23.2026.04.10.12.54.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:54:23 -0700 (PDT)
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
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 08/27] target/m68k: Replace target_monitor_defs -> SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:02 +0200
Message-ID: <20260410195323.17937-9-philmd@linaro.org>
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

Restrict m68k_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu.c     | 18 ++++++++++++++++++
 target/m68k/monitor.c | 21 ---------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90fc..f704a6af613 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,6 +25,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
+#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -602,11 +603,28 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+static const MonitorDef m68k_monitor_defs[] = {
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { NULL },
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .monitor_defs = m68k_monitor_defs,
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..3e0df40a6b8 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -21,24 +21,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
     dump_mmu(env1);
 }
-
-static const MonitorDef monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0

