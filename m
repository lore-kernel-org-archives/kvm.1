Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F1242D9D
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052831; cv=none; b=X87swUjlHhfuZr5/t+WCmrZzZA0Coxz8W/vsWnROdM4R2oduj0ZJwcp4YGeoJ5fj4YiD8Mx8ibR9rHYsQKpeeRD81syjsbdGIrVFISeqUPshQBThDm8zh6c59xwcIfywlA7vmOnu6v7DUF2dDqXFKI4lL6ipuZsUi6Aw5SYqLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052831; c=relaxed/simple;
	bh=zND3vvwQyaPgYriOhaRZZgPXLGs7NEXIBc9VDNPOrfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDGs1PK1YMzQxPOS0WJj8MrkgMXghnhtxLPHkFgLG3/BYcGhfrNi9RCvJg6X++MtlAPABgtWuotIXrg4xbk/+lizh2/kfENRt63+LwPY0fZAgdroVJEwuv/+y2ppT/tOiYp9Wfs2yecaH8t5pj+5EaMdCsj04dnsXFutzDcvXN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O6FCB+6v; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6FCB+6v"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8581f7723aso3546166a12.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052830; x=1781657630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=724RgwNGECYZAQrR7huttJyeJ2iqdlEoMMuWqlZB/zc=;
        b=O6FCB+6vsNr2DF7lR3C6Ac+hDVdNlwAy4h7nxJ5iHRCIOpKNGlAgWrvwUHpP1VRvSJ
         PjL+mKQZIJTnkrk1W8IyH+Y37EQnIZS+20ie1ZOaqAglfiKULWWaui+vHdBCm9AbQYUQ
         nVds6LJ2oQ9W0/oJ+CWg1A/4jHvO9xPkJgXSR//3nOnEt9c6y395Pv4iVDN6wa+A9Gsu
         aQFw8ULn5dit88wAVHD3nhX59mwjnuIEvi1uPvQ7yVUv4Vph4WPwX6NUXi0QvKSCJUPx
         JgDOyLzF0k4cAuVkjVr28o4f+Qra3zUrm86DjDivY0y7dNbKqpB7NvI9y/dDIyCzkrkq
         7Gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052830; x=1781657630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=724RgwNGECYZAQrR7huttJyeJ2iqdlEoMMuWqlZB/zc=;
        b=OgJ0zTOhtO0mkxfXJHIK9RcdenTsdL8Axrd381efvNxYfFwixhDuFPsHiAabFavKA1
         Az/C80CAEX6Dieo+fyq0zFLc6by0Eh+2PuvCek3UgLNIYk+svxByowCM/tHfUHyuhdix
         q33bOBSkxzDQ7ZFjrJMThIMVVY6wbYDoUWOHVDWxY/l6XX2iH++BkAdtAVEqRlxBTWkV
         d5M+NIHW20t2EAcu3n5fK3kziwGfAfaobsojkYxEiwuNkpxEIZ5oUt2ERpo7xEmx+QIa
         PwsfokccasAYDqPgyc039DEfFB4SWOaKdUnHu9q+/RNQM9z+AIF18LWj/4sixCn/09de
         3Y0w==
X-Forwarded-Encrypted: i=1; AFNElJ/fsNZ63w0DHaQT288aeifnXrk43dOqylCkh8GOcUZRFtZaZtLnDSNRI3plYuN9Aw4d+9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD6luryqMuindqylJOQ+g9aMnW82b4wmxzNNsy6cZf77Q+5tXb
	vZg2flK/WRrhtWxyPJzUt+AwIvlC7oS9+Bm/KvCaTrMOCIYq7Icv7H/2T/4/WbqEyYrHXEyfx+i
	AfXSzTQ==
X-Received: from pfw3.prod.google.com ([2002:a05:6a00:a263:b0:82f:4d28:b8c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4390:b0:82c:d7c4:4c57
 with SMTP id d2e1a72fcca58-842b0e73596mr23804989b3a.19.1781052829531; Tue, 09
 Jun 2026 17:53:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:26 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-7-seanjc@google.com>
Subject: [PATCH v6 06/18] KVM: selftests: Add helper to get host IRQ from
 device MSI-X for IRQ bypass test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Introduce proc_util.c and proc_util.h to house utility functions for
interacting with the proc filesystem.

Add vfio_msix_to_host_irq(), which parses /proc/interrupts, to get the host
Linux IRQ for a given VFIO device BDF and MSI-X vector.

This helper will be used by the eventfd IRQ test to print the host IRQ
number when triggering IRQs via VFIO device, e.g. to aid in debugging if
the test fails.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/include/proc_util.h |  9 +++++
 tools/testing/selftests/kvm/lib/proc_util.c   | 40 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 1339228cbf53..90a370ed99f2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -11,6 +11,7 @@ LIBKVM += lib/kvm_util.c
 LIBKVM += lib/lru_gen_util.c
 LIBKVM += lib/memstress.c
 LIBKVM += lib/guest_sprintf.c
+LIBKVM += lib/proc_util.c
 LIBKVM += lib/rbtree.c
 LIBKVM += lib/sparsebit.c
 LIBKVM += lib/test_util.c
diff --git a/tools/testing/selftests/kvm/include/proc_util.h b/tools/testing/selftests/kvm/include/proc_util.h
new file mode 100644
index 000000000000..704839b6d7af
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_PROC_UTIL_H
+#define SELFTEST_KVM_PROC_UTIL_H
+
+#include <stdint.h>
+
+unsigned int vfio_msix_to_host_irq(const char *vfio_device_bdf, int msix);
+
+#endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
new file mode 100644
index 000000000000..84d30f055a0a
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "proc_util.h"
+
+static FILE *open_proc_interrupts(void)
+{
+	FILE *fp;
+
+	fp = fopen("/proc/interrupts", "r");
+	TEST_ASSERT(fp, "fopen(/proc/interrupts) failed");
+
+	return fp;
+}
+
+unsigned int vfio_msix_to_host_irq(const char *device_bdf, int msix)
+{
+	char search_string[64];
+	char line[4096];
+	int irq = -1;
+	FILE *fp;
+
+	fp = open_proc_interrupts();
+
+	snprintf(search_string, sizeof(search_string), "vfio-msix[%d]", msix);
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, device_bdf) && strstr(line, search_string)) {
+			TEST_ASSERT_EQ(1, sscanf(line, "%d:", &irq));
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	TEST_ASSERT(irq != -1, "Failed to locate IRQ for %s %s", device_bdf,
+		    search_string);
+	return (unsigned int)irq;
+}
+
-- 
2.54.0.1099.g489fc7bff1-goog

