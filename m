Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0237F00D
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782426155; cv=none; b=e1KVbQlg0goiXPJ/Om0lYwveHYmolcwANHwX4U9oHKle6Wzu/JRft6E3JC3A9hZR9keVK+yGNRsVSlmItlwFwHFEJrTo1Mf69+vrWJqtQzIOnT95NZI4xfPAPr3lh1Jzy12PWtDjKVRq4NWI4jon0Pt+xwUW2Dwrk/I37fBr9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782426155; c=relaxed/simple;
	bh=ebi1ut0R45RNUK3DzH9rwLP8LgUO8MNJO+TOylRTJOI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jFcLCfcV+pmlsB0HtA3QbQkzsQi3OxZQI1+vkd3swCNzWvWx3i/RhVFhjiwWovmSccm0kr0vpB5fx103+yjSBbOkfQr9yRaHaILT5vS4Uv9ezGFHs9I3UiFbVM/doEMlRvMVus2VhwKdCKNK8UYAhEoXRT50zemnp2uFnUDq+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LG/9RXk7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LG/9RXk7"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso216186a91.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782426153; x=1783030953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gaWZ/8o7SD9H9LBqIjY3b6M4mG1xtYaImHaGL0nNvu8=;
        b=LG/9RXk79xmiCW0Q9LCdKJZzDG532zyQBP1JZwWpfToNQSyNWfZjgLqy49aNdaYpci
         E//8878TxUsdo01nlZGKdpHpq7rBbjb5UFnTjHElnjbHChi6TY/NUX41W2XYN2me3xva
         mhzc057z/gPkJ5/tTR2JG4LRtRSTMI8Vu9o33tki55yORD0Q8jfqmX9RNxSYBSomFAMs
         qqdMudaBfQ8oZ9Fo0EY1iEhtkf+jVWwibacHGrHRDscCFSfdRSdM4KmD9CmE2qyyLiYE
         qXsRgaQ4x9AS7YrcgggoJC97IX87WHm9TgUOJWfDZislcD1HxWPdItk6jbxjh9q/FCr+
         bxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782426153; x=1783030953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaWZ/8o7SD9H9LBqIjY3b6M4mG1xtYaImHaGL0nNvu8=;
        b=IOUUjDD3gx76UgnNw4ET+SUdEr9waYYL9BV10ORdCWyytiZ9pV+Sf0IUBwHEe4QKgU
         41MmsEdn6MmooUG2TpFe7CMeu6gI5OkbXcsfeutSh80VCa7+UpOs/CaGBlmG5SLcQYhN
         wgUjnHDO5RoyUiePd9vveJq4ZsvjlwRdouQCVLRgSbW+YgnmmgZevjNET9fWrIszlKtW
         ekKUbAsUOiYlq2M+8yyWl6dAh705lZErvq/+XJe6OcFyRGZc16/1othgPN3KjW8SLlZv
         jxieC8H9AVMAiBTU7AMz0d1rbky+JDc6DE1aoeBllkYj0RStwd22DMUhgsFb6JNhve9r
         sX5w==
X-Gm-Message-State: AOJu0YzuvflQWtuMBvj5OZq3wJjRhzIvw37ksxtvoQWYvtmRH7Sza1iY
	/Vr1wtetRGfR/W+TTGKgDv6TuxLtYTHW2tMJZnTPMjPByUdF4mS7/pbN67In3LAt71qkE9qJ9ho
	pgzXmiw==
X-Received: from pjbay2.prod.google.com ([2002:a17:90b:302:b0:37d:28b5:c046])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1347:b0:36a:5d1f:7b6
 with SMTP id 98e67ed59e1d1-37df9f38334mr3670137a91.2.1782426153361; Thu, 25
 Jun 2026 15:22:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Jun 2026 15:22:23 -0700
In-Reply-To: <20260625222229.3367197-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260625222229.3367197-2-seanjc@google.com>
Subject: [PATCH 1/7] KVM: SEV: Track the GPA of the guest-controlled VMSA used
 for SNP guests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"

Track the GPA of the guest-provided VMSA used after AP_CREATION events when
running SNP guests, instead of simply tracking whether or not the vCPU is
using a guest-provided VMSA.  KVM needs to know the GPA of the VMSA that's
actively being used so that it can react to MMU invalidation events, i.e.
so that KVM can drop the VMSA if its backing guest_memfd page is punched
out of existence.

Opportunistically rename snp_vmsa_gpa to clarify that it tracks the pending
VMSA GPA, whereas snp_guest_vmsa_gpa now tracks the in-use VMSA GPA.

Note!  Take care to track the GPA, not the GFN, as VALID_PAGE() won't
behave correctly if an invalid GFN is converted to a GPA for checking.

Note #2!  Keep snp_has_guest_vmsa so that switching to a guest-provided
VMSA is sticky, even if the guest-provided VMSA becomes invalid.

No functional change intended.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 14 +++++++++-----
 arch/x86/kvm/svm/svm.h |  3 ++-
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74fb15551e83..827f5dc06102 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4003,6 +4003,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 
 	/* Clear use of the VMSA */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	/*
 	 * When replacing the VMSA during SEV-SNP AP creation,
@@ -4010,11 +4011,11 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
+	if (!VALID_PAGE(svm->sev_es.snp_pending_vmsa_gpa))
 		return;
 
-	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+	gfn = gpa_to_gfn(svm->sev_es.snp_pending_vmsa_gpa);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
@@ -4039,6 +4040,7 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_has_guest_vmsa = true;
 
 	/* Use the new VMSA */
+	svm->sev_es.snp_guest_vmsa_gpa = gfn_to_gpa(gfn);
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
 	/* Mark the vCPU as runnable */
@@ -4105,10 +4107,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			return -EINVAL;
 		}
 
-		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		target_svm->sev_es.snp_pending_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
-		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+		target_svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
@@ -4791,6 +4793,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	svm->sev_es.vmsa = page_address(vmsa_page);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 716be21fba33..d077783c287e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -271,7 +271,8 @@ struct vcpu_sev_es_state {
 	u64 ghcb_registered_gpa;
 
 	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
-	gpa_t snp_vmsa_gpa;
+	gpa_t snp_pending_vmsa_gpa;
+	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
 };
-- 
2.55.0.rc0.799.gd6f94ed593-goog

