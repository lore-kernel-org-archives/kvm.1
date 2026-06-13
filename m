Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19691A9F8C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310046; cv=none; b=HIrsY1EjgwnsQToPHd30hm33JsEMfsFQHQ0q+dNHzdI7TqLfHrUgpMh5yLnDC0wlRTlx1Mx5zOq8Gg4HlIDnr+Hg1ea5SSFytELJf94OU3GwXsSs7nsY5dDzdyWhllkkXzxh8dO7AYZoDA96fOX0CmIL3YeYeAioWIfK41wyJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310046; c=relaxed/simple;
	bh=s0bpQt5NuHnGfmMetQxC9qly3FYJZ67mlGuCyv4j5uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FDvoWHQsy2eKTwYm/DE5fzr1YaKXT+nLjdUgeOmpjxu/gzsUjknV1B3lwUzlqIyPzV03hDlNmHEQj3UJI6SHIIz3wSMdBUmPsRxtA+6WmdaHhJKdwy4oNoNl9Y2+5yX6GZuYQvf0+Fc5KOzH7KQun3s3i2cnVJRIrMFvqPoVvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNIXHJbz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNIXHJbz"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a298cd62so1135159a12.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310043; x=1781914843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AQKAT4ecSXXBBlOYiZyrbyjt8/WfFZTiCmselJ1RZro=;
        b=dNIXHJbzbbllCAlSc5zmKANA3l6J97rVUXhMcEcn4TX4SGdF6f4LtsOEDfP0vvJ0nB
         7IC+vvkiup1YnbPPD4fjoVPRunZtbvMP0/gO+3tkLphGeYFw878v+fxVbL0qdvOqk2SI
         KPBTu6C7LZV+fNbbtckCwQy+Qi+Qty41rLyPsEJNWMWMDjy4bhbkpvSF8w/2kV8GuTOP
         Em8SdaUaOEsa5b9u5/FtKGRjZM7hH77t2/i4/jJbTKu/LH1pt4BSbeEavX1IaIEr71fV
         LVT3GlX+YvoojUY1+Nk4063SxFAxjIdxXQPpekEwX9Cjmgs+S4ys1Q7R5lM8XMNzsPBD
         d6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310043; x=1781914843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQKAT4ecSXXBBlOYiZyrbyjt8/WfFZTiCmselJ1RZro=;
        b=Ort/LPprLe7rjic2BcxkrEddg7LtE4NT/RXx59UP7oKdnhSpTDBaDTeaKui1IXX6HF
         /+UThefOPm9n872a8iIwv9YFw83aQDu69V/09rRi37I2p0j+GGVTwFeNgWuEF1FnYkc2
         dy95qpmv12kZBANmTvPdIGFdiKsDrBMNi4tQ/R547n7o2DsZa70/D6eOXXizYU6htewA
         e5L6sgRjrJkI+zyTSQstH3YA1n3Q7QrEGpICMv+00i4nQMflgrPJ5fQerZlxLCOF2kQV
         cjrLhtiPTwW2E3TRBcqrRBEIA05KuLpSKouI3xQHEDm1pnjVG5fB5hemD1Vl+fjeMvHG
         ygmg==
X-Forwarded-Encrypted: i=1; AFNElJ9GUgIztdy9Qhit6Gv2Si7EkCzGV5RnpkAywc22b5todGg65IGHaKcNNW6IV4ptY+b9Tc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygaeEMWx5LkZuFVqaOaH2cpSyH7uhTz+Cuo4XgTV/bq47eWYWH
	0pcHG8Eovhb5lGLJWiTLJ30lEOcmDAfFpepTUNvLsVnpDvyc/2Ly6xIrMdBDGMCGTmDTdHB0AJo
	2nlVjEg==
X-Received: from pgo32.prod.google.com ([2002:a63:e60:0:b0:c86:2164:967d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2585:b0:3b2:924c:566e
 with SMTP id adf61e73a8af0-3b796421dc3mr1897654637.36.1781310043121; Fri, 12
 Jun 2026 17:20:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:18 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-8-seanjc@google.com>
Subject: [PATCH v7 07/20] KVM: selftests: Add an irqfd send+receive (and later
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
index 59ec232b1e93..de5f6e91203b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -157,6 +157,7 @@ TEST_GEN_PROGS_x86 += coalesced_io_test
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
2.54.0.1136.gdb2ca164c4-goog

