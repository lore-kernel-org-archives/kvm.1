Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420569;
	b=qkSMs01yvvSSq3e8VsPfZc6ccWPAWWj1I301FeFqA9f5T7kZeEalskzdFRTVA0VvP+E7
	 uvpemYG6dszIYj0fozr7BxRYD1i8AW0ZU9raZmagCG1U5agMkUKRyLJDCVZIhYYfEwIhX
	 mS2eo9PtMC+pbcdMiWNJJrKOijV4C53pR5jM29my0yTkLoEWHIL23ex+urMjLKsQqeLIp
	 09m8BmWxZw1umBYFvBJGkRg9OAO/S7+aNalGFq1H1ucZMVY6eB4ycNn1zDcBh0B0uMq4d
	 fCYLgXzqAKa5qQiBOZqajDKh07IQe+WhrRUBWG15jSFEEZEWG48P3gfmsiHv64iqlJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=GdnbBhvrzYUipflvGAT/EG/9EgSypN3WFvXoLDRRsWY=;
	b=ct63BJi5bPrrV3K33MqZ61OJ6JrvE0ZVqe329pv6P+BzCVD4aHxs4bwlBjq67o6VXb62
	 13QWkXZORsrYWhdf5P0GV703p8XdgrxbjNkDfWFuO7vkRnt1rRr/CoXTMOp2bqjW2e+00
	 SpepMRkeEDBOQzr/5YHmDHwzKn0Ti+cwNj7O6ly3jbIMVrofjUGwEYydiA5Y/sAjADXJ3
	 mFGvJxdXJKU8gQOvSoicPvzDhElpsIh3MTC3VR8VmCNpRE6w02icbUMFmsReyQDXb4JwJ
	 07fnPbCwJySamPkRg3gQ+U4VkwasuZPHVRLDQWsUPoHT8Z0E4gyAwAbJBEgIadLi0UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=HDEZT6oO;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A9606A326;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E47A9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=HDEZT6oO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=GdnbBhvrzYUipflvGAT/EG/9EgSypN3WFvXoLDRRsWY=; b=HDEZT6oOyWC3YLyw/q57JyxYNP
	ipW46XfuTzaA8mRqPqAtsraRuk2E5KoarIv6v/1OXEDLrZdGX8RlJdWzNxJzzDKV8fNKylgdYg/zp
	J1jPEbwumgjyGpA4b4hWOI30PFic7FEwvFFIJUnAx2WSY4V8C/Q/J9Da57rGER89bTBh5auTR89f6
	HZPrNLnWDNMDsoPwOq91pihhvxcGj/vuAD4C8jWFZpQQWhCnTq7qdeVN7jEiUoXJ3+gTkPPy0W/Pi
	6b5dtl6HKuUW3G7By0qYBZC9bZWHoWuUOrJ99kyexdeuPc9ePUx8LV6ejp8y+QrFdJTLrW1Yf0Ca1
	XI5kHu9Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKwD-3HVq;
	Wed, 11 Nov 2026 18:09:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtG-2Rhq;
	Wed, 11 Nov 2026 18:09:23 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sascha Bischoff <Sascha.Bischoff@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Jack Allister <jalliste@amazon.com>,
	Dongli Zhang <dongli.zhang@oracle.com>,
	joe.jin@oracle.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v13 19/26] KVM: selftests: Add KVM/PV clock selftest to prove timer correction
Date: Wed, 11 Nov 2026 10:09:15 -0800
Message-ID: <20261111180922.4177927-20-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111180922.4177927-1-dwmw2@infradead.org>
References: <20261111180922.4177927-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
  2. Steps the KVM clock forward 10 seconds with KVM_SET_CLOCK and
     induces a change in PVTI data, so the divergence the correction
     must eliminate is deterministic.
  3. Snapshots the PVTI after the change (PVTI1).
  4. Requests correction via KVM_SET_CLOCK_GUEST using PVTI0.
  5. Snapshots the PVTI after correction (PVTI2).

Then samples the TSC at a single point in time and calculates the KVM
clock using each PVTI snapshot, verifying that the uncorrected clock
diverged and that the corrected clock matches the boot clock to
within ±2ns.

Also test PVCLOCK_TSC_STABLE_BIT across matched, offset-mismatched
and frequency-mismatched vCPUs, and KVM_[GS]ET_CLOCK_GUEST on vCPUs
with divergent TSC offsets.

The test enumerates multiple TSC frequencies from 1GHz to 5GHz at 500MHz
steps, crossing the 32-bit boundary, to exercise the scaling path at
various ratios. The sleep duration between snapshots is configurable via
the -s/--sleep command line option.

