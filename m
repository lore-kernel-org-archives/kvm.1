Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28139FCAD;
	Sat,  9 May 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778366932; cv=none; b=R4Ji06RpKd06v1UxIUEIgF41iS6zfK3rt6wYsMUDOxCBElZueR317r8YUtzvJMh+Ez21R2PZkdJwzydN5u0aOc2EPzKuxc2TM8U6CI1fdzN9iomJBISDh3vGM0Qugv6+uZB6f1Gq8TErf4yiln5gkZkVztsWEqVPMFbTtVJnQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778366932; c=relaxed/simple;
	bh=KMlDQw51giIPNiAd+3IIobHYFW0Onpv+ANnz6WgO45g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgxoRhE/dFUrdyib4pJmLGfqYBMr1z4R/8NsmNguGcLWJeqf0wj/AV/rtezL1J2j00kv7l9q82OLvXpte6KKLh9v92kQIKlpW/FNz1ZDN3OWTM0fbPrz+hBFlqCDWafXpShzFJer7wdSinId6s7tjQgUr+q3ihugEDWzTS9JTQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KLhaK8eB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLhaK8eB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=fjV26NrwIY9cQcLo8KkXdG7OKt7Yi3rTCYPgBP8g6KA=; b=KLhaK8eBC6ebOLVUd2G2XJdjhp
	GXwrOjDkaQr8ATVtUHjTxBu5zBqFFwsjGTlzl3hjb+yDwKI/GmtnzkbTLBCprwF5i88X+i2gNfNtu
	AhTzqJLvX1o0xaW7BbsUEpF6HwIzH+C2ZBvSKAi6klr3u/5mYzzCxSJlrpU+cmgbBrcCNwGqty8hx
	MvQC0vAJX2NsYDgXYha5BQc60V0RqWatSl4OwQvuBRfWWCc1TYsEBzZ4dkPj7w/H8YWI9dn5o/cm6
	juwXijSC7WN8YToiRDEbEXHGa1bNmrufksGVCXtjiXykouJq4qg1d6G3d2NX7Gxi1KBXm5+3pWC0N
	o7slZr4g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLqTD-00000008wz8-0RZG;
	Sat, 09 May 2026 22:48:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLqTC-0000000DhHZ-0vyl;
	Sat, 09 May 2026 23:48:26 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 05/30] KVM: selftests: Add KVM/PV clock selftest to prove timer correction
Date: Sat,  9 May 2026 23:46:31 +0100
Message-ID: <20260509224824.3264567-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260509224824.3264567-1-dwmw2@infradead.org>
References: <20260509224824.3264567-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Jack Allister <jalliste@amazon.com>

A VM's KVM/PV clock has an inherent relationship to its TSC. When either
the host system live-updates or the VM is live-migrated this pairing of
the two clock sources should stay the same. In reality this is not the
case without some correction taking place.

The KVM_GET_CLOCK_GUEST/KVM_SET_CLOCK_GUEST ioctls can be used to
perform a correction on the PVTI (PV time information) structure held by
KVM to effectively fix up the kvmclock_offset prior to the guest VM
resuming in either a live-update/migration scenario.

This test proves that without the necessary fixup there is a perceived
change in the guest TSC and KVM/PV clock relationship before and after a
simulated LU/LM takes place, and that the correction eliminates it.

The test:
  1. Snapshots the PVTI at boot (PVTI0).
  2. Induces a change in PVTI data (KVM_REQ_MASTERCLOCK_UPDATE).
  3. Snapshots the PVTI after the change (PVTI1).
  4. Requests correction via KVM_SET_CLOCK_GUEST using PVTI0.
  5. Snapshots the PVTI after correction (PVTI2).

Then samples the TSC at a single point in time and calculates the KVM
clock using each PVTI snapshot. The corrected clock should match the
boot clock to within ±1ns.

The test enumerates multiple TSC frequencies from 1GHz to 5GHz at 500MHz
steps, crossing the 32-bit boundary, to exercise the scaling path at
various ratios. The sleep duration between snapshots is configurable via
the -s/--sleep command line option.

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Jack Allister <jalliste@amazon.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/x86/pvclock_test.c  | 415 ++++++++++++++++++
 2 files changed, 416 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..fb935ae3bf38 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -105,6 +105,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/pvclock_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
 TEST_GEN_PROGS_x86 += x86/smaller_maxphyaddr_emulation_test
