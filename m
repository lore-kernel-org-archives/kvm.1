Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319D45D5F5;
	Tue, 28 Jul 2026 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250220; cv=none; b=iRzzVI4Frpq1rrUtbkF1zPbGOSNCN9lDjhmvSm2lAq1TR30/cFyWjQ2UCIwG4KjCRdAGrLVKP4anSJDVQdcCfV+v6BWMfunCPLAyo9GaUMewR3UHLeMebLrNkeh1mF5YiNMlFsSrLQbS70wVxY3gE7jZ2TD+gaurQ058VhgyqxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250220; c=relaxed/simple;
	bh=2AVjOQu8cZ+xHCjoQIt0PatsubDtrEo1YaED+pWcBDA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6RDCR9vz06V/vexT+85rZ3CDS9e1cQjSZao0F0qHoaD/bz28YMh4JVa/oMnvPtvRzellTxIHbuk2HcIvB1jHn0ZCjl3xMFI5isR02ZJNt1nrUAMsJu0HUOyu7zMPQHbIB9HSPBcZcGCG1CM6UN8N0qRHVneXIqEYRptoCUqqbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JOHaDrqv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JOHaDrqv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=x2xSqS7e8FBOCcPpiOhTMYKg8ozG39niUAQrIOEk/A8=; b=JOHaDrqvK090x0RSRF/PIKJTnV
	FmtgYrpwSeXHDWGsA+tiDap7GABi/+lWvkv9R1FF1LUf3waoTJpjCMQcxzB/iZlO+3ddInW9mYB/b
	g2dtZkwa2UMDaDPRTz91cHEtdLA6k7vem5b8/sxJU1sZ/BFkgE6TNRr4+ytI1AThll/OFaETPOBuA
	jbh15RbtiCHsdF2+kAB2Tpb6wjmHDnUKdZJ3wYUzEiJMxocWqIiQDH52pIlKXNaT9QeJignU404dz
	Ht0QF+kYfpeTPz86Kb7PeYr/DR3ViY+wqGdpfu8G8MK19+70zpKgbF4yLRxaTYXvNYEMKE5FIWSyl
	EVaNnURg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1woj82-000000052Vk-35of;
	Tue, 28 Jul 2026 14:49:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1woj80-00000001Ua7-2wQn;
	Tue, 28 Jul 2026 15:49:56 +0100
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
Subject: [PATCH v7 35/36] KVM: selftests: Add Xen/generic CPUID timing leaf test
Date: Tue, 28 Jul 2026 15:40:15 +0100
Message-ID: <20260728144954.355376-36-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728144954.355376-1-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Verify that userspace can correctly populate Xen and generic CPUID
timing leaves using the KVM_VCPU_TSC_SCALE and
KVM_VCPU_TSC_SCALE attributes.

This validates that the removal of KVM's runtime Xen CPUID modification
doesn't break guests: userspace queries the effective TSC and bus
frequencies, computes the pvclock mul/shift, populates the CPUID leaves,
and the guest verifies the values match.

The test exercises:
 - KVM_VCPU_TSC_SCALE at native and scaled frequencies
 - KVM_VCPU_TSC_SCALE ratio verification against effective frequency
 - Generic timing leaf 0x40000010 (EAX=tsc_khz, EBX=bus_khz)
 - Xen leaf 3 sub-leaf 0 (ECX=guest TSC kHz)
 - Xen leaf 3 sub-leaf 1 (ECX=mul, EDX=shift)

Gracefully skips TSC scaling tests on hardware without support.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/xen_cpuid_timing_test.c | 230 ++++++++++++++++++
 2 files changed, 231 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f6027a35f790..2029190f86d1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -145,6 +145,7 @@ TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
