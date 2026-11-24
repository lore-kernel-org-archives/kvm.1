Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557214;
	b=pLCNyiuh8zsky35Wk1ElGi3g+p2UKYppf1lgDrTb6hpUudnVFuA1d06g2nAUjGS93bq+
	 YQAxsJiz6bgkRVDZeTxdjA+lF2j9WoFNbB1s8fHBUjOMpWfJ/QGgSDXwHPYeb42a8GQ4U
	 F1DQK3bNvBhHGh0T6U47QKsQ6kc01/kkcgsRjBBd2yLzDu9DUof5gVwt8Si+TE94+Ur8T
	 mU0E8VCTx2BIwXraxdcGcOTrYqZ+wVaHwyC4QcR4T/M9ypy/tEWXonlPoxDhKaLPgCkWG
	 4UUDyHDGYuRmFlJGNZd/esJYj8s+jeGtgZhIx9X653lSgL9mXpYfb5qsx0CNNC+EJaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557214;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Rr0T2s3Rs5X/n4VmNDdYEbZ5EM8E6saA7GPOelvGDuY=;
	b=u9gUOnfcKV7gBZanFu35w2nKJey6ld1vCeLRdnoYwS+bUayyTqXP7hp6eyKKCOKNjYf2
	 XTdZp7NkaVyZU8SMsno6ktWXPf5uDwJv5ppvTYVmFPtmgjeH/VU0W4N+QjUYKJ1ErjVIW
	 7oZTmH6ycL8HGJp5G3aJ0eBG8paxHEEKw3IVtKMm33Li65SPeet3rEBjB+34HzwCFzeZ+
	 6Xu3hw96BHU16TWAi7Me1jMEa8x7EAz5SHU7/gSF+n0qZxBrToxTgCBKJUPHX8zz2KddG
	 biDuDACzBObBubMI5P/UnOkROD+0bJ9I9mYjhr3E+jv28l+h1rsZY11rYykz/xMtBnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dsA1RA/N";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403760A6F57;
	Tue, 24 Nov 2026 21:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7403760A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dsA1RA/N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557214; x=1827093214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84/I6rLDA8dzHRgL/IU3CoIW99Sr7ASdIcqz0yh7qvM=;
  b=dsA1RA/Nrt6/dySMFMZx7fXvZB07V+rUff5SEzvuxNlHeq5layPaIapv
   3mDHzBCT8KIMH63diFyvrj9kRbSUqP2T/KcEbk1+ISrJEGFdNri7DfCcA
   heSZKBYWaFpBotV50PcdiEtmalG5R+NlCXyhPxZ4/RAaS3zpkDPlEEmrP
   qJUqQB9qr8Tb8LfU4L0Z1qQYG4b9yOtAviMV0pjIe3RFl0kNRTknbbpQz
   nRk014qU/YHQLZmlFn2uDDyfbnSmY1OZX+lo7nCbVeB2WvIBrrsfJRG8o
   Y5Bx5ofFq+rl0NcarllJdixBtq41Iub3l+ERxCfcy7kfNft4+x167nkwB
   w==;
X-CSE-ConnectionGUID: VYIcgnZMTaSTcqMQRQOi2g==
X-CSE-MsgGUID: /xLG1FQUSGe86IHNNi3Y/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306088"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306088"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:32 -0800
X-CSE-ConnectionGUID: uopqse2wTgu1mMsRoYLO4A==
X-CSE-MsgGUID: 5ltIJn5zQAqSXw96QuHZGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271967"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:31 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v10 17/18] KVM: selftests: Move and generalize PMU guest measurement helpers
Date: Tue, 24 Nov 2026 14:39:00 -0700
Message-ID: <20261124213901.120572-18-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
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

Move GUEST_MEASURE_EVENT() from pmu_counters_test.c into
include/x86/pmu.h so the measurement assembly sequence can be shared
across PMU selftests (e.g. Topdown PERF_METRICS).

Introduce GUEST_RUN_PAYLOAD() to execute the loop while selecting the
supported cache-flush instruction (CLFLUSHOPT, CLFLUSH, or NOP).

No functional change intended.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10: new patch.
---
 tools/testing/selftests/kvm/include/x86/pmu.h | 54 +++++++++++++++++++
 .../selftests/kvm/x86/pmu_counters_test.c     | 53 +-----------------
 2 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 608ed83d7c6a..c06ac78db01f 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -127,4 +127,58 @@ static inline bool this_pmu_has_errata(enum pmu_errata errata)
 	return pmu_errata_mask & BIT_ULL(errata);
 }
 
