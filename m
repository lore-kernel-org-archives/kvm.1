Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDC40855
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775770418; cv=none; b=nPs8VjDEkTXUiBcxOrP3aB/yfgoDuP/wNAFWOJIYbRzIG3UrFK7D4p9Ny/sWhRkXTf5wXbuBLR3ycAWqAxsF3A1kRTtsugi4DWwJcMhGH1eBvKwf6mfWKYV/b659qUjXPZLE532BfoPWrI2zqtYISzl0DXD4lxz45770B4mH9U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775770418; c=relaxed/simple;
	bh=RiYsC8LEzM2KZf2cHt5XEQzfkrzerruJFazB+5dpR7Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OpYsZb/092BTszu2WyxZ/tq3jRX+zZT8qQnR51lG+jniQwRqB83WTxtBCUQGA8lDrTdSZdnEe2sHkogmQLIQReSRzu+lx8i1HiOF+9WPpbkX6qtAbUjeFtUXakZk6aVeTSUY5dDuIv6op7vkqg6MGC6Gh2be3GNkW7qFbuwRyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cix0lJZ2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cix0lJZ2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b0c30b51bfso24181295ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775770417; x=1776375217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAAGc/758UPR7rJ3hllpHOTGIHrlnl3O1dZD0kkoUKw=;
        b=Cix0lJZ2o9Wmbzirg5OqV+gpaV5N+8xLblesWT8FUa273mU0XtZAymlAtPJZLjo3Ca
         gjAQ25iuuzLkf1lGjA3/SwBXYal2NivYUq9TPLm5tIEQY90/HbD91mBkG4DgzSwg0jai
         0lL1fRsYpPofojSWBX3znMeKl68mYW3OJZLdsHo89EKUWpC9lfOn7SIgc26tj9OE3biU
         DC9r5lBhJmaQcIJBxArv0+/yc79qsBkUprDsGpGk7QgeWDioAKH8DUeKNsnv8dsocrIL
         niNAeRe6xy1jzAlmV7OA9+kERc4KihDT3zL59FI3uzuGkSwEsiQFdecb1Z4b2FA5x40O
         CUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775770417; x=1776375217;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAAGc/758UPR7rJ3hllpHOTGIHrlnl3O1dZD0kkoUKw=;
        b=WJVKAw4G5c2Z85U3L5XrzETUW+BMGxvzag0Tu12r6oALitzjSSu73Wj88QZ8IqpN8R
         Ri4TVMrgTx09dvXplOhLSXDDFw0AIYtVVUtI801IR6T8xsiFx9kS60yBwBJ3YmCxoqdW
         qZ/k/JdA58W5CWdgKUuJ5H08kKgtH3kWlVH4GLWIb/THhBAXg3IahCcyKJ/+/V5ZzHlY
         PRvz2mR7W+jFhvc4F4Q0TnfAxDGbfURQ8dMqyHr+BLwlD5VaXh7bs9XcP1dIupCoHoHi
         pivgRqdY1UnHq33tWBEwXzfvB+kbA2ZgTM4PS7oFP9yCxYGeBxU6qU5OlAuJpP0sOFpL
         1Rcw==
X-Gm-Message-State: AOJu0YwXG4NRiKXIYhcN7leXyXG9ygEycf85ROIXNC1kpfBhOXyF/mXr
	NHqCgTJNq0YZtPLg3mI0HN/2HeKvvN/ymZsGhoosp9IepgcoISf2CSbAFpmKSiEBL4+tBzWxTuv
	NK3qKvw==
X-Received: from plas13.prod.google.com ([2002:a17:903:200d:b0:2ae:c103:2745])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b213:b0:2b2:5503:1b8d
 with SMTP id d9443c01a7336-2b2d5938b1fmr4462465ad.6.1775770416588; Thu, 09
 Apr 2026 14:33:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 14:33:33 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409213333.1995382-1-seanjc@google.com>
Subject: [PATCH] KVM: Drop kvm_vcpu.ready to squash race where "ready" can get
 stuck "true"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanghao <zhanghao1@kylinos.cn>, Wanpeng Li <kernellwp@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Drop kvm_vcpu.ready and instead detect the case where a recently awakened
vCPU is runnable but not yet scheduled in by explicitly, manually checking
for a target vCPU that is (a) scheduled out, (b) wants to run, (c) is
marked as blocking in its stat, but (d) not actually flagged as blocking.
I.e. treat a runnable vCPU that's in the blocking sequence but not truly
blocking as a candidate for directed yield.

