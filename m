Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502C93CC327
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509759; cv=none; b=TqoigFZ+2+po8TOn9IiWmt616xZn8Qp4LtLRn9aU2W0KbLZztlqDZE7jZs7XjM6Qd4xDOlWhyH5oEHl8o38yKM5qYabwGLfhkajvSbCibPKovFvdci2XLY5JNKj64VAYz1N0wxVKevWDY0G3TASVdKr9qmerdT4yDn8zMBlYzTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509759; c=relaxed/simple;
	bh=vmmsAiUlRWxl7xDEQ2+LvViLrzxIQ0OL/Z3FhERGXXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jF0yvU2QglMVGtPoG/w0RWr8pQoY/s06hWdzHQiMHyrycgPytmd29ilK0ZQFaRQPgmBs0l5EHO8oko7fpTK+cuQISyNWhr6x8Tl64qYdPf87zhwrqy6JQ+dakyRIz4KipzmhI3afRtBbrajOfXA9SqJJxgeQAez1IsNj1+wvm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBAq9WiK; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBAq9WiK"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37cc07f3e36so1588894a91.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509753; x=1783114553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LnOwvJzchK4FfYVRhLUd9M/CfdcZF8IWyQ377aEQXH0=;
        b=MBAq9WiKWhvlrcrjUDVq1gQN1pN11Ibj8tlcI4m9xbgyFn0GHnwkTJt6H7VsDL8/fk
         ufwYH8HSHIiTb76p9mzxIN2kYfmgr8CZhj57IESvlDnuX1VX4wNZGbmb1QbDxAO/jPQf
         ZX6xqWaDZULFTXSI5J4aopAIPILm1Y+xqX0a3Q6njZRPTFvPnSh7z4A7CGIlEbvueLpa
         LmDedAiV2dnLpIx58urkGbDTSDkW5yq9nllzh4HdzxIkNG57cGIOZEehWfI558e0vFQL
         SIBfkheOsbpdRvbTXoxm53DPLalosCuB+mzDEv6UV5H0jDzkKpGXut3YHFADqxN6NgEc
         hK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509753; x=1783114553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnOwvJzchK4FfYVRhLUd9M/CfdcZF8IWyQ377aEQXH0=;
        b=cMAyCwAusHRaGFA/j0kqQnQxf2/mLyhcmQWALLtEtq1MsY/VghDj0SElH2piyCEgDt
         jUa1hVfHuly7arOV1KHAx7JYKWR2zeunVpfvrHsB3tALBVaXrh5mTkKFO0wQguHo0iW5
         rF/1qOORXAtESAuPsjpkWoQXTaKCqtzNazwMZf0BPYumAs6jGtUov0e0+2K9HADxsmUa
         q/p+IT958nUYV1uKS6hILHqQ3MgJcoIzOQxG16oNu/C14C9NX2yejUOa+nDbYBTfqyOq
         uSfmz0tGov71vexxSDAkZUXP5dVapcmCrRjhEYuIOPuA0tY6wYddzqQaSZBhU7DUEWrj
         gooQ==
X-Forwarded-Encrypted: i=1; AHgh+RocvaI/HKn1ZGeWk8op/8XenND6gRaDLHo93qUA31QDW5WDCy4Ra6+4GvMzdMqNEgMV6Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTe8PiQjGfjtM7HWgJmmV8cE6rvKNzuUKWolHdRgcGq0DdK3D
	aDPnCpv+gTwYrq1/vc5MTnl1TG9BM7hlW0eglGE8QTGmwWY1unAD2v/cfzZfRNKHMnhVlXAZO8X
	gtr5CVw==
X-Received: from pgge9.prod.google.com ([2002:a63:db09:0:b0:c85:62f4:f188])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28cc:b0:37e:a09:2432
 with SMTP id 98e67ed59e1d1-37e0a0936b9mr5335064a91.4.1782509753021; Fri, 26
 Jun 2026 14:35:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:27 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-15-seanjc@google.com>
Subject: [PATCH v8 14/20] KVM: selftests: Verify non-postable IRQ remapping in
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
index bb20bb81e930..48520c6dea69 100644
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
@@ -103,7 +114,7 @@ static void trigger_interrupt(struct vfio_pci_device *device, int eventfd)
 
 
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
-			  u8 vector)
+			  u8 vector, bool use_nmi)
 {
 	struct {
 		struct kvm_irq_routing header;
@@ -114,7 +125,7 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 			.gsi = gsi,
 			.type = KVM_IRQ_ROUTING_MSI,
 			.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
-			.u.msi.data = vector,
+			.u.msi.data = use_nmi ? NMI_VECTOR | (4 << 8) : vector,
 		},
 	};
 
@@ -146,13 +157,14 @@ static const char *probe_iommu_type(void)
 
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
@@ -183,11 +195,12 @@ int main(int argc, char **argv)
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
@@ -201,6 +214,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'n':
+			use_nmi = true;
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
@@ -214,6 +230,7 @@ int main(int argc, char **argv)
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	if (device_bdf) {
 		if (!iommu_type)
@@ -251,36 +268,45 @@ int main(int argc, char **argv)
 
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
2.55.0.rc0.799.gd6f94ed593-goog

