Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24E239659A
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775774573; cv=none; b=DVTexpJS3wGfdtja0KdaJJHlxGsHlteTcFOP2J7Dn8aYfFKApBufBpVMO6kRuY38U95IQLYniE07kSskD92mTVHAPBUQb/nFRJD9edZYiUpIm/9x3+mityieJo5If05J6P12fSi9JJsjVT3LeuqcqsbmgfJIBhX2sY3eKppvwBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775774573; c=relaxed/simple;
	bh=BWqoYQtBhm8kqHPCG//Ltf+xQapfCYWKp4l+Z2Ugs0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qrAoAlHYv3JSrsWj3Gyoab7I/LxzqGQQ+HRzdigczaBzFS15zQud0V0Z+0wHUJ2PT95M9r5gB+5r7Rk/6QsY0wlwrU83EJ0LhGSHsL9ne19QgdmhlbjKff2WeyGZliMxk7FrDlc0mlvP1dYd5LEIb+ll0mNvjk8MS84wV6TVRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khzQmL7X; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khzQmL7X"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0f4e632caso21403455ad.3
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775774571; x=1776379371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISba7WJRVs+RImaJEsr8hL9vwMMdBHQV2nut6xn7NB4=;
        b=khzQmL7X37N7UtDeuv1GaOo3TkdptB8hlJacwmuwNnGPECBrWxEfsJ6l32l8wiLMpL
         xekrA1PZJUut0K49bLLMMkOipnYc4otiSc5fv9sFypLcOs/BQvwn5pSho+uQ/Z74a3m2
         Mdoi384bROGBistFumN7DPEVfSFA/msg1ANxp9DYRDC5wg9Gq4XtEr3luB/uEYC/VSFN
         kUtC2eCvAOSj4l7C80xCXMvYjMXUvcdwrKVWdzwk7Jzvdf/zGiLCPaHzX3fzCysoX9g/
         3x/yru2tWTei6HEbwq9/1i/oPvh6/DqUDjgQ0d1FjJGzKkXojMERoNwmJXy0p3C2c33T
         alNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775774571; x=1776379371;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISba7WJRVs+RImaJEsr8hL9vwMMdBHQV2nut6xn7NB4=;
        b=lflevf3OiAQiixHC9Xwz/pUO4oYbg3RseICN/+ojCmakBFnD/Jcn8dvHg7JQdXhACU
         n4OLML/soLctdHNdbpu/pMj1ZJOaOD/OFcir5Km/FaJ+sgtJlBB7n7CwQlzaRtxIrSde
         sO1bwdN9vS1iISDh0U6YANzLQvriUwdIM6TmfPCacg6+mUOjDcdJZQcQgKS2rQuR9zP7
         g6riwCe1eHE1TqmoqcdsP7CauQNNUuijYySNKJdNdqr4aoSpY/a07Kz3j3P/B5dzaPNH
         sPglojIvcd6TeC9KPfsthLr2ZtK84uit3Kqt7P4OsVkfx03MHteYZ4PHWQyA//NpnMuk
         f+sQ==
X-Gm-Message-State: AOJu0YxBkx7s0tXEOvxlal6j2wdJyq8KAKAcIEgHvKtAQaYPShdJ/Sor
	plqo3th0Hb672duas04ONx3GclxGxZJZLCLbW124Yngw8EjIkkU0Jk426s0C6/mW2LPf/UdqABU
	Ae3JMVg==
