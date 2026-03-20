Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C12D3A93
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773997872; cv=none; b=oNUXo85sALZ//o162PkKuZL0Dd0gLz1Tu/FcmHRGYkzLNVejbGYIIXMKNbYn/HmgBvAvbYZBuO1eZyz3yrUhWHAfU1JCGsB6eefkANs9bCoe0YnyOh3I5aSaqIA6KmFvny8HzDPycTrIEN+b63PO1t7EcnYG6RbNoKrF+CBcdJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773997872; c=relaxed/simple;
	bh=58r+oDHaLHvsvp696rZg1aDZSrY/4CMV7X9HwVz/dKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TinWt2EZPC8LM0+w8LcCy+hBXoEBaK7ilF+pNiPf3eK+yUowQpcfDPpHlbpp3bOwWBtB8ICmThobjkuk3cHrGGISjqAYkDx4i+gNuAtB4wftfsB4D4wvHlk1LDmxAExmUfwEDY/+nxJafLzzW5WEMCQJ2G8acrNVUL53ryeftkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnazI4l6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnazI4l6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so12019855e9.1
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773997865; x=1774602665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSjJLHf6QZ6otlVl4S28eFxoMW617Z3itEErL+k5Pp0=;
        b=EnazI4l6PV6CWOL1OtTrbtOMA6PWogkU7zmINLcYlT0S4YTblgc6sgwBGeIVtt2PKK
         B4y5IVN3j0EFem24EJYk3r0OBYXiW8FXxcL4snOgISn0gcAVLvnTGbdUjXJ/We1scziS
         I15xZCqcTGDNCmx7Tt7hmfc5/s/7n32VCPwYqVVQnioKekJnA2PmGsx0sFjmlsVUCmwA
         3HQbdWXUypp5AZKBx8xYnESkIU4PHfZVCcyUuO/TyCebHHsFcUOKP5Ti2UConAXNw59W
         xmFmLIBl4jDG3wWpOxbfq4j8VdTdighLIytmyHp3MIhmcaZ7eDPinRJryqkNvtJ/6pYN
         Swqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773997865; x=1774602665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSjJLHf6QZ6otlVl4S28eFxoMW617Z3itEErL+k5Pp0=;
        b=pW2vNisVbLD9A2YTGvioB5R5hyKFCvXZxDRBxWD6kQ1EVmCHwqovASS4ldk+ZRkt+V
         oCGTMUswF3PhdqVWLlJydZ1bsCJXSwG4+Pg4J3OFFcEFWgBhFBHgrYQBXxXW4ea61lGs
         ZNnS8+eT5nxkh+I1UjsKDNVbM4YXBIOYEO/WAYM3TLpoB6ANt+/vjD5Ybxm9b9b6O9jN
         t323nANPQUyw2/r9I4/Ezitt70uEUh79a8MnO1Dj2WGYM/ay6fvLdLhC7SXQk8gZITDF
         gyKwJmjOHyKqn5ZwsL/Wdkxli50q1fGFzbrOIWo8FEGhCPiSh9r1DKNTMHRNAArW8TS6
         6+pw==
X-Forwarded-Encrypted: i=1; AJvYcCWGs9ntUMOA7diUESWGxv9ghBWcrE6PiWBhHYH/3noyEyUWTZ9uETSnn9FuVZeyYk7q+NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjbWg9gX9XNVBUFe6N64zwYJk4efXYBD9G/qV6dsa8VLjTzf/D
	MIRl3buKOw7zFP9VpGuxB7gvdgh87IggRpNaCMjq7Zm0ZYZTk8stF5NmFG9x3kvA82M=
X-Gm-Gg: ATEYQzwR/uTzrCuJbmAqdScwibYVCPgQx8uW70VXglnm9IkX8uK/SgBOH74u6UlgW7B
	lG0AMPrrO140g7VVF+Zf/eyJ/EWTRuFxBHdNEJZytin9vaM+lTXCjt80unGO9b0jY6bxiffNKq8
	+TfiT/1Sc1CncA9qDEShOm3hpHPU77CUjQM5SfzPLHYdQLu2y+0VFS0VAYMAoS10Jk6FogQ8u+3
	QhxzxrYg03836aQyKomoXKQKJBaxoY0I3rQISgkRc7Q7Iq1UTmY4ScV37ZTJsstKiBjZKEeyLnh
	2SX0+KVNLevBcXqbt7nv+LIK6fIKLLrFHeRl7rIPe8qRWVBhi0XDbKbcIsFMr+PiyECbQHt/JfK
	hQOlxoEa9QnJ2CcDvFWQrMFgwBOse6n5iVi1V7ah/HH8u/oRCmUFls4BawAkiRWGLnDQQoUJpSM
	6REWf+HDeVq4oIq/1p0BVY62Zsbj0ANrpcjVzGtrRPT3VpMmIJw9YSkrGfhA9z+L2BZnD2M9Fn9
	4l+zLVvE84=
X-Received: by 2002:a05:600c:350b:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-486fe8fcf64mr36117125e9.16.1773997864476;
        Fri, 20 Mar 2026 02:11:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe6d9896sm57523785e9.2.2026.03.20.02.11.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Mar 2026 02:11:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	kvm@vger.kernel.org,
	qemu-ppc@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH-for-11.1 v6 6/6] monitor: Remove 'monitor/hmp-target.h' header
Date: Fri, 20 Mar 2026 10:10:18 +0100
Message-ID: <20260320091019.59902-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320091019.59902-1-philmd@linaro.org>
References: <20260320091019.59902-1-philmd@linaro.org>
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
 MAINTAINERS                   |  2 +-
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
 19 files changed, 14 insertions(+), 60 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f2759138d..d4b4aca60a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3407,7 +3407,7 @@ F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
-F: include/monitor/hmp-target.h
+F: include/monitor/hmp.h
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
index e222bea60cd..26571d35e84 100644
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
index bad034937a9..a85c5243a40 100644
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
index a3306b69c93..2574c5d8b4b 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -27,7 +27,6 @@
 #include "monitor/qdev.h"
 #include "net/slirp.h"
 #include "system/device_tree.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 1d645090667..c63da13e310 100644
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

