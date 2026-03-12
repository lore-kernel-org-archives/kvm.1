Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A450401A1F
	for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345799; cv=none; b=TeB+X4Cl3h4/t65wm/V25MPXhnDHk9S50J1+IqbkkT4H7Ilut/RKTOm6a9XaBRAC4ZWP5q13GJJzQC9hSFH6+r63fLM0LB9D4Oi2OmjO7GFtIXCtEahJKkUxBp0cYg2Ck6ScaHQgcH0C4X7kN4VuSfrNibDFfIhCWgJxKYVM9Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345799; c=relaxed/simple;
	bh=QmD8eQIOWS5+AwR0q3zNGzvld1y+nahIW8IwEFOcOU8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mT8AaIHR08YDsiswQbq3oCXrT84IunMkVgYum6dAP+PbLtlNtngluzQOpMQ3DXk+/qQwwTIaly0khy0UPbSKiP+dfHo2ekRq/gzYgdlD5sBjNeIGJsar4p2LbeHmy6AGEdMI0AF2sts5pX6tTXaEL3fgZqCy6xFvThGCTREPZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtL1p4q7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chengkev.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wtL1p4q7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35449510446so1121025a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773345796; x=1773950596; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwLmK6qzx7XSYMEkdNEwzO4eT9/vXNK29O2UsupncTk=;
        b=wtL1p4q7KLTWayWz6MyBiUbtVL6bYYxXmE4ZXgI1Jj/CqLz8XhmaGb3BYGDve1FTia
         dxfDf3gh/FRSzqmjdnkew8EkwX14BCuV+rYFjnvUUI4qLdesKIRSfGSLMF/xo3EGaZ5t
         xCwUpQGR1qud18eg3Ush3zYnwRr/MVu0JBlBmYAuMZHo4KbzrLBUb5FvRzNxQnAw7a2b
         XTS/8KN4FSnScKc/OzlGjJAQMojNz96du/wmOAP2tgWNUpwyvVCR4VVrM4W/yCwRoztz
         qwRR71rZv/NW864Rk19K1Bh1X/VMl1ryM96FVWk87CkSrezfN+7s9pL00qIlEVPClrad
         bFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345796; x=1773950596;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwLmK6qzx7XSYMEkdNEwzO4eT9/vXNK29O2UsupncTk=;
        b=SWq5fNU/LFBPUf52WRv8eE1SWCZv4a3sSoEniz3swRPGNkba9XN/BFPDOk4nNz1r9J
         XrUucIQ/T4tm6n51JA8Te4P61Ax6Q+6poXmmiIEFpbP5LTVg1/XX6KfLW6SFJoUaj9wf
         Sf7p19bnj8G3qf+zVpjdvcZICfhIz8iBjF3qqAanpQ2zSFyJ6mfdG0gNQTvn/hRkx5mB
         7mIa3jENkWwr3L1OH2CuXkDa9037SBVIFN7iMG5Hcl59QbWCP6N77j9l6/9b1sfwnm85
         z7EguMyFg5RNvi4kP/LZIJunATYcPYPtbBP0TZ5/iUh7Vyhqe/jQxUFTvjTOeosHVx2m
         UyaQ==
X-Gm-Message-State: AOJu0Yw3FWSnAer3pctsnnajQR7vixMI5p8bOAVpTyM2Q54NiFAN2tpf
	84qUqqMjbAvI4XK8BkBRDGUsOvxGZoR7CxTLrMDpgbNKiNxJo8Fz+bt2zkvL5Ji9grlo/nPseye
	FFhZOEMz9L9goUvrXsvemv0G3UlbcN3OVOJ6slhN09eQ0AX5SSeV9H2eAzYP6bFU2MiXAXEqAV8
	o3VYh8PiImuFp0jkvKiJAbvI/ZNr+EQQA1KiO7MExlUa0=
