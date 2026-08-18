Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69237C93F
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085885; cv=none; b=p+6QLkIaD+SeeNFVmRjaQOu4ghgb+nLtQi2uJWruY/QHHijGHjAF+V3Dm49ngZ+hw9Om2Ctb6Jip+hgMgUVNaH7FSy8J41s81G28cVsWdIeOHX5kxajpgZRakUAqSDnwCialmsg9ScI0Jn9HepT1ZVfqxX63347lnMQa+X4SluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085885; c=relaxed/simple;
	bh=1raa8r7p0aYRxu/KirPLwQYDnggKiHKGdcVN4goFT+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=es5vQtnDK1BMNyRsvUSzEDvjpz7SxCBYqZKknPU0JP1TfQ62qJQ1AHM+fGOocEzzJ1V2IdyobiUtD5Rux2paigtTnWI8FNOFtyt7kLXNcHuAHrfBCunvpaVGFKLlMTJLJzFAbazv5lI6Z3jzpgmNKoOoPEx8UDStCgQkOlV4yUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fR5mNxro; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackyli.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fR5mNxro"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e048a801dso420676b3a.3
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787085883; x=1787690683; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08nTZ8BlEZVF2fG/KvaQ5nP1tNkYkFgXiPifhkCCDBg=;
        b=fR5mNxro6sBwOZ9ZcyVtmVzMaUkHdx8PKJXubt4wSiNgxs0/S3vrOcaQ+yim+REfqW
         B83eStDQcz5cFHBIqWgH8FuEsHWPGwMk4PV6OcUg55IE1QoGW/ZMo/uoA2ncbWEREqGq
         HwX+1OgLmQt4/Ruc3SyTbJk44niaNUr3+Ba6pE71TpxtZ/ytqDdcGDZ/QDnRxH9JYpSN
         sy2NVgIW0KUJCNzaTtP9VxhUfuPeQA6AHAI3mcub5iaEhir1lc80niGVgGSCbZPuTS04
         ia8mScsuuTCWRhIScsz69s12a8TuRp2vLKfkohZkznYw/J25jELQdAGH0eYehHjy0Vc5
         96JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787085883; x=1787690683;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08nTZ8BlEZVF2fG/KvaQ5nP1tNkYkFgXiPifhkCCDBg=;
        b=PMUGHIBYw5JWAF58nuyUYLIuMn4yiQFULtJevRvsbY4PRnqd++e3JmhoV3bP3RgDjZ
         sYvMRV/j/ZO7JilrTI+QlwWdghOkM9Wehw0SJLMdZ625kiAVZ5GWXjw0b+yn4tkkGa3f
         ijpZxewOwShLfOdk6Y/svK9K/fD5GML/0YhXI6sLtxWvf4WavBRwfiCUr90HluP6K3d8
         863k63Ww8Rzi6rvTWb82aNBIVJYe3qNvir2m9EuqGHqPARCxdgduvyE+x4bxSPK9RiE/
         fTJ6NLsuvM5CF8ksmwUcKG0KYve+qoLMXY74NOGkMdx8/8OvQOSRov5ZWwOxYeuuoAaG
         q05g==
X-Forwarded-Encrypted: i=1; AHgh+Rqvkqmun43zlmCoHaQR+MyEPJ2dp2RSlhlXZLNsSsXrn3DC5TQdHly8+pdAwd7X5uu7kpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQq2702RWafq2ChiRC+A50Of3y3HFpTSeR2bRUWiHzqsXL+0O3
	usLpNCNCvIDGA9NgpoiBe6nnDj9b0YuuoJBObI85svaOMa6VHOF5KFdOPV79ab9oBVXZLRa0tev
	veuQMqay/
