Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122801FF5E3
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310064; cv=none; b=QlQqw7vnk24mJuiG0Bh6XXZWoSf8WK88VOIe+/4iRCD9nJQk+uHafF6ThVZr+JiiweJBqzaqafORayj3YpYcMXzPjC3BsDqEYbxCgm7ZHk9wXTAe9LVU1Oy4Q9l43BdAFD2/BL7Q6kYlv59B4dqTu9aFmzr3wHek/xFZgs0FDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310064; c=relaxed/simple;
	bh=dobb812CFa6AqbMlfIGYuplutzdEOys/WuG9iEFSsW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bs2nVFeMLBTrO0UzptCBgKBm8NNjjgPP7H67liez0Vm5jmg0wN9hhgjCyHhIKONMyK2jEVOSltfZ+6rN9TWOmzkMlXqTwWznMQ5bYGRSyYbhXisG8+KDFlEfVnlw1f75oiFuEBXa00AiemdE3c69tq0JcYSEmDpSrcS1Q6vsrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wR4oWUvN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wR4oWUvN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso36610965ad.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310055; x=1781914855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Of0+/OyjoX6CQ6jcUnUQyOfLggopCHteLCuLm5aJ7j0=;
        b=wR4oWUvN0lDirqGWAflMLA74ZLgYTe3F1s0/ec24SGizVWmtf8t0BjD8FBon7J8aQp
         XHl/ewfABb9XtD+7zgG5FNimw47FpSLyHnPLcEH3VtVFr7ixMm+uZPbRTwcB/Zxray3t
         UhlFMmSt60ENwKGFGZmRZp9Fb9qjyA+eDCcyfPVOg+MUVe0MPtrkyWfyBh6UXMTO8SSL
         QKlJjrC6xf0I25w+/wxWNkfDkDbU3rCJc9oBVQPREQr4dT1a1vEEoHXkbwiFyPJxtwAi
         v3QfF4A0noWYvwcyVIcyFeSW/zGkDh9UVeg1LipQdpDqDH8Aam3I+4eaMWKaMPpMriau
         VbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310055; x=1781914855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Of0+/OyjoX6CQ6jcUnUQyOfLggopCHteLCuLm5aJ7j0=;
        b=U13pkk0BsPeL8LUSO1DlnEYk29T6Qo8YwqRoJ0KNcsLbdTtl39MjaYoSvuFa3+qwp1
         tTuEcx54SYoZ9+AzFsRCSTGgbzvAESXn2j1VMPoffqFM55PopC2IHlgrA+wO6LWz6Ncj
         B0TMJNwif1oXbTEzQQyHFXDcUnFER7MFk646/M0L6rZvPWV0HwxNcoYXEskrT3yPBgr1
         D3rXjD6l7Ju2lEddnDtttzox17/bbFLeu1B6ysAGCAm03FREszHBuj+7QuswxALwadqL
         MeJRUf3Jf03xuMeYOkrQ7Hqf8M9HW2q4zLXoZmKxLrZ2MRUgjSI77lawEvjvnY81WcDI
         L87w==
X-Forwarded-Encrypted: i=1; AFNElJ9jWgbf/rnzDzaadlusMQDxwWSFallffhm801bOmRlu2VWn89Fo2wy4F4COpxCfDcHa5Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVjsC71ephk4hXJOSHLv/z4ddPEdFlZeHYGMOdR+qXtJc7JZJ
	Ldsemv1DuZ4vMpF8batTdz+Sr35X8In3z+FbHVRsvFpLQ4GvlwYPgnjjfCQKKzV/LMy/vUbIBpT
	RF8QZnw==
X-Received: from plfp3.prod.google.com ([2002:a17:902:e743:b0:2b2:a715:a848])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0e:b0:2c3:5683:9acb
 with SMTP id d9443c01a7336-2c412e2203emr57678865ad.32.1781310055345; Fri, 12
 Jun 2026 17:20:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:20:27 -0700
In-Reply-To: <20260613002031.745413-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613002031.745413-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613002031.745413-17-seanjc@google.com>
Subject: [PATCH v7 16/20] KVM: selftests: Add kvm_sched_getaffinity() wrapper
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
index 2e08d9fcefc7..9bf28b7d9d7a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -673,13 +673,12 @@ void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
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
2.54.0.1136.gdb2ca164c4-goog

