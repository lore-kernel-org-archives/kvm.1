Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E13A0E84
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986088; cv=none; b=Lz+NzlV4SWeNFN4iPDacEpkpiMDwlpRkRsH4Dfuwhkw4GyVPiHYByVurwldhoG0mxzh1M8Bdvl4PjPCdBoCuYRYwrz/iITRnyBpce73dtZcu5wi+3Im+ZxWkSrfgp4jrr99w6CSCrkAFWCKvTBHKG5YxtE9wUreOg0L6MuFCffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986088; c=relaxed/simple;
	bh=5Ym4IDJ1ONO6l3piQhvOANwoFlFN72kjVn6PpDvaF3Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDq5zCPgFhJTN/9TZJIL103jYniddlncpJaahz1n2hRRr8yJjY40aB9kA35MtKoRSVxD3boCyNVDMvGlki4aZz2zHwBcmWZvTEB8H58VU0BZn+MgpI6NHC1dtD6tE0lCv0YJ934mCYfASYzstC+fR/u0+ugotMOriGdNMr/qMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwJ4tPOT; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwJ4tPOT"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c83bd48afso3045360b3a.3
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986087; x=1775590887; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0agTUtp+VbLRknVdfliX0MIdMTy6HZ2MFwP0wzMvvDs=;
        b=FwJ4tPOTI54lwskjktcFMgsqikHC5I/gMcyg+8sXRQVkyY0xkKAPCS44GaFFsb+5Gx
         SwUAXMDBG7DzL5MV1Fdx8nYTerqJ+IGbcXLGpbEPPAidz4crsb2SETZqIFZvugat2sjk
         EDxq8VP5i+H5q59hZMlDYcLdWyXjxennQNGQ4+CtcgScq7Hq9HXtUCG43Hvu8fpU5QBV
         fdffFdJwZCaslGmo8Pz8NgJ1Me/iPXv6l8UeqjAMDT/MYLtGrfZJ+vw7tqeGOohwRd16
         DpOiert7gHdQV2nCUl90hKf6619ck0ytSFKCJb8/w+Dkncpl7dB73Il/uwOXssP901sU
         ikZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986087; x=1775590887;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0agTUtp+VbLRknVdfliX0MIdMTy6HZ2MFwP0wzMvvDs=;
        b=QraLkiWD/DwpSLViFNWqcaQTePrg+76gUJn+sQVOAydxOVVD+wj9dXuucOAfLMhPLB
         g/7nROwlmnSrSLJ0PrcUHvVwXIWPmHT/B02/zI9ArQkxmfV7TfuSUgPJDeDptdStONO3
         HKRuEmHfVFMhKZ48VcuxJgTdiK3hy04HNhs6PBRMSwEgljAtojXDyZgBiPBdOjRIRQtq
         TiQDXXfCNv/r9R666StBBx8YKzOgP22Vrv8GKVAQ7UzBI+xVKF+KhWHBCYhmY1b53XZG
         IPq3aAeRRQE3qflQKwjF3qVbDZe+ui3FF5MGn10OA56Xi6FZ0E0A/XooCCvYDuBkBy2o
         kD1w==
X-Gm-Message-State: AOJu0YzMLEljXMjyDRONJjOznEgfNsyb7TlqVtOuattNnWXKdie7NyEm
	ckKb9f9OJLrY0Ip2MCC8NmLj2n4waHXoxPw6RRAXo/Q/FwrKj4mSZSN08TUqfFgsSFzmxM5McwD
	m+6OkaxyK
X-Received: from pfbna41.prod.google.com ([2002:a05:6a00:3e29:b0:829:8b09:e941])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a27:b0:82c:ac06:3004
 with SMTP id d2e1a72fcca58-82ce88eb9f4mr884562b3a.8.1774986086494; Tue, 31
 Mar 2026 12:41:26 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:22 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-4-jrhilke@google.com>
Subject: [PATCH v2 03/14] KVM: selftests: Add vfio_pci_irq_test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the initial implementation of vfio_pci_irq_test, which routes and
delivers an MSI from a vfio-pci device into a guest. This establishes
the core test infrastructure, including the vCPU thread loop and the
basic IRQ triggering mechanism using irqfd.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/kvm/20250404193923.1413163-68-seanjc@google.com/
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 217 ++++++++++++++++++
 2 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/vfio_pci_irq_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d8f77e181e8e..4220edaa466a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += vfio_pci_irq_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
