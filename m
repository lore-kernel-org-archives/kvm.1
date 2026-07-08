Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A393F5BF3;
	Wed,  8 Jul 2026 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546035; cv=none; b=IGY6bG7iLnE3FQRs5l6x3eE+qVQov2SV1WsE6Xim+V6ZcQ20Jx5RMSF8RvGVRZQOBTNyE3rrfiD+n7Bz4c+vELBCnpEn/FVguuK/s6Q7zk2TqTYvgrl/zPOWF3U8nRxlSHd+vJezWNj9OE5x3Gy/ikxACaZ3cSn0inuPsU8aomo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546035; c=relaxed/simple;
	bh=BYyluYDmPWkGcE7cWaxqcOhBWLXQ1413Gx5Hu67VXM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sb9hdTytfxPQDWmEj62mbL1xd5hVvx8fBwFX1bN/LrN5Ad4Vrseljl1p26BDssILF5FvzHk7gng4vqpfdMwqGa7Rmjl0c4Wf3VrKbNEKFAN1umz29n8eQvrhevXH6tdAtqjUY8SVrO6FEOZudXV0A9wFhtjNxAMBNuqtgOVUXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxZle7uK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxZle7uK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783546034; x=1815082034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BYyluYDmPWkGcE7cWaxqcOhBWLXQ1413Gx5Hu67VXM0=;
  b=gxZle7uKWsUu3l8pTayp7BnfTCLCHAzveOJIDpmWmfYZc1ksmlXGJprq
   d0MDaUK1+zkKZbbkW//9lyKeMU01id7a5LlOyBgPtzcHG5TA+Betv0p76
   ZDZXwFm49lAhOOFMnnylyJweJCUdfXMeCTOJ5Qsz2+cY457K4o+usHEFd
   ld6F2sBg2iEoBtpypEdEXtOPKYS4q9QVEOOMQ/DbXPkr/QNEJKytrRuuW
   KPIGVpsWEVjxRXReje71uPqDBdfiVQwL+yiiu1SnGkONxu5+T9F3E6Gyv
   ieqL30qDmkhJB5CTvhyaWLQc2uTUiboeiNnZM4ZYJpnqlSt92QQz6kobB
   A==;
X-CSE-ConnectionGUID: gBlSUuBiS0WYqssM5HEDuw==
X-CSE-MsgGUID: hC6nSzD/SBGUgAtaB5fjhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107016572"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="107016572"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 14:27:13 -0700
X-CSE-ConnectionGUID: jm0uBBq9Szq8dW4LDMXs+Q==
X-CSE-MsgGUID: i1f8mDyRRgSB2tIVaaQs4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="249978584"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jul 2026 14:27:13 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	chang.seok.bae@intel.com,
	Zhao Liu <zhao1.liu@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH] KVM: x86: Remove AMX-TF32 enumeration
Date: Wed,  8 Jul 2026 21:01:18 +0000
Message-ID: <20260708210118.402005-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMX-TF32 enumeration was added based on the Intel documentation [1]. The
recent update removed the feature, indicating that the feature is no
longer planned for hardware implementation.

[1] Intel Architecture Instruction Set Extensions and Future Features

Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Note: The feature first appeared in the September 2025 revision of the
document and was removed in the June 2026 revision.
---
 arch/x86/kvm/cpuid.c         | 1 -
 arch/x86/kvm/reverse_cpuid.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 591d2294acd7..759a1c557080 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1082,7 +1082,6 @@ void kvm_initialize_cpu_caps(void)
 		F(AMX_COMPLEX_ALIAS),
 		F(AMX_FP16_ALIAS),
 		F(AMX_FP8),
-		F(AMX_TF32),
 		F(AMX_AVX512),
 		F(AMX_MOVRS),
 	);
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 2ad25781cefb..1bb13903c5b2 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -56,7 +56,6 @@
 #define X86_FEATURE_AMX_COMPLEX_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 2)
 #define X86_FEATURE_AMX_FP16_ALIAS	KVM_X86_FEATURE(CPUID_1E_1_EAX, 3)
 #define X86_FEATURE_AMX_FP8		KVM_X86_FEATURE(CPUID_1E_1_EAX, 4)
-#define X86_FEATURE_AMX_TF32		KVM_X86_FEATURE(CPUID_1E_1_EAX, 6)
 #define X86_FEATURE_AMX_AVX512		KVM_X86_FEATURE(CPUID_1E_1_EAX, 7)
 #define X86_FEATURE_AMX_MOVRS		KVM_X86_FEATURE(CPUID_1E_1_EAX, 8)
 
-- 
2.53.0

