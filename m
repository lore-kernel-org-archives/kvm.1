Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142A3A7F4A
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779003; cv=none; b=YnMt0LA7Le6bOw3Bjv+9Au+tFNuGi1pWVM4lird/k/31cQVN1UkzudL95k/cDdRWT22P72uUJG2l1hWZXQ3LvNqXncC61ETrJQvKm1f4r4tyjW68VLzv5NJNavM85Ut0ssR+8LekgEBofG/xsB9P4gxhZkJPq0u5kSclJyISqv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779003; c=relaxed/simple;
	bh=sMfqhRATYAH8c56MQfwyBUdQ6WoWb5C1W9/MzxOqavw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S9B2yrTi713GRWvI75iswtBlZll5p3VocFKbhx9sTFxAOOffOmJEx5ym8idh7ePCY4cHvOcoR1uXzSewM83KvNz0lfhB7Di3OlEBWVEWfK+3Gk23/M8vi8l34jjq7YAdoNyOdMhKxY8C3YtTQIjMqL9gIveUyr7Er5kgRZb/TFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xm7iCqsK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xm7iCqsK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7423ba5342so1999338a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Apr 2026 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775779001; x=1776383801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ2ir7cB0iDTrk12lQCbzg/x/kA+2peyLgF9XpnbgiY=;
        b=Xm7iCqsKdwjd+PHo7NC3IYAysablRoWRBjYwTmKL/dDsVKiUZBPC5OgragbGMMcItO
         9PHtrXudRsH4V8+uefsDltQZIIAiKIWVp5OtePx6PlBMUN44IozOyTp+dzyZRuU+XGcx
         tqB7EcYfm5uczGtb0OcdDb4saeGnDj0BQlji5bIerM/J8keFzobOdbvnAyVq8YliughV
         f1NSfcFoG6xzrHtUeAdT6nwIinGKN6Vd9xdasFyUQAtujkjTOMZX4uVneqxQlS3bDiBV
         Gri/24vcU+NQbCPf1FSFPZJgbDNSDXJWDiL4KaQld+dry+Sc8i+RqADCIaRVYpF0rcWz
         EXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775779001; x=1776383801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ2ir7cB0iDTrk12lQCbzg/x/kA+2peyLgF9XpnbgiY=;
        b=nTedFFvxEL0vFnegP8fZ3KHEd/gdX1E4RI+dutxL+z1mClMuy3KcTPYWEU/DEfEYzi
         jjd5aLISwP0Uz7wj58BIU7wcprWI3fXEj5afa4Q0f5eVoT7RRdcWYlkZ212Tdvb9pKRc
         65CVkhUQQFSktFF3Y1OD8XNMGmtPUIr1X1+z4Ak6fi3iki8RIAyidN+pe2VnD3B98lzg
         iZWi63RlqQJc3qp6OlGwlA/ooJA33dMEpGKhH6BXLHfRa3hZd0bGwgYUHiYJ2eRlA5O3
         dNZkC1LeJK7VUTIQFlS2nDuVs6a+tzGwLv6d3Pjo87aKyALMiqL/rFHvKIGSYDkGh/Eb
         f5xg==
X-Gm-Message-State: AOJu0YxHe/tJEyvBKPwRgceElvFNYVc0CFmMI1U0q2Qw4IOR9Zyohbvz
	Xrpukvbo1XbC2v9QTVGJdN5DlC0Xu0ZqUBlYjIi8AUAAXlh4D4ubm+8bDBVyH+3n7ZDc/+0rxyR
	lZm4NEA==
X-Received: from pfbic2.prod.google.com ([2002:a05:6a00:8a02:b0:82c:efb6:4087])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:bd02:b0:82c:2647:eeea
 with SMTP id d2e1a72fcca58-82f0c33fd65mr1145614b3a.38.1775779001063; Thu, 09
 Apr 2026 16:56:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Apr 2026 16:56:18 -0700
In-Reply-To: <20260409235622.2052730-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409235622.2052730-8-seanjc@google.com>
Subject: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c      |  12 ++--
 arch/x86/kvm/hyperv.c     |  24 ++++----
 arch/x86/kvm/hyperv.h     |   4 +-
 arch/x86/kvm/svm/nested.c |   6 +-
 arch/x86/kvm/svm/svm.c    |  13 ++--
 arch/x86/kvm/vmx/nested.c |   8 +--
 arch/x86/kvm/vmx/sgx.c    |   4 +-
 arch/x86/kvm/vmx/tdx.c    |  18 +++---
 arch/x86/kvm/x86.c        | 121 +++++++++++++++++++-------------------
 arch/x86/kvm/x86.h        |  88 +++++++++++++++++----------
 arch/x86/kvm/xen.c        |  30 +++++-----
 11 files changed, 175 insertions(+), 153 deletions(-)

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
index 9b140bbdc1d8..14e2fcf19def 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2375,10 +2375,10 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 
 	longmode = is_64_bit_hypercall(vcpu);
 	if (longmode)
