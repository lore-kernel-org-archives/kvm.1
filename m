Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC44BEE3B;
	Fri, 11 Sep 2026 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163033; cv=none; b=cqNWP+L0dLIM+0dVkiygbw9khuTfU4RiUjaTchAepKLHYIoBRjGxypzjC+4cZWeVACG5spgDbGE4iBt+pCkbRoTnZ7P3FkyGkjDH/ypM0FmmVUpWk/U7PMY+YOpVsHpSBBeYPNWoRBgp/oFo1MqgoZkL2TgqmzwUUk+iA4j5b3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163033; c=relaxed/simple;
	bh=xTcz+8SJvIkx43QiWYnGAhgtbnaSw9N12NLUCq9wllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT+RxCosfa/Te+9xk82AZlEn2KOmN8E2didb2qFRMtpRvWg8EKqh6wtw+Du+Ug1LoLF0wTGtIpTfah6pbwxLpI/FgA3ulFHgDFyL2IVBrVLpmFuMv04W2yKLCEpRr8V8v/vlflVq1VKjdti1csn80DR3iaKGsz9LTgoEsAYK60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mf/Unxai; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mf/Unxai"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163033; x=1820699033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xTcz+8SJvIkx43QiWYnGAhgtbnaSw9N12NLUCq9wllo=;
  b=mf/Unxaiz1DR/1r0oGmSqq5aPv5BqtVoFEc6HWkq1h25VZOd7mfarb9z
   K5kftWMOGO9ioM++88KvNdm+JGoa/OgYxBCVHJqhGfj1mEJ6EbffEaMso
   u18B6pl+3aXK4bsaJJRmZnR862Et8exCfjW67hgZY/1yS2drhilSPBEhE
   bKCtQ/QLaeEw7Povv2Q+5mCOAmY+/xiLzcq9Kb0Ercgat6f2nXPdXSHz/
   bw6Kt+LIn86kEv7NRj+pvIXu9vFoRnoTvCqXIRagcBv8Es66yAcuTHpzj
   M1clH34fvO2CIv2iVRBnioOD3E4WbrsGhwD3eN2n20BAXEYVUdMrrZUQ/
   Q==;
X-CSE-ConnectionGUID: NnPAQhLfSJyAWH8Dv4n3rA==
X-CSE-MsgGUID: 9vEqNf/kTTqRY5jEPaKWrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572932"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572932"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:43:52 -0700
X-CSE-ConnectionGUID: ZxDSJ2FLRzyNkuPE9JxAcQ==
X-CSE-MsgGUID: G+1GdaUyRFuRBOyaOwsMhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004368"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:43:51 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 26/28] KVM: selftests: Add FRED MSRs to msrs_test
Date: Fri, 11 Sep 2026 14:36:56 -0700
Message-ID: <20260911213659.2025974-27-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Li <xin@zytor.com>

Add FRED MSR coverage to msrs_test, including the FRED RSP0-3, SSP0-3,
STKLVLS and CONFIG MSRs.

Signed-off-by: Xin Li <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - New patch.
---
 tools/arch/x86/include/asm/msr-index.h        |  2 +
 .../selftests/kvm/include/x86/processor.h     |  1 +
 tools/testing/selftests/kvm/x86/msrs_test.c   | 52 ++++++++++++++++++-
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 18c4be75e927..14632e29f981 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -64,6 +64,8 @@
 #define MSR_IA32_FRED_SSP3	0x1d3			/* Level 3 shadow stack pointer */
 #define MSR_IA32_FRED_CONFIG	0x1d4			/* Entrypoint and interrupt stack level */
 
+#define FRED_CONFIG_RESERVED		(BIT_ULL(2) | GENMASK_ULL(5, 4) | BIT_ULL(11))
+
 /* Intel MSRs. Some also available on other CPUs */
 #define MSR_TEST_CTRL				0x00000033
 #define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..916646cb4d89 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -195,6 +195,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_FRED		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 17)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86/msrs_test.c b/tools/testing/selftests/kvm/x86/msrs_test.c
