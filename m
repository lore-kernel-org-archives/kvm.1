Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD5A3D25BD
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795649; cv=none; b=ruLiyKrNVzPwObkHuiOjhWnj+IUCZZJT/r9Lb5FN3idDYytG7l39Y6b+Kj6L8ZWVo/dBiOoiH/8pJ3E4Y2osK5K3PRzkO4qAHeX0wVSwcJHnplYBzcfDiqOtdZXG3lpNA0xi+ZjWNdyM36lcq39WDl6TmYagx5o4A/tz3jJ6sBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795649; c=relaxed/simple;
	bh=/7WGcr+w6dGw7gtqTCNGgHkdnFAOxbkW6ggtoAdN6/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzM+tz6jm3eFEtW9j7OVrn7qm2XcrKINOn3fFuuT+RwDF5mG4qxI0kWNAU74NLLtMEvqMR8SFP3QZItxEDpT4i5f8XI8WlQ7cs/aWxSFWldYfGKOk7IGAMUfZI+FuWT+NchWIqwc4oBTKQzOvSOq0qzuOeYpAvkRHXFqZ6mqk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cXz6/xw5; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cXz6/xw5"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83eefe4867eso2100617b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795646; x=1779400446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tsZR7o5U5njspjjsGG2ZXE4g2wdS0yroCDi4c1UBTZ0=;
        b=cXz6/xw5JPBKATRrbN3lSPvx9zsdS//YdGckby1S7+P55UtaJv56UBes4pcV2xDdBG
         V5YIp8F2HTLdjuOJ64ktiJbs3Rrpi3OmMfzoDUNARwXHYEvocJi3GJ6lod7S1RqVNzns
         JpLKESYbYju1Rw7g9w1C+Jl4jzDhjjXBk/RLf6Q4Sm7d0CuhUOwVxCPd/CToEPjPcnqd
         oIa0iUCXk66l9BgiGB3VW7fCWk4ZjjGeJn4F8hRoyQ0/+W8DjSUla7evWisLvy2MyXi3
         ymeICmbGioeTmRnGkxlvdGX4LQi+CMQpGkCEDqb3wfEjguwvxIDdx0Xx/Zw20if1JwDt
         6tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795646; x=1779400446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsZR7o5U5njspjjsGG2ZXE4g2wdS0yroCDi4c1UBTZ0=;
        b=LaBdz/zRUffb5Kd+9SQS5U/T7Kka6w3OUm0pWDYdKDGFvhWuZT90Wo9stz9SFvLARt
         sgRQinJ3wOW0WnEaQvrWLOqE2o1/jWNUeS7RUpqXRBr4+OmcAIhlkM5xekU9n/V3C6Tb
         y+y7SWqLuKqDYuq9GbP5tzjeqZUwOIZI2I1ifw6FfWxJIuW1BiWbWzIuBtSPqZQIrRnZ
         CHcYI2YCeKNgHO2oNKtDQwgYdYqx0FmnrhqPnlHyuhvqBDbTI8tFS1nCW1tQ2hkPM0zT
         yw9NzKz+0rhr+Qq6cio2R9BHEHHpb+OEAkKyRB2pYHNjxhk1913BD2vK1CeG3rLrW1+y
         PtzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8onDJw/QucDGAVV1dKf6gaeI1yC8c2yK4BOOkFCLeO5Vf0AbztiT7wPOU98MTsHum2ziI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9pWP+FfEbuc4F8X9ZNJ6U6sJWtO5idbgYytOUSySMizKoirB
	jwLxuTfeTlthJg34TqXB85JYb6i7TIAT3HeIh6FejUUH690o++QBfuUJEIelSjMj6EZSjId8aoS
	7pJ5gKA==
