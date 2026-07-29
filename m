Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC03D2FFC;
	Wed, 29 Jul 2026 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354243; cv=none; b=Yw6tw+2leh+/E2adHCfVpFCQAtsIk7Wt/sOIjtLFYg2lRVD1YtZqH/Bj5rNYtRhmTHKX5pEE4WSEsagjG14Ts17z9qeGSNQHgfMG8eBRRmWjtXkSWn9+y8pjg+8s9ajJyFxBx0qXCiQV+IoyyN6u595oYOk/dBhmNG9k3W11FAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354243; c=relaxed/simple;
	bh=RwLBDBbobIqfFHCU7EokVXN2+HJdk9ueCTsifluUNac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuOXoKEcVpsfOEy+fU9vYZwnUTWeFiflun6/PUmtflJP5FVbnLcicPIdluxrwH4DbPvCPni85VF2XFpeBW4dqjHW8bbwjc9GWpVv76mFqidd/UfjL2+3ZkwBAoMT3VRDyDPcwogXjZUAlXnyxDcopSShjEp6zTqSKUh4t07yv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6khPXE8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6khPXE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354237; x=1816890237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RwLBDBbobIqfFHCU7EokVXN2+HJdk9ueCTsifluUNac=;
  b=J6khPXE8NE5TKpsNw76MusxdVE5PUhINXfpqciFO2fM1nTd5ytZblVwZ
   +uHZ263gkbYr1EJgtFzElXbnwbJZh3pzr/4vMreCpm37/KNJgblxadlrO
   ICMMDQpE3WBAXvcvJrJvMqNXb2gMqOg7SNU+JloBKslmA4FhP2NklgQaq
   gwMe0js/ox7udIAoVC+HY4lIob64VcS1ZGd2qT8gYj9QYTr48SsM+hGTP
   qyEt2J/iTfA04glJYrOAHrLS5nItdCXpoC2v+2YXPrisgd1xnsN/ePY3D
   P70Ec4yR3a3FiN/W+141/7fB1RZpEMiP+URIovSCY0PQMGdP3pm5TJyFZ
   A==;
X-CSE-ConnectionGUID: mMpN0iVYQnSjNJqoTKK43g==
X-CSE-MsgGUID: 6YaT10nIRPKuDzDI3zri+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508297"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508297"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:30 -0700
X-CSE-ConnectionGUID: LLXvqet5S/67UM8DcPzq6g==
X-CSE-MsgGUID: SCUgHDUkRruj1mWsv/oNGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769263"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:30 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 14/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
Date: Wed, 29 Jul 2026 19:16:50 +0000
Message-ID: <20260729191656.598771-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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

