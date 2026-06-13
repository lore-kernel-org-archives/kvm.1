Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704EC259C9C
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310048; cv=none; b=WQ/DYxNONllITjwYkR7fi7ONJFyPSJCbX/S1gCqq74F64maB/jayv3YH/gNIRYoGbmdzk5e+PioCouOIK//jxtN3U0XeTVgcz926JEeCBM/6dx3bZu7jADToxXjOxYfbfK0FFjVW+RS5s65BDqzFjbjfU2ApZvwmkxni4lawOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310048; c=relaxed/simple;
	bh=VsOVTXzdFi+lMwQWBy18h6E94UCvpdzzHRjGZnk8RUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IF1c55xUq0gfM0oxDPUl7KKriQ4ljL29871Y0bsjHISsP8esVs6Iyj9fez4zM8jqq0YJclEm36w7o+KkvD0/2vsGOcJOLwUQzHZjNnYPGrhGRBmkRY+Xmmntg+WpZQPIBufD5etnQIwzK4CFgCYrfSGpPCzSqOYz0usgg3fpP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jgWammvH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jgWammvH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2078702a91.1
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310046; x=1781914846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rbyYS8ZaN6I18K1C4Zmj5fncA5FOF75opinAhCG/xTc=;
        b=jgWammvHQU3T0Ry06H1QAuCp2eOCiqnmXuqKE8d1/C14N9o0sz1JlWdEeo97ACkeDF
         DDXUxAoiN1UQjKhdBbTCDib7HRdgM7jEJKVd5rYdaFdBVbg+XrPCH8OYM0fqdje5c7DY
         GDZ3NTjJHpZVcAmmvV+5hRq/IRDZ17D3vmRuKwRpJdf3jDTo/BXV/W4GpjqRrqAJLC03
         6vUsiyFlGTIkFkZ8Wh9Z+5Fs3/Gqow6L4L2QiDusj8sr84gpl9dlhO9xZPsAcM/eCEba
         QHmc1/Bnrc5mQ3O/g1irK5alCzZroHmbnBxkssWP0AqIFU0O7DEnyQXiWKhDASMVl9qd
         dNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310046; x=1781914846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rbyYS8ZaN6I18K1C4Zmj5fncA5FOF75opinAhCG/xTc=;
        b=O2C6mZgxS5V/id7LXh982u5QphRVY2h7ythySlFijJQO4vwz4JUTeWb7SqxjPtoLka
         YdUOC33nKrTSIT2AaEo8DUWiNoJgb2O6ZNXjan2qxc8yfYjOv/gc4hzWzIeIIvqQ/BXY
         7G2h8uf9TXqeGHXU9rywKAiHhNG5YCh0x3BMnTNp5bzO978XNlMAcvqpMfurF/A36dqA
         dH89DC78JA3NSA1v0iCDawH8pRXwGH+siv0oB+q/s7uY1PjRaot6HRDmHDrkn0J62ky1
         ZqRPJRRILbW1kqzpW4C3rRkjkkweuaoMQ6ncb3/9JRhC2/ZlaeEePim+iEJJC81Ng56k
         3wfA==
X-Forwarded-Encrypted: i=1; AFNElJ851bHznRDUgjAuKOE7674qi2yh3XykWkRqXJSMoG97qOC8neB1mGgxvcbC18dAsOCxw1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6it3xUSgh3o86ZwG2vNi2a71RTNSH4OeeicpOSXdk+Rkgcvz8
	WA5O3nFYozXNOhLf+rQ0cp6j24EkvgBUGT3gWqYEFSFzEyTThVrcA/q9vL5uNkY5bIJ9ab6tVHg
	pi1KI5g==
X-Received: from pgge7.prod.google.com ([2002:a63:db07:0:b0:c85:104d:a751])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a123:b0:3b4:8f4a:3bc6
 with SMTP id adf61e73a8af0-3b7963db64bmr1960906637.32.1781310045422; Fri, 12
 Jun 2026 17:20:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:20 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-10-seanjc@google.com>
Subject: [PATCH v7 09/20] KVM: selftests: Add VFIO device support to eventfd
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
2.54.0.1136.gdb2ca164c4-goog

