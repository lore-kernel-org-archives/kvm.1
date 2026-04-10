Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF93845D4
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850838; cv=none; b=Evcmkl0w8TQWX7LmYkfJ9dTPTYwSe3TGiridsjhIJR1i+gV5ldp4W+hJHjtWdK7XrWgdRS1Jyi/n+23e+ctVZNCvifZKtXeaOwRdfeJS6YO5braLF++CLSz1qJ2dR0R6gII94mJFFkIE+iBv8tmRfWZ98ZRyqUl2VK19bwUuqds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850838; c=relaxed/simple;
	bh=ViMf/+NuDv50acX5ejB6iwzi6AxWv1z+CaAZT96SwXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGmHnXRSj3zDjAyqDCx0N+qonrKe+S999oC7OYmVBZM6vAX61EvhQgyq0HEAuChL+fReyXnaLvUZ06EAOamZgtJrDdPtjKH3riPjd6EDTYlmXQyxUC21ZG7qXac8H00Fv5Z+B3JGn2TFdO1gKC9r9Lh/1TXPqHza/LwxOir7I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AhsaSebf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhsaSebf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so37223465e9.2
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850835; x=1776455635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lliv5w5ANZiNvmNx2mtJSUDbcwDuEoJ/CNkgnVy9fPs=;
        b=AhsaSebfjI5Y87DZLU8aZrdbdhxmnnvbUr7s2WP80TvxVkRQ+Z4WGyfA22BfU5y0+I
         IUcuqTrkB6SS4etqikd4P+oY77LTVGv8Xls5b5spzhxqZZX35xt/2H/k1SL+7BGBm0JR
         93Jsb+mdX0rvmVgHwuhA/olo3h9Wo99QKcNz0m35Pr6TJjKmOGYiWuKHHIehInjvusKW
         ICd6QnIb4CZFxvyv21/fZBhi6vwBCAqw/y2/pLddkbXhp7lfCoIh17YSVyXzLPZ3QVal
         UbwFCBNXQ5WNUXQ0LE+LXf7Miky47wIbvg7iaiUQ9TWCtDOyq6StSH9qwmB+TYMftjFv
         rRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850835; x=1776455635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lliv5w5ANZiNvmNx2mtJSUDbcwDuEoJ/CNkgnVy9fPs=;
        b=KBcwo5qvK5VkFT3PD64orC2M8sDTeqGfMya7ouqz2gvbrm4LyNbOSK85gd/zo69Oq3
         cgzCs8FPsfop7e4NY37MUmutjSB9Hy6hrgyngI/BE/XYElu1Hukik2johOrR/AaujYED
         NwbeTpF0m4bA4koXZfLEMHuqaeFLEV6wkQ8ShY65il75RjJJla+71yUb0HVB7FKuEobD
         G9gu/imFLa81V9tGV1K7AtzcJq2W6jp/AR+FHQOMp/ES2mz1Kv9jRc6Ku6cu7pwGdfNx
         HYqonCYKY0uEZIy5TDklYnG4xcpx05iQ/gkLDQ3NxvwIZIkD6i/BlcBipftDrKxFYS/6
         +E6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEZ1zJlGRI8syTSzWxc22a1QL08VFvorZfLM0r+KGDEkyqLQezUDFPpntpvXA0ri9+Xx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrAIMSf3RbchoUkjnPrh6Kr6FDMKCXqhrwqiDLRYtkDbW9YSq+
	G2F3B4CCYysyJDrfur2azUMElvWyii1/yiuhFYTjp1iLGNXR8TTSNCOdtXLXAyWS40M=
X-Gm-Gg: AeBDiesUctt8H3YjLIZ+Sxjrhj0CkbBH1ktm+EIoDkhTrZPeJEIdf/EduT+hw3swUvx
	6pWM+9HyJ52GezPAWl3uhkHxuSm4RI2F5zhpjKh0EVBeOKX1mm5Unka5JwIBOYlCgBZgwkt5AEp
	7y+TJ8RF00/Xc3FFmoh7OXyPniUfGvTPnd9H1y0zSMKGnaJaRLnqZifvFQqeLToCl25B1iFpuGn
	tLrpa/pM7vxcycYmXdRzrooMVHIHK/Zmx9ZmbY57FWYPAfZNkLIuMdi1YS9KuZ9LjGbCWmdrGxq
	W1WUpXg85mec/lcC+Bbd7JvJarNg0Bp5dbwwQlRC3XiESGM+J49c8MViQ5CUh4A/0hmhMq89625
	2D9z6ua3E+H/GSsrNpEndX+IGKNYusSF2UdH8sXGWTWLK8pQZOiqs4pOlxTY5gJc2fTf7z+Fw6C
	/SHzEOKFRNk8rXXa2yL8KOVrDfWVPxg9j7lrjrpWJxPChKfSiCB1R5wO8CO947NFh3os+i+GaSK
	PP/sgJ3970=
