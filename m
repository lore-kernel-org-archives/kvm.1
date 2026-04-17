Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D54037475B
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411154; cv=none; b=ZJh7Fy3ZLE8F3iP9tIIRLf2lxnims+6IZaKnkhhWx4FTiGb4a/3a4FdX9Ll+xyDX9Enb2UlN/kmKA3acjhkErOwmhxuxQm/tZfJ/60G9z5q7Isiu3HalQvlCfT8mVoXILgXH+J9flJpAQsoldRn087wv0K3Ge2UkAAHBtT0aRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411154; c=relaxed/simple;
	bh=RPnANJ53q15CzFpNZGw78++TFAHEfXWUisFRZBG7c+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4oBBwDnjrPaGTQpv4R+B5YdX65ViWX3mY4D/7qZHvzdvyYwSBXQaD7ro7etx4M2CspfockPVaIh/2GacgCHKzbrJwrpuRq6ZPckzsipRz9IUR/T5DQlTsmycNPnsci/z09kf9Y7w4OPYQOS2veq44ALy2yyvZUgJ+gGDZb46vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaojuZQs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaojuZQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411153; x=1807947153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPnANJ53q15CzFpNZGw78++TFAHEfXWUisFRZBG7c+k=;
  b=MaojuZQsEwFYI8tWPCsjQ+Y9cdD4X6Q06J0+wm3EzR6ROY37iNNZaag8
   whS1lxdFya2CjFIXMeXdUIHo8yiWgU4r1bFsT7hrserxL1IfHOJyumkxR
   uCnaDfVLtgFiuInGCSElw4MIjkYNSbfT4LnzB2cxXV43XA4PnYDKkSsGj
   3N5AvrtLBSF/6bau1cxl5RNMf1SYNW6Sy6/nH/XfBxSMmF4m9X9lo1WNv
   b4pTKat2qmMoaTWEjnxu35z0HGqGDUzqvaUN+RoNpOwpY6fl2cet301wD
   BLn64qFG6PcEsbggu4xn5fd3smS+9lzMSbdjeYF9oUBP9GfbLdjEcZNdz
   g==;
X-CSE-ConnectionGUID: V+W5Z41zReyhNbAJYuR4oA==
X-CSE-MsgGUID: QymNHrJmSeiePm4LLxcjSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070190"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070190"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:25 -0700
X-CSE-ConnectionGUID: SVNyd0ZdR1iNGCTcZTTleg==
X-CSE-MsgGUID: B0GetUH2RnyV5ntrcRYHkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284920"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:23 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 10/27] KVM: x86: Use vendor-specific overlay flags instead of F_CPUID_DEFAULT
Date: Fri, 17 Apr 2026 15:35:53 +0800
Message-ID: <20260417073610.3246316-11-binbin.wu@linux.intel.com>
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

Use F_CPUID_VMX or F_CPUID_SVM instead of F_CPUID_DEFAULT when a feature
is vendor specific and the underlying hardware capability is not
checked. Also, use respective flags in vendor modules.

A feature initialized via F() and its variants in kvm_cpu_cap_init()
will check the host CPU capability or the raw CPUID, the feature can
only be set to the related overlay when the feature is supported by the
underlying hardware. Using F_CPUID_VMX or F_CPUID_SVM when a feature is
vendor specific makes the code more readable, however, it could
introduce regressions if a common feature is set only for one vendor.
For simplicity, just keep using F_CPUID_DEFAULT when the underlying
hardware capability will be checked.

Features initialized via kvm_cpu_cap_set(), EMULATED_F() doesn't check
the host CPU capability or the raw CPUID, use F_CPUID_VMX or
F_CPUID_SVM respectively if the feature is vendor specific.

In vendor modules, vendor flags are used respectively.

