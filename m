Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1F2FE056
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411153; cv=none; b=OHckq/7qfzjyNCikav5CTltWTYbkVkV2rHNrv7bV45wQuSkqf99qOT0jHXZIRQDmUEuJWjJjdtZ41upjyGoJqbUsNThFnGzBI9bmRffmX7Uucjj524f6+kvK+R9VzVyAmF29+CIvj0gkLSAAP9SYJeTVo5csxJPJgYl3qKP65MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411153; c=relaxed/simple;
	bh=9J6ubSWrm47+wBmcFja2Ns8Z7bTsmLdMW4NOKgsBP1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpYVReRvrpu9AcV2yN5jZGvW3ymqPUD4z4X4cYG9ym3zFXbZa8DDmHRwMHFD6Vhw3gOgR1rY8sm/LQ9z635MrKy2Wy2MSf7IjQadPJT4RvLnbCJV/CUANC7+hDckqvOKQW5Ekz2kUMvBAvoowfVtcORSBfJ6jolsFisab7wDhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzqKEfO3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzqKEfO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411152; x=1807947152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9J6ubSWrm47+wBmcFja2Ns8Z7bTsmLdMW4NOKgsBP1M=;
  b=EzqKEfO3ddvD9k5BMnGMgu/rjq1L5Xw+CgvrJhGbbAqfuUZb3v9UNIv/
   nLPGuHoLFtSQ5hc73JxEBG0tE32lf/dszSLdtYW6MnFm2dEp000LB7Y97
   2yxnlb6o9IiBx/kMMPDatEpN+xlu5Zw77WBRpJkyT8Z/Ud8tupKLgg+Tx
   GPA198FtCDHk3Vw83x3iwMmMsxi8rTVE5NpicdUbvXzUYccDfSorl2ZaA
   UqxIBPENuvnb8cnj5p/9mWDfVb98RTt6IEbGsM2vr3EptggdwpDOp529e
   HXoNbrt3bO/+jTgSgUhLku3oBc+uXUhvdfxGkSUQpFB+UoYLtDhwtzVwx
   g==;
X-CSE-ConnectionGUID: s7REVVaaTCSsZ1EF4Q0U+Q==
X-CSE-MsgGUID: giuaNs2iQHmOM0MZSSnRaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070176"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070176"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:21 -0700
X-CSE-ConnectionGUID: fe2vglsyR/Saau6y9PXhGA==
X-CSE-MsgGUID: RXPtF5msR/uA2KFposivZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284908"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:18 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 08/27] KVM: x86: Thread @kvm to KVM CPU capability helpers
Date: Fri, 17 Apr 2026 15:35:51 +0800
Message-ID: <20260417073610.3246316-9-binbin.wu@linux.intel.com>
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

Thread @kvm through kvm_cpu_cap_has(), kvm_cpu_cap_get(),
cpuid_entry_override(), cpuid_func_emulated(), __do_cpuid_func(), and
their callers, to prepare for allowing KVM to select the appropriate
CPUID overlay based on the VM type and hardware vendor.

Remove the __kvm_cpu_cap_has() wrapper macro, as kvm_cpu_cap_has() now
takes @kvm directly.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c      | 112 +++++++++++++++++++-------------------
 arch/x86/kvm/cpuid.h      |   9 +--
 arch/x86/kvm/svm/nested.c |   4 +-
 arch/x86/kvm/svm/svm.c    |   8 +--
 arch/x86/kvm/vmx/hyperv.c |   2 +-
 arch/x86/kvm/vmx/nested.c |   8 +--
 arch/x86/kvm/vmx/vmx.c    |  13 +++--
 arch/x86/kvm/x86.c        |  38 ++++++-------
 arch/x86/kvm/x86.h        |   2 +-
 9 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9634ea01d2a3..20ea483ddc7a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -369,8 +369,8 @@ static u32 cpuid_get_reg_unsafe(struct kvm_cpuid_entry2 *entry, u32 reg)
 	}
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
-			       bool include_partially_emulated);
+static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
+			       u32 func, bool include_partially_emulated);
 
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
@@ -406,7 +406,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		 */
 		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[CPUID_OL_DEFAULT][i];
 		if (!cpuid.index) {
-			cpuid_func_emulated(&emulated, cpuid.function, true);
+			cpuid_func_emulated(vcpu->kvm, &emulated, cpuid.function, true);
 			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
 		}
 		vcpu->arch.cpu_caps[i] &= cpuid_get_reg_unsafe(entry, cpuid.reg);
