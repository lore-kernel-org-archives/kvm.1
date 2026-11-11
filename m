Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420578;
	b=DGGzVrj6CPhhZMzzcwi1oLZYduywMUMrM8yotnRdJLAdGNgMO9HA5bs2NqWO5dDmhmbR
	 Al1qbnVvcMfZuY3mVgsRvWfigC0OByS4gw3/IwskabugZUhxz/tbNp4CPq2W1JEhTkw+g
	 h4+3TRH2n+rNDh72i11HXZQY1Y7uqJzER5oyaHQExRGvIi5MGvQNdOiHDfyUdN5Agqagu
	 y+AGueOZLXcN+CmEsj+mbvIApa9ZES5T4I0YIAJ3WzMCR7rBXo4osH72x3nniFmqRzNAc
	 lv4Z0ZJm4qOzdhnVHbU8m9benFxVJPjUd02GePVXx/Bl7z2BsKCWewH0Nu+fOuYdZ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420578;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=4ef/OanmIYVhZ39mmN9i+3nPMTOvgl3kuiqty0UYfVQ=;
	b=VfZeOT93vw15DXFk+nHnh5x98zQqtEXgeXcCxGh+NuA9m3WIoT4bmpux16P/9Ncff1Bu
	 0P/W2DhcYzQ9FP8l8lUjsw3TXBm7mKERKsX51xuvfkW98C6k2hqKnygIiGyip/unuekOx
	 nBDq3i6l48vGi9qTEa5Rkt1Iqi84Q/C/OASKPyAxhum3S7xMsBlUeE5U6KlXE3I+ueAx9
	 hOzD1CvzufGV3X6e5euPQ6il81giVAr2fXcyIpGYDmQdRHZ0PhjOUkM9dr8U08SgVBZ7W
	 Po8wNdGoPCVKf2I9Sfwa77F+fZ7Ls0EIZz+5StXy44rQRPXBKb/RvLRueOGvV9/Pipw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SD0xiGvv;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E7606B786;
	Wed, 11 Nov 2026 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 367E7606B786
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=SD0xiGvv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=4ef/OanmIYVhZ39mmN9i+3nPMTOvgl3kuiqty0UYfVQ=; b=SD0xiGvvBw2dlcpqPpcWV9L2+k
	mjhmtahbMru1wSFigKkPtLdMIbq6ARAi+aPrLpmV2mivUqywxfvTIaNiGfRnwPaPSsSFrZaJL1bdv
	2y8Xyu4Lob3V1L+GpGysy+IcDHm8riQaTRPULdapwbWb7Afm3NOYjqlcTX1tgRxnEGBmouft6brAr
	FOCFYggCV9wL2ICBKLWhAC1yAFx5/Tih0QCnu/dtzCF7i07S+zmJIghGHHoeATwhcRriZgDJvlwHN
	W8/AezTrx8Relfr7KFhyfQqeAoUbI8TfPHLJcEcs42UfFfalxobACwOIN174UAsdKnrXC+XzUUTrM
	Ld2X3mOQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRClB-00000009PvU-3Bk1;
	Wed, 11 Nov 2026 18:09:25 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRCl9-0000000HWtS-2zfy;
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
Subject: [PATCH v13 22/26] KVM: selftests: Add Xen runstate migration test
Date: Wed, 11 Nov 2026 10:09:18 -0800
Message-ID: <20261111180922.4177927-23-dwmw2@infradead.org>
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

The VM is placed in long mode explicitly (KVM_XEN_ATTR_TYPE_LONG_MODE)
so the kernel writes the 64-bit runstate layout; nothing in this test
writes the hypercall-page MSR, which is what would otherwise latch the
mode from the guest's EFER.

The guest TSC is transferred via the KVM_VCPU_TSC_OFFSET attribute. As
the "migration" is to a new VM on the same host, restoring the same
offset makes the guest TSC continue uninterrupted across the gap, so the
restored pvclock yields a kvmclock which has kept running too. That is
what makes the migration gap visible: the destination kvmclock is ahead
of the saved state_entry_time by (at least) the gap duration, rather
than restarting from the destination VM's creation time.

The kernel accounts the gap because: on vcpu_load, it transitions from
RUNSTATE_runnable to RUNSTATE_running, computing delta = kvmclock_now -
state_entry_time. Since kvmclock has advanced past the saved entry time
(real time elapsed during migration), the delta is added to time_runnable.