The divergent-offset test steps the VM clock forward between the GET
and the SET and asserts the divergence, so a silently ignored SET
cannot pass — the same discrimination the single-vCPU path already
has. The pvclock arithmetic and guest-side snapshot protocol come from
the shared tools/arch/x86/include/asm/pvclock.h helpers, and only the
scaled-frequency sweep and frequency-mismatch case require
KVM_CAP_TSC_CONTROL; the correction and offset tests still run without
hardware TSC scaling.

Co-developed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Jack Allister <jalliste@amazon.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Cc: Dongli Zhang <dongli.zhang@oracle.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/x86/pvclock_test.c  | 462 ++++++++++++++++++
 2 files changed, 463 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/pvclock_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 18605318860e..15a1a8f64723 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -114,6 +114,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86 += x86/pvclock_migration_test
+TEST_GEN_PROGS_x86 += x86/pvclock_test
 TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
diff --git a/tools/testing/selftests/kvm/x86/pvclock_test.c b/tools/testing/selftests/kvm/x86/pvclock_test.c
new file mode 100644
index 000000000000..cb57f5e2bf1e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pvclock_test.c
@@ -0,0 +1,462 @@
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
+#include <asm/pvclock.h>
+#include <asm/pvclock-abi.h>
+
+static inline void pvti_snapshot(struct pvclock_vcpu_time_info *dst,
+				 volatile struct pvclock_vcpu_time_info *src)
+{
+	const struct pvclock_vcpu_time_info *p = (void *)src;
+	u32 version;
+
+	do {
+		version = pvclock_read_begin(p);
+		*dst = *p;
+	} while (pvclock_read_retry(p, version));
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
+	u64 tsc_guest;
+	u64 clk_boot, clk_uncorrected, clk_corrected;
+	s64 delta_corrected;
+
+	/* Set up kvmclock and snapshot the initial pvclock parameters. */
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	pvti_snapshot(&pvti_boot, pvti);
+	GUEST_SYNC(STAGE_FIRST_BOOT);
+
+	/*
+	 * Trigger an update of the PVTI. Calculating the KVM clock using this
+	 * updated structure will show a delta from the original.
+	 */
+	trigger_pvti_update();
+	pvti_snapshot(&pvti_uncorrected, pvti);
+	GUEST_SYNC(STAGE_UNCORRECTED);
+
+	/*
+	 * Snapshot the corrected time (the host does KVM_SET_CLOCK_GUEST when
+	 * handling STAGE_UNCORRECTED).
+	 */
+	pvti_snapshot(&pvti_corrected, pvti);
+
+	/*
+	 * Sample the TSC at a single point in time, then calculate the
+	 * effective KVM clock using the PVTI from each stage. Verify that the
+	 * corrected clock matches the boot clock to within ±2ns.
+	 */
+	tsc_guest = rdtsc();
+
+	clk_boot = __pvclock_read_cycles(&pvti_boot, tsc_guest);
+	clk_uncorrected = __pvclock_read_cycles(&pvti_uncorrected, tsc_guest);
+	clk_corrected = __pvclock_read_cycles(&pvti_corrected, tsc_guest);
+
+	/*
+	 * The host stepped the KVM clock forward by 10 seconds at
+	 * STAGE_FIRST_BOOT, so the uncorrected clock must diverge; without
+	 * this, a no-op KVM_SET_CLOCK_GUEST would pass the test below.
+	 */
+	__GUEST_ASSERT((s64)(clk_uncorrected - clk_boot) > NSEC_PER_SEC,
+		       "uncorrected clock did not diverge (boot=%lu uncorrected=%lu)",
+		       clk_boot, clk_uncorrected);
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
+	struct kvm_clock_data clock_step;
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
+			vcpu_get_clock_guest(vcpu, &pvti_before);
+
+			/* Sleep to let the clocks diverge. */
+			sleep(sleep_sec);
+
+			/*
+			 * Step the KVM clock forward 10 seconds so that the
+			 * divergence the correction must eliminate is
+			 * deterministic, not at the mercy of accumulated
+			 * drift during the sleep.
+			 */
+			vm_get_clock(vm, &clock_step);
+			clock_step.clock += 10ull * NSEC_PER_SEC;
+			clock_step.flags = 0;
+			vm_set_clock(vm, &clock_step);
+			break;
+
+		case STAGE_UNCORRECTED:
+			/* Restore the original pvclock parameters. */
+			vcpu_set_clock_guest(vcpu, &pvti_before);
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
+	nr_pages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, getpagesize());
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, nr_pages, 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA, nr_pages);
+}
+
+static void run_at_frequency(u64 tsc_khz, unsigned int sleep_sec)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	pr_info("Testing at TSC frequency %lu kHz\n", tsc_khz);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	configure_pvclock(vm);
+	vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)tsc_khz);
+	run_test(vm, vcpu, sleep_sec);
+	kvm_vm_free(vm);
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
+	u64 host_khz;
+	u64 freq;
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "s:h", long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 's':
+			sleep_sec = atoi_non_negative("sleep", optarg);
+			break;
+		case 'h':
+		default:
+			usage(argv[0]);
+			return opt == 'h' ? 0 : 1;
+		}
+	}
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_CLOCK_GUEST));
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
+	kvm_vm_free(vm);
+
+	if (kvm_has_cap(KVM_CAP_TSC_CONTROL)) {
+		for (freq = 1000000; freq <= 5000000; freq += 500000) {
+			if (freq == host_khz)
+				continue;
+			run_at_frequency(freq, sleep_sec);
+		}
+	} else {
+		pr_info("Skipping scaled frequencies (no KVM_CAP_TSC_CONTROL)\n");
+	}
+
+	test_tsc_stable_bit();
+	test_clock_guest_with_offsets();
+
+	return 0;
+}
+
+static volatile u32 vcpu_counter;
+static void guest_code_stable_bit(void)
+{
+	u32 idx = __atomic_fetch_add(&vcpu_counter, 1, __ATOMIC_SEQ_CST);
+	u64 gpa = KVMCLOCK_GPA + idx * KVMCLOCK_SIZE;
+
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, gpa | KVM_MSR_ENABLED);
+	GUEST_SYNC(0);
+	GUEST_SYNC(0);
+	GUEST_SYNC(0);
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
+	vcpu_get_clock_guest(vcpus[0], &pvti);
+	TEST_ASSERT(pvti.flags & PVCLOCK_TSC_STABLE_BIT,
+		    "PVCLOCK_TSC_STABLE_BIT should be set with matched TSCs");
+
+	/*
+	 * Case 2: Different TSC offset, same frequency.
+	 * Master clock should still be active (frequency matches), but
+	 * PVCLOCK_TSC_STABLE_BIT should be cleared (offsets differ).
+	 */
+	vcpu_set_tsc_offset(vcpus[1], 12345678);
+	run_vcpu_once(vcpus[1]);
+	run_vcpu_once(vcpus[0]);
+
+	ret = __vcpu_get_clock_guest(vcpus[0], &pvti);
+	if (ret) {
+		/*
+		 * Master clock disabled by offset mismatch — old kernel.
+		 * -ENODATA is the only legitimate reason to skip; anything
+		 * else is a regression, not an old kernel.
+		 */
+		TEST_ASSERT(errno == ENODATA,
+			    "GET_CLOCK_GUEST failed with unexpected errno %d", errno);
+		pr_info("  Skipping offset test (master clock requires matched offsets)\n");
+		goto case_freq;
+	}
+	TEST_ASSERT(!(pvti.flags & PVCLOCK_TSC_STABLE_BIT),
+		    "PVCLOCK_TSC_STABLE_BIT should be clear with offset-mismatched TSCs");
+
+case_freq:
+	/*
+	 * Case 3: Different TSC frequency.
+	 * Master clock should be disabled entirely.
+	 */
+	if (!kvm_has_cap(KVM_CAP_TSC_CONTROL)) {
+		pr_info("  Skipping frequency-mismatch case (no KVM_CAP_TSC_CONTROL)\n");
+		kvm_vm_free(vm);
+		return;
+	}
+	vcpu_ioctl(vcpus[1], KVM_SET_TSC_KHZ,
+		   (void *)(unsigned long)(__vcpu_ioctl(vcpus[1], KVM_GET_TSC_KHZ, NULL) / 2));
+	/* Write TSC to trigger kvm_synchronize_tsc / kvm_track_tsc_matching */
+	vcpu_set_msr(vcpus[1], MSR_IA32_TSC, 0);
+	run_vcpu_once(vcpus[1]);
+
+	ret = __vcpu_get_clock_guest(vcpus[0], &pvti);
+	TEST_ASSERT(ret && errno == ENODATA,
+		    "GET_CLOCK_GUEST should fail with frequency-mismatched TSCs, got %d (errno %d)",
+		    ret, errno);
+
+	kvm_vm_free(vm);
+}
+
+static void test_clock_guest_with_offsets(void)
+{
+	struct pvclock_vcpu_time_info pvti0, pvti1, pvti1_after;
+	struct kvm_vcpu *vcpus[2];
+	struct kvm_vm *vm;
+	s64 delta;
+	int ret;
+
+	pr_info("Testing KVM_[GS]ET_CLOCK_GUEST with different TSC offsets\n");
+
+	vm = vm_create_with_vcpus(2, guest_code_stable_bit, vcpus);
+	configure_pvclock(vm);
+
+	/* Set different TSC offsets on the two vCPUs */
+	vcpu_set_tsc_offset(vcpus[0], 0);
+	vcpu_set_tsc_offset(vcpus[1], 1000000000ull);
+
+	/* Run both to establish kvmclock */
+	run_vcpu_once(vcpus[0]);
+	run_vcpu_once(vcpus[1]);
+
+	/* GET_CLOCK_GUEST on both — should succeed (master clock active) */
+	ret = __vcpu_get_clock_guest(vcpus[0], &pvti0);
+	if (ret) {
+		TEST_ASSERT(errno == ENODATA,
+			    "GET_CLOCK_GUEST failed with unexpected errno %d", errno);
+		pr_info("  Skipping (master clock requires matched offsets on this kernel)\n");
+		kvm_vm_free(vm);
+		return;
+	}
+	vcpu_get_clock_guest(vcpus[1], &pvti1);
+
+	/* The tsc_timestamps should differ (different offsets) */
+	TEST_ASSERT(pvti0.tsc_timestamp != pvti1.tsc_timestamp,
+		    "tsc_timestamps should differ with different offsets");
+
+	/*
+	 * Step the VM clock forward so that a silently ignored
+	 * KVM_SET_CLOCK_GUEST cannot pass the delta check below: after
+	 * the step, the uncorrected clock computed from pvti0 must
+	 * diverge from the stepped clock, and only an applied SET
+	 * restores the original timeline.
+	 */
+	{
+		struct kvm_clock_data clock_step;
+
+		vm_get_clock(vm, &clock_step);
+		clock_step.clock += 10ull * NSEC_PER_SEC;
+		clock_step.flags = 0;
+		vm_set_clock(vm, &clock_step);
+	}
+
+	{
+		struct pvclock_vcpu_time_info pvti_stepped;
+		s64 diverged;
+
+		vcpu_get_clock_guest(vcpus[0], &pvti_stepped);
+		diverged = (s64)(__pvclock_read_cycles(&pvti_stepped,
+						     pvti_stepped.tsc_timestamp) -
+				 __pvclock_read_cycles(&pvti0,
+						     pvti_stepped.tsc_timestamp));
+		TEST_ASSERT(diverged > (s64)NSEC_PER_SEC,
+			    "clock did not diverge after step, got %ld ns",
+			    diverged);
+	}
+
+	/* Restore vcpu0's original clock */
+	vcpu_set_clock_guest(vcpus[0], &pvti0);
+
+	/* Run vcpu0 to process the clock update */
+	run_vcpu_once(vcpus[0]);
+
+	/*
+	 * After SET on vcpu0, verify the correction worked by getting
+	 * the clock on vcpu0 again. The mul/shift should be the same,
+	 * and computing kvmclock at the same TSC should give the same
+	 * result as the original (within ±2ns).
+	 */
+	{
+		struct pvclock_vcpu_time_info pvti0_after;
+		u64 tsc_now, clk_from_old, clk_from_new;
+
+		vcpu_get_clock_guest(vcpus[0], &pvti0_after);
+
+		TEST_ASSERT(pvti0_after.tsc_to_system_mul == pvti0.tsc_to_system_mul &&
+			    pvti0_after.tsc_shift == pvti0.tsc_shift,
+			    "mul/shift changed across KVM_SET_CLOCK_GUEST");
+
+		tsc_now = pvti0_after.tsc_timestamp;
+		clk_from_old = __pvclock_read_cycles(&pvti0, tsc_now);
+		clk_from_new = __pvclock_read_cycles(&pvti0_after, tsc_now);
+
+		delta = (s64)clk_from_new - (s64)clk_from_old;
+		TEST_ASSERT(delta >= -2 && delta <= 2,
+			    "clock correction delta should be <=2ns, got %ld ns",
+			    delta);
+	}
+
+	/*
+	 * Also verify that vcpu1's clock is still accessible (master
+	 * clock still active with different offsets).
+	 */
+	vcpu_get_clock_guest(vcpus[1], &pvti1_after);
+
+	kvm_vm_free(vm);
+}
-- 
2.43.0

