Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D037475B
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411135; cv=none; b=H5NwzqIzxQJ7JUe6K5HtffcXl5W1CzFHgxaQzhcXgd+vCFgNze/zTC5qkvGteU7Lwn+uH0PlRCXoW3cvpy88RvI6V+40+FhHQIAlv+Ewdhvlh9m4D9mJZm3pgIDk4RY4bI/c18B/zgWnrfqa995UUuaLuM52zv9pajcGWC/MTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411135; c=relaxed/simple;
	bh=OoGl2s0c2CY2xHyRbS7lt3wh5uA8JvxlrZQ2WtDOmyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ntnz7iLkL0pve32/dgnEeqpw31z04kemONQKv8nLs+TlFy3sJu5b+A4yQ8+MO4IaHOMOyt3h99QMHT/m/ORhQzp88yROLa9xr9FbPLfiAa2wyLu0wHzWdbPKf0y2ZQdfOViixamySUcoQNIMbA8AofnnW6DucqstURB+sHVTYgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LimUgOSC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LimUgOSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411134; x=1807947134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OoGl2s0c2CY2xHyRbS7lt3wh5uA8JvxlrZQ2WtDOmyI=;
  b=LimUgOSCYyWMr1i+mkx/jmlD/fDSis59bG6VuptUJVd7pwTXPmEnle7I
   zP56OWCt0uiFPz1oVqougDfIF7X0SUEHysNDy0IU1O9Ll8mYiE49WcCnA
   7oYjgn9zgkOV2UkaLWJhtX09L36jaIGwyC9kf1G1yfyzJeiD/qCiV8qz6
   sDShBNt68B1QlvrMCy7ON+iFNGOAc+AXyVkptXzQ03ISMLxex+kdL7sqn
   8jr0AudK7cxjowGo6d4PjaRp82BD4w038TEsyV1PjAmkOr4yC02aw2V16
   Zttru8Wky9Y8PynedMFecLx3YJm3ZYol4LJyrYQ+L6XjJngEJ50kWiH9s
   A==;
X-CSE-ConnectionGUID: 9c9TBgA8RaqNhvuVZA5uog==
X-CSE-MsgGUID: kzVDHaBLSv2kDADVeKrrjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070133"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070133"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:12 -0700
X-CSE-ConnectionGUID: +oWmokmqT9iHTGPhCmtfCg==
X-CSE-MsgGUID: z88BFyLrS5OW9xF0N3BvGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284854"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:09 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 04/27] KVM: x86: Extend F() and its variants for CPUID overlays
Date: Fri, 17 Apr 2026 15:35:47 +0800
Message-ID: <20260417073610.3246316-5-binbin.wu@linux.intel.com>
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

Change kvm_cpu_caps[] to a 2D array and extend F() and its variants
for preparation to accommodate capabilities for different CPUID overlays.

Use F_CPUID_DEFAULT to set the capabilities for both VMX and SVM
overlays, and define the temporary CPUID_OL_DEFAULT to be the effective
overlay that is actually VMX overlay, which equals to the original
version of kvm_cpu_caps[].

It's a bit weird to use CPUID_OL_DEFAULT, which is VMX overlay, in
ALIASED_1_EDX_F() for the SVM only features, but there is no
functional change since CPUID_OL_DEFAULT is used for all VM types.

VENDOR_F() and RUNTIME_F() don't actually set any capability, keep them
as what they are.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 498 ++++++++++++++++++++++---------------------
 arch/x86/kvm/cpuid.h |  16 +-
 2 files changed, 264 insertions(+), 250 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 056f86121728..d3f3e9f0d493 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -33,7 +33,7 @@
  * Unlike "struct cpuinfo_x86.x86_capability", kvm_cpu_caps doesn't need to be
  * aligned to sizeof(unsigned long) because it's not accessed via bitops.
  */
-u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
+u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS] __read_mostly;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_caps);
 
 bool kvm_is_configuring_cpu_caps __read_mostly;
@@ -404,7 +404,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		 * in guest CPUID.  Note, this includes features that are
 		 * supported by KVM but aren't advertised to userspace!
 		 */
