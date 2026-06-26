Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2C3C1F31
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509753; cv=none; b=rbcSa7e0WEWww+oVBpLRq7GFKSvxiMoM/bPz5jJ2O8iehRicsQ4fZ7yNj+cOAAU8afyHZUr6zPKUATzSufJfrapGwDFijAOCY/iSpTl9WAXVuj5ptx+1bewRaMPFqguI1uJ+++w2IfdZ1mgDiYsgQtqbWr6fElHKRxXoaXwppvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509753; c=relaxed/simple;
	bh=ZbaRyKJ5+N5Q+0DLeDMTRepe35qClN0OPdAISbfzeZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OxJN4D5H6iUsS5BVT7IlsdL6zyEEy7E/9+1NdAM44ALYVY5BwMpkqW4gENj0kRmeqfGQssNG2vHxYB6kMNJbHZqiNW7oIxS8bjV1QVd4dicupF0fJ7CMy619a6Jv+3jM+RLtpL+IoTZKk+HJHHe+VFh8j8oDisOEK8eNHvt3WVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B1tOtHA/; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B1tOtHA/"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9a700dc0eso760925ad.1
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509751; x=1783114551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BfGxV+xN5MQJzo1OxAcNftwHJizNMsItpsF+xT3GCNY=;
        b=B1tOtHA/8UWgi74eQemWL7XK3FXNzMJUPQ3UlMnzCVgIQX9yBvmQlntGUvhaSDl0SL
         y56mzsTBbKt/2J6+E+oGfyzn2KesbMLT5yw9ErhstU60mtppuvKjuGyD6m/jHbKd6VyJ
         5zXLOyLYwsjNqffEHnRugEY6xuZOy/92+Yhekr9T0B3FS89XQVDSh9Z4YKipQfBwDPzO
         Ng54L8oJKfL8q3FIc7rMi8tDAKPnwADdALn+rj2WkqxgMJVdTocfwuWwydjQXve9cNbp
         jNSWyp472PS9IA0eVLQsZ/4Qon6qqpA0qrviq4yIHTOM8plHqyWnCPA26tTxsl9PCZ27
         yz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509751; x=1783114551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfGxV+xN5MQJzo1OxAcNftwHJizNMsItpsF+xT3GCNY=;
        b=g8RZ2CEqDjKrXzbnweD0fIF27adn9J9RrzOFZT13achnjf0SpZKYZNuMocAcAawC4q
         HFxBgeOphm2aEQzivTGsmffSrlfD3i0HbudLHjc85woqmyMKuHTsBX48brM6p90g2bxi
         Kc/dwApX4S18GELiOo3EC4sy5TmgqMcJ7mgVdUoN2gRKkEBebNvqKJmEYXLu11/tIecM
         OHLajGjQKtgHS9IK1nCqZLztauPmmSMTqgwY8Yy8d1QJA7DbKyeOrx2RZmEDszF8+Xel
         hO3Y0yAnQm7nf9kK6FEhMfANdfTQ/OOrGGCOUfG0ORtycTdR7OP1TZHUiu13Hn/vr0nH
         6mjw==
X-Forwarded-Encrypted: i=1; AHgh+RpiAHAX0gmaAd9KaxiSKlC5e9IFeZF0w6C7HU8b/llR+Hv8GBWrhlGq7J+NaHoq9+zi0Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAl8Bn6r7cpP2I5q0l6IMGcmoOucQCeJojdyMCL+qK6mTlNdQo
	vRF4XnQdFZkzSG2pm4eIX8vVR93FMSmymzl1DmtvajbxLNTnIxDJvtXOlQjPpTHxqzSmErI+r5/
	KgesRSQ==
X-Received: from plbmj7.prod.google.com ([2002:a17:903:2b87:b0:2c7:f558:fbb4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f786:b0:2c0:bb2d:a30b
 with SMTP id d9443c01a7336-2c7fc754bebmr76656145ad.32.1782509750610; Fri, 26
 Jun 2026 14:35:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:25 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-13-seanjc@google.com>
Subject: [PATCH v8 12/20] KVM: selftests: Add option to set empty routing
 between IRQs in eventfd IRQ test
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

Extend the eventfd IRQ test with an '-e' flag to set empty GSI routing
between interrupts.  Clobbering the GSI routing table verifies that KVM
correctly handles CPUx => NULL => CPUy transitions, not just CPUx => CPUy
transitions, and verifies that KVM can "rebuild" an entire routing setup.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: '-e' for "empty" instead of '-c' for "clear", massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index fd386e3e9ac3..fd03ec940362 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -121,6 +121,13 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing.header);
 }
 
+static void kvm_set_empty_gsi_routing(struct kvm_vm *vm)
+{
+	struct kvm_irq_routing routing = {};
+
+	vm_ioctl(vm, KVM_SET_GSI_ROUTING, &routing);
+}
+
 static const char *probe_iommu_type(void)
 {
 	int io_fd;
@@ -139,11 +146,12 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-h] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
+	printf("-e	Set empty GSI routing in-between some interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -170,6 +178,7 @@ int main(int argc, char **argv)
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
+	bool set_empty_routing = false;
 	const char *device_bdf = NULL;
 	const char *iommu_type = NULL;
 	int i, j, c, msix, eventfd;
@@ -177,7 +186,7 @@ int main(int argc, char **argv)
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:eht:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -185,6 +194,9 @@ int main(int argc, char **argv)
 		case 'd':
 			device_bdf = optarg;
 			break;
+		case 'e':
+			set_empty_routing = true;
+			break;
 		case 't':
 			iommu_type = optarg;
 			break;
@@ -234,9 +246,13 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < nr_irqs; i++) {
+		const bool do_set_empty_routing = set_empty_routing && (i & BIT(3));
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
+		if (do_set_empty_routing)
+			kvm_set_empty_gsi_routing(vm);
+
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
 		if (irq_affinity) {
-- 
2.55.0.rc0.799.gd6f94ed593-goog

