Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD5A171AF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309025; cv=none; b=AUy4zj+bItq+UoocoFZs+j943Bl3uzFx04knsUFILnQAfeWPsBFgw3lAm5O7vbq3nh5mTZQZp+6BZ/1QuAtn38eWrB3kzIGjYi1RjVhW0EyjirpM3aMUewFe22VfpLTMDTzHw3Gkq+NPx8aOnLO0XqozwhJhk2WybVfB8UL7dl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309025; c=relaxed/simple;
	bh=Ht5JXbfiylzEkkJmkiWmk3ElXXGMY4wPbpbIPBAaedQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JyQBVdRWEWSKCVMD6f2Sc5FgtsdEfj6o2VFby6Ny9hcXrKoAKEZ6IjopqPh1Lg5S+O1u/m0K+RE9k0Lrr0GTSONfmKGyZqJmrR6AaCAnaEs4vrdD0ElujdYvksQWzoYYIHGeWJFlybBySDMuOaKjzlAByqzEsf6CWg6v43V091g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ci2PJMaH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ci2PJMaH"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36e09ec696aso2388578a91.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309018; x=1781913818; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uE9H9jnAveU10Vcg/YmWNwjZQdzrayi8A+/+30D8+K8=;
        b=ci2PJMaHH7+hBQUTC/Y0d1cfTwpTBJVkY8B+20xa0hFHQfnA0QltxOUzzx9d+oOHE/
         jvL5zjawk/yantcJCcLixqYZd0iJa0wpbGmiVyY+THcpmLod2g+INUtWV0RdIeXblLrS
         xzJUBM1Q50EW/wQXr1YbrlvJWZsLEAeCwBeD0XW5jLfXIlKHGgrYk5IKPS2NUQD0a0ep
         Jues5m5ig+iWBQGKr1X3sOWhGi0vcA3yuefznzE33LXZSdBL72jTNevD+9ajI8jZqL8e
         J4pOAq9hQxTSZr3kcaT78U3sTX3xPXmjYyRSkH5/UgKVjSWONnr+0TAXWJzcuLBjEg4i
         HHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309018; x=1781913818;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uE9H9jnAveU10Vcg/YmWNwjZQdzrayi8A+/+30D8+K8=;
        b=cKNRGn+BtDBYlXxZ9s119BWF4NM5rZfVKLS25/L2PQzUpHRejCWcvSEv0eqYwGyHJr
         AnA/ffESJMUo07QozD8TsYrbYTxRxOO6aGGL9H16CUtCM4oTdetJft80+PWarN1drgwv
         ZQHpP44gwoaefsu50rzAmHhoTF3IW7SU1wCqbBJRkAc0JVX8TEk+XV0x1l+qU90K9G88
         42GU5tGMpqO2QFXQYI7CehXApxzVGmdhkY558aD2lZx2+M7XcinnbP038VRPuYzvN5Vs
         2eW6glAD5JfhaetdCGdXTCdi80oLXfzwCX4sRrh+0iG/UO1V/9HzfkOObNjDB3i7Ie6b
         JaQg==
X-Gm-Message-State: AOJu0YxRh9JdFzZTIkZhbCpNh1+bhUlx4OT2a5xMiAFVqlrdk6x/Y5zm
	5WbH4jjp8qGzo4rX7sa+8N0bo3yyIdR8BFh4INkr/4dFuPTDU+ddb/DoG4/n4Kkz3uGHDREuJqh
	Tngn//g==
X-Received: from pfbkm50.prod.google.com ([2002:a05:6a00:3c72:b0:842:48cf:89b9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d93:b0:3b4:b2db:d784
 with SMTP id adf61e73a8af0-3b783b42581mr6243310637.2.1781309018192; Fri, 12
 Jun 2026 17:03:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 17:03:04 -0700
In-Reply-To: <20260613000329.732085-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000329.732085-6-seanjc@google.com>
Subject: [PATCH v4 05/30] KVM: x86: Move local APIC specific helpers out of asm/kvm_host.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move single-use local APIC IRQ helpers out of asm/kvm_host.h so that they
are co-located with their user, and not exposed to the broader world.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 12 ------------
 arch/x86/kvm/irq.c              |  7 +++++++
 arch/x86/kvm/lapic.h            |  5 +++++
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3886b536c8a5..71e575d011e7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1772,11 +1772,6 @@ struct kvm_lapic_irq {
 	bool msi_redir_hint;
 };
 
-static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
-{
-	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
-}
-
 enum kvm_x86_run_flags {
 	KVM_RUN_FORCE_IMMEDIATE_EXIT	= BIT(0),
 	KVM_RUN_LOAD_GUEST_DR6		= BIT(1),
@@ -2509,13 +2504,6 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
-static inline bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
-{
-	/* We can only post Fixed and LowPrio IRQs */
-	return (irq->delivery_mode == APIC_DM_FIXED ||
-		irq->delivery_mode == APIC_DM_LOWEST);
-}
-
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 	kvm_x86_call(vcpu_blocking)(vcpu);
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 8c62c6d4d5c1..727245a6ab34 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -423,6 +423,13 @@ void kvm_arch_irq_routing_update(struct kvm *kvm)
 		kvm_make_scan_ioapic_request(kvm);
 }
 
+static bool kvm_irq_is_postable(struct kvm_lapic_irq *irq)
+{
+	/* We can only post Fixed and LowPrio IRQs */
+	return (irq->delivery_mode == APIC_DM_FIXED ||
+		irq->delivery_mode == APIC_DM_LOWEST);
+}
+
 static int kvm_pi_update_irte(struct kvm_kernel_irqfd *irqfd,
 			      struct kvm_kernel_irq_routing_entry *entry)
 {
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 71970213dc1f..32f09b25884a 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -237,6 +237,11 @@ static inline int kvm_lapic_latched_init(struct kvm_vcpu *vcpu)
 	return lapic_in_kernel(vcpu) && test_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
 }
 
+static inline u16 kvm_lapic_irq_dest_mode(bool dest_mode_logical)
+{
+	return dest_mode_logical ? APIC_DEST_LOGICAL : APIC_DEST_PHYSICAL;
+}
+
 bool kvm_apic_pending_eoi(struct kvm_vcpu *vcpu, int vector);
 
 bool kvm_lapic_suppress_eoi_broadcast(struct kvm_lapic *apic);
-- 
2.54.0.1136.gdb2ca164c4-goog

