Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8995137F00A
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527793; cv=none; b=kku1wBcl53WqaHEij0gNL23IRnkXcCu8M9Zn7wkMHZGHMxPA64dc7usdDiSyV7IU9GMotykxAJ7xzCrR2xlwiyhEMg/dnSL7Bf/dj8pWK8+CgVsJwQ9HBKz0B7/7KKCtGS65SPdI9uSRKDSIiRi13mTE6A/n8GF4z0XbBeYIDGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527793; c=relaxed/simple;
	bh=/OJMHDnQk4DxGr7QQt6Ocl9NtwW1FgQMJGQWB3tRuDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IH1F+ZRcIRMKLbMjdbyuk65eztKYug905W1+N31GrRlGR/51MfBzNpVeLGhQ2IYcJNDQ5TewHPpwwECs9EXCIldnv2jirA3YOTiB/KtatsSrCMeQq05c8lBlqaC+LC7fOQ1Ha05QwrH/8G6VjGwug6cUwToaXYAPwPqvP5dL4vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fNTiSkwY; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fNTiSkwY"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c860544c077so2887174a12.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785527790; x=1786132590; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hp708L//iArg9TjvY21pP5toBSAUeUQGGXgQT+srdHg=;
        b=fNTiSkwYVPjsx5lnsCBn+6gZcgAV+iQDlueby/7E4NWVaalMHhC6/iS98/cd6TpXKe
         0pA0biXNMxP8NLG1Dozb54kCU/5tU/630/AS0vjVm+VaxvKGWdJtPurgQLTC3f6dHsvT
         TJxpjsA992Dzre03MqMhTnftdDqmc+3+jmHJa/VOlhfhmtsA6MYxSjz+ibnyakYHMbCe
         z6epsd2MB1lEqHbl9rnq4YZux+lQV/yAk2p7GDXK8JULrsvCZErSrg35Yxi3ueQqeunh
         wiLuy8K5r6zXecAOqw4jE+NgJn0ylR9s3mKiPRiQlElWEvHlDug7GdWMOaJDKLfMjB29
         GlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527790; x=1786132590;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hp708L//iArg9TjvY21pP5toBSAUeUQGGXgQT+srdHg=;
        b=bjxIhj/1XOdjy3L++FTJKL/Zb4+uJrYf+NvI0TnQexnx8dhpF8/KAkQkubBbuZp5Iv
         /ZocAS3WOicAJ1aaWAzfC0BKbpwC+miTU8zY+9lVtp4ZqrHUeC0LfvPR+5jHxxuFvDJa
         sC3ppZJphJj6IaiR/KozXFc90PclxTUmPfeo8yfTdBjqe4gPACFCapFQzlniDZAp0hnx
         4KTKQcMAdKR7xVOhTqVgIL7DB559iHrIazW8703lV8Y34xixV/OcDQN543jELjQKn7gL
         oyb3nIYTW0yG6r3ovphLbFkbHC520/BjjtxJ/tSnVz88AY74FQy042HM1lTiamxGn3HH
         +3SA==
X-Forwarded-Encrypted: i=1; AHgh+RonOYdMIGbwj88Zb7AFWYpgQkoq/2b9RYx8iZi3lQgvYrsyHzY+fPSYln2hLEObRFy+wd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP20Aor7slMhnX8g6RNjaScIgg7eXcui0cy1EOFq4dmxLgw81P
	8cy4dy8vDCB24bPjMRe0Q698pv00A3ZJ1cNZK0KUG8vJgliiFyJ4sP1/jdDT4b5xH/PvT+aQvnP
	kOYRBYg==
X-Received: from pgmh4.prod.google.com ([2002:a63:5744:0:b0:c92:dd1e:dc60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88ca:0:b0:847:893f:2d0c
 with SMTP id d2e1a72fcca58-84ee47e512dmr830032b3a.5.1785527790077; Fri, 31
 Jul 2026 12:56:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 12:56:12 -0700
In-Reply-To: <20260731195612.2697986-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731195612.2697986-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731195612.2697986-13-seanjc@google.com>
Subject: [PATCH v3 12/12] KVM: selftests: Clean up global constants in
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

Rename the global constants in the hardware disable test to better
capture what they control, and open code the literal number of sleeping
tasks and iterations instead of using power-of-2 math to express values
that are 100% arbitrary.

Opportunistically tag the global semaphore with "static".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/hardware_disable_test.c     | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
index 72bac346bdd9..43a36ef3ead8 100644
--- a/tools/testing/selftests/kvm/hardware_disable_test.c
+++ b/tools/testing/selftests/kvm/hardware_disable_test.c
@@ -17,13 +17,13 @@
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
 
 static cpu_set_t threads_cpu_set;
-sem_t *sem;
+static sem_t *sem;
 
 static void guest_code(void)
 {
@@ -75,15 +75,15 @@ static void run_test(u32 run)
 	TEST_ASSERT_EQ(pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &threads_cpu_set), 0);
 #endif
 
-	vm = vm_create(VCPU_NUM);
+	vm = vm_create(NR_VCPUS);
 
 	pr_debug("%s: [%d] start vcpus\n", __func__, run);
-	for (i = 0; i < VCPU_NUM; ++i) {
+	for (i = 0; i < NR_VCPUS; ++i) {
 		vcpu = vm_vcpu_add(vm, i, guest_code);
 
 		kvm_pthread_create(&thread, &attr, run_vcpu, vcpu);
 
-		for (j = 0; j < SLEEPING_THREAD_NUM; ++j)
+		for (j = 0; j < NR_SLEEPERS_PER_VCPU; ++j)
 			kvm_pthread_create(&thread, &attr, sleeping_thread, (void *)NULL);
 	}
 	pr_debug("%s: [%d] all threads launched\n", __func__, run);
@@ -132,7 +132,7 @@ int main(int argc, char **argv)
 
 	kvm_sched_getaffinity(0, sizeof(cpu_set_t), &allowed_cpu_set);
 
-	for (i = 0; i < VCPU_NUM && CPU_COUNT(&allowed_cpu_set); i++) {
+	for (i = 0; i < NR_VCPUS && CPU_COUNT(&allowed_cpu_set); i++) {
 		cpu = kvm_pick_random_cpu(&allowed_cpu_set);
 		CPU_CLR(cpu, &allowed_cpu_set);
 		CPU_SET(cpu, &threads_cpu_set);
@@ -141,7 +141,7 @@ int main(int argc, char **argv)
 	sem = sem_open("vm_sem", O_CREAT | O_EXCL, 0644, 0);
 	sem_unlink("vm_sem");
 
-	for (i = 0; i < FORK_NUM; ++i) {
+	for (i = 0; i < NR_ITERATIONS; ++i) {
 		pid = fork();
 		TEST_ASSERT(pid >= 0, "%s: unable to fork", __func__);
 		if (pid == 0)
-- 
2.55.0.508.g3f0d502094-goog

