Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21173D1A99
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795648; cv=none; b=JTCbAQT1SAnRIwggBNTMyzQJ7RjlBdJaL2iaE214yPpzsvw80/qQyI5cPzv0VLVm904BI5DDcRKSpRrAsITWxXIgz++a58f5KnJpnE4wFNGdQsBBkITxQHm0ZvDRMhGYfRUPIUQwKFcdQDrdNT0+OcyIjD4NUx4aQ1hwf12/588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795648; c=relaxed/simple;
	bh=u7t/6O99gKqVMGcNhRnugOCAcBoXyxs2DtCzobtXGNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HnxRwrRvYtJJ2QkeEIqj1Ujz9KMZiSBtI0MNHeJdYc7w3r7r0ead4PwoGLRIANDvo63o1U3E3DTZRbgA3OAaU0T6XxeZM7xTgsfUR0u4oePpTPHAnDDnFcK/y+Hv4wJ2WZptG+iDvnVg6wlXiXMTpojkHr1+tp1MadUB5M56ggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XviSiJfq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XviSiJfq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82726f7b0bso3495969a12.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795645; x=1779400445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kj3u+QM9+85lpIpuH+gR93oa8wLXvI0R29z+6Y1bnto=;
        b=XviSiJfqMjtclFqtSrajLAhPXDCY6sugwktQ/ZVAOzva3I8H3a+pBesyPjbHeWShj2
         OVyaAJXpAQbML/Tm4EGHw/5VbBuhi+nFePzBHg88mF59vMz2ZBNz694cW4E5T87r4eGp
         1pnB25KLXoHd3tGSGdmb/gaM0Qbg6VpNN1dcA32aJXYH408ARnKf4mxOSMbE9nFoKS78
         CqHX4tV6lqUvFTfN5fHSuIn0wc4eiEc2JYuiFSaDanp6+yPM82Bw1HcaYcrW60te5OMJ
         wtqEhb+WpWBgXCiwuqmdyz5iDcaXyClEOVk02Q39IAA9BFHnS2rAhXMrVBrpYIXV4BkX
         pNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795645; x=1779400445;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj3u+QM9+85lpIpuH+gR93oa8wLXvI0R29z+6Y1bnto=;
        b=r9ZPrBOnQU4BddzHQWcsygdoCkh8RF8h8nIhOiH1N1euuSsQfPXyfTap38cDIZ8oWp
         Hl2LgXKy+DA15pyhApTOrE7k5/+mmUyFoRGf0SCGk78vdpqyCPM4zwsruSjdMYHlLBDv
         CVCB8J5v7xIU7ciCLEanUKxl0VhaV9dprmT+lAT6hdXtD9a4yemyzxnailHsZ8CVVEx/
         OpUJf5nhhaHqzVzMxbrhnB6NuBEJiB6jz1N25aNdx6yfDzEFwMdak5lcFdjrcCYTU9x5
         xfdi+yHWI4RW2wDhr82rzHyMFRrP80K7wn94ReVhxjjlGmdvRa8+AEc65AoCHjmIXr7C
         qPxA==
X-Forwarded-Encrypted: i=1; AFNElJ/HOpqQuAFv3mvI7t7Oz3rh4fXn9xMkrstcezNiS6AEuElx5LOel1lYmcgeJdxxdLtR26Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrywMJFvMDXzp+Hq5ukanT7Wo+Qgv2BtVXCu2Nvb/Bp36NlyNZ
	Qig45qKrdkL0OsY7v00sSkyX7DreDruW1ct8Mf09etSPKMCMOp4niwlNoMZ/B31kDTnq13d32xF
	SCjwEUw==
