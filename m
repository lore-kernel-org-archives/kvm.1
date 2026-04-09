Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B864E38F940
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775773495; cv=none; b=bpEl9Q1z+X04zJQMQewdnYVoRN4uV8U/r21SsZ1hOinX14/+FknSuPFtyc/wk/3BBqo7D6wqIFZWVXgEb39a0YHgI9ZT+Wz6d4oh+CKNE74flECt+H7dX6W0rSk92dlc6KQjKxTolDAFLm67jhlKddADHCAk1GTfZixHDNiHsUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775773495; c=relaxed/simple;
	bh=aDwH+MMYXaOvmnW6sjqONolO2mDyDJseqaYwCrZzXCc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PbGGWz2aZtNdIHab1W5Ram2lIUX9Zp2qjulmmASVB929zVmL8rdrTzHFgEZDFdavrqzB+DrNbSFj5WZJPFV+f1zTjchJ6Fe/dP6KITdM4E7Agwz4UfRfKNFNT6QquRpXn6HHRM7xSnx1jDafFNjHHZlT3c/emXoNWfLQu+ndJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M48zMlM9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M48zMlM9"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso2984965a91.2
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775773494; x=1776378294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=voCuk6N+Zbgqw6oi0f6cUzYlY+mVhATQs0grs8oy33k=;
        b=M48zMlM94N3uorFv8a6RoQHAR2vjrNO+4h34ssYOisJv+COAdeETCetGUew0o5Yp3X
         Jp2NgDGMQZbGtbxCQudfaw6NIHROTYVF38P4C6cnzb73vpj9ub1BI+/IhaBgpmv1TR7j
         dYOhViZeoohCvOqvxQE0ioNSsCuPJGVV9RFJDnO8MK4S+UKnNDPvpsHRn3VBzIerrsFE
         eGcKhnv9KF8amcEoZDlT/BSZJD70fmxuBBnL0OrjsrwbcWS4vE+nbvi16hLCitb5jMAw
         9BP3KzCx5l4rqlaiODql61aggHa5CAyzrJsormipspIk41Swr6TE8HAIHP3osJeK3pOP
         SxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775773494; x=1776378294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voCuk6N+Zbgqw6oi0f6cUzYlY+mVhATQs0grs8oy33k=;
        b=PqXitaskSsOSBHP6k+Zf1n4Q9t1NRB8GhUCt8bcaQGc7w5wZ+z9Kh4wSnRC/9M938q
         U5zh6/Wjzl6U5RrPYRW+fLbkbDWaQlWWm06c4MKSDR5J2a3PK/dM58bJyyK5CJ+ZV5Hr
         Ry+oKFMvhB8/4Rf5vO1NDlSaOEEGtkRVmYMhv2qtuPgS1riAIsMDAPx2h1ZBNT3dd/AX
         XcgTVNFFCBVlya13/R333Owk+yOV8l0yI0c38zIg4eBx00uYjxR9RIquSny9/Vej6n5Y
         H5M9zVMhwMyHpllM4XCVpnL/cuhP0d67JYnpGatknuXlS0YYj+PvdbaRFcU08UzYaBZY
         ffWg==
X-Gm-Message-State: AOJu0YzaA0N71QK5D10kmfBTWejno28voLCjFOGf6nBTmj76Rt+83D0x
	rXlXNvyncAhz9itJfeH4j1y3WUjdr+GzEheMqiM01dHNEr49ukCTkDhEcQi75GximljSyNsreOf
	Yvsd8OQ==
X-Received: from pjbcp1.prod.google.com ([2002:a17:90a:fb81:b0:35d:972a:7f6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b49:b0:35b:ea35:c3ce
 with SMTP id 98e67ed59e1d1-35e42867ce0mr710269a91.27.1775773493865; Thu, 09
 Apr 2026 15:24:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:24:47 -0700
In-Reply-To: <20260409222449.2013847-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409222449.2013847-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409222449.2013847-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs KVM
 actually supports
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Fix multiple (classes of) bugs with one stone by using KVM's mask of
readable local APIC registers to determine which x2APIC MSRs to pass
through (or not) when toggling x2AVIC on/off.  The existing hand-coded
list of MSRs is wrong on multiple fronts:

 - ARBPRI, DFR, and ICR2 aren't supported by x2APIC; disabling
   interception is nonsensical and suboptimal (the access generates a
   #VMEXIT that requires decoding the instruction).

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
 arch/x86/kvm/svm/avic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..df974ee290d0 100644
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
@@ -162,9 +165,15 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!x2avic_enabled)
 		return;
 
+	x2apic_readable_mask = kvm_lapic_readable_reg_mask(vcpu->arch.apic);
+
+	for (i = 0; i < BITS_PER_TYPE(typeof(x2apic_readable_mask)); i++)
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
2.53.0.1213.gd9a14994de-goog

