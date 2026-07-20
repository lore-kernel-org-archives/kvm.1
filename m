Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D64534B7;
	Mon, 20 Jul 2026 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569603; cv=none; b=d9orDXYsFFtO+So1S0tdh3paS+ACy+M94yxvIauoRWq/DTP5VyLh1ygEIRmbBVory3KWSQ5JX7AAMJFJUG1+DjF9HDX7PsnfN0G4OTNuTjWD2/MR697/NJiRJ15dWrG3Tl8y4C+9acuyIKGiQKOmmCk9fZ5EpN/kteGZkFT1t8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569603; c=relaxed/simple;
	bh=RwLBDBbobIqfFHCU7EokVXN2+HJdk9ueCTsifluUNac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn2bPAxUMWjJehmU6lF5icw6M+k3/Ffu96rvcjEYu1nNl70WqgiboEeT3uUPeZ7arPsn+rrCNrC28zuc9IGN5FG5tEpqyKGOiIC/lvmOSr2rQQadbaK9AbiDT4gAz5N32BMnvTuqlhggUkDCQ5HGOVk5zHtBCeYzmE+1QPfxtoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd7xNlEO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd7xNlEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569594; x=1816105594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RwLBDBbobIqfFHCU7EokVXN2+HJdk9ueCTsifluUNac=;
  b=Cd7xNlEOT+H0i7rAuLChW7SM5Xj5VYzc+brgcroxaqE/Drz95L2zBmZY
   jnQZRjnA1+Z4AGjutKqVsYTYAtfRESwt7Ohigv14XndU0uV61ZBh1ow6E
   OsOmNCJuHULnAUjk2HcPqFNtAwPZg8Qek3+5LfQEDvI44tCDyB9KFRIfk
   JEY5KLiIvPVsV9kGaLb/V7cxEGXxfXcC3aOyZ8CnxdpihR1UyPpfAMmxD
   N4afICt0fk4o8SqIJJHsQaN77pz27MuuuSIUcUFdZK8XKDxh13KhftUPx
   cd+vMSdrAF0CVikTClKruTG16vAvMdnaZFey7sZ86e7fWLcin+5XJOicF
   Q==;
X-CSE-ConnectionGUID: qpaYB8PjRqKZhoukezlvwQ==
X-CSE-MsgGUID: 3Vn5VnhxTReX7ffz2Sqp0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691696"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691696"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:09 -0700
X-CSE-ConnectionGUID: yB5LLLWIQUaP379BC6MjxQ==
X-CSE-MsgGUID: kH02+0qMTw6MutGN1mT91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575386"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:09 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 14/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
Date: Mon, 20 Jul 2026 17:19:43 +0000
Message-ID: <20260720171949.498680-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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
V4 -> V5: New patch (Sean)
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 122e46db9a15..1fc7a0f9a13a 100644
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
index 5578df10179a..84b2dcfcb007 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -191,19 +191,7 @@ module_param(pi_inject_timer, bint, 0644);
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
@@ -7009,6 +6997,19 @@ static void kvm_x86_check_cpu_compat(void *ret)
 
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

