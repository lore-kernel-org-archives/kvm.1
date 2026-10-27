Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139150;
	b=DRM45hkGCSDtP6oJEev64TXAy6stxxGGFBPFrzMXfqiZ6Fi18elEuugmwqfRN5wtLlyb
	 usdbJNsvhCg0qoyUhrCblzxK43FHisHxlkvDHJmpg/TDbWBeW1NJ+M0Q3AXzydNoQkIIf
	 f5TBKAXTWBwcBSfA13qHw9ZByfngTGaWASdeWhCacIrQveMZ8U9K5AY0j8cYvAWnsZjlG
	 zLNYrllXWZQwq5U9vHYGiLS5A728mIkRsfzsjPW4PK1EtsaJQxT3Udc5Bs8rKrXNnmVdr
	 9xOZRLQE0t802EfvQNs2jG3H62LipS04aCasFHlqhcxOC4Tna621GJYjdl1TbzdJSmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
	b=f1DIOgmt9tlr9Hjm3YbGTxrG5Es6P9qq5ctdgJyJOdFBY6beaH589QvZFm/1wBp9zHx9
	 2CWwqcbG5P0dMdqysP8hUL8hNCuf1HMHmwb5TGbu5wgceSGMghu8PblsG7s7e+ET3XCwu
	 K5IPQUyUUTMtvtqbQhMnciqQd3MO747WpRO+FV2ArE3fHvG94BgQJth9H1NY5mhZt1Dm6
	 rA0NztNu54jOmWscW8K6TbD8E2CNqE8bgAeg7E2OARXK/s6QsHUBnPuQnxBhnbqLgHlLh
	 jjc4/8p38v6fxXnerRds8w06jWgt7ZpPai4YIeMkWD9FrakEeP/sBbB8zWi7XVVHR5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mpsm39LZ;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823E60A5BC3
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4823E60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Mpsm39LZ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac7a4ba546so1070816a91.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793139149; x=1793743949; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
        b=Mpsm39LZxvwcoqS/9y6vFmAJ2iNORCk70S0zmS54Agbl+AmpLYQxH2Pw0kpGA/eMeF
         uPID+pjeoWE6ZiR7C/htgWoczL0F9bbljYw2CfGuQJ9JEUqv3FynDDntuvP3WCvC2ioK
         MBYGoSMF+buQzHIqVzVWWZD+Mwoi3iG8D9jvFJ+w4+GJvPL5tPB80MBvyPdiacBArpfM
         OngNYqrrRfiOEON5Wkyqw9ySIwgCHoQwUWnYsZsevE4KVPVfnCmncxyfQDAQ6/kQSMHx
         mWS7aFHPnM0qR+OuHLHeM0jIZ7pRHBHIZvON39h7bbaHfiakK58RnmNmw4jZyY+mbzOF
         hq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139149; x=1793743949;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CfieY5T+2+zXN7L+WJxdK99n1brgDAnzfFn1YUPYGik=;
        b=AVwtNj+A6h1Dz8u7a/q2tT87ZLx2wHXMBYrnqAsWkPpI8vMxuZHlwLeAXLZbkgfPtm
         xA5RgWgNCAQOMc0CRnTJj7iFXlyc80Zh4r5hiQeLljNK+sOp8qGvKlAYljoTgzfi8CYw
         MFu4KgDvnsXKj1K2p0lK6ImMIZlVF6sK74LREFG7Uo3vISGAzZvsRPxegSxe2zFyTPyy
         HN45kpZ+C7xssckH4jdkZPtz+ODqOVX1QNAUaZgMXp9MyRfvSZLlb4bPBI5/1mDR4XU7
         4qzDgGR3Zja6Ak7A0p8UX4ZXsprDG2HuhxTvQjgDdnPKgqwwYwGLqai4sB9eHWujK+6M
         l0kg==
X-Forwarded-Encrypted: i=1; AKwUvBxQa/J1zVsTeW2I738c71h42Tnh8HSLZIYFrGvQjaK61psYd31pTSdKXtGI/R2W+vDZ2A0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwOxutO0l04HrxHtL6PzeVUgB4phx3hUpSeklNEoriHEQSw7OS
	GbbeG4r3A8PKQhgL2j1c0uckSSu4JUKBmE1rxFFPrUBYRUVz8ZTBLZJTSi7IGM5kdE4lJudEyYU
	Nwbq4FQ==