@@ -450,10 +450,8 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	kvm_pmu_refresh(vcpu);
 
-#define __kvm_cpu_cap_has(UNUSED_, f) kvm_cpu_cap_has(f)
-	vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(__kvm_cpu_cap_has, UNUSED_) |
+	vcpu->arch.cr4_guest_rsvd_bits = __cr4_reserved_bits(kvm_cpu_cap_has, vcpu->kvm) |
 					 __cr4_reserved_bits(guest_cpu_cap_has, vcpu);
-#undef __kvm_cpu_cap_has
 
 	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu));
 
@@ -1331,8 +1329,8 @@ void kvm_initialize_cpu_caps(void)
 	 *
 	 * If MSR_TSC_AUX probing failed, TDX will be disabled.
 	 */
-	if (WARN_ON((kvm_cpu_cap_has(X86_FEATURE_RDTSCP) ||
-		     kvm_cpu_cap_has(X86_FEATURE_RDPID)) &&
+	if (WARN_ON((kvm_cpu_cap_has(NULL, X86_FEATURE_RDTSCP) ||
+		     kvm_cpu_cap_has(NULL, X86_FEATURE_RDPID)) &&
 		     !kvm_is_supported_user_return_msr(MSR_TSC_AUX))) {
 		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP, F_CPUID_DEFAULT);
 		kvm_cpu_cap_clear(X86_FEATURE_RDPID, F_CPUID_DEFAULT);
@@ -1407,8 +1405,8 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
 	return entry;
 }
 
-static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
-			       bool include_partially_emulated)
+static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
+			       u32 func, bool include_partially_emulated)
 {
 	memset(entry, 0, sizeof(*entry));
 
@@ -1436,7 +1434,7 @@ static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
 	case 7:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 		entry->eax = 0;
-		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
+		if (kvm_cpu_cap_has(kvm, X86_FEATURE_RDTSCP))
 			entry->ecx = feature_bit(RDPID);
 		return 1;
 	default:
@@ -1444,16 +1442,16 @@ static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
 	}
 }
 
-static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
+static int __do_cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_array *array, u32 func)
 {
 	if (array->nent >= array->maxnent)
 		return -E2BIG;
 
-	array->nent += cpuid_func_emulated(&array->entries[array->nent], func, false);
+	array->nent += cpuid_func_emulated(kvm, &array->entries[array->nent], func, false);
 	return 0;
 }
 
-static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
+static inline int __do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array, u32 function)
 {
 	struct kvm_cpuid_entry2 *entry;
 	int r, i, max_idx;
@@ -1473,8 +1471,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = min(entry->eax, 0x24U);
 		break;
 	case 1:
-		cpuid_entry_override(entry, CPUID_1_EDX);
-		cpuid_entry_override(entry, CPUID_1_ECX);
+		cpuid_entry_override(kvm, entry, CPUID_1_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_1_ECX);
 		break;
 	case 2:
 		/*
@@ -1516,9 +1514,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	/* function 7 has additional index. */
 	case 7:
 		max_idx = entry->eax = min(entry->eax, 2u);
-		cpuid_entry_override(entry, CPUID_7_0_EBX);
-		cpuid_entry_override(entry, CPUID_7_ECX);
-		cpuid_entry_override(entry, CPUID_7_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_7_0_EBX);
+		cpuid_entry_override(kvm, entry, CPUID_7_ECX);
+		cpuid_entry_override(kvm, entry, CPUID_7_EDX);
 
 		/* KVM only supports up to 0x7.2, capped above via min(). */
 		if (max_idx >= 1) {
@@ -1526,9 +1524,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			if (!entry)
 				goto out;
 
-			cpuid_entry_override(entry, CPUID_7_1_EAX);
-			cpuid_entry_override(entry, CPUID_7_1_ECX);
-			cpuid_entry_override(entry, CPUID_7_1_EDX);
+			cpuid_entry_override(kvm, entry, CPUID_7_1_EAX);
+			cpuid_entry_override(kvm, entry, CPUID_7_1_ECX);
+			cpuid_entry_override(kvm, entry, CPUID_7_1_EDX);
 			entry->ebx = 0;
 		}
 		if (max_idx >= 2) {
@@ -1536,7 +1534,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			if (!entry)
 				goto out;
 
-			cpuid_entry_override(entry, CPUID_7_2_EDX);
+			cpuid_entry_override(kvm, entry, CPUID_7_2_EDX);
 			entry->ecx = 0;
 			entry->ebx = 0;
 			entry->eax = 0;
@@ -1590,7 +1588,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		if (!entry)
 			goto out;
 
-		cpuid_entry_override(entry, CPUID_D_1_EAX);
+		cpuid_entry_override(kvm, entry, CPUID_D_1_EAX);
 		if (entry->eax & (feature_bit(XSAVES) | feature_bit(XSAVEC)))
 			entry->ebx = xstate_required_size(permitted_xcr0 | permitted_xss,
 							  true);
@@ -1627,7 +1625,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 				continue;
 			}
 
-			if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
+			if (!kvm_cpu_cap_has(kvm, X86_FEATURE_XFD))
 				entry->ecx &= ~BIT_ULL(2);
 			entry->edx = 0;
 		}
