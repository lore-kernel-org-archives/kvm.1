Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27A3793AD
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588647; cv=none; b=UK+Vc2PMydVI5IiQmJlhYhiU2SigDJbZzz0BwHJFyQjVwlpruu7j4VUaWwRPH9vBKC8PKedG4K4CdOCHDqVtIhvjHgVgHW5TGQQJ+gSAl1IqyS6eC1WSYNSo6O0sTRCCXI10fpzLD5ugYUaIzP3+WjCZYhX8q3dXZrXqJzx0X2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588647; c=relaxed/simple;
	bh=HE16aqvo2kSNiQCGfnKf8BZKOYvkGmEshj6tm2tsYAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5og/8+JJG1Abfz6T5VjbSYeWsHTpqQGNr9hdu7buYppbarA/a4t95/N/yqg8vk5wKrWvM7gQpWC2MBojkGAOTOPAkisTS1HmNv3uA5MjKadzs9oXLCXVIfYD1q8OS6DFVdUZxQyWeoTFx4/GnPHXgml5XxwoS0LRAP4LEUwt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XYh4ZtL5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XYh4ZtL5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c9364612fso7810451b3a.2
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775588636; x=1776193436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqVeCtX1aVyum4q4mSfbZ8Tffgvj54dtcUsGbe5OM+k=;
        b=XYh4ZtL5A485cChxmVJOfH4Ty43TIkG9A7y2IySVq/bnGyWXYjwLpvQvjw5Srv9QF7
         6ieKQk+dMgQmr+Fkr94qkc/GKJtSaDN0hxUtMEDywF1fL69VC/XMxugGx2rzo1iG36M5
         FOYXFqWlGpDYn+E8uIjRwzZz4t74fviZfYp83QzYQU8y0Fmeu8ZIMaOM7zgN+j3aReSE
         tbHNuZIgi6gYq2eT3be3Dbd1NPunC5wJU8u2eAhKo1pDXlQ/OiNtarFxnqon6evhb+/V
         9rgG3BQSOtg9gCzZLN1Qys9prniY7oQLJWA6JZHENv2T8JXG0papX9WNr2de4pbBy/WK
         Bu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775588636; x=1776193436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqVeCtX1aVyum4q4mSfbZ8Tffgvj54dtcUsGbe5OM+k=;
        b=ncWAyDxl1shGDDTIVsEfIrEXKfFqzRzDJA8r7ofL3ckevUeLs6RdJNOF2W+8MmKU7f
         4mmF3vVCjGP/cZNEifXeMzwVBEld+J7Vv/v5+C0+5ddjB5nm1F4sWB8ZDBS5WBql7gd9
         Gjk/SKwCUyeEoAsjPLUG7SDnLmpZnr2iRL+7XUgFxlP+uWmvTm0NxVTLr7zS0HsBNwRV
         oA7iPOElWEVlpH2Yzwb6BGxr3vKwInyPWdWRP1VMge71KICtDw+qtb8jmIKTWYqllIhC
         bxl0Vs7xOtnBjSVQ8JrnOGfpQVXfakdkLyq5sBJH2qIfgR81u6B+q7eZ/1QcZHNGaeAg
         xCLg==
X-Forwarded-Encrypted: i=1; AJvYcCX8rHdtcNufPZT5nCpQOFpSBux8Vb78NPafSxskDp+uFf1necbrp35NDYLN7Q5m9N/+ahw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWvEnfR8pZjwCcAVqyvSQ0wQnJUnXMRF+Rv3oPYvw0M+MyTn7
	6QawPC0gss7/yJAkYj3cvScCqyU79/E26bqB0LNG0nb9HX5vQ0NTdPLBelYKCTSvbghqDCgtEgV
	0ToQJAswa4s3a/A==
X-Received: from pfbcm16.prod.google.com ([2002:a05:6a00:3390:b0:824:c676:35a8])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1388:b0:82c:9c4f:da3 with SMTP id d2e1a72fcca58-82d0db5abefmr18297546b3a.31.1775588635172;
 Tue, 07 Apr 2026 12:03:55 -0700 (PDT)
