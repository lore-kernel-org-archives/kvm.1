Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A4F37475B
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411138; cv=none; b=SzULO72dSZG60hfb5hDx1s7OYi8WzPMMbK97KHViTmJsO73ydp8k24rKhloOyin8QOY8bgWMhcL0rvRLKLcl6SCg0J9fZmkOb+jU0FsmXqkt9e5BojQtR8pXFh4l3z7GpQaFsSXAXD7+N1ARiM2o+4qA3U0D27J7vuy/2Vpb7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411138; c=relaxed/simple;
	bh=71LocTFk728q/SjZo+qttMll9HoIRVSn5EBElBws14Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4stvpNzEoSmc6nbC5duFu6e2nSUWs6x3FH5oHwGELCXyShkRmK7xO3k3XQitcAOkMAOpjfSJwlKQKc+ma+YAKE/RtJgul/jIi15jUe8xtJ9fsnq2MeFjWxlb7qQXphVJEsX/L2YhpEIBjaD9nN3ei0da3Kp3ueureyj42/6QPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3xx7OGQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3xx7OGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411137; x=1807947137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=71LocTFk728q/SjZo+qttMll9HoIRVSn5EBElBws14Y=;
  b=Z3xx7OGQEfg+k3U3YOqe6T84p3h4284B3WwtegE8rPLz94TNN74bco77
   V3WgHEYyLKbMWnmhR9gvsuWB77ZW/cuGmWWbusDEdyfTgezFK8dcCsEDU
   ShSOw/5E9VygATIR5EOq8nBjrx6J7DETPvbB1KtNcfEbwdZS9Jh+QD4CL
   j6wqySwyGHyG37Elmk+NR6E+CZDWFSSV9mWVAKf+5aLGgGdXAomxAZFDg
   STOC8BI7S/D7k6RNwOv4hhY1pnA02MqHgLqSybd7TVOYQFicGvP/BMMQW
   nMl70uH78k4qeaOIS9usmbzyQ1jjtZjyfOqro2OIFA02RMBSWkbHznwJ1
   A==;
X-CSE-ConnectionGUID: u2oH7ZHpR3Cf6ernN2Ymjw==
X-CSE-MsgGUID: ObEEWA1TT+GLlE+dWuQMgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070161"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:17 -0700
X-CSE-ConnectionGUID: iLoyil6ZQOaK+pf8C5GFAg==
X-CSE-MsgGUID: 1njLPCnXQAi3wtaI9i7cyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284877"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:14 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 06/27] KVM: x86: Populate TDX CPUID overlay with supported feature bits
Date: Fri, 17 Apr 2026 15:35:49 +0800
Message-ID: <20260417073610.3246316-7-binbin.wu@linux.intel.com>
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

Tag CPUID feature bits with F_CPUID_TDX in kvm_initialize_cpu_caps() and
vmx_set_cpu_caps() to populate the TDX overlay, so that KVM can
advertise/check a TDX-specific set of CPUID capabilities to/from
userspace for TDX guests.

Features that are deliberately *not* tagged with F_CPUID_TDX fall into
the following categories:
- Fixed-0 or reserved in TDX.
- Not yet supported by KVM for TDX, e.g, HLE, RTM, WAITPKG, etc.
- AMD-only features.

Note that fixed-1 bits, which are initialized via kvm_cpu_cap_init() or
kvm_cpu_cap_check_and_set(), could be impacted by boot_cpu_has() if the
related feature is disabled by host kernel. Considering these features
are normally not disabled, for simplicity, reuse them for TDX overlay.