X-Received: from pgc26.prod.google.com ([2002:a05:6a02:2f9a:b0:c73:cc95:c0e9])
 (user=chengkev job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a08:b0:398:7357:bb8f with SMTP id adf61e73a8af0-398eccb9cedmr428107637.41.1773345796001;
 Thu, 12 Mar 2026 13:03:16 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:03:01 +0000
In-Reply-To: <20260312200308.3089379-1-chengkev@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260312200308.3089379-1-chengkev@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312200308.3089379-4-chengkev@google.com>
Subject: [kvm-unit-tests PATCH v3 03/10] x86/svm: Add tests for APIC passthrough
From: Kevin Cheng <chengkev@google.com>
To: kvm@vger.kernel.org
Cc: yosry@kernel.org, andrew.jones@linux.dev, thuth@redhat.com, 
	pbonzini@redhat.com, seanjc@google.com, Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two tests to SVM test suite to validate APIC passthrough
capabilities.

In the apic_passthrough test, the guest asserts irq-line to trigger a
level-triggered interrupt that should be injected directly in the guest.
Confirm that the remote_irr is set before the guest's EOI and cleared
after guest's EOI. Include a variant that uses a separate thread to
trigger the interrupt to ensure cross CPU delivery is handled correctly.

The svm_apic_passthrough_tpr_threshold_test validates that a guest can
directly modify the host's APIC TPR. The host queues a pending self-IPI
by disabling interrupts and raising the TPR to a high value. The test
then runs a guest that lowers the TPR to 0, and upon returning to the
host, it confirms that the pending interrupt is delivered once
interrupts are enabled.

The nVMX tests already has coverage for APIC passthrough. Add a similar
test for nSVM to improve test parity between nSVM and nVMX.

This test uses the old V1 test framework to utilize the test stage for
specific test event sequencing.

Signed-off-by: Kevin Cheng <chengkev@google.com>
---
 x86/svm_tests.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 11d0e3d39f5b..0eedad6bc3af 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -12,6 +12,7 @@
 #include "util.h"
 #include "x86/usermode.h"
 #include "vmalloc.h"
+#include "fwcfg.h"
 
 #define SVM_EXIT_MAX_DR_INTERCEPT 0x3f
 
@@ -3575,6 +3576,172 @@ static void svm_shutdown_intercept_test(void)
 	report(vmcb->control.exit_code == SVM_EXIT_SHUTDOWN, "shutdown test passed");
 }
 
