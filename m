Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85E230BD5
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310047; cv=none; b=md/gArk00oeH5A1nd5SD8zfE4/8y/Iw6Ey0HzQQdVEzJkZB0tYyb/Wxw7jVHVoJt4fXrvgzQiyo78H622SqmUOB9JNGItMxfYGCQCrme/iyX/lhTp9jSArzPxRojL8CIwxt55R7W1fncLGerJkqoxyMudsd8yJhm4ESQRiY31CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310047; c=relaxed/simple;
	bh=V+fai80fvGy6xNbMhzBzclZirnMI9czJqjJ8MXI2MX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K+d39eGlICyRKVA1jLTJYt8tB3zT4bFhs+J1BZQ6+rBeBL0qirNDMZ6wxdzPuwQ/dMUL/b1d2ykzeNi3tBmNXOyJFEp0pYloUUKPBekHptKc1u5edS2hkkcQIJTYPbf9rwEohknMpaI6ySOzVjdX1M4CFtHdZfT2JJQnEf4QPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5/Ciz5B; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5/Ciz5B"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf160f7191so10029685ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310044; x=1781914844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=3qRbqYxE/FHHRGIPHLP62KGhWo8UkYosmytEIIXQZ9U=;
        b=X5/Ciz5B9czGyvHpFAgYYMSyz6ctkGJi3MiVMsiZzkd5GCIObI6f+IVjtnas8x/12b
         344eqynQISMLQYKI34c3JFyqnIRASaP1JThmR63qaqKA3v0BGeniwGqR24ETv+9hGrL1
         0nQVpuqEMArcpEVqKy00f/kjdn1/lugcPThoURq8jWx9hacr5OaeIqlFV05TOVTPJmk5
         Ut6uBQ5dePEbTIM0uzB7utec1uLMptcxg7jfCsJ2A46nZY0MCuELvhTWVudt8/6U2Z62
         3fWzsAsTI5k4/DtPf9TGMZGkGdkHiQUuuzLYClmnWQ9n2S2aYcYz/5dObziwNcilXbWF
         M1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310044; x=1781914844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qRbqYxE/FHHRGIPHLP62KGhWo8UkYosmytEIIXQZ9U=;
        b=m4WcLIKRMZ2mdmWPok0mEeJ8P0UN10Z5oHraN0GxY51iRjynxo4tKCEHxO/YSN4HSu
         kWUlg3rv14u1C4BK2Ek13SXJdNjwfoCOVs2iu45QTgfsv1mwSTiYbHcAQTyEUxcZGIeP
         zAEjv+jeJlCBBip2jpwEWnb3AjN82flSaFXfZexqnr/pxfY07VecaUMJXPoroiS+bWt/
         IxTnDOxmc1dA1yzSIyeBgAwaDaAzDXxwcjuyrs/S3f6rMux6oit2mAjNiNtKNWLnXULL
         nWd9JNH4rlm2c1idplI//4lJD7MXX24DiGlNFOW8IoiKtQ2wxCbNDprF9K4QULf0tNYy
         YUBQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sOjvzz9uBpNlHm19bNuK9aZwnknvk0QiJAvyBxXcaArPpYUIMP5lF1WRixG05KVrEPmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSKZv4jyxI9flrwYS8VmIhARcoWItVbuUF1ZGTOYwIDAO3+DLx
	eEljJjb2s7L5ZTfdnh6QkFVv9YSipZOWeRGanpT1PlhfKL1um7khY7/wK8OQ57BXkomr9UObnOU
	87OyFpw==
X-Received: from plrx19.prod.google.com ([2002:a17:902:b413:b0:2bd:3dba:a4c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:acb:b0:2c0:a746:7b16
 with SMTP id d9443c01a7336-2c6641e3058mr18450205ad.22.1781310044254; Fri, 12
 Jun 2026 17:20:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:19 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-9-seanjc@google.com>
Subject: [PATCH v7 08/20] KVM: selftests: Add helper to get host IRQ from
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
index de5f6e91203b..c112cedd3a2a 100644
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
2.54.0.1136.gdb2ca164c4-goog

