Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457887;
	b=U7ydvWG6RT6DZpa9EWfla76b8B1FKX1LYijcbPL/gR/j0robF85EBscjWemuKTYSN7fu
	 ZlfuzPG8QYFZ3HsGtnKvRlLrXCOepYzB6FY+yyl+WPsN+r/p8CO1+expfNupIjeG50Y4Q
	 DjSLZxh8c7XfO2l8liMYo39WfuwepONoBZ2xkP93uQ9rwGyEcsR0P3UxkBg4+0dvr2FAc
	 y6xixqq8fRyfJW8Qdv7UQi6kvPfLpWvj23FInIY7Q3Y3ojFAje1M9S40n8vmhNVNHupbX
	 ZbL6BtCXXAGtmdhpXhAJnmg0mTbwSigjHOJr5ECIPYJZxJhcwohYoGany27N2fuKoew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457887;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C+OKCbCj/+FwUPoRIhHBUdDtkYKPRH1IZOXEOlJa3W0=;
	b=KWYviQf87+cQwAXOyQEm6domdkDVonR+fbqzktoX37C18t4mycqBOyWPUNVWUTo+VKSo
	 uAOcJwDTQePizVxZ0Zyx85yBzpIqJsMLJAWQSTrOwfShgQo2yf7q+gRXVv+fnove9+Jz4
	 ApoDekZV5V1DoBnFu3YpuhXTzdtJj7AhRQFxNBhVveYmIpaMGbEsAkuZUQdXNTZ5vB9PK
	 EhbGhN2hfmuiwREt/HAmKytNoiAZxNSgbaWlYwR8nl0zjTwcU/8QFetqyFoWyhqmtVwg8
	 jAyibwEm1GHA60ss6dHPE0opavrAoIRr9kkIxe2fqPzETUUxcL+wK0eunttvnaktjfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oCaLoOLe;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE760A381C;
	Mon, 23 Nov 2026 18:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87EE760A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oCaLoOLe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457886; x=1826993886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i64rSDZA8SFqBOxQjbPrImmjqt4k6OIVrfJ8IrD+l/I=;
  b=oCaLoOLeNqDRU4z83B3QJKAZCFvTK3J2ZUQetz6KAcdteL9pXTtOjB6u
   RhnH2FuAWs+hR5LOjbN0N/qTeiJ1uPIekKoJMg8qiT4k1QV+71+zhgrx0
   R640mZQBlnE0uioj2aNchj3eArtHtCV5m5XI6353aFCgS6iKUCeFL7YKz
   hVWecH2D6POROjG6Oodx1Aflm3R1icVJDH+3CKyZHy8TU756Rvtx0v1x1
   GXXXoePP5KZkblyCntRoSz8WRnP1BeKQwRmKqk27jUgeoxBINdVXXqPcf
   D89tGycsMFrSCfWlRuyjujNJb0EvHz+uTmWmoSkIiF2WTyTeItwictFnw
   w==;
X-CSE-ConnectionGUID: OqarNx+vRw6tyOflIWAvkQ==
X-CSE-MsgGUID: XCgbZY0KQSqyWJ4NRkWg/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288829"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288829"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:21 -0800
X-CSE-ConnectionGUID: F7hFg7AJR12h1odLSvB7Mg==
X-CSE-MsgGUID: NvrUq5imSRSnW+hTKOpj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241133"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:21 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com,
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH v10 10/20] KVM: nVMX: Propagate extended instruction information
Date: Mon, 23 Nov 2026 17:37:22 +0000
Message-ID: <20261123173732.1072124-11-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the new extended_instruction_info field in struct vmcs12 and
propagate it to nested VMX. Gate the propagation on the guest APX
enumeration, which aligns with bare metal behavior. Thus, define the
CPUID bit here too.

Suggested-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/aRvOSnaUt1E+%2FpkC@intel.com
---
V9 -> V10: Collect a review tag
---
 arch/x86/kvm/reverse_cpuid.h | 2 ++
 arch/x86/kvm/vmx/nested.c    | 3 +++
 arch/x86/kvm/vmx/vmcs12.c    | 4 ++++
 arch/x86/kvm/vmx/vmcs12.h    | 3 ++-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 89345af0f7ad..1ff87fe63c3c 100644
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
index aebdad142d67..3899d50b3e64 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4751,6 +4751,9 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 		vmcs12->vm_exit_intr_info = exit_intr_info;
 		vmcs12->vm_exit_instruction_len = exit_insn_len;
 		vmcs12->vmx_instruction_info = vmcs_read32(VMX_INSTRUCTION_INFO);
+		/* The extended field exists whenever APX is enumerated. */
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_APX))
+			vmcs12->extended_instruction_info = vmcs_read64(EXTENDED_INSTRUCTION_INFO);
 
 		/*
 		 * According to spec, there's no need to store the guest's
diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
index 1ebe67c384ad..dc6a22db7388 100644
--- a/arch/x86/kvm/vmx/vmcs12.c
+++ b/arch/x86/kvm/vmx/vmcs12.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include "vmcs12.h"
+#include "vmx_ops.h"
 
 #define VMCS12_OFFSET(x) offsetof(struct vmcs12, x)
 #define FIELD(number, name)	[ENC_TO_VMCS12_IDX(number)] = VMCS12_OFFSET(name)
@@ -53,6 +54,7 @@ static const u16 kvm_supported_vmcs12_field_offsets[] __initconst = {
 	FIELD64(XSS_EXIT_BITMAP, xss_exit_bitmap),
 	FIELD64(ENCLS_EXITING_BITMAP, encls_exiting_bitmap),
 	FIELD64(GUEST_PHYSICAL_ADDRESS, guest_physical_address),
+	FIELD64(EXTENDED_INSTRUCTION_INFO, extended_instruction_info),
 	FIELD64(VMCS_LINK_POINTER, vmcs_link_pointer),
 	FIELD64(GUEST_IA32_DEBUGCTL, guest_ia32_debugctl),
 	FIELD64(GUEST_IA32_PAT, guest_ia32_pat),
@@ -203,6 +205,8 @@ static __init bool cpu_has_vmcs12_field(unsigned int idx)
 	case HOST_SSP:
 	case HOST_INTR_SSP_TABLE:
 		return cpu_has_load_cet_ctrl();
+	VMCS12_CASE64(EXTENDED_INSTRUCTION_INFO):
+		return vmx_instr_info_extended();
 
 	/* KVM always emulates PML and the VMX preemption timer in software. */
 	case GUEST_PML_INDEX:
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

