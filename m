Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699737F723
	for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850973; cv=none; b=ZYOdVEbHIaRALrRi+EeQxwQhlLGhu6bJbxChHHK0KpbTtjjpZGzcGvwVvRPsBAMZGWh0Ckb7PKzA4YdkdMqMwqdAeMPtVQKWpNGuJuQ51Gg0E8iTokigA3YWtSehSb6sf50uz6HMjQZXQDXpSC6kkbWlwaKK3F91wQRhSOqQmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850973; c=relaxed/simple;
	bh=DtrsUieVBspiNJtg6Ff5y9XGC3dvqOD+5G7m5OVIvt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/cIsaZclWUqtdUw62Un5RSHMuUxZel89PsyIU9SdG3KgdJTLDxalTlqsgPU5JrZFXBQpslDTsaIGBD2dTMpjlRBksd8K7ZNwZo4WShJnoC0Bl7qXFXm9r1Xrwr1SgIYTqEZBl8oVOISFKWa4iOeJlTEanh2oWsLCmI7JAMPMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQNLn8eP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQNLn8eP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0046078so24119795e9.1
        for <kvm@vger.kernel.org>; Fri, 10 Apr 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775850971; x=1776455771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C78IbPBsz6cVs2Ym43RKAMokAYox7chDUSzKqZO66SU=;
        b=hQNLn8ePXmk7gK6JwM1nuHI/h8IOHs2stq0BsTcb0ttPvKO6OUrXSPmxhDizNVMWGg
         0Vtd+ZMayR153BS6osoU1EU+QxyuvaQOWY3P0UOR1pXU7ZMuQiPsoNxx2DmXmeOF0Qc/
         YI6ZmbC9kofW/YrYsidGYHAtN5zwU+CdsPnvXkaZV2VVF9DNsd3St90Kn+E5UUn3eDXl
         H+e6lJqdzDyG778HUpQzSX53v4j8V+fccA+kJLMp67Y4Nm+loUDZCIvtoEkLY8p7dN/6
         csZDmhRxfrtByT5pVJJjdVEnjLGyvpjYFJlCvAwibAOqNgmv4/DYsDX/tuLWc6yeMc0y
         GZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775850971; x=1776455771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C78IbPBsz6cVs2Ym43RKAMokAYox7chDUSzKqZO66SU=;
        b=X8W3Z0rmrtQ0+JLMByfNi/Ngb0HGeDl79TCmlhPA2GTWXSBS4imRtV92hDyVErMGiI
         ABm1ybEnBjdYP5TKgkcTlIyqSa0JSHlkRLJxCj0hT7gYzwbJTV2obYC0ks3FwpzddrWn
         ja1ItUy6eMQTLZ34+e8FQ6KtGpGFqyfsBeUHsTHQCTO4MYhxdf0CZYA3wm+EfkDMa2kC
         gNw0GwnqwaiFP/shZVOTZZ+QyXYg3qfaKKmx6PiBNzc2CLvJtcO+/47NZvtBgRfX3t+L
         W6xKi91gWp/2/6mLxUhMJ61gwLYI54lOyPqU0Pr+YYzWrvzJdDRaVNDVF9PHm/jxBxE/
         vQSw==
X-Forwarded-Encrypted: i=1; AJvYcCWm+1XA8/PE3hJW6XMZY81o9Lcx2P9PlytT/keucvmvv6+szYTe72RRpkaQ/viL07pMyCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFE8OzOkndZRnmzwH33dFYZB20GUulVudWcOrtJpLCQOluUais
	WwHkm81KKwZofk+4BQ1jx1FBqEU3MMPem1Wgj4AWvFR0B3+29qaBw9quXDWH//q17nY=
X-Gm-Gg: AeBDieuybzP5A7GhRRun2to1BTfR1pc3agZ1HH5KCTqiJbV80IEK1YYK4wqgsx/Asqk
	MUsn0DJVcpGY7+8IBJnPmHAKS1D5EUCXyCFjN2ax1xCTviPVwiSAOvZBJmYjdKL9l88w3ppG+TL
	Q9xDFfVSOJPPGElB4zj+Y7BST72vtfaoVjaCW0jqoYjNZuPoJ9kIH0OBjbkm4YTAaNKQLQaUEq5
	btWKYXjaIznrQA0wFGZKZuPvx/y8GLLzfGhIZYLOPGIqBqcEB7MqIEbDrIPU9+m0FDWwQdW/JtS
	4wm+SU6HP6S6X8rCheNcjLLcr34mdixHWyh+grXw4q+vg0/XI8Hh416utIybEctfTkIOnpl4IC1
	HoLF7IPOYCcCbAL9qkhUMLMsfH7fzwOnw6lsmvd+Gkv8L3cZ2tRCqYJ1ODr3BU/Oiuz9YnSOoZt
	85yyLzvz1xaa8uSVSO3vHBBA8h+X492lXFxHNy+F1IzYnjRdfVvFte+EsS6pPf7bg6VItlD0TX
X-Received: by 2002:a05:600c:45c9:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488d689cf9emr52390385e9.29.1775850970618;
        Fri, 10 Apr 2026 12:56:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d531f2b6sm106301525e9.2.2026.04.10.12.56.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Apr 2026 12:56:10 -0700 (PDT)
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
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 23/27] monitor: Do not check TARGET_I386 to build 'info sgx' command
Date: Fri, 10 Apr 2026 21:53:17 +0200
Message-ID: <20260410195323.17937-24-philmd@linaro.org>
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

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 458951bc051..31e973fdeb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,6 +514,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/sgx*
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
new file mode 100644
index 00000000000..cf1d9a6344b
--- /dev/null
+++ b/hw/i386/sgx-hmp-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sgx' stub (CONFIG_SGX)
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
+void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SGX is not available in this QEMU\n");
+}
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 6e82773a86d..59d58926311 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -22,11 +22,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
     return NULL;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SGX is not available in this QEMU\n");
-}
-
 void pc_machine_init_sgx_epc(PCMachineState *pcms)
 {
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b575e4ac993..da9fdc0ab7b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -866,15 +866,14 @@ SRST
     Display the vcpu dirty page limit information.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sgx",
         .args_type  = "",
         .params     = "",
         .help       = "show intel SGX information",
         .cmd        = hmp_info_sgx,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sgx``
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..b611fbb5a7f 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+stub_ss.add(files('sgx-hmp-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.53.0

