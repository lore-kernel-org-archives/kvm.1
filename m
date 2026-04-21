Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492BE3ACA72
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813414; cv=none; b=FBf5v+ncQtZmlFS2Wdn/w6BRX7X8MzObtR77CWBW/6D5lWYv61TQmEjQ/8kQF9Ep+hrsklr12JJ2yq3QIgS1O9RH62LQ6HObkdqJ9HAHYKj38dSYCeB1M1i1vFaX/QnHUmz9FiLuPlMbu559yx+jrqj2HgzOq3F5giKmtzpP1e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813414; c=relaxed/simple;
	bh=JF4s8v+mqbvTlk7yLB1wARmKdzRBmtKSxDXsUWd1F1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dfzSn8JhqXVdeYQAvUHjzyL4HMaYb5a3E2yJ9yo/jKFN8w/8MO1wOvjZjGmb5ludSKGyV3lhXubUkkZMXC1VtvnLlXsmXkJtZTyIgyb6MLGmgLntZCVIjXkogD+KFS1Sg7Tf6Jwy1JDzQBMLFcEVN0zUOarthUfvU8XGB8OD+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ja4yiKn7; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ja4yiKn7"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso2248278b3a.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776813413; x=1777418213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kUAmSXYQQnOg/tuWPXoEr0xuDCH8FDfuwMytI/W+gUU=;
        b=Ja4yiKn7yGKT78MqgKNQVqb/HUtXn989dY5owHw6sbtPDAPrSy/VhY5gsWi7AMCRhi
         /tnqRW3ykt/6WsE3jagh5mwkWppCLoauDpj1scR81tHzyIqsg5ugB2D2T9ngaowD/6HU
         np1SGE5GJqQqP3JPbMRymSIAxHpJCCSigXDSww0iTG4aY7TF+aaeqDZ/Y8ZkctRktlR/
         ctLhZlem5IFpiP0XlLWFJKjxWFml7HLcORGDiwnamJPAlxwx7xiufRiIbmuDhUgz+/dT
         Ym8KCohtWN3WIiiS4Yfkp1zcv7m9hqDM7fjAselzyyonl7PzOgcgtP5joP3bS4vsA9Bp
         KxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813413; x=1777418213;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUAmSXYQQnOg/tuWPXoEr0xuDCH8FDfuwMytI/W+gUU=;
        b=d6/P/URog8jC8JVhGPIIRVF+iLAuj15mfr8HzQLt6po3GIH+YC/YYgw92s9QQKM1JS
         +67kMjh3BBd0ndrQeJI89Ch5Hkbcj2ZoCHKr7a8Gpw5Xr1O0M46B6fwZmwUhTuZQjo/I
         iBXaOGyqh6uA9RMnTBxH9DAPIkFNq0uEohAp6cCe8uoFrH9ts250pWJFjQWGBmR/KMJx
         ry6vWFLEyADIgTstmV8GC41D9vazBj5VRZypsCPYLpi8dyT+UdT8MAk+P9JD/bPPvkvH
         76IbpCjiFfhhAV3YV4Rdb1OCJyVQbbq6qOv15FofbMCDGhReSprQKq2Fudp2IF/A61XB
         C1QA==
X-Gm-Message-State: AOJu0YxIEkFB2ZW+Q39C26/EajEwULapZl571tPiSrF/9/AgTGDGFs5Z
	Yyuh3ZDAjDMNXg5z4E0OBtmCRSOiDLHb66jvlOE77MBWzdZ2j9AEYbqSk+2PsHl7d/VTnzfVleb
	1YB3jZ5Z5
X-Received: from pfbkx31.prod.google.com ([2002:a05:6a00:6f1f:b0:82f:8956:e620])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc8:b0:82d:30f:b197
 with SMTP id d2e1a72fcca58-82f8c8aec07mr21029033b3a.22.1776813412477; Tue, 21
 Apr 2026 16:16:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:15:54 +0000
In-Reply-To: <20260421231557.1254270-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421231557.1254270-14-jrhilke@google.com>
Subject: [PATCH v3 13/16] KVM: selftests: Verify vCPU migration during IRQ delivery
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-m' flag to irq_test to migrate vCPU threads across random
physical CPUs during the test. This validates KVM's ability to handle
vCPUs changing physical CPUs while interrupts are actively being
injected.

