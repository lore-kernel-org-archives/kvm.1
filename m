Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457893;
	b=MoimicI2wKTeg1jQynj5bgT8cBxbdS+3AzRvO981p/n2iktEYAisucXu8oF4m24EXiQi
	 OGKTZZ8uT3q5Matcst0uXImYwVGacMvqK4GodbLceAETTgoZmFONPfjVRNKveA5IDAJh9
	 Fd0tn6VC9EOUvgFDIVbHpZxLJ71nZ6aoJyo1L77LEDXiZ52Wi9VqV9p31ZrvMXUJUQPgk
	 4dVoSbvIBNw4XeoxTej15IX5tXOElXOFeOpRV1fKnZUHgC6f2ipcxAt68hk7ZLWR5H9jZ
	 UBY75f7wuq12q2NB0CsXsDl4ZcWqovUgZHgBeMjAB0VQgsGCAquiGcnZmZGNthGwP4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457893;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oSEvoi0ea2goxyB/FH21gAIlok4zi1iIF9z0KyQZf80=;
	b=X3XprDeMBL89Ga4eWlduWzuidtUKvOSr4Jx/w5d4/+cb1leYt7UQK7pU6Fdo5rU9HyBY
	 QE4u4Oc1ZUOigaBMna7DshgIlkYjUn0aj22AqJuMz3eK9PXFH3LlOuBKpq2khaV5T3f5k
	 m6Rf3V5NnQOs1pmn7TgCDCe2IAs4sLA7w3HjTZkejmDQNUDZlPCKyeSbZPwZyXYAfYy4G
	 YT0XwX5mJ2gaRQbcc8u0dCfFMJO1PdIZ0VyF4i8h9v2Tqrrm7DwOeLkD0TxWdLma1BSu2
	 J2akuUs0MCZZIRTE1Rc3nEoJxuKqd/yp5GxliubZ97c1sbh8vnYCUcmjDxuLGEfKBMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="A/AZsZV3";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3C606BCD2;
	Mon, 23 Nov 2026 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CF3C606BCD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A/AZsZV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457893; x=1826993893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pEfBuwXeuUja3VTwO8qCyONQvwtpZbKDmz71+elVXeg=;
  b=A/AZsZV3xqXpjic3dt0kwKIhaV067OQZH0RcniEzBwMZsde55CcWCd/B
   44Nnf7N25hKumFtKuMrPf38E+CpcE1qMM1BXifDG+Ljd4ECvlgObqEopp
   0YbRSFdbGTRA3p2WYC5ZbEFwjWcuNCvA7lBzN5zwxW8CbrTPZ10ySlAD6
   qtjzlu6u7XGwQFLbu8Dikyb03/dbXEEX8PI7xJgdQTomrpesNLDh00g74
   Vt/xezdVOxbDxB2pHy3bqpDvVPS8byRqOgSPi6ptT6LEKhq1K2g0wLvhM
   2mfyh02UKRvpbHFdYPS20mWoYYZ8bxDBY3TjWXyWf5DnedmAmmhOoZq70
   g==;
X-CSE-ConnectionGUID: ufuoOP+NR6qwQGhEJQc5UA==
X-CSE-MsgGUID: dx8O7xiiS+q5pLERreKzlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288915"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288915"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:40 -0800
X-CSE-ConnectionGUID: MXccp4qLQFSiFKYYHF0ALQ==
X-CSE-MsgGUID: BTyh8gVpRWK4QVcJrWQdUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241184"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:40 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 20/20] KVM: selftests: Add APX state handling and XCR0 sanity checks
Date: Mon, 23 Nov 2026 17:37:32 +0000
Message-ID: <20261123173732.1072124-21-chang.seok.bae@intel.com>
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

Now that KVM exposes the APX feature to guests, extend some existing
selftests to validate XCR0 configuration and state management.

Since APX repurposes the XSAVE area previously used by MPX in the
non-compacted format, add a check to ensure that MPX state is not set
when APX is enabled.

Also, load non-init APX state for the ABI test.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
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

