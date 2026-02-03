Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC87EEAB
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079486; cv=none; b=qwSDdjNMz3U98X0EjGYh29Tl9ehXaZG1Qs2DFPhohzVbHRnVlG16oQkT8Y/PW/D9AK2YoBruiUJPPtLdka3D5iZRZAxucl4VA5wZsAZwmA/eoXy7vhoLaP703xP4Xj3qzHQNjP6nut1ZOEWh+IMWAOIs1uR/f6K416RhX6l+dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079486; c=relaxed/simple;
	bh=o0pzk3e+K6js3lPrruqF8JHH/3B9nNKLcoSI25gYOw4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t54ns4+gk13koWwejgR0kh/OYYNOyUyy0znGimV0yzgy3yMRHkXaZi8KesaQQJI1vzS8X1zGxtFzbb4862vCYbJwNNK2F3sKZxJbqL02mnM98lT1rz2vPjPww6U0RIwL6x0Dm2QCdS5tg5d9T2oTPvDDOTdE1sL0ojwcLdMXEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATjm0lor; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATjm0lor"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a79164b686so51111545ad.0
        for <kvm@vger.kernel.org>; Mon, 02 Feb 2026 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770079484; x=1770684284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6dyPEJa2eNIZMpQNWCBQo7CQ4DxEAH0l/sPapwrY0I=;
        b=ATjm0lorPvA6NFXh9qUNejvghqLMJ32W992LK6Bsmm3UdO+4DmINj0rNa0lHF9MLJu
         qJ3PQ4GGqZhCEqjzLgFTVgf/+ExuTAbZi+PurUev+YWcrnLS2bVwcTtMGf7MnjZhJTPO
         xk8BqtRRqwMrzab1rT67rPxCSYZUlRjsSmCpSGombtKjnmrQywUGuiZNG9eOpkOJZyGn
         K29kHpoqS9rsTyVpYVYhajDjsKghfPjcMfoQBjnje1wzuqM3rmrv8KM7kYjd85Nltdfl
         D/kTiOhMIdQyp/9wdtE/xgIKZ8sQQV7ifAcEk+f2oZHoGs7RUjEhtGPq3l5jx48C6/sC
         fyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079484; x=1770684284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6dyPEJa2eNIZMpQNWCBQo7CQ4DxEAH0l/sPapwrY0I=;
        b=CjDccXSnGhgst/wMhjtIfjAWt4TtB9vQdb8Dq1efw7M8Nz4SIYDqvi7zqgN899TNWO
         W3ukEkCRTQGYiK1rrMbYWHlECLtSkXEjKGzxqedtVV1gxPxtMb1GS3eKJ7TdPRcgukDv
         wdaZkzhzsu32AM9ub+ju9g4ukbHBPA6GM5muyIjzFyXsbeiXq7jiivSkDz/JHhA6A4ih
         Pbw6BQgVQ3gfMIrecmVwjKxeTC2iKsuJ9RjjL7ZpKJYT+DQXDRrcka3yIk8iVCZEJDwU
         VchRqnl+uZRDnkBH4qzj4tGG/No6qVMOCW3RQonFkxd+siEFlFrVNYk9ayZQYxN0ddmH
         p1Yw==
X-Gm-Message-State: AOJu0YwgARi529VfAEjPvBvO30Wo86VXtcoNWYoTeQcZE1ULH8LOgXEH
	MwwNnVnvGeGZOWW+WhwcqhDhvAtZ6gp9YTOnZenaEGrZlvbVtvqU/IVq7TE/B63TYdhOjxF2VI3
	iLNhxFw==
