Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312F3CBE79
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792721; cv=none; b=Iq+QES8xFuRXjs/IM6LF9pG2vs1iyGEdqKOfKYrX8oykJfk+I50qCbSvQwYAhEI3fLHQZ/xW00KH5YOsQaS3+s1lL/I5Eu5pWB/Aebegfksbw9vq8QX3RmaUMk9uefbHGBe02QdbUw/miDqIYF9a9bo6/TeCizDrjzQE/gzFrWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792721; c=relaxed/simple;
	bh=wROWXw/L1fbFPvvKV3Qc1kOJ3ucw62TXE0wayD8omYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nVcBrRwMsUhGfS8H3iS4N2LeuAvsxiw2A3AXjww9RPZrpdtZBT4x7QBums8K4bl2hGDCoRGaW2b4czscryDntCc8PCRQFlbXbsA3CJQWmzFahfBPdfVTQnnUmFGi4Mq6h+TQMr7+b2ZQr4daAQejA3EBeEgph2uXuagZ773nb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jx+FnpnT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jx+FnpnT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8276c91addso3500129a12.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792719; x=1779397519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=sCXxRb1vMVGfy+jWVYyoIdWhH/vbIL/ZMoB9EKMl9Mw=;
        b=jx+FnpnT8RkvPNweibhd8vEtZBKlVcpgWrqBK7kIpYnMKQ7FaU4GVRRb8gBzmd0WuX
         HMDQ7Hpjff0mktlgV32jbS9FUFhbO6a5ZI072aMYbvDKNfsbNtQh1WG864JeLmYdd7lA
         m/H4YXnMKPqNrnDxgPvCJpgyhz+I1wR1jBsJyqwK1UsAD/OSLiT4JizInUWVmQmTboPp
         Se5t/Xlu9YXYboU29+MqC7wnVC+KGrl6yPGEB0k/3a48BhBGl0x685HVGxkuhCz9UE41
         DIIDuiAwP2kF7+ESQCaCw+eqPPRiGNYzdWOwh9Vlr4ENGooUv8Q7z4XjKRUGLLHS0tkG
         3wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792719; x=1779397519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCXxRb1vMVGfy+jWVYyoIdWhH/vbIL/ZMoB9EKMl9Mw=;
        b=KxPZ0DIN2jQXrSF1Wlg6pxEXcQIDvhT2SQ0r3LTanIqH3ImZqa/GDVitBDdThqB958
         yMgaOqyne27NgtXyeDcnbSEdqhqHvoPZ6wMvHsR/JpgI5QlE1VQL6H6Qb1HsmA3taTD2
         ibwyn6bH5rtcvTDyjIft8Kji2yLlIQW8D7iEhbQdAlET8IR5BNy410kPTuMWVTDbIxkn
         AlI8P6lQSAKX0nB6/LLmbhyWytvGgKaAYSYr+e19aJnmNnCshKYCfnfK4Ue3pzRKEjWk
         WgHcHzI5ArOrMJwXGZBI29zNShV2KqisPsyLBcRV8omtul07Bz8OAilmHyCKg+D59+0h
         nRAg==
X-Gm-Message-State: AOJu0YwA/A8piYJuDpB+a3qgptXiaiRGhGT0PXvKYWYuADMi+HvAbuiv
	m7NDJdhoiMriAWWFHWv0dQNUbl7oSA4d0fwnR8nP/UmY+voFPjkCfuV0dHjX0KjP4XoLsUuWziA
	moVx2mQ==
X-Received: from pgbcs10.prod.google.com ([2002:a05:6a02:418a:b0:c61:35ea:4553])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7294:b0:3a2:f7bd:a9a5
 with SMTP id adf61e73a8af0-3b22ec73c64mr878965637.38.1778792718795; Thu, 14
 May 2026 14:05:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:54 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-15-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 14/20] x86/kvmclock: Replace spaces with tabs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Replace (8) spaces with tabs in the kvmclock code so that upcoming changes
don't propagate the antiquated formatting.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/kvmclock.c      |  42 ++++-----
 x86/kvmclock_test.c | 218 ++++++++++++++++++++++----------------------
 2 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/x86/kvmclock.c b/x86/kvmclock.c
