Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFF47DF93;
	Mon, 20 Jul 2026 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569612; cv=none; b=Ok5Xw751ij+G0W1iGdvGKfvYfdmY9fU7s18tBkxaUGrb05CHzNn6L5gQNQTAulGS29afWU8Td+fDhHvtNjbuTnzB2RKNbtk+EYKl/HwDkKT7ruWH2f4Y+fhlTxM8lTaGsAHUIzs6zH45cZRAxMxU3bJX5R7Pr0IEuETIoQvbRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569612; c=relaxed/simple;
	bh=IhZeM7zxjWaSgsnlxClxC83wEUNt59WiQ2MHUpItWFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3y2QOulw+YXQJR7JiJOOjpL3oGSR/+4i01m/XQSc7dM+8jI/x2rC6BS3v2C/BsqchXeDoUOWIEF2PygEW0aWGQBw3nf1yeHmjDy+rbwJc8XAN1NFX0NtU6pRw23HEjfJzR0Q+Fc+Phi9q0qvyVbTQf+1cJsTtuAczIDnRhcsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuFIubv3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuFIubv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569605; x=1816105605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IhZeM7zxjWaSgsnlxClxC83wEUNt59WiQ2MHUpItWFc=;
  b=UuFIubv3LE3XRap7+olFIEOGoW2h01smLzHJ/B9NjijdfnfiYP8AI9ju
   Wq52QRM+WAY9mTjZCXQ8tepBc4VVUf1/asUdbBu1RucuGycAV4T0lVHYm
   pqILuGQ+yX83vUS5iGlRXebXc1U4OYYwl5zv927klG/fFE0hdVpEKekMQ
   nfQidQ8eq8wR2kUEmau/Sb4JZwg4FWxMO/uucL+C3nMp7VQZOrN7iaHMF
   ZbNVJniZtGL6RxdXB5pyBEssshV8WZH6HHTlKPGtDBg5eyR3Zj54PCLjg
   hHJIxxzYn+WzrnEgHSIWDuC+BRMXOe5mOQcpp31HyNNMuRO50kl4XJx/o
   A==;
X-CSE-ConnectionGUID: z6aZTtPMRrW0Cu92UqflPA==
X-CSE-MsgGUID: a0JO+rsNT5+dSlpbmis9VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691710"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:12 -0700
X-CSE-ConnectionGUID: /cH0cVd7QUOHk5mYhG2HhA==
X-CSE-MsgGUID: aVfnZWW5TMOJZHqvXtnwFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575396"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:12 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v5 17/20] KVM: x86: Expose APX foundation feature to userspace
Date: Mon, 20 Jul 2026 17:19:46 +0000
Message-ID: <20260720171949.498680-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
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
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/cpuid.c   | 10 +++++++++-
 arch/x86/kvm/svm/svm.c |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1fc7a0f9a13a..db95f6b578d0 100644
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
@@ -1442,7 +1446,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1713,6 +1717,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
index eb1b2ba1261d..573411777662 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5593,6 +5593,7 @@ static __init void svm_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
-- 
2.53.0

