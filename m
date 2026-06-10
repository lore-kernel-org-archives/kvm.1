Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE331A045
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052847; cv=none; b=OMbbNgqenmBUyXNHIFtnJZBn+HE+ZPqtqyqVhEkPjXwy5zx8UYAs12stF6WnPbt9kd5R81eh6YXG1K/JNKMIoy6x1ostH7UThoaFSpX+VJHomLR+SUZI4ms8Sr+g5RvJDAkQBVMid+npSXqRt1eLMxof8koC2aUQfxT/jl8l/yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052847; c=relaxed/simple;
	bh=M1SdOxQSqUB+H9HERaK00A5DaRRJ8hWJ3nSlC9W7AKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1evD5HxnzDW24fD1Js53AABxpT3GNuVZbL7cFpqGegPeLfPToyo/rWZU3+Uwf1NAGAEKZ1A3cbIbJGC44Gc1gTQgHtJYDwcwr+ICYe8dRjD4AUeNic++oZOS/WBYZkrN2rIlOHa8FCOX4du+P9Yn9lO12Tm96id1bOt8pevNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1PR2EG1; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1PR2EG1"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d979441eeso5292346a91.0
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052846; x=1781657646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6cKvUgF9aEo/LoEwdPMR+iUYk9h9pBrQbVTXEbhkSEo=;
        b=N1PR2EG1aMMFzhRnQcHEDimtyVztZArfX1CVYoPIYi62/xRICyRW1wYNxJ1ntrKNQU
         Xi3uqepYx3gxWK67AIFmSXsMBOJUvWhkffvV31EAqFLoGlh0OfDjssBY4rKcxsV26Olu
         BSfvyb8iNkmJHev/CTzwYqE8645wNcNECJwwCj2CyTCGWJM7KJLPGgj8DOg88n6b5HR2
         zjKbumMkbeWCe/FptmtumftnIFeookqJAASzW/zo0wwpVwM0UHa28I8BUPhT2nELyqGg
         O0kdzxoOLzhaTozCjPeTXnpsZzfqWbKgIB4rvKAQnqimdAJcjkllbBfBKPHIAjOuUOv7
         aAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052846; x=1781657646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6cKvUgF9aEo/LoEwdPMR+iUYk9h9pBrQbVTXEbhkSEo=;
        b=SlXDjP4OiMFjitH1371+1xb8XNrED9HQ69ElcmdMcDFzrUlTG7xFQAvXv1cqynAld+
         F38tUWqu390cVPbcaEFgpjs1htANJ0hA23ySWW8rUz1u7XLbpn9ruPQAtdO+614oMB7k
         4YoB6LYumIMspBa7S0fOjx0g/tbTO638hJUsakOmd5CaM+YRfMlzmlMT3ZSxsPAsTz1A
         3XJ/kI8Ai6tDijLHHVaCtBvFPoAci+tBe7Ye5hdVFtdfgcw0IKAkCo0PKpX6MgSdYNii
         chWZcEvVNj7ELCMNokhHt35pDdvBTiH6hmdj/o7AOgwuPDLpUpFot7HkpKEUf7SD5mLc
         Y+pw==
X-Forwarded-Encrypted: i=1; AFNElJ8ze126Kp+bKIHdw3EzSQf22SNE556gvVyeNKZANXE2ORz1aBhCj6te61R0rRRvjxqnLnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VlVIC0da6BJeBeBW1XJnP6mYeRI4nFok2M6SXNWTvKfz71+4
	Ps4J/9+vOyS3sZEnmuSkzH7LClrxEPovnn/FpZJrMoZ196ORFiJtOkheyv9jiFdoFFm+usgzINA
	LyGCSmA==
X-Received: from plbkx6.prod.google.com ([2002:a17:902:f946:b0:2bd:99a8:49c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540c:b0:36d:b680:3036
 with SMTP id 98e67ed59e1d1-370ee447882mr23877534a91.4.1781052845496; Tue, 09
 Jun 2026 17:54:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:37 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-18-seanjc@google.com>
Subject: [PATCH v6 17/18] KVM: selftests: Make number of vCPUs configurable in
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

Extend the eventfd IRQ test with a '-v' flag to allow the user to
configure the number of vCPUs to create and run (versus only ever using a
single vCPU).

Update the routing logic to play nice with 32 bit IDs, enable x2APIC format
in KVM (to enable 32-bit ID routing), and disable KVM's x2APIC broadcast
quirk so that targeting vCPU 255 doesn't blast the interrupt to all vCPUs
when in x2APIC mode.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index aeede7937147..7d64fd29ea8b 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -112,7 +112,8 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 		.entry = {
 			.gsi = gsi,
 			.type = KVM_IRQ_ROUTING_MSI,
-			.u.msi.address_lo = 0xFEE00000 | (vcpu->id << 12),
+			.u.msi.address_lo = 0xFEE00000 | (vcpu->id & GENMASK(7, 0)) << 12,
+			.u.msi.address_hi = vcpu->id & GENMASK(31, 8),
 			.u.msi.data = use_nmi ? NMI_VECTOR | (4 << 8) : vector,
 		},
 	};
@@ -145,7 +146,7 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type] [-v nr_vcpus]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
@@ -155,6 +156,7 @@ static void help(const char *name)
 	printf("-m	Pin target vCPU to random physical CPU before triggering interrupt\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
+	printf("-v	Number of vCPUS to run\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -191,7 +193,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ehi:mnt:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:mnt:v:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -214,6 +216,11 @@ int main(int argc, char **argv)
 		case 't':
 			iommu_type = optarg;
 			break;
+		case 'v':
+			nr_vcpus = atoi_positive("Number of vCPUS", optarg);
+			TEST_ASSERT(nr_vcpus <= KVM_MAX_VCPUS,
+				    "KVM selftests support at most %u vCPUs", KVM_MAX_VCPUS);
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -223,6 +230,9 @@ int main(int argc, char **argv)
 	TEST_REQUIRE(kvm_arch_has_default_irqchip());
 
 	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	vm_enable_cap(vm, KVM_CAP_X2APIC_API, KVM_X2APIC_API_USE_32BIT_IDS |
+					      KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK);
+
 	vm_install_exception_handler(vm, vector, guest_irq_handler);
 	vm_install_exception_handler(vm, NMI_VECTOR, guest_nmi_handler);
 
-- 
2.54.0.1099.g489fc7bff1-goog

