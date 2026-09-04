Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE8936A369
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483841; cv=none; b=EieFjyH56TxLwx5+gBRA/yfZC+9bqMXvS7jYxwUV28vup15oPpSUhX9Bc7sIyOasxsmH0fCNFADcoWxGO+lCiQ1pCXvp23AZOry2ZSO/BBGTe00BMRXvqfO4iIt+NWkQ803SBLTWqaKqb0L1gXJTb9icD/agtBVq2J6rejTyuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483841; c=relaxed/simple;
	bh=hmPFoHDi198piLc+Mjunw9WTBgvQgwN+OdxP0ZAXmZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHf2D/FMCookSVmwnJTNLHNXb8NXhl2CJNjw/dOaDsNKFLRybLzLOLsohgOzH1inFSt5czzjeTZnzQLtdagF2neOM/6ljE+NUBtvokZG4R6HwBIx+M+OQzwagrNTBL+eM7GDgxQPHHWrlI6RjOwoxkxfWV3LxXzqwjkgmsmF6aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWPbUp10; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWPbUp10"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9057fab9eso7762985ad.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483839; x=1789088639; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vSlMjq8tWu4P44mUn9mh71lQHrhgq0jSndGTEJFOM2U=;
        b=gWPbUp1039zmHORJOqcwMvVebpdAXtNWuTeyLzADJPmk9trTgoFYUMF9Mt7pMCMP9j
         UAH+S92LXxo2hTBQfrcgHrtVCQFpZHJX/IbooDblMi/xYtSjZmWmi4izS6X95Gffsank
         yd236VEddxa65FuIHhEWZvsM08Qe9QcriMUXDMO5lf3MZGc4J4mNolbpqJhWAuO9R8/n
         cyGxc868kbKThAI4jPHHtvFAjKjO1/p02x9riogbnH1YcwlModWn/zh4/vR6W6hUy0cM
         5o+eAyfPEvGZLhvaYPAIFmdN8PQ8NkEqRn6oEpM27cVFamWJPsd3X8LJ0XIr82DKkCKB
         dn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483839; x=1789088639;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vSlMjq8tWu4P44mUn9mh71lQHrhgq0jSndGTEJFOM2U=;
        b=aeAqr9HmPjhTuj4G2MMSVdjSLJNgoWhsNEihFCe4MnUxIvIaRcK4VaoUbRZgXzbWdy
         YZoIRkhYHx1W9fxCjfNP9dMgHCjKNCbyOWE1k0AtfwaA21jIKQrKLn+VGow+A4SJV1RT
         Eh5GCgStd8dC2ApW07LhueXb6bIK6vxUfl1SS5n8cCB2Wb+OcCjtTLThYrdKUoKnmmSd
         uKjW0s2Rp5VBBKjbWQQjzjYufGlVCJyxiiNQUCtMydhagIlzCdfRFZ0Dy9RntwmrZsV6
         9Q1ZHU2scPYpi/Pq5+ywKM8WNo64pWMnUT3JsL/ebdIv97WMdXdFn+6/5DBVKxo3C9OF
         LGPA==
X-Gm-Message-State: AFuF++n5j0xsSQnKRQibwlCGSep/eEuynI1ksIE/13WLtL4D0Yp21tch
	X0j86RWqSGfO80RfUdikKF9sxet8NSW25f7PnPs11fOYzozN9IaGh65UEtyHUZ06qIKuVWgvMCQ
	+fCBkQQ==
X-Received: from plei1.prod.google.com ([2002:a17:902:e481:b0:2ce:9b92:ec60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:468d:b0:2d9:56d8:75f
 with SMTP id d9443c01a7336-2db1266772dmr44885415ad.9.1788483838837; Thu, 03
 Sep 2026 18:03:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:48 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-4-seanjc@google.com>
Subject: [PATCH v3 3/8] KVM: VMX: Move the shared NMI handler/trampoline to
 common code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move vmx_handle_nmi() to main.c to capture that it's a common handler and
to allow guarding against incorrectly using to_vmx().

Opportunistically use a "vt" prefix instead of "vmx" to communicate that
it's a shared handler.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/common.h |  2 +-
 arch/x86/kvm/vmx/main.c   | 11 +++++++++++
 arch/x86/kvm/vmx/tdx.c    |  2 +-
 arch/x86/kvm/vmx/vmx.c    | 13 +------------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 88f637c81353..4b1d46eafd0f 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -189,6 +189,6 @@ static inline void __vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu,
 	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
 }
 
-noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu);
+noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_COMMON_H */
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 9614f43e7987..b1069a8e30a7 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -947,6 +947,17 @@ static void vt_handle_exit_irqoff(struct kvm_vcpu *vcpu)
 	}
 }
 
+noinstr void vt_handle_nmi(struct kvm_vcpu *vcpu)
+{
+	if ((u16)vmx_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
+	    !is_nmi(vmx_get_intr_info(vcpu)))
+		return;
+
+	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
+	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+	kvm_after_interrupt(vcpu);
+}
+
 #define VMX_REQUIRED_APICV_INHIBITS				\
 	(BIT(APICV_INHIBIT_REASON_DISABLED) |			\
 	 BIT(APICV_INHIBIT_REASON_ABSENT) |			\
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a7..46b0e798f8b9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -974,7 +974,7 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu)
 	tdx->exit_gpa = tdx->vp_enter_args.r8;
 	vt->exit_intr_info = tdx->vp_enter_args.r9;
 
-	vmx_handle_nmi(vcpu);
+	vt_handle_nmi(vcpu);
 
 	guest_state_exit_irqoff();
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index adf2bc13bed2..a06dd2d77f10 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7363,17 +7363,6 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 	}
 }
 
-noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
-{
-	if ((u16)vmx_get_exit_reason(vcpu).basic != EXIT_REASON_EXCEPTION_NMI ||
-	    !is_nmi(vmx_get_intr_info(vcpu)))
-		return;
-
-	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-	kvm_after_interrupt(vcpu);
-}
-
 static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					unsigned int flags)
 {
@@ -7406,7 +7395,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if (likely(!vmx_get_exit_reason(vcpu).failed_vmentry))
 		vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
 
-	vmx_handle_nmi(vcpu);
+	vt_handle_nmi(vcpu);
 
 out:
 	guest_state_exit_irqoff();
-- 
2.55.0.979.g7e5102b832-goog

