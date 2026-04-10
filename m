Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3531353C
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850959; cv=none; b=fmYzIALdCKViCTRl3iXwFvG98xWNvCY/EUzC2AfKtAwUaL2zrE2aao8UIrF2GRM/cAuxsI6dGjTkfnmT7CwIyQa7XDdmggFmqBbwSxslYHRps7Mb6qqEy4Ms6PZIwJ9HY+E0DVOVHmN6WwDCioB66nIX3fNqFYHuGbF6q8Y9+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850959; c=relaxed/simple;
	bh=ZPlYU1WRHTxaxxvY6Gbg4NiNCsjNycIO7Cusn15fxXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNN3S+l6zwqCgAeCl2yAK2W9WMDUaQWgl1Ebs3eJ6JJ3S47ZGKQy5V2OB1hBiWZCykbJxOLYpqWqjny1lxauDdkUIDSkGKeV9iu+vnO6RvpOMpLLxushjFzjINFNlNmjlfuqhQPjjZdth4oK7d4sGYwD3PQqJ4cTE+Is+/bpbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sUKinm1x; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sUKinm1x"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488c2690057so23823105e9.0
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850957; x=1776455757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns/VNhECUVMMVKjm49BzmvODa90VglcciVurHoSA27A=;
        b=sUKinm1xqDfcGvtXgaJTqNyuvcV2DTNmmQbcvTn7DCkG9TnDTcqSiZR+WOiUcp/rCo
         4ka4hKgFRZa/oFQJQ2LDa8t//2NMi7osz+gSiIu3JUsaWvhbzERmnF1sim7nboSiuEds
         /iIohMRT2T/zGCzcnFRwlb9Kn1ZP0l6kps4ksAgX7z/8jH8M4pVwbahjOYAbrUPWVKgS
         hgiR4JUtyrlvwIlmhkq5FtyS2xFgBiEVcQXZFRn0TJCIRBKS4wlrg0448XgHMLvcu55O
         NQ/N0HTMgoEpsWsqXwgdjpxISzcU0jmhge8LFYcTLFenCCmINgjzsErWYQVE3BUafdTI
         k5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850957; x=1776455757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ns/VNhECUVMMVKjm49BzmvODa90VglcciVurHoSA27A=;
        b=sAJ7aCbYPVH0qiUYOhdvrhCNcn96iyUd/qSZ+xSSOmeRPILefbAokw9jdPlZJSu9Bj
         IclljAjBZXXTrful2CZeL3ByVDLQl/59YKVO+QCgmmFV/iajbGlqioHOTZ69/YiUp0pR
         8vnhLN72DeilMH9DTZ8zrtfhVDsh7lHi9kzY4BMgAFFIlrDl9LW7Jsamj/sdqU2V65uE
         /Spo70PJOvPE/vXwx+aKm8yGIbnM61BXYBkhF1pwk5/Y3W/6wtIsf88AoadLZxx0ZxYj
         IqHO5geIFTgrh63gt4+9O3fiqTKAqHXZxYFg+u/7IvkLhUhsnpdp1FJNjsj+EeQP0NzS
         1GDw==
X-Forwarded-Encrypted: i=1; AJvYcCUsfH7nnM/X+xxhV+o/YXBFaXDriA92ra8FhHrTHQ1R+eCQjmzY1gQAVINDSZKwc3ZvmWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvjD4o/yy90JnTx1LOiWNYWNZLzOs6ZUGP66qJWMxn3Tfx0rO
	mWecNhrkaBUMQstKJNLagXEvieQUL4/JxbZ0WGnNqhZJVh+aricHef6eCN505lud/qc=
X-Gm-Gg: AeBDievAMY/ovVufBrOM99ACjm7+notTsuzE/O1j8CGhJo6YEL+VN98wLEjsxem3swO
	KChGHqYrXn8/SAOzWr3MEbYsHjgzySI23CKTScHhKmAOAb19zJQG+fC7zlbjW+d8XplTRGXCVVw
	pwKSFyv8lOfOnHXH5fuKa37uz3eY4/vFnPu+8324OB2tNy5jd7LoAn4E4zOkmJMgb5osqFgKB+X
	ksTJmwaX7AswS/JwsyFZdCSMwclN2Qp9TySW/gGb+ocBOxotehanVIRkeDP3LJ0ouzGQIgnsi00
	HZx6zOpeI6eTm3O9PlifWPyDvJmRsjSDwIrXu880ejVgBqhq2CuDhh5HcKS1UMmpVrv8hZmniN7
	efC73AvHzc8P6k6Yyd+lxBMycNziCAHoFIXyIuQPoqhCj+XilOrOtQRlKe+HQAMsFPGNozsEB1N
	NuAZnVVm6MvykwF8sWoi6Ddy4SAV6geirqEN5jY9dc3+P248eQ7ZFRrpanqQxHNyC3OV3eUB73