index f7e39bf887ad..6e2d8b8f1bd3 100644
--- a/tools/testing/selftests/kvm/x86/msrs_test.c
+++ b/tools/testing/selftests/kvm/x86/msrs_test.c
@@ -60,9 +60,23 @@ static const u64 u64_val = 0xaaaa5555aaaa5555ull;
 #define MSR_TEST_CANONICAL(msr, feat)					\
 	__MSR_TEST(msr, #msr, canonical_val, NONCANONICAL, 0, feat)
 
+#define MSR_TEST_CANONICAL2(msr, feat, f2)				\
+	____MSR_TEST(msr, #msr, canonical_val, NONCANONICAL, 0, feat, f2, false)
+
 #define MSR_TEST_KVM(msr, val, rsvd, feat)				\
 	____MSR_TEST(KVM_REG_ ##msr, #msr, val, rsvd, 0, feat, feat, true)
 
+/* FRED RSPs are 64-byte aligned, thus bits 5:0 are all zero */
+static const u64 fred_rsp_canonical_val = canonical_val + 0xbc0;
+
+/*
+ * FRED SSP[123] are 8-byte aligned, thus bits 2:0 are all zero.
+ *
+ * For legacy reasons, FRED SSP0 is allowed to be 4-byte aligned, but treat
+ * it as 8-byte aligned to simplify the tests.
+ */
+static const u64 fred_ssp_canonical_val = canonical_val + 0xbc8;
+
 /*
  * The main struct must be scoped to a function due to the use of structures to
  * define features.  For the global structure, allocate enough space for the
@@ -388,8 +402,9 @@ static void test_msrs(void)
 		MSR_TEST2(MSR_IA32_S_CET, CET_ENDBR_EN, CET_RESERVED, IBT, SHSTK),
 		MSR_TEST2(MSR_IA32_U_CET, CET_SHSTK_EN, CET_RESERVED, SHSTK, IBT),
 		MSR_TEST2(MSR_IA32_U_CET, CET_ENDBR_EN, CET_RESERVED, IBT, SHSTK),
-		MSR_TEST_CANONICAL(MSR_IA32_PL0_SSP, SHSTK),
-		MSR_TEST(MSR_IA32_PL0_SSP, canonical_val, canonical_val | 1, SHSTK),
+		MSR_TEST_CANONICAL2(MSR_IA32_PL0_SSP, SHSTK, FRED),
+		MSR_TEST2(MSR_IA32_PL0_SSP, canonical_val, canonical_val | 1, SHSTK, FRED),
+		MSR_TEST2(MSR_IA32_PL0_SSP, canonical_val, canonical_val | 1, FRED, SHSTK),
 		MSR_TEST_CANONICAL(MSR_IA32_PL1_SSP, SHSTK),
 		MSR_TEST(MSR_IA32_PL1_SSP, canonical_val, canonical_val | 1, SHSTK),
 		MSR_TEST_CANONICAL(MSR_IA32_PL2_SSP, SHSTK),
@@ -398,10 +413,35 @@ static void test_msrs(void)
 		MSR_TEST(MSR_IA32_PL3_SSP, canonical_val, canonical_val | 1, SHSTK),
 
 		MSR_TEST_KVM(GUEST_SSP, canonical_val, NONCANONICAL, SHSTK),
+
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_RSP0, FRED),
+		MSR_TEST(MSR_IA32_FRED_RSP0, fred_rsp_canonical_val, fred_rsp_canonical_val | 1, FRED),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_RSP1, FRED),
+		MSR_TEST(MSR_IA32_FRED_RSP1, fred_rsp_canonical_val, fred_rsp_canonical_val | 2, FRED),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_RSP2, FRED),
+		MSR_TEST(MSR_IA32_FRED_RSP2, fred_rsp_canonical_val, fred_rsp_canonical_val | 4, FRED),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_RSP3, FRED),
+		MSR_TEST(MSR_IA32_FRED_RSP3, fred_rsp_canonical_val, fred_rsp_canonical_val | 7, FRED),
+
+		MSR_TEST_CANONICAL2(MSR_IA32_FRED_SSP0, FRED, SHSTK),
+		MSR_TEST2(MSR_IA32_FRED_SSP0, fred_ssp_canonical_val, fred_ssp_canonical_val | 1, SHSTK, FRED),
+		MSR_TEST2(MSR_IA32_FRED_SSP0, fred_ssp_canonical_val, fred_ssp_canonical_val | 1, FRED, SHSTK),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_SSP1, FRED),
+		MSR_TEST(MSR_IA32_FRED_SSP1, fred_ssp_canonical_val, fred_ssp_canonical_val | 2, FRED),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_SSP2, FRED),
+		MSR_TEST(MSR_IA32_FRED_SSP2, fred_ssp_canonical_val, fred_ssp_canonical_val | 4, FRED),
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_SSP3, FRED),
+		MSR_TEST(MSR_IA32_FRED_SSP3, fred_ssp_canonical_val, fred_ssp_canonical_val | 7, FRED),
+
+		MSR_TEST(MSR_IA32_FRED_STKLVLS, 0xe41be41be41be41b, 0, FRED),
+
+		MSR_TEST_CANONICAL(MSR_IA32_FRED_CONFIG, FRED),
+		MSR_TEST(MSR_IA32_FRED_CONFIG, canonical_val, canonical_val | FRED_CONFIG_RESERVED, FRED),
 	};
 
 	const struct kvm_x86_cpu_feature feat_none = X86_FEATURE_NONE;
 	const struct kvm_x86_cpu_feature feat_lm = X86_FEATURE_LM;
+	const struct kvm_x86_cpu_feature feat_fred = X86_FEATURE_FRED;
 
 	/*
 	 * Create three vCPUs, but run them on the same task, to validate KVM's
@@ -432,6 +472,14 @@ static void test_msrs(void)
 	 * immutable once the vCPU has been run.
 	 */
 	for (idx = 0; idx < ARRAY_SIZE(__msrs); idx++) {
+		/*
+		 * Feature word 0x7:1:EAX used by FRED doesn't exist on some CPU
+		 * models, simply skip clearing FRED feature bit.
+		 */
+		if (!memcmp(&msrs[idx].feature, &feat_fred, sizeof(feat_fred)) &&
+		    !kvm_cpu_has(X86_FEATURE_FRED))
+			continue;
+
 		/*
 		 * Don't clear LM; selftests are 64-bit only, and KVM doesn't
 		 * honor LM=0 for MSRs that are supposed to exist if and only
-- 
2.43.0

