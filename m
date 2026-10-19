Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427097;
	b=TnTJkLbSaKxsHXvgPJvUieVFt4IO1WPuxStKzAKKUhtddWBwiATLi7XKPXhlD3AwBrs+
	 0a6BQvgF8T/y3AKDuUniTQzyWXIfDL30xPsNFms9jZ39cFjNwZmvrIFh5QwVwT+MEQ4Xl
	 cGw7TPB8g37b5a+jzDDLOLOO0WWEll1YVntgZ//dCspwIe26adUpeE/He+7vb1g1AwPkP
	 /y5Xsb9eejOlRWQF55Dh53Yw68Ygv1bchDcxKs52dZM9ajHtDPJxLdQMTirtgmyxIxwll
	 2s9brdxyu6ztwv+pMJvu1Jq+3KVziqkFVkaxd5ng7u5gN/EhUyQGc5FnCGsai9mYMBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427097;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=+ROGGbrwRxlzxKuroErkPGxq0J1T+FijXvzUEmP253o=;
	b=wkYa9BqAVW1kokkmj0BgYuCDEo7C+6beFQV0AYiXzKGLiRlRjTfIBxeaVVcuXeGdf0p9
	 e8JotSHJG5TEJUU35DiMorpQYt8dzzttsfbjZc80Dn1pkkiXiQfobm1+/E451eHkom7pM
	 Zi+7/h9J36GWUacs3fF1SyBdW87uq2KKYzLHu561Rq9KcQCuycRg5ezt+I0nqb8ZqvchW
	 iA60R+tRUotj0Fm1GoQkLKT0ccIINDbUo03EzeVfl/vw7sYXzg/rqp+0VNefEb8J15Nxc
	 hJUYBd+3s+sW5I5uhm/F17J9JNlFio9FGRRk8mDVtbXo/Ba77qzO+zv4Uuyik2/5JPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE1606A31D;
	Mon, 19 Oct 2026 16:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ECE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=+ROGGbrwRxlzxKuroErkPGxq0J1T+FijXvzUEmP253o=; b=vtJd7WPmuk/DgBvf71j20tgiVQ
	wyGJPG23Q06ZKuDUGsr8JJ6FV4/UjQskCsxvAUW78H7H5skcQ4E6vTcl4Ml1pI9MidltDsohgoWSZ
	Ee/gf0e2UeNM8+h1YyMf+B0wsnzqkwnd/+lwleWqAkQfqdzUtuBh8qsx70tyY7rclf+cGYkEIpE6F
	jR+pNPVzfJsSxUuZIbNBlutWl8UU6sGKOBS0DyzvQWYKPrly14bn/7HzHdNTIDSS3F5SuZj5juuJK
	WVCrfctGbLV5ZMSNBu4JWpQG0Xfs250Z0lC27Cl6CkmqPiZdFZekCFwf5gXnA4nFxWwFOqQ+SQIbD
	CpU74KJg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIqAH-00000009VGQ-48rv;
	Mon, 19 Oct 2026 16:24:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009hB-3Mgk;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 11/12] KVM: selftests: Add Xen evtchn vs memslot-update race test
Date: Mon, 19 Oct 2026 17:24:42 +0100
Message-ID: <20261019162445.37219-12-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
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
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 208 ++++++++++++++++++
 2 files changed, 209 insertions(+)
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
index 000000000000..08dd1aac884f
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c
@@ -0,0 +1,208 @@
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
+ * Regression test for that deadlock: KVM must leave the hypercall
+ * uncompleted so the guest re-executes it, rather than wait in exit
+ * context.
+ *
+ * The guest sends events in a tight loop; a host thread deletes and
+ * recreates the shared_info slot in a tight loop. On a broken host
+ * this livelocks within a second or two (the test then dies by
+ * timeout); on a fixed host the guest completes all N
+ * iterations (sends which hit the no-slot gap between DELETE and
+ * re-CREATE legitimately fail; most deliver).
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
+	int delivered = 0;
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
+		if (!__xen_hypercall(__HYPERVISOR_event_channel_op,
+				     EVTCHNOP_send, &s))
+			delivered++;
+		GUEST_SYNC(i);
+	}
+
+	/* The churn must not have starved delivery entirely. */
+	GUEST_ASSERT(delivered);
+
+	/* Report the delivered count (always > TEST_ITERATIONS - sync i). */
+	GUEST_SYNC(TEST_ITERATIONS + delivered);
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
+	/*
+	 * Self-guard: on a kernel with the deadlock under test, the vCPU
+	 * never returns from KVM_RUN. Die with SIGALRM rather than hang
+	 * when run standalone. One budget for the whole run — a healthy
+	 * kernel finishes in seconds, and a per-iteration bound would
+	 * impose a KVM_RUN latency claim this test doesn't make.
+	 */
+	alarm(90);
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
+			/*
+			 * The final sync reports how many of the sends were
+			 * delivered: purely a diagnostic for how much of the
+			 * churn the guest actually raced with.
+			 */
+			if (uc.args[1] >= TEST_ITERATIONS)
+				pr_info("%lu of %u sends delivered\n",
+					uc.args[1] - TEST_ITERATIONS,
+					TEST_ITERATIONS);
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
+	alarm(0);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

