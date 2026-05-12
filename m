Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5892C21D8;
	Tue, 12 May 2026 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550042; cv=none; b=Lk5ZqHPu0f/3mnXy2VEcA9SG46DYqZervke5zxjO9nC2rjp7saa9o8rfEO8k7B9zwzBkGv2RA85rkbIyS0p3YNiknsxB9XqcmKTpYPy7b6HWOYZATkEJXXJpD0QwE/9bL7/kw+yrPjHCjZgaU8S39hicYf2xn78APNaplsXqU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550042; c=relaxed/simple;
	bh=iHeLqSbW5PSKY8Pf60SklfQv9r5k5HtSoB3mqhVGP+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldQzE0rD8Wm54dw19jaTuDo2kVf+2lyJtAsHiRmsPFUX+ioP14dS2OSYeWFY530WpgO8o7aLpNihR6/J841+RVhmyoKhZ8wn+YQj3SB17HYeZf6TX4RuzDMj6Udy2K+k89gEQGL0zFwYaqksUyS4ux899fP6HoBLU2Ek/gNeFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M7mwa91B; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M7mwa91B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550040; x=1810086040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHeLqSbW5PSKY8Pf60SklfQv9r5k5HtSoB3mqhVGP+0=;
  b=M7mwa91BPN43GDJBNHYu8zWC11KYQ5TedrvZ/Ublr966B8808sTRwfgR
   qgCGGPaQOqHgeJBnx52D7terOx2SdYNM71wEmqmN7h8Oh2BKgkPbIkRvC
   b5EihNnh4ouUn+SiVY6AT/Z8y++W9dyM/34PmZN1jvSME9goQitTMvxro
   XnkKdNdNhyo8+nQrt3kPmjVSDOao0eAXI/CtxiPCAABTkon/eyUuguIOa
   x6GZGv4+yYydD7Sl87E3/XkP/WAp5mVgeXNu4hAdjzpdwatG7f6bsnyD8
   m07KS7yqK3lfOrf2mtTJMvkUH9PvpU26RoJWx8mapEsoA0pNEtjF5QxZz
   Q==;
X-CSE-ConnectionGUID: goXqGNZvRbqQCNJtu8IL5w==
X-CSE-MsgGUID: kmRfYrm9TK+dWbJiRZO27w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322188"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322188"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:32 -0700
X-CSE-ConnectionGUID: bUi6CLeRRoyvAv52oqcRGg==
X-CSE-MsgGUID: xxnZy0AVRzK+DwUVjsrEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572829"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:31 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v4 18/21] KVM: x86: Expose APX foundation feature to guests
Date: Tue, 12 May 2026 01:14:59 +0000
Message-ID: <20260512011502.53072-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the APX xfeature bit to the list of supported XCR0 components and
expose the APX feature to guests. Update the maximum supported CPUID leaf
to 0x29 to include the APX leaf.

On SVM, do not advertise APX, as EGPR support is not yet implemented.

No APX sub-features are enumerated yet. Those will be exposed in a
separate patch.

Originally-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/cpuid.c   | 11 ++++++++++-
 arch/x86/kvm/svm/svm.c |  1 +
 arch/x86/kvm/x86.c     |  8 +++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 82cb7c8fbc07..21dd3dac4211 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1061,8 +1061,12 @@ void kvm_initialize_cpu_caps(void)
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
@@ -1441,7 +1445,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1712,6 +1716,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	}
+	/* APX sub-features */
+	case 0x29: {
+		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		break;
+	}
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 85d4087ea927..84496bc0508d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5554,6 +5554,7 @@ static __init void svm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f5f27e7b00b6..fc0924389398 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -219,10 +219,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
 static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
 static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
 
+#ifndef CONFIG_KVM_APX
+#undef  XFEATURE_MASK_APX
+#define XFEATURE_MASK_APX 0
+#endif
+
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
+				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE \
+				| XFEATURE_MASK_APX)
 
 #define XFEATURE_MASK_CET_ALL	(XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
 /*
-- 
2.51.0

