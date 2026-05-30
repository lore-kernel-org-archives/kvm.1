Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE4D1F3D56
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780100608; cv=none; b=SPME0oSOdGNb00Con3mrjoZMf20El68V/09Hsa1PqzBlT5E+kXbUY05EZ6WOPBJTjE8tJ5/pt+A4zphGXYmC8GUbXMDIYhasTjvwS5Dng7A/FsiCK/UKehykr//TLkSJO8ojX2uExAxgZRNMHOqlAIMGlm/vJpjqESOCsLyrPNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780100608; c=relaxed/simple;
	bh=e2ukZCOaE1hVDKiG2x+yhZ3ADBfa0ap4M2fqLVx6QTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGN2VsFkSkXpAldfm9e7gkhmtYlus8JLJh45glEEznWy6YLMQHZZtYr6uL2oxpVDZyj01CvPe965l2Y7EqsSXyP4/0qyde4Sm6DWeGHO2GerYcpMPvaLmGICtt9CZA8Q5LkGJKtwLeF/SfchAngthIVQI4sbxa97BV3ystI621o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cq42zjxZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cq42zjxZ"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf30576aa3so5109725ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780100606; x=1780705406; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5EgP5OPxH9Bs2ZhJ3J58MhczjNuI2GKmzjzYwdFlh+w=;
        b=Cq42zjxZBLrIMHdSPUoDCUXUcXcjHO1jL+E0AoeiFV9shxBrCHwMlSdBd4ZGF9YZFG
         JGVst1Cvl7507oQuX9q8UZSefNx9bXQt0/FvBEHS/dcmMfpEwlvrHRcVgxS9qYEBLs31
         0L5y1eIw9carfiR4BD6tQV9cmYAdXYnHrf2jO3SED6blQ4gifWhIBxs2yQOVVfrNcw7r
         Bezsn7ClTpEngeHgPuYTbLJ6eTEvFvGHSudP7XG4OB+fFIPHEVCCP56fYsrjHD9vWSWb
         utUyjuyn2G1zb+hqK5XKefZIS2Eczc+smcrYDp7UUuhhkpQY3PycoosK94SKa6hJICFG
         nfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780100606; x=1780705406;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EgP5OPxH9Bs2ZhJ3J58MhczjNuI2GKmzjzYwdFlh+w=;
        b=V1ytPVtTu8CaF0KFCOqUL+AdvPzA4xSQw4NzDqsJ//ynGxzSqEEwG+f31xfMZ3J1r/
         EdRG7t0qnJN9PMU6bDAscMXD/kaxhgBuc3/fl4Jd3Xb2TPCC+tWzojGYk91JZyeV7bZP
         lhKECG9HzLwoEyPHBXiYHINSHOUg10AZ5Wf0nsU7Fsm2xc2AMd+NQ4AC22MfE+3OmGbQ
         XDIr8wJVXhOb2oboConSIl/PfHGS5dXcg6QKN4il0fh+PDGYUSMUIXl7ffLDn/mJ1rxl
         l8l3M6mVX9D0WM57Eq1WNmN8x3baT4uegltkiQOeomJXvw1t/Nv29F6jbXGK0WP3ti8c
         Sr6A==
X-Gm-Message-State: AOJu0YzSBOXFhspDE5y0eEmE3CtQmD8Fad8eIcufQp49nzJeRY9fSJXn
	IH/ezkD4BHGhjEhgUw3XXIpax5/yKW6pMF5I39g01RL3DoGFhpWCg4A0p13qHTe/M7CXfki2BWM
	fvjmUPgbR
X-Received: from pgh1.prod.google.com ([2002:a05:6a02:4e01:b0:c82:7761:9940])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2b0c:b0:2bf:800:1a00
 with SMTP id d9443c01a7336-2bf3682a4a1mr25445155ad.22.1780100606193; Fri, 29
 May 2026 17:23:26 -0700 (PDT)
Date: Sat, 30 May 2026 00:21:28 +0000
In-Reply-To: <20260530002134.558837-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260530002134.558837-14-jrhilke@google.com>
Subject: [PATCH v4 13/19] KVM: selftests: Add kvm_gettid() wrapper and convert users
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a KVM wrapper for the gettid() syscall to avoid compilation errors
in versions of Glibc that don't contain gettid(). Convert existing users
of the syscall to use this new wrapper.

This helper will be used in a future change in the KVM IRQ test to
migrate vCPU threads.

No functional changes intended.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c   | 2 +-
 tools/testing/selftests/kvm/include/kvm_syscalls.h | 5 +++++
 tools/testing/selftests/kvm/lib/assert.c           | 8 ++------
 tools/testing/selftests/kvm/lib/test_util.c        | 3 ++-
 tools/testing/selftests/kvm/rseq_test.c            | 2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 0202b78f8680..4ebb2a9c3ba1 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -57,7 +57,7 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 static int handle_uffd_page_request(int uffd_mode, int uffd,
 		struct uffd_msg *msg)
 {
-	pid_t tid = syscall(__NR_gettid);
+	pid_t tid = kvm_gettid();
 	uint64_t addr = msg->arg.pagefault.address;
 	struct timespec start;
 	struct timespec ts_diff;
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d4e613162bba..522ffff0462c 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -73,6 +73,11 @@ static inline int kvm_dup(int fd)
 	return new_fd;
 }
 
+static inline pid_t kvm_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658c60..7914046d334d 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -10,6 +10,7 @@
 #include <sys/syscall.h>
 
 #include "kselftest.h"
+#include "kvm_syscalls.h"
 
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
@@ -58,11 +59,6 @@ static void test_dump_stack(void)
 #pragma GCC diagnostic pop
 }
 
-static pid_t _gettid(void)
-{
-	return syscall(SYS_gettid);
-}
-
 void __attribute__((noinline))
 test_assert(bool exp, const char *exp_str,
 	const char *file, unsigned int line, const char *fmt, ...)
@@ -75,7 +71,7 @@ test_assert(bool exp, const char *exp_str,
 		fprintf(stderr, "==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
 			"  pid=%d tid=%d errno=%d - %s\n",
-			file, line, exp_str, getpid(), _gettid(),
+			file, line, exp_str, getpid(), kvm_gettid(),
 			errno, strerror(errno));
 		test_dump_stack();
 		if (fmt) {
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index dc47ed9736e9..2006e46926d3 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -17,6 +17,7 @@
 #include "linux/kernel.h"
 
 #include "test_util.h"
+#include "kvm_syscalls.h"
 
 sigjmp_buf expect_sigbus_jmpbuf;
 
@@ -395,7 +396,7 @@ long get_run_delay(void)
 	long val[2];
 	FILE *fp;
 
-	sprintf(path, "/proc/%ld/schedstat", syscall(SYS_gettid));
+	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
 	fp = fopen(path, "r");
 	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
 	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) < 2)
diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index f80ad6b47d16..6510fbfd64f1 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -244,7 +244,7 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	pthread_create(&migration_thread, NULL, migration_worker,
-		       (void *)(unsigned long)syscall(SYS_gettid));
+		       (void *)(unsigned long)kvm_gettid());
 
 	if (latency >= 0) {
 		/*
-- 
2.54.0.929.g9b7fa37559-goog