The result is reported through the kselftest TAP machinery.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/xen_migration_test.c    | 227 ++++++++++++++++++
 2 files changed, 228 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_migration_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 79d26de18bf3..1edc78845fd3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -153,6 +153,7 @@ TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_cpuid_timing_test
+TEST_GEN_PROGS_x86 += x86/xen_migration_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_migration_test.c b/tools/testing/selftests/kvm/x86/xen_migration_test.c
new file mode 100644
index 000000000000..e316e6cd82de
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_migration_test.c
@@ -0,0 +1,227 @@
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
+/*
+ * The 64-bit (long mode) layout: 'state' is followed by 4 bytes of
+ * padding so state_entry_time is naturally aligned. The VM is placed
+ * in long mode explicitly below; without that, KVM would latch 32-bit
+ * mode (no hypercall-page write ever happens here to latch it from
+ * EFER) and write the packed compat layout instead.
+ */
+struct vcpu_runstate_info {
+	u32 state;
+	u64 state_entry_time;
+	u64 time[4];
+};
+
+static void guest_code(void)
+{
+	volatile struct vcpu_runstate_info *rs =
+		(void *)(unsigned long)RUNSTATE_GPA;
+
+	/*
+	 * Report runstate times — no need to enable the kvmclock MSR,
+	 * the kernel writes runstate using its internal kvmclock.
+	 */
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
+	/* The guest runs in long mode; make the runstate layout match. */
+	struct kvm_xen_hvm_attr lm = {
+		.type = KVM_XEN_ATTR_TYPE_LONG_MODE,
+		.u.long_mode = 1,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &lm);
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
+	u64 tsc_offset;
+	int ret;
+
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_CLOCK_GUEST));
+
+	ksft_print_header();
+	ksft_set_plan(1);
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
+	vcpu_get_clock_guest(vcpu, &pvti);
+
+	/*
+	 * Save the guest TSC offset. This test migrates to a new VM on
+	 * the same host, so restoring the same offset makes the guest
+	 * TSC continue uninterrupted across the migration gap, and the
+	 * restored pvclock (KVM_SET_CLOCK_GUEST) then yields a kvmclock
+	 * which has also kept running across the gap. (A real migration
+	 * to a different host would compute the destination offset from
+	 * KVM_GET_CLOCK's {host_tsc, realtime} pair as described in
+	 * Documentation/virt/kvm/devices/vcpu.rst.)
+	 */
+	tsc_offset = vcpu_get_tsc_offset(vcpu);
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
+		(u64)runstate_save.u.runstate.time_running,
+		(u64)runstate_save.u.runstate.time_runnable,
+		(u64)runstate_save.u.runstate.state_entry_time);
+
+	u64 saved_runnable = runstate_save.u.runstate.time_runnable;
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
+	/* Restore the guest TSC offset (same host: TSC continues) */
+	vcpu_set_tsc_offset(vcpu, tsc_offset);
+
+	/* Restore clock — kvmclock will now be ~10ms ahead of the snapshot */
+	vcpu_set_clock_guest(vcpu, &pvti);
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
+	u64 guest_runnable = uc.args[2];
+	u64 guest_running = uc.args[3];
+
+	pr_info("  Guest sees: runnable=%" PRIu64 " running=%" PRIu64 "\n",
+		guest_runnable, guest_running);
+
+	u64 steal_increase = guest_runnable - saved_runnable;
+	pr_info("  Steal time increase: %" PRIu64 " ns (migration gap)\n",
+		steal_increase);
+
+	/*
+	 * The steal time increase should be at least 10ms (the sleep).
+	 * The actual gap runs from the source's state_entry_time to the
+	 * destination's kvmclock "now" at vcpu_load time, which includes
+	 * everything from the source guest's last runstate transition
+	 * through VM teardown and re-creation — so the upper bound exists
+	 * only to catch wild miscalculation (e.g. an unscaled TSC delta),
+	 * and is deliberately generous for slow or loaded hosts.
+	 */
+	TEST_ASSERT(steal_increase >= 10000000ULL &&
+		    steal_increase < 60000000000ULL,
+		    "Steal time increase %" PRIu64 " ns not in expected range "
+		    "[10ms, 60s]", steal_increase);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("migration gap accounted as steal time\n");
+	ksft_finished();
+}
-- 
2.43.0

