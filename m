Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0D38A299
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093379; cv=none; b=HkH1Vu420Z3GEb7vTcN7U2Fx33NQnikBuFo3scA/FFsvUPplTCmOKbG61rpArtgFv7UWgqwiWijuIrk35mTHtyH9K79ZpwjVUaO+rDzRq2S0+DuBYbZSBZy9HWhOkm4T//2ogCCs+WzG8qKGiqdIKNsHeCz4KVuvKOp02iJu1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093379; c=relaxed/simple;
	bh=xjAIQteLMqHfY21rM/s6bwjc4Au8udfDNArzvMlig2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HG3zf7E6UuTWXoQwGdb1NGhDmzYkNtVOzI7QCt99MzgSCfrm51Ji5KuisbSJ6goDRC6Icsd4GesBmTEGrSVE9X/f5glGgdOD3DdRSMaLXf90/cR/b4scTwxAJzCta+jz+yXvLEIEcfbP6rHdm/C+/QgMo08jO6I1EoxU+CWbk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jt0uklbc; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jt0uklbc"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b99eb06178so72285645ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780093372; x=1780698172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zSnMZ07GxQ9ezxjo5/6a7rsfOhY3fI+SftZS6P79xyU=;
        b=Jt0uklbcEveatJ2XP5ibFIs9zucBdoXZniGSCqHC88sz/qC5u4MnkmvtyfibidTaeL
         AI1uy5AeK9nczEdA6J12WZZu8KR0NABceZkOB0Y7hzQPgRx2USb3xkMERkc3XU8mSsOa
         2ti1qzHOCFVUmmVddTaIEQMhZ2SrXIShm1pPsDWXlV8SFGICUKiDS8KFSs5tfNIjJWv5
         j94DK4YF2fBzMWeQHyudtAP2Lx98j1SxsA2Hwpoh66dGxHWczuFNaz8bbX5HEodHgPJI
         YcoIndmOB3udWthkdjD07d/c+3yFDiNi/402UFD/8/9H5MTCuy1rp1rmBTHckoJnRrW4
         m37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780093372; x=1780698172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSnMZ07GxQ9ezxjo5/6a7rsfOhY3fI+SftZS6P79xyU=;
        b=IwPiHxCH1wvPcWdurTYOIbzFDNDJ6qso6mU9+tyF/iAEjLCW+toOoPFZVbTknHhuHW
         +H0PsduBHnf9xhjD/cHU79Qca6AUaN6ZAZLM2O6G0HJAWL/lqRG+vrcbsgON2F/FV3gc
         Em727YALi0hy2sLypbbhIg2ib41gH1rNfHlDrkLzrgImObBubTWcUIjiC1GO5kAK41OX
         63ktJN40rAd/DKY1MbzJHaDKedbq5u0ka4JshcgxywyJD4p2dOIni7NVA2AsFHrZWlGh
         8cQt9//7tP9v+0LAJt7DZq6Xr2+xnE2Bj+lAKdZPYJFDE3V6RL2oXKnz9czxmLAqb1/i
         I1ZQ==
X-Gm-Message-State: AOJu0YxR/ydTZ0WCKpJdCU7v84QHnakW2ylJq+XiZYuuKei2H3m4ww4e
	XM1T7yqETuMeFh/QMBR2MjHx1dy6XY+6cEK/SWPOAwaaD+2jCv5mS0rK93XF5OMOse1L79ba5xv
	cj+12qQ==
