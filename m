Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702023909F
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126694; cv=none; b=gMdcvP2hi39/4XdeEGidnuIxFhD95LnjRxEXCeqYQ0+VaNhkKgE8re4SpoTiro5wvc3JXN1dJoTWQVZgT/tUlgNXdrW0naXM2omISl34yXvAjw/oqvb0s9pL53ZNiMUkKh3zvaEAKOd7cyejqVDCPqsIwd3UBF5b77V53EVZ7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126694; c=relaxed/simple;
	bh=IQIHMsO+G8mRbfLphIahWVHp6GFluzV99090S7ijM/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX09zLaBw1kHMdj0W7W91ntupHwSrWnWDZRM8n/Tdg/jy02QXHkidMZ8sV5p2WsZ4rdqmxUpunsXtx5jHL0ADsFH516snNtTwuQxiDZVmYa1wCBrdpdAclAXI8dP0F+zPTwNGBF7iELwhsLNooxDKdH8qSn05sHKrkW3XvX3mn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eL8GapsT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eL8GapsT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48896199cbaso53437895e9.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 17:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776126692; x=1776731492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt+4kyReD5cZ8XMM2eCoJcAo0IpKXrafGm4URfy/RPM=;
        b=eL8GapsTEdHhgW3LInbIc9VBDfw6twRtmSviglfg20tlrgIHreeFGDJnuy/pR6D1Nz
         VlsVOwCG+IIUQnWm8qggzDLK6GfpkaoEjwFxJ5T6mX85B8babHJVulVb+AMoPvzvoQY3
         yVGlmLkkh+2pVqft93N3Jp9emrYGPOqEiitz9chfF3UruZBHlp3UlJhTxHny81PJIH7A
         vxJ25YsaO8P3eubbPlzoYeYx6WItFUGyCmTEMAj/m3i+YzeuIdCxTQBLUPBobHS2jDki
         3A11JsUK/RTJU10GN+gatbk5dImLSI/9ZwPx1/qBmY0x9/qHMOJC3w32e0P0Omf3OX02
         OPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776126692; x=1776731492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bt+4kyReD5cZ8XMM2eCoJcAo0IpKXrafGm4URfy/RPM=;
        b=TH09azAHzhEZrfGNOpFhyBEKgwefNOKrahryyzO1zgcnbouHlRaaBlKwV/NtBJfAIG
         ghEsh6m56HnMw2svRraHLviPkuweKF9T/B1jT3U2itNrgl9A/O8fsNeBt/Pl2ueqRhXp
         uhgJtkPJkZVcN8d6174Xd4NvNV+5X8uGaIlEWxs81uZ4W5p3he45MEx8+/4YB9j5oUsG
         eok8MYk0D9+a4SPjQIog2jH01A/4QN/thDp7Om20RAHe6jg36p4vhykJaTrg0wE6/HY6
         b9qtXPiA0AChLrZKPKbYm+u67nTYIU1iwtJdqmmHfA1fN71l7YK9aL4xcxa+m1obYMt5
         XzHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/iTmkCNDP2Q7QpD61QO5BWZjKAcbUjW/nvTqc3o0qmao6RJtd1a2irnbigVu3V7TgJ3OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbnIC72gqsFJnnyy/+/ehetrCsdrsNxeMwN4KYcMAciMTtI6Im
	NHbzwRvf3Rai9EusqnRYZ2jPhnGFRSvAdbUysqndAmACfIl4tuj+C4qQCY0+HmpSzGU=
X-Gm-Gg: AeBDieugr6gBj+V/LYiqHI7ifZJqihVghF8NDBnXQ7tAAMPpj3pP8JOO+LHIe6ylOge
	KRbrjnh5xpNHPTOcCMMZZmyOOJYqXve6ilHtFR73xE2k786UyfVE8NLqpblrFimb8KjYymkGNSN
	EI/J7xn4wreZefR+qG76hwukLU/BWW4OeBp5oyt/5YL84ZMv1sEvz2LXFgGvBY949bcshSPwFf4
	oVcHVs7K2yAX/XjA7LwruBtYuPHNUDec7v3Yv3la51BWmGphMjZNt34fngXt1K3AxoBN1PDBikE
	tqO3c0fTBCkTy1aRm5/Wb50ieHEZI+bpiEylz5djusOJJA2a+/O8gZaNdGeqnUzq77rKeY2EYOA
	EHjhXwVpp9f3Pv/6/HylDcz9Dn1X1WV7B/tchB7KN34A/yGWGQnXXLV9PA0Z+761DQZ3mezMaX4
	mmcYo/7hZq6IuHRwU7LaIH+OzbinaitDBoYoRF41Th3wT1Y1oApedIajezZGsbIPkKGByIT/92
X-Received: by 2002:a05:600c:64c4:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-488d686c04fmr187577555e9.21.1776126691684;
        Mon, 13 Apr 2026 17:31:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm12018185e9.6.2026.04.13.17.31.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 17:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	kvm@vger.kernel.org
Subject: [PATCH v3 12/27] monitor: Do not check TARGET_I386 to build 'info sev' command
Date: Tue, 14 Apr 2026 02:29:44 +0200
Message-ID: <20260414003001.97571-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                   |  1 +
 stubs/hmp-cmd-info_sev.c      | 16 ++++++++++++++++
 target/i386/sev-system-stub.c |  5 -----
 hmp-commands-info.hx          |  3 +--
 stubs/meson.build             |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_sev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 16a3d71af02..580a80ab254 100644
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
index fb84aee94d2..2ea85597cf9 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -32,11 +32,6 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
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
index 4d1a803c17c..4a1d687a111 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0

