Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CF345CBC;
	Tue, 28 Apr 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353999; cv=none; b=V9wHpXc55t4S41kd7jrnhqQKLmezLaVPe9kae2qRHemKKpj7Qye1XhzeTAS8PQX864P1Yvand43GqqIq/TJUUuNlIPw3YxybIxhpaUFUixsf/CvA5GA51qDE7sfeYopPoNqHDDSXDdNMOFuG4ImMt9BzaQMd06zPpxeenMpjAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353999; c=relaxed/simple;
	bh=ZJM/wrnM8+Dz0yfe1dbQ9sc67Jq3Vx8mS7vE+ND6vSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ELg39fuxF/dhElwqAuc0bewZQAQ0w+QNVvYAFhNq46rYqUX0FNsPzXnyyAzp6JrZe7AHeW8/z//8BhZFDAhGxgtqf7zLSOW+r0Q3iJh6HomLaWZ4GWM00qb18RGGexhLyYsCTdrtFdbndhMP1SfDxMLq+by92G60Q+HrAVAlG5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTeg2daw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTeg2daw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353998; x=1808889998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZJM/wrnM8+Dz0yfe1dbQ9sc67Jq3Vx8mS7vE+ND6vSI=;
  b=mTeg2dawX6XlvkPErhn9zqSpIv8MXjJykUDsFcDahI7uWAoUknj7vH26
   q2oZ4dByX0zuDCzIlJzf6zzMcejbYw/NhT7CS31ynNdlQkiolrKIXQ2G+
   LFLnWEZ/oMoYDG2QMxXdn+kLCa3gpkz84ptptnFejExY1E8UcnhCooXpm
   RY32ghA/9Y6Wbzgcz1xCoOUasPqPi0X3PbZBQPcEhUcTAVhNmQNT3KY6b
   k20lV6siB1PhgMPZzKFr+RSccVSd4RvYZfRb6gJ9p8Cy9iLsdzuz18Md7
   3VAqnjg8oCXP+29DIpDyk9A7NxWJrZyC2HzVCFJfS8+KRNvutZU0MSmHa
   g==;
X-CSE-ConnectionGUID: pP+yGYntTXO6aV94JhjZdQ==
X-CSE-MsgGUID: OkoSCqBkQN6CxZAuS6ZB3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131745"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:34 -0700
X-CSE-ConnectionGUID: EtagUIT6QDee+fNDiixS9w==
X-CSE-MsgGUID: jju6eY/JRDyGF8C7l2aT/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130229"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:34 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v3 17/20] KVM: x86: Expose APX foundation feature to guests
Date: Tue, 28 Apr 2026 05:01:08 +0000
Message-ID: <20260428050111.39323-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the APX xfeature bit to the list of supported XCR0 components and
expose the APX feature to guests. Update the maximum supported CPUID leaf
to 0x29 to include the APX leaf.

On SVM, do not advertise APX, as EGPR support is not yet implemented.

No APX sub-features are enumerated yet. Those will be exposed in a
separate patch.

Originally-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Make both APX XCR0 and CPUID consistent with CONFIG_KVM_APX

Note: with recent changes, the patch now is pretty much in a different
shape from the original.
---
 arch/x86/kvm/cpuid.c   | 11 ++++++++++-
 arch/x86/kvm/svm/svm.c |  1 +
 arch/x86/kvm/x86.c     |  8 +++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 82cb7c8fbc07..21dd3dac4211 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1061,8 +1061,12 @@ void kvm_initialize_cpu_caps(void)
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
@@ -1441,7 +1445,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1712,6 +1716,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	}
+	/* APX sub-features */
+	case 0x29: {
+		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		break;
+	}
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 080bc2f829d9..d1da1c1ca6e8 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5527,6 +5527,7 @@ static __init void svm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b6b2fd877893..a3a0692fa25e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -219,10 +219,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_nr_uret_msrs);
 static u32 __read_mostly kvm_uret_msrs_list[KVM_MAX_NR_USER_RETURN_MSRS];
 static DEFINE_PER_CPU(struct kvm_user_return_msrs, user_return_msrs);
 
+#ifndef CONFIG_KVM_APX
+#undef  XFEATURE_MASK_APX
+#define XFEATURE_MASK_APX 0
+#endif
+
 #define KVM_SUPPORTED_XCR0     (XFEATURE_MASK_FP | XFEATURE_MASK_SSE \
 				| XFEATURE_MASK_YMM | XFEATURE_MASK_BNDREGS \
 				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
-				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE)
+				| XFEATURE_MASK_PKRU | XFEATURE_MASK_XTILE \
+				| XFEATURE_MASK_APX)
 
 #define XFEATURE_MASK_CET_ALL	(XFEATURE_MASK_CET_USER | XFEATURE_MASK_CET_KERNEL)
 /*
-- 
2.51.0

