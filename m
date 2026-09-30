Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0852844E;
	Wed, 30 Sep 2026 21:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804106; cv=none; b=W3TUEquQAVTw1P+/t4Sl3QdXx9ZjaTyVdbgMpcIdOWJTeAEeJd2eaNTZwkmCFWvwKy6Fx4xnJb8HGyNmFUsE7/ZosMXitXyGA3im+QxYJzHFRIFYG9ewnUrbbJxtY2DqwUnva42Mr1K15cK1tBqeQQBXThncmRrymcNwYSWdJ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804106; c=relaxed/simple;
	bh=wfTnKDNq1hpNV7kNb/zioEuIYiglvTf9CTXZb65A/eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qe8x9h5VkcguDty8JPHkgbxKTnh0M3AhtMi1cVvSMCkD1IpQ2i0ucqzvpyXoI77s45r66QJPa8kQcElAi+zQmmp+F8jp0woHS5sHsPaAv/WifMhHfzIwHFbRi2v9Ja7jluFLl38i89FQwPOv3tIqI/YpYeuXnBP4LVnoVWN7pe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAITGcq6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAITGcq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804105; x=1822340105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wfTnKDNq1hpNV7kNb/zioEuIYiglvTf9CTXZb65A/eA=;
  b=AAITGcq6s93sO6XvGVlY2gRdPyW8q/7V17VBzL38dc0mPmBywDABqm0D
   hLvGX2G6vYzy0JE1pJtSYwmpH3JL509kIfsBonfE4OSo8uUeVxtw8TFdU
   mDwLw64G5LvvjAwZpLUcJEZ8XjX3LCfDQfw41xWtD8Ouonuh0VdIobaF4
   8nb8jAXomZiQjildm0BBzDljVNm2/unvUL+9Uhxj6SdaxdijLGqI4Vd+Z
   bpeE3ZbQeqT/9vpFgFsMjALkLXVI9NS8OgB9G5o0jp+XkU6LDKpIxYOWW
   RoNWGet7Upv0MAllDKyq8W7rqKvRim60bpXskZmN6iGqNv4ygroGQqgPD
   g==;
X-CSE-ConnectionGUID: nsSM8SnERvyU9wODZKppfQ==
X-CSE-MsgGUID: RDyuq43sRv6X7IhHNQli5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432693"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432693"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:05 -0700
X-CSE-ConnectionGUID: d6fcl/1GTdyMNFDn7FAPUQ==
X-CSE-MsgGUID: 4ZClnL6GQ9aqARMz3GaHpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867294"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:05 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com,
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH v8 09/20] KVM: nVMX: Propagate extended instruction information
Date: Wed, 30 Sep 2026 21:07:39 +0000
Message-ID: <20260930210750.1487547-10-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the new extended_instruction_info field in struct vmcs12 and
propagate it to nested VMX. Gate the propagation on the guest APX
enumeration, which aligns with bare metal behavior. Thus, define the
CPUID bit here too.

Suggested-by: Chao Gao <chao.gao@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com
---
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 arch/x86/kvm/vmx/nested.c    | 6 ++++++
 arch/x86/kvm/vmx/vmcs12.c    | 1 +
 arch/x86/kvm/vmx/vmcs12.h    | 3 ++-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 2ad25781cefb..80b41d5559da 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -37,6 +37,7 @@
 #define X86_FEATURE_AVX_VNNI_INT16      KVM_X86_FEATURE(CPUID_7_1_EDX, 10)
 #define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
 #define X86_FEATURE_AVX10               KVM_X86_FEATURE(CPUID_7_1_EDX, 19)
+#define KVM_X86_FEATURE_APX             KVM_X86_FEATURE(CPUID_7_1_EDX, 21)
 
 /* Intel-defined sub-features, CPUID level 0x00000007:2 (EDX) */
 #define X86_FEATURE_INTEL_PSFD		KVM_X86_FEATURE(CPUID_7_2_EDX, 0)
@@ -146,6 +147,7 @@ static __always_inline u32 __feature_translate(int x86_feature)
 	KVM_X86_TRANSLATE_FEATURE(SGX1);
 	KVM_X86_TRANSLATE_FEATURE(SGX2);
 	KVM_X86_TRANSLATE_FEATURE(SGX_EDECCSSA);
+	KVM_X86_TRANSLATE_FEATURE(APX);
 	KVM_X86_TRANSLATE_FEATURE(CONSTANT_TSC);
 	KVM_X86_TRANSLATE_FEATURE(PERFMON_V2);
 	KVM_X86_TRANSLATE_FEATURE(RRSBA_CTRL);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7229934c38bb..69302b806a98 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4773,6 +4773,12 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmcs12->vm_exit_intr_info = exit_intr_info;
 		vmcs12->vm_exit_instruction_len = exit_insn_len;
 		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+		/*
+		 * The APX enumeration guarantees the presence of the extended
+		 * fields. This CPUID bit alone is sufficient to rely on it.
+		 */
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_APX))
+			vmcs12->extended_instruction_info = vmcs_read64(EXTENDED_INSTRUCTION_INFO);
 
 		/*
 		 * According to spec, there's no need to store the guest's
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 1ebe67c384ad..267aa64f005e 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -53,6 +53,7 @@ static const u16 kvm_supported_vmcs12_field_offsets[] __initconst = {
 	FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
 	FIELD64(ENCLS_EXITING_BITMAP, encls_exiting_bitmap),
 	FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
+	FIELD64(EXTENDED_INSTRUCTION_INFO, extended_instruction_info),
 	FIELD64(VMCS_LINK_POINTER, vmcs_link_pointer),
 	FIELD64(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl),
 	FIELD64(GUEST_IA32_PAT, guest_ia32_pat),
diff --git a/arch/x86/kvm/vmx/vmcs12.h b/arch/x86/kvm/vmx/vmcs12.h
index 21cd1b75e4fd..25e9a41c248f 100644
--- a/arch/x86/kvm/vmx/vmcs12.h
+++ b/arch/x86/kvm/vmx/vmcs12.h
@@ -71,7 +71,7 @@ struct __packed vmcs12 {
 	u64 pml_address;
 	u64 encls_exiting_bitmap;
 	u64 tsc_multiplier;
-	u64 padding64[1]; /* room for future expansion */
+	u64 extended_instruction_info;
 	/*
 	 * To allow migration of L1 (complete with its L2 guests) between
 	 * machines of different natural widths (32 or 64 bit), we cannot have
@@ -261,6 +261,7 @@ static inline void vmx_check_vmcs12_offsets(void)
 	CHECK_OFFSET(pml_address, 312);
 	CHECK_OFFSET(encls_exiting_bitmap, 320);
 	CHECK_OFFSET(tsc_multiplier, 328);
+	CHECK_OFFSET(extended_instruction_info, 336);
 	CHECK_OFFSET(cr0_guest_host_mask, 344);
 	CHECK_OFFSET(cr4_guest_host_mask, 352);
 	CHECK_OFFSET(cr0_read_shadow, 360);
-- 
2.53.0

