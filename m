Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A239B367F3D;
	Mon, 29 Jun 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730820; cv=none; b=l9jThCLEL1xlI+fSC2/0AFTOyxT6o+P+CNPveOMReCcpB31dgkcurEZgkAJwK/4g5X64KAVgUD6Sn6Z1tQAgxGEg+1X4wHeV0Bh6JZlOIrw6oAecoUUS2MBvmIfWYABW4WgddVB34ZoqKzlXMjCER4uthTf3TiY1SKrhiDeVMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730820; c=relaxed/simple;
	bh=BUDStiJ4u7CmKE0ybAT6ipDN4SALCLfjoIvBPOupl7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq0xfD5WnfVzkItrg47cq7MLUihsugUOGLtLAyxVmMg6PVl3K0hQO3poPRBkiP4dLBpbRfOMH7AJgHy5xpVFhVW2/Xjt7FFhNeBFFJD1j7TC1CB6WLncwu+FZWiHDlWQRGJ1Fh8oI5g8rwjQLVlX31aocDF/Lnms1z7+3CpJVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q+xhBCEG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q+xhBCEG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A672B176C;
	Mon, 29 Jun 2026 04:00:08 -0700 (PDT)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 589AC3FA21;
	Mon, 29 Jun 2026 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782730813; bh=BUDStiJ4u7CmKE0ybAT6ipDN4SALCLfjoIvBPOupl7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+xhBCEGczqW7/hCbOCtmAct223xaQ6GH69cI0DGNgh4oBjmCarwi+dkUvh7zNDro
	 vkTFOI9AAnSOjj/TtzbMYp/1K87BR2OYWu3ezUuOIB5CP3mBz4mrnCUiksS67g2ixf
	 5ZtOmrHmzjP6pfRDl3hEUEzvJwxIX8X6I3JjujCI=
From: Leonardo Bras <leo.bras@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	David Matlack <dmatlack@google.com>,
	Leonardo Bras <leo.bras@arm.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Wu Fei <wu.fei9@sanechips.com.cn>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] KVM: selftests: dirty_log_perf_test: Add dirty-ring support
Date: Mon, 29 Jun 2026 11:59:42 +0100
Message-ID: <20260629105950.1790259-4-leo.bras@arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629105950.1790259-1-leo.bras@arm.com>
References: <20260629105950.1790259-1-leo.bras@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10756; i=leo.bras@arm.com; h=from:subject; bh=BUDStiJ4u7CmKE0ybAT6ipDN4SALCLfjoIvBPOupl7I=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLKc/CsSGlZ8SNmvtf2/pfjeY/s1bxvFXXAtjZC5v2r9r bjmG0atHaUsDGJcDLJiiiyyj+av4vk+JePIlR8LYOawMoEMYeDiFICJzHjK8N9JxHvul/TTktfK 9hg4l7toxk1U8uZQET2Y+tnTf72duwYjw1OLbwXbL5t7nNwYdXXqQ51Jsj9a1z11+C//5N/NRW9 q+FkA
X-Developer-Key: i=leo.bras@arm.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

dirty_log_test supports both dirty-bitmap and dirty-ring as dirty-page
tracking mechanisms, while dirty_log_perf_test only supports dirty-bitmap.

Add support to dirty-ring on dirty_log_perf_test so it can be used to
compare performance between changes in the mechanism.

Signed-off-by: Leonardo Bras <leo.bras@arm.com>
---
 .../selftests/kvm/dirty_log_perf_test.c       | 95 +++++++++++++++++--
 1 file changed, 86 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 69b38791440e..9bb14340bff5 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -6,61 +6,110 @@
  *
  * Copyright (C) 2018, Red Hat, Inc.
  * Copyright (C) 2020, Google, Inc.
  */
 
 #include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
 #include <pthread.h>
 #include <linux/bitmap.h>
+#include <asm/barrier.h>
 
 #include "kvm_util.h"
 #include "test_util.h"
 #include "memstress.h"
 #include "guest_modes.h"
 #include "ucall_common.h"
 
 /* How many host loops to run by default (one KVM_GET_DIRTY_LOG for each loop)*/
 #define TEST_HOST_LOOP_N		2UL
 
 static int nr_vcpus = 1;
 static u64 guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
 static bool run_vcpus_while_disabling_dirty_logging;
 
 /* Host variables */
 static u64 dirty_log_manual_caps;
+static u32 dirty_ring_size;
 static bool host_quit;
 static int iteration;
 static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
