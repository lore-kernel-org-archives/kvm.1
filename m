Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2014BFE63
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797010; cv=none; b=QOgdDMn4pSpSJBrs7ZvtyHVUcPC1RfW75w9KApqvCRD61J97bXns0c2+Jp7172zawBOTQee+JDkuL9uWTdsiBbiz/C+04QiAbEDJu9f/L8mDcyN9Yomw/NgZMilQbuDZ+3x/fksw/KRVeX4yTVO9PUKqw47GTEgc02wZmF961Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797010; c=relaxed/simple;
	bh=qNaxT1lfEbT1LPSsEVh5+AezcCglRx9kPOdT2poCI4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y0tpDdiKJUNl2VTt6Fmgmd1GWDavB4Ipea6utvRK1+K3mn16bZoHlCzRxNO2dxcBpw20O87gLbX0hzxhvFW5NP/abBa1oqpHLG9yh4CZeJUJ4twvX3207Mwzh22B/bn9+S/1jFAFbIHFvelkPAHVbaaZ1VWPky7D9bUc0zy8Dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUBsoK46; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUBsoK46"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4c1fc9ceaso3467093a12.3
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790797008; x=1791401808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlcl2f6ewwzrBjcQFC4aq+Z9uRrmySkT+V2ro3tMTk0=;
        b=VUBsoK46WEyZTpYVlR8l0P+kUd03RmBT/YMOzz8Tj8MUsluuwoZfvQHy+pq8PwadMn
         6i+NdC+SVUWOsaFtP5sDpdBkmpzw6Mz2iYtii6EVRqUypOCnsP2pEHtMSWo9c/Bqi6/H
         kUvBKupaND7/MkKgUf67nfxwqgyO3xfDY+wddWoHHh2JVTiRMG1HkkxS7FR0qqxn3Cff
         CNHMUdHaYqcx1BDSr7Iz66cED9E1w+GHjoR47GoRK5BM319xMNHF6WQjNzT1ZQbsmX2r
         SjEe4MBK7ZS3yiyIWvBjwWxTAIbb/Guft+1LeYwuJG1v1L1VR6z+e/ixywpNoL7stM9N
         lTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797008; x=1791401808;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vlcl2f6ewwzrBjcQFC4aq+Z9uRrmySkT+V2ro3tMTk0=;
        b=SC/gqqOshof7aG/UGqaQXoDoFibnZHfsqLpQ66K1atwIzdY6izchNs47+LAycfH4e1
         DaHaBhmxoa9Cz+ZearKv7M1uAZBH2pbcOEigP2qM0pB/3uDXgM2FQbnN+OvsddKh5Tbl
         Z0MzKb+KzSJqR+AUwJnpr5QL3FUDq2zwR6CkJwhGPBzakCRBaWd5UUYVthQEKZY1abhi
         NOL0nCYxvL7Os9RmhZGBIPZFkosUxtJSmWVf0krXdIwdHQSQM+8x/aoVoWCZN8koVEtM
         Ao/m4OVVU6Ez7Occ0XuI1A1WVKGy9g3v/fSRifbMjADN8F8lI0u4plGR8jYFtwWWGQ5t
         mbUQ==
X-Gm-Message-State: AFuF++mCx01rOFZJ92wpC4PwUSljbbFhvv4rHf7LLYrkPjLzva3zjosy
	VBOmTPIP+g/28Bmi3ycdZxg6Z9/XEAU2IosHd0VAD42keEOFS4BMG+VseDzSQuK8h0fuJv0nFLe
	MqyRs1w==
X-Received: from pgbdo4.prod.google.com ([2002:a05:6a02:e84:b0:cc7:d747:ae32])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2d4b:b0:3de:53ba:4071
 with SMTP id adf61e73a8af0-3de9e740039mr2189302637.32.1790797007784; Wed, 30
 Sep 2026 12:36:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 30 Sep 2026 12:36:30 -0700
In-Reply-To: <20260930193634.3415089-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930193634.3415089-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930193634.3415089-9-seanjc@google.com>
Subject: [PATCH v6 08/12] KVM: nSVM: Disable LBRV in nested control cache when unsupported
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Shivansh Dhiman <shivansh.dhiman@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Shivansh Dhiman <shivansh.dhiman@amd.com>

Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
the vCPU does not support LBR Virtualization. This lets the cached value be
consumed directly instead of re-checking X86_FEATURE_LBRV on every access.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 8 +++++---
 arch/x86/kvm/svm/svm.c    | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b61149814acc..aca2bbc66f47 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -527,12 +527,16 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 
 	/* Always clear misc_ctl bits that the guest cannot use */
 	to->misc_ctl = from->misc_ctl;
+	to->misc_ctl2 = from->misc_ctl2;
 	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_NPT))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_NP;
 
 	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
 		to->misc_ctl &= ~SVM_MISC_ENABLE_GMET;
 
+	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
+		to->misc_ctl2 &= ~SVM_MISC2_ENABLE_V_LBR;
+
 	to->iopm_base_pa        = from->iopm_base_pa & PAGE_MASK;
 	to->msrpm_base_pa       = from->msrpm_base_pa & PAGE_MASK;
 	to->tsc_offset          = from->tsc_offset;
@@ -550,7 +554,6 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_vcpu *vcpu,
 	to->event_inj_err       = from->event_inj_err;
 	to->next_rip            = from->next_rip;
 	to->nested_cr3          = from->nested_cr3;
-	to->misc_ctl2		= from->misc_ctl2;
 	to->pause_filter_count  = from->pause_filter_count;
 	to->pause_filter_thresh = from->pause_filter_thresh;
 
@@ -737,8 +740,7 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
-	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
-		(to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
+	return to_svm(vcpu)->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR;
 }
 
 static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 775eccfb7b24..5253c0143666 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -882,7 +882,7 @@ static bool svm_need_lbr_virtualization(struct kvm_vcpu *vcpu)
 	if (svm->vmcb->save.dbgctl & DEBUGCTLMSR_LBR)
 		return true;
 
-	return is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
+	return is_guest_mode(vcpu) &&
 	       (svm->nested.ctl.misc_ctl2 & SVM_MISC2_ENABLE_V_LBR);
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

