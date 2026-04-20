Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C19353EC0
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721731; cv=none; b=trSi4Y3F3VptQc7v+vnUhQ6FNcOCS+Gki2Iop4EzpzBw+6pZG1+F3+0oz71oOCkiOfOCzAzV3UThncZhO6WyFBYGUn+/9lK9+VuItcaHUWIoqToL5JWBf0I4obau6t6YfFaSXlvr77ZYpl1pMaqLIHzsOF0i/pkLJRZUPOERZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721731; c=relaxed/simple;
	bh=QuNWZ4L77xYBX9u3KSBKLFT//gD6QjS8KSAxSIfBFrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnL52hJedifUDBaALnMkAsighm0zyg82blHimEbsCPcX+YePs3w0y6ujDelt7THb3bbuHnyy8ImkjemHZVHL12qG3JVVZsXHYmvElTKFzeCyawfbNwkYdidGTxYHNwt+TI/YfCDZp07/H224Cua2aRLxd4uSEF7DVX6A/0Hkk18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9jVqkCj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9jVqkCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776721730; x=1808257730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuNWZ4L77xYBX9u3KSBKLFT//gD6QjS8KSAxSIfBFrc=;
  b=D9jVqkCj8R0lxu7dzSwlNI6rKlCJu+LvQFcYTbR+G8RnEFpIssL/mLOD
   w8ehtRt2pBbbFBlVJtdcBytpvyCHS441XVQWjVLZ2HjXvemgETRKaobqx
   Q3eCe7XgmkjtFYEgpCU7HToyVIc2t6bY6O9QVtITlLxmWAExR9rOI80SN
   hZMdpBbHwzj6hMSXyOkMm1NYNlPqkquF9O6tQtaNqgGoscTdx6sTM8qaS
   wknvzLl8EvTURqYQ3so/whKqzulIq942/ea7JARUXqeWBSaS8pkIGnHn6
   SK6Bo0SG6U1cT9m0rk+A99vK/K53WnMeGUqoWXUgWkBQAs5zB74gpiq8t
   g==;
X-CSE-ConnectionGUID: 9DuUpLiNTK+UKnU3pLPTaw==
X-CSE-MsgGUID: 5JHkmAYNTuWjEBH92VmC1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88347682"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="88347682"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 14:48:49 -0700
X-CSE-ConnectionGUID: yAH5yhW5TP6SY/PtEJ2RuQ==
X-CSE-MsgGUID: Dtpl24DpTJGeTTJU2JrSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="236816735"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.172])
  by fmviesa005.fm.intel.com with ESMTP; 20 Apr 2026 14:48:49 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH kvm-unit-tests] x86: xsave: Add test case for emulation of APX instructions
Date: Mon, 20 Apr 2026 21:23:55 +0000
Message-ID: <20260420212355.507827-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <072ad56c-24d5-425a-9faf-c1a3ba732005@redhat.com>
References: <072ad56c-24d5-425a-9faf-c1a3ba732005@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to validate emulation support for extended GPRs (EGPRs). APX
extends the x86 general-purpose register set with R16-R31.

The test follows the pattern established by existing AVX tests: it
performs register-to-memory and register-to-register moves across various
combinations, and cross-checks emulated execution against native results.

For convenience, make available only when built with a compiler that
supports APX. Otherwise, raw bytecode is ugly and inefficient, and
even macrofied bytecode looks to be an overkill.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Note:
As suggested by Paolo [1], I also think this piece of testing can go to
the KVM test tree. Additional (new) cases like testing KVM ABI and EGPR
state management will be included to the KVM series (from next revision).

[1]: https://lore.kernel.org/lkml/072ad56c-24d5-425a-9faf-c1a3ba732005@redhat.com/
---
 lib/linux/compiler.h |  5 +++
 lib/x86/processor.h  |  1 +
 x86/xsave.c          | 86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/lib/linux/compiler.h b/lib/linux/compiler.h
index 8e62aae02b5e..e9df821d50fd 100644
--- a/lib/linux/compiler.h
+++ b/lib/linux/compiler.h
@@ -13,6 +13,11 @@
 		     + __GNUC_PATCHLEVEL__)
 
 #ifdef __clang__
+
+#define CLANG_VERSION (__clang_major__ * 10000	\
+		       + __clang_minor__ * 100	\
+		       + __clang_patchlevel__)
+
 #if __has_builtin(__builtin_add_overflow) && \
     __has_builtin(__builtin_sub_overflow) && \
     __has_builtin(__builtin_mul_overflow)
diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index 42dd2d2a4787..85e96741a6bf 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -198,6 +198,7 @@ static inline u64 get_non_canonical(u64 addr, u64 mask)
 #define XFEATURE_MASK_LBR		BIT_ULL(15)
 #define XFEATURE_MASK_XTILE_CFG		BIT_ULL(17)
 #define XFEATURE_MASK_XTILE_DATA	BIT_ULL(18)
