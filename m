Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA702F90C9
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850966; cv=none; b=gGSgGnf2lOhhnoT464NoDMZk1s0L3D4VJZ0fxmkY1zYymDgigU5+awe3bAIoGRv647SsLDdQaUQi3qwZGJccuy+k1PhIH8mBDseN+72N8wKYWm2OQDACwDDvgf7smdSc4xUaP54zVg5LqB1hMFG72fW6zVTvk1S9Zv/fTOLVO/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850966; c=relaxed/simple;
	bh=EeuS7L8ppWwl7JrKJ2CM7K9S5U04CuZJGYAanYmCJys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8FKNnKAdDiU2Y29CiASolwrb0YtpysGpVtMuK8FdmgdcHLoWqhHdX+g+Z1/KNPRQrUqM7hgkb3fQc8bB8fM8NyGKDjSB0MJEpZDzM5D/imZKy4qxOGcYVkw1ZCD8uupn7UEJW++vdKSTym+9O97VBUVxYQK2xkM3vkvFTOBtfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jx/we5xS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jx/we5xS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-482f454be5bso26608665e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850964; x=1776455764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k99xMD4s012E4So2wpbCNS02HNMrfRabi5ydC/W3ahM=;
        b=jx/we5xSuTsXKqfFiljGCY1axz4bU3nUht3UWnxcYeYeihP68eTqRuFBDODgx58D3f
         uhA81Kolb3h9co+1rwK+9fo9lmojOgxRZI6TKQ+bgrH+LBu3XwDm9APijrTkI1h588Zh
         TltfaG9Q4xrK+uxmYccs7jqvsFDTQ11ov7zVz5CyQpY7lRiPY2aM+8Dkche1hfJqQCHy
         trBvdyJEDSjIOPVqitqvWPOu+37WqFg2Ph5YPzON46nBnpuU3Ue0aibsFOxmzsaHuza9
         BFPZE6CbqFghUBglH7O+Igo6FGyTPSZ0nOjVg2Kna8NOdOv4zB7EaxjB5mj7mfbL8nXk
         YG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850964; x=1776455764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k99xMD4s012E4So2wpbCNS02HNMrfRabi5ydC/W3ahM=;
        b=Ig2FpyW5BCASfYDLF8YoLTv6I1rSfjTmvDP7L2eR6YikG6GKisgz091nIsGWortIUa
         jE8IbFJRbg1V1n3XrG0g5zaxzwLuNZCG8LRgkIV6HtwGZcEXfB1IIXGwdcXvWDnNV2fg
         MOSs+GwoHV7s3tTNzh2JkcX43TKhhEYXHL/z+lhiVzPwboxF4w+1oRw7RXx5TSDh6Egx
         uDpbODq5nct0l6dE3QW8bkVVpS2UevJQxP7GlEiXsoYOnQGCJB4lj4eAGzXOyOBYvD2g
         bRKnYTNKvmrZNptEj8or3KFe/atWjp1zsHvzf4la6cxj3tRGdlhntJjdeh8SPk+WzTQ9
         OhRA==
X-Forwarded-Encrypted: i=1; AJvYcCWekI4unD8UgM5Oi7HjYOVuemPevdQuy+XrFmdO7gWA/RZ5J6FCjBRyH9P2F5S3jfdkOd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh05gfG494xBkLxwNWiWlqS0pbcjqMRJYlA24qLTsE+g2Coj+a
	ee1fqPjHTUrhTbfJzn3gLjUoMK/A5tNvWQEQ+SkaIkboQaZQbAHTyNjXAhvVy0SzpjI=
