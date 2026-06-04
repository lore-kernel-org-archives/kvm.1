Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDA305064
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538562; cv=none; b=qxzub+tdN0q5/qaIqxyGK35ADRs+329Hgzj5d9WfDN2myWYfoyN9F064fAufQd7MF/MLyccIOJFIW4lyEp6fNdwrY5rgBNg6FVPvYsBRBjeHM6HZvcJcUx7evBMypf4ZLvN09HqDj3kZQGuUFJSErUBPQDqGgpoliGtSd1fXS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538562; c=relaxed/simple;
	bh=dUckI3ACUlNVyG05qKIZGA7lEqMu1UN6inzd36IVR1s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BD6LHUeBfZeGvu5SBMladD4OJWgYPJunvvRmkkry1313eDao5vSvNsSioHtW/GM8r2LiVJeV/iw1hQ7s0zynRx9VTNH0MY7hWEH+lnU3Tzw7cyaxeVPdi1b/DaGFC8mObDlMNpmurOzFfDLVJ7ODJ9B2EHrZw6S9i6ACg7lOnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fUwio3O1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fUwio3O1"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c36f4b76so2327295ad.3
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538560; x=1781143360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBO3SD4MRwFGdf7qbVZzQxys78yaiEUcI+94zXfzD4=;
        b=fUwio3O1IcEO86R9TTkF0atiMhR7qq2BC/P8Im1uXSKeymAI73l2o7+PUOtUZiXb/h
         Xc2TKYG6Zk6J7JiK1XYQzXrs8BKEE2UfypyvKeOx8ZCRDzT+M6DlyqWn7TiSNHjYRuzf
         g+zmSJo0MVL1d2vlFUs8ldbKZA8Lnsl0jhDNEziuGjaBn/1nZlLAIAKmZCVHM2BRAaxd
         5tfGrC4X1mYjxmCEAoGs9Xi3LAVlv7dC+dpKdSZbwel8NpQt4TDeHUpz35Mh+Ka/gapA
         BzvpAyLKgaB6rtzzLELkf34NOwQMbLQ+umiyqfi9Z3xMXQagioUg+BtEZxkmZm0b6ptO
         q44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538560; x=1781143360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHBO3SD4MRwFGdf7qbVZzQxys78yaiEUcI+94zXfzD4=;
        b=ACwZjn3YK/AzvvKBFf2ckZWF1IhelW1vfs0R6sFQSKdCExHDqGxHMb0rR6Ph+ACNb2
         7vkdLLBsZBREBDEgRc9k3vpAW2oLYJsdPyD6PIKZEfxzBIyGM7NuhAWbyRjj/LhiPgZm
         jeyPW4p+2V82BPD3PZ/pXzr/MmKYZ3NyOXk8n3Ux8An8gYRgo4Kc7gWTT3wK03Ne0N2h
         qtkbSZYcxu3UCreFM4ipL0XvQWHDWJ2LggUNBrq04E6TAxMTgjoD1TfD4t8vl9TbIbDx
         N4W+PGO+oSExfPw9rQvDUO5+eFZLP00k321X3GUhjKFc/AnyN83s+eiAj9Ab/Ct+KDhc
         ctOw==
X-Gm-Message-State: AOJu0Yz86EsALZgy8n5bgMa5iIDwqI2lNDJ01LwN9WjbZ/tHTtmdmU9C
	ostJmNm+4J3xoXsLIMq1BDUWPxET6uDrpP4pNin+8l87OgUTHlQczfIy5KqE7kdS+tQ7Zu2N9Xb
	xPdoIfCWm
X-Received: from plav20.prod.google.com ([2002:a17:902:f0d4:b0:2bf:1a98:5111])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11d0:b0:2b2:5515:661c
 with SMTP id d9443c01a7336-2c1644add6emr69532855ad.31.1780538559512; Wed, 03
 Jun 2026 19:02:39 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:32 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-11-jrhilke@google.com>
Subject: [PATCH v5 10/21] KVM: selftests: Verify interrupts are received when
 IRQ affinity changes in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-a' flag to tools/testing/selftests/kvm/irq_test.c to randomly
affinitize the device's host IRQ to different physical CPUs throughout
the test. This stresses the kernel's ability to maintain correct
interrupt routing and delivery even as the underlying hardware IRQ
affinity is changed dynamically via /proc/irq/.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 41 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 5b42d8abd1ea..90cff165c351 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -11,11 +11,13 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <sys/eventfd.h>
+#include <sys/sysinfo.h>
 #include <libvfio.h>
 
 static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool irq_affinity;
 static bool done;
 
 #define GUEST_RECEIVED_IRQ(__vcpu)	\
@@ -109,9 +111,10 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-d <segment:bus:device.function>] [-h]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-h]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
+	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -139,13 +142,18 @@ int main(int argc, char **argv)
 	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
 	const char *device_bdf = NULL;
+	FILE *irq_affinity_fp = NULL;
 	int i, j, c, msix, eventfd;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	unsigned int irq;
+	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "d:h")) != -1) {
+	while ((c = getopt(argc, argv, "ad:h")) != -1) {
 		switch (c) {
+		case 'a':
+			irq_affinity = true;
+			break;
 		case 'd':
 			device_bdf = optarg;
 			break;
@@ -168,7 +176,11 @@ int main(int argc, char **argv)
 		eventfd = device->msi_eventfds[msix];
 		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
 		       irq);
+		if (irq_affinity)
+			irq_affinity_fp = open_proc_irq_smp_affinity_list(irq);
 	} else {
+		TEST_ASSERT(!irq_affinity,
+			    "Setting IRQ affinity (-a) requires a backing device (-d)");
 		eventfd = kvm_new_eventfd();
 	}
 
@@ -187,12 +199,23 @@ int main(int argc, char **argv)
 			continue;
 	}
 
+	/*
+	 * Suppress a false positive maybe-uninitialized compiler warning due
+	 * to conditional changes in IRQ affinity.
+	 */
+	irq_cpu = -1;
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity_fp) {
+			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
+			write_proc_irq_smp_affinity_list(irq_affinity_fp, irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++)
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
@@ -205,9 +228,18 @@ int main(int argc, char **argv)
 			if (GUEST_RECEIVED_IRQ(vcpu))
 				break;
 
-			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
+				printf("Timeout waiting for interrupt!\n");
+				printf("  vCPU: %d\n", vcpu->id);
+				if (irq_affinity_fp) {
+					printf("  irq_cpu: %d\n", irq_cpu);
+					print_proc_irq_smp_affinity(irq);
+					print_proc_irq_effective_affinity(irq);
+				}
+
 				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					  vcpu->id, gsi, vector);
+			}
 		}
 
 		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
@@ -218,6 +250,9 @@ int main(int argc, char **argv)
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_join(vcpu_threads[i], NULL);
 
+	if (irq_affinity_fp)
+		fclose(irq_affinity_fp);
+
 	printf("Test passed!\n");
 
 	return 0;
-- 
2.54.0.1032.g2f8565e1d1-goog

