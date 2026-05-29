Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19549381AE2
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093380; cv=none; b=gW1eh0IAQOOhG9vHQQwlCMOxeYtnXnIKJ0ReyXCo5I06g+OBrrAiawK0MOQJGGmmfm+tPpOPOvrL/iqF7HeleciaC8sWczvE6j850LldbE/C8mM49fcH1fN2sf+Mjk4OWxLVJLYMtHM/pU7X1ao6gDNQdLdFsE+K8Rfsrwn3Vmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093380; c=relaxed/simple;
	bh=EY1UUzjByJuYr1Hg1BkNVerLXRBIjRX+RVz1UvMuW9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gkepCMfHZhC0uwWw8aRtFoKTXmHX64LQBmG9PcVfkl5IZnEHMZuw8+pE6wQ+5MDFyLIANzFRw2UNqqwMiJcGGf1GL9AEwfwL1Jdx1pvgsIbbxKMt8F5WPNpNwZrBCpxGXwna8/xa1B2gKAViceu/Ie83HkaKVMgeQP4YeVDjDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTGh4B+6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTGh4B+6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bf08c2a24bso26327825ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093378; x=1780698178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lYYEV5eYbnO5d9jgWyRMntwUD0jcJ4Dk7yFI3OcsKAc=;
        b=XTGh4B+6joX60vacpmfqCs1Qe39MK7AiCxMRJUWybOQKlSgQqIROTMZmeqcKlUtS6u
         PBjPkIo47J8cbNjc7YLBq7LVIeFP5PjGxBfwSm4IbNmpfQAIRJhuhRLSI1sLrC5pRUYI
         JpSxBC1stL8IvYA0aS9tHw+DFzzJaO82+mVqacK+UBHggAb0gI9ngRgDdmxUxRkOhtvC
         N2aqs4O4Q8n5eIPrsUz+fC47ahwEUrtbC8b+PbpFEFJZxk8NZI7Wr9gu1ljbi71xDjAw
         ybX4TWSluvMhDdXDv0PHvihG7egwXsUeqdX/GxIKvTqJ9WLrH+8FINjDXUdHPtUsqkCB
         PJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093378; x=1780698178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYYEV5eYbnO5d9jgWyRMntwUD0jcJ4Dk7yFI3OcsKAc=;
        b=lTYJIi7mm67Q3Z6s19/cLxeoHIgu/7jpJA5A1xMtAZozX7fqt1TNYrMgNA2HT0+Zrt
         PiU8w5wx5AM4qAO9E3tRSe1L3jcjwzKw8CelcX2PN2zFTfC+TRJuMJlWBdk0QQkKtfku
         A9h7Cw87QCgmCQY9pu0RVw++MTSR4t+3b9rIQ3bDpLmdgg+3HsmWK1zAgimbScOWTTbT
         uXUTEi83jpi4MUFCYt+D4Ngw3SmvGkj29u/IIXSvyp4VHz1KdjjwjTcIQemzNxUar2St
         3n3lPOKm5zPof/OOjbjqvp4IqwnVj1Nv37ODjuHStO9xo77zDtCTPZeb4EJEh8KdihCt
         GHvw==
X-Gm-Message-State: AOJu0YyKOSIXVqLnslwTCYTZFwz3Gp6dtw8JONcORghApHQG2SiWv4TD
	FDh4V8P9XRA9h2IyIwr9/HOhAzwvHdaP1C3V0egSBRRGEU1qN+mOxOwVHdOL6b1oY2ZGbEIEo89
	T20/rIQ==
X-Received: from plem4.prod.google.com ([2002:a17:902:e404:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2450:b0:2b9:86ca:5bf2
 with SMTP id d9443c01a7336-2bf368463f1mr18712055ad.30.1780093378228; Fri, 29
 May 2026 15:22:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:56 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-14-seanjc@google.com>
Subject: [PATCH v3 13/40] KVM: x86: Move update_cr8_intercept() to lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move update_cr8_intercept() to lapic.c so that it's globally visible
in anticipation of extracting most of the register-specific code out of
x86.c and into a new compilation unit.  Opportunistically prefix the
helper kvm_lapic_ to make its role/scope more obvious.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 26 ++++++++++++++++++++++++++
 arch/x86/kvm/lapic.h |  1 +
 arch/x86/kvm/x86.c   | 34 +++-------------------------------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 15777869b292..9d2df8623f6d 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2761,6 +2761,32 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
 	return (tpr & 0xf0) >> 4;
 }
 
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu)
+{
+	int max_irr, tpr;
+
+	if (!kvm_x86_ops.update_cr8_intercept)
+		return;
+
+	if (!lapic_in_kernel(vcpu))
+		return;
+
+	if (vcpu->arch.apic->apicv_active)
+		return;
+
+	if (!vcpu->arch.apic->vapic_addr)
+		max_irr = kvm_lapic_find_highest_irr(vcpu);
+	else
+		max_irr = -1;
+
+	if (max_irr != -1)
+		max_irr >>= 4;
+
+	tpr = kvm_lapic_get_cr8(vcpu);
+
+	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
+}
+
 static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 {
 	u64 old_value = vcpu->arch.apic_base;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index f763cd29a508..71970213dc1f 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -100,6 +100,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
 void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8);
+void kvm_lapic_update_cr8_intercept(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
 void kvm_apic_after_set_mcg_cap(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a102269a7af9..034428b3d8e9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -128,7 +128,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -5337,7 +5336,7 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -10582,33 +10581,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 		kvm_run->flags |= KVM_RUN_X86_GUEST_MODE;
 }
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu)
-{
-	int max_irr, tpr;
-
-	if (!kvm_x86_ops.update_cr8_intercept)
-		return;
-
-	if (!lapic_in_kernel(vcpu))
-		return;
-
-	if (vcpu->arch.apic->apicv_active)
-		return;
-
-	if (!vcpu->arch.apic->vapic_addr)
-		max_irr = kvm_lapic_find_highest_irr(vcpu);
-	else
-		max_irr = -1;
-
-	if (max_irr != -1)
-		max_irr >>= 4;
-
-	tpr = kvm_lapic_get_cr8(vcpu);
-
-	kvm_x86_call(update_cr8_intercept)(vcpu, tpr, max_irr);
-}
-
-
 int kvm_check_nested_events(struct kvm_vcpu *vcpu)
 {
 	if (kvm_test_request(KVM_REQ_TRIPLE_FAULT, vcpu)) {
@@ -11349,7 +11321,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_call(enable_irq_window)(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+			kvm_lapic_update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
 	}
@@ -12495,7 +12467,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&
-- 
2.54.0.823.g6e5bcc1fc9-goog