-		kvm_rax_write(vcpu, result);
+		kvm_rax_write_raw(vcpu, result);
 	else {
-		kvm_rdx_write(vcpu, result >> 32);
-		kvm_rax_write(vcpu, result & 0xffffffff);
+		kvm_edx_write(vcpu, result >> 32);
+		kvm_eax_write(vcpu, result & 0xffffffff);
 	}
 }
 
@@ -2542,18 +2542,18 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 
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
+		hc.param = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
+			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
+		hc.ingpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
+			    (kvm_rdx_read_raw(vcpu) & 0xffffffff);
+		hc.outgpa = ((u64)kvm_rdx_read_raw(vcpu) << 32) |
+			     (kvm_rdx_read_raw(vcpu) & 0xffffffff);
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
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f45..00de9375c836 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -757,7 +757,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
 
 	svm->vcpu.arch.cr2 = save->cr2;
 
-	kvm_rax_write(vcpu, save->rax);
+	kvm_rax_write_raw(vcpu, save->rax);
 	kvm_rsp_write(vcpu, save->rsp);
 	kvm_rip_write(vcpu, save->rip);
 
@@ -1238,7 +1238,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
 	vmcb12->save.rflags = kvm_get_rflags(vcpu);
 	vmcb12->save.rip    = kvm_rip_read(vcpu);
 	vmcb12->save.rsp    = kvm_rsp_read(vcpu);
-	vmcb12->save.rax    = kvm_rax_read(vcpu);
+	vmcb12->save.rax    = kvm_rax_read_raw(vcpu);
 	vmcb12->save.dr7    = vmcb02->save.dr7;
 	vmcb12->save.dr6    = svm->vcpu.arch.dr6;
 	vmcb12->save.cpl    = vmcb02->save.cpl;
@@ -1391,7 +1391,7 @@ void nested_svm_vmexit(struct vcpu_svm *svm)
 	svm_set_efer(vcpu, vmcb01->save.efer);
 	svm_set_cr0(vcpu, vmcb01->save.cr0 | X86_CR0_PE);
 	svm_set_cr4(vcpu, vmcb01->save.cr4);
-	kvm_rax_write(vcpu, vmcb01->save.rax);
+	kvm_rax_write_raw(vcpu, vmcb01->save.rax);
 	kvm_rsp_write(vcpu, vmcb01->save.rsp);
 	kvm_rip_write(vcpu, vmcb01->save.rip);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a1b2e4152afe..0e2e7a803d64 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2378,15 +2378,12 @@ static int clgi_interception(struct kvm_vcpu *vcpu)
 
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
index 3fe88f29be7a..9a1bf35fe7cd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6135,7 +6135,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
 static int nested_vmx_eptp_switching(struct kvm_vcpu *vcpu,
 				     struct vmcs12 *vmcs12)
 {
-	u32 index = kvm_rcx_read(vcpu);
+	u32 index = kvm_ecx_read(vcpu);
 	u64 new_eptp;
 
 	if (WARN_ON_ONCE(!nested_cpu_has_ept(vmcs12)))
@@ -6169,7 +6169,7 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12;
-	u32 function = kvm_rax_read(vcpu);
+	u32 function = kvm_eax_read(vcpu);
 
 	/*
 	 * VMFUNC should never execute cleanly while L1 is active; KVM supports
@@ -6291,7 +6291,7 @@ static bool nested_vmx_exit_handled_msr(struct kvm_vcpu *vcpu,
 	    exit_reason.basic == EXIT_REASON_MSR_WRITE_IMM)
 		msr_index = vmx_get_exit_qual(vcpu);
 	else
-		msr_index = kvm_rcx_read(vcpu);
+		msr_index = kvm_ecx_read(vcpu);
 
 	/*
 	 * The MSR_BITMAP page is divided into four 1024-byte bitmaps,
@@ -6401,7 +6401,7 @@ static bool nested_vmx_exit_handled_encls(struct kvm_vcpu *vcpu,
 	    !nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENCLS_EXITING))
 		return false;
 
-	encls_leaf = kvm_rax_read(vcpu);
+	encls_leaf = kvm_eax_read(vcpu);
 	if (encls_leaf > 62)
 		encls_leaf = 63;
 	return vmcs12->encls_exiting_bitmap & BIT_ULL(encls_leaf);
diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 4c61fc33f764..4ca11e5ff4eb 100644
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
index 1e47c194af53..9f6885d035a2 100644
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
@@ -2031,12 +2031,12 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
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
+		kvm_eax_write(vcpu, tdx->vp_enter_args.r13 & -1u);
+		kvm_edx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
 		return kvm_emulate_wrmsr(vcpu);
 	case EXIT_REASON_EPT_MISCONFIG:
 		return tdx_emulate_mmio(vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 34ee79c1cbf3..e5d073763fc1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1313,7 +1313,7 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 {
 	/* Note, #UD due to CR4.OSXSAVE=0 has priority over the intercept. */
 	if (kvm_x86_call(get_cpl)(vcpu) != 0 ||
-	    __kvm_set_xcr(vcpu, kvm_rcx_read(vcpu), kvm_read_edx_eax(vcpu))) {
+	    __kvm_set_xcr(vcpu, kvm_ecx_read(vcpu), kvm_read_edx_eax(vcpu))) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -1602,7 +1602,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_get_dr);
 
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 {
-	u32 pmc = kvm_rcx_read(vcpu);
+	u32 pmc = kvm_ecx_read(vcpu);
 	u64 data;
 
 	if (kvm_pmu_rdpmc(vcpu, pmc, &data)) {
@@ -1610,8 +1610,8 @@ int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	kvm_rax_write(vcpu, (u32)data);
-	kvm_rdx_write(vcpu, data >> 32);
+	kvm_eax_write(vcpu, (u32)data);
+	kvm_edx_write(vcpu, data >> 32);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdpmc);
@@ -2058,8 +2058,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_msr_write);
 static void complete_userspace_rdmsr(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu->run->msr.error) {
-		kvm_rax_write(vcpu, (u32)vcpu->run->msr.data);
-		kvm_rdx_write(vcpu, vcpu->run->msr.data >> 32);
+		kvm_eax_write(vcpu, (u32)vcpu->run->msr.data);
+		kvm_edx_write(vcpu, vcpu->run->msr.data >> 32);
 	}
 }
 
