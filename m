Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E13C4567
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509749; cv=none; b=U9KTFRzI0Sfllldpd3LGDLVoFa0Mcu9Kt4W1HgLgfKnWYaBjoIWp9mI3kqpSbzGodh0qHgpj6EVi+4mMkXxKfLkhf9ZIx/EzJR46g76nWq3HN3x41Hc9y3YVZGu4TbMOaPvSpYvMUM0g/wpKe0duMg22fJLvbjZCzNU15QBGNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509749; c=relaxed/simple;
	bh=SROkhbh6/bZDK8vpbuJbeyr6/QiF+pI9lfh9kvOCqug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GPAcNTjTUPXuJV2gX/skxPZEPLAhpYOIJwkUC3q0nkL/TMqaOOClD8GBUyTUk+vAr+JBDTFmLtCoTM0JkM6Tv/XDOzbvio1/FypubNGp9Wg2DOSMt+9hCtwheUqOhl/ihFZmK8YDxV/rjiq0xmLi4miAJdJHhM95E01cAPTa2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Thz3Y5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Thz3Y5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-845bae98cdcso1117373b3a.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509746; x=1783114546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pnTbJ0qzupqs+OdQTBbFmTptoXz92YWWt6sTMLKlVlM=;
        b=G+Thz3Y5BV8uSy6t6rG6LYo78LZi1vALC/Kh7P3VkqXtC/t2NLZQOkKJUJvBK+/xdT
         NW6IEPw1+cNTueb4G1gZHVSRzjS6yyHWoIbtMO50Y8SolDAY1NEX9r2ZjpEC7yNGpsjD
         0N3JsgC7L5BN5gXJy5Bd7QKVc/fCkFzMaCw0xl0xzA1X2ysgyKLpQrJbFZAXfB8kyYYd
         zKH8afbP8pOv0Dz9B1lhNLG4bn6Z0uepea1sWlmxCP1j0tlb92gSsk1AdOmSXqB7TXFD
         sIpRKmYQUru+G6gKHEd2RoU3JOJShLQeIPieyQQSWjuFXdBHb3tOkdRRBVOq7bVXLaWs
         Rvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509746; x=1783114546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnTbJ0qzupqs+OdQTBbFmTptoXz92YWWt6sTMLKlVlM=;
        b=Hx17oGkm6fpTGLeuRiV35JjR5O5lXDyVOK6zUEb/BnCha2zE6a88p2avfoIWMjqmbe
         xhfgiM/Q212g6WONqPqp5jUaV46BBnJiDRINuXdbQFGj5If3TqVkUK5A9lnJGhTrR57g
         NyLWA5PgyCyC3BOSrtjvL1OsFO+dOI5SXUfguDPcU3+JXmYqf8nnKV7cFZ09jU6J3MRp
         e/4WE9d4OXWqXNhTzFJFikholRILpChGEQH+UQ3PVYuU0Th6/waKAg9M1UpIrKJeKK/4
         z/cBRgOI7GeDAeyuaOWnSBuG+/eB2FCtZeyBMF1bcfRCEfcy9vrAycF6T6xUZcGcrkpx
         HR/A==
X-Forwarded-Encrypted: i=1; AHgh+RqlFlPzBPiBweVhEjwlEP2Oj3dOOiC0Xl7Q3PtqYr1XIq4uamzg6wNYt7LxUcJX1yoGCtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yn+pxP3Iavr05D5ReNStNO9uVM9rlnwZ1QOawu3n7tjkzIsQ
	Mp5AbG2TDTgRX9j5OEYq0RUfI0Q/xp/ixdSYyGQ4dzIFnVgirD22ZPeAroDsVjx0d121GAjsOJj
	e9AjF7g==
X-Received: from pfbhx20.prod.google.com ([2002:a05:6a00:8994:b0:842:7548:51e8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:66c6:b0:845:ba0d:3e5c
 with SMTP id d2e1a72fcca58-845ba0d45cfmr6880920b3a.42.1782509746265; Fri, 26
 Jun 2026 14:35:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:21 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-9-seanjc@google.com>
Subject: [PATCH v8 08/20] KVM: selftests: Add helper to get host IRQ from
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
index a24875fada03..88c6c8046dde 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

