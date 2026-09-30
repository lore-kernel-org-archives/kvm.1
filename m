Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB22535FB1;
	Wed, 30 Sep 2026 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804119; cv=none; b=Oj4UGyc4nJf2RMea261tFnM5jPdeYxO/sOEzwHxO+YtKXl0Z1XY8zw6bhr7S1O7TnMjDwm4OX6QgO8kxc0hpoSkWEWE15SYa7NZyNHdsxM7m3mmRNogysZ8F3RBR3c8pAfdSx4+ILcRhjtId/nEF1a6VQxyTtbjJsPe9qA/Lweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804119; c=relaxed/simple;
	bh=1wyZnsmdf31qT1qwa/X7mzrOmoFGRg3aNCHF+s1JFbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwFfLTnLN5ghbUv2LXFLPkXg7dunqBZoODhiL33NIUQ/yObYsdQCMKftpz3qM7jwTFm5H+t2d+teuNvauI8jGkr3UBCHCQZuNASPbhpxoQdPDZpcp+ase/s0MDN56QgfpdByuJOOoD9RzlWkYLYiM20My+c7ZZenfcOwCprKY+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8tYMTuj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8tYMTuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804118; x=1822340118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1wyZnsmdf31qT1qwa/X7mzrOmoFGRg3aNCHF+s1JFbM=;
  b=n8tYMTujELO3pJLAV+XK7Fbm/oFdjffZhMpJRhk1MoyZxivEey9Booop
   FzwPR/9hDmqTX4HPWht2bIEpRWlnmLZN+hpJlYMUf7I9IObrCmL1fHliR
   OeBAxkE5PRF96KWYNhlSHCkhLhbRJUMHP3+iR09YonXfLUFjnMm6rSFy5
   8B4jRAqTCq6jzqopISgiLac0nN93aZIPkmNN5/6FuDFMOWy2qHkDoMpj2
   f/2mqHPogmTyXYwGzE/CpSedlWrCcj9zncfMuPHU0x+xOkzJ1i+qBhuAo
   DRoeUeMTSJTnIB9QTQNNSqjf8IIOXgsuNKNACTLmm9NgbgkWxjXOmWOc+
   Q==;
X-CSE-ConnectionGUID: kAfL/PicRviQp/5CLSpZvA==
X-CSE-MsgGUID: QdbJkQPXQVqEUiSdZ/TcEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432729"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432729"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:18 -0700
X-CSE-ConnectionGUID: LKhF7IkLT+WhHAEvtcE38Q==
X-CSE-MsgGUID: rDKnISp+QcmLSX5X4y4RUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867396"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:18 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v8 17/20] KVM: x86: Expose APX foundation feature to userspace
Date: Wed, 30 Sep 2026 21:07:47 +0000
Message-ID: <20260930210750.1487547-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the APX feature to userspace component. Update the maximum
supported CPUID leaf to 0x29 to include the APX leaf.

On SVM, do not advertise APX, as EGPR support is not yet implemented.

No APX sub-features are enumerated yet. Those will be exposed in a
separate patch.

Originally-by: Peter Fang <peter.fang@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/cpuid/api.h |  1 +
 arch/x86/kvm/cpuid.c             | 10 +++++++++-
 arch/x86/kvm/svm/svm.c           |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 82eddfa2347b..f38d5e8a3c05 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -182,6 +182,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1e:
 	case 0x1f:
 	case 0x24:
+	case 0x29:
 	case 0x8000001d:
 		return true;
 	}
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e72543088695..990ad7ea4818 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1062,8 +1062,12 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX_VNNI_INT16),
 		F(PREFETCHITI),
 		F(AVX10),
+		SCATTERED_F(APX),
 	);
 
+	if (!IS_ENABLED(CONFIG_KVM_APX))
+		kvm_cpu_cap_clear(X86_FEATURE_APX);
+
 	kvm_cpu_cap_init(CPUID_7_2_EDX,
 		F(INTEL_PSFD),
 		F(IPRED_CTRL),
@@ -1456,7 +1460,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1727,6 +1731,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	}
+	/* APX sub-features */
+	case 0x29:
+		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		break;
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 2962501c4b67..7d9314645872 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5597,6 +5597,7 @@ static __init void svm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
-- 
2.53.0

