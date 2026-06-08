Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6813F58D8;
	Mon,  8 Jun 2026 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780930524; cv=none; b=aK0m0jYhLkkrDKGzWOTkQOcCNqSBUBN7fJrdmhM2X+v0bVuYb9yLspAkcbtE7Gq+3TxLDEiIQx8JGyFN6l6KEIEZtZjv6UGGxvDrMLk2dnWRz3ELAC//LQSAYi5+Ur1IR4b8642kdkZ+WT5QVr/dgn0vFDfBGtjACN+VM25ynrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780930524; c=relaxed/simple;
	bh=EXs3rlRXtX9lEtce+/2A07D+59JhdlafBkWnhKLQCtc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjTK4HDUWgFnKHbwzsJRoCnlzYjc5MTMd2m8FuuGiw+HcsZDAZKKAnBmqlGX3BUh0i1YJtWvAOGliV62asjp4s7rWQ0ED4CZoB1YIcD/dSGdhXQ4UFAk34PUuqaHhcZSiL53zBUgCVPb2xWdjDGaA9ZXc4l91VUkOasVwYuEni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i2W5qdjt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i2W5qdjt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=ONJsZsuBBdVs8sdkr0bY486TNXSRV1vDyDb41XHmd34=; b=i2W5qdjt3Ffu2Ly9INCzHjLLH6
	RkzTt1z+9AsIrp0HUAIl9AGZPPTK09k3yNWdrUA/VeJa981Xw8Ug3rTfQwWuLJjb1gjJmph3lQkQJ
	+lo+godeqk4nMD1OC4bM595+9edWadmNDfCGT6rYGVTOTIoOZ5qTE02zBBvciBfF9+2MU6+ydassJ
	lJ20Tgl6c4JIXS0G8KdGzZ9qgXD3UeUy1KZCziPm5oMpvEDb+Gew4saE9xRT0JrdjLuLNbamLGgZ0
	jtO5zNHyxnIC8Z6fNFOeqn/n7WYT7Akwywu/K/AHgbVD2CVdIIwzOD+94WtIULLip2HGqbVy4+qee
	YJj4F0fw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNU-00000001AgH-2Mvm;
	Mon, 08 Jun 2026 14:55:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wWbNS-00000000NFu-1qUd;
	Mon, 08 Jun 2026 15:54:58 +0100
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
Subject: [PATCH v5 22/34] KVM: selftests: Add master clock offset test
Date: Mon,  8 Jun 2026 15:48:03 +0100
Message-ID: <20260608145455.89187-23-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608145455.89187-1-dwmw2@infradead.org>
References: <20260608145455.89187-1-dwmw2@infradead.org>
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

Verify that KVM master clock mode remains active when vCPUs have
different TSC offsets but the same frequency. Creates three vCPUs,
sets one to a different TSC value, and confirms:

 - KVM_CLOCK_HOST_TSC is set (master clock active)
 - KVM_CLOCK_TSC_STABLE is NOT set (offsets differ)

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Kiro (claude-opus-4.6-1m)
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/masterclock_offset_test.c         | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/masterclock_offset_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 90568ab631d7..7ecaaf82056e 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -106,6 +106,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86 += x86/pvclock_test
+TEST_GEN_PROGS_x86 += x86/masterclock_offset_test
 TEST_GEN_PROGS_x86 += x86/pvclock_migration_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
