Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81134F27B
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779880719; cv=none; b=RU1PjItgTDw0JKd78VdYajjAaZkpbNFJGVuILXbF+7sRVPH8/oGguabolc2FGlOxj02CW90F2WBXT7P2hm/r4YEsyxzRH8+NgoP0MgQ3i9LGR3ctvwWMFGbYXKtxGoobB6kFkMYU44NBPcdePhXbQM87sCNV0fjK695sTu9hilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779880719; c=relaxed/simple;
	bh=fCILp+DohVOOIR+UUseLdprSQEaMH1NXcjDAJS0gm9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UP9sHxrRvb16KpnGvpQ4CwuR1KT7X1aF34B0Em7vMxCB+2+u46YdSuwUknPzeR2mrCXRHkHABNt50qKqo2IEYufMu9gUZahpWebTMolDyazxmOE5x7UsgUv2TSH9v42/qL0DQ9UVgF/786gzzCd+0iT3vh8YHIZ5l2851+w08UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaTNVpIM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaTNVpIM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44e5624c053so6919401f8f.2
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779880716; x=1780485516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0QGieyo5gKzeqh6AipqQcO1qteBU8LLbZeI6OWN5t84=;
        b=OaTNVpIMG3GmBn/NFlNOi6RAQxpLGJ9o+haqavFSb3fisE9rgexYyhtVXDVzf3LfPn
         DYfJiEfCnXMZ2vgo2sf85zwIXa1ECvntChUA1pClljTyeWGb/PfmP4V2/LzSO0bD01ZM
         4rUcwiFu9NuRmq+onTnNIWIcbuKINirfHekAMokd06aK6K4YsE3yxS9Dm2Wh8ZXmIy1m
         PDxMpjInvoOUWvemRR+IvRfXYD2mzDjvEqIEWYIliAGxP/3q34KkBZpEg+Ch3eKrdU7i
         HQG1GcDR0Uoj+IALlGxFpYI3AL2pZMXkIn/0LwoWXvHZijqd95O9dL/zi2Yzeze70cht
         HvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779880716; x=1780485516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QGieyo5gKzeqh6AipqQcO1qteBU8LLbZeI6OWN5t84=;
        b=WR9si0+aaEw3kkTTdU479L9CUVvo1Ms6NmumoJY5ji6BxPP+bMxNhip1//ovTlWx+4
         gOOc5AW5R64Djfz5r22aKa85zLi9ZSANJ7Q3idNNubNXPa9BJHWwT7TUK0JRc/ye6cAv
         i9sd6ZwsfdfhYmUZtrp8J85w/HPaiFxJFA9Gq45sUR6yNZ0DAFmXbhUVdtwxZ1peoR+5
         Q1bgj0oAsgCt5ctUwR/Zk/XgKwzyw3kbASj+Q12TVUfiANa97E4V528JVblpJTYfV+fv
         RRzKWUXEuqu7uQ/o2eF4JiQ8DbcoGsi9zP+ooPYFDkOtuSDgQqN5UKNixi1cuSLe70pQ
         BQ2w==
X-Forwarded-Encrypted: i=1; AFNElJ901rxC/F9dkP5WufgOq9nF950uhfCOQj3MzpO9rPNUH3em69luSRCRrAtzTQE2tWB7JsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkyc7QXpE7O0K92rRDwdIkCpJ/zCkkXwCXgL3YhGTJV6Q9oz9I
	pSW3V3G8BXJfTPmDnXhkkqux1/GaVUHgrTqTJJVJ1GLybB0dBJjH/SuRd6eJ/CQkrhY=
X-Gm-Gg: Acq92OF0UkcXUV8kRhTEw61jVVMfEPkSYF1yrAd4EsRZ/tZQlg3PV4ND3+ZaBZMU8Pc
	I1xhy46NLEr8+HLG9TlE27WlRGe+z5hYgAN2PXgrZsDSH4V37pWDnJS8SkNaSnuJpFvA8ut+scr
	1KECwmrJyYPbBQX7315upfOjowfcUmKk6xxtKJWgVrcCtqToWowRE7ZAaxOuqMD6E1RxpOfP0Q5
	1mVVpgpJ9LCp0Su3YCScPZ1hUU1i/igQoqMF3hdXJLGrKwgF0HWCS8T0vJM1SkC1CDrO/wJR2kN
	3QG2zx4o4ynwh+R9hTDMdb7onuspJ/AtcAaOWkh1Jrkm9IjGNQTXsbJJA+kBtZoSkRv50cPy9nT
	sKdvT6DozSqZg4xBLH6XGL8jqlz+aPyvWdRDsIoSyINGOESdYoZ9YSoBQ7rCeAmut3qbajAew6t
	RWswX9CM0lVd3oEuCRqBLuYGZP6A2DrpZtCw==
