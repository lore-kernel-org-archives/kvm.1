Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116646983C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439158; cv=none; b=ALfLRBi93ibhnOWVPOn6fxksoBw92Dd1dR2t+W8ChhA8QcnyAu/8rSdhXoOfwBjvS/hPf0XFjbggAjA0y/sbJXiaeRlL8VeiSIjctvN/f+x14zwBL1fJKIWIxBFub59ziKjE08ZmuLpijsKwS6K+gvulZ0LcV4+IYQrtXl9/8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439158; c=relaxed/simple;
	bh=Tzl/WlspRR+eS7uKI+T8ZIUt3U1xrKjzYObeF9nE8eU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FahmvE/wp+x9CCRdVPdXwB5vOBICVrl91mFp/Gy5q9Bi+TC1kKRme38dOBFa2Vh+C+7ZKiGCSy0yaAp5SIw/Kz/lSAyZL8hdaMBvVPniyt8Es0V9oHMDUYXfap6q8tJ6A5bDlmKxIO7NIHV7sQJTsE700bRpUNHy1PtN9SPb+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wRcRltLO; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wRcRltLO"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso538736a91.0
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785439154; x=1786043954; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kV7AgRqM0rROb0IpxCIjCBLFpIy5wqfEikqI+1M66/s=;
        b=wRcRltLOAqI+rd8eg4e0Pk/orXdlrKBRjOKN9beoWUl90bJAexi2XJjeLXWYxescgd
         OMDkhSsgyyGNRfRKeCvIsQmPeKLo4BWBBVs7Y5LfbD4z3HPRa7NjsuXliiwBTgO1f374
         vt4GyI75/WdpV3sCcoBjTWnF8tsPXd/tGT2qLXWBy9r7QEzS44COOX1WLYt+aOp2R0mq
         lPkpQho2TVkJE9dMog8lmg/wV8hpcYsVRDmjeTJiSYCG5ZPQSzbGiuYzxVvKunwbP6Rb
         1dVLA1myR8QEiV1HqsIcflSr+no0AvTbdWlKFylGWjY7nokPFcunfaNsjtRG1rWKtqDM
         YAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785439154; x=1786043954;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kV7AgRqM0rROb0IpxCIjCBLFpIy5wqfEikqI+1M66/s=;
        b=k8ZIYHAbz/pczQA5yjrCjO8KGMrKxc4G0Mivg1trJ0g4RDtwUKmCRUoL4/8Lj9Myu/
         V6HljfPBeIA0kNCgdbAdtBUAKg20dvPTdt+n9l1ltFrfE8RCjxCzn3hCg+jIOSgqZ4pT
         yhTwDxiYRPpqB6EZQb+tZhDtGog/cmL8yBBjvucDnkWJB/6uF74jc9P85692u1yEVySv
         IEyyTsX7hEB2h99e6JeTM8yZpVXnisG/trgJmdlbaTX+9k8JtKxpAKhkiI9xGeJIbXqz
         aRE2fbYfnowwNIOya3bC/B4RhTzhpmVm+UyBhEhLAJzzTHAl5GU8PIotzgrlXNBVlghY
         au3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp2KOIWgYFg5Zu3gGGOkSi6lbhrAZRO0sXjATVSH3/Mw1K5pK0mrNZXVaGvwP/i2Lu9N9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfri7XCvl+J8WNzJakF3RJZcG3HViDKtPxSL/VkiWVOcluR3O
	wRrTaRSWsYEcp//sceVtewi9Z/zSyQu8ctf1oMeXQKAZs7jBtr7mYInVpiKLQXHcNcT4yoiYSkH
	iZK3cyQ==
X-Received: from pjbmg16.prod.google.com ([2002:a17:90b:3710:b0:381:bbcf:b10f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e4f:b0:38d:dfd1:7a8
 with SMTP id 98e67ed59e1d1-38f9bd3ef8cmr2857348a91.2.1785439154115; Thu, 30
 Jul 2026 12:19:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Jul 2026 12:19:02 -0700
In-Reply-To: <20260730191908.2084803-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260730191908.2084803-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260730191908.2084803-4-seanjc@google.com>
Subject: [PATCH 3/9] KVM: selftests: Affine child tasks to other pCPUs in
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

When possible, affine child tasks to a different pCPU than the parent task
in the hardware disable test.  On preemptible kernels, running 4 + 4*16
child tasks on the same 4 pCPUs as the parent can result in runtimes of
several minutes due to the children making it difficult for the parent to
make forward progress.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/hardware_disable_test.c     | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 3147f5c97e94..1bcbd13e9994 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -22,6 +22,7 @@
 #define DELAY_US_MAX 2000
 
 sem_t *sem;
+static cpu_set_t child_cpu_set;
 
 static void guest_code(void)
 {
@@ -84,16 +85,11 @@ static void run_test(u32 run)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
-	cpu_set_t cpu_set;
 	pthread_t threads[VCPU_NUM];
 	pthread_t throw_away;
 	void *b;
 	u32 i, j;
 
-	CPU_ZERO(&cpu_set);
-	for (i = 0; i < VCPU_NUM; i++)
-		CPU_SET(i, &cpu_set);
-
 	vm = vm_create(VCPU_NUM);
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
@@ -101,12 +97,12 @@ static void run_test(u32 run)
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
 		check_create_thread(&threads[i], NULL, run_vcpu, vcpu);
-		check_set_affinity(threads[i], &cpu_set);
+		check_set_affinity(threads[i], &child_cpu_set);
 
 		for (j = 0; j < SLEEPING_THREAD_NUM; ++j) {
 			check_create_thread(&throw_away, NULL, sleeping_thread,
 					    (void *)NULL);
-			check_set_affinity(throw_away, &cpu_set);
+			check_set_affinity(throw_away, &child_cpu_set);
 		}
 	}
 	pr_debug("%s: [%d] all threads launched\n", __func__, run);
@@ -147,12 +143,30 @@ void wait_for_child_setup(pid_t pid)
 	}
 }
 
+static void setup_child_cpu_set(void)
+{
+	int cpu;
+
+	kvm_sched_getaffinity(0, sizeof(child_cpu_set), &child_cpu_set);
+
+	if (CPU_COUNT(&child_cpu_set) < 2)
+		return;
+
+	cpu = pin_task_to_random_cpu(pthread_self(), &child_cpu_set);
+	CPU_CLR(cpu, &child_cpu_set);
+
+	while (CPU_COUNT(&child_cpu_set) > VCPU_NUM)
+		CPU_CLR(kvm_pick_random_cpu(&child_cpu_set), &child_cpu_set);
+}
+
 int main(int argc, char **argv)
 {
 	u32 i;
 	int s, r;
 	pid_t pid;
 
+	setup_child_cpu_set();
+
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
 
-- 
2.55.0.508.g3f0d502094-goog

