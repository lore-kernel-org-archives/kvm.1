Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D42C11CF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310053; cv=none; b=uw+9GaABs4bP9pCuLRKYgOCMeA3xWIYW9GOYfNUU11DWhkchEXCWwLcSKnNcykj7ogft1r46cVGYxiy+TlQgRdqQ5KfNlPC2g7l0DHA+mvN4QY5afGxJw8N+9ckqMu/+GrbLzvElXk1SRGmxN2x1oxyyiqDeb9u62ByhNZXGiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310053; c=relaxed/simple;
	bh=pRjDYVgvzAMSMcyC4gsaWq6nGi+ggwtK6qIS2vByNj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+vOr2SgIPMgrPtu6V6ddf2I8BT1he7QifIXP9Jyz82enz0rhcZWesgoWuzuQwiDjtEIskD6Z/a/gLp8yVuoKqdnOfIwshLb34kWlZAA68a9NJZrVNvfdJ//OfbH6DAFQG2FUnw8UeZeTjYtc53TQRUMdgmDQHN6Eg5pBIZY+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Af4WTYVA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Af4WTYVA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36ba24fcd46so1100141a91.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310049; x=1781914849; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xZ0eZe4fkiDCH3zVpYK4NQsEFBnaL8FaPs5jLK/npco=;
        b=Af4WTYVAnhsjKm7SCzSou45hi7KbnWcGfR2q6JXNublGC3Q3Kp9GaKdQPhuBQT2PZ1
         CQMSVUEQgvwlIONt9SPoQxyE9jzSMB9AkPCULM4yHA3cHbzkz8WLeTL+HFMX4962lqBE
         Ye7Yk9AqJT3vZuCR0F5BGz7cv/0g/YXvk59qwF1/LC+gTanrHDVUGhbcHg6C3qHsyapl
         5r6Am0hi0s9LgvRNNsEqlN/X11UL5D/zu5r8hmc60cdrT1lgNumbXUPGFWvO+iW1aDvN
         utCr0gDUTxJKdWqr/7pThfqioU2bxJoq/Mj7GCbxeb9ai17NmOfi4CO3VayvocJYNZzL
         MnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310049; x=1781914849;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZ0eZe4fkiDCH3zVpYK4NQsEFBnaL8FaPs5jLK/npco=;
        b=gwPyFNIWDmYgmfDN7FkFTFMuYQ5FOYHortIusgEdiZyY9i1G77NN8oCT+Ml+KbAT29
         1XW1PdkH/T/wyLPQJKO3xYvnhzcCefTQrmUdlB1GoENpEljtk21EVLc8Jf47RaBHISbJ
         1+UOs0LcCoGUsEQr5QB6kl6bJvMfoE4wSS5/sK0f8LcvZeEmRACVGaxAaXVCAFT9sgEv
         TOdZDKjHecUY+EDYy9wEHACX/goCyW9CvcJFqnfUifHoOQmXFY9mZ54hDfBJv1bxTAjV
         XICygjvnkRp9OzFSuNKi9eE4tDLsovVS+jqHgdTSHAVpUYb6HUf/keGDMHNi88xAEIvU
         p3Bg==
X-Forwarded-Encrypted: i=1; AFNElJ90fXw00yhjDVTEUvwwiDfowvVwbdpKQSeq0nePorT5q/tpcwDOmhmQJdp7YFvFEcvQQ2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzvLD+4dX1pYDDQgXz7iCwb9Mc6G3vV7JNE4v+gs6XrYMAVER
	JBQciust54bpF0vPxxBc63CDPbIejEmnYzb94zXm4GjRfYp/+VGkGWmM7guN9ouAZdVOLLQTaW+
	MQuG6ww==
X-Received: from pjty19.prod.google.com ([2002:a17:90a:ca93:b0:369:bec6:fd63])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8e:b0:368:ac5f:d31b
 with SMTP id 98e67ed59e1d1-37a040b3ec6mr5340250a91.24.1781310049202; Fri, 12
 Jun 2026 17:20:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:22 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-12-seanjc@google.com>
Subject: [PATCH v7 11/20] KVM: selftests: Verify interrupts are received when
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
 tools/testing/selftests/kvm/irq_test.c | 27 +++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 6888be54ee4a..c01aa313f719 100644
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
@@ -125,9 +127,10 @@ static const char *probe_iommu_type(void)
 
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
@@ -160,10 +163,13 @@ int main(int argc, char **argv)
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
@@ -192,7 +198,11 @@ int main(int argc, char **argv)
 		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
 		       irq);
 	} else {
+		TEST_ASSERT(!irq_affinity,
+			    "Setting IRQ affinity (-a) requires a backing device (-d)");
+
 		eventfd = kvm_new_eventfd();
+		irq = -1;
 	}
 
 	pr_info("Injecting interrupts for GSI %d (guest vector 0x%x) %d times\n",
@@ -210,12 +220,19 @@ int main(int argc, char **argv)
 			continue;
 	}
 
+	irq_cpu = -1;
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct kvm_vcpu *vcpu = vcpus[i % nr_vcpus];
 		struct timespec start;
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity) {
+			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
+			proc_irq_set_smp_affinity(irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++)
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
@@ -229,8 +246,8 @@ int main(int argc, char **argv)
 			cpu_relax();
 
 		TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpu),
-			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d\n",
-			    vcpu->id, vector, gsi);
+			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d (via CPU %d)\n",
+			    vcpu->id, vector, gsi, irq_cpu);
 
 		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog

