Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04062E7162
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538560; cv=none; b=icOzUVMiBH25VHAzGNOaa+9s66FH5ihj01NV9guNhEgDSV1Ay6Zu2UVteWRK0xrYUyDz/1XfyrslOh8RgXyznsY1Cup3yf4bG/gkVhJ+RYQXHXfUFb0QZTDLTWceMns8jYMNXVoSmZ25KX+Av3SaI9NvG7eHYD1IuYmymYFqYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538560; c=relaxed/simple;
	bh=zrNl+JH8vjU7uSPg+JCRyB18yy5SlEyRLk6yM7c1Wvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PA2i4wmGBcjuCERcnIsCgddyZhYk/WJkQrw8wOKLq68oprD86bjeKNylbzsoZCJAAUWBhlMeR+omv6bNvF0H1by9BGkqt+31y/ehL6hrDM+V9VlD1kAD5CpbBWrzVD3sJh109M43Q0fGX+P7wdPyAKc9X45Ad7S2Jli+qkzR+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/VxyUo2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/VxyUo2"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85c530ddebso136132a12.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538557; x=1781143357; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IXCqa1BPoqbMNgkQEA2NIjwyLKz0tdvhhBmIxPnEIvI=;
        b=v/VxyUo29SSiq2zFFq/VsOunEQlKDLA6r763+TMMy3gqDmf1xgJE6eyyWvaY7SqdO0
         KJjJSH6+vj2KlMjkZng2gnpYUoU6OI8d37xvre6T6SK60VL+Y/CQlEfmnsn28LK5aO2o
         8XW+IKpLtt69w2/xrvqHcPR5vZdtwqnRiYf8k7c+lvOhdEwb0kk76FwVD/jqX2NTRK//
         4FHSwiYey2QZhPHwwn5jm6OnlKIGvfpLMHTRAXRtMNtdTSiCS1vb/Bg3oVlQpedZhWXz
         Y6xvnU/sTIoqKUGYRYUDgun5dji8fvyri7qNYjEayYsR7cCpcMfEsOz2ski8wQ6W/pFU
         PYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538557; x=1781143357;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IXCqa1BPoqbMNgkQEA2NIjwyLKz0tdvhhBmIxPnEIvI=;
        b=ikDQ1uvgYQ59NP8thwSQEe11tIeb+nMrf6kklRkcVjmzF8slETZiX8P0wYNBUqjU2f
         LFJK5OjFwFVIGbaWbxw6G4m2nwY0IbmwHUalTm8ggmtvWBtWHXWjOUNz15d8DvlHKya8
         fjjF+RAr5Yf5ETAbrRFLvx2MX4HJZ6eZkuly7tSDxT4FEiVbhkUdS/2usVUhLl4qb3Hl
         +WxViDUZT6ahqrFytuC8cg3iD2xOCcaKf+4nq9bqpS6zCTXbqwvYDq04kU1IBB3cIw+o
         7l+8OoJiG66yzHx74aJk+XN9uhrjQfLSI2Eyg69W2+OyNwa6pgha66qP35NeAiMSgiKL
         ZEdw==
X-Gm-Message-State: AOJu0YxWO3WKLCGLwR/Z1E2AOIySqZdwfhlW+AZ0m9qYKHmgczRvdODN
	ZlIPPKktRj7ngncWKi3Z5F+C602jUtDUTp0FHxR0wUqQruQQRxLrPK/Q0NweDJGwDZ7xzS38kxE
	9sAstequ7
X-Received: from pgar22.prod.google.com ([2002:a05:6a02:2e96:b0:c85:b75b:a85d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7314:b0:3a3:171f:6aff
 with SMTP id adf61e73a8af0-3b497348e84mr6333680637.2.1780538556829; Wed, 03
 Jun 2026 19:02:36 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:29 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-8-jrhilke@google.com>
Subject: [PATCH v5 07/21] KVM: selftests: Verify IRQ bypass works in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
 tools/testing/selftests/kvm/irq_test.c | 64 +++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index d3fee51cf451..5b42d8abd1ea 100644
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
@@ -100,14 +134,21 @@ int main(int argc, char **argv)
 	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
 	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
 
-	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
+	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
+	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
-	int i, j, c, eventfd;
+	const char *device_bdf = NULL;
+	int i, j, c, msix, eventfd;
+	struct iommu *iommu;
 	struct kvm_vm *vm;
+	unsigned int irq;
 
-	while ((c = getopt(argc, argv, "h")) != -1) {
+	while ((c = getopt(argc, argv, "d:h")) != -1) {
 		switch (c) {
+		case 'd':
+			device_bdf = optarg;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -119,7 +160,17 @@ int main(int argc, char **argv)
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 
-	eventfd = kvm_new_eventfd();
+	if (device_bdf) {
+		iommu = iommu_init(default_iommu_mode);
+		device = vfio_pci_device_init(device_bdf, iommu);
+		msix = vfio_setup_msi(device);
+		irq = vfio_msix_to_host_irq(device_bdf, msix);
+		eventfd = device->msi_eventfds[msix];
+		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
+		       irq);
+	} else {
+		eventfd = kvm_new_eventfd();
+	}
 
 	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
 	       gsi, vector, nr_irqs);
@@ -147,8 +198,7 @@ int main(int argc, char **argv)
 				    "IRQ flag for vCPU %d not clear prior to test",
 				    vcpus[j]->id);
 
-		/* Trigger interrupt */
-		eventfd_write(eventfd, 1);
+		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-- 
2.54.0.1032.g2f8565e1d1-goog

