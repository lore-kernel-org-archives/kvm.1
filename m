Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0589365A19
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189243; cv=none; b=ZiD+tGMg3me8gF2nPtJyueZ8a+FSOj7apnwBaSOhT//VZt4Ozvn0h+OBpdtGb0f1tfA2403nGaZ30L9C7Ocq3zT3BHfbOdTEedqKUnU/kyNpUxFd0ZGdlvKFuoXaKRdLhHs6qpgVmJQVo/5Ox29jey/w1jyBjkPzO4h2ffTFmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189243; c=relaxed/simple;
	bh=/AZ+SwQNuV1HBEW+2zllqRNISfAa3nxcBibWN/35fOM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V4QhdnXO0+1MV5DAxESaT4aDPy8qYbR9CJUxNl5pSrZH/B8r/aNPpVdC8SzyQEwnGcWfp8/kdq1P7UYK8X6NcKvhjMZM27T6rqJUxJbg4Sb/G/IOT3Fh4T7DcpPUFaIh++ZyB8jDhpQkdxn9iarEe8C72WRDOnXoz8Va/MsN6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T1ahHzBV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1ahHzBV"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c738f716bfaso216005a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773189241; x=1773794041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VrwT1qYZM1BVcF4TouPNh26klS1cOdhqo+z3t1px/qc=;
        b=T1ahHzBVDJ2gVUp2qFuRNU6/Mo1l0ksXq40Z7X4T9QleJXu1/EmfPPcZ/S5Kl0Q7le
         vqiixRzXbIEIx/1lmHc+lZcNJluj5oiFiZu5RbA+13Ppfcvt/5039Bbkcn9OBdTqXc6/
         fsICG3iEQ0E83yNFVaEt0P2nIjsP2lmYrPVQyStj/PzsuxMZ2x4r5/Kf26APXk3slj3z
         gAj5AkRVhueSjWJHQzGPMoC132Kd9qVCKS20cvpCXsVWjFh/PJ+Q/fWVcjJFURCNKuBC
         4y/2IB7VpOGvLc0v4unnkGdwjTWCB29yDd8RVoA3a4Yibveky0AaNIcA6avVjZSPAq1+
         z+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773189241; x=1773794041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrwT1qYZM1BVcF4TouPNh26klS1cOdhqo+z3t1px/qc=;
        b=Z/3K9qPw/GVBbYkbaNhJAk0diUFrlmNGNdFrLYHvNj9tFMPBiM2YQlM8BKggJOMYyY
         K0NsmCCshJ+UEtp44Im8l1ymVhMzc9SpbZqF9XHMOmF6BwsMhE/fJF2QrrGlaY7pk2T6
         59EZ2ePc5XziXeVJU93Mrr0asxoTpWe06frsmPq2PQT3Yxss4y2aDUUQDrV5nJCIh6kt
         GFjhanu9huKkXntJ5U90anMWecvVfI90VgvbdBwTYIH1tsY30HYZufh0j6lAr4iYJHFh
         +sB2R+rGHULt23t8jzmq5wkoW1ozaj9pd5N/0gRtzlAThvpOvcPW9Msu8EFVXNeFPdU4
         PySQ==
X-Gm-Message-State: AOJu0Yzleds4qBh5/1MXJV6cPv7ZLGiD+pYA0jEvGk39ek3zLSTa8Tv1
	M2LM6D0Vi0UKVC/ll2xHGTLut8gQWYH+wSm4SyIq6rQkqMiolAz1gJbykU137PCT4yNGid3KYWn
	TdmzRkQ==
X-Received: from pfbfm23.prod.google.com ([2002:a05:6a00:2f97:b0:823:747:7567])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d1:b0:825:2927:3aa6
 with SMTP id d2e1a72fcca58-829f79d5943mr495224b3a.14.1773189240997; Tue, 10
 Mar 2026 17:34:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 10 Mar 2026 17:33:43 -0700
In-Reply-To: <20260311003346.2626238-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311003346.2626238-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311003346.2626238-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: x86: Add wrapper APIs to reset dirty/available
 register masks
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Chang S . Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add wrappers for setting regs_{avail,dirty} in anticipation of turning the
fields into proper bitmaps, at which point direct writes won't work so
well.

