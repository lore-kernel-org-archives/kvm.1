Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AA3CEB98
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794283; cv=none; b=P0dpi37WS7EzxeD1L8YpFKexX9EreICrLAqzpfm7izmhS+w4pyg7abVvSeTibswhyVdoiKmfpFLCsshsrcN6w2XzjiD7UpdRmAGEToKAETtqYYOnKt1PQ3cKbs1JBfEsk5C+N0DTJXJRPMpZNO23H309bdIv+SzoIWLNl02n9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794283; c=relaxed/simple;
	bh=jL5IYb03hmKidFINs/UfB/2dGQeYQJrV/+wNelGTthQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MKC6dGrZUvi4BYitoErRVrqJ0Y/fpXGNVyvsFaH/NQ4blfdMcrCf/Qs35Rn+2fdOVRD+dtghX4SNl9nIlXSF5mD2nzhDUwJjAA5M1X1NZjSv1KwpD26iQsk0ccQhFqVRk+0oYpIVbIGlJniyUvjygG+WNWqXBK3ihyukKCWQMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xqs7WrN0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xqs7WrN0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663cbff31cso15132649a91.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778794281; x=1779399081; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NPbCmXIxeXWQqxNfYcnl9k3H40V4UxyT19ETB/rfsj0=;
        b=Xqs7WrN077fyeHOHRvVgNEk1ZuHw4VvWKLKrLUNi2sdLT87OEIMnFRiNu2DzszGmjX
         PR6jBjTyK0f6EKQ+h4Bt1ZtdbCsdBxiEZEFqah8oafgNJVbEegfF/4zCkS1QAj5d1ywn
         aErbMHdbo1sabgIeZslCZLD43s99cC5KCtGwLZgQDIquq54ugaMG8St6jbGVLtjDRJYV
         XHH9yF0RpVZeKke6MANuTBgvnLOqeOeZzfddRQvbqKHzNd4yfVTmCu0KKRefs1OXXvrZ
         HAGnno7PYkNjODRfYasFOYBWA41SJg7MklDl8N4MCbOZ5pY3L3WA50MYJUsxTqzzrHCy
         HGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778794281; x=1779399081;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPbCmXIxeXWQqxNfYcnl9k3H40V4UxyT19ETB/rfsj0=;
        b=MeNTOcjDvZgmv3kywDxH7EYmSfQ3Tgz39r/eazcDrK5GB+qUGMeM8VV8RAMtaK4s7J
         CKa3+tN0qwF1cYUEr7qtTMVfVFszyYbLlEItHgYCOLLYbPSr7gyek2tk4l2ga2cRPulM
         AbvXA7Y8ns3NcrSy4ZpuveHTsVx2SYGyRYixCBiIG8yjHuGF7Bu00zeqhpiX0M6XRjSK
         M2qmfi8SgTmn2E5oteGQBAzMHtxlYNwyYxfa5BWOsBdDZ59231BvIyZdZ+YoOHcTXqF0
         C5EAJCA1sHPv33bTTQVgHgJ6JJz/f4LCB2WgJ2GPhXeZt+d2jLGW9Zc5iGhzKiDm7R43
         lvZw==
X-Gm-Message-State: AOJu0Yz13CI4Pqd43U7o+XG79z4awm39V4L6C59f8dMRVwkvInSYjKVM
	/+oau/jLgIOigdBurLEogFqEfh6NhEXTd0GIUAWoWmBJYA/kLfzSKJHJq+0P1LVDc9mOdZXjSZ/
	pHyqr9w==
X-Received: from pjuv11.prod.google.com ([2002:a17:90a:d58b:b0:368:f2e1:2bc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3dc4:b0:365:fca2:8bdd
 with SMTP id 98e67ed59e1d1-36951778509mr1083170a91.0.1778794280643; Thu, 14
 May 2026 14:31:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:31:15 -0700
In-Reply-To: <20260514213115.1637082-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514213115.1637082-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514213115.1637082-4-seanjc@google.com>
Subject: [PATCH v3 3/3] KVM: SVM: Only disable x2AVIC WRMSR interception for
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
the APM's documentation is imperfect and contradictory.  The table in
"15.29.3.1 Virtual APIC Register Accesses" of simply states that such
writes generate exits, where as "Section 15.29.10 x2AVIC" says:

  x2APIC MSR intercept checks and access checks have higher priority than
  AVIC access permission checks.

CPU behavior follows the latter (which makes perfect sense), but all in
all there's simply no reason to disable interception just to make a #GP
faster.

Note, the set of MSRs that are passed through for write is identical to
VMX's set when IPI virtualization is enabled.  This is not a coincidence,
and is another motiviating factor for cleaning up the intercepts, as x2AVIC
is functionally equivalent to APICv+IPIv.

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Reviewed-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 40 ++++------------------------------------
 1 file changed, 4 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 8e4926c7b8dc..724a45c2aa23 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -124,39 +124,6 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 {
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	u64 rd_regs;
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
@@ -171,9 +138,10 @@ static void avic_set_x2apic_msr_interception(struct vcpu_svm *svm,
 		svm_set_intercept_for_msr(vcpu, APIC_BASE_MSR + i,
 					  MSR_TYPE_R, intercept);
 
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
2.54.0.563.g4f69b47b94-goog

