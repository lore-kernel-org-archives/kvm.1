Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950044E658
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519229; cv=none; b=b0c8xI+3iWf9cp/i++Xn/4YZkAAWXL1AArI0GDgrlMEm/rbA/f14zYRiLsICgTP2TEeJoZlsn0SuGVd2Ka66sFQGRqJnrbTa1H1+0EGcyT87IEOABr8MYNbwH5R2aUcxCe5zWA62GS6xDq8kAMcDbpXnYRnHMLjPN5g8IL6Hz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519229; c=relaxed/simple;
	bh=JjorgHnrRqHA3MkLqNR/CwX6y2mrNEKtCoXCr6JiDQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gWSAG8cS3Vi+1BZuHPpw8JR9sgMG0VRj1XjLjwtmYpYT0uCqdglsrS/OByPc7MNU8ElqYNqbgXfYu9GieHcn/JfmKqaCMgS26gWdsHs+7Peh1gB3rQE6z5o5YTuFOxeXUnxaH+AbJZvDuS+UI3j7eamcfn90i4/PE7alh0kOXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ideod2JF; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ideod2JF"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8484f26852dso1440837b3a.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519226; x=1786124026; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kx00NjRjiwHJ66IMeM0hhNXW9W7e0zenonV59M82y0I=;
        b=ideod2JFXlmiSHoRfol/iH+Q6ZJFlolFrjQBBKedbv43NdEZdRNqIvBt27DTtXBxeU
         5+FDiBDGp1GNHZDYkB6WRWGKww8R2ntHb365FJim9djbBlzC834wKVo4eK5zLAALzXAt
         /64pghacpSqj8P9fXQi+DSHFrAjPzd0CAqKTJqKtu/RA9ME5lVxXM23efRw3IZPg9fZd
         768K7/v1IWVmvxaespeWRzVTKHPTzrGV/7KtaXKJwHzXlwmXfZaOU6lhVuMCiKwVw+gH
         chDwgVkFtScF+Dt4NV5T1eO0jSFvBKohkrzkNvWvOPt7wvvX2ZmJFtXcj2eouaakNv6c
         kDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519226; x=1786124026;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kx00NjRjiwHJ66IMeM0hhNXW9W7e0zenonV59M82y0I=;
        b=Pa7DUx6sM3WPfdhvizmLjc5xpdDCKbCojFYSQj3HHFqLcEv5owQ92z5UB1ecKN4l9q
         FEGEbGyLeFvn6dvCP3zDVnsqe+D+Z/V4zA00QvDnAqvlkGkeVWv/OIF/1s+kOMD0AhvJ
         9od1JcOdnTLVddN0ZRtrmTUq5mW0XsY+UQFcVudGlSBEwzAYawKIqhd+i6bhGatZRnib
         RQ7nxmDBLEeCPWQkV0BdGEuF9qoh2w22b8RG3NdGJy6uYnE9UhM692BespYvf1RQO+Rf
         FGUWNGB4/WwkD0v3dIqM5lgwPHpMq6VVSt8PGLEe64eZqEJTwWeVGiJf+SDzfHzP5wrl
         uaHQ==
X-Gm-Message-State: AOJu0YxuuN3cXx5dQQa7EcaJ7D6Z6DhufHecQKtdumCkYfLF8YoeaLoS
	rjVmlC2RTK6NkLfbfaXSKOwzNrFNwY9493+dT7iU/XqUv6PcSdnTQdg9JjqL++cgSN6rrRpoVMa
	dlxzX6g==