X-Gm-Gg: AeBDiesBV4WvWCCd9BATNHDOk+qifAWeH9SbMdD7QFe/aKnStFrbE0pN80VhbCDIrD1
	pUSxx+yJqzDJnMG4b1v2Xl7gYQUjvihMXUI6W4ipbUTk4ldGBGSEOf6720DjGAEjRvcj1Ox+9Fa
	mHIFYYX9hfGrY9VBkbOdyI5Cbpe3tMdz2alGkxAvEADGMTvznW1YHn1VrSQhUdFINDKTyEX4Yqh
	98ndThfSQgnA6cuD+IZUVCJDLCvBVSiyPYN6WFK1GwqbY+xn/G4FLQdE93xQby9r1qgWFp0xeea
	68qFGcxSbSLo6pOnt7QgV5KIx2V5qn6nINmWR5+dPhWODEfRVcwY9GZ/iUvO1oe9P0N18ctqxrW
	Qy7PMvbuHHe5Xol3sJxGWI97PW8LM4A5a8perJmPM/IHhjkgrmR1FhLu2Wa9doHJf4AeewmSsEb
	5/52kdl/rhdBF0iq9Ysy8c0ioqnKDBm/7JEpoD9oLDBneaur6Y+UwmzMr4FcE87Yj8+YEiq3RE
X-Received: by 2002:a05:600c:609a:b0:485:3e00:944a with SMTP id 5b1f17b1804b1-488d68ae78amr59095475e9.9.1775850963612;
        Fri, 10 Apr 2026 12:56:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d525c931sm98635955e9.0.2026.04.10.12.56.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:03 -0700 (PDT)
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
Subject: [PATCH v2 22/27] monitor: Do not check TARGET_I386 to build target/i386/ commands
Date: Fri, 10 Apr 2026 21:53:16 +0200
Message-ID: <20260410195323.17937-23-philmd@linaro.org>
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

These commands are filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since these methods are used inconditionally within target/i386/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 stubs/hmp-cmds-target-i386.c | 13 +++++++++++++
 hmp-commands-info.hx         |  4 +---
 hmp-commands.hx              |  5 +----
 stubs/meson.build            |  1 +
 5 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmds-target-i386.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e53158143a8..458951bc051 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ F: configs/targets/i386-softmmu.mak
 F: configs/targets/x86_64-softmmu.mak
 F: docs/system/i386/
 F: docs/system/target-i386*
+F: stubs/hmp-cmds-target-i386.c
 F: target/i386/*.[ch]
 F: target/i386/Kconfig
 F: target/i386/meson.build
diff --git a/stubs/hmp-cmds-target-i386.c b/stubs/hmp-cmds-target-i386.c
new file mode 100644
index 00000000000..43a167056d5
--- /dev/null
+++ b/stubs/hmp-cmds-target-i386.c
@@ -0,0 +1,13 @@
+/*
+ * Human Monitor x86 stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_local_apic)
+HMP_STUB(mce)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 28dec25642d..b575e4ac993 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -113,16 +113,14 @@ SRST
     Show the cpu registers.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "lapic",
         .args_type  = "apic-id:i?",
         .params     = "[apic-id]",
         .help       = "show local apic state (apic-id: local apic to read, default is which of current CPU)",
-
         .cmd        = hmp_info_local_apic,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info lapic``
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ff65b39b454..cfd53bdc744 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1488,18 +1488,15 @@ SRST
   Stop the QEMU embedded NBD server.
 ERST
 
-
-#if defined(TARGET_I386)
-
     {
         .name       = "mce",
         .args_type  = "broadcast:-b,cpu_index:i,bank:i,status:l,mcg_status:l,addr:l,misc:l",
         .params     = "[-b] cpu bank status mcgstatus addr misc",
         .help       = "inject a MCE on the given CPU [and broadcast to other CPUs with -b option]",
         .cmd        = hmp_mce,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
 
-#endif
 SRST
 ``mce`` *cpu* *bank* *status* *mcgstatus* *addr* *misc*
   Inject an MCE on the given CPU (x86 only).
diff --git a/stubs/meson.build b/stubs/meson.build
index d4a6bc0dde4..dc289e3a482 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -85,6 +85,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
+  stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0

