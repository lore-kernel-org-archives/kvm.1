Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2194C352C3C
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073490; cv=none; b=ZVx0wO/dQ49EVcpxUhr0mU5lQPHh7HInpmANbqvbGNnLYP8xHztLAPQOZjNnyT4b5SE0rPQg8MczrwwC7acOzFm0o/xx2ctB1j54C32tR7/bbyB6SfP0K817oBp00Emez7q0PAQCZsMerNq9h8+Jx/n1+2TyeRxqIYOyyWhhcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073490; c=relaxed/simple;
	bh=WjoDBDihuoTsObsTRtzBi0FovEtka+bji/1FjjVQEiI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D6r5riczmLdvAgMwexJuqq6ZE8RoaK/f/hPY1TyZSV8p0xN9OFvNHnwc7rompnBaoWrvIK61bzN1g4yNRkhHk+nKWdocL2Xkh9Oz2sLR/9FlfOPlUFXAnP5Eija1f/tFugA11TxR5g2VaNfzeu9HbVCJ0oRXdaTCUN8cXBpCVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DniI1gUC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DniI1gUC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso106707985ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073485; x=1780678285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkSZAvSUuIZkLdKqbpwmfPEheEuKi4ON1NJkkf1RUcU=;
        b=DniI1gUCaOoqM1im4zrt2gs1XhJbyzYKvrnV86F/VNcEsBciIl+y0OBbZxdSJ0Dh23
         HqEsuwXtZMNqRdoPfeTxy7DAjxVm9kmT/SbUhWMdLdjxJ+MZ90qPhKdyBqC+qS1RFaDZ
         3VkU3pLkosyNZZL5IBApWX3V9CrqeVZtGkxGm3N0s4+DkzSUtVknC2UcrEHGAv/YSUZz
         Ob5Ww9ab8GtHTIWOlD6K/erDWFdbBF6bDhMCWr/bLvJkDVJrYTymWulyNCF5FH4JnKYv
         JAsz2QSQmnfDEZ4Eq2gmsetXrhZ12rznuinIuzTKq4Bo4EAtn2Ge+fXTaajJ3eGnOfSb
         FF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073485; x=1780678285;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkSZAvSUuIZkLdKqbpwmfPEheEuKi4ON1NJkkf1RUcU=;
        b=mGK1xtaWiG4akSc0nV2rSwF2vkA/g0gAkPm2+RMEBAgDcFYjeO1OhUmFHpvXq/KAEn
         PggRmmOG4atYf1biInhGKrYkRfR2S17ShWXzuOtUjlCdcrvvTpThA0n3VRPPQI5tRb2r
         45XddgL0kgsX8A2jaS9651OoEF38h5pzRasz7TfG37fSh2PuuAcbCMnHaQg7dq7KlVC5
         Ua6kuISzEhicZJuxICNZgu7KeANTY7xKONpIfG+L6RYH3B+pSla/aMHW1nvbAydgxY7k
         r7Mlv+Bice4rBfaQasgNuYx6PPCaTil1hY4u484kIBz8nakCxMPznOwBeruJPadxW/+d
         n23w==
X-Forwarded-Encrypted: i=1; AFNElJ8+eJyTxRF/4LFM0hMkh2NEC9ZwPHHgpLDa7icTODMEClWic3kemeIQHE0zUotvHRwHY+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2Smqs+q3FPpH26t99EuTPkTyE43YLiPU1M0BHj4e+HG0TQoc
	4BTRV+3dSM2VDaEkSXUtu3RtMlADCwgokSSVjKWCtjLcRylJjPal7yB2GJfEhOvK8y8DDv/a/AK
	NOQ/Egg==
X-Received: from pleu6.prod.google.com ([2002:a17:903:41c6:b0:2bf:1803:8eec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f8d:b0:2b0:4fb6:85ce
 with SMTP id d9443c01a7336-2bf3684d836mr6960405ad.21.1780073485069; Fri, 29
 May 2026 09:51:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:56 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-3-seanjc@google.com>
Subject: [PATCH v2 02/20] KVM: x86/xen: Use read_trylock() for GPC locks in
 hardirq/atomic paths
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: David Woodhouse <dwmw@amazon.co.uk>

kvm_xen_set_evtchn_fast() is called from hardirq context (timer
callback, kvm_arch_set_irq_inatomic()). On PREEMPT_RT, rwlock_t is a
sleeping lock, so read_lock_irqsave() cannot be used in this context.

Switch to read_trylock() and return -EWOULDBLOCK on contention, which is
the designed fallback =E2=80=94 there is always a slow path for the case wh=
ere
the GPC is invalid and needs to be refreshed.

Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D208f7f3e5f59c11aeb90
Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and even=
t channel delivery")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..9bdb8e3cad58 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -697,6 +697,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc =3D &v->arch.xen.vcpu_info_cache;
+	bool atomic =3D in_atomic() || !task_is_running(current);
 	unsigned long flags;
 	u8 rc =3D 0;
=20
@@ -713,7 +714,15 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=3D
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
=20
-	read_lock_irqsave(&gpc->lock, flags);
+	if (atomic) {
+		local_irq_save(flags);
+		if (!read_trylock(&gpc->lock)) {
+			local_irq_restore(flags);
+			return 1;
+		}
+	} else {
+		read_lock_irqsave(&gpc->lock, flags);
+	}
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
=20
@@ -725,7 +734,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 		 * and we'll end up getting called again from a context where we *can*
 		 * fault in the page and wait for it.
 		 */
-		if (in_atomic() || !task_is_running(current))
+		if (atomic)
 			return 1;
=20
 		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
@@ -1794,7 +1803,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe=
, struct kvm *kvm)
 	struct gfn_to_pfn_cache *gpc =3D &kvm->arch.xen.shinfo_cache;
 	struct kvm_vcpu *vcpu;
 	unsigned long *pending_bits, *mask_bits;
-	unsigned long flags;
 	int port_word_bit;
 	bool kick_vcpu =3D false;
 	int vcpu_idx, idx, rc;
@@ -1816,9 +1824,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *x=
e, struct kvm *kvm)
=20
 	idx =3D srcu_read_lock(&kvm->srcu);
=20
-	read_lock_irqsave(&gpc->lock, flags);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+	if (!read_trylock(&gpc->lock))
 		goto out_rcu;
+	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+		goto out_unlock;
=20
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 		struct shared_info *shinfo =3D gpc->khva;
@@ -1847,11 +1856,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *=
xe, struct kvm *kvm)
 	} else {
 		rc =3D 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel *=
/
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 		gpc =3D &vcpu->arch.xen.vcpu_info_cache;
=20
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		if (!read_trylock(&gpc->lock)) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
 			 * and prod the vCPU to deliver it for itself.
@@ -1860,6 +1868,11 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *x=
e, struct kvm *kvm)
 				kick_vcpu =3D true;
 			goto out_rcu;
 		}
+		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel=
))
+				kick_vcpu =3D true;
+			goto out_unlock;
+		}
=20
 		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 			struct vcpu_info *vcpu_info =3D gpc->khva;
@@ -1883,8 +1896,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe=
, struct kvm *kvm)
 		}
 	}
=20
+ out_unlock:
+	read_unlock(&gpc->lock);
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
 	srcu_read_unlock(&kvm->srcu, idx);
=20
 	if (kick_vcpu) {
--=20
2.54.0.823.g6e5bcc1fc9-goog

