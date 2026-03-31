Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C53A0E84
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986107; cv=none; b=Y0wCr9Mn5fA//FrGHKE6efBkU/DBsEIWPDkSt2p0uDz+pCcvgmBXnjuxIyOsoOhTtPTEpJgtIwLp4rWVVJttE8hpuImIa87ioqImW0vjI14ewugWcTzHjQ+cKVzmpSUf7fx6ntxo5EAD93mIQjPv+Sq6BOU6VkcPReEMgRf8UI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986107; c=relaxed/simple;
	bh=DCfQ1RawfXXNSq/i8blcDdypkv8VKu1rmVN18BM4PEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SANUmN5Jhby23z8XKUB/FWieecbcL4rOD6jaSI2hSgENd7DlNjXYE+MYs1kwqD+KdKI7OOwGO8IH07YoHgLCKYJi8/bFgPbUyaSaDIs/m3Cpy528HCvYT7VTL1131NftTJz/myt5ASyYMm0+rdCXQu0Kes2ahiTwIoWtLWNoo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fz7TCDml; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fz7TCDml"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82cdaf0f934so1724177b3a.0
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986105; x=1775590905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxwG7aohChyIoN48UBiTJgA59bUyjMrHgMkkpsg7bHA=;
        b=Fz7TCDml+dNN2ttnyG0gca5nxLFg6uklNdMrNh2dId3H7wavhV6qGnPqPR5T/xN+8X
         JenEnSLrlgGZ9U99jRnUO1wQM1NPHcpRvS2IDjGGi0hHqXVTv9C0MoOktZI3/WWhztYk
         LZY//0CJKTQxByhbYx6ReuDMr5GcLQe8Ywj1bj2QvfAmg17AMBI+ri/mwNTMwpktyUCz
         U0DjFyc6Vh1E9nQAxSbejK4gDIvkQpkT/RF7th/GIPQVB26THp0Q82qnMo7Hd2IzFMW7
         0ufH3K1hVU5PwVAapIP7RgO4VOeXCBJada4sRyKsjCo8/43Ebfyi7mG8+dFil3A09NqM
         J26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986105; x=1775590905;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxwG7aohChyIoN48UBiTJgA59bUyjMrHgMkkpsg7bHA=;
        b=MHGMJz4jphuLXupqrSp7M/1mKTktVhzObI3lDmkwsMY57TBchzPsJ1/gU/AMW0z3A4
         dT6eTVGcAxR4cAy4P7PBLoKURkn1nNudB+a3d6IMpUYRYzcIuiB0avRK55Y5LBOadVh0
         P+rttoWeaMXbjCVx8qEfRHFeuJKxMiDqZI+aVaJYtnD1VrHsO6boV7ODgdjQNwzRqvSk
         cdpTw+DAuHgQnhtvoHGdv+Hpzrzqy0DsGcFPMSv3koGd7O7QDnLJzEN1n/Ot94vZ9Qbp
         7JH2Vkq28UPFJ1n1lQpIEoPy0K3jAdltfTR1GEcmlW8CYu5p8E1nPFI5QQrBWUThBcw/
         gCDw==
X-Gm-Message-State: AOJu0YzP0AYzlcuI1llUPa53jYGdH5qKEYxMERAuXm7KZwRUzsNdRMZ4
	AqZkqS7AoSkztWI6mYj8UZdDv2kMtGlCSaLK43dRDidePdFyJ4ZcarjfUvis9nRKR1zsblWvucv
	TJKpwlQhJ
X-Received: from pfjg13.prod.google.com ([2002:a05:6a00:b8d:b0:829:884e:b688])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:90a9:b0:829:af4a:5ebc
 with SMTP id d2e1a72fcca58-82ce88d4038mr786303b3a.7.1774986104583; Tue, 31
 Mar 2026 12:41:44 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:29 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-11-jrhilke@google.com>