X-Received: from plgv18.prod.google.com ([2002:a17:902:e8d2:b0:2b0:aa9a:2c78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:7616:b0:2ae:4a4e:1e25
 with SMTP id d9443c01a7336-2b2d5a348f0mr4593565ad.25.1775774570949; Thu, 09
 Apr 2026 15:42:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 15:42:31 -0700
In-Reply-To: <20260409224236.2021562-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409224236.2021562-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409224236.2021562-3-seanjc@google.com>
Subject: [PATCH v2 2/6] KVM: x86: Drop the "EX" part of "EXREG" to avoid
 collision with APX
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now that NR_VCPU_REGS is no longer a thing, and now that now that RIP is
effectively an EXREG, drop the "EX" is for extended (or maybe extra?")
prefix from non-GPR registers to avoid a collision with APX (Advanced
Performance Extensions), which adds:

  16 additional general-purpose registers (GPRs) R16=E2=80=93R31, also refe=
rred
  to as Extended GPRs (EGPRs)  in this document;

I.e. KVM's version of "extended" won't match with APX's definition.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 18 +++++++--------
 arch/x86/kvm/kvm_cache_regs.h   | 16 ++++++-------
 arch/x86/kvm/svm/svm.c          |  6 ++---
 arch/x86/kvm/svm/svm.h          |  2 +-
 arch/x86/kvm/vmx/nested.c       |  6 ++---
 arch/x86/kvm/vmx/tdx.c          |  4 ++--
 arch/x86/kvm/vmx/vmx.c          | 40 ++++++++++++++++-----------------
 arch/x86/kvm/vmx/vmx.h          | 20 ++++++++---------
 arch/x86/kvm/x86.c              | 16 ++++++-------
 9 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 68a11325e8bc..b1eae1e7b04f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -195,8 +195,8 @@ enum kvm_reg {
=20
 	VCPU_REG_RIP =3D NR_VCPU_GENERAL_PURPOSE_REGS,
=20
-	VCPU_EXREG_PDPTR,
-	VCPU_EXREG_CR0,
+	VCPU_REG_PDPTR,
+	VCPU_REG_CR0,
 	/*
 	 * Alias AMD's ERAPS (not a real register) to CR3 so that common code
 	 * can trigger emulation of the RAP (Return Address Predictor) with
@@ -204,13 +204,13 @@ enum kvm_reg {
 	 * is cleared on writes to CR3, i.e. marking CR3 dirty will naturally
 	 * mark ERAPS dirty as well.
 	 */
-	VCPU_EXREG_CR3,
-	VCPU_EXREG_ERAPS =3D VCPU_EXREG_CR3,
-	VCPU_EXREG_CR4,
-	VCPU_EXREG_RFLAGS,
-	VCPU_EXREG_SEGMENTS,
-	VCPU_EXREG_EXIT_INFO_1,
-	VCPU_EXREG_EXIT_INFO_2,
+	VCPU_REG_CR3,
+	VCPU_REG_ERAPS =3D VCPU_REG_CR3,
+	VCPU_REG_CR4,
+	VCPU_REG_RFLAGS,
+	VCPU_REG_SEGMENTS,
+	VCPU_REG_EXIT_INFO_1,
+	VCPU_REG_EXIT_INFO_2,
 };
=20
 enum {
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 9b7df9de0e87..ac1f9867a234 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -159,8 +159,8 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu,=
 int index)
 {
 	might_sleep();  /* on svm */
=20
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_PDPTR))
-		kvm_x86_call(cache_reg)(vcpu, VCPU_EXREG_PDPTR);
+	if (!kvm_register_is_available(vcpu, VCPU_REG_PDPTR))
+		kvm_x86_call(cache_reg)(vcpu, VCPU_REG_PDPTR);
=20
 	return vcpu->arch.walk_mmu->pdptrs[index];
 }
@@ -174,8 +174,8 @@ static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *=
vcpu, ulong mask)
 {
 	ulong tmask =3D mask & KVM_POSSIBLE_CR0_GUEST_BITS;
 	if ((tmask & vcpu->arch.cr0_guest_owned_bits) &&
-	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR0))
-		kvm_x86_call(cache_reg)(vcpu, VCPU_EXREG_CR0);
+	    !kvm_register_is_available(vcpu, VCPU_REG_CR0))
+		kvm_x86_call(cache_reg)(vcpu, VCPU_REG_CR0);
 	return vcpu->arch.cr0 & mask;
 }
