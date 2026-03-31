Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29D73AA4E5
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986094; cv=none; b=OXJBzBgDlpr/KuS4nKOqV7lrQfPEN5wX1E9GmQ6zWdLxvF5+9KJqcsc71rWv20VlVerZ0MYQX884avolw/ha5OBVwfAs/DoqDo17Pu3oN6MNGdoww2NPOdluCuj72DMPpVn6FJ/g9bsm8g1iD2f+zAuxc1okxG7iIHV6iI3tYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986094; c=relaxed/simple;
	bh=WeOMjsB1r6GltdpOLs46DMj4DDR4vx1W74epJhK2/I8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vu1lJqCkb8nZnNYV2VhHtu8VyYwa82soOdVSMloGEJyhd5nHnxxvZWxWodRT2pRGVZn+/eunI2txo4GLcMYHgGOkMs9S0eg316BDAyUMGycZ9Y9MoyBgGoVEbNHCmyF/zb4NGeA6lcwMJvZcJ3Z8WaGDnSTA9QEh3iir2PKN44k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LGGyhv9s; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGGyhv9s"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35d96923dd2so3840291a91.1
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986092; x=1775590892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VWdzHNPfRffL+aobHn8nvBhlPUaE8JjmT+a1EKnSiWk=;
        b=LGGyhv9sZuroLWxFf23MDTaZLv4nTKG/Iup9Ql8kswf3DZ583Cwq3nt0ldnHzAkE72
         7mNoz76TwmLeq28cAZnqAQRspmfbjcv5utftI/HAruUBUqKyW4S2XrYf6jyCBDYhkghC
         VGp8hnJ1T0UG5pA8W4XG2MZ2I3JsH2KDd1cEveu6G1QHM2k4g1CHl9t2ZB98Or+mU4np
         eJ0/h/i4f5jbE79EtWe0YdHWVo522C49/q5smSjXFKPH8cdYgp6iFyHxParOsZ7OSTrs
         YhUh2IL6PrbGKlPhIn9bCWPCX8k96EjSGrVuHrsYizO48EIROb0xhtw2ELFwmaIwD04K
         vsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986092; x=1775590892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWdzHNPfRffL+aobHn8nvBhlPUaE8JjmT+a1EKnSiWk=;
        b=Lf4KrvFxLtTDFSJmu2bZmC4TZMuFhfjIYaUnAD7o9I9QtIlEIC7CC0WgNH/6MHvwpu
         UxBIRtCBkuR5pW2bVhPlCV9KcVoCt8L1g41Z0LLtB2NJuNy4D3fkMmpcklIRo2FAkYA3
         mi5rL2qP7wySdckMmZMsU67t5aa0z778EMdB3P381l16bo46spqtMTd3o6AsYGZ1CGUp
         30zE2IHpTmtKhGMDKTs4k3Z2w+CRU0JrS7fEixpC2h5F21zhT6GJSBk5n4M1wCZfKX3l
         kunqj43SEGZz6kfvJJ8DweMxKkfMNvEdhX2NhSnVHLzm2zJ9mQGd3g/c7dF4fakmD362
         ZDMQ==
X-Gm-Message-State: AOJu0YzGcPX5KW98b5MbwXxoxUZ+j9x9zuOFMbkmY7XpdY8dHN3Vnrqi
	ZSqlYdrVWJiEtlHBx9g7mrIjX7MXpLCyupr6xUA3ehGV5rZrq77tag3t4lp9oGsv+M03E2X6mtX
	EnRqLYd9n
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:35d:9fc4:2679])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c8c:b0:35b:96bb:47ba
 with SMTP id 98e67ed59e1d1-35dc7057f68mr472428a91.26.1774986091940; Tue, 31
 Mar 2026 12:41:31 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:24 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-6-jrhilke@google.com>
Subject: [PATCH v2 05/14] KVM: selftests: Add support for random host IRQ affinity
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-a' flag to vfio_pci_irq_test to randomly affinitize the
device's host IRQ to different physical CPUs throughout the test.  This
stresses the kernel's ability to maintain correct interrupt routing and
delivery even as the underlying hardware IRQ affinity is changed
dynamically via /proc/irq/.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index 6f40b3c2b985..1957d1b7bbf2 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -88,9 +88,11 @@ static void send_msi(struct vfio_pci_device *device, int msi)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-h] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-h] segment:bus:device.function\n",
 	       name);
 	printf("\n");
+	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
+	       "      throughout the test.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -113,6 +115,7 @@ int main(int argc, char **argv)
 	u8 vector = 32 + rand() % (UINT8_MAX - 32);
 
 	/* Test configuration (overridable by command line flags). */
+	bool irq_affinity = false;
 	int nr_irqs = 1000;
 	int nr_vcpus = 1;
 
@@ -122,13 +125,19 @@ int main(int argc, char **argv)
 	struct vfio_pci_device *device;
 	struct iommu *iommu;
 	const char *device_bdf;
+	FILE *irq_affinity_fp;
 	int i, j, c, msi, irq;
 	struct kvm_vm *vm;
+	int irq_cpu;
+	int ret;
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "h")) != -1) {
+	while ((c = getopt(argc, argv, "ah")) != -1) {
 		switch (c) {
+		case 'a':
+			irq_affinity = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -163,6 +172,14 @@ int main(int argc, char **argv)
 			continue;
 	}
 
+	if (irq_affinity) {
+		char path[PATH_MAX];
+
+		snprintf(path, sizeof(path), "/proc/irq/%d/smp_affinity_list", irq);
+		irq_affinity_fp = fopen(path, "w");
+		TEST_ASSERT(irq_affinity_fp, "fopen(%s) failed", path);
+	}
+
 	/* Set a consistent seed so that test are repeatable. */
 	srand(0);
 
@@ -172,6 +189,13 @@ int main(int argc, char **argv)
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity && vcpu->id == 0) {
+			irq_cpu = rand() % get_nprocs();
+
+			ret = fprintf(irq_affinity_fp, "%d\n", irq_cpu);
+			TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%d to CPU %d", irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(
 				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
@@ -189,6 +213,8 @@ int main(int argc, char **argv)
 			if (timespec_to_ns(timespec_elapsed(start)) > TIMEOUT_NS) {
 				printf("Timeout waiting for interrupt!\n");
 				printf("  vCPU: %d\n", vcpu->id);
+				if (irq_affinity)
+					printf("  irq_cpu: %d\n", irq_cpu);
 
 				TEST_FAIL("vCPU never received IRQ!\n");
 			}
@@ -203,6 +229,9 @@ int main(int argc, char **argv)
 		pthread_join(vcpu_threads[i], NULL);
 	}
 
+	if (irq_affinity)
+		fclose(irq_affinity_fp);
+
 	printf("Host interrupts handled:\n");
 	printf("  IRQ-%d: %lu\n", irq, get_irq_count(irq) - irq_count);
 	printf("  Posted-interrupt notification events: %lu\n",
-- 
2.53.0.1118.gaef5881109-goog