index f9f21032..ea9c0e7e 100644
--- a/x86/kvmclock.c
+++ b/x86/kvmclock.c
@@ -56,7 +56,7 @@ static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
 # define do_div(n,base) ({					\
 	u32 __base = (base);    				\
 	u32 __rem;						\
-	__rem = ((u64)(n)) % __base;                            \
+	__rem = ((u64)(n)) % __base;			    \
 	(n) = ((u64)(n)) / __base;				\
 	__rem;							\
  })
@@ -194,9 +194,9 @@ static cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	} while (pvclock_read_retry(src, version));
 
 	if ((valid_flags & PVCLOCK_RAW_CYCLE_BIT) ||
-            ((valid_flags & PVCLOCK_TSC_STABLE_BIT) &&
-             (flags & PVCLOCK_TSC_STABLE_BIT)))
-                return ret;
+	    ((valid_flags & PVCLOCK_TSC_STABLE_BIT) &&
+	     (flags & PVCLOCK_TSC_STABLE_BIT)))
+		return ret;
 
 	/*
 	 * Assumption here is that last_value, a global accumulator, always goes
@@ -224,27 +224,27 @@ static cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 
 cycle_t kvm_clock_read(void)
 {
-        struct pvclock_vcpu_time_info *src;
-        cycle_t ret;
-        int index = smp_id();
+	struct pvclock_vcpu_time_info *src;
+	cycle_t ret;
+	int index = smp_id();
 
-        src = &hv_clock[index];
-        ret = pvclock_clocksource_read(src);
-        return ret;
+	src = &hv_clock[index];
+	ret = pvclock_clocksource_read(src);
+	return ret;
 }
 
 void kvm_clock_init(void *data)
 {
-        int index = smp_id();
-        struct pvclock_vcpu_time_info *hvc = &hv_clock[index];
+	int index = smp_id();
+	struct pvclock_vcpu_time_info *hvc = &hv_clock[index];
 
-        printf("kvm-clock: cpu %d, msr %p\n", index, hvc);
-        wrmsr(MSR_KVM_SYSTEM_TIME_NEW, (unsigned long)hvc | 1);
+	printf("kvm-clock: cpu %d, msr %p\n", index, hvc);
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, (unsigned long)hvc | 1);
 }
 
 void kvm_clock_clear(void *data)
 {
-        wrmsr(MSR_KVM_SYSTEM_TIME_NEW, 0LL);
+	wrmsr(MSR_KVM_SYSTEM_TIME_NEW, 0LL);
 }
 
 static void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
@@ -275,15 +275,15 @@ static void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 
 void kvm_get_wallclock(struct timespec *ts)
 {
-        struct pvclock_vcpu_time_info *vcpu_time;
-        int index = smp_id();
+	struct pvclock_vcpu_time_info *vcpu_time;
+	int index = smp_id();
 
-        wrmsr(MSR_KVM_WALL_CLOCK_NEW, (unsigned long)&wall_clock);
-        vcpu_time = &hv_clock[index];
-        pvclock_read_wallclock(&wall_clock, vcpu_time, ts);
+	wrmsr(MSR_KVM_WALL_CLOCK_NEW, (unsigned long)&wall_clock);
+	vcpu_time = &hv_clock[index];
+	pvclock_read_wallclock(&wall_clock, vcpu_time, ts);
 }
 
 void pvclock_set_flags(unsigned char flags)
 {
-        valid_flags = flags;
+	valid_flags = flags;
 }
diff --git a/x86/kvmclock_test.c b/x86/kvmclock_test.c
index de4b5e13..d21c6c72 100644
--- a/x86/kvmclock_test.c
+++ b/x86/kvmclock_test.c
@@ -12,144 +12,144 @@ long sec = 0;
 long threshold = DEFAULT_THRESHOLD;
 
 struct test_info {
-        struct spinlock lock;
-        u64 warps;                /* warp count */
-        u64 stalls;               /* stall count */
-        long long worst;          /* worst warp */
-        volatile cycle_t last;    /* last cycle seen by test */
-        int check;                /* check cycle ? */
+	struct spinlock lock;
+	u64 warps;		/* warp count */
+	u64 stalls;		/* stall count */
+	long long worst;	/* worst warp */
+	volatile cycle_t last;	/* last cycle seen by test */
+	int check;		/* check cycle ? */
 };
 
 struct test_info ti[4];
 
 static void wallclock_test(void *data)
 {
-        int *p_err = data;
-        long ksec, offset;
-        struct timespec ts;
+	int *p_err = data;
+	long ksec, offset;
+	struct timespec ts;
 
-        kvm_get_wallclock(&ts);
-        ksec = ts.tv_sec;
+	kvm_get_wallclock(&ts);
+	ksec = ts.tv_sec;
 
-        offset = ksec - sec;
-        printf("Raw nanoseconds value from kvmclock: %" PRIu64 " (cpu %d)\n", kvm_clock_read(), smp_id());
-        printf("Seconds get from kvmclock: %ld (cpu %d, offset: %ld)\n", ksec, smp_id(), offset);
+	offset = ksec - sec;
+	printf("Raw nanoseconds value from kvmclock: %" PRIu64 " (cpu %d)\n", kvm_clock_read(), smp_id());
+	printf("Seconds get from kvmclock: %ld (cpu %d, offset: %ld)\n", ksec, smp_id(), offset);
 
-        if (offset > threshold || offset < -threshold) {
-                printf("offset too large!\n");
-                (*p_err)++;
-        }
+	if (offset > threshold || offset < -threshold) {
+		printf("offset too large!\n");
+		(*p_err)++;
+	}
 }
 
 static void kvm_clock_test(void *data)
 {
-        struct test_info *hv_test_info = (struct test_info *)data;
-        long i, check = hv_test_info->check;
+	struct test_info *hv_test_info = (struct test_info *)data;
+	long i, check = hv_test_info->check;
 
-        for (i = 0; i < loops; i++){
-                cycle_t t0, t1;
-                long long delta;
+	for (i = 0; i < loops; i++){
+		cycle_t t0, t1;
+		long long delta;
 
-                if (check == 0) {
-                        kvm_clock_read();
-                        continue;
-                }
+		if (check == 0) {
+			kvm_clock_read();
+			continue;
+		}
 
-                spin_lock(&hv_test_info->lock);
-                t1 = kvm_clock_read();
-                t0 = hv_test_info->last;
-                hv_test_info->last = kvm_clock_read();
-                spin_unlock(&hv_test_info->lock);
+		spin_lock(&hv_test_info->lock);
+		t1 = kvm_clock_read();
+		t0 = hv_test_info->last;
+		hv_test_info->last = kvm_clock_read();
+		spin_unlock(&hv_test_info->lock);
 
-                delta = t1 - t0;
-                if (delta < 0) {
-                        spin_lock(&hv_test_info->lock);
-                        ++hv_test_info->warps;
-                        if (delta < hv_test_info->worst){
-                                hv_test_info->worst = delta;
-                                printf("Worst warp %lld\n", hv_test_info->worst);
-                        }
-                        spin_unlock(&hv_test_info->lock);
-                }
-                if (delta == 0)
-                        ++hv_test_info->stalls;
+		delta = t1 - t0;
+		if (delta < 0) {
+			spin_lock(&hv_test_info->lock);
+			++hv_test_info->warps;
+			if (delta < hv_test_info->worst){
+				hv_test_info->worst = delta;
+				printf("Worst warp %lld\n", hv_test_info->worst);
+			}
+			spin_unlock(&hv_test_info->lock);
+		}
+		if (delta == 0)
+			++hv_test_info->stalls;
 
-                if (!((unsigned long)i & 31))
-                        asm volatile("rep; nop");
-        }
+		if (!((unsigned long)i & 31))
+			asm volatile("rep; nop");
+	}
 }
 
 static int cycle_test(int check, struct test_info *ti)
 {
-        unsigned long long begin, end;
+	unsigned long long begin, end;
 
-        begin = rdtsc();
+	begin = rdtsc();
 
-        ti->check = check;
-        on_cpus(kvm_clock_test, ti);
+	ti->check = check;
+	on_cpus(kvm_clock_test, ti);
 
-        end = rdtsc();
+	end = rdtsc();
 
-        printf("Total vcpus: %d\n", cpu_count());
-        printf("Test  loops: %ld\n", loops);
-        if (check == 1) {
-                printf("Total warps:  %" PRId64 "\n", ti->warps);
-                printf("Total stalls: %" PRId64 "\n", ti->stalls);
-                printf("Worst warp:   %lld\n", ti->worst);
-        } else
-                printf("TSC cycles:  %lld\n", end - begin);
+	printf("Total vcpus: %d\n", cpu_count());
+	printf("Test  loops: %ld\n", loops);
+	if (check == 1) {
+		printf("Total warps:  %" PRId64 "\n", ti->warps);
+		printf("Total stalls: %" PRId64 "\n", ti->stalls);
+		printf("Worst warp:   %lld\n", ti->worst);
+	} else
+		printf("TSC cycles:  %lld\n", end - begin);
 
-        return ti->warps ? 1 : 0;
+	return ti->warps ? 1 : 0;
 }
 
 int main(int ac, char **av)
 {
-        int nerr = 0;
-        int ncpus;
-        int i;
-
-        if (ac > 1)
-                loops = atol(av[1]);
-        if (ac > 2)
-                sec = atol(av[2]);
-        if (ac > 3)
-                threshold = atol(av[3]);
-
-        ncpus = cpu_count();
-        if (ncpus > MAX_CPU)
-                report_abort("number cpus exceeds %d", MAX_CPU);
-
-        on_cpus(kvm_clock_init, NULL);
-
-        if (ac > 2) {
-                printf("Wallclock test, threshold %ld\n", threshold);
-                printf("Seconds get from host:     %ld\n", sec);
-                for (i = 0; i < ncpus; ++i)
-                        on_cpu(i, wallclock_test, &nerr);
-        }
-
-        printf("Check the stability of raw cycle ...\n");
-        pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT
-                          | PVCLOCK_RAW_CYCLE_BIT);
-        if (cycle_test(1, &ti[0]))
-                printf("Raw cycle is not stable\n");
-        else
-                printf("Raw cycle is stable\n");
-
-        pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
-        printf("Monotonic cycle test:\n");
-        nerr += cycle_test(1, &ti[1]);
-
-        printf("Measure the performance of raw cycle ...\n");
-        pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT
-                          | PVCLOCK_RAW_CYCLE_BIT);
-        cycle_test(0, &ti[2]);
-
-        printf("Measure the performance of adjusted cycle ...\n");
-        pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
-        cycle_test(0, &ti[3]);
-
-        on_cpus(kvm_clock_clear, NULL);
-
-        return nerr > 0 ? 1 : 0;
+	int nerr = 0;
+	int ncpus;
+	int i;
+
+	if (ac > 1)
+		loops = atol(av[1]);
+	if (ac > 2)
+		sec = atol(av[2]);
+	if (ac > 3)
+		threshold = atol(av[3]);
+
+	ncpus = cpu_count();
+	if (ncpus > MAX_CPU)
+		report_abort("number cpus exceeds %d", MAX_CPU);
+
+	on_cpus(kvm_clock_init, NULL);
+
+	if (ac > 2) {
+		printf("Wallclock test, threshold %ld\n", threshold);
+		printf("Seconds get from host:     %ld\n", sec);
+		for (i = 0; i < ncpus; ++i)
+			on_cpu(i, wallclock_test, &nerr);
+	}
+
+	printf("Check the stability of raw cycle ...\n");
+	pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT
+			  | PVCLOCK_RAW_CYCLE_BIT);
+	if (cycle_test(1, &ti[0]))
+		printf("Raw cycle is not stable\n");
+	else
+		printf("Raw cycle is stable\n");
+
+	pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
+	printf("Monotonic cycle test:\n");
+	nerr += cycle_test(1, &ti[1]);
+
+	printf("Measure the performance of raw cycle ...\n");
+	pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT
+			  | PVCLOCK_RAW_CYCLE_BIT);
+	cycle_test(0, &ti[2]);
+
+	printf("Measure the performance of adjusted cycle ...\n");
+	pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
+	cycle_test(0, &ti[3]);
+
+	on_cpus(kvm_clock_clear, NULL);
+
+	return nerr > 0 ? 1 : 0;
 }
-- 
2.54.0.563.g4f69b47b94-goog

