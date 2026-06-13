Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D8D2DCF52
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310057; cv=none; b=K8o344TJ1FZFmbznlM1i+gQOReA0pxcuPa+aXMce3cFXEr1A9A0H6ps1oSziV6prX65t4jPI47IFj4pW6pEVpfawBIuE8tWGZjCcH3WKQYzTlo4W3qg3+z4hDE85wDaSpfHJjBCdbbEDepU5S0iZzs0wWO3V2Q8yGObSMe+virE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310057; c=relaxed/simple;
	bh=vqDfFoW01Vqj9t6sAi35oFdcuhR9Gu7vXgufWqoBPwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KC4y7iISzpv/sylPoGBJjan7PvYpNh25V0uu4QfIXYqJuKTLjFhM1ERfYfSGWwl1IJM3gblt5DJx9wh5VGM+3up2CHFJKTmTni12nnrNCDcjxhhszxaeP7Bh3v0cQBRp/vivpOVedZsyllipd1VzSODjRR81FeFwO7QWoV8b6Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vyKnwlOx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vyKnwlOx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8428384f31fso1184417b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310053; x=1781914853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H1eSMtwb9G7YtnadMLAB7K5SNJIa+tjm/mrc7JGQxkw=;
        b=vyKnwlOx004IcaBTkP6ippjPSEmadP0SLianLg87lgSF3NhMvlhSpBT4T4YDW1olfL
         0/WLVQxwqCq4RtftJwjBmzKGttd3OwPV3m90IuQK4kQZJ4wUCyrVHamrAq/sFOcB7nzk
         gLWuKaPfDK0v+BZgRcAL8osx3T1KcZJIU62z4/ejL+TJyFsz7AR/hQCStfucKvpga8C/
         wbT704pB1VH3J7WwZiMId7b1iqkcVvWHrOQWZVIS/jzHd8VYvjg0iW/qMjbKP4+M6sAd
         B4YdgI1LsnDK3fFGAFXqcspIb6Jr/HfQivlqOPVC2Tvn6Nz0YJ0gGRttCpWIYjbF95no
         yVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310053; x=1781914853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1eSMtwb9G7YtnadMLAB7K5SNJIa+tjm/mrc7JGQxkw=;
        b=Xy0trAfl/QJthL4ShsLASqodZyKz6PdByFodLMvrXEapjmvgZbI0nggzwfp0EIW8EH
         vTJciylvL/CSzTFIB6vMfNRubvBqHLnSYbQa7xdBMlHKFzhu5WVLgMNHCrbed7za/oT+
         exJbwuBqzCn6Hsm3dxX0QoXdKbxyVJU/VoMyYYXXlvo3zG+kbwdpGUSyTZjfXdSpuSgA
         VPrjYvLtmrea1g808tpf5KSkw74KEuxmUb7FRZMQcSpiXyBVysF707EFYiYjJFc97iNU
         LZ2DBXrP+y238BqRq50xooJgKfckdWMu4nxeUQReEvYPZ+x5lGa0aGWed73yz4+8E+2M
         EtAw==
X-Forwarded-Encrypted: i=1; AFNElJ9Q76W4UvwYE99cIk6y/ugdTJ2Bxg74f4n6MMcrbsg+KMxzDVorNHzmVmrOJ17TZOHMmdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7j6vVgGtTLEvJENudphspWxMR5EN0SsP8yPZQMcGn0w1xnxfF
	LSYqHd+OJ+SWwnlHdFa4/CilsSgTkf+9go6koiHP8IHeVUhC+2sOtgZAG4MGOMX4oiLa2EcZp+e
	e7xlo5Q==
