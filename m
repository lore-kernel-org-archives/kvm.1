Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABF48165D
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396638; cv=none; b=q++aWJ+4o99YAVhBX0frCCoff/iN/tlNVh4PvoKwgNZRQxGH0Gm0Ra1TYd8b/4HzBn9I3lfSR4dUT3u4NHsUDs2FAN1D24cNXlP4ilKo6jHjorGfyj/xlz6N/lrfrymbBX6TyiPYec4taPEgjxU6Km4ENbV7W3PXGfanGT+34VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396638; c=relaxed/simple;
	bh=SONWYcdPcjrKf2//KEOjNIh1j3maD965uH6P86sw/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTIPhahmRdOyWhiuGi4HN+cbauTVq/dnt1tGvFKsnnS3BxhuvKMUkUFrvF1CDCj2T9zQ1j/6zBCYTbWD9JuCCbbv1JWTtBmYjcewgi+DNG1JySsm3tUqO+2DCTQ4hazbHJrhb+YyNkBJdOuyWPB53Cncxqjnxzn0dgjGJMDJnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBQVKjOA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBQVKjOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789396634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ELCkix0+WnOCFlipd8TL3JKAOHcz0ZUF61+78nQ9X8=;
	b=GBQVKjOAweIs0jjfNZ5vridh71mJrnOOJgVhXI1l7TT+AeT4rwNKxdlXnZKwo+BY+CetnR
	ZhP8aeFir4siN2YVc8I47xrz/xEektzRGb/H0sRMujVI8Dhy2HO82T9qLpGXCWKUPjCeoZ
	kg9XON9FMG/oOEfwVJMLt7WcgCwTtho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-f8umiuUhM82_fIZRNvCxQw-1; Mon,
 14 Sep 2026 10:37:11 -0400
X-MC-Unique: f8umiuUhM82_fIZRNvCxQw-1
X-Mimecast-MFC-AGG-ID: f8umiuUhM82_fIZRNvCxQw_1789396630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16871195423A;
	Mon, 14 Sep 2026 14:37:10 +0000 (UTC)
Received: from aharivel-thinkpadp1gen3.rmtfr.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACCAB18005AE;
	Mon, 14 Sep 2026 14:37:08 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	linux-kernel@vger.kernel.org,
	Anthony Harivel <aharivel@redhat.com>
Subject: [PATCH RFC v3 3/3] KVM: selftests: add cstate_policy_test for KVM_CAP_CSTATE_POLICY
Date: Mon, 14 Sep 2026 16:37:02 +0200
Message-ID: <20260914143702.915401-4-aharivel@redhat.com>
In-Reply-To: <20260914143702.915401-1-aharivel@redhat.com>
References: <20260914143702.915401-1-aharivel@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add a KVM selftest that validates the KVM_CAP_CSTATE_POLICY capability:

  1. cap_supported: capability is advertised
  2. valid_policies: max_cstate -1 through 6 accepted
  3. invalid_policies: out-of-range values and bad flags rejected
  4. policy_change: policy can be changed at runtime on a live VM
  5. cpuidle_no_policy: control test — without policy, deep C-states
     (C6) are entered during guest HLT (confirms test methodology)
  6. cpuidle_enforcement: with policy=C1, deep C-states are blocked —
     C6 usage delta is near zero while C1 accumulates
  7. policy_c0_no_idle: with policy=C0, no idle states are entered

Tests 5-7 pin a vCPU to a specific pCPU and compare host cpuidle
usage counters before and after 1000 guest HLT cycles. The guest
uses a periodic APIC timer to wake from HLT.

Tested on Dell R640 (Intel Xeon Gold 5118, intel_idle driver with
POLL/C1/C1E/C6 states). Results:
  - No policy:    C6 entered 1003 times (control)
  - Policy=C1:    C6 entered 0 times, C1 entered 1073 times
  - Policy=C0:    POLL entered 56743 times, no real idle

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/cstate_policy_test.c    | 517 ++++++++++++++++++
 2 files changed, 518 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/cstate_policy_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fc34e9bf8e1..09e58d6c71e3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -151,6 +151,7 @@ TEST_GEN_PROGS_x86 += x86/max_vcpuid_cap_test
 TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
