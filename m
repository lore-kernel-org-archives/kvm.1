Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D7399364
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774579; cv=none; b=SUuRLh16n4Ee1NX7VUqRfL+HIcYbD4XbfUS3n0nBsIsAGyCHIj3lv4nTNR7PLCgZm23FO0kKJI47wd8h7vr/tLYbja8uBevJOheNVhCtOwxirlrhpMr++lbnmy8+W0ec4nqG4AjvzjSXuUp8UBBwHgvXD4lNiytaQY8Km1Z1YLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774579; c=relaxed/simple;
	bh=60Q/zHtyyGDIBP/ak7485shWUHxtFzoB9QyfDmyCpMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Vluz+n27VJ578J86Z4Ym1YjLf2L8yEMp0b84NRlzN1EGVxDIC/Xramw2i2zwoeYUZClSntqHePa1oo6pgm25bzv2JFpijqJ5i80By9ZM344jritDx/OizRlVdDwJd7aKzp0IkKzt9TfylOzEmI0d5AZEN0YfSCol6tITa2LFVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fiVQyvVz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fiVQyvVz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c6929bd26so1455196b3a.3
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775774577; x=1776379377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7rpQhjNm3mTGjbc05HVtkw07FHdO4o+YZx1lMSvn+bc=;
        b=fiVQyvVz2bhZQHA87I5g+R/Xxvnvl3jw+A5EwEIveFUBSbD0Au/julNDq1LlLuPhiF
         a2oqMSvTLaou8FD++Vcz4uv0N/XOtT/zytdENxtTMJccafSk/c67eOPuty+QAFA5fcQI
         FDoxSXvmBpRXlmMbkD1YRtRo2peqNFdsuxH56FfwV9oY3EXkX5SEJVW3G5TLY3pIcFK6
         5UGdB/CcOoJij2JPsEMr5hEwAOb/cBb6lPk1iYIHjunM0w7KtMmlLJcbLqKZ84zZMQZi
         TsQoUfY5JK9q6LRRWeJH4P9f8+D5Gn7qDw9wQ3waeA7nRCHHFgMmIgMuk0ysc5/Z1+Kf
         dtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774577; x=1776379377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rpQhjNm3mTGjbc05HVtkw07FHdO4o+YZx1lMSvn+bc=;
        b=SgXvvVYCe8d4021i1Mc3YxtiQF3NPQHfMx9j3Tah9vSBia3X+rU2tPCtm79Ux77CsH
         Nwnsfy4eBj2uB5qvr02/Dfy1uJbzOEKwrI2SOtberKyK0Hj0XsP/bz2RP5yRrvmMa/OC
         T6eKvXIfjf3w3CWXXJo1IEIaodq5Q8+c1G6YxXHh8UwVehvCNhazdb6hD+UAlYRtZfA4
         giTkBNu/tML/vJx7OtRwenCh66NLYS4dtE5/0VtMNfnaxfvIdX7poLPUr8LtNXNLZT0o
         rPCvpqB6oqus9kN5jn6+0fqo8+qcYofehUzU1qNhIeu0BP8y+/urKMCqSESEWjYp07/y
         Fxmg==
X-Gm-Message-State: AOJu0YwBNo8bCMs3iD+BQd5lnihEp6gFeyW0riLFiQrwKVOj+USrAjE6
	d2rjctY0vULErngHlGCvJ1FfgY17b2KK1zEWQK3lSnmaCOArkrMo21D2VuED0qvXQuhDIWp2Cyj
	ynjxT6A==
