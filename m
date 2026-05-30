Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD023E324
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100598; cv=none; b=ZRpx/CmJEuO20aBGLRFkhhSYHKX2Cv4NeTLYJNHM2c+sQvn8YInchH12bENEJ5zTSCU22Ow+KYCuf1MFUXqn1EUYqFrfBfAeLohcMjZTTfMx2zZBCu1pAW0EskQUzyzNEjLUVzF7pwSMnT9Np4SijKiRu45ZJ/Hh40slMXX/nkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100598; c=relaxed/simple;
	bh=kuJDGzNlOupw9zrcTsIKl2bXMewkhe+KmRKeRL79LdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r1oZfrDGEm0fvTXsdsT8AQryN/0bbZlvp7+QQHi7grqn5es0snoWSMFO/j0OZGsdyOjQjun36zRFCIYm+GOdC7kJRfS4Dbl5y4j2pk3/ddOHGgIEh+yJgfLdfMX5slKGNY47Q5XVOo6UPW7G+wJucwTAfnsim/LaktIsrA0qQ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUxQDWkx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUxQDWkx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf281d523eso5201265ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100596; x=1780705396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tI/496f5tHNM/4UlnuACeSVaDbzvZJZQ1aj5DlmVwnc=;
        b=hUxQDWkx4vGN683yOM3E9CFejk+Jz1fD1Qc85ciHQwM1gc7k8UYrVzbwevPAGaHwIy
         GIxcXxl0jauOZvLvWfZhUl3+DAmY8/gHDVwQTbtjHBrUFptC35G/5TSJQqT31ohNBf54
         L6vwEtvvYJyHuHjwFkN5UATeOd/025CdbCe8qbcvoeeG38QyTKmyndGM0rj4b7IiveuW
         EciQ+6d3VqD/H8fBt8LX8A8mZH+pNayCERa2YLEJIT2vB77aQDwbvzK3EHcVpJW8GDww
         KTmDmln/xWTwOctIA9aCEW8+gQ6VY5TAyUsmlU2LPC7UqJ6URe9KYtgkO8R3rGYpAWpc
         TPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100596; x=1780705396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI/496f5tHNM/4UlnuACeSVaDbzvZJZQ1aj5DlmVwnc=;
        b=WTYvEUYrFCJyxCS1L7w3xxPVNG7E2gX+t4DwTm2LnwfCbrLRryKFMjpUMACXSrQ2yF
         ozpUUyC2bF1CTsEZphYi9nqVssysC3+CcVUxkplVBmn2iJFabk99mGrr2bSB2a8s8AJ5
         bsVoupzkwvb99rfMGFgLaBfLUat86iODh+GnC60EkaGtattl5E35vGFOkyaoNXHq3k+O
         EXRXSTwEHw5tYsJ/HUCAMFSzxhBJD9omZWff2DrMblwigdC1FBfTahO+7F3sT9FIzT7v
         aIRkNpCUurC23ln9pRDrljpS7fn1T6eokKqOsSKNeKo/oAMSzITveYWa4aZID9RMJDZB
         CfkQ==
X-Gm-Message-State: AOJu0Yw1wmg/NTHEtT+HFVbOmNsoP6bVU6fLleKk9R8pSA7mc9+8r1KI
	21FHIw0G0AlSN3M27faU2RilzgYHDq6pw9SFoaT+7Hx5CeCyZEfmKarKRL4vCWm1nUxcGwCn0Ba
	T/nuue9Eg
X-Received: from plbbj2.prod.google.com ([2002:a17:902:8502:b0:2bf:1b54:1fc4])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88c:b0:2bf:30c8:bfa1
 with SMTP id d9443c01a7336-2bf368bd8aamr23911685ad.41.1780100596044; Fri, 29
 May 2026 17:23:16 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:23 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-9-jrhilke@google.com>
Subject: [PATCH v4 08/19] KVM: selftests: Verify interrupts are received when
 IRQ affinity changes in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
 .../testing/selftests/kvm/include/proc_util.h | 19 +++++++++++
 tools/testing/selftests/kvm/irq_test.c        | 34 ++++++++++++++++---
 tools/testing/selftests/kvm/lib/proc_util.c   | 20 +++++++++++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/proc_util.h b/tools/testing/selftests/kvm/include/proc_util.h
