Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8B374759
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411162; cv=none; b=GxlN9ygfVRCt6kHVIw9hasAqq5A8h9mfIYNTBIIiZwYax/OWhEwefFGWwuk2Zik9B3ccTigqmx2b4b/JmFRVo1NRWM3IOm8gLUcVjmIIqCg/X3GZ10JSfoLH8XInrV1q7V1fuI7uz8vYquJwG7Y8PcEsIh1r0L80s1gEXhGvd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411162; c=relaxed/simple;
	bh=6TVPcXU8njplrlPCFULiGaVR9QvNv3ln+Vo3D7T7q7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inO4BA4owzElGL3XMy4N2jsDWzofvn1w7DCf4mnX+KEB5W/bfkA2y+euWwO2FPoatIHElvUyRWWw+KMWK6TdCo4cZuzZvyIghMq4sC+fPZLvgAkSMcTrdAKQ5GzgdiwOYawYAdYecXetWrl4+O0+VRslFZgY0VMVN+VDvxPH42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWe/ID4/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWe/ID4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411161; x=1807947161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6TVPcXU8njplrlPCFULiGaVR9QvNv3ln+Vo3D7T7q7s=;
  b=ZWe/ID4/Jy8D3vGyBr8PR7uOWnYDtgGHqMk0h2KdIN66jG202fDKcpFp
   0fwJYYySf6Fuq52EzDrpdDZeU7XQhiax+YCoBZ+EAcrhgXTFQ33HP2VgH
   WvIkfqeZjEDI7iLtxbylWbF6J9oVXO/X3KCpDpez+yLJV/GePqZWpN7Mp
   ylhDjo5lG0t3LGRwJIEEKFwm1/jZJ6xER+q8JihLLrb4TAbizwbRNn4i2
   0iyODpx36fiq3ypWZPwD5zcV8lr0GOZ2XBaSw9/hzMx5nUozlpbzkUHn/
   gZ+UAygObgJg15ZpAQYxVMc8IPz6NE5XYfSaziTMCahG3nbvG+BosY32D
   g==;
X-CSE-ConnectionGUID: Tg0KK5Z9SMiPBpZernomvw==
X-CSE-MsgGUID: 0PfTAXd5T4+uHvUdTLkMCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070256"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070256"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:40 -0700
X-CSE-ConnectionGUID: vrmWGI+FRF28FE3YipxCDg==
X-CSE-MsgGUID: 6uxp9318Qz6pTnXb1JLicg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226285006"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:38 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 17/27] KVM: x86: Init allowed masks for extended CPUID range in paranoid mode
Date: Fri, 17 Apr 2026 15:36:00 +0800
Message-ID: <20260417073610.3246316-18-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Populate the CPUID paranoid mode validation data for the extended CPUID
range (0x80000000 through 0x80000022).

As with the basic range, each register follows one of three rules: ignored
(skipped during validation), mask/value checked, or zero checked (for
reserved or unsupported registers).

Most added extended range leaves are AMD-specific and are initialized
for the SVM overlay only.  A few registers (max extended leaf, brand
string, cache line size) are relevant to all overlays but are ignored
since KVM doesn't meaningfully constrain them.

Notable leaf-specific handling:
 - 0x80000000: EAX (max extended leaf) ignored for all overlays.
   EBX/ECX/EDX (vendor string) ignored for SVM only.
 - 0x80000001: EAX ignored for all overlays — reserved on Intel but
   userspace may set it.  EBX allowed mask initialized for SVM.
 - 0x80000002–0x80000004: brand string, all registers ignored.
 - 0x80000005: L1 cache/TLB info, ignored for SVM only.
 - 0x80000006: cache info — EAX/EBX ignored for SVM, ECX ignored for
   all overlays, EDX allowed mask for SVM.
 - 0x80000008: EAX allowed bits 23:0 (phys/virt address widths) for
   all overlays.  ECX (core count/APIC ID size) for SVM only.
 - 0x8000000A: SVM revision (EAX) allowed if SVM is supported.
   ASID count (EBX) is ignored.
 - 0x8000001A: performance optimization identifiers, intersected with
   raw host CPUID.
 - 0x8000001D: AMD cache topology (analogous to CPUID 4), with
   sub-leaf common pattern mapping added.
 - 0x8000001E: extended topology, initialized when TOPOEXT is
   supported.
 - 0x8000001F: EBX allows bits 11:0 only (excludes VMPL fields).
 - 0x80000021: EBX allows the ERAPS size field (bits 23:16) when
   ERAPS is supported.
 - 0x80000022: EBX allows core performance counter count (bits 3:0)
   when PERFMON_V2 is supported and PMU is enabled.