X-Received: from pfblj2.prod.google.com ([2002:a05:6a00:71c2:b0:83e:c835:edc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4484:b0:829:8cfb:df45
 with SMTP id d2e1a72fcca58-83f33c99b07mr1271607b3a.15.1778795645919; Thu, 14
 May 2026 14:54:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:48 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-9-seanjc@google.com>
Subject: [PATCH v2 08/15] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
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

Make kvm_<reg>_{read,write}() mode-aware (where the value is truncated to
32 bits if the vCPU isn't in 64-bit mode), and convert all the intentional
"raw" accesses to kvm_<reg>_{read,write}_raw() versions.  To avoid
confusion and bikeshedding over whether or not explicit 32-bit accesses
should use the "raw" or mode-aware variants, add and use "e" versions, e.g.
for things like RDMSR, WRMSR, and CPUID, where the instruction uses only
only bits 31:0, regardless of mode.

No functional change intended (all use of "e" versions is for cases where
the value is already truncated due to bouncing through a u32).

Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c      |  12 ++--
 arch/x86/kvm/hyperv.c     |  21 +++----
 arch/x86/kvm/hyperv.h     |   4 +-
 arch/x86/kvm/regs.h       |  80 +++++++++++++++++--------
 arch/x86/kvm/svm/nested.c |   6 +-
 arch/x86/kvm/svm/svm.c    |  13 ++--
 arch/x86/kvm/vmx/nested.c |   8 +--
 arch/x86/kvm/vmx/sgx.c    |   4 +-
 arch/x86/kvm/vmx/tdx.c    |  18 +++---
 arch/x86/kvm/x86.c        | 121 +++++++++++++++++++-------------------
 arch/x86/kvm/x86.h        |   8 +--
 arch/x86/kvm/xen.c        |  32 +++++-----
 12 files changed, 173 insertions(+), 154 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..fe765f1c3b15 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2165,13 +2165,13 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 	    !kvm_require_cpl(vcpu, 0))
 		return 1;
 
-	eax = kvm_rax_read(vcpu);
-	ecx = kvm_rcx_read(vcpu);
+	eax = kvm_eax_read(vcpu);
+	ecx = kvm_ecx_read(vcpu);
 	kvm_cpuid(vcpu, &eax, &ebx, &ecx, &edx, false);
-	kvm_rax_write(vcpu, eax);
-	kvm_rbx_write(vcpu, ebx);
-	kvm_rcx_write(vcpu, ecx);
-	kvm_rdx_write(vcpu, edx);
+	kvm_eax_write(vcpu, eax);
+	kvm_ebx_write(vcpu, ebx);
+	kvm_ecx_write(vcpu, ecx);
+	kvm_edx_write(vcpu, edx);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_cpuid);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 015c6947b462..3551af9a9453 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2377,10 +2377,10 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (longmode)
-		kvm_rax_write(vcpu, result);
+		kvm_rax_write_raw(vcpu, result);
 	else {
-		kvm_rdx_write(vcpu, result >> 32);
-		kvm_rax_write(vcpu, result & 0xffffffff);
+		kvm_edx_write(vcpu, result >> 32);
+		kvm_eax_write(vcpu, result);
 	}
 }
 
@@ -2544,18 +2544,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
 #ifdef CONFIG_X86_64
 	if (is_64_bit_hypercall(vcpu)) {
-		hc.param = kvm_rcx_read(vcpu);
-		hc.ingpa = kvm_rdx_read(vcpu);
-		hc.outgpa = kvm_r8_read(vcpu);
+		hc.param = kvm_rcx_read_raw(vcpu);
+		hc.ingpa = kvm_rdx_read_raw(vcpu);
+		hc.outgpa = kvm_r8_read_raw(vcpu);
 	} else
 #endif
 	{
-		hc.param = ((u64)kvm_rdx_read(vcpu) << 32) |
-			    (kvm_rax_read(vcpu) & 0xffffffff);
-		hc.ingpa = ((u64)kvm_rbx_read(vcpu) << 32) |
-			    (kvm_rcx_read(vcpu) & 0xffffffff);
-		hc.outgpa = ((u64)kvm_rdi_read(vcpu) << 32) |
-			     (kvm_rsi_read(vcpu) & 0xffffffff);
+		hc.param = ((u64)kvm_edx_read(vcpu) << 32) | kvm_eax_read(vcpu);
+		hc.ingpa = ((u64)kvm_ebx_read(vcpu) << 32) | kvm_ecx_read(vcpu);
+		hc.outgpa = ((u64)kvm_edi_read(vcpu) << 32) | kvm_esi_read(vcpu);
 	}
 
 	hc.code = hc.param & 0xffff;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 6301f79fcbae..65e89ed65349 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -232,8 +232,8 @@ static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 	if (!hv_vcpu)
 		return false;
 
