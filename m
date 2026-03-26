Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8539E196
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547406; cv=none; b=eV8EM3JaUcyUAhu00SbMorabmrVs+eveb6OEbmmdFfF4+s0aZqUA4nAumlXgXC9ErfcHo/YIurCMDIFAQQWc7lZV5sCSej2ON1lTpgiK+Jli8yRh2pCOiYAQUFAIWvTScqfg85DEdu+Yj5i6MicNHeLOCon8ru7xQ7awzOX9fNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547406; c=relaxed/simple;
	bh=7SI+MHaHsHfhtgMbQHFaI8EaRKrXuYVzdDzUpM37mAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgJI3a5TosF7NPHNBHUKXmHPqZJfouGarkXPqBM4Hko103VmOwh+jbVpoMrxOmTid33BMh2649Tp3ZTjKNbiv/oyZgE88Q8/dKNjlJrArUsw2xKeOsLJQSwWFjkoiEkrFuboFdnrAAJiRa9s8Q2GC+f6O95L9f782PSsRPFJlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMFWS+Cb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMFWS+Cb"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c0f03b2a1so3477891a91.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547405; x=1775152205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAH8qf9G0XQlUHg8hq3D+h8w7UbFbHHt2UywU7wF7JE=;
        b=bMFWS+CbAlPgtWgAQLqGrWn4MGa018kPlooveayc45iZqssaGy4r/nZ1hWo9+i4b+Y
         LpNyiT4pQn3VP9ud0Jtu3sZHCUKFSD6NLpoTrcXuRlggNZk7nSEoAs3DBGEr97ccCG3D
         OypuunB+7wRFDpna/sYH5KAjGjR8k6Y8Fcqno+cR05G7H4ehyclaMI02mZmVo2NKSAIb
         p6KKOWhXjyvr4BdylG+ANt0oAQXwkzny82Y/rrDEasWdj/1XCRFrnckG1Gf5T8IGER/I
         QhqX4R+jPVc1Y5MxgwCy5vaLOKQx1H79qKEdy+Pv3TCl3Cru27D7VRDFo3MZqZ0ntUBy
         oJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547405; x=1775152205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAH8qf9G0XQlUHg8hq3D+h8w7UbFbHHt2UywU7wF7JE=;
        b=KcTUyaeEqmP4sJqssjQ8pCfBd3XyBGMl7jZsTGjNjC/CxgOpk73qeUXqYdPOAO1js4
         zzRjO8Us0PFo1xJd628golDDQzWw1aw+RCykSVun9JgEJA7L1QsK37DvYli9QLViZhi0
         h49Gu/mcws9hEIPoz916xDEoF8jqskg3kHkUUgpFlVxVLszCO5GNyqDaPBWXpWSq5E3C
         sOJZnbO2wgs6ARBXQYZ8ieGT3K/ihnz0zUcBHbA8LMCpGXMwhCB3Lf+RGql0TGFTsMEj
         fQBuCpG6BEVoybxrX3/7oY4FAtezkVZVk3tQw613mbbLKmPI7u6U8th5paB8xgeoH8KE
         2SkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe1JlricgjCy5QlnvVbQdLgbse6E5tFFoA6JIMdY2ZEMGbufFz0mrQF3cGqFkK77MGCy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1CoxXx/SsYX9XU20G/fLAirWd3b4vsAIWzZPdJltcuVvuGMX
	w2sOYAySn/9xTBjG3W3QL/EO94eYpsAw+JiGwI7oKviUPOVxwpHE+GfMkyOJIDhBD70sc4ooJ5V
	gWAL4XasTcrKjVg==
X-Received: from pjbie10.prod.google.com ([2002:a17:90b:400a:b0:35a:294:ab56])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e183:b0:35b:9d0c:a2f5 with SMTP id 98e67ed59e1d1-35c0ddf1215mr8406645a91.33.1774547404300;
 Thu, 26 Mar 2026 10:50:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:21 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-4-jmattson@google.com>
Subject: [PATCH v6 03/10] KVM: x86: nSVM: Cache and validate vmcb12 g_pat
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and nested paging is
enabled in vmcb12, validate g_pat at emulated VMRUN and cause an immediate
VMEXIT with exit code VMEXIT_INVALID if it is invalid, as specified in the
APM, volume 2: "Nested Paging and VMRUN/VMEXIT."

Fixes: 3d6368ef580a ("KVM: SVM: Add VMRUN handler")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/svm/nested.c       | 17 +++++++++++++----
 arch/x86/kvm/svm/svm.h          |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0809d8f28208..0b4ab141feae 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2511,7 +2511,7 @@ int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 	 KVM_X86_QUIRK_SLOT_ZAP_ALL |		\
 	 KVM_X86_QUIRK_STUFF_FEATURE_MSRS |	\
 	 KVM_X86_QUIRK_IGNORE_GUEST_PAT |	\
-	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM	\
+	 KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM |	\
 	 KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)
 
 #define KVM_X86_CONDITIONAL_QUIRKS		\
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 32fa8e688c00..0ad1e0348492 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -410,7 +410,8 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu,
 
 /* Common checks that apply to both L1 and L2 state.  */
 static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
-				   struct vmcb_save_area_cached *save)
+				   struct vmcb_save_area_cached *save,
+				   bool check_gpat)
 {
 	if (CC(!(save->efer & EFER_SVME)))
 		return false;
@@ -445,6 +446,9 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
+	if (check_gpat && CC(!kvm_pat_valid(save->g_pat)))
+		return false;
+
 	return true;
 }
 
@@ -452,7 +456,8 @@ int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
+	if (!nested_vmcb_check_save(vcpu, &svm->nested.save,
+				    l2_has_separate_pat(svm)) ||
 	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
 		return -EINVAL;
 
@@ -562,6 +567,7 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 
 	to->rax = from->rax;
 	to->cr2 = from->cr2;
+	to->g_pat = from->g_pat;
 
 	svm_copy_lbrs(to, from);
 }
@@ -1971,13 +1977,16 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
 	/*
 	 * Validate host state saved from before VMRUN (see
-	 * nested_svm_check_permissions).
+	 * nested_svm_check_permissions). Note that the g_pat field is not
+	 * validated, because (a) it may have been clobbered by SMM before
+	 * KVM_GET_NESTED_STATE, and (b) it is not loaded at emulated
+	 * #VMEXIT.
 	 */
 	__nested_copy_vmcb_save_to_cache(&save_cached, save);
 	if (!(save->cr0 & X86_CR0_PG) ||
 	    !(save->cr0 & X86_CR0_PE) ||
 	    (save->rflags & X86_EFLAGS_VM) ||
-	    !nested_vmcb_check_save(vcpu, &save_cached))
+	    !nested_vmcb_check_save(vcpu, &save_cached, false))
 		goto out_free;
 
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 0f0c08c5ce0c..3588f6d3fb9b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -161,6 +161,7 @@ struct vmcb_save_area_cached {
 	u64 isst_addr;
 	u64 rax;
 	u64 cr2;
+	u64 g_pat;
 	u64 dbgctl;
 	u64 br_from;
 	u64 br_to;
-- 
2.53.0.1018.g2bb0e51243-goog

