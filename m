Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420569;
	b=unlxx7mFZuMhXx02sZtqcrkRbPagJVOFmekEuO1PuArfaqyalx5zo4Ry8903e3rs+ytW
	 FimOTk7oJF62KXhXULEFTjTRlhDPaiMlYZEuCRKRX7GrFLpSe4asX0Sw4yllT0F/EAYUA
	 diLnho4/EUS0Xa40pIDvX0ffkFbw8WUezM4IBKKBL7dvUXqHTG1LiV6HzN2rpaULpSyJ1
	 UyqsQNQ2HWSrl8r2Wrj0J5jL3YslsT+9ZZcRGhvfADAMovHF8quxdmbyBJVzsLRNIdDhW
	 4GqG1FumkX5a0Zctzo/NnYi7p61u/4pdcVL9nqOxGGSwwI3aV+GS0L7Jtu5VTa2AT/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420569;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=O1JSbo6dSmTIhtBA7w37syORnO0n3Px43xR/cCKp3Ls=;
	b=Q15iBFOCycAQhfuOjRJ2LNIDdt6l6YAbrb9j+RKUP8OVOwOd0gjzdS6/wVoOrAq+2g0C
	 R9Bh7YqE8b+3EBUcFMeaqS6b0hHykKZMLcW6R26kObpW4EYTZv110T/M3JKLjMLsnDKX2
	 gdeG8gLpAdDpyGIVnL1GkwuVXdE786/Takec5uiP4kv3mv64Y4/nxb+2yfigPheiyauhf
	 1ISdDrEPzgIqHG2mz/STY82dA9f2/bKQW9UdzipeXebUpsdqxiGSwFogtNRz9gp1JivBD
	 74Kzt7WOszSAEHdJbOYpIWbhnP34r3shYIibN07kAnDamHQkmsTI8LzLoqm67p0EdvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dF+Qcltt;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4807606A32A;
	Wed, 11 Nov 2026 18:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4807606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=dF+Qcltt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=O1JSbo6dSmTIhtBA7w37syORnO0n3Px43xR/cCKp3Ls=; b=dF+QclttGB67d05ZX6xmyNH9Ee
	A7i8Y/K5tS7G7dHg2HYXybS1iMzjpS6NO86Ex8A9na/dr4IsVdb5PPT15TNx7oxv0oUit7UTdXIEF
	Z4DXMTYafIaajHYREMsk1wGYAqXWx89lOXxztRt5QQlx1zcQglsM4+H2S1Fk1OY7f4oAfGysIHe59
	nKLwAzaW8ujFQrXcJYeV8mnxo/z6RHweT6OMtpHM0EsrvdyF9jG9ebJaYkvo5p0Ibkpm0QWa2wn1B
	3NdLhWvLmD13ZCO7YrUqM9jonW20nnxYCYJFHIuOyMOpsTXTXhrzfVKhaT7sfh6T4reNZQhuHvjbw
	IIjUXJmg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRCl9-0000000CKwL-3SfK;
	Wed, 11 Nov 2026 18:09:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtK-2d6D;
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
Subject: [PATCH v13 20/26] KVM: selftests: Add master clock offset test
Date: Wed, 11 Nov 2026 10:09:16 -0800
Message-ID: <20261111180922.4177927-21-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Verify that KVM master clock mode remains active when vCPUs have
different TSC offsets but the same frequency. Creates three vCPUs,
sets one to a different TSC value, and confirms:

 - KVM_CLOCK_HOST_TSC is set (master clock active)
 - KVM_CLOCK_TSC_STABLE IS set (master clock ⇒ stable flag)
 - PVCLOCK_TSC_STABLE_BIT is NOT set (offsets differ)

Then set the KVM clock forward one hour with KVM_SET_CLOCK and verify
that all vCPUs still agree on the KVM clock computed from their own
pvclock parameters.

This remains a separate binary from pvclock_test deliberately: the
rdtsc()-plus-offset arithmetic here is exact only at the default host
frequency, while pvclock_test sweeps scaled frequencies, and the two
must not inherit each other's constraints.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/masterclock_offset_test.c         | 249 ++++++++++++++++++
 2 files changed, 250 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/masterclock_offset_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 15a1a8f64723..4d4eff41c525 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -95,6 +95,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
