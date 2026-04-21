Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B33AC0E9
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813412; cv=none; b=rCre0Y6UGe9/1DDIa/pmpIJukfNfTsZhir50+z1ftRsGRj0acg/VYLsHl+xPV2rFivBPv6WuVmozuIaVAIqoHlCPeOJNwo6OzWyolfDl8g7jDDYmHpJ56x2nT4xk73mfislOdfGcb52vFaGMn213beMpkHSNTPUNIogPgqA437Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813412; c=relaxed/simple;
	bh=tLPEzwopX6dton3/Ha6grXVi3X09hu5wNYrlOXU/WTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fyo7ab/b1Bmks52ZPcdWh3VSOSu1t6Atjd7hn+djHTs212+lmIWOTZYQt8aJgDLLDKN+8MlExxbOv2gUe3DVtzS/vMpRCK1/wDoUR570NxvltiMoZDAqb6KaEr9vU+bsYpHMgdj/dqwSpPiQTAr7TeHx2Z01MgmwKuRXJcXP+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6V5dsa8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6V5dsa8"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b24611696eso33255955ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813410; x=1777418210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpu7DXILjAa0mygdthMzFuQN1CB0JLFZNOmeTcbZBKk=;
        b=B6V5dsa8zgPnd0hDePGKbDc+haRIEMznX/8HZYbvFZyNNywBhfxfMx8eVXEqtiXeKw
         rodiBVeOUPDsU1HVhjGEeVKS34ApbvrFkGbuxFhn+rQy5jG7xwcMbpNlDW3tlmvTlEq2
         E3pdCMPPpPx8RLGS5fWbem1mCqUxuC5KwCtn3f9ncGP3tJiw9exQzd323gRxNhCwqCyj
         TbyJXqyQUJ2c59NLYSZqBlf5c6Xci8dacU0sqIdnI81arsrJC8QH2OD7wEc+Ro2hf3+v
         oFBesDZfsBTw1xXWSWxN5cmJ4S/FssGeivxET5MN3Iew3VdyuUdyS44BrMnByPIsAuOj
         ByXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813410; x=1777418210;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gpu7DXILjAa0mygdthMzFuQN1CB0JLFZNOmeTcbZBKk=;
        b=na9BHduYNgHjzQUJbgaF2C4pUV/np4Hr8EzpMdzSJNn/RfcaTECzpkPI+Ir4Y0Hl9y
         bqVl2pfT0K7dLVrHtdOlHjOJifNJrVxlblnYkZ7zaeULSaycj/YLGw6kdKq+zntmS5XK
         GGxTFshXMzOPuh2J7qkWUu7oyT/ENFJn57yl3h5GkcJUA9Mystru6fgO5X8QiwfmS+h+
         5NjZTzCGF+63zC8yDGF6Qo3792hlICyCZ4rLakBfXDlWmRUeJAIT7QLSHXfVGsaLSa1c
         S4NbtX/RZJ89ouHxC2bBCUS6tHpE9pM1PPUt7Per0xcovmzVP2qr+Q4MRQOe2eNRCxkS
         1O/g==
X-Gm-Message-State: AOJu0YwovsQBHpNVBFd71/sAzzcLHW2hOdtsk6M9PhQxGBpZxjy6C4wU
	nm6I64RC3EKLzqNYlnoFO74AcKv0+f41U6OuvpgAFQhFDlZj4d54eL4Dr32Ykpigbqs1gVgiBPG
	F5m/D2DCH
