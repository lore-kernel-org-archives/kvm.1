Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0B39D6D7
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813399; cv=none; b=XyCvpypuvk04G91EPASm9J5EwSd96kciNfkQOsHVzLkt//XPImyDNlIVunuLqerrNF3nVe1q36vROGzRrfq2c74oZABVAc+gR3nJaUXHtZecloOlu9VWK+NwXwRYgnjl75WPT11XtI16gO1i14z971H+TpKcWW3pPbtvgHx8iN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813399; c=relaxed/simple;
	bh=Zagm7ot0pvac7A0w6F89lFrDv3pvnEw6X4kD3+zQuNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f3PMb9arK3+o0AsGIst7enf27YFcAcYKMTi/LeHOtnNGDguFeZGnHfk53jiPz19UE87fR1GhDTNq1W/JCHVh82PXXVbVlQKcpdANxIj1T6im6T/N7HzrQ0T6MX/4aDnith+DcxXvbj8nBt0nDmYhtpPrZad0gaBukOJAExZ9qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDZj8eYP; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDZj8eYP"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso2345349b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813395; x=1777418195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ECgA6/sdKM2W357V0lC8UhEDIugczN8oX9UZAE2qr+s=;
        b=IDZj8eYPcLCHxxb5IuG/Sh/42Gd3ANkaEwNT0eA1bZMd9q7kV1ILOX8/3nf6i2QEsy
         XU3eNUPhTaSOvSv8xUa8DVaXy0hun6vYyeSAzIuu5CQGb1wmcFlwzXPOWeCSMVmqrHsI
         qbvqQoBwX21wdDRRwM/PyfLYmi7alt+roJ6nRNg1DFdrWhZgZo9xViUqBSXgxQnlVMf5
         drQ/3ZQxHaqQBly7buk0JzetBAKFZqJ2aJ/G2AjOI+rwwBc4UetB1l5EhRr0N6frZ0to
         K2ceiMYYj7bb62TnQXB6uPaWDADWAST4Xm5Y7lkX5QEAjuLckuwmacVNJMKAtCtbDZKA
         ANCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813395; x=1777418195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECgA6/sdKM2W357V0lC8UhEDIugczN8oX9UZAE2qr+s=;
        b=edetOtqQtXhPk1+DY/so/r8ObmrgkR6/aq8bpjdo9PT/hnAHZjTIq9N+yMxeVpLJZd
         n0djqC+2LOVFyYELHhD3npWLUQf/5l3h6JH558iNNyiyY6y3GKebeCn7FG/SJ20K3K5i
         EvJSqA40qP7OJ4wk/Kdz39jbbYqM8g74XtiR7lSU1FxBm8PN/dLMvikf4lJY0wD8vwT5
         YYMP+euy6sGNS8G0S4UC6Non12LP8CmhFr7CdUQtXtHfL+ADMj3OGT8iMIbF5XYuTFEM
         A+et1cyT7njdxXHnKFbQyYHC3/Gg1xj5ZvtlpP3o2d3hXtcoXLYM23TsjsJcqJc260+i
         /Qdw==
X-Gm-Message-State: AOJu0Yx+vKNXrZBP1LczNd4hnfiWTsORS2VxPqWT+vuenoQEOli4b9WV
	WkYdxSRPMi40VoPjQrZRrMzIH2h3ipc10HHtuNRrMsPQ0Kw+f4nGxLn7tG3lv9Mg3/xe2yVP1eG
	OXIrWUVZU
X-Received: from pfmb3.prod.google.com ([2002:a05:6a00:1143:b0:82f:a75b:f7fa])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:92a7:b0:827:4bca:f1a2
 with SMTP id d2e1a72fcca58-82f8c87e27fmr20134382b3a.10.1776813394911; Tue, 21
 Apr 2026 16:16:34 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:48 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-8-jrhilke@google.com>
Subject: [PATCH v3 07/16] KVM: selftests: Verify device IRQs are routed to vCPUs
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Trigger real interrupts from a VFIO device instead of emulating
interrupts using KVM eventfds.

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
index 317e04899df3..434dce7188cc 100644
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
@@ -52,6 +55,36 @@ static void *vcpu_thread_main(void *arg)
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
@@ -73,9 +106,10 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
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
@@ -99,12 +133,18 @@ int main(int argc, char **argv)
 
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
@@ -116,7 +156,17 @@ int main(int argc, char **argv)
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
@@ -145,8 +195,7 @@ int main(int argc, char **argv)
 				"IRQ flag for vCPU %d not clear prior to test",
 				vcpus[j]->id);
 
-		/* Trigger interrupt */
-		eventfd_write(eventfd, 1);
+		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-- 
2.54.0.rc2.533.g4f5dca5207-goog

