Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A53C1970
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509752; cv=none; b=jfZg+YzsdWsh6oWNnS38PDNoPMkgb05zaUo8lGHoldxJPKQ3Xj+lHSqQmMSK41PYz6t9SmF/g8jfffGRYlOBz+RQF5meGhQqS4VYCi+ExeudgFVOMOSewFGsAUeKmtK5M2NyMBGHQaFUHV8U3te78bQ2FW39clSpg1qgZwk8OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509752; c=relaxed/simple;
	bh=i3GvfveA7+GiUeZ1BzHLxcrilZtxu8MQFiGottmgjpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sg7+mGHbmxz8+v+Hp6wtAPXWvPvxvjThxnRg0U5cLS6/HTwVoXhp7/XKohpn9uPP8JCU/9KkLer+agcvEbZIuGwLOZdTuBveEfrjKqmnZNvnft2KEIJkcDL+DrjNNQHKWCByG783hKug9aL2QpwSjnUvdaRbukzrVb495eiv2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nd4h2ZRg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nd4h2ZRg"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c80f89b64bso18558615ad.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782509750; x=1783114550; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jjdh/fhaNd2JbtrBCobPcqX80InnjRHE8TkDXBPMD4=;
        b=Nd4h2ZRgRaj6OhC/juaOFYI6R/04AWKStYaf2I6eGnVsvRmKBmDlzI8IfstYiHE3oh
         qS9P596r+zBh3YikEIotaUeQinDuODZUqlzTEf2xCWJLSe/LCPJ09DXndiPkeKyHlDXi
         Sx0P72FwsePpBiF5ygSgJJexiciY1hu41hhxKvcj9fayRIRJvzO7ZSKIEYE6SFq4KfbT
         1tfEEHqEjyMjl7zsE+dROe7nIFzYqIAJ7PAVgCUsn1mFcnN+7OS70dF785FoWpO1wXtu
         //R/hEiZgvNmyDHhLDkrqplkK38YiL1qse7HL1FMePSGAvpV6fcN2HP39FNznooEN/0H
         upEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509750; x=1783114550;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Jjdh/fhaNd2JbtrBCobPcqX80InnjRHE8TkDXBPMD4=;
        b=gn4nRTdVHB9Yj4DuzNVKxBL6j2fHOO64CMe+RTD7E2v2uyrgfU5uEjnRV9nhpyRaGL
         DCqR4xvpNqzEAcb8SteDzZjprn7FaAIeczHvumGNFqybCLFqNTCUVATnOWFC3H6z3sRI
         QUpC7bFbWtD9TSbET6zaSUc9eqnMh3ssBU75HXj/jr9gZOLJ5o8edldocXseHcosqxjD
         /zY51w8J3eKALvk2nNFPKzqB+cPL+Hd410up5fjQykpQABKHUXgqhlTsbQPn26hgdQra
         JZ2QjZZ0atMcYlsBynWz7LSgWCp49MH4LgX390XEZ0VZ3T+vgFxPkZ3GG9HPUz27V7BF
         hBKg==
X-Forwarded-Encrypted: i=1; AHgh+RoUs2+fHKnjSuUydv22yNJ9DPrVgzghdbJJ6g3p2svY+vQCNd81K6bTK4RkCzuqwGT8aWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BtvFiuPekBB6N48dpkW6QdziMdu/pEunF8Iu4G/iLDQEF40Z
	fROSKlMDRUZKSnYdI/hgeZ5PSVQC+By/tahT/e/s9kHu3Jf4zCoRMAkFQXLTytnzw5vETrYUZ4b
	qRYES4A==
X-Received: from plxx12.prod.google.com ([2002:a17:902:e04c:b0:2c7:6c19:9ae9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b08:b0:2c6:937a:249
 with SMTP id d9443c01a7336-2c7fc8a2889mr83480545ad.29.1782509749463; Fri, 26
 Jun 2026 14:35:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Jun 2026 14:35:24 -0700
In-Reply-To: <20260626213534.3866178-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626213534.3866178-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260626213534.3866178-12-seanjc@google.com>
Subject: [PATCH v8 11/20] KVM: selftests: Verify interrupts are received when
 IRQ affinity changes in IRQ test
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

Extent the eventfd IRQ test with a '-a' flag to randomly affinitize the
device's host IRQ to different physical CPUs throughout the test.  This
stresses the kernel's ability to maintain correct interrupt routing and
delivery even as the underlying hardware IRQ affinity is changed
dynamically via /proc/<irq>/smp_affinity{,_list}.

Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 70b2c9cac279..fd386e3e9ac3 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -12,10 +12,12 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <sys/eventfd.h>
+#include <sys/sysinfo.h>
 
 static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
+static bool irq_affinity;
 static bool done;
 
 #define GUEST_RECEIVED_IRQ(__vcpu)	\
@@ -137,9 +139,10 @@ static const char *probe_iommu_type(void)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-d <segment:bus:device.function>] [-h] [-t iommu_type]\n", name);
+	printf("Usage: %s [-a] [-d <segment:bus:device.function>] [-h] [-t iommu_type]\n", name);
 	printf("\n");
 	printf("Tests KVM interrupt routing and delivery via irqfd.\n");
+	printf("-a	Affine the device's host IRQ to a random physical CPU\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of manually signaling the eventfd\n");
 	printf("-t	Override the IOMMU type to use (vfio_type1_iommu or iommufd)\n");
 	printf("\n");
@@ -172,10 +175,13 @@ int main(int argc, char **argv)
 	int i, j, c, msix, eventfd;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
-	int irq;
+	int irq, irq_cpu;
 
-	while ((c = getopt(argc, argv, "d:ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ad:ht:")) != -1) {
 		switch (c) {
+		case 'a':
+			irq_affinity = true;
+			break;
 		case 'd':
 			device_bdf = optarg;
 			break;
@@ -204,7 +210,12 @@ int main(int argc, char **argv)
 		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
 		       irq);
 	} else {
+		TEST_ASSERT(!irq_affinity,
+			    "Setting IRQ affinity (-a) requires a backing device (-d)");
+
 		eventfd = kvm_new_eventfd();
+		irq = -1;
+		irq_cpu = -1;
 	}
 
 	pr_info("Injecting interrupts for GSI %d (guest vector 0x%x) %d times\n",
@@ -228,6 +239,11 @@ int main(int argc, char **argv)
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity) {
+			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
+			proc_irq_set_smp_affinity(irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++)
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
@@ -241,8 +257,8 @@ int main(int argc, char **argv)
 			cpu_relax();
 
 		TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpu),
-			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d\n",
-			    vcpu->id, vector, gsi);
+			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d (via CPU %d)\n",
+			    vcpu->id, vector, gsi, irq_cpu);
 
 		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
-- 
2.55.0.rc0.799.gd6f94ed593-goog

