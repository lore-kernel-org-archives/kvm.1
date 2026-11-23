Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457890;
	b=DcDoDwuq/VQ/lZlYK8cyHmILKipY+SoqJbJm1LKz36iYzIJyY9/cBuzmxSgSJ6hAwerN
	 87sxfzODaxMxR5xw3cFeRP0+fHHoqkQA+kOzoslKO4vLn/c1f9JTM4xOvoK+plgz4skAO
	 iYj0ggrA0VyNOTum36SkQ1eQmfuwbSaNTJBDiHZSvwIyh6M7uV2WO6JwmTFquEh8/zW5J
	 G1nt2LeypSEG4upUMC+P9VB3/6Y8agdOfIZmAixvSQgS6rUQjbkLNaxxmz6l+cep4f5rM
	 4mdeXVAII4wHcOA0oPPZroC4+fHcVcsA18QVVvKxh6eKqZQnGuspnm7Vo9/7z9EitQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hbEzsj2VUxF9bmuyjXO37zsnxste6rzSyipIhG+p3qk=;
	b=FEJB4O4PXqgSXG+9EKBxd+wubxCTMMv4kz4AjUNxUe7xtE1Wh+hMPdXo7Qv/l3NaGyaS
	 3vUkoivFttvkeHM0pnZH4TW8SrYE+uPKYdARp2Ea/l2ImMWCNAPYnLzMxkap6TsXpu4Aq
	 t7276Ix2Xg6WwRdZYWBfVi4qRfuszQjbt+P1CLa1m5h2BCoPpWS19OMYc0XFW5Wmtsqwm
	 hR0ER42dIG46gnMU7jsaqxzn+3vtho2vSwbgY5J+UbgY5273YHHPnoQzK5GyOQ0d8HcBw
	 2bQFjSEhwfkb6I+7ObshYVwq6qxMvTU2JyLsOBL2QWxvzFR4+UQj35czqX0xidy4IFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En+oSH5h;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541460A6F77;
	Mon, 23 Nov 2026 18:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5541460A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=En+oSH5h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457890; x=1826993890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QESkkAr0sX7IhiZEoMVmvU6IAAmj8KDUOlejoqDwr5o=;
  b=En+oSH5hfF9lwKT3R5WOKJPeHb9RhnVAhjgumnyIWHKZessWd3P7Kgqs
   aLj95pF/njHIXJzYHCufQr5xh6IQGhDmb+9CazZA//CyATzZIuZHuAIcr
   q/81E775jPfFIiDL9x1AxQmDPfQO+DanH2YXcF3Pc5ED1H9m1kFy398FB
   5YltSsU/2PYsovT8/3iqp+1Z1DXPww1sTUF3aEzFYdSEHyPX8CIHkBpgb
   qf8MijDu2/AixrOgj6eshi/Hm7J2kVQ0lFY1PnbWGvmPgZVY37v+RtARC
   nBfUfsslAJKVEmRWyOxWyZOHRczervxw1VFiZHbpKxe/n1U0ZmmCsQOAu
   w==;
X-CSE-ConnectionGUID: e8OqluFRQQWqkWgOM8qOCA==
X-CSE-MsgGUID: cpNb3ry+TK6NyALKcV2dYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288870"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:30 -0800
X-CSE-ConnectionGUID: PFWqBDC9Rw66m0G7DH+Uvg==
X-CSE-MsgGUID: VJAiQhm2Q2SQv01/ZhKxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241158"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:30 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 15/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
Date: Mon, 23 Nov 2026 17:37:27 +0000
Message-ID: <20261123173732.1072124-16-chang.seok.bae@intel.com>
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

From: Sean Christopherson <seanjc@google.com>

Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init() as "const u64"
values so that KVM's initialization code can further manipulate the set
of supported XCR0/XSS features without ugly #ifdeffery and without
risking other code treating KVM_SUPPORTED_{XCR0,XSS} as 100%
authoritative.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/ahmtyMNsj2BCoEEo@google.com
---
 arch/x86/kvm/cpuid.c |  2 +-
 arch/x86/kvm/x86.c   | 25 +++++++++++++------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7c6825000928..f476a78a570a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -265,7 +265,7 @@ static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu)
 
 /*
  * Calculate guest's supported XCR0 taking into account guest CPUID data and
- * KVM's supported XCR0 (comprised of host's XCR0 and KVM_SUPPORTED_XCR0).
+ * KVM's supported XCR0 (the host's actual XCR0 masked by what KVM supports).
  */
 static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b2d44c2f70e6..131f18534816 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -210,19 +210,7 @@ module_param(pi_inject_timer, bint, 0644);
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
@@ -7121,6 +7109,19 @@ static void kvm_x86_check_cpu_compat(void *ret)
 
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

