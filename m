Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A716B3EE1D5
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778093271; cv=none; b=Ko96d5XuQbIUCdTnnGcbaSvTrAWEZTlw+32z3jyXWHIeI5xOcAwlKfy6bfIRY1mY5f7Cs81z7qBeokzvIyBIx+vY7q3OELtE99QNCmF6XYeWeSsQ7Sb1mBLITommp0WBtqiREtOsO+HGWU5SUs/5DR4o93yX4YcNR6BF8iykI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778093271; c=relaxed/simple;
	bh=p7J+uw5b34LLAZnMp4/PcOaObcys1nJtUFFNXeP7F9A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oQ4cmV31eMbAYRijdpIQoxHbmyGSNXrj4QJbx4v3b17OW5tuY5Mtq/LJk23ViRTuTJMsIuD25LnL9NZeRpL1BGEtGY0hpwW/WnYl4Zum694iBhD3g6OU2Wum2yLBqxqmHq6mbzGOIf2JW268MOEFTaFvtRIg3Iw+s241mNVqMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bArDrlL7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bArDrlL7"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8354503d9acso4439516b3a.1
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778093270; x=1778698070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KaRAnm9TWkwtG/Tz6owkNV7zcvQZ21OcGUicttDoqOg=;
        b=bArDrlL7C+uR8GjJwgja6k8AtZqTBPM4d4eEdEsWjc3ol0bUvJFv9UkvQsj/4IknWx
         xHBqlUC2XzA4v4pNFk8gSmvDgHRSfWjDyjWz+0YcWxJO9mj7Ena+QHlHBwgKGBVQ/mOQ
         WmZpC7y9VhQbvxyslR5P4oN9FSN5ztubgKAA/Aa5Jc5gOoZI0ZhMn5E8T16LovHH77Gs
         K4zId4nLLLagao390USo+vUEBs5nVekhFek1LmRw1I5gCIJ9qBTSJH3MZxB4PjVQpSXb
         fcg9XF3oK78X5/Srt5MMZBtJmw/ZXRBsa142Y6/wm/7yZ14zAbIGZqSh5ZQ0WpTIfBoH
         Nt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778093270; x=1778698070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KaRAnm9TWkwtG/Tz6owkNV7zcvQZ21OcGUicttDoqOg=;
        b=hYxVUFPJO9sOwuwf6t31uo5RuYTXrmgUGDpC9CIv+A1qKqTRbDxFyXQP5dymLlkw7U
         emi+YEYfq7ipOckDfjYerN1Rc1Kxx70hUhZIVM0f4kZb9HEpJklQCxd6Dw9x2sxRYRDa
         Eh/voHwSFRQzYOeOOvw3UMJ7uhs5fmj2b9/fVDSVECndH/e7+5x+fJHLBk7a+whiZjgx
         4hweSljXaJoDwY6FdLZmPZPS1xniZtXSTGWBn0essXl9nC6XuNjGj348XY1MhwHaFkkd
         2RNvQ9ZLpkQT2WgeJA7FnbE2GX4hcK1+PtX/0HjPhiJyXZFgOK0JcvtQEgU3DaoCCP2A
         wLJw==
X-Gm-Message-State: AOJu0YzNv76OBb7z5pM850gg+1hW4UjsLNmHudMrwx4IX0xVf5A+7AxP
	EL2efP7dGwfGi5ktBFdSgy8l8YJ8HBByZDeBeKXI8ETE0vcqIo2B7rq3wDefFvqZRj699NDoOfy
	Xxp99DA==
X-Received: from pfbio7.prod.google.com ([2002:a05:6a00:8e07:b0:82f:7220:86e7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4517:b0:827:3d52:5d1a
 with SMTP id d2e1a72fcca58-83a58a2afc1mr3885578b3a.0.1778093269727; Wed, 06
 May 2026 11:47:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 May 2026 11:47:42 -0700
In-Reply-To: <20260506184746.2719880-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506184746.2719880-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506184746.2719880-2-seanjc@google.com>
Subject: [PATCH v2 1/5] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs
 KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix multiple (classes of) bugs with one stone by using KVM's mask of
readable local APIC registers to determine which x2APIC MSRs to pass
through (or not) when toggling x2AVIC on/off.  The existing hand-coded
list of MSRs is wrong on multiple fronts:

 - ARBPRI isn't supported by x2APIC, but its unaccelerated AVIC intercept
   is fault-like; disabling interception is nonsensical and suboptimal as
   the access generates a #VMEXIT that requires decoding the instruction.

 - DFR and ICR2 aren't supported by x2APIC and so don't need their
   intercepts disabled for performance reasons.  While the #GP due to
   x2APIC being abled has higher priority than the trap-like #VMEXIT,
   disabling interception of unsupported MSRs is confusing and unnecessary.

 - RRR is completely unsupported.

 - AVIC currently fails to pass through the "range of vectors" registers,
   IRR, ISR, and TMR, as e.g. X2APIC_MSR(APIC_IRR) only affects IRR0, and
   thus only disables intercept for vectors 31:0 (which are the *least*
   interesting registers).

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..4f203e503e8e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -122,6 +122,9 @@ static u32 x2avic_max_physical_id;
 static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 					     bool intercept)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u64 x2apic_readable_mask;
+
 	static const u32 x2avic_passthrough_msrs[] = {
 		X2APIC_MSR(APIC_ID),
 		X2APIC_MSR(APIC_LVR),
@@ -162,9 +165,16 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!x2avic_enabled)
 		return;
 
+	x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+
+	for_each_set_bit(i, (unsigned long *)&x2apic_readable_mask,
+			 BITS_PER_TYPE(x2apic_readable_mask))
+		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
+					  MSR_TYPE_R, intercept);
+
 	for (i = 0; i < ARRAY_SIZE(x2avic_passthrough_msrs); i++)
-		svm_set_intercept_for_msr(&svm->vcpu, x2avic_passthrough_msrs[i],
-					  MSR_TYPE_RW, intercept);
+		svm_set_intercept_for_msr(vcpu, x2avic_passthrough_msrs[i],
+					  MSR_TYPE_W, intercept);
 
 	svm->x2avic_msrs_intercepted = intercept;
 }
-- 
2.54.0.545.g6539524ca2-goog