diff --git a/tools/testing/selftests/kvm/x86/masterclock_offset_test.c b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
new file mode 100644
index 000000000000..88e2bd2edab5
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/masterclock_offset_test.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that KVM master clock mode works with different TSC offsets
+ * as long as all vCPUs have the same TSC frequency.
+ */
+#include <stdint.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock-abi.h>
+
+#define KVMCLOCK_GPA	0xc0000000ull
+#define TSC_OFFSET	(1000000000ULL)
+
+static uint64_t pvclock_calc(struct pvclock_vcpu_time_info *pvti, uint64_t guest_tsc)
+{
+	uint64_t delta = guest_tsc - pvti->tsc_timestamp;
+
+	if (pvti->tsc_shift >= 0)
+		delta <<= pvti->tsc_shift;
+	else
+		delta >>= -(int)pvti->tsc_shift;
+
+	return pvti->system_time + ((__uint128_t)delta * pvti->tsc_to_system_mul >> 32);
+}
+
+static void guest_code(void)
+{
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, KVMCLOCK_GPA | KVM_MSR_ENABLED);
+	for (;;)
+		GUEST_SYNC(0);
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpus[3];
+	struct kvm_clock_data clock;
+	struct pvclock_vcpu_time_info pvti[3];
+	struct kvm_vm *vm;
+	uint64_t offset0, host_tsc, clk0, clk2;
+	int i;
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	vm = vm_create_with_vcpus(3, guest_code, vcpus);
+
+	TEST_REQUIRE(!__vcpu_has_device_attr(vcpus[0], KVM_VCPU_TSC_CTRL,
+					     KVM_VCPU_TSC_OFFSET));
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    KVMCLOCK_GPA, 1,
+				    vm_calc_num_guest_pages(VM_MODE_DEFAULT,
+							   getpagesize()), 0);
+	virt_map(vm, KVMCLOCK_GPA, KVMCLOCK_GPA,
+		 vm_calc_num_guest_pages(VM_MODE_DEFAULT, getpagesize()));
+
+	/* Get vCPU 0's default offset and set vCPU 2's offset higher */
+	vcpu_device_attr_get(vcpus[0], KVM_VCPU_TSC_CTRL,
+			     KVM_VCPU_TSC_OFFSET, &offset0);
+	uint64_t offset2 = offset0 + TSC_OFFSET;
+	vcpu_device_attr_set(vcpus[2], KVM_VCPU_TSC_CTRL,
+			     KVM_VCPU_TSC_OFFSET, &offset2);
+
+	/* Run each vCPU to enable kvmclock (with offset already set) */
+	for (i = 0; i < 3; i++) {
+		vcpu_run(vcpus[i]);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpus[i], KVM_EXIT_IO);
+	}
+
+	/* Check master clock is active */
+	memset(&clock, 0, sizeof(clock));
+	vm_ioctl(vm, KVM_GET_CLOCK, &clock);
+	pr_info("KVM_GET_CLOCK flags: 0x%x\n", clock.flags);
+	TEST_ASSERT(clock.flags & KVM_CLOCK_HOST_TSC,
+		    "Master clock should be active, flags=0x%x", clock.flags);
+	TEST_ASSERT(clock.flags & KVM_CLOCK_TSC_STABLE,
+		    "KVM_CLOCK_TSC_STABLE should be set, flags=0x%x", clock.flags);
+
+	/* Get per-vCPU pvclock in order 0, 2, 1 */
+	int order[] = {0, 2, 1};
+	for (i = 0; i < 3; i++) {
+		int idx = order[i];
+		__vcpu_ioctl(vcpus[idx], KVM_GET_CLOCK_GUEST, &pvti[idx]);
+		pr_info("vCPU %d: tsc_timestamp=%lu system_time=%lu "
+			"mul=%u shift=%d flags=0x%x\n",
+			idx, (unsigned long)pvti[idx].tsc_timestamp,
+			(unsigned long)pvti[idx].system_time,
+			pvti[idx].tsc_to_system_mul, pvti[idx].tsc_shift,
+			pvti[idx].flags);
+	}
+
+	/* Read guest TSCs: should see (0+OFF) < 2 < (1+OFF) */
+	uint64_t gtsc0 = vcpu_get_msr(vcpus[0], MSR_IA32_TSC);
+	uint64_t gtsc2 = vcpu_get_msr(vcpus[2], MSR_IA32_TSC);
+	uint64_t gtsc1 = vcpu_get_msr(vcpus[1], MSR_IA32_TSC);
+	pr_info("Guest TSCs: vcpu0=%lu vcpu2=%lu vcpu1=%lu\n",
+		(unsigned long)gtsc0, (unsigned long)gtsc2, (unsigned long)gtsc1);
+	pr_info("vcpu0+OFF=%lu vcpu1+OFF=%lu\n",
+		(unsigned long)(gtsc0 + TSC_OFFSET),
+		(unsigned long)(gtsc1 + TSC_OFFSET));
+	TEST_ASSERT(gtsc0 + TSC_OFFSET < gtsc2 && gtsc2 < gtsc1 + TSC_OFFSET,
+		    "Expected (vcpu0+OFF) < vcpu2 < (vcpu1+OFF)");
+
+	/* PVCLOCK_TSC_STABLE_BIT should NOT be set (offsets differ) */
+	TEST_ASSERT(!(pvti[2].flags & PVCLOCK_TSC_STABLE_BIT),
+		    "PVCLOCK_TSC_STABLE_BIT should NOT be set, flags=0x%x",
+		    pvti[2].flags);
+
+	/* Same mul/shift */
+	TEST_ASSERT(pvti[0].tsc_to_system_mul == pvti[2].tsc_to_system_mul &&
+		    pvti[0].tsc_shift == pvti[2].tsc_shift,
+		    "All vCPUs should have same mul/shift");
+
+	/*
+	 * Read host TSC once. At this instant:
+	 *   vCPU 0 guest TSC = host_tsc + offset0
+	 *   vCPU 2 guest TSC = host_tsc + offset0 + TSC_OFFSET
+	 * Feed each through its pvclock. Expect the same kvmclock.
+	 */
+	host_tsc = rdtsc();
+	clk0 = pvclock_calc(&pvti[0], host_tsc + offset0);
+	clk2 = pvclock_calc(&pvti[2], host_tsc + offset0 + TSC_OFFSET);
+
+	pr_info("kvmclock via vCPU 0: %lu ns\n", (unsigned long)clk0);
+	pr_info("kvmclock via vCPU 2: %lu ns\n", (unsigned long)clk2);
+	TEST_ASSERT(clk0 == clk2,
+		    "kvmclock from offset vCPUs should match exactly, "
+		    "diff=%ld ns", (long)(clk2 - clk0));
+
+	pr_info("PASSED: pvclock consistent across offset vCPUs\n");
+
+	/*
+	 * Now add an hour to the VM kvmclock via KVM_SET_CLOCK, run each
+	 * vCPU to pick up the update, and check they're still in sync.
+	 */
+	{
+#define ONE_HOUR_NS (3600ULL * NSEC_PER_SEC)
+		struct kvm_clock_data setclk = { .clock = clock.clock + ONE_HOUR_NS };
+
+		vm_ioctl(vm, KVM_SET_CLOCK, &setclk);
+	}
+
+	/* Guest code does GUEST_SYNC then exits — run each to see update */
+	for (i = 0; i < 3; i++) {
+		vcpu_run(vcpus[order[i]]);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpus[order[i]], KVM_EXIT_IO);
+	}
+
+	/* Re-read pvclocks */
+	for (i = 0; i < 3; i++)
+		__vcpu_ioctl(vcpus[order[i]], KVM_GET_CLOCK_GUEST, &pvti[order[i]]);
+
+	pr_info("After +1h: vCPU 0 system_time=%lu, vCPU 2 system_time=%lu\n",
+		(unsigned long)pvti[0].system_time,
+		(unsigned long)pvti[2].system_time);
+	TEST_ASSERT(pvti[0].system_time == pvti[2].system_time,
+		    "system_time should still match after KVM_SET_CLOCK");
+
+	host_tsc = rdtsc();
+	clk0 = pvclock_calc(&pvti[0], host_tsc + offset0);
+	clk2 = pvclock_calc(&pvti[2], host_tsc + offset0 + TSC_OFFSET);
+
+	pr_info("After +1h: kvmclock via vCPU 0: %lu ns\n", (unsigned long)clk0);
+	pr_info("After +1h: kvmclock via vCPU 2: %lu ns\n", (unsigned long)clk2);
+	TEST_ASSERT(clk0 == clk2,
+		    "After +1h: kvmclock should still match, diff=%ld ns",
+		    (long)(clk2 - clk0));
+
+	/* Verify the clock actually moved by ~1 hour */
+	TEST_ASSERT(clk0 > ONE_HOUR_NS,
+		    "Clock should be > 1 hour after set, got %lu ns",
+		    (unsigned long)clk0);
+
+	pr_info("PASSED: pvclock still consistent after KVM_SET_CLOCK +1h\n");
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0

