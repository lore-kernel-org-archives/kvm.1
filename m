Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E435328A6;
	Wed, 30 Sep 2026 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804116; cv=none; b=hSp5ToZV3OF9L1p2h17IedfsJOSGGtrN+HLyPz4J8imBVuaFyZmQ4gFtQbDwyNTsItIkl36fwlfVyCJ5W2Aff7lvgrgveTZuMO8VxQMiut6eS9GykmFV+M2b4wVN+JBLieZkpzH4iJsmcBHkRcrvobWOrS9XPNfRxNIooPwXWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804116; c=relaxed/simple;
	bh=10xqJ5BcMr0nYEySUs6QsQLTR3mmAjeWtQAIS64uNRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1dnSlEczCpOT9iWcFLulcGGUX1WNJ4SGXLY6am+XiTdtPNxRlZMyECz9CJmeXRikcRLJYqwOoF3uedhgby84G2fsmQeVkl1+fNyh38m7N7/NWmqQ1BuT3Vyjm66pHMpcxV7wxegZlZojh//+4qJJz36qWcG5N1EX8V2vjULBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip0Gfq7C; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip0Gfq7C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804114; x=1822340114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10xqJ5BcMr0nYEySUs6QsQLTR3mmAjeWtQAIS64uNRU=;
  b=ip0Gfq7CnuGW69drt+Gt8buWEaZZ1gR/BgNFAwQLnnDvNU2I1nXNssxH
   azJOR3JRIJB3vPcMO62k4NwhvZW9HRV3iSHqirUH7erloPkNUFkCyyw1F
   TK6BV7RjNsuN554Ld3vac3X4VM5Jc7K/XK9blnoOju5BOyD4zGTdf4of5
   vBqokURnBXfJaDmv659zi82AH2D+sug+PfvAWLjkyrhW75/XHQKS5n5/k
   Yao9TO4SFhCp+fBeAo2a4KEPUVYcPyvbRJrjQamiV0M/wvrW26CZPUIao
   EEn350+ssvpH/TPaBIKAzmSnzT19I+G8Ge1o9bbPnRILddT/GNg0w3skZ
   g==;
X-CSE-ConnectionGUID: bZc2J9xITwi6vj9DKbmlWQ==
X-CSE-MsgGUID: PIIn1tK4RvmWnwd/0sOOzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432716"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432716"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:13 -0700
X-CSE-ConnectionGUID: huw7UMLHQuyfifv1XhL7gw==
X-CSE-MsgGUID: 4OOxCRreRQG7gxsk65j6+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867373"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:13 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 14/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
Date: Wed, 30 Sep 2026 21:07:44 +0000
Message-ID: <20260930210750.1487547-15-chang.seok.bae@intel.com>
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

From: Sean Christopherson <seanjc@google.com>

Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init() as "const u64"
values so that KVM's initialization code can further manipulate the set
of supported XCR0/XSS features without ugly #ifdeffery and without
risking other code treating KVM_SUPPORTED_{XCR0,XSS} as 100%
authoritative.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/ahmtyMNsj2BCoEEo@google.com
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index a3f583a376ab..e72543088695 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -264,7 +264,7 @@ static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu)
 
 /*
  * Calculate guest's supported XCR0 taking into account guest CPUID data and
- * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
+ * KVM's supported XCR0 (the host's actual XCR0 masked by what KVM supports).
  */
 static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0df74422759f..91666b868ab9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -208,19 +208,7 @@ module_param(pi_inject_timer, bint, 0644);
 static bool __read_mostly mitigate_smt_rsb;
 module_param(mitigate_smt_rsb, bool, 0444);
 
-#define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
-				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
-				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
-
 #define XFEATURE_MASK_CET_ALL	(XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
-/*
- * Note, KVM supports exposing PT to the guest, but does not support context
- * switching PT via XSTATE (KVM's PT virtualization relies on perf; swapping
- * PT via guest XSTATE would clobber perf state), i.e. KVM doesn't support
- * IA32_XSS[bit 8] (guests can/must use RDMSR/WRMSR to save/restore PT MSRs).
- */
-#define KVM_SUPPORTED_XSS	(XFEATURE_MASK_CET_ALL)
 
 bool __read_mostly allow_smaller_maxphyaddr = 0;
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(allow_smaller_maxphyaddr);
@@ -7059,6 +7047,19 @@ static void kvm_x86_check_cpu_compat(void *ret)
 
 int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 {
+	const u64 KVM_SUPPORTED_XCR0 = XFEATURE_MASK_FP | XFEATURE_MASK_SSE |
+				       XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS |
+				       XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 |
+				       XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE;
+	/*
+	 * Note, KVM supports exposing PT to the guest, but does not support
+	 * context switching PT via XSTATE (KVM's PT virtualization relies on
+	 * perf; swapping PT via guest XSTATE would clobber perf state), i.e.
+	 * KVM doesn't support IA32_XSS[bit 8] (guests can/must use RDMSR/WRMSR
+	 * to save/restore PT MSRs).
+	 */
+	const u64 KVM_SUPPORTED_XSS = XFEATURE_MASK_CET_ALL;
+
 	u64 host_pat;
 	int r, cpu;
 
-- 
2.53.0

