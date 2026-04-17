Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC0373BE7
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411137; cv=none; b=PzfHPhzO9mTuH1qpA555qM2krjv9lCVt1tp78RVJOeCbP0VMC1PWWVuCF1K9Kf776VUyWkSr82evhZJOJnaB3ioUx1vyFAm/0yBReZfYnlEaohfrAcNDAr6GvmFYbjUo4GbEUI3QxyysezMkCf7mpUUvfHSgwVeTtGVpdrewDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411137; c=relaxed/simple;
	bh=l2h+BywCxJjmTqw/sj4oxTXsnDqPsbWnrfZ3mUL33eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFkkG2VBPfKVUO5H9D8sA+UBgdx9Yfe6EFjgEp147rSh7UzrzAa6/s0EoY1hrcYxFzohU2ERT7BGmdjjXYVNZVswcDKJRvtxcPt+bXLfP6nWF0atSIHFD0RUL0HP30Jri8YWXuV66zRj/Ppk9HGCt4BltFGbuYaPrtZtW5TdvjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9LIDDjj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9LIDDjj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411136; x=1807947136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2h+BywCxJjmTqw/sj4oxTXsnDqPsbWnrfZ3mUL33eI=;
  b=f9LIDDjjcMu21ltCev0gD4Uc+vyf0Xzmb4N9phvyG+Zu/momqPIgeSM9
   DtEBVtZHhgdoYIoEHGxjcl8fga7xX63Yxg7PNfNIC5Hi1AR0hIe+7Reme
   G2Mr1jcCYLfh9iJ4BhgRYMN4wZU3YqmLLOw+Mu8WGaKrAAIlnbxpcC+fP
   R9wT1ALcG7SoL1ZUMf6kEvONG98aJpp6qIbGAcb+DjaGjlIC2ghxw2osW
   1C55tnAjptAjcraXcXUhz2DI2FF7YztdXgZKQBy2jwm1ZX0yZFAsD7C96
   c9F8WuuiZ9FxxvKYeFFE9/HCbZz8fj7Oc1mkrJZWOS3ooZcvIeHjQyhw8
   g==;
X-CSE-ConnectionGUID: 7lb24L5rRxiDcaZYrlwE8Q==
X-CSE-MsgGUID: w2mUUnSETYuKKdChFhgVfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070153"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070153"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:14 -0700
X-CSE-ConnectionGUID: cWrucZFNTzSTuG4PTrEgXQ==
X-CSE-MsgGUID: VB4qLlIORpSidOuttLnJcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284865"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:12 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 05/27] KVM: x86: Extend kvm_cpu_cap_{set/clear}() to configure overlays
Date: Fri, 17 Apr 2026 15:35:48 +0800
Message-ID: <20260417073610.3246316-6-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend kvm_cpu_cap_{set/clear}() for preparation to set/clear a CPU
feature bit for different overlays.

All callers use F_CPUID_DEFAULT to set/clear a capability for both
VMX and SVM overlays.

The effective overlay used is still CPUID_OL_DEFAULT (VMX overlay) for
all VM types.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c   | 36 ++++++++++++++++++------------------
 arch/x86/kvm/cpuid.h   | 18 ++++++++++++------
 arch/x86/kvm/svm/sev.c |  6 +++---
 arch/x86/kvm/svm/svm.c | 38 +++++++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c | 38 +++++++++++++++++++-------------------
 arch/x86/kvm/x86.c     |  4 ++--
 6 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d3f3e9f0d493..767c007ab5f0 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -992,7 +992,7 @@ void kvm_initialize_cpu_caps(void)
 	 * to be set on the host. Clear it if that is not the case
 	 */
 	if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
-		kvm_cpu_cap_clear(X86_FEATURE_PKU);
+		kvm_cpu_cap_clear(X86_FEATURE_PKU, F_CPUID_DEFAULT);
 
 	/*
 	 * Shadow Stacks aren't implemented in the Shadow MMU.  Shadow Stack
@@ -1000,7 +1000,7 @@ void kvm_initialize_cpu_caps(void)
 	 * doesn't know how to emulate or map.
 	 */
 	if (!tdp_enabled)
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_7_EDX,
 		/* Reserved, SGX_KEYS */
@@ -1036,18 +1036,18 @@ void kvm_initialize_cpu_caps(void)
 	 * SHSTK, nor does KVM handle Shadow Stack #PFs (see above).
 	 */
 	if (allow_smaller_maxphyaddr) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
 	}
 
 	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
 	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
 	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
-		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
+		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL, F_CPUID_DEFAULT);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
+		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP, F_CPUID_DEFAULT);
 	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
+		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_7_1_EAX,
 		F(SHA512, F_CPUID_DEFAULT),
@@ -1179,7 +1179,7 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
-		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
+		kvm_cpu_cap_set(X86_FEATURE_GBPAGES, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_8000_0007_EDX,
 		SCATTERED_F(CONSTANT_TSC, F_CPUID_DEFAULT),
@@ -1208,26 +1208,26 @@ void kvm_initialize_cpu_caps(void)
 	 * record that in cpufeatures so use them.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB, F_CPUID_DEFAULT);
 		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) &&
 		    !boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB))
