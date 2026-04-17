Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4F8376465
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411164; cv=none; b=ChwcjAa9Eh+gNlR3mNGhS6f7Ybt0BcVuWrgdVntN4QL4yTFNDHGtX31n+Kql5a1dDOGCiIxwRVISz3ysQ1R4hwnzQM7Yxu+feD9aSFPrZ1AkeK+CymGizfjC0cRTs5ZDWY0fALVJ1mQObmAZMC7GpUTsD9fvuHUIhbutVE1UfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411164; c=relaxed/simple;
	bh=1eU6O3KIG45Ue5pgJMsgcDXraCD841YpHY/EZOJ0F0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnn1IgHODY+IGkuUoiHE5qMv1zYI7UuumrGNs2m+nOC+Ah2T8vNTtzYIJCNWhWbzG3kWiKWAN7muFJmJGRbee3YnfUpCIHhefZsIMpWtscWjSNF00G6Q/MZjceGmSq1xBxDPWq4me5ZiAng19bJSQIupRHLTEpdtoSsbF7dyVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRibQU4v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRibQU4v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411158; x=1807947158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1eU6O3KIG45Ue5pgJMsgcDXraCD841YpHY/EZOJ0F0Y=;
  b=WRibQU4v5rxjurPDsEhGXt+AQZmiYXRuRHvS/h18efNoE6jNdVftZhRu
   9aUlcV8m0rdcghbfgN2d0GDRcFQvTQINlwg+MRsjyJ2R4TDfxaZE51Iv4
   qgKAJlsA9RWkGRJ0HMbhYx7yQ6WG9yv/rfczeA0gH5PkFaQCuY+JrUs1H
   +l5YbePLrqWtasEcE7wU9RrfgAOK7Q79CMGuE/0K9EA1cq79piD1oXU7N
   0gU0AmB0TuibZ2oNY9gPONrs1EE7FhMSMyeODN7lPQiB4f0Rrpo+GzH2i
   4dxO4Y/+REC1LwNJvfF+YoGGnW50eFEZX0jq2SmsL0SkJfvbgmwK8/Uen
   A==;
X-CSE-ConnectionGUID: QF8lWasORriIC4Yn5fgIGw==
X-CSE-MsgGUID: MQffUYrFTWScgusJnJZ+Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070247"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070247"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:38 -0700
X-CSE-ConnectionGUID: SVIFb/v/TC2ZwRPFTViPUw==
X-CSE-MsgGUID: h42GZB+6QReaJvj6yRtHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284995"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:36 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 16/27] KVM: x86: Init allowed masks for basic CPUID range in paranoid mode
Date: Fri, 17 Apr 2026 15:35:59 +0800
Message-ID: <20260417073610.3246316-17-binbin.wu@linux.intel.com>
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

Populate the CPUID paranoid mode validation data for the basic CPUID
range (0x0 through 0x24).

For each CPUID output register, the validation follows one of three
rules:
  1. Ignored: the register is added to the ignored set and KVM skips
     validation of the userspace-provided value.
  2. Mask/value check: a new KVM-only CPUID leaf enum is defined with a
     corresponding reverse_cpuid[] entry, and an allowed mask or fixed
     value is initialized per-overlay.
  3. Zero check: for reserved registers or registers where no bits are
     supported, userspace input is checked against zero.

Add is_cpuid_subleaf_common_pattern() to map higher sub-leaf indices to
a representative sub-leaf for validation, avoiding duplicate mask
definitions for CPUID functions 4, 0xB, 0xD, 0x12, and 0x1F.

Add is_cpuid_reg_check_value() to flag registers where userspace input
must exactly match fixed values (CPUID 0x1D, 0x1E.0.EBX) rather than
being validated against a bitmask.

