Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D29483BF2
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936962; cv=none; b=iqgewFeCYoyjkPvlqMFIGDrru91CqIJv9FCHYK9URY8U5TlWDO94iXy/xrRlwNJ6LZo80gyhom1XMt6EKVlNeApxZoRXbYOuDorsqh2t8gHzgdAKQuscF5xX+9txD5o18ghCPPKUAA58JzzAax4c6a8IGniBtYBo5g55scvMPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936962; c=relaxed/simple;
	bh=clhH7ZiPLA41sFe5o/Oy5NJahjU10uFPXtPs2IKrxas=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZD5nGbtQKlveO+nQXKZ8ojcJf4AZ+ttdHRcx828zwV8O2BDOtuHIPu2Mc4H6iRPwvIDKtLJ0jYn1JAxabp6hpyoSR/Ffg+NOQBli4Zqwbbjyly8RazGiHL64KQwmtcRCbccMLYSjLygO9rBJMfs66Ngki8bXEVpijoANikJbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHSgursg; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHSgursg"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2069819a91.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784936959; x=1785541759; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/mXExy5GosFJWtTs0j3IlVUvvfvMu2OiveS7OM0Y9lY=;
        b=PHSgursg1HOVcpANARiozARhv0HyQFgZ0ZVblx1ELNP80nsiUoHIMWgC+YzmvNDwvr
         sqaBon2AJtmzkkLfZtEcn3iOSgA5ImCA0g29yMlzleRzBxgl+7HtEMbKelRGu17+256h
         E5KClKeI1sbIzsbNb8p+lmvAD3sqhQ5NUr5JF4kK3yJeC7/GULJbU7ctgmaixXZ97ezl
         IoOH/yWXXt55JC64G4O457mhtGfHNnwKqS6jR42r2a7dOEYU2+loEqE3e/k2NFmWHhE2
         QXiMkEcmnSNu5sMATBzfXnSJP/TuFMwWaPBHI+84PgYJARVSgPPmHgk3G4wavhQqPKGP
         4mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936959; x=1785541759;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mXExy5GosFJWtTs0j3IlVUvvfvMu2OiveS7OM0Y9lY=;
        b=hhW1s/jIw/lILQ9sM8c/OD6h2ngWjpMxlYtIBidyQBLKaJJWVTFprd65aknLpjIPb6
         upS3VaOpRRKL//udLt2Hxatxt5BgoNGtVIOc2I5ukoeEVhd7xdFL+9M+h9RNGezO5j34
         FciyGP2FrVVsBf1N2MqTkDEMC6Zu5FJT37WSxllyd6RoZ0OfGJzStm1sdY0fZ3+1iNP2
         mDhXhMZ678vdxtt5HxjNhEpvzMzyusXjIroU81Ez8iSGh74tSFkTpIBU67EJr3glL8Mi
         1agqksaQqLqxSN660b3pYMeZE5YoXhj7OBD8aaOOHNU2mIuSZv3ekV8YzrGQ/6oJHrtK
         ZSAg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1jhUC6tUgvZBVRyRp61UIBPIstT0oqMJTaAVSMrv87hTsBImBk4u1kGrAm+MWauGIIts=@vger.kernel.org
X-Gm-Message-State: AOJu0YypiQwKw4YHh4mB8TME8wPMy2JGaJDFbcAiSGSSbfTUiu1LORT8
	oECtJwBP5vh7E6ZR4pZa/AcpnvxBQq3wOkpO4VccIs4mH/7LS8mgiRpidKCrfP6eRUp6IOXOHfh
	7N6UdnjAsMJTphg==
X-Received: from pjbpi15.prod.google.com ([2002:a17:90b:1e4f:b0:38e:befb:90c6])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:558d:b0:38e:2fa0:491b with SMTP id 98e67ed59e1d1-38f29780228mr414631a91.31.1784936958457;
 Fri, 24 Jul 2026 16:49:18 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:49:13 -0700
In-Reply-To: <20260724234914.987987-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724234914.987987-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724234914.987987-2-jmattson@google.com>
Subject: [PATCH v5 1/2] KVM: VMX: Bury all of the VMX preemption timer code
 under CONFIG_X86_64=y
From: Jim Mattson <jmattson@google.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: chao.gao@intel.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Double down on using the VMX preemption timer only for 64-bit kernels, and
bury the setup and runtime adjustment code, and all global variables, under
CONFIG_X86_64=y.  This will allow addressing various Intel erratum without
running afoul of unused-but-set-variable and __udivdi3() warnings/errors on
32-bit kernels.

No functional change intended.

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
2.55.0.229.g6434b31f56-goog