X-Received: from pjbmv23.prod.google.com ([2002:a17:90b:1997:b0:352:f162:7d9f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:a8f:b0:29e:bf76:2d91
 with SMTP id d9443c01a7336-2a8d99285c3mr133805765ad.42.1770079484405; Mon, 02
 Feb 2026 16:44:44 -0800 (PST)
Date: Mon, 2 Feb 2026 16:44:42 -0800
In-Reply-To: <20260131163017.3341753-1-ingyujang25@korea.ac.kr>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131163017.3341753-1-ingyujang25@korea.ac.kr>
Message-ID: <aYFE-tGOPtKlSWhn@google.com>
Subject: Re: [Question] Dead code in KVM PIT ioctl error handling?
From: Sean Christopherson <seanjc@google.com>
To: Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Sun, Feb 01, 2026, Ingyu Jang wrote:
> Hi,
> 
> I noticed that in arch/x86/kvm/x86.c, the functions
> kvm_vm_ioctl_get_pit() and kvm_vm_ioctl_get_pit2() always return 0,
> making their error checks unreachable.
> 
> Both functions (at lines 6408 and 6433) simply perform:
>   1. Lock mutex
>   2. Copy PIT state
>   3. Unlock mutex
>   4. return 0;
> 
> There are no error paths in either function.
> 
> However, their call sites check the return values:
> 
> 1. At line 7164:
>    r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
>    if (r)
>        goto out;
> 
> 2. At line 7190:
>    r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
>    if (r)
>        goto out;
> 
> Since both functions always return 0, these error checks appear to be
> dead code.
> 
> Is this intentional defensive coding for potential future changes,
> or could this be cleaned up?

Hmm, the answer is probably somewhere in between :-)

My vote would be to push the !pit checks down into the helpers, to eliminate the
dead code without creating the potential for future bugs, e.g.

---
 arch/x86/kvm/i8254.c | 18 +++++++++++++++++-
 arch/x86/kvm/x86.c   | 14 --------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
index 850972deac8e..fd3049c675a4 100644
--- a/arch/x86/kvm/i8254.c
+++ b/arch/x86/kvm/i8254.c
@@ -651,8 +651,12 @@ static void pit_mask_notifier(struct kvm_irq_mask_notifier *kimn, bool mask)
 
 int kvm_vm_ioctl_get_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 {
-	struct kvm_kpit_state *kps = &kvm->arch.vpit->pit_state;
+	struct kvm_kpit_state *kps;
 
+	if (!kvm->arch.vpit)
+		return -ENXIO;
+
+	kps = &kvm->arch.vpit->pit_state;
 	BUILD_BUG_ON(sizeof(*ps) != sizeof(kps->channels));
 
 	mutex_lock(&kps->lock);
@@ -666,6 +670,9 @@ int kvm_vm_ioctl_set_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 	int i;
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	mutex_lock(&pit->pit_state.lock);
 	memcpy(&pit->pit_state.channels, ps, sizeof(*ps));
 	for (i = 0; i < 3; i++)
@@ -676,6 +683,9 @@ int kvm_vm_ioctl_set_pit(struct kvm *kvm, struct kvm_pit_state *ps)
 
 int kvm_vm_ioctl_get_pit2(struct kvm *kvm, struct kvm_pit_state2 *ps)
 {
+	if (!kvm->arch.vpit)
+		return -ENXIO;
+
 	mutex_lock(&kvm->arch.vpit->pit_state.lock);
 	memcpy(ps->channels, &kvm->arch.vpit->pit_state.channels,
 		sizeof(ps->channels));
@@ -692,6 +702,9 @@ int kvm_vm_ioctl_set_pit2(struct kvm *kvm, struct kvm_pit_state2 *ps)
 	u32 prev_legacy, cur_legacy;
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	mutex_lock(&pit->pit_state.lock);
 	prev_legacy = pit->pit_state.flags & KVM_PIT_FLAGS_HPET_LEGACY;
 	cur_legacy = ps->flags & KVM_PIT_FLAGS_HPET_LEGACY;
@@ -711,6 +724,9 @@ int kvm_vm_ioctl_reinject(struct kvm *kvm, struct kvm_reinject_control *control)
 {
 	struct kvm_pit *pit = kvm->arch.vpit;
 
+	if (!pit)
+		return -ENXIO;
+
 	/* pit->pit_state.lock was overloaded to prevent userspace from getting
 	 * an inconsistent state after running multiple KVM_REINJECT_CONTROL
 	 * ioctls in parallel.  Use a separate lock if that ioctl isn't rare.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index db3f393192d9..b0112c515584 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7406,9 +7406,6 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		r = -EFAULT;
 		if (copy_from_user(&u.ps, argp, sizeof(struct kvm_pit_state)))
 			goto out;
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto out;
 		r = kvm_vm_ioctl_get_pit(kvm, &u.ps);
 		if (r)
 			goto out;
@@ -7423,18 +7420,11 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
 			goto out;
 		mutex_lock(&kvm->lock);
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto set_pit_out;
 		r = kvm_vm_ioctl_set_pit(kvm, &u.ps);
-set_pit_out:
 		mutex_unlock(&kvm->lock);
 		break;
 	}
 	case KVM_GET_PIT2: {
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto out;
 		r = kvm_vm_ioctl_get_pit2(kvm, &u.ps2);
 		if (r)
 			goto out;
@@ -7449,11 +7439,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (copy_from_user(&u.ps2, argp, sizeof(u.ps2)))
 			goto out;
 		mutex_lock(&kvm->lock);
-		r = -ENXIO;
-		if (!kvm->arch.vpit)
-			goto set_pit2_out;
 		r = kvm_vm_ioctl_set_pit2(kvm, &u.ps2);
-set_pit2_out:
 		mutex_unlock(&kvm->lock);
 		break;
 	}

base-commit: bca955f212e0583a15f7e9f681032cda36500eff
-- 