X-Received: by 2002:a05:600c:64c4:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-488d68c2c56mr54818125e9.22.1775850956615;
        Fri, 10 Apr 2026 12:55:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888c12sm109936675e9.3.2026.04.10.12.55.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:55:56 -0700 (PDT)
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
	Cornelia Huck <cohuck@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 21/27] monitor: Do not check TARGET_S390X to build s390x commands
Date: Fri, 10 Apr 2026 21:53:15 +0200
Message-ID: <20260410195323.17937-22-philmd@linaro.org>
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

These commands are filtered at build-time for s390x binary.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter them at runtime, making it possible to compile
hmp-commands[-info].hx files once.

Since the methods are used inconditionally within hw/s390x/,
define them in the same stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS               |  1 +
 include/monitor/hmp.h     |  7 +++++++
 monitor/hmp-target.c      |  5 -----
 stubs/hmp-cmds-hw-s390x.c | 15 +++++++++++++++
 hmp-commands-info.hx      |  6 ++----
 hmp-commands.hx           |  6 ++----
 stubs/meson.build         |  1 +
 7 files changed, 28 insertions(+), 13 deletions(-)
 create mode 100644 stubs/hmp-cmds-hw-s390x.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1810625eb1e..e53158143a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -122,6 +122,7 @@ F: include/hw/watchdog/wdt_diag288.h
 F: pc-bios/s390-ccw/
 F: pc-bios/s390-ccw.img
 F: stubs/qmp-cpu-s390x.c
+F: stubs/hmp-cmds-hw-s390x.c
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index a0a063db8e4..c8ce8579424 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -16,6 +16,13 @@
 
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
+#include "monitor/monitor.h"
+
+#define HMP_STUB(cmd) \
+    void hmp_##cmd(Monitor *mon, const QDict *qdict) \
+    { \
+        g_assert_not_reached(); \
+    }
 
 struct MonitorDef {
     const char *name;
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 9d8dcb8835a..4968d511101 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -35,11 +35,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-machine.h"
 
-#if defined(TARGET_S390X)
-#include "hw/s390x/storage-keys.h"
-#include "hw/s390x/storage-attributes.h"
-#endif
-
 /* Make devices configuration available for use in hmp-commands*.hx templates */
 #include CONFIG_DEVICES
 
diff --git a/stubs/hmp-cmds-hw-s390x.c b/stubs/hmp-cmds-hw-s390x.c
new file mode 100644
index 00000000000..2b4f4cac79f
--- /dev/null
+++ b/stubs/hmp-cmds-hw-s390x.c
@@ -0,0 +1,15 @@
+/*
+ * Human Monitor hw/s390x stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(dump_skeys)
+HMP_STUB(info_cmma)
+HMP_STUB(info_skeys)
+HMP_STUB(migrationmode)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 463038c302a..28dec25642d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -717,30 +717,28 @@ SRST
     Show rocker OF-DPA groups.
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "skeys",
         .args_type  = "addr:l",
         .params     = "address",
         .help       = "Display the value of a storage key",
         .cmd        = hmp_info_skeys,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
   ``info skeys`` *address*
     Display the value of a storage key (s390 only)
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "cmma",
         .args_type  = "addr:l,count:l?",
         .params     = "address [count]",
         .help       = "Display the values of the CMMA storage attributes for a range of pages",
         .cmd        = hmp_info_cmma,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
   ``info cmma`` *address*
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 06d7b17bf25..ff65b39b454 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1125,30 +1125,28 @@ SRST
 
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "dump-skeys",
         .args_type  = "filename:F",
         .params     = "",
         .help       = "Save guest storage keys into file 'filename'.\n",
         .cmd        = hmp_dump_skeys,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
 ``dump-skeys`` *filename*
   Save guest storage keys to a file.
 ERST
 
-#if defined(TARGET_S390X)
     {
         .name       = "migration_mode",
         .args_type  = "mode:i",
         .params     = "mode",
         .help       = "Enables or disables migration mode\n",
         .cmd        = hmp_migrationmode,
+        .arch_bitmask = QEMU_ARCH_S390X,
     },
-#endif
 
 SRST
 ``migration_mode`` *mode*
diff --git a/stubs/meson.build b/stubs/meson.build
index 356d7800760..d4a6bc0dde4 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmds-hw-s390x.c'))
 endif
 
 if have_system or have_user
-- 
2.53.0