@@ -2140,8 +2140,8 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 		trace_kvm_msr_read(msr, data);
 
 		if (reg < 0) {
-			kvm_rax_write(vcpu, data & -1u);
-			kvm_rdx_write(vcpu, (data >> 32) & -1u);
+			kvm_eax_write(vcpu, data & -1u);
+			kvm_edx_write(vcpu, (data >> 32) & -1u);
 		} else {
 			kvm_register_write(vcpu, reg, data);
 		}
@@ -2158,7 +2158,7 @@ static int __kvm_emulate_rdmsr(struct kvm_vcpu *vcpu, u32 msr, int reg,
 
 int kvm_emulate_rdmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_rdmsr(vcpu, kvm_rcx_read(vcpu), -1,
+	return __kvm_emulate_rdmsr(vcpu, kvm_ecx_read(vcpu), -1,
 				   complete_fast_rdmsr);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_rdmsr);
@@ -2194,7 +2194,7 @@ static int __kvm_emulate_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 
 int kvm_emulate_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __kvm_emulate_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __kvm_emulate_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				   kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_wrmsr);
@@ -2304,7 +2304,7 @@ static fastpath_t __handle_fastpath_wrmsr(struct kvm_vcpu *vcpu, u32 msr, u64 da
 
 fastpath_t handle_fastpath_wrmsr(struct kvm_vcpu *vcpu)
 {
-	return __handle_fastpath_wrmsr(vcpu, kvm_rcx_read(vcpu),
+	return __handle_fastpath_wrmsr(vcpu, kvm_ecx_read(vcpu),
 				       kvm_read_edx_eax(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(handle_fastpath_wrmsr);
@@ -9699,7 +9699,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
 			    unsigned short port)
 {
-	unsigned long val = kvm_rax_read(vcpu);
+	unsigned long val = kvm_rax_read_raw(vcpu);
 	int ret = emulator_pio_out(vcpu, size, port, &val, 1);
 
 	if (ret)
@@ -9735,10 +9735,10 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
 	}
 
 	/* For size less than 4 we merge, else we zero extend */
-	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read(vcpu) : 0;
+	val = (vcpu->arch.pio.size < 4) ? kvm_rax_read_raw(vcpu) : 0;
 
 	complete_emulator_pio_in(vcpu, &val);
-	kvm_rax_write(vcpu, val);
+	kvm_rax_write_raw(vcpu, val);
 
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -9750,11 +9750,11 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
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
 
@@ -10421,29 +10421,30 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 
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
@@ -12144,23 +12145,23 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
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
@@ -12184,23 +12185,23 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
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
@@ -13103,7 +13104,7 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	 * on RESET.  But, go through the motions in case that's ever remedied.
 	 */
 	cpuid_0x1 = kvm_find_cpuid_entry(vcpu, 1);
-	kvm_rdx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
+	kvm_edx_write(vcpu, cpuid_0x1 ? cpuid_0x1->eax : 0x600);
 
 	kvm_x86_call(vcpu_reset)(vcpu, init_event);
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index c44154ed3f26..2550380fa79e 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -421,53 +421,77 @@ static inline bool vcpu_match_mmio_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	return false;
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
+static __always_inline void kvm_e##lname##_write(struct kvm_vcpu *vcpu,	u32 val)	\
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
 
 static inline u64 kvm_read_edx_eax(struct kvm_vcpu *vcpu)
 {
-	return (kvm_rax_read(vcpu) & -1u)
-		| ((u64)(kvm_rdx_read(vcpu) & -1u) << 32);
+	return kvm_eax_read(vcpu) | (u64)(kvm_edx_read(vcpu)) << 32;
 }
 
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
index 895095dc684e..e98fa3544bdd 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1408,7 +1408,7 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 
 static int kvm_xen_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 {
-	kvm_rax_write(vcpu, result);
+	kvm_rax_write_raw(vcpu, result);
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
@@ -1685,23 +1685,23 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 
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
2.53.0.1213.gd9a14994de-goog