X-Received: from plrb10.prod.google.com ([2002:a17:902:a9ca:b0:2b2:50b1:329c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:74c2:b0:2b0:6d33:e7c0
 with SMTP id d9443c01a7336-2b5f9ecaea6mr160285015ad.1.1776813410270; Tue, 21
 Apr 2026 16:16:50 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:53 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-13-jrhilke@google.com>
Subject: [PATCH v3 12/16] KVM: selftests: Verify non-postable IRQ remapping
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Matlack <dmatlack@google.com>

Add the -n flag to tools/testing/selftests/kvm/irq_test.c to route a
portion of device interrupts as NMIs (Non-Maskable Interrupts) into the
guest using an alternating pattern of 4 NMIs followed by 4 regular
interrupts.

While this adds coverage for NMI injection, the primary goal is to
validate KVM's handling of non-postable interrupt delivery=E2=80=94specific=
ally
the transitions between posted and remapped modes.  NMIs are used for
this purpose because they are a reliable, architectural way to force
these code paths.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 44 ++++++++++++++++++++------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftes=
ts/kvm/irq_test.c
index 9efb7e655623..03b88b7585b3 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -17,6 +17,7 @@
 static u64 timeout_ns =3D 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool guest_received_nmi[KVM_MAX_VCPUS];
 static bool irq_affinity;
 static bool block_vcpus;
 static bool done;
@@ -33,6 +34,11 @@ static void guest_irq_handler(struct ex_regs *regs)
 	x2apic_write_reg(APIC_EOI, 0);
 }
=20
+static void guest_nmi_handler(struct ex_regs *regs)
+{
+	WRITE_ONCE(guest_received_nmi[guest_get_vcpu_id()], true);
+}
+
 static void guest_code(void)
 {
 	x2apic_enable();
@@ -93,7 +99,7 @@ static void trigger_interrupt(struct vfio_pci_device *dev=
ice, int eventfd)
=20
=20
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcp=
u,
-			  u8 vector)
+			  u8 vector, bool use_nmi)
 {
 	struct {
 		struct kvm_irq_routing head;
@@ -106,7 +112,7 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, s=
truct kvm_vcpu *vcpu,
 	routes->entries[0].gsi =3D gsi;
 	routes->entries[0].type =3D KVM_IRQ_ROUTING_MSI;
 	routes->entries[0].u.msi.address_lo =3D 0xFEE00000 | (vcpu->id << 12);
-	routes->entries[0].u.msi.data =3D vector;
+	routes->entries[0].u.msi.data =3D use_nmi ? NMI_VECTOR | (4 << 8) : vecto=
r;
=20
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
@@ -120,7 +126,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
=20
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] =
[-i nr_irqs]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] =
[-i nr_irqs] [-n]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physica=
l CPUs throughout the test\n");
@@ -128,6 +134,7 @@ static void help(const char *name)
 	printf("-c	Destroy and recreate KVM's GSI routing table in between some i=
nterrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an=
 emulated eventfd\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -149,6 +156,7 @@ int main(int argc, char **argv)
 	u32 gsi =3D kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1)=
;
 	u8 vector =3D kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
=20
+	bool clear_routes =3D false, use_nmi =3D false;
 	int i, j, c, msi, irq, eventfd, irq_cpu;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
@@ -156,11 +164,10 @@ int main(int argc, char **argv)
 	int nr_irqs =3D 1000, nr_vcpus =3D 1;
 	const char *device_bdf =3D NULL;
 	FILE *irq_affinity_fp =3D NULL;
-	bool clear_routes =3D false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
=20
-	while ((c =3D getopt(argc, argv, "abcd:hi:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "abcd:hi:n")) !=3D -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity =3D true;
@@ -177,6 +184,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs =3D atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'n':
+			use_nmi =3D true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -187,6 +197,7 @@ int main(int argc, char **argv)
=20
 	vm =3D vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
=20
 	if (device_bdf) {
 		iommu =3D iommu_init(default_iommu_mode);
@@ -224,35 +235,45 @@ int main(int argc, char **argv)
=20
 	for (i =3D 0; i < nr_irqs; i++) {
 		const bool do_clear_routes =3D clear_routes && (i & BIT(3));
+		const bool do_use_nmi =3D use_nmi && (i & BIT(2));
 		struct kvm_vcpu *vcpu =3D vcpus[i % nr_vcpus];
 		struct timespec start;
=20
 		if (do_clear_routes)
 			kvm_clear_gsi_routes(vm);
=20
-		kvm_route_msi(vm, gsi, vcpu, vector);
+		kvm_route_msi(vm, gsi, vcpu, vector, do_use_nmi);
=20
 		if (irq_affinity && vcpu->id =3D=3D 0) {
 			irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs();
 			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
 		}
=20
-		for (j =3D 0; j < nr_vcpus; j++)
+		for (j =3D 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(
 				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),
 				"IRQ flag for vCPU %d not clear prior to test",
 				vcpus[j]->id);
+			TEST_ASSERT(
+				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_nmi[vcpus[j]->id]),
+				"NMI flag for vCPU %d not clear prior to test",
+				vcpus[j]->id);
+		}
=20
 		trigger_interrupt(device, eventfd);
=20
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-			if (SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpu->id]))
+			if (!do_use_nmi && SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpu=
->id]))
+				break;
+
+			if (do_use_nmi && SYNC_FROM_GUEST_AND_READ(vm, guest_received_nmi[vcpu-=
>id]))
 				break;
=20
 			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
+				printf("  is interrupt NMI: %s\n", do_use_nmi ? "true" : "false");
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
=20
@@ -261,7 +282,10 @@ int main(int argc, char **argv)
 			}
 		}
=20
-		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+		if (do_use_nmi)
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_nmi[vcpu->id], false);
+		else
+			WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
=20
 	WRITE_AND_SYNC_TO_GUEST(vm, done, true);
@@ -273,7 +297,7 @@ int main(int argc, char **argv)
 		 * below, will hang.
 		 */
 		if (block_vcpus) {
-			kvm_route_msi(vm, gsi, vcpus[i], vector);
+			kvm_route_msi(vm, gsi, vcpus[i], vector, false);
 			trigger_interrupt(device, eventfd);
 		}
=20
--=20
2.54.0.rc2.533.g4f5dca5207-goog