- 0x80000000: EAX (max extended leaf) is ignored for all overlays, it
  could be checked in the future if needed. EBX/ECX/EDX are ignored for
  SVM only.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 13 +++++++
 arch/x86/kvm/cpuid.c            | 68 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/reverse_cpuid.h    | 13 +++++++
 3 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 90514791f0fd..2ec4d92e3e79 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -837,6 +837,19 @@ enum kvm_only_cpuid_leafs {
 	CPUID_1F_0_EBX,
 	CPUID_1F_0_ECX,
 	CPUID_24_0_EAX,
+	CPUID_8000_0001_EBX,
+	CPUID_8000_0006_EDX,
+	CPUID_8000_0008_EAX,
+	CPUID_8000_0008_ECX,
+	CPUID_8000_000A_EAX,
+	CPUID_8000_001A_EAX,
+	CPUID_8000_001D_EAX,
+	CPUID_8000_001D_EDX,
+	CPUID_8000_001E_EBX,
+	CPUID_8000_001E_ECX,
+	CPUID_8000_001F_EBX,
+	CPUID_8000_0021_EBX,
+	CPUID_8000_0022_EBX,
 	NR_KVM_CPU_CAPS_PARANOID,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS_PARANOID - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 59f0b3166eaa..471733eb68d8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -434,6 +434,7 @@ static bool __maybe_unused is_cpuid_subleaf_common_pattern(u32 func, u32 *index)
 	case 4:
 	case 0xB:
 	case 0x1F:
+	case 0x8000001D:
 		*index = 0;
 		return true;
 	case 0xD:
@@ -1310,6 +1311,18 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX10_VNNI_INT, F_CPUID_DEFAULT),
 	);
 
+	kvm_cpu_cap_ignore(0x80000000, 0, 0, BIT(CPUID_EAX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0x80000000, 0, 0, BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_SVM);
+
+	/*
+	 * Although EAX is reserved for Intel platforms, userspace may set it,
+	 * to avoid breaking userspace, ignore it for VMX/TDX as well.
+	 */
+	kvm_cpu_cap_ignore(0x80000001, 0, 0, BIT(CPUID_EAX), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_8000_0001_EBX, ~GENMASK_U32(27, 16), F_CPUID_SVM);
+
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
 		F(LAHF_LM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(CMP_LEGACY, F_CPUID_DEFAULT),
@@ -1367,10 +1380,31 @@ void kvm_initialize_cpu_caps(void)
 	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
 		kvm_cpu_cap_set(X86_FEATURE_GBPAGES, F_CPUID_DEFAULT);
 
+	kvm_cpu_cap_ignore(0x80000002, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0x80000003, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_ignore(0x80000004, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_DEFAULT | F_CPUID_TDX);
+
+	kvm_cpu_cap_ignore(0x80000005, 0, 0,
+			   BIT(CPUID_EAX) | BIT(CPUID_EBX) | BIT(CPUID_ECX) | BIT(CPUID_EDX),
+			   F_CPUID_SVM);
+
+	kvm_cpu_cap_ignore(0x80000006, 0, 0, BIT(CPUID_EAX) | BIT(CPUID_EBX), F_CPUID_SVM);
+	kvm_cpu_cap_ignore(0x80000006, 0, 0, BIT(CPUID_ECX), F_CPUID_DEFAULT | F_CPUID_TDX);
+	kvm_cpu_cap_init_mf(CPUID_8000_0006_EDX, ~GENMASK_U32(17, 16), F_CPUID_SVM);
+
 	kvm_cpu_cap_init(CPUID_8000_0007_EDX,
 		SCATTERED_F(CONSTANT_TSC, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
+	kvm_cpu_cap_init_mf(CPUID_8000_0008_EAX, GENMASK_U32(23, 0),
+			    F_CPUID_DEFAULT | F_CPUID_TDX);
+
 	kvm_cpu_cap_init(CPUID_8000_0008_EBX,
 		F(CLZERO, F_CPUID_DEFAULT),
 		F(XSAVEERPTR, F_CPUID_DEFAULT),
@@ -1388,6 +1422,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AMD_IBPB_RET, F_CPUID_DEFAULT),
 	);
 
+	kvm_cpu_cap_init_mf(CPUID_8000_0008_ECX, GENMASK_U32(17, 12) | GENMASK_U32(7, 0),
+			    F_CPUID_SVM);
+	kvm_cpu_cap_ignore(0x80000008, 0, 0, BIT(CPUID_EDX), F_CPUID_SVM);
+
 	/*
 	 * AMD has separate bits for each SPEC_CTRL bit.
 	 * arch/x86/kernel/cpu/bugs.c is kind enough to
@@ -1415,6 +1453,11 @@ void kvm_initialize_cpu_caps(void)
 	    !boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD, F_CPUID_SVM);
 
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_SVM)) {
+		kvm_cpu_cap_init_mf(CPUID_8000_000A_EAX, GENMASK_U32(7, 0), F_CPUID_SVM);
+		kvm_cpu_cap_ignore(0x8000000A, 0, 0, BIT(CPUID_EBX), F_CPUID_SVM);
+	}
+
 	/* All SVM features required additional vendor module enabling. */
 	kvm_cpu_cap_init(CPUID_8000_000A_EDX,
 		VENDOR_F(NPT),
@@ -1431,6 +1474,21 @@ void kvm_initialize_cpu_caps(void)
 		VENDOR_F(SVME_ADDR_CHK),
 	);
 
+	kvm_cpu_cap_ignore(0x80000019, 0, 0, BIT(CPUID_EAX) | BIT(CPUID_EBX), F_CPUID_SVM);
+
+	kvm_cpu_cap_check_and_init_mf(CPUID_8000_001A_EAX, GENMASK_U32(2, 0), F_CPUID_SVM);
+
+	kvm_cpu_cap_init_mf(CPUID_8000_001D_EAX, GENMASK_U32(25, 14) | GENMASK_U32(9, 0),
+			    F_CPUID_SVM);
+	kvm_cpu_cap_ignore(0x8000001D, 0, -1, BIT(CPUID_EBX) | BIT(CPUID_ECX), F_CPUID_SVM);
+	kvm_cpu_cap_init_mf(CPUID_8000_001D_EDX, GENMASK_U32(1, 0), F_CPUID_SVM);
+
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_TOPOEXT)) {
+		kvm_cpu_cap_ignore(0x8000001E, 0, 0, BIT(CPUID_EAX), F_CPUID_SVM);
+		kvm_cpu_cap_init_mf(CPUID_8000_001E_EBX, GENMASK_U32(15, 0), F_CPUID_SVM);
+		kvm_cpu_cap_init_mf(CPUID_8000_001E_ECX, GENMASK_U32(10, 0), F_CPUID_SVM);
+	}
+
 	kvm_cpu_cap_init(CPUID_8000_001F_EAX,
 		VENDOR_F(SME),
 		VENDOR_F(SEV),
@@ -1439,6 +1497,9 @@ void kvm_initialize_cpu_caps(void)
 		F(SME_COHERENT, F_CPUID_DEFAULT),
 	);
 
+	/* KVM does not support VMPL */
+	kvm_cpu_cap_init_mf(CPUID_8000_001F_EBX, GENMASK_U32(11, 0), F_CPUID_SVM);
+
 	kvm_cpu_cap_init(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP, F_CPUID_DEFAULT),
 		F(WRMSR_XX_BASE_NS, F_CPUID_DEFAULT),
@@ -1472,6 +1533,9 @@ void kvm_initialize_cpu_caps(void)
 		F(SRSO_USER_KERNEL_NO, F_CPUID_DEFAULT),
 	);
 
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_ERAPS))
+		kvm_cpu_cap_init_mf(CPUID_8000_0021_EBX, GENMASK_U32(23, 16), F_CPUID_SVM);
+
 	kvm_cpu_cap_init(CPUID_8000_0021_ECX,
 		SYNTHESIZED_F(TSA_SQ_NO, F_CPUID_DEFAULT),
 		SYNTHESIZED_F(TSA_L1_NO, F_CPUID_DEFAULT),
@@ -1481,6 +1545,10 @@ void kvm_initialize_cpu_caps(void)
 		F(PERFMON_V2, F_CPUID_DEFAULT),
 	);
 
