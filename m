Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21203C2D
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100584; cv=none; b=hQYhnVEoK5JGw82V5VyF/+FuL446/KJepkdWb6/8QTxzOnpMkSmJyI63sL4QqaSlpj+mUxQIqUrRq9JxLsIONXJEivojb7MSMu24K+Unersx9hcAwl9sGQ2ZYDv7prDz7LK35nWm0DkfXx02wsxjbrV0d0iSYG/tMAQiOXLBKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100584; c=relaxed/simple;
	bh=Za+s+OgPLfvUhN+QI3n1p7epUkpLwBru3OqG8CCuomI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aTDYDzGegLnzGZnIOBWwIlulE9LFaI96T4KBM3w25ziUldUWfB8/NlNlck2POrErdgUip4e0n2CEk6w6dH5xLdX9YkIkKhS1NjmYgUdi+IVr68LrvAUFcWBEKRX7bWPDwSOdVqPDZlzBThj8Uk/tontvkCBFz0MuNkdgpO3IKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fr7F20Rf; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fr7F20Rf"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8421fa54cf9so409932b3a.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100583; x=1780705383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9DXbh05mf0SUiaS4tAY6E1/7NEkibUbeq5dHsgLItpk=;
        b=Fr7F20RfTLfpxAZz8vsawslSD+rCVnmKqyOItVpR6NGQk0qzM5Odw5lnqr3Q2hXAiL
         5+ImmS/aG495T4uT5XK1DO7yiyPmlI8cbOaKXU74NXPTKxAz6gXpVFPA+dr4GTpcSl7I
         o48VsTi1dX9ONpHnt3fRQefJas4tZFiXfcR6DlvM115rjyfctjQAhb/s/cYZeiCWIsI5
         IllD7YOwr3OK7J0RG3oBl5PSt8bJ9AjqEIB0xp/nkE7XRzs9+Djh42X5xxRUi9cJ4F50
         Bq0aIh9qaC/IcRATXEGx4ULMraZIkVY0bp4S9asZtT6729/ebyV5VcsYXm6YHfhNwTJ1
         XXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100583; x=1780705383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9DXbh05mf0SUiaS4tAY6E1/7NEkibUbeq5dHsgLItpk=;
        b=f9iV14OUjVYbJyZzNecB281wndtW7oKXc1J56LAsqKnV3QOacSIbJZMMTv5EhxpwQq
         gk51jTn1AwT8FhHMpbh43rz2NcsBblSdjqg0YOOETlKmmLklJBJjEgtdOOjqdDs/L6id
         gZ6PTvXyi7jCPAQnfbMXH8dybMDFX87MMKENQSWUHzh8z9ZXLTR6bl+yutlxIyw6uooc
         yyv3b+yjwpZ9tD3/EBJUwAxOtRAokrWFkgZnCU11EHliZcxvVeNsktL1KVBWaGAWOhnM
         g+4fCD3CBaX+kmLqK/KxLu4SKgSLoyQrN1UJbwwHLCm9ImdE9iLGM71bb01D6PAUwqrA
         QgEg==
X-Gm-Message-State: AOJu0Yycc6V8EGSCRhDskSEzT0QN5a6h4eWxHhHN3MO1nWMm5S2rp/cx
	iKGw25n7ZW3q4e/HCbBDAWYlZmh5rfusp3LsJOzdqehemQ0zfw+snlckUX9U6xQwYzNtjr5eXsn
	3kYtr7tys
X-Received: from pfbky35.prod.google.com ([2002:a05:6a00:6f63:b0:82f:473b:a2d5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a25:b0:82f:9985:d4a1
 with SMTP id d2e1a72fcca58-842255cf8edmr1642023b3a.24.1780100582679; Fri, 29
 May 2026 17:23:02 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:17 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-3-jrhilke@google.com>
Subject: [PATCH v4 02/19] KVM: selftests: Add /proc/interrupts parsing helpers
 for IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Introduce utility functions to parse /proc/interrupts and extract the
host IRQ number for a given VFIO device and MSI vector.

These helpers lay the groundwork for subsequent patches that will creat
a KVM IRQ test and use real VFIO devices to trigger hardware interrupts.
Specifically, they are needed to allow the test to log the exact IRQ
number being used for better debugging.

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
2.54.0.929.g9b7fa37559-goog