Notable leaf-specific handling:
 - CPUID 0x1.EDX: HT is emulated to allow userspace to set it, but
   masked when reporting supported CPUID to userspace.
 - CPUID 0x6.EAX: ARAT initialized as emulated, replacing the hardcoded
   value in __do_cpuid_func().
 - CPUID 0x6.ECX: APERFMPERF allowed for VMX/SVM (userspace may enable
   KVM_X86_DISABLE_EXITS_APERFMPERF and set it), fixed-0 for TDX.
 - CPUID 0x7.0.EDX: CORE_CAPABILITIES set for TDX to accommodate old
   TDX modules that report bit 30 as fixed-1; MSR_IA32_CORE_CAPS reads
   return 0 inside a TD as a workaround.
 - CPUID 0xD: XCR0-based masks for subleaf 0, XSS-based for subleaf 1;
   size/offset fields are ignored
 - CPUID 0x12: SGX sub-leaf masks initialized when SGX is supported,
   replacing hardcoded masks in __do_cpuid_func().
 - CPUID 0x14: PT masks initialized for VMX from intel pt_caps[].
   Override CPUID.0x14.0.{EBX, ECX} when reporting capabilities to
   userspace.
 - CPUID 0x1D: fixed values from Intel SDM, exact-match required.
 - CPUID 0x1E.0: EAX capped at 1 (max supported sub-leaf), EBX is a
   fixed value from Intel SDM.
 - CPUID 0x24: AVX10 version capped at 2, merged with vector-width bits.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h |  45 +++++++-
 arch/x86/kvm/cpuid.c            | 186 +++++++++++++++++++++++++++++---
 arch/x86/kvm/reverse_cpuid.h    |  47 ++++++++
 arch/x86/kvm/vmx/tdx.c          |  10 +-
 arch/x86/kvm/vmx/vmx.c          |  14 +++
 5 files changed, 288 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 75895ab569fb..90514791f0fd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -794,7 +794,50 @@ enum kvm_only_cpuid_leafs {
 	CPUID_24_1_ECX,
 	/* End of the leafs tracked by per-vcpu caps. */
 	NR_KVM_CPU_CAPS,
-	NR_KVM_CPU_CAPS_PARANOID = NR_KVM_CPU_CAPS,
+	CPUID_1_EAX = NR_KVM_CPU_CAPS,
+	CPUID_2_EAX,
+	CPUID_4_0_EAX,
+	CPUID_4_0_EDX,
+	CPUID_5_EAX,
+	CPUID_5_EBX,
+	CPUID_5_ECX,
+	CPUID_6_ECX,
+	CPUID_A_EAX,
+	CPUID_A_EBX,
+	CPUID_A_ECX,
+	CPUID_A_EDX,
+	CPUID_B_0_EAX,
+	CPUID_B_0_EBX,
+	CPUID_B_0_ECX,
+	CPUID_D_0_EAX,
+	CPUID_D_0_EDX,
+	CPUID_D_1_ECX,
+	CPUID_D_2_ECX,
+	CPUID_12_0_EBX,
+	CPUID_12_0_EDX,
+	CPUID_12_1_EAX,
+	CPUID_12_1_ECX,
+	CPUID_12_1_EDX,
+	CPUID_12_2_EAX,
+	CPUID_12_2_EBX,
+	CPUID_12_2_ECX,
+	CPUID_12_2_EDX,
+	CPUID_14_0_EAX,
+	CPUID_14_0_EBX,
+	CPUID_14_0_ECX,
+	CPUID_14_1_EAX,
+	CPUID_14_1_EBX,
+	CPUID_1D_0_EAX,
+	CPUID_1D_1_EAX,
+	CPUID_1D_1_EBX,
+	CPUID_1D_1_ECX,
+	CPUID_1E_0_EAX,
+	CPUID_1E_0_EBX,
+	CPUID_1F_0_EAX,
+	CPUID_1F_0_EBX,
+	CPUID_1F_0_ECX,
+	CPUID_24_0_EAX,
+	NR_KVM_CPU_CAPS_PARANOID,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS_PARANOID - NCAPINTS,
 };
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e633707277f9..59f0b3166eaa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -392,8 +392,8 @@ static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
  * - Use -1 as index_end to indicate open-ended index ranges starting from
  *   index_start.
  */
