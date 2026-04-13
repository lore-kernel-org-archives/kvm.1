Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9337C92E
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113209; cv=none; b=u9j57Re/Mgk9aUnPQjEix8I223Mf/h8FP/zwxDwckgbLriEtiJZpIQGvEItex+68SgT5w9zaX348MYLDSplfIq5hlwm5ahai5mR8POXMggesmTvp6KS7Vy2PHowNJXYogTz3ElCD0BArywtz7qqYEeJxoZqTn67UmX8mhI0YJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113209; c=relaxed/simple;
	bh=1JhpdHjs4nhsKu12NN8RJ/F7gAo6s0Kly6krui3KfCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o/8GQvKS2Cc8O1FGQeTSH+3Hbqj/oSxwplH4Io/nb5cSpMa9OO7rv8EfuunqppcjSzZH1DvVw04Dqa/XUTYZfN5w/emnV2Fe/1E8clhPZZUdHh6WPZNmDbE8gPL9wdBR2uAEXKcuRpvcrFhZSXQTk1lB+hTvWBSV07pf2vW+KJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLt7Uh/s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLt7Uh/s"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2d83e7461so57727355ad.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776113208; x=1776718008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sl1KtXC/+tuHHiZ0wl9PU8IScEDOzQEqTGCZa1m8Xg=;
        b=LLt7Uh/s3RaY+4IpFEGnuvaBnbUpQnRjiDtz6vyhRarYTVzXJGhtuNdL/6zkFveD0P
         Ve915ni3YN1pyyezJWuAyvJACFv6FXLIcgkgKUuhgtQyAiNKEPvuiZAXGK0rxIBlwAne
         ziCIvuRz8C/wDVyUlddEZmAqzqG4LV0pV8vi8tw6JBO+N+7uZpLjE6EYiMc30ua8mich
         nY/3NuyITyScKt20dGel+30764nRWTH1L1U1p7DBHgP4MAzlV713cHNYwuxPald0o+yt
         tHHlNOH4V/TYa2tN0AlIa2gHMyYVyv6HnHm/bVlVZwZbVMQ6jgJ6MFGRJngQGNv134AE
         nidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113208; x=1776718008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sl1KtXC/+tuHHiZ0wl9PU8IScEDOzQEqTGCZa1m8Xg=;
        b=GUuqKr1dma2nJarprzRi8IZ8XD4Z5+GwOHWSPQwoTDrznaEKZWRCqB4DUVZOFLFtGB
         3nn33xgLtaeeL/mG2m9MoBgbvHFmm9WtN+NOLUcO7fg6+n+jrCEPM9plPVs9+/pUjwac
         xWXKLSLJB16d0tK8YE6EibzHL0ZrFwFGMuIJHyzHN4UA12S8RKPtL8hcgI7W0lxKv4r8
         dWbfpNCVJMlh8LE0gr9C5AVy1ybEmal4XRAX9UkEhxeora+7zbuSQFQwAkWELQdhw270
         NHl7juvGC66TETinrqP12CkWJ0CPxg1AtpSYGhuhgKlmZsQe1d4bPhFS9lKVWEQkKUPR
         VTPw==
X-Gm-Message-State: AOJu0Yybswf/xu4YqelBxFNU8qKHQm6EysOYW3lI9qIznfbr9aNWw5wZ
	/2gtUlLzgoG3jRfp6pW+KQuaiC6cMonlPX5fo1vHuzP7TsLOlKXEZLLOVsOAdBeRpLK60LbDApS
	yftAeZ1Tdf+jrT/kj2MK5wzg5XHBWz9FR3liMpPWldiYVzB5o5bYcKXEJbnL7Et3ncuXsd/pvSa
	i+ethiGOfELXNA1KhHAAm18xUwJjq4mT84POgvGFcJOXFH3+lq4YXRurNpXUk=
X-Received: from plv10.prod.google.com ([2002:a17:903:bca:b0:2b2:a715:a848])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:aa4a:b0:2b0:c451:ae8a with SMTP id d9443c01a7336-2b2d597d32dmr109567715ad.13.1776113207637;
 Mon, 13 Apr 2026 13:46:47 -0700 (PDT)
Date: Mon, 13 Apr 2026 13:46:30 -0700
In-Reply-To: <20260413204630.1149038-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413204630.1149038-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260413204630.1149038-8-jingzhangos@google.com>
Subject: [kvm-unit-tests PATCH v2 7/7] arm64: Add Stage-2 MMU demand paging test
From: Jing Zhang <jingzhangos@google.com>
To: KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.linux.dev>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, Yao Yuan <yaoyuan@linux.alibaba.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Andrew Jones <andrew.jones@linux.dev>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Colton Lewis <coltonlewis@google.com>, 
	Jing Zhang <jingzhangos@google.com>
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
 arm/stage2-mmu-test.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)
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
index 00000000..0df4704b
--- /dev/null
+++ b/arm/stage2-mmu-test.c
@@ -0,0 +1,107 @@
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
+static enum guest_handler_result guest_exception_handler(struct guest *guest)
+{
+	unsigned long far, ec;
+	unsigned long *fixup_page;
+
+	ec = guest->esr_el2 >> ESR_ELx_EC_SHIFT;
+
+	if (ec == ESR_ELx_EC_HVC64) {
+		report_info("CPU%d: Guest exited via HVC.", smp_processor_id());
+		return GUEST_ACTION_EXIT;
+	}
+
+	if (ec == ESR_ELx_EC_DABT_LOW) {
+		far = guest->far_el2;
+		if (far == FAULT_ADDR_IPA) {
+			fixup_page = alloc_page();
+			s2mmu_map(guest->s2mmu, FAULT_ADDR_IPA,
+				  virt_to_phys(fixup_page), PAGE_SIZE, S2_MAP_RW);
+			report(true, "Caught stage-2 fault at 0x%lx", far);
+		} else {
+			report(false, "Unexpected fault address: 0x%lx", far);
+		}
+	} else {
+		report(false, "Unexpected exception class: 0x%lx", ec);
+	}
+
+	return GUEST_ACTION_RESUME;
+}
+
+int main(int argc, char **argv)
+{
+	struct guest *guest;
+	unsigned long *test_page;
+	unsigned long code_va_base, code_pa_base, data_base;
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
+	guest_install_handler(guest, ELx_LOW_SYNC_64, guest_exception_handler);
+
+	report_info("CPU%d: entering guest...", smp_processor_id());
+
+	guest_run(guest);
+
+	report(handled, "Stage-2 fault handling test completed");
+	guest_destroy(guest);
+
+	return report_summary();
+}
-- 
2.53.0.1213.gd9a14994de-goog

