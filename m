Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=ofQj6whpgweKxa1OUOHoOZ8b9cZ4LJBNVpzMqWVQdesbhb57CBN7ULZPKq2KpzgIKsjk
	 N3IUwBIbdOtUEtK5R7i7qnjV/zkSVjuDvHk5TEtZ+V/iLAcqWNJ/9pyy1uqDLCKIXEIMI
	 W3Q/gen5tQ/BzbvRw2MnUfaANhjYS4R0DVhg/5qhOv89eQEoaozijJS/B6GfBgfzRMlE9
	 GoNpawiVzugBEaMzoIB4HkKwjVPo8bSPANze/5lSGh8fcdGdMO+5k3u9xZucSQnIEKHMK
	 yf5ccb6CvLt57I2mIpaOry1uDn/C1rtl9N8xzJUww/dqYYWZ8PaFVQa3bTXeU7PNo/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=cXjQZKqIl2OYPcFHIBDb+bTEqqXL97xMp1LRSEJsias=;
	b=VIUKEfHGE7JMKNLXuZazj+d54AkJsh38TQN2lEBaOGkIK7TDnVByFf/SricOnaDE8MFC
	 N0F476RQkkeIzB8NoEeGyQ2W+hBv4AyDISNY4dfSLLNW1BGjDVMRkRlqTx01hSHaF+l8T
	 N1Qf62ubAAauCfXh+e6RPy4qpbVBveFidEFWXmmAszRILYj4OmxjGalDsSqmjA0WMOUfv
	 PTLqSiM8NwF5l1uB6y1ZDVBi3KZNF5JRJCiF5LWAoQ0bWCGbLYLosu/LaBx5n6BLCxZXG
	 C/9VXBvUHMBnd8Y724GS6xYp2W9r+3Oyf+ln5yR60yE+78udg+fIynsNnXIm4VLgpxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aEYDQ803;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FD606B7B0;
	Wed, 11 Nov 2026 18:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 115FD606B7B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=aEYDQ803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=cXjQZKqIl2OYPcFHIBDb+bTEqqXL97xMp1LRSEJsias=; b=aEYDQ803CRaehE4cut3cAiMuGk
	plgaJ+v+zciptCjVs+y7SKylPtGeqiFg6EyAFTILn+LQ8SPH6IggBpbvP/pVChFgXGCgsxrUIMM6z
	sJbBUr1S7vcqfLaYQYa9QMperqX8B8E9llZOTBrgmSknUi+PY0QhsR0D0eLuWxB9RJD785TPl8b0k
	Xnfk/zjsWJbw81WfvsgzsOOPmR+8/OUdJXM7J9a37peSj9IS+cEEPCs0f9rf0uoq6YWgofBS7dxVy
	WBjdAz/8KiPxEtAPEferIrkBBOPfbHjofdzbjNeVsEuMmqaBiNy9q79bPRlIciywVYVI/c5qg8jHF
	8OBYFeFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvT-3DMi;
	Wed, 11 Nov 2026 18:09:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtO-2oOe;
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
Subject: [PATCH v13 21/26] KVM: selftests: Add Xen/generic CPUID timing leaf test
Date: Wed, 11 Nov 2026 10:09:17 -0800
Message-ID: <20261111180922.4177927-22-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Verify that userspace can correctly populate Xen and generic CPUID
timing leaves using the KVM_GET_TSC_KHZ ioctl and
KVM_VCPU_TSC_SCALE attribute.

This validates that commit 7d3bd21e457b ("KVM: x86: Remove runtime Xen
TSC frequency CPUID update") doesn't break guests: userspace queries
the effective TSC and bus frequencies, computes the pvclock mul/shift,
populates the CPUID leaves, and the guest verifies the values match.

The test exercises:
 - KVM_GET_TSC_KHZ at native and scaled frequencies
 - KVM_VCPU_TSC_SCALE ratio verification against effective frequency
 - Generic timing leaf 0x40000010 (EAX=tsc_khz, EBX=bus_khz)
 - Xen leaf 3 sub-leaf 0 (ECX=guest TSC kHz)
 - Xen leaf 3 sub-leaf 1 (ECX=mul, EDX=shift)

Where KVM_CAP_XEN_HVM is available, the guest is given the Xen
signature leaf and the Xen hypercall MSR is enabled — the exact
configuration in which the removed runtime update used to fire — and
a sentinel is planted in leaf 3 sub-leaf 2 EAX, where it used to
write, which the guest verifies survives untouched.

The scaled runs are skipped on hardware without TSC scaling. For a
requested frequency within tsc_tolerance_ppm of the host's (where no
scaling engages and the ratio stays identity), only the ratio
cross-check is skipped, and the skip is gated on the frequencies
themselves — read from the kernel's actual tsc_tolerance_ppm — not on
the reported ratio, which is exactly what a broken KVM would get
wrong. Results go through the kselftest TAP machinery, a fixed plan
of five.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/xen_cpuid_timing_test.c | 293 ++++++++++++++++++
 2 files changed, 294 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 4d4eff41c525..79d26de18bf3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -152,6 +152,7 @@ TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