-	code = is_64_bit_hypercall(vcpu) ? kvm_rcx_read(vcpu) :
-					   kvm_rax_read(vcpu);
+	code = is_64_bit_hypercall(vcpu) ? kvm_rcx_read_raw(vcpu) :
+					   kvm_eax_read(vcpu);
 
 	return (code == HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE ||
 		code == HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST ||
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index ecc66b577e82..b28e71caed25 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -47,32 +47,61 @@ static inline bool is_64_bit_hypercall(struct kvm_vcpu *vcpu)
 	return vcpu->arch.guest_state_protected || is_64_bit_mode(vcpu);
 }
 
-#define BUILD_KVM_GPR_ACCESSORS(lname, uname)				      \
-static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)\
-{									      \
-	return vcpu->arch.regs[VCPU_REGS_##uname];			      \
-}									      \
-static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,	      \
-						unsigned long val)	      \
-{									      \
-	vcpu->arch.regs[VCPU_REGS_##uname] = val;			      \
+static __always_inline unsigned long kvm_reg_mode_mask(struct kvm_vcpu *vcpu)
+{
+#ifdef CONFIG_X86_64
+	return is_64_bit_mode(vcpu) ? GENMASK(63, 0) : GENMASK(31, 0);
+#else
+	return GENMASK(31, 0);
+#endif
+}
+
+#define __BUILD_KVM_GPR_ACCESSORS(lname, uname)						\
+static __always_inline unsigned long kvm_##lname##_read(struct kvm_vcpu *vcpu)		\
+{											\
+	return vcpu->arch.regs[VCPU_REGS_##uname] & kvm_reg_mode_mask(vcpu);		\
+}											\
+static __always_inline void kvm_##lname##_write(struct kvm_vcpu *vcpu,			\
+						unsigned long val)			\
+{											\
+	vcpu->arch.regs[VCPU_REGS_##uname] = val & kvm_reg_mode_mask(vcpu);		\
+}											\
+static __always_inline unsigned long kvm_##lname##_read_raw(struct kvm_vcpu *vcpu)	\
+{											\
+	return vcpu->arch.regs[VCPU_REGS_##uname];					\
+}											\
+static __always_inline void kvm_##lname##_write_raw(struct kvm_vcpu *vcpu,		\
+						    unsigned long val)			\
+{											\
+	vcpu->arch.regs[VCPU_REGS_##uname] = val;					\
 }
-BUILD_KVM_GPR_ACCESSORS(rax, RAX)
-BUILD_KVM_GPR_ACCESSORS(rbx, RBX)
-BUILD_KVM_GPR_ACCESSORS(rcx, RCX)
-BUILD_KVM_GPR_ACCESSORS(rdx, RDX)
-BUILD_KVM_GPR_ACCESSORS(rbp, RBP)
-BUILD_KVM_GPR_ACCESSORS(rsi, RSI)
-BUILD_KVM_GPR_ACCESSORS(rdi, RDI)
+#define BUILD_KVM_GPR_ACCESSORS(lname, uname)						\
+static __always_inline u32 kvm_e##lname##_read(struct kvm_vcpu *vcpu)			\
+{											\
+	return vcpu->arch.regs[VCPU_REGS_##uname];					\
+}											\
+static __always_inline void kvm_e##lname##_write(struct kvm_vcpu *vcpu, u32 val)	\
+{											\
+	vcpu->arch.regs[VCPU_REGS_##uname] = val;					\
+}											\
+__BUILD_KVM_GPR_ACCESSORS(r##lname, uname)
+
+BUILD_KVM_GPR_ACCESSORS(ax, RAX)
+BUILD_KVM_GPR_ACCESSORS(bx, RBX)
+BUILD_KVM_GPR_ACCESSORS(cx, RCX)
+BUILD_KVM_GPR_ACCESSORS(dx, RDX)
+BUILD_KVM_GPR_ACCESSORS(bp, RBP)
+BUILD_KVM_GPR_ACCESSORS(si, RSI)
+BUILD_KVM_GPR_ACCESSORS(di, RDI)
 #ifdef CONFIG_X86_64
-BUILD_KVM_GPR_ACCESSORS(r8,  R8)
-BUILD_KVM_GPR_ACCESSORS(r9,  R9)
-BUILD_KVM_GPR_ACCESSORS(r10, R10)
-BUILD_KVM_GPR_ACCESSORS(r11, R11)
-BUILD_KVM_GPR_ACCESSORS(r12, R12)
-BUILD_KVM_GPR_ACCESSORS(r13, R13)
-BUILD_KVM_GPR_ACCESSORS(r14, R14)
-BUILD_KVM_GPR_ACCESSORS(r15, R15)
+__BUILD_KVM_GPR_ACCESSORS(r8,  R8)
+__BUILD_KVM_GPR_ACCESSORS(r9,  R9)
+__BUILD_KVM_GPR_ACCESSORS(r10, R10)
+__BUILD_KVM_GPR_ACCESSORS(r11, R11)
+__BUILD_KVM_GPR_ACCESSORS(r12, R12)
+__BUILD_KVM_GPR_ACCESSORS(r13, R13)
+__BUILD_KVM_GPR_ACCESSORS(r14, R14)
+__BUILD_KVM_GPR_ACCESSORS(r15, R15)
 #endif
 
 /*
@@ -210,8 +239,7 @@ static inline void kvm_rsp_write(struct kvm_vcpu *vcpu, unsigned long val)
 
 static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
 {
-	return (kvm_rax_read(vcpu) & -1u)
-		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+	return kvm_eax_read(vcpu) | (u64)(kvm_edx_read(vcpu)) << 32;
 }
 
 static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 4ef9bc6a553f..7b2d804ef2b0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -778,7 +778,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	svm->vcpu.arch.cr2 = save->cr2;
 
-	kvm_rax_write(vcpu, save->rax);
+	kvm_rax_write_raw(vcpu, save->rax);
 	kvm_rsp_write(vcpu, save->rsp);
 	kvm_rip_write(vcpu, save->rip);
 
@@ -1244,7 +1244,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->save.rflags = kvm_get_rflags(vcpu);
 	vmcb12->save.rip    = kvm_rip_read(vcpu);
 	vmcb12->save.rsp    = kvm_rsp_read(vcpu);
-	vmcb12->save.rax    = kvm_rax_read(vcpu);
+	vmcb12->save.rax    = kvm_rax_read_raw(vcpu);
 	vmcb12->save.dr7    = vmcb02->save.dr7;
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
@@ -1394,7 +1394,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm_set_efer(vcpu, vmcb01->save.efer);
 	svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CR0_PE);
 	svm_set_cr4(vcpu, vmcb01->save.cr4);
-	kvm_rax_write(vcpu, vmcb01->save.rax);
+	kvm_rax_write_raw(vcpu, vmcb01->save.rax);
 	kvm_rsp_write(vcpu, vmcb01->save.rsp);
 	kvm_rip_write(vcpu, vmcb01->save.rip);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index be775d285ce7..02fb9560c26e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2408,15 +2408,12 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
 static int invlpga_interception(struct kvm_vcpu *vcpu)
 {
-	gva_t gva = kvm_rax_read(vcpu);
-	u32 asid = kvm_rcx_read(vcpu);
-
-	if (nested_svm_check_permissions(vcpu))
-		return 1;
-
 	/* FIXME: Handle an address size prefix. */
-	if (!is_64_bit_mode(vcpu))
-		gva = (u32)gva;
+	gva_t gva = kvm_rax_read(vcpu);
+	u32 asid = kvm_ecx_read(vcpu);
+
+	if (nested_svm_check_permissions(vcpu))
+		return 1;
 
 	trace_kvm_invlpga(to_svm(vcpu)->vmcb->save.rip, asid, gva);
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4690a4d23709..20d75bf0a455 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6148,7 +6148,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
 {
-	u32 index = kvm_rcx_read(vcpu);
+	u32 index = kvm_ecx_read(vcpu);
 	u64 new_eptp;
 
 	if (WARN_ON_ONCE(!nested_cpu_has_ept(vmcs12)))
@@ -6182,7 +6182,7 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	u32 function = kvm_rax_read(vcpu);
+	u32 function = kvm_eax_read(vcpu);
 
 	/*
 	 * VMFUNC should never execute cleanly while L1 is active; KVM supports
@@ -6304,7 +6304,7 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
 		msr_index = vmx_get_exit_qual(vcpu);
 	else
-		msr_index = kvm_rcx_read(vcpu);
+		msr_index = kvm_ecx_read(vcpu);
 
 	/*
 	 * The MSR_BITMAP page is divided into four 1024-byte bitmaps,
@@ -6414,7 +6414,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENCLS_EXITING))
 		return false;
 
-	encls_leaf = kvm_rax_read(vcpu);
+	encls_leaf = kvm_eax_read(vcpu);
 	if (encls_leaf > 62)
 		encls_leaf = 63;
 	return vmcs12->encls_exiting_bitmap & BIT_ULL(encls_leaf);
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 66c315554b46..2f5a1c58f3c5 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -352,7 +352,7 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
 		rflags &= ~X86_EFLAGS_ZF;
 	vmx_set_rflags(vcpu, rflags);
 
-	kvm_rax_write(vcpu, ret);
+	kvm_eax_write(vcpu, ret);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
@@ -380,7 +380,7 @@ static inline bool sgx_enabled_in_guest_bios(struct kvm_vcpu *vcpu)
 
 int handle_encls(struct kvm_vcpu *vcpu)
 {
-	u32 leaf = (u32)kvm_rax_read(vcpu);
+	u32 leaf = kvm_eax_read(vcpu);
 
 	if (!enable_sgx || !guest_cpu_cap_has(vcpu, X86_FEATURE_SGX) ||
 	    !guest_cpu_cap_has(vcpu, X86_FEATURE_SGX1)) {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f97bcf580e6d..ec88b58e2b27 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1163,11 +1163,11 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 
 static int tdx_emulate_vmcall(struct kvm_vcpu *vcpu)
 {
-	kvm_rax_write(vcpu, to_tdx(vcpu)->vp_enter_args.r10);
-	kvm_rbx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r11);
-	kvm_rcx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r12);
-	kvm_rdx_write(vcpu, to_tdx(vcpu)->vp_enter_args.r13);
-	kvm_rsi_write(vcpu, to_tdx(vcpu)->vp_enter_args.r14);
+	kvm_rax_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r10);
+	kvm_rbx_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r11);
+	kvm_rcx_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r12);
+	kvm_rdx_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r13);
+	kvm_rsi_write_raw(vcpu, to_tdx(vcpu)->vp_enter_args.r14);
 
 	return __kvm_emulate_hypercall(vcpu, 0, complete_hypercall_exit);
 }
@@ -2028,12 +2028,12 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 	case EXIT_REASON_IO_INSTRUCTION:
 		return tdx_emulate_io(vcpu);
 	case EXIT_REASON_MSR_READ:
-		kvm_rcx_write(vcpu, tdx->vp_enter_args.r12);
+		kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
 		return kvm_emulate_rdmsr(vcpu);
 	case EXIT_REASON_MSR_WRITE:
-		kvm_rcx_write(vcpu, tdx->vp_enter_args.r12);
-		kvm_rax_write(vcpu, tdx->vp_enter_args.r13 & -1u);
-		kvm_rdx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
+		kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
+		kvm_eax_write(vcpu, tdx->vp_enter_args.r13);
+		kvm_edx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
 		return kvm_emulate_wrmsr(vcpu);
 	case EXIT_REASON_EPT_MISCONFIG:
 		return tdx_emulate_mmio(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ab13aed2cbd0..b958521bc81f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1319,7 +1319,7 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 {
 	/* Note, #UD due to CR4.OSXSAVE=0 has priority over the intercept. */
 	if (kvm_x86_call(get_cpl)(vcpu) != 0 ||
-	    __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), kvm_read_edx_eax(vcpu))) {
+	    __kvm_set_xcr(vcpu, kvm_ecx_read(vcpu), kvm_read_edx_eax(vcpu))) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -1608,7 +1608,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dr);
 
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
-	u32 pmc = kvm_rcx_read(vcpu);
+	u32 pmc = kvm_ecx_read(vcpu);
 	u64 data;
 
 	if (kvm_pmu_rdpmc(vcpu, pmc, &data)) {
@@ -1616,8 +1616,8 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	kvm_rax_write(vcpu, (u32)data);
-	kvm_rdx_write(vcpu, data >> 32);
+	kvm_eax_write(vcpu, data);
+	kvm_edx_write(vcpu, data >> 32);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdpmc);
@@ -2064,8 +2064,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
 static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu->run->msr.error) {
-		kvm_rax_write(vcpu, (u32)vcpu->run->msr.data);
-		kvm_rdx_write(vcpu, vcpu->run->msr.data >> 32);
+		kvm_eax_write(vcpu, vcpu->run->msr.data);
+		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
 	}
 }
 
@@ -2146,8 +2146,8 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 		trace_kvm_msr_read(msr, data);
 
 		if (reg < 0) {
-			kvm_rax_write(vcpu, data & -1u);
-			kvm_rdx_write(vcpu, (data >> 32) & -1u);
+			kvm_eax_write(vcpu, data);
+			kvm_edx_write(vcpu, data >> 32);
 		} else {
 			kvm_register_write(vcpu, reg, data);
 		}
@@ -2164,7 +2164,7 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
+	return __kvm_emulate_rdmsr(vcpu, kvm_ecx_read(vcpu), -1,
 				   complete_fast_rdmsr);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr);
@@ -2200,7 +2200,7 @@ static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __kvm_emulate_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				   kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr);
@@ -2310,7 +2310,7 @@ static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 da
 
 fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __handle_fastpath_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __handle_fastpath_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				       kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr);