+/*
+ * Enable and disable the PMC in a monolithic asm blob to ensure that the
+ * compiler can't insert _any_ code into the measured sequence.
+ *
+ * If CLFLUSH{,OPT} is supported, flush and reload a dummy cacheline on each
+ * loop iteration to force LLC references and misses, i.e. to allow testing
+ * that those events actually count.
+ *
+ * If forced emulation is enabled (and specified), force emulation on a subset
+ * of the measured code to verify that KVM correctly emulates instructions and
+ * branches retired events in conjunction with hardware also counting said
+ * events.
+ */
+#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP, _loops)		\
+do {									\
+	u32 _a = (u32)(_value), _d = (u32)((_value) >> 32);		\
+	u32 _c = (_msr);						\
+	u32 _dummy = 0;							\
+									\
+	__asm__ __volatile__("wrmsr\n\t"				\
+			     "mov %[loops], %%ecx\n\t"			\
+			     "1:\n\t"					\
+			     FEP "enter $0, $0\n\t"			\
+			     clflush "\n\t"				\
+			     "mfence\n\t"				\
+			     "mov (%[ptr]), %%eax\n\t"			\
+			     FEP "leave\n\t"				\
+			     FEP "loop 1b\n\t"				\
+			     FEP "mov %%edi, %%ecx\n\t"			\
+			     FEP "xor %%eax, %%eax\n\t"			\
+			     FEP "xor %%edx, %%edx\n\t"			\
+			     "wrmsr\n\t"				\
+			     : "+a"(_a), "+d"(_d), "+c"(_c)		\
+			     : "D"(_msr), [ptr]"S"(&_dummy),		\
+			       [loops]"i"(_loops)			\
+			     : "memory", "cc"				\
+	);								\
+} while (0)
+
+#define GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP, _loops)		\
+do {									\
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))			\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
+				    "clflushopt (%[ptr])",		\
+				    FEP, _loops);			\
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))			\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
+				    "clflush (%[ptr])",		\
+				    FEP, _loops);			\
+	else								\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop",		\
+				    FEP, _loops);			\
+} while (0)
+
 #endif /* SELFTEST_KVM_PMU_H */
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 5ae7f2d15d04..4836745bef7f 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -219,61 +219,10 @@ static void guest_assert_event_count(u8 idx, u32 pmc, u32 pmc_msr)
 	GUEST_ASSERT_EQ(_rdpmc(pmc), 0xdead);
 }
 
-/*
- * Enable and disable the PMC in a monolithic asm blob to ensure that the
- * compiler can't insert _any_ code into the measured sequence.
- *
- * If CLFLUSH{,OPT} is supported, flush and reload a dummy cacheline on each
- * loop iteration to force LLC references and misses, i.e. to allow testing
- * that those events actually count.
- *
- * If forced emulation is enabled (and specified), force emulation on a subset
- * of the measured code to verify that KVM correctly emulates instructions and
- * branches retired events in conjunction with hardware also counting said
- * events.
- */
-#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP, _loops)		\
-do {									\
-	u32 _a = (u32)(_value), _d = (u32)((_value) >> 32);		\
-	u32 _c = (_msr);						\
-	u32 _dummy = 0;							\
-									\
-	__asm__ __volatile__("wrmsr\n\t"				\
-			     "mov %[loops], %%ecx\n\t"			\
-			     "1:\n\t"					\
-			     FEP "enter $0, $0\n\t"			\
-			     clflush "\n\t"				\
-			     "mfence\n\t"				\
-			     "mov (%[ptr]), %%eax\n\t"			\
-			     FEP "leave\n\t"				\
-			     FEP "loop 1b\n\t"				\
-			     FEP "mov %%edi, %%ecx\n\t"			\
-			     FEP "xor %%eax, %%eax\n\t"			\
-			     FEP "xor %%edx, %%edx\n\t"			\
-			     "wrmsr\n\t"				\
-			     : "+a"(_a), "+d"(_d), "+c"(_c)		\
-			     : "D"(_msr), [ptr]"S"(&_dummy),		\
-			       [loops]"i"(_loops)			\
-			     : "memory", "cc"				\
-	);								\
-} while (0)
-
 #define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
 do {									\
 	wrmsr(_pmc_msr, 0);						\
-									\
-	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))			\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
-				    "clflushopt (%[ptr])",		\
-				    FEP, NUM_LOOPS);			\
-	else if (this_cpu_has(X86_FEATURE_CLFLUSH))			\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
-				    "clflush (%[ptr])",		\
-				    FEP, NUM_LOOPS);			\
-	else								\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop",		\
-				    FEP, NUM_LOOPS);			\
-									\
+	GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP, NUM_LOOPS);		\
 	guest_assert_event_count(_idx, _pmc, _pmc_msr);			\
 } while (0)
 
-- 
2.56.1

