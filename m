Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395285;
	b=21tj0drv2HwT2zjDwTqTNTuxD60ETOYhSJjd0r67Q9kvCevfiiJkHaAZsPEnq3YzlS1a
	 p2Rw/9TntKOS+3f825nF6A0IgwQrN9YxTvWy+Q88cB4qrMsCx5o9KpxZ3/q8AKfh+fFpS
	 gvLQkC4yaQMSGYSw3QF+LRM8/uess/GxBHHpdDdyjANuukpiT3597wLfiNXmP9dazdWSt
	 Dz/7zbd5/77e8iadZqaR85SPFnyfzKYR32PKyg+9cy13xm5ucXAdV0xLrKK3kVg1I1lPy
	 V/9Wc3LEDBm1cYvL6F7244br1KrBPFdrDsJzFaKHd+z4hJicoTpiaWwYjFXK6cjzBsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
	b=AvN05tgSypjzoSrQw4kRkktVIfhNDUAhNyqRhMBjl0wjLBd7LOsaqAKWDCqe9WyEHGVJ
	 08WxtweMLNN9R2hLtGQFrxFlyNrYX3MBk1dHHlgOI/efuP3D4hohaTw0bEix/8CoB8wZx
	 nL8N4xUbc94fKnO013Gkvt380Le4Q8O0+RYFTDIuJFc3Rg0QfG7s2C94wervHH/wS84WD
	 rXy8bGvDWYjudY2myn3NHusAKl4m3n/KDxv0iM9vMSB17K72xoX26XJeLjor7WdLQs68g
	 JdI0iTpt2+lVscy02TKRksE4jLBdPkdZ/7/YhpILdYjhv3W0viJ+fM92b7Eh32Fudng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+UDukdI;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210B60A2616
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 21:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4210B60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G+UDukdI
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so1618711a91.3
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 14:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793395285; x=1794000085; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
        b=G+UDukdIeED2uRXFxXeqbYF3PMScrlAvnfagXfyLr1WfwJUDVJBTNyzDjvbjL9yags
         nB70KHAsMhV6OL0kqYE3CZ27nBvHLtnMRl9Pa9TIfTJmdrk5B9CtLPbS/403yWo8dWQv
         fPqYdQsWlr/Npsm9PRVgE42HyJJNoMOLTrAQIu1Hi8WOUp6vVqFXzoCF5NLS07HgJHMU
         swOeZkvW60U0vHyoSMEruvjH8ISumlVdjEkbe2OkecIEvOQsDs9ewk2/TVWHNe5KmE8U
         H/8Zih2cCkgjIjR0HPJ4PIp+hiLdLBO1Zhrld7jU+rh/vH/5PLTkhIfMP/9yi6UMSfj0
         Cu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395285; x=1794000085;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FBcwwQefjg5U9pbFhBbpj/PcCf2fiNl2oUBEHVQucg=;
        b=Jp8AOyNuarljwcUab5HriPB4RP7acpJk6svyl0rVbVzJW2yTJVjjJx+UcB9EKhVubr
         TwQ5gT3y4D/Ur54evVOOwRUfh+krmgAz7l9QIUeKfSeA8fvfgbi0n4+Di9Vc/H266j3S
         FHuf5HxC6Cpj+CR8rJOpAZaruzJ51kDTZ9fe8vLTzbmdNsukD9VRZ84XufMYAXhtVYoD
         ePWF2XK6X3//1tazchzkTxzlM4ND45yAvkECcZQxDXPk9ljwFd1N22S/zNMOlC0iHvHA
         5zmMqUZ5bfDFX4UcK5jDr9DrBFWUlkB7Q7ql134H2QTgOJyDg4qf5JHC7tYKnOsBg/w6
         t+1A==
X-Forwarded-Encrypted: i=1; AKwUvBzIGnDGYFRQdqf1bylGaqG9i3u5SB+et86pEUs8bXNIVDVRe0BS//gvO89FUwFEuT7jkME=@vger.kernel.org
X-Gm-Message-State: AFq9FYJazh9l/2nXWRuIl5nEHlQG+qyIygZjyZpmgrEfAVks4gT7irEr
	zolq+nKa8kuY+3WY1/EbV53RiHG5dlrRquNlmHSaqhT5ESjzcseAB1cHnZjARsS/d0jNnSiLpKt
	1RG9mJQ==
X-Received: from pjry9.prod.google.com ([2002:a17:90a:bd09:b0:3ab:d09d:a37a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b44:b0:3ac:74b3:a8f3
 with SMTP id 98e67ed59e1d1-3ae8983b590mr3022604a91.44.1793395284519; Fri, 30
 Oct 2026 14:21:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 30 Oct 2026 14:20:57 -0700
In-Reply-To: <20261030212112.2598640-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261030212112.2598640-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261030212112.2598640-10-seanjc@google.com>
Subject: [PATCH v4 09/23] KVM: x86: Re-queue APICv update request if
 inhibiting APIC access page fails
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	James Houghton <jthoughton@google.com>, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Re-queue an APICv update request if deleting the APIC access page memslot
fails when trying to (permanently) inhibit the APIC access page.  Sadly,
memslot deletion requires a memory allocation and so can fail even if KVM
does everything right.

Fixes: 2008fab34530 ("KVM: x86: Inhibit APIC memslot if x2APIC and AVIC are enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845fb1..c20e2a25834f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2931,6 +2931,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_alloc_apic_access_page);
 void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
+	void __user *p;
 
 	if (!kvm->arch.apic_access_memslot_enabled)
 		return;
@@ -2939,25 +2940,30 @@ void kvm_inhibit_apic_access_page(struct kvm_vcpu *vcpu)
 
 	mutex_lock(&kvm->slots_lock);
 
-	if (kvm->arch.apic_access_memslot_enabled) {
-		__x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
-		/*
-		 * Clear "enabled" after the memslot is deleted so that a
-		 * different vCPU doesn't get a false negative when checking
-		 * the flag out of slots_lock.  No additional memory barrier is
-		 * needed as modifying memslots requires waiting other vCPUs to
-		 * drop SRCU (see above), and false positives are ok as the
-		 * flag is rechecked after acquiring slots_lock.
-		 */
-		kvm->arch.apic_access_memslot_enabled = false;
+	if (!kvm->arch.apic_access_memslot_enabled)
+		goto out;
 
-		/*
-		 * Mark the memslot as inhibited to prevent reallocating the
-		 * memslot during vCPU creation, e.g. if a vCPU is hotplugged.
-		 */
-		kvm->arch.apic_access_memslot_inhibited = true;
+	p = __x86_set_memory_region(kvm, APIC_ACCESS_PAGE_PRIVATE_MEMSLOT, 0, 0);
+	if (IS_ERR(p)) {
+		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+		goto out;
 	}
 
+	/*
+	 * Clear "enabled" after the memslot is deleted so that a different vCPU
+	 * doesn't get a false negative when checking the flag out of slots_lock.
+	 * No additional memory barrier is needed as modifying memslots requires
+	 * waiting other vCPUs to drop SRCU (see above), and false positives are
+	 * ok as the flag is rechecked after acquiring slots_lock.
+	 */
+	kvm->arch.apic_access_memslot_enabled = false;
+
+	/*
+	 * Mark the memslot as inhibited to prevent reallocating the memslot
+	 * during vCPU creation, e.g. if a vCPU is hotplugged.
+	 */
+	kvm->arch.apic_access_memslot_inhibited = true;
+out:
 	mutex_unlock(&kvm->slots_lock);
 
 	kvm_vcpu_srcu_read_lock(vcpu);
-- 
2.56.0.385.gac671c819a-goog

