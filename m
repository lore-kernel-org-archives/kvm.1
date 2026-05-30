Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BA1DF74F
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100594; cv=none; b=li1GhskAumPqnmC8CuHCftY7tdZpVC5mH+dkYSad7ysQKIRTx0LpvNgQE8b70ZjX6BAsr7awTNej03HaCoObRGIBdXLYSdQ1hsZAcNA57IVFdBwPXZVEOkea6eAQ2E7mgYkHQVUx0PZDO/R2goovdc4KxJkIcSbmMUSy6h/YPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100594; c=relaxed/simple;
	bh=R+hEcm7b/r397fBUWES/1n0hvwRz7jF4RnQGQaDxRd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oURTB2QKHXpELqZzMHC5RTOdeVChy06T8VEx1uISsjP3v2ThYzrGMc5uPDVk1sRDNAId/jEZBefWorIgB3j38O4RIDEr+PFgWySaQ4bP9regcdNeMMT+FYrJ0NDLGU1o+x6eWgUf7V5jmOnrsV+H2Sa8gC2gBCybrH6tAlM8Ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BycmC3ow; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BycmC3ow"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8581f7723aso316980a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100592; x=1780705392; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NpzUIf2nz3ba993vjETr2W7fmZYW6oBzRwXR+J9UohE=;
        b=BycmC3owNgNzR6tk0b7F99W3rptWAOubZmSiQpkcpI3xM1CayFh8vOwzvCSZuS5NLA
         s+JYX+QjkSrZbIP98rE2G8G6YnrZ2fhFP+fAPM2Eb3Q8ZqpnybI6A7pEkNepgTvK9eIv
         HIFSPylthFxFnirE+1eSI4/yQGekXlxRJ4a9nzFpPUMN6bvFoyHKnY7Bu8SzCNt++X2J
         BP2WP10xjAU4h6OMAfpkwEM5ABKvCnGXKUTmZu7KCqB++3ifvDff8Ye5fyosSw+VG6lw
         ngcuGTrxP0H5FAeLqcQM3TXx6PibHGr+M4neh+3oNMLtPiyOpQCuxP4x6vgXclPf07VT
         +kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100592; x=1780705392;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpzUIf2nz3ba993vjETr2W7fmZYW6oBzRwXR+J9UohE=;
        b=iZF8igABmmdT2QvZsvW/brg2I9TPIvauKEAD1KsKlFA/ey1gmlNcrgvXejE0eKnqbI
         1ZV92PKMxqqRgZ9qXDU9mxQHG0z6vDsregsRCP/jYALcNrqjnm130Ehx+gZFPQ4QLQd9
         aKJmwWM9w2GNli0FNa38Kh5ekUpFfZWHRi1p/Wi1YRUxoYwP3LRfCNNZwdWBMRBWJMkQ
         eEDxtFonZlyfRPLhwbmtxzYJji4/4Eicq2bGC0h/grhazA95popcx77muhkYP68XrsMe
         eMwPsg2ncyHfUFZTMSvDrjHWhs5CktCvDkhrvDQIO0YYHc0o1/UKmjPELnzO3uKRFlcc
         olcQ==
X-Gm-Message-State: AOJu0YwbCYy5c42fJtzhrMu9hkAj4HMl4AzivJ4nka0/sYj+RNJ/PJ37
	iwVpAJLduGJusvAB9C3B+/Qq2nkYnMKdVELis/QQw1TWOQLLxS+VQyYBBNTvydQIHPw0K6iasqJ
	TVx9+yXZ4
X-Received: from pfbfj37.prod.google.com ([2002:a05:6a00:3a25:b0:83e:b5cc:11c3])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a0e:b0:838:29b3:9ed1
 with SMTP id d2e1a72fcca58-842255c8233mr1554904b3a.41.1780100592008; Fri, 29
 May 2026 17:23:12 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:21 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-7-jrhilke@google.com>
Subject: [PATCH v4 06/19] KVM: selftests: Add IRQ injection test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a new test, irq_test.c, which verifies that KVM correctly injects
interrupts into a running guest when triggered via an eventfd bound to a
GSI using the irqfd mechanism.

This test is intentionally simple. Support for IRQ bypass, receiving
interrupts from real devices, and other features will be added to this
test in future changes.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   2 +
 tools/testing/selftests/kvm/irq_test.c   | 174 +++++++++++++++++++++++
 2 files changed, 176 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d944b81cad7d..9e5a00699dd0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -149,6 +149,7 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
+TEST_GEN_PROGS_x86 += irq_test
 TEST_GEN_PROGS_x86 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86 += memslot_perf_test
 TEST_GEN_PROGS_x86 += mmu_stress_test
@@ -157,6 +158,7 @@ TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
 
+
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
 
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
new file mode 100644
index 000000000000..d3fee51cf451
--- /dev/null
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -0,0 +1,174 @@
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
+#define GUEST_RECEIVED_IRQ(__vcpu)	\
+	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu)->id])
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
+			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
+				    "IRQ flag for vCPU %d not clear prior to test",
+				    vcpus[j]->id);
+
+		/* Trigger interrupt */
+		eventfd_write(eventfd, 1);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (;;) {
+			if (GUEST_RECEIVED_IRQ(vcpu))
+				break;
+
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
+				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
+					  vcpu->id, gsi, vector);
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
2.54.0.929.g9b7fa37559-goog

