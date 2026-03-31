Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CF3A255D
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986099; cv=none; b=JqA1r7MMzZeCvbdW2xUsu1PzNLF7moWhKRILNQZZE9vvUAC+63Q4zBVAb9Xid1v4gkUol39MWdl9u3FshS8GazStB27iaZOkN/18AmghL1CVkYK2Gvf7PDXnTjykpHKAVEgcL7YN4g1xWLz9ufx5MFAeJW8mIwmKcFncruuvoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986099; c=relaxed/simple;
	bh=phQ0Tx4BgI6zgyod9STlDIcT0MA2f908MLa7iNjHQMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R4lnw/XEF1941tCNTvGsgnFIPK43irtvDwkPlumj6IHJ/fNXMDPndUUHMqK0rdIhmuLdIip3JyrHLNz6oXvWLqJV7p1RIQHpPI0K2RMlyGXRSchN/n74wj87fT7r9NfrvizIzHNHDCYxZAX5dbkwVCSfr2/okJn8U2Omb11O9MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdqLKyst; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdqLKyst"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c69a734a4so4655044b3a.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986097; x=1775590897; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtp5GIRcgHf7RkSluykZLrqHpCUTb+18Ya07A8XWh/g=;
        b=KdqLKysttvrLUiFjA+5bBArFpsUST/LCLnNK3V6wRo+vIyWtHtT8ZMTIrY35wZdF9v
         YV7uAZP9BhoWhTrr3JfYaoaSzGACqaL87rytI+SBd5DRb/VhSrnU3okpuxsnEL+TUgPh
         ZhDTGfJKndCWS0zIXyj3CPJlWgBvQO/FsqBF8b4t66mkP0fKcmoTEx3libKoaClZtSC4
         1NqLQzj9Z85kMCuuePU2D6iFxHYKBa/0ilFSDHoJMTTYnXi/yuMLTJYTeqRjuDhXz2Lq
         guF3YwhYGoLQqDV94dfFojc9Yx7VIvT90AzGH5JGiXivTR5iP8MAVc9/IUZvmaJi14+4
         5ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986097; x=1775590897;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtp5GIRcgHf7RkSluykZLrqHpCUTb+18Ya07A8XWh/g=;
        b=M3uSXHLcADIfIRCHVfeyV6Cv1Nn4nBUIyEgrDlLDBDnWflond7VOLUNhi/LRXZuHAF
         2j4INs3DTVy/7w9Mv7JGbPfNZJrE+XOxTkiku6duqHF+ExSqda/RWv788XlkI2y2N/O5
         ECJH1rXJ1J3sKUZt8t6cu8mqGNLVexdqtC/U7C/qpo/Vh//jVJ451XC8/iZnru6zd82v
         KVfLHA5kWEsxVwmX0ee2HHOlaIxGzLfLu7617PAqrfen0rWv3RMT/Kh8ieSyfbzvCZ5Q
         8/TKoGPAluldMzviJWCr+nuH9cs7VUgY0bwJaWw9RwwyPt3yJqc4LD08XbICBcYBvYVp
         Ia6Q==
X-Gm-Message-State: AOJu0Yzl5+nBGM4xY/FuUjXOy8xzNyZC9cEQ/4c7qScfhB+8D2W4An3p
	1/rnpqcznVkmc9Cc/zA3zsTR6vSvo+rqzXqypTO51wJXuPOWFYkpIyDWfig9s7jce3kCREzb7zG
	eLxIPnGx8
X-Received: from pfau7.prod.google.com ([2002:a05:6a00:aa87:b0:823:b9a:9230])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4308:b0:82a:650c:1630
 with SMTP id d2e1a72fcca58-82ce8c82398mr722891b3a.52.1774986097072; Tue, 31
 Mar 2026 12:41:37 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:26 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-8-jrhilke@google.com>