=20
@@ -196,8 +196,8 @@ static inline ulong kvm_read_cr4_bits(struct kvm_vcpu *=
vcpu, ulong mask)
 {
 	ulong tmask =3D mask & KVM_POSSIBLE_CR4_GUEST_BITS;
 	if ((tmask & vcpu->arch.cr4_guest_owned_bits) &&
-	    !kvm_register_is_available(vcpu, VCPU_EXREG_CR4))
-		kvm_x86_call(cache_reg)(vcpu, VCPU_EXREG_CR4);
+	    !kvm_register_is_available(vcpu, VCPU_REG_CR4))
+		kvm_x86_call(cache_reg)(vcpu, VCPU_REG_CR4);
 	return vcpu->arch.cr4 & mask;
 }
=20
@@ -211,8 +211,8 @@ static __always_inline bool kvm_is_cr4_bit_set(struct k=
vm_vcpu *vcpu,
=20
 static inline ulong kvm_read_cr3(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-		kvm_x86_call(cache_reg)(vcpu, VCPU_EXREG_CR3);
+	if (!kvm_register_is_available(vcpu, VCPU_REG_CR3))
+		kvm_x86_call(cache_reg)(vcpu, VCPU_REG_CR3);
 	return vcpu->arch.cr3;
 }
=20
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 85edaee27b03..ee5749d8b3e8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1517,7 +1517,7 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, enum=
 kvm_reg reg)
 	kvm_register_mark_available(vcpu, reg);
=20
 	switch (reg) {
-	case VCPU_EXREG_PDPTR:
+	case VCPU_REG_PDPTR:
 		/*
 		 * When !npt_enabled, mmu->pdptrs[] is already available since
 		 * it is always updated per SDM when moving to CRs.
@@ -4179,7 +4179,7 @@ static void svm_flush_tlb_gva(struct kvm_vcpu *vcpu, =
gva_t gva)
=20
 static void svm_flush_tlb_guest(struct kvm_vcpu *vcpu)
 {
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_ERAPS);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS);
=20
 	svm_flush_tlb_asid(vcpu);
 }
@@ -4457,7 +4457,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_=
vcpu *vcpu, u64 run_flags)
 	svm->vmcb->save.cr2 =3D vcpu->arch.cr2;
=20
 	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS) &&
-	    kvm_register_is_dirty(vcpu, VCPU_EXREG_ERAPS))
+	    kvm_register_is_dirty(vcpu, VCPU_REG_ERAPS))
 		svm->vmcb->control.erap_ctl |=3D ERAP_CONTROL_CLEAR_RAP;
=20
 	svm_fixup_nested_rips(vcpu);
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index fd0652b32c81..677d268ae9c7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -474,7 +474,7 @@ static inline bool svm_is_vmrun_failure(u64 exit_code)
  * KVM_REQ_LOAD_MMU_PGD is always requested when the cached vcpu->arch.cr3
  * is changed.  svm_load_mmu_pgd() then syncs the new CR3 value into the V=
MCB.
  */
-#define SVM_REGS_LAZY_LOAD_SET	(1 << VCPU_EXREG_PDPTR)
+#define SVM_REGS_LAZY_LOAD_SET	(1 << VCPU_REG_PDPTR)
=20
 static inline void __vmcb_set_intercept(unsigned long *intercepts, u32 bit=
)
 {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3fe88f29be7a..22b1f06a9d40 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1189,7 +1189,7 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu,=
 unsigned long cr3,
 	}
=20
 	vcpu->arch.cr3 =3D cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
=20
 	/* Re-initialize the MMU, e.g. to pick up CR4 MMU role changes. */
 	kvm_init_mmu(vcpu);
@@ -4972,7 +4972,7 @@ static void nested_vmx_restore_host_state(struct kvm_=
vcpu *vcpu)
=20
 	nested_ept_uninit_mmu_context(vcpu);
 	vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
-	kvm_register_mark_available(vcpu, VCPU_EXREG_CR3);
+	kvm_register_mark_available(vcpu, VCPU_REG_CR3);
=20
 	/*
 	 * Use ept_save_pdptrs(vcpu) to load the MMU's cached PDPTRs
@@ -5074,7 +5074,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 v=
m_exit_reason,
 	kvm_service_local_tlb_flush_requests(vcpu);
=20
 	/*
-	 * VCPU_EXREG_PDPTR will be clobbered in arch/x86/kvm/vmx/vmx.h between
+	 * VCPU_REG_PDPTR will be clobbered in arch/x86/kvm/vmx/vmx.h between
 	 * now and the new vmentry.  Ensure that the VMCS02 PDPTR fields are
 	 * up-to-date before switching to L1.
 	 */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..c23ec4ac8bc8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1013,8 +1013,8 @@ static fastpath_t tdx_exit_handlers_fastpath(struct k=
vm_vcpu *vcpu)
 	return EXIT_FASTPATH_NONE;
 }
