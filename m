Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8793725B099;
	Wed,  2 Sep 2026 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317105; cv=none; b=jncHoICa9zXDlXGwE8VEFUHLz9EZ7vZoin1nIq1lBi600OChAUsKeGYgwtxkxT771DE21IoknYnlTCZpHwXO/wBLADQ4tmPnGqsGZwgNHT9sZQnccc1fEYpjGZI5sd1gMT34D0/Pvp3o+lNXhVm2fpa+AqZb0Zm47K1zfJa4eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317105; c=relaxed/simple;
	bh=10xqJ5BcMr0nYEySUs6QsQLTR3mmAjeWtQAIS64uNRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIJKGckrLRoWs6oNQ8k7wOJ+dwXfn5RtX/elGdBHqVDh2rhlF1RAqQLpRvgu6NYJo8lrIo3Jep8gPaL3hiecpBdzvhtOgWkBYIqGhcavOcxF4aZwvFGqTcAOSVJ8MUbSSavJJYPJvaEplCMtOKSz2JkNwjrBCdGjV9CYeKA8gEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n46242IB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n46242IB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317103; x=1819853103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=10xqJ5BcMr0nYEySUs6QsQLTR3mmAjeWtQAIS64uNRU=;
  b=n46242IBEdvpLtrmgNkXTC2R+TCjKVmgucO9Owvr2sKS9pR84FlFIozu
   XqSRoJOKd90bXH16QyOZqE+rdX6DVSIsle04E2kFQBLEopC+3inFSbDRS
   GYKwhnvzALMFLra6hv0t6Fep2i9ZU7g7VD9pbMwYmQXabEctnZBnmnXw4
   HAJMkJ5NSYo0dVR3erNtgqxzJwrkgoueB1ngjyl4jANaw0iUjvU+OgbHX
   DbHJ1R9NP3FKbMG+nUOlFD0PfRVxJ4VUoGH7KsBTbvWt4TZK/bbATB2/X
   ijXyvqUfpPvkMfFSN1wrLqvyC6M6mhOAm0SIxBAozrAGGJeO5GXhpQl1v
   A==;
X-CSE-ConnectionGUID: qjUR+ST3QoS5N8tv6I+vyw==
X-CSE-MsgGUID: ctFxCEXQSVyGHduF1fL3zQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282965"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282965"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:59 -0700
X-CSE-ConnectionGUID: a0iG5bRsTNqGKQkAC+u06Q==
X-CSE-MsgGUID: EQmuPH4yS7S12Bu8OXGWhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775530"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:59 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 14/20] KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()
Date: Wed,  2 Sep 2026 02:17:58 +0000
Message-ID: <20260902021804.718676-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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