X-Received: by 2002:a05:600c:8b30:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488d6657928mr61369125e9.0.1775850835153;
        Fri, 10 Apr 2026 12:53:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f229sm129543465e9.3.2026.04.10.12.53.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:53:54 -0700 (PDT)
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
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu.zevorn@gmail.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 04/27] monitor: Remove 'monitor/hmp-target.h' header
Date: Fri, 10 Apr 2026 21:52:58 +0200
Message-ID: <20260410195323.17937-5-philmd@linaro.org>
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

The "monitor/hmp-target.h" header doesn't contain any
target-specific declarations anymore. Merge it with
"monitor/hmp.h", its target-agnostic counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 MAINTAINERS                   |  1 -
 include/monitor/hmp-target.h  | 42 -----------------------------------
 include/monitor/hmp.h         | 12 ++++++++++
 hw/i386/sgx-stub.c            |  1 -
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 monitor/hmp-target.c          |  1 -
 monitor/hmp.c                 |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  1 -
 target/i386/monitor.c         |  1 -
 target/i386/sev-system-stub.c |  1 -
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  1 -
 target/ppc/monitor.c          |  2 --
 target/riscv/monitor.c        |  1 -
 target/sh4/monitor.c          |  1 -
 target/sparc/monitor.c        |  1 -
 target/xtensa/monitor.c       |  1 -
 19 files changed, 13 insertions(+), 60 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 535d1d3398e..edbbd544d62 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3411,7 +3411,6 @@ F: hmp.h
 F: hmp-commands*.hx
 F: include/monitor/hmp.h
 F: include/monitor/hmp-completion.h
-F: include/monitor/hmp-target.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
deleted file mode 100644
index 6364c94edf8..00000000000
--- a/include/monitor/hmp-target.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/*
- * QEMU monitor
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
-#ifndef MONITOR_HMP_TARGET_H
-#define MONITOR_HMP_TARGET_H
-
-typedef struct MonitorDef MonitorDef;
-
-struct MonitorDef {
-    const char *name;
-    int offset;
-    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
-};
-
-const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
-
-#endif /* MONITOR_HMP_TARGET_H */
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 9c2330205fc..f17a50a3fed 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,6 +17,18 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
+typedef struct MonitorDef {
+    const char *name;
+    int offset;
+    int64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int offset);
+} MonitorDef;
+
+const MonitorDef *target_monitor_defs(void);
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
+
+CPUArchState *mon_get_cpu_env(Monitor *mon);
+CPUState *mon_get_cpu(Monitor *mon);
+
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 1dd8d9afbfa..6e82773a86d 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5e792e8e6e9..7e4c509f5a4 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -17,7 +17,6 @@
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bc26b39d708..e81632f5551 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -22,7 +22,6 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index c840ae5f0a2..d07e545ef7e 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -27,7 +27,6 @@
 #include "monitor/qdev.h"
 #include "net/slirp.h"
 #include "system/device_tree.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
 #include "block/block-hmp-cmds.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 20ba1e62988..983048db1b9 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bswap.h"
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index 35a0a342772..0dd4cdb34f6 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index eaa10ad2a3d..5599a4675c5 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index b128334e571..ddc666d3451 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index fb84aee94d2..f799a338d60 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "sev.h"
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 9dde972c118..97e745f27c4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -39,7 +39,6 @@
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 94bb12833af..be7411edca6 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 776a76602ea..7c88e0e2bda 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -7,9 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "cpu.h"
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index a9d31114442..3f206b9fca5 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -25,7 +25,6 @@
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/memory.h"
 
 #ifdef TARGET_RISCV64
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426eb..50324d3600c 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index a60671a60a4..99abddbf1e0 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d55530..2af84934f83 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-- 
2.53.0

