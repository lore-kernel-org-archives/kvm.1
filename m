Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218072E92B3
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052841; cv=none; b=u8rjq/Sp8CjCFva30W2bgyD4F7T6Zq9qkQ9gfHBAxbHZYGfEHFDi0HnYl/ueWkEjV2WcrwELJe9iYEgID5cajzi86IxXzNPD5TU9Csn9Uif2jhgnhRdcnatDOwThbcyblmDL7gSwf3kxJ2RPiZSlQBpCU5Erg4AP1D57S90BDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052841; c=relaxed/simple;
	bh=TF/7f1GoTDJgtPk44yqwmW7J2ephny2Ec/VMEg4h/4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDrPxhbEtgDoovgFxsklXzRHkUWD+XtTGamfDfyHEFiKFaiged2+C2jYlSZXWwCupGsFlCP4gOQYIsCBKYlsv1qtjVYMZ6zxtNY7JT0yDne9f6F4xPLAKq7n0WznCY9DrOpKiRFNMdxjdR26DaNm2mHmjllZsdGZqxCpW1lOGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TzEtMNEw; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TzEtMNEw"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f3e4728so4039918b3a.2
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052839; x=1781657639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8ZpcWMnVr5/m3HbsHebdKOhGRYEoJTay0WQIxFsC+10=;
        b=TzEtMNEw0P5oQSJUyrguYAGFLoFgUTycn3J9Ff4CobtGp55DTZFVR//77G1XcSxXzN
         bKMTqKQchJFfSq8LE3N4M6qXpj/h0BiOlJTvm9Fw1BhMK+qx1exWtsOP2ImzXW1WD+sV
         5apRyOmu18R5iGlunWD8E6C7Qcq5F8zebOn1YX17bkXQOS6+ORFAMrqZeQ2YlW0wE8C5
         xU7GkNSO34DxvvLXysY3aLwektvq8/V5DjpHm8w8bLQPVfI3+SXQg298+25cUGBHCvN0
         9gpdj/oEpjsIzZZ2Oktlc+zvCgUcJjr/R9o6r5KWxT7TB2FkPtinbrAwBe2dntBunVML
         gTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052839; x=1781657639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZpcWMnVr5/m3HbsHebdKOhGRYEoJTay0WQIxFsC+10=;
        b=gfB54Z1h4YJsJOtRxZeBQFIMJI4TuZQznOFUx4c8GCDMFiviJPH4Jw0Lq0ftWvvLHZ
         bQREy5wXEvvYd5rmy4fxUhCpk6C3aCiEuzIj7hu5HgbD4b1U7N25cg5Een0zx7eK5tmd
         +ec3ugxpexQJN2egRZZVjnxubkit43AXZMB/I2aVl357AndBhWpzhmV5UzpbW4/nat0L
         kypndFxmfG9pookOmXqirn5sTOyxdVzad+EokWnTiu81qj00JDIt4WisDXdouFWxSlWy
         2bXMzvSS5qTbjylPV2fsx1VtXm4DNjohczXbnCO36JgP0wZqVlmJ3c43OTjOyl3Y0jEM
         O7og==
X-Forwarded-Encrypted: i=1; AFNElJ93Cm181aRDEgprdSIaTiwBksvvXx7/lAlFZFC1E4DjZ8iXLf1nKC9/3KZ1Kd/dIZ6buOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mO5bSqIjg9JnZF6Oe33l7YPPD5z01w8oIowqlxwvnLhCzSSQ
	FsXpVzZ3yJxh1HCljEZJL0bV2fcjdcoa9hiuvjEmae0LQATw9HWLjxyP2RFTvpVG4HSMELsZGK4
	ioruQLw==
X-Received: from pfuj3.prod.google.com ([2002:a05:6a00:1303:b0:842:35ec:5b49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea9:b0:842:7a78:8f14
 with SMTP id d2e1a72fcca58-842b0f1f235mr20890818b3a.6.1781052839177; Tue, 09
 Jun 2026 17:53:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:34 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-15-seanjc@google.com>
Subject: [PATCH v6 14/18] KVM: selftests: Add kvm_sched_getaffinity() wrapper
 and convert users
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Josh Hilke <jrhilke@google.com>

Add and use a KVM wrapper for the sched_getaffinity() syscall so that
selftests don't need to manually assert that the syscall succeeded.

Note, some tests didn't actually assert success, but they all obviously
rely on the syscall to succeed.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/arch_timer.c                  | 2 +-
 tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c | 2 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h        | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c                | 5 ++---
 tools/testing/selftests/kvm/mmu_stress_test.c             | 6 +-----
 tools/testing/selftests/kvm/rseq_test.c                   | 4 +---
 6 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index 90c475a61b22..f8b02597897b 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -85,7 +85,7 @@ static u32 test_get_pcpu(void)
 	cpu_set_t online_cpuset;
 
 	nproc_conf = get_nprocs_conf();
-	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
+	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
 
 	/* Randomly find an available pCPU to place a vCPU on */
 	do {
diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index f7625eb711d6..d9c9377a6325 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -1039,7 +1039,7 @@ int main(int argc, char *argv[])
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
-	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+	kvm_sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
 	set_counter_defaults();
 
 	if (test_args.test_virtual) {
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index dc4fb97aef8d..5dae6143ddb0 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -12,6 +12,7 @@
 #include <sys/mman.h>
 #include <sys/syscall.h>
 
+#include <sched.h>
 #include <test_util.h>
 
 #define MAP_ARGS0(m,...)
@@ -93,6 +94,7 @@ __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
 __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
+__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #define kvm_free_fd(fd)		\
 do {				\
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 875030c22d07..92013883f35b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -668,13 +668,12 @@ void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 	cpu_set_t allowed_mask;
 	char *cpu, *cpu_list;
 	char delim[2] = ",";
-	int i, r;
+	int i;
 
 	cpu_list = strdup(pcpus_string);
 	TEST_ASSERT(cpu_list, "strdup() allocation failed.");
 
-	r = sched_getaffinity(0, sizeof(allowed_mask), &allowed_mask);
-	TEST_ASSERT(!r, "sched_getaffinity() failed");
+	kvm_sched_getaffinity(0, sizeof(allowed_mask), &allowed_mask);
 
 	cpu = strtok(cpu_list, delim);
 
diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 473ef4c0ea9f..3d5f33a63b2b 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -255,11 +255,7 @@ static void rendezvous_with_vcpus(struct timespec *time, const char *name)
 static void calc_default_nr_vcpus(void)
 {
 	cpu_set_t possible_mask;
-	int r;
-
-	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
-	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)",
-		    errno, strerror(errno));
+	kvm_sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 
 	nr_vcpus = CPU_COUNT(&possible_mask);
 	TEST_ASSERT(nr_vcpus > 0, "Uh, no CPUs?");
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index 6510fbfd64f1..557e393c223b 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -226,9 +226,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	r = sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
-	TEST_ASSERT(!r, "sched_getaffinity failed, errno = %d (%s)", errno,
-		    strerror(errno));
+	kvm_sched_getaffinity(0, sizeof(possible_mask), &possible_mask);
 
 	calc_min_max_cpu();
 
-- 
2.54.0.1099.g489fc7bff1-goog