X-Received: from pfbdh4.prod.google.com ([2002:a05:6a00:4784:b0:829:94bc:6c15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4c98:b0:82c:ec1b:9e15
 with SMTP id d2e1a72fcca58-82f0c1e99bbmr915561b3a.1.1775774576585; Thu, 09
 Apr 2026 15:42:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:42:34 -0700
In-Reply-To: <20260409224236.2021562-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409224236.2021562-6-seanjc@google.com>
Subject: [PATCH v2 5/6] KVM: x86: Track available/dirty register masks as
 "unsigned long" values
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Convert regs_{avail,dirty} and all related masks to "unsigned long" values
as an intermediate step towards declaring the fields as actual bitmaps, and
as a step toward support APX, which will push the total number of registers
beyond 32 on 64-bit kernels.

Opportunistically convert TDX's ULL bitmask to a UL to match everything
else (TDX is 64-bit only, so it's a nop in the end).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/kvm_cache_regs.h   |  2 +-
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/tdx.c          | 36 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.h          | 20 +++++++++---------
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b1eae1e7b04f..c47eb294c066 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -802,8 +802,8 @@ struct kvm_vcpu_arch {
 	 */
 	unsigned long regs[NR_VCPU_GENERAL_PURPOSE_REGS];
 	unsigned long rip;
-	u32 regs_avail;
-	u32 regs_dirty;
+	unsigned long regs_avail;
+	unsigned long regs_dirty;
 
 	unsigned long cr0;
 	unsigned long cr0_guest_owned_bits;
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 7f71d468178c..171e6bc2e169 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -106,7 +106,7 @@ static __always_inline bool kvm_register_test_and_mark_available(struct kvm_vcpu
 }
 
 static __always_inline void kvm_clear_available_registers(struct kvm_vcpu *vcpu,
-							  u32 clear_mask)
+							  unsigned long clear_mask)
 {
 	/*
 	 * Note the bitwise-AND!  In practice, a straight write would also work
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 677d268ae9c7..7b46a3f13de1 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -474,7 +474,7 @@ static inline bool svm_is_vmrun_failure(u64 exit_code)
  * KVM_REQ_LOAD_MMU_PGD is always requested when the cached vcpu->arch.cr3
  * is changed.  svm_load_mmu_pgd() then syncs the new CR3 value into the VMCB.
  */
-#define SVM_REGS_LAZY_LOAD_SET	(1 << VCPU_REG_PDPTR)
+#define SVM_REGS_LAZY_LOAD_SET	(BIT(VCPU_REG_PDPTR))
 
 static inline void __vmcb_set_intercept(unsigned long *intercepts, u32 bit)
 {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c9ab7902151f..85f28363e4cc 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1013,23 +1013,23 @@ static fastpath_t tdx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 	return EXIT_FASTPATH_NONE;
 }
 
-#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_REG_EXIT_INFO_1) | \
-				 BIT_ULL(VCPU_REG_EXIT_INFO_2) | \
-				 BIT_ULL(VCPU_REGS_RAX) | \
-				 BIT_ULL(VCPU_REGS_RBX) | \
-				 BIT_ULL(VCPU_REGS_RCX) | \
-				 BIT_ULL(VCPU_REGS_RDX) | \
-				 BIT_ULL(VCPU_REGS_RBP) | \
-				 BIT_ULL(VCPU_REGS_RSI) | \
-				 BIT_ULL(VCPU_REGS_RDI) | \
-				 BIT_ULL(VCPU_REGS_R8) | \
-				 BIT_ULL(VCPU_REGS_R9) | \
-				 BIT_ULL(VCPU_REGS_R10) | \
-				 BIT_ULL(VCPU_REGS_R11) | \
-				 BIT_ULL(VCPU_REGS_R12) | \
-				 BIT_ULL(VCPU_REGS_R13) | \
-				 BIT_ULL(VCPU_REGS_R14) | \
-				 BIT_ULL(VCPU_REGS_R15))
+#define TDX_REGS_AVAIL_SET	(BIT(VCPU_REG_EXIT_INFO_1) | \
+				 BIT(VCPU_REG_EXIT_INFO_2) | \
+				 BIT(VCPU_REGS_RAX) | \
+				 BIT(VCPU_REGS_RBX) | \
+				 BIT(VCPU_REGS_RCX) | \
+				 BIT(VCPU_REGS_RDX) | \
+				 BIT(VCPU_REGS_RBP) | \
+				 BIT(VCPU_REGS_RSI) | \
+				 BIT(VCPU_REGS_RDI) | \
+				 BIT(VCPU_REGS_R8) | \
+				 BIT(VCPU_REGS_R9) | \
+				 BIT(VCPU_REGS_R10) | \
+				 BIT(VCPU_REGS_R11) | \
+				 BIT(VCPU_REGS_R12) | \
+				 BIT(VCPU_REGS_R13) | \
+				 BIT(VCPU_REGS_R14) | \
+				 BIT(VCPU_REGS_R15))
 
 static void tdx_load_host_xsave_state(struct kvm_vcpu *vcpu)
 {
@@ -1098,7 +1098,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	tdx_load_host_xsave_state(vcpu);
 
-	kvm_clear_available_registers(vcpu, ~(u32)TDX_REGS_AVAIL_SET);
+	kvm_clear_available_registers(vcpu, ~TDX_REGS_AVAIL_SET);
 
 	if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
 		return EXIT_FASTPATH_NONE;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9fb76ea48caf..48447fa983f4 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -620,16 +620,16 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC_CONTROL, 64)
  * cache on demand.  Other registers not listed here are synced to
  * the cache immediately after VM-Exit.
  */
-#define VMX_REGS_LAZY_LOAD_SET	((1 << VCPU_REG_RIP) |         \
-				(1 << VCPU_REGS_RSP) |          \
-				(1 << VCPU_REG_RFLAGS) |      \
-				(1 << VCPU_REG_PDPTR) |       \
-				(1 << VCPU_REG_SEGMENTS) |    \
-				(1 << VCPU_REG_CR0) |         \
-				(1 << VCPU_REG_CR3) |         \
-				(1 << VCPU_REG_CR4) |         \
-				(1 << VCPU_REG_EXIT_INFO_1) | \
-				(1 << VCPU_REG_EXIT_INFO_2))
+#define VMX_REGS_LAZY_LOAD_SET	(BIT(VCPU_REGS_RSP) |		\
+				 BIT(VCPU_REG_RIP) |		\
+				 BIT(VCPU_REG_RFLAGS) |		\
+				 BIT(VCPU_REG_PDPTR) |		\
+				 BIT(VCPU_REG_SEGMENTS) |	\
+				 BIT(VCPU_REG_CR0) |		\
+				 BIT(VCPU_REG_CR3) |		\
+				 BIT(VCPU_REG_CR4) |		\
+				 BIT(VCPU_REG_EXIT_INFO_1) |	\
+				 BIT(VCPU_REG_EXIT_INFO_2))
 
 static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
 {
-- 
2.53.0.1213.gd9a14994de-goog

