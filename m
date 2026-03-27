Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8733EAEC
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654839; cv=none; b=jsKcgzws4cr2qBItlikxwS7GPIu07j8xm+T2YOLjk0zJks78zVkG4+dSjA6Fxnv0cfq85PLGhumb+BrC/fqTslLvoR5BbJ4kqbleHYn7OQK45ouUJ1mJkFghn10moUf1MxY/Hw9h8uwODpgGNf1LwUgL3gDL1Nfq7dgqpcYpqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654839; c=relaxed/simple;
	bh=NlXwBnZ1bTT+62YJ+MeeQ/QO8FkcP8rapcnFH5xIbuA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hUWUf6lxvjuAgJrSGrV6wStDxxWau8MVKwUVMKApkZL0h0AhjgiqTM5cWNol1SlHJvTHnqYu3s62Ig4xyShLfrbPR9pO4WS6NyB3DMoVReJQHuAAmA0CHdhmA6pLLL7g7ldf8Eau/J0Vhhb4J7rNS2EFys5XBYmEE19QkwOHso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fVG/htAD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fVG/htAD"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso4889795a12.1
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654835; x=1775259635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xllQ07LuXMkS9oh5VHlxnSe05QNYm8Ww7MJ9nxpGyM=;
        b=fVG/htADpTYmQ50SKYjj0FReDTfirulftJHyE6R2tRxMLA8y+v21xmPiVOSNF/VB4r
         IJCm/Ex1MCixC7dWywBVutv3o48J7VrTJCSXlI6ASIhtodKIExz/pPgg09YyJ5vthBOS
         RimIC0gZ/1tvCM+SpzOz3G3lrBzO2LbuJPJYo1qu9RxiCAq0TwYclmmN6NO/Arp4jK97
         KOfPPW3lshZO7F9YKjIKxEz4JHnAiHThmuPhuIp/nkwEZE7wT5n/u3+VWG51n0A4RhBx
         vB+nai53OTd2P/L79bj8vHktoGjQbsCa6Gb8SbDaVRcpERVvDjFOFcfIlOCklgcIK9cO
         j0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654835; x=1775259635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xllQ07LuXMkS9oh5VHlxnSe05QNYm8Ww7MJ9nxpGyM=;
        b=eXZIV6T92t86spcA37/dOhgll8Ha75l1JZW8DR/vdJlHw7EiHmP2davceDme5J9dfh
         tdrZJA1tYbQnTlc+u0/vUrvxyvqsxhK3hxFM0T09PmNk99ZMkaerV3QmZlgGTHhIkkGd
         smEj/eYpAqoAzAjy6cAGxfSWAhzAnzowHWMGxe1+ibnKkSAepTWWO0pEvfcALWlLVLXh
         JuuSKIN3MCUgqcP02UkFIYfnPca/gW0KfbeEgp6QQROkzE/lTGaA9BGOMPLPVgeuqG3s
         a6E3PRF5OR1ZxHUrv80pmlJRUrUZYhuJ/nq5kBJTHNhUXs7VyAt4HRKhUo2GfotLcWZq
         lvfw==
X-Forwarded-Encrypted: i=1; AJvYcCVGOKfmXOSRoi7B5trTZwhL6acRL4CtyGgPDAqCfn4DdN7bfrapQ0jNETuolKzQJl03nyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhzqNEaGieMMhEizf6fIumcBuQKPxRnZWlZ0bOhQ7ku6Ql0RS
	8QWMCDIzu9nuSFpwrI8WMZAoMu1ikaeF7iapjc+9pW/GyDEGrCkeI9Cjql2DJmb9VQcbSVF7CNe
	E9gpKrN0vPwGwrQ==
X-Received: from pfjt19.prod.google.com ([2002:a05:6a00:21d3:b0:82c:6ae6:e5b])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9a6:b0:82c:6d88:2a8e with SMTP id d2e1a72fcca58-82c95c1133emr4446772b3a.20.1774654835305;
 Fri, 27 Mar 2026 16:40:35 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:11 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-5-jmattson@google.com>
Subject: [PATCH v7 4/9] KVM: x86: nSVM: Set vmcb02.g_pat correctly for nested NPT
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

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled and nested NPT is
enabled in vmcb12, copy the (cached and validated) vmcb12 g_pat field to
vmcb02's g_pat, giving L2 its own independent guest PAT register.

When the quirk is enabled (default), or when NPT is enabled but nested NPT
is disabled, copy L1's IA32_PAT MSR to the vmcb02 g_pat field, since L2
shares the IA32_PAT MSR with L1.

When NPT is disabled, the g_pat field is ignored by hardware.

Fixes: 15038e147247 ("KVM: SVM: obey guest PAT")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index cb837842f2c3..8170042d5fb3 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -727,9 +727,6 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 	struct vmcb *vmcb02 = svm->nested.vmcb02.ptr;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 
-	nested_vmcb02_compute_g_pat(svm);
-	vmcb_mark_dirty(vmcb02, VMCB_NPT);
-
 	/* Load the nested guest state */
 	if (svm->nested.vmcb12_gpa != svm->nested.last_vmcb12_gpa) {
 		new_vmcb12 = true;
@@ -760,6 +757,13 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 		vmcb_mark_dirty(vmcb02, VMCB_CET);
 	}
 
+	if (l2_has_separate_pat(svm)) {
+		if (unlikely(new_vmcb12 || vmcb12_is_dirty(control, VMCB_NPT)))
+			vmcb_set_gpat(vmcb02, svm->nested.save.g_pat);
+	} else if (npt_enabled) {
+		vmcb_set_gpat(vmcb02, vcpu->arch.pat);
+	}
+
 	kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
 
 	svm_set_efer(vcpu, svm->nested.save.efer);
-- 
2.53.0.1018.g2bb0e51243-goog

