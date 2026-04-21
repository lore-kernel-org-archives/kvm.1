Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459238422F
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813393; cv=none; b=IUbE00IzN18utzy1g7YHXIG2woReGD1Bdjtcm/OQdIQAKTuWLF2j9qK/b15a5HIGTlCNFgkpWaxacCNRv84hb2oQWTqIf/D8Cyja4hWdZYqe0NC22r3hm2c0PbOfiHdpv4Gbxhah/kl65HEFLQg5qGcwhR1Bd1tGFArH1I2YzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813393; c=relaxed/simple;
	bh=yuVZG5bnHVDFGkeTr7s59w77kNVoCAnWk2sY++DZRl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyJ8WlOvfMR9IfFgxJ9SuKebGgDEjgRKgYvtF4Fm3yLm+k4ttgqPLqkvN/M2aruAv5nn8hf2njB9xDmi69xSxapDRefH5tGuODVjZDglOPqMzdEVnVGGQOExvkXj3ZdfBCmgfOkktvpCApHwB+FsYYppVBT9Xl3p4Q9tfHQq190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iwC+ayhB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iwC+ayhB"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3614272b00cso5758386a91.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813392; x=1777418192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcMD+a+mUM9pTuq5mPlb/KFU2SXXC0lNH02gTQSKwJs=;
        b=iwC+ayhBRphAwxxyOa593a1QibG2J9z2E8w70u+Q+rA7fCVoCRsqkKhVkdBF5I6MBp
         6WzdQksRg0LFyBGabd+Ia35Vs6vtqx6qwVMEVw9nDwJthFRMaNzizmPAPRAcFIoS2vIZ
         VZM+cOcMTDmJl7xoxk4B7COfuj7Z2dxlQQAv0X45x/B4M3U5wv4Azvym93o8AFIJBCf9
         y7MZJDXk2KEbvqGTLnk49/e3yVAF++8XvYs3vPchlo05D0UWfdVfoF6zijPoMzJJB3Ds
         jcrNqnZHw2bzjgJVVoQot1iRs9Syi2iBQzrS2PKFHM9lpOlpwZlQ73wlNoQUyy5CjN1i
         X4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813392; x=1777418192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcMD+a+mUM9pTuq5mPlb/KFU2SXXC0lNH02gTQSKwJs=;
        b=mX3RoZHW+/JbaTm+990S6fi2drpYOY3mil1wE6741urcH4g9hewmUn5GUx9qoJgDG9
         GUX5ESYNI3zb8Q+iZ9EHRSrZ7VJ0bS/sZ9TwaE7m0fLomJEymhLw1Yu4fU0UBoJuD9gA
         0y31wEHGUQIWOt+ZY450sd65UnxJwKHxb9Qf45VZWelrz4OQ7Zs+mLeuh0HbQtUESJ0C
         6VmP6HdfbBeX53TPkp8rD4dk5AL7FIrlN4FQIeNSuK8CruD3wDRDG7e8/cPTC75QV/a6
         teJQje/bnS7O4oSRXRqft59i0n3rKA0LtYWINTQ75Qh8NdSvJ/uDIqOaDSNwjNCgvYiO
         UUTg==
X-Gm-Message-State: AOJu0YyKXQovHCYr/9Zi7TDDU7DOMBLDsCJ+NAvghdoM9mz7aQKMZkAe
	6D2ip4ZxVYp75gBxCSqlQL7cqOSv91tBNBfeCqZDh+RZj3Sg5na1QE2VhkYQaBWtMEWQLJDfOzl
	LIMlo/SYq
X-Received: from pjbcq15.prod.google.com ([2002:a17:90a:f98f:b0:35e:b019:85e1])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc9:b0:35b:e551:e776
 with SMTP id 98e67ed59e1d1-361404a6c39mr19138740a91.27.1776813391719; Tue, 21
 Apr 2026 16:16:31 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:47 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-7-jrhilke@google.com>
Subject: [PATCH v3 06/16] KVM: selftests: Add IRQ injection test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a new test, irq_test.c, which verifies that KVM correctly injects
interrupts into a running guest when triggered via an eventfd bound to a
GSI using the irqfd mechanism.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/irq_test.c   | 173 +++++++++++++++++++++++
 2 files changed, 174 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d944b81cad7d..693c03372a31 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += irq_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
