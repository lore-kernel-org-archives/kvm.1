Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677FC282F01
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538559; cv=none; b=ttfdvQ6EU84c22lHxmQcyhsWKqnSDaYqCrPRd9vF0/KS6vMcBe5qpK5PjMdADJAj5lBW97Lf3xfgQ0Bq5rajT0+PUnW3Ivw4qaGXC9nlGfa0hMC6YbIL5NldVhmKFvw9DrYi6MKtqbA65tQycZ2kmpyCBfbq+cmcHKCVAsNQ6r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538559; c=relaxed/simple;
	bh=P/6Oa6bCc2moG68o8GGr9AwgkKQdUS96ekeltgT4d24=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=saWMpuZ9NNGcFgy9zpEF8TKKvOUnyUeF4WASkFScZUvvkSvYY2MebuTHCyY0po2Fg6Vuax+Lj33r9dJcLol4/5MIEsjDzMHoZZiRzLcxS67vBbB0ENK29TFWcJa01KkNaefYcAFEB3uZPj97U167yWPpZRUcZ9bEt9Wm4GNkc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dW18vjmo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dW18vjmo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf11699875so1783875ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538555; x=1781143355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQgBRd3Ewi2bKAxe1ytwImVpDEDSkEWWH2AxFYnyA80=;
        b=dW18vjmoDlz3k77xBhh7QUz7K5eC2JL9TvXLVodq6tlfgx70eXw8rcuBEE5BRcsIel
         PWiP9Ya7RjtLnn/J1XWhHJoPLpIh+HY/z5d/ubBQrAk3HsHHOrMWon1qB+xmeWzhBer6
         2QfjOiLnlm80zC6iRE3/o9sD3eVWC7j0Xb99gA7ypnUVx3GZgyfubBOxsrBZoRhlY7P1
         LpVmegL2gMYtOxwjS7Nb3pwWma0Av6r5iZWJnmoTJ7efQz1YaIumpGF0m78Rz+DPcV+K
         AbHFLXn7/5ZT8kbEHk6KBXZZIZLaHoHRvt983mrJj6gBInNYDfNcvLzQjFXcjxRuQp34
         5/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538555; x=1781143355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQgBRd3Ewi2bKAxe1ytwImVpDEDSkEWWH2AxFYnyA80=;
        b=gWMG35V5W7vH69SwxWBJs8WkKqzbzuAT1u9AcapagzKUgeURaE40fCgeZ0K8eLdEva
         u2aZCLGRAwA5ttb3c2cnYez5M5NPYWtrDeGZD2udqjg8ZGoDnq6Oa0HJp9f+botO5gny
         dctCgE6b7psK6oPQ3y70OywdPgFJe80GcmpPTFSPRo92PgoE0cU74OzMWHmr9jv6U55K
         jKyksIbpYOkTpCVPlyy97zPyaEcwAMq4kgGRQxUZE4/hBoxayYykrqqhDDdzu2sU029H
         B2MIOOUGb3/Y8gybgZ/EvGZrJIwWR4oLM2NRNYmkZ6Cx9EkCJsKKAvcanMWtW7GZaEJF
         SPvg==
X-Gm-Message-State: AOJu0YySWUooui2Ojj+yxAHJtsx2xgtTFdnmBtvY6AaBlUwsn94MpuvQ
	oevumsGn6B9AJQ6Obqpu9EeoMqGyeBaHzlK2CWieWWYUDbVylEf7KloBxIQTR2X6Sjy648pBRMN
	XJ2RdJi6+
X-Received: from plbkz12.prod.google.com ([2002:a17:902:f9cc:b0:2b2:c88b:31b8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc4c:b0:2be:1eb1:eaf3
 with SMTP id d9443c01a7336-2c197e4a128mr15126185ad.11.1780538555044; Wed, 03
 Jun 2026 19:02:35 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:27 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-6-jrhilke@google.com>
Subject: [PATCH v5 05/21] KVM: selftests: Add IRQ injection test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index 2da11e1f3d9a..b859098121c7 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -153,12 +153,14 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
+TEST_GEN_PROGS_x86 += irq_test
 TEST_GEN_PROGS_x86 += mmu_stress_test
 TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
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
2.54.0.1032.g2f8565e1d1-goog

