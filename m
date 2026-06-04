Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6C3264C8
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538566; cv=none; b=LIl0rBbx/chweLs1zfbAG7/JvnnTIBJBoKc1rP2pvhy/DVqh6lgbzpD6iiOH+8hssruzuXHi+9IhOHCKF5q+2lZnSeS/fls8aJjduxyOpDCZdX2tabCA9Jvrqg6g4kU4AQ7H6n/CXoM/RzD8eXmE+4mzO1HkwED2Kq1KBOrfoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538566; c=relaxed/simple;
	bh=GV6lQKBYkSyvEQ8lXXe8QR9yQGxvUrb+6BI3SEWa5k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j0Egq6fJsdG/eAYtK6PPpZorhUEKLrakJKgqsVRu+bGcoRi68RF95ho5/GRVVbhMpOiSSK0w/cBh11QABopd+Ce7x+rE+1l8NdFEPm5fSno6d70lrG/vtDXcW1xf75ZC4YuhCJsdMu/GWgpGS7Qjwj2nL5pykvsr9kJ9dUhw2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pIHeE8wY; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pIHeE8wY"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso2274415ad.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538563; x=1781143363; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4R2VRn9iysSlwMbRgPpgRS4TGcGh9zwYnFc5Li/5R+o=;
        b=pIHeE8wYVJt6E06MtKbfCkYG1S0uDLw1a5EYqjeSK3nPJuPa6Ryu7oTYPWUK/MI5aj
         MyUpaQjvTHAA1d/dX6ANB8bld6yNQMYq7g5oZ7odnOZnfGo47+novXtllqYbc95aDQ2k
         LHiuavw/BTNvSHauL6C5Xi8hFVCePfRBnjVDOxnSPUOpn6tyXv38cUuarFfZuKhwMeSF
         +BmYw+KSHi2+CMNMJ+mjI2RAb0NB8G6aM6RoiUxDSF4dWESNkW0ZITV+NcMZV950lYVZ
         1eLvfqAciPEw8dhwfGGaV0A1mGPsmqfxQHijyYu6Wn0VTT5VjrMwtH4/J0g2IxjMmo+P
         wmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538563; x=1781143363;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4R2VRn9iysSlwMbRgPpgRS4TGcGh9zwYnFc5Li/5R+o=;
        b=RPNKBRaTaxOcfLzHRXKLQs8ltVqcXH+tacV3N+wCnRpOgBm0oMfZLyXQFlW2aBTSCx
         Oe+5Q5fozQzLsTUcFL2JbQUy4kH1+4SM7gRLZAcLFzjwFu4qxtE/Tpvk5W8ZBwLgqRh8
         zFF2YUvl0iOBeNygyGx0bvEVk0M6B2nbS1YAb8tRxsAd3BQgp1ZPenkLppQEAAZlEopc
         9TEGd7UFdUi1soe4tcO3mwVMjL+uhk1Qeh/vvhMg5bwlv2UvWTYPdy88Yjd4lXVBagh4
         r2fgYq+hMtQEoX0Gs0XzOPGLnIX/pKR1ZPIW8TGhDixPC3UKXuIRlaAra/zsaEBNIhuG
         CTqA==
X-Gm-Message-State: AOJu0Yw7a1oZCNqSqWMNL4tdmhw2paxITIWjO7Isv58qHa3S+8moq7PG
	LpKMUI/VplRHLj74QT9Xw27UjEMl33hkZeLkP5PxzeNVkiVMO9L7veVmsfMInmbwSiNGtIRLZXD
	U9Y/24b9K
X-Received: from plwg5.prod.google.com ([2002:a17:902:f745:b0:2bf:195a:2b9d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e851:b0:2c0:d99a:2fc
 with SMTP id d9443c01a7336-2c1639eddffmr61018075ad.2.1780538562923; Wed, 03
 Jun 2026 19:02:42 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:36 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-15-jrhilke@google.com>
Subject: [PATCH v5 14/21] KVM: selftests: Verify non-postable IRQ remapping in
 IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the -n flag to tools/testing/selftests/kvm/irq_test.c to route a
portion of device interrupts as NMIs (Non-Maskable Interrupts) into the
guest using an alternating pattern of 4 NMIs followed by 4 regular
interrupts.

While this adds coverage for NMI injection, the primary goal is to
validate KVM's handling of non-postable interrupt delivery.
Specifically, the transitions between posted and remapped modes.  NMIs
are used for this purpose because they are a reliable, architectural way
to force these code paths.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 44 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index de8c29baa2b0..ed48562318bf 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -17,12 +17,15 @@
 static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool guest_received_nmi[KVM_MAX_VCPUS];
 static bool irq_affinity;
 static bool block_vcpus;
 static bool done;
 
 #define GUEST_RECEIVED_IRQ(__vcpu)	\
 	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu)->id])
