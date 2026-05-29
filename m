Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33013C1418
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093377; cv=none; b=dMhXZaHHJmiETUY2YJQCa9X29f45HqCxlRIWoAhYukjwn3rJISud98qR7NSIeG/yv/2GuY/zsKNDfVdmPvO9GLsH5Z89v8HNxZCOeinnErpv3Wz/cSBJOng+NIlY5ya5WnVhPQ4DpFRZku9REq5TShXRo9vvRp2b65ZU1dFNdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093377; c=relaxed/simple;
	bh=I4JrKYYUi9Z/UJsEexbtKy+IMRYAO5db/1mDENYIFq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oZ63bFMJy5T1Kw4uVcPSYvMKBhGIPxcXtsU1Cd1xzUBJFe4eqZ0qodhrBYmpupqzlE4SWhTzXxDk8/TdiGOKsP6yIyHzWxmydLgzkeQvsJqu6Cs5XtP03RZ2ekOM8qGresKdAsd+/yTTJVkWUiOZFcObHX5HB8Rw3KGnr2x0tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJULEdPA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJULEdPA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf243973c2so8297605ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093371; x=1780698171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JiUeYThTwHb2vUrssGyx+Ryc7M1Q55eYse5ayLPWdBA=;
        b=WJULEdPA/rC83ClaQ5A17GqrFzMWe98NmkexurxeaAUzWgqUjMAdbEJ0hVRsZQV+Nv
         U1E79HoZdlm+xZ08OmSfCY3z00TyYb1CsJN4s+H5Ve8SjfmbaWzMpi19u/Kgej9AkFL2
         ZpYCJPpPtfcX0mvdV6sz0klsCDWtvI1Vjs/ClRXDHbmy8HKdm4T+aFg9hETtGX19I5Ph
         me3V/K3n+HgPi1Aq8ys1GviWEpI0Y9Swc8xR0d1+MK1LCPqYq0TBiIwuCzQZQ0pJlDcU
         n+d1E5K1ZDK4AA2cGBFsrbEextFZrps9PZTcR50Lq9c+xzLokIRjx05Xx9FaUguzwjSj
         c7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093371; x=1780698171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiUeYThTwHb2vUrssGyx+Ryc7M1Q55eYse5ayLPWdBA=;
        b=KPOaok/oM9+TNPW6y+MX1UijDRWQd2cMDyGHpH7pwdYXvNUVN5zJsvK9mxBQkkfL+k
         kCU44d+88BoVowyHWBQdpKPrQU8Iv6naZk3Us9VEo0ndxPPiMgYNljM5uEvo+9obwJjt
         H0aQZGS2Ni5BQhIxfI7ErYq2GLpQu7AB1P+2bBLJ4H1CD5kSwWed33C84gLC/P2svTjR
         JJMiUdKlU5y5KJ0ZB9XPMIl0xkD2oxRTFT+kG6ctJp3GDtuljK0TxbJtPFEGCGiDfx2Z
         1Eklt/sGgJvFii1zisACuYlhnD5wVkkvWGp61bl4iVg1lpxSK1VTE8YtmgSM1afEMKKl
         K3Sg==
X-Gm-Message-State: AOJu0YxXy6mTOIhzRoIzEDu0OKWoULZwhrpk6Li3siI/lhVS5QvYowrX
	zH1df6xWzVkmsacggU1Q7x/nVAgEt9LcONNabwJFVjxKw8XPBhMN6mUKMRzUDIzUgVmVxBoHMja
	Wykpp9Q==
X-Received: from pgbcs5.prod.google.com ([2002:a05:6a02:4185:b0:c82:3948:7e01])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:ce4e:b0:3a2:d79c:416c
 with SMTP id adf61e73a8af0-3b427f97563mr1248571637.32.1780093371151; Fri, 29
 May 2026 15:22:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:50 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-8-seanjc@google.com>
Subject: [PATCH v3 07/40] KVM: x86: Move inlined GPR, CR, and DR helpers from
 x86.h to regs.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move inlined General Purpose Register, Control Register, and Debug
Register helpers from x86.h to the aptly named regs.h, to help trim
down x86.h (and x86.c in the future).

Move *very* select EFER functionality as well, but leave behind the bulk of
EFER handling and all other MSR handling.  There is more than enough MSR
code to carve out msrs.{c,h} in the future.  Give is_long_bit_mode()
special treatment as it's more along the lines of a CR4 bit check, but just
happens to be accessed through an MSR interface.  And more importantly,
because giving regs.h access to is_long_bit_mode() greatly simplifies
dependency chains.

No functional change intended.

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/regs.h | 123 ++++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kvm/x86.h  | 117 -----------------------------------------
 2 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 4440f3992fce..62cc9deea226 100644
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
@@ -143,6 +174,13 @@ static inline unsigned long kvm_register_read_raw(struct kvm_vcpu *vcpu, int reg
 	return vcpu->arch.regs[reg];
 }
 
+static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu, int reg)
+{
+	unsigned long val = kvm_register_read_raw(vcpu, reg);
+
+	return is_64_bit_mode(vcpu) ? val : (u32)val;
+}
+
 static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
 					  unsigned long val)
 {
@@ -153,6 +191,14 @@ static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
 	kvm_register_mark_dirty(vcpu, reg);
 }
 
+static inline void kvm_register_write(struct kvm_vcpu *vcpu,
+				       int reg, unsigned long val)
+{
+	if (!is_64_bit_mode(vcpu))
+		val = (u32)val;
+	return kvm_register_write_raw(vcpu, reg, val);
+}
+
 static inline unsigned long kvm_rip_read(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_register_is_available(vcpu, VCPU_REG_RIP))
@@ -177,6 +223,12 @@ static inline void kvm_rsp_write(struct kvm_vcpu *vcpu, unsigned long val)
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
@@ -243,10 +295,75 @@ static inline ulong kvm_read_cr4(struct kvm_vcpu *vcpu)
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
index a6b2be462e6d..3845b10020c9 100644
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
@@ -421,21 +365,6 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	return false;
 }
 
-static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu, int reg)
-{
-	unsigned long val = kvm_register_read_raw(vcpu, reg);
-
-	return is_64_bit_mode(vcpu) ? val : (u32)val;
-}
-
-static inline void kvm_register_write(struct kvm_vcpu *vcpu,
-				       int reg, unsigned long val)
-{
-	if (!is_64_bit_mode(vcpu))
-		val = (u32)val;
-	return kvm_register_write_raw(vcpu, reg, val);
-}
-
 static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
 {
 	return !(kvm->arch.disabled_quirks & quirk);
@@ -627,17 +556,6 @@ static inline bool kvm_pat_valid(u64 data)
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
@@ -684,41 +602,6 @@ enum kvm_msr_access {
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
2.54.0.823.g6e5bcc1fc9-goog