-			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
+			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET, F_CPUID_DEFAULT);
 	}
 	if (boot_cpu_has(X86_FEATURE_IBRS))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS, F_CPUID_DEFAULT);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP, F_CPUID_DEFAULT);
 	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD, F_CPUID_DEFAULT);
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO, F_CPUID_DEFAULT);
 	/*
 	 * The preference is to use SPEC CTRL MSR instead of the
 	 * VIRT_SPEC MSR.
 	 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
+		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_DEFAULT);
 
 	/* All SVM features required additional vendor module enabling. */
 	kvm_cpu_cap_init(CPUID_8000_000A_EDX,
@@ -1296,7 +1296,7 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
+		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
 		F(XSTORE, F_CPUID_DEFAULT),
@@ -1322,8 +1322,8 @@ void kvm_initialize_cpu_caps(void)
 	if (WARN_ON((kvm_cpu_cap_has(X86_FEATURE_RDTSCP) ||
 		     kvm_cpu_cap_has(X86_FEATURE_RDPID)) &&
 		     !kvm_is_supported_user_return_msr(MSR_TSC_AUX))) {
-		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP);
-		kvm_cpu_cap_clear(X86_FEATURE_RDPID);
+		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
 	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_initialize_cpu_caps);
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index e87adecacd03..4b1274f055e5 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -219,20 +219,26 @@ static inline bool cpuid_fault_enabled(struct kvm_vcpu *vcpu)
 		  MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
 }
 
-static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
+static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature, u32 overlay_mask)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
 	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
-	kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] &= ~__feature_bit(x86_feature);
+	for (int i = 0; i < NR_CPUID_OL; i++) {
+		if (overlay_mask & BIT(i))
+			kvm_cpu_caps[i][x86_leaf] &= ~__feature_bit(x86_feature);
+	}
 }
 
-static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature)
+static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature, u32 overlay_mask)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
 	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
-	kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] |= __feature_bit(x86_feature);
+	for (int i = 0; i < NR_CPUID_OL; i++) {
+		if (overlay_mask & BIT(i))
+			kvm_cpu_caps[i][x86_leaf] |= __feature_bit(x86_feature);
+	}
 }
 
 static __always_inline u32 kvm_cpu_cap_get(unsigned int x86_feature)
@@ -247,10 +253,10 @@ static __always_inline bool kvm_cpu_cap_has(unsigned int x86_feature)
 	return !!kvm_cpu_cap_get(x86_feature);
 }
 
-static __always_inline void kvm_cpu_cap_check_and_set(unsigned int x86_feature)
+static __always_inline void kvm_cpu_cap_check_and_set(unsigned int x86_feature, u32 overlay_mask)
 {
 	if (boot_cpu_has(x86_feature))
-		kvm_cpu_cap_set(x86_feature);
+		kvm_cpu_cap_set(x86_feature, overlay_mask);
 }
 
 static __always_inline bool guest_pv_has(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..6ec9c806e1fb 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3014,15 +3014,15 @@ void sev_vm_destroy(struct kvm *kvm)
 void __init sev_set_cpu_caps(void)
 {
 	if (sev_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV);
+		kvm_cpu_cap_set(X86_FEATURE_SEV, F_CPUID_DEFAULT);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
 	}
 	if (sev_es_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV_ES);
+		kvm_cpu_cap_set(X86_FEATURE_SEV_ES, F_CPUID_DEFAULT);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
 	}
 	if (sev_snp_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP);
+		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP, F_CPUID_DEFAULT);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
 	}
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e7fdd7a9c280..7d1289f34f9f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5445,48 +5445,48 @@ static __init void svm_set_cpu_caps(void)
 
 	kvm_caps.supported_perf_cap = 0;
 
-	kvm_cpu_cap_clear(X86_FEATURE_IBT);
+	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
 
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
 	if (nested) {
-		kvm_cpu_cap_set(X86_FEATURE_SVM);
-		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN);
+		kvm_cpu_cap_set(X86_FEATURE_SVM, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN, F_CPUID_DEFAULT);
 
 		/*
 		 * KVM currently flushes TLBs on *every* nested SVM transition,
 		 * and so for all intents and purposes KVM supports flushing by
 		 * ASID, i.e. KVM is guaranteed to honor every L1 ASID flush.
 		 */
-		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID);
+		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID, F_CPUID_DEFAULT);
 
 		if (nrips)
-			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
+			kvm_cpu_cap_set(X86_FEATURE_NRIPS, F_CPUID_DEFAULT);
 
 		if (npt_enabled)
-			kvm_cpu_cap_set(X86_FEATURE_NPT);
+			kvm_cpu_cap_set(X86_FEATURE_NPT, F_CPUID_DEFAULT);
 
 		if (tsc_scaling)
-			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR);
+			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR, F_CPUID_DEFAULT);
 
 		if (vls)
-			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD);
+			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD, F_CPUID_DEFAULT);
 		if (lbrv)