+TEST_GEN_PROGS_x86 += x86/masterclock_offset_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
new file mode 100644
index 000000000000..7d0fe97cedc4
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that KVM master clock mode works with different TSC offsets
+ * as long as all vCPUs have the same TSC frequency.
+ */
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock.h>
+#include <asm/pvclock-abi.h>
+
+#define KVMCLOCK_GPA	0xc0000000ull
+#define TSC_OFFSET	(1000000000ULL)
+
+#define NR_VCPUS	3
+
+/* Read the per-vCPU pvclocks in an order other than creation order. */
+static const int vcpu_order[NR_VCPUS] = {0, 2, 1};
+
+static void guest_code(u64 pvti_gpa)
+{
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, pvti_gpa | KVM_MSR_ENABLED);
+	for (;;)
+		GUEST_SYNC(0);
+}
+
+static void get_pvtis(struct kvm_vcpu **vcpus,
+		      struct pvclock_vcpu_time_info *pvti)
+{
+	int i;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		int idx = vcpu_order[i];
+
+		vcpu_get_clock_guest(vcpus[idx], &pvti[idx]);
+		pr_info("vCPU %d: tsc_timestamp=%lu system_time=%lu "
+			"mul=%u shift=%d flags=0x%x\n",
+			idx, (unsigned long)pvti[idx].tsc_timestamp,
+			(unsigned long)pvti[idx].system_time,
+			pvti[idx].tsc_to_system_mul, pvti[idx].tsc_shift,
+			pvti[idx].flags);
+	}
+}
+
+static void run_all_vcpus(struct kvm_vcpu **vcpus)
+{
+	int i;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		vcpu_run(vcpus[vcpu_order[i]]);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpus[vcpu_order[i]], KVM_EXIT_IO);
+	}
+}
+
+/*
+ * The guest-visible pvclock pages must carry exactly what the ioctl
+ * reports: in master clock mode both are derived from the same master
+ * snapshot. Requires every vCPU to have run since the last masterclock
+ * update, so the pages are written from the settled snapshot.
+ */
+static void assert_guest_pages_match(struct kvm_vm *vm,
+				     struct pvclock_vcpu_time_info *pvti,
+				     const char *what)
+{
+	int i;
+
+	for (i = 0; i < NR_VCPUS; i++) {
+		struct pvclock_vcpu_time_info *guest_pvti =
+			addr_gpa2hva(vm, KVMCLOCK_GPA + i *
+				     sizeof(struct pvclock_vcpu_time_info) * 2);
+
+		TEST_ASSERT(guest_pvti->tsc_timestamp == pvti[i].tsc_timestamp &&
+			    guest_pvti->system_time == pvti[i].system_time &&
+			    guest_pvti->tsc_to_system_mul == pvti[i].tsc_to_system_mul &&
+			    guest_pvti->tsc_shift == pvti[i].tsc_shift,
+			    "%s: vCPU%d guest page pvclock should match KVM_GET_CLOCK_GUEST",
+			    what, i);
+	}
+}
+
+/*
+ * Read the host TSC once and feed it through each vCPU's pvclock
+ * (adding each vCPU's TSC offset). All must compute exactly the same
+ * kvmclock value.
+ */
+static void assert_pvclocks_match(struct pvclock_vcpu_time_info *pvti,
+				  u64 offset0, const char *what)
+{
+	u64 host_tsc, clk0, clk1, clk2;
+
+	host_tsc = rdtsc();
+	clk0 = __pvclock_read_cycles(&pvti[0], host_tsc + offset0);
+	clk1 = __pvclock_read_cycles(&pvti[1], host_tsc + offset0);
+	clk2 = __pvclock_read_cycles(&pvti[2], host_tsc + offset0 + TSC_OFFSET);
+
+	pr_info("%s: kvmclock via vCPU 0: %lu ns, vCPU 1: %lu ns, vCPU 2: %lu ns\n",
+		what, (unsigned long)clk0, (unsigned long)clk1,
+		(unsigned long)clk2);
+	TEST_ASSERT(clk0 == clk1 && clk0 == clk2,
+		    "%s: kvmclock from all vCPUs should match exactly "
+		    "(0: %lu, 1: %lu, 2: %lu)", what, (unsigned long)clk0,
+		    (unsigned long)clk1, (unsigned long)clk2);
+}
+
+static void test_masterclock_active(struct kvm_vm *vm,
+				    struct kvm_clock_data *clock)
+{
+	memset(clock, 0, sizeof(*clock));
+	vm_get_clock(vm, clock);
+	pr_info("KVM_GET_CLOCK flags: 0x%x\n", clock->flags);
+	TEST_ASSERT(clock->flags & KVM_CLOCK_HOST_TSC,
+		    "Master clock should be active, flags=0x%x", clock->flags);
+	TEST_ASSERT(clock->flags & KVM_CLOCK_TSC_STABLE,
+		    "KVM_CLOCK_TSC_STABLE should be set, flags=0x%x",
+		    clock->flags);
+}
+
+static void test_offset_consistency(struct kvm_vcpu **vcpus,
+				    struct pvclock_vcpu_time_info *pvti,
+				    u64 offset0)
+{
+	u64 gtsc0, gtsc1, gtsc2;
+
+	get_pvtis(vcpus, pvti);
+
+	/* Read guest TSCs: should see (0+OFF) < 2 < (1+OFF) */
+	gtsc0 = vcpu_get_msr(vcpus[0], MSR_IA32_TSC);
+	gtsc2 = vcpu_get_msr(vcpus[2], MSR_IA32_TSC);
+	gtsc1 = vcpu_get_msr(vcpus[1], MSR_IA32_TSC);
+	pr_info("Guest TSCs: vcpu0=%lu vcpu2=%lu vcpu1=%lu\n",
+		(unsigned long)gtsc0, (unsigned long)gtsc2,
+		(unsigned long)gtsc1);
+	TEST_ASSERT(gtsc0 + TSC_OFFSET < gtsc2 && gtsc2 < gtsc1 + TSC_OFFSET,
+		    "Expected (vcpu0+OFF) < vcpu2 < (vcpu1+OFF)");
+
+	/* PVCLOCK_TSC_STABLE_BIT should NOT be set (offsets differ) */
+	TEST_ASSERT(!(pvti[2].flags & PVCLOCK_TSC_STABLE_BIT),
+		    "PVCLOCK_TSC_STABLE_BIT should NOT be set, flags=0x%x",
+		    pvti[2].flags);
+
+	/* Same mul/shift */
+	TEST_ASSERT(pvti[0].tsc_to_system_mul == pvti[1].tsc_to_system_mul &&
+		    pvti[0].tsc_to_system_mul == pvti[2].tsc_to_system_mul &&
+		    pvti[0].tsc_shift == pvti[1].tsc_shift &&
+		    pvti[0].tsc_shift == pvti[2].tsc_shift,
+		    "All vCPUs should have same mul/shift");
+
+	assert_pvclocks_match(pvti, offset0, "Initial");
+}
+
+#define ONE_HOUR_NS (3600ULL * NSEC_PER_SEC)
+
+static void test_set_clock_consistency(struct kvm_vm *vm,
+				       struct kvm_vcpu **vcpus,
+				       struct pvclock_vcpu_time_info *pvti,
+				       struct kvm_clock_data *clock,
+				       u64 offset0)
+{
+	struct kvm_clock_data setclk = { .clock = clock->clock + ONE_HOUR_NS };
+	u64 clk0;
+
+	/*
+	 * Add an hour to the VM kvmclock via KVM_SET_CLOCK, run each
+	 * vCPU to pick up the update, and check they're still in sync.
+	 */
+	vm_set_clock(vm, &setclk);
+
+	/*
+	 * KVM_SET_CLOCK refreshes the master snapshot synchronously and
+	 * broadcasts a clock update, so a single pass rewrites every
+	 * guest pvclock page from the settled snapshot. Run two passes
+	 * anyway, so this flow doesn't silently depend on that: after a
+	 * per-vCPU write which parks a masterclock update on one vCPU
+	 * (as the TSC-offset writes in main() do), the first pass
+	 * services it and only the second rewrites every page.
+	 */
+	run_all_vcpus(vcpus);
+	run_all_vcpus(vcpus);
+
+	get_pvtis(vcpus, pvti);
+	assert_guest_pages_match(vm, pvti, "After +1h");
+
+	TEST_ASSERT(pvti[0].system_time == pvti[1].system_time &&
+		    pvti[0].system_time == pvti[2].system_time,
+		    "system_time should still match after KVM_SET_CLOCK");
+
+	assert_pvclocks_match(pvti, offset0, "After +1h");
+
+	/* Verify the clock actually moved by ~1 hour */
+	clk0 = __pvclock_read_cycles(&pvti[0], rdtsc() + offset0);
+	TEST_ASSERT(clk0 > ONE_HOUR_NS,
+		    "Clock should be > 1 hour after set, got %lu ns",
+		    (unsigned long)clk0);
+}
+
+int main(void)
+{
+	struct pvclock_vcpu_time_info pvti[NR_VCPUS];
+	struct kvm_vcpu *vcpus[NR_VCPUS];
+	struct kvm_clock_data clock;
+	struct kvm_vm *vm;
+	u64 offset0;
+	int nr_pages;
+	int i;
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_CLOCK_GUEST));
+
+	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
+
+	TEST_REQUIRE(!__vcpu_has_device_attr(vcpus[0], KVM_VCPU_TSC_CTRL,
+					     KVM_VCPU_TSC_OFFSET));
+
+	nr_pages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, getpagesize());
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1, nr_pages, 0);
+
+	/* Give each vCPU its own pvclock structure within the page */
+	for (i = 0; i < NR_VCPUS; i++)
+		vcpu_args_set(vcpus[i], 1, KVMCLOCK_GPA +
+			      i * sizeof(struct pvclock_vcpu_time_info) * 2);
+
+	/* Get vCPU 0's default offset and set vCPU 2's offset higher */
+	offset0 = vcpu_get_tsc_offset(vcpus[0]);
+	vcpu_set_tsc_offset(vcpus[2], offset0 + TSC_OFFSET);
+
+	/*
+	 * Run each vCPU twice to enable kvmclock (with the offset already
+	 * set): the first pass services the masterclock update requested
+	 * by the offset write, the second rewrites every guest pvclock
+	 * page from the settled snapshot.
+	 */
+	run_all_vcpus(vcpus);
+	run_all_vcpus(vcpus);
+
+	test_masterclock_active(vm, &clock);
+	test_offset_consistency(vcpus, pvti, offset0);
+	assert_guest_pages_match(vm, pvti, "Initial");
+	pr_info("PASSED: pvclock consistent across offset vCPUs\n");
+
+	test_set_clock_consistency(vm, vcpus, pvti, &clock, offset0);
+	pr_info("PASSED: pvclock still consistent after KVM_SET_CLOCK +1h\n");
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

