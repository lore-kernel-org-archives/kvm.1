Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D52556B81;
	Tue, 13 Oct 2026 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924521; cv=none; b=Uc3qEd1BSvfUDVHxuteeS/UQJpEJ6e2Js1+5F0zTX4kNeXIm/+SvTpBg943+wl3x100Xzn8yQpx7N7myihe9Wv2Atv0tvEVDO6vyBwt/IRw5djsQFwxHdVM8VndGkzUVu6XAXDPSR2HJhjUdS6Urlner1Rgzp+CxMv9KexU5xG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924521; c=relaxed/simple;
	bh=JIQYfSl4FHO7RBWGs+X9PTpxL/QlAOxSwIT/tiEcNng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRfdQHxRFMVRnRvBgxIk1qFOr3i9qdJSv/isbtCI4b6tzR/dnt9L0KShJfnQbbXVu+R4F0EOjDptKazyZN/X0mFsuhbq8GXOVCzZGzIpCZbu/5heQgQjy1MmIHGSO3UYr/KOpYbK+WhL2uVHsNtzvGtEJUd73NoeUOa+zggjuSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmNgv1sE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmNgv1sE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Fqo6lpO9UQiTdCHFymA7Pg1AUf+HpjLRc+2WggDizO8=; b=lmNgv1sE4NK7JJ4bQu5Sxhaz3B
	ktwqhHDLcIXM5ctlSCmzowgRuHGQ5/fdGm6lDDlXsqgJTCAP3M/yDO44W4KvntiyVlIvPy55Hrrtx
	BzF9Zb+2nqwU0eUXdVNjnWJBD+yHm1mSN2oyrBrdkuzDNYZRRwNVlgZ2r1TJIxUbdsSV4EYpPCoP3
	Bwt3m7I5lt3Uo3yMxYkr37uEjgmuZHauv+3+IOzjiQjf6v69B9C/sFp1QniWLG/qYK0dnTHgI29M/
	zg230crwh0FXK7nUNLKAV+uskIMbzCiWvePwWYVfSLOeP+23+D9klBBzJCVjO0PF9YKsP1NCFdvfI
	q/nkgz8w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4CA-0wr2;
	Tue, 13 Oct 2026 20:48:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ9-00000001uAa-06z6;
	Tue, 13 Oct 2026 21:48:25 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 10/10] KVM: selftests: Add Xen evtchn vs memslot-update race test
Date: Tue, 13 Oct 2026 21:48:23 +0100
Message-ID: <20261013204824.454208-11-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013204824.454208-1-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
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

