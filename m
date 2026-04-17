Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCB375ACF
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411154; cv=none; b=WFEgEVw4oRXZpUwVygvB4hGw22fxSZxtdBOxqTTl/oo5xKM67QhOfO8o4/Hpr9hCXq/QcMdrnG0O/UW0pTtB+yzsydfE2mGh+mNW2TdtS4Lf9UOucj80dmi4ca68+NxccVcD67DSeHzu3cZqW1ZFiKtt6QnKfGcEulSqxRrpEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411154; c=relaxed/simple;
	bh=uwFyOP6f56OLQye1sM8/AVVFhs1SdRMwyrTIN17qQxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJnKWVRKYAeiczSNFCudQMfqdVlL/X4cTpWPyC7qe1qp21b6soD8UkS4jmpxLWqQiG7MDyivhvsOuwe46J1O8KkuXpvmKA2TAnbDHlN3B9eed05V22bT0lPiuv3US4Tbzt4032ZNkZoBGMserW1QX4OsM4n5zLU6o9FV6/CDHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBYl3toq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBYl3toq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411154; x=1807947154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwFyOP6f56OLQye1sM8/AVVFhs1SdRMwyrTIN17qQxw=;
  b=FBYl3toqcljU3VHw0WYOYFG1CFSFgSw7fuzRq8xHxVOwThve9eNS0NcN
   KV7MrjBgIo2PQqjocMugUIPCTd9mZTKDuCYGAxaHUu3HnHi6BQt+rtkZI
   M1mDXin/kMWCC5MBHqWijd4yvBUOBZa8nt2Afs4F0idhmhi6J4sDVZI2T
   IzizfgLOYKcK90B6QaX795ZbIvG1/DiYsRbSKjqQWaKBQPBFakK7rF6mL
   xBF725/vyx3OKVj6/VAWDhZogoNFq/iV1p9i2P7m7x3gILQhZpZ2NFWcL
   ABp1oAVXEM1iF3cZkbDx5g4d1rjgpo74lpogeMVV8JyHzq/Z+Wa+hKJVj
   Q==;
X-CSE-ConnectionGUID: N2Uqm+r1TrSgF1yzgiqi5w==
X-CSE-MsgGUID: kQx3tBuwQTmuBIiFNbgSKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070207"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:28 -0700
X-CSE-ConnectionGUID: QpUCXuhKSUunbz3nTlEHHA==
X-CSE-MsgGUID: 1JlOaocDRfam4C0WInkJgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284927"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:25 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 11/27] KVM: SVM: Drop unnecessary clears of unsupported common x86 features
Date: Fri, 17 Apr 2026 15:35:54 +0800
Message-ID: <20260417073610.3246316-12-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kvm_cpu_cap_clear() calls for IBT, BUS_LOCK_DETECT, and MSR_IMM
in svm_set_cpu_caps() since they are not set in common code anymore.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/svm/svm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a21c500e1a91..ab3405640764 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5445,8 +5445,6 @@ static __init void svm_set_cpu_caps(void)
 
 	kvm_caps.supported_perf_cap = 0;
 
-	kvm_cpu_cap_clear(X86_FEATURE_IBT, F_CPUID_SVM);
-
 	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
 	if (nested) {
 		kvm_cpu_cap_set(X86_FEATURE_SVM, F_CPUID_SVM);
@@ -5517,13 +5515,6 @@ static __init void svm_set_cpu_caps(void)
 	/* CPUID 0x8000001F (SME/SEV features) */
 	sev_set_cpu_caps();
 
-	/*
-	 * Clear capabilities that are automatically configured by common code,
-	 * but that require explicit SVM support (that isn't yet implemented).
-	 */
-	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT, F_CPUID_SVM);
-	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM, F_CPUID_SVM);
-
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
-- 
2.46.0

