Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DF47DD76;
	Mon, 20 Jul 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569623; cv=none; b=jw/PDHIuSbcJkpIOTJqYXEPb1Az9wGIfbyNhHU3JG2TV8Ppl4BCBUKXN1wtMPpHlWaY1HdxTQZDuhXeDGPtcEtOxxylxTmw0XtTEGw1EJF4HxQ24s8FYNyUl4byJfBW3ZB4IOgT9jghjYVlJapIcSVMWXjTbcs7uu8fVaK7sRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569623; c=relaxed/simple;
	bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBGIx130ygp+oRHScEOy9gHfD1O6XqXYLhENt1dSQQKjK63PbAIrbWDyQjoaP23IUdmdEGaULKu8fd3dybrqCshWp429fnsQRH2/MNsdn4DNjNKnr5lNsi2aw7DBGdVoQhNlSsFk9iKvppoC29/o1bZQFS3RrCJC1bhkadSmBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrC49w6o; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrC49w6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569616; x=1816105616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=anr9jp6F95ZMl5OuNXc1gxmHfRhIi2vcRZyTglo+qmk=;
  b=BrC49w6oK4QA4AubRl0y+VDb7R4Z1SxZTEdFCwASdpBCs8R1KDH00nAv
   SzZrGZgvkfKrRsch7FqlbXSec88S+wpWN29CYwT6Ko5w0hm5ZcfCh37ED
   +rV3KeuIfc40PIzeMBdlRn2YzBiDxcfh//RcNemAlqHj5z9enQ1OML+ii
   7xvv21CsKHdCLEx7Ke94aWY7jQSlR06YrozT73h9SAF/Ohdnyvq34LwbZ
   ieK1w+FhCxov0a5okx+JcreC672DuEpofP/w5ow95BymSQB3OQCoWzNe5
   lrhafkmxyxx6Q8gzQcz0+rRDo2NSKNARZ+G8qKN8CuBhgVTJDXfZwtAft
   A==;
X-CSE-ConnectionGUID: 2LBe41T3Q/mwCO5c2vcv4Q==
X-CSE-MsgGUID: hbS6JkvHSRmp1DPOjVZqRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691724"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691724"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:15 -0700
X-CSE-ConnectionGUID: 5FzX9gdrQT6oA5eJ6aFeZQ==
X-CSE-MsgGUID: 22/wnI0iQyWo0bB70nGtKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575407"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:14 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 20/20] KVM: x86: selftests: Add APX state handling and XCR0 sanity checks
Date: Mon, 20 Jul 2026 17:19:49 +0000
Message-ID: <20260720171949.498680-21-chang.seok.bae@intel.com>
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