For CET, TDX follows the support for normal VMX VM, e.g if KVM is
loaded with unrestricted guest disabled or allow_smaller_maxphyaddr
enabled, which should be rare, KVM will clear CET support for TDX
guests as well for simplicity.  Note that allow_smaller_maxphyaddr
doesn't applied to TDX, so SHSTK and IBT are not cleared for TDX overlay
in kvm_initialize_cpu_caps() when allow_smaller_maxphyaddr is true,
however, without SHSTK and IBT, XFEATURE_MASK_CET_ALL will be cleared
in kvm_caps.supported_xss, so that SHSTK and IBT are cleared for TDX
overlay eventually in kvm_setup_xss_caps().

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c   | 320 +++++++++++++++++++++--------------------
 arch/x86/kvm/vmx/vmx.c |  22 ++-
 arch/x86/kvm/x86.c     |   4 +-
 3 files changed, 184 insertions(+), 162 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 767c007ab5f0..938b19767feb 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -854,8 +854,8 @@ void kvm_initialize_cpu_caps(void)
 		     sizeof(boot_cpu_data.x86_capability));
 
 	kvm_cpu_cap_init(CPUID_1_ECX,
-		F(XMM3, F_CPUID_DEFAULT),
-		F(PCLMULQDQ, F_CPUID_DEFAULT),
+		F(XMM3, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PCLMULQDQ, F_CPUID_DEFAULT | F_CPUID_TDX),
 		VENDOR_F(DTES64),
 		/*
 		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
@@ -864,124 +864,131 @@ void kvm_initialize_cpu_caps(void)
 		 * that KVM is aware that it's a known, unadvertised flag.
 		 */
 		RUNTIME_F(MWAIT),
-		/* DS-CPL */
+		/* DSCPL is fixed-1 in TDX */
+		F(DSCPL, F_CPUID_TDX),
 		VENDOR_F(VMX),
 		/* SMX, EST */
 		/* TM2 */
-		F(SSSE3, F_CPUID_DEFAULT),
+		F(SSSE3, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* CNXT-ID */
 		/* Reserved */
-		F(FMA, F_CPUID_DEFAULT),
-		F(CX16, F_CPUID_DEFAULT),
+		F(FMA, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CX16, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* xTPR Update */
-		F(PDCM, F_CPUID_DEFAULT),
-		F(PCID, F_CPUID_DEFAULT),
+		F(PDCM, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PCID, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved, DCA */
-		F(XMM4_1, F_CPUID_DEFAULT),
-		F(XMM4_2, F_CPUID_DEFAULT),
-		EMULATED_F(X2APIC, F_CPUID_DEFAULT),
-		F(MOVBE, F_CPUID_DEFAULT),
-		F(POPCNT, F_CPUID_DEFAULT),
-		EMULATED_F(TSC_DEADLINE_TIMER, F_CPUID_DEFAULT),
-		F(AES, F_CPUID_DEFAULT),
-		F(XSAVE, F_CPUID_DEFAULT),
+		F(XMM4_1, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XMM4_2, F_CPUID_DEFAULT | F_CPUID_TDX),
+		EMULATED_F(X2APIC, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MOVBE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(POPCNT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		EMULATED_F(TSC_DEADLINE_TIMER, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AES, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XSAVE, F_CPUID_DEFAULT | F_CPUID_TDX),
 		RUNTIME_F(OSXSAVE),
-		F(AVX, F_CPUID_DEFAULT),
-		F(F16C, F_CPUID_DEFAULT),
-		F(RDRAND, F_CPUID_DEFAULT),
-		EMULATED_F(HYPERVISOR, F_CPUID_DEFAULT),
+		F(AVX, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(F16C, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(RDRAND, F_CPUID_DEFAULT | F_CPUID_TDX),
+		EMULATED_F(HYPERVISOR, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_1_EDX,
-		F(FPU, F_CPUID_DEFAULT),
-		F(VME, F_CPUID_DEFAULT),
-		F(DE, F_CPUID_DEFAULT),
-		F(PSE, F_CPUID_DEFAULT),
-		F(TSC, F_CPUID_DEFAULT),
-		F(MSR, F_CPUID_DEFAULT),
-		F(PAE, F_CPUID_DEFAULT),
-		F(MCE, F_CPUID_DEFAULT),
-		F(CX8, F_CPUID_DEFAULT),
-		F(APIC, F_CPUID_DEFAULT),
+		F(FPU, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(VME, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(DE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PSE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(TSC, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MSR, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PAE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MCE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CX8, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(APIC, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
-		F(SEP, F_CPUID_DEFAULT),
-		F(MTRR, F_CPUID_DEFAULT),
-		F(PGE, F_CPUID_DEFAULT),
-		F(MCA, F_CPUID_DEFAULT),
-		F(CMOV, F_CPUID_DEFAULT),
-		F(PAT, F_CPUID_DEFAULT),
+		F(SEP, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MTRR, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PGE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MCA, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CMOV, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PAT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		/* PSE36 is fixed-0 in TDX */
 		F(PSE36, F_CPUID_DEFAULT),
 		/* PSN */
-		F(CLFLUSH, F_CPUID_DEFAULT),
+		F(CLFLUSH, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
 		VENDOR_F(DS),
 		/* ACPI */
-		F(MMX, F_CPUID_DEFAULT),
-		F(FXSR, F_CPUID_DEFAULT),
-		F(XMM, F_CPUID_DEFAULT),
-		F(XMM2, F_CPUID_DEFAULT),
-		F(SELFSNOOP, F_CPUID_DEFAULT),
+		F(MMX, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FXSR, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XMM, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XMM2, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SELFSNOOP, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* HTT, TM, Reserved, PBE */
 	);
 
 	kvm_cpu_cap_init(CPUID_7_0_EBX,
-		F(FSGSBASE, F_CPUID_DEFAULT),
-		EMULATED_F(TSC_ADJUST, F_CPUID_DEFAULT),
+		F(FSGSBASE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		EMULATED_F(TSC_ADJUST, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(SGX, F_CPUID_DEFAULT),
-		F(BMI1, F_CPUID_DEFAULT),
+		F(BMI1, F_CPUID_DEFAULT | F_CPUID_TDX),
+		/* KVM doesn't support HLE for TDX yet */
 		F(HLE, F_CPUID_DEFAULT),
-		F(AVX2, F_CPUID_DEFAULT),
-		F(FDP_EXCPTN_ONLY, F_CPUID_DEFAULT),
-		F(SMEP, F_CPUID_DEFAULT),
-		F(BMI2, F_CPUID_DEFAULT),
-		F(ERMS, F_CPUID_DEFAULT),
-		F(INVPCID, F_CPUID_DEFAULT),
+		F(AVX2, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FDP_EXCPTN_ONLY, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SMEP, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(BMI2, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(ERMS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(INVPCID, F_CPUID_DEFAULT | F_CPUID_TDX),
+		/* KVM doesn't support RTM for TDX yet */
 		F(RTM, F_CPUID_DEFAULT),
-		F(ZERO_FCS_FDS, F_CPUID_DEFAULT),
+		/* CQM */
+		F(ZERO_FCS_FDS, F_CPUID_DEFAULT | F_CPUID_TDX),
 		VENDOR_F(MPX),
-		F(AVX512F, F_CPUID_DEFAULT),
-		F(AVX512DQ, F_CPUID_DEFAULT),
-		F(RDSEED, F_CPUID_DEFAULT),
-		F(ADX, F_CPUID_DEFAULT),
-		F(SMAP, F_CPUID_DEFAULT),
-		F(AVX512IFMA, F_CPUID_DEFAULT),
-		F(CLFLUSHOPT, F_CPUID_DEFAULT),
-		F(CLWB, F_CPUID_DEFAULT),
+		/* RDT_A */
+		F(AVX512F, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512DQ, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(RDSEED, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(ADX, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SMAP, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512IFMA, F_CPUID_DEFAULT | F_CPUID_TDX),
+		/* Reserved */
+		F(CLFLUSHOPT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CLWB, F_CPUID_DEFAULT | F_CPUID_TDX),
 		VENDOR_F(INTEL_PT),
-		F(AVX512PF, F_CPUID_DEFAULT),
-		F(AVX512ER, F_CPUID_DEFAULT),
-		F(AVX512CD, F_CPUID_DEFAULT),
-		F(SHA_NI, F_CPUID_DEFAULT),
-		F(AVX512BW, F_CPUID_DEFAULT),
-		F(AVX512VL, F_CPUID_DEFAULT),
+		F(AVX512PF, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512ER, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512CD, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SHA_NI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512BW, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512VL, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_ECX,
 		/* PREFETCHWT1 */
-		F(AVX512VBMI, F_CPUID_DEFAULT),
-		F(UMIP, F_CPUID_DEFAULT),
-		F(PKU, F_CPUID_DEFAULT),
+		F(AVX512VBMI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(UMIP, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PKU, F_CPUID_DEFAULT | F_CPUID_TDX),
 		RUNTIME_F(OSPKE),
 		VENDOR_F(WAITPKG),
-		F(AVX512_VBMI2, F_CPUID_DEFAULT),
-		X86_64_F(SHSTK, F_CPUID_DEFAULT),
-		F(GFNI, F_CPUID_DEFAULT),
-		F(VAES, F_CPUID_DEFAULT),
-		F(VPCLMULQDQ, F_CPUID_DEFAULT),
-		F(AVX512_VNNI, F_CPUID_DEFAULT),
-		F(AVX512_BITALG, F_CPUID_DEFAULT),
+		F(AVX512_VBMI2, F_CPUID_DEFAULT | F_CPUID_TDX),
+		X86_64_F(SHSTK, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(GFNI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(VAES, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(VPCLMULQDQ, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512_VNNI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512_BITALG, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* TME */
-		F(AVX512_VPOPCNTDQ, F_CPUID_DEFAULT),
+		F(AVX512_VPOPCNTDQ, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
-		PASSTHROUGH_F(LA57, F_CPUID_DEFAULT),
+		PASSTHROUGH_F(LA57, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* MPX_MAWAU */
-		F(RDPID, F_CPUID_DEFAULT),
+		F(RDPID, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* KEY_LOCKER */
-		F(BUS_LOCK_DETECT, F_CPUID_DEFAULT),
-		F(CLDEMOTE, F_CPUID_DEFAULT),
+		F(BUS_LOCK_DETECT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CLDEMOTE, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
-		F(MOVDIRI, F_CPUID_DEFAULT),
-		F(MOVDIR64B, F_CPUID_DEFAULT),
+		F(MOVDIRI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MOVDIR64B, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* ENQCMD */
 		F(SGX_LC, F_CPUID_DEFAULT),
 		/* PKS */
@@ -1000,34 +1007,34 @@ void kvm_initialize_cpu_caps(void)
 	 * doesn't know how to emulate or map.
 	 */
 	if (!tdp_enabled)
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT | F_CPUID_TDX);
 
 	kvm_cpu_cap_init(CPUID_7_EDX,
 		/* Reserved, SGX_KEYS */
-		F(AVX512_4VNNIW, F_CPUID_DEFAULT),
-		F(AVX512_4FMAPS, F_CPUID_DEFAULT),
-		F(FSRM, F_CPUID_DEFAULT),
+		F(AVX512_4VNNIW, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512_4FMAPS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FSRM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* UINT, Reserved, Reserved */
-		F(AVX512_VP2INTERSECT, F_CPUID_DEFAULT),
+		F(AVX512_VP2INTERSECT, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* SRBDS_CTRL */
-		F(MD_CLEAR, F_CPUID_DEFAULT),
+		F(MD_CLEAR, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* RTM_ALWAYS_ABORT, Reserved, TSX_FORCE_ABORT */
-		F(SERIALIZE, F_CPUID_DEFAULT),
+		F(SERIALIZE, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* HYBRID_CPU */
-		F(TSXLDTRK, F_CPUID_DEFAULT),
+		F(TSXLDTRK, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved, PCONFIG, ARCH_LBR */
-		F(IBT, F_CPUID_DEFAULT),
+		F(IBT, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
-		F(AMX_BF16, F_CPUID_DEFAULT),
-		F(AVX512_FP16, F_CPUID_DEFAULT),
-		F(AMX_TILE, F_CPUID_DEFAULT),
-		F(AMX_INT8, F_CPUID_DEFAULT),
-		F(SPEC_CTRL, F_CPUID_DEFAULT),
-		F(INTEL_STIBP, F_CPUID_DEFAULT),
-		F(FLUSH_L1D, F_CPUID_DEFAULT),
-		EMULATED_F(ARCH_CAPABILITIES, F_CPUID_DEFAULT),
+		F(AMX_BF16, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512_FP16, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_TILE, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_INT8, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SPEC_CTRL, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(INTEL_STIBP, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FLUSH_L1D, F_CPUID_DEFAULT | F_CPUID_TDX),
+		EMULATED_F(ARCH_CAPABILITIES, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* CORE_CAPABILITIES */
-		F(SPEC_CTRL_SSBD, F_CPUID_DEFAULT),
+		F(SPEC_CTRL_SSBD, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	/*
@@ -1050,53 +1057,55 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL_SSBD, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_7_1_EAX,
-		F(SHA512, F_CPUID_DEFAULT),
-		F(SM3, F_CPUID_DEFAULT),
-		F(SM4, F_CPUID_DEFAULT),
-		F(AVX_VNNI, F_CPUID_DEFAULT),
-		F(AVX512_BF16, F_CPUID_DEFAULT),
-		F(CMPCCXADD, F_CPUID_DEFAULT),
-		F(FZRM, F_CPUID_DEFAULT),
-		F(FSRS, F_CPUID_DEFAULT),
-		F(FSRC, F_CPUID_DEFAULT),
-		X86_64_F(LKGS, F_CPUID_DEFAULT),
-		F(WRMSRNS, F_CPUID_DEFAULT),
-		F(AMX_FP16, F_CPUID_DEFAULT),
-		F(AVX_IFMA, F_CPUID_DEFAULT),
-		F(LAM, F_CPUID_DEFAULT),
-		F(MOVRS, F_CPUID_DEFAULT),
+		F(SHA512, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SM3, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(SM4, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX_VNNI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX512_BF16, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(CMPCCXADD, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FZRM, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FSRS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(FSRC, F_CPUID_DEFAULT | F_CPUID_TDX),
+		X86_64_F(LKGS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(WRMSRNS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_FP16, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX_IFMA, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(LAM, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MOVRS, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_1_ECX,
+		/* MSR_IMM is reserved in TDX spec */
 		SCATTERED_F(MSR_IMM, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_1_EDX,
-		F(AVX_VNNI_INT8, F_CPUID_DEFAULT),
-		F(AVX_NE_CONVERT, F_CPUID_DEFAULT),
-		F(AMX_COMPLEX, F_CPUID_DEFAULT),
-		F(AVX_VNNI_INT16, F_CPUID_DEFAULT),
-		F(PREFETCHITI, F_CPUID_DEFAULT),
-		F(AVX10, F_CPUID_DEFAULT),
+		F(AVX_VNNI_INT8, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX_NE_CONVERT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_COMPLEX, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX_VNNI_INT16, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(PREFETCHITI, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX10, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_7_2_EDX,
-		F(INTEL_PSFD, F_CPUID_DEFAULT),
-		F(IPRED_CTRL, F_CPUID_DEFAULT),
-		F(RRSBA_CTRL, F_CPUID_DEFAULT),
-		F(DDPD_U, F_CPUID_DEFAULT),
-		F(BHI_CTRL, F_CPUID_DEFAULT),
-		F(MCDT_NO, F_CPUID_DEFAULT),
+		F(INTEL_PSFD, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(IPRED_CTRL, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(RRSBA_CTRL, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(DDPD_U, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(BHI_CTRL, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(MCDT_NO, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_D_1_EAX,
-		F(XSAVEOPT, F_CPUID_DEFAULT),
-		F(XSAVEC, F_CPUID_DEFAULT),
-		F(XGETBV1, F_CPUID_DEFAULT),
-		F(XSAVES, F_CPUID_DEFAULT),
-		X86_64_F(XFD, F_CPUID_DEFAULT),
+		F(XSAVEOPT, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XSAVEC, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XGETBV1, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(XSAVES, F_CPUID_DEFAULT | F_CPUID_TDX),
+		X86_64_F(XFD, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
+	/* SGX related features are fixed-0 for TDX */
 	kvm_cpu_cap_init(CPUID_12_EAX,
 		SCATTERED_F(SGX1, F_CPUID_DEFAULT),
 		SCATTERED_F(SGX2, F_CPUID_DEFAULT),
@@ -1104,36 +1113,37 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_1E_1_EAX,
-		F(AMX_INT8_ALIAS, F_CPUID_DEFAULT),
-		F(AMX_BF16_ALIAS, F_CPUID_DEFAULT),
-		F(AMX_COMPLEX_ALIAS, F_CPUID_DEFAULT),
-		F(AMX_FP16_ALIAS, F_CPUID_DEFAULT),
-		F(AMX_FP8, F_CPUID_DEFAULT),
-		F(AMX_TF32, F_CPUID_DEFAULT),
-		F(AMX_AVX512, F_CPUID_DEFAULT),
-		F(AMX_MOVRS, F_CPUID_DEFAULT),
+		F(AMX_INT8_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_BF16_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_COMPLEX_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_FP16_ALIAS, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_FP8, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_TF32, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_AVX512, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AMX_MOVRS, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_24_0_EBX,
-		F(AVX10_128, F_CPUID_DEFAULT),
-		F(AVX10_256, F_CPUID_DEFAULT),
-		F(AVX10_512, F_CPUID_DEFAULT),
+		F(AVX10_128, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX10_256, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(AVX10_512, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_24_1_ECX,
+		/* AVX10_VNNI_INT is reserved in TDX spec */
 		F(AVX10_VNNI_INT, F_CPUID_DEFAULT),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
-		F(LAHF_LM, F_CPUID_DEFAULT),
+		F(LAHF_LM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(CMP_LEGACY, F_CPUID_DEFAULT),
 		VENDOR_F(SVM),
 		/* ExtApicSpace */
 		F(CR8_LEGACY, F_CPUID_DEFAULT),
-		F(ABM, F_CPUID_DEFAULT),
+		F(ABM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(SSE4A, F_CPUID_DEFAULT),
 		F(MISALIGNSSE, F_CPUID_DEFAULT),
-		F(3DNOWPREFETCH, F_CPUID_DEFAULT),
+		F(3DNOWPREFETCH, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(OSVW, F_CPUID_DEFAULT),
 		/* IBS */
 		F(XOP, F_CPUID_DEFAULT),
@@ -1156,7 +1166,7 @@ void kvm_initialize_cpu_caps(void)
 		ALIASED_1_EDX_F(CX8),
 		ALIASED_1_EDX_F(APIC),
 		/* Reserved */
-		F(SYSCALL, F_CPUID_DEFAULT),
+		F(SYSCALL, F_CPUID_DEFAULT | F_CPUID_TDX),
 		ALIASED_1_EDX_F(MTRR),
 		ALIASED_1_EDX_F(PGE),
 		ALIASED_1_EDX_F(MCA),
@@ -1164,16 +1174,16 @@ void kvm_initialize_cpu_caps(void)
 		ALIASED_1_EDX_F(PAT),
 		ALIASED_1_EDX_F(PSE36),
 		/* Reserved */
-		F(NX, F_CPUID_DEFAULT),
+		F(NX, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
 		F(MMXEXT, F_CPUID_DEFAULT),
 		ALIASED_1_EDX_F(MMX),
 		ALIASED_1_EDX_F(FXSR),
 		F(FXSR_OPT, F_CPUID_DEFAULT),
-		X86_64_F(GBPAGES, F_CPUID_DEFAULT),
-		F(RDTSCP, F_CPUID_DEFAULT),
+		X86_64_F(GBPAGES, F_CPUID_DEFAULT | F_CPUID_TDX),
+		F(RDTSCP, F_CPUID_DEFAULT | F_CPUID_TDX),
 		/* Reserved */
-		X86_64_F(LM, F_CPUID_DEFAULT),
+		X86_64_F(LM, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(3DNOWEXT, F_CPUID_DEFAULT),
 		F(3DNOW, F_CPUID_DEFAULT),
 	);
@@ -1182,13 +1192,13 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_GBPAGES, F_CPUID_DEFAULT);
 
 	kvm_cpu_cap_init(CPUID_8000_0007_EDX,
-		SCATTERED_F(CONSTANT_TSC, F_CPUID_DEFAULT),
+		SCATTERED_F(CONSTANT_TSC, F_CPUID_DEFAULT | F_CPUID_TDX),
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0008_EBX,
 		F(CLZERO, F_CPUID_DEFAULT),
 		F(XSAVEERPTR, F_CPUID_DEFAULT),
-		F(WBNOINVD, F_CPUID_DEFAULT),
+		F(WBNOINVD, F_CPUID_DEFAULT | F_CPUID_TDX),
 		F(AMD_IBPB, F_CPUID_DEFAULT),
 		F(AMD_IBRS, F_CPUID_DEFAULT),
 		F(AMD_SSBD, F_CPUID_DEFAULT),
@@ -1318,6 +1328,8 @@ void kvm_initialize_cpu_caps(void)
 	 * RDPID is misreported, and KVM has botched MSR_TSC_AUX emulation in
 	 * the past.  For example, the sanity check may fire if this instance of
 	 * KVM is running as L1 on top of an older, broken KVM.
+	 *
+	 * If MSR_TSC_AUX probing failed, TDX will be disabled.
 	 */
 	if (WARN_ON((kvm_cpu_cap_has(X86_FEATURE_RDTSCP) ||
 		     kvm_cpu_cap_has(X86_FEATURE_RDPID)) &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 7879a8a532c4..fae6b33949f5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8079,6 +8079,8 @@ static __init u64 vmx_get_perf_capabilities(void)
 
 static __init void vmx_set_cpu_caps(void)
 {
+	u32 enable_mask;
+
 	kvm_initialize_cpu_caps();
 
 	/* CPUID 0x1 */
@@ -8086,21 +8088,27 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_VMX, F_CPUID_DEFAULT);
 
 	/* CPUID 0x7 */
+	/* MPX is fixed-0 for TDX */
 	if (kvm_mpx_supported())
 		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX, F_CPUID_DEFAULT);
+	/* INVPCID is fixed-1 for TDX */
 	if (!cpu_has_vmx_invpcid())
 		kvm_cpu_cap_clear(X86_FEATURE_INVPCID, F_CPUID_DEFAULT);
+	/* KVM doesn't support PT for TDX yet */
 	if (vmx_pt_mode_is_host_guest())
 		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT, F_CPUID_DEFAULT);
-	if (vmx_pebs_supported()) {
-		kvm_cpu_cap_check_and_set(X86_FEATURE_DS, F_CPUID_DEFAULT);
-		kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64, F_CPUID_DEFAULT);
-	}
 
+	/* DS and DTES64 are fixed-1 for TDX */
+	enable_mask = vmx_pebs_supported() ? F_CPUID_TDX | F_CPUID_DEFAULT : F_CPUID_TDX;
+	kvm_cpu_cap_check_and_set(X86_FEATURE_DS, enable_mask);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_DTES64, enable_mask);
+
+	/* PDCM is fixed-1 for TDX */
 	if (!enable_pmu)
 		kvm_cpu_cap_clear(X86_FEATURE_PDCM, F_CPUID_DEFAULT);
 	kvm_caps.supported_perf_cap = vmx_get_perf_capabilities();
 
+	/* SGX related features are fixed-0 for TDX */
 	if (!enable_sgx) {
 		kvm_cpu_cap_clear(X86_FEATURE_SGX, F_CPUID_DEFAULT);
 		kvm_cpu_cap_clear(X86_FEATURE_SGX_LC, F_CPUID_DEFAULT);
@@ -8113,6 +8121,7 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_UMIP, F_CPUID_DEFAULT);
 
 	/* CPUID 0xD.1 */
+	/* XSAVES is fixed-1 for TDX */
 	if (!cpu_has_vmx_xsaves())
 		kvm_cpu_cap_clear(X86_FEATURE_XSAVES, F_CPUID_DEFAULT);
 
@@ -8122,6 +8131,7 @@ static __init void vmx_set_cpu_caps(void)
 		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
 	}
 
+	/* KVM doesn't support WAITPKG for TDX yet */
 	if (cpu_has_vmx_waitpkg())
 		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG, F_CPUID_DEFAULT);
 
@@ -8133,8 +8143,8 @@ static __init void vmx_set_cpu_caps(void)
 	 */
 	if (!cpu_has_load_cet_ctrl() || !enable_unrestricted_guest ||
 	    !cpu_has_vmx_basic_no_hw_errcode_cc()) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT | F_CPUID_TDX);
 	}
 
 	kvm_setup_xss_caps();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5b830997e693..db8434f9a2ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10024,8 +10024,8 @@ void kvm_setup_xss_caps(void)
 		kvm_caps.supported_xss &= ~XFEATURE_MASK_CET_ALL;
 
 	if ((kvm_caps.supported_xss & XFEATURE_MASK_CET_ALL) != XFEATURE_MASK_CET_ALL) {
-		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT);
-		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT);
+		kvm_cpu_cap_clear(X86_FEATURE_SHSTK, F_CPUID_DEFAULT | F_CPUID_TDX);
+		kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_DEFAULT | F_CPUID_TDX);
 		kvm_caps.supported_xss &= ~XFEATURE_MASK_CET_ALL;
 	}
 }
-- 
2.46.0

