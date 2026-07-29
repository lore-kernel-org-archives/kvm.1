Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36E4A2E1E
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332528; cv=none; b=LH4zqV5G3h1L19nj0lYuBOZyEF5liVANP4IBg32GszGRuvx2RSGxUrc0j++Ghm8Y1MXXB5GsTKrQPFqbDYllZZys7pl/YJYFdLjQwe6AWOEzVgOqCU8fCKlFU3k2583hdmMMIPcG52OjFJ1EBA9rXB0v3l6rratP+sZm7QS17D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332528; c=relaxed/simple;
	bh=o2ocT60TqyLBSaChb6lnTEX8NzfmnirNcjWOf+Ovk2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JFpDWN6MYPb6RqnfQfCwShEaaZ9QOkkSXb19yurWvLZBNJqB2lSrud6z+w+6JOw+SiLBoPwPgaXJGrrR20obFW5z6ZoTXC0vWaBSR6UIpMQDG16v/md5US29dExRq3iId8SYPiXoX1CCnnYxfwx30h4PCyb6+zWBPPAU0/MO18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km1ApLMH; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km1ApLMH"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso860557a91.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 06:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332526; x=1785937326; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ewml3mFJDfijxONZ/2DyTZEGxGavy7PkGMgGYY5kjrM=;
        b=km1ApLMHzIOmXkTlXXgFtqrPIGGl1BRdFy9z2VusJdWxopuouEXPdacVyr7/1spXbc
         h1IE6vTpJltjIwwdS5py6MVn3euNxHKVeURxatkMjwGMjtRr1yEp2Ly5XUt+5Kt4s4rN
         mizeaXBheAuzZ2aoS4ai2B+K78ciS0l+tgvkAp6vCzN7sj66U5ROo+U5jEBjCIwmkG/U
         AgXuf1+Gc/qafiYEK8tSrbw2IkGent2fmdG42FxQV5OiFfK8jFs5JVgq69PhKPkrjvu7
         0UIT/gmclbJPn6VZB4sUWjj1ifzEMJ5lWCYn/eNDmKzjqq5VeWtnAbOZFE68dox0eHGg
         c9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332526; x=1785937326;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ewml3mFJDfijxONZ/2DyTZEGxGavy7PkGMgGYY5kjrM=;
        b=gzAkKCoUrvPTXkzBLwEsDXh8MKRM0C2E9TXe5ZqY0blj+VP20GvJRBs/GvJAIcpoPD
         CDgT+HQI3EThhiTBiEm3cf710P6ZVGJ/6aZBu3xUKrLsyK0pTJknvtjUqyGCFxlLGnjO
         lVJKNMWC9eW4DguQ8tYBVHO/PlLwxq1ZpizC7+Q0M8XQViX1e2ONkRDt7aSGUH/o9biB
         Vpv+zBBipaQBUigGURzuj3QcbgFSE98UGV6dbbfP4mZKJabn51p0SK+Uxe7DiAmaJGuh
         M1sEMJfIXIcAbM6z0SmUtBQWrAEab5oEVnoJmZgK0exmihRLoAJPHDlZ8De8QZrrlcsd
         lZkg==
X-Gm-Message-State: AOJu0Yw+tyFi8if9wYA9wpWUVtZsOo9//n9+vYejY2eKpnRheXQmttms
	FEMoJzN5gEekL8wNKQ73GUoBoYx7l1qjkAIJJeax2+Yl8PCKpe6su7tMMuReC/q4VfweyXGyVM/
	F+DyD8g==
X-Received: from pjkx20.prod.google.com ([2002:a17:90a:7894:b0:37c:c540:67c4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c0f:b0:37f:a915:1c29
 with SMTP id 98e67ed59e1d1-38f6a498a00mr6558309a91.19.1785332526337; Wed, 29
 Jul 2026 06:42:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 29 Jul 2026 06:42:02 -0700
In-Reply-To: <20260729134203.1377606-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260729134203.1377606-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.487.gaf234c4eb3-goog
Message-ID: <20260729134203.1377606-2-seanjc@google.com>
Subject: [PATCH v6 1/2] KVM: VMX: Bury all of the VMX preemption timer code
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
2.55.0.487.gaf234c4eb3-goog