-		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[i];
+		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[CPUID_OL_DEFAULT][i];
 		if (!cpuid.index) {
 			cpuid_func_emulated(&emulated, cpuid.function, true);
 			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
@@ -713,15 +713,18 @@ do {									\
 									\
 	feature_initializers						\
 									\
-	kvm_cpu_caps[leaf] = kvm_cpu_cap_features;			\
+	/* Handle the tailing comma compiler errors */			\
+	(void)kvm_cpu_cap_features;					\
 									\
 	if (leaf < NCAPINTS)						\
-		kvm_cpu_caps[leaf] &= kernel_cpu_caps[leaf];		\
+		kvm_cpu_cap_features &= kernel_cpu_caps[leaf];		\
 									\
-	kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;			\
-	kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |			\
-			       kvm_cpu_cap_synthesized);		\
-	kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;			\
+	kvm_cpu_cap_features |= kvm_cpu_cap_passthrough;		\
+	kvm_cpu_cap_features &= (raw_cpuid_get(cpuid) |			\
+				 kvm_cpu_cap_synthesized);		\
+	kvm_cpu_cap_features |= kvm_cpu_cap_emulated;			\
+	for (int i = 0; i < NR_CPUID_OL; i++)				\
+		kvm_cpu_caps[i][leaf] &= kvm_cpu_cap_features;		\
 } while (0)
 
 /*
@@ -736,37 +739,43 @@ do {									\
 	BUILD_BUG_ON(__leaf != kvm_cpu_cap_init_in_progress);		\
 } while (0)
 
-#define F(name)							\
-({								\
-	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
-	kvm_cpu_cap_features |= feature_bit(name);		\
+#define F(name, overlay_mask)						\
+({									\
+	u32 __leaf = __feature_leaf(X86_FEATURE_##name);		\
+									\
+	KVM_VALIDATE_CPU_CAP_USAGE(name);				\
+	kvm_cpu_cap_features |= feature_bit(name);			\
+	for (int i = 0; i < NR_CPUID_OL; i++) {				\
+		if ((overlay_mask) & BIT(i))				\
+			kvm_cpu_caps[i][__leaf] |= feature_bit(name);	\
+	}								\
 })
 
 /* Scattered Flag - For features that are scattered by cpufeatures.h. */
