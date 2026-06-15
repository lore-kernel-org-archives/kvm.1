Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CCE261B9B
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515651; cv=none; b=ZHscbUlgFo2o0b15YOL70tZZDblDwPFrgbwmRl6Q9lnFExAVytDxj4xD0AGxdABLn7ny9/AfU1Orq4x0XlX4sd1p8bmKDJmL7Nl9VsjwEDAiP3icPubPSDGMv6Ap9yWdCk5yctjU2dwPOvHXZQtADy+pdBrJ+hq2dwU5UlhwP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515651; c=relaxed/simple;
	bh=H7EZwXgJEj3c9kVNVhT8VDDfokXTHcQRTwNK8adnCYQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fKbUKC9PSt02/yV5W3xFoh98UuM27y3OUGiewG73wKvDS2/iaDKhDQCN05R3DMSxfCxdjDjv1LCtgmQS/FnVT5mdxjfOk5bGPRVXjYDME6jucj87Pg/TZTOSzWJNQTjqZf0zhkcRJWM+8WHOvml9BsovS0GqvcDATPoDBkOJLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8Dxhul7xS9qwkoUAA--.53092S3;
	Mon, 15 Jun 2026 17:27:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxvsJ3xS9q8_ymAA--.54255S3;
	Mon, 15 Jun 2026 17:27:19 +0800 (CST)
Subject: Re: [PATCH v4 3/3] KVM: selftests: loongarch: Add PV TLB flush
 performance test
To: Tao Cui <cui.tao@linux.dev>, zhaotianrui@loongson.cn,
 chenhuacai@kernel.org, loongarch@lists.linux.dev
Cc: kernel@xen0n.name, kvm@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
References: <20260615082154.42144-1-cui.tao@linux.dev>
 <20260615082154.42144-4-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4efcc81b-bf7e-4d78-ba82-9f4590673486@loongson.cn>
Date: Mon, 15 Jun 2026 17:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260615082154.42144-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsJ3xS9q8_ymAA--.54255S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw43JrWrGrWxCFW5uw1xZwc_yoW3Gw17pF
	WYyasxKF4rXr17JrZ3XF1UJFn5uws7Xay3XFWayFyUAw4DGr15GrWfKFZYqan7u34kXr4f
	ur45ArnruFZrtagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4s2-UUUUU

Hi Tao,

Thanks for you patch.

Now LoongArch KVM is just workable and not used with wide scale, I am a 
little worried the stability of this PV feature.

Do you have real work load to show the benefits of the PV TLB flush, and 
which TLB APIs should be hooked.

Regards
Bibo Mao

