Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707991F3D56
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100610; cv=none; b=roUJXg6RMQ96pJujG4QHDHlPDSDjOE2bBpg5m8UNer5HZlsrW3ONMFhJaHHPWsii9Aa9eKC1OmhkLckl3pKhGjvcphXURNDOy7eBJtHBIubP5AuWqFtrJ38C86XS/+sxuhWKvS3IhBk+bkgJ1fGK8T7ntHpviG0rLwlobXGp9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100610; c=relaxed/simple;
	bh=sFiyZUNppJvupkfg1Y319YjkFu4NJ8Q99u8ITtvADpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nfB7nXyLl4MH+hvNeoUtgd8eA7YmHnQXyzDwmE+AuIuhv309jOu/BBGLPyUFekk7gSkM2rj4IGTPN3Y2wD19xb0HO+womBg8gGKMjALg9ngCqN4Cugb3k18cQnwNu9/8y/KgEpoW1iqRqbSHDvVJvB3U+c0aTFOIcxxphW8S+Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gnuC5wc4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnuC5wc4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so13198093a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100609; x=1780705409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwK+oHR7LpIedlIX8UM2oEn2HzPBvHfoG9vzzz2iSsE=;
        b=gnuC5wc4ah2RwIGYlPwR/49oOkA6eJIbPANHUFP6PhbsbAJoJXWCsCbgVhyrvVlFfk
         /dAVGpKTF1knkCt2wiK1mzv8hD0rwhtxlb8QgJ6VKZ2TTKLBBcTPuJ4QsFKjUqPgi77A
         iZTpXdoU9UazBXiMWGFfX2JNEovyYhXPTia664Tf2Xq1TrvRq6YNFRgPx/JKb/ZKYTuM
         jVeElKJw1WS5FaOQ9rqJApBcL0gtwgqgoj1cad53wiBFgNTG4SewQBDvTuKny0fYS8mu
         we9UOIHxKQY7iH2ZZMvqqTtNItrER8CkvPfXNEqV1nMdErpiqIDHik/EYwClsAKORGhX
         PH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100609; x=1780705409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwK+oHR7LpIedlIX8UM2oEn2HzPBvHfoG9vzzz2iSsE=;
        b=M9qybN9AjFHeXUrxT/YVB27p/LBw/xYy/wy9kzoIEsh2twLm4JLLHzsv+RTOEGVT1C
         9mp0KMNXJk8YBlFng5Yt415SND7FyQaj/HKB/iPber9mdEgpmmRQ3Ircv2w0Nee+1qRd
         umsL6UEi/e/m29f/jGcFQ/eZEaso4Bs40Wp5dcG7g4yop5MKG+YcuvegkrzOGlKlhdoQ
         RLiSKZnkDgKOhcUig7uSI1unAq3h1wSnP+ZNN8kPWmmSxLV9fjzMRmqorRqyR+HNRos4
         gA6Ldd08/O/+dpA/F5L2ckgxcB3ezh3PIa7e+53kMbHqNF4SKF0Hnj8S2eeORDDiIZ63
         1XcA==
X-Gm-Message-State: AOJu0YzETYYZIqYleQxePElvvmkkKKwOCDQshdcQ5fpGByVsWz7OAw0h
	pank3nvaJBj/qXUda1C93TAZUNmvEXCuJIVDu6zwz1Q2J0GKWxDvjKVanviCWvne4Wr9ivNbuYR
	+PzNfFADa
X-Received: from pgbdr23.prod.google.com ([2002:a05:6a02:fd7:b0:c82:35ce:8939])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c6ca:b0:3b2:86c9:baa5
 with SMTP id adf61e73a8af0-3b427f59c8fmr1574170637.38.1780100608073; Fri, 29
 May 2026 17:23:28 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:29 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-15-jrhilke@google.com>
Subject: [PATCH v4 14/19] KVM: selftests: Add kvm_sched_getaffinity() wrapper
 and convert users
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
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
 tools/testing/selftests/kvm/include/kvm_syscalls.h        | 1 +
 tools/testing/selftests/kvm/lib/kvm_util.c                | 5 ++---
 tools/testing/selftests/kvm/mmu_stress_test.c             | 6 +-----
 tools/testing/selftests/kvm/rseq_test.c                   | 4 +---
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/arch_timer.c b/tools/testing/selftests/kvm/arch_timer.c
index cf8fb67104f1..e4289800f432 100644
--- a/tools/testing/selftests/kvm/arch_timer.c
+++ b/tools/testing/selftests/kvm/arch_timer.c
@@ -85,7 +85,7 @@ static uint32_t test_get_pcpu(void)
 	cpu_set_t online_cpuset;
 
 	nproc_conf = get_nprocs_conf();
-	sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
+	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &online_cpuset);
 
 	/* Randomly find an available pCPU to place a vCPU on */
 	do {
diff --git a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
index 993c9e38e729..c7fd601566c1 100644
--- a/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
+++ b/tools/testing/selftests/kvm/arm64/arch_timer_edge_cases.c
@@ -1040,7 +1040,7 @@ int main(int argc, char *argv[])
 	if (!parse_args(argc, argv))
 		exit(KSFT_SKIP);
 
-	sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
+	kvm_sched_getaffinity(0, sizeof(default_cpuset), &default_cpuset);
 	set_counter_defaults();
 
 	if (test_args.test_virtual) {
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index 522ffff0462c..2e362fda50af 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -82,5 +82,6 @@ __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
+__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b247b2015b2a..ebd04cf1847b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -668,13 +668,12 @@ void kvm_parse_vcpu_pinning(const char *pcpus_string, uint32_t vcpu_to_pcpu[],
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
index a9fac4bc02c2..98546edbf11b 100644
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
2.54.0.929.g9b7fa37559-goog

