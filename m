Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773112C1788
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813399; cv=none; b=LwkEL+H6bveCEpETfNyXjJnhhYXFUN4PP/5SSwliTJPMmM9uzKJbdlfkugzSMClK+ATnJy6nKfKeB3BVwnxJxNaLHExGGov6X/BC/gKG6DQzGcoBHKktMqjo+zNikhnJcvDvlNL/b1XJzYIhIwL0AvU7Jo/Ek7YRFxCAsgCRzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813399; c=relaxed/simple;
	bh=g/y5dHJeRIa1rtCrBVyHrEAWX57QUXQYjX729SgzpNk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eYOGQmU9DsDI/xEZdnn291F981zQen1m6TWe4jJRkN3YhiT087+klk1ZfX3ObcNApHWJJag7krRDfP3AU7vM65DOE7f5LT3cJlIOPIxxLQZ4FnWuaWi/VAkIVQAbtlY/pt6nOiTGsxCja6+qAVG3MxFM/3RVlBRIgs47qUUHzQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2FWkvyj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2FWkvyj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso2063136a12.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813398; x=1777418198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oB4fHNMTwDjMTWMSwGo8dDsC6oRH1VqUz0hgU85i0Q=;
        b=e2FWkvyjxSQKFHU0kr9NPRF6jH4houfR6BSXshjj+vB6Tmw2zs3LgYm8VbCP1O16wy
         EOFO5Y/eSo9r096uvqgk3+O6tprDYYlYRTjQbDk9TctYoYr9Zveg33aDVBToQYLhUV4a
         N1E+LIpzM7fCoCXsaipL9thPzpzh6EYpi3Im/m7p0TzQBonWZ/P7uv+UEP0+ULet9Hsu
         WgMVL78F1qrxwczlG+wlaeWJaYStDRePfIRAsrN8Poy4c5rSEr9dJK+76toOur49dddf
         91TNrEawEa4/nIcAjDVcQo6FMOxsdEHfycQMFOw2iFNTDc0EDhMN3Z1h25DOkJVYC7LL
         nshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813398; x=1777418198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oB4fHNMTwDjMTWMSwGo8dDsC6oRH1VqUz0hgU85i0Q=;
        b=Ror4r0bYNDID+I/WAdyCw2sVmHXH4qMDrb8Ml1AyNrMbpTrJVLW6T3wBrSN+ctLBjw
         XK3du3yscrBJ5zcg5TSVDHgO87yCNIMMT9rY2h8avThsuj18CnFUcU20tl1rN+eof26v
         nc/EMEJ2fLYhF4Onm8051WCRY1yulmhv5KF+s+ApOaIH4WPoLFrAa+zJ0KfbxiFCwRE/
         MvdZogZOTBC2bmi28K8qO/pBgT99YuUWNQSQdGippI0GLAeMM+Q4CZkUmZ9W6qCq3hN9
         d2/A9lxEoFHWypWOnjkjO7x6V9+iFHDR/fk384g0YKhXiEDDDu/pidMpTHqGrRxG1A6+
         olow==
X-Gm-Message-State: AOJu0YyGNzptDDiSRD3lS3O2/ku6ZJXvr5KHlGacUPvJy6KxFGgnRrXY
	Or8CDQyt5ft7w8Q19JwmOl94efd5UmR3vQsoCSZY9Ebh5JhGMvl5a+tY6SsvbZdAp96csJ62jfx
	u9gXqSAVu
X-Received: from pfad8.prod.google.com ([2002:a05:6a00:288:b0:82f:1e4a:bfb2])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a0b:b0:82f:b519:a5cb
 with SMTP id d2e1a72fcca58-82fb519a73emr8946524b3a.37.1776813397604; Tue, 21
 Apr 2026 16:16:37 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:49 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-9-jrhilke@google.com>
Subject: [PATCH v3 08/16] KVM: selftests: Verify IRQ affinity changes
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
 .../testing/selftests/kvm/include/proc_util.h | 19 ++++++++++
 tools/testing/selftests/kvm/irq_test.c        | 37 ++++++++++++++++---
 tools/testing/selftests/kvm/lib/proc_util.c   | 20 ++++++++++
 3 files changed, 70 insertions(+), 6 deletions(-)

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
index 434dce7188cc..bb124028fb20 100644
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
 
 static u32 guest_get_vcpu_id(void)
@@ -106,9 +108,10 @@ static void kvm_route_msi(struct kvm_vm *vm, u32 gsi, struct kvm_vcpu *vcpu,
 
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
@@ -131,17 +134,21 @@ int main(int argc, char **argv)
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
@@ -168,6 +175,11 @@ int main(int argc, char **argv)
 		eventfd = kvm_new_eventfd();
 	}
 
+	if (irq_affinity) {
+		TEST_ASSERT(device_bdf, "-a requires -d");
+		irq_affinity_fp = open_proc_irq_affinity(irq);
+	}
+
 	printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
 	       gsi, vector, nr_irqs);
 
@@ -189,6 +201,11 @@ int main(int argc, char **argv)
 
 		kvm_route_msi(vm, gsi, vcpu, vector);
 
+		if (irq_affinity && vcpu->id == 0) {
+			irq_cpu = kvm_random_u64(&kvm_rng) % get_nprocs();
+			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
+		}
+
 		for (j = 0; j < nr_vcpus; j++)
 			TEST_ASSERT(
 				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),
@@ -202,10 +219,15 @@ int main(int argc, char **argv)
 			if (SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpu->id]))
 				break;
 
-			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns)
-				TEST_FAIL(
-					"vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
+			if (timespec_to_ns(timespec_elapsed(start)) > timeout_ns) {
+				printf("Timeout waiting for interrupt!\n");
+				printf("  vCPU: %d\n", vcpu->id);
+				if (irq_affinity)
+					printf("  irq_cpu: %d\n", irq_cpu);
+
+				TEST_FAIL("vCPU %d timed out waiting for IRQ from GSI %d (Vector 0x%x) !\n",
 					vcpu->id, gsi, vector);
+			}
 		}
 
 		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
@@ -216,6 +238,9 @@ int main(int argc, char **argv)
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
2.54.0.rc2.533.g4f5dca5207-goog

