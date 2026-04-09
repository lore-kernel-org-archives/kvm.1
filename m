Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C33909BD
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773499; cv=none; b=lqo/EIA7EDWphBKK7pN2ha6sOgRhNeZWirjX/OA8VSy67+XAMfdbIX01nhVxyo0a817s7g7QXES8UenXIufEqWGDBOgruQuTZvy41+QK/FQ/ICZCvmiVogHn+ZtdHRAJke8M1U5M/RC98+HvBmDfUiCz78SkTr8tRl3f1I53Glo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773499; c=relaxed/simple;
	bh=I8WW17ZPIO8KJkzIrv6QGMTSkBehnNdCs/gQSTd6No0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G+tg/JMRBtq3lvj3u1EyMaMgjX+QIvW9AUuDBUxa3b/qJn5mbTmUdXyf2AgMrBtPPSOJCbo5oCFmzkzw0SePERvJXfzq6x15yIqQCvBkx1JAsBj84pEz4AjwTuP9U5Fq+LyC1G6exwSIG624xfu2deOc8VUx5LUPKhmsF/iSR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmtnVA65; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmtnVA65"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b249975139so30527655ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775773498; x=1776378298; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4DK2SGPGgi94zwO3TzmcQCMtONLUKFf74w9+rXmgeZ8=;
        b=AmtnVA65pmGezIpzu44cveUfLV/sLHp/x4K98jMrNpih3ka6eMopKfUdPOT4xQBgkB
         F5gyAcNlB7PY0tiRbgQNln1N4QHserzNL6Rs+gdVYTbJZ0y7r5WiPDl7HmPQVWA5SRee
         Tane5Mi/Kgzx55KobcmpCDt+y7KNFjS45J8K1QgdpMcOnSKQJnha5C833J0oFKFCqStp
         HJFosn82edy5CAWsBE7yDZaZ/pNnFH6yWYVQBaW/DnrmTFT22BK2ANoewJF7AcBA/lkj
         qJ1CfZkIiEwMB028MfxsHyNEbtLMBRu5Y2PwjsPcIN2FXmzF/9IYwEzs4JoE06sgxReB
         8fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775773498; x=1776378298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4DK2SGPGgi94zwO3TzmcQCMtONLUKFf74w9+rXmgeZ8=;
        b=n2LXocISwnyO75p/ztLnl9RAUt7TMcPWh8spYoT/NqJZz8AC1PoXFjGI64qHFqtVQT
         z7/x68utNIYDjcwjRGE7gKHjoTIr7Dli/F2xD+/H0F5tIaHe+jxI9mb2Uwh+g1xT5lJV
         WORBx+L0wi0olBNiDEiMQxsI6FGeJu2cP+aSgDpCdMjalLGlFMsEQW22irFCtH3SxxAL
         m2XQojATA9hqH/vIqO6HXkesy9gF5/SK0vlwUimOUvbjBSyY1b6ST9ijyF2j5hdrj8Ij
         CDtEblIuGRKqq0/zxJrNew16uzbQqlf7fwavx6GynDedTizQpU/jt0M5Zkl++W0rR3lo
         72EA==
X-Gm-Message-State: AOJu0YzRj29opKmPxOZvjXpQ9PyE9IJOgUV3O2EOyKfzttwBcXelwmAu
	fvXqBRk0gFk2EGOhkwZJjPfedyZioy4phiyEQKocWFOkdOD/c0rXhg1RPdCDSvnvhMX2MvX2SYt
	3sOgKrw==
X-Received: from pgac8.prod.google.com ([2002:a05:6a02:2948:b0:c76:651e:6d72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7292:b0:39b:d9f1:6d00
 with SMTP id adf61e73a8af0-39fe3ff1405mr731014637.43.1775773497504; Thu, 09
 Apr 2026 15:24:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:24:49 -0700
In-Reply-To: <20260409222449.2013847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409222449.2013847-4-seanjc@google.com>
Subject: [PATCH 3/3] KVM: SVM: Only disable x2AVIC WRMSR interception for MSRs
 that are accelerated
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When x2AVIC is enabled, disable WRMSR interception only for MSRs that are
actually accelerated by hardware.  Disabling interception for MSRs that
aren't accelerated is functionally "fine", but very suboptimal as many
accesses generate AVIC_UNACCELERATED_ACCESS fault #VMEXITs, which requires
KVM to decode the instruction to figure out what the guest was trying to
access.

Note, the set of MSRs that are passed through for write is identical to
VMX's set when IPI virtualization is enabled.  This is not a coincidence,
as x2AVIC is functionally equivalent to APICv+IPIv.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index c9e9872ad880..2b07cc347b90 100644
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
@@ -174,9 +141,10 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
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
2.53.0.1213.gd9a14994de-goog