-static void __maybe_unused kvm_cpu_cap_ignore(u32 func, u32 index_start, u32 index_end,
-					      u32 reg_mask, u32 overlay_mask)
+static void kvm_cpu_cap_ignore(u32 func, u32 index_start, u32 index_end,
+			       u32 reg_mask, u32 overlay_mask)
 {
 	if (WARN_ON_ONCE(ignored_set.nr >= KVM_MAX_CPUID_ENTRIES))
 		return;
@@ -419,6 +419,35 @@ static bool __maybe_unused is_cpuid_paranoid_ignored(u32 func, u32 index, int re
 	return false;
 }
 
+static bool __maybe_unused is_cpuid_reg_check_value(u32 func, u32 index, int reg)
+{
+	switch (func) {
+	case 0x1D: return true;
+	case 0x1E: return index == 0 && reg == CPUID_EBX;
+	default: return false;
+	}
+}
+
+static bool __maybe_unused is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
+{
+	switch (func) {
+	case 4:
+	case 0xB:
+	case 0x1F:
+		*index = 0;
+		return true;
+	case 0xD:
+	case 0x12:
+		if (*index >= 2) {
+			*index = 2;
+			return true;
+		}
+		return false;
+	default:
+		return false;
+	}
+}
+
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
@@ -876,6 +905,14 @@ void kvm_initialize_cpu_caps(void)
 	BUILD_BUG_ON(sizeof(kvm_cpu_caps)/NR_CPUID_OL - (NKVMCAPINTS * sizeof(**kvm_cpu_caps)) >
 		     sizeof(boot_cpu_data.x86_capability));
 
+	kvm_cpu_cap_ignore(0, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+
+	kvm_cpu_cap_init_mf(CPUID_1_EAX, GENMASK_U32(27, 16) | GENMASK_U32(13, 0),
+			    F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(1, 0, 0, BIT(CPUID_EBX), F_CPUID_DEFAULT | F_CPUID_TDX);
+
 	kvm_cpu_cap_init(CPUID_1_ECX,
 		F(XMM3, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(PCLMULQDQ, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -946,9 +983,40 @@ void kvm_initialize_cpu_caps(void)
 		F(XMM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(XMM2, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(SELFSNOOP, F_CPUID_DEFAULT | F_CPUID_TDX),
-		/* HTT, TM, Reserved, PBE */
+		/* Allow userspace to set HT regardless of underlying hardware. */
+		EMULATED_F(HT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		/* TM, Reserved, PBE */
+	);
+
+	/* EAX[7:0] are reserved with value 1. */
+	kvm_cpu_cap_init_mf(CPUID_2_EAX, GENMASK_U32(31, 8) | 0x01, F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(2, 0, 0, BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_VMX | F_CPUID_TDX);
+
+	kvm_cpu_cap_init_mf(CPUID_4_0_EAX, ~GENMASK_U32(13, 10), F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_4_0_EDX, GENMASK_U32(2, 0), F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(4, 0, -1, BIT(CPUID_EBX) | BIT(CPUID_ECX), F_CPUID_VMX | F_CPUID_TDX);
+
+	kvm_cpu_cap_init_mf(CPUID_5_EAX, GENMASK_U32(15, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_5_EBX, GENMASK_U32(15, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_5_ECX, GENMASK_U32(1, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(5, 0, 0, BIT(CPUID_EDX), F_CPUID_VMX | F_CPUID_TDX);
+
+	kvm_cpu_cap_init(CPUID_6_EAX,
+		EMULATED_F(ARAT, F_CPUID_DEFAULT | F_CPUID_TDX),
+	);
+
+	/*
+	 * KVM allows userspace to set APERFMPERF after enabling
+	 * KVM_X86_DISABLE_EXITS_APERFMPERF.
+	 * Fixed-0 for TDX.
+	 */
+	kvm_cpu_cap_init(CPUID_6_ECX,
+		F(APERFMPERF, F_CPUID_DEFAULT),
 	);
 
+	kvm_cpu_cap_ignore(7, 0, 0, BIT(CPUID_EAX), F_CPUID_DEFAULT | F_CPUID_TDX);
+
 	kvm_cpu_cap_init(CPUID_7_0_EBX,
 		F(FSGSBASE, F_CPUID_DEFAULT | F_CPUID_TDX),
 		EMULATED_F(TSC_ADJUST, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1056,7 +1124,7 @@ void kvm_initialize_cpu_caps(void)
 		F(INTEL_STIBP, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(FLUSH_L1D, F_CPUID_DEFAULT | F_CPUID_TDX),
 		EMULATED_F(ARCH_CAPABILITIES, F_CPUID_DEFAULT | F_CPUID_TDX),
-		/* CORE_CAPABILITIES */
+		F(CORE_CAPABILITIES, F_CPUID_TDX),
 		F(SPEC_CTRL_SSBD, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
@@ -1120,6 +1188,30 @@ void kvm_initialize_cpu_caps(void)
 		F(MCDT_NO, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
+	if (enable_pmu) {
+		/* KVM doesn't support PERFMON for TDX yet. */
+		kvm_cpu_cap_init_mf(CPUID_A_EAX, GENMASK_U32(31, 0), F_CPUID_VMX);
+		kvm_cpu_cap_init_mf(CPUID_A_EBX, GENMASK_U32(12, 10) | GENMASK_U32(7, 0),
+				    F_CPUID_VMX);
+		kvm_cpu_cap_init_mf(CPUID_A_ECX, GENMASK_U32(31, 0), F_CPUID_VMX);
+		kvm_cpu_cap_init_mf(CPUID_A_EDX, GENMASK_U32(19, 15) | GENMASK_U32(12, 0),
+				    F_CPUID_VMX);
+	}
+
+	/* CPUID 0xB is derived from CPUID.0x1F for TDX, but allow userspace to set it. */
+	kvm_cpu_cap_init_mf(CPUID_B_0_EAX, GENMASK_U32(4, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_B_0_EBX, GENMASK_U32(15, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_B_0_ECX, GENMASK_U32(15, 0), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0xB, 0, -1, BIT(CPUID_EDX), F_CPUID_DEFAULT | F_CPUID_TDX);
+
+
+	kvm_cpu_cap_init_mf(CPUID_D_0_EAX, (u32)kvm_caps.supported_xcr0,
+			    F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0xD, 0, 0, BIT(CPUID_EBX) | BIT(CPUID_ECX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_D_0_EDX, (u32)(kvm_caps.supported_xcr0 >> 32),
+			    F_CPUID_DEFAULT | F_CPUID_TDX);
+
 	kvm_cpu_cap_init(CPUID_D_1_EAX,
 		F(XSAVEOPT, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(XSAVEC, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1128,6 +1220,19 @@ void kvm_initialize_cpu_caps(void)
 		X86_64_F(XFD, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
+	kvm_cpu_cap_ignore(0xD, 1, 1, BIT(CPUID_EBX), F_CPUID_DEFAULT | F_CPUID_TDX);
+
+	/* No bits are defined in CPUID.D.1.EDX (i.e., the upper 32 bits of XSS) yet. */
+	kvm_cpu_cap_init_mf(CPUID_D_1_ECX, (u32)kvm_caps.supported_xss,
+			    F_CPUID_DEFAULT | F_CPUID_TDX);
+
+	if ((kvm_caps.supported_xss | kvm_caps.supported_xcr0) & GENMASK_U64(62, 2)) {
+		kvm_cpu_cap_ignore(0xD, 2, 62, BIT(CPUID_EAX) | BIT(CPUID_EBX),
+				   F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_init_mf(CPUID_D_2_ECX, GENMASK_U32(2, 0),
+				    F_CPUID_DEFAULT | F_CPUID_TDX);
+	}
+
 	/* SGX related features are fixed-0 for TDX */
 	kvm_cpu_cap_init(CPUID_12_EAX,
 		SCATTERED_F(SGX1, F_CPUID_DEFAULT),
@@ -1135,6 +1240,40 @@ void kvm_initialize_cpu_caps(void)
 		SCATTERED_F(SGX_EDECCSSA, F_CPUID_DEFAULT),
 	);
 
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_SGX)) {
+		kvm_cpu_cap_check_and_init_mf(CPUID_12_0_EBX, SGX_MISC_EXINFO, F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_0_EDX, GENMASK_U32(15, 0), F_CPUID_DEFAULT);
+
+		kvm_cpu_cap_check_and_init_mf(CPUID_12_1_EAX,
+					      SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK,
+					      F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_1_ECX, (u32)kvm_caps.supported_xcr0, F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_1_EDX, (u32)(kvm_caps.supported_xcr0 >> 32),
+				    F_CPUID_DEFAULT);
+
+		/*
+		 * SUB_LEAF_TYPE (EAX[3:0]) is valid only when it is 1. The
+		 * masks are initialized according to type 1.
+		 */
+		kvm_cpu_cap_init_mf(CPUID_12_2_EAX, GENMASK_U32(31, 12) | 0x1, F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_2_EBX, GENMASK_U32(19, 0), F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_2_ECX, ~GENMASK_U32(11, 4), F_CPUID_DEFAULT);
+		kvm_cpu_cap_init_mf(CPUID_12_2_EDX, GENMASK_U32(19, 0), F_CPUID_DEFAULT);
+	}
+
+	/* Hardcoded with fixed values in Intel SDM. */
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_AMX_TILE)) {
+		kvm_cpu_cap_init_mf(CPUID_1D_0_EAX, 0x00000001, F_CPUID_DEFAULT | F_CPUID_TDX);
+
+		kvm_cpu_cap_init_mf(CPUID_1D_1_EAX, 0x04002000, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_init_mf(CPUID_1D_1_EBX, 0x00080040, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_init_mf(CPUID_1D_1_ECX, 0x00000010, F_CPUID_DEFAULT | F_CPUID_TDX);
+
+		/* KVM limits the subleaf up to 1. */
+		kvm_cpu_cap_init_mf(CPUID_1E_0_EAX, 0x00000001, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_init_mf(CPUID_1E_0_EBX, 0x00004010, F_CPUID_DEFAULT | F_CPUID_TDX);
+	}
+
 	kvm_cpu_cap_init(CPUID_1E_1_EAX,
 		F(AMX_INT8_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(AMX_BF16_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
@@ -1146,11 +1285,25 @@ void kvm_initialize_cpu_caps(void)
 		F(AMX_MOVRS, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
-	kvm_cpu_cap_init(CPUID_24_0_EBX,
-		F(AVX10_128, F_CPUID_DEFAULT | F_CPUID_TDX),
-		F(AVX10_256, F_CPUID_DEFAULT | F_CPUID_TDX),
-		F(AVX10_512, F_CPUID_DEFAULT | F_CPUID_TDX),
-	);
+	kvm_cpu_cap_init_mf(CPUID_1F_0_EAX, GENMASK_U32(4, 0), F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_1F_0_EBX, GENMASK_U32(15, 0), F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_1F_0_ECX, GENMASK_U32(15, 0), F_CPUID_VMX | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0x1F, 0, -1, BIT(CPUID_EDX), F_CPUID_VMX | F_CPUID_TDX);
+
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_AVX10)) {
+		/* KVM supports up to subleaf 1 */
+		kvm_cpu_cap_init_mf(CPUID_24_0_EAX, 0x00000001, F_CPUID_DEFAULT | F_CPUID_TDX);
+		/*
+		 * The allowed value for AVX10 version is 1 or 2. The version is
+		 * guaranteed to be >=1 if AVX10 is supported, and KVM supports
+		 * up to version 2. For simplicity, just allow lower 2 bits to
+		 * be set by userspace.
+		 * EBX[18:16] is reserved at 111b for all vector widths, i.e.,
+		 * AVX10_128, AVX10_256, and AVX10_512.
+		 */
+		kvm_cpu_cap_init_mf(CPUID_24_0_EBX, GENMASK_U32(18, 16) | GENMASK_U32(1, 0),
+				    F_CPUID_DEFAULT | F_CPUID_TDX);
+	}
 
 	kvm_cpu_cap_init(CPUID_24_1_ECX,
 		/* AVX10_VNNI_INT is reserved in TDX spec */
@@ -1501,6 +1654,11 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 		break;
 	case 1:
 		cpuid_entry_override(kvm, entry, CPUID_1_EDX);
+		/*
+		 * Clear HT when reporting to userspace since it's not emulated
+		 * by KVM.
+		 */
+		entry->edx &= ~feature_bit(HT);
 		cpuid_entry_override(kvm, entry, CPUID_1_ECX);
 		break;
 	case 2:
@@ -1535,7 +1693,7 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 		}
 		break;
 	case 6: /* Thermal management */
-		entry->eax = 0x4; /* allow ARAT */
+		cpuid_entry_override(kvm, entry, CPUID_6_EAX);
 		entry->ebx = 0;
 		entry->ecx = 0;
 		entry->edx = 0;
@@ -1674,7 +1832,7 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 		 * feature flags), while enclave size is unrestricted.
 		 */
 		cpuid_entry_override(kvm, entry, CPUID_12_EAX);
-		entry->ebx &= SGX_MISC_EXINFO;
+		cpuid_entry_override(kvm, entry, CPUID_12_0_EBX);
 
 		entry = do_host_cpuid(array, function, 1);
 		if (!entry)
@@ -1687,7 +1845,7 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
 		 * expected to derive it from supported XCR0.
 		 */
-		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
+		cpuid_entry_override(kvm, entry, CPUID_12_1_EAX);
 		entry->ebx &= 0;
 		break;
 	/* Intel PT */
@@ -1697,6 +1855,9 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 			break;
 		}
 
+		cpuid_entry_override(kvm, entry, CPUID_14_0_EBX);
+		cpuid_entry_override(kvm, entry, CPUID_14_0_ECX);
+
 		for (i = 1, max_idx = entry->eax; i <= max_idx; ++i) {
 			if (!do_host_cpuid(array, function, i))
 				goto out;
@@ -1750,6 +1911,7 @@ static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array
 		 */
 		avx10_version = min_t(u8, entry->ebx & 0xff, 2);
 		cpuid_entry_override(kvm, entry, CPUID_24_0_EBX);
+		entry->ebx &= ~GENMASK_U32(7, 0);
 		entry->ebx |= avx10_version;
 
 		entry->ecx = 0;
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 657f5f743ed9..5c7c0fbb0fec 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -76,6 +76,9 @@
 #define KVM_X86_FEATURE_TSA_SQ_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 1)
 #define KVM_X86_FEATURE_TSA_L1_NO	KVM_X86_FEATURE(CPUID_8000_0021_ECX, 2)
 
+/* CPUID level 0x6 (ECX) */
+#define KVM_X86_FEATURE_APERFMPERF	KVM_X86_FEATURE(CPUID_6_ECX, 0)
+
 struct cpuid_reg {
 	u32 function;
 	u32 index;
@@ -109,6 +112,49 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
 	[CPUID_24_1_ECX]      = {      0x24, 1, CPUID_ECX},
+	[CPUID_1_EAX]         = {         1, 0, CPUID_EAX},
+	[CPUID_2_EAX]         = {         2, 0, CPUID_EAX},
+	[CPUID_4_0_EAX]       = {         4, 0, CPUID_EAX},
+	[CPUID_4_0_EDX]       = {         4, 0, CPUID_EDX},
+	[CPUID_5_EAX]         = {         5, 0, CPUID_EAX},
+	[CPUID_5_EBX]         = {         5, 0, CPUID_EBX},
+	[CPUID_5_ECX]         = {         5, 0, CPUID_ECX},
+	[CPUID_6_ECX]         = {         6, 0, CPUID_ECX},
+	[CPUID_A_EAX]         = {       0xa, 0, CPUID_EAX},
+	[CPUID_A_EBX]         = {       0xa, 0, CPUID_EBX},
+	[CPUID_A_ECX]         = {       0xa, 0, CPUID_ECX},
+	[CPUID_A_EDX]         = {       0xa, 0, CPUID_EDX},
+	[CPUID_B_0_EAX]       = {       0xb, 0, CPUID_EAX},
+	[CPUID_B_0_EBX]       = {       0xb, 0, CPUID_EBX},
+	[CPUID_B_0_ECX]       = {       0xb, 0, CPUID_ECX},
+	[CPUID_D_0_EAX]       = {       0xd, 0, CPUID_EAX},
+	[CPUID_D_0_EDX]       = {       0xd, 0, CPUID_EDX},
+	[CPUID_D_1_ECX]       = {       0xd, 1, CPUID_ECX},
+	[CPUID_D_2_ECX]       = {       0xd, 2, CPUID_ECX},
+	[CPUID_12_0_EBX]      = {      0x12, 0, CPUID_EBX},
+	[CPUID_12_0_EDX]      = {      0x12, 0, CPUID_EDX},
+	[CPUID_12_1_EAX]      = {      0x12, 1, CPUID_EAX},
+	[CPUID_12_1_ECX]      = {      0x12, 1, CPUID_ECX},
+	[CPUID_12_1_EDX]      = {      0x12, 1, CPUID_EDX},
+	[CPUID_12_2_EAX]      = {      0x12, 2, CPUID_EAX},
+	[CPUID_12_2_EBX]      = {      0x12, 2, CPUID_EBX},
+	[CPUID_12_2_ECX]      = {      0x12, 2, CPUID_ECX},
+	[CPUID_12_2_EDX]      = {      0x12, 2, CPUID_EDX},
+	[CPUID_14_0_EAX]      = {      0x14, 0, CPUID_EAX},
+	[CPUID_14_0_EBX]      = {      0x14, 0, CPUID_EBX},
+	[CPUID_14_0_ECX]      = {      0x14, 0, CPUID_ECX},
+	[CPUID_14_1_EAX]      = {      0x14, 1, CPUID_EAX},
+	[CPUID_14_1_EBX]      = {      0x14, 1, CPUID_EBX},
+	[CPUID_1D_0_EAX]      = {      0x1d, 0, CPUID_EAX},
+	[CPUID_1D_1_EAX]      = {      0x1d, 1, CPUID_EAX},
+	[CPUID_1D_1_EBX]      = {      0x1d, 1, CPUID_EBX},
+	[CPUID_1D_1_ECX]      = {      0x1d, 1, CPUID_ECX},
+	[CPUID_1E_0_EAX]      = {      0x1e, 0, CPUID_EAX},
+	[CPUID_1E_0_EBX]      = {      0x1e, 0, CPUID_EBX},
+	[CPUID_1F_0_EAX]      = {      0x1f, 0, CPUID_EAX},
+	[CPUID_1F_0_EBX]      = {      0x1f, 0, CPUID_EBX},
+	[CPUID_1F_0_ECX]      = {      0x1f, 0, CPUID_ECX},
+	[CPUID_24_0_EAX]      = {      0x24, 0, CPUID_EAX},
 };
 
 /*
@@ -151,6 +197,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(TSA_SQ_NO);
 	KVM_X86_TRANSLATE_FEATURE(TSA_L1_NO);
 	KVM_X86_TRANSLATE_FEATURE(MSR_IMM);
+	KVM_X86_TRANSLATE_FEATURE(APERFMPERF);
 	default:
 		return x86_feature;
 	}
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..a1df89d66a84 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2141,7 +2141,7 @@ bool tdx_has_emulated_msr(u32 index)
 static bool tdx_is_read_only_msr(u32 index)
 {
 	return  index == MSR_IA32_APICBASE || index == MSR_EFER ||
-		index == MSR_IA32_FEAT_CTL;
+		index == MSR_IA32_FEAT_CTL || index == MSR_IA32_CORE_CAPS;
 }
 
 int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
@@ -2161,6 +2161,14 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			return 1;
 		msr->data = vcpu->arch.mcg_ext_ctl;
 		return 0;
+	case MSR_IA32_CORE_CAPS:
+		/*
+		 * KVM doesn't support MSR_IA32_CORE_CAPS, however, in some old
+		 * TDX modules, CPUID.0x7.0.EDX[30] is fixed-1. As a workaround,
+		 * just return 0 for this MSR.
+		 */
+		msr->data = 0;
+		return 0;
 	default:
 		if (!tdx_has_emulated_msr(msr->index))
 			return 1;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f772558758f7..17c9048c87f3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8099,6 +8099,20 @@ static __init void vmx_set_cpu_caps(void)
 	if (vmx_pt_mode_is_host_guest())
 		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT, F_CPUID_VMX);
 
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_INTEL_PT)) {
+		kvm_cpu_cap_init_mf(CPUID_14_0_EAX, GENMASK_U32(31, 0), F_CPUID_VMX);
+		/* Lower 9 bits are defined, however, bit 6 is not supported in intel pt_caps[] */
+		kvm_cpu_cap_check_and_init_mf(CPUID_14_0_EBX,
+					      GENMASK_U32(8, 7) | GENMASK_U32(5, 0),
+					      F_CPUID_VMX);
+		kvm_cpu_cap_check_and_init_mf(CPUID_14_0_ECX,
+					      BIT(31) | GENMASK_U32(3, 0),
+					      F_CPUID_VMX);
+
+		kvm_cpu_cap_init_mf(CPUID_14_1_EAX, ~GENMASK_U32(15, 3), F_CPUID_VMX);
+		kvm_cpu_cap_init_mf(CPUID_14_1_EBX, GENMASK_U32(31, 0), F_CPUID_VMX);
+	}
+
 	/* DS and DTES64 are fixed-1 for TDX */
 	enable_mask = vmx_pebs_supported() ? F_CPUID_TDX | F_CPUID_VMX : F_CPUID_TDX;
 	kvm_cpu_cap_check_and_set(X86_FEATURE_DS, enable_mask);
-- 
2.46.0

