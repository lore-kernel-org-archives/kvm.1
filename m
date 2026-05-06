Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6204C6F0F
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093274; cv=none; b=l7ok4eA22TyfQD5k0NY3XxQXQRKUfJ1lSRHuldmd+MGXhZQ22HA5pFLUOQlS2rkaxObwknuJEFHtOsS+lnxz+NRp5CdHUn3k53X+Y4aOUF2UkHSWHr8dPXZ/1cAOjQgT9MCW3ZGT3HWppPc1VWBfDOx0QhnS2NWx2YWAPmsar8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093274; c=relaxed/simple;
	bh=rJa6lpv99o22Bt4dXSV76XbqnvBJ85dX4+BN7GlZQA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J5AEMrr3TopmN7GWftscg+2jaglSS/QnXNvf4NkE8m8TQIM/S44kq8dDAxpm8k+VdAh6HSXp33bVlp87O3wxYYMvojcZOwDC+Oi7sPrLLjC5fGB7SIUmVRvVgoXHmLeOBqcpxq4UCQjyV0yDwxx6r7quqClt/XyIyJUYpgXjxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abTJAuNu; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abTJAuNu"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso4387078b3a.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093272; x=1778698072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SF+FXtPBkIquBwi3EFTY4HPFR9y0EyGhb7WDhn4cHt4=;
        b=abTJAuNu79+VmncJY0RJSg43zLuy6ZBCsUJLfxTOvG8ZrIHSxuVj+LWJ0Wi1HJ0Kfs
         M0uun6R89ci2EyI2UnZD6qAjK2vIEJZyDo7OMDivsdNl1NUmiI1qgo5dueh//6jg/Uy2
         maGT0tYpXBb9LBt0SyHmyTb2bj/R9QeWdS/0MaTKNIAp1WEeOrlJKR7wWhC8HnQvNyNl
         FpBRwL9uhNkcoDDeeHrMGtnNRZ0HDrYxDC79+s/NWVgs3+7A8LOXusJUEE9SYw0Ojp6c
         cDLf0DHy08jUKjQ5d9gilOf5MSyxc7eHb2MdzSm7px3/P+XDJjOwmi4evx3zYUEcx+X3
         fyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093272; x=1778698072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SF+FXtPBkIquBwi3EFTY4HPFR9y0EyGhb7WDhn4cHt4=;
        b=kR9pXg+MUdzmLn++5+URdmU9k7nQN3IjC5wzdufkKGhmyt6TNzafZFiAg5mONfVDvw
         aD0UzKv4VIbFIt503dcTKJsG5qq2Uzt3rCpynptaYsROpnr3TwnvyjkziLASXmhUGUtA
         vSL+VW35eAy8//fLXw4brs+8WHXmY8k7J1EfV1N6Lrz3y9emxbRvsBfFJX5BAtJ/I8n6
         z3Qvp7leiQd7CJJXZThECLDHPYG4DdM5sTEoeoN2X/lwvpZuvZa7YetxuKVnSO6Zsjoy
         waDnvIYPVp2t5x1JOvwzC3pGgt6Fak+qrdlyBPTmKnIutj6BiskS30GbOMFiiNEAxs9q
         uGRA==
X-Gm-Message-State: AOJu0YyO6uVoSV+DC10npMMk9R2VkJBmaRP4TjtTIG0Mtyj9bsiz5uZt
	ScdiQg3HiSjqQTMMUOMMzyt3rynq/s8wOdpXlmJNkwEm1/9TM3lrUfeljes0iyJLn7/Iw21SpWT
	p+27dXQ==
X-Received: from pfbgg26.prod.google.com ([2002:a05:6a00:631a:b0:837:7965:c70c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94a9:b0:83b:40c8:6de4
 with SMTP id d2e1a72fcca58-83b40c872c5mr1416365b3a.28.1778093271951; Wed, 06
 May 2026 11:47:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:44 -0700
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-4-seanjc@google.com>
Subject: [PATCH v2 3/5] KVM: SVM: Only disable x2AVIC WRMSR interception for
 MSRs that are accelerated
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
actually accelerated by hardware.  Disabling interception for MSRs that
aren't accelerated is functionally "fine", and in some cases a weird "win"
for performance, but only for cases that should never be triggered by a
well-behaved VM (writes to read-only registers; the #GP will typically
occur in the guest without taking a #VMEXIT, even for fault-like exits).

But overall, disabling interception for MSRs that aren't accelerated is at
best confusing and unintuitive, and at worst introduces avoidable risk, as
the effective guest-visible behavior depends on the whims of the CPU (the
behavior of x2APIC MSR writes on at least Zen4 doesn't match the behavior
documented in the table in "15.29.3.1 Virtual APIC Register Accesses" of
the APM).

Note, the set of MSRs that are passed through for write is identical to
VMX's set when IPI virtualization is enabled.  This is not a coincidence,
and is another motiviating factor for cleaning up the intercepts, as x2AVIC
is functionally equivalent to APICv+IPIv.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d693c9ff9f18..c5d46c0d2403 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -124,39 +124,6 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	u64 x2apic_readable_mask;
-
-	static const u32 x2avic_passthrough_msrs[] = {
-		X2APIC_MSR(APIC_ID),
-		X2APIC_MSR(APIC_LVR),
-		X2APIC_MSR(APIC_TASKPRI),
-		X2APIC_MSR(APIC_ARBPRI),
-		X2APIC_MSR(APIC_PROCPRI),
-		X2APIC_MSR(APIC_EOI),
-		X2APIC_MSR(APIC_RRR),
-		X2APIC_MSR(APIC_LDR),
-		X2APIC_MSR(APIC_DFR),
-		X2APIC_MSR(APIC_SPIV),
-		X2APIC_MSR(APIC_ISR),
-		X2APIC_MSR(APIC_TMR),
-		X2APIC_MSR(APIC_IRR),
-		X2APIC_MSR(APIC_ESR),
-		X2APIC_MSR(APIC_ICR),
-		X2APIC_MSR(APIC_ICR2),
-
-		/*
-		 * Note!  Always intercept LVTT, as TSC-deadline timer mode
-		 * isn't virtualized by hardware, and the CPU will generate a
-		 * #GP instead of a #VMEXIT.
-		 */
-		X2APIC_MSR(APIC_LVTTHMR),
-		X2APIC_MSR(APIC_LVTPC),
-		X2APIC_MSR(APIC_LVT0),
-		X2APIC_MSR(APIC_LVT1),
-		X2APIC_MSR(APIC_LVTERR),
-		X2APIC_MSR(APIC_TMICT),
-		X2APIC_MSR(APIC_TMCCT),
-		X2APIC_MSR(APIC_TDCR),
-	};
 	int i;
 
 	if (intercept == svm->x2avic_msrs_intercepted)
@@ -175,9 +142,10 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!intercept)
 		svm_enable_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TMCCT), MSR_TYPE_R);
 
-	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
-		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
-					  MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_TASKPRI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_EOI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_SELF_IPI), MSR_TYPE_W, intercept);
+	svm_set_intercept_for_msr(vcpu, X2APIC_MSR(APIC_ICR), MSR_TYPE_W, intercept);
 
 	svm->x2avic_msrs_intercepted = intercept;
 }
-- 
2.54.0.545.g6539524ca2-goog