Deliberately leave the initialization in kvm_arch_vcpu_create() as-is,
because the regs_avail logic in particular is special in that it's the one
and only place where KVM marks eagerly synchronized registers as available.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/kvm_cache_regs.h | 19 +++++++++++++++++++
 arch/x86/kvm/svm/svm.c        |  4 ++--
 arch/x86/kvm/vmx/nested.c     |  4 ++--
 arch/x86/kvm/vmx/tdx.c        |  2 +-
 arch/x86/kvm/vmx/vmx.c        |  4 ++--
 5 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index ac1f9867a234..94e31cf38cb8 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -105,6 +105,25 @@ static __always_inline bool kvm_register_test_and_mark_available(struct kvm_vcpu
 	return arch___test_and_set_bit(reg, (unsigned long *)&vcpu->arch.regs_avail);
 }
 
+static __always_inline void kvm_reset_available_registers(struct kvm_vcpu *vcpu,
+							  u32 available_mask)
+{
+	/*
+	 * Note the bitwise-AND!  In practice, a straight write would also work
+	 * as KVM initializes the mask to all ones and never clears registers
+	 * that are eagerly synchronized.  Using a bitwise-AND adds a bit of
+	 * sanity checking as incorrectly marking an eagerly sync'd register
+	 * unavailable will generate a WARN due to an unexpected cache request.
+	 */
+	vcpu->arch.regs_avail &= available_mask;
+}
+
+static __always_inline void kvm_reset_dirty_registers(struct kvm_vcpu *vcpu,
+						      u32 dirty_mask)
+{
+	vcpu->arch.regs_dirty = dirty_mask;
+}
+
 /*
  * The "raw" register helpers are only for cases where the full 64 bits of a
  * register are read/written irrespective of current vCPU mode.  In other words,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1712c21f4128..1a6626c32188 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4524,7 +4524,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vcpu->arch.regs[VCPU_REGS_RSP] = svm->vmcb->save.rsp;
 		vcpu->arch.rip = svm->vmcb->save.rip;
 	}
-	vcpu->arch.regs_dirty = 0;
+	kvm_reset_dirty_registers(vcpu, 0);
 
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
@@ -4570,7 +4570,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vcpu->arch.apf.host_apf_flags =
 			kvm_read_and_reset_apf_flags();
 
-	vcpu->arch.regs_avail &= ~SVM_REGS_LAZY_LOAD_SET;
+	kvm_reset_available_registers(vcpu, ~SVM_REGS_LAZY_LOAD_SET);
 
 	if (!msr_write_intercepted(vcpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL))
 		rdmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, vcpu_to_pmu(vcpu)->global_ctrl);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index af2aaef38502..d4ba64bde709 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -310,13 +310,13 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
 	vmx_sync_vmcs_host_state(vmx, prev);
 	put_cpu();
 
-	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
+	kvm_reset_available_registers(vcpu, ~VMX_REGS_LAZY_LOAD_SET);
 
 	/*
 	 * All lazily updated registers will be reloaded from VMCS12 on both
 	 * vmentry and vmexit.
 	 */
-	vcpu->arch.regs_dirty = 0;
+	kvm_reset_dirty_registers(vcpu, 0);
 }
 
 static void nested_put_vmcs12_pages(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c23ec4ac8bc8..d4cb6dc8098f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1098,7 +1098,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 
 	tdx_load_host_xsave_state(vcpu);
 
-	vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
+	kvm_reset_available_registers(vcpu, TDX_REGS_AVAIL_SET);
 
 	if (unlikely(tdx->vp_enter_ret == EXIT_REASON_EPT_MISCONFIG))
 		return EXIT_FASTPATH_NONE;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ed44eb5b4349..217ea6e72c2f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7472,7 +7472,7 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 				   flags);
 
 	vcpu->arch.cr2 = native_read_cr2();
-	vcpu->arch.regs_avail &= ~VMX_REGS_LAZY_LOAD_SET;
+	kvm_reset_available_registers(vcpu, ~VMX_REGS_LAZY_LOAD_SET);
 
 	vmx->idt_vectoring_info = 0;
 
@@ -7538,7 +7538,7 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 		vmcs_writel(GUEST_RSP, vcpu->arch.regs[VCPU_REGS_RSP]);
 	if (kvm_register_is_dirty(vcpu, VCPU_REG_RIP))
 		vmcs_writel(GUEST_RIP, vcpu->arch.rip);
-	vcpu->arch.regs_dirty = 0;
+	kvm_reset_dirty_registers(vcpu, 0);
 
 	if (run_flags & KVM_RUN_LOAD_GUEST_DR6)
 		set_debugreg(vcpu->arch.dr6, 6);
-- 
2.53.0.473.g4a7958ca14-goog