+static struct timespec vcpu_dirty_ring_collect[KVM_MAX_VCPUS];
+
+static void dirty_ring_collect(struct kvm_vcpu *vcpu, u32 *ring_idx,
+				struct timespec *ts)
+{
+	struct timespec start;
+	struct kvm_dirty_gfn *dirty_gfns = vcpu_map_dirty_ring(vcpu);
+	u32 ret, idx = *ring_idx;
+	u32 ring_size = vcpu->vm->dirty_ring_size / sizeof(struct kvm_dirty_gfn);
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
+	while (true) {
+		struct kvm_dirty_gfn *cur;
+
+		cur = &dirty_gfns[idx % ring_size];
+		if (smp_load_acquire(&cur->flags) != KVM_DIRTY_GFN_F_DIRTY)
+			break;
+
+		smp_store_release(&cur->flags, KVM_DIRTY_GFN_F_RESET);
+		idx++;
+	}
+
+	*ring_idx = idx;
+
+	ret = kvm_vm_reset_dirty_ring(vcpu->vm);
+
+	TEST_ASSERT(ret >= 0, "Error (%d) found when cleaning dirty-ring\n", ret);
+
+	*ts = timespec_add(*ts, timespec_elapsed(start));
+}
 
 static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 {
 	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
 	int vcpu_idx = vcpu_args->vcpu_idx;
 	u64 pages_count = 0;
 	struct kvm_run *run;
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec total = (struct timespec){0};
 	struct timespec avg;
+	bool use_dirty_ring = !!vcpu->vm->dirty_ring_size;
+	u32 ring_idx = 0;
 	int ret;
 
 	run = vcpu->run;
 
 	while (!READ_ONCE(host_quit)) {
 		int current_iteration = READ_ONCE(iteration);
+		struct timespec collect = (struct timespec){0};
 
 		clock_gettime(CLOCK_MONOTONIC, &start);
-		ret = _vcpu_run(vcpu);
+
+		do {
+			ret = _vcpu_run(vcpu);
+			if (!use_dirty_ring)
+				break;
+
+			dirty_ring_collect(vcpu, &ring_idx, &collect);
+		} while (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL);
+
 		ts_diff = timespec_elapsed(start);
 
+		if (use_dirty_ring) {
+			ts_diff = timespec_sub(ts_diff, collect);
+			vcpu_dirty_ring_collect[vcpu_idx] = collect;
+		}
+
 		TEST_ASSERT(ret == 0, "vcpu_run failed: %d", ret);
 		TEST_ASSERT(get_ucall(vcpu, NULL) == UCALL_SYNC,
 			    "Invalid guest sync status: exit_reason=%s",
 			    exit_reason_str(run->exit_reason));
 
 		pr_debug("Got sync event from vCPU %d\n", vcpu_idx);
 		vcpu_last_completed_iteration[vcpu_idx] = current_iteration;
 		pr_debug("vCPU %d updated last completed iteration to %d\n",
 			 vcpu_idx, vcpu_last_completed_iteration[vcpu_idx]);
 
@@ -112,42 +161,45 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	struct timespec start;
 	struct timespec ts_diff;
 	struct timespec get_dirty_log_total = (struct timespec){0};
 	struct timespec vcpu_dirty_total = (struct timespec){0};
 	struct timespec avg;
 	struct timespec clear_dirty_log_total = (struct timespec){0};
 	int i;
 
 	vm = memstress_create_vm(mode, nr_vcpus, guest_percpu_mem_size,
 				 p->slots, p->backing_src,
-				 p->partition_vcpu_memory_access, 0);
+				 p->partition_vcpu_memory_access,
+				 dirty_ring_size);
 
 	memstress_set_write_percent(vm, p->write_percent);
 
 	guest_num_pages = (nr_vcpus * guest_percpu_mem_size) >> vm->page_shift;
 	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
 	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
 	pages_per_slot = host_num_pages / p->slots;
 
 	bitmaps = memstress_alloc_bitmaps(p->slots, pages_per_slot);
 
 	if (dirty_log_manual_caps)
 		vm_enable_cap(vm, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2,
 			      dirty_log_manual_caps);
 
 	/* Start the iterations */
 	iteration = 0;
 	host_quit = false;
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
-	for (i = 0; i < nr_vcpus; i++)
+	for (i = 0; i < nr_vcpus; i++) {
 		vcpu_last_completed_iteration[i] = -1;
+		vcpu_dirty_ring_collect[i] = (struct timespec){0};
+	}
 
 	/*
 	 * Use 100% writes during the population phase to ensure all
 	 * memory is actually populated and not just mapped to the zero
 	 * page. The prevents expensive copy-on-write faults from
 	 * occurring during the dirty memory iterations below, which
 	 * would pollute the performance results.
 	 */
 	memstress_set_write_percent(vm, 100);
 	memstress_set_random_access(vm, false);
@@ -188,20 +240,35 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			while (READ_ONCE(vcpu_last_completed_iteration[i])
 			       != iteration)
 				;
 		}
 
 		ts_diff = timespec_elapsed(start);
 		vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
 		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
