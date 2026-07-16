Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C73D9DCD
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244334; cv=none; b=re7E6OUfponLVAscZEUP3bA23pwMaM7clJNjWPzHbAiPh/+Y82pxvXiV7WVHKDf1+o6vLqstHH6HMxORo7IT0PV+Ut006ZYnwzKtip4LYqoaalZh0B/SgFtsUBt0xpCy6d4w7piNUzogLd7xldfL6RKMlaleK2iPtobCW28/XXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244334; c=relaxed/simple;
	bh=6TvaU5yRFG+wd9N+3J6qrtOUCW9AU/SJMy509bOju6Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eu+Ht1uJNGt+FDwRdr/od6TXjhpPIqaCpvyY9qBwOaSQn1nqHiu6YjPNLQNSFwFPwW1yuemS94vjtx6Vjn+wyvcQ/V0EhJ1qhYhKNLh5reFdBGmKEcJ+KGfuJK6Qc9N96gMnOtiPsv7Abi4Pg4dydUDCoqWLnz4DLbejzhCirfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hBLQZ8Bx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hBLQZ8Bx"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-38127ae6b99so1423865a91.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784244333; x=1784849133; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RC/IB/eOqx2bXjdUW+O6U555+IPWSr9bP6zMmFexm7o=;
        b=hBLQZ8BxBB3NKDe6eN3SR7647j0SapWmioYAplC8dpaOE1JJw7WRkicnWuqLQ2/FWZ
         m3VeNDQOMkQzfJTqiTmDMoIcjgXfFGP9VBcvJCRGXyooSTz5KYty0o+DW8UCVx7OOxvV
         1ICJcgfr1HThR3yTEdOYEJx13l1asVx42p7J7WnUgckgF8Gwvi9wzfhkrvQaENYQuEs2
         NFJ//f/agfzXx7oDWdK4XkMn21Suj5Kea2yKPBNVz3wrzAajXxP1I268sxA/rzOhpaz4
         IAk1i7OtxCu7/rguy9rCceGEjW+uRh8Ot82BYZvLE8iKA9d93qFI/PWyoRcz6d++SQ35
         7Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244333; x=1784849133;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RC/IB/eOqx2bXjdUW+O6U555+IPWSr9bP6zMmFexm7o=;
        b=emmS22VXCg8VjC1HcDIlc0TBuf6U7v4mSF9/rwK3YF5p1IB/rp3+ccfe46RrkmrEp6
         jWOAUddJqxkbhbiJHuk1sIMfAj3OigloOWcaWlSOrfrQZdSCtZdJBhNAN5ORZnkaKffw
         0eGDLRGkFdXJCBlxA34Xiat/r996C0thWCOCglhuQp23FvpkSRCWKIpfgO/HHeVSMnnG
         Tghmya2x5w7GF6riVIIeTrJ51mIudd4FW40U7XAuTKeUKnSEf+vpJGIwl/xCkDVbl8hk
         f5gMarHSWFLcfK4ZSHCwVtyvrsbyulObfUSLJi43gyqCszt7e+HCZA/+J9uR0Hnjo0I6
         vQ9w==
X-Forwarded-Encrypted: i=1; AHgh+RpWqf5oODh/6wW9OARxclQi/IW0dTxw18D9Bt/39JjXVpfS6c2Q+rvkgmsoj6fsHOmjdPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpz3LnuXE56Gnj9qE0+UB5VgsXM6J4+/IkZhPc6/qW2UiZ7Esp
	D5oHSxgSQ2hUINm3mJZxrf525iiQql8WlxCU7x4q2toXTH82UB7GHfwUiX7JYQ6VPwIPq/pve65
	6Aqt28gfdU0FmTg==
X-Received: from pjboj17.prod.google.com ([2002:a17:90b:4d91:b0:381:dfe0:e5a3])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5644:b0:387:d5bd:622e with SMTP id 98e67ed59e1d1-38e4b6828cdmr74564a91.17.1784244332530;
 Thu, 16 Jul 2026 16:25:32 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:25:23 -0700
In-Reply-To: <20260716232524.2092085-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716232524.2092085-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716232524.2092085-3-jmattson@google.com>
Subject: [PATCH 2/3] KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@amd.com>, venkateshs@google.com, yosry@kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per the AMD APM, ERAPS clears the Return Address Predictor (RAP/RSB) on all
implicit TLB invalidations (e.g. modifying certain CR[04] bits).

Move kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS) into
svm_flush_tlb_asid() so that any ASID-level TLB flush marks ERAPS dirty.
Centralizing the ERAPS dirty call in svm_flush_tlb_asid() ensures that all
ASID flushes (flush_tlb_current, flush_tlb_all, flush_tlb_guest) properly
set ERAP_CONTROL_CLEAR_RAP on the next VMRUN.

Remove the now redundant svm_flush_tlb_guest() wrapper.

Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b76c6a76ce37..2514c6516fa1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4168,6 +4168,8 @@ static void svm_flush_tlb_asid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
+
 	/*
 	 * Unlike VMX, SVM doesn't provide a way to flush only NPT TLB entries.
 	 * A TLB flush for the current ASID flushes both "host" and "guest" TLB
@@ -4226,13 +4228,6 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t gva)
 	invlpga(gva, svm->vmcb->control.asid);
 }
 
-static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
-{
-	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
-
-	svm_flush_tlb_asid(vcpu);
-}
-
 static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5380,7 +5375,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.flush_tlb_all = svm_flush_tlb_all,
 	.flush_tlb_current = svm_flush_tlb_current,
 	.flush_tlb_gva = svm_flush_tlb_gva,
-	.flush_tlb_guest = svm_flush_tlb_guest,
+	.flush_tlb_guest = svm_flush_tlb_asid,
 
 	.vcpu_pre_run = svm_vcpu_pre_run,
 	.vcpu_run = svm_vcpu_run,
-- 
2.55.0.229.g6434b31f56-goog

