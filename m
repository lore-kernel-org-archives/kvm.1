Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E51376497
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986087; cv=none; b=mbx1OYeMY77DzW1nGovaOMCbHOR5nr+ka/RElylSRFOlZu0CcFTfzAD+KxReXZaD544B1NOfynXZRwgBsbmaybkK3QsZunIyZt7d3NdEtN61UisKQ9qXBiz/JZfQvaM9w+QO/IKNlm26eHfTUIGwtOebjMvW8QcJgrJDtd25Lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986087; c=relaxed/simple;
	bh=dUfPAlISRjjrGd7kz70/2EXoVFmcqsRAaLzfoQCUysM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgaFaS9cumj2WXbEMBDteDnMFLtelY2GsJdK5c4jhtUXjYXZmThaV0TF5k2WigCYNHCSUKdE83OqJKhzUDNGDiSXyox2NS0CcazOzbx1vLldSuHBigeMITAC3bZ6o517Qb9wX0o6ESFFaoTcihY1Ad61xuwJoUQlIV62PaChYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOLq4w7p; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOLq4w7p"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so4004902b3a.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986085; x=1775590885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rr4/DsQ3BGApR8G11qnk07yGrAQLcfm8tjJjEwZ22ZA=;
        b=EOLq4w7pWKkiML4offIpQw7A7IVh/FmB+nLpZSs8XetmAfqXooa+/QssgCDj2SeUYn
         LP+vY5lwhWVS6Lgj0kYU2AHeVeUvU8x6VvM3ZjkoAxjo5mYsc/BpEAsGDg8dq6lVVa5D
         XRNn9I0VgW4oW5CZriCL16zNqrho1YEeOM7tW/luxrrO4aEBM1AIyk/NF1eEnhuQludf
         l0Dc7iEFQ7DyytDetwduArNN8SfBELntn80QR8Qfb76T+8FSYz+wAiikvJm1Ddu4Xko1
         ouoh2ZMw9GziJFO6LVpnGLPO5XxTvxMMD4hqLTC/rvRfcUMy5xqfRA+6Q7ElfyHgbNjl
         s4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986085; x=1775590885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rr4/DsQ3BGApR8G11qnk07yGrAQLcfm8tjJjEwZ22ZA=;
        b=HAMzqU4XIfPperC8PmlFqOri/Klt04/a8+IP1HX4/m06VqPDle/YyuIG7K03rNl4Aj
         E4dYnKc2IGSKCFuIxfGKIiKSyBdnXxrW6JOdBUWCQjwFICdJ/pEMbiMyf/km+TLxSAlg
         kNGYJKd/UTxnYI+HA9Ytm1ySAv06MfTqhSMp1G2EeFCvwkTzK6j2XTsaK55SxHEIJ4GX
         As1akJO+o3qj1eQNgTH+mg4W54vX/xEEu8zkrTtnONfodDdITPy7Plx9QpJyTl/3dLvp
         GTYrI5BxPCdOQCoWxdhlIt9mJYPirAmxir/EFbhet9CRZ2daKFYq/4mlYxu5iydXgIZV
         5p/w==
X-Gm-Message-State: AOJu0YwW7XabDvVgYS1HOR2guklWTjPEvse84vcOuXSosqdcUF0Sn3Qx
	JF0pPA8nM0WoeXRI4wMjnVG9Ig7cBcy0MnvOi1Fa4xZF16Ym+jWwqPOSvHGykGtwLbBrqbobzC3
	/PMGjXV7l
X-Received: from pfbkq16.prod.google.com ([2002:a05:6a00:4b10:b0:82c:63f8:59db])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca1:b0:82c:6f07:299f
 with SMTP id d2e1a72fcca58-82ce89812e7mr743280b3a.14.1774986084864; Tue, 31
 Mar 2026 12:41:24 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:21 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-3-jrhilke@google.com>
Subject: [PATCH v2 02/14] KVM: selftests: Add helper functions for IRQ testing
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a test library to get IRQ numbers and counts. Add utility
functions to synchronize global variables between the host and guest to
track interrupt reception and readiness.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/include/irq_util.h  | 11 +++
 .../testing/selftests/kvm/include/kvm_util.h  | 11 +++
 tools/testing/selftests/kvm/lib/irq_util.c    | 84 +++++++++++++++++++
 4 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/irq_util.h
 create mode 100644 tools/testing/selftests/kvm/lib/irq_util.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b3e223f45575..d8f77e181e8e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -11,6 +11,7 @@ LIBKVM += lib/kvm_util.c
 LIBKVM += lib/lru_gen_util.c
 LIBKVM += lib/memstress.c
 LIBKVM += lib/guest_sprintf.c
+LIBKVM += lib/irq_util.c
 LIBKVM += lib/rbtree.c
 LIBKVM += lib/sparsebit.c
 LIBKVM += lib/test_util.c
diff --git a/tools/testing/selftests/kvm/include/irq_util.h b/tools/testing/selftests/kvm/include/irq_util.h
new file mode 100644
index 000000000000..a5d6b63b30da
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/irq_util.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_PROC_UTIL_H
+#define SELFTEST_KVM_PROC_UTIL_H
+
+#include <stdint.h>
+
+int get_irq_number(const char *device_bdf, int msi);
+uint64_t get_irq_count(int irq);
+uint64_t get_irq_count_by_name(const char *name);
+
+#endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 8b39cb919f4f..8be02e7980eb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1144,6 +1144,17 @@ vm_adjust_num_guest_pages(enum vm_guest_mode mode, unsigned int num_guest_pages)
 	memcpy(&(g), _p, sizeof(g));				\
 })
 
+#define READ_FROM_GUEST(_vm, _variable) ({		\
+	sync_global_from_guest(_vm, _variable);		\
+	READ_ONCE(_variable);				\
+})
+
+#define WRITE_TO_GUEST(_vm, _variable, _value) do {	\
+	WRITE_ONCE(_variable, _value);			\
+	sync_global_to_guest(_vm, _variable);		\
+} while (0)
+
+
 /*
  * Write a global value, but only in the VM's (guest's) domain.  Primarily used
  * for "globals" that hold per-VM values (VMs always duplicate code and global
diff --git a/tools/testing/selftests/kvm/lib/irq_util.c b/tools/testing/selftests/kvm/lib/irq_util.c
new file mode 100644
index 000000000000..062f6cda23b9
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/irq_util.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "irq_util.h"
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
+int get_irq_number(const char *device_bdf, int msi)
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
+	TEST_ASSERT(irq != -1, "Failed to locate IRQ for %s %s", device_bdf, search_string);
+	return irq;
+}
+
+static int parse_interrupt_count(char *token)
+{
+	char *c;
+
+	for (c = token; *c; c++) {
+		if (!isdigit(*c))
+			return 0;
+	}
+
+	return atoi_non_negative("interrupt count", token);
+}
+
+uint64_t get_irq_count_by_name(const char *name)
+{
+	uint64_t total_count = 0;
+	char line[4096];
+	FILE *fp;
+
+	fp = open_proc_interrupts();
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *token = strtok(line, " ");
+
+		if (strcmp(token, name))
+			continue;
+
+		while ((token = strtok(NULL, " ")))
+			total_count += parse_interrupt_count(token);
+
+		break;
+	}
+
+	fclose(fp);
+	return total_count;
+}
+
+uint64_t get_irq_count(int irq)
+{
+	char search_string[32];
+
+	snprintf(search_string, sizeof(search_string), "%d:", irq);
+	return get_irq_count_by_name(search_string);
+}
-- 
2.53.0.1118.gaef5881109-goog

