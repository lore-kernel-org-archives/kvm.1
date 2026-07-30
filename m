Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C145A2AA
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439159; cv=none; b=uX8KMTPjYBOymairVaEiCr+20YSRFuURZX5IYUJcJaw/wvM5VYR+Rp6H4jN4ACVlcrwET5X46AdqUr8KaqQgTiSx6lYml7J/nZONKvTtry1XCvRQuB/Aicz5942q2JZtad+0uH9XsjoguWZfF1RImcrGFdd7vGta2Yw/Tc/9Nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439159; c=relaxed/simple;
	bh=lwh4ys9HIR2gOOVKZEfdEzqJQI0Ip7JtSbwGpkz2B/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sKzqzWwNODu/Sgk0OZCYxMYHY6LQ86ZCOJwNqjQeCfUdr1h5jvt9HTw5sH55G30zT7MUeY5PgUEsB0bSJM2KsJn/wZyeJ1rDk9F2E6++e5YrFlhqlZAgDS3k30UlGJYnwNC7VkWvIXIi+id1JV7DNsA/1JYdzvDxenfuz209mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxbrTfTJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxbrTfTJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848474825ffso59448b3a.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439156; x=1786043956; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o2DcwzlrubCNuT24RD/nTN5cT+um7dgpX6VefWZNk0A=;
        b=TxbrTfTJWH5zrTzNP8Et3nA9aCJi8fV6fmlTdNJQhf07Bwq2JFGgkuVYwEnVTfvk89
         yrXY7hkfoMDub+/fwNBGa0Ayd+TRq7qndAS/9x6/iqg8daeeMhbRQNpKl9STLwdjm2jX
         v5Gb/7ppmOai7AirOafLER8oq46vriirCHiDKi9DfHWATQc95wiP/9Ml0Gw14wkZXwor
         v6B5rcBgi3sRFSXfA/4oKjUjbY3MdfxVPAwoUIRpkNz8lrLw+EyuHw+xbetwHgvRF1Fc
         rE7HVHlzksO+CLQt3+QUj8gYZPZGixwUxvYxpKOFcgcFWCusUKOdTeRFbkjCacnqOxjJ
         potA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439156; x=1786043956;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o2DcwzlrubCNuT24RD/nTN5cT+um7dgpX6VefWZNk0A=;
        b=Cr/lm6k6LH2Oq1YVE3mEvl2xJPCMnOHObIa6wJWGz/aQ0lkYsHOT8ol95qElrl6aLh
         iMZfwhOt8ld5VjJUUIjCs1tT08fLRxZ5m1uCqvjtdpuEIMhyvCEmt2+w2kPxes+EIajC
         JS6WDBgX94kmr6qpcbE5VFfJfBCK7Dd5xs/qMlzAfaq0XRCAAKfJZawFDFYDIo5YtkwX
         GG6EqhXjrkCnLg8bbFpccOcjqZ+EV37enyoy+HVBLcHzkNhMqQRGB/RoPCWIS3/FhrED
         cT/+uESZ9MbRCJHhce0IUwj5TlWkTfQt8q0IXKYXv2aHhyvNZGIefU4p4URfTRqxL3F7
         Saug==
X-Forwarded-Encrypted: i=1; AHgh+RoYDYp1X92lLyB5/fAODWyulKIxxhnLj74cFUJWxumE5QIcVK4P7E5PihzXCkVlbcu9/sw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jQRFd4y/G1+71wApHiuC12uHzCPYIJ/SUVbg/6scNFHQ4dfi
	vQlREByxLUpPAfxqi9KDDs5FL6QgowiIp9VKCBlHNzgJBVOYWfK0jOjvCsb+ZwZCJEd2whTQtK2
	OOLXqlw==
X-Received: from pfx52.prod.google.com ([2002:a05:6a00:a474:b0:84a:6b32:7768])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c8b:b0:848:3576:3204
 with SMTP id d2e1a72fcca58-84eca87f787mr1125578b3a.34.1785439155333; Thu, 30
 Jul 2026 12:19:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 12:19:03 -0700
In-Reply-To: <20260730191908.2084803-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730191908.2084803-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: selftests: Drop unreachable, dead code from hardware
 disable test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop all of the code that is unreachable in the hardware disable test, as
it adds a lot of noise that makes the test seem far more complicated than
it actually is.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/hardware_disable_test.c     | 42 +++++++------------
 1 file changed, 14 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 1bcbd13e9994..e08aef94382f 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -15,6 +15,7 @@
 #include <test_util.h>
 
 #include "kvm_util.h"
+#include "ucall_common.h"
 
 #define VCPU_NUM 4
 #define SLEEPING_THREAD_NUM (1 << 4)
@@ -28,7 +29,7 @@ static void guest_code(void)
 {
 	for (;;)
 		;  /* Some busy work */
-	printf("Should not be reached.\n");
+	GUEST_ASSERT(0);
 }
 
 static void *run_vcpu(void *arg)
@@ -38,22 +39,19 @@ static void *run_vcpu(void *arg)
 
 	vcpu_run(vcpu);
 
-	TEST_ASSERT(false, "%s: exited with reason %d: %s",
-		    __func__, run->exit_reason,
-		    exit_reason_str(run->exit_reason));
-	pthread_exit(NULL);
+	TEST_FAIL("vCPU%d exited with reason %d: %s",
+		  vcpu->id, run->exit_reason, exit_reason_str(run->exit_reason));
 }
 
 static void *sleeping_thread(void *arg)
 {
 	int fd;
 
-	while (true) {
+	while (1) {
 		fd = open("/dev/null", O_RDWR);
 		close(fd);
 	}
-	TEST_ASSERT(false, "%s: exited", __func__);
-	pthread_exit(NULL);
+	TEST_FAIL("%s: exited", __func__);
 }
 
 static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
@@ -73,21 +71,11 @@ static inline void check_set_affinity(pthread_t thread, cpu_set_t *cpu_set)
 	TEST_ASSERT(r == 0, "%s: failed set affinity", __func__);
 }
 
-static inline void check_join(pthread_t thread, void **retval)
-{
-	int r;
-
-	r = pthread_join(thread, retval);
-	TEST_ASSERT(r == 0, "%s: failed to join thread", __func__);
-}
-
 static void run_test(u32 run)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	pthread_t threads[VCPU_NUM];
-	pthread_t throw_away;
-	void *b;
+	pthread_t thread;
 	u32 i, j;
 
 	vm = vm_create(VCPU_NUM);
@@ -96,21 +84,19 @@ static void run_test(u32 run)
 	for (i = 0; i < VCPU_NUM; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
-		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
-		check_set_affinity(threads[i], &child_cpu_set);
+		check_create_thread(&thread, NULL, run_vcpu, vcpu);
+		check_set_affinity(thread, &child_cpu_set);
 
 		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
-			check_create_thread(&throw_away, NULL, sleeping_thread,
-					    (void *)NULL);
-			check_set_affinity(throw_away, &child_cpu_set);
+			check_create_thread(&thread, NULL, sleeping_thread, (void *)NULL);
+			check_set_affinity(thread, &child_cpu_set);
 		}
 	}
 	pr_debug("%s: [%d] all threads launched\n", __func__, run);
 	sem_post(sem);
-	for (i = 0; i < VCPU_NUM; ++i)
-		check_join(threads[i], &b);
-	/* Should not be reached */
-	TEST_ASSERT(false, "%s: [%d] child escaped the ninja", __func__, run);
+
+	/* Wait for the parent to SIGKILL this child. */
+	while (1);
 }
 
 void wait_for_child_setup(pid_t pid)
-- 
2.55.0.508.g3f0d502094-goog

