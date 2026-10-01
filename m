Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF651C35A
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883528; cv=none; b=L6D11A3zPLyR5dGI+j2GfbWlJuQ4TvD7qTzF8mLL0/u41CTa6Rz7Lx3HC+0QpqVnlTMJly9kU5K2nEUBF24EooQVHQ8wOVfmqjgD5Y/5+qgc7dIP26pO92xydV5XTvrIsHhq1m87q9za0nsBafMd2vBkUZHGwI1BBHB4Q8GDwlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883528; c=relaxed/simple;
	bh=zp0fCXEEXhwkdiJK13QWS3aC86M9pq8mXqRQKAIXcDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nijg2QzQTIzNTyYxvR4Teunso6r/fh7c+S+pG04klnD2X1199a8rpN98x+o5nwLj4E86gj35hrICOydcIR6U1/s5EjaKp4/cVyL+l6Rw7QOBFFSPRjIsPi5UytyWxkauTu+0SSdSmq2iQgFw5WGRQGKx8Uwk6wkwYO/cUSo9324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bra8MQFO; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bra8MQFO"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e2dc7312e5so21782865ad.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883526; x=1791488326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/NoryhY8HfDhtfJWA4MzZfEK4rb7jcSVHQTgNWX/UM=;
        b=Bra8MQFO/FiTdmxFqkuw5u8AADlCNejLpXq/GO+MJWswmeuw0yqMCrgDdmQ2fukw7P
         N3dualua0bqpPNS9/yHcy3caXR7YdVK+StMYAJ+XRCTwcNzM9sSs8rSfUVbNJyTAMbeS
         pO6Dw3cspXZB5V8XKO22qbDta8Taiz/1B22875HN3CpYZjmgTMywu4aULpGE2D1+5WmT
         LNqOUEwyIUbloWso0Eh/QjkkE4TmrTJkgTvfalbZx75nC3M9S+uDvmjsfNFriSx2sC1Y
         CP4z3OkJ6PKRj0qJ/QNTLSOc50euKIHWy/xbPzDHxhu3177ARUNEcASSfKlz7S6C9yoI
         DOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883526; x=1791488326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U/NoryhY8HfDhtfJWA4MzZfEK4rb7jcSVHQTgNWX/UM=;
        b=Qf0yTWAp0d9dabYOSMbnxwC62ZVWbQjqUwjzm4fd4H+SiMntZiX5otPvQyQYff9c0o
         h9wC5Xqhdp8P3la25ICskUxG2baeL6q7f54UIOroFwn8o9KLLujcQroezHz0OxuUWl6U
         t0pxVE8QBLoagUZszjVyJ1gfyNwIhTCXdF6pAPJsmIqaGG9szwBB3bNVEeGgN4NSUuNz
         Eium/x/TYvsyQjM6EOTEJ/vEZKCMKMYRL8cGVDz/OD7sS2dfmOcMFe79o8ZfDpj6VkzF
         3Gg7WnBwM41uBQ4/MdHKiYatIuacA8G5VQU+p25xbH6ndAo1lahcZQ1XnWvy2287P7Qj
         u1pw==
X-Forwarded-Encrypted: i=1; AKwUvBwyWlh+TTmGzr0vbI3tAbHlnuIQFVmOozb2XtyXyzfP9TjmHPMLOld8eyvZ1631OrUFGac=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqeWCiRQ8Uc/J/XQ+7IM/ZBQZCPdikhtARHmwuPs52gj3EVkHZ
	zbZJKn7kACHanZArzQ5D306ZHNySbgJVXO2PmYqie15eLPC4fMIN2TLHhMLE/bd27QYA73x646q
	UgwtTsA==
X-Received: from pjnq4.prod.google.com ([2002:a17:90a:8704:b0:3a6:c7ae:6dd9])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44c:b0:3a4:e013:8768
 with SMTP id 98e67ed59e1d1-3a6ceb1b22dmr485911a91.45.1790883525538; Thu, 01
 Oct 2026 12:38:45 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:31 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=1878;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=JAF4AonfKOce2MPkEm+6H47o5hzM1UYJCFnc5WFeYP8=; b=DztLG+OxqhK/sRaaOkaqQqgPibtyctWSl8J8kXdEMwYHg5RjZIo9FjVbn/6aPjylEB/+7+w3w
 kBaLg6DuipIDI6IBKsYm1AdVsAInVjZDqMT90f8ik2KB++RcTL156uM
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-4-7c62a5d8a992@google.com>
Subject: [PATCH v15 04/23] KVM: selftests: Expose segment definitions to
 assembly files
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Extract kernel segment definitions into a separate header for assembly
files.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor_asm.h | 12 ++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c         |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor_asm.h b/tools/testing/selftests/kvm/include/x86/processor_asm.h
new file mode 100644
index 000000000000..713b6bc0aeb7
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/processor_asm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Used for storing defines used by both c and assembly code.
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_ASM_H
+#define SELFTEST_KVM_PROCESSOR_ASM_H
+
+#define KERNEL_CS	0x8
+#define KERNEL_DS	0x10
+#define KERNEL_TSS	0x18
+
+#endif  /* SELFTEST_KVM_PROCESSOR_ASM_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b87ba7d8538b..1944eb2489d8 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -8,6 +8,7 @@
 #include "kvm_util.h"
 #include "pmu.h"
 #include "processor.h"
+#include "processor_asm.h"
 #include "smm.h"
 #include "svm_util.h"
 #include "sev.h"
@@ -18,10 +19,6 @@
 #define NUM_INTERRUPTS 256
 #endif
 
-#define KERNEL_CS	0x8
-#define KERNEL_DS	0x10
-#define KERNEL_TSS	0x18
-
 gva_t exception_handlers;
 bool host_cpu_is_amd;
 bool host_cpu_is_intel;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

