Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D5372ECD
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527789; cv=none; b=JTmYLffJPvJCXbc7I96HbRfVghwTsYrkDTGsaxX7eoRlbm/XkbpVd34cXX9VkPjusGlCLbJKpdbQGoaEZ+orZBQExNlM+fblnbO4cK3i/QU9R/k+VY7XSL4IOuOj1sB7AmGaHLdaAgoTPHVbra3uUc28hZC7hS9svxDbnqG6XF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527789; c=relaxed/simple;
	bh=GSlZ/QfH22uYNIQc6bnCNCACqwR92zhApm/uHM2zGa0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JOwxpNzVDBztTvJHi1qtv+x1xGXBvG1Kt0BgKSzi1DWLZc9+mY/wGPiGfSO2ZDdxbqESjcTMuXOCLLjMB6R6aeVDnY+tybyxXGwlL2i269x9iw/GfE+v9LuiFeEG6JQoGMXtZlvYM1d1Sgq3CyyJ4WUsuhkouvRPJ5vwDCbpXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C8u3WcBA; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8u3WcBA"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso3014033b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527784; x=1786132584; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NUF7ZMtALHs5ft2o/4IkbgfVOeTdBoOGjjUFtC1Jiy0=;
        b=C8u3WcBA4I9JMWPU1OPJl8Ym1b5Ad6/bKS8weqFpXAE1bdIfoqqe/P/qtq60yCbqxq
         ly/xSgHWcnaFXOg7svcUULwAXc5hIYlJ8mLm4mS7s8xUXZ/EWHivn06s0+jQIyDbckNV
         6oYBzD5sYp8TQyb11M1INrwks0Lz8tth4goZAYrACPWLvH8m2vSJ6MaWH+u5Kh9r2RuS
         awTv7SNxjKhulNSGGlo3GXjMiYy5U5yFWDMQz3DbQImNHsNlwk9whcpzjb+IAB8cGN1q
         /fIDxgFCMUG3uvJrfVtZxSiDabx15DIIAuCsqHLxIwBMW6XuKh/V3SgIlq9dYzK2u/nV
         JnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527784; x=1786132584;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUF7ZMtALHs5ft2o/4IkbgfVOeTdBoOGjjUFtC1Jiy0=;
        b=lIkuCv8xzTOpfI8Mqr/XlSzWDihhz2iDiKsYSySLLPldjcqq9GF/uJ9xtr1nwWAcC0
         99BdCgwuTe1qJuD3Oyip2CW8SFuQrTgVe5+NCRru6KrIgGBBNYyKP/49Y5tGmKdl/wPT
         GFwjwj3KghV8QqtgjA/pK1BtleZj+mbmIRbnoRbKGshc775pSFE8NAea6hVBTyCSRz8H
         Dd/MoUSMJPTmfuIcaknO9AE6dF75RDBeC5iEJ2jqyyri8l8k7fC2+Dr5ZGtjKPw0GZ3/
         aS8KYrVi3wl6hsk/CU514i7cZGdfTQFZ9kk5+H3qYKQjKYk35tDlsqs1G2bZiP5xfHKR
         PwDw==
X-Forwarded-Encrypted: i=1; AHgh+RqlA5f0G1V5DVmmd0Yyppp/vF3TpiF50WrNXbAIeJ5cKkehUXMA7SzAggFyBc1/6CAKoeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDGlUjBXghbnYxvttz7ttiLXlfZEOIo/5uqQ3pTRGKPcabjai
	MFhac2UPJfTScmCWs9rG0BHsXwBtWNDNuPHXRYp/KNCO1m8c0GPNNtcLrdxQLpJOloOqlJ/UE8d
	XAZ8cjQ==
X-Received: from pfva4.prod.google.com ([2002:a05:6a00:c84:b0:845:4ca2:60a5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d8c:b0:845:df5c:2567
 with SMTP id d2e1a72fcca58-84ee492fc27mr727552b3a.25.1785527784352; Fri, 31
 Jul 2026 12:56:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:07 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-8-seanjc@google.com>
Subject: [PATCH v3 07/12] KVM: selftests: Drop unreachable, dead code from
 hardware disable test
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
 .../selftests/kvm/hardware_disable_test.c     | 41 +++++++------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index fcc06c602fca..de8e63da7b58 100644
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
@@ -42,10 +43,8 @@ static void *run_vcpu(void *arg)
 
 	vcpu_run(vcpu);
 
-	TEST_ASSERT(false, "%s: exited with reason %d: %s",
-		    __func__, run->exit_reason,
-		    exit_reason_str(run->exit_reason));
-	pthread_exit(NULL);
+	TEST_FAIL("vCPU%d exited with reason %d: %s",
+		  vcpu->id, run->exit_reason, exit_reason_str(run->exit_reason));
 }
 
 static void *sleeping_thread(void *arg)
@@ -56,12 +55,11 @@ static void *sleeping_thread(void *arg)
 	kvm_sched_setaffinity(0, sizeof(cpu_set_t), &threads_cpu_set);
 #endif
 
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
@@ -73,22 +71,12 @@ static inline void check_create_thread(pthread_t *thread, pthread_attr_t *attr,
 	TEST_ASSERT(r == 0, "%s: failed to create thread", __func__);
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
 	pthread_attr_t attr;
 	struct kvm_vm *vm;
-	pthread_t threads[VCPU_NUM];
-	pthread_t throw_away;
-	void *b;
+	pthread_t thread;
 	u32 i, j;
 
 	TEST_ASSERT_EQ(pthread_attr_init(&attr), 0);
@@ -102,19 +90,18 @@ static void run_test(u32 run)
 	for (i = 0; i < VCPU_NUM; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
-		check_create_thread(&threads[i], &attr, run_vcpu, vcpu);
+		check_create_thread(&thread, &attr, run_vcpu, vcpu);
 
-		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
-			check_create_thread(&throw_away, &attr, sleeping_thread,
+		for (j = 0; j < SLEEPING_THREAD_NUM; ++j)
+			check_create_thread(&thread, &attr, sleeping_thread,
 					    (void *)NULL);
-		}
 	}
 	pr_debug("%s: [%d] all threads launched\n", __func__, run);
 	sem_post(sem);
-	for (i = 0; i < VCPU_NUM; ++i)
-		check_join(threads[i], &b);
-	/* Should not be reached */
-	TEST_ASSERT(false, "%s: [%d] child escaped the ninja", __func__, run);
+
+	/* Wait for the parent to SIGKILL this child. */
+	while (1)
+		pause();
 }
 
 void wait_for_child_setup(pid_t pid)
-- 
2.55.0.508.g3f0d502094-goog

