Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6D301468
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100622; cv=none; b=UJexfyUayacXqInlEJKZPL86GkBeTBYAwerOxnK2f3y0/XMbx+8IelgmPbWy77u8Sj87lAwUIEOlTG0MfnFhe5Ra27dWNhxvxpYIEHltJJ5xhCV/aU3w5EMYbC8FBzykyno8dHRKwa2Qphjvd9ILMH+zxYVU3/ZrjNR9OdDZbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100622; c=relaxed/simple;
	bh=3yeVP6qjqV8GM2bvDNGyj/WO9RKz1xKmC/mcaxsDUX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDpd0lSRncYjyVPmpBH4pHmTISlGEuKKMCM3GFvofS4X+v0xPAGxQoUm2z6KUQPg3vOfKMX9qBymCXK1Qu51FKYmK8rJG9JtgTBfTqjsUmyNfoc0rUCj5YTC5cPSonLlbR1xAdb5mKJcOxIGqHP7PwBpWGRg29J/dODk1NhV2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtcmJBoD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtcmJBoD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so7042012a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100621; x=1780705421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dNSvW6+2aoUGl/zEwvlnmm46oR9NmJ5Z6dcbh7LJmwQ=;
        b=gtcmJBoDn1d70iLDrnkld6+5I8r6c/mbFyfNk6zLm69/truUfLheU4KJTy9kPqzuyz
         plEisHTduqxdRh9vNqs49WyvK/ilhY5tTNnNtmNVu7FFUvSB9OU9i0xWlm/Otn6PWGU1
         5gSqqdDW7a7aMEbcWxRG9dZW+COj6kD2SD2kJJtLB53LerWHodJo4e/jtaH75XMXxHBc
         RM703HvTBtxJ2KaFy4pEQ4ZA2SDBUrvTaKf9JM7uCRa/osyPIoOxOis4331buFj9Paex
         5+fhHWnVZa77zHwWwXpNuX33Q1VgSAUsWUq8zANKePpbS6EbC8N+32qa9VbMJt+j9Rxi
         tdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100621; x=1780705421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNSvW6+2aoUGl/zEwvlnmm46oR9NmJ5Z6dcbh7LJmwQ=;
        b=pjrmfGUdoQu4FqxpXElk2TaUshqQQImy1bn4WS5vB3NkXRf/ND9rvj6/UZncsxYcvN
         R3/hSeIQokCNxXX64Pa14j+NOgIT/zT9Ima3d3qVRlmBW4xtdH7kwxJtLW/DUdj/6i0r
         jXrsBlzwIjmyIlyuNRs1as8R8u1R+qYRS/KuM6hVC2e8JfklCsKFfvmTF5UXvRp8u6xv
         1wPzipifxuRP8CwRu4ekTieQngm0IYoLUBBQRmbKAIrhP/v/kLcPhUxAr+AqNgVATwWP
         tKceZ3E2WG0X2CHrw1gCuqVLmGnXQLqqFzjYv4p1juyGNzSU+Rjj3SNRtgE4Vs0DeWIJ
         on+w==
X-Gm-Message-State: AOJu0YwDtxUKpUSIqT3QZgxAhyeiGVnsZBl4P0Xq5AXV0NV4Zl/K8lBu
	ifCARx1lpTwXu2sa+DfT8Es8cJ50hRd8GWDaoSEn1iDq8BYmpeEhPRF/ae1T+NB6hnEdp5MBq1s
	dsQMxfQK/
X-Received: from pglc6.prod.google.com ([2002:a63:d06:0:b0:c82:7498:e3b5])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce4e:b0:3a2:d79c:416c
 with SMTP id adf61e73a8af0-3b427f97563mr1614544637.32.1780100620429; Fri, 29
 May 2026 17:23:40 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:34 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-20-jrhilke@google.com>
Subject: [PATCH v4 19/19] KVM: selftests: Add xAPIC support in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-x' flag to tools/testing/selftests/kvm/irq_test.c to configure
the guest to use xAPIC mode instead of the default x2APIC mode. This
expands test coverage to ensure that IRQ injection and routing work
correctly when the guest uses the older xAPIC interface.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 28 +++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 967083b8e2ff..29f54a435c8e 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -20,6 +20,7 @@ static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
 static pid_t vcpu_tids[KVM_MAX_VCPUS];
 static bool migrate_vcpus;
+static bool x2apic = true;
 static bool irq_affinity;
 static bool block_vcpus;
 static bool done;
@@ -31,14 +32,20 @@ static bool done;
 
 static u32 guest_get_vcpu_id(void)
 {
-	return x2apic_read_reg(APIC_ID);
+	if (x2apic)
+		return x2apic_read_reg(APIC_ID);
+	else
+		return xapic_read_reg(APIC_ID) >> 24;
 }
 
 static void guest_irq_handler(struct ex_regs *regs)
 {
 	WRITE_ONCE(guest_received_irq[guest_get_vcpu_id()], true);
 
-	x2apic_write_reg(APIC_EOI, 0);
+	if (x2apic)
+		x2apic_write_reg(APIC_EOI, 0);
+	else
+		xapic_write_reg(APIC_EOI, 0);
 }
 
 static void guest_nmi_handler(struct ex_regs *regs)
@@ -48,7 +55,10 @@ static void guest_nmi_handler(struct ex_regs *regs)
 
 static void guest_code(void)
 {
-	x2apic_enable();
+	if (x2apic)
+		x2apic_enable();
+	else
+		xapic_enable();
 
 	sti_nop();
 
@@ -144,7 +154,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n] [-v nr_vcpus] [-x]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -155,6 +165,7 @@ static void help(const char *name)
 	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-v	Number of vCPUS to run\n");
+	printf("-x	Use xAPIC mode instead of x2APIC mode in the guest\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -188,7 +199,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	cpu_set_t available_cpus;
 
-	while ((c = getopt(argc, argv, "abcd:hi:mnv:")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mnv:x")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -214,6 +225,9 @@ int main(int argc, char **argv)
 		case 'v':
 			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
 			break;
+		case 'x':
+			x2apic = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -226,6 +240,9 @@ int main(int argc, char **argv)
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
+	if (!x2apic)
+		virt_pg_map(vm, APIC_DEFAULT_GPA, APIC_DEFAULT_GPA);
+
 	if (device_bdf) {
 		iommu = iommu_init(default_iommu_mode);
 		device = vfio_pci_device_init(device_bdf, iommu);
@@ -248,6 +265,7 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	sync_global_to_guest(vm, x2apic);
 	sync_global_to_guest(vm, block_vcpus);
 
 	for (i = 0; i < nr_vcpus; i++)
-- 
2.54.0.929.g9b7fa37559-goog

