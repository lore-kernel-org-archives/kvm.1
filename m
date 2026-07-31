Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEF044C67B
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518373; cv=none; b=drgnlW/zvTdHGnmoSrdzHwRMk3IfPpQ6QQWqhWbDTw/y6PCBpCFTJTNpz0v4YJQv2wnyj7mT6ZF7MuFsKjCwL5DM+K++9TOjsMbgvFjD6GlKeLrhNdPxkB5wZBxVkKZlXvDcevMpUaooJIRfN79x1J+hPMxuChlcTuS7obqgRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518373; c=relaxed/simple;
	bh=zMeBIHN0CGdZnKytc/O1sTgliErd+dm5vaI/CQ98LIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtRLLpJ7SmfYuw8+T4BZ2e1c93OnlNkhURhOchlunOtKbM5od3ONcLIQEsxpdFDB4oIOhRF7wt9uWGxSLSTrmGlZZCCmO6MAiixgvNUn1AMXjBob5ORZ9CTSpiB740VE3y193NvBbeGKRVKL0nUOQeR7Joz0pSpjLd0S0pNtlGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7K4by+n; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7K4by+n"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cceabd70f5so33313155ad.1
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785518369; x=1786123169; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DkmcTN43qpor8TZvvRVUAHGm6+rjqfKAX0vCCdL92HM=;
        b=n7K4by+nGPDx5TFRT7vjR8fVTFok/p87gKJxXGNaaCcVeUlYZmtG1Y658E71F8ZZQw
         8FrMicfByRp5QGEYWp9qQByQuP6vZsxzNwNk0+PjZd0aOveTzUOWGXc5Pgad4argvfw0
         KkiJxIh0fkL7RIlY+9iFaC9RATCKJ9HaWqnniTB5t98kpAtjfD8T+ssyEZr/qJ8I9Lkj
         IuF4tXaHM3uMl5BQjDRJLXahDnftOU4L/bx9zOTWpV6k7rW3rZgzmhwq1+kZ3hTIUEGk
         BbMVojqhZPZa3O/46udPFCgu2rXBnufJouXg24pEv1cuX6NkQKxbTciOfo/NWHZ69nCx
         cdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518369; x=1786123169;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DkmcTN43qpor8TZvvRVUAHGm6+rjqfKAX0vCCdL92HM=;
        b=F0A3lD/6PSMgLQJWcxtPhdcNQ1fFjGZhhzoVt5FqjB6NXvhy4k7P3RQRLiseLyD6nh
         68WcGtLPkns/fobliuNV9yHP46KwdnJzxlAgYE/IV8whlgvYDH9pnSQA/Fx0oJgz9nCY
         oRKhqtKVh+2dO0scWVI2ztgHYtxAcbrlshKTClX6KPCspLu8jScwg8iakVt+NOvGvTSY
         p7XZzLlwx8HcZyVxb7N1FUvOVMpYpYULNqPOBxgtbPBn3Ji6CcY6GmUnIA57re+xCrq0
         Wc+LGoVy4+kLiF4N0AWvi32RTmWi6BqVgyIu/7j/UM1kYK1mhviYNvTByssudtrnvSA7
         N/7Q==
X-Gm-Message-State: AOJu0YyLTdUuPeXIG8nsD7WZVESqSwi8AkAhm4dfJ2wm0vbdu77mRNgZ
	p07rdxTUDs5cTESoHPXaCEe33LaSnVbnNuZzTbrpT2w7ChTGXndeJ6xiZ/WHm3L8G9PwiZAA17q
	KILdDTg==