+	/* Only expose number of core performance counters. */
+	if (enable_pmu && kvm_cpu_cap_has(NULL, X86_FEATURE_PERFMON_V2))
+		kvm_cpu_cap_init_mf(CPUID_8000_0022_EBX, GENMASK_U32(3, 0), F_CPUID_SVM);
+
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE, F_CPUID_SVM);
 
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 5c7c0fbb0fec..1bdb05aaa852 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -155,6 +155,19 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_1F_0_EBX]      = {      0x1f, 0, CPUID_EBX},
 	[CPUID_1F_0_ECX]      = {      0x1f, 0, CPUID_ECX},
 	[CPUID_24_0_EAX]      = {      0x24, 0, CPUID_EAX},
+	[CPUID_8000_0001_EBX] = {0x80000001, 0, CPUID_EBX},
+	[CPUID_8000_0006_EDX] = {0x80000006, 0, CPUID_EDX},
+	[CPUID_8000_0008_EAX] = {0x80000008, 0, CPUID_EAX},
+	[CPUID_8000_0008_ECX] = {0x80000008, 0, CPUID_ECX},
+	[CPUID_8000_000A_EAX] = {0x8000000a, 0, CPUID_EAX},
+	[CPUID_8000_001A_EAX] = {0x8000001a, 0, CPUID_EAX},
+	[CPUID_8000_001D_EAX] = {0x8000001d, 0, CPUID_EAX},
+	[CPUID_8000_001D_EDX] = {0x8000001d, 0, CPUID_EDX},
+	[CPUID_8000_001E_EBX] = {0x8000001e, 0, CPUID_EBX},
+	[CPUID_8000_001E_ECX] = {0x8000001e, 0, CPUID_ECX},
+	[CPUID_8000_001F_EBX] = {0x8000001f, 0, CPUID_EBX},
+	[CPUID_8000_0021_EBX] = {0x80000021, 0, CPUID_EBX},
+	[CPUID_8000_0022_EBX] = {0x80000022, 0, CPUID_EBX},
 };
 
 /*
-- 
2.46.0