diff --git a/tools/testing/selftests/kvm/x86/pvclock_test.c b/tools/testing/selftests/kvm/x86/pvclock_test.c
new file mode 100644
index 000000000000..1a3d52923c71
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pvclock_test.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © Amazon.com, Inc. or its affiliates.
+ *
+ * Tests for pvclock API
+ * KVM_SET_CLOCK_GUEST/KVM_GET_CLOCK_GUEST
+ */
+#include <getopt.h>
+#include <stdint.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock-abi.h>
+
+/*
+ * Reproduce the pvclock calculation the guest uses to convert TSC to
+ * nanoseconds. This must match the kernel's __pvclock_read_cycles().
+ */
+static inline uint64_t pvclock_scale_delta(uint64_t delta, uint32_t mul,
+					   int8_t shift)
+{
+	if (shift < 0)
+		delta >>= -shift;
+	else
+		delta <<= shift;
+	return ((__uint128_t)delta * mul) >> 32;
+}
+
+static inline uint64_t pvclock_read_cycles(struct pvclock_vcpu_time_info *src,
+					   uint64_t tsc)
+{
+	uint64_t delta = tsc - src->tsc_timestamp;
+
+	return src->system_time + pvclock_scale_delta(delta,
+						      src->tsc_to_system_mul,
+						      src->tsc_shift);
+}
+
+enum {
+	STAGE_FIRST_BOOT,
+	STAGE_UNCORRECTED,
+	STAGE_CORRECTED
+};
+
+#define KVMCLOCK_GPA	0xc0000000ull
+#define KVMCLOCK_SIZE	sizeof(struct pvclock_vcpu_time_info)
+
+static void trigger_pvti_update(void)
+{
+	/*
+	 * Toggle between KVM's old and new system time methods to coerce KVM
+	 * into updating the fields in the PV time info struct.
+	 */
+	wrmsr(MSR_KVM_SYSTEM_TIME, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+}
+
+static void guest_code(void)
+{
+	struct pvclock_vcpu_time_info *pvti =
+		(void *)(unsigned long)KVMCLOCK_GPA;
+	struct pvclock_vcpu_time_info pvti_boot;
+	struct pvclock_vcpu_time_info pvti_uncorrected;
+	struct pvclock_vcpu_time_info pvti_corrected;
+	uint64_t tsc_guest;
+	uint64_t clk_boot, clk_uncorrected, clk_corrected;
+	int64_t delta_corrected;
+
+	/* Set up kvmclock and snapshot the initial pvclock parameters. */
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	pvti_boot = *pvti;
+	GUEST_SYNC(STAGE_FIRST_BOOT);
+
+	/*
+	 * Trigger an update of the PVTI. Calculating the KVM clock using this
+	 * updated structure will show a delta from the original.
+	 */
+	trigger_pvti_update();
+	pvti_uncorrected = *pvti;
+	GUEST_SYNC(STAGE_UNCORRECTED);
+
+	/*
+	 * Snapshot the corrected time (the host does KVM_SET_CLOCK_GUEST when
+	 * handling STAGE_UNCORRECTED).
+	 */
+	pvti_corrected = *pvti;
+
+	/*
+	 * Sample the TSC at a single point in time, then calculate the
+	 * effective KVM clock using the PVTI from each stage. Verify that the
+	 * corrected clock matches the boot clock to within ±1ns.
+	 */
+	tsc_guest = rdtsc();
+
+	clk_boot = pvclock_read_cycles(&pvti_boot, tsc_guest);
+	clk_uncorrected = pvclock_read_cycles(&pvti_uncorrected, tsc_guest);
+	clk_corrected = pvclock_read_cycles(&pvti_corrected, tsc_guest);
+
+	delta_corrected = clk_boot - clk_corrected;
+
+	__GUEST_ASSERT(delta_corrected >= -2 && delta_corrected <= 2,
+		       "corrected delta %ld out of range (boot=%lu uncorrected=%lu corrected=%lu)",
+		       delta_corrected, clk_boot, clk_uncorrected, clk_corrected);
+
+	GUEST_SYNC(STAGE_CORRECTED);
+}
+
+static void run_test(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
+		     unsigned int sleep_sec)
+{
+	struct pvclock_vcpu_time_info pvti_before;
+	struct ucall uc;
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_SYNC:
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall");
+		}
+
+		switch (uc.args[1]) {
+		case STAGE_FIRST_BOOT:
+			/* Save the pvclock parameters before the update. */
+			vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &pvti_before);
+
+			/* Sleep to let the clocks diverge. */
+			sleep(sleep_sec);
+			break;
+
+		case STAGE_UNCORRECTED:
+			/* Restore the original pvclock parameters. */
+			vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, &pvti_before);
+			break;
+
+		case STAGE_CORRECTED:
+			/* Guest verified the delta in-guest. */
+			return;
+
+		default:
+			TEST_FAIL("Unknown stage %lu", uc.args[1]);
+		}
+	}
+}
+
+static void configure_pvclock(struct kvm_vm *vm)
+{
+	unsigned int nr_pages;
+
+	nr_pages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, KVMCLOCK_SIZE);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, nr_pages, 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, nr_pages);
+}
+
+static void run_at_frequency(uint64_t tsc_khz, unsigned int sleep_sec)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	pr_info("Testing at TSC frequency %lu kHz\n", tsc_khz);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	configure_pvclock(vm);
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)tsc_khz);
+	run_test(vm, vcpu, sleep_sec);
+	kvm_vm_release(vm);
+}
+
+static void test_tsc_stable_bit(void);
+static void test_clock_guest_with_offsets(void);
+
+static void usage(const char *name)
+{
+	printf("Usage: %s [options]\n"
+	       "  -s, --sleep SEC     sleep duration between snapshots (default: 2)\n"
+	       "  -h, --help          show this help\n", name);
+}
+
+int main(int argc, char *argv[])
+{
+	static const struct option long_opts[] = {
+		{ "sleep", required_argument, NULL, 's' },
+		{ "help",  no_argument,       NULL, 'h' },
+		{ NULL,    0,                  NULL,  0  },
+	};
+	unsigned int sleep_sec = 2;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint64_t host_khz;
+	uint64_t freq;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "s:h", long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 's':
+			sleep_sec = atoi(optarg);
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return opt == 'h' ? 0 : 1;
+		}
+	}
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	configure_pvclock(vm);
+
+	/* First run at native frequency (no scaling). */
+	run_test(vm, vcpu, sleep_sec);
+
+	/*
+	 * Then enumerate a range of TSC frequencies crossing the 32-bit
+	 * boundary, to exercise the scaling path at various ratios.
+	 */
+	host_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	kvm_vm_release(vm);
+
+	for (freq = 1000000; freq <= 5000000; freq += 500000) {
+		if (freq == host_khz)
+			continue;
+		run_at_frequency(freq, sleep_sec);
+	}
+
+	test_tsc_stable_bit();
+	test_clock_guest_with_offsets();
+
+	return 0;
+}
+
+static void guest_code_stable_bit(void)
+{
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	GUEST_SYNC(0);
+	GUEST_SYNC(0);
+	GUEST_SYNC(0);
+}
+
+static void set_tsc_offset(struct kvm_vcpu *vcpu, uint64_t offset)
+{
+	struct kvm_device_attr attr = {
+		.group = KVM_VCPU_TSC_CTRL,
+		.attr = KVM_VCPU_TSC_OFFSET,
+		.addr = (__u64)(uintptr_t)&offset,
+	};
+	vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &attr);
+}
+
+static void run_vcpu_once(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_SYNC:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall");
+	}
+}
+
+static void test_tsc_stable_bit(void)
+{
+	struct pvclock_vcpu_time_info pvti;
+	struct kvm_vcpu *vcpus[2];
+	struct kvm_vm *vm;
+	int ret;
+
+	pr_info("Testing PVCLOCK_TSC_STABLE_BIT with matched/unmatched TSCs\n");
+
+	vm = vm_create_with_vcpus(2, guest_code_stable_bit, vcpus);
+	configure_pvclock(vm);
+
+	/*
+	 * Case 1: All TSCs matched (same frequency and offset).
+	 * Master clock should be active, PVCLOCK_TSC_STABLE_BIT set.
+	 */
+	run_vcpu_once(vcpus[0]);
+
+	ret = __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
+	TEST_ASSERT(!ret, "GET_CLOCK_GUEST should succeed with matched TSCs");
+	TEST_ASSERT(pvti.flags & PVCLOCK_TSC_STABLE_BIT,
+		    "PVCLOCK_TSC_STABLE_BIT should be set with matched TSCs");
+
+	/*
+	 * Case 2: Different TSC offset, same frequency.
+	 * Master clock should still be active (frequency matches), but
+	 * PVCLOCK_TSC_STABLE_BIT should be cleared (offsets differ).
+	 */
+	set_tsc_offset(vcpus[1], 12345678);
+	run_vcpu_once(vcpus[1]);
+	run_vcpu_once(vcpus[0]);
+
+	ret = __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
+	if (ret) {
+		/* Master clock disabled by offset mismatch — old kernel */
+		pr_info("  Skipping offset tests (master clock requires matched offsets)\n");
+		goto out_stable;
+	}
+	TEST_ASSERT(!(pvti.flags & PVCLOCK_TSC_STABLE_BIT),
+		    "PVCLOCK_TSC_STABLE_BIT should be clear with offset-mismatched TSCs");
+
+	/*
+	 * Case 3: Different TSC frequency.
+	 * Master clock should be disabled entirely.
+	 */
+	vcpu_ioctl(vcpus[1], KVM_SET_TSC_KHZ,
+		   (void *)(unsigned long)(__vcpu_ioctl(vcpus[1], KVM_GET_TSC_KHZ, NULL) / 2));
+	/* Write TSC to trigger kvm_synchronize_tsc / kvm_track_tsc_matching */
+	vcpu_set_msr(vcpus[1], MSR_IA32_TSC, 0);
+	run_vcpu_once(vcpus[1]);
+
+	ret = __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "GET_CLOCK_GUEST should fail with frequency-mismatched TSCs, got %d (errno %d)",
+		    ret, errno);
+
+out_stable:
+	kvm_vm_release(vm);
+}
+
+static void test_clock_guest_with_offsets(void)
+{
+	struct pvclock_vcpu_time_info pvti0, pvti1, pvti1_after;
+	struct kvm_vcpu *vcpus[2];
+	struct kvm_vm *vm;
+	int64_t delta;
+	int ret;
+
+	pr_info("Testing KVM_[GS]ET_CLOCK_GUEST with different TSC offsets\n");
+
+	vm = vm_create_with_vcpus(2, guest_code_stable_bit, vcpus);
+	configure_pvclock(vm);
+
+	/* Set different TSC offsets on the two vCPUs */
+	set_tsc_offset(vcpus[0], 0);
+	set_tsc_offset(vcpus[1], 1000000000ull);
+
+	/* Run both to establish kvmclock */
+	run_vcpu_once(vcpus[0]);
+	run_vcpu_once(vcpus[1]);
+
+	/* GET_CLOCK_GUEST on both — should succeed (master clock active) */
+	ret = __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti0);
+	if (ret) {
+		pr_info("  Skipping (master clock requires matched offsets on this kernel)\n");
+		kvm_vm_release(vm);
+		return;
+	}
+	ret = __vcpu_ioctl(vcpus[1], KVM_GET_CLOCK_GUEST, &pvti1);
+	TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu1 failed");
+
+	/* The tsc_timestamps should differ (different offsets) */
+	TEST_ASSERT(pvti0.tsc_timestamp != pvti1.tsc_timestamp,
+		    "tsc_timestamps should differ with different offsets");
+
+	/* Sleep to let time elapse, then restore vcpu0's clock */
+	sleep(1);
+	vcpu_ioctl(vcpus[0], KVM_SET_CLOCK_GUEST, &pvti0);
+
+	/* Run vcpu0 to process the clock update */
+	run_vcpu_once(vcpus[0]);
+
+	/* GET_CLOCK_GUEST on vcpu1 — should reflect the correction */
+	ret = __vcpu_ioctl(vcpus[1], KVM_GET_CLOCK_GUEST, &pvti1_after);
+	TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu1 after SET failed");
+
+	/*
+	 * After SET on vcpu0, verify the correction worked by getting
+	 * the clock on vcpu0 again. The mul/shift should be the same,
+	 * and computing kvmclock at the same TSC should give the same
+	 * result as the original (within ±2ns).
+	 */
+	{
+		struct pvclock_vcpu_time_info pvti0_after;
+		uint64_t tsc_now, clk_from_old, clk_from_new;
+
+		ret = __vcpu_ioctl(vcpus[0], KVM_GET_CLOCK_GUEST, &pvti0_after);
+		TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu0 after SET failed");
+
+		tsc_now = pvti0_after.tsc_timestamp;
+		clk_from_old = pvclock_read_cycles(&pvti0, tsc_now);
+		clk_from_new = pvclock_read_cycles(&pvti0_after, tsc_now);
+
+		delta = (int64_t)clk_from_new - (int64_t)clk_from_old;
+		TEST_ASSERT(delta >= -2 && delta <= 2,
+			    "clock correction delta should be <=2ns, got %ld ns",
+			    delta);
+	}
+
+	/*
+	 * Also verify that vcpu1's clock is still accessible (master
+	 * clock still active with different offsets).
+	 */
+	ret = __vcpu_ioctl(vcpus[1], KVM_GET_CLOCK_GUEST, &pvti1_after);
+	TEST_ASSERT(!ret, "GET_CLOCK_GUEST on vcpu1 after SET failed");
+
+	kvm_vm_release(vm);
+}
-- 
2.51.0

