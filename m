Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45160376469
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411155; cv=none; b=D0qgScRqhsYXwv/SkqmHIXt3tVgQNIX0Iivtki+cq6D+A8qsN8PGbu61/gnglZEQPmO+AlmKQMbiqLo1tKqy0IdODhDlCso5Ykm/tYZN3TC11xwaQmZQvMR0RVaKt/s6MWPmhe9G051wd9sEd7DmUQGOgAVuvi2i3QtEHC1SDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411155; c=relaxed/simple;
	bh=jn3GChMgnzMSoEvJVToPFCe08KgUvZDWpR/Avotu/Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI75Z23RcUvjyTRunSozRaAKibcFMU/gHeycVwc6voBJXOlGus4Zf4zUyU9/tDBvxyDxnMt/da5povwlmxshB8jSX9C62r/xim+Jrp30Zd49vhiDJa2bUTgLhwqaTzjhLtVcDs/UBLVjhCrDvAK8MRChZ9cfkWxT/jI4/lfsDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dhdf1+UL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dhdf1+UL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411154; x=1807947154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jn3GChMgnzMSoEvJVToPFCe08KgUvZDWpR/Avotu/Po=;
  b=Dhdf1+ULKVb2vQXRnXMja678dRQnhzMmq7m4Xfl0XmRwUdYwmUT9pb0D
   PtEIR2/lAeITwl5074YK1tB2WE1MUbEL4zbdKkpMDM8ioR3IuPGDcrgjM
   bpNO6/jEeq5Rg+uZf8KYIx37VmhLuhbjWE3UwCxauN2qudF80hqGPlj5Y
   0XqgaCNNrVn2KBATX4ufpUe+R16lbIUckAtdFG/k9zw65CcrOOMvBUeNc
   wXkZJzz3F2bkq78rQTJwuo3QJmBYGHA4/W945cMV1PRhl8L5EDfKCBafp
   DggQINC6DOlFtp+AlQzaTDLx+Ffa8XT06A3FF5D1RevusilSE2H53s9oN
   w==;
X-CSE-ConnectionGUID: jM3sKKJbTx2KNgGQLqvIyw==
X-CSE-MsgGUID: o1/NsS4KTEaCBu802Xlf8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070213"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070213"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:29 -0700
X-CSE-ConnectionGUID: 7hj6nMSXT/WNGLFG6NK9tg==
X-CSE-MsgGUID: DTVDGOTsQ7uPCa90F4AdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284939"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:27 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 12/27] KVM: x86: Split KVM CPU cap leafs into two parts
Date: Fri, 17 Apr 2026 15:35:55 +0800
Message-ID: <20260417073610.3246316-13-binbin.wu@linux.intel.com>
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

Introduce NR_KVM_CPU_CAPS_PARANOID as the total number of KVM CPUID
leafs, distinct from NR_KVM_CPU_CAPS which denotes only the leafs
tracked in the per-vCPU cpu_caps[] array.

The number of per-overlay leafs in the global kvm_cpu_caps[][] array is
extended to NR_KVM_CPU_CAPS_PARANOID so that it can hold both CPUID
leafs queried by KVM during vCPU runtime and additional leafs used
exclusively for CPUID paranoid mode validation.  The per-vCPU
cpu_caps[] array in kvm_vcpu_arch remains sized to NR_KVM_CPU_CAPS,
since KVM only cares these leaves during vCPU running and should not
grow when paranoid-mode-only leaves are added.

Add BUILD_BUG_ON() for guest_cpu_cap_{set, clear, has}() to prevent
accidental out-of-bounds access to the per-vCPU array with leaves that
are only present in the global array.

No functional change, as NR_KVM_CPU_CAPS_PARANOID == NR_KVM_CPU_CAPS
until paranoid-only leaves are introduced.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/include/asm/kvm_host.h | 13 +++++++++----
 arch/x86/kvm/cpuid.c            |  4 ++--
 arch/x86/kvm/cpuid.h            |  5 ++++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..75895ab569fb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -774,9 +774,12 @@ struct kvm_queued_exception {
 };
 
 /*
- * Hardware-defined CPUID leafs that are either scattered by the kernel or are
- * unknown to the kernel, but need to be directly used by KVM.  Note, these
- * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
+ * The leafs before NR_KVM_CPU_CAPS are hardware-defined CPUID leafs that are
+ * either scattered by the kernel or are unknown to the kernel, but need to be
+ * directly used by KVM during vCPU running.  Note, these word values conflict
+ * with the kernel's "bug" caps, but KVM doesn't use those.
+ * The leafs from NR_KVM_CPU_CAPS and above are only used for validation of
+ * CPUID inputs from userspace in CPUID paranoid mode.
  */
 enum kvm_only_cpuid_leafs {
 	CPUID_12_EAX	 = NCAPINTS,
@@ -789,9 +792,11 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	/* End of the leafs tracked by per-vcpu caps. */
 	NR_KVM_CPU_CAPS,
+	NR_KVM_CPU_CAPS_PARANOID = NR_KVM_CPU_CAPS,
 
-	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
+	NKVMCAPINTS = NR_KVM_CPU_CAPS_PARANOID - NCAPINTS,
 };
 
 struct kvm_vcpu_arch {
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 71959f4918e7..78d8f89d6079 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -33,7 +33,7 @@
  * Unlike "struct cpuinfo_x86.x86_capability", kvm_cpu_caps doesn't need to be
  * aligned to sizeof(unsigned long) because it's not accessed via bitops.
  */
-u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS] __read_mostly;
+u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS_PARANOID] __read_mostly;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_cpu_caps);
 
 bool kvm_is_configuring_cpu_caps __read_mostly;
@@ -382,7 +382,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	int i;
 
 	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
-	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS);
+	BUILD_BUG_ON(ARRAY_SIZE(reverse_cpuid) != NR_KVM_CPU_CAPS_PARANOID);
 
 	/*
 	 * Reset guest capabilities to userspace's guest CPUID definition, i.e.
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index c3f2417c7980..bdfaedb1cfcc 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -31,7 +31,7 @@ static inline u8 get_cpuid_overlay(struct kvm *kvm)
 	return CPUID_OL_VMX;
 }
 
-extern u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS] __read_mostly;
+extern u32 kvm_cpu_caps[NR_CPUID_OL][NR_KVM_CPU_CAPS_PARANOID] __read_mostly;
 extern bool kvm_is_configuring_cpu_caps __read_mostly;
 
 void kvm_initialize_cpu_caps(void);
@@ -273,6 +273,7 @@ static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
+	BUILD_BUG_ON(x86_leaf >= NR_KVM_CPU_CAPS);
 	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
@@ -281,6 +282,7 @@ static __always_inline void guest_cpu_cap_clear(struct kvm_vcpu *vcpu,
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
+	BUILD_BUG_ON(x86_leaf >= NR_KVM_CPU_CAPS);
 	vcpu->arch.cpu_caps[x86_leaf] &= ~__feature_bit(x86_feature);
 }
 
@@ -299,6 +301,7 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
+	BUILD_BUG_ON(x86_leaf >= NR_KVM_CPU_CAPS);
 	/*
 	 * Except for MWAIT, querying dynamic feature bits is disallowed, so
 	 * that KVM can defer runtime updates until the next CPUID emulation.
-- 
2.46.0