+#define XFEATURE_MASK_APX		BIT_ULL(19)
 
 #define XFEATURE_MASK_FP_SSE		(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
 
diff --git a/x86/xsave.c b/x86/xsave.c
index 254f9fde6976..a1e57dea18db 100644
--- a/x86/xsave.c
+++ b/x86/xsave.c
@@ -1,6 +1,11 @@
 #include "libcflat.h"
 #include "desc.h"
 #include "processor.h"
+#include "linux/compiler.h"
+
+#if GCC_VERSION >= 140000 || CLANG_VERSION >= 180000
+#define TEST_EGPRS
+#endif
 
 char __attribute__((aligned(32))) v32_1[32];
 char __attribute__((aligned(32))) v32_2[32];
@@ -43,6 +48,78 @@ do {									\
 		__TEST_VMOVDQA(ymm##r1, ymm##r2, KVM_FEP);		\
 } while (0)
 
+#ifdef TEST_EGPRS
+
+char __attribute__((aligned(8)))  r8_1[8];
+char __attribute__((aligned(8)))  r8_2[8];
+char __attribute__((aligned(8)))  r8_3[8];
+
+static void initialize_gpr_buffers(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(r8_1); i++)
+		r8_1[i] = (char)rdtsc();
+
+	memset(r8_2, 0, sizeof(r8_2));
+	memset(r8_3, 0, sizeof(r8_3));
+}
+
+#define __TEST_MOV_GPRS(reg1, reg2, FEP)				\
+do {									\
+	asm volatile(FEP "mov r8_1(%%rip), %%" #reg1 "\n"		\
+		     FEP "mov %%" #reg1 ", %%" #reg2 "\n"		\
+		     FEP "mov %%" #reg2 ", r8_2(%%rip)\n"		\
+		     "mov %%" #reg2 ", r8_3(%%rip)\n"			\
+		     ::: "memory", #reg1, #reg2);			\
+									\
+	report(!memcmp(r8_1, r8_2, sizeof(r8_1)),			\
+	       "%s MOV using " #reg1 " and " #reg2,			\
+	       strlen(FEP) ? "Emulated" : "Native");			\
+	report(!memcmp(r8_1, r8_3, sizeof(r8_1)),			\
+	       "%s MOV using " #reg1 " and " #reg2,			\
+	       strlen(FEP) ? "Emulated+Native" : "Native");		\
+} while (0)
+
+#define TEST_MOV_GPRS(r1, r2)						\
+do {									\
+	initialize_gpr_buffers();					\
+									\
+	__TEST_MOV_GPRS(r##r1, r##r2, "");				\
+									\
+	if (is_fep_available)						\
+		__TEST_MOV_GPRS(r##r1, r##r2, KVM_FEP);			\
+} while (0)
+
+static __attribute__((target("apxf"))) void test_mov_egprs(void)
+{
+	TEST_MOV_GPRS(16, 31);
+	TEST_MOV_GPRS(17, 30);
+	TEST_MOV_GPRS(18, 29);
+	TEST_MOV_GPRS(19, 28);
+	TEST_MOV_GPRS(20, 27);
+	TEST_MOV_GPRS(21, 26);
+	TEST_MOV_GPRS(22, 25);
+	TEST_MOV_GPRS(23, 24);
+	TEST_MOV_GPRS(24, 23);
+	TEST_MOV_GPRS(25, 22);
+	TEST_MOV_GPRS(26, 21);
+	TEST_MOV_GPRS(27, 20);
+	TEST_MOV_GPRS(28, 19);
+	TEST_MOV_GPRS(29, 18);
+	TEST_MOV_GPRS(30, 17);
+	TEST_MOV_GPRS(31, 16);
+}
+
+#else
+
+static test_mov_egprs(void)
+{
+	report_skip("Skip EGPR MOV tests: compiler does not support APX");
+}
+
+#endif /* TEST_EGPRS */
+
 static void test_write_xcr0(u64 val)
 {
 	u64 xcr0_alias = rdtsc() << 32, cur;
@@ -93,6 +170,12 @@ static __attribute__((target("avx"))) void test_avx_vmovdqa(void)
 	TEST_VMOVDQA(15, 1);
 }
 
+static void test_apx(void)
+{
+	test_write_xcr0(XFEATURE_MASK_FP_SSE | XFEATURE_MASK_APX);
+	test_mov_egprs();
+}
+
 static void test_unsupported_xcrs(void)
 {
 	u64 ign;
@@ -151,6 +234,9 @@ static void test_xsave(void)
 	if (supported_xcr0 & XFEATURE_MASK_YMM)
 		test_avx_vmovdqa();
 
+	if (supported_xcr0 & XFEATURE_MASK_APX)
+		test_apx();
+
 	report(write_xcr0_safe(0) == GP_VECTOR,
 	       "Write XCR0 = 0 - expect #GP");
 
-- 
2.51.0

