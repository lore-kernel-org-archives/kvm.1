Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A406352017;
	Fri,  3 Jul 2026 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783113815; cv=none; b=s03OlEP/Yf5a8Ih/iqzKT9h6/rdnzfrejsC9tyi6D949MGhuwD7ZMmBw/uLubq/4tZ1HqqgxZQjCHRqu5uOX7/U0OXVhkpGkxCY3eodR0LBOR8p+RIKUkdtaAR+Bdm25QavtPbCGalq1ikAuIBz1v11ab1WylWKJOd3fobTw948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783113815; c=relaxed/simple;
	bh=nVaXU8weZ/YR/6D/q2TDV/VQgiSNoyVXsC24+Caa5ZQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV02HBN+kTIWV3kIN7dh/OnumGzNOpwB+ltMwKhOncyh/8brUV1l75XfV5qfwDBG1L/l1aA10mj3faL8tjB7lVn28GXjXEnXXo7kO3hXBfhQhQ7qAxQsu/5v8Bo3O934SYntUtXYra7hR+/kMCHRgXd5tAoGj6rl8yaNbdXzmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iU6SK+6H; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iU6SK+6H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=MSS/L0DlzIiHi7Bw2B047mUTxdF1yD6n9Esd4lrjANw=; b=iU6SK+6HlatYeQ2gl9tGwyLkqi
	sAlSNaCj1PI5JPhBJmRbg/ZFhceYepOCKk0FhLL4jYcu0Ca1VR2EtHfZyR4QbM6Nkewx7oXq5ElzM
	SEIB8TwnLNxYKX69h8tecrdlNIfS4rDY4Bwhm5882oYca8mbjNYb3jUkg7/HSWCpmyYBUBFyQOOi3
	tcR/CDUHlwPBWqbHVVgaWWgQRlA6+jwPo9gNJ9sC8Gj+x8HkO25EeY7RimOfYveAQMCdQmD5iWBYI
	UP7CHZJJi5EKQaHg39iDBGsOfy3hGBLeHuhNl9ZJkgXvFeo9mpsYJEgU9DxfO7FEEbwn5yRsKKDgf
	yzRGECYw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKe-000000059OD-0yjS;
	Fri, 03 Jul 2026 21:22:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wflKX-00000001RPs-2B0E;
	Fri, 03 Jul 2026 22:21:49 +0100
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
Subject: [PATCH v6 31/36] KVM: selftests: Add Xen runstate migration test
Date: Fri,  3 Jul 2026 22:18:10 +0100
Message-ID: <20260703212145.343527-32-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703212145.343527-1-dwmw2@infradead.org>
References: <20260703212145.343527-1-dwmw2@infradead.org>
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

Test that Xen runstate (steal time) is correctly accounted across a
simulated live migration using KVM_XEN_VCPU_ATTR and KVM_[GS]ET_CLOCK_GUEST.

The test simulates what a real VMM does during migration:
1. Creates a VM with Xen HVM config and runstate tracking
2. Runs the guest to accumulate some kvmclock time
3. Saves clock (KVM_GET_CLOCK_GUEST), TSC offset, and runstate
4. Marks the saved state as RUNSTATE_runnable (vCPU not running)
5. Destroys the source VM
6. Sleeps 10ms (simulating migration network transfer time)
7. Creates a new VM and restores all state precisely as saved
8. Runs the guest and verifies the migration gap appears as steal

The kernel accounts the gap because: on vcpu_load, it transitions from
RUNSTATE_runnable to RUNSTATE_running, computing delta = kvmclock_now -
state_entry_time. Since kvmclock has advanced past the saved entry time
(real time elapsed during migration), the delta is added to time_runnable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/xen_migration_test.c    | 194 ++++++++++++++++++
 2 files changed, 195 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_migration_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 58aac2980cdf..f155683bd7f8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -142,6 +142,7 @@ TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_cpuid_timing_test