=20
-#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_EXREG_EXIT_INFO_1) | \
-				 BIT_ULL(VCPU_EXREG_EXIT_INFO_2) | \
+#define TDX_REGS_AVAIL_SET	(BIT_ULL(VCPU_REG_EXIT_INFO_1) | \
+				 BIT_ULL(VCPU_REG_EXIT_INFO_2) | \
 				 BIT_ULL(VCPU_REGS_RAX) | \
 				 BIT_ULL(VCPU_REGS_RBX) | \
 				 BIT_ULL(VCPU_REGS_RCX) | \
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 577b0c6286ad..aa1c26018439 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -843,8 +843,8 @@ static bool vmx_segment_cache_test_set(struct vcpu_vmx =
*vmx, unsigned seg,
 	bool ret;
 	u32 mask =3D 1 << (seg * SEG_FIELD_NR + field);
=20
-	if (!kvm_register_is_available(&vmx->vcpu, VCPU_EXREG_SEGMENTS)) {
-		kvm_register_mark_available(&vmx->vcpu, VCPU_EXREG_SEGMENTS);
+	if (!kvm_register_is_available(&vmx->vcpu, VCPU_REG_SEGMENTS)) {
+		kvm_register_mark_available(&vmx->vcpu, VCPU_REG_SEGMENTS);
 		vmx->segment_cache.bitmask =3D 0;
 	}
 	ret =3D vmx->segment_cache.bitmask & mask;
@@ -1609,8 +1609,8 @@ unsigned long vmx_get_rflags(struct kvm_vcpu *vcpu)
 	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
 	unsigned long rflags, save_rflags;
=20
-	if (!kvm_register_is_available(vcpu, VCPU_EXREG_RFLAGS)) {
-		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
+	if (!kvm_register_is_available(vcpu, VCPU_REG_RFLAGS)) {
+		kvm_register_mark_available(vcpu, VCPU_REG_RFLAGS);
 		rflags =3D vmcs_readl(GUEST_RFLAGS);
 		if (vmx->rmode.vm86_active) {
 			rflags &=3D RMODE_GUEST_OWNED_EFLAGS_BITS;
@@ -1633,7 +1633,7 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned l=
ong rflags)
 	 * if L1 runs L2 as a restricted guest.
 	 */
 	if (is_unrestricted_guest(vcpu)) {
-		kvm_register_mark_available(vcpu, VCPU_EXREG_RFLAGS);
+		kvm_register_mark_available(vcpu, VCPU_REG_RFLAGS);
 		vmx->rflags =3D rflags;
 		vmcs_writel(GUEST_RFLAGS, rflags);
 		return;
@@ -2607,17 +2607,17 @@ void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_=
reg reg)
 	case VCPU_REG_RIP:
 		vcpu->arch.rip =3D vmcs_readl(GUEST_RIP);
 		break;
-	case VCPU_EXREG_PDPTR:
+	case VCPU_REG_PDPTR:
 		if (enable_ept)
 			ept_save_pdptrs(vcpu);
 		break;
-	case VCPU_EXREG_CR0:
+	case VCPU_REG_CR0:
 		guest_owned_bits =3D vcpu->arch.cr0_guest_owned_bits;
=20
 		vcpu->arch.cr0 &=3D ~guest_owned_bits;
 		vcpu->arch.cr0 |=3D vmcs_readl(GUEST_CR0) & guest_owned_bits;
 		break;
-	case VCPU_EXREG_CR3:
+	case VCPU_REG_CR3:
 		/*
 		 * When intercepting CR3 loads, e.g. for shadowing paging, KVM's
 		 * CR3 is loaded into hardware, not the guest's CR3.
@@ -2625,7 +2625,7 @@ void vmx_cache_reg(struct kvm_vcpu *vcpu, enum kvm_re=
g reg)
 		if (!(exec_controls_get(to_vmx(vcpu)) & CPU_BASED_CR3_LOAD_EXITING))
 			vcpu->arch.cr3 =3D vmcs_readl(GUEST_CR3);
 		break;
-	case VCPU_EXREG_CR4:
+	case VCPU_REG_CR4:
 		guest_owned_bits =3D vcpu->arch.cr4_guest_owned_bits;
=20
 		vcpu->arch.cr4 &=3D ~guest_owned_bits;
@@ -3350,7 +3350,7 @@ void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu =3D vcpu->arch.walk_mmu;
=20
-	if (!kvm_register_is_dirty(vcpu, VCPU_EXREG_PDPTR))
+	if (!kvm_register_is_dirty(vcpu, VCPU_REG_PDPTR))
 		return;
=20
 	if (is_pae_paging(vcpu)) {
@@ -3373,7 +3373,7 @@ void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 	mmu->pdptrs[2] =3D vmcs_read64(GUEST_PDPTR2);
 	mmu->pdptrs[3] =3D vmcs_read64(GUEST_PDPTR3);
=20
-	kvm_register_mark_available(vcpu, VCPU_EXREG_PDPTR);
+	kvm_register_mark_available(vcpu, VCPU_REG_PDPTR);
 }
=20
 #define CR3_EXITING_BITS (CPU_BASED_CR3_LOAD_EXITING | \
@@ -3416,7 +3416,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long=
 cr0)
 	vmcs_writel(CR0_READ_SHADOW, cr0);
 	vmcs_writel(GUEST_CR0, hw_cr0);
 	vcpu->arch.cr0 =3D cr0;
-	kvm_register_mark_available(vcpu, VCPU_EXREG_CR0);
+	kvm_register_mark_available(vcpu, VCPU_REG_CR0);
=20
 #ifdef CONFIG_X86_64
 	if (vcpu->arch.efer & EFER_LME) {
@@ -3434,8 +3434,8 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long=
 cr0)
 		 * (correctly) stop reading vmcs.GUEST_CR3 because it thinks
 		 * KVM's CR3 is installed.
 		 */
-		if (!kvm_register_is_available(vcpu, VCPU_EXREG_CR3))
-			vmx_cache_reg(vcpu, VCPU_EXREG_CR3);
+		if (!kvm_register_is_available(vcpu, VCPU_REG_CR3))
+			vmx_cache_reg(vcpu, VCPU_REG_CR3);
=20
 		/*
 		 * When running with EPT but not unrestricted guest, KVM must
@@ -3472,7 +3472,7 @@ void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long=
 cr0)
 		 * GUEST_CR3 is still vmx->ept_identity_map_addr if EPT + !URG.
 		 */
 		if (!(old_cr0_pg & X86_CR0_PG) && (cr0 & X86_CR0_PG))
-			kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+			kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 	}
=20
 	/* depends on vcpu->arch.cr0 to be set to a new value */
@@ -3501,7 +3501,7 @@ void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t ro=
ot_hpa, int root_level)
=20
 		if (!enable_unrestricted_guest && !is_paging(vcpu))
 			guest_cr3 =3D to_kvm_vmx(kvm)->ept_identity_map_addr;
-		else if (kvm_register_is_dirty(vcpu, VCPU_EXREG_CR3))
+		else if (kvm_register_is_dirty(vcpu, VCPU_REG_CR3))
 			guest_cr3 =3D vcpu->arch.cr3;
 		else /* vmcs.GUEST_CR3 is already up-to-date. */
 			update_guest_cr3 =3D false;
@@ -3561,7 +3561,7 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long=
 cr4)
 	}