new file mode 100644
index 000000000000..317e04899df3
--- /dev/null
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "apic.h"
+#include "processor.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <sys/eventfd.h>
+
+static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
+static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
+static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool done;
+
+static u32 guest_get_vcpu_id(void)
+{
+	return x2apic_read_reg(APIC_ID);
+}
+
+static void guest_irq_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(guest_received_irq[guest_get_vcpu_id()], true);
+
+	x2apic_write_reg(APIC_EOI, 0);
+}
+
+static void guest_code(void)
+{
+	x2apic_enable();
+
+	sti_nop();
+
+	WRITE_ONCE(guest_ready_for_irqs[guest_get_vcpu_id()], true);
+
+	while (!READ_ONCE(done))
+		cpu_relax();
+
+	GUEST_DONE();
+}
+
+static void *vcpu_thread_main(void *arg)
+{
+	struct kvm_vcpu *vcpu = arg;
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, &uc));
+
+	return NULL;
+}
+
+static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
+			  u8 vector)
+{
+	struct {
+		struct kvm_irq_routing head;
+		struct kvm_irq_routing_entry entry;
+	} routing_data = {};
+
+	struct kvm_irq_routing *routes = &routing_data.head;
+
+	routes->nr = 1;
+	routes->entries[0].gsi = gsi;
+	routes->entries[0].type = KVM_IRQ_ROUTING_MSI;
+	routes->entries[0].u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12);
+	routes->entries[0].u.msi.data = vector;
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
+}
+
+static void help(const char *name)
+{
+	printf("Usage: %s [-h]\n", name);
+	printf("\n");
+	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
+	printf("\n");
+	exit(KSFT_FAIL);
+}
+
+int main(int argc, char **argv)
+{
+	/*
+	 * Pick a random vector and a random GSI to use for device IRQ.
+	 *
+	 * Pick an IRQ vector in range [32, UINT8_MAX]. Min value is 32 because
+	 * Linux/x86 reserves vectors 0-31 for exceptions and architecture
+	 * defined NMIs and interrupts.
+	 *
+	 * Pick a GSI in range [24, KVM_MAX_IRQ_ROUTES - 1]. The min value is 24
+	 * because KVM reserves GSIs 0-15 for legacy ISA IRQs and 16-23 only go
+	 * to the IOAPIC. The max is KVM_MAX_IRQ_ROUTES - 1, because
+	 * KVM_MAX_IRQ_ROUTES is exclusive.
+	 */
+	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
+	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
+
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	pthread_t vcpu_threads[KVM_MAX_VCPUS];
+	int nr_irqs = 1000, nr_vcpus = 1;
+	int i, j, c, eventfd;
+	struct kvm_vm *vm;
+
+	while ((c = getopt(argc, argv, "h")) != -1) {
+		switch (c) {
+		case 'h':
+		default:
+			help(argv[0]);
+		}
+	}
+
+	TEST_REQUIRE(kvm_arch_has_default_irqchip());
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	vm_install_exception_handler(vm, vector, guest_irq_handler);
+
+	eventfd = kvm_new_eventfd();
+
+	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
+	       gsi, vector, nr_irqs);
+
+	kvm_assign_irqfd(vm, gsi, eventfd);
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		while (!SYNC_FROM_GUEST_AND_READ(vm, guest_ready_for_irqs[vcpu->id]))
+			continue;
+	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
+		struct timespec start;
+
+		kvm_route_msi(vm, gsi, vcpu, vector);
+
+		for (j = 0; j < nr_vcpus; j++)
+			TEST_ASSERT(
+				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),
+				"IRQ flag for vCPU %d not clear prior to test",
+				vcpus[j]->id);
+
+		/* Trigger interrupt */
+		eventfd_write(eventfd, 1);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (;;) {
+			if (SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpu->id]))
+				break;
+
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
+				TEST_FAIL(
+					"vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
+					vcpu->id, gsi, vector);
+		}
+
+		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+	}
+
+	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_join(vcpu_threads[i], NULL);
+
+	printf("Test passed!\n");
+
+	return 0;
+}
-- 
2.54.0.rc2.533.g4f5dca5207-goog

