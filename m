Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC125B0A8
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052834; cv=none; b=P4rSrV4G8Eh4+H7kqHPz5fKtsCv4xOTbzKzGNaA4oMQqreplthtjs9hkolzz4TI62WHF+t5muBqjyxdeELw4oTJjKbffQmcuiAzlo8SbW1Xuskv/a77suM70CrZTsQs1AkoX77UpbjtTwekvwRff/6jKeN/ROzYSGOfLcaGmDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052834; c=relaxed/simple;
	bh=3kgZ4Hp3aocx9frJ+hGvONt/ETFM1SIvxHL3/CDxT+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dkdDDW54XCKeFLDySgBgihax3V6U2DHWBeNPASrZR1M0rI67W+PkjYMhckyWzTPsUDIn24PW3B5nb40fXA2edtsT9myCJn7nWarG8BlzDCQmHZzIK1Z6Se/IcDjz/tQ1ISz63KIzM5wsvjocywKTiEHtzmdz5gVaI++Ai8XwwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pkxZQCBO; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pkxZQCBO"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423f424d5bso4139150b3a.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052831; x=1781657631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ3/l2MPP25v59/w1QGxHHbEaCrmVOx/NA7PdBl04FQ=;
        b=pkxZQCBOHq+1pbkfOb0Fup7nlWHfKDVpJp5TLfy3mn+V4qCI5zG18Ko92QTFWhIe+j
         lw3ypmxIoMPWvjvs9Hq7Qxu0YPtI1F/8hxifvAYg7sffkdGzk+9SroguGq4GAaiabkCa
         R6gdRZeB4QTnUQ778Yde1XPx1pbJGUzzVx4Tl2+hQv6KV4gjkTgDnaY5KKbleUJH5ISX
         djuSSQfV7e8jprLZgQjpGhSX/7rPbvGTghR8HUf2zJPBAjj5uk+b60m2xT/rgUjWy7MN
         Jqg/BV2NLTrG9XGwqcaVXg7qyLmQJLF0n8f3hEDNKZjNGN9q124xpXpvtxXXleTzF1MN
         /SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052831; x=1781657631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uJ3/l2MPP25v59/w1QGxHHbEaCrmVOx/NA7PdBl04FQ=;
        b=LS1lMZ5JKRo9D5LQSKn2jfu/8zVAb4Sq8K/CRhiig5/uFJ81Yq+zyey4q37YjtqVkp
         cYj2gbOmYZt6Ew1DS9W6Nw1/cJsysI3cbCQg5JyxMMX91RbjzhvtQuxjKCoTJlYK3eRI
         KnoV1NEjyZIt7a0hZ96B+sAy7bcY6FwvUhf6upsb3MWehM6bz2ZCwjiDlUAt6J3W2/Xz
         2oUZnYuSszMs1ZfHBTPBnE1tP5LpBCOqKPfEVBv1iBChW/dHkbuPmm3zT/eYt60xdME9
         tP0hQQ6jRmO3hyOnU8ROWs6Ccz1JwtkYUBHTVTXU2LSXaU0mlEi91brdeJSWky6BiKC7
         wKNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a2B1VOoZhgxAv+CgbL7W8kZeLJ/kJHP1MTvJV9n3G90dTpIWnueDIV7bLeed2x6YFDJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJmWRMPTG7XE6UTeyvq2KyWaOlYVW2dMZnOaL1DBTq6CAQ8EfB
	TOslcr9jtaBk6PLbbZv02mDyxS2Wh5FPnxlpCGoVMcuNy1xt/xkaVWXKQNmWyrvnwXZkd1qoEuF
	OKXmqYw==
X-Received: from pfr9.prod.google.com ([2002:a05:6a00:94c9:b0:842:3697:8685])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21c5:b0:831:7f71:c810
 with SMTP id d2e1a72fcca58-842b0f9455fmr23501445b3a.35.1781052830791; Tue, 09
 Jun 2026 17:53:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:27 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-8-seanjc@google.com>
Subject: [PATCH v6 07/18] KVM: selftests: Add VFIO device support to eventfd
 IRQ test
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

