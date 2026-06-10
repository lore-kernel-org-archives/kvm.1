Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBC22256F
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052830; cv=none; b=ADpVPq4qsPoD/BJVj5oEjxR6ccrbbY2NDcHQd2aMt6roTAEjxXJKNIM437wBvlnGgMB7PkmMSuAiZyZfnhc9n+r6gr2bhhByyzKDbLE4Bobl5gtq93gawKSJ+kp1HxmtWttUrwzOEcrmU4F2N4bSJl+0ctnOrGTscbnSnCVqu7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052830; c=relaxed/simple;
	bh=OMHgBZdQznbdaBHXokn5ySfwp9R7As9kWeHY4hFWOew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gFyylszROqQDSwSFgBdOWSd7OUSMMV82h3iP5CsJaIK7ndP2nxjZYVAH4dfcxolkMCje7aZyt54D9ONmxD+djCsxjq4vQLamDTo5uFKaz+CiFpnktXN9EwL9yemojmRh9Z64Bn/uWlBpBL/U8wmiaYdZ5nHBI6w4ixZGnrHkm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1uvXn5l; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1uvXn5l"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-842692bf60aso8749430b3a.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052828; x=1781657628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4jgcYAAflMnUINIsIj8y+YCHO2jVOfAFlt5LrZDdIY=;
        b=d1uvXn5lpz3CHcCXTvHbrntuqt0KoVfr0getf+HoWKV6y3hTzQd+05T0iZLlUFiSbl
         63bkC2DB5wr+zX124YlOCo1gT7MHaqc60h0HSs4tv1WrN1Tq/9DoRzVnd9YkgmnKB/NL
         kBlM8tHDfVXwFzxTfo+ZG7KsU7cpiGddqvsWYoIR5Cux1/Io4/FKStA94/CjMS49rSxg
         HmNmKXYjPz0yFivxnaJPTHOue/wjPCUMCPuCUXkm9CSln7fexTNHJ39iPymCxXHHvBAb
         WgQuCPmNPr7FgvaR9vSjiI7znNPvCTKIpMG3zvbBtTHXQZOm6N4/U/jk1T0rOS4KAf9j
         zkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052828; x=1781657628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4jgcYAAflMnUINIsIj8y+YCHO2jVOfAFlt5LrZDdIY=;
        b=BrZttp4CXNcz1S3LUi/gc2RDwNrWeqQDZwsHJD3MzvkA5LNCxl+133Hy8wt/ij9Av3
         41r5tHpODopOaE1ipdhMFn3Lzi3HWpvGHBMt4xzDFPfuz8/EpRExsMVN1ZpGm6tfCeAH
         0WmFsqmS2n4fbSrzZYE8VruRpFRRieIoYCv18heXgGnvjKuZr0wal4QpAwEjXf+7pq3f
         WaKDXXrSo0M/mBRb7LimNeVS6+OG9R1XYWBl96KW3VkbCgPufqEbS24oN4U9CLPa1i2x
         Vx81LNGC6fc4wMlj6T6a2kEDaqUBNC+UvvQ13V+VRj2/dwMfkQNN1NtXFIzmcBKXD7b2
         BBPA==
X-Forwarded-Encrypted: i=1; AFNElJ+eB474mcwlhSlDBhBNB9EA74r70Iw5rQUf+e1IV17RADwaVBsQRvVah7cgT0Om62KOaAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRYF2v9DBhVpDNSz5kKMwwb51Sp+bdbcNMadku1F8aZsCpF9my
	LPSpqY7x6UtFb60F1rG/qoroVfVcjpRu0+A2vI0qgoEnu5iiZbEgelhEw/W4vT3CmDGvN4G6b6c
	0A5x8Rg==
X-Received: from pfnd21.prod.google.com ([2002:aa7:8155:0:b0:842:5989:fb63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9286:b0:842:4023:42c9
 with SMTP id d2e1a72fcca58-842b0fc08c5mr23541407b3a.41.1781052828129; Tue, 09
 Jun 2026 17:53:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:25 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-6-seanjc@google.com>
Subject: [PATCH v6 05/18] KVM: selftests: Add an irqfd send+receive (and later
 IRQ bypass) test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add a new test, irq_test to verify that KVM correctly delivers interrupts
to a running vCPU, when triggered via an eventfd bound to a KVM GSI using
KVM's irqfd mechanism.

This test is intentionally simple, for now.  Support for sending interrupts
via VFIO devices, for IRQ bypass, and for other features will be added in
the near future.

Add the test in common code, even though it currently will only build and
run on x86, as the concept and the bulk of the host-side code isn't
specific to x86.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: use while() and TEST_ASSERT() instead of if-statement => TEST_FAIL()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm |   1 +
 tools/testing/selftests/kvm/irq_test.c   | 170 +++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 14316358fd9f..1339228cbf53 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
 TEST_GEN_PROGS_x86 += guest_memfd_test
 TEST_GEN_PROGS_x86 += hardware_disable_test
+TEST_GEN_PROGS_x86 += irq_test
 TEST_GEN_PROGS_x86 += mmu_stress_test
 TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
new file mode 100644
index 000000000000..9f8895b89821
--- /dev/null
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -0,0 +1,170 @@
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
+		struct kvm_irq_routing header;
+		struct kvm_irq_routing_entry entry;
+	} routing = {
+		.header.nr = 1,
+		.entry = {
+			.gsi = gsi,
+			.type = KVM_IRQ_ROUTING_MSI,
+			.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
+			.u.msi.data = vector,
+		},
+	};
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
+}
+
+static void help(const char *name)
+{
+	printf("Usage: %s [-h]\n", name);
+	printf("\n");
+	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
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
+	pr_info("Injecting interrupts for GSI %d (guest vector 0x%x) %d times\n",
+		gsi, vector, nr_irqs);
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
+		eventfd_write(eventfd, 1);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		while (!GUEST_RECEIVED_IRQ(vcpu) &&
+		       timespec_to_ns(timespec_elapsed(start)) <= timeout_ns)
+			cpu_relax();
+
+		TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpu),
+			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d\n",
+			    vcpu->id, vector, gsi);
+
+		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+	}
+
+	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_join(vcpu_threads[i], NULL);
+
+	return 0;
+}
-- 
2.54.0.1099.g489fc7bff1-goog

