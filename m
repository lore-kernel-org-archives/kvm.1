Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A828DC4
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051445; cv=none; b=Ia//8c6xRSQnpuFx/uR2aMDu/caDcmAeGG4gEV8CsRz6HvdOK1Qvcy1XLgmfYOutmvgHuI+kVPFeYqt70Nwb0HFV28/e8+RJoEJmwzXcB5PQHqPdMZy/EDWCelGBfyu3sLEyknTTXeScvieHPgZybDd46FMjq8XzB2RNvjxI6MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051445; c=relaxed/simple;
	bh=dktA9++J9r6aTcq4akdt9LRxdp6c0lEXVyWcz/evdyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/vyhcbRQ8C8PvOQvEAsIizrh+dJ7gt+2ZeHUMpZc/gmCj3kwXmtJ2kQDlsnFoJnYGq111unr+XDpRNz0MjRIXp18QJ2TWbGP0O9QstO03YBr3KutPIP6ONh29w5ak71XLQaJoh0OOVnkXEWBKPI4lhf26Vs/ajyrFjdAbp7xTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nt5B2sNc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nt5B2sNc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84256bee9a9so3860480b3a.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781051439; x=1781656239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oF92QU8113CX/4r9ArdYbVmsuzWRuNLZzrfHHoxXZyU=;
        b=Nt5B2sNce02J/CUhUOV1TnT1llZmXFCDkcLinmlRigl3cddNYlmv+nYmSHCsOtjow/
         VaPSOOJWeYL91QKttJEungX1Cjg8e2sqR2ElgagD8419N5d8CVIYqXuMaykCZnZCUQNj
         0LRuiwbb017fOQq9U1PYNlXKtGut8uzMqFb4TPt/2hZf8enxmAquEAnJteDg2V14/qDD
         EXOGzXKC+/UDePnGyIZ4Uu5TRHEfbAy3+wo9mdRp7LtCR/mu9j6c0iLjgO90dReoH2v7
         Z/XeEI/NYxN5MG1NyRgRJgDilqHH0Wpn/LSTC6VSSzPVeFjw2LqRd0LMtRTRpZTiG3rI
         2b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051439; x=1781656239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oF92QU8113CX/4r9ArdYbVmsuzWRuNLZzrfHHoxXZyU=;
        b=iEXzSh41mM/w9LAglG9Xt5wcvLwXo6gDrgBzwW9OTjyi/CKiE1iqo+7DCtZmJuvgAH
         FP5MawfnD5kZh/GBSDyEuK2eiBcTXgNc+DbxgrxaAHOG2AeRcraKYpZlffJk7D2Bw+PK
         lGy8v7ob09hfVGa6UZlnJHh5ZjUaliiZeyQd10K/9zVDglJk3uXI2Hc86N/EWnX0SVWD
         0dsp1HMLfiRSgnpjYpHMJ1TQRwm7qFaxqXHY2E0inXORFKr652sEMHeIAwCzFCM3Glcg
         sVWpXdP9/gIeHlw7yUah5QSXOx0E25AsNZCP6L0CfdPUayGOlkb6DhaX9y8trBjF4Ifn
         rDLg==
X-Gm-Message-State: AOJu0YyHhjbANxVTHNN3xC7qPKBa2D1qJMbAUY4so82vsmXT0EMplDrO
	4RFZIKNkmbRL8iqRMY1DVg7mcO3bJnOPWelhnyPdDcb80FEVXkMQEveP+hWlqbbig7rrE+C2OSN
	60koyLg==
X-Received: from pfbff21.prod.google.com ([2002:a05:6a00:2f55:b0:842:377a:c843])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e23:b0:842:66f3:c51c
 with SMTP id d2e1a72fcca58-842b0fb6c50mr22565386b3a.40.1781051438214; Tue, 09
 Jun 2026 17:30:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:30:30 -0700
In-Reply-To: <20260610003030.2957261-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610003030.2957261-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610003030.2957261-6-seanjc@google.com>
Subject: [PATCH v8 5/5] KVM: selftests: Add svm_pmu_host_guest_test for
 Host-Only/Guest-Only bits
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Jim Mattson <jmattson@google.com>

Add a selftest to verify KVM correctly virtualizes the AMD PMU Host-Only
(bit 41) and Guest-Only (bit 40) event selector bits across all relevant
SVM state transitions.

The test programs 4 PMCs simultaneously with all combinations of the
Host-Only and Guest-Only bits, then verifies correct counting behavior
with EFER.SVME clear and set, as well as in host mode and guest mode.
The test also verifies that updating Host-Only / Guest-Only bits for a
PMC works as intended, and that event filtering is still respected.

Signed-off-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 215 ++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e0ddd3ff9472..9462919d2660 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -120,6 +120,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
+TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 98537cc8840d..608ed83d7c6a 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -38,6 +38,12 @@
 #define ARCH_PERFMON_EVENTSEL_INV		BIT_ULL(23)
 #define ARCH_PERFMON_EVENTSEL_CMASK		GENMASK_ULL(31, 24)
 
+/*
+ * These are AMD-specific bits.
+ */
+#define AMD64_EVENTSEL_GUESTONLY		BIT_ULL(40)
+#define AMD64_EVENTSEL_HOSTONLY			BIT_ULL(41)
+
 /* RDPMC control flags, Intel only. */
 #define INTEL_RDPMC_METRICS			BIT_ULL(29)
 #define INTEL_RDPMC_FIXED			BIT_ULL(30)
