Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9C35A384
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538569; cv=none; b=kNKwONhFM8RkPPIO2gRs8lF9gi5Y9ZPuR328ujt1JLDcPgYl868rXcBL01Zn65iUWc3RE8+sOP4BLqyGBUYzwrYAVXweJbelSp5fx8cPRqsABV1RxlnyioFyGD856nb5vXFvHaVe3sjCvT51MGXEGAcY1kpUxkOweMcIwJSph+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538569; c=relaxed/simple;
	bh=MUR6NE2vPYTJB/pmLIQ3jm48P+R2f4+6eIf6s3bO0T4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R6DuC9sfZr6TBZs38M6r0thtRODaprCTgShpkvYHZDW4yApQ+wmhYwM6m4M7jAD70iUCmB06I6zb6TRPfcoNL0GC3NHA+hmq3fwCsdTGbwDl7qJ2q2pO68IRX0PW/YPquBUqlcW3I5G/cW0zQtbKymLrmRKmRgGEPJ+mW4kQ5ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzMTxNHx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzMTxNHx"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0bf6904a6so3999065ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538567; x=1781143367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qCiJ8xzq+I/vxn4SzqtijIE4qOrazB6JANMHyalZPrg=;
        b=UzMTxNHxZRwd2/YACk5sr+CeszbMtj0pd33PSsf0gziu1ioxZDhv4l7/K203rkO9tg
         pVuMnXmQCnOpUBi2eAd92b0Tyba/B59IJxcMGY4FNYsMnxKjtWfIFp8AnLqjSbfuWaWR
         iyj4s8XhW2RskzWj7bMnRZt2FDOzByUVhGxWb00XF6iMYgGssMLuWOdCKWyk5G3fT38r
         jPlDhWFDk3izuYHcT5h+Y/kmf71D/nnpYUb2g0x0JjgfhJg9ObfKg40EoHuzoV9tVJsx
         Ljbb/7KWdh7Fbk0OdA1zFkZcucDBipLrpjeLxsnn9WN3Jp5mTLCUYLlojy9JmhXHwMV1
         jNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538567; x=1781143367;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCiJ8xzq+I/vxn4SzqtijIE4qOrazB6JANMHyalZPrg=;
        b=MRZjf0DtzamZitS9qRvEx593NTzyB8clqbaU7xVZQlqQD2qRjWEsxx6vdV8ZyW8Mj/
         wWRtX8VZY8EUIu+l76mZIn2Kefg9hhGWmga/wdLQFXg04EDH3Arkdpx5+F7zekvIpqJg
         LOLeVkQlyGgwkghXzD2ia5bqMMRZDHxifXCwwaF1w+MFars+4bQ7kia7lcWbP7/KDlOV
         FYhL7T4fMkzWVBxZJQ/g4kP75u7KdohXiP3tsUyAX/L/wKRcQrrSz6ORwX9hQkjZCPec
         GhHRUzO/HcEzwelaTkT9QdJ1D3L0jEc2hpfLrC/hOHzCpZi7NIZAXkLKdm8rIO+gMUUC
         T7GQ==
X-Gm-Message-State: AOJu0Yz1mx/DSeql4RyeICxsHCSX/bayD9WcZ0faD/BPLrzurEIBa1w/
	2OkaAvLaJ1NzTZ3AuEDDnEK80nLK3f0GAiW6UeVfOVm0mgZpI3aDV+jf/b8INjGpZAifWTthv/t
	2t7WogIJy
X-Received: from pgmd38.prod.google.com ([2002:a63:1d66:0:b0:c79:39f0:12f2])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db09:b0:3a0:adc5:52c1
 with SMTP id adf61e73a8af0-3b497552575mr6539853637.11.1780538566504; Wed, 03
 Jun 2026 19:02:46 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:40 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-19-jrhilke@google.com>
Subject: [PATCH v5 18/21] KVM: selftests: Verify vCPU migration during IRQ
 delivery in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-m' flag to tools/testing/selftests/kvm/irq_test.c to migrate
vCPU threads across random physical CPUs during the test. This validates
KVM's ability to handle vCPUs changing physical CPUs while interrupts
are actively being injected.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index ed48562318bf..5f7df76005ec 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -18,6 +18,8 @@ static u64 timeout_ns = 2ULL * 1000 * 1000 * 1000;
 static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
+static pid_t vcpu_tids[KVM_MAX_VCPUS];
+static bool migrate_vcpus;
 static bool irq_affinity;
 static bool block_vcpus;
 static bool done;
@@ -67,12 +69,23 @@ static void *vcpu_thread_main(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct ucall uc;
 
+	WRITE_ONCE(vcpu_tids[vcpu->id], kvm_gettid());
+
 	vcpu_run(vcpu);
 	TEST_ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, &uc));
 
 	return NULL;
 }
 
+static void migrate_vcpu_threads(int nr_vcpus, pthread_t *vcpu_threads,
+				 cpu_set_t *available_cpus)
+{
+	int i;
+
+	for (i = 0; i < nr_vcpus; i++)
+		pin_task_to_random_cpu(vcpu_threads[i], available_cpus);
+}
+
 static int vfio_setup_msi(struct vfio_pci_device *device)
 {
 	const int flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -131,7 +144,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-n]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -139,6 +152,7 @@ static void help(const char *name)
 	printf("-c	Destroy and recreate KVM's GSI routing table in between some interrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -169,13 +183,14 @@ int main(int argc, char **argv)
 	FILE *irq_affinity_fp = NULL;
 	int i, j, c, msix, eventfd;
 	bool clear_routes = false;
+	cpu_set_t available_cpus;
 	bool use_nmi = false;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 	unsigned int irq;
 	int irq_cpu;
 
-	while ((c = getopt(argc, argv, "abcd:hi:n")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -192,6 +207,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'm':
+			migrate_vcpus = true;
+			break;
 		case 'n':
 			use_nmi = true;
 			break;
@@ -246,6 +264,14 @@ int main(int argc, char **argv)
 	 */
 	irq_cpu = -1;
 
+	if (migrate_vcpus) {
+		kvm_sched_getaffinity(vcpu_tids[0], sizeof(available_cpus), &available_cpus);
+
+		if (nr_vcpus > CPU_COUNT(&available_cpus)) {
+			printf("There are more vCPUs than pCPUs; refusing to migrate.\n");
+			migrate_vcpus = false;
+		}
+	}
 	for (i = 0; i < nr_irqs; i++) {
 		const bool do_clear_routes = clear_routes && (i & BIT(3));
 		const bool do_use_nmi = use_nmi && (i & BIT(2));
@@ -262,6 +288,9 @@ int main(int argc, char **argv)
 			write_proc_irq_smp_affinity_list(irq_affinity_fp, irq, irq_cpu);
 		}
 
+		if (migrate_vcpus && vcpu->id == 0)
+			migrate_vcpu_threads(nr_vcpus, vcpu_threads, &available_cpus);
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
-- 
2.54.0.1032.g2f8565e1d1-goog