@@ -1635,7 +1633,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	}
 	case 0x12:
 		/* Intel SGX */
-		if (!kvm_cpu_cap_has(X86_FEATURE_SGX)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_SGX)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1646,7 +1644,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * are restricted by kernel and KVM capabilities (like most
 		 * feature flags), while enclave size is unrestricted.
 		 */
-		cpuid_entry_override(entry, CPUID_12_EAX);
+		cpuid_entry_override(kvm, entry, CPUID_12_EAX);
 		entry->ebx &= SGX_MISC_EXINFO;
 
 		entry = do_host_cpuid(array, function, 1);
@@ -1665,7 +1663,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* Intel PT */
 	case 0x14:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_INTEL_PT)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1677,7 +1675,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	/* Intel AMX TILE */
 	case 0x1d:
-		if (!kvm_cpu_cap_has(X86_FEATURE_AMX_TILE)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_AMX_TILE)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1688,7 +1686,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	case 0x1e: /* TMUL information */
-		if (!kvm_cpu_cap_has(X86_FEATURE_AMX_TILE)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_AMX_TILE)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1701,7 +1699,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			if (!entry)
 				goto out;
 
-			cpuid_entry_override(entry, CPUID_1E_1_EAX);
+			cpuid_entry_override(kvm, entry, CPUID_1E_1_EAX);
 			entry->ebx = 0;
 			entry->ecx = 0;
 			entry->edx = 0;
@@ -1710,7 +1708,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	case 0x24: {
 		u8 avx10_version;
 
-		if (!kvm_cpu_cap_has(X86_FEATURE_AVX10)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_AVX10)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1722,7 +1720,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * version needs to be captured before overriding EBX features!
 		 */
 		avx10_version = min_t(u8, entry->ebx & 0xff, 2);
-		cpuid_entry_override(entry, CPUID_24_0_EBX);
+		cpuid_entry_override(kvm, entry, CPUID_24_0_EBX);
 		entry->ebx |= avx10_version;
 
 		entry->ecx = 0;
@@ -1734,7 +1732,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 			if (!entry)
 				goto out;
 
-			cpuid_entry_override(entry, CPUID_24_1_ECX);
+			cpuid_entry_override(kvm, entry, CPUID_24_1_ECX);
 			entry->eax = 0;
 			entry->ebx = 0;
 			entry->edx = 0;
@@ -1793,8 +1791,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0x80000001:
 		entry->ebx &= ~GENMASK(27, 16);
-		cpuid_entry_override(entry, CPUID_8000_0001_EDX);
-		cpuid_entry_override(entry, CPUID_8000_0001_ECX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0001_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0001_ECX);
 		break;
 	case 0x80000005:
 		/*  Pass host L1 cache and TLB info. */
@@ -1804,7 +1802,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->edx &= ~GENMASK(17, 16);
 		break;
 	case 0x80000007: /* Advanced power management */
-		cpuid_entry_override(entry, CPUID_8000_0007_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0007_EDX);
 
 		/* mask against host */
 		entry->edx &= boot_cpu_data.x86_power;
@@ -1854,11 +1852,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = phys_as | (virt_as << 8) | (g_phys_as << 16);
 		entry->ecx &= ~(GENMASK(31, 16) | GENMASK(11, 8));
 		entry->edx = 0;
-		cpuid_entry_override(entry, CPUID_8000_0008_EBX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0008_EBX);
 		break;
 	}
 	case 0x8000000A:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SVM)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_SVM)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 			break;
 		}