+TEST_GEN_PROGS_x86 += x86/xen_cpuid_timing_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
new file mode 100644
index 000000000000..33b5300efa03
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_cpuid_timing_test.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that userspace can correctly populate Xen and generic CPUID
+ * timing leaves using KVM_GET_TSC_KHZ and KVM_VCPU_TSC_SCALE.
+ *
+ * This validates that the removal of KVM's runtime Xen CPUID modification
+ * doesn't break guests, because userspace has all the information needed.
+ */
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+
+#define XEN_CPUID_BASE		0x40000100
+#define XEN_CPUID_LEAF(n)	(XEN_CPUID_BASE + (n))
+#define GENERIC_TIMING_LEAF	0x40000010
+
+/*
+ * Sentinel in Xen leaf 3 sub-leaf 2 EAX (where the removed runtime
+ * update used to write the vCPU's tsc_khz): it must survive untouched.
+ */
+#define XEN_SENTINEL		0xdeadbeef
+
+/* Values set by host, verified by guest */
+static u32 expected_tsc_khz;
+static u32 expected_bus_khz;
+static u32 expected_tsc_mul;
+static s8   expected_tsc_shift;
+static u64 host_khz;
+static bool xen_enabled;
+
+static void guest_code(void)
+{
+	u32 eax, ebx, ecx, edx;
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
+	GUEST_ASSERT_EQ((s8)edx, expected_tsc_shift);
+
+	if (xen_enabled) {
+		/*
+		 * With the Xen signature present and Xen enabled, verify the
+		 * sentinel survives: KVM's removed runtime CPUID update used
+		 * to clobber this sub-leaf for exactly this configuration.
+		 */
+		__cpuid(XEN_CPUID_LEAF(3), 2, &eax, &ebx, &ecx, &edx);
+		GUEST_ASSERT_EQ(eax, XEN_SENTINEL);
+	}
+
+	GUEST_SYNC(0);
+}
+
+static void add_cpuid_entry(struct kvm_vcpu *vcpu, u32 function,
+			    u32 index, u32 eax, u32 ebx,
+			    u32 ecx, u32 edx)
+{
+	struct kvm_cpuid2 *cpuid = vcpu->cpuid;
+	struct kvm_cpuid_entry2 *entry;
+	int n = cpuid->nent;
+
+	cpuid = realloc(vcpu->cpuid,
+			sizeof(*cpuid) + (n + 1) * sizeof(*entry));
+	TEST_ASSERT(cpuid, "Failed to grow vCPU CPUID array");
+	vcpu->cpuid = cpuid;
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
+static void compute_tsc_mul_shift(u64 tsc_hz, u32 *mul, s8 *shift)
+{
+	u64 scaled = 1000000000ULL;
+	u64 base = tsc_hz;
+	s32 s = 0;
+	u32 base32;
+
+	while (base > scaled * 2 || base >> 32) {
+		base >>= 1;
+		s--;
+	}
+	base32 = (u32)base;
+	while (base32 <= scaled || scaled >> 32) {
+		if (scaled >> 32 || base32 & (1U << 31))
+			scaled >>= 1;
+		else
+			base32 <<= 1;
+		s++;
+	}
+	*mul = (u32)((scaled << 32) / base32);
+	*shift = (s8)s;
+}
+
+static void run_test(u64 tsc_khz)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	u32 effective_tsc_khz, effective_bus_khz;
+	int bus_cycle_ns, ret;
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
+	ret = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	TEST_ASSERT(ret > 0, "KVM_GET_TSC_KHZ failed: %d", ret);
+	effective_tsc_khz = ret;
+	bus_cycle_ns = vm_check_cap(vm, KVM_CAP_X86_APIC_BUS_CYCLES_NS);
+	effective_bus_khz = bus_cycle_ns > 0 ? 1000000 / bus_cycle_ns : 1000000;
+
+	pr_info("  Effective TSC: %u kHz, Bus: %u kHz\n", effective_tsc_khz, effective_bus_khz);
+
+	/* Also exercise KVM_VCPU_TSC_SCALE if available */
+	if (!__vcpu_has_device_attr(vcpu, KVM_VCPU_TSC_CTRL,
+				    KVM_VCPU_TSC_SCALE)) {
+		struct kvm_vcpu_tsc_scale scale;
+
+		vcpu_device_attr_get(vcpu, KVM_VCPU_TSC_CTRL,
+				     KVM_VCPU_TSC_SCALE, &scale);
+		pr_info("  TSC scale: ratio=%llu frac_bits=%llu\n",
+			scale.tsc_ratio, scale.tsc_frac_bits);
+
+		/*
+		 * A requested frequency within tsc_tolerance_ppm of the
+		 * host's does not engage hardware scaling: the effective
+		 * frequency is the requested one but the ratio stays 1.0,
+		 * so the ratio cross-check cannot hold. Skip only that
+		 * check — the CPUID leaf population and guest verification
+		 * below are about the effective frequency and remain valid.
+		 *
+		 * Judge "within tolerance" from the frequencies, not from
+		 * the reported ratio: an identity ratio for a frequency
+		 * far outside tolerance is exactly the regression the
+		 * cross-check exists to catch, and must not take the skip
+		 * path. Read the kernel's actual tsc_tolerance_ppm, and
+		 * compute the bounds exactly as kvm_set_tsc_khz() does
+		 * (multiply then truncate), so the window matches even at
+		 * its edges and when the parameter has been tuned.
+		 */
+		u64 tol_ppm = get_kvm_param_integer("tsc_tolerance_ppm");
+		u64 thresh_lo = host_khz * (1000000 - tol_ppm) / 1000000;
+		u64 thresh_hi = host_khz * (1000000 + tol_ppm) / 1000000;
+		bool within_tol = tsc_khz >= thresh_lo &&
+				  tsc_khz <= thresh_hi;
+
+		if (tsc_khz && within_tol &&
+		    scale.tsc_ratio == (1ULL << scale.tsc_frac_bits)) {
+			pr_info("  Requested frequency within host tolerance; scaling not engaged, skipping ratio cross-check\n");
+		} else if (tsc_khz) {
+			/*
+			 * Verify: applying the ratio to the host TSC frequency
+			 * should give approximately the effective frequency.
+			 */
+			u64 computed = ((__uint128_t)host_khz * scale.tsc_ratio) >> scale.tsc_frac_bits;
+			s64 diff = (s64)computed - (s64)effective_tsc_khz;
+
+			TEST_ASSERT(diff >= -1 && diff <= 1,
+				    "TSC_SCALE ratio mismatch: computed %lu vs effective %u (diff %ld)",
+				    computed, effective_tsc_khz, diff);
+		}
+	}
+
+	compute_tsc_mul_shift((u64)effective_tsc_khz * 1000,
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
+			(u32)(s32)expected_tsc_shift);
+
+	/*
+	 * Where possible, make this a real Xen guest: install the Xen
+	 * signature leaf and enable the Xen hypercall MSR, which is the
+	 * configuration in which KVM's removed runtime CPUID update used
+	 * to fire, and plant a sentinel where it used to write.
+	 */
+	xen_enabled = kvm_has_cap(KVM_CAP_XEN_HVM);
+	if (xen_enabled) {
+		struct kvm_xen_hvm_config cfg = {
+			.msr = 0x40000200,
+		};
+
+		vm_ioctl(vm, KVM_XEN_HVM_CONFIG, &cfg);
+		add_cpuid_entry(vcpu, XEN_CPUID_BASE, 0, XEN_CPUID_LEAF(4),
+				0x566e6558 /* "XenV" */,
+				0x65584d4d /* "MMXe" */,
+				0x4d4d566e /* "nVMM" */);
+		add_cpuid_entry(vcpu, XEN_CPUID_LEAF(3), 2,
+				XEN_SENTINEL, 0, 0, 0);
+	}
+	sync_global_to_guest(vm, xen_enabled);
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
+	u64 freq;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	bool have_tsc_scale;
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	have_tsc_scale = !__vcpu_has_device_attr(vcpu, KVM_VCPU_TSC_CTRL,
+						 KVM_VCPU_TSC_SCALE);
+	host_khz = __vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL);
+	kvm_vm_free(vm);
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	/* Native frequency */
+	run_test(0);
+	ksft_test_result_pass("native frequency (%lu kHz)\n",
+			      (unsigned long)host_khz);
+
+	/* Scaled frequencies, when hardware TSC scaling is available */
+	for (freq = 1000000; freq <= 4000000; freq += 1000000) {
+		if (!have_tsc_scale) {
+			ksft_test_result_skip("%lu kHz (no TSC scaling)\n",
+					      (unsigned long)freq);
+		} else if (freq == host_khz) {
+			ksft_test_result_skip("%lu kHz is the host frequency\n",
+					      (unsigned long)freq);
+		} else {
+			run_test(freq);
+			ksft_test_result_pass("%lu kHz\n", (unsigned long)freq);
+		}
+	}
+
+	ksft_finished();
+}
-- 
2.43.0

