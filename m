Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557213;
	b=XyCX1tJUNwqiWi/kmDQKNyLtWHIs42oDeq+QDNTOmRLkvuMK4o4LAqBzU2QCUWJnEbJx
	 RcDleE71o9P1lRExxE9BGzMb479FY1wwge1L0CLmw5s7hoBxKOVnf46zz/EqMOwYF8miW
	 xqnt3p1S8Z5fQBUEcYDCFVWDgSdWhbz31du0gi8nThKQWmV/MBQSth0nh7cck0m/IVcAM
	 CF6nwYtD1uqEw+fiIe5oNtONZ3pMQAcX/tYHGp2Dr8OTzYFzZHtdJEsjhBnk8wUDFOEsi
	 HD0duYhYjK+yPBa9jpLmmm5iC1eFz0SZ4sFcRChWnflqSm4h9Kw6yMg1zL9yB4qa6RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557213;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j7B1YaM6MKmQ9VO/CYs4WRTaUXI726RdX1hVNvUA3Nw=;
	b=RHg+4OFVLWiLskJWVgII9cO+FV9FUIRyUAJnTe0CgCMR1zzUFKwxhHmPUn4+CatgVJwZ
	 0pXVcahjHwabXQb0wpvnA9J7OXd14SQnq7dpt0RD4/fytu7qBMJfNGdn9I3Big/X3Iatv
	 actvS+bvI/83fSgSNMlTnXtOkNl6hFS3F+v5itf9lacoM0Drm8i1N1Y2jOvs2S0gRE8m8
	 +w5fPc9eerVvatLYQ69np68KDILmHgsRFgheIiFplID6pam8Nq9VeJixZq8s/Ghpl73vw
	 X78bk7PGXnsyytUl3aWYQOaMbQWZRa3NhdVlkMIA43DvXdF7PGRS8T6jZknqV/Yeo7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="HL/UB8Bh";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BD160A5BE8;
	Tue, 24 Nov 2026 21:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BD160A5BE8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HL/UB8Bh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557213; x=1827093213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQWWJ27TC+fI3UePadAEfcg7sAhLKXL/RJJPcQugzLA=;
  b=HL/UB8BhTPzMLHX7rgbi+qMcGHRReddv3kquRm8rfA1m6VBx6c9OGzMs
   4WhxqoOJpGOHLq+wXPcZf5wXlOBID0WdRJ0Im+njlYDGWkz80yWEkFHBY
   JBF3nY9TgajQ/r8H0xdLy/3dxDn5TapUcJQ6u/plHrUa8DGO7AuNuP8/J
   agloYJb9jWKTfR+vo/XWAKXK+HS3xFTyDmQtfU1QBgbsbtQue3lArVSjQ
   BU6oDzrV3Iq0Zue2YVBidxPGRUJIbZ8/RD8XIrVTs8/VuMk6hPTN0RmOx
   ykY4Yecbo/lVau4I3OYfodw9uc9laXpZk8HXQzcTsJWe5GvILZFuRNP3s
   g==;
X-CSE-ConnectionGUID: GJc10XvDSIW8Liqn/NLzhQ==
X-CSE-MsgGUID: kuZKZgk4Qz2OsHLvx8ue6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306082"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306082"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:31 -0800
X-CSE-ConnectionGUID: W9gLWzkfT6CPmOycjIUAug==
X-CSE-MsgGUID: lW4u8qxkTa+JNWqoVsi14g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271964"
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
Subject: [PATCH v10 16/18] KVM: selftests: Rework PMU guest measurement asm operands
Date: Tue, 24 Nov 2026 14:38:59 -0700
Message-ID: <20261124213901.120572-17-zide.chen@intel.com>
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

GUEST_MEASURE_EVENT() hardcodes symbols specific to pmu_counters_test,
preventing it from being safely shared with other PMU tests.

Flush and reload a local dummy stack variable instead of
kvm_pmu_version. Because the dummy variable resides on the stack,
pass its address in %rsi ("S") to remain immune to %rsp and %rbp
changes caused by "enter $0, $0".

Also mark %rax/%rdx/%rcx as read-write outputs (+a/+d/+c) and add "cc"
to clobbers since the asm modifies them, pass loop count via an
immediate operand ("i"), and fix the "CLFUSH" typo in the comment.

No change in what the test measures.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10: new patch.
---
 .../selftests/kvm/x86/pmu_counters_test.c     | 81 ++++++++++---------
 1 file changed, 45 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index c3e784e16348..5ae7f2d15d04 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -221,51 +221,60 @@ static void guest_assert_event_count(u8 idx, u32 pmc, u32 pmc_msr)
 
 /*
  * Enable and disable the PMC in a monolithic asm blob to ensure that the
- * compiler can't insert _any_ code into the measured sequence.  Note, ECX
- * doesn't need to be clobbered as the input value, @pmc_msr, is restored
- * before the end of the sequence.
+ * compiler can't insert _any_ code into the measured sequence.
  *
- * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
- * CLFUSH{,OPT} instruction on each loop iteration to force LLC references and
- * misses, i.e. to allow testing that those events actually count.
+ * If CLFLUSH{,OPT} is supported, flush and reload a dummy cacheline on each
+ * loop iteration to force LLC references and misses, i.e. to allow testing
+ * that those events actually count.
  *
  * If forced emulation is enabled (and specified), force emulation on a subset
  * of the measured code to verify that KVM correctly emulates instructions and
  * branches retired events in conjunction with hardware also counting said
  * events.
  */
-#define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
-do {										\
-	__asm__ __volatile__("wrmsr\n\t"					\
-			     " mov $" __stringify(NUM_LOOPS) ", %%ecx\n\t"	\
-			     "1:\n\t"						\
-			     FEP "enter $0, $0\n\t"				\
-			     clflush "\n\t"					\
-			     "mfence\n\t"					\
-			     "mov %[m], %%eax\n\t"				\
-			     FEP "leave\n\t"					\
-			     FEP "loop 1b\n\t"					\
-			     FEP "mov %%edi, %%ecx\n\t"				\
-			     FEP "xor %%eax, %%eax\n\t"				\
-			     FEP "xor %%edx, %%edx\n\t"				\
-			     "wrmsr\n\t"					\
-			     :: "a"((u32)_value), "d"(_value >> 32),	\
-				"c"(_msr), "D"(_msr), [m]"m"(kvm_pmu_version)	\
-	);									\
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
 } while (0)
 
-#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
-do {										\
-	wrmsr(_pmc_msr, 0);							\
-										\
-	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt %[m]", FEP);	\
-	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush  %[m]", FEP);	\
-	else									\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
-										\
-	guest_assert_event_count(_idx, _pmc, _pmc_msr);				\
+#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
+do {									\
+	wrmsr(_pmc_msr, 0);						\
+									\
+	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))			\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
+				    "clflushopt (%[ptr])",		\
+				    FEP, NUM_LOOPS);			\
+	else if (this_cpu_has(X86_FEATURE_CLFLUSH))			\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value,			\
+				    "clflush (%[ptr])",		\
+				    FEP, NUM_LOOPS);			\
+	else								\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop",		\
+				    FEP, NUM_LOOPS);			\
+									\
+	guest_assert_event_count(_idx, _pmc, _pmc_msr);			\
 } while (0)
 
 static void __guest_test_arch_event(u8 idx, u32 pmc, u32 pmc_msr,
-- 
2.56.1