+TEST_GEN_PROGS_x86 += x86/xen_migration_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_init2_tests
diff --git a/tools/testing/selftests/kvm/x86/xen_migration_test.c b/tools/testing/selftests/kvm/x86/xen_migration_test.c
new file mode 100644
index 000000000000..4a041d36f1b9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_migration_test.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test Xen runstate (steal time) preservation across simulated migration.
+ *
+ * Verifies that the kernel correctly accounts the migration gap as
+ * steal time (runnable) when runstate data is saved and restored
+ * precisely, but real time elapses during the migration.
+ *
+ * The key insight: userspace saves the runstate with state=RUNSTATE_runnable
+ * (the vCPU is not running during migration). On restore, the kernel sees
+ * that kvmclock has advanced past state_entry_time, and accounts the
+ * difference as time spent in the runnable state.
+ */
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <asm/pvclock-abi.h>
+
+#define SHINFO_GPA	0xc0000000ULL
+#define RUNSTATE_GPA	(SHINFO_GPA + 0x1000)
+
+#define RUNSTATE_running  0
+#define RUNSTATE_runnable 1
+#define RUNSTATE_blocked  2
+#define RUNSTATE_offline  3
+
+struct vcpu_runstate_info {
+	uint32_t state;
+	uint64_t state_entry_time;
+	uint64_t time[4];
+} __attribute__((packed));
+
+static void guest_code(void)
+{
+	volatile struct vcpu_runstate_info *rs =
+		(void *)(unsigned long)RUNSTATE_GPA;
+
+	/* Report runstate times — no need to enable kvmclock MSR,
+	 * the kernel writes runstate using its internal kvmclock. */
+	GUEST_SYNC_ARGS(0, rs->time[RUNSTATE_runnable],
+			rs->time[RUNSTATE_running], 0, 0);
+}
+
+static struct kvm_vm *create_xen_vm(struct kvm_vcpu **vcpu)
+{
+	struct kvm_vm *vm;
+	int xen_caps;
+
+	vm = vm_create_with_one_vcpu(vcpu, guest_code);
+
+	xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_RUNSTATE);
+
+	/* Map pages */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    SHINFO_GPA, 1, 2, 0);
+	virt_map(vm, SHINFO_GPA, SHINFO_GPA, 2);
+
+	/* Enable Xen HVM with MSR interception (enables runstate tracking) */
+	struct kvm_xen_hvm_config cfg = {
+		.flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL,
+		.msr = 0x40000000,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_CONFIG, &cfg);
+
+	/* Set shared_info */
+	struct kvm_xen_hvm_attr ha = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.u.shared_info.gfn = SHINFO_GPA >> 12,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
+
+	/* Set runstate address */
+	struct kvm_xen_vcpu_attr rs_addr = {
+		.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADDR,
+		.u.gpa = RUNSTATE_GPA,
+	};
+	vcpu_ioctl(*vcpu, KVM_XEN_VCPU_SET_ATTR, &rs_addr);
+
+	return vm;
+}
+
+int main(void)
+{
+	struct pvclock_vcpu_time_info pvti;
+	struct kvm_xen_vcpu_attr runstate_save;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t tsc_offset;
+	int ret;
+
+	/* === SOURCE SIDE === */
+	pr_info("=== Source: create VM and run guest ===\n");
+	vm = create_xen_vm(&vcpu);
+
+	/* Run guest once to accumulate some runstate time */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+
+	pr_info("  Guest sees: runnable=%" PRIu64 " running=%" PRIu64 "\n",
+		uc.args[2], uc.args[3]);
+
+	/* Save clock state */
+	ret = __vcpu_ioctl(vcpu, KVM_GET_CLOCK_GUEST, &pvti);
+	TEST_ASSERT(!ret, "KVM_GET_CLOCK_GUEST failed");
+
+	/* Save TSC offset */
+	tsc_offset = vcpu_get_msr(vcpu, MSR_IA32_TSC_ADJUST);
+
+	/* Save runstate — the vCPU is now "runnable" (not running) */
+	runstate_save.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA;
+	vcpu_ioctl(vcpu, KVM_XEN_VCPU_GET_ATTR, &runstate_save);
+
+	/*
+	 * Transition to runnable state before saving — the vCPU is
+	 * not running during migration.
+	 */
+	runstate_save.u.runstate.state = RUNSTATE_runnable;
+
+	pr_info("  Saved runstate: running=%" PRIu64 " runnable=%" PRIu64
+		" entry=%" PRIu64 "\n",
+		(uint64_t)runstate_save.u.runstate.time_running,
+		(uint64_t)runstate_save.u.runstate.time_runnable,
+		(uint64_t)runstate_save.u.runstate.state_entry_time);
+
+	uint64_t saved_runnable = runstate_save.u.runstate.time_runnable;
+
+	kvm_vm_free(vm);
+
+	/* === MIGRATION GAP === */
+	pr_info("=== Simulating migration (sleeping 10ms) ===\n");
+	usleep(10000);
+
+	/* === DESTINATION SIDE === */
+	pr_info("=== Destination: create new VM and restore ===\n");
+	vm = create_xen_vm(&vcpu);
+
+	/* Restore TSC offset */
+	vcpu_set_msr(vcpu, MSR_IA32_TSC_ADJUST, tsc_offset);
+
+	/* Restore clock — kvmclock will now be ~10ms ahead of the snapshot */
+	vcpu_ioctl(vcpu, KVM_SET_CLOCK_GUEST, &pvti);
+
+	/* Restore runstate exactly as saved (state=runnable) */
+	runstate_save.type = KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA;
+	ret = __vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &runstate_save);
+	TEST_ASSERT(!ret, "Restore runstate failed: errno %d", errno);
+
+	/*
+	 * Run the guest. When the vCPU enters vcpu_run, the kernel
+	 * transitions from RUNSTATE_runnable to RUNSTATE_running.
+	 * It computes: delta = kvmclock_now - state_entry_time
+	 * This delta (which includes the migration gap) is added to
+	 * time_runnable (steal time).
+	 */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+
+	uint64_t guest_runnable = uc.args[2];
+	uint64_t guest_running = uc.args[3];
+
+	pr_info("  Guest sees: runnable=%" PRIu64 " running=%" PRIu64 "\n",
+		guest_runnable, guest_running);
+
+	uint64_t steal_increase = guest_runnable - saved_runnable;
+	pr_info("  Steal time increase: %" PRIu64 " ns (migration gap)\n",
+		steal_increase);
+
+	/*
+	 * The steal time increase should be at least 10ms (the sleep)
+	 * but not more than 5s (allowing for VM creation overhead).
+	 * The actual gap is from the source's state_entry_time to the
+	 * destination's kvmclock "now" at vcpu_load time.
+	 */
+	TEST_ASSERT(steal_increase >= 10000000ULL &&
+		    steal_increase < 5000000000ULL,
+		    "Steal time increase %" PRIu64 " ns not in expected range "
+		    "[10ms, 5s]", steal_increase);
+
+	kvm_vm_free(vm);
+	pr_info("PASS: Migration gap correctly accounted as steal time\n");
+	return 0;
+}
-- 
2.54.0

