Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B621A2FD69A
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052846; cv=none; b=UDaPw6FbByK8yrvQ27mGMObJk7Z2g7I8qDVq77TBTEhxe8nmEJhMvoKXKxN3LkjLNOYkxH3T/O4DZ9YcMLNrbHW+C4kX53oFPJcRKhi5AgmzidLmT3je1tImbBdvLsdzKTWltpiGsEnkVOUuUOOetoxhwXsow94sqhSsam7nLTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052846; c=relaxed/simple;
	bh=qRiHP93HzItwv9bapY68Uc63LTzVWdeDkf8XAm1kmZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZM0tLmGXx3bouOn7pzIt/QftyjTCMyRjV7F31/Wkykh1g2k1WNIiKlZAaAvkuT1K3ItLIbFuV2cV2ixq1Scn9cKexM1TaaEBMI1K4RzsYgiqCqQUy2NCVH1e71VMXHOw6HH7iZd55NgNSOHjVbajqyexS+gjx9QpNTHigjF3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2uM3wph; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2uM3wph"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so5366405a91.3
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052844; x=1781657644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uzhOX8od6JHJiC3xs1cQBCBTU98nABZKFOR7TwpKopY=;
        b=t2uM3wphJ3i37wqEe73heb1D4QvXuUjPRbcozmYB7uATPjq5lkOd7+1cVw8P1Bv9KS
         A7jSKNpc7cx9j8K5/v1ozHuwvO5vfCufX8g5XLTaVyCvu3eK7WHBjSVU1DTM79oVa/YM
         bcEBNxQFeUhE+ci8BcimmLRX5p983NjZ9XcajfVck675Tams1orzY/qfoPC+UkdxMLUQ
         uiAbwyqv5GWdDvByBaLmSC9owF6utC535/8ZOlQHTEhzghctxuoiqj5csTgNKvuHtPW9
         diH12gZ/AMEVBgMzOv3PWXN+BCd5TUiAD9ee3IedbG0nixMD/AkZVnfMQyoh09xk9ld1
         AEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052844; x=1781657644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzhOX8od6JHJiC3xs1cQBCBTU98nABZKFOR7TwpKopY=;
        b=eW5D79fSH0ciU0+NeLrgxhsXrgb+g32F3RjULP08DC4lVj1CiPokfY9KXJTqg0QX4H
         SwtEN7SwHfLR3pKc+m6J7SC/g39BDSCUjHJkLwxj9vMxBiqn4R6+Inu5ypqD31rOhH2X
         sy06ujvdKwc/tW90Mu1VIiEf7PV+kyTwp/YZdNg56sI9a7ixKSkrhVSOQM3WUISNM0gY
         KcWMJGFo6ZJrJcsViI9npxnKKIRPUf9D1FIjP0eRPVLgssacpioDW9GpQ4vzH6M4sfF0
         W9g4GYGZVJJQ8YB6Z9BtxW6nVgBHLRXbGfQndE8SGFOk9/cGRfu+rIw83W5y+Fhj4kFM
         sGIw==
X-Forwarded-Encrypted: i=1; AFNElJ/0PFZ5oDk+RmNd9zynarrwNvaxNicnY8ccUYcBKjMHPhAp+2pQQcIxvG164MD/3UHonAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMaBmBl+ouluoTPQCgY6g2cJlmu3F21eWTHY2SA9yzJLQ4ksX
	Z9aIpSQXZG0VvdAzU9/g/Sdx6RkbbXhbrodadckcv+5TdRmHK0uhhehkVH9/2b4jDHAqM9y9ZPW
	BJAwwTQ==
X-Received: from pfbha13.prod.google.com ([2002:a05:6a00:850d:b0:83f:24a9:a829])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b04:b0:36a:5d1f:7b6
 with SMTP id 98e67ed59e1d1-370ee5444e7mr23400292a91.2.1781052843860; Tue, 09
 Jun 2026 17:54:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:36 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-17-seanjc@google.com>
Subject: [PATCH v6 16/18] KVM: selftests: Verify vCPU migration during IRQ
 delivery in IRQ test
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

Extend the eventfd IRQ test with a '-m' flag to have the test migrate the
target vCPU to a random physical CPU before triggering its interrupt, e.g.
to validate KVM's ability to update device posted IRQ routing.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: pin one vCPU at a time to simplify things, use main()'s affinity]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 3fed76c553dd..aeede7937147 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -145,13 +145,14 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-n] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-e] [-h] [-i nr_irqs] [-m] [-n] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
 	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
 	printf("-e	Set empty GSI routing in-between some interrupts\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-m	Pin target vCPU to random physical CPU before triggering interrupt\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
@@ -183,12 +184,14 @@ int main(int argc, char **argv)
 	const char *device_bdf = NULL;
 	const char *iommu_type = NULL;
 	int i, j, c, msix, eventfd;
+	bool migrate_vcpus = false;
+	cpu_set_t available_cpus;
 	bool use_nmi = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "ad:ehi:nt:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ehi:mnt:")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -202,6 +205,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'm':
+			migrate_vcpus = true;
+			break;
 		case 'n':
 			use_nmi = true;
 			break;
@@ -244,6 +250,9 @@ int main(int argc, char **argv)
 
 	kvm_assign_irqfd(vm, gsi, eventfd);
 
+	if (migrate_vcpus)
+		kvm_sched_getaffinity(0, sizeof(available_cpus), &available_cpus);
+
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
 
@@ -270,6 +279,9 @@ int main(int argc, char **argv)
 			proc_irq_set_smp_affinity(irq, irq_cpu);
 		}
 
+		if (migrate_vcpus)
+			pin_task_to_random_cpu(vcpu_threads[i % nr_vcpus], &available_cpus);
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
-- 
2.54.0.1099.g489fc7bff1-goog

