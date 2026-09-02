Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C537EFE4;
	Wed,  2 Sep 2026 02:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317115; cv=none; b=nX92eZlV11PLJOrBij82W1toHJ+L2miosABmve6BF5mIPz34qLWcu49+QWDsdzeAp4sKZeMRgqNwqa93SS5ZrHJ2mC30tzJsLRoxSG9FpLjuQhIM5Q1Fh/K9ZihEibBSSnOa0LlEiWQB9hgkjCjK95qnaECg5AnvxnmWv1hXXb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317115; c=relaxed/simple;
	bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHQoWhf1NYUfbodgwTSf/XltWEm2h/9obGMGjKFV88dGRe+HF5LQLW1IPjDv59v5tGa0l8I4UEC6iYXC0yUZ/fvpupEMR/gaQgNQr6h3MknTHMki6bIUQ3zCIOEsXDWjwLdH8tdmPYEymSTn+RfwI887+XoRvkO636df8MoeDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTVod+AH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTVod+AH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317114; x=1819853114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
  b=QTVod+AHgEkZ11qaWxKc/PP7wwVvfgqlhUTWbuTQ7+sqnx9pRM7O8pfZ
   kDOpIxJeJ5zT264P6jYcC7r3mIWXAWgHJSvYmWUq7UL9oUIIz03NmWfif
   LdeuFAlA5YEaYPiHpEtCU0CXcHZILCWAJFBa4SKbSWqfczkUeGgTeUa94
   ByOjC10DQbq7hqdBVvGXUNvxKTH8CpLY58kgEadlaJoHbaOa+GIRVs/w7
   rk3YZ/AXMz+qsCpGo++Lsxm2bkzis97iERQ2Vih0JMt77y4MoSdbij7vv
   sKjWpezYuidlCAmhXe6zgMPGZnJmx0Nl3K4R8bT96edKhs5CEguVaB/cD
   Q==;
X-CSE-ConnectionGUID: y2jHewAGTmWtNZDvobEUjw==
X-CSE-MsgGUID: tgsK4yxIQoGmMURUYCOfaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106283007"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106283007"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:45:06 -0700
X-CSE-ConnectionGUID: J7Og6u2XTsiZADc/KPn/Qg==
X-CSE-MsgGUID: GLdGF7T3R/eQfmQf7KEu2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775606"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:45:06 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 20/20] KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
Date: Wed,  2 Sep 2026 02:18:04 +0000
Message-ID: <20260902021804.718676-21-chang.seok.bae@intel.com>
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

Now that KVM exposes the APX feature to guests, extend some existing
selftests to validate XCR0 configuration and state management.

Since APX repurposes the XSAVE area previously used by MPX in the
non-compacted format, add a check to ensure that MPX state is not set
when APX is enabled.

Also, load non-init APX state data in the guest so that XSTATE_BV[APX] is
set, allowing validation of APX state testing.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 tools/testing/selftests/kvm/x86/state_test.c  |  3 +++
 .../selftests/kvm/x86/xcr0_cpuid_test.c       | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 4a1056a6cb8d..9727dbb2b981 100644
--- a/tools/testing/selftests/kvm/x86/state_test.c
+++ b/tools/testing/selftests/kvm/x86/state_test.c
@@ -164,6 +164,9 @@ static void __attribute__((__flatten__)) guest_code(void *arg)
 			asm volatile ("vmovupd %0, %%zmm16" :: "m" (buffer));
 		}
 
+		if (supported_xcr0 & XFEATURE_MASK_APX)
+			write_egpr(16, 0xcccccccc);
+
 		if (this_cpu_has(X86_FEATURE_MPX)) {
 			u64 bounds[2] = { 10, 0xffffffffull };
 			u64 output[2] = { };
diff --git a/tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c b/tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c
index 40dc9e6b3fad..f74978ef5951 100644
--- a/tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c
+++ b/tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c
@@ -46,6 +46,20 @@ do {									\
 		       __supported, (xfeatures));			\
 } while (0)
 
+/*
+ * Verify that mutually exclusive architectural features do not overlap.
+ * For example, APX and MPX must never be reported as supported together.
+ */
+#define ASSERT_XFEATURE_CONFLICT(supported_xcr0, xfeatures, conflicts)			\
+do {											\
+	uint64_t __supported = (supported_xcr0) & ((xfeatures) | (conflicts));		\
+											\
+	__GUEST_ASSERT((__supported & (xfeatures)) != (xfeatures) ||			\
+		       !(__supported & (conflicts)),					\
+		       "supported = 0x%lx, xfeatures = 0x%llx, conflicts = 0x%llx",	\
+		       __supported, (xfeatures), (conflicts));				\
+} while (0)
+
 static void guest_code(void)
 {
 	u64 initial_xcr0;
@@ -79,6 +93,11 @@ static void guest_code(void)
 	ASSERT_ALL_OR_NONE_XFEATURE(supported_xcr0,
 				    XFEATURE_MASK_XTILE);
 
+	/* Check APX by ensuring MPX is not exposed concurrently */
+	ASSERT_XFEATURE_CONFLICT(supported_xcr0,
+				 XFEATURE_MASK_APX,
+				 XFEATURE_MASK_BNDREGS | XFEATURE_MASK_BNDCSR);
+
 	vector = xsetbv_safe(0, XFEATURE_MASK_FP);
 	__GUEST_ASSERT(!vector,
 		       "Expected success on XSETBV(FP), got %s",
-- 
2.53.0

