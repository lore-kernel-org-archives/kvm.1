Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A68F30D410
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309056; cv=none; b=n16wWQx5YGSAuigtIDR+SL3rbGfRv+2wyu9SJCBpw3yC4jS8aYzgvy3KyHdKcoWx8IrtQZ3NIL6ngCuxwqQWsgm/yiu+ug8lZWPB9cHPbkKs94uVgqg2xsfgLetQNhDGDH1LOXS0zHyfkFM9mYDysUSbwIJk8y7tgVWigz6laZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309056; c=relaxed/simple;
	bh=39euOQ4m6HunRmuI42lC5o9taVffhWSGCqZpYe33RKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyiL2zdpHl/xeMp58NwLkXawJaBZ4+xiNUeoVoMOoHM7qGXmvr1Ep1nP5SUqemwixyNbE15FC8+TijCZxptThIqQusikBbHMGzYL7rH8hQ81i1EKJ+TFUcZ9+btL3/WruGcl1J4eXkbynMao8RpMw+m8RpzQMsyCQyoakfFZVbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKBD413K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKBD413K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf3636d6c0so14972655ad.2
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309053; x=1781913853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RaK4/YViTu43p8aaf8vfIbCsXldE2lvhPNuEga0Iirs=;
        b=lKBD413KNkeyC2C+Snd8bc3gR6A6r4zFhy73rv5JYO5dEUf3c77hYTcWHbTFGp7tc8
         gcYzd666LQfzag0ihv3BhngrU8nJoyRomDuBhCWiK0+FjBvyUl/PZdrD7NoDElLIVUE0
         vFuk17ku9iKGajcbc14jiirFf48/hKcUqCzyXx4UOpT9UaW421bDNALZhCLmqtzZ1+Nz
         FNviPuPJqGtGDOXZySLPIeYeZQKoVB9vzbViBQvUGr+P6izORwhTlpDRXEiOYnaiAH8h
         Wh50XbG6E5mjPSWuwNnH8K+VGTKIF8/9agCDQ7UJIjQohLAtIejWaf2CdXeZYGTWR4oa
         iN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309053; x=1781913853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RaK4/YViTu43p8aaf8vfIbCsXldE2lvhPNuEga0Iirs=;
        b=VaUAixP9yXbkj514VnD/7kHRnCyDcGulWa+eMU8Ft3qhSsCFGyEL71bv04Iiveq9qj
         MwwQTFmNfd0pjwQUvrjWD5nkPwsxTi6o4Ts8P0QUPgNv4aDHDAMsck2ZJEiaxWmQ6Yh7
         0en+YFgEgC9hlDdnlrbq+GFmdqRb6j4r7FlvJ/4JA0eeu80SUJI5phzDEDFahDUEOKGJ
         vlqaw5cqjSoUVaKu7idrXPTsaXIsuFGnsf5KyRdWBcaa/UO9frXTPu0NWfAiKmpsDsol
         bZbS7XzyMtalyyp/Y5vRqGNHTa0HWRYYKhmcdHeYyadccLdx0WSCgYBoLwt47ZfMUmv9
         iSsA==
X-Gm-Message-State: AOJu0YyaHafyVksOBrgqYDokE6+McyiFrIaMdbWQRTkNUfe0CaRnbgV7
	LuOZasvZepqfKVjNupPeG4M2iknA0Gzrv29X/ufcc1xoCINPvrDrnhlzxo/W7MyNf5fLNKuvDxm
	/AVtkFg==
X-Received: from plk18.prod.google.com ([2002:a17:902:e9d2:b0:2bc:838b:f23e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41d0:b0:2c0:ee6c:c53c
 with SMTP id d9443c01a7336-2c410cd1639mr61288495ad.1.1781309052476; Fri, 12
 Jun 2026 17:04:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:26 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-28-seanjc@google.com>
Subject: [PATCH v4 27/30] KVM: x86: Rework kvm_arch_interrupt_allowed() into kvm_is_interrupt_allowed()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_arch_interrupt_allowed() to kvm_is_interrupt_allowed() and
change its return type to a boolean, as the purpose of the helper is purely
to check if interrupts are architecturally allowed.  I.e. whether or not
interrupts are temporarily disallowed due a pending nested VM-Enter is
irrelevant (and callers are most definitely not supposed to care).

Opportunistically bury the helper in x86.c, as it hasn't been referenced by
arch-neutral code since commit a1b37100d9e2 ("KVM: Reduce runnability
interface with arch support code"), and has long since gained _very_
x86-specific semantics (see above).

Opportunistically add a comment to call out that treating -EBUSY as
"allowed" is intentional.

For all intents and purposes, no functional change intended (KVM treats
-EBUSY as "allowed" before and after).

Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 23 +++++++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0f6f71642e1d..878944aaea85 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2338,7 +2338,6 @@ enum {
 # define kvm_memslots_for_spte_role(kvm, role) __kvm_memslots(kvm, 0)
 #endif
 
-int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 
 u64 kvm_scale_tsc(u64 tsc, u64 ratio);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e0456133133b..ed85012d1c0d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2697,6 +2697,18 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+static bool kvm_is_interrupt_allowed(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Note, .interrupt_allowed() returns -EBUSY if interrupts are allowed
+	 * based on CPU state, but can't be immediately delivered due to a
+	 * pending nested VM-Enter.  Treat that case as "allowed", because
+	 * the goal here is just to check if interrupts are architecturally
+	 * allowed, not to check if they can be injected.
+	 */
+	return kvm_x86_call(interrupt_allowed)(vcpu, false);
+}
+
 static int kvm_cpu_accept_dm_intr(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -2722,7 +2734,7 @@ static int kvm_vcpu_ready_for_interrupt_injection(struct kvm_vcpu *vcpu)
 	 * or KVM_SET_SREGS.  For that to work, we must be at an
 	 * instruction boundary and with no events half-injected.
 	 */
-	return (kvm_arch_interrupt_allowed(vcpu) &&
+	return (kvm_is_interrupt_allowed(vcpu) &&
 		kvm_cpu_accept_dm_intr(vcpu) &&
 		!kvm_event_needs_reinjection(vcpu) &&
 		!kvm_is_exception_pending(vcpu));
@@ -8472,7 +8484,7 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 	if (kvm_test_request(KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, vcpu))
 		return true;
 
-	if (kvm_arch_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
+	if (kvm_is_interrupt_allowed(vcpu) && kvm_cpu_has_interrupt(vcpu))
 		return true;
 
 	if (kvm_hv_has_stimer_pending(vcpu))
@@ -10308,11 +10320,6 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
-int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu)
-{
-	return kvm_x86_call(interrupt_allowed)(vcpu, false);
-}
-
 static inline u32 kvm_async_pf_hash_fn(gfn_t gfn)
 {
 	BUILD_BUG_ON(!is_power_of_2(ASYNC_PF_PER_VCPU));
@@ -10448,7 +10455,7 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu)
 	 * If interrupts are off we cannot even use an artificial
 	 * halt state.
 	 */
-	return kvm_arch_interrupt_allowed(vcpu);
+	return kvm_is_interrupt_allowed(vcpu);
 }
 
 bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
-- 
2.54.0.1136.gdb2ca164c4-goog

