Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCC2F90C9
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850987; cv=none; b=GRd2RR2iV/z+dBnScZzfsaDtAViVAkj3p3TZECUxqteUJ7YyzHG7jprRtemuZqX6VM2TavEGU6m7rjNYB0kROJ1l2okTZpiMMgVTM/6muoyG4OtI45QL8usm62DngBf59RDh8LE+dMn9H3LWPY5LlBE88+TKKJPTBLWLNKp9rBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850987; c=relaxed/simple;
	bh=CzVwQyy5heD/LwKrf/nSRSgRPNLI1TZuLLC7iHCfeVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsVAkWYIerVPmDcy11Bpg34mIR8HKskbNofQMjaauqp/VNHFhURke6d7lrgwbkHpa8CQaptz2eoaieQOW+cSUgJibjOCrYEphLcW00mPS/Y9aKcKFlV3FtA0U37l4XvjUMB0V5yN9deIBRTIPGVcuAnDIcjF7ZdMMyiAIymDvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ntuEcp9Q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ntuEcp9Q"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso23625195e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850984; x=1776455784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N9tVXkZOmp74LI4AeaDzzl55NbG18DiRwK9K16fx5c=;
        b=ntuEcp9QONfbT5FtXRCowNCQDZ934CA+zT3DiuGyGpvVQX38SvUsLnToULZOEW/9Fx
         Pnr6nGAGg/S/X1BhFx+TDGHJA/5NltbQSPatvbyQRINEiLTAZkED89X7me6ZRVacjW79
         ++GGKDsK6/2qR4o8nYmiWW1Sb4MTeajnHaDMWxLB/tnyFl+AYfmjU8z58z3NfrbK9qCp
         KYJNeQa3oJV2esI5Z+N8mSlc5P0ePQQv5eXtLED0wP3CaMA2zU7pCvgDvIlS2pkJLmZB
         UtEIKkvUSTL2Fkrske8/chYN4rD8DduvBXxrOzNCSt5P6sq/tS5xr8W//r+FdxBHi/bt
         tPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850984; x=1776455784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3N9tVXkZOmp74LI4AeaDzzl55NbG18DiRwK9K16fx5c=;
        b=ITHL9GQb4ZN0IsT1KVFOzwNdW9UV49C7Bd+Faok1nnLsXNMs/QOmigbGX56rJui7EA
         fm9ix8zlVjwsbVNh3CLEx3plMcpW3AqQII7CFkWL4pz4ImCw+bGVGjIx+rwUDemutqLB
         aTFQYYacuDOlluAZGDY95YgBOg66P2YYiBGiJRyQw6WVqELcG3BjvdxayMuLOFegbrQr
         y8yTORHLZ6Bl/kXVRuAmV0RNNKmL5OLzYqKSJQzzdvD1b53YVwuH3UjLo4K6DaI+vnsm
         XcKtoXp2muo3FWTfeBuJ0L/Wqif44CYkY/C4dhdh0+6tj+z/a9jH49b5QGNkO+4a79/U
         30iw==
X-Forwarded-Encrypted: i=1; AJvYcCWa9RzgM9VwSWaKkGH5ugyjFDp3PuuSvdVRIp47f3VXBylbiAzmLfbceHlnihQy1woeol0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvXeroBEMz7RzWw0PgN65t7B4ii+OOwllg9hYVFu6sTVFLbR8
	qQiIY1h3oCGBKne743ORko3ID/ejCINeWEtc5kiyvyP328Dbp7bN7AM1YW6LFoZV54A=
X-Gm-Gg: AeBDievPwcVpsq2hli1z0hxJFpD17c2CShiY2S4MZw03LSiRDVxoDvFS5QI7kuxGG3d
	+W1kqOkoRhbHFwytLobjQhUrzck3Cj3s6FUylCmLsVqI28uA5iq5wxmUPvJ+rmfepnvw+alNWlZ
	ipAWUaPmqTht7Qp4etixyDSfKSM4a3WqoUnV/qVcOLJ6Io6DXV3Dtqul0ZBxVgx/EVPA1xuPD2N
	yuuPOFy6WJ1pnLvcGeFmOxvCBHaJ6bZzsnSEkXjKjxPH8uy/3735qMopR0VSGPoH+4N1XS1i9sj
	ch4OedOOKrciQy49E/Skrg2W+hh/lgQk1CX9FJRbmbPpywO8dzrf+F3UwHvbsOHbijCNt4HpUK7
	Gc/dxZsnu1K7KbYDszBVBu6qccfjnXNDdc42+ZcK6KKLsPjO4cFQi58SBb0QDIM8Rco/WqnjjhG
	A4ePaJoc7WAAKukm/8rrlIJU3nPkximhBKGRj3g16aipK++gc2ipR4YOQZ+vDD9LjBNWpDJS60
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488d68b27d6mr64123085e9.26.1775850984497;
        Fri, 10 Apr 2026 12:56:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm96903885e9.15.2026.04.10.12.56.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:23 -0700 (PDT)
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
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 25/27] monitor: Do not check TARGET_I386/RISCV to build 'info mem' command
Date: Fri, 10 Apr 2026 21:53:19 +0200
Message-ID: <20260410195323.17937-26-philmd@linaro.org>
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

This command is filtered at build-time for i386/x86_64 and
riscv32/riscv64 binaries. By using the recently introduced
HMPCommand::arch_bitmask flag we can filter it at runtime,
making it possible to compile hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
 hmp-commands-info.hx     |  3 +--
 stubs/meson.build        |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_mem.c

diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
new file mode 100644
index 00000000000..8a53e367a9f
--- /dev/null
+++ b/stubs/hmp-cmd-info_mem.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info mem' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_mem)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 336ab870a2c..2d0a8f7d48f 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -209,15 +209,14 @@ SRST
     Show virtual to physical memory mappings.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",
         .args_type  = "",
         .params     = "",
         .help       = "show the active virtual memory mappings",
         .cmd        = hmp_info_mem,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_RISCV,
     },
-#endif
 
 SRST
   ``info mem``
diff --git a/stubs/meson.build b/stubs/meson.build
index 09e73ef8b73..ed7ca54ae06 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
-- 
2.53.0