+
+static void set_irq_line_thread(void *data)
+{
+	/* Wait until other CPU entered L2 */
+	while (get_test_stage(data) != 1)
+		;
+
+	/* Set irq-line 0xf to raise vector 0x78 for vCPU 0 */
+	ioapic_set_redir(0xf, 0x78, TRIGGER_LEVEL);
+	set_test_stage(data, 2);
+}
+
+static void irq_78_handler_guest(isr_regs_t *regs)
+{
+	set_irq_line(0xf, 0);
+	vmmcall();
+	eoi();
+	vmmcall();
+}
+
+static void svm_apic_passthrough_guest(struct svm_test *test)
+{
+	handle_irq(0x78, irq_78_handler_guest);
+	sti();
+
+	/* If requested, wait for other CPU to trigger ioapic scan */
+	if (get_test_stage(test) < 1) {
+		set_test_stage(test, 1);
+		while (get_test_stage(test) != 2)
+			;
+	}
+
+	set_irq_line(0xf, 1);
+}
+
+static void svm_disable_intercept_for_x2apic_msrs(void)
+{
+	for (u32 msr = APIC_BASE_MSR; msr <= (APIC_BASE_MSR+0xff); ++msr) {
+		int bit_nr = get_msrpm_bit_nr(msr);
+
+		__clear_bit(bit_nr, msr_bitmap);
+		__clear_bit(bit_nr + 1, msr_bitmap);
+	}
+}
+
+static void svm_apic_passthrough_prepare(struct svm_test *test,
+					 bool set_irq_line_from_thread)
+{
+	if (set_irq_line_from_thread && (cpu_count() < 2)) {
+		report_skip("%s : CPU count < 2", __func__);
+		return;
+	}
+
+	/* Test device is required for generating IRQs */
+	if (!test_device_enabled()) {
+		report_skip("%s : No test device enabled", __func__);
+		return;
+	}
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+	svm_disable_intercept_for_x2apic_msrs();
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR);
+
+	if (set_irq_line_from_thread) {
+		on_cpu_async(1, set_irq_line_thread, test);
+	} else {
+		ioapic_set_redir(0xf, 0x78, TRIGGER_LEVEL);
+		set_test_stage(test, 2);
+	}
+}
+
+static void svm_apic_passthrough_test_prepare(struct svm_test *test)
+{
+	svm_apic_passthrough_prepare(test, false);
+}
+
+static void svm_apic_passthrough_thread_test_prepare(struct svm_test *test)
+{
+	svm_apic_passthrough_prepare(test, true);
+}
+
+static bool svm_apic_passthrough_test_finished(struct svm_test *test)
+{
+	u32 exit_code = vmcb->control.exit_code;
+
+	report(exit_code == SVM_EXIT_VMMCALL, "Expected VMMCALL VM-Exit, got exit reason 0x%x",
+	       exit_code);
+
+	switch (get_test_stage(test)) {
+	case 2:
+		/* Jump over VMMCALL instruction */
+		vmcb->save.rip += 3;
+
+		/* Before EOI remote_irr should still be set */
+		report(1 == (int)ioapic_read_redir(0xf).remote_irr,
+			"IOAPIC pass-through: remote_irr=1 before EOI");
+		set_test_stage(test, 3);
+		return false;
+	case 3:
+		/* Jump over VMMCALL instruction */
+		vmcb->save.rip += 3;
+
+		/* After EOI remote_irr should be cleared */
+		report(0 == (int)ioapic_read_redir(0xf).remote_irr,
+			"IOAPIC pass-through: remote_irr=0 after EOI");
+		set_test_stage(test, 4);
+		return false;
+	case 4:
+		break;
+	default:
+		report_fail("Unexpected stage %d", get_test_stage(test));
+	}
+
+	return true;
+}
+
+static bool svm_apic_passthrough_test_check(struct svm_test *test)
+{
+	return get_test_stage(test) == 4;
+}
+
+static void svm_apic_passthrough_tpr_threshold_guest(struct svm_test *test)
+{
+	cli();
+	apic_set_tpr(0);
+}
+
+static bool svm_apic_passthrough_tpr_threshold_ipi_isr_fired;
+static void svm_apic_passthrough_tpr_threshold_ipi_isr(isr_regs_t *regs)
+{
+	svm_apic_passthrough_tpr_threshold_ipi_isr_fired = true;
+	eoi();
+}
+
+static void svm_apic_passthrough_tpr_threshold_test(void)
+{
+	int ipi_vector = 0xe1;
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+	svm_disable_intercept_for_x2apic_msrs();
+
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR);
+	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
+
+	/* Raise L0 TPR-threshold by queueing vector in LAPIC IRR */
+	cli();
+	apic_set_tpr((ipi_vector >> 4) + 1);
+	apic_icr_write(APIC_DEST_SELF | APIC_DEST_PHYSICAL |
+			APIC_DM_FIXED | ipi_vector,
+			0);
+
+	test_set_guest(svm_apic_passthrough_tpr_threshold_guest);
+	clgi();
+	svm_vmrun();
+	stgi();
+
+	report(apic_get_tpr() == 0, "TPR was zero by guest");
+
+	/* Clean pending self-IPI */
+	svm_apic_passthrough_tpr_threshold_ipi_isr_fired = false;
+	handle_irq(ipi_vector, svm_apic_passthrough_tpr_threshold_ipi_isr);
+	sti_nop();
+	report(svm_apic_passthrough_tpr_threshold_ipi_isr_fired, "self-IPI fired");
+}
+
 struct svm_test svm_tests[] = {
 	{ "null", default_supported, default_prepare,
 	  default_prepare_gif_clear, null_test,
@@ -3694,6 +3861,14 @@ struct svm_test svm_tests[] = {
 	{ "vgif", vgif_supported, prepare_vgif_enabled,
 	  default_prepare_gif_clear, test_vgif, vgif_finished,
 	  vgif_check },
+	{ "apic_passthrough", default_supported, svm_apic_passthrough_test_prepare,
+	  default_prepare_gif_clear, svm_apic_passthrough_guest,
+	  svm_apic_passthrough_test_finished, svm_apic_passthrough_test_check},
+	{ "apic_passthrough_thread", default_supported,
+	  svm_apic_passthrough_thread_test_prepare, default_prepare_gif_clear,
+	  svm_apic_passthrough_guest, svm_apic_passthrough_test_finished,
+	  svm_apic_passthrough_test_check},
+	TEST(svm_apic_passthrough_tpr_threshold_test),
 	TEST(svm_cr4_osxsave_test),
 	TEST(svm_guest_state_test),
 	TEST(svm_vmrun_errata_test),
-- 
2.53.0.851.ga537e3e6e9-goog

