Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3569E34405B
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813383; cv=none; b=lhfxKZ1R23qgPR/AnTHgB3cP2AYF618mPRBENApQdUjlL9AyESTImMDfGXJ7vA7JCC8O182TaxzJR/7efYXltmX7KjYgc3gjFj1Z8iUHSoCRvsFOODRW/WCgtOETS/4Tuq76R2Jk85+4uae4u9AvmVhDfQ5RE0/i1fO/VNyl2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813383; c=relaxed/simple;
	bh=Fa5Z2b3AFmLW659rMLC6e+YsFIKYNkhhbhmajGAg4nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMyFbzHZlmN0c6YxScOJHcBkjhmDuN4ceJ4ioT3KgTq3MAaFQDIt4bjXrwaNY9Am+oRWdKi9j2IqcLCruOf6OnubOholJeT9tvpYGQbwEFSy4EKSOWZvqpybvuUnPz3G0i6EqfLLZeWnXnBUWqH3Ft62AoYMLIKjscnu9Jw5iwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uD/+xPdh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uD/+xPdh"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso2248085b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813382; x=1777418182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rO/sEyq9fOmOK5M/bH4lLglok4DGILopTeBk6BkE89o=;
        b=uD/+xPdhypYdxotlXFJ/U+5synkwswX801iTRPOTvCZD6wkqv+Oo0RxOe3Hj9IBEgm
         lai85CpRDf9XEYas6vLixY5URX/0KOCT07Mq1sUKHRylW3iTV0QkCgeBSbk0m0eOuO50
         19lMOCa/iD0RNohRpCu52KFHVV9htg8dtrNL2tlM7rc9P7n727rm4dkC5Xu8WeOprtKg
         wWG6RiZF/8OMRalpq30oHrinCJKHdNCE6f30COb4FZ3/NbofvgCOdQFoP21OrfqPdpAJ
         aNQJqdGknvUjsHKvavrmSN/4Yi3+kuY8nZFK2QJ2m5BjHdiVSbtv42120sciyC+zbI64
         zyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813382; x=1777418182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rO/sEyq9fOmOK5M/bH4lLglok4DGILopTeBk6BkE89o=;
        b=UBXCXY7FE8NjbnoBQ5w9W0HH/Dsnf7NVFf+5HznqCnreKERUhnsgIUigvWgQLdno0K
         VhGWDK5f7lqPdk/kJ+RGNCRrRR/sD+kBHVGT7dYVCxmXwR0FFGktg0hfWa+Q3VXG6uSS
         L8pjzj5EFZyqwTlea6Hm9UvZoWbnLmIwtS1+OvzxeQM+Hho2i0X6OEd2z4ftygvS9tA6
         SdyJURzVelxdiNc8XZvR/driqingg3ixsr75dkxkfrTfDnDxt0Em6yQPsiuSmc78HskQ
         WGQbPYbb4EersdJNCotDq89kvEVm6mw1neWXKg0z6gIgJTxXy18MMN5dNLYd3nwsoiMM
         Tt5Q==
X-Gm-Message-State: AOJu0YxGl2hE7V4RaSL7VU4wpLcorGLATbuFCwr+5dvkeIPIeTxuxGLH
	dQ7b+IrJawwp82WqnEwsam5zBwxuGlpuwEzzPyyw+AG/pP2xJwNsU8UWFBjnk3Csln/+JYts4Qb
	ya9uXOZvL
X-Received: from pfkm16.prod.google.com ([2002:a05:6a00:810:b0:82f:acfe:350b])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a0b:b0:82f:b519:a5cb
 with SMTP id d2e1a72fcca58-82fb519a73emr8945998b3a.37.1776813381347; Tue, 21
 Apr 2026 16:16:21 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:43 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-3-jrhilke@google.com>
Subject: [PATCH v3 02/16] KVM: selftests: Add /proc/interrupts parsing helpers
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Introduce utility functions to parse /proc/interrupts and extract the
host IRQ number for a given VFIO device and MSI vector.

These helpers lay the groundwork for subsequent patches that will use
real VFIO devices to trigger hardware interrupts. Specifically, they are
needed to allow the test to log the exact IRQ number being used for
better debugging.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/include/proc_util.h |  9 ++++
 tools/testing/selftests/kvm/lib/proc_util.c   | 42 +++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b3e223f45575..d944b81cad7d 100644
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
index 000000000000..7c465e8584e2
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_PROC_UTIL_H
+#define SELFTEST_KVM_PROC_UTIL_H
+
+#include <stdint.h>
+
+int get_proc_vfio_irq_number(const char *vfio_device_bdf, int msi);
+
+#endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
new file mode 100644
index 000000000000..ad1c54a81869
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "proc_util.h"
+
+#include <ctype.h>
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
+int get_proc_vfio_irq_number(const char *device_bdf, int msi)
+{
+	char search_string[64];
+	char line[4096];
+	int irq = -1;
+	FILE *fp;
+
+	fp = open_proc_interrupts();
+
+	snprintf(search_string, sizeof(search_string), "vfio-msix[%d]", msi);
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
+	return irq;
+}
+
-- 
2.54.0.rc2.533.g4f5dca5207-goog