X-Received: from pfnv20.prod.google.com ([2002:aa7:8514:0:b0:84b:57b7:60c5])
 (user=jackyli job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4094:b0:848:4859:a45
 with SMTP id d2e1a72fcca58-851cd954427mr1821986b3a.2.1787085883244; Tue, 18
 Aug 2026 13:44:43 -0700 (PDT)
Date: Tue, 18 Aug 2026 20:44:15 +0000
In-Reply-To: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260818-feature-pkey-dev-v1-1-8c0ef96a4da9@google.com>
Subject: [RFC PATCH 1/6] x86: Introduce basic PKRU hardware wrappers
From: Jacky Li <jackyli@google.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"=?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=" <philmd@mailo.com>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>, Jacky Li <jackyli@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce basic hardware instruction wrappers and helper functions for
interacting with x86 Protection Keys for Userspace (PKRU / MPK) in QEMU.

Signed-off-by: Jacky Li <jackyli@google.com>
---
 MAINTAINERS |  1 +
 util/pkey.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b51f5c3e60..5a31c45963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -156,6 +156,7 @@ F: target/i386/meson.build
 F: tools/i386/
 F: tests/functional/i386/
 F: tests/functional/x86_64/
+F: util/pkey.c
 
 X86 VM file descriptor change on reset test
 M: Ani Sinha <anisinha@redhat.com>
diff --git a/util/pkey.c b/util/pkey.c
new file mode 100644
index 0000000000..4f14a72151
--- /dev/null
+++ b/util/pkey.c
@@ -0,0 +1,96 @@
+/*
+ * QEMU guest memory protection key helpers
+ *
+ * Copyright (c) 2026 Google LLC
+ *
+ * Author:
+ *  Jacky Li <jackyli@google.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/cpu-common.h"
+#include "qemu/error-report.h"
+
+#if defined(HOST_X86_64) && defined(CONFIG_LINUX)
+#include <asm/unistd.h>
+#include <cpuid.h>
+#include <immintrin.h>
+#include <linux/kvm.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+
+#include "qemu/atomic.h"
+
+#ifndef PR_SET_SPECULATION_CTRL
+#define PR_SET_SPECULATION_CTRL 53
+#endif
+#ifndef PR_SPEC_INDIRECT_BRANCH
+#define PR_SPEC_INDIRECT_BRANCH 1
+#endif
+#ifndef PR_SPEC_DISABLE
+#define PR_SPEC_DISABLE (1UL << 2)
+#endif
+
+#ifndef PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS 0x1
+#endif
+
+/* Each protection key occupies exactly 2 bits in the PKRU register. */
+#define BITS_PER_KEY 2
+/* The mask used to extract/write the 2-bit permission flags. */
+#define KEY_MASK 3U
+/* Max protection keys supported on x86_64 */
+#define KEY_COUNT 16
+
+static inline __attribute__((target("pku"), always_inline))
+uint32_t rdpkru(void)
+{
+    return _rdpkru_u32();
+}
+
+static inline __attribute__((target("pku"), always_inline)) void wrpkru(
+        uint32_t pkru)
+{
+    _wrpkru(pkru);
+}
+
+static inline __attribute__((target("pku"), always_inline)) int inline_pkey_get(
+        int pkey)
+{
+    uint32_t pkru = rdpkru();
+    return (pkru >> (pkey * BITS_PER_KEY)) & KEY_MASK;
+}
+
+static inline __attribute__((target("pku"), always_inline)) void
+inline_pkey_set(int pkey, unsigned int access_rights)
+{
+    uint32_t pkru = rdpkru();
+    pkru &= ~(KEY_MASK << (pkey * BITS_PER_KEY));
+    pkru |= ((access_rights & KEY_MASK) << (pkey * BITS_PER_KEY));
+    wrpkru(pkru);
+}
+
+static inline __attribute__((always_inline)) intptr_t local_syscall3(
+        intptr_t num, intptr_t arg1, intptr_t arg2, intptr_t arg3)
+{
+    intptr_t ret = num;
+    asm volatile("syscall\n"
+               : "+a"(ret)
+               : "D"(arg1), "S"(arg2), "d"(arg3)
+               : "rcx", "r11", "memory");
+    return ret;
+}
+
+#else
+/* Dummy implementations for all other configurations (non-x86_64 Linux, */
+/* Windows, macOS, etc.) */
+#if defined(CONFIG_LINUX)
+#include <linux/kvm.h>
+#include <sys/ioctl.h>
+#endif
+#endif

-- 
2.55.0.737.g08866a6d13-goog

