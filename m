Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD0364E87
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850980; cv=none; b=O3Hbm7LH5T0U5Dwdjv4uP+ApprNVsf3hhdPdmpy/s2HpYB1Bj4d04BQo/LBgcGFmLi2Wj3AKelP2SMv7AKEu7Y3ryRB1SiutfRIYMf5dpr0eHNrF72JPVg/55BPeAepw7hHIavPUiuMWo6oyBJ/tCUCF7Y0qqj6rUfC5bPpGYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850980; c=relaxed/simple;
	bh=JoD8sCmif0r5gKtkSs9z0M5LNibJf9A3pg36bs0oOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6PJZ7Bj+8a0v4lidKhUraQ/XvmKkFXLhpXHoppr1Cm86uvEYlRhqrYi9Qz5WpsqHzvaltjGoWheB/cO4kg0QrT5mQnKwyCl/rAWGJF2kDtoWYZbhuhYhNPv3wEtgDLhWP4cw2OL8rhqz+k1BuQdo40NSE1n2SynkBOPs136cqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CBL2UFMC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CBL2UFMC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b8efed61so22044625e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850978; x=1776455778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow/eQWa3P4KDoGEVMogN/Isn8lewWO8ymg/RYy5QKo0=;
        b=CBL2UFMCkQ1Bh0M+IDz9PX6/czMk/Wq+BMwfcjt46rQtQlPZXdMUt0sL4F+Mf83u8/
         WxKX1+CgHk2ZNhYuyq3AgelXNB58p29MrEDzh1wfWAXc+iOrFJ0sk1TGJFgCIwv0JJ9K
         GWKlD6PzysdR1hsLYB3rZ8HqjQbSfzSEbFJ8fwlQT5cBPmDHboDoYxZIJFsAkSvO474H
         mKa4RcjSrYxcLXb4eAeKWmWZJaEHmcIXxdu4/4zdUO0F1s/7cVNAIfYqHdCKyXJFoWDK
         l8FTeZ65TKLXOTShRCfH+m4/0BCSD05TI7w2FWMq4MWS35g6kKRP722wkgQxAgvOGgW5
         5u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850978; x=1776455778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ow/eQWa3P4KDoGEVMogN/Isn8lewWO8ymg/RYy5QKo0=;
        b=f+cK07EtwDG8RST7FNf8FsbwRFALiKv7Z4oeM4x/yhF4OL3FIXE0iNmtc+3yek8Ahz
         Oa8V18J+vXx11s1AohDvnzTtG3phWHvQHOIO/wBl6VlvHiqWe1GwufhJFH9SaUgt7zY2
         ndUcLBo9mj0LmkMhHxkvpU7Tlg/WCTRrquTD4w81UlNlse7atDSibrnX+imW96dUNlmo
         G9xkFF4/Bo9NFRoVOaWV7ZWvoJ1RlqoILMwr1X5nO5JRk+7AZHqvPLJSb9lWMa88532s
         x2fOf1vCwh2z/h1eGNZnBwtvcFub0bKtKRe3hHCco8baSckY4iz9cGfW3w41DriegOpv
         WEig==
X-Forwarded-Encrypted: i=1; AJvYcCWAsTuHnu1ES+NzDRfToMnMdka4GrQ5JujQQwuQ/9UIBMn6Cw9LwMIA+z3Nfjp6XTRgzxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6EG3bdJXKjwHgFLu3oLF3LAacphKpHTMCvAOEX2EIwVIqIor
	pY/XqJ6Hnmc5d/U0wP8EDolyyAlyAVRamiruM7anyGcSmrI6vQrmV0xx4efHPfhGtg4=
X-Gm-Gg: AeBDievgpFjARlINJyJj2DXs2ZFtwPWl9XLJrtmVXln1qtiQ7nbMRXyNhzYxtqVkehr
	cjC0Oy8UD+cnfzbXAbyD0jKKd8HD215UT9bZUpg8oZKdKvZFEA74K4qzlFjC9lUTg8do4FdywHz
	ivNN9TZlKh/KrUykeDpEP5dxXkzG8OFOYGr5croY+DbI/Mpkve0fKePvuG+1kl51LLgBRxHiZfj
	eHr/cc/cGbiUOBeXZ9wTbutG2F8KyUTwDt3jB9PmufRBVPm6Ez1dopL9WHLTva/sEQOfzPAjyV1
	a+ufvelwYZMBAU3J6XpnaV2PfWGLTNE1SS5EEgsnMLrhB97xMjoHQb+hiXEjp5f24zVwiNM+/1Y
	7HwtFvSgMfa029XqK1KDmPdMwovrRUFLNYyGrf9iR+C/MHvSpZtPIASsVnjp/COd6thKzeqow/H
	hD14UkQpS+WaH1VUaxl3hRhPqB88WTy7NuIKMtXtgO6HN3YrR0L9phVwyMEV1r9H9qf9AA9obTG
	XMEMq+JDTI=
X-Received: by 2002:a7b:cd05:0:b0:488:a9c3:44a3 with SMTP id 5b1f17b1804b1-488cd4f463dmr84378015e9.2.1775850977577;
        Fri, 10 Apr 2026 12:56:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm10026977f8f.33.2026.04.10.12.56.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:17 -0700 (PDT)
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
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 24/27] monitor: Do not check TARGET_I386 to build 'info sev' command
Date: Fri, 10 Apr 2026 21:53:18 +0200
Message-ID: <20260410195323.17937-25-philmd@linaro.org>
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SEV definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                   |  1 +
 stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
 target/i386/sev-system-stub.c |  5 -----
 hmp-commands-info.hx          |  3 +--
 stubs/meson.build             |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_sev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 31e973fdeb0..5dcd24a8a89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,6 +515,7 @@ S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
 F: hw/i386/sgx*
+F: stubs/hmp-cmd-info_sev.c
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/stubs/hmp-cmd-info_sev.c b/stubs/hmp-cmd-info_sev.c
new file mode 100644
index 00000000000..f3624423a33
--- /dev/null
+++ b/stubs/hmp-cmd-info_sev.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sev' stub (CONFIG_SEV)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SEV is not available in this QEMU\n");
+}
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index f799a338d60..d97536cca1c 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -31,11 +31,6 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     g_assert_not_reached();
 }
 
-void hmp_info_sev(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SEV is not available in this QEMU\n");
-}
-
 void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
 {
 }
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index da9fdc0ab7b..336ab870a2c 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -812,15 +812,14 @@ SRST
     enabled) memory in bytes.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sev",
         .args_type  = "",
         .params     = "",
         .help       = "show SEV information",
         .cmd        = hmp_info_sev,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sev``
diff --git a/stubs/meson.build b/stubs/meson.build
index dc289e3a482..09e73ef8b73 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -84,6 +84,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0