@@ -9691,7 +9691,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port)
 {
-	unsigned long val = kvm_rax_read(vcpu);
+	unsigned long val = kvm_rax_read_raw(vcpu);
 	int ret = emulator_pio_out(vcpu, size, port, &val, 1);
 
 	if (ret)
@@ -9727,10 +9727,10 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 	}
 
 	/* For size less than 4 we merge, else we zero extend */
-	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read(vcpu) : 0;
+	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read_raw(vcpu) : 0;
 
 	complete_emulator_pio_in(vcpu, &val);
-	kvm_rax_write(vcpu, val);
+	kvm_rax_write_raw(vcpu, val);
 
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -9742,11 +9742,11 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
 	int ret;
 
 	/* For size less than 4 we merge, else we zero extend */
-	val = (size < 4) ? kvm_rax_read(vcpu) : 0;
+	val = (size < 4) ? kvm_rax_read_raw(vcpu) : 0;
 
 	ret = emulator_pio_in(vcpu, size, port, &val, 1);
 	if (ret) {
-		kvm_rax_write(vcpu, val);
+		kvm_rax_write_raw(vcpu, val);
 		return ret;
 	}
 
@@ -10413,29 +10413,30 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 
 	if (!is_64_bit_hypercall(vcpu))
 		ret = (u32)ret;