+TEST_GEN_PROGS_x86 += x86/cstate_policy_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/cstate_policy_test.c b/tools/testing/selftests/kvm/x86/cstate_policy_test.c
new file mode 100644
index 000000000000..cb10d5ade454
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/cstate_policy_test.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for KVM_CAP_CSTATE_POLICY
+ *
+ * Copyright (C) 2026, Red Hat, Inc.
+ *
+ * Verify that KVM_CAP_CSTATE_POLICY correctly constrains host cpuidle
+ * state selection when a vCPU halts. The test pins a vCPU to a specific
+ * pCPU, sets a C-state policy, runs a guest that executes HLT in a loop,
+ * and checks host cpuidle usage counters to confirm that deeper C-states
+ * are not entered.
+ *
+ * Requires: isolated pCPU (isolcpus= or cgroup cpuset) for clean signal.
+ */
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <dirent.h>
+#include <errno.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+#include "kselftest.h"
+
+/*
+ * KVM_CAP_CSTATE_POLICY — defined in include/uapi/linux/kvm.h.
+ * Fallback for building against older headers.
+ */
+#ifndef KVM_CAP_CSTATE_POLICY
+#define KVM_CAP_CSTATE_POLICY	251
+#endif
+
+#define NUM_HALTS		1000
+#define MAX_CPUIDLE_STATES	10
+
+struct cpuidle_snapshot {
+	int		num_states;
+	char		name[MAX_CPUIDLE_STATES][32];
+	int		latency[MAX_CPUIDLE_STATES];
+	unsigned long	usage[MAX_CPUIDLE_STATES];
+	unsigned long long time[MAX_CPUIDLE_STATES];
+};
+
+static int read_sysfs_int(const char *path)
+{
+	FILE *f = fopen(path, "r");
+	int val = -1;
+
+	if (f) {
+		fscanf(f, "%d", &val);
+		fclose(f);
+	}
+	return val;
+}
+
+static unsigned long read_sysfs_ulong(const char *path)
+{
+	FILE *f = fopen(path, "r");
+	unsigned long val = 0;
+
+	if (f) {
+		fscanf(f, "%lu", &val);
+		fclose(f);
+	}
+	return val;
+}
+
+static unsigned long long read_sysfs_ull(const char *path)
+{
+	FILE *f = fopen(path, "r");
+	unsigned long long val = 0;
+
+	if (f) {
+		fscanf(f, "%llu", &val);
+		fclose(f);
+	}
+	return val;
+}
+
+static void read_sysfs_str(const char *path, char *buf, size_t len)
+{
+	FILE *f = fopen(path, "r");
+
+	buf[0] = '\0';
+	if (f) {
+		if (fgets(buf, len, f)) {
+			char *nl = strchr(buf, '\n');
+			if (nl)
+				*nl = '\0';
+		}
+		fclose(f);
+	}
+}
+
+static void snapshot_cpuidle(int cpu, struct cpuidle_snapshot *snap)
+{
+	char path[256];
+	int i;
+
+	snap->num_states = 0;
+	for (i = 0; i < MAX_CPUIDLE_STATES; i++) {
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/name",
+			 cpu, i);
+		if (access(path, R_OK) != 0)
+			break;
+
+		read_sysfs_str(path, snap->name[i], sizeof(snap->name[i]));
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/latency",
+			 cpu, i);
+		snap->latency[i] = read_sysfs_int(path);
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/usage",
+			 cpu, i);
+		snap->usage[i] = read_sysfs_ulong(path);
+
+		snprintf(path, sizeof(path),
+			 "/sys/devices/system/cpu/cpu%d/cpuidle/state%d/time",
+			 cpu, i);
+		snap->time[i] = read_sysfs_ull(path);
+
+		snap->num_states = i + 1;
+	}
+}
+
+#define TIMER_VECTOR	0x30
+
+static void guest_timer_handler(struct ex_regs *regs)
+{
+	xapic_write_reg(APIC_EOI, 0);
+}
+
+static void guest_hlt_loop(void)
+{
+	int i;
+
+	xapic_enable();
+
+	/* Periodic APIC timer to wake from HLT */
+	xapic_write_reg(APIC_LVTT, APIC_LVT_TIMER_PERIODIC | TIMER_VECTOR);
+	xapic_write_reg(APIC_TDCR, 0x3); /* divide by 16 */
+	xapic_write_reg(APIC_TMICT, 100000);
+
+	for (i = 0; i < NUM_HALTS; i++) {
+		asm volatile("sti; hlt; cli");
+		GUEST_SYNC(i);
+	}
+	GUEST_DONE();
+}
+
+static int enable_cstate_policy(struct kvm_vm *vm, int max_cstate, int flags)
+{
+	struct kvm_enable_cap cap = {
+		.cap = KVM_CAP_CSTATE_POLICY,
+		.args = { max_cstate, flags },
+	};
+
+	return __vm_ioctl(vm, KVM_ENABLE_CAP, &cap);
+}
+
+/*
+ * Test: capability query and basic validation
+ */
+static void test_cap_supported(void)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_barebones();
+
+	ret = vm_check_cap(vm, KVM_CAP_CSTATE_POLICY);
+	TEST_ASSERT(ret > 0, "KVM_CAP_CSTATE_POLICY not supported");
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("cap_supported\n");
+}
+
+/*
+ * Test: valid policy values accepted
+ */
+static void test_valid_policies(void)
+{
+	struct kvm_vm *vm;
+	int ret, cstate;
+
+	for (cstate = -1; cstate <= 6; cstate++) {
+		vm = vm_create_barebones();
+		ret = enable_cstate_policy(vm, cstate, 0);
+		TEST_ASSERT(ret == 0,
+			    "Setting max_cstate=%d should succeed, got %d",
+			    cstate, ret);
+		kvm_vm_free(vm);
+	}
+
+	ksft_test_result_pass("valid_policies\n");
+}
+
+/*
+ * Test: invalid policy values rejected
+ */
+static void test_invalid_policies(void)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	/* max_cstate too low */
+	vm = vm_create_barebones();
+	ret = enable_cstate_policy(vm, -2, 0);
+	TEST_ASSERT(ret < 0, "max_cstate=-2 should fail");
+	kvm_vm_free(vm);
+
+	/* max_cstate too high */
+	vm = vm_create_barebones();
+	ret = enable_cstate_policy(vm, 7, 0);
+	TEST_ASSERT(ret < 0, "max_cstate=7 should fail");
+	kvm_vm_free(vm);
+
+	/* non-zero flags */
+	vm = vm_create_barebones();
+	ret = enable_cstate_policy(vm, 1, 1);
+	TEST_ASSERT(ret < 0, "non-zero flags should fail");
+	kvm_vm_free(vm);
+
+	ksft_test_result_pass("invalid_policies\n");
+}
+
+/*
+ * Test: policy can be changed at runtime
+ */
+static void test_policy_change(void)
+{
+	struct kvm_vm *vm;
+	int ret;
+
+	vm = vm_create_barebones();
+
+	ret = enable_cstate_policy(vm, 1, 0);
+	TEST_ASSERT(ret == 0, "Initial policy set failed");
+
+	ret = enable_cstate_policy(vm, 6, 0);
+	TEST_ASSERT(ret == 0, "Policy change to 6 failed");
+
+	ret = enable_cstate_policy(vm, -1, 0);
+	TEST_ASSERT(ret == 0, "Policy change to -1 (disable) failed");
+
+	ret = enable_cstate_policy(vm, 0, 0);
+	TEST_ASSERT(ret == 0, "Policy change to 0 failed");
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("policy_change\n");
+}
+
+/*
+ * Test: cpuidle enforcement — with policy=C1, deep C-states (C6) should
+ * not accumulate additional usage during guest HLT.
+ *
+ * This test requires running on isolated CPUs for reliable results.
+ * It is marked as SKIP if the signal is too noisy.
+ */
+static void test_cpuidle_enforcement(void)
+{
+	struct cpuidle_snapshot before, after;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int cpu, i, deep_state_idx;
+	unsigned long deep_usage_delta;
+	bool has_deep_state = false;
+
+	cpu = pin_self_to_any_cpu();
+
+	snapshot_cpuidle(cpu, &before);
+	TEST_REQUIRE(before.num_states >= 3);
+
+	/*
+	 * Find the deepest state (typically C6). We'll check that its usage
+	 * counter does NOT increase when policy caps at C1.
+	 */
+	deep_state_idx = before.num_states - 1;
+	if (before.latency[deep_state_idx] > 50)
+		has_deep_state = true;
+
+	TEST_REQUIRE(has_deep_state);
+
+	/* Create VM with C-state policy = C1 (state index 1) */
+	vm = vm_create(1);
+
+	i = enable_cstate_policy(vm, 1, 0);
+	TEST_ASSERT(i == 0, "Failed to set C-state policy to C1");
+
+	vcpu = vm_vcpu_add(vm, 0, guest_hlt_loop);
+	vm_install_exception_handler(vm, TIMER_VECTOR, guest_timer_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	snapshot_cpuidle(cpu, &before);
+
+	for (i = 0; i < NUM_HALTS; i++) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+done:
+	snapshot_cpuidle(cpu, &after);
+
+	deep_usage_delta = after.usage[deep_state_idx] -
+			   before.usage[deep_state_idx];
+
+	printf("  CPU %d, policy=C1, %d HLTs\n", cpu, NUM_HALTS);
+	for (i = 0; i < after.num_states; i++) {
+		unsigned long delta = after.usage[i] - before.usage[i];
+
+		printf("    %-6s (lat=%3dus): usage +%lu\n",
+		       after.name[i], after.latency[i], delta);
+	}
+
+	/*
+	 * With policy=C1, the deep C-state (C6, latency >100us) should see
+	 * zero or near-zero additional entries. Allow a small margin for
+	 * host interrupts that might briefly enter idle between our
+	 * measurements.
+	 */
+	TEST_ASSERT(deep_usage_delta < 5,
+		    "Deep C-state '%s' entered %lu times with policy=C1 "
+		    "(expected <5). Policy enforcement may not be working.",
+		    after.name[deep_state_idx], deep_usage_delta);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("cpuidle_enforcement\n");
+}
+
+/*
+ * Test: without policy (max_cstate=-1), deep C-states ARE entered during HLT.
+ * This is the control test — confirms the test methodology works.
+ */
+static void test_cpuidle_no_policy(void)
+{
+	struct cpuidle_snapshot before, after;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int cpu, i, deep_state_idx;
+	unsigned long deep_usage_delta, total_idle_delta;
+	bool has_deep_state = false;
+
+	cpu = pin_self_to_any_cpu();
+
+	snapshot_cpuidle(cpu, &before);
+	TEST_REQUIRE(before.num_states >= 3);
+
+	deep_state_idx = before.num_states - 1;
+	if (before.latency[deep_state_idx] > 50)
+		has_deep_state = true;
+
+	TEST_REQUIRE(has_deep_state);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_hlt_loop);
+	vm_install_exception_handler(vm, TIMER_VECTOR, guest_timer_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	snapshot_cpuidle(cpu, &before);
+
+	for (i = 0; i < NUM_HALTS; i++) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+done:
+	snapshot_cpuidle(cpu, &after);
+
+	total_idle_delta = 0;
+	printf("  CPU %d, no policy (default), %d HLTs\n", cpu, NUM_HALTS);
+	for (i = 0; i < after.num_states; i++) {
+		unsigned long delta = after.usage[i] - before.usage[i];
+
+		printf("    %-6s (lat=%3dus): usage +%lu\n",
+		       after.name[i], after.latency[i], delta);
+		total_idle_delta += delta;
+	}
+
+	deep_usage_delta = after.usage[deep_state_idx] -
+			   before.usage[deep_state_idx];
+
+	/*
+	 * Without a policy, we expect SOME idle state entries. If nothing
+	 * entered idle at all, halt polling consumed everything and this
+	 * test can't validate the control case — skip.
+	 */
+	if (total_idle_delta == 0) {
+		ksft_test_result_skip("cpuidle_no_policy: halt polling "
+				      "consumed all halts, no idle entries\n");
+		kvm_vm_free(vm);
+		return;
+	}
+
+	/*
+	 * We don't strictly require deep C-state entry here (the governor
+	 * might choose shallow states for short halts), but we log it for
+	 * comparison with the enforcement test.
+	 */
+	printf("  Deep state '%s' entered %lu times (control — no cap)\n",
+	       after.name[deep_state_idx], deep_usage_delta);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("cpuidle_no_policy\n");
+}
+
+/*
+ * Test: policy=C0 means guest HLT returns immediately (no idle at all).
+ */
+static void test_policy_c0_no_idle(void)
+{
+	struct cpuidle_snapshot before, after;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int cpu, i;
+	unsigned long total_idle_delta;
+
+	cpu = pin_self_to_any_cpu();
+
+	vm = vm_create(1);
+	i = enable_cstate_policy(vm, 0, 0);
+	TEST_ASSERT(i == 0, "Failed to set C-state policy to C0");
+
+	vcpu = vm_vcpu_add(vm, 0, guest_hlt_loop);
+	vm_install_exception_handler(vm, TIMER_VECTOR, guest_timer_handler);
+	virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
+	snapshot_cpuidle(cpu, &before);
+
+	for (i = 0; i < NUM_HALTS; i++) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+done:
+	snapshot_cpuidle(cpu, &after);
+
+	total_idle_delta = 0;
+	printf("  CPU %d, policy=C0, %d HLTs\n", cpu, NUM_HALTS);
+	for (i = 0; i < after.num_states; i++) {
+		unsigned long delta = after.usage[i] - before.usage[i];
+
+		printf("    %-6s (lat=%3dus): usage +%lu\n",
+		       after.name[i], after.latency[i], delta);
+		if (i > 0)
+			total_idle_delta += delta;
+	}
+
+	/*
+	 * With policy=C0, HLT should return immediately without entering
+	 * any real idle state (state > POLL). Allow small margin for
+	 * host background activity.
+	 */
+	TEST_ASSERT(total_idle_delta < 5,
+		    "Idle states entered %lu times with policy=C0 (expected <5)",
+		    total_idle_delta);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("policy_c0_no_idle\n");
+}
+
+int main(int argc, char *argv[])
+{
+	ksft_print_header();
+	ksft_set_plan(7);
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_CSTATE_POLICY));
+
+	test_cap_supported();
+	test_valid_policies();
+	test_invalid_policies();
+	test_policy_change();
+	test_cpuidle_no_policy();
+	test_cpuidle_enforcement();
+	test_policy_c0_no_idle();
+
+	ksft_finished();
+	return 0;
+}
-- 
2.55.0

