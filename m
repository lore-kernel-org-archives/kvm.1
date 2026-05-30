Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F02D9EE7
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100615; cv=none; b=FenAx38jUklXNnBRcs1QP+2o7PKInHMW1OJRWgZ952O7g0mcX2BYsqEaY67lxMFTu34H8LdQ850T5LqVsbh865zYJ1/eWnlTf7g6D5FLbcyHbHevHFO+FYkgE0lLC/thcN0kwengDViquL71Mj5lb+S9f/WQTpK6ovFfbdoOwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100615; c=relaxed/simple;
	bh=kE8XjfOxzJs8azoyHN62Q77wqmIgre+C9k/tz5VsTwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uf8BlskzQV/cbBfOWvHDIVM8E1psF7SnfY8rFy79W+TLchEaNGFary4hGwqtvh6m7CPu0WfmPY4HZyro2RYT/R+XXOs81lZGGlKozTl33RSEx61NgUZslAsL1C6ChdYV4HROhKXP08CxzUShdLasbW+j31VgXpV49cqXz9u0S3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2Zk12P/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2Zk12P/"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8584e80bfcso242371a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100613; x=1780705413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm1HsuW4vpwjSUMEY8SE1UJyBnCa5qMSZzhyXJG3FSY=;
        b=f2Zk12P/XxKZHX4jJlPBVVPvhVPqCEBEG2BgZaS5fQS4t5ZRclCDKufjrCYPJj7C47
         wUtw/h3rF61pQTJnr6Oy5Epyh0LeyPVcCYXkIju9ncvKf7rC2OW/l3hnHp/TkCVO+tdp
         yQckwm2+gdH6sp+rmBloAhEVT/aWjMzU5pypwLasP3O0QKZB/IBxav2PoKkj35JqqBY2
         wzerU9bqJSJuhfTS3CENkg/VBwN8gUy+GujjJYlq1+7rpfgHnr/IhMmUXLgK7L94o8Oi
         sexpxNP1vIYf+otOnMMGNNlEepVLJaLmL317up+0rFS0+fY5cA5jVLrGFu2AZib8LN5q
         YWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100613; x=1780705413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qm1HsuW4vpwjSUMEY8SE1UJyBnCa5qMSZzhyXJG3FSY=;
        b=bTwEDbfyUyXAMhqoBchqy4W8hDSwJxT3wLwBSCv5bWicETGb12MA3QoF/+fJ33h/vV
         uEPPopqd9o5mya2rUxD26qMSsje1xAeMh5FiKfRa2ehz6xgyQ8ALbd+H+vX7lP2E7GfD
         F1JXxVE569jl7JWwVPhoNZkKoVDL+cqz0U9KDoOZ5KuUXsrFlDzeqnX5M1MZomV+SsfY
         LvQKVp9sNPxv1rdGzT1cHBcLeCSBnm2UZrh4g55fox8ymCgVe1ZA76RAX86/NU5DY/Q6
         M37hbiRmyKj5+dFOwJ/ZwQwqcparfMTgTM/xDOg/S3wZuVWGHT1uUb9pyMJvAVU4lNaL
         v6hA==
X-Gm-Message-State: AOJu0Yyd/O5G3yY3acSKiNyV+QrJ5F2rOtI0hmmqcRTMt41XGDzj3dWT
	lUans5z3M/t0ZMDFbttnD/XdtnzIO3VLX0UEgDuJdQEFxNcV5C8vMrDEYz4qXdjbOKrO2HJroLf
	WzEFT90J4
X-Received: from pgbbc23.prod.google.com ([2002:a65:6d97:0:b0:c79:85be:4c5c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d80c:b0:39c:4b84:d90f
 with SMTP id adf61e73a8af0-3b427e7b3d7mr1764882637.8.1780100613386; Fri, 29
 May 2026 17:23:33 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:31 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-17-jrhilke@google.com>
Subject: [PATCH v4 16/19] KVM: selftests: Verify vCPU migration during IRQ
 delivery in IRQ test
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the '-m' flag to tools/testing/selftests/kvm/irq_test.c to migrate
vCPU threads across random physical CPUs during the test. This validates
KVM's ability to handle vCPUs changing physical CPUs while interrupts
are actively being injected.

Co-developed-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/kvm/irq_test.c | 34 ++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftests/kvm/irq_test.c
index 79b0691c9889..f653317022e3 100644
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
@@ -171,8 +185,9 @@ int main(int argc, char **argv)
 	FILE *irq_affinity_fp = NULL;
 	struct iommu *iommu;
 	struct kvm_vm *vm;
+	cpu_set_t available_cpus;
 
-	while ((c = getopt(argc, argv, "abcd:hi:n")) != -1) {
+	while ((c = getopt(argc, argv, "abcd:hi:mn")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -189,6 +204,9 @@ int main(int argc, char **argv)
 		case 'i':
 			nr_irqs = atoi_positive("Number of IRQs", optarg);
 			break;
+		case 'm':
+			migrate_vcpus = true;
+			break;
 		case 'n':
 			use_nmi = true;
 			break;
@@ -238,6 +256,15 @@ int main(int argc, char **argv)
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
@@ -254,6 +281,9 @@ int main(int argc, char **argv)
 			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
 		}
 
+		if (migrate_vcpus && vcpu->id == 0)
+			migrate_vcpu_threads(nr_vcpus, vcpu_threads, &available_cpus);
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(!GUEST_RECEIVED_IRQ(vcpus[j]),
 				    "IRQ flag for vCPU %d not clear prior to test",
-- 
2.54.0.929.g9b7fa37559-goog

