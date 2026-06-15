Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4293C277F
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511773; cv=none; b=XtJNr3cMGRSlNVc85p8H4gLdcjvm+0UJQ+P4D7eZHiUGfEXw4wSVKxglHgawvV3dAZ4ozTmnQ6HhaDgvon4cPW4EvpiPIOM/MBSe+/k3TFYw8WbS66AUmT2sqPNLHy/oGWNNQM8sevUKzom9yey7lB8+Q7jfaCvhptU0rbSQDCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511773; c=relaxed/simple;
	bh=uBNhK6KtGcFR3eNmNbnW1ZOnE+kOk92RNqqbOlS0qKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHD7/AKYhOAtHtwjrvXlT4PqGpuWkiMB99He/2m+dNPH4kSs5rS7ihtG6EXg6e+WI42HppkKOf/n4pg1MBLQB8mxBB7OEPhwa3YkLCK1kD3cOB9qJwlPQAj/DR0B4WXMr47R24hOiFQXBa2l+GO6Uij0XhRbD4MGGpbEy+yWZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mFZZY17X; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mFZZY17X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781511769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Eh/EXbfSgli/VtNqRSiq1G8g3cnusFdcmncTrvbgow=;
	b=mFZZY17XmQQGWBIxZrxZ3YDeiWHXTNNOEOJSvGyF4aj6tvSCyov3Q8pQy1sbcziDMSfz/V
	tWX4A75zhNxUwrZRB+hXLvQiUyI4KNFdkko+H9Q1+xN61yImEiYMvnX7SGhkjb+Iyqmg+h
	vnN4ZFR6Bn5tanjdl39W6cmuY21CgOE=
From: Tao Cui <cui.tao@linux.dev>
To: maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Cc: kernel@xen0n.name,
	kvm@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4 3/3] KVM: selftests: loongarch: Add PV TLB flush performance test
Date: Mon, 15 Jun 2026 16:21:54 +0800
Message-ID: <20260615082154.42144-4-cui.tao@linux.dev>
In-Reply-To: <20260615082154.42144-1-cui.tao@linux.dev>
References: <20260615082154.42144-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Add a multi-threaded benchmark to measure PV TLB flush performance
inside LoongArch KVM guests.

The test spawns flusher threads that repeatedly mmap/munmap to trigger
TLB shootdown IPIs, alongside idle threads that either sleep or
busy-spin. With PV TLB flush enabled, IPIs to preempted vCPUs are
replaced by deferred flags in the steal-time shared page.

Usage (inside guest):
  ./pv_tlb_flush_test <flushers> <idle> <iterations> <busy_idle>
  busy_idle=0: idle threads sleep (PV can skip IPIs to preempted vCPUs)
  busy_idle=1: idle threads spin (all vCPUs active, PV cannot optimize)

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 .../kvm/loongarch/pv_tlb_flush_test.c         | 194 ++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c