X-Received: from plht14.prod.google.com ([2002:a17:903:2f0e:b0:2ca:d66c:97b2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cd:b0:2c9:97a9:2098
 with SMTP id d9443c01a7336-2d052421484mr8012735ad.44.1785518369216; Fri, 31
 Jul 2026 10:19:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:19:25 -0700
In-Reply-To: <20260731171926.2629627-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731171926.2629627-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731171926.2629627-2-seanjc@google.com>
Subject: [PATCH v7 1/2] KVM: VMX: Bury all of the VMX preemption timer code
 under CONFIG_X86_64=y
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Double down on using the VMX preemption timer only for 64-bit kernels, and
bury the setup and runtime adjustment code, and all global variables, under
CONFIG_X86_64=y.  This will allow addressing a widespread Intel erratum
without running afoul of unused-but-set-variable and __udivdi3() errors on
32-bit kernels.

No functional change intended.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 122 +++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e4b9ac7fed9f..a07faa066ef0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -150,10 +150,12 @@ module_param(dump_invalid_vmcs, bool, 0644);
 #define KVM_VMX_TSC_MULTIPLIER_MAX     0xffffffffffffffffULL
 
 /* Guest_tsc -> host_tsc conversion requires 64-bit division.  */
+#ifdef CONFIG_X86_64
 static int __read_mostly cpu_preemption_timer_multi;
 static bool __read_mostly enable_preemption_timer = 1;
-#ifdef CONFIG_X86_64
 module_param_named(preemption_timer, enable_preemption_timer, bool, S_IRUGO);
+#else
+#define enable_preemption_timer false
 #endif
 
 extern bool __read_mostly allow_smaller_maxphyaddr;
@@ -7408,32 +7410,6 @@ static void vmx_refresh_guest_perf_global_control(struct kvm_vcpu *vcpu)
 	pmu->global_ctrl = vmcs_read64(GUEST_IA32_PERF_GLOBAL_CTRL);
 }
 
-static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
-{
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	u64 tscl;
-	u32 delta_tsc;
-
-	if (force_immediate_exit) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
-		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
-	} else if (vmx->hv_deadline_tsc != -1) {
-		tscl = rdtsc();
-		if (vmx->hv_deadline_tsc > tscl)
-			/* set_hv_timer ensures the delta fits in 32-bits */
-			delta_tsc = (u32)((vmx->hv_deadline_tsc - tscl) >>
-				cpu_preemption_timer_multi);
-		else
-			delta_tsc = 0;
-
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
-		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
-	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
-		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
-		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
-	}
-}
-
 void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
 {
 	if (unlikely(host_rsp != vmx->loaded_vmcs->host_state.rsp)) {
@@ -7519,6 +7495,8 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	guest_state_exit_irqoff();
 }
 
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit);
+
 fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
 {
 	bool force_immediate_exit = run_flags & KVM_RUN_FORCE_IMMEDIATE_EXIT;
@@ -8328,6 +8306,36 @@ static inline int u64_shl_div_u64(u64 a, unsigned int shift,
 	return 0;
 }
 
+static __init void vmx_setup_preemption_timer(void)
+{
+	if (!cpu_has_vmx_preemption_timer())
+		enable_preemption_timer = false;
+
+	if (enable_preemption_timer) {
+		u64 use_timer_freq = 5000ULL * 1000 * 1000;
+
+		cpu_preemption_timer_multi =
+			vmx_misc_preemption_timer_rate(vmcs_config.misc);
+
+		if (tsc_khz)
+			use_timer_freq = (u64)tsc_khz * 1000;
+		use_timer_freq >>= cpu_preemption_timer_multi;
+
+		/*
+		 * KVM "disables" the preemption timer by setting it to its max
+		 * value.  Don't use the timer if it might cause spurious exits
+		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
+		 */
+		if (use_timer_freq > 0xffffffffu / 10)
+			enable_preemption_timer = false;
+	}
+
+	if (!enable_preemption_timer) {
+		vt_x86_ops.set_hv_timer = NULL;
+		vt_x86_ops.cancel_hv_timer = NULL;
+	}
+}
+
 int vmx_set_hv_timer(struct kvm_vcpu *vcpu, u64 guest_deadline_tsc,
 		     bool *expired)
 {
@@ -8372,6 +8380,39 @@ void vmx_cancel_hv_timer(struct kvm_vcpu *vcpu)
 {
 	to_vmx(vcpu)->hv_deadline_tsc = -1;
 }
+
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	u64 tscl;
+	u32 delta_tsc;
+
+	if (force_immediate_exit) {
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, 0);
+		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
+	} else if (vmx->hv_deadline_tsc != -1) {
+		tscl = rdtsc();
+		if (vmx->hv_deadline_tsc > tscl)
+			/* set_hv_timer ensures the delta fits in 32-bits */
+			delta_tsc = (u32)((vmx->hv_deadline_tsc - tscl) >>
+				cpu_preemption_timer_multi);
+		else
+			delta_tsc = 0;
+
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, delta_tsc);
+		vmx->loaded_vmcs->hv_timer_soft_disabled = false;
+	} else if (!vmx->loaded_vmcs->hv_timer_soft_disabled) {
+		vmcs_write32(VMX_PREEMPTION_TIMER_VALUE, -1);
+		vmx->loaded_vmcs->hv_timer_soft_disabled = true;
+	}
+}
+#else
+static __init void vmx_setup_preemption_timer(void) { }
+
+static void vmx_update_hv_timer(struct kvm_vcpu *vcpu, bool force_immediate_exit)
+{
+	BUILD_BUG_ON(1);
+}
 #endif
 
 void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
@@ -8734,32 +8775,7 @@ __init int vmx_hardware_setup(void)
 	if (!enable_ept || !enable_ept_ad_bits || !cpu_has_vmx_pml())
 		enable_pml = 0;
 
-	if (!cpu_has_vmx_preemption_timer())
-		enable_preemption_timer = false;
-
-	if (enable_preemption_timer) {
-		u64 use_timer_freq = 5000ULL * 1000 * 1000;
-
-		cpu_preemption_timer_multi =
-			vmx_misc_preemption_timer_rate(vmcs_config.misc);
-
-		if (tsc_khz)
-			use_timer_freq = (u64)tsc_khz * 1000;
-		use_timer_freq >>= cpu_preemption_timer_multi;
-
-		/*
-		 * KVM "disables" the preemption timer by setting it to its max
-		 * value.  Don't use the timer if it might cause spurious exits
-		 * at a rate faster than 0.1 Hz (of uninterrupted guest time).
-		 */
-		if (use_timer_freq > 0xffffffffu / 10)
-			enable_preemption_timer = false;
-	}
-
-	if (!enable_preemption_timer) {
-		vt_x86_ops.set_hv_timer = NULL;
-		vt_x86_ops.cancel_hv_timer = NULL;
-	}
+	vmx_setup_preemption_timer();
 
 	kvm_caps.supported_mce_cap |= MCG_LMCE_P;
 	kvm_caps.supported_mce_cap |= MCG_CMCI_P;
-- 
2.55.0.508.g3f0d502094-goog

