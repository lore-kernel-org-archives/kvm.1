Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B707156661
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126687; cv=none; b=ZmnBr6Bu5Vuy3LGRe6npGGS9sX/W1b8YEeORJr9ge+7eq9s2jSh6HjlYlXPHxUmPQsjmv5DTiCqUXIOoRZ1d503cNLYXEMGKOqjuUoyji90/m76+/cdo+h0lXcy4J7YlZ0hqcehIAhwKrAgk764MSwsuAXCBFsUUWIlLGw7x5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126687; c=relaxed/simple;
	bh=JXjbmeUBByFUK8np9cjkSqwMXlIjdUBBedsYzn170Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHwzpUeIpYe9WWtkfvYvJZYbcOM8+Bxa6ZDadL9AGexRQMuyFOCcRD84OeUzNw4664N1JhkVs+hBFQOXP036KyYMx8zjDL2kIyQ9//oyXvsYMVx8MaaBqtgLOpP+7eeduF4EK29hyAgMCz3GkaR/LDccn/2RxOwn/RwOFHS3fqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aUqzRDtj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aUqzRDtj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488971db0fdso49331055e9.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776126685; x=1776731485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gugBCWVY82uTJlbHhOJnHmVxWC9Bv2gRPQgW/p0QwY=;
        b=aUqzRDtjvgTo5EO8DHj7HkUxr90VWVNiHdXlONHRviokaLJbRn7AnJw4AtxzWek+0a
         zHbsgckbyh3pKgJe6MFQbV8mOgwh2LvjKSoB4+QI3N+wbjBNnD7MzLfPTi6K8DXRMmYB
         V8KA3rrU3KHkq896gwrXAF4BB51vYrwFx52CKQSmSnrN7up3Ap3I8m0ZMh856GiMKPf1
         ZKv4sK/p1LdUq8uhfR74xnDOZOUr3QdxG1CM+HsrU8lH/AUb9KrrjUsxlzvGO1Z1wmt9
         isNRm6TqSd5FNUNbEr/wRJ4RwSYel9A3oMqvxFcaEKolUDjJLmWMdTnvjAv2wxLjU1ZO
         0nTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776126685; x=1776731485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gugBCWVY82uTJlbHhOJnHmVxWC9Bv2gRPQgW/p0QwY=;
        b=H8oxxxqUDHZy9Rc0k9MTcUY6cDyPwE30kA7ULDQsrL0s5pG5q9805S+Ga94cOySvrd
         AoMGK63YqoA1aONe/6Qs0o9FT+sAMB8Y8rrBeQlBvxq4stIH+j1OOgIy2uOr9cbnA1jY
         Zt72JOZB9FkUcy/l0TPnaSZ4STtaDRns1dAt9FN7z0qEazOt3dceZZylAYjLOFpc8pjf
         /l7kGnr0Q206KJ/sL/PyBZMCcgONYgGBdgSUXpGsO8l8RIFlCwx2Ham7ckEPkZZdqPHo
         ILzr+YcrWZSrV7/YTrl0tzQyfBs5KVY7TQ8/Jtfs1VW7vPsLIsa+UoRobyo42JMYY5p1
         gEkw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZOloQLDniYHpHU6cOm4rfdU3HPUcQI59+oRaGviBTlj0xJ6YZFFntG5OEjcEC5rWyTqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxReZMiK2MQ0nh417+YqvML8onzoW/9wSHzHWxh+XDMJHccrHOu
	p0FQuARtBzwUnpy9LTCljnkDLosUzmRmlKFxgADDT19wV4jRx5bqwALkp7eTpvQ9kPQ=
X-Gm-Gg: AeBDiev6PyLV4llcxTOKZaznpIVEwvLKJqaVWt5FrOCFmceL6n5ircaRdraMuUxwXPJ
	itLJm03h4PbQqQ7vFv26FN90ZTYpeAAxh4nomK7+47kn99Sgz2tu+pX0oXYxVvK1xqU3T58wRzE
	X9qcj7Y4IvYyQ7irpfL8KhKQLnSdXj4cuWTgrTbOebHFdrXQleYyBsikfASwCNcNs4KGd3K74qB
	5Aj434OqvwapEXLccoTRWNVhwVFOT6qDDGsYfe04f4LETRVkUJ5swP8GyfxMT7ZoMPX5TZYRZ3p
	kK9fg1u9g1pTh1rdVGqOquYIOmeJGjeTeYp58zXaku/wp1+IbYeGdy3hzPqsPGW4uJ4XBarEd0S
	E7bF5IukukwlK3ERovEmJeSxVgpTP2sW/M6cd8os/2vDIrCjRVvdvf1yFekD2Lvbw+fwEmZ8e1q
	AAdWGxuxv6r6v9LxFuprZApFHK1c/LYu5w9I0mRceJZBmHFh+7qpItXTglIU/KkpJ3qPUuIa2d
X-Received: by 2002:a05:600c:5249:b0:485:7f02:afd5 with SMTP id 5b1f17b1804b1-488d680079bmr201952685e9.13.1776126684652;
        Mon, 13 Apr 2026 17:31:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee019d9bsm5975475e9.14.2026.04.13.17.31.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 17:31:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org
Subject: [PATCH v3 11/27] monitor: Do not check TARGET_I386 to build 'info sgx' command
Date: Tue, 14 Apr 2026 02:29:43 +0200
Message-ID: <20260414003001.97571-12-philmd@linaro.org>
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

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0c8f484163..16a3d71af02 100644
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
index 1dd8d9afbfa..2b083c77bc1 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -23,11 +23,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
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

