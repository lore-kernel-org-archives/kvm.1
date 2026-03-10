Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26F3F20E5
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180261; cv=none; b=gsyjPrM4Y19gDdeYoJVaWyqvH/ClHYfbHDgiV78vBxNGs+vft8+LjGqKMWwafXYI937YWEXc0G8451juzgtSldy+pyOTzKQTR8+qwHFKozQgrrNtDu72wA5EcAqZedDv5lRYuVEXL5zHjhivRPC6+nndnMLZjHU0IHKRs+8W768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180261; c=relaxed/simple;
	bh=lE0K9Je/w0ZhiGDqNCv8UqndQifIY5jPoFxLd4PUljQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T42pSndA+bqopiZU+0RGISn149DRRVcmTQP3Ve+rEyi8kWOLtzCYNrTqT4ZhPf6Mq7ayiURzqWKkxMRv7Wsgmt0yvDDFl7tBEWcNiESZmZdveQiHe0JSqwYkj2279bLCGvjaS6P7GQvWOrw2UBBm80gSqbSz00hd4pvy1Xj5oWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOy3zJ1R; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOy3zJ1R"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4e9577ceso489481255ad.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 15:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773180256; x=1773785056; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NmflkMmCh1+M25HJ2VtiJQJbU+JaF3SO+uDwG5B5XM=;
        b=iOy3zJ1Rs+lfLKhM2oyBnkXKIxE5dGy4NwIdXMTaf/Rsjqeq0AUdt2uadaFXUGTxtJ
         MK486YSck1HLuVlY4qUiSpsZC67kKGc/KwNDeclPtqCYhYdV+iD1Jt+UHCHtkv6OHaR3
         wvc73ykQhpyPlBqXJdf835gO6Y26mrJYShVAqe+Z/62oOyK4Uwbr1RcXGfsO5O0mE9Ba
         CtMgNkcSKGCGZSCKxms/P2+M5qW3PRszDxqa1S/r2z5Os50Dlybj25BrSpuXkfGZAtPa
         WPxzqC5nACDBPCLyV0sdITnPaxKZsdrI5vVwZMmjDvZutKp7NYO0mmAARMil/dyKBeDP
         ve3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773180256; x=1773785056;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0NmflkMmCh1+M25HJ2VtiJQJbU+JaF3SO+uDwG5B5XM=;
        b=oC4Nfd/cy5C+mCdiEl9tW5hLbyDiuOv/jShEzJua+CEp0WhriUmrzHpPmvTRJjFA0X
         0p3O8blJqx+Z78niHITNHBTbi08JgVSnge9WcGUCo60txR8dEomX5e/fjjRn5q205TDI
         s2vrGX/BZYKwPbA/sHXM/F9HyRw1uZDSbC0xwPa0iFKuI2HPwYLM9vLLZ5xTLKcJN4cr
         nmRjdcckh9npbw427pfSujuIOzlcWO2wGD23gNSjVM2FX98+90fF54Q3j/rLVKfR2/Xz
         E2IXJYi0BUtPi3pcHpT6ByYorODcukK/ApSY5T81bPCmi5Bkw0LTk91aS/dS3gxbwdU2
         wq+A==
X-Gm-Message-State: AOJu0YxDr+E11DRrRznFsUrQulN7d5mgm87r6SLBapMQ2uqlbRILpy/0
	2o9jOn6LXpXaYPb7/o49YwWMiH5MBuDK+gMiZVtrNzDtipakjjyN8wVX5m0EGtTAaZ6hrkGA5if
	tknmorQ==
X-Received: from plhz12.prod.google.com ([2002:a17:902:d9cc:b0:2ab:192e:f70d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:174e:b0:2ae:5104:571e
 with SMTP id d9443c01a7336-2aeae76fa46mr2948195ad.9.1773180255942; Tue, 10
 Mar 2026 15:04:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 15:04:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260310220414.2569208-1-seanjc@google.com>
Subject: [PATCH] KVM: SVM: Add a helper to get LBR field pointer to dedup MSR accesses
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Add a helper to get a pointer to the corresponding VMCB field given an LBR
MSR index, and use it to dedup the handling in svm_{g,s}et_msr().

No functional change intended.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 48 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3407deac90bd..88999b6fc8a3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2750,6 +2750,23 @@ static int svm_get_feature_msr(u32 msr, u64 *data)
 	return 0;
 }
 
+static __always_inline u64 *svm_vmcb_lbr(struct vcpu_svm *svm, u32 msr)
+{
+	switch (msr) {
+	case MSR_IA32_LASTBRANCHFROMIP:
+		return &svm->vmcb->save.br_from;
+	case MSR_IA32_LASTBRANCHTOIP:
+		return &svm->vmcb->save.br_to;
+	case MSR_IA32_LASTINTFROMIP:
+		return &svm->vmcb->save.last_excp_from;
+	case MSR_IA32_LASTINTTOIP:
+		return &svm->vmcb->save.last_excp_to;
+	default:
+		break;
+	}
+	BUILD_BUG();
+}
+
 static bool sev_es_prevent_msr_access(struct kvm_vcpu *vcpu,
 				      struct msr_data *msr_info)
 {
@@ -2826,16 +2843,10 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = lbrv ? svm->vmcb->save.dbgctl : 0;
 		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		msr_info->data = lbrv ? svm->vmcb->save.br_from : 0;
-		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		msr_info->data = lbrv ? svm->vmcb->save.br_to : 0;
-		break;
 	case MSR_IA32_LASTINTFROMIP:
-		msr_info->data = lbrv ? svm->vmcb->save.last_excp_from : 0;
-		break;
 	case MSR_IA32_LASTINTTOIP:
-		msr_info->data = lbrv ? svm->vmcb->save.last_excp_to : 0;
+		msr_info->data = lbrv ? *svm_vmcb_lbr(svm, msr_info->index) : 0;
 		break;
 	case MSR_VM_HSAVE_PA:
 		msr_info->data = svm->nested.hsave_msr;
@@ -3111,35 +3122,14 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		svm_update_lbrv(vcpu);
 		break;
 	case MSR_IA32_LASTBRANCHFROMIP:
-		if (!lbrv)
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (!msr->host_initiated)
-			return 1;
-		svm->vmcb->save.br_from = data;
-		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
-		break;
 	case MSR_IA32_LASTBRANCHTOIP:
-		if (!lbrv)
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (!msr->host_initiated)
-			return 1;
-		svm->vmcb->save.br_to = data;
-		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
-		break;
 	case MSR_IA32_LASTINTFROMIP:
-		if (!lbrv)
-			return KVM_MSR_RET_UNSUPPORTED;
-		if (!msr->host_initiated)
-			return 1;
-		svm->vmcb->save.last_excp_from = data;
-		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
-		break;
 	case MSR_IA32_LASTINTTOIP:
 		if (!lbrv)
 			return KVM_MSR_RET_UNSUPPORTED;
 		if (!msr->host_initiated)
 			return 1;
-		svm->vmcb->save.last_excp_to = data;
+		*svm_vmcb_lbr(svm, ecx) = data;
 		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		break;
 	case MSR_VM_HSAVE_PA:

base-commit: 5128b972fb2801ad9aca54d990a75611ab5283a9
-- 
2.53.0.473.g4a7958ca14-goog