X-Received: from pfbk15.prod.google.com ([2002:a05:6a00:b00f:b0:84e:4b64:d17b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9284:b0:84e:24df:3870
 with SMTP id d2e1a72fcca58-84ee45dfe1fmr529111b3a.0.1785519225828; Fri, 31
 Jul 2026 10:33:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:37 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-4-seanjc@google.com>
Subject: [PATCH v5 3/6] KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initialization()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="UTF-8"

Rework .vcpu_pre_run() into a more specific .vcpu_needs_initialization() to
consolidate the SNP and TDX control flows, and to eliminate the potentially
confusing almost-collision between svm_vcpu_pre_run() and pre_sev_run(): the
former is SEV specific, but is pre-KVM_RUN, whereas the latter is pre-VMRUN.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  2 +-
 arch/x86/kvm/svm/sev.c             |  5 +++++
 arch/x86/kvm/svm/svm.c             | 12 +-----------
 arch/x86/kvm/svm/svm.h             |  1 +
 arch/x86/kvm/vmx/main.c            | 10 ++++------
 arch/x86/kvm/vmx/tdx.c             |  9 +++------
 arch/x86/kvm/vmx/vmx.c             |  5 -----
 arch/x86/kvm/vmx/x86_ops.h         |  3 +--
 arch/x86/kvm/x86.c                 |  5 ++++-
 10 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index e5b0458afc25..e213c9ae3e30 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -63,7 +63,7 @@ KVM_X86_OP_OPTIONAL(flush_remote_tlbs_range)
 #endif
 KVM_X86_OP(flush_tlb_gva)
 KVM_X86_OP(flush_tlb_guest)
-KVM_X86_OP(vcpu_pre_run)
+KVM_X86_OP_OPTIONAL_RET0(vcpu_needs_initialization)
 KVM_X86_OP(vcpu_run)
 KVM_X86_OP(handle_exit)
 KVM_X86_OP(skip_emulated_instruction)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7e3cacb2df9b..283847619ff8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1586,7 +1586,7 @@ struct kvm_x86_ops {
 	 */
 	void (*flush_tlb_guest)(struct kvm_vcpu *vcpu);
 
-	int (*vcpu_pre_run)(struct kvm_vcpu *vcpu);
+	bool (*vcpu_needs_initialization)(struct kvm_vcpu *vcpu);
 	enum exit_fastpath_completion (*vcpu_run)(struct kvm_vcpu *vcpu,
 						  u64 run_flags);
 	int (*handle_exit)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 90a08d36d843..fcb41dfde4c0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3556,6 +3556,11 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 	__sev_es_unmap_ghcb(svm);
 }
 
+bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
+{
+	return to_kvm_sev_info(vcpu->kvm)->need_init;
+}
+
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c1e6d62512b9..9d607b98bd06 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4400,16 +4400,6 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 	svm_complete_interrupts(vcpu);
 }
 
-static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
-{
-#ifdef CONFIG_KVM_AMD_SEV
-	if (to_kvm_sev_info(vcpu->kvm)->need_init)
-		return -EINVAL;
-#endif
-
-	return 1;
-}
-
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -5376,7 +5366,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.flush_tlb_gva = svm_flush_tlb_gva,
 	.flush_tlb_guest = svm_flush_tlb_guest,
 
-	.vcpu_pre_run = svm_vcpu_pre_run,
 	.vcpu_run = svm_vcpu_run,
 	.handle_exit = svm_handle_exit,
 	.skip_emulated_instruction = svm_skip_emulated_instruction,
@@ -5434,6 +5423,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 #endif
 
 #ifdef CONFIG_KVM_AMD_SEV
+	.vcpu_needs_initialization = sev_vcpu_needs_initialization,
 	.dev_get_attr = sev_dev_get_attr,
 	.mem_enc_ioctl = sev_mem_enc_ioctl,
 	.mem_enc_register_region = sev_mem_enc_register_region,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index a327bf751ecd..66b44b54608e 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -979,6 +979,7 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 void sev_es_unmap_ghcb(struct vcpu_svm *svm);
 
 #ifdef CONFIG_KVM_AMD_SEV
+bool sev_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
 int sev_mem_enc_ioctl(struct kvm *kvm, void __user *argp);
 int sev_mem_enc_register_region(struct kvm *kvm,
 				struct kvm_enc_region *range);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 2a69dc3ac690..0ff3230fd95e 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -140,12 +140,10 @@ static void vt_vcpu_put(struct kvm_vcpu *vcpu)
 	vmx_vcpu_put(vcpu);
 }
 