Subject: [PATCH v2 10/14] KVM: selftests: Add support for NMI delivery
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-n' flag to vfio_pci_irq_test to route device interrupts
to be delivered as NMIs (Non-Maskable Interrupts) into the guest.
This expands test coverage to include KVM's NMI injection and
delivery logic for assigned devices.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 43 +++++++++++++++----
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index f02d455969bb..fa77ce348251 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -20,6 +20,8 @@ static bool block;
 
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool guest_received_nmi[KVM_MAX_VCPUS];
+
 #define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)
 
 static u32 guest_get_vcpu_id(void)
@@ -34,6 +36,11 @@ static void guest_irq_handler(struct ex_regs *regs)
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
@@ -71,7 +78,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 }
 
 static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
-			  u8 vector)
+			  u8 vector, bool do_nmi)
 {
 	u8 buf[sizeof(struct kvm_irq_routing) + sizeof(struct kvm_irq_routing_entry)] = {};
 	struct kvm_irq_routing *routes = (void *)&buf;
@@ -80,7 +87,7 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	routes->entries[0].gsi = gsi;
 	routes->entries[0].type = KVM_IRQ_ROUTING_MSI;
 	routes->entries[0].u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12);
-	routes->entries[0].u.msi.data = vector;
+	routes->entries[0].u.msi.data = do_nmi ? NMI_VECTOR | (4 << 8) : vector;
 
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, routes);
 }
@@ -125,7 +132,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -136,6 +143,8 @@ static void help(const char *name)
 	printf("  -e: Destroy and recreate KVM's GSI routing table in between\n"
 	       "      some interrupts.\n");
 	printf("  -i: The number of IRQs to generate during the test.\n");
+	printf("  -n: Route some of the device interrupts to be delivered as\n"
+	       "      an NMI into the guest.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -159,7 +168,7 @@ int main(int argc, char **argv)
 
 	/* Test configuration (overridable by command line flags). */
 	bool use_device_msi = false, irq_affinity = false;
-	bool empty = false;
+	bool empty = false, nmi = false;
 	int nr_irqs = 1000;
 	int nr_vcpus = 1;
 
@@ -177,7 +186,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdehi:")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:n")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -194,6 +203,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'n':
+			nmi = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -202,6 +214,7 @@ int main(int argc, char **argv)
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
+	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
 	iommu = iommu_init(default_iommu_mode);
 	device = vfio_pci_device_init(device_bdf, iommu);
@@ -243,13 +256,14 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nr_irqs; i++) {
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
+		const bool do_nmi = nmi && (i & BIT(2));
 		const bool do_empty = empty && (i & BIT(3));
 		struct timespec start;
 
 		if (do_empty)
 			kvm_clear_gsi_routes(vm);
 
-		kvm_route_msi(vm, gsi, vcpu, vector);
+		kvm_route_msi(vm, gsi, vcpu, vector, do_nmi);
 
 		if (irq_affinity && vcpu->id == 0) {
 			irq_cpu = rand() % get_nprocs();
@@ -263,18 +277,26 @@ int main(int argc, char **argv)
 				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
 				"IRQ flag for vCPU %d not clear prior to test",
 				vcpu->id);
+			TEST_ASSERT(
+				!READ_FROM_GUEST(vm, guest_received_nmi[vcpu->id]),
+				"NMI flag for vCPU %d not clear prior to test",
+				vcpu->id);
 		}
 
 		send_msi(device, use_device_msi, msi);
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		for (;;) {
-			if (READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
+			if (do_nmi && READ_FROM_GUEST(vm, guest_received_nmi[vcpu->id]))
+				break;
+
+			if (!do_nmi && READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]))
 				break;
 
 			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
+				printf("  do_nmi: %d\n", do_nmi);
 				printf("  do_empty: %d\n", do_empty);
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
@@ -283,14 +305,17 @@ int main(int argc, char **argv)
 			}
 		}
 
-		WRITE_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
+		if (do_nmi)
+			WRITE_TO_GUEST(vm, guest_received_nmi[vcpu->id], false);
+		else
+			WRITE_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
 
 	WRITE_TO_GUEST(vm, done, true);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		if (block) {
-			kvm_route_msi(vm, gsi, vcpus[i], vector);
+			kvm_route_msi(vm, gsi, vcpus[i], vector, false);
 			send_msi(device, false, msi);
 		}
 
-- 
2.53.0.1118.gaef5881109-goog