Race a guest EVTCHNOP_send loop against a host thread which deletes
and recreates the shared_info memslot. Delivery which hits the update
window now returns -EAGAIN and the hypercall is re-executed; if KVM
instead waited in the vCPU's exit-handling context — under vcpu_run's
kvm->srcu read section — it would deadlock against
kvm_swap_active_memslots() waiting out that reader, and this test
livelocks within seconds.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 178 ++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..e7e17d19d6cb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -144,6 +144,7 @@ TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
+TEST_GEN_PROGS_x86 += x86/xen_evtchn_memslot_race_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c b/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c
new file mode 100644
index 000000000000..2b6974d3d464
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xen_evtchn_memslot_race_test
+ *
+ * A guest EVTCHNOP_send whose delivery races a DELETE/re-CREATE of the
+ * memslot holding the shared_info page. The delivery path runs in the
+ * vCPU's exit-handling context, under vcpu_run's kvm->srcu read
+ * section; if it waits there for the memslot update to complete, it
+ * deadlocks against kvm_swap_active_memslots()'s
+ * synchronize_srcu_expedited() waiting out that very read section.
+ * Regression test for that deadlock: KVM must defer the delivery to
+ * the next guest entry rather than spin in exit context.
+ *
+ * The guest sends events in a tight loop; a host thread deletes and
+ * recreates the shared_info slot in a tight loop. On a broken host
+ * this livelocks within a second or two (the test then dies by
+ * timeout); on a fixed host every send eventually delivers and the
+ * test completes N iterations.
+ */
+#include <pthread.h>
+#include <stdatomic.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <stdint.h>
+
+#define SHINFO_REGION_GPA	0xc0000000ULL
+#define SHINFO_REGION_SLOT	10
+
+#define EVTCHN_PORT		15
+#define TEST_ITERATIONS		4000
+
+#define EVTCHNOP_send		4
+#define __HYPERVISOR_event_channel_op	32
+
+#define XEN_HYPERCALL_MSR	0x40000000
+
+#define EVTCHNSTAT_ipi		5
+
+struct evtchn_send {
+	uint32_t port;
+};
+
+static void guest_code(void)
+{
+	struct evtchn_send s = { .port = EVTCHN_PORT };
+	int i;
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		/*
+		 * The delivery may legitimately fail while the shared_info
+		 * slot is mid-churn (between DELETE and re-CREATE there is
+		 * no slot at all, which is -EFAULT, not a transient). The
+		 * failure mode under test is the vCPU never coming back at
+		 * all (deadlock -> timeout), not the hypercall rc.
+		 */
+		__xen_hypercall(__HYPERVISOR_event_channel_op, EVTCHNOP_send, &s);
+		GUEST_SYNC(i);
+	}
+
+	GUEST_DONE();
+}
+
+static atomic_bool churn_stop;
+
+static void *memslot_churn(void *arg)
+{
+	struct kvm_vm *vm = arg;
+
+	while (!atomic_load(&churn_stop)) {
+		vm_mem_region_delete(vm, SHINFO_REGION_SLOT);
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+					    SHINFO_REGION_GPA,
+					    SHINFO_REGION_SLOT, 2, 0);
+	}
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	struct ucall uc;
+	int done = 0;
+	int r;
+
+	int xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    SHINFO_REGION_GPA, SHINFO_REGION_SLOT, 2, 0);
+
+	struct kvm_xen_hvm_config hvmc = {
+		.flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
+			 KVM_XEN_HVM_CONFIG_EVTCHN_SEND,
+		.msr = XEN_HYPERCALL_MSR,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_CONFIG, &hvmc);
+
+	struct kvm_xen_hvm_attr lm = {
+		.type = KVM_XEN_ATTR_TYPE_LONG_MODE,
+		.u.long_mode = 1,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &lm);
+
+	struct kvm_xen_hvm_attr ha = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
+
+	struct kvm_xen_vcpu_attr vi = {
+		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO,
+		.u.gpa = SHINFO_REGION_GPA + 0x40,
+	};
+	vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &vi);
+
+	/* Loop the port back to this vCPU as an IPI. */
+	struct kvm_xen_hvm_attr evt = {
+		.type = KVM_XEN_ATTR_TYPE_EVTCHN,
+		.u.evtchn.send_port = EVTCHN_PORT,
+		.u.evtchn.type = EVTCHNSTAT_ipi,
+		.u.evtchn.flags = 0,
+		.u.evtchn.deliver.port.port = EVTCHN_PORT,
+		.u.evtchn.deliver.port.vcpu = vcpu->id,
+		.u.evtchn.deliver.port.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &evt);
+
+	r = pthread_create(&thread, NULL, memslot_churn, vm);
+	TEST_ASSERT(!r, "pthread_create() failed: %d", r);
+
+	while (!done) {
+		vcpu_run(vcpu);
+
+		/*
+		 * In the window where the shared_info slot is fully deleted
+		 * (between the churn thread's DELETE and re-CREATE), the
+		 * delivery fails with -EFAULT and the hypercall bounces to
+		 * userspace as KVM_EXIT_XEN. Complete it with an error
+		 * result and keep going; the failure mode under test is
+		 * the vCPU never coming back (deadlock -> timeout), not
+		 * the hypercall rc.
+		 */
+		if (vcpu->run->exit_reason == KVM_EXIT_XEN &&
+		    vcpu->run->xen.type == KVM_EXIT_XEN_HCALL) {
+			vcpu->run->xen.u.hcall.result = -EFAULT;
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			done = 1;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+
+	atomic_store(&churn_stop, true);
+	pthread_join(thread, NULL);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

