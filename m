Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539948;
	b=PmbE6cDkKRV87FuB+cgw0GrNCMU/Dq6I/Ab+q4UoU7nmEbyOxtJmO2lcJR0TTzF0fLeN
	 N34VoOiuxRop0fD/DlWdfImZIUcR3xtKwRsnFcZFddGg3FkcJMXpYKRpPd5oL0UXJhWYy
	 bTAkHRCY5GsKnVcu4RKEwGaPjAAYNvQsmj3Ed/RKBnBncXUApGF4oGbTtaa7J0W8UHG1F
	 lmilK0O9ggnDqjBjpx/rS8LBbT3JDERguxIbvhKwzZMAq5/f2huk2LAKXYh/P/21rWWD1
	 0opX4Whx/nwU0NLyfV2ayfkcthk2LfcrY30ieIQrHmBi975K/6YeUoLG5ki7oXyaNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
	b=dcln9deXRr2O0M1O99CvZ/0VjX9nPhOY0b2ENYy8P9gJrfPDGO/O5gcYGG4v95DzczLk
	 denpLysaz22zlV9pTjKGv8svNlCbjJM5Q19y3ihUfl/yt9DGf9rhb0+dNOq6M+1yy0Ajx
	 fCjrene+45n9c7Kedk+yQA/eF2tdknOjJWpdI8md/0impo0QX+Xr98dxdoUTYGg+e/10Z
	 ebscCWigMU8uM6RV6yI7clSQAQXSmcZ0WpJanTc6qmh6tE3ebscYUz83gNUKp9TII89HR
	 eeN3OGCf3VEFKU8rvG7/QTOFtrvwOsgrrXdthEPXVbGlTUoYX98jTk+gQ/rFjkZJ5qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SjZc4EnG;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF7606A332
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0AF7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SjZc4EnG
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df8484f12cso1108735ad.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 16:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792539947; x=1793144747; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
        b=SjZc4EnG/LgcnRtcUFPZUGudsMzD4xQ5n13Nno+UwiSl4dyeXWBIHERfQHW+y6hBu4
         f723eEuF8Q6m4yKLUewpE0nKrj3WtsuKY37dP0ZqmjQrjSL32s7HbXTnufx4CdDEiobi
         OIPaLktQunnmExsvcC/VwdY3N+P3qt4l0DNL1d/7trYcJA4IfUXxPD4Uaf56YY9W4bhz
         25lX+HTTxFNnFFmP3KuzDqo5gArsAdWyCGvySB+woNpFKWmFIicUfin0PTVv2YWzl3lO
         qZmjsWTwwPmiDWeOHjJBa6VYO2NBT9YLw3FATOXtAQmumBErIXuHgWuSJ+4GkC2w8hHw
         3Frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539947; x=1793144747;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+TfMg64jOFPKI8BrWsSCAubaYF+Edkz42TVHe5mp54=;
        b=ujfHxIneLEiIRVtlCPaGxS2mcIznyUUMFWqhGktUfFI0NyBrwvqsAqzulmuKtKXDIn
         7PJi0SACbFJ9Uyl1O1GV875mue5JfPVR5phaAzbjB37Lb9gdAH1SSVsNiXY9L8wIg1I3
         DF+7TwrM38KCO+wHo0fxfdCLtpeBBjN7bkEV+B0EeAZ1mavsORDmlHNVbQbSmEltswxg
         1u7RVLyaPjmKBpolsIlqlZnnvyva8uvvDHK2o+MCZ7LkSkk6NyBGqDteOrACzJq7Gahz
         OTQUz4w84IvdWmK9wq2zVYjcDzO/HXRzj+OZw41rW++wHtbGSAktVnISLqTz/K59+6xp
         S4yA==
X-Forwarded-Encrypted: i=1; AKwUvByDugd7nf1qX0NTdc0nWgd6YLdov6apd+fmxX+cLwkeNNrJOtLgb5XCum4TMSDj7m5LwFc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLOm6p/cjMXJSoIGLHgrjsNtHV17Yda7MeK7Xvj2GLu01erD6JY
	cBba4flwmtLTthLLj9UMScMr7n4+Xm8y6HKpeCajWdpJyXCTj5VopXOcvv3xqYXOVme60E7u0sR
	TXb9sUYybIBmMoA==
X-Received: from plbkk5.prod.google.com ([2002:a17:903:705:b0:2e9:7e8e:b72e])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ebc6:b0:2dd:ad73:c98b with SMTP id d9443c01a7336-2ea43f928abmr2553835ad.35.1792539945981;
 Tue, 20 Oct 2026 16:45:45 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:45:27 -0700
