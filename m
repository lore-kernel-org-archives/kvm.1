Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694913D16EA
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795654; cv=none; b=HFLbMfpasPW/8frPkTI7iThxlT4+zsZ59w85YbXlEe9S6D0Isyrq6Mba1tVDXDUvPi+ooUHgVyz/k+4flCvsrl3DsbCurvI0hSDP5vBv+VeEHrs7KTUocfHlnbAeip5XFhWqJOaNQRF669Jmi/jraZElXd1Ddhe5ISiWmFya+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795654; c=relaxed/simple;
	bh=KrQzVOQV563oIUJ/VEU8+6nkqUmBj6iF52H6K+QKjMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XDXZo8pnT3v7Be9E5ZlJahn172+RD8t4fjoysUK/6zPtDHBf/pJxgIbzkH82VhdwbkwP/hO2lozYyg3k8xfcklFjv8E4vyIHHfpzL4D6ta5S96qAddwwLMgro10NaxBBc47T7hyXNHs18Vtc3oisbBDnVFa+SJOGRIft69zEOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPvE02p4; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPvE02p4"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83565161a6eso139985b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795652; x=1779400452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PkJ0oOSgDIB4In8kN5PJvcBuLqM4XeIONdFdM8EJTow=;
        b=uPvE02p4vfBu15gmndiBLJfRSMClma2TVGrcvSq7BST8Agi4lEUT4NYTJCcbD4xxQY
         CEP6jw3zb62TFkHCmXVVp979sHIReQuIYJCLlt7T4JdsVYf9AUv3hn+ypmVcfR5d9Dmz
         3nPD4JBqz7cN0h2CQLcsA5JYmNCDrhcFbRwqDf3PWzKAMVufghg0BrEKRJ9ys8q2NlE/
         Soxqzp8quWriHLFhu3VVHk+AVBj3IdAlh4FKSVoLNebopQKdGggeBxdBome8nnKkuO/d
         ZVXtTWMIIz/gABF2VhETL7mwEVcVopoZVi7EYgbuKrj4a1hJlf2mj8DWVEBpNKUKSP4I
         hxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795652; x=1779400452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkJ0oOSgDIB4In8kN5PJvcBuLqM4XeIONdFdM8EJTow=;
        b=daPYh340RSBmi7k5u57GAhDlvDYNKs8mLsoMJjdt/RZKf/EPIsuZCoH0BUrfh7hC92
         hvWHvR0+rdh/Aw4R5kfjY3PMbGdTVtaBuy7Crxa6CaZS2xyxPZmx5f1ZxVxW9Onogs52
         gVO7ziDRlXcvtNMBxny051DLhD3FsnCsswWJUj6jfI5qevHXxo+hVQ+ZNxlRKjpQBQTe
         jgqDR2rG+EFTCILuxc1rt1IGN5Zftn6cgzrJrL70ecn9GwqdDFOkWcobcYWLmQQD1HMg
         kazbTLMkNvx0HNiv/0x66lFH7qOaAkOSfQHjFFKu5R+RilCA7hqMR1lUPVaoHCfWdiQT
         1gIw==
X-Forwarded-Encrypted: i=1; AFNElJ9NuSFCkHmNUt3mKobzsrT76WjKYW20M/9VhRGCrLahRSulV8vKuAVg+eLfcMb1bYmjm+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+9XqrqwYAy+xhHGTrTDcoXJd6ArPj250Eec5aiCF9pT+lyOSc
	NfEyEXK+THvgiYXiDRYjKRlpXR1uR4dJnm3OsVh2D7XprxxcfES4sqfsmH+AcRo8VcXVYKswQlu
	bEosCEQ==
X-Received: from pfhh2.prod.google.com ([2002:a05:6a00:2302:b0:82f:7163:35c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:240e:b0:82f:6d4a:df3e
 with SMTP id d2e1a72fcca58-83f33ad8a57mr1146074b3a.5.1778795651528; Thu, 14
 May 2026 14:54:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:53 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-14-seanjc@google.com>
Subject: [PATCH v2 13/15] KVM: x86: Move update_cr8_intercept() to lapic.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
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
index d8dbfb107bfb..27cca31308bd 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2744,6 +2744,32 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
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
index 274885af4ebc..533581d06151 100644
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
index b958521bc81f..1113a31978dd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -128,7 +128,6 @@ static u64 __read_mostly efer_reserved_bits = ~((u64)EFER_SCE);
 				    KVM_X2APIC_ENABLE_SUPPRESS_EOI_BROADCAST	| \
 				    KVM_X2APIC_DISABLE_SUPPRESS_EOI_BROADCAST)
 
-static void update_cr8_intercept(struct kvm_vcpu *vcpu);
 static void process_nmi(struct kvm_vcpu *vcpu);
 static void __kvm_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 static void store_regs(struct kvm_vcpu *vcpu);
@@ -5342,7 +5341,7 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	r = kvm_apic_set_state(vcpu, s);
 	if (r)
 		return r;
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	return 0;
 }
@@ -10583,33 +10582,6 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
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
@@ -11350,7 +11322,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			kvm_x86_call(enable_irq_window)(vcpu);
 
 		if (kvm_lapic_enabled(vcpu)) {
-			update_cr8_intercept(vcpu);
+			kvm_lapic_update_cr8_intercept(vcpu);
 			kvm_lapic_sync_to_vapic(vcpu);
 		}
 	}
@@ -12496,7 +12468,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 	kvm_set_segment(vcpu, &sregs->tr, VCPU_SREG_TR);
 	kvm_set_segment(vcpu, &sregs->ldt, VCPU_SREG_LDTR);
 
-	update_cr8_intercept(vcpu);
+	kvm_lapic_update_cr8_intercept(vcpu);
 
 	/* Older userspace won't unhalt the vcpu on reset. */
 	if (kvm_vcpu_is_bsp(vcpu) && kvm_rip_read(vcpu) == 0xfff0 &&
-- 
2.54.0.563.g4f69b47b94-goog