@@ -1866,7 +1864,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
 				   ASID emulation to nested SVM */
 		entry->ecx = 0; /* Reserved */
-		cpuid_entry_override(entry, CPUID_8000_000A_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_000A_EDX);
 		break;
 	case 0x80000019:
 		entry->ecx = entry->edx = 0;
@@ -1881,10 +1879,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->edx = 0; /* reserved */
 		break;
 	case 0x8000001F:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SEV)) {
+		if (!kvm_cpu_cap_has(kvm, X86_FEATURE_SEV)) {
 			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		} else {
-			cpuid_entry_override(entry, CPUID_8000_001F_EAX);
+			cpuid_entry_override(kvm, entry, CPUID_8000_001F_EAX);
 			/* Clear NumVMPL since KVM does not support VMPL.  */
 			entry->ebx &= ~GENMASK(31, 12);
 			/*
@@ -1899,26 +1897,26 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0x80000021:
 		entry->edx = 0;
-		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0021_EAX);
 
-		if (kvm_cpu_cap_has(X86_FEATURE_ERAPS))
+		if (kvm_cpu_cap_has(kvm, X86_FEATURE_ERAPS))
 			entry->ebx &= GENMASK(23, 16);
 		else
 			entry->ebx = 0;
 
-		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0021_ECX);
 		break;
 	/* AMD Extended Performance Monitoring and Debug */
 	case 0x80000022: {
 		union cpuid_0x80000022_ebx ebx = { };
 
 		entry->ecx = entry->edx = 0;
-		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2)) {
+		if (!enable_pmu || !kvm_cpu_cap_has(kvm, X86_FEATURE_PERFMON_V2)) {
 			entry->eax = entry->ebx = 0;
 			break;
 		}
 
-		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
+		cpuid_entry_override(kvm, entry, CPUID_8000_0022_EAX);
 
 		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
 		entry->ebx = ebx.full;
@@ -1930,7 +1928,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = min(entry->eax, 0xC0000004);
 		break;
 	case 0xC0000001:
-		cpuid_entry_override(entry, CPUID_C000_0001_EDX);
+		cpuid_entry_override(kvm, entry, CPUID_C000_0001_EDX);
 		break;
 	case 3: /* Processor serial number */
 	case 5: /* MONITOR/MWAIT */
@@ -1950,19 +1948,19 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	return r;
 }
 
-static int do_cpuid_func(struct kvm_cpuid_array *array, u32 func,
-			 unsigned int type)
+static int do_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array,
+			 u32 func, unsigned int type)
 {
 	if (type == KVM_GET_EMULATED_CPUID)
-		return __do_cpuid_func_emulated(array, func);
+		return __do_cpuid_func_emulated(kvm, array, func);
 
-	return __do_cpuid_func(array, func);
+	return __do_cpuid_func(kvm, array, func);
 }
 
 #define CENTAUR_CPUID_SIGNATURE 0xC0000000
 