=20
 	vcpu->arch.cr4 =3D cr4;
-	kvm_register_mark_available(vcpu, VCPU_EXREG_CR4);
+	kvm_register_mark_available(vcpu, VCPU_REG_CR4);
=20
 	if (!enable_unrestricted_guest) {
 		if (enable_ept) {
@@ -5021,7 +5021,7 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_=
event)
 	vmcs_write32(GUEST_IDTR_LIMIT, 0xffff);
=20
 	vmx_segment_cache_clear(vmx);
-	kvm_register_mark_available(vcpu, VCPU_EXREG_SEGMENTS);
+	kvm_register_mark_available(vcpu, VCPU_REG_SEGMENTS);
=20
 	vmcs_write32(GUEST_ACTIVITY_STATE, GUEST_ACTIVITY_ACTIVE);
 	vmcs_write32(GUEST_INTERRUPTIBILITY_INFO, 0);
@@ -7514,9 +7514,9 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 ru=
n_flags)
=20
 		vmx->vt.exit_reason.full =3D EXIT_REASON_INVALID_STATE;
 		vmx->vt.exit_reason.failed_vmentry =3D 1;
-		kvm_register_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_1);
+		kvm_register_mark_available(vcpu, VCPU_REG_EXIT_INFO_1);
 		vmx->vt.exit_qualification =3D ENTRY_FAIL_DEFAULT;
