Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C93783A4
	for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 22:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701054; cv=none; b=djA41b71AaSfX4YpMonSadPNiahE49CpatuzKBfX4kqfvaxaxwUw2MsAFEPGpd76Ty3w8xRaK8N9JmC7mkd+OocxkRxR2jB2qzID7PRx5BVS0UpPmYQ4ZBSn2NvCCgMo/bM43y0PCfqfluvzOIvxKIybnexg/HvEbUSOCA2r/ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701054; c=relaxed/simple;
	bh=CRZaBcVT4Nccd9wr2yksdpHezTrKvIKkYwQqtZlwzaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lm9QPwm3AQ6xccG8BpgCn0YGrm0e8K60Vh6j5oqcg5dhfWhwcm7Ch7AnKB/3Ey6CWdK59UojJ2R4JWtYr3C7cSyuPwwVALgVI2pSxIBXUWdZsTZar8cMNeOskTZNin61pi1+qXAwQmClxkzvZcrdPeNAyOpqp99c5ChOxRGPH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oz0uYsW7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oz0uYsW7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829a72475a1so19871905b3a.3
        for <kvm@vger.kernel.org>; Mon, 16 Mar 2026 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773701052; x=1774305852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft9HYj5yB7NMR4Js2O0wNzazbO+Nfd7jWsn5KEAvFFc=;
        b=Oz0uYsW7zY3Rckr9oNg+B2GnNuY+t5BJpSiid94/U8WTROALM4TZtyW+U6423JTqPX
         Kn57S0fjJzVPzef7y3G4tSeybIfyOWHLNGyufabxCYK/CRfl/u/fBHOROXylgM8oWXWm
         ORImpEtx3d64n9WCDU9kpq21GYP1lp4DB6J/acsjCUwwfuN6xrx9oSJkGKJ2NAJEueiS
         IeFw1RmIBR7qM23Pm0OR6C4Arq/wk3BjLS6fMZon5RQecphQLGWJiVQODDVbOin8JOhQ
         SA+xFwqWdElWeTi9AV8eEM55NXjEwzI+VSk5RhTO9U2mxHCfnfxKCpqL00KjK+KEAGRZ
         KgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701052; x=1774305852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft9HYj5yB7NMR4Js2O0wNzazbO+Nfd7jWsn5KEAvFFc=;
        b=E5PsR4Z32VZqB5hDFAWYQTez3MZ6XwSyHjtod0Sgh6eTmHQoB7nU6+X20fFxFQL2an
         iFUbXXVpsripJEaVsKDujagkCvp2B8QbIwax919r5NDEQtQlMgT6/QapgO7rhWAc8Og3
         3TjrWsAg+k0SsCyJWR/8EwElqFSGF8L7C+2rkgXsXQvj8CTB/3IxvT6Xsf/iXSXsNc0K
         8EiVYeXwf1hKH2G00L+1YhA9TudX35Rx5BB61Cp1gN76lOjsV3ch41ubD/iTo/34HB6Z
         MMccEMS3k+AsBnu4rs04mZoCrLcEVR+HpT6tvqbqTT4eQxbSzWXtV5ZQJhyBhsNGyUD3
         Do3w==
X-Gm-Message-State: AOJu0Yyeompmf9obz4WBu5CmwYq+qRZiISoEHRlXJAgHomJNqmSJXl9A
	uWu1P68VXIm4NC9Y1jdaRkM8OPf85JRH4qmMcUdTlroKoShtQHn5QhxZaHzvmkVhkBRP93PXqV6
	ppzY2kktA1SV/+VHzR7sBcNr1KgjsAB0UHVIDkeEXgenGaAPlM8KfYJ94Rcjw0qJIrUrl9tPkK3
	O/NxZ9rg/mL5L8aOP3NPc6PkNLYfGRIuzMWKXFK1mm/NU7fRcOKP0kkNVAMz0=
X-Received: from pfbho21.prod.google.com ([2002:a05:6a00:8815:b0:824:b235:888c])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:130f:b0:824:a182:1dd4 with SMTP id d2e1a72fcca58-82a19928c35mr13559051b3a.54.1773701051395;
 Mon, 16 Mar 2026 15:44:11 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:43:49 -0700
In-Reply-To: <20260316224349.2360482-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316224349.2360482-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316224349.2360482-4-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v1 3/3] arm64: Add Stage-2 MMU demand paging test
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new test case to validate Stage-2 MMU fault handling. The
test verifies that the hypervisor correctly identifies and handles
Stage-2 data aborts triggered by a guest accessing unmapped memory.

The test performs the following:
- Sets up a guest with Stage-1 disabled, using identity-mapped host
   code and shared data in the Stage-2 page tables.
- Triggers a Stage-2 data abort by accessing a specific unmapped IPA.
- Catches the exception in the host, verifies the fault address,
   and dynamically maps a new page to resolve the fault.