-static int vt_vcpu_pre_run(struct kvm_vcpu *vcpu)
+static bool vt_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
 {
-	if (is_td_vcpu(vcpu))
-		return tdx_vcpu_pre_run(vcpu);
-
-	return vmx_vcpu_pre_run(vcpu);
+	return is_td_vcpu(vcpu) &&
+	       tdx_vcpu_needs_initialization(vcpu);
 }
 
 static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
@@ -949,7 +947,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.flush_tlb_gva = vt_op(flush_tlb_gva),
 	.flush_tlb_guest = vt_op(flush_tlb_guest),
 
-	.vcpu_pre_run = vt_op(vcpu_pre_run),
+	.vcpu_needs_initialization = vt_op_tdx_only(vcpu_needs_initialization),
 	.vcpu_run = vt_op(vcpu_run),
 	.handle_exit = vt_op(handle_exit),
 	.skip_emulated_instruction = vmx_skip_emulated_instruction,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d1af0a752e97..b272c20586a7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -897,13 +897,10 @@ void tdx_vcpu_free(struct kvm_vcpu *vcpu)
 	tdx->state = VCPU_TD_STATE_UNINITIALIZED;
 }
 
-int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu)
+bool tdx_vcpu_needs_initialization(struct kvm_vcpu *vcpu)
 {
-	if (unlikely(to_tdx(vcpu)->state != VCPU_TD_STATE_INITIALIZED ||
-		     to_kvm_tdx(vcpu->kvm)->state != TD_STATE_RUNNABLE))
-		return -EINVAL;
-
-	return 1;
+	return to_tdx(vcpu)->state != VCPU_TD_STATE_INITIALIZED ||
+	       to_kvm_tdx(vcpu->kvm)->state != TD_STATE_RUNNABLE;
 }
 
 static __always_inline u32 tdcall_to_vmx_exit_reason(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2337b7ede290..76160adf8297 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6110,11 +6110,6 @@ static int handle_invalid_guest_state(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu)
-{
-	return 1;
-}
-
 /*
  * Indicate a busy-waiting vcpu in spinlock. We do not enable the PAUSE
  * exiting, so only get here on cpu with PAUSE-Loop-Exiting.
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 551b4195bc1b..cdb38d940cfb 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -21,7 +21,6 @@ int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
 int vmx_vcpu_create(struct kvm_vcpu *vcpu);
-int vmx_vcpu_pre_run(struct kvm_vcpu *vcpu);
 fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void vmx_vcpu_free(struct kvm_vcpu *vcpu);
 void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
@@ -138,7 +137,7 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu);
 void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 void tdx_vcpu_free(struct kvm_vcpu *vcpu);
 void tdx_vcpu_load(struct kvm_vcpu *vcpu, int cpu);
-int tdx_vcpu_pre_run(struct kvm_vcpu *vcpu);
+bool tdx_vcpu_needs_initialization(struct kvm_vcpu *vcpu);
 fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags);
 void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void tdx_vcpu_put(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 64a13acc37be..d94b59140c45 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8867,12 +8867,15 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
 	    !kvm_apic_init_sipi_allowed(vcpu))
 		return -EINVAL;
 
+	if (kvm_x86_call(vcpu_needs_initialization)(vcpu))
+		return -EINVAL;
+
 	if (kvm_x86_call(unhandleable_emulation_required)(vcpu)) {
 		kvm_prepare_emulation_failure_exit(vcpu);
 		return 0;
 	}
 
-	return kvm_x86_call(vcpu_pre_run)(vcpu);
+	return 1;
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
-- 
2.55.0.508.g3f0d502094-goog