There are a few exceptions, i.e., IBT, BUS_LOCK_DETECT, and
MSR_IMM. They are common features for both vendors, but not supported
by SVM yet. Use F_CPUID_VMX instead of F_CPUID_DEFAULT for them.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c   | 30 +++++++++++++++---------------
 arch/x86/kvm/svm/sev.c |  6 +++---
 arch/x86/kvm/svm/svm.c | 38 +++++++++++++++++++-------------------
 arch/x86/kvm/vmx/vmx.c | 36 ++++++++++++++++++------------------
 4 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2c4e64aa14c4..71959f4918e7 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -983,7 +983,7 @@ void kvm_initialize_cpu_caps(void)
 		/* MPX_MAWAU */
 		F(RDPID, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* KEY_LOCKER */
-		F(BUS_LOCK_DETECT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(BUS_LOCK_DETECT, F_CPUID_VMX | F_CPUID_TDX),
 		F(CLDEMOTE, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
 		F(MOVDIRI, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1022,7 +1022,7 @@ void kvm_initialize_cpu_caps(void)
 		/* HYBRID_CPU */
 		F(TSXLDTRK, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved, PCONFIG, ARCH_LBR */
-		F(IBT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(IBT, F_CPUID_VMX | F_CPUID_TDX),
 		/* Reserved */
 		F(AMX_BF16, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(AVX512_FP16, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1049,11 +1049,11 @@ void kvm_initialize_cpu_caps(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
 	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
 	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
-		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL, F_CPUID_SVM);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP, F_CPUID_VMX);
 	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_SVM);
 
 	kvm_cpu_cap_init(CPUID_7_1_EAX,
 		F(SHA512, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1075,7 +1075,7 @@ void kvm_initialize_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_7_1_ECX,
 		/* MSR_IMM is reserved in TDX spec */
-		SCATTERED_F(MSR_IMM, F_CPUID_DEFAULT),
+		SCATTERED_F(MSR_IMM, F_CPUID_VMX),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_1_EDX,
@@ -1217,26 +1217,26 @@ void kvm_initialize_cpu_caps(void)
 	 * record that in cpufeatures so use them.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
-		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB, F_CPUID_SVM);
 		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) &&
 		    !boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB))
-			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET, F_CPUID_SVM);
 	}
 	if (boot_cpu_has(X86_FEATURE_IBRS))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS, F_CPUID_SVM);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_STIBP, F_CPUID_SVM);
 	if (boot_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_SSBD, F_CPUID_SVM);
 	if (!boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
-		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_SSB_NO, F_CPUID_SVM);
 	/*
 	 * The preference is to use SPEC CTRL MSR instead of the
 	 * VIRT_SPEC MSR.
 	 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_SVM);
 
 	/* All SVM features required additional vendor module enabling. */
 	kvm_cpu_cap_init(CPUID_8000_000A_EDX,
@@ -1282,7 +1282,7 @@ void kvm_initialize_cpu_caps(void)
 		F(NULL_SEL_CLR_BASE, F_CPUID_DEFAULT),
 		/* UpperAddressIgnore */
 		F(AUTOIBRS, F_CPUID_DEFAULT),
-		EMULATED_F(NO_SMM_CTL_MSR, F_CPUID_DEFAULT),
+		EMULATED_F(NO_SMM_CTL_MSR, F_CPUID_SVM),
 		/* PrefetchCtlMsr */
 		/* GpOnUserCpuid */
 		/* EPSF */
@@ -1305,7 +1305,7 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE, F_CPUID_SVM);
 
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
 		F(XSTORE, F_CPUID_DEFAULT),
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 6ec9c806e1fb..4b10d63a095a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3014,15 +3014,15 @@ void sev_vm_destroy(struct kvm *kvm)
 void __init sev_set_cpu_caps(void)
 {
 	if (sev_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SEV, F_CPUID_SVM);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_VM);
 	}
 	if (sev_es_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV_ES, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SEV_ES, F_CPUID_SVM);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SEV_ES_VM);
 	}
 	if (sev_snp_enabled) {
-		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SEV_SNP, F_CPUID_SVM);
 		kvm_caps.supported_vm_types |= BIT(KVM_X86_SNP_VM);
 	}
 }
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2b4a17536580..a21c500e1a91 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5445,48 +5445,48 @@ static __init void svm_set_cpu_caps(void)
 
 	kvm_caps.supported_perf_cap = 0;
 
-	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
+	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_SVM);
 
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
 	if (nested) {
-		kvm_cpu_cap_set(X86_FEATURE_SVM, F_CPUID_DEFAULT);
-		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SVM, F_CPUID_SVM);
+		kvm_cpu_cap_set(X86_FEATURE_VMCBCLEAN, F_CPUID_SVM);
 
 		/*
 		 * KVM currently flushes TLBs on *every* nested SVM transition,
 		 * and so for all intents and purposes KVM supports flushing by
 		 * ASID, i.e. KVM is guaranteed to honor every L1 ASID flush.
 		 */
-		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_FLUSHBYASID, F_CPUID_SVM);
 
 		if (nrips)
-			kvm_cpu_cap_set(X86_FEATURE_NRIPS, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_NRIPS, F_CPUID_SVM);
 
 		if (npt_enabled)
-			kvm_cpu_cap_set(X86_FEATURE_NPT, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_NPT, F_CPUID_SVM);
 
 		if (tsc_scaling)
-			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_TSCRATEMSR, F_CPUID_SVM);
 
 		if (vls)
-			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_V_VMSAVE_VMLOAD, F_CPUID_SVM);
 		if (lbrv)
-			kvm_cpu_cap_set(X86_FEATURE_LBRV, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_LBRV, F_CPUID_SVM);
 
 		if (boot_cpu_has(X86_FEATURE_PAUSEFILTER))
-			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_PAUSEFILTER, F_CPUID_SVM);
 
 		if (boot_cpu_has(X86_FEATURE_PFTHRESHOLD))
-			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_PFTHRESHOLD, F_CPUID_SVM);
 
 		if (vgif)
-			kvm_cpu_cap_set(X86_FEATURE_VGIF, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_VGIF, F_CPUID_SVM);
 
 		if (vnmi)
-			kvm_cpu_cap_set(X86_FEATURE_VNMI, F_CPUID_DEFAULT);
+			kvm_cpu_cap_set(X86_FEATURE_VNMI, F_CPUID_SVM);
 
 		/* Nested VM can receive #VMEXIT instead of triggering #GP */