-static int get_cpuid_func(struct kvm_cpuid_array *array, u32 func,
-			  unsigned int type)
+static int get_cpuid_func(struct kvm *kvm, struct kvm_cpuid_array *array,
+			  u32 func, unsigned int type)
 {
 	u32 limit;
 	int r;
@@ -1972,13 +1970,13 @@ static int get_cpuid_func(struct kvm_cpuid_array *array, u32 func,
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 0;
 
-	r = do_cpuid_func(array, func, type);
+	r = do_cpuid_func(kvm, array, func, type);
 	if (r)
 		return r;
 
 	limit = array->entries[array->nent - 1].eax;
 	for (func = func + 1; func <= limit; ++func) {
-		r = do_cpuid_func(array, func, type);
+		r = do_cpuid_func(kvm, array, func, type);
 		if (r)
 			break;
 	}
@@ -2042,7 +2040,7 @@ int kvm_vm_ioctl_get_cpuid(struct kvm *kvm, struct kvm_cpuid2 *cpuid,
 	array.maxnent = cpuid->nent;
 
 	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
-		r = get_cpuid_func(&array, funcs[i], type);
+		r = get_cpuid_func(kvm, &array, funcs[i], type);
 		if (r)
 			goto out_free;
 	}
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 0afde541b036..eae46f37d30f 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -117,7 +117,8 @@ static inline bool page_address_valid(struct kvm_vcpu *vcpu, gpa_t gpa)
 	return kvm_vcpu_is_legal_aligned_gpa(vcpu, gpa, PAGE_SIZE);
 }
 
-static __always_inline void cpuid_entry_override(struct kvm_cpuid_entry2 *entry,
+static __always_inline void cpuid_entry_override(struct kvm *kvm,
+						 struct kvm_cpuid_entry2 *entry,
 						 unsigned int leaf)
 {
 	u32 *reg = cpuid_entry_get_reg(entry, leaf * 32);
@@ -241,16 +242,16 @@ static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature, u32 overla
 	}
 }
 
-static __always_inline u32 kvm_cpu_cap_get(unsigned int x86_feature)
+static __always_inline u32 kvm_cpu_cap_get(struct kvm *kvm, unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
 	return kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] & __feature_bit(x86_feature);
 }
 
-static __always_inline bool kvm_cpu_cap_has(unsigned int x86_feature)
+static __always_inline bool kvm_cpu_cap_has(struct kvm *kvm, unsigned int x86_feature)
 {
-	return !!kvm_cpu_cap_get(x86_feature);
+	return !!kvm_cpu_cap_get(kvm, x86_feature);
 }
 
 static __always_inline void kvm_cpu_cap_check_and_set(unsigned int x86_feature, u32 overlay_mask)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 961804df5f45..4b8eb1ff3c1d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1182,13 +1182,13 @@ void svm_copy_vmrun_state(struct vmcb_save_area *to_save,
 	to_save->rip = from_save->rip;
 	to_save->cpl = 0;
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK)) {
 		to_save->s_cet  = from_save->s_cet;
 		to_save->isst_addr = from_save->isst_addr;
 		to_save->ssp = from_save->ssp;
 	}
 
-	if (kvm_cpu_cap_has(X86_FEATURE_LBRV)) {
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_LBRV)) {
 		svm_copy_lbrs(to_save, from_save);
 		to_save->dbgctl &= ~DEBUGCTL_RESERVED_BITS;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7d1289f34f9f..2b4a17536580 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -833,7 +833,7 @@ static void svm_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		svm_disable_intercept_for_msr(vcpu, MSR_IA32_MPERF, MSR_TYPE_R);
 	}
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_SHSTK)) {
 		bool shstk_enabled = guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
 
 		svm_set_intercept_for_msr(vcpu, MSR_IA32_U_CET, MSR_TYPE_RW, !shstk_enabled);
@@ -1029,7 +1029,7 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 	 * Intercept INVPCID if shadow paging is enabled to sync/free shadow
 	 * roots, or if INVPCID is disabled in the guest to inject #UD.
 	 */
-	if (kvm_cpu_cap_has(X86_FEATURE_INVPCID)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_INVPCID)) {
 		if (!npt_enabled ||
 		    !guest_cpu_cap_has(&svm->vcpu, X86_FEATURE_INVPCID))
 			svm_set_intercept(svm, INTERCEPT_INVPCID);
@@ -1037,7 +1037,7 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 			svm_clr_intercept(svm, INTERCEPT_INVPCID);
 	}
 