On 2026/6/15 下午4:21, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> Add a multi-threaded benchmark to measure PV TLB flush performance
> inside LoongArch KVM guests.
> 
> The test spawns flusher threads that repeatedly mmap/munmap to trigger
> TLB shootdown IPIs, alongside idle threads that either sleep or
> busy-spin. With PV TLB flush enabled, IPIs to preempted vCPUs are
> replaced by deferred flags in the steal-time shared page.
> 
> Usage (inside guest):
>    ./pv_tlb_flush_test <flushers> <idle> <iterations> <busy_idle>
>    busy_idle=0: idle threads sleep (PV can skip IPIs to preempted vCPUs)
>    busy_idle=1: idle threads spin (all vCPUs active, PV cannot optimize)
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   .../kvm/loongarch/pv_tlb_flush_test.c         | 194 ++++++++++++++++++
>   1 file changed, 194 insertions(+)
>   create mode 100644 tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> 
> diff --git a/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> new file mode 100644
> index 000000000000..63efaf9ef1cd
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/loongarch/pv_tlb_flush_test.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * LoongArch PV TLB Flush Performance Test
> + *
> + * Measure the overhead of remote TLB flushes in a KVM guest by spawning
> + * flusher threads that repeatedly mmap/munmap (triggering TLB shootdown
> + * IPIs) alongside idle threads that either sleep or busy-spin.
> + *
> + * With PV TLB flush enabled, IPIs to preempted vCPUs are replaced by
> + * deferred flags in the steal-time shared page, reducing flush latency.
> + *
> + * Usage:
> + *   Compile on LoongArch guest:
> + *     gcc -O2 -static -pthread -o pv_tlb_flush_test pv_tlb_flush_test.c
> + *   Run (inside KVM guest):
> + *     ./pv_tlb_flush_test <flushers> <idle> <iterations> <busy_idle>
> + *   Examples:
> + *     ./pv_tlb_flush_test 1 31 50000 0   # 1 flusher, 31 sleep, PV helps
> + *     ./pv_tlb_flush_test 1 31 50000 1   # 1 flusher, 31 busy-spin, no PV
> + *
> + *   busy_idle=0: idle threads sleep, vCPUs get preempted, PV TLB flush
> + *                can skip IPIs to them
> + *   busy_idle=1: idle threads spin, all vCPUs stay active, PV TLB flush
> + *                cannot optimize (baseline for comparison)
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/mman.h>
> +#include <string.h>
> +#include <time.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <pthread.h>
> +
> +#define MEM_SIZE (2*1024*1024)
> +#define DEFAULT_ITERS 50000
> +#define MAX_THREADS 64
> +
> +static int nr_iters = DEFAULT_ITERS;
> +static volatile int start_barrier;
> +static volatile int stop_flag;
> +static int busy_idle = 0;
> +
> +struct thread_args {
> +	int cpu;
> +	unsigned long *result;
> +	int *completed;
> +};
> +
> +static inline unsigned long clock_ns(void) {
> +    struct timespec ts;
> +    clock_gettime(CLOCK_MONOTONIC, &ts);
> +    return (unsigned long)ts.tv_sec * 1000000000UL + ts.tv_nsec;
> +}
> +
> +static void pin_cpu(int cpu) {
> +    cpu_set_t set;
> +    if (cpu < 0)
> +        return;
> +    CPU_ZERO(&set);
> +    CPU_SET(cpu, &set);
> +    sched_setaffinity(0, sizeof(set), &set);
> +}
> +
> +static void *idle_thread(void *arg) {
> +    struct thread_args *ta = arg;
> +    pin_cpu(ta->cpu);
> +    while (!__atomic_load_n(&start_barrier, __ATOMIC_ACQUIRE));
> +    if (busy_idle) {
> +        volatile long sink = 0;
> +        while (!__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE))
> +            sink++;
> +    } else {
> +        while (!__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE))
> +            usleep(1000);
> +    }
> +    return NULL;
> +}
> +
> +static void *flush_thread(void *arg) {
> +    struct thread_args *ta = arg;
> +    unsigned long start, end;
> +    int i;
> +    size_t mem_size = MEM_SIZE;
> +    pin_cpu(ta->cpu);
> +    while (!__atomic_load_n(&start_barrier, __ATOMIC_ACQUIRE));
> +    start = clock_ns();
> +    for (i = 0; i < nr_iters && !__atomic_load_n(&stop_flag, __ATOMIC_ACQUIRE); i++) {
> +        void *p = mmap(NULL, mem_size, PROT_READ|PROT_WRITE,
> +                       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> +        if (p == MAP_FAILED) break;
> +        for (size_t off = 0; off < mem_size; off += 65536)
> +            ((volatile char*)p)[off] = 0;
> +        munmap(p, mem_size);
> +    }
> +    end = clock_ns();
> +    *ta->result = end - start;
> +    *ta->completed = i;
> +    return NULL;
> +}
> +
> +int main(int argc, char **argv) {
> +    int nr_flush = 1, nr_idle = 3, i, run;
> +    int ncpus = sysconf(_SC_NPROCESSORS_ONLN);
> +    if (argc > 1) nr_flush = atoi(argv[1]);
> +    if (argc > 2) nr_idle = atoi(argv[2]);
> +    if (argc > 3) nr_iters = atoi(argv[3]);
> +    if (argc > 4) busy_idle = atoi(argv[4]);
> +
> +    if (nr_flush < 1 || nr_idle < 0 || nr_flush + nr_idle > MAX_THREADS) {
> +        fprintf(stderr, "Usage: %s [flushers(1-%d)] [idle(0-%d)] [iters] [busy_idle]\n",
> +                argv[0], MAX_THREADS, MAX_THREADS);
> +        return 1;
> +    }
> +    if (nr_iters <= 0) {
> +        fprintf(stderr, "Error: iterations must be positive\n");
> +        return 1;
> +    }
> +
> +    printf("=== TLB Flush Benchmark ===\n");
> +    printf("CPUs: %d  Flushers: %d  Idle: %d  Iters: %d  Mode: %s\n",
> +           ncpus, nr_flush, nr_idle, nr_iters,
> +           busy_idle ? "busy-spin" : "sleep");
> +
> +    for (run = 0; run < 3; run++) {
> +        int total = nr_flush + nr_idle;
> +        int do_pin = (total <= ncpus);
> +        int created = 0;
> +        pthread_t threads[MAX_THREADS];
> +        unsigned long results[MAX_THREADS];
> +        int completed[MAX_THREADS];
> +        struct thread_args args[MAX_THREADS];
> +        start_barrier = 0; stop_flag = 0;
> +
> +        for (i = 0; i < nr_idle; i++) {
> +            args[i].cpu = do_pin ? nr_flush + i : -1;
> +            args[i].result = NULL;
> +            args[i].completed = NULL;
> +            if (pthread_create(&threads[i], NULL, idle_thread, &args[i])) {
> +                perror("pthread_create idle");
> +                goto cleanup;
> +            }
> +            created++;
> +        }
> +        for (i = 0; i < nr_flush; i++) {
> +            int idx = nr_idle + i;
> +            results[idx] = 0;
> +            completed[idx] = 0;
> +            args[idx].cpu = do_pin ? i : -1;
> +            args[idx].result = &results[idx];
> +            args[idx].completed = &completed[idx];
> +            if (pthread_create(&threads[idx], NULL, flush_thread, &args[idx])) {
> +                perror("pthread_create flush");
> +                goto cleanup;
> +            }
> +            created++;
> +        }
> +
> +        usleep(10000);
> +        __atomic_store_n(&start_barrier, 1, __ATOMIC_RELEASE);
> +        for (i = 0; i < nr_flush; i++)
> +            pthread_join(threads[nr_idle + i], NULL);
> +        __atomic_store_n(&stop_flag, 1, __ATOMIC_RELEASE);
> +        for (i = 0; i < nr_idle; i++)
> +            pthread_join(threads[i], NULL);
> +
> +        unsigned long total_ns = 0;
> +        unsigned long total_done = 0;
> +        for (i = 0; i < nr_flush; i++) {
> +            int idx = nr_idle + i;
> +            unsigned long done = completed[idx];
> +            if (done == 0) {
> +                printf("  Run %d flusher %d: no iterations completed\n", run, i);
> +                continue;
> +            }
> +            printf("  Run %d flusher %d: %lu ns/flush (%lu iters)\n",
> +                   run, i, results[idx] / done, done);
> +            total_ns += results[idx];
> +            total_done += done;
> +        }
> +        if (total_done > 0)
> +            printf("  Run %d Avg: %lu ns/flush\n", run, total_ns / total_done);
> +        continue;
> +
> +cleanup:
> +        __atomic_store_n(&start_barrier, 1, __ATOMIC_RELEASE);
> +        __atomic_store_n(&stop_flag, 1, __ATOMIC_RELEASE);
> +        for (i = 0; i < created; i++)
> +            pthread_join(threads[i], NULL);
> +        return 1;
> +    }
> +    return 0;
> +}
> 

