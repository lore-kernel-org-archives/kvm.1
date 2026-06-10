Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC72E7389
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052840; cv=none; b=O14jGXo+e9DBNoJlIvsqyb/D+PlH+fNd6OZIcY2OCNyXI4OGgeXRrlgzzOscNN/6np3dp3BpLfK5I8VPeMsywoQhcaJZmy06lwonn65suK0l5drLeFL3AgObFs6Ly7IrMNk0Bs4ceLjMjFJYzhKNfTLVBT7GvHsK0jge8L4irf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052840; c=relaxed/simple;
	bh=kTsTUQjOgq2pBM78bPztwNpiRrfOvWm2sYF+7djT1RM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QD1PFBJHABUVj94jGV1X4WIAfRZg7YjkEDenOehlbdvNwgeR6FYM5jrE8r+UNSqVt1zWUxIIb0EqV/Ryzcg71Sn7Q7aoH2r9Ge9Ri8lddPbfbzmnUTMT+PqX1GeJei/1yd2rVU1V/XpIuRlcrYrhMWeXkL6dk9QWVYOEMSQfU+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0oVZGjg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0oVZGjg"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c857ebbb0easo3982676a12.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 17:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781052838; x=1781657638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=oMIGqi5rnt7y0yP17wmyIl1/mzPYUzFOX3xknWS/BZY=;
        b=E0oVZGjgFRHC5PBhRKhSMx6RKCG1rSAnBXcuDztgJB4tZUpqL76+5HPvYRZHDJFev8
         QUWpQVdPhxI2ds6ddn6m7xH7x85bSgY3IoQjh9uxHs3hPfYTpiV+hsLcJoBlqNzImtFk
         fJ/uNI26voyj4dEDUzg0nHnxIGLyIrANS2pVpFc0SYh5H8kfJ8LzwaJCxkVxgkkqQzko
         Qrx4scVQGcZ9puLpI9BXFY8B91rYaJ91aIaKPBnTK7aPLYxC9/2XFq3IhSjMhtir+/h2
         vgh2hPPXUDvO5jgxqtJcbum2H0mOpCHjb8xWA4od8kH1vFA1+gyLUWjc9+OS0ldTk7Hy
         b80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781052838; x=1781657638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMIGqi5rnt7y0yP17wmyIl1/mzPYUzFOX3xknWS/BZY=;
        b=c4neoX4D6NfPU3iqz/w0huiJPkcrkb+WF2dZEj5Wi972Es53GGjA+ETe8cTcJ99jzM
         KvERYqpUnIBeaeRukx8jb96v5P5yrS1o2E+H3cJp9OL1MY6/ncbHF8ut5KNUjA2Dpp9L
         sP6Mgcy9/5eaCIbj3r6V6I2BvdVfihrBN7z8TPwYdEUpByqyllJ41TUez9aaFyHSbi6K
         wn0Wqx6/M4JBpRT2pF+58Nqqcevrm7CQPd7iCltKuRtMGgnDQV6SX5u7WW6CNSKHi1zK
         GvlUWE8ityOOndNvQNeWSijqbtnty6/8yHs8R+KhXJPJ3e3r5tqZa9VWEKq+z/kqK92C
         w8UA==
X-Forwarded-Encrypted: i=1; AFNElJ9CX2tXTqkmqhwc5yiK0e1q4FmSohGPJfr8FjRAXKBqvMeIJDhuzQKL2AWQH7xTroBj6fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRT2A5cYmDMaBYxdrhFan91hv+QOIr26TBCz2TI+ZckEOcMDOW
	6MY5Xh7tVHL+2zeopB2uK18CV31F5+Y5Pxc8weq4dA6cbPybzL+CXJtvxpK1Mjf08yrlXpIMqBv
	YgHPv2w==
X-Received: from pgww20.prod.google.com ([2002:a05:6a02:2c94:b0:c86:21eb:a0c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4387:b0:3b4:661d:8405
 with SMTP id adf61e73a8af0-3b4d39f7d02mr20264688637.4.1781052838106; Tue, 09
 Jun 2026 17:53:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jun 2026 17:53:33 -0700
In-Reply-To: <20260610005338.2967132-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610005338.2967132-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610005338.2967132-14-seanjc@google.com>
Subject: [PATCH v6 13/18] KVM: selftests: Add kvm_gettid() wrapper and convert users
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

Add a KVM wrapper for the gettid() syscall so that tests don't have to
open code the syscall() themselves.  Unfortunately, not all flavors of
libc that KVM selftests support provide gettid().  Convert all existing
users of the syscall to the new wrapper.

Note, per the gettid() manpage[1], "This call is always successful", i.e.
prefixing kvm_ to the syscall name is aligned with the goal of providing
syscall wrappers that guarantee success.

No functional changes intended.

Link: https://man7.org/linux/man-pages/man2/gettid.2.html [1]
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
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
index 6cb3bed29b81..dc4fb97aef8d 100644
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
2.54.0.1099.g489fc7bff1-goog