In-Reply-To: <20261020234535.3182385-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020234535.3182385-2-jmattson@google.com>
Subject: [PATCH 1/4] KVM: SVM: Always update LBR MSR intercepts on full MSR
 intercept recalc
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the "already up-to-date" check out of the code that writes the LBR
MSR intercepts, and write the intercepts unconditionally from
svm_recalc_msr_intercepts(), so that changes to userspace MSR filters are
reflected in the MSR permissions map.

svm_recalc_msr_intercepts() is invoked in response to
KVM_REQ_RECALC_INTERCEPTS, which is raised on MSR filter updates.  But
svm->lbr_msrs_intercepted tracks only the interception KVM wants, not
what is actually in the bitmap after the filter is applied.  If the LBR
MSRs are passed through when userspace installs a filter that denies
them, the early return leaves them passed through, and the guest can
access them without exiting to userspace.  Conversely, if a filter
forced interception when LBR virtualization was enabled, relaxing the
filter leaves the MSRs needlessly intercepted.  Either way, the bitmap
remains stale until the next change to LBR_CTL.

Full intercept recalculations are rare (e.g. on RESET/INIT, EFER.SVME
toggles, and CPUID, PERF_CAPABILITIES, and MSR filter updates), and
never happen on nested VMRUN or #VMEXIT, so writing the intercepts there
does not reintroduce the redundant per-VMRUN bitmap updates that the
check was added to avoid.  And because svm_recalc_msr_intercepts()
already unconditionally writes the intercepts for many other MSRs (and
thus marks Hyper-V's nested enlightenments dirty), writing the LBR MSR
intercepts there doesn't introduce any new invalidations.

Add a comment to clarify that lbr_msrs_intercepted reflects KVM's
desired interception, not necessarily the state of the bitmap.

Fixes: 3fa05f96fc08 ("KVM: SVM: Fix redundant updates of LBR MSR intercepts")
Cc: stable@vger.kernel.org
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 28 +++++++++++++++++++++++-----
 arch/x86/kvm/svm/svm.h |  6 ++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index fe0cba4731b2..55b3ee840365 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -721,14 +721,11 @@ void *svm_alloc_permissions_map(unsigned long size, gfp_t gfp_mask)
 	return pm;
 }
 
-static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+static void svm_set_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	bool intercept = !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 
-	if (intercept == svm->lbr_msrs_intercepted)
-		return;
-
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHFROMIP, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTBRANCHTOIP, MSR_TYPE_RW, intercept);
 	svm_set_intercept_for_msr(vcpu, MSR_IA32_LASTINTFROMIP, MSR_TYPE_RW, intercept);
@@ -740,6 +737,22 @@ static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm->lbr_msrs_intercepted = intercept;
 }
 
+static void svm_recalc_lbr_msr_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	bool intercept = !(svm->vmcb->control.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+
+	/*
+	 * Skip redundant updates from svm_update_lbrv(), e.g. on every nested
+	 * VMRUN and #VMEXIT.  Note, svm_recalc_msr_intercepts() updates the
+	 * bitmap unconditionally, as userspace MSR filters may have changed.
+	 */
+	if (intercept == svm->lbr_msrs_intercepted)
+		return;
+
+	svm_set_lbr_msr_intercepts(vcpu);
+}
+
 void svm_vcpu_free_msrpm(void *msrpm)
 {
 	__free_pages(virt_to_page(msrpm), get_order(MSRPM_SIZE));
@@ -795,8 +808,13 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	svm_disable_intercept_for_msr(vcpu, MSR_SYSCALL_MASK, MSR_TYPE_RW);
 #endif
 
+	/*
+	 * Unconditionally refresh the LBR MSR intercepts, as userspace MSR
+	 * filters may have changed, in which case the bitmap may be stale even
+	 * if KVM's desired interception hasn't changed.
+	 */
 	if (lbrv)
-		svm_recalc_lbr_msr_intercepts(vcpu);
+		svm_set_lbr_msr_intercepts(vcpu);
 
 	if (cpu_feature_enabled(X86_FEATURE_IBPB))
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_PRED_CMD, MSR_TYPE_W,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 84f19026d3e8..62e08d6d4706 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -364,6 +364,12 @@ struct vcpu_svm {
 
 	bool avic_irq_window;
 	bool x2avic_msrs_intercepted;
+
+	/*
+	 * True if KVM wants the LBR MSRs to be intercepted.  Note, userspace MSR
+	 * filters may force interception regardless, i.e. this doesn't
+	 * necessarily reflect the state of the MSR bitmap.
+	 */
 	bool lbr_msrs_intercepted;
 
 	/* Guest GIF value, used when vGIF is not enabled */
-- 
2.56.0.212.g129ede20d9-goog