X-Received: from pldy13.prod.google.com ([2002:a17:902:cacd:b0:2b2:a70b:98ea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebcd:b0:2be:1b3e:3a1f
 with SMTP id d9443c01a7336-2bf36779d38mr21033785ad.2.1780093372306; Fri, 29
 May 2026 15:22:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 15:21:51 -0700
In-Reply-To: <20260529222223.870923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529222223.870923-9-seanjc@google.com>
Subject: [PATCH v3 08/40] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Make kvm_<reg>_{read,write}() mode-aware (where the value is truncated to
32 bits if the vCPU isn't in 64-bit mode), and convert all the intentional
"raw" accesses to kvm_<reg>_{read,write}_raw() versions.  To avoid
confusion and bikeshedding over whether or not explicit 32-bit accesses
should use the "raw" or mode-aware variants, add and use "e" versions, e.g.
for things like RDMSR, WRMSR, and CPUID, where the instruction uses only
bits 31:0, regardless of mode.

No functional change intended (all use of "e" versions is for cases where
the value is already truncated due to bouncing through a u32).

Cc: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Kai Huang <kai.huang@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c      |  12 ++--
 arch/x86/kvm/hyperv.c     |  21 +++----
 arch/x86/kvm/hyperv.h     |   4 +-
 arch/x86/kvm/regs.h       |  88 +++++++++++++++++----------
 arch/x86/kvm/svm/nested.c |   6 +-
 arch/x86/kvm/svm/svm.c    |  13 ++--
 arch/x86/kvm/vmx/nested.c |   8 +--
 arch/x86/kvm/vmx/sgx.c    |   4 +-
 arch/x86/kvm/vmx/tdx.c    |  18 +++---
 arch/x86/kvm/x86.c        | 121 +++++++++++++++++++-------------------
 arch/x86/kvm/xen.c        |  32 +++++-----
 11 files changed, 173 insertions(+), 154 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8e5340dd2621..fd3b02575cd0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -2166,13 +2166,13 @@ int kvm_emulate_cpuid(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
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
index 62cc9deea226..12db5039aace 100644
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
@@ -176,9 +205,7 @@ static inline unsigned long kvm_register_read_raw(struct kvm_vcpu *vcpu, int reg
 
 static inline unsigned long kvm_register_read(struct kvm_vcpu *vcpu, int reg)
 {
-	unsigned long val = kvm_register_read_raw(vcpu, reg);
-
-	return is_64_bit_mode(vcpu) ? val : (u32)val;
+	return kvm_register_read_raw(vcpu, reg) & kvm_reg_mode_mask(vcpu);
 }
 
 static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
@@ -194,9 +221,7 @@ static inline void kvm_register_write_raw(struct kvm_vcpu *vcpu, int reg,
 static inline void kvm_register_write(struct kvm_vcpu *vcpu,
 				       int reg, unsigned long val)
 {
-	if (!is_64_bit_mode(vcpu))
-		val = (u32)val;
-	return kvm_register_write_raw(vcpu, reg, val);
+	return kvm_register_write_raw(vcpu, reg, val & kvm_reg_mode_mask(vcpu));
 }
 
 static inline unsigned long kvm_rip_read(struct kvm_vcpu *vcpu)
@@ -225,8 +250,7 @@ static inline void kvm_rsp_write(struct kvm_vcpu *vcpu, unsigned long val)
 
 static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
 {
-	return (kvm_rax_read(vcpu) & -1u)
-		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+	return kvm_eax_read(vcpu) | (u64)(kvm_edx_read(vcpu)) << 32;
 }
 
 static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7ad4b4fb7a1c..d817dbb350d6 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -793,7 +793,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	svm->vcpu.arch.cr2 = save->cr2;
 
-	kvm_rax_write(vcpu, save->rax);
+	kvm_rax_write_raw(vcpu, save->rax);
 	kvm_rsp_write(vcpu, save->rsp);
 	kvm_rip_write(vcpu, save->rip);
 
@@ -1272,7 +1272,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->save.rflags = kvm_get_rflags(vcpu);
 	vmcb12->save.rip    = kvm_rip_read(vcpu);
 	vmcb12->save.rsp    = kvm_rsp_read(vcpu);
-	vmcb12->save.rax    = kvm_rax_read(vcpu);
+	vmcb12->save.rax    = kvm_rax_read_raw(vcpu);
 	vmcb12->save.dr7    = vmcb02->save.dr7;
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
@@ -1424,7 +1424,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm_set_efer(vcpu, vmcb01->save.efer);
 	svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CR0_PE);
 	svm_set_cr4(vcpu, vmcb01->save.cr4);
-	kvm_rax_write(vcpu, vmcb01->save.rax);
+	kvm_rax_write_raw(vcpu, vmcb01->save.rax);
 	kvm_rsp_write(vcpu, vmcb01->save.rsp);
 	kvm_rip_write(vcpu, vmcb01->save.rip);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d4bfda10f1df..8402e94ac094 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2409,15 +2409,12 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
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
index 30dcabc899a2..b2c851cc7d5c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6165,7 +6165,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
 {
-	u32 index = kvm_rcx_read(vcpu);
+	u32 index = kvm_ecx_read(vcpu);
 	u64 new_eptp;
 
 	if (WARN_ON_ONCE(!nested_cpu_has_ept(vmcs12)))
@@ -6199,7 +6199,7 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	u32 function = kvm_rax_read(vcpu);
+	u32 function = kvm_eax_read(vcpu);
 
 	/*
 	 * VMFUNC should never execute cleanly while L1 is active; KVM supports
@@ -6321,7 +6321,7 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
 		msr_index = vmx_get_exit_qual(vcpu);
 	else
-		msr_index = kvm_rcx_read(vcpu);
+		msr_index = kvm_ecx_read(vcpu);
 
 	/*
 	 * The MSR_BITMAP page is divided into four 1024-byte bitmaps,
@@ -6431,7 +6431,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
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
index 77e3d1bb24cb..ffe9d0db58c5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1169,11 +1169,11 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 
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
@@ -2107,12 +2107,12 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
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
index 4fe2fb3ceba6..a102269a7af9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1300,7 +1300,7 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 {
 	/* Note, #UD due to CR4.OSXSAVE=0 has priority over the intercept. */
 	if (kvm_x86_call(get_cpl)(vcpu) != 0 ||
-	    __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), kvm_read_edx_eax(vcpu))) {
+	    __kvm_set_xcr(vcpu, kvm_ecx_read(vcpu), kvm_read_edx_eax(vcpu))) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -1597,7 +1597,7 @@ static unsigned long kvm_get_effective_dr7(struct kvm_vcpu *vcpu)
 
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
-	u32 pmc = kvm_rcx_read(vcpu);
+	u32 pmc = kvm_ecx_read(vcpu);
 	u64 data;
 
 	if (kvm_pmu_rdpmc(vcpu, pmc, &data)) {
@@ -1605,8 +1605,8 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	kvm_rax_write(vcpu, (u32)data);
-	kvm_rdx_write(vcpu, data >> 32);
+	kvm_eax_write(vcpu, data);
+	kvm_edx_write(vcpu, data >> 32);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdpmc);
@@ -2053,8 +2053,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
 static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu->run->msr.error) {
-		kvm_rax_write(vcpu, (u32)vcpu->run->msr.data);
-		kvm_rdx_write(vcpu, vcpu->run->msr.data >> 32);
+		kvm_eax_write(vcpu, vcpu->run->msr.data);
+		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
 	}
 }
 
@@ -2135,8 +2135,8 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 		trace_kvm_msr_read(msr, data);
 
 		if (reg < 0) {
-			kvm_rax_write(vcpu, data & -1u);
-			kvm_rdx_write(vcpu, (data >> 32) & -1u);
+			kvm_eax_write(vcpu, data);
+			kvm_edx_write(vcpu, data >> 32);
 		} else {
 			kvm_register_write(vcpu, reg, data);
 		}
@@ -2153,7 +2153,7 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
+	return __kvm_emulate_rdmsr(vcpu, kvm_ecx_read(vcpu), -1,
 				   complete_fast_rdmsr);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr);
@@ -2189,7 +2189,7 @@ static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __kvm_emulate_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				   kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr);
@@ -2299,7 +2299,7 @@ static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 da
 
 fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __handle_fastpath_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __handle_fastpath_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				       kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr);
@@ -9690,7 +9690,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port)
 {
-	unsigned long val = kvm_rax_read(vcpu);
+	unsigned long val = kvm_rax_read_raw(vcpu);
 	int ret = emulator_pio_out(vcpu, size, port, &val, 1);
 
 	if (ret)
@@ -9726,10 +9726,10 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 	}
 
 	/* For size less than 4 we merge, else we zero extend */
-	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read(vcpu) : 0;
+	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read_raw(vcpu) : 0;
 
 	complete_emulator_pio_in(vcpu, &val);
-	kvm_rax_write(vcpu, val);
+	kvm_rax_write_raw(vcpu, val);
 
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -9741,11 +9741,11 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
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
 
@@ -10412,29 +10412,30 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 
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
@@ -12132,23 +12133,23 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
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
@@ -12172,23 +12173,23 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
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
@@ -13091,7 +13092,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	 * on RESET.  But, go through the motions in case that's ever remedied.
 	 */
 	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
-	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
+	kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
 
 	kvm_x86_call(vcpu_reset)(vcpu, init_event);
 
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
2.54.0.823.g6e5bcc1fc9-goog