X-Received: from pgar14.prod.google.com ([2002:a05:6a02:2e8e:b0:c82:2dd8:9d48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b12:b0:3a2:e0d3:37d2
 with SMTP id adf61e73a8af0-3b783fb31efmr5801901637.35.1781310053018; Fri, 12
 Jun 2026 17:20:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:25 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-15-seanjc@google.com>
Subject: [PATCH v7 14/20] KVM: selftests: Verify non-postable IRQ remapping in
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

Extend the eventfd IRQ test with an '-n' flag to route a subset of device
interrupts as NMIs (Non-Maskable Interrupts) into the guest using an
alternating pattern of 4 NMIs followed by 4 regular interrupts.

While this adds coverage for NMI injection, the primary goal is to
validate KVM's handling of non-postable interrupt delivery (AMD and Intel
IOMMUs only support posting fixed IRQs targeting a single vCPU).  KVM
has historically bungled handling transitions between posted and remapped
modes.  Use NMIs to stress the transitions, because they are a reliable,
architectural way to force these code paths.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: add GUEST_RECEIVED_INTERRUPT(), massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 48 ++++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 2cfb6c24e8d6..d2d861119854 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -17,11 +17,17 @@
 static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool guest_received_nmi[KVM_MAX_VCPUS];
 static bool irq_affinity;
 static bool done;
 
 #define GUEST_RECEIVED_IRQ(__vcpu)	\
 	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_irq[(__vcpu)->id])
+#define GUEST_RECEIVED_NMI(__vcpu)	\
+	SYNC_FROM_GUEST_AND_READ((__vcpu)->vm, guest_received_nmi[(__vcpu)->id])
+
+#define GUEST_RECEIVED_INTERRUPT(__vcpu, __nmi)	\
+	((__nmi) ? GUEST_RECEIVED_NMI(__vcpu) : GUEST_RECEIVED_IRQ(__vcpu))
 
 static u32 guest_get_vcpu_id(void)
 {
@@ -35,6 +41,11 @@ static void guest_irq_handler(struct ex_regs *regs)
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
@@ -91,7 +102,7 @@ static void trigger_interrupt(struct vfio_pci_device *device, int eventfd)
 
 
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
-			  u8 vector)
+			  u8 vector, bool use_nmi)
 {
 	struct {
 		struct kvm_irq_routing header;
@@ -102,7 +113,7 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 			.gsi = gsi,
 			.type = KVM_IRQ_ROUTING_MSI,
 			.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
-			.u.msi.data = vector,
+			.u.msi.data = use_nmi ? NMI_VECTOR | (4 << 8) : vector,
 		},
 	};
 
@@ -134,13 +145,14 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-n] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
 	printf("-e	Set empty GSI routing in-between some interrupts\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -171,11 +183,12 @@ int main(int argc, char **argv)
 	const char *device_bdf = NULL;
 	const char *iommu_type = NULL;
 	int i, j, c, msix, eventfd;
+	bool use_nmi = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ehi:t:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:nt:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -189,6 +202,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'n':
+			use_nmi = true;
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
@@ -202,6 +218,7 @@ int main(int argc, char **argv)
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	if (device_bdf) {
 		if (!iommu_type)
@@ -240,36 +257,45 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nr_irqs; i++) {
 		const bool do_set_empty_routing = set_empty_routing && (i & BIT(3));
+		const bool do_use_nmi = use_nmi && (i & BIT(2));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
 		if (do_set_empty_routing)
 			kvm_set_empty_gsi_routing(vm);
 
-		kvm_route_msi(vm, gsi, vcpu, vector);
+		kvm_route_msi(vm, gsi, vcpu, vector, do_use_nmi);
 
 		if (irq_affinity) {
 			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
 			proc_irq_set_smp_affinity(irq, irq_cpu);
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
-		while (!GUEST_RECEIVED_IRQ(vcpu) &&
+		while (!GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi) &&
 		       timespec_to_ns(timespec_elapsed(start)) <= timeout_ns)
 			cpu_relax();
 
-		TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpu),
-			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d (via CPU %d)\n",
-			    vcpu->id, vector, gsi, irq_cpu);
+		TEST_ASSERT(GUEST_RECEIVED_INTERRUPT(vcpu, do_use_nmi),
+			    "vCPU %d timed out waiting for %s (vector 0x%x) from GSI %d (via CPU %d)\n",
+			    vcpu->id, do_use_nmi ? "NMI" : "IRQ",
+			    do_use_nmi ? NMI_VECTOR : vector, gsi, irq_cpu);
 
-		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+		if (do_use_nmi)
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_nmi[vcpu->id], false);
+		else
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
 
 	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
-- 
2.54.0.1136.gdb2ca164c4-goog

