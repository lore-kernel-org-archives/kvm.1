Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AD3438A3
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538568; cv=none; b=VXpGUoKdUzZi2xqyPk8huxO2K5qOqB4iayLBu13zb/cm8RIl4lKfbzqGUqOXL2xk0e0LwpSf/bWSQIp40oxlqzaEi/sKLQ4jFgKb7TpQJAjp/FMM7jxnFfd0ahVJ+AkVU4nHQCVx3Tdf6Yl0BrB+TaJIR+xFBs/4M2MqxPfEeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538568; c=relaxed/simple;
	bh=Tmq3ikjfX2IvEobDHt7oddZb9hop4sb5bX8l2Qsy2YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dON5PdR+Ao5oHZ3u9Duy4Zza489acoSVvgJdhhA6u4Tsf40BhoeARRA1uUAeev/iFgdMb7gAZISO71Zd7A5QLWZnlpjTXyPFrHH02mjcdz9ZSReOA9rdH6dMvKh7w4bjntSguUOFXjsMmi/H/Ahn1fmhwThnp/ERYfHRHWrMeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DpcJvbcB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DpcJvbcB"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c850ff84ddfso254120a12.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538565; x=1781143365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAgDySiCq7cDdYA1GOoaBCXyUElvHMmMLGpEHQQY0Fw=;
        b=DpcJvbcBljEsoyKyNlHCyC7hdwWYriSI07QUWKgu98OIhhcrM4JgQ+IdlK1rA/wp5F
         71H+Awg4bmEO8RYJtUs5aKa0Sm1mLxK34xCclyiPPpV20mLVaG8uzsrZXHcCGoHXWyCI
         ATbM2luuX5mnSbZqN8XyDjMb2sQsCtDF0S2sq3jqZoP8+DRTOP2xD3nlcIcTVts+SMv6
         1hR3Rv/90KRt6+xQhFS7KaiXx4SAxqj7/KYmceRxhxCyMTxJzUTdthj+GZgmaSK/olAj
         x6K8rbvVMrKDRPp21Id0ZgUPvvpnAJt7aWEnU6+FXfnYDvYcworCsZ7VwHtdW+TTvV4p
         YFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538565; x=1781143365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VAgDySiCq7cDdYA1GOoaBCXyUElvHMmMLGpEHQQY0Fw=;
        b=VE8uE7uysCPAWRciShUrvgiG8e7w4xvEQm7+7S8cQGiRMVL0cqaDj+C3rd5gkMom8t
         fWDPugjm2dd3hJ7qvJKJRRDAl3SFbtifLiacHBjNvEumTJyPy6ryDPBE2fcN6mfaQ0KD
         Cb51tFBRGtdMDjx1p7QS4c4RGFRdaApfMMjnF9NIbpvkqkBuFjo0BMVm6LSGn8CHzaoB
         UQlj4KZfk/IHdTkYIfinSc+9rSesNCZcPR1jIGDOJKwr5pTccSJSvMvluT4IwrDzS6Cc
         wyFfCE07dV/3xyUyHQmCzfGyeNL4lKntvJthv+3UDYFilRw1d4WNfNWk2xbuLlof+2do
         M9Nw==
X-Gm-Message-State: AOJu0YwtgLFntfK7P74D/Z9Zt2PR9Amb4zwzoDhH5s2aS08ud42f7wm5
	/Bpyu2THtB498pvsZ511Ph2uKQi1pZobhNgX0gMMSZ496k67PZYD0xqFtDOPFXbOkuoTp4Kqh6M
	hI6BPUlNL
X-Received: from pgc24.prod.google.com ([2002:a05:6a02:2f98:b0:c80:192c:51ff])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:50e:b0:3b4:736b:da61
 with SMTP id adf61e73a8af0-3b49790c56cmr6485908637.35.1780538564662; Wed, 03
 Jun 2026 19:02:44 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:38 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-17-jrhilke@google.com>
Subject: [PATCH v5 16/21] KVM: selftests: Add kvm_sched_getaffinity() wrapper
 and convert users
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a KVM wrapper for the sched_getaffinity syscall named
kvm_sched_getaffinity(). Convert existing users of sched_getaffinity to
use the new wrapper.

This helper will be used in a future change in the KVM IRQ test to
migrate vCPU threads.

No functional changes intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
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
index e4731741373e..b02a860b5680 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -10,6 +10,7 @@
 #include <linux/mman.h>
 
 #include <sys/mman.h>
+#include <sched.h>
 #include <sys/syscall.h>
 
 #include <test_util.h>
@@ -93,5 +94,6 @@ __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
 __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
+__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 2d24d8db86b1..0089d4543f5e 100644
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
2.54.0.1032.g2f8565e1d1-goog