+#define GUEST_RECEIVED_NMI(__vcpu)	\
+	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_nmi[(__vcpu)->id])
 
 static u32 guest_get_vcpu_id(void)
 {
@@ -36,6 +39,11 @@ static void guest_irq_handler(struct ex_regs *regs)
 	x2apic_write_reg(APIC_EOI, 0);
 }
 
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(guest_received_nmi[guest_get_vcpu_id()], true);
+}
+
 static void guest_code(void)
 {
 	x2apic_enable();
@@ -96,7 +104,7 @@ static void trigger_interrupt(struct vfio_pci_device *device, int eventfd)
 
 
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
-			  u8 vector)
+			  u8 vector, bool use_nmi)
 {
 	struct {
 		struct kvm_irq_routing head;
@@ -109,7 +117,7 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	routes->entries[0].gsi = gsi;
 	routes->entries[0].type = KVM_IRQ_ROUTING_MSI;
 	routes->entries[0].u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12);
-	routes->entries[0].u.msi.data = vector;
+	routes->entries[0].u.msi.data = use_nmi ? NMI_VECTOR | (4 << 8) : vector;
 
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
@@ -123,7 +131,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-n]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -131,6 +139,7 @@ static void help(const char *name)
 	printf("-c	Destroy and recreate KVM's GSI routing table in between some interrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -160,12 +169,13 @@ int main(int argc, char **argv)
 	FILE *irq_affinity_fp = NULL;
 	int i, j, c, msix, eventfd;
 	bool clear_routes = false;
+	bool use_nmi = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abcd:hi:")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:n")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -182,6 +192,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'n':
+			use_nmi = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -192,6 +205,7 @@ int main(int argc, char **argv)
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	if (device_bdf) {
 		iommu = iommu_init(default_iommu_mode);
@@ -234,34 +248,43 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nr_irqs; i++) {
 		const bool do_clear_routes = clear_routes && (i & BIT(3));
+		const bool do_use_nmi = use_nmi && (i & BIT(2));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
 		if (do_clear_routes)
 			kvm_clear_gsi_routes(vm);
 
-		kvm_route_msi(vm, gsi, vcpu, vector);
+		kvm_route_msi(vm, gsi, vcpu, vector, do_use_nmi);
 
 		if (irq_affinity_fp) {
 			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
 			write_proc_irq_smp_affinity_list(irq_affinity_fp, irq, irq_cpu);
 		}
 
-		for (j = 0; j < nr_vcpus; j++)
+		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
 				    vcpus[j]->id);
+			TEST_ASSERT(!GUEST_RECEIVED_NMI(vcpus[j]),
+				    "NMI flag for vCPU %d not clear prior to test",
+				    vcpus[j]->id);
+		}
 
 		trigger_interrupt(device, eventfd);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-			if (GUEST_RECEIVED_IRQ(vcpu))
+			if (!do_use_nmi && GUEST_RECEIVED_IRQ(vcpu))
+				break;
+
+			if (do_use_nmi && GUEST_RECEIVED_NMI(vcpu))
 				break;
 
 			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
+				printf("  is interrupt NMI: %s\n", do_use_nmi ? "true" : "false");
 				if (irq_affinity_fp) {
 					printf("  irq_cpu: %d\n", irq_cpu);
 					print_proc_irq_smp_affinity(irq);
@@ -273,7 +296,10 @@ int main(int argc, char **argv)
 			}
 		}
 
-		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+		if (do_use_nmi)
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_nmi[vcpu->id], false);
+		else
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
 
 	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
@@ -285,7 +311,7 @@ int main(int argc, char **argv)
 		 * below, will hang.
 		 */
 		if (block_vcpus) {
-			kvm_route_msi(vm, gsi, vcpus[i], vector);
+			kvm_route_msi(vm, gsi, vcpus[i], vector, false);
 			trigger_interrupt(device, eventfd);
 		}
 
-- 
2.54.0.1032.g2f8565e1d1-goog