X-Received: from pgbbc18.prod.google.com ([2002:a65:6d92:0:b0:c73:7b68:90d9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:394b:b0:3ab:1692:fe91
 with SMTP id adf61e73a8af0-3b22ec63d85mr1000346637.41.1778795644789; Thu, 14
 May 2026 14:54:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:47 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-8-seanjc@google.com>
Subject: [PATCH v2 07/15] KVM: x86: Move inlined CR and DR helpers from x86.h
 to regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move inlined Control Register and Debug Register helpers from x86.h to the
aptly named regs.h, to help trim down x86.h (and x86.c in the future).

Move select EFER functionality, but leave behind all other MSR handling,
There is more than enough MSR code to carve out msr.{c,h} in the future.
Give EFER special treatment as it's an "MSR" in name only, e.g. it's has
far more in common with CR4 than it does with any MSR.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.h | 108 ++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.h  | 102 -----------------------------------------
 2 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 4440f3992fce..ecc66b577e82 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -16,6 +16,37 @@
 
 static_assert(!(KVM_POSSIBLE_CR0_GUEST_BITS & X86_CR0_PDPTR_BITS));
 
+static inline bool is_long_mode(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return !!(vcpu->arch.efer & EFER_LMA);
+#else
+	return false;
+#endif
+}
+
+static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
+{
+	int cs_db, cs_l;
+
+	WARN_ON_ONCE(vcpu->arch.guest_state_protected);
+
+	if (!is_long_mode(vcpu))
+		return false;
+	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
+	return cs_l;
+}
+
+static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * If running with protected guest state, the CS register is not
+	 * accessible. The hypercall register values will have had to been
+	 * provided in 64-bit mode, so assume the guest is in 64-bit.
+	 */
+	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
+}
+
 #define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
 static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
 {									      \
@@ -177,6 +208,12 @@ static inline void kvm_rsp_write(struct kvm_vcpu *vcpu, unsigned long val)
 	kvm_register_write_raw(vcpu, VCPU_REGS_RSP, val);
 }
 
+static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
+{
+	return (kvm_rax_read(vcpu) & -1u)
+		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+}
+
 static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 {
 	might_sleep();  /* on svm */
@@ -243,10 +280,75 @@ static inline ulong kvm_read_cr4(struct kvm_vcpu *vcpu)
 	return kvm_read_cr4_bits(vcpu, ~0UL);
 }
 
-static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
+static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
-	return (kvm_rax_read(vcpu) & -1u)
-		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+	return !(cr4 & vcpu->arch.cr4_guest_rsvd_bits);
+}
+
+#define __cr4_reserved_bits(__cpu_has, __c)             \
+({                                                      \
+	u64 __reserved_bits = CR4_RESERVED_BITS;        \
+                                                        \
+	if (!__cpu_has(__c, X86_FEATURE_XSAVE))         \
+		__reserved_bits |= X86_CR4_OSXSAVE;     \
+	if (!__cpu_has(__c, X86_FEATURE_SMEP))          \
+		__reserved_bits |= X86_CR4_SMEP;        \
+	if (!__cpu_has(__c, X86_FEATURE_SMAP))          \
+		__reserved_bits |= X86_CR4_SMAP;        \
+	if (!__cpu_has(__c, X86_FEATURE_FSGSBASE))      \
+		__reserved_bits |= X86_CR4_FSGSBASE;    \
+	if (!__cpu_has(__c, X86_FEATURE_PKU))           \
+		__reserved_bits |= X86_CR4_PKE;         \
+	if (!__cpu_has(__c, X86_FEATURE_LA57))          \
+		__reserved_bits |= X86_CR4_LA57;        \
+	if (!__cpu_has(__c, X86_FEATURE_UMIP))          \
+		__reserved_bits |= X86_CR4_UMIP;        \
+	if (!__cpu_has(__c, X86_FEATURE_VMX))           \
+		__reserved_bits |= X86_CR4_VMXE;        \
+	if (!__cpu_has(__c, X86_FEATURE_PCID))          \
+		__reserved_bits |= X86_CR4_PCIDE;       \
+	if (!__cpu_has(__c, X86_FEATURE_LAM))           \
+		__reserved_bits |= X86_CR4_LAM_SUP;     \
+	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
+	    !__cpu_has(__c, X86_FEATURE_IBT))           \
+		__reserved_bits |= X86_CR4_CET;         \
+	__reserved_bits;                                \
+})
+
+static inline bool is_protmode(struct kvm_vcpu *vcpu)
+{
+	return kvm_is_cr0_bit_set(vcpu, X86_CR0_PE);
+}
+
+static inline bool is_pae(struct kvm_vcpu *vcpu)
+{
+	return kvm_is_cr4_bit_set(vcpu, X86_CR4_PAE);
+}
+
+static inline bool is_pse(struct kvm_vcpu *vcpu)
+{
+	return kvm_is_cr4_bit_set(vcpu, X86_CR4_PSE);
+}
+
+static inline bool is_paging(struct kvm_vcpu *vcpu)
+{
+	return likely(kvm_is_cr0_bit_set(vcpu, X86_CR0_PG));
+}
+
+static inline bool is_pae_paging(struct kvm_vcpu *vcpu)
+{
+	return !is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu);
+}
+
+static inline bool kvm_dr7_valid(u64 data)
+{
+	/* Bits [63:32] are reserved */
+	return !(data >> 32);
+}
+static inline bool kvm_dr6_valid(u64 data)
+{
+	/* Bits [63:32] are reserved */
+	return !(data >> 32);
 }
 
 static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 2bbecc83ecc2..16d1c3c1a2d9 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -243,42 +243,6 @@ static inline bool kvm_exception_is_soft(unsigned int nr)
 	return (nr == BP_VECTOR) || (nr == OF_VECTOR);
 }
 