X-Received: by 2002:a05:6000:4606:b0:44a:b0a3:7c1a with SMTP id ffacd0b85a97d-45eb36b0126mr40044368f8f.24.1779880716257;
        Wed, 27 May 2026 04:18:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b28absm5398550f8f.27.2026.05.27.04.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 04:18:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 9ECBF5F7F0;
	Wed, 27 May 2026 12:18:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Andrew Jones <andrew.jones@linux.dev>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	kvmarm@lists.linux.dev (open list:ARM),
	kvm@vger.kernel.org (open list:Default mailing list)
Subject: [kvm-unit-tests PATCH v2] arm: add wfx test case
Date: Wed, 27 May 2026 12:18:21 +0100
Message-ID: <20260527111822.1563679-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is based on a similar test case I wrote for QEMU's tcg tests although
obviously able to take advantage of kvm-unit-tests additional plumbing for
dealing with the GIC and IRQs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop TIMEOUT in favour of computed 10ms timeout
  - add comments for each test
  - use sevl for local clearing
  - set gic irc depending on CurrentEL
  - EOI the GIC
  - display elapsed ns (no float to do ms ;-)
  - fix some style issues
  - make test TCG only
---
 arm/Makefile.arm64        |   1 +
 lib/arm64/asm/processor.h |   7 ++
 lib/arm64/asm/sysreg.h    |   3 +
 arm/wfx.c                 | 187 ++++++++++++++++++++++++++++++++++++++
 arm/unittests.cfg         |   7 ++
 5 files changed, 205 insertions(+)
 create mode 100644 arm/wfx.c

diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
index a40c830d..52b3f35d 100644
--- a/arm/Makefile.arm64
+++ b/arm/Makefile.arm64
@@ -64,6 +64,7 @@ tests += $(TEST_DIR)/cache.$(exe)
 tests += $(TEST_DIR)/debug.$(exe)
 tests += $(TEST_DIR)/fpu.$(exe)
 tests += $(TEST_DIR)/mte.$(exe)
+tests += $(TEST_DIR)/wfx.$(exe)
 
 include $(SRCDIR)/$(TEST_DIR)/Makefile.common
 
diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
index 32ddc1b3..2104036d 100644
--- a/lib/arm64/asm/processor.h
+++ b/lib/arm64/asm/processor.h
@@ -173,5 +173,12 @@ static inline bool system_supports_rndr(void)
 	return ((id_aa64isar0_el1 >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf) != 0;
 }
 
+static inline bool system_supports_wfxt(void)
+{
+	u64 id_aa64isar2_el1 = read_sysreg_s(ID_AA64ISAR2_EL1);
+
+	return ((id_aa64isar2_el1 >> ID_AA64ISAR2_EL1_WFxT_SHIFT) & 0xf) != 0;
+}
+
 #endif /* !__ASSEMBLER__ */
 #endif /* _ASMARM64_PROCESSOR_H_ */
diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
index f2d05018..cb96a649 100644
--- a/lib/arm64/asm/sysreg.h
+++ b/lib/arm64/asm/sysreg.h
@@ -77,6 +77,9 @@ asm(
 #define ID_AA64ISAR0_EL1_RNDR_SHIFT	60
 #define ID_AA64PFR1_EL1_MTE_SHIFT	8
 
+#define ID_AA64ISAR2_EL1		sys_reg(3, 0, 0, 6, 2)
+#define ID_AA64ISAR2_EL1_WFxT_SHIFT	0
+
 #define ID_AA64MMFR0_EL1_FGT_SHIFT	56
 #define ID_AA64MMFR0_EL1_FGT_FGT2	0x2
 
diff --git a/arm/wfx.c b/arm/wfx.c
new file mode 100644
index 00000000..0825c5cb
--- /dev/null
+++ b/arm/wfx.c
@@ -0,0 +1,187 @@
+/*
+ * WFX Instructions Test (WFI, WFE, WFIT, WFET)
+ *
+ * Copyright (c) 2026 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <libcflat.h>
+#include <asm/processor.h>
+#include <asm/gic.h>
+#include <asm/timer.h>
+#include <asm/io.h>
+
+#define sev() asm volatile("sev" : : : "memory")
+#define sevl() asm volatile("sevl" : : : "memory")
+#define wfi() asm volatile("wfi" : : : "memory")
+#define wfe() asm volatile("wfe" : : : "memory")
+
+#define wfit(reg) \
+	asm volatile(".arch armv8.7-a\n\twfit %0" : : "r" (reg) : "memory")
+#define wfet(reg) \
+	asm volatile(".arch armv8.7-a\n\twfet %0" : : "r" (reg) : "memory")
+
+uint64_t time_hz;
+uint64_t time_10ms;
+
+static void timer_handler(struct pt_regs *regs)
+{
+	u32 irqstat = gic_read_iar();
+	u32 irqnr = gic_iar_irqnr(irqstat);
+
+	/* Disable timer to stop IRQ from re-firing */
+	if (irqnr == TIMER_VTIMER_IRQ || irqnr == TIMER_HVTIMER_IRQ) {
+		write_sysreg(0, cntv_ctl_el0);
+		isb();
+	} else {
+		if (irqnr != GICC_INT_SPURIOUS)
+			gic_write_eoir(irqstat);
+		report_info("Unexpected interrupt: %d\n", irqnr);
+		return;
+	}
+
+	/* Also acknowledge EOI for the GIC */
+	gic_write_eoir(irqstat);
+}
+
+static bool check_elapsed(uint64_t start, uint64_t threshold, const char *test, bool more)
+{
+	uint64_t end = read_sysreg(cntvct_el0);
+	uint64_t elapsed = end - start;
+	bool pass = more ? elapsed >= threshold : elapsed <= threshold;
+
+	report(pass, "%s (%ld ticks / %ld ns)",
+	       test, elapsed, elapsed / (time_hz / 1000000));
+
+	if (!pass)
+		report_info("%s %s", test, more ? "woke too early" : "slept despite SEV");
+
+	return pass;
+}
+
+/*
+ * Test WFI with timer interrupt
+ *
+ * WFI should wake up when the interrupt is pending. We unmask
+ * interrupts here so they are taken and then check WFI actually
+ * did sleep rather than return straight away.
+ */
+static void test_wfi(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFI...");
+
+	start = read_sysreg(cntvct_el0);
+	write_sysreg(time_10ms, cntv_tval_el0);
+	write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
+	isb();
+
+	local_irq_enable();
+	wfi();
+	local_irq_disable();
+
+	check_elapsed(start, time_10ms, "WFI", true);
+}
+
+/*
+ * Test WFE and SEV[L]
+ *
+ * There are two SEV instructions, the normal one is a broadcast
+ * from any PE on the system, the other is local only.
+ * Functionally they have the same effect (setting the event
+ * register) and should be immediately consumed by the WFE.
+ *
+ * As we want to detect an early exit the sense of the timeout
+ * check is reversed.
+ */
+static void test_wfe(void)
+{
+	uint64_t start;
+
+	report_info("Testing WFE/SEV...");
+	sev();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, time_10ms, "WFE/SEV", false);
+
+	report_info("Testing WFE/SEVL...");
+	sevl();
+	start = read_sysreg(cntvct_el0);
+	wfe();
+	check_elapsed(start, time_10ms, "WFE/SEVL", false);
+}
+
+/*
+ * Test WFIT
+ *
+ * With the timer disabled and no other IRQ sources firing the
+ * WFIT instruction should timeout.
+ */
+static void test_wfit(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFIT...");
+	start = read_sysreg(cntvct_el0);
+	timeout = start + time_10ms;
+	wfit(timeout);
+	check_elapsed(start, time_10ms, "WFIT", true);
+}
+
+/*
+ * Test WFET
+ *
+ * Much like WFIT there are no IRQs to wake us up. However the
+ * event_register is a latch so we must first consume the event
+ * register with a normal WFE before we do the timeout version.
+ */
+static void test_wfet(void)
+{
+	uint64_t start, timeout;
+
+	report_info("Testing WFET...");
+	/* Ensure no pending events */
+	sevl();
+	wfe();
+
+	start = read_sysreg(cntvct_el0);
+	timeout = start + time_10ms;
+	wfet(timeout);
+	check_elapsed(start, time_10ms, "WFET", true);
+}
+
+int main(void)
+{
+	uint32_t irq = current_level() == CurrentEL_EL1 ? TIMER_VTIMER_IRQ : TIMER_HVTIMER_IRQ;
+
+	if (gic_init() < 0) {
+		report_abort("GIC init failed");
+		return 1;
+	}
+
+	/* Install timer handler for WFI wake-up */
+	install_irq_handler(EL1H_IRQ, timer_handler);
+	gic_enable_defaults();
+	time_hz = read_sysreg(cntfrq_el0);
+	time_10ms = time_hz / 100;
+
+	/* Enable Virtual Timer PPI */
+	gic_irq_set_clr_enable(irq, true);
+
+	report_prefix_push("WFx");
+	test_wfi();
+	test_wfe();
+	report_prefix_pop();
+
+	if (system_supports_wfxt()) {
+		report_prefix_push("WFxT");
+		test_wfit();
+		test_wfet();
+	} else {
+		report_skip("WFxT instructions not supported");
+	}
+
+	return report_summary();
+}
diff --git a/arm/unittests.cfg b/arm/unittests.cfg
index 12fc4468..ae8b5534 100644
--- a/arm/unittests.cfg
+++ b/arm/unittests.cfg
@@ -339,3 +339,10 @@ groups = mte
 test_args = asymm
 qemu_params = -machine mte=on
 arch = arm64
+
+[wfx]
+file = wfx.flat
+groups = wfx
+arch = arm64
+# This test exercise CPU emulation so limit to TCG to avoid confusion
+accel = tcg
-- 
2.47.3