Subject: [PATCH v2 07/14] KVM: selftests: Add support for physical device MSI triggers
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-d' flag to vfio_pci_irq_test to trigger interrupts using the
physical device hardware instead of emulating them via eventfd writes.
This leverages the VFIO library's driver support to provide a more
realistic validation of the hardware-to-guest interrupt path.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 51 +++++++++++++++----
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 98dc1f4a7836..0435e8c75dd1 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -78,26 +78,54 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
 
-static int setup_msi(struct vfio_pci_device *device)
+static int setup_msi(struct vfio_pci_device *device, bool use_device_msi)
 {
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	struct dma_region *region;
+
+	if (use_device_msi) {
+		/* A driver is required to generate an MSI. */
+		TEST_REQUIRE(device->driver.ops);
+
+		/* Set up a DMA-able region for the driver to use. */
+		region = &device->driver.region;
+		region->iova = 0;
+		region->size = SZ_2M;
+		region->vaddr = kvm_mmap(region->size, prot, flags, -1);
+		TEST_ASSERT(region->vaddr != MAP_FAILED, "mmap() failed\n");
+		iommu_map(device->iommu, region);
+
+		vfio_pci_driver_init(device);
+
+		return device->driver.msi;
+	}
+
 	TEST_REQUIRE(device->msix_info.count > 0);
 	vfio_pci_msix_enable(device, 0, 1);
 	return 0;
 }
 
-static void send_msi(struct vfio_pci_device *device, int msi)
+static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int msi)
 {
-	vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
+	if (use_device_msi) {
+		TEST_ASSERT_EQ(msi, device->driver.msi);
+		vfio_pci_driver_send_msi(device);
+	} else {
+		vfio_pci_irq_trigger(device, VFIO_PCI_MSIX_IRQ_INDEX, msi);
+	}
 }
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-h] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-h] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
 	       "      throughout the test.\n");
 	printf("  -b: Block vCPUs (e.g. HLT) instead of spinning in guest-mode\n");
+	printf("  -d: Use the device to trigger the IRQ instead of emulating\n"
+	       "      it with an eventfd write.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -120,7 +148,7 @@ int main(int argc, char **argv)
 	u8 vector = 32 + rand() % (UINT8_MAX - 32);
 
 	/* Test configuration (overridable by command line flags). */
-	bool irq_affinity = false;
+	bool use_device_msi = false, irq_affinity = false;
 	int nr_irqs = 1000;
 	int nr_vcpus = 1;
 
@@ -138,7 +166,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abh")) != -1) {
+	while ((c = getopt(argc, argv, "abdh")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -146,6 +174,9 @@ int main(int argc, char **argv)
 		case 'b':
 			block = true;
 			break;
+		case 'd':
+			use_device_msi = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -157,7 +188,7 @@ int main(int argc, char **argv)
 
 	iommu = iommu_init(default_iommu_mode);
 	device = vfio_pci_device_init(device_bdf, iommu);
-	msi = setup_msi(device);
+	msi = setup_msi(device, use_device_msi);
 	irq = get_irq_number(device_bdf, msi);
 
 	irq_count = get_irq_count(irq);
@@ -165,7 +196,7 @@ int main(int argc, char **argv)
 	piw_count = get_irq_count_by_name("PIW:");
 
 	printf("%s %s MSI-X[%d] (IRQ-%d) %d times\n",
-               "Notifying the eventfd for",
+	       use_device_msi ? "Triggering" : "Notifying the eventfd for",
 	       device_bdf, msi, irq, nr_irqs);
 
 	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
@@ -213,7 +244,7 @@ int main(int argc, char **argv)
 				vcpu->id);
 		}
 
-		send_msi(device, msi);
+		send_msi(device, use_device_msi, msi);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
@@ -238,7 +269,7 @@ int main(int argc, char **argv)
 	for (i = 0; i < nr_vcpus; i++) {
 		if (block) {
 			kvm_route_msi(vm, gsi, vcpus[i], vector);
-			send_msi(device, msi);
+			send_msi(device, false, msi);
 		}
 
 		pthread_join(vcpu_threads[i], NULL);
-- 
2.53.0.1118.gaef5881109-goog