-			kvm_cpu_cap_set(X86_FEATURE_LBRV);
+			kvm_cpu_cap_set(X86_FEATURE_LBRV, F_CPUID_DEFAULT);
 
 		if (boot_cpu_has(X86_FEATURE_PAUSEFILTER))
-			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER);
+			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER, F_CPUID_DEFAULT);
 
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
-			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD);
+			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD, F_CPUID_DEFAULT);
 
 		if (vgif)
-			kvm_cpu_cap_set(X86_FEATURE_VGIF);
+			kvm_cpu_cap_set(X86_FEATURE_VGIF, F_CPUID_DEFAULT);
 
 		if (vnmi)
-			kvm_cpu_cap_set(X86_FEATURE_VNMI);
+			kvm_cpu_cap_set(X86_FEATURE_VNMI, F_CPUID_DEFAULT);
 
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
-		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK);
+		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK, F_CPUID_DEFAULT);
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD))
@@ -5495,7 +5495,7 @@ static __init void svm_set_cpu_caps(void)
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
+		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_DEFAULT);
 
 	if (enable_pmu) {
 		/*
@@ -5507,11 +5507,11 @@ static __init void svm_set_cpu_caps(void)
 			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
 							  kvm_pmu_cap.num_counters_gp);
 		else
-			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
+			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE, F_CPUID_DEFAULT);
 
 		if (kvm_pmu_cap.version != 2 ||
 		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
-			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2);
+			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2, F_CPUID_DEFAULT);
 	}
 
 	/* CPUID 0x8000001F (SME/SEV features) */
@@ -5521,8 +5521,8 @@ static __init void svm_set_cpu_caps(void)
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
-	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_DEFAULT);
+	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_DEFAULT);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..7879a8a532c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8083,47 +8083,47 @@ static __init void vmx_set_cpu_caps(void)
 
 	/* CPUID 0x1 */
 	if (nested)
-		kvm_cpu_cap_set(X86_FEATURE_VMX);
+		kvm_cpu_cap_set(X86_FEATURE_VMX, F_CPUID_DEFAULT);
 
 	/* CPUID 0x7 */
 	if (kvm_mpx_supported())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX, F_CPUID_DEFAULT);
 	if (!cpu_has_vmx_invpcid())
-		kvm_cpu_cap_clear(X86_FEATURE_INVPCID);
+		kvm_cpu_cap_clear(X86_FEATURE_INVPCID, F_CPUID_DEFAULT);
 	if (vmx_pt_mode_is_host_guest())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT, F_CPUID_DEFAULT);
 	if (vmx_pebs_supported()) {
-		kvm_cpu_cap_check_and_set(X86_FEATURE_DS);
-		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DS, F_CPUID_DEFAULT);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64, F_CPUID_DEFAULT);
 	}
 
 	if (!enable_pmu)
-		kvm_cpu_cap_clear(X86_FEATURE_PDCM);
+		kvm_cpu_cap_clear(X86_FEATURE_PDCM, F_CPUID_DEFAULT);
 	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
 
 	if (!enable_sgx) {
-		kvm_cpu_cap_clear(X86_FEATURE_SGX);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX_LC);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX1);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX2);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX_EDECCSSA);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX_LC, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX1, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX2, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX_EDECCSSA, F_CPUID_DEFAULT);
 	}
 
 	if (vmx_umip_emulated())
-		kvm_cpu_cap_set(X86_FEATURE_UMIP);
+		kvm_cpu_cap_set(X86_FEATURE_UMIP, F_CPUID_DEFAULT);
 
 	/* CPUID 0xD.1 */
 	if (!cpu_has_vmx_xsaves())
-		kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
+		kvm_cpu_cap_clear(X86_FEATURE_XSAVES, F_CPUID_DEFAULT);
 
 	/* CPUID 0x80000001 and 0x7 (RDPID) */
 	if (!cpu_has_vmx_rdtscp()) {
-		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP);
-		kvm_cpu_cap_clear(X86_FEATURE_RDPID);
+		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
 	}
 
 	if (cpu_has_vmx_waitpkg())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG, F_CPUID_DEFAULT);
 
 	/*
 	 * Disable CET if unrestricted_guest is unsupported as KVM doesn't
@@ -8133,8 +8133,8 @@ static __init void vmx_set_cpu_caps(void)
 	 */
 	if (!cpu_has_load_cet_ctrl() || !enable_unrestricted_guest ||
 	    !cpu_has_vmx_basic_no_hw_errcode_cc()) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
 	}
 
 	kvm_setup_xss_caps();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..5b830997e693 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10024,8 +10024,8 @@ void kvm_setup_xss_caps(void)
 		kvm_caps.supported_xss &= ~XFEATURE_MASK_CET_ALL;
 
 	if ((kvm_caps.supported_xss & XFEATURE_MASK_CET_ALL) != XFEATURE_MASK_CET_ALL) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
 		kvm_caps.supported_xss &= ~XFEATURE_MASK_CET_ALL;
 	}
 }
-- 
2.46.0