-	if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_RDTSCP)) {
 		if (guest_cpu_cap_has(vcpu, X86_FEATURE_RDTSCP))
 			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
 		else
@@ -5510,7 +5510,7 @@ static __init void svm_set_cpu_caps(void)
 			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE, F_CPUID_DEFAULT);
 
 		if (kvm_pmu_cap.version != 2 ||
-		    !kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE))
+		    !kvm_cpu_cap_has(NULL, X86_FEATURE_PERFCTR_CORE))
 			kvm_cpu_cap_clear(X86_FEATURE_PERFMON_V2, F_CPUID_DEFAULT);
 	}
 
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index fa41d036acd4..302f7953b939 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -38,7 +38,7 @@ uint16_t nested_get_evmcs_version(struct kvm_vcpu *vcpu)
 	 * Note, do not check the Hyper-V is fully enabled in guest CPUID, this
 	 * helper is used to _get_ the vCPU's supported CPUID.
 	 */
-	if (kvm_cpu_cap_get(X86_FEATURE_VMX) &&
+	if (kvm_cpu_cap_get(NULL, X86_FEATURE_VMX) &&
 	    (!vcpu || to_vmx(vcpu)->nested.enlightened_vmcs_enabled))
 		return (KVM_EVMCS_VERSION << 8) | 1;
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3fe88f29be7a..d7841038edfc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7132,8 +7132,8 @@ static void nested_vmx_setup_exit_ctls(struct vmcs_config *vmcs_conf,
 		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT |
 		VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
 
-	if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
-	    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+	if (!kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK) &&
+	    !kvm_cpu_cap_has(NULL, X86_FEATURE_IBT))
 		msrs->exit_ctls_high &= ~VM_EXIT_LOAD_CET_STATE;
 
 	/* We support free control of debug control saving. */
@@ -7157,8 +7157,8 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
 
-	if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
-	    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+	if (!kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK) &&
+	    !kvm_cpu_cap_has(NULL, X86_FEATURE_IBT))
 		msrs->entry_ctls_high &= ~VM_ENTRY_LOAD_CET_STATE;
 
 	/* We support free control of debug control loading. */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fae6b33949f5..d6d32f3d162b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4268,7 +4268,7 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 	vmx_set_intercept_for_msr(vcpu, MSR_IA32_SPEC_CTRL, MSR_TYPE_RW,
 				  !to_vmx(vcpu)->spec_ctrl);
 
-	if (kvm_cpu_cap_has(X86_FEATURE_XFD))
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_XFD))
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_XFD_ERR, MSR_TYPE_R,
 					  !guest_cpu_cap_has(vcpu, X86_FEATURE_XFD));
 
@@ -4280,7 +4280,7 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_FLUSH_CMD, MSR_TYPE_W,
 					  !guest_cpu_cap_has(vcpu, X86_FEATURE_FLUSH_L1D));
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_SHSTK)) {
 		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
 
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL0_SSP, MSR_TYPE_RW, intercept);
@@ -4289,7 +4289,8 @@ static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
 		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PL3_SSP, MSR_TYPE_RW, intercept);
 	}
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK) || kvm_cpu_cap_has(X86_FEATURE_IBT)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_SHSTK) ||
+	    kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_IBT)) {
 		intercept = !guest_cpu_cap_has(vcpu, X86_FEATURE_IBT) &&
 			    !guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK);
 
@@ -5031,12 +5032,12 @@ void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 
 	vmcs_write32(VM_ENTRY_INTR_INFO_FIELD, 0);  /* 22.2.1 */
 
-	if (kvm_cpu_cap_has(X86_FEATURE_SHSTK)) {
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_SHSTK)) {
 		vmcs_writel(GUEST_SSP, 0);
 		vmcs_writel(GUEST_INTR_SSP_TABLE, 0);
 	}
-	if (kvm_cpu_cap_has(X86_FEATURE_IBT) ||
-	    kvm_cpu_cap_has(X86_FEATURE_SHSTK))
+	if (kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_IBT) ||
+	    kvm_cpu_cap_has(vcpu->kvm, X86_FEATURE_SHSTK))
 		vmcs_writel(GUEST_S_CET, 0);
 
 	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 525fcb09a4c0..4f713afd909a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7672,33 +7672,33 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 			return;
 		break;
 	case MSR_TSC_AUX:
-		if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP) &&
-		    !kvm_cpu_cap_has(X86_FEATURE_RDPID))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_RDTSCP) &&
+		    !kvm_cpu_cap_has(NULL, X86_FEATURE_RDPID))
 			return;
 		break;
 	case MSR_IA32_UMWAIT_CONTROL:
