Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399546C830
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439165; cv=none; b=Up9ved0xQjWwifbVenQKBIr0igngnlOIjvzGIVk0uL+4bsFiEfspzZWbkOFyORF/q+ouGBvbGE+5C/XNM6n3dJAJyltqZdOuIu1zwrhMkDD30OiOgVhe/fohZO+rlFOYygpehJW+qGjFOhMB0PdiS8V4dmVzc4UEBV4R3pBrIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439165; c=relaxed/simple;
	bh=YqbowzZLTbvED6IIZ5eKs/x5hI5KUK0TZBiCRoRnSms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mXTY6RB6Kok6fBkY6yBvji77DdL5CvJso6nl5mYuZQSg0fmxbavxNlloO71RtvO1H67pKZYCw0aFFyT4xKpZPiV+mAA45CGaObjy/xSVWJKIkLJDGIKgDeq6+fDiJCy5kZ0Ljwy+hME1XlIBxvRvz563LecwJRobaVYE/O1/7cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a4IX5Vro; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4IX5Vro"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so196001a91.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439162; x=1786043962; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ej1XcnuLH5yYzQBAwBT+NjRAfZ8wjNCP8hhOnMl6lPQ=;
        b=a4IX5VrofDPfAqWf3LZfRSYhYxFbsXWwAd+40bUKHXBxwisaiEuFDvWTC1c8p2EmvA
         O5WTJHq7SgN7hL+y3Yr+nQo31rILebW53QzccWk1ZaobL8VN0d6IOhXo40SF0WdasG7f
         fCEdOsjxFNZE+riinZ3WnVqJdgToVlVQM3Rpo7K0kIi7FHHl2QCU0l+ZEZLovkSBPD5S
         NO4AZXZbYEo+S4mspl7xRdmXZTAaSEaiDqsBV2PnxJ07Ix4V1bflnm/4asa4kLSW09CL
         lmQ4s11XOvjWyqsxQglX1n02V3GIOxZ/zCQSRSUSvK2QviZpllsTIZuOB9hERE6r9V/T
         eNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439162; x=1786043962;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ej1XcnuLH5yYzQBAwBT+NjRAfZ8wjNCP8hhOnMl6lPQ=;
        b=XHXHB6L4g2M9y7tkrVXf+QHMogMHUxUjRZg1eRSI+T4v0w3fkJanEXGFAHOIMLDkGo
         /O+PRb/E1jrNwKgraMC9/0DZzzWhH8XXpSXBuVtfa32N3tqTCFB8CZyRuQF2SoPLGkJ7
         m0ARzP1DzV64rzWCPp1eKYi2P7uZ/jvWc/Saiyouyw23zAKFI/1d6TFjIih27R83q89B
         /evoISXI3MA9KxC83wtTC8mQ4XlgFGvctE0DPT45TTNXREGwJDgA9FeMY/ORjZ+pk2JQ
         PE5LznWFvD7kU2rGX5aYVCJ6ZFu/d1UTvkrpxyScgWR7nY80YBXTsakao5Dg6QsmfSUE
         fo4g==
X-Forwarded-Encrypted: i=1; AHgh+RrXo6UCKCCHBjbypQrutC6j5PeQpOt0Sv42cqBTMrwvF+E2H0Fo3fj47EFhMLYKS34FBqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEY6ANyKMjbYZJ5yEeTKGlBviWgGeO0S6CbledRtlwZ+nbp7L2
	y1ahjF7I4Pr7ri9cmLMlpJPe3rL294tp6+P9YnPNy7pTQuCq+oLX7YBLseLi30VEiuvNM0BCgJL
	I0A9wzg==
X-Received: from pjpo7.prod.google.com ([2002:a17:90a:9f87:b0:38e:c35c:d872])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b82:b0:38e:2a4:cffc
 with SMTP id 98e67ed59e1d1-38f9c020226mr3137625a91.25.1785439161887; Thu, 30
 Jul 2026 12:19:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 12:19:08 -0700
In-Reply-To: <20260730191908.2084803-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730191908.2084803-10-seanjc@google.com>
Subject: [PATCH 9/9] KVM: selftests: Clean up global constants in hardware
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

Rename the global constants in the hardware disable test to better
capture what they control, and open code the literal number of sleeping
tasks and iterations instead of using power-of-2 math to express values
that are 100% arbitrary.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/hardware_disable_test.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index bcca42182656..4abad7158989 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -17,10 +17,10 @@
 #include "kvm_util.h"
 #include "ucall_common.h"
 
-#define VCPU_NUM 4
-#define SLEEPING_THREAD_NUM (1 << 4)
-#define FORK_NUM (1ULL << 9)
-#define DELAY_US_MAX 2000
+#define NR_VCPUS		4
+#define NR_SLEEPERS_PER_VCPU	16
+#define NR_ITERATIONS		512
+#define DELAY_US_MAX		2000
 
 sem_t *sem;
 static cpu_set_t child_cpu_set;
@@ -61,16 +61,16 @@ static void run_test(u32 run)
 	pthread_t thread;
 	u32 i, j;
 
-	vm = vm_create(VCPU_NUM);
+	vm = vm_create(NR_VCPUS);
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
-	for (i = 0; i < VCPU_NUM; ++i) {
+	for (i = 0; i < NR_VCPUS; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
 		kvm_pthread_create(&thread, NULL, run_vcpu, vcpu);
 		kvm_pthread_setaffinity(thread, &child_cpu_set);
 
-		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
+		for (j = 0; j < NR_SLEEPERS_PER_VCPU; ++j) {
 			kvm_pthread_create(&thread, NULL, sleeping_thread, (void *)NULL);
 			kvm_pthread_setaffinity(thread, &child_cpu_set);
 		}
@@ -124,7 +124,7 @@ static void setup_child_cpu_set(void)
 	cpu = pin_task_to_random_cpu(pthread_self(), &child_cpu_set);
 	CPU_CLR(cpu, &child_cpu_set);
 
-	while (CPU_COUNT(&child_cpu_set) > VCPU_NUM)
+	while (CPU_COUNT(&child_cpu_set) > NR_VCPUS)
 		CPU_CLR(kvm_pick_random_cpu(&child_cpu_set), &child_cpu_set);
 }
 
@@ -139,7 +139,7 @@ int main(int argc, char **argv)
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
 
-	for (i = 0; i < FORK_NUM; ++i) {
+	for (i = 0; i < NR_ITERATIONS; ++i) {
 		pid = fork();
 		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
 		if (pid == 0)
-- 
2.55.0.508.g3f0d502094-goog

