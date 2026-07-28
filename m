Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83417245008
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199439; cv=none; b=QFrReRqBdKaWdiiXwwrzbg5CD6SLkJ/nLh0AtewIBHxwzserpi/xDfiJoKrXJhXkfMGKRcZwVxYerMDyp+8zEmjs0UwbrHha5ITkOD0I9cOlDI+R8hO4v1XCw6Hj6CNSa4oR5isimQyW9AiYjhM6Ulyyj93XrTDKtz/c6+rjmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199439; c=relaxed/simple;
	bh=vUVtaJqby96JxIHbgIT89MpM/r+mxhCTGYIcpuqxQ+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TYDrWVVXAola5oHekJWkq426vs83GKSV5OH8dUN8hpY0sQwNcRVv6JRhJ+hyhvyY5GZ/lG+pKlfe6tdlYDdS25DTHemLkwV5WJ95r5Cvjhm5/w2niW5lH/nPNtaV9OjI5XRFfkPXf48yDCRJRydqExlhhKRWhx/ATbrwwcPs28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=na0sOqJ9; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="na0sOqJ9"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485d853b08so8628369b3a.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199437; x=1785804237; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=i72EmMYtRGL5cLshL49yerm7oy63OdOX2oCt0s+j/7Y=;
        b=na0sOqJ9iTrMmmTpojWVIWU6X3lnWTaqeGvtlnRvsiK76hS8i9qYQNjrhgkgd+E630
         cOJSKJc9IMPr6YH0RD10GRDCfXKpRTidLv4GwrbI4KVFUa83+2CrzgCeJz5V658pnAku
         jQVthuRN9ZyG73tt9kMszjZgw+bf9/kNxnEE1j/TO/1FUVo8vG0soILUmFCJCx6atWaA
         KAKezZhbanYqZvYk08HjfiH5m8LZZjv35LOvJh8kXQi3lrZstKm+6Ljd99TxnIcQZl2Y
         fJ/omXmckH1lwq6e1TA68rR4uRbYkYpXn+d4wj8Z9sGBjsp2DF925QKhOakpTiLOjjih
         H2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199437; x=1785804237;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i72EmMYtRGL5cLshL49yerm7oy63OdOX2oCt0s+j/7Y=;
        b=aP/oHHSfp2SOCcT+rlR0dtNKByVW1/lgSZUrUICJR+gxWNSL6iCpeEfGGm2ewmcIqR
         Rfo7fS1Leaw4DbKvhcfY1mUKRdH9GGaBat0hKj2DjcDHawcQ7M2Qc6frErvK85PomfpA
         qPv6oNfEXXUUoljpW1frNVs5C/hypOl9zRBkpPZU1j30oQC73GLbejkVuC+ZO2ep8kzp
         lh3YvgMFzAFsMEXEEoWe3b/NquQ9TvZ265ZEJb6sHTSZ4IVLJVqPIxRXXGykH+N3gwfN
         Xe4CQboKkJQTHz1sxrQgOZt12tMFMCxWAb1R/WDCG0nY2FWksIphSHQ7iXNdIfRQcMYw
         ArYw==
X-Gm-Message-State: AOJu0YzDX2bmnHuTctwUKtLH1CoVQNGbSEYCmKDfNDtzcHD747vUPUFU
	ec7NS9Okmbp6HlxhzrMqnT6GSA4vZDSaIWPdyn+21KxGIk1eR7b+0QaUI/W0RRyt5L6ZpFPvSwF
	wWLSNWQ==
X-Received: from pfbmb2.prod.google.com ([2002:a05:6a00:7602:b0:847:80c0:ec04])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9288:b0:84e:23a:14c5
 with SMTP id d2e1a72fcca58-84e932c7a05mr153259b3a.57.1785199436262; Mon, 27
 Jul 2026 17:43:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:48 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-4-seanjc@google.com>
Subject: [PATCH v4 3/6] KVM: x86: Rework kvm_x86_ops.vcpu_pre_run() into .vcpu_needs_initialization()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
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
 arch/x86/kvm/vmx/x86_ops.h         |  2 +-
 arch/x86/kvm/x86.c                 |  5 ++++-
 9 files changed, 21 insertions(+), 27 deletions(-)

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
index d68cba12c772..bccca9c5b966 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4402,16 +4402,6 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
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
@@ -5388,7 +5378,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.flush_tlb_gva = svm_flush_tlb_gva,
 	.flush_tlb_guest = svm_flush_tlb_guest,
 
-	.vcpu_pre_run = svm_vcpu_pre_run,
 	.vcpu_run = svm_vcpu_run,
 	.handle_exit = svm_handle_exit,
 	.skip_emulated_instruction = svm_skip_emulated_instruction,
@@ -5446,6 +5435,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
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
index 924a629c21e2..0ff3230fd95e 100644
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
-	return 1;
+	return is_td_vcpu(vcpu) &&
+	       tdx_vcpu_needs_initialization(vcpu);
 }
 
 static fastpath_t vt_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
@@ -949,7 +947,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.flush_tlb_gva = vt_op(flush_tlb_gva),
 	.flush_tlb_guest = vt_op(flush_tlb_guest),
 
-	.vcpu_pre_run = vt_op_tdx_only(vcpu_pre_run),
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
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 4d2dd88afe7f..cdb38d940cfb 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -137,7 +137,7 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu);
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
2.55.0.229.g6434b31f56-goog