Keying off vcpu->stat.generic.blocking will yield some number of false
positives, e.g. if the vCPU is preempted _before_ blocking, but the rate of
false positives should be roughly the same as the existing approach, as
kvm_sched_out() would previously mark the vCPU as ready when it's scheduled
out and runnable.

Eliminating the write to vcpu->ready in kvm_vcpu_wake_up() fixes a race
where vcpu->ready could be set *after* the target vCPU is scheduled in,
e.g. if the task waking the target vCPU is preempted (or otherwise delayed)
after waking the vCPU, but before setting vcpu->ready.  Hitting the race
leads to a very degraded state as KVM will constantly attempt to schedule
in a vCPU that is already running.

Fixes: d73eb57b80b9 ("KVM: Boost vCPUs that are delivering interrupts")
Reported-by: zhanghao <zhanghao1@kylinos.cn>
Closes: https://lore.kernel.org/all/tencent_AE2873502605DBDD4CD1E810F06C410F0105@qq.com
Cc: stable@vger.kernel.org
Cc: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c       |  2 +-
 include/linux/kvm_host.h |  9 +++++++++
 virt/kvm/kvm_main.c      | 10 +++-------
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..eebb2eb39ec0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10399,7 +10399,7 @@ static void kvm_sched_yield(struct kvm_vcpu *vcpu, unsigned long dest_id)
 
 	rcu_read_unlock();
 
-	if (!target || !READ_ONCE(target->ready))
+	if (!target || !kvm_vcpu_is_runnable_and_scheduled_out(target))
 		goto no_yield;
 
 	/* Ignore requests to yield to self */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7981e9cab2eb..241a976e3410 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1753,6 +1753,15 @@ static inline bool kvm_vcpu_is_blocking(struct kvm_vcpu *vcpu)
 	return rcuwait_active(kvm_arch_vcpu_get_wait(vcpu));
 }
 
+static inline bool kvm_vcpu_is_runnable_and_scheduled_out(struct kvm_vcpu *vcpu)
+{
+	return READ_ONCE(vcpu->preempted) ||
+	       (READ_ONCE(vcpu->scheduled_out) &&
+		READ_ONCE(vcpu->wants_to_run) &&
+		READ_ONCE(vcpu->stat.generic.blocking) &&
+		!kvm_vcpu_is_blocking(vcpu));
+}
+
 #ifdef __KVM_HAVE_ARCH_INTC_INITIALIZED
 /*
  * returns true if the virtual interrupt controller is initialized and
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9faf70ccae7a..9f71e32daac5 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -455,7 +455,6 @@ static void kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
 	kvm_vcpu_set_in_spin_loop(vcpu, false);
 	kvm_vcpu_set_dy_eligible(vcpu, false);
 	vcpu->preempted = false;
-	vcpu->ready = false;
 	preempt_notifier_init(&vcpu->preempt_notifier, &kvm_preempt_ops);
 	vcpu->last_used_slot = NULL;
 
@@ -3803,7 +3802,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_halt);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
 	if (__kvm_vcpu_wake_up(vcpu)) {
-		WRITE_ONCE(vcpu->ready, true);
 		++vcpu->stat.generic.halt_wakeup;
 		return true;
 	}
@@ -4008,7 +4006,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 			continue;
 
 		vcpu = xa_load(&kvm->vcpu_array, idx);
-		if (!READ_ONCE(vcpu->ready))
+		if (!kvm_vcpu_is_runnable_and_scheduled_out(vcpu))
 			continue;
 		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
 			continue;
@@ -6393,7 +6391,6 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
 	struct kvm_vcpu *vcpu = preempt_notifier_to_vcpu(pn);
 
 	WRITE_ONCE(vcpu->preempted, false);
-	WRITE_ONCE(vcpu->ready, false);
 
 	__this_cpu_write(kvm_running_vcpu, vcpu);
 	kvm_arch_vcpu_load(vcpu, cpu);
@@ -6408,10 +6405,9 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 
 	WRITE_ONCE(vcpu->scheduled_out, true);
 
-	if (task_is_runnable(current) && vcpu->wants_to_run) {
+	if (task_is_runnable(current) && vcpu->wants_to_run)
 		WRITE_ONCE(vcpu->preempted, true);
-		WRITE_ONCE(vcpu->ready, true);
-	}
+
 	kvm_arch_vcpu_put(vcpu);
 	__this_cpu_write(kvm_running_vcpu, NULL);
 }

base-commit: b89df297a47e641581ee67793592e5c6ae0428f4
-- 
2.53.0.1213.gd9a14994de-goog

