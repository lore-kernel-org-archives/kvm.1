Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373045A2AF
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762064; cv=none; b=YyruhYsvOzPpp2Yhm/l/U4oa4Rlg8hvLtQk6oOwqYHXClwLbCB1MfiV/0Z8GiSd6KKyrv2QUuGTmD7mhs0D4sU2rdG2wTiDV1tsMo6Jusr2p9IAUTE5tZmY7vD2CLjvI+d+YR13T/ueEeFArxz8H2r67J+vfVNS6cd5edU/CX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762064; c=relaxed/simple;
	bh=V9qPB5Q4LeTwwvk34bhwRSUabO8T9Mew6hfZ0GpdBnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YTiCYWlTajsguVGbOyuXXmQmilgsXYMqLyI4F9FSZl5h4jOeq9O+bb2/doyoNeH1I+b8AHIoYuaAZd9wMocmXVs6Xm7F951HMv6qmxlCumLk11ByBS5fiJkvUOYorXIfIlP6iwdJIWeva315DQyQXaa2UWC+Dvo0JgY8CXNsDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQ7/rICu; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQ7/rICu"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccafc5e82cso539515ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762061; x=1785366861; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yww/CCbtIflA6zUbBX2detwduDGeaD8MIEWbRdLgMx8=;
        b=MQ7/rICuZ5tevD/do6XilgmMUwtue9mAcDsPWPUzN7rV/SRPMDD/yJeTMTrIkG5yDD
         QdrVp4wRHcDV3wBHs/cC75JCv5d0wytIvAAs5L+bZa/v86D2BItA6XJkx/ifJsI3BmL2
         wfDPNdiHhET+r0KOi3qwE9f2oMDsGWY/Jdj2d4MXYzzGQ0pAcdMhmU0s1ov/u86Ln73J
         Wn7wLoqWPo3UyzdHFe87SPhv/fDiRJTZ7+BYzdM8KUbvJmw499HhSosOVSkjvSnqJlph
         Tm+Cq0HH9CYvKcNMt0LUhSjcHtpI7o89oMAXcr16y1MSJX2gDl2TMhe3BYOolNdh3FFC
         FS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762061; x=1785366861;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yww/CCbtIflA6zUbBX2detwduDGeaD8MIEWbRdLgMx8=;
        b=NFoVIIqqOfFdzNbv1o4T9Ei1IlAGiovlqRnG4Ci4fWqrDrGGnbGOAr/3CT9v+5GVI+
         QQkgaZpGar6rlIqmD1K+j2d+FoZLi7mtdfRJwp5sZZyTblb475ECw6ChbCLMLT/YoD1M
         j/12U4TPGkHiB5E4QO2ubiOcUlIsG30LPfGTT8iGSnStoEBzDvrZND9HzGwvbyl7pfUm
         TaajxwQ83RWBqtf7oM+rRw3ttWk02i1yNz4oNqhHNsmJBkCWoC+gTharYt+HB3wyZNNp
         Izejkeng6KHZsa8nAIpi2BkqQzIx2Bgm5hON4BBEGHAtPxzy+X8/UAfoO5KMixQ87Eeo
         4szA==
X-Forwarded-Encrypted: i=1; AHgh+RokSgdOIlAcaRuniuyzJdz/uefJiORnEG2mgLTyq+OrstXj+hsg84X7Fups77gnIi6WlN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4i3oRddWpZU97mhBX60AyX4rnJ1PWEQyrJsC2fM+rTR3JGCg
	9nG5Owjlc1p+XjW3EsA0+BWz5rR3C6p65IQ950p+O5GvYj6M2XyHxt+bImKNS9nl/xWN2ggGU0W
	pplS2/w==
X-Received: from plnf15.prod.google.com ([2002:a17:903:1a6f:b0:2ce:9b49:d497])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2282:b0:2c9:c083:cd50
 with SMTP id d9443c01a7336-2cfa6b799eamr10224075ad.17.1784762061199; Wed, 22
 Jul 2026 16:14:21 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:10 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=1838;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=iBqKDnsWg3oJX07267DkscrYgDO1smB3E8LEOAOLwOM=; b=Eoo9zVSr1brvaXAAlLApyWhjCV/awTaposcKMi9eCntr2ggtwIKJiEjKuGir3mLOZ4sBhl9vE
 GprFiY/y/m7BBdR+gvsyOWCgXotCwSuYxjNlbN0yhmUn0oEjnUD3Yhg
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-5-15ad654a50db@google.com>
Subject: [PATCH v14 05/22] KVM: selftests: Expose segment definitions to
 assembly files
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

Move kernel segment definitions to a separate file which can be included
from assembly files.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
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
index 7d23344854cc..97acc5aaf7b7 100644
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
2.55.0.229.g6434b31f56-goog

