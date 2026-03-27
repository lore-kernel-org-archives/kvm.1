Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4353A0B3F
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654838; cv=none; b=HwWuE3AYE00qN38kLlsZoTJBLLghVGZNCjmm9GCm9jZull50pAHG8GRF7EktY1lP0+UMa6fr4jIAMQ16M5k1tmJn27ozyZgIt70FUn+F0YSNZN/XRca1rFDZGcKi/L2ITIn2HeX04t0RCFicyRxnNevpi4EihZfCdwBXj9MvQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654838; c=relaxed/simple;
	bh=RPbgJ0c4Fa9PKqVXhRieBWd7nnk0p+dj+Ta6IzkqBl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e56/IrtBxrT2IKHMKTbOce2bJ1wjNgapre9EY1S12EDk//B8aD7MOZlMJA8JPAB7vwQO7DaZUMn/AL+gy1FRVpFDIUwMpiYpTOf3vDTSaANL2iMVGtClcybQYCqore/ahW+D/6zepHqhIwpsy7ajo2RM4E39lN276SVGM0fEtY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujRbNi7H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujRbNi7H"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358f058973fso3607439a91.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654834; x=1775259634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qAI9OI68WEJnrwpx1Qcu7Sb9TsTUzYiN2XdEpiva10=;
        b=ujRbNi7HIUqcDr3dOn6EOjxSI9jMqWY0F60O9i23N8x50vbrLw5Z25TwNE8ZPuwekd
         6G3+RU6LiP/+ewzfQeAicnbvcobIiXeKCGvGyo6q8qyhx8fP54EltRq7W4abe7kodSXN
         7m4/X2LS5Zce18IO0+waXLJVSmU2B9BKEzjR4WVS8EOlBbB+bKrLOfA2lKT2PBW90K33
         uMUXw9ePXZD32+DQqfjb3Im3E9Uug+9i45PaLta8vZRUL06sSM3s9EWRtJ3UFY6EjmRV
         NOM4Ap9k5tIYJJDAkWY/QSUwG1vXQZddGhYZ4G8E2CHKa2zSMqbFt3El6Ii4Ry6yuugt
         lmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654834; x=1775259634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qAI9OI68WEJnrwpx1Qcu7Sb9TsTUzYiN2XdEpiva10=;
        b=a054EISYkNpo9C6o+8zIfHOM3dJw8ft3123l7vLBuHozXw7cp6gAxlJ8QBwi5Tpewx
         SXVc0RbTPDwcZF0/tILk9fqkRXl3yvuPcEov8Hk+yIHHMOQv85dpc7TX+iLH3dOFIyTJ
         QfA5vsbKK/oqtWdkZM0tKKmdSIfSPqKz3HHstQCnoZnHj2kNXRh9AEsHOmAz9QVDZbG9
         ZwEzHt+liMmc1BX1oAz3op0GxEy9wT0w7f6oy3aFwYvpgod5/tdHYiM2ta5Gh14QqPIO
         nbgu0ntA+eHhwfU0nqPapbtuC6NlWc+FYHpaCc28JEBadXodLN9T9K8LyO8o4inM/sRn
         BvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIe3EPNI0EbCpCU7G08wC+J9mMTccWgc12cZr7+Cf9DEVU8WgIl4nOrlfzzxifu1mdChM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxht3ghKwwIZ0oDQ3Lrc3z9Ut6iVx4t3oyu43Yazh0RXt32izYp
	wWGCWyNTwjMaZ5A2o0PtNXELCrRYM8M9UmQjPzKvsf6sztJ/SUwocWr8CJR5U0MrJ0gsgeXThVQ
	YU/0Zcwwb2VkIoA==
X-Received: from pjzb14.prod.google.com ([2002:a17:90a:e38e:b0:359:7e40:7d79])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3cce:b0:356:7b41:d348 with SMTP id 98e67ed59e1d1-35c300b9811mr3853636a91.20.1774654833713;
 Fri, 27 Mar 2026 16:40:33 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:10 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-4-jmattson@google.com>
Subject: [PATCH v7 3/9] KVM: x86: nSVM: Cache and validate vmcb12 g_pat
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
 arch/x86/kvm/svm/nested.c | 23 +++++++++++++++++++----
 arch/x86/kvm/svm/svm.h    |  1 +
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 32fa8e688c00..cb837842f2c3 100644
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
@@ -445,6 +446,15 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *vcpu,
 	if (CC(!kvm_valid_efer(vcpu, save->efer)))
 		return false;
 
+	/*
+	 * If userspace contrives to get an invalid g_pat into vmcb02 by
+	 * disabling KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT in a race with
+	 * this check, it should be prepared for the KVM_EXIT_FAIL_ENTRY
+	 * that will follow.
+	 */
+	if (check_gpat && CC(!kvm_pat_valid(save->g_pat)))
+		return false;
+
 	return true;
 }
 
@@ -452,7 +462,8 @@ int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
-	if (!nested_vmcb_check_save(vcpu, &svm->nested.save) ||
+	if (!nested_vmcb_check_save(vcpu, &svm->nested.save,
+				    l2_has_separate_pat(svm)) ||
 	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl))
 		return -EINVAL;
 
@@ -562,6 +573,7 @@ static void __nested_copy_vmcb_save_to_cache(struct vmcb_save_area_cached *to,
 
 	to->rax = from->rax;
 	to->cr2 = from->cr2;
+	to->g_pat = from->g_pat;
 
 	svm_copy_lbrs(to, from);
 }
@@ -1971,13 +1983,16 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 
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
index a1d62c3cc3d6..b43e37b0448c 100644
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