Extend the eventfd IRQ test with a '-d' argument that takes a BDF (in the
format segment:bus:device.function) of an interrupt-capable PCI(e) device
bound to VFIO, and use said device to trigger interrupts instead of always
synthesizing interrupts via direct writes to the eventfd.

Using a VFIO device to trigger interrupts validates the end-to-end delivery
of IRQs for "real" devices, and when supported by hardware (and KVM), also
validates interrupt delivery via IRQ bypass, i.e. via device posted IRQs.

Now that IOMMUFD is a thing, auto-probe IOMMUFD vs. "legacy" VFIO by
temporarily opening /dev/iommufd, and skip the test if neither IOMMUFD nor
legacy VFIO is available.  Add a '-t' option to the user override the probe
logic, e.g. in case IOMMUFD is available but the system is configured for
legacy usage.

Note, the device must have a VFIO selftest driver in order to work with
the test.  A helper script to list supported devices will hopefully be
available in the near future at
tools/testing/selftests/vfio/scripts/list_supported_devices.sh[1].

Example:
$ ./tools/testing/selftests/kvm/irq_test -d 0000:06:0a.1

Link: https://lore.kernel.org/all/20260602222941.3133236-1-jrhilke%40google.com [1]
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 86 ++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 9f8895b89821..6888be54ee4a 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -3,7 +3,10 @@
 #include "test_util.h"
 #include "apic.h"
 #include "processor.h"
+#include "proc_util.h"
 
+#include <libvfio.h>
+#include <linux/sizes.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
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
@@ -74,11 +107,29 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
 }
 
+static const char *probe_iommu_type(void)
+{
+	int io_fd;
+
+	io_fd = open("/dev/iommu", O_RDONLY);
+	if (io_fd >= 0) {
+		close(io_fd);
+		return MODE_IOMMUFD;
+	}
+
+	io_fd = __open_path_or_exit("/dev/vfio", O_RDONLY,
+				    "Is VFIO (or IOMMUFD) loaded and enabled?");
+	close(io_fd);
+	return MODE_VFIO_TYPE1_IOMMU;
+}
+
 static void help(const char *name)
 {
-	printf("Usage: %s [-h]\n", name);
+	printf("Usage: %s [-d <segment:bus:device.function>] [-h] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
+	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
+	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -100,14 +151,25 @@ int main(int argc, char **argv)
 	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
 	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
 
-	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
-	int i, j, c, eventfd;
+	const char *device_bdf = NULL;
+	const char *iommu_type = NULL;
+	int i, j, c, msix, eventfd;
+	struct iommu *iommu;
 	struct kvm_vm *vm;
+	int irq;
 
-	while ((c = getopt(argc, argv, "h")) != -1) {
+	while ((c = getopt(argc, argv, "d:ht:")) != -1) {
 		switch (c) {
+		case 'd':
+			device_bdf = optarg;
+			break;
+		case 't':
+			iommu_type = optarg;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -119,7 +181,19 @@ int main(int argc, char **argv)
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
-	eventfd = kvm_new_eventfd();
+	if (device_bdf) {
+		if (!iommu_type)
+			iommu_type = probe_iommu_type();
+		iommu = iommu_init(iommu_type);
+		device = vfio_pci_device_init(device_bdf, iommu);
+		msix = vfio_setup_msi(device);
+		irq = vfio_msix_to_host_irq(device_bdf, msix);
+		eventfd = device->msi_eventfds[msix];
+		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
+		       irq);
+	} else {
+		eventfd = kvm_new_eventfd();
+	}
 
 	pr_info("Injecting interrupts for GSI %d (guest vector 0x%x) %d times\n",
 		gsi, vector, nr_irqs);
@@ -147,7 +221,7 @@ int main(int argc, char **argv)
 				    "IRQ flag for vCPU %d not clear prior to test",
 				    vcpus[j]->id);
 
-		eventfd_write(eventfd, 1);
+		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		while (!GUEST_RECEIVED_IRQ(vcpu) &&
-- 
2.54.0.1099.g489fc7bff1-goog

