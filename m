Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457892;
	b=V6K984DoaRK7DrqB4tkNyR9LCvTVuYOdC+Dk9spHAMtcMi/aSTO4Um8lg3EQX0PzGFqS
	 Km0G3EnvvqcSyH/ppVt1ErM0micqGte2BwEGVhPsTydg+gd/J896ZgcbePN+5QpQhyeHz
	 HjBH0YUI8An0sWR0SrzeoqupxbcPTaFyTbaw+JN9fBYvung6F+Up0J8RFhHM49UkJVz1d
	 hJo27tB0a6ityVNF+JaEFjQWKrG8L95zVAyYm/PfugwX+3mSAp89s2q6Y5apKkWs77W4t
	 II2fN/juvi/e2P7qnQC40g1HP2/KIjPGYozk5L09KYfShOYFHWdXx/i2vs7f9B4Zq0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457892;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8ddN5ZA29Ts2hTnH3cvKyYmTCkEzZCs049kB7I7V2l8=;
	b=4RTmQDjip33mgAPm3bNGbOS0JcQ40vRCHrmTT2wPCCfBd2Rtf5/YrJnO2bzVysxT4bzb
	 91/6e4bvAD98sx5ZRzNQGnwtvkHLycVFjhRdpP6VJIun8oqc+0UTzSoRAsjLAM+spYmCC
	 A05RsRU4HAjZJyup2uHwggnYXQ2hawkpFlWyCZaPasMfq5YZTfEmWa/9EmU4zadxkq+8v
	 kzPq7kdMM4r1Tp4oN8OWn1z8JmzAt7kgv7JWYE3sjfga9YgUV7bFtEUoCBhEhkJUZyn04
	 mkb13DqgxpWaWxcyKZ89NXBljWVo6JYoZ30GiTXBbLJWXAuRTaUNvgXlin5DmJjT3Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FxMn6PbQ;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A04606AE05;
	Mon, 23 Nov 2026 18:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A04606AE05
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FxMn6PbQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457892; x=1826993892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QQOeZx3PshKrdiTHfxbpnU2vc62voj3HDAU3ca8Xr8I=;
  b=FxMn6PbQPXrsWnCJzrhTAZP9cHG0s7fg7DZkXXNXWDutp/2yucO+V33K
   P4WzN0zGi6Wx5DcvKKcTtjNO2p0Sly6sMH1vVrK5LLya950xLWpwbodjw
   0kWCwtRf4JPEksGG6McS+p3acN33Eseigw9Y3UPQ2dkqLoaOC0meUiy3d
   T6PLGPuJLmhOtJpVW0IyecHlaXR2ivb3VpQn/m51XX35jCy55sJ1S1Ym0
   3M5cn+FtLPWPbiu3T4DpyLQW7GTzAl6e/ceNbeaOh4axCJNMV/SlWftjU
   rUpGJiE1z9DiudHNTDRBUdw4IkkTaijO3w7smjYmUugYdhNdfUtYB3bCg
   w==;
X-CSE-ConnectionGUID: 3txNZMHRSii8tKYPhesOTg==
X-CSE-MsgGUID: WsIgaiPrRAyqRhUS7iRQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288901"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:36 -0800
X-CSE-ConnectionGUID: u8mNMD6YSdmYs+gAURmZ1g==
X-CSE-MsgGUID: hCeQsZGMRr6s1xC6eI/O3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241177"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:36 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 18/20] KVM: x86: Expose APX feature to userspace
Date: Mon, 23 Nov 2026 17:37:30 +0000
Message-ID: <20261123173732.1072124-19-chang.seok.bae@intel.com>
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

Expose the APX feature and its sub-features to userspace. Add support for
CPUID leaf 0x29, sub-leaf 0, to enumerate the APX sub-features.

On SVM or when using eVMCS, do not advertise APX, as EGPR support is not
implemented yet.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V9 -> V10: Collect a review tag
---
 arch/x86/include/asm/cpuid/api.h |  1 +
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/kvm/cpuid.c             | 21 ++++++++++++++++++++-
 arch/x86/kvm/reverse_cpuid.h     |  4 ++++
 arch/x86/kvm/svm/svm.c           |  1 +
 arch/x86/kvm/vmx/vmx.c           |  4 ++++
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 759b12d94bbf..80402959804f 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -183,6 +183,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1f:
 	case 0x23:
 	case 0x24:
+	case 0x29:
 	case 0x8000001d:
 		return true;
 	}
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 327d26e38cbc..abf73bd75bd1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -729,6 +729,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_29_0_EBX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f476a78a570a..2fa48efb1caa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1049,8 +1049,12 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX_VNNI_INT16),
 		F(PREFETCHITI),
 		F(AVX10),
+		SCATTERED_F(APX),
 	);
 
+	if (!IS_ENABLED(CONFIG_KVM_APX))
+		kvm_cpu_cap_clear(X86_FEATURE_APX);
+
 	kvm_cpu_cap_init(CPUID_7_2_EDX,
 		F(INTEL_PSFD),
 		F(IPRED_CTRL),
@@ -1095,6 +1099,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX10_V1_AUX),
 	);
 
+	kvm_cpu_cap_init(CPUID_29_0_EBX,
+		F(APX_NCI_NDD_NF),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
 		F(LAHF_LM),
 		F(CMP_LEGACY),
@@ -1463,7 +1471,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1734,6 +1742,17 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	}
+	/* APX sub-features */
+	case 0x29:
+		if (!kvm_cpu_cap_has(X86_FEATURE_APX)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+		cpuid_entry_override(entry, CPUID_29_0_EBX);
+		entry->eax = 0;
+		entry->ecx = 0;
+		entry->edx = 0;
+		break;
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 1ff87fe63c3c..9a4445138a8f 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -69,6 +69,9 @@
 /* Intel-defined sub-features, CPUID level 0x00000024:1 (ECX) */
 #define X86_FEATURE_AVX10_V1_AUX	KVM_X86_FEATURE(CPUID_24_1_ECX, 2)
 
+/* Intel-defined sub-features, CPUID level 0x00000029:0 (EBX) */
+#define X86_FEATURE_APX_NCI_NDD_NF	KVM_X86_FEATURE(CPUID_29_0_EBX, 0)
+
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
@@ -112,6 +115,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
 	[CPUID_24_1_ECX]      = {      0x24, 1, CPUID_ECX},
+	[CPUID_29_0_EBX]      = {      0x29, 0, CPUID_EBX},
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5ef785811e3f..074c8dab7420 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5730,6 +5730,7 @@ static __init void svm_set_cpu_caps(void)
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	/*
 	 * LBR Virtualization must be enabled to support BusLockTrap inside the
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3c1d4629a00c..1ef1fbc95982 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8023,6 +8023,10 @@ static __init void vmx_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_set(X86_FEATURE_EFER_LMSLE_MBZ);
 
+	/* eVMCS isn't prepared yet for APX */
+	if (kvm_is_using_evmcs())
+		kvm_cpu_cap_clear(X86_FEATURE_APX);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
-- 
2.53.0