-static inline bool is_protmode(struct kvm_vcpu *vcpu)
-{
-	return kvm_is_cr0_bit_set(vcpu, X86_CR0_PE);
-}
-
-static inline bool is_long_mode(struct kvm_vcpu *vcpu)
-{
-#ifdef CONFIG_X86_64
-	return !!(vcpu->arch.efer & EFER_LMA);
-#else
-	return false;
-#endif
-}
-
-static inline bool is_64_bit_mode(struct kvm_vcpu *vcpu)
-{
-	int cs_db, cs_l;
-
-	WARN_ON_ONCE(vcpu->arch.guest_state_protected);
-
-	if (!is_long_mode(vcpu))
-		return false;
-	kvm_x86_call(get_cs_db_l_bits)(vcpu, &cs_db, &cs_l);
-	return cs_l;
-}
-
-static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * If running with protected guest state, the CS register is not
-	 * accessible. The hypercall register values will have had to been
-	 * provided in 64-bit mode, so assume the guest is in 64-bit.
-	 */
-	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
-}
-
 static inline bool x86_exception_has_error_code(unsigned int vector)
 {
 	static u32 exception_has_error_code = BIT(DF_VECTOR) | BIT(TS_VECTOR) |
@@ -293,26 +257,6 @@ static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
 	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
 }
 
-static inline bool is_pae(struct kvm_vcpu *vcpu)
-{
-	return kvm_is_cr4_bit_set(vcpu, X86_CR4_PAE);
-}
-
-static inline bool is_pse(struct kvm_vcpu *vcpu)
-{
-	return kvm_is_cr4_bit_set(vcpu, X86_CR4_PSE);
-}
-
-static inline bool is_paging(struct kvm_vcpu *vcpu)
-{
-	return likely(kvm_is_cr0_bit_set(vcpu, X86_CR0_PG));
-}
-
-static inline bool is_pae_paging(struct kvm_vcpu *vcpu)
-{
-	return !is_long_mode(vcpu) && is_pae(vcpu) && is_paging(vcpu);
-}
-
 static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 {
 	return kvm_is_cr4_bit_set(vcpu, X86_CR4_LA57) ? 57 : 48;
@@ -630,17 +574,6 @@ static inline bool kvm_pat_valid(u64 data)
 	return (data | ((data & 0x0202020202020202ull) << 1)) == data;
 }
 
-static inline bool kvm_dr7_valid(u64 data)
-{
-	/* Bits [63:32] are reserved */
-	return !(data >> 32);
-}
-static inline bool kvm_dr6_valid(u64 data)
-{
-	/* Bits [63:32] are reserved */
-	return !(data >> 32);
-}
-
 /*
  * Trigger machine check on the host. We assume all the MSRs are already set up
  * by the CPU and that we still run on the same CPU as the MCE occurred on.
@@ -687,41 +620,6 @@ enum kvm_msr_access {
 #define  KVM_MSR_RET_UNSUPPORTED	2
 #define  KVM_MSR_RET_FILTERED		3
 
-static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
-{
-	return !(cr4 & vcpu->arch.cr4_guest_rsvd_bits);
-}
-
-#define __cr4_reserved_bits(__cpu_has, __c)             \
-({                                                      \
-	u64 __reserved_bits = CR4_RESERVED_BITS;        \
-                                                        \
-	if (!__cpu_has(__c, X86_FEATURE_XSAVE))         \
-		__reserved_bits |= X86_CR4_OSXSAVE;     \
-	if (!__cpu_has(__c, X86_FEATURE_SMEP))          \
-		__reserved_bits |= X86_CR4_SMEP;        \
-	if (!__cpu_has(__c, X86_FEATURE_SMAP))          \
-		__reserved_bits |= X86_CR4_SMAP;        \
-	if (!__cpu_has(__c, X86_FEATURE_FSGSBASE))      \
-		__reserved_bits |= X86_CR4_FSGSBASE;    \
-	if (!__cpu_has(__c, X86_FEATURE_PKU))           \
-		__reserved_bits |= X86_CR4_PKE;         \
-	if (!__cpu_has(__c, X86_FEATURE_LA57))          \
-		__reserved_bits |= X86_CR4_LA57;        \
-	if (!__cpu_has(__c, X86_FEATURE_UMIP))          \
-		__reserved_bits |= X86_CR4_UMIP;        \
-	if (!__cpu_has(__c, X86_FEATURE_VMX))           \
-		__reserved_bits |= X86_CR4_VMXE;        \
-	if (!__cpu_has(__c, X86_FEATURE_PCID))          \
-		__reserved_bits |= X86_CR4_PCIDE;       \
-	if (!__cpu_has(__c, X86_FEATURE_LAM))           \
-		__reserved_bits |= X86_CR4_LAM_SUP;     \
-	if (!__cpu_has(__c, X86_FEATURE_SHSTK) &&       \
-	    !__cpu_has(__c, X86_FEATURE_IBT))           \
-		__reserved_bits |= X86_CR4_CET;         \
-	__reserved_bits;                                \
-})
-
 int kvm_sev_es_mmio(struct kvm_vcpu *vcpu, bool is_write, gpa_t gpa,
 		    unsigned int bytes, void *data);
 int kvm_sev_es_string_io(struct kvm_vcpu *vcpu, unsigned int size,
-- 
2.54.0.563.g4f69b47b94-goog