Date: Tue,  7 Apr 2026 12:03:28 -0700
In-Reply-To: <20260407190343.325299-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407190343.325299-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407190343.325299-6-jmattson@google.com>
Subject: [PATCH] KVM: x86: nSVM: Redirect IA32_PAT accesses to either hPAT or gPAT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and the vCPU is in
guest mode with nested NPT enabled, guest accesses to IA32_PAT are
redirected to the gPAT register, which is stored in VMCB02's g_pat field.

Non-guest accesses (e.g. from userspace) to IA32_PAT are always redirected
to hPAT, which is stored in vcpu->arch.pat.

Directing host-initiated accesses to hPAT ensures that KVM_GET/SET_MSRS and
KVM_GET/SET_NESTED_STATE are independent of each other and can be ordered
arbitrarily during save and restore. gPAT is saved and restored separately
via KVM_GET/SET_NESTED_STATE.

Use WARN_ON_ONCE to flag any host-initiated accesses originating from KVM
itself rather than userspace.

Use pr_warn_once to flag any use of the common MSR-handling code (now
shared by VMX and TDX) for IA32_PAT by a vCPU that is SVM-capable.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c |  9 ---------
 arch/x86/kvm/svm/svm.c    | 36 +++++++++++++++++++++++++++++++++---
 arch/x86/kvm/svm/svm.h    |  1 -
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 58574e803812..8c9dd685b616 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -703,15 +703,6 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	return 0;
 }
 
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
-{
-	if (!svm->nested.vmcb02.ptr)
-		return;
-
-	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
-}
-
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
 {
 	return guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 56b6bd5dfdca..8d968ead6f45 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2767,6 +2767,20 @@ static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 	       !msr_write_intercepted(vcpu, msr_info->index);
 }
 
+static bool svm_pat_accesses_gpat(struct kvm_vcpu *vcpu, bool from_host)
+{
+	/*
+	 * When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and nested
+	 * NPT is enabled, L2 has a separate PAT from L1.  Guest accesses
+	 * to IA32_PAT while running L2 target L2's gPAT; host-initiated
+	 * accesses always target L1's hPAT so that KVM_GET/SET_MSRS and
+	 * KVM_GET/SET_NESTED_STATE are independent of each other and can
+	 * be ordered arbitrarily during save and restore.
+	 */
+	WARN_ON_ONCE(from_host && vcpu->wants_to_run);
+	return !from_host && is_guest_mode(vcpu) && l2_has_separate_pat(vcpu);
+}
+
 static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -2883,6 +2897,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_AMD64_DE_CFG:
 		msr_info->data = svm->msr_decfg;
 		break;
+	case MSR_IA32_CR_PAT:
+		if (svm_pat_accesses_gpat(vcpu, msr_info->host_initiated)) {
+			msr_info->data = svm->vmcb->save.g_pat;
+			break;
+		}
+		return kvm_get_msr_common(vcpu, msr_info);
 	default:
 		return kvm_get_msr_common(vcpu, msr_info);
 	}
@@ -2966,13 +2986,23 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 		break;
 	case MSR_IA32_CR_PAT:
+		if (svm_pat_accesses_gpat(vcpu, msr->host_initiated)) {
+			if (!kvm_pat_valid(data))
+				return 1;
+
+			vmcb_set_gpat(svm->vmcb, data);
+			break;
+		}
+
 		ret = kvm_set_msr_common(vcpu, msr);
 		if (ret)
 			break;
 
-		vmcb_set_gpat(svm->vmcb01.ptr, data);
-		if (is_guest_mode(vcpu))
-			nested_vmcb02_compute_g_pat(svm);
+		if (npt_enabled) {
+			vmcb_set_gpat(svm->vmcb01.ptr, data);
+			if (is_guest_mode(vcpu) && !l2_has_separate_pat(vcpu))
+				vmcb_set_gpat(svm->vmcb, data);
+		}
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fdd6286d965e..677e899bda33 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -881,7 +881,6 @@ void nested_copy_vmcb_control_to_cache(struct vcpu_svm *svm,
 void nested_copy_vmcb_save_to_cache(struct vcpu_svm *svm,
 				    struct vmcb_save_area *save);
 void nested_sync_control_from_vmcb02(struct vcpu_svm *svm);
-void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm);
 void svm_switch_vmcb(struct vcpu_svm *svm, struct kvm_vmcb_info *target_vmcb);
 
 extern struct kvm_x86_nested_ops svm_nested_ops;
-- 
2.53.0.1213.gd9a14994de-goog

