Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A553CA6D;
	Thu, 15 Oct 2026 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095729; cv=none; b=JNj9apMgv2cGMyM13wBCF/hPLtJDx+SHKf0HEYJkUMe9Iezc1Pv3kahSO54s6KiRwPSx1qA7xc9H0EIxeGZ9SJhs9IvyErugdE+xOB7o/7ZBm5y0DRNHtuCPMGABF5b49yWpY6/OGMaW5x4sjcNVrPc7j9UH/6aODj18uL6n+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095729; c=relaxed/simple;
	bh=bE5+1IemOECT05OEvh34mnl/ZoqjgtYYKl4gXF9D0BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjLM9TEjlqhwLHDANUl6HMY3H5OmRBHGewc1ldOlzgUW1taxIHs5lBFXigaztWuMY79oO9hOcB9MIzKrSLmVeMi6z461z4i/9vJSkIZDy2yqZ3AGpAiYSXNB50HGGhN2FPN146PUCnghlXG4SH0AL+2YfUtZglT3ca/wgTijMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDwgL3bg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDwgL3bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095726; x=1823631726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bE5+1IemOECT05OEvh34mnl/ZoqjgtYYKl4gXF9D0BA=;
  b=HDwgL3bgrUZ1ZvZ5eiV1WNWWMjhbCtKpILnDt1VTOTOEHW7SbSdNiPOS
   sw1W+SrzeS8LH6ZKb53dBOoyFh7YkxT22MzuWhpi54bmIRJQH1GgVIEK9
   LIoPD+m1//qvauX/mkmT/CFzFj6xc9b38QVlv9A1W1JwPLmMEZ6kQxDMU
   CzEwIOvWZYVEjEy+s8L+3PQ0kxYL1W+IrS70UVVeWYmO1dHHVgqchO4gt
   sfnlJz3di33uJxW1YWARvG/01B9CCWn4gQCQFehoU3Vk/vXQGxZcnCZ3W
   A+GH4W+lDCzRF5kYhb780ejqNNVriwo7curUYpozjcFSmr5/5rqg+3lQi
   A==;
X-CSE-ConnectionGUID: 4/JoFbNAQre+4ugryk9NQQ==
X-CSE-MsgGUID: 7HjycFQ0S96cj5PRCKzmSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911138"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911138"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:22:02 -0700
X-CSE-ConnectionGUID: REvyi5jzSzS0k4n65gpYaQ==
X-CSE-MsgGUID: fTOr0R0jRGOlhEPoB7vVEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844502"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:22:00 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 6/6] KVM: selftests: Extend set_sregs_test to cover LASS
Date: Thu, 15 Oct 2026 13:19:40 -0700
Message-ID: <20261015201940.1655956-7-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015201940.1655956-1-sohil.mehta@intel.com>
References: <20261015201940.1655956-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend set_sregs_test to cover CR4.LASS and verify that KVM_SET_SREGS
accepts CR4.LASS when LASS is supported, and rejects it, without
modifying sregs, when it isn't.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Kishen Maloor <kishen.maloor@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v5:
 - Avoided the CR4 write test specific to LASS.
 - Picked up review and test tags

v4:
 - New patch
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 ++
 tools/testing/selftests/kvm/x86/set_sregs_test.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 5898a277a2e0..606ee9fe0ddb 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -81,6 +81,7 @@ const char *ex_str(int vector);
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_LASS		(1ul << 27)
 
 struct xstate_header {
 	u64				xstate_bv;
@@ -197,6 +198,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_LASS		KVM_X86_CPU_FEATURE(0x7, 1, EAX, 6)
 #define	X86_FEATURE_XTILECFG		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 17)
 #define	X86_FEATURE_XTILEDATA		KVM_X86_CPU_FEATURE(0xD, 0, EAX, 18)
 #define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
diff --git a/tools/testing/selftests/kvm/x86/set_sregs_test.c b/tools/testing/selftests/kvm/x86/set_sregs_test.c
index 5afc4187f5eb..f30dc61fe00f 100644
--- a/tools/testing/selftests/kvm/x86/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86/set_sregs_test.c
@@ -72,6 +72,8 @@ static u64 calc_supported_cr4_feature_bits(void)
 		cr4 |= X86_CR4_SMAP;
 	if (kvm_cpu_has(X86_FEATURE_PKU))
 		cr4 |= X86_CR4_PKE;
+	if (kvm_cpu_has(X86_FEATURE_LASS))
+		cr4 |= X86_CR4_LASS;
 
 	return cr4;
 }
@@ -128,6 +130,7 @@ static void test_cr_bits(struct kvm_vcpu *vcpu, u64 cr4)
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMEP);
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_SMAP);
 	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_PKE);
+	TEST_INVALID_SREG_BIT(vcpu, cr4, sregs, X86_CR4_LASS);
 
 	for (i = 32; i < 64; i++)
 		TEST_INVALID_SREG_BIT(vcpu, cr0, sregs, BIT(i));
-- 
2.43.0