-		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_SVME_ADDR_CHK, F_CPUID_SVM);
 	}
 
 	if (cpu_feature_enabled(X86_FEATURE_BUS_LOCK_THRESHOLD))
@@ -5495,7 +5495,7 @@ static __init void svm_set_cpu_caps(void)
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
-		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_SVM);
 
 	if (enable_pmu) {
 		/*
@@ -5507,11 +5507,11 @@ static __init void svm_set_cpu_caps(void)
 			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
 							  kvm_pmu_cap.num_counters_gp);
 		else
-			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE, F_CPUID_DEFAULT);
+			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE, F_CPUID_SVM);
 
 		if (kvm_pmu_cap.version != 2 ||
 		    !kvm_cpu_cap_has(NULL, X86_FEATURE_PERFCTR_CORE))
-			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2, F_CPUID_DEFAULT);
+			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2, F_CPUID_SVM);
 	}
 
 	/* CPUID 0x8000001F (SME/SEV features) */
@@ -5521,8 +5521,8 @@ static __init void svm_set_cpu_caps(void)
 	 * Clear capabilities that are automatically configured by common code,
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_DEFAULT);
-	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_DEFAULT);
+	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_SVM);
+	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_SVM);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d6d32f3d162b..f772558758f7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8086,55 +8086,55 @@ static __init void vmx_set_cpu_caps(void)
 
 	/* CPUID 0x1 */
 	if (nested)
-		kvm_cpu_cap_set(X86_FEATURE_VMX, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_VMX, F_CPUID_VMX);
 
 	/* CPUID 0x7 */
 	/* MPX is fixed-0 for TDX */
 	if (kvm_mpx_supported())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX, F_CPUID_DEFAULT);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX, F_CPUID_VMX);
 	/* INVPCID is fixed-1 for TDX */
 	if (!cpu_has_vmx_invpcid())
-		kvm_cpu_cap_clear(X86_FEATURE_INVPCID, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_INVPCID, F_CPUID_VMX);
 	/* KVM doesn't support PT for TDX yet */
 	if (vmx_pt_mode_is_host_guest())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT, F_CPUID_DEFAULT);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT, F_CPUID_VMX);
 
 	/* DS and DTES64 are fixed-1 for TDX */
-	enable_mask = vmx_pebs_supported() ? F_CPUID_TDX | F_CPUID_DEFAULT : F_CPUID_TDX;
+	enable_mask = vmx_pebs_supported() ? F_CPUID_TDX | F_CPUID_VMX : F_CPUID_TDX;
 	kvm_cpu_cap_check_and_set(X86_FEATURE_DS, enable_mask);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64, enable_mask);
 
 	/* PDCM is fixed-1 for TDX */
 	if (!enable_pmu)
-		kvm_cpu_cap_clear(X86_FEATURE_PDCM, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_PDCM, F_CPUID_VMX);
 	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
 
 	/* SGX related features are fixed-0 for TDX */
 	if (!enable_sgx) {
-		kvm_cpu_cap_clear(X86_FEATURE_SGX, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX_LC, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX1, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX2, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_SGX_EDECCSSA, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX, F_CPUID_VMX);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX_LC, F_CPUID_VMX);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX1, F_CPUID_VMX);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX2, F_CPUID_VMX);
+		kvm_cpu_cap_clear(X86_FEATURE_SGX_EDECCSSA, F_CPUID_VMX);
 	}
 
 	if (vmx_umip_emulated())
-		kvm_cpu_cap_set(X86_FEATURE_UMIP, F_CPUID_DEFAULT);
+		kvm_cpu_cap_set(X86_FEATURE_UMIP, F_CPUID_VMX);
 
 	/* CPUID 0xD.1 */
 	/* XSAVES is fixed-1 for TDX */
 	if (!cpu_has_vmx_xsaves())
-		kvm_cpu_cap_clear(X86_FEATURE_XSAVES, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_XSAVES, F_CPUID_VMX);
 
 	/* CPUID 0x80000001 and 0x7 (RDPID) */
 	if (!cpu_has_vmx_rdtscp()) {
-		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_VMX);
+		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_VMX);
 	}
 
 	/* KVM doesn't support WAITPKG for TDX yet */
 	if (cpu_has_vmx_waitpkg())
-		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG, F_CPUID_DEFAULT);
+		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG, F_CPUID_VMX);
 
 	/*
 	 * Disable CET if unrestricted_guest is unsupported as KVM doesn't
@@ -8144,8 +8144,8 @@ static __init void vmx_set_cpu_caps(void)
 	 */
 	if (!cpu_has_load_cet_ctrl() || !enable_unrestricted_guest ||
 	    !cpu_has_vmx_basic_no_hw_errcode_cc()) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT | F_CPUID_TDX);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_VMX | F_CPUID_TDX);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_VMX | F_CPUID_TDX);
 	}
 
 	kvm_setup_xss_caps();
-- 
2.46.0