-		if (!kvm_cpu_cap_has(X86_FEATURE_WAITPKG))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_WAITPKG))
 			return;
 		break;
 	case MSR_IA32_RTIT_CTL:
 	case MSR_IA32_RTIT_STATUS:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_INTEL_PT))
 			return;
 		break;
 	case MSR_IA32_RTIT_CR3_MATCH:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_INTEL_PT) ||
 		    !intel_pt_validate_hw_cap(PT_CAP_cr3_filtering))
 			return;
 		break;
 	case MSR_IA32_RTIT_OUTPUT_BASE:
 	case MSR_IA32_RTIT_OUTPUT_MASK:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_INTEL_PT) ||
 		    (!intel_pt_validate_hw_cap(PT_CAP_topa_output) &&
 		     !intel_pt_validate_hw_cap(PT_CAP_single_range_output)))
 			return;
 		break;
 	case MSR_IA32_RTIT_ADDR0_A ... MSR_IA32_RTIT_ADDR3_B:
-		if (!kvm_cpu_cap_has(X86_FEATURE_INTEL_PT) ||
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_INTEL_PT) ||
 		    (msr_index - MSR_IA32_RTIT_ADDR0_A >=
 		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
 			return;
@@ -7725,12 +7725,12 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
-		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_PERFMON_V2))
 			return;
 		break;
 	case MSR_IA32_XFD:
 	case MSR_IA32_XFD_ERR:
-		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_XFD))
 			return;
 		break;
 	case MSR_IA32_TSX_CTRL:
@@ -7743,16 +7743,16 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		break;
 	case MSR_IA32_U_CET:
 	case MSR_IA32_S_CET:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
-		    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK) &&
+		    !kvm_cpu_cap_has(NULL, X86_FEATURE_IBT))
 			return;
 		break;
 	case MSR_IA32_INT_SSP_TAB:
-		if (!kvm_cpu_cap_has(X86_FEATURE_LM))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_LM))
 			return;
 		fallthrough;
 	case MSR_IA32_PL0_SSP ... MSR_IA32_PL3_SSP:
-		if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK))
+		if (!kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK))
 			return;
 		break;
 	default:
@@ -10026,11 +10026,11 @@ static struct notifier_block pvclock_gtod_notifier = {
 
 void kvm_setup_xss_caps(void)
 {
-	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
+	if (!kvm_cpu_cap_has(NULL, X86_FEATURE_XSAVES))
 		kvm_caps.supported_xss = 0;
 
-	if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
-	    !kvm_cpu_cap_has(X86_FEATURE_IBT))
+	if (!kvm_cpu_cap_has(NULL, X86_FEATURE_SHSTK) &&
+	    !kvm_cpu_cap_has(NULL, X86_FEATURE_IBT))
 		kvm_caps.supported_xss &= ~XFEATURE_MASK_CET_ALL;
 
 	if ((kvm_caps.supported_xss & XFEATURE_MASK_CET_ALL) != XFEATURE_MASK_CET_ALL) {
@@ -10043,13 +10043,13 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_setup_xss_caps);
 
 static void kvm_setup_efer_caps(void)
 {
-	if (kvm_cpu_cap_has(X86_FEATURE_NX))
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_NX))
 		kvm_enable_efer_bits(EFER_NX);
 
-	if (kvm_cpu_cap_has(X86_FEATURE_FXSR_OPT))
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_FXSR_OPT))
 		kvm_enable_efer_bits(EFER_FFXSR);
 
-	if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
+	if (kvm_cpu_cap_has(NULL, X86_FEATURE_AUTOIBRS))
 		kvm_enable_efer_bits(EFER_AUTOIBRS);
 }
 
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..45534d863bbe 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -320,7 +320,7 @@ static inline u8 vcpu_virt_addr_bits(struct kvm_vcpu *vcpu)
 
 static inline u8 max_host_virt_addr_bits(void)
 {
-	return kvm_cpu_cap_has(X86_FEATURE_LA57) ? 57 : 48;
+	return kvm_cpu_cap_has(NULL, X86_FEATURE_LA57) ? 57 : 48;
 }
 
 /*
-- 
2.46.0