-		kvm_register_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_2);
+		kvm_register_mark_available(vcpu, VCPU_REG_EXIT_INFO_2);
 		vmx->vt.exit_intr_info =3D 0;
 		return EXIT_FASTPATH_NONE;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d0cc5f6c6879..9fb76ea48caf 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -317,7 +317,7 @@ static __always_inline unsigned long vmx_get_exit_qual(=
struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vt *vt =3D to_vt(vcpu);
=20
-	if (!kvm_register_test_and_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_1) &=
&
+	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_1) &&
 	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
 		vt->exit_qualification =3D vmcs_readl(EXIT_QUALIFICATION);
=20
@@ -328,7 +328,7 @@ static __always_inline u32 vmx_get_intr_info(struct kvm=
_vcpu *vcpu)
 {
 	struct vcpu_vt *vt =3D to_vt(vcpu);
=20
-	if (!kvm_register_test_and_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_2) &=
&
+	if (!kvm_register_test_and_mark_available(vcpu, VCPU_REG_EXIT_INFO_2) &&
 	    !WARN_ON_ONCE(is_td_vcpu(vcpu)))
 		vt->exit_intr_info =3D vmcs_read32(VM_EXIT_INTR_INFO);
=20
@@ -622,14 +622,14 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC=
_CONTROL, 64)
  */
 #define VMX_REGS_LAZY_LOAD_SET	((1 << VCPU_REG_RIP) |         \
 				(1 << VCPU_REGS_RSP) |          \