diff --git a/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
new file mode 100644
index 000000000000..63efaf9ef1cd
--- /dev/null
+++ b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * LoongArch PV TLB Flush Performance Test
+ *
+ * Measure the overhead of remote TLB flushes in a KVM guest by spawning
+ * flusher threads that repeatedly mmap/munmap (triggering TLB shootdown
+ * IPIs) alongside idle threads that either sleep or busy-spin.
+ *
+ * With PV TLB flush enabled, IPIs to preempted vCPUs are replaced by
+ * deferred flags in the steal-time shared page, reducing flush latency.
+ *
+ * Usage:
+ *   Compile on LoongArch guest:
+ *     gcc -O2 -static -pthread -o pv_tlb_flush_test pv_tlb_flush_test.c
+ *   Run (inside KVM guest):
+ *     ./pv_tlb_flush_test <flushers> <idle> <iterations> <busy_idle>
+ *   Examples:
+ *     ./pv_tlb_flush_test 1 31 50000 0   # 1 flusher, 31 sleep, PV helps
+ *     ./pv_tlb_flush_test 1 31 50000 1   # 1 flusher, 31 busy-spin, no PV
+ *
+ *   busy_idle=0: idle threads sleep, vCPUs get preempted, PV TLB flush
+ *                can skip IPIs to them
+ *   busy_idle=1: idle threads spin, all vCPUs stay active, PV TLB flush
+ *                cannot optimize (baseline for comparison)
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sched.h>
+#include <pthread.h>
+
+#define MEM_SIZE (2*1024*1024)
+#define DEFAULT_ITERS 50000
+#define MAX_THREADS 64
+
+static int nr_iters = DEFAULT_ITERS;
+static volatile int start_barrier;
+static volatile int stop_flag;
+static int busy_idle = 0;
+
+struct thread_args {
+	int cpu;
+	unsigned long *result;
+	int *completed;
+};
+
+static inline unsigned long clock_ns(void) {
+    struct timespec ts;
+    clock_gettime(CLOCK_MONOTONIC, &ts);
+    return (unsigned long)ts.tv_sec * 1000000000UL + ts.tv_nsec;
+}
+
+static void pin_cpu(int cpu) {
+    cpu_set_t set;
+    if (cpu < 0)
+        return;
+    CPU_ZERO(&set);
+    CPU_SET(cpu, &set);
+    sched_setaffinity(0, sizeof(set), &set);
+}
+
+static void *idle_thread(void *arg) {
+    struct thread_args *ta = arg;
+    pin_cpu(ta->cpu);
+    while (!__atomic_load_n(&start_barrier, __ATOMIC_ACQUIRE));
+    if (busy_idle) {
+        volatile long sink = 0;
+        while (!__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE))
+            sink++;
+    } else {
+        while (!__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE))
+            usleep(1000);
+    }
+    return NULL;
+}
+
+static void *flush_thread(void *arg) {
+    struct thread_args *ta = arg;
+    unsigned long start, end;
+    int i;
+    size_t mem_size = MEM_SIZE;
+    pin_cpu(ta->cpu);
+    while (!__atomic_load_n(&start_barrier, __ATOMIC_ACQUIRE));
+    start = clock_ns();
+    for (i = 0; i < nr_iters && !__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE); i++) {
+        void *p = mmap(NULL, mem_size, PROT_READ|PROT_WRITE,
+                       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+        if (p == MAP_FAILED) break;
+        for (size_t off = 0; off < mem_size; off += 65536)
+            ((volatile char*)p)[off] = 0;
+        munmap(p, mem_size);
+    }
+    end = clock_ns();
+    *ta->result = end - start;
+    *ta->completed = i;
+    return NULL;
+}
+
+int main(int argc, char **argv) {
+    int nr_flush = 1, nr_idle = 3, i, run;
+    int ncpus = sysconf(_SC_NPROCESSORS_ONLN);
+    if (argc > 1) nr_flush = atoi(argv[1]);
+    if (argc > 2) nr_idle = atoi(argv[2]);
+    if (argc > 3) nr_iters = atoi(argv[3]);
+    if (argc > 4) busy_idle = atoi(argv[4]);
+
+    if (nr_flush < 1 || nr_idle < 0 || nr_flush + nr_idle > MAX_THREADS) {
+        fprintf(stderr, "Usage: %s [flushers(1-%d)] [idle(0-%d)] [iters] [busy_idle]\n",
+                argv[0], MAX_THREADS, MAX_THREADS);
+        return 1;
+    }
+    if (nr_iters <= 0) {
+        fprintf(stderr, "Error: iterations must be positive\n");
+        return 1;
+    }
+
+    printf("=== TLB Flush Benchmark ===\n");
+    printf("CPUs: %d  Flushers: %d  Idle: %d  Iters: %d  Mode: %s\n",
+           ncpus, nr_flush, nr_idle, nr_iters,
+           busy_idle ? "busy-spin" : "sleep");
+
+    for (run = 0; run < 3; run++) {
+        int total = nr_flush + nr_idle;
+        int do_pin = (total <= ncpus);
+        int created = 0;
+        pthread_t threads[MAX_THREADS];
+        unsigned long results[MAX_THREADS];
+        int completed[MAX_THREADS];
+        struct thread_args args[MAX_THREADS];
+        start_barrier = 0; stop_flag = 0;
+
+        for (i = 0; i < nr_idle; i++) {
+            args[i].cpu = do_pin ? nr_flush + i : -1;
+            args[i].result = NULL;
+            args[i].completed = NULL;
+            if (pthread_create(&threads[i], NULL, idle_thread, &args[i])) {
+                perror("pthread_create idle");
+                goto cleanup;
+            }
+            created++;
+        }
+        for (i = 0; i < nr_flush; i++) {
+            int idx = nr_idle + i;
+            results[idx] = 0;
+            completed[idx] = 0;
+            args[idx].cpu = do_pin ? i : -1;
+            args[idx].result = &results[idx];
+            args[idx].completed = &completed[idx];
+            if (pthread_create(&threads[idx], NULL, flush_thread, &args[idx])) {
+                perror("pthread_create flush");
+                goto cleanup;
+            }
+            created++;
+        }
+
+        usleep(10000);
+        __atomic_store_n(&start_barrier, 1, __ATOMIC_RELEASE);
+        for (i = 0; i < nr_flush; i++)
+            pthread_join(threads[nr_idle + i], NULL);
+        __atomic_store_n(&stop_flag, 1, __ATOMIC_RELEASE);
+        for (i = 0; i < nr_idle; i++)
+            pthread_join(threads[i], NULL);
+
+        unsigned long total_ns = 0;
+        unsigned long total_done = 0;
+        for (i = 0; i < nr_flush; i++) {
+            int idx = nr_idle + i;
+            unsigned long done = completed[idx];
+            if (done == 0) {
+                printf("  Run %d flusher %d: no iterations completed\n", run, i);
+                continue;
+            }
+            printf("  Run %d flusher %d: %lu ns/flush (%lu iters)\n",
+                   run, i, results[idx] / done, done);
+            total_ns += results[idx];
+            total_done += done;
+        }
+        if (total_done > 0)
+            printf("  Run %d Avg: %lu ns/flush\n", run, total_ns / total_done);
+        continue;
+
+cleanup:
+        __atomic_store_n(&start_barrier, 1, __ATOMIC_RELEASE);
+        __atomic_store_n(&stop_flag, 1, __ATOMIC_RELEASE);
+        for (i = 0; i < created; i++)
+            pthread_join(threads[i], NULL);
+        return 1;
+    }
+    return 0;
+}
-- 
2.43.0