X-Received: from pjdw9.prod.google.com ([2002:a17:90a:15c9:b0:3ac:a379:dc7c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3bc3:b0:3a0:d7f2:5a58
 with SMTP id 98e67ed59e1d1-3ae57e14372mr206675a91.3.1793139149377; Tue, 27
 Oct 2026 15:12:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Oct 2026 15:12:06 -0700
In-Reply-To: <20261027221209.1560865-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027221209.1560865-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027221209.1560865-14-seanjc@google.com>
Subject: [PATCH v3 13/15] KVM: VMX: Explicitly remove dying vCPUs from the PI
 wakeup list
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Explicitly remove dying vCPUs that were blocking when the VM was released
from the Posted Interrupts wakeup list instead of very, very subtly relying
on the vcpu_load() in nested_vmx_free_vcpu() to take the vCPU off said list.
In addition to helping avoid future regressions, e.g. if an enterprising
developer were to optimize nested_vmx_free_vcpu() by bailing early if
"nested" is completely disabled, this will allow dropping the load+put pair
from nested_vmx_free_vcpu().

Provide a dedicated API to remove a vCPU from the wakeup list, i.e. don't
_completely_ abuse vt_vcpu_pi_load(), but do reuse the core logic for
updating the PID control word.  Using a CMPXCHG8B _should_ be unnecessary
as IRQ routing has already been torn down, i.e. no IRTEs should be pointing
at updating the PID, and there are obviously no other references to the VM
or vCPU, and so concurrently modifications of the PID should be impossible.
For the same reasons, updating the destination should also be unnecessary,
as nothing should ever send an IRQ.  However, relying on those assumptions
begs for WARNs to ensure they hold, along with fallback code to avoid the
worst case scenario, at which point trying to take advantage of the fact
that the PID is unreachable would be *more* complex than what is now
__vt_vcpu_pi_load(), not to mention KVM would have two paths to maintain.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 68 +++++++++++++++++++++-------------
 arch/x86/kvm/vmx/posted_intr.h |  1 +
 arch/x86/kvm/vmx/vmx.c         |  2 +
 3 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 2644add54b76..7414fb551d2e 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -56,35 +56,13 @@ static int pi_try_set_control(struct pi_desc *pi_desc, u64 *pold, u64 new)
 	return 0;
 }
 
-void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+static void __vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
-	struct vcpu_vt *vt = to_vt(vcpu);
 	struct pi_desc old, new;
-	unsigned long flags;
 	unsigned int dest;
 
-	/*
-	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
-	 * PI.SN up-to-date even if there is no assigned device or if APICv is
-	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
-	 */
-	if (!enable_apicv || !lapic_in_kernel(vcpu))
-		return;
-
-	/*
-	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
-	 * full update can be skipped as neither the vector nor the destination
-	 * needs to be changed.  Clear SN even if there is no assigned device,
-	 * again for simplicity.
-	 */
-	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
-		if (pi_test_and_clear_sn(pi_desc))
-			goto after_clear_sn;
-		return;
-	}
-
-	local_irq_save(flags);
+	guard(irqsave)();
 
 	/*
 	 * If the vCPU was waiting for wakeup, remove the vCPU from the wakeup
@@ -103,7 +81,7 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		raw_spin_lock(spinlock);
 		spin_acquire(&spinlock->dep_map, PI_LOCK_SCHED_OUT, 0, _RET_IP_);
-		list_del(&vt->pi_wakeup_list);
+		list_del(&to_vt(vcpu)->pi_wakeup_list);
 		spin_release(&spinlock->dep_map, _RET_IP_);
 		raw_spin_unlock(spinlock);
 	}
@@ -129,8 +107,33 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 */
 		new.nv = POSTED_INTR_VECTOR;
 	} while (pi_try_set_control(pi_desc, &old.control, new.control));
+}
 
-	local_irq_restore(flags);
+void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
+
+	/*
+	 * To simplify hot-plug and dynamic toggling of APICv, keep PI.NDST and
+	 * PI.SN up-to-date even if there is no assigned device or if APICv is
+	 * deactivated due to a dynamic inhibit bit, e.g. for Hyper-V's SyncIC.
+	 */
+	if (!enable_apicv || !lapic_in_kernel(vcpu))
+		return;
+
+	/*
+	 * If the vCPU wasn't on the wakeup list and wasn't migrated, then the
+	 * full update can be skipped as neither the vector nor the destination
+	 * needs to be changed.  Clear SN even if there is no assigned device,
+	 * again for simplicity.
+	 */
+	if (pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR && vcpu->cpu == cpu) {
+		if (pi_test_and_clear_sn(pi_desc))
+			goto after_clear_sn;
+		return;
+	}
+
+	__vt_vcpu_pi_load(vcpu, cpu);
 
 after_clear_sn:
 
@@ -146,6 +149,19 @@ void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		pi_set_on(pi_desc);
 }
 
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu)
+{
+	WARN_ON_ONCE(refcount_read(&vcpu->kvm->users_count));
+
+	if (!enable_apicv || !lapic_in_kernel(vcpu) ||
+	    vcpu_to_pi_desc(vcpu)->nv != POSTED_INTR_WAKEUP_VECTOR)
+		return;
+
+	__vt_vcpu_pi_load(vcpu, get_cpu());
+
+	put_cpu();
+}
+
 static bool vt_can_use_vtd_pi(struct kvm *kvm)
 {
 	/*
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index c5860ea828ae..1d9ccbc2bb6f 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -10,6 +10,7 @@
 
 void vt_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vt_vcpu_pi_put(struct kvm_vcpu *vcpu);
+void vt_vcpu_pi_remove_from_wakeup_list(struct kvm_vcpu *vcpu);
 void pi_wakeup_handler(void);
 void __init pi_init_cpu(int cpu);
 void pi_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 292001bbcbff..1f9e43c5b4c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7514,6 +7514,8 @@ void vmx_vcpu_free(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	vt_vcpu_pi_remove_from_wakeup_list(vcpu);
+
 	if (enable_pml)
 		vmx_destroy_pml_buffer(vcpu);
 	free_vpid(vmx->vpid);
-- 
2.56.0.307.g5fe7bd680c-goog