-#define SCATTERED_F(name)					\
+#define SCATTERED_F(name, overlay_mask)				\
 ({								\
 	BUILD_BUG_ON(X86_FEATURE_##name >= MAX_CPU_FEATURES);	\
 	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
 	if (boot_cpu_has(X86_FEATURE_##name))			\
-		F(name);					\
+		F(name, overlay_mask);				\
 })
 
 /* Features that KVM supports only on 64-bit kernels. */
-#define X86_64_F(name)						\
+#define X86_64_F(name, overlay_mask)				\
 ({								\
 	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
 	if (IS_ENABLED(CONFIG_X86_64))				\
-		F(name);					\
+		F(name, overlay_mask);				\
 })
 
 /*
  * Emulated Feature - For features that KVM emulates in software irrespective
  * of host CPU/kernel support.
  */
-#define EMULATED_F(name)					\
+#define EMULATED_F(name, overlay_mask)				\
 ({								\
 	kvm_cpu_cap_emulated |= feature_bit(name);		\
-	F(name);						\
+	F(name, overlay_mask);					\
 })
 
 /*
@@ -774,13 +783,13 @@ do {									\
  * i.e. may not be present in the raw CPUID, but can still be advertised to
  * userspace.  Primarily used for mitigation related feature flags.
  */
-#define SYNTHESIZED_F(name)					\
+#define SYNTHESIZED_F(name, overlay_mask)			\
 ({								\
 	kvm_cpu_cap_synthesized |= feature_bit(name);		\
 								\
 	BUILD_BUG_ON(X86_FEATURE_##name >= MAX_CPU_FEATURES);	\
 	if (boot_cpu_has(X86_FEATURE_##name))			\
-		F(name);					\
+		F(name, overlay_mask);				\
 })
 
 /*
@@ -789,21 +798,22 @@ do {									\
  * use the feature.  Simply force set the feature in KVM's capabilities, raw
  * CPUID support will be factored in by kvm_cpu_cap_mask().
  */
-#define PASSTHROUGH_F(name)					\
+#define PASSTHROUGH_F(name, overlay_mask)			\
 ({								\
 	kvm_cpu_cap_passthrough |= feature_bit(name);		\
-	F(name);						\
+	F(name, overlay_mask);					\
 })
 
 /*
  * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
  * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
  */
-#define ALIASED_1_EDX_F(name)							\
-({										\
-	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);	\
-	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);	\
-	kvm_cpu_cap_features |= feature_bit(name);				\
+#define ALIASED_1_EDX_F(name)								\
+({											\
+	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);		\
+	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);		\
+	kvm_cpu_cap_features |= feature_bit(name);					\
+	kvm_cpu_caps[CPUID_OL_DEFAULT][CPUID_8000_0001_EDX] |= feature_bit(name);	\
 })
 
 /*
@@ -840,12 +850,12 @@ void kvm_initialize_cpu_caps(void)
 	WARN_ON_ONCE(kvm_is_configuring_cpu_caps);
 	kvm_is_configuring_cpu_caps = true;
 
-	BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
+	BUILD_BUG_ON(sizeof(kvm_cpu_caps)/NR_CPUID_OL - (NKVMCAPINTS * sizeof(**kvm_cpu_caps)) >
 		     sizeof(boot_cpu_data.x86_capability));
 
 	kvm_cpu_cap_init(CPUID_1_ECX,
-		F(XMM3),
-		F(PCLMULQDQ),
+		F(XMM3, F_CPUID_DEFAULT),
+		F(PCLMULQDQ, F_CPUID_DEFAULT),
 		VENDOR_F(DTES64),
 		/*
 		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
@@ -858,122 +868,122 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(VMX),
 		/* SMX, EST */
 		/* TM2 */
-		F(SSSE3),
+		F(SSSE3, F_CPUID_DEFAULT),
 		/* CNXT-ID */
 		/* Reserved */
-		F(FMA),
-		F(CX16),
+		F(FMA, F_CPUID_DEFAULT),
+		F(CX16, F_CPUID_DEFAULT),
 		/* xTPR Update */
-		F(PDCM),
-		F(PCID),
+		F(PDCM, F_CPUID_DEFAULT),
+		F(PCID, F_CPUID_DEFAULT),
 		/* Reserved, DCA */
-		F(XMM4_1),
-		F(XMM4_2),
-		EMULATED_F(X2APIC),
-		F(MOVBE),
-		F(POPCNT),
-		EMULATED_F(TSC_DEADLINE_TIMER),
-		F(AES),
-		F(XSAVE),
+		F(XMM4_1, F_CPUID_DEFAULT),
+		F(XMM4_2, F_CPUID_DEFAULT),
+		EMULATED_F(X2APIC, F_CPUID_DEFAULT),
+		F(MOVBE, F_CPUID_DEFAULT),
+		F(POPCNT, F_CPUID_DEFAULT),
+		EMULATED_F(TSC_DEADLINE_TIMER, F_CPUID_DEFAULT),
+		F(AES, F_CPUID_DEFAULT),
+		F(XSAVE, F_CPUID_DEFAULT),
 		RUNTIME_F(OSXSAVE),
-		F(AVX),
-		F(F16C),
-		F(RDRAND),
-		EMULATED_F(HYPERVISOR),
+		F(AVX, F_CPUID_DEFAULT),
+		F(F16C, F_CPUID_DEFAULT),
+		F(RDRAND, F_CPUID_DEFAULT),
+		EMULATED_F(HYPERVISOR, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_1_EDX,
-		F(FPU),
-		F(VME),
-		F(DE),
-		F(PSE),
-		F(TSC),
-		F(MSR),
-		F(PAE),
-		F(MCE),
-		F(CX8),
-		F(APIC),
+		F(FPU, F_CPUID_DEFAULT),
+		F(VME, F_CPUID_DEFAULT),
+		F(DE, F_CPUID_DEFAULT),
+		F(PSE, F_CPUID_DEFAULT),
+		F(TSC, F_CPUID_DEFAULT),
+		F(MSR, F_CPUID_DEFAULT),
+		F(PAE, F_CPUID_DEFAULT),
+		F(MCE, F_CPUID_DEFAULT),
+		F(CX8, F_CPUID_DEFAULT),
+		F(APIC, F_CPUID_DEFAULT),
 		/* Reserved */
-		F(SEP),
-		F(MTRR),
-		F(PGE),
-		F(MCA),
-		F(CMOV),
-		F(PAT),
-		F(PSE36),
+		F(SEP, F_CPUID_DEFAULT),
+		F(MTRR, F_CPUID_DEFAULT),
+		F(PGE, F_CPUID_DEFAULT),
+		F(MCA, F_CPUID_DEFAULT),
+		F(CMOV, F_CPUID_DEFAULT),
+		F(PAT, F_CPUID_DEFAULT),
+		F(PSE36, F_CPUID_DEFAULT),
 		/* PSN */
-		F(CLFLUSH),
+		F(CLFLUSH, F_CPUID_DEFAULT),
 		/* Reserved */
 		VENDOR_F(DS),
 		/* ACPI */
-		F(MMX),
-		F(FXSR),
-		F(XMM),
-		F(XMM2),
-		F(SELFSNOOP),
+		F(MMX, F_CPUID_DEFAULT),
+		F(FXSR, F_CPUID_DEFAULT),
+		F(XMM, F_CPUID_DEFAULT),
+		F(XMM2, F_CPUID_DEFAULT),
+		F(SELFSNOOP, F_CPUID_DEFAULT),
 		/* HTT, TM, Reserved, PBE */
 	);
 
 	kvm_cpu_cap_init(CPUID_7_0_EBX,
-		F(FSGSBASE),
-		EMULATED_F(TSC_ADJUST),
-		F(SGX),
-		F(BMI1),
-		F(HLE),
-		F(AVX2),
-		F(FDP_EXCPTN_ONLY),
-		F(SMEP),
-		F(BMI2),
-		F(ERMS),
-		F(INVPCID),
-		F(RTM),
-		F(ZERO_FCS_FDS),
+		F(FSGSBASE, F_CPUID_DEFAULT),
+		EMULATED_F(TSC_ADJUST, F_CPUID_DEFAULT),
+		F(SGX, F_CPUID_DEFAULT),
+		F(BMI1, F_CPUID_DEFAULT),
+		F(HLE, F_CPUID_DEFAULT),
+		F(AVX2, F_CPUID_DEFAULT),
+		F(FDP_EXCPTN_ONLY, F_CPUID_DEFAULT),
+		F(SMEP, F_CPUID_DEFAULT),
+		F(BMI2, F_CPUID_DEFAULT),
+		F(ERMS, F_CPUID_DEFAULT),
+		F(INVPCID, F_CPUID_DEFAULT),
+		F(RTM, F_CPUID_DEFAULT),
+		F(ZERO_FCS_FDS, F_CPUID_DEFAULT),
 		VENDOR_F(MPX),
-		F(AVX512F),
-		F(AVX512DQ),
-		F(RDSEED),
-		F(ADX),
-		F(SMAP),
-		F(AVX512IFMA),
-		F(CLFLUSHOPT),
-		F(CLWB),
+		F(AVX512F, F_CPUID_DEFAULT),
+		F(AVX512DQ, F_CPUID_DEFAULT),
+		F(RDSEED, F_CPUID_DEFAULT),
+		F(ADX, F_CPUID_DEFAULT),
+		F(SMAP, F_CPUID_DEFAULT),
+		F(AVX512IFMA, F_CPUID_DEFAULT),
+		F(CLFLUSHOPT, F_CPUID_DEFAULT),
+		F(CLWB, F_CPUID_DEFAULT),
 		VENDOR_F(INTEL_PT),
-		F(AVX512PF),
-		F(AVX512ER),
-		F(AVX512CD),
-		F(SHA_NI),
-		F(AVX512BW),
-		F(AVX512VL),
+		F(AVX512PF, F_CPUID_DEFAULT),
+		F(AVX512ER, F_CPUID_DEFAULT),
+		F(AVX512CD, F_CPUID_DEFAULT),
+		F(SHA_NI, F_CPUID_DEFAULT),
+		F(AVX512BW, F_CPUID_DEFAULT),
+		F(AVX512VL, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_ECX,
 		/* PREFETCHWT1 */
-		F(AVX512VBMI),
-		F(UMIP),
-		F(PKU),
+		F(AVX512VBMI, F_CPUID_DEFAULT),
+		F(UMIP, F_CPUID_DEFAULT),
+		F(PKU, F_CPUID_DEFAULT),
 		RUNTIME_F(OSPKE),
 		VENDOR_F(WAITPKG),
-		F(AVX512_VBMI2),
-		X86_64_F(SHSTK),
-		F(GFNI),
-		F(VAES),
-		F(VPCLMULQDQ),
-		F(AVX512_VNNI),
-		F(AVX512_BITALG),
+		F(AVX512_VBMI2, F_CPUID_DEFAULT),
+		X86_64_F(SHSTK, F_CPUID_DEFAULT),
+		F(GFNI, F_CPUID_DEFAULT),
+		F(VAES, F_CPUID_DEFAULT),
+		F(VPCLMULQDQ, F_CPUID_DEFAULT),
+		F(AVX512_VNNI, F_CPUID_DEFAULT),
+		F(AVX512_BITALG, F_CPUID_DEFAULT),
 		/* TME */
-		F(AVX512_VPOPCNTDQ),
+		F(AVX512_VPOPCNTDQ, F_CPUID_DEFAULT),
 		/* Reserved */
-		PASSTHROUGH_F(LA57),
+		PASSTHROUGH_F(LA57, F_CPUID_DEFAULT),
 		/* MPX_MAWAU */
-		F(RDPID),
+		F(RDPID, F_CPUID_DEFAULT),
 		/* KEY_LOCKER */
-		F(BUS_LOCK_DETECT),
-		F(CLDEMOTE),
+		F(BUS_LOCK_DETECT, F_CPUID_DEFAULT),
+		F(CLDEMOTE, F_CPUID_DEFAULT),
 		/* Reserved */
-		F(MOVDIRI),
-		F(MOVDIR64B),
+		F(MOVDIRI, F_CPUID_DEFAULT),
+		F(MOVDIR64B, F_CPUID_DEFAULT),
 		/* ENQCMD */
-		F(SGX_LC),
+		F(SGX_LC, F_CPUID_DEFAULT),
 		/* PKS */
 	);
 
@@ -994,30 +1004,30 @@ void kvm_initialize_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_7_EDX,
 		/* Reserved, SGX_KEYS */
-		F(AVX512_4VNNIW),
-		F(AVX512_4FMAPS),
-		F(FSRM),
+		F(AVX512_4VNNIW, F_CPUID_DEFAULT),
+		F(AVX512_4FMAPS, F_CPUID_DEFAULT),
+		F(FSRM, F_CPUID_DEFAULT),
 		/* UINT, Reserved, Reserved */
-		F(AVX512_VP2INTERSECT),
+		F(AVX512_VP2INTERSECT, F_CPUID_DEFAULT),
 		/* SRBDS_CTRL */
-		F(MD_CLEAR),
+		F(MD_CLEAR, F_CPUID_DEFAULT),
 		/* RTM_ALWAYS_ABORT, Reserved, TSX_FORCE_ABORT */
-		F(SERIALIZE),
+		F(SERIALIZE, F_CPUID_DEFAULT),
 		/* HYBRID_CPU */
-		F(TSXLDTRK),
+		F(TSXLDTRK, F_CPUID_DEFAULT),
 		/* Reserved, PCONFIG, ARCH_LBR */
-		F(IBT),
+		F(IBT, F_CPUID_DEFAULT),
 		/* Reserved */
-		F(AMX_BF16),
-		F(AVX512_FP16),
-		F(AMX_TILE),
-		F(AMX_INT8),
-		F(SPEC_CTRL),
-		F(INTEL_STIBP),
-		F(FLUSH_L1D),
-		EMULATED_F(ARCH_CAPABILITIES),
+		F(AMX_BF16, F_CPUID_DEFAULT),
+		F(AVX512_FP16, F_CPUID_DEFAULT),
+		F(AMX_TILE, F_CPUID_DEFAULT),
+		F(AMX_INT8, F_CPUID_DEFAULT),
+		F(SPEC_CTRL, F_CPUID_DEFAULT),
+		F(INTEL_STIBP, F_CPUID_DEFAULT),
+		F(FLUSH_L1D, F_CPUID_DEFAULT),
+		EMULATED_F(ARCH_CAPABILITIES, F_CPUID_DEFAULT),
 		/* CORE_CAPABILITIES */
-		F(SPEC_CTRL_SSBD),
+		F(SPEC_CTRL_SSBD, F_CPUID_DEFAULT),
 	);
 
 	/*
@@ -1040,97 +1050,97 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD);
 
 	kvm_cpu_cap_init(CPUID_7_1_EAX,
-		F(SHA512),
-		F(SM3),
-		F(SM4),
-		F(AVX_VNNI),
-		F(AVX512_BF16),
-		F(CMPCCXADD),
-		F(FZRM),
-		F(FSRS),
-		F(FSRC),
-		X86_64_F(LKGS),
-		F(WRMSRNS),
-		F(AMX_FP16),
-		F(AVX_IFMA),
-		F(LAM),
-		F(MOVRS),
+		F(SHA512, F_CPUID_DEFAULT),
+		F(SM3, F_CPUID_DEFAULT),
+		F(SM4, F_CPUID_DEFAULT),
+		F(AVX_VNNI, F_CPUID_DEFAULT),
+		F(AVX512_BF16, F_CPUID_DEFAULT),
+		F(CMPCCXADD, F_CPUID_DEFAULT),
+		F(FZRM, F_CPUID_DEFAULT),
+		F(FSRS, F_CPUID_DEFAULT),
+		F(FSRC, F_CPUID_DEFAULT),
+		X86_64_F(LKGS, F_CPUID_DEFAULT),
+		F(WRMSRNS, F_CPUID_DEFAULT),
+		F(AMX_FP16, F_CPUID_DEFAULT),
+		F(AVX_IFMA, F_CPUID_DEFAULT),
+		F(LAM, F_CPUID_DEFAULT),
+		F(MOVRS, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_1_ECX,
-		SCATTERED_F(MSR_IMM),
+		SCATTERED_F(MSR_IMM, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_1_EDX,
-		F(AVX_VNNI_INT8),
-		F(AVX_NE_CONVERT),
-		F(AMX_COMPLEX),
-		F(AVX_VNNI_INT16),
-		F(PREFETCHITI),
-		F(AVX10),
+		F(AVX_VNNI_INT8, F_CPUID_DEFAULT),
+		F(AVX_NE_CONVERT, F_CPUID_DEFAULT),
+		F(AMX_COMPLEX, F_CPUID_DEFAULT),
+		F(AVX_VNNI_INT16, F_CPUID_DEFAULT),
+		F(PREFETCHITI, F_CPUID_DEFAULT),
+		F(AVX10, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_2_EDX,
-		F(INTEL_PSFD),
-		F(IPRED_CTRL),
-		F(RRSBA_CTRL),
-		F(DDPD_U),
-		F(BHI_CTRL),
-		F(MCDT_NO),
+		F(INTEL_PSFD, F_CPUID_DEFAULT),
+		F(IPRED_CTRL, F_CPUID_DEFAULT),
+		F(RRSBA_CTRL, F_CPUID_DEFAULT),
+		F(DDPD_U, F_CPUID_DEFAULT),
+		F(BHI_CTRL, F_CPUID_DEFAULT),
+		F(MCDT_NO, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_D_1_EAX,
-		F(XSAVEOPT),
-		F(XSAVEC),
-		F(XGETBV1),
-		F(XSAVES),
-		X86_64_F(XFD),
+		F(XSAVEOPT, F_CPUID_DEFAULT),
+		F(XSAVEC, F_CPUID_DEFAULT),
+		F(XGETBV1, F_CPUID_DEFAULT),
+		F(XSAVES, F_CPUID_DEFAULT),
+		X86_64_F(XFD, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_12_EAX,
-		SCATTERED_F(SGX1),
-		SCATTERED_F(SGX2),
-		SCATTERED_F(SGX_EDECCSSA),
+		SCATTERED_F(SGX1, F_CPUID_DEFAULT),
+		SCATTERED_F(SGX2, F_CPUID_DEFAULT),
+		SCATTERED_F(SGX_EDECCSSA, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_1E_1_EAX,
-		F(AMX_INT8_ALIAS),
-		F(AMX_BF16_ALIAS),
-		F(AMX_COMPLEX_ALIAS),
-		F(AMX_FP16_ALIAS),
-		F(AMX_FP8),
-		F(AMX_TF32),
-		F(AMX_AVX512),
-		F(AMX_MOVRS),
+		F(AMX_INT8_ALIAS, F_CPUID_DEFAULT),
+		F(AMX_BF16_ALIAS, F_CPUID_DEFAULT),
+		F(AMX_COMPLEX_ALIAS, F_CPUID_DEFAULT),
+		F(AMX_FP16_ALIAS, F_CPUID_DEFAULT),
+		F(AMX_FP8, F_CPUID_DEFAULT),
+		F(AMX_TF32, F_CPUID_DEFAULT),
+		F(AMX_AVX512, F_CPUID_DEFAULT),
+		F(AMX_MOVRS, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_24_0_EBX,
-		F(AVX10_128),
-		F(AVX10_256),
-		F(AVX10_512),
+		F(AVX10_128, F_CPUID_DEFAULT),
+		F(AVX10_256, F_CPUID_DEFAULT),
+		F(AVX10_512, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_24_1_ECX,
-		F(AVX10_VNNI_INT),
+		F(AVX10_VNNI_INT, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
-		F(LAHF_LM),
-		F(CMP_LEGACY),
+		F(LAHF_LM, F_CPUID_DEFAULT),
+		F(CMP_LEGACY, F_CPUID_DEFAULT),
 		VENDOR_F(SVM),
 		/* ExtApicSpace */
-		F(CR8_LEGACY),
-		F(ABM),
-		F(SSE4A),
-		F(MISALIGNSSE),
-		F(3DNOWPREFETCH),
-		F(OSVW),
+		F(CR8_LEGACY, F_CPUID_DEFAULT),
+		F(ABM, F_CPUID_DEFAULT),
+		F(SSE4A, F_CPUID_DEFAULT),
+		F(MISALIGNSSE, F_CPUID_DEFAULT),
+		F(3DNOWPREFETCH, F_CPUID_DEFAULT),
+		F(OSVW, F_CPUID_DEFAULT),
 		/* IBS */
-		F(XOP),
+		F(XOP, F_CPUID_DEFAULT),
 		/* SKINIT, WDT, LWP */
-		F(FMA4),
-		F(TBM),
-		F(TOPOEXT),
+		F(FMA4, F_CPUID_DEFAULT),
+		F(TBM, F_CPUID_DEFAULT),
+		F(TOPOEXT, F_CPUID_DEFAULT),
 		VENDOR_F(PERFCTR_CORE),
 	);
 
@@ -1146,7 +1156,7 @@ void kvm_initialize_cpu_caps(void)
 		ALIASED_1_EDX_F(CX8),
 		ALIASED_1_EDX_F(APIC),
 		/* Reserved */
-		F(SYSCALL),
+		F(SYSCALL, F_CPUID_DEFAULT),
 		ALIASED_1_EDX_F(MTRR),
 		ALIASED_1_EDX_F(PGE),
 		ALIASED_1_EDX_F(MCA),
@@ -1154,42 +1164,42 @@ void kvm_initialize_cpu_caps(void)
 		ALIASED_1_EDX_F(PAT),
 		ALIASED_1_EDX_F(PSE36),
 		/* Reserved */
-		F(NX),
+		F(NX, F_CPUID_DEFAULT),
 		/* Reserved */
-		F(MMXEXT),
+		F(MMXEXT, F_CPUID_DEFAULT),
 		ALIASED_1_EDX_F(MMX),
 		ALIASED_1_EDX_F(FXSR),
-		F(FXSR_OPT),
-		X86_64_F(GBPAGES),
-		F(RDTSCP),
+		F(FXSR_OPT, F_CPUID_DEFAULT),
+		X86_64_F(GBPAGES, F_CPUID_DEFAULT),
+		F(RDTSCP, F_CPUID_DEFAULT),
 		/* Reserved */
-		X86_64_F(LM),
-		F(3DNOWEXT),
-		F(3DNOW),
+		X86_64_F(LM, F_CPUID_DEFAULT),
+		F(3DNOWEXT, F_CPUID_DEFAULT),
+		F(3DNOW, F_CPUID_DEFAULT),
 	);
 
 	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
 		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
 
 	kvm_cpu_cap_init(CPUID_8000_0007_EDX,
-		SCATTERED_F(CONSTANT_TSC),
+		SCATTERED_F(CONSTANT_TSC, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0008_EBX,
-		F(CLZERO),
-		F(XSAVEERPTR),
-		F(WBNOINVD),
-		F(AMD_IBPB),
-		F(AMD_IBRS),
-		F(AMD_SSBD),
-		F(VIRT_SSBD),
-		F(AMD_SSB_NO),
-		F(AMD_STIBP),
-		F(AMD_STIBP_ALWAYS_ON),
-		F(AMD_IBRS_SAME_MODE),
-		PASSTHROUGH_F(EFER_LMSLE_MBZ),
-		F(AMD_PSFD),
-		F(AMD_IBPB_RET),
+		F(CLZERO, F_CPUID_DEFAULT),
+		F(XSAVEERPTR, F_CPUID_DEFAULT),
+		F(WBNOINVD, F_CPUID_DEFAULT),
+		F(AMD_IBPB, F_CPUID_DEFAULT),
+		F(AMD_IBRS, F_CPUID_DEFAULT),
+		F(AMD_SSBD, F_CPUID_DEFAULT),
+		F(VIRT_SSBD, F_CPUID_DEFAULT),
+		F(AMD_SSB_NO, F_CPUID_DEFAULT),
+		F(AMD_STIBP, F_CPUID_DEFAULT),
+		F(AMD_STIBP_ALWAYS_ON, F_CPUID_DEFAULT),
+		F(AMD_IBRS_SAME_MODE, F_CPUID_DEFAULT),
+		PASSTHROUGH_F(EFER_LMSLE_MBZ, F_CPUID_DEFAULT),
+		F(AMD_PSFD, F_CPUID_DEFAULT),
+		F(AMD_IBPB_RET, F_CPUID_DEFAULT),
 	);
 
 	/*
@@ -1240,12 +1250,12 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(SEV),
 		/* VM_PAGE_FLUSH */
 		VENDOR_F(SEV_ES),
-		F(SME_COHERENT),
+		F(SME_COHERENT, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0021_EAX,
-		F(NO_NESTED_DATA_BP),
-		F(WRMSR_XX_BASE_NS),
+		F(NO_NESTED_DATA_BP, F_CPUID_DEFAULT),
+		F(WRMSR_XX_BASE_NS, F_CPUID_DEFAULT),
 		/*
 		 * Synthesize "LFENCE is serializing" into the AMD-defined entry
 		 * in KVM's supported CPUID, i.e. if the feature is reported as
@@ -1256,49 +1266,49 @@ void kvm_initialize_cpu_caps(void)
 		 * CPUID will drop the flags, and reporting support in AMD's
 		 * leaf can make it easier for userspace to detect the feature.
 		 */
-		SYNTHESIZED_F(LFENCE_RDTSC),
+		SYNTHESIZED_F(LFENCE_RDTSC, F_CPUID_DEFAULT),
 		/* SmmPgCfgLock */
 		/* 4: Resv */
-		SYNTHESIZED_F(VERW_CLEAR),
-		F(NULL_SEL_CLR_BASE),
+		SYNTHESIZED_F(VERW_CLEAR, F_CPUID_DEFAULT),
+		F(NULL_SEL_CLR_BASE, F_CPUID_DEFAULT),
 		/* UpperAddressIgnore */
-		F(AUTOIBRS),
-		EMULATED_F(NO_SMM_CTL_MSR),
+		F(AUTOIBRS, F_CPUID_DEFAULT),
+		EMULATED_F(NO_SMM_CTL_MSR, F_CPUID_DEFAULT),
 		/* PrefetchCtlMsr */
 		/* GpOnUserCpuid */
 		/* EPSF */
-		F(PREFETCHI),
-		F(AVX512_BMM),
-		F(ERAPS),
-		SYNTHESIZED_F(SBPB),
-		SYNTHESIZED_F(IBPB_BRTYPE),
-		SYNTHESIZED_F(SRSO_NO),
-		F(SRSO_USER_KERNEL_NO),
+		F(PREFETCHI, F_CPUID_DEFAULT),
+		F(AVX512_BMM, F_CPUID_DEFAULT),
+		F(ERAPS, F_CPUID_DEFAULT),
+		SYNTHESIZED_F(SBPB, F_CPUID_DEFAULT),
+		SYNTHESIZED_F(IBPB_BRTYPE, F_CPUID_DEFAULT),
+		SYNTHESIZED_F(SRSO_NO, F_CPUID_DEFAULT),
+		F(SRSO_USER_KERNEL_NO, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0021_ECX,
-		SYNTHESIZED_F(TSA_SQ_NO),
-		SYNTHESIZED_F(TSA_L1_NO),
+		SYNTHESIZED_F(TSA_SQ_NO, F_CPUID_DEFAULT),
+		SYNTHESIZED_F(TSA_L1_NO, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
-		F(PERFMON_V2),
+		F(PERFMON_V2, F_CPUID_DEFAULT),
 	);
 
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 
 	kvm_cpu_cap_init(CPUID_C000_0001_EDX,
-		F(XSTORE),
-		F(XSTORE_EN),
-		F(XCRYPT),
-		F(XCRYPT_EN),
-		F(ACE2),
-		F(ACE2_EN),
-		F(PHE),
-		F(PHE_EN),
-		F(PMM),
-		F(PMM_EN),
+		F(XSTORE, F_CPUID_DEFAULT),
+		F(XSTORE_EN, F_CPUID_DEFAULT),
+		F(XCRYPT, F_CPUID_DEFAULT),
+		F(XCRYPT_EN, F_CPUID_DEFAULT),
+		F(ACE2, F_CPUID_DEFAULT),
+		F(ACE2_EN, F_CPUID_DEFAULT),
+		F(PHE, F_CPUID_DEFAULT),
+		F(PHE_EN, F_CPUID_DEFAULT),
+		F(PMM, F_CPUID_DEFAULT),
+		F(PMM_EN, F_CPUID_DEFAULT),
 	);
 
 	/*
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index f41f8d3db794..e87adecacd03 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -14,9 +14,13 @@ enum kvm_cpuid_overlay {
 	NR_CPUID_OL
 };
 
+/* Temporarily use VMX overlay as the default one */
+#define CPUID_OL_DEFAULT	CPUID_OL_VMX
+
 #define F_CPUID_VMX		BIT(CPUID_OL_VMX)
 #define F_CPUID_SVM		BIT(CPUID_OL_SVM)
 #define F_CPUID_TDX		BIT(CPUID_OL_TDX)
+#define F_CPUID_DEFAULT		(F_CPUID_VMX | F_CPUID_SVM)
 
 static inline u8 get_cpuid_overlay(struct kvm *kvm)
 {
@@ -30,7 +34,7 @@ static inline u8 get_cpuid_overlay(struct kvm *kvm)
 	return CPUID_OL_VMX;
 }
 
-extern u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
+extern u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS] __read_mostly;
 extern bool kvm_is_configuring_cpu_caps __read_mostly;
 
 void kvm_initialize_cpu_caps(void);
@@ -118,8 +122,8 @@ static __always_inline void cpuid_entry_override(struct kvm_cpuid_entry2 *entry,
 {
 	u32 *reg = cpuid_entry_get_reg(entry, leaf * 32);
 
-	BUILD_BUG_ON(leaf >= ARRAY_SIZE(kvm_cpu_caps));
-	*reg = kvm_cpu_caps[leaf];
+	BUILD_BUG_ON(leaf >= ARRAY_SIZE(kvm_cpu_caps[0]));
+	*reg = kvm_cpu_caps[CPUID_OL_DEFAULT][leaf];
 }
 
 static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
@@ -220,7 +224,7 @@ static __always_inline void kvm_cpu_cap_clear(unsigned int x86_feature)
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
 	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
-	kvm_cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
+	kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] &= ~__feature_bit(x86_feature);
 }
 
 static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature)
@@ -228,14 +232,14 @@ static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature)
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
 	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
-	kvm_cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
+	kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] |= __feature_bit(x86_feature);
 }
 
 static __always_inline u32 kvm_cpu_cap_get(unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	return kvm_cpu_caps[x86_leaf] & __feature_bit(x86_feature);
+	return kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] & __feature_bit(x86_feature);
 }
 
 static __always_inline bool kvm_cpu_cap_has(unsigned int x86_feature)
-- 
2.46.0