-	kvm_rax_write(vcpu, ret);
+	kvm_rax_write_raw(vcpu, ret);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
 int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, int cpl,
 			      int (*complete_hypercall)(struct kvm_vcpu *))
 {
-	unsigned long ret;
-	unsigned long nr = kvm_rax_read(vcpu);
-	unsigned long a0 = kvm_rbx_read(vcpu);
-	unsigned long a1 = kvm_rcx_read(vcpu);
-	unsigned long a2 = kvm_rdx_read(vcpu);
-	unsigned long a3 = kvm_rsi_read(vcpu);
 	int op_64_bit = is_64_bit_hypercall(vcpu);
+	unsigned long ret, nr, a0, a1, a2, a3;
 
 	++vcpu->stat.hypercalls;
 
-	if (!op_64_bit) {
-		nr &= 0xFFFFFFFF;
-		a0 &= 0xFFFFFFFF;
-		a1 &= 0xFFFFFFFF;
-		a2 &= 0xFFFFFFFF;
-		a3 &= 0xFFFFFFFF;
+	if (op_64_bit) {
+		nr = kvm_rax_read_raw(vcpu);
+		a0 = kvm_rbx_read_raw(vcpu);
+		a1 = kvm_rcx_read_raw(vcpu);
+		a2 = kvm_rdx_read_raw(vcpu);
+		a3 = kvm_rsi_read_raw(vcpu);
+	} else {
+		nr = kvm_eax_read(vcpu);
+		a0 = kvm_ebx_read(vcpu);
+		a1 = kvm_ecx_read(vcpu);
+		a2 = kvm_edx_read(vcpu);
+		a3 = kvm_esi_read(vcpu);
 	}
 
 	trace_kvm_hypercall(nr, a0, a1, a2, a3);
@@ -12133,23 +12134,23 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 		emulator_writeback_register_cache(vcpu->arch.emulate_ctxt);
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 	}
-	regs->rax = kvm_rax_read(vcpu);
-	regs->rbx = kvm_rbx_read(vcpu);
-	regs->rcx = kvm_rcx_read(vcpu);
-	regs->rdx = kvm_rdx_read(vcpu);
-	regs->rsi = kvm_rsi_read(vcpu);
-	regs->rdi = kvm_rdi_read(vcpu);
+	regs->rax = kvm_rax_read_raw(vcpu);
+	regs->rbx = kvm_rbx_read_raw(vcpu);
+	regs->rcx = kvm_rcx_read_raw(vcpu);
+	regs->rdx = kvm_rdx_read_raw(vcpu);
+	regs->rsi = kvm_rsi_read_raw(vcpu);
+	regs->rdi = kvm_rdi_read_raw(vcpu);
 	regs->rsp = kvm_rsp_read(vcpu);
-	regs->rbp = kvm_rbp_read(vcpu);
+	regs->rbp = kvm_rbp_read_raw(vcpu);
 #ifdef CONFIG_X86_64
-	regs->r8 = kvm_r8_read(vcpu);
-	regs->r9 = kvm_r9_read(vcpu);
-	regs->r10 = kvm_r10_read(vcpu);
-	regs->r11 = kvm_r11_read(vcpu);
-	regs->r12 = kvm_r12_read(vcpu);
-	regs->r13 = kvm_r13_read(vcpu);
-	regs->r14 = kvm_r14_read(vcpu);
-	regs->r15 = kvm_r15_read(vcpu);
+	regs->r8 = kvm_r8_read_raw(vcpu);
+	regs->r9 = kvm_r9_read_raw(vcpu);
+	regs->r10 = kvm_r10_read_raw(vcpu);
+	regs->r11 = kvm_r11_read_raw(vcpu);
+	regs->r12 = kvm_r12_read_raw(vcpu);
+	regs->r13 = kvm_r13_read_raw(vcpu);
+	regs->r14 = kvm_r14_read_raw(vcpu);
+	regs->r15 = kvm_r15_read_raw(vcpu);
 #endif
 
 	regs->rip = kvm_rip_read(vcpu);
@@ -12173,23 +12174,23 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
-	kvm_rax_write(vcpu, regs->rax);
-	kvm_rbx_write(vcpu, regs->rbx);
-	kvm_rcx_write(vcpu, regs->rcx);
-	kvm_rdx_write(vcpu, regs->rdx);
-	kvm_rsi_write(vcpu, regs->rsi);
-	kvm_rdi_write(vcpu, regs->rdi);
+	kvm_rax_write_raw(vcpu, regs->rax);
+	kvm_rbx_write_raw(vcpu, regs->rbx);
+	kvm_rcx_write_raw(vcpu, regs->rcx);
+	kvm_rdx_write_raw(vcpu, regs->rdx);
+	kvm_rsi_write_raw(vcpu, regs->rsi);
+	kvm_rdi_write_raw(vcpu, regs->rdi);
 	kvm_rsp_write(vcpu, regs->rsp);
-	kvm_rbp_write(vcpu, regs->rbp);
+	kvm_rbp_write_raw(vcpu, regs->rbp);
 #ifdef CONFIG_X86_64
-	kvm_r8_write(vcpu, regs->r8);
-	kvm_r9_write(vcpu, regs->r9);
-	kvm_r10_write(vcpu, regs->r10);
-	kvm_r11_write(vcpu, regs->r11);
-	kvm_r12_write(vcpu, regs->r12);
-	kvm_r13_write(vcpu, regs->r13);
-	kvm_r14_write(vcpu, regs->r14);
-	kvm_r15_write(vcpu, regs->r15);
+	kvm_r8_write_raw(vcpu, regs->r8);
+	kvm_r9_write_raw(vcpu, regs->r9);
+	kvm_r10_write_raw(vcpu, regs->r10);
+	kvm_r11_write_raw(vcpu, regs->r11);
+	kvm_r12_write_raw(vcpu, regs->r12);
+	kvm_r13_write_raw(vcpu, regs->r13);
+	kvm_r14_write_raw(vcpu, regs->r14);
+	kvm_r15_write_raw(vcpu, regs->r15);
 #endif
 
 	kvm_rip_write(vcpu, regs->rip);
@@ -13092,7 +13093,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	 * on RESET.  But, go through the motions in case that's ever remedied.
 	 */
 	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
-	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
+	kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
 
 	kvm_x86_call(vcpu_reset)(vcpu, init_event);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 16d1c3c1a2d9..bd4423e82b02 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -367,17 +367,13 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 
 static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu, int reg)
 {
-	unsigned long val = kvm_register_read_raw(vcpu, reg);
-
-	return is_64_bit_mode(vcpu) ? val : (u32)val;
+	return kvm_register_read_raw(vcpu, reg) & kvm_reg_mode_mask(vcpu);
 }
 
 static inline void kvm_register_write(struct kvm_vcpu *vcpu,
 				       int reg, unsigned long val)
 {
-	if (!is_64_bit_mode(vcpu))
-		val = (u32)val;
-	return kvm_register_write_raw(vcpu, reg, val);
+	return kvm_register_write_raw(vcpu, reg, val & kvm_reg_mode_mask(vcpu));
 }
 
 static inline bool kvm_check_has_quirk(struct kvm *kvm, u64 quirk)
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 895095dc684e..694b31c1fcc9 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1408,7 +1408,7 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 
 static int kvm_xen_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 {
-	kvm_rax_write(vcpu, result);
+	kvm_rax_write_raw(vcpu, result);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
@@ -1679,29 +1679,29 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	u8 cpl;
 
 	/* Hyper-V hypercalls get bit 31 set in EAX */
-	if ((kvm_rax_read(vcpu) & 0x80000000) &&
+	if ((kvm_rax_read_raw(vcpu) & 0x80000000) &&
 	    kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (!longmode) {
-		input = (u32)kvm_rax_read(vcpu);
-		params[0] = (u32)kvm_rbx_read(vcpu);
-		params[1] = (u32)kvm_rcx_read(vcpu);
-		params[2] = (u32)kvm_rdx_read(vcpu);
-		params[3] = (u32)kvm_rsi_read(vcpu);
-		params[4] = (u32)kvm_rdi_read(vcpu);
-		params[5] = (u32)kvm_rbp_read(vcpu);
+		input = kvm_eax_read(vcpu);
+		params[0] = kvm_ebx_read(vcpu);
+		params[1] = kvm_ecx_read(vcpu);
+		params[2] = kvm_edx_read(vcpu);
+		params[3] = kvm_esi_read(vcpu);
+		params[4] = kvm_edi_read(vcpu);
+		params[5] = kvm_ebp_read(vcpu);
 	}
 	else {
 #ifdef CONFIG_X86_64
-		input = (u64)kvm_rax_read(vcpu);
-		params[0] = (u64)kvm_rdi_read(vcpu);
-		params[1] = (u64)kvm_rsi_read(vcpu);
-		params[2] = (u64)kvm_rdx_read(vcpu);
-		params[3] = (u64)kvm_r10_read(vcpu);
-		params[4] = (u64)kvm_r8_read(vcpu);
-		params[5] = (u64)kvm_r9_read(vcpu);
+		input = (u64)kvm_rax_read_raw(vcpu);
+		params[0] = (u64)kvm_rdi_read_raw(vcpu);
+		params[1] = (u64)kvm_rsi_read_raw(vcpu);
+		params[2] = (u64)kvm_rdx_read_raw(vcpu);
+		params[3] = (u64)kvm_r10_read_raw(vcpu);
+		params[4] = (u64)kvm_r8_read_raw(vcpu);
+		params[5] = (u64)kvm_r9_read_raw(vcpu);
 #else
 		KVM_BUG_ON(1, vcpu->kvm);
 		return -EIO;
-- 
2.54.0.563.g4f69b47b94-goog

