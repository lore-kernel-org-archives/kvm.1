Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063053A8B2;
	Wed, 30 Sep 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804125; cv=none; b=FU3bs74e3ISNUaA8PWG9ZcAEwegBsQlUrKA344UAP10WWHR8JDNmysOsr0+bwKt8wI8dewTFNHDXLOvLu2bOSHusR/3TSiCDx9VTym+dnizDIMNUZ6v58jFOfoeO2mo8gx1X7QAX6oO1DJR7D5p2slEarl7wIWbbVUNVLkcmr54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804125; c=relaxed/simple;
	bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilwb2OcnLIljXSTrgoQv5A7Em1uWGdi58Oqoty15lnEzt1ZyuJVBmCuBt2FS5SgnkaZqi5nMfJpNXd7FQ7/gc4KntHWDn3asMPURw6OFfBhbysEXtvXc/VWE/54gUSWlRdI7KszouXtrtML8vu8p3D7zUrKUW5IlCh0XuNQpfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQwpc33p; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQwpc33p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804123; x=1822340123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
  b=mQwpc33psAJKFyOokQt7aBmifbRckuRf2t3NaxXihipaEXnBTqO26OvT
   lesUxD/veIkLZDRApAh9QUxXklL2Io7SEzS5/0ENIirtI/vFLODuPFUm5
   V57cbz6jzDilxzfrbdw/q4gt0rp9eZLo7Gbi0aPc/2WvIPOeFwNN06MGC
   lSuCHggejnNL9fL1BO+Ri57k8lfRiiuBeBW7yJFQtnbYDLcbAsUwYo8dU
   WjwfnlpRqYCWA0IqGvhCUyIx+pZYn4RKw5A3t6bM7oG9p17On59kfsm7x
   Wb/2zlKyTH5CsSPdlqy7dSMAMI+afd4d26TqW+CfNnPy+RGmuzdlXPV5T
   Q==;
X-CSE-ConnectionGUID: lX9+je9PQVicKgwUunwtzA==
X-CSE-MsgGUID: qhUJTZLeQ92ojYlt88+8kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432743"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432743"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:22 -0700
X-CSE-ConnectionGUID: W859WissSW6KLmmAq7nEGg==
X-CSE-MsgGUID: yrtumyRvQfu4xR1FdfpoEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867409"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:22 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 20/20] KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
Date: Wed, 30 Sep 2026 21:07:50 +0000
Message-ID: <20260930210750.1487547-21-chang.seok.bae@intel.com>
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

