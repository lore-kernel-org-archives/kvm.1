Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F4C37475B
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411130; cv=none; b=nFZ8ghz5lCgP0R77I/SC5fVcwY8nUCxS/KNrQzs0ZoflALIjtwS6uhdngcxJKsbkKTAra10H00WCZ4K+WdN07lLIIExgApsi1GggUIaT/HXytr8U4hSI+BenULfCHFdZhyW6CeFn9QITSdnbWfW8PaOKS1hDqkYTGh+1ftUqVes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411130; c=relaxed/simple;
	bh=DYroadLYZ3vHawS6R2/C6mU1YlGE/m10ELXHsun8edg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERz+doOUN0r3SkcIV2UUWTHWiNd6Rg2P0DNH5QP+jcdUytDxFyUWJ99s/Zkf4fQ/j10CBr0UghZnLsNMk1RY2SQCB37c6ZyyBI7pNfBf0QdRbt7DhwPzCfCQItgizrCVOE6iYrkQIwd5lpaPhuncFVlb6m5Nrpw+a+pFX8bv3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPqBVt99; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPqBVt99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411129; x=1807947129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYroadLYZ3vHawS6R2/C6mU1YlGE/m10ELXHsun8edg=;
  b=CPqBVt99HNGeFVX2bqS9U4nUddYe7ti4FSxNdIrN6smRjSNRnAhXRpPc
   bhghjBjn+MILRy+TOomve8/OO0oWi2NB23+Ijm7CTmqw29/cRq2EBaQUD
   41ffwj+fyw1C53LPRnJaGrLm6z9kXd77LyQUJ3nICx/YDciXt6fRGwuxZ
   kfLmVpAeEr6hW+Opab27d5TNY8gqdEUeal4uO21O2IdvRdB3WSjo8+CLn
   AnJW1L1pRPtlbfN6Vgt72Lq2xP44UAyy/kl9wPXBIhqoRac1q38I3bLhn
   o3QrkYwAhZykAATl2zZWwc0TX7lA8YX6pQyDRmmKyPOwlOKc9XyP2rYwR
   Q==;
X-CSE-ConnectionGUID: hWwMO3CqRcaZsl2vJOm/iA==
X-CSE-MsgGUID: Q6nhb/8TSZKaDSmJ1akyuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070120"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070120"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:08 -0700
X-CSE-ConnectionGUID: 1X+KU3wBQ32yrMIQZHzDDA==
X-CSE-MsgGUID: QPD9bJeFQneWnKMRYS3eIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284830"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:05 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 02/27] KVM: x86: Reorder the features for CPUID 7
Date: Fri, 17 Apr 2026 15:35:45 +0800
Message-ID: <20260417073610.3246316-3-binbin.wu@linux.intel.com>
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

Reorder the feature bits in CPUID_7_ECX, CPUID_7_EDX and CPUID_7_1_EAX
to align with the hardware defined order.

Opportunistically add comments for unsupported bits for CPUID_7_ECX and
CPUID_7_EDX.

No functional change intended.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 48 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 25f582a8d795..056f86121728 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -947,26 +947,34 @@ void kvm_initialize_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_7_ECX,
+		/* PREFETCHWT1 */
 		F(AVX512VBMI),
-		PASSTHROUGH_F(LA57),
+		F(UMIP),
 		F(PKU),
 		RUNTIME_F(OSPKE),
-		F(RDPID),
-		F(AVX512_VPOPCNTDQ),
-		F(UMIP),
+		VENDOR_F(WAITPKG),
 		F(AVX512_VBMI2),
+		X86_64_F(SHSTK),
 		F(GFNI),
 		F(VAES),
 		F(VPCLMULQDQ),
 		F(AVX512_VNNI),
 		F(AVX512_BITALG),
+		/* TME */
+		F(AVX512_VPOPCNTDQ),
+		/* Reserved */
+		PASSTHROUGH_F(LA57),
+		/* MPX_MAWAU */
+		F(RDPID),
+		/* KEY_LOCKER */
+		F(BUS_LOCK_DETECT),
 		F(CLDEMOTE),
+		/* Reserved */
 		F(MOVDIRI),
 		F(MOVDIR64B),
-		VENDOR_F(WAITPKG),
+		/* ENQCMD */
 		F(SGX_LC),
-		F(BUS_LOCK_DETECT),
-		X86_64_F(SHSTK),
+		/* PKS */
 	);
 
 	/*
@@ -985,23 +993,31 @@ void kvm_initialize_cpu_caps(void)
 		kvm_cpu_cap_clear(X86_FEATURE_SHSTK);
 
 	kvm_cpu_cap_init(CPUID_7_EDX,
+		/* Reserved, SGX_KEYS */
 		F(AVX512_4VNNIW),
 		F(AVX512_4FMAPS),
-		F(SPEC_CTRL),
-		F(SPEC_CTRL_SSBD),
-		EMULATED_F(ARCH_CAPABILITIES),
-		F(INTEL_STIBP),
-		F(MD_CLEAR),
-		F(AVX512_VP2INTERSECT),
 		F(FSRM),
+		/* UINT, Reserved, Reserved */
+		F(AVX512_VP2INTERSECT),
+		/* SRBDS_CTRL */
+		F(MD_CLEAR),
+		/* RTM_ALWAYS_ABORT, Reserved, TSX_FORCE_ABORT */
 		F(SERIALIZE),
+		/* HYBRID_CPU */
 		F(TSXLDTRK),
+		/* Reserved, PCONFIG, ARCH_LBR */
+		F(IBT),
+		/* Reserved */
+		F(AMX_BF16),
 		F(AVX512_FP16),
 		F(AMX_TILE),
 		F(AMX_INT8),
-		F(AMX_BF16),
+		F(SPEC_CTRL),
+		F(INTEL_STIBP),
 		F(FLUSH_L1D),
-		F(IBT),
+		EMULATED_F(ARCH_CAPABILITIES),
+		/* CORE_CAPABILITIES */
+		F(SPEC_CTRL_SSBD),
 	);
 
 	/*
@@ -1033,8 +1049,8 @@ void kvm_initialize_cpu_caps(void)
 		F(FZRM),
 		F(FSRS),
 		F(FSRC),
-		F(WRMSRNS),
 		X86_64_F(LKGS),
+		F(WRMSRNS),
 		F(AMX_FP16),
 		F(AVX_IFMA),
 		F(LAM),
-- 
2.46.0

