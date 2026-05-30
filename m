Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FD2248A8
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100597; cv=none; b=AJapZW6NgsT0SyVy5soFAtQS0xi2CPQP2rYGJP0mZtgT5Ng1LgSQpaTLbBRAoVRGKP81elHO5/nBxmCLBoJtK9a6U/2ZR224m+SzQNK8rI95rwJARyV3I4VHPV9G81O1bv44BsPpdRoBSENc/36tdKAvz7uPkc8IQBqHW+gWUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100597; c=relaxed/simple;
	bh=aF6O9VsSjQ97pF3SrAsvLPtLXN6re5Q7TRYgYqYPOZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M4poc1TzIFoN+f75ylMmfVN/o5CSOAFJVv/JyVfM8xDZjzqTVWU5Yqv6rhZmbA3M2kEAEfVKBe+pZU+j0EDB87zvrE1sREKTcBX1rtZktkapO3wVyhrgmy5aaHJn864dV5v2Srk9/xfOMvrt3yD73Y8BlEmaC1RBgK+Tob584pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EL3k2J+l; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EL3k2J+l"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba98cc003so1322909a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100594; x=1780705394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1p04x6ZghZmLiQW4r6y7TuUkEl7HeypX+13BZ14qNiE=;
        b=EL3k2J+lHvpsnI9YEkzX3rvrUYwExE4gsgH6CGJAuw0BQJTHlB98fMpIdSwzsFEZxN
         MRoqpDbU3S2gIp9yVERKBQHhBYM4L0YbviAkTssk9/ACFP1capT8fA9Du87zUDQ7Jh4n
         fkmTW/p6pp5rY+V6D4B1j9E9/dLWkEln7oU2vkIGrAq0Lsk46iSeX018ejridubYNCH3
         EsxCJ2kVGmogsWtEqvS1FEQrq+Kmw5yblRoTJhPPbXGq6zo4NzKY9u9aHJMb8IFCV9WG
         KA1mpBurXbhHyEfNLIivMlCDxVQg6y15PjYWvQdcjKRbe1Fg7DefzvYKonbXGV/zxHDi
         pQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100594; x=1780705394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p04x6ZghZmLiQW4r6y7TuUkEl7HeypX+13BZ14qNiE=;
        b=pdEItFttosP8jW1nKb7QRCL012aVApMaNZHYoExX9yQaaVVw62aKfXwehIrn2UkJ36
         +s2AsE7xgrHfGkm3QoKPc5lH4PyGt42k5NVgvV79ZQqe65fRJuy0Hpi6UYCoNUQmwB1t
         AF+MgKx5zvPVQpot9SIuqrrOAeZy47NowhleNsFsFFL0Fnt8t6YbeBIwhOBlSbTel35V
         GuA1vFNq3X1L3sucblbwkEYHFZo5+EtozPloNd2qNjHIHS1hMwzvvH2iNbFXAsOCRxbJ
         mGYNfOYBLkK3MMuRf1wGT9J/VOst3DzvSFxbgmQavDl0wV2tFUS0I49uB8MngdEiDMK3
         iyYQ==
X-Gm-Message-State: AOJu0YxVPH/uUqP+ftm8KzmLTKv1tld9YTP+zL0sj183wsMsBM3SqR+u
	PKQ3PfVnMdJxzPKE/5rSbl5aA/FwRhZWuc5mNoKA3CHwS76rN70NxvB6As6fR88kPDusPX0A5b0
	JCZP1CfV9
X-Received: from play17.prod.google.com ([2002:a17:902:e191:b0:2bd:16cc:1966])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2409:b0:2bf:211c:4977
 with SMTP id d9443c01a7336-2bf3686ccc3mr25408265ad.36.1780100593997; Fri, 29
 May 2026 17:23:13 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:22 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-8-jrhilke@google.com>
Subject: [PATCH v4 07/19] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Trigger interrupts from a VFIO device instead of emulating interrupts
using KVM eventfds. This verifies that guests receive interrupts via IRQ
bypass.

Add a '-d' argument to tools/testing/selftests/kvm/irq_test which
takes the segment:bus:device.function number of a PCI device bound to
VFIO which will trigger interrupts. The device must have a VFIO selftest
driver in order to work with the test.

Example:
$ ./tools/testing/selftests/kvm/irq_test -d 0000:06:0a.1

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 61 +++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index d3fee51cf451..616eb38c05b8 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -1,14 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "kvm_util.h"
 #include "test_util.h"
+#include <linux/sizes.h>
 #include "apic.h"
 #include "processor.h"
+#include "proc_util.h"
 
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <pthread.h>
 #include <sys/eventfd.h>
+#include <libvfio.h>
 
 static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
@@ -55,6 +58,36 @@ static void *vcpu_thread_main(void *arg)
 	return NULL;
 }
 
+static int vfio_setup_msi(struct vfio_pci_device *device)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	struct dma_region *region;
+
+	/* A driver is required to generate an MSI. */
+	TEST_REQUIRE(device->driver.ops);
+
+	/* Set up a DMA-able region for the driver to use. */
+	region = &device->driver.region;
+	region->iova = 0;
+	region->size = SZ_2M;
+	region->vaddr = kvm_mmap(region->size, prot, flags, -1);
+	TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
+	iommu_map(device->iommu, region);
+
+	vfio_pci_driver_init(device);
+	return device->driver.msi;
+}
+
+static void trigger_interrupt(struct vfio_pci_device *device, int eventfd)
+{
+	if (device)
+		vfio_pci_driver_send_msi(device);
+	else
+		eventfd_write(eventfd, 1);
+}
+
+
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 			  u8 vector)
 {
@@ -76,9 +109,10 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-h]\n", name);
+	printf("Usage: %s [-d <segment:bus:device.function>] [-h]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
+	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -102,12 +136,18 @@ int main(int argc, char **argv)
 
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
+	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
-	int i, j, c, eventfd;
+	int i, j, c, msi, irq, eventfd;
+	const char *device_bdf = NULL;
+	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "h")) != -1) {
+	while ((c = getopt(argc, argv, "d:h")) != -1) {
 		switch (c) {
+		case 'd':
+			device_bdf = optarg;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -119,7 +159,17 @@ int main(int argc, char **argv)
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
-	eventfd = kvm_new_eventfd();
+	if (device_bdf) {
+		iommu = iommu_init(default_iommu_mode);
+		device = vfio_pci_device_init(device_bdf, iommu);
+		msi = vfio_setup_msi(device);
+		irq = get_proc_vfio_irq_number(device_bdf, msi);
+		eventfd = device->msi_eventfds[msi];
+		printf("Using device %s MSI-X[%d] (IRQ-%d)\n", device_bdf, msi,
+		       irq);
+	} else {
+		eventfd = kvm_new_eventfd();
+	}
 
 	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
 	       gsi, vector, nr_irqs);
@@ -147,8 +197,7 @@ int main(int argc, char **argv)
 				    "IRQ flag for vCPU %d not clear prior to test",
 				    vcpus[j]->id);
 
-		/* Trigger interrupt */
-		eventfd_write(eventfd, 1);
+		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-- 
2.54.0.929.g9b7fa37559-goog