new file mode 100644
index 000000000000..6f40b3c2b985
--- /dev/null
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "kvm_util.h"
+#include "test_util.h"
+#include "irq_util.h"
+#include "apic.h"
+#include "processor.h"
+
+#include <stdint.h>
+#include <pthread.h>
+#include <ctype.h>
+#include <time.h>
+#include <linux/vfio.h>
+#include <linux/sizes.h>
+#include <sys/sysinfo.h>
+
+#include <libvfio.h>
+
+static bool done;
+
+static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
+static bool guest_received_irq[KVM_MAX_VCPUS];
+#define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)
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
+	while (!READ_ONCE(done)) {
+		cpu_relax();
+	}
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
+	u8 buf[sizeof(struct kvm_irq_routing) + sizeof(struct kvm_irq_routing_entry)] = {};
+	struct kvm_irq_routing *routes = (void *)&buf;
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
+static int setup_msi(struct vfio_pci_device *device)
+{
+	TEST_REQUIRE(device->msix_info.count > 0);
+	vfio_pci_msix_enable(device, 0, 1);
+	return 0;
+}
+
+static void send_msi(struct vfio_pci_device *device, int msi)
+{
+	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
+}
+
+static void help(const char *name)
+{
+	printf("Usage: %s [-h] segment:bus:device.function\n",
+	       name);
+	printf("\n");
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
+	*/
+	u32 gsi = 24 + rand() % (KVM_MAX_IRQ_ROUTES - 1 - 24);
+	u8 vector = 32 + rand() % (UINT8_MAX - 32);
+
+	/* Test configuration (overridable by command line flags). */
+	int nr_irqs = 1000;
+	int nr_vcpus = 1;
+
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	pthread_t vcpu_threads[KVM_MAX_VCPUS];
+	u64 irq_count, pin_count, piw_count;
+	struct vfio_pci_device *device;
+	struct iommu *iommu;
+	const char *device_bdf;
+	int i, j, c, msi, irq;
+	struct kvm_vm *vm;
+
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	while ((c = getopt(argc, argv, "h")) != -1) {
+		switch (c) {
+		case 'h':
+		default:
+			help(argv[0]);
+		}
+	}
+
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	vm_install_exception_handler(vm, vector, guest_irq_handler);
+
+	iommu = iommu_init(default_iommu_mode);
+	device = vfio_pci_device_init(device_bdf, iommu);
+	msi = setup_msi(device);
+	irq = get_irq_number(device_bdf, msi);
+
+	irq_count = get_irq_count(irq);
+	pin_count = get_irq_count_by_name("PIN:");
+	piw_count = get_irq_count_by_name("PIW:");
+
+	printf("%s %s MSI-X[%d] (IRQ-%d) %d times\n",
+               "Notifying the eventfd for",
+	       device_bdf, msi, irq, nr_irqs);
+
+	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
+
+	for (i = 0; i < nr_vcpus; i++)
+		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i];
+
+		while (!READ_FROM_GUEST(vm, guest_ready_for_irqs[vcpu->id]))
+			continue;
+	}
+
+	/* Set a consistent seed so that test are repeatable. */
+	srand(0);
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
+		struct timespec start;
+
+		kvm_route_msi(vm, gsi, vcpu, vector);
+
+		for (j = 0; j < nr_vcpus; j++) {
+			TEST_ASSERT(
+				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
+				"IRQ flag for vCPU %d not clear prior to test",
+				vcpu->id);
+		}
+
+		send_msi(device, msi);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		for (;;) {
+			if (READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
+				break;
+
+			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
+				printf("Timeout waiting for interrupt!\n");
+				printf("  vCPU: %d\n", vcpu->id);
+
+				TEST_FAIL("vCPU never received IRQ!\n");
+			}
+		}
+
+		WRITE_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+	}
+
+	WRITE_TO_GUEST(vm, done, true);
+
+	for (i = 0; i < nr_vcpus; i++) {
+		pthread_join(vcpu_threads[i], NULL);
+	}
+
+	printf("Host interrupts handled:\n");
+	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
+	printf("  Posted-interrupt notification events: %lu\n",
+	       get_irq_count_by_name("PIN:") - pin_count);
+	printf("  Posted-interrupt wakeup events: %lu\n",
+	       get_irq_count_by_name("PIW:") - piw_count);
+
+	vfio_pci_device_cleanup(device);
+	iommu_cleanup(iommu);
+
+	return 0;
+}
-- 
2.53.0.1118.gaef5881109-goog