- Resumes the guest to confirm the memory access completes successfully
   and the fault handler functioned as expected.

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 arm/Makefile.arm64    |   1 +
 arm/stage2-mmu-test.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 arm/stage2-mmu-test.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index 9026fd71..e547f92d 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -67,6 +67,7 @@ tests += $(TEST_DIR)/cache.$(exe)
 tests += $(TEST_DIR)/debug.$(exe)
 tests += $(TEST_DIR)/fpu.$(exe)
 tests += $(TEST_DIR)/mte.$(exe)
+tests += $(TEST_DIR)/stage2-mmu-test.$(exe)
 
 include $(SRCDIR)/$(TEST_DIR)/Makefile.common
 
diff --git a/arm/stage2-mmu-test.c b/arm/stage2-mmu-test.c
new file mode 100644
index 00000000..391c28f0
--- /dev/null
+++ b/arm/stage2-mmu-test.c
@@ -0,0 +1,100 @@
+/*
+ * ARM64 Stage-2 MMU Demand Paging Test
+ *
+ * This test validates stage-2 data abort handling by purposefully
+ * accessing unmapped memory in the guest and verifying that the
+ * host correctly handles the fault by mapping the page.
+ *
+ * Copyright (C) 2026 Google LLC.
+ * Author: Jing Zhang <jingzhangos@google.com>
+ *
+ * SPDX-License-Identifier: LGPL-2.0-or-later
+ */
+#include <libcflat.h>
+#include <alloc_page.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/guest.h>
+#include <asm/stage2_mmu.h>
+
+#define TEST_PAGE_IPA		0x40000000UL
+#define FAULT_ADDR_IPA		0x50000000UL
+#define TEST_DATA		0xBEEFCAFEUL
+
+static volatile bool handled = false;
+
+static void guest_code(void)
+{
+	volatile unsigned long *test_va = (void *)TEST_PAGE_IPA;
+	volatile unsigned long *fault_va = (void *)FAULT_ADDR_IPA;
+
+	*fault_va = *test_va;
+
+	if (*fault_va == *test_va)
+		handled = true;
+
+	asm("hvc #0");
+}
+
+int main(int argc, char **argv)
+{
+	struct guest *guest;
+	unsigned long *test_page, *fixup_page;
+	unsigned long code_va_base, code_pa_base, data_base, far, ec;
+
+	report_prefix_push("stage2-mmu");
+
+	guest = guest_create(smp_processor_id(), guest_code, S2_PAGE_4K);
+
+	/* Map host code: IPA(VA) -> PA */
+	/* We use the host VA as the Guest IPA because guest stage 1 is disabled. */
+	code_va_base = (unsigned long)guest_code;
+	code_pa_base = virt_to_phys((void *)guest_code);
+
+	/* Align to 2MB to use block descriptors where possible */
+	code_va_base = code_va_base & ~(SZ_2M - 1);
+	code_pa_base = code_pa_base & ~(SZ_2M - 1);
+	s2mmu_map(guest->s2mmu, code_va_base, code_pa_base, SZ_2M, S2_MAP_RW);
+
+	/* Identity map the shared variable */
+	data_base = virt_to_phys((void *)&handled) & PAGE_MASK;
+	s2mmu_map(guest->s2mmu, data_base, data_base, PAGE_SIZE, S2_MAP_RW);
+
+	/* Map test data page */
+	test_page = alloc_page();
+	*test_page = TEST_DATA;
+	s2mmu_map(guest->s2mmu, TEST_PAGE_IPA, virt_to_phys(test_page), PAGE_SIZE, S2_MAP_RW);
+
+	report_info("CPU%d: entering guest...", smp_processor_id());
+
+	while (1) {
+		guest_run(guest);
+
+		if (guest->exit_code == GUEST_VECTOR_SYNC) {
+			ec = guest->esr_el2 >> ESR_ELx_EC_SHIFT;
+			if (ec == ESR_ELx_EC_HVC64) {
+				report_info("CPU%d: Guest exited via HVC.", smp_processor_id());
+				break;
+			} else if (ec == ESR_ELx_EC_DABT_LOW) {
+				far = guest->far_el2;
+				if (far == FAULT_ADDR_IPA) {
+					fixup_page = alloc_page();
+					s2mmu_map(guest->s2mmu, FAULT_ADDR_IPA,
+						  virt_to_phys(fixup_page), PAGE_SIZE, S2_MAP_RW);
+					report(true, "Caught stage-2 fault at 0x%lx", far);
+				} else {
+					report(false, "Unexpected fault address: 0x%lx", far);
+					break;
+				}
+			} else {
+				report(false, "Unexpected exception class: 0x%lx", ec);
+				break;
+			}
+		}
+	}
+
+	report(handled, "Stage-2 fault handling test completed");
+	guest_destroy(guest);
+
+	return report_summary();
+}
-- 
2.53.0.851.ga537e3e6e9-goog

