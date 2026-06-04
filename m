Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296582EC0A7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538560; cv=none; b=rznpQWoaNEKJhkAn8sMvQRFA5HL6qcqRGFo/nqBQnkTJnm2zCkMgAiGtD899eSBfDL4XElmpXrkkrevbfdLfTjmmQEiVHCDBvMD+v6Pv/5DuqvDypMDml2+TdoAljmlddtZ2UHimVWVIi7RnpmLL6vMDP/sywzmQJpChQmLfIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538560; c=relaxed/simple;
	bh=IPGEt70vS4FiYPmd9MbalH+VmvWwbOgc68lRIPMypl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2Pt4s0S35rCgQjy7OSv69MGHCVQ1plF/Ry7WkwLA3MZuSX/+5mXShaF3JeKMu8833/EzAQOJ8NJeFj6ei5xjHMw44bA1gizagMRUOiC8/IU763VdTjKkjwlm5b5RxoSiCYWoeUy+MktGSw3JFAJkF9Eqd0RLRhby5G2aK81dhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJ/K5KYz; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJ/K5KYz"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf0b7425bbso4338245ad.0
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538556; x=1781143356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXgfk9ZIydC5OjUB+yhLarQexw0ICCKfMTUcdnWHPEE=;
        b=CJ/K5KYzbdttgZcmEDDfYq8h951YVfoKcC0EDpDiwmwJT1LOdsPi1qG2C4d/6yvvC9
         o3q/Dy0mdfQxum6zAac8oCL1XT7E3umGGpMhpppx3InfZi5WVREaypq5V9Qcc9e8dnO5
         v1lifzxTYihFeX+uP7KWiXorGTLp9qnQOUyY9R5ljVxD9SlzT+ySaswv9AwTB7ChDyjF
         A849d55DFEABdFpZyisBO867oQ83+7DQvij2oYBfQYluZOf1c6kMCE1AbNdF0O1/o/mR
         deFXIz9PJbmOTcoP8TKYZtOa57YjuKYXMMlh4oaS9ByDQK1/F18Umw55Gv7KL+rry3kn
         bAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538556; x=1781143356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXgfk9ZIydC5OjUB+yhLarQexw0ICCKfMTUcdnWHPEE=;
        b=X1faW+yBqc+yiQ/oUy4Q+o4q4FyJ8aVF8UE7MHFseSlbxVH3SH9OmZQkZkwBu6NJ3O
         utL5vVPyBAwM37tUVOxG5k5L5mmPBOVvKReMxaYFYqtVxCd5qb93n30F9kMR/wTuW0EX
         qpKrZFbGrH6JpXsb0joetYzY2zo67IBmIQDMDD4S8y2khe6467YkPh/2LN3NpICEN2mQ
         Oe5jtcjHTHMw0p4cjmfP6GkLYH7Exyuto7FLG/nUesp0Mua4AaYS8CIsVPrAsCVyerQT
         GCdCv/Ejkewhe4kdmjmUMOfL/jwglTSWLmIQX1FdUqlgYpzvwN1/fLxHCsezFiil+eAE
         AdhQ==
X-Gm-Message-State: AOJu0YyvNIV/C2DTWHKISCNsgDf1nxjKlvUG4orbJOsJhlifNrTF7f6U
	Te/3ofQcN7QqUeGT1i+SxhunfmVoFs1DW0PWtLPFdRVnyuVun5j7qX8MbrHm4GBsKFwGkzIyx0j
	4evZjEAch
X-Received: from plbjz7.prod.google.com ([2002:a17:903:4307:b0:2b0:b410:3605])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced1:b0:2bd:5ab:af95
 with SMTP id d9443c01a7336-2c1634f9212mr58595075ad.0.1780538555986; Wed, 03
 Jun 2026 19:02:35 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:28 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-7-jrhilke@google.com>
Subject: [PATCH v5 06/21] KVM: selftests: Add helper to get host IRQ from
 device MSIX for IRQ bypass test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Introduce proc_util.c and proc_util.h to house utility functions for
interacting with the proc filesystem.

Add vfio_msix_to_host_irq(), which parses
/proc/interrupts to map a VFIO device BDF and MSI-X vector to its
corresponding host IRQ number.

This helper will be used in a subsequent patch for debugging when
implementing support for IRQ bypass in the KVM IRQ test.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/include/proc_util.h |  9 +++++
 tools/testing/selftests/kvm/lib/proc_util.c   | 40 +++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/proc_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/proc_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b859098121c7..63355b56c42f 100644
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
2.54.0.1032.g2f8565e1d1-goog