+		if (dirty_ring_size) {
+			struct timespec iteration_sum = (struct timespec){0};
+
+			for (i = 0; i < nr_vcpus; i++)
+				iteration_sum = timespec_add(iteration_sum,
+							     vcpu_dirty_ring_collect[i]);
+
+			pr_info("Iteration %d clear dirty ring time: %ld.%.9lds\n",
+				iteration, iteration_sum.tv_sec, iteration_sum.tv_nsec);
+
+			clear_dirty_log_total = timespec_add(clear_dirty_log_total,
+							     iteration_sum);
+			continue;
+		}
+
 		clock_gettime(CLOCK_MONOTONIC, &start);
 		memstress_get_dirty_log(vm, bitmaps, p->slots);
 		ts_diff = timespec_elapsed(start);
 		get_dirty_log_total = timespec_add(get_dirty_log_total,
 						   ts_diff);
 		pr_info("Iteration %d get dirty log time: %ld.%.9lds\n",
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		if (dirty_log_manual_caps) {
 			clock_gettime(CLOCK_MONOTONIC, &start);
@@ -231,46 +298,51 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		ts_diff.tv_sec, ts_diff.tv_nsec);
 
 	/*
 	 * Tell the vCPU threads to quit.  No need to manually check that vCPUs
 	 * have stopped running after disabling dirty logging, the join will
 	 * wait for them to exit.
 	 */
 	host_quit = true;
 	memstress_join_vcpu_threads(nr_vcpus);
 
-	avg = timespec_div(get_dirty_log_total, p->iterations);
-	pr_info("Get dirty log over %lu iterations took %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
-		p->iterations, get_dirty_log_total.tv_sec,
-		get_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+	if (!dirty_ring_size) {
+		avg = timespec_div(get_dirty_log_total, p->iterations);
+		pr_info("Get dirty log over %lu iterations took %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
+			p->iterations, get_dirty_log_total.tv_sec,
+			get_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+	}
 
-	if (dirty_log_manual_caps) {
+	if (dirty_log_manual_caps || dirty_ring_size) {
 		avg = timespec_div(clear_dirty_log_total, p->iterations);
 		pr_info("Clear dirty log over %lu iterations took %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
 			p->iterations, clear_dirty_log_total.tv_sec,
 			clear_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
 	}
 
 	memstress_free_bitmaps(bitmaps, p->slots);
 	memstress_destroy_vm(vm);
 }
 
 static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-a] [-i iterations] [-p offset] [-g] "
 	       "[-m mode] [-n] [-b vcpu bytes] [-v vcpus] [-o] [-r random seed ] [-s mem type]"
 	       "[-x memslots] [-w percentage] [-c physical cpus to run test on]\n", name);
 	puts("");
 	printf(" -a: access memory randomly rather than in order.\n");
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
+	printf(" -d: specify the size of dirty-ring for tracking dirty pages.\n"
+	       "     If non-zero, will cause dirty-ring to be used instead of\n"
+	       "     dirty-bitmap. Must be a power of two.\n");
 	printf(" -g: Do not enable KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2. This\n"
 	       "     makes KVM_GET_DIRTY_LOG clear the dirty log (i.e.\n"
 	       "     KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE is not enabled)\n"
 	       "     and writes will be tracked as soon as dirty logging is\n"
 	       "     enabled on the memslot (i.e. KVM_DIRTY_LOG_INITIALLY_SET\n"
 	       "     is not enabled).\n");
 	printf(" -p: specify guest physical test memory offset\n"
 	       "     Warning: a low offset can conflict with the loaded test code.\n");
 	guest_modes_help();
 	printf(" -n: Run the vCPUs in nested mode (L2)\n");
@@ -313,31 +385,36 @@ int main(int argc, char *argv[])
 	/* Override the seed to be deterministic by default. */
 	guest_random_seed = 1;
 
 	dirty_log_manual_caps =
 		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
 	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
 				  KVM_DIRTY_LOG_INITIALLY_SET);
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "ab:c:eghi:m:nop:r:s:v:x:w:")) != -1) {
+	while ((opt = getopt(argc, argv, "ab:c:d:eghi:m:nop:r:s:v:x:w:")) != -1) {
 		switch (opt) {
 		case 'a':
 			p.random_access = true;
 			break;
 		case 'b':
 			guest_percpu_mem_size = parse_size(optarg);
 			break;
 		case 'c':
 			pcpu_list = optarg;
 			break;
+		case 'd':
+			dirty_ring_size = parse_size(optarg);
+			dirty_ring_size *= sizeof(struct kvm_dirty_gfn);
+			dirty_log_manual_caps = 0;
+			break;
 		case 'e':
 			/* 'e' is for evil. */
 			run_vcpus_while_disabling_dirty_logging = true;
 			break;
 		case 'g':
 			dirty_log_manual_caps = 0;
 			break;
 		case 'h':
 			help(argv[0]);
 			break;
-- 
2.54.0