index 7c465e8584e2..2c8086158f68 100644
--- a/tools/testing/selftests/kvm/include/proc_util.h
+++ b/tools/testing/selftests/kvm/include/proc_util.h
@@ -6,4 +6,23 @@
 
 int get_proc_vfio_irq_number(const char *vfio_device_bdf, int msi);
 
+/*
+ * open_proc_irq_affinity - Open the smp_affinity_list file for a given IRQ
+ * @irq: The IRQ number
+ *
+ * Opens /proc/irq/<irq>/smp_affinity_list for writing and returns the FILE
+ * pointer.
+ */
+FILE *open_proc_irq_affinity(int irq);
+
+/*
+ * write_proc_irq_affinity - Write a CPU number to the smp_affinity_list file
+ * @fp: The FILE pointer for the smp_affinity_list file
+ * @irq: The IRQ number (for error reporting)
+ * @irq_cpu: The CPU number to write
+ *
+ * Writes the given CPU number to the provided FILE pointer.
+ */
+void write_proc_irq_affinity(FILE *fp, int irq, int irq_cpu);
+
 #endif /* SELFTEST_KVM_PROC_UTIL_H */
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 616eb38c05b8..e76784e0a054 100644
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
@@ -134,17 +137,21 @@ int main(int argc, char **argv)
 	u32 gsi = kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - 1);
 	u8 vector = kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
 
+	int i, j, c, msi, irq, eventfd, irq_cpu;
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t vcpu_threads[KVM_MAX_VCPUS];
 	struct vfio_pci_device *device = NULL;
 	int nr_irqs = 1000, nr_vcpus = 1;
-	int i, j, c, msi, irq, eventfd;
 	const char *device_bdf = NULL;
+	FILE *irq_affinity_fp = NULL;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "d:h")) != -1) {
+	while ((c = getopt(argc, argv, "ad:h")) != -1) {
 		switch (c) {
+		case 'a':
+			irq_affinity = true;
+			break;
 		case 'd':
 			device_bdf = optarg;
 			break;
@@ -171,6 +178,11 @@ int main(int argc, char **argv)
 		eventfd = kvm_new_eventfd();
 	}
 
+	if (irq_affinity) {
+		TEST_ASSERT(device_bdf, "-a requires -d");
+		irq_affinity_fp = open_proc_irq_affinity(irq);
+	}
+
 	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
 	       gsi, vector, nr_irqs);
 
@@ -192,6 +204,11 @@ int main(int argc, char **argv)
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity && vcpu->id == 0) {
+			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
+			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++)
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
@@ -204,9 +221,15 @@ int main(int argc, char **argv)
 			if (GUEST_RECEIVED_IRQ(vcpu))
 				break;
 
-			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
+				printf("Timeout waiting for interrupt!\n");
+				printf("  vCPU: %d\n", vcpu->id);
+				if (irq_affinity)
+					printf("  irq_cpu: %d\n", irq_cpu);
+
 				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					  vcpu->id, gsi, vector);
+			}
 		}
 
 		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
@@ -217,6 +240,9 @@ int main(int argc, char **argv)
 	for (i = 0; i < nr_vcpus; i++)
 		pthread_join(vcpu_threads[i], NULL);
 
+	if (irq_affinity)
+		fclose(irq_affinity_fp);
+
 	printf("Test passed!\n");
 
 	return 0;
diff --git a/tools/testing/selftests/kvm/lib/proc_util.c b/tools/testing/selftests/kvm/lib/proc_util.c
index ad1c54a81869..e5a4ee262f5e 100644
--- a/tools/testing/selftests/kvm/lib/proc_util.c
+++ b/tools/testing/selftests/kvm/lib/proc_util.c
@@ -40,3 +40,23 @@ int get_proc_vfio_irq_number(const char *device_bdf, int msi)
 	return irq;
 }
 
+FILE *open_proc_irq_affinity(int irq)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "/proc/irq/%d/smp_affinity_list", irq);
+	fp = fopen(path, "w");
+	TEST_ASSERT(fp, "fopen(%s) failed", path);
+
+	return fp;
+}
+
+void write_proc_irq_affinity(FILE *fp, int irq, int irq_cpu)
+{
+	int ret;
+
+	ret = fprintf(fp, "%d\n", irq_cpu);
+	TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%d to CPU %d", irq, irq_cpu);
+	fflush(fp);
+}
-- 
2.54.0.929.g9b7fa37559-goog