+TEST_GEN_PROGS_x86 += x86/xen_cpuid_timing_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
new file mode 100644
index 000000000000..2098cb511ef0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that userspace can correctly populate Xen and generic CPUID
+ * timing leaves using KVM_GET_TSC_KHZ and KVM_VCPU_TSC_SCALE.
+ *
+ * This validates that the removal of KVM's runtime Xen CPUID modification
+ * doesn't break guests, because userspace has all the information needed.
+ */
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock-abi.h>
+
+#define XEN_CPUID_BASE		0x40000100
+#define XEN_CPUID_LEAF(n)	(XEN_CPUID_BASE + (n))
+#define GENERIC_TIMING_LEAF	0x40000010
+
+/* Values set by host, verified by guest */
+static uint32_t expected_tsc_khz;
+static uint32_t expected_bus_khz;
+static uint32_t expected_tsc_mul;
+static int8_t   expected_tsc_shift;
+static uint64_t host_khz;
+
+static void guest_code(void)
+{
+	uint32_t eax, ebx, ecx, edx;
+
+	/* Check generic timing leaf 0x40000010 */
+	__cpuid(GENERIC_TIMING_LEAF, 0, &eax, &ebx, &ecx, &edx);
+	GUEST_ASSERT_EQ(eax, expected_tsc_khz);
+	GUEST_ASSERT_EQ(ebx, expected_bus_khz);
+
+	/* Check Xen leaf 3, sub-leaf 0: ECX = guest TSC frequency */
+	__cpuid(XEN_CPUID_LEAF(3), 0, &eax, &ebx, &ecx, &edx);
+	GUEST_ASSERT_EQ(ecx, expected_tsc_khz);
+
+	/* Check Xen leaf 3, sub-leaf 1: ECX = mul, EDX = shift */
+	__cpuid(XEN_CPUID_LEAF(3), 1, &eax, &ebx, &ecx, &edx);
+	GUEST_ASSERT_EQ(ecx, expected_tsc_mul);
+	GUEST_ASSERT_EQ((int8_t)edx, expected_tsc_shift);
+
+	GUEST_SYNC(0);
+}
+
+static void add_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function,
+			    uint32_t index, uint32_t eax, uint32_t ebx,
+			    uint32_t ecx, uint32_t edx)
+{
+	struct kvm_cpuid2 *cpuid = vcpu->cpuid;
+	struct kvm_cpuid_entry2 *entry;
+	int n = cpuid->nent;
+
+	vcpu->cpuid = realloc(vcpu->cpuid,
+			      sizeof(*cpuid) + (n + 1) * sizeof(*entry));
+	cpuid = vcpu->cpuid;
+	cpuid->nent = n + 1;
+
+	entry = &cpuid->entries[n];
+	memset(entry, 0, sizeof(*entry));
+	entry->function = function;
+	entry->index = index;
+	entry->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+	entry->eax = eax;
+	entry->ebx = ebx;
+	entry->ecx = ecx;
+	entry->edx = edx;
+}
+
+/*
+ * Compute pvclock mul/shift from frequency, matching kvm_get_time_scale().
+ */
+static void compute_tsc_mul_shift(uint64_t tsc_hz, uint32_t *mul, int8_t *shift)
+{
+	uint64_t scaled = 1000000000ULL;
+	uint64_t base = tsc_hz;
+	int32_t s = 0;
+	uint32_t base32;
+
+	while (base > scaled * 2 || base >> 32) {
+		base >>= 1;
+		s--;
+	}
+	base32 = (uint32_t)base;
+	while (base32 <= scaled || scaled >> 32) {
+		if (scaled >> 32 || base32 & (1U << 31))
+			scaled >>= 1;
+		else
+			base32 <<= 1;
+		s++;
+	}
+	*mul = (uint32_t)((scaled << 32) / base32);
+	*shift = (int8_t)s;
+}
+
+static void run_test(uint64_t tsc_khz)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint32_t effective_tsc_khz, effective_bus_khz;
+	int bus_cycle_ns;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	if (tsc_khz) {
+		pr_info("Testing at TSC frequency %lu kHz\n", tsc_khz);
+		vcpu_ioctl(vcpu, KVM_SET_TSC_KHZ, (void *)(unsigned long)tsc_khz);
+	} else {
+		pr_info("Testing at native TSC frequency\n");
+	}
+
+	effective_tsc_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	bus_cycle_ns = vm_check_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS);
+	effective_bus_khz = bus_cycle_ns > 0 ? 1000000 / bus_cycle_ns : 1000000;
+
+	/* If scaling wasn't applied, skip this frequency */
+	if (tsc_khz && effective_tsc_khz == host_khz) {
+		pr_info("  TSC scaling not available, skipping\n");
+		kvm_vm_free(vm);
+		return;
+	}
+
+	pr_info("  Effective TSC: %u kHz, Bus: %u kHz\n", effective_tsc_khz, effective_bus_khz);
+
+	/* Also exercise KVM_VCPU_TSC_SCALE if available */
+	{
+		struct { uint64_t ratio; uint64_t frac_bits; } scale;
+		struct kvm_device_attr scale_attr = {
+			.group = KVM_VCPU_TSC_CTRL,
+			.attr = KVM_VCPU_TSC_SCALE,
+			.addr = (uint64_t)(uintptr_t)&scale,
+		};
+
+		if (!__vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &scale_attr)) {
+			vcpu_ioctl(vcpu, KVM_GET_DEVICE_ATTR, &scale_attr);
+			pr_info("  TSC scale: ratio=%lu frac_bits=%lu\n",
+				scale.ratio, scale.frac_bits);
+
+			/*
+			 * Verify: applying the ratio to the host TSC frequency
+			 * should give approximately the effective frequency.
+			 */
+			if (tsc_khz) {
+				uint64_t computed = ((__uint128_t)host_khz * scale.ratio) >> scale.frac_bits;
+				int64_t diff = (int64_t)computed - (int64_t)effective_tsc_khz;
+
+				TEST_ASSERT(diff >= -1 && diff <= 1,
+					    "TSC_SCALE ratio mismatch: computed %lu vs effective %u (diff %ld)",
+					    computed, effective_tsc_khz, diff);
+			}
+		}
+	}
+
+	compute_tsc_mul_shift((uint64_t)effective_tsc_khz * 1000,
+			      &expected_tsc_mul, &expected_tsc_shift);
+
+	expected_tsc_khz = effective_tsc_khz;
+	expected_bus_khz = effective_bus_khz;
+
+	sync_global_to_guest(vm, expected_tsc_khz);
+	sync_global_to_guest(vm, expected_bus_khz);
+	sync_global_to_guest(vm, expected_tsc_mul);
+	sync_global_to_guest(vm, expected_tsc_shift);
+
+	/* Populate CPUID leaves as a VMM would */
+	add_cpuid_entry(vcpu, GENERIC_TIMING_LEAF, 0,
+			effective_tsc_khz, effective_bus_khz, 0, 0);
+	add_cpuid_entry(vcpu, XEN_CPUID_LEAF(3), 0,
+			0, 0, effective_tsc_khz, 0);
+	add_cpuid_entry(vcpu, XEN_CPUID_LEAF(3), 1,
+			0, 0, expected_tsc_mul,
+			(uint32_t)(uint8_t)expected_tsc_shift);
+
+	vcpu_set_cpuid(vcpu);
+
+	pr_info("  pvclock mul=%u shift=%d\n", expected_tsc_mul, expected_tsc_shift);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_SYNC:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall");
+	}
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	uint64_t freq;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct kvm_device_attr attr = {
+		.group = KVM_VCPU_TSC_CTRL,
+		.attr = KVM_VCPU_TSC_SCALE,
+	};
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	/* Check KVM_VCPU_TSC_SCALE is supported (implies TSC scaling) */
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	TEST_REQUIRE(!__vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &attr));
+	host_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	kvm_vm_free(vm);
+
+	/* Native frequency */
+	run_test(0);
+
+	/* Scaled frequencies — skip if TSC scaling not available */
+	for (freq = 1000000; freq <= 4000000; freq += 1000000) {
+		if (freq == host_khz)
+			continue;
+		run_test(freq);
+	}
+
+	pr_info("PASS: All CPUID timing leaf tests passed\n");
+	return 0;
+}
-- 
2.55.0