To support this, add wrappers for gettid() and sched_getaffinity(), and
introduce pin_task_to_random_cpu() in lib/kvm_util.c.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/kvm/include/kvm_syscalls.h      |  6 ++++
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/irq_test.c        | 34 +++++++++++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +++++++++++
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d4e613162bba..d73f45c5df92 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -73,9 +73,15 @@ static inline int kvm_dup(int fd)
 	return new_fd;
 }
 
+static inline int gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
+__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 499e695f1fc4..f725ab0ed4f9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1096,6 +1096,8 @@ static inline void pin_task_to_cpu(pthread_t task, int cpu)
 	TEST_ASSERT(!r, "Failed to set thread affinity to pCPU '%u'", cpu);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus);
+
 static inline int pin_task_to_any_cpu(pthread_t task)
 {
 	int cpu = sched_getcpu();
diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 03b88b7585b3..dd6a08d3bf4f 100644
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
@@ -62,12 +64,23 @@ static void *vcpu_thread_main(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct ucall uc;
 
+	WRITE_ONCE(vcpu_tids[vcpu->id], gettid());
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
@@ -126,7 +139,7 @@ static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-n]\n", name);
+	printf("Usage: %s [-a] [-b] [-c] [-d <segment:bus:device.function>] [-h] [-i nr_irqs] [-m] [-n]\n", name);
 	printf("\n");
 	printf("Tests KVM IRQ injection via irqfd using an emulated eventfd.\n");
 	printf("-a	Randomly affinitize the device's host IRQ to different physical CPUs throughout the test\n");
@@ -134,6 +147,7 @@ static void help(const char *name)
 	printf("-c	Destroy and recreate KVM's GSI routing table in between some interrupts\n");
 	printf("-d	Use a VFIO device to send MSI-X interrupts instead of using an emulated eventfd\n");
 	printf("-i	The number of IRQs to generate during the test\n");
+	printf("-m	Pin vCPU threads to random physical CPUs throughout the test\n");
 	printf("-n	Deliver 50 percent of IRQs as non-maskable interrupts\n");
 	printf("\n");
 	exit(KSFT_FAIL);
@@ -164,10 +178,11 @@ int main(int argc, char **argv)
 	int nr_irqs = 1000, nr_vcpus = 1;
 	const char *device_bdf = NULL;
 	FILE *irq_affinity_fp = NULL;
+	cpu_set_t available_cpus;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
 
-	while ((c = getopt(argc, argv, "abcd:hi:n")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -184,6 +199,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'm':
+			migrate_vcpus = true;
+			break;
 		case 'n':
 			use_nmi = true;
 			break;
@@ -233,6 +251,15 @@ int main(int argc, char **argv)
 			continue;
 	}
 
+	if (migrate_vcpus) {
+		kvm_sched_getaffinity(vcpu_tids[0], sizeof(available_cpus), &available_cpus);
+
+		if (nr_vcpus > CPU_COUNT(&available_cpus)) {
+			printf("There are more vCPUs than pCPUs; refusing to migrate.\n");
+			migrate_vcpus = false;
+		}
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		const bool do_clear_routes = clear_routes && (i & BIT(3));
 		const bool do_use_nmi = use_nmi && (i & BIT(2));
@@ -249,6 +276,9 @@ int main(int argc, char **argv)
 			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
 		}
 
+		if (migrate_vcpus && vcpu->id == 0)
+			migrate_vcpu_threads(nr_vcpus, vcpu_threads, &available_cpus);
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(
 				!SYNC_FROM_GUEST_AND_READ(vm, guest_received_irq[vcpus[j]->id]),
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b247b2015b2a..83732c07dfda 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -662,6 +662,25 @@ void kvm_print_vcpu_pinning_help(void)
 	       "     (default: no pinning)\n", name, name);
 }
 
+void pin_task_to_random_cpu(pthread_t task, cpu_set_t *possible_cpus)
+{
+	int i = 0, nr_cpus = CPU_COUNT(possible_cpus);
+	int cpu, target_idx;
+
+	target_idx = kvm_random_u64(&kvm_rng) % nr_cpus;
+
+	for (cpu = 0; i < nr_cpus; cpu++) {
+		if (!CPU_ISSET(cpu, possible_cpus))
+			continue;
+
+		if (i == target_idx) {
+			pin_task_to_cpu(task, cpu);
+			return;
+		}
+		i++;
+	}
+}
+
 void kvm_parse_vcpu_pinning(const char *pcpus_string, uint32_t vcpu_to_pcpu[],
 			    int nr_vcpus)
 {
-- 
2.54.0.rc2.533.g4f5dca5207-goog

