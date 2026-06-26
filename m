Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE33C1081
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509751; cv=none; b=YvDkcEVP2Rb0KIUFxxams8rF2R55AocBR4SWpEYGjqTfp+DYqs8KepsfV58EkSWOav/jVwb0hjLT5Cfl17vvGKmgkcwT1C+tYxumso0AVd8vlRSY06ushoEgNWegy4GBIVaVtzybwF6rQO2H14X5AocFXaf5zK+aUV5k7MYdR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509751; c=relaxed/simple;
	bh=qB0d72ez1NHl3UqKmCwxaCkrkHi0KCAo7LAgN3ooies=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IzskbPo5EWjhUjYfKUSprvw99ek48AkJh9vYaBE1D9jDWGZp/MzAFHs09jbYNdjqMzOo+ISOiPlmi5VTTR+KwjsAj8VIdkkWECnn/3EsP1YCwz6DED6VELLkXNz2iALmDG6Y3C1HeQwEOwr1bU0ynPb6FnNVScGA0bKBCkOwpx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J6CPaaxT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6CPaaxT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88fc985a65so782544a12.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509747; x=1783114547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2XjP7ltNePjDS5cnt47gmPWCN7JEd91hh65v72L1LY8=;
        b=J6CPaaxTut0mKnOeBBcCUJfnSa0mCifmeaeL2SaoJSN77705gC19kdhS83e9UOJrqq
         WmURHlV75LFPl8RTeBnsFCtKFBgJwrZFu+7wE/odDaJjHP47fDcdf6E5la3GnutjVH9w
         x3TwUr/w8HgfhM5Emf+CPYvsylgcwvDdtdwrQAx1LEsMIBqATnK95E+4kxUHpvk/Su3L
         /8SUCOd9nMCMML9xRTn+8orCIuN6MuuFhYyvY+DPR9wOWTXAR91/RkopAA8g/wRbkreV
         b8jEwwogyAByn4kn7hJukSOqD19ffKmvwOlTtExPobT+VZAu3xPXPvpVxFsiKtsu4lcn
         KcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509747; x=1783114547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XjP7ltNePjDS5cnt47gmPWCN7JEd91hh65v72L1LY8=;
        b=FKa8VTxbaJZrd7F7yh4y8LBK/kRtbSYcGZaN3aMjk6vPkp/sSYBQZrXFrPg2nwFEDe
         Zs4eSx7PBCF9Jebcyjmu+A8pEzptxKGRVT5HX9j1bKdEhjTBkJ8SeV/vvHwooFrZ/oKz
         e4Jmq8fCXYBAX1hsTPO1QQVIhHK1pBUIAdNkl/toPC2k9n5g2WjozUQOr3y4Lmv79FLa
         K0TKx6oKPqmgRqd/EIi3jzehqiGw/QbLR+QRVj7jvtL2BZHQZaGceSPnoEKj5NjI5zdQ
         qYhIz9pZhxmvm5GfUOnabtAC/fua5XTyZolSLwcY1zwaqA5jCii0BciE2pbPBY6Gxx5N
         1fvw==
X-Forwarded-Encrypted: i=1; AFNElJ9VT+P/NmRZvFET+aIeBMmodfLJx47oRoPlXzTPKKoAPkRu+AwaLpi/DJg0LYJPvF964K4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9qpSf9/y6KW+lr4YoMgGn6GoojnQZNx7ZRwzGt92AQqTy0aP
	iZ25H8IjY8EuEIMwXekdN3HMQR5p8zMEEc7oMYRwIn8jBTKm184ou6CUPfDMOAQ/o10qjmnUavH
	AggLMYQ==
X-Received: from pgcv18.prod.google.com ([2002:a05:6a02:5312:b0:c8c:6076:b4a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1bc1:b0:39f:24a5:3065
 with SMTP id adf61e73a8af0-3bd4aee9d34mr9183524637.7.1782509747404; Fri, 26
 Jun 2026 14:35:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:22 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-10-seanjc@google.com>
Subject: [PATCH v8 09/20] KVM: selftests: Add VFIO device support to eventfd
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
 tools/testing/selftests/kvm/irq_test.c | 98 ++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 9f8895b89821..70b2c9cac279 100644
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
@@ -55,6 +58,48 @@ static void *vcpu_thread_main(void *arg)
 	return NULL;
 }
 
+static int vfio_setup_msi(struct vfio_pci_device *device)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	struct iova_allocator *allocator;
+	struct dma_region *region;
+
+	/* Sanity check that the device+driver can actually send MSIs. */
+	TEST_REQUIRE(device->driver.ops);
+	TEST_REQUIRE(device->driver.ops->send_msi);
+
+	/*
+	 * Set up a DMA-able region for the driver to use.   Very few devices
+	 * provide a way to arbitrarily send interrupts (MSIs), e.g. by writing
+	 * an MMIO register.  Instead, most devices send MSIs when an action is
+	 * completed, and practically all actions involve DMA of some form.
+	 */
+	allocator = iova_allocator_init(device->iommu);
+
+	region = &device->driver.region;
+	region->size = SZ_2M;
+	region->iova = iova_allocator_alloc(allocator, region->size);
+	region->vaddr = kvm_mmap(region->size, prot, flags, -1);
+	TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
+	iommu_map(device->iommu, region);
+
+	iova_allocator_cleanup(allocator);
+
+	vfio_pci_driver_init(device);
+
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
@@ -74,11 +119,29 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
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
+	io_fd = __open_path_or_exit("/dev/vfio/vfio", O_RDONLY,
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
@@ -100,14 +163,25 @@ int main(int argc, char **argv)
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
@@ -119,7 +193,19 @@ int main(int argc, char **argv)
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
@@ -147,7 +233,7 @@ int main(int argc, char **argv)
 				    "IRQ flag for vCPU %d not clear prior to test",
 				    vcpus[j]->id);
 
-		eventfd_write(eventfd, 1);
+		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		while (!GUEST_RECEIVED_IRQ(vcpu) &&
-- 
2.55.0.rc0.799.gd6f94ed593-goog

