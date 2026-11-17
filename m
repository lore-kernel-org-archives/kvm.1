Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940362;
	b=rJft3RvYFhDS3yiOMr6nC5Q3TWuZALQmb+B4ZGbg78/XvAzkEKQgQ+a6DQ3viyvNZ8tb
	 JlojwD0pcXElnYrT0b3LoQAIKJyQLHZS9P72a1heNedf9zvfLDK1ZigoGBVkKVZd0Jfy+
	 M1GzFTCAdce4KPrxTxu9k/ap+4iaIOsFhrwVVi3MuaRyOBtGy+vmKCGMiQ0ffUVjlYTes
	 utqpOT/tzV8SsgOAKFhC7xgbacyeH8IEE0ZMZLvqdjcMZQrjKM2Z0tAES+9aW/xYk9/2g
	 nqvOgsYaeZuKTcVHt03z5DmLnIsfuX5MwOQ9pC2AguHCSasSpzclRt3CZImAKO/eLFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940362;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Z6jtJNNYFFp+hjg6wKK585o2STUO5fvIMDTSZH5S44=;
	b=tR4vqaNoBvxAiJ6rhcjdfHN+tcwalye5efGnKLl1OTsdqZEP8+hv9AayNdxfAaOaxZgG
	 FOs9Yj9cmKokwVYosliiabCiSz/ovW46VxfnagcBL1BIPkeI90MQJl9S4elK8Fy6aR7a7
	 kD5fprW1a/dowlXXmxuMNVcuaL67bkamusiQfGPE7vapHzkGeSnUqEExe6RPDX/jKmSF6
	 eaqy8BOCA2U2WkA8pEhcMAQXWt6n6YBdV6FrfJFch52p/sm3SxS/2O4DCX6/sMiOAgyYT
	 eADRAOnrplPXODs2+OcpISgDDimaQ9P/0Thx4HMDB0XujE0CB6LjqsszEsM7wNe8jog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="YsY4aZ/1";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C8D606A336;
	Tue, 17 Nov 2026 18:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2C8D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YsY4aZ/1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940362; x=1826476362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xsPmhgTq6J6dxFqBtI7zTN6mwmXMw3t97sgU6uIacZ0=;
  b=YsY4aZ/1cA8HsOhXK7ZwsuVDs0vtEvdgLV/RfCzgGM2uwxhFG1Flvk7C
   4zsExp7DM8smJz1FXW+N+T9Rhe2pKoxCcZW8hAHrLu6tx2XBSPBqwXABS
   wurIvhCyBC9Apmm4TUesG6Z+XZv8jo0eD/jeLOsR49CzFoK8NNkPI9S+N
   YaJZMDDwOikx4P44ezpq+w93xJIH1lcEJZFstKPvYg0FcX7COQinVOifG
   Y1B34IDPjZMQrVtNX8vNQOxWElNV7ro7N9mC8wx5NR++dzTb+UuP3bJrR
   f90oe7ZVsog0KE8+eigDPuVLhjLh9P+vvWbNUmUyJjZMtoqcDjR7i/vc6
   g==;
X-CSE-ConnectionGUID: j0//Cru8RHaudd7RW4+LBA==
X-CSE-MsgGUID: K0aMXG4yRFWskAygE5bP4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607409"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607409"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:31:11 -0800
X-CSE-ConnectionGUID: GDlYqA+2Q8yCPRKXWRpF5g==
X-CSE-MsgGUID: k37Q3qULRi+a2Q5AfhPcNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775118"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:11 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 20/20] KVM: selftests: Add APX state handling and XCR0 sanity checks
Date: Tue, 17 Nov 2026 18:03:10 +0000
Message-ID: <20261117180310.921701-21-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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

Now that KVM exposes the APX feature to guests, extend some existing
selftests to validate XCR0 configuration and state management.

Since APX repurposes the XSAVE area previously used by MPX in the
non-compacted format, add a check to ensure that MPX state is not set
when APX is enabled.

Also, load non-init APX state data in the guest so that XSTATE_BV[APX] is
set and the save/restore of APX state is exercised.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
V8 -> V9: uint64_t -> u64 (Jim Mattson)
---
 tools/testing/selftests/kvm/x86/state_test.c  |  3 +++
 .../selftests/kvm/x86/xcr0_cpuid_test.c       | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/state_test.c b/tools/testing/selftests/kvm/x86/state_test.c
index 500b09762555..22fe0784dbc0 100644
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
index 40dc9e6b3fad..adf665f483c1 100644
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
+	u64 __supported = (supported_xcr0) & ((xfeatures) | (conflicts));		\
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