diff --git a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
new file mode 100644
index 000000000000..c5b5cd788d93
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nested SVM PMU Host-Only/Guest-Only test
+ *
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test that KVM correctly virtualizes the AMD PMU Host-Only (bit 41) and
+ * Guest-Only (bit 40) event selector bits across all SVM state
+ * transitions.
+ *
+ * Programs 4 PMCs simultaneously with all combinations of Host-Only and
+ * Guest-Only bits, then verifies correct counting behavior with different
+ * combinations of EFER.SVME and host/guest mode -- as well as event filtering.
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "pmu.h"
+
+#define EVENTSEL_RETIRED_INSNS	(ARCH_PERFMON_EVENTSEL_OS |	\
+				 ARCH_PERFMON_EVENTSEL_USR |	\
+				 ARCH_PERFMON_EVENTSEL_ENABLE |	\
+				 AMD_ZEN_INSTRUCTIONS_RETIRED)
+
+/* PMC configurations: index corresponds to Host-Only | Guest-Only bits */
+#define PMC_NONE	0  /* Neither bit set */
+#define PMC_G		1  /* Guest-Only bit set */
+#define PMC_H		2  /* Host-Only bit set */
+#define PMC_HG		3  /* Both bits set */
+#define NR_PMCS		4
+
+#define LOOP_INSNS	1000
+
+static __always_inline void run_instruction_loop(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < LOOP_INSNS; i++)
+		__asm__ __volatile__("nop");
+}
+
+static __always_inline void read_counters(uint64_t *counts)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++)
+		counts[i] = rdmsr(MSR_F15H_PERF_CTR + 2 * i);
+}
+
+static __always_inline void run_and_measure(uint64_t *deltas)
+{
+	uint64_t before[NR_PMCS], after[NR_PMCS];
+	int i;
+
+	read_counters(before);
+	run_instruction_loop();
+	read_counters(after);
+
+	for (i = 0; i < NR_PMCS; i++)
+		deltas[i] = after[i] - before[i];
+}
+
+static void assert_pmc_counts(uint64_t *deltas, unsigned int expected_counting)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++) {
+		if (expected_counting & BIT(i))
+			GUEST_ASSERT_NE(deltas[i], 0);
+		else
+			GUEST_ASSERT_EQ(deltas[i], 0);
+	}
+}
+
+static uint64_t l2_deltas[NR_PMCS];
+
+static void l2_guest_code(void)
+{
+	run_and_measure(l2_deltas);
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t deltas[NR_PMCS];
+	uint64_t eventsel;
+	int i;
+
+	/* Program 4 PMCs with all combinations of Host-Only/Guest-Only bits */
+	for (i = 0; i < NR_PMCS; i++) {
+		eventsel = EVENTSEL_RETIRED_INSNS;
+		if (i & PMC_G)
+			eventsel |= AMD64_EVENTSEL_GUESTONLY;
+		if (i & PMC_H)
+			eventsel |= AMD64_EVENTSEL_HOSTONLY;
+		wrmsr(MSR_F15H_PERF_CTL + 2 * i, eventsel);
+		wrmsr(MSR_F15H_PERF_CTR + 2 * i, 0);
+	}
+
+	/* Step 1: SVME=0 - Only the counter with neither bits set counts */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE));
+
+	/* Step 2: Set SVME=1 - In L1 "host mode"; Guest-Only stops */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 3: VMRUN to L2 - In "guest mode"; Host-Only stops */
+	generic_svm_setup(svm, l2_guest_code);
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	assert_pmc_counts(l2_deltas, BIT(PMC_NONE) | BIT(PMC_G) | BIT(PMC_HG));
+
+	/* Step 4: After VMEXIT to L1 - Back in "host mode"; Guest-Only stops */
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 5: Set KVM_PMU_EVENT_DENY - all counters stop */
+	GUEST_SYNC(KVM_PMU_EVENT_DENY);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, 0);
+
+	/* Step 6: Set KVM_PMU_EVENT_ALLOW - back to all except Guest-only */
+	GUEST_SYNC(KVM_PMU_EVENT_ALLOW);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 7: Clear Host-Only for PMC_HG - counter stops in "host mode" */
+	eventsel = rdmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG);
+	wrmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG, eventsel & ~AMD64_EVENTSEL_HOSTONLY);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H));
+
+	/* Step 8: Restore Host-Only for PMC_HG - counter counts again */
+	wrmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG, eventsel);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 9: Clear SVME - Only the counter with neither bits set counts */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE));
+
+	GUEST_DONE();
+}
+
+static struct kvm_pmu_event_filter *alloc_event_filter(u64 event)
+{
+	struct kvm_pmu_event_filter *filter;
+
+	filter = malloc(sizeof(*filter) + sizeof(event));
+	TEST_ASSERT(filter != NULL, "Filter allocation failed");
+
+	memset(filter, 0, sizeof(*filter));
+	memcpy(filter->events, &event, sizeof(event));
+	filter->nevents = 1;
+	filter->action = KVM_PMU_EVENT_ALLOW;
+
+	return filter;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_pmu_event_filter *filter;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t svm_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+	TEST_REQUIRE(kvm_is_mediated_pmu_enabled());
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	filter = alloc_event_filter(AMD_ZEN_INSTRUCTIONS_RETIRED);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			goto done;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_SYNC:
+			filter->action = uc.args[1];
+			vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, filter);
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+			goto done;
+		}
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0.1099.g489fc7bff1-goog