-				(1 << VCPU_EXREG_RFLAGS) |      \
-				(1 << VCPU_EXREG_PDPTR) |       \
-				(1 << VCPU_EXREG_SEGMENTS) |    \
-				(1 << VCPU_EXREG_CR0) |         \
-				(1 << VCPU_EXREG_CR3) |         \
-				(1 << VCPU_EXREG_CR4) |         \
-				(1 << VCPU_EXREG_EXIT_INFO_1) | \
-				(1 << VCPU_EXREG_EXIT_INFO_2))
+				(1 << VCPU_REG_RFLAGS) |      \
+				(1 << VCPU_REG_PDPTR) |       \
+				(1 << VCPU_REG_SEGMENTS) |    \
+				(1 << VCPU_REG_CR0) |         \
+				(1 << VCPU_REG_CR3) |         \
+				(1 << VCPU_REG_CR4) |         \
+				(1 << VCPU_REG_EXIT_INFO_1) | \
+				(1 << VCPU_REG_EXIT_INFO_2))
=20
 static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..ac05cc289b56 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1090,14 +1090,14 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned lon=
g cr3)
 	}
=20
 	/*
-	 * Marking VCPU_EXREG_PDPTR dirty doesn't work for !tdp_enabled.
+	 * Marking VCPU_REG_PDPTR dirty doesn't work for !tdp_enabled.
 	 * Shadow page roots need to be reconstructed instead.
 	 */
 	if (!tdp_enabled && memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs)))
 		kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);
=20
 	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_PDPTR);
 	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 	vcpu->arch.pdptrs_from_userspace =3D false;
=20
@@ -1478,7 +1478,7 @@ int kvm_set_cr3(struct kvm_vcpu *vcpu, unsigned long =
cr3)
 		kvm_mmu_new_pgd(vcpu, cr3);
=20
 	vcpu->arch.cr3 =3D cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 	/* Do not call post_set_cr3, we do not get here for confidential guests. =
 */
=20
 handle_tlb_flush:
@@ -12473,7 +12473,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu=
, struct kvm_sregs *sregs,
 	vcpu->arch.cr2 =3D sregs->cr2;
 	*mmu_reset_needed |=3D kvm_read_cr3(vcpu) !=3D sregs->cr3;
 	vcpu->arch.cr3 =3D sregs->cr3;
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
 	kvm_x86_call(post_set_cr3)(vcpu, sregs->cr3);
=20
 	kvm_set_cr8(vcpu, sregs->cr8);
@@ -12566,7 +12566,7 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, stru=
ct kvm_sregs2 *sregs2)
 		for (i =3D 0; i < 4 ; i++)
 			kvm_pdptr_write(vcpu, i, sregs2->pdptrs[i]);
=20
-		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
+		kvm_register_mark_dirty(vcpu, VCPU_REG_PDPTR);
 		mmu_reset_needed =3D 1;
 		vcpu->arch.pdptrs_from_userspace =3D true;
 	}
@@ -13111,7 +13111,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool ini=
t_event)
 	kvm_rip_write(vcpu, 0xfff0);
=20
 	vcpu->arch.cr3 =3D 0;
-	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+	kvm_register_mark_dirty(vcpu, VCPU_REG_CR3);
=20
 	/*
 	 * CR0.CD/NW are set on RESET, preserved on INIT.  Note, some versions
@@ -14323,7 +14323,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsig=
ned long type, gva_t gva)
 		 * the RAP (Return Address Predicator).
 		 */
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
-			kvm_register_is_dirty(vcpu, VCPU_EXREG_ERAPS);
+			kvm_register_is_dirty(vcpu, VCPU_REG_ERAPS);
=20
 		kvm_invalidate_pcid(vcpu, operand.pcid);
 		return kvm_skip_emulated_instruction(vcpu);
@@ -14339,7 +14339,7 @@ int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsig=
ned long type, gva_t gva)
 		fallthrough;
 	case INVPCID_TYPE_ALL_INCL_GLOBAL:
 		/*
-		 * Don't bother marking VCPU_EXREG_ERAPS dirty, SVM will take
+		 * Don't bother marking VCPU_REG_ERAPS dirty, SVM will take
 		 * care of doing so when emulating the full guest TLB flush
 		 * (the RAP is cleared on all implicit TLB flushes).
 		 */
--=20
2.53.0.1213.gd9a14994de-goog

