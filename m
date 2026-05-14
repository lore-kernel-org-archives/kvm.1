Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F633CDBAA
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794282; cv=none; b=kxLlemKXK5MJWg4zRrnnXaaa0cAKLNk0Zaa8rK/2UFvWcod/LHZhSAQtbRooIuK0l6p5tOatd/irsnQPivyCbVk9C+52fdDRxXD1YHKA2AXUzs4JampgmGLSacMJMGb6F/O1BLV97++kKZU6f4wk6Teo63oOD6vY4W6h0Jt2Oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794282; c=relaxed/simple;
	bh=nnXXn09j1ksj4LKsVJcu4ngNhykURiZr/EZcfzQZh2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ud8A6yisruskJ1Ciro9Oer9lNgyHGRIUq6hoIOrqINzXPjG+zpMTdY7MrqKDiRuGjxHdjPMsbegbz6OhBS4MYnAEsnWnRRdTPSIX2F0KpVtydV+sh21di9gb9wSO85gHWu8XVSBxzFgKIlcpF2TxLvBSEooFEjclNlyYAO1HOOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpKWy5Is; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpKWy5Is"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso5336341b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778794280; x=1779399080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=W8XSmdIGAkJ060bjV22HpsDNJp+6MFB13DB5rwFbE4w=;
        b=YpKWy5IsYih2ObjV/T2gmjVRYGHm1HxDdToGNgp+CQoLqxW6tp0es0jey3HteKNYSh
         gYFWAklGlNfRYUOWQ9wY9NzZ1DXC7ot1FzHPbBAC1tKMkO6EJ91tvAUm5mf1B1pW9MVl
         fO8yVQTJ0PcY24RRgpEEuOzms7wxJGZu5l67ypiGk+zZ3w9VcndOENBP1mczv6hg2uIM
         8ufd9iY9Ht/723hEoeymHKPAVi276QI4vAwOHFO9tua2TvtT1nx1kQi9FDXYQUf9Qayx
         HIb1rBxG5duCcAVKmvHU8dMCgU4IWfdaaJyHYyuu+E1hU60P9ok8nWZ1uMN1jpggDHgG
         Ohwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778794280; x=1779399080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W8XSmdIGAkJ060bjV22HpsDNJp+6MFB13DB5rwFbE4w=;
        b=XhphzOd3IqayR5QtskVi5JBBjTV87M1ryPxImn6tGqQQotEG5hsg+JQz1GgJF82xxf
         Jou5Mk9hOexddEZLxfAv0ZPOQr10N794R9R6HnlgOm3hArhRKWwwzdtvifPHHgQwZPS7
         s9kwoLzmKTLyvcdrk+5aszKzdvRc+ykKOhmZuuXo/fnje8OkqqOCSe+ahulFEnTpScKv
         yZOPZlPttaZeQBFay60BhM+aEz1ZM4WoQ4hPTqYDVS6cxiCGWLwpgBuTA8j4CijezSdv
         sRbXjUnLTPi6kG3wCTAocryQECtsM+IuxCJHZrnr6H71805eWE1A8DfK9wIrkAjLvV+n
         FuVA==
X-Gm-Message-State: AOJu0YzCD/UN0SFhEA00D8jvH8OXVBPkgdpAYAd1b0jX1/+HtnYUqhxU
	I1qQ1M02TpWXNAR2dm2csWKqZh2A2h77xapw+kr/GI6Dfxo//DHROWqhNBUenl81MwDu5eM/WT0
	CAnL1iw==
X-Received: from pfhh11.prod.google.com ([2002:a05:6a00:230b:b0:82f:8afc:f74a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab0d:b0:838:1c71:bc7d
 with SMTP id d2e1a72fcca58-83f33bae2d5mr1187298b3a.3.1778794279515; Thu, 14
 May 2026 14:31:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:14 -0700
In-Reply-To: <20260514213115.1637082-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514213115.1637082-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514213115.1637082-3-seanjc@google.com>
Subject: [PATCH v3 2/3] KVM: SVM: Disable x2AVIC RDMSR interception for MSRs
 KVM actually supports
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When toggling x2AVIC on/off, use KVM's curated mask of x2APIC MSRs that
can/should be passed through to the guest (or not) when 2AVIC is enabled.
Using the effective list provided by the local APIC emulation fixes
multiple (classes of) bugs, as the existing hand-coded list of MSRs is
wrong on multiple fronts:

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

 - TMCCT (the current APIC timer count) isn't accelerated by hardware, and
   generates a fault-like AVIC_UNACCELERATED_ACCESS #VMEXIT, i.e. requires
   KVM to decode the instruction to figure out what the guest was trying to
   access.  Note, the only reason this isn't a fatal bug is that the AVIC
   architecture had the foresight to guard against buggy hypervisors.  E.g.
   if hardware simply read from the virtual APIC page, the guest would get
   garbage (because the timer is emulated in software).

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index adf211860949..8e4926c7b8dc 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -122,6 +122,9 @@ static u32 x2avic_max_physical_id;
 static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 					     bool intercept)
 {
+	struct kvm_vcpu *vcpu = &svm->vcpu;
+	u64 rd_regs;
+
 	static const u32 x2avic_passthrough_msrs[] = {
 		X2APIC_MSR(APIC_ID),
 		X2APIC_MSR(APIC_LVR),
@@ -162,9 +165,15 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 	if (!x2avic_enabled)
 		return;
 
+	rd_regs = kvm_x2apic_disable_read_intercept_reg_mask(vcpu);
+
+	for_each_set_bit(i, (unsigned long *)&rd_regs, BITS_PER_TYPE(rd_regs))
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
2.54.0.563.g4f69b47b94-goog

