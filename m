Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CA3911C3
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492428; cv=none; b=YVi2X8WPEQ6M4NF23ZaPWQuu/YPM9KK6uKUDOOeWFLZ3JNqTE1gxi7q3ysdnZxZUVs3x+K6/tkIdpDcUmol7Xhb6m1BWBae84w2UWgOlDCwnzpde/2s5UYSP/c/1XViU8Bs2ZWWyrVigitSfKNyDKK22Yjj7CHa2Duq6UFHo9tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492428; c=relaxed/simple;
	bh=dKhndIESxOmMOENIbqkxr6Q8qh/5uCmzDxH6K9ofD4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m7Mzw9OP9ZexCDeqVWXsgE1PPv8e7pVyWdDlrWSzpmMLr2eDWkFDHsDyPgXThfnG5xRIUkbS4z2DRcjTdTQX3d5we7FKzFWfjUKJNbtidUYUsKCK86hktjQhUtaKmBd5oSsO4yMoqyl8RyanSSDzhcA7IleXuHLeRmrTBvDsl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjk+0538; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjk+0538"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso4036419a12.0
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492425; x=1780097225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0kdwtawVGarwPM3X1uzUBTtCZA+NB2eeZjpdD8sKl7w=;
        b=hjk+0538Uu9gPFHlz2D8cOxPs+0xRY5eStludugr73PA3KL8rK+sGY6v6AKTSB/6E/
         TZk0YB7lQV6CWp0DyyE46JLS/V4D0faetinc5JfJIJGNZQ+iiRY0qkUZkfh3Tb2/D0jT
         42m1F0cKMgRSAQ4VXr8btUf4cFvMR105+XlqsG5zHLgc3LVKkIE/q6Q+oExBRtcWozed
         yE6dqZ8nGveVSa9tL3NPVjWf5hfHVzn4/FOAxZQkFTqeT6AUDI21V4KjuWoWNEwpRfy6
         YNGkuJ3zj+3u1b+KG4i682giE/M/QHS9nZ08mwADlY5tK96BgTqRYnG11SDqm2CuAB5G
         0T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492425; x=1780097225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kdwtawVGarwPM3X1uzUBTtCZA+NB2eeZjpdD8sKl7w=;
        b=FX1YN7BaGkGNpqce4e8l7KF4ATk99IueNxti0wuyAWbgiWghkSaZhu2hCmTqDuSvi9
         SELe420xzB24UkQnSFhhcn4qkqWyzWbGHAkTvDJ7VO7iG2D74BKcBFQaRhz0snI81v00
         cSJph2RvoTES5+AsPBj0bu0pYQvzmNrMK1gSiHDuiFO71xkef8xSkIe3Cv8TY/6Tu7gd
         IwV3JcJi47Sq8PiAldUZFK99MkkWXsgO1+Ktwnu4tNUmKcBXAh7UJmqvt/R3VJAk5/20
         n9mV09HfQuMWA5vePtPWewyie7r9wZDNgDiYddN+fYoDFha505E9mUu50EBctGUTUGjy
         iAHg==
X-Gm-Message-State: AOJu0YyG/v6Y+nITejbC43XDcr40Q/LGF++msHcWDk06pUmsxyjpm3AC
	TxVmwfDti6GluYzTdqs/clQGWpDCUz/D6DwXV5X0d2s3MM5zD9Z44l7U5tHSd1fch3JJ/Ncin7D
	6k4oKWQ==
X-Received: from pgt6.prod.google.com ([2002:a63:1346:0:b0:c82:7a06:d5f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d505:b0:3b2:b203:7896
 with SMTP id adf61e73a8af0-3b3293b8415mr5948848637.40.1779492424645; Fri, 22
 May 2026 16:27:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:26:58 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-3-seanjc@google.com>
Subject: [PATCH v4 2/5] KVM: x86: Tell ->inject_page_fault() whether or a
 fault came from hardware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

When injecting a page fault (including nested TDP faults into L1), tell the
injection routine whether or not the fault originated in hardware, i.e. if
KVM is effectively forwarding a fault it intercept.  For nested TDP fault
injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information from the
VMCB/VMCS, _if_ the fault originated in hardware.

No functional change intended (nothing uses the new param, yet...).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
 arch/x86/kvm/svm/nested.c       |  3 ++-
 arch/x86/kvm/vmx/nested.c       |  3 ++-
 arch/x86/kvm/x86.c              | 16 +++++++++-------
 5 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 271bdd109a98..d11063c36f03 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -484,7 +484,8 @@ struct kvm_mmu {
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault);
+				  struct x86_exception *fault,
+				  bool from_hardware);
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
@@ -2305,9 +2306,18 @@ void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code);
 void kvm_queue_exception_p(struct kvm_vcpu *vcpu, unsigned nr, unsigned long payload);
 void kvm_requeue_exception(struct kvm_vcpu *vcpu, unsigned int nr,
 			   bool has_error_code, u32 error_code);
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault);
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault);
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware);
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware);
+
+static inline void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+						  struct x86_exception *fault)
+{
+	__kvm_inject_emulated_page_fault(vcpu, fault, false);
+}
+
 bool kvm_require_cpl(struct kvm_vcpu *vcpu, int required_cpl);
 bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 51f8b4522314..cc9c7deb34bc 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -813,7 +813,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 */
 	if (!r) {
 		if (!fault->prefetch)
-			kvm_inject_emulated_page_fault(vcpu, &walker.fault);
+			__kvm_inject_emulated_page_fault(vcpu, &walker.fault, true);
 
 		return RET_PF_RETRY;
 	}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4ef9bc6a553f..1c1a5e322d18 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -34,7 +34,8 @@
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
 static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
-				       struct x86_exception *fault)
+				       struct x86_exception *fault,
+				       bool from_hardware)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb = svm->vmcb;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4690a4d23709..3bb7eaa7b2a5 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -411,7 +411,8 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
-		struct x86_exception *fault)
+					 struct x86_exception *fault,
+					 bool from_hardware)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cecb2f84e5e0..aa2f8f43d94c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -969,7 +969,8 @@ static int complete_emulated_insn_gp(struct kvm_vcpu *vcpu, int err)
 				       EMULTYPE_COMPLETE_USER_EXIT);
 }
 
-void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
+void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault,
+			   bool from_hardware)
 {
 	++vcpu->stat.pf_guest;
 
@@ -986,8 +987,9 @@ void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
 					fault->address);
 }
 
-void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
-				    struct x86_exception *fault)
+void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
+				      struct x86_exception *fault,
+				      bool from_hardware)
 {
 	struct kvm_mmu *fault_mmu;
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
@@ -1004,9 +1006,9 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 		kvm_mmu_invalidate_addr(vcpu, fault_mmu, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->inject_page_fault(vcpu, fault);
+	fault_mmu->inject_page_fault(vcpu, fault, from_hardware);
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inject_emulated_page_fault);
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_inject_emulated_page_fault);
 
 void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 {
@@ -14065,7 +14067,7 @@ bool kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
 		fault.nested_page_fault = false;
 		fault.address = work->arch.token;
 		fault.async_page_fault = true;
-		kvm_inject_page_fault(vcpu, &fault);
+		kvm_inject_page_fault(vcpu, &fault, false);
 		return true;
 	} else {
 		/*
@@ -14236,7 +14238,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault);
+	vcpu->arch.walk_mmu->inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.54.0.794.g4f17f83d09-goog

