Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF7D330646
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780538567; cv=none; b=Yul9IgglBRbP3YipT4VVJFjFNNPbZkdljZHS3P7d6OFSgpreVucQp9lgtkDktZjRGg2ikV8GZ5sRfLMObkyTj24Y+I+/ZLPIaMXA42RSyUvoath9tpmiv0BLa0tcTgUWJ3oATojwQN/B1UizsEtAgzUBiwYtkaQPoQ1/fpj+BQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780538567; c=relaxed/simple;
	bh=QhhAmSqoPpHT6Fc6XlKDIK5Xihuk7/jRSy7HRwPriB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VB0R0VGxdjNFXuHCStfGV3neBYajbg89pPo0uPOtd9o/rQ1krBg+DTivNsmDMV9GDS2tJ8qcxTETWAMuZWWG4LPWQW6uP1CFtqfxGuamolLL+JFvJZacq4LdgdfdKu2pPzUVRtzVIXmho9SvwLKOWFT+kl9RAhlnzn2XFUU/XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I9gi5ANP; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9gi5ANP"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c10cd7df22so3374705ad.2
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 19:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780538564; x=1781143364; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4MH394H3rFgdkGclrrJ7AlM8yZjDGqTeBC6SyP9lSo=;
        b=I9gi5ANPj8xG2cdVV8azN2+cwnYtuubKSiouj3eF4ZPc7ovcmbv0zR+rJIXqF3xb2m
         +l6D+Ir3iJ0g94HRUrSv0HIpWNve/4ko+caajGCASzjrVRSosmZfiLWCmbWPNQuwfrrT
         L5GIU+opUpoYpejUm6JotNEJ6abdEfcR8uX3k3Z+bd1tTKEVrlyAzvITbng6eegpocPf
         QimCKRxyeHcZlRS9BojuU3QYyqRM29xuVPp2tVGQM0cLntHm25r5CkNwrzE0csa8yQWR
         3XXMyU/OYg5B8a9yTK7mdcFfL3YKx3ekIy8m080+ErsLsl1P81VKeD79Bhul4ayoyza+
         b+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780538564; x=1781143364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4MH394H3rFgdkGclrrJ7AlM8yZjDGqTeBC6SyP9lSo=;
        b=nW+Xmo95sjxOUDOnPgPUy3V+EHpaairplQKQnN7TgvjT1sXzY88kHWi3MNypKJEcxH
         DT69efv2+mya0b3fHZUq0eC9gs06xKW0XPcasy0+rLFdsMbWntYa0gbyoII9pgQteIAi
         1JuTMPr50K2ei+Vai8bB9R8qRfMEQx7MUO8L65+nMlkAsVH0WabLFPCtegunB27F6pGr
         sHuq0FdLFMiLboty7LHZj3p8dvp7LzfIGGK4E3zfHZEtkkJBb+sjXAfUPO6xIs2nvBYM
         nWCvh0uKNjqY5W29IATU1QhE8+19lJjAsXyDKQCqMYYZwSuqIJIb+isB4KamCDLAYn3z
         7xSw==
X-Gm-Message-State: AOJu0Ywz5J0Yvxtiwl/guEXzZuqf64iumRt5+dJ2LtUoa5pIoPSx+RmL
	soMqxr4tKpMovy0bYTO/lDXdOsCNz26p6SQKrAuA3VrYFZjRIhYb1xwI+P2oDVMa1RvPhswLKYH
	KMhPDKKp2
X-Received: from plblk13.prod.google.com ([2002:a17:903:8cd:b0:2bf:1cdf:9e4b])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1786:b0:2c0:c38d:9d37
 with SMTP id d9443c01a7336-2c163d92f23mr60364875ad.25.1780538563812; Wed, 03
 Jun 2026 19:02:43 -0700 (PDT)
Date: Thu,  4 Jun 2026 02:01:37 +0000
In-Reply-To: <20260604020143.748245-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604020143.748245-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604020143.748245-16-jrhilke@google.com>
Subject: [PATCH v5 15/21] KVM: selftests: Add kvm_gettid() wrapper and convert users
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>
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
index 302c4923d093..f8b3d0b68830 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -57,7 +57,7 @@ static void vcpu_worker(struct memstress_vcpu_args *vcpu_args)
 static int handle_uffd_page_request(int uffd_mode, int uffd,
 		struct uffd_msg *msg)
 {
-	pid_t tid = syscall(__NR_gettid);
+	pid_t tid = kvm_gettid();
 	u64 addr = msg->arg.pagefault.address;
 	struct timespec start;
 	struct timespec ts_diff;
diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index 067a4c9cf452..e4731741373e 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -83,6 +83,11 @@ static inline int kvm_dup(int fd)
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
index 8be0d09ecf0f..1d72dcdfce3b 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -10,6 +10,7 @@
 #include <sys/syscall.h>
 
 #include "kselftest.h"
+#include "kvm_syscalls.h"
 
 #ifdef __GLIBC__
 #include <execinfo.h>
@@ -64,11 +65,6 @@ static void test_dump_stack(void)
 static void test_dump_stack(void) {}
 #endif
 
-static pid_t _gettid(void)
-{
-	return syscall(SYS_gettid);
-}
-
 void __attribute__((noinline))
 test_assert(bool exp, const char *exp_str,
 	const char *file, unsigned int line, const char *fmt, ...)
@@ -81,7 +77,7 @@ test_assert(bool exp, const char *exp_str,
 		fprintf(stderr, "==== Test Assertion Failure ====\n"
 			"  %s:%u: %s\n"
 			"  pid=%d tid=%d errno=%d - %s\n",
-			file, line, exp_str, getpid(), _gettid(),
+			file, line, exp_str, getpid(), kvm_gettid(),
 			errno, strerror(errno));
 		test_dump_stack();
 		if (fmt) {
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index e208a57f190c..6b00ab11f3c0 100644
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
2.54.0.1032.g2f8565e1d1-goog

