Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCF3D75A8;
	Wed, 29 Jul 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354250; cv=none; b=s2LEKkY2/frK03a1gi5TJ3nN5kHAEgcRvWefkpxCssocMcI4lCctyo4N4jvI0l4zGz6nJnJLJjWnOQBrnGNSAq/WlZ9T2JCmdwUrcOIPxU77+4fJ8AVsBcRPdZ432iLuBVGiVqchJajduc9+wCVRxmD2e0P2WdsG5c6Kohhk5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354250; c=relaxed/simple;
	bh=h7VxCTD9N3GLuadAd7Kgbl147OmRMcBv6s7hLun0H2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmXyBFen7kYOAdLDrnQqU8BBaS35IDH42zJeSPWKWu8DrRvpiYanTNjQo4kOq9T8FfzZaQnuDxfl9pkgJfoip/mI22hksw8mk+Q7FhkUpZThmi2DYVllSdOYaynne5ifEHX4BR6tsif8XlqDw0RPfMazgjMnWT8WqxEfXLUXNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HheBEMSy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HheBEMSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354245; x=1816890245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h7VxCTD9N3GLuadAd7Kgbl147OmRMcBv6s7hLun0H2g=;
  b=HheBEMSypJI01Im8tlN3Ya7Ebe5UjAbz1VHlyJ0LK+gC/l4PWSv3Wrdy
   HU6Va3JIqUMSoH4X28n9nDxNrvyp2ujgCpGu8PNZx3W/m71OdfijcbNnj
   GIXG8EDTqoU3Vs1W1/lD9+bdT6jvHXsL0Bv38NZFxyrSVBw/t1rQ+qby3
   PV9K56OrqJnGweiNUhzmk+lndjTfCyPjAhAYB6zXgXjpGg1L1zKsBFONl
   Pcs7s516gPlh5aURPZ5f8RREcHCK5w/hFm+ESBwHjEO6Ra+FD5XsIBBe0
   Rj1EuctWByKziy/NsUdJKdUGq37SKOwn5O1Rh7JK74abI018BWhVzAsFf
   Q==;
X-CSE-ConnectionGUID: ueBpnFK3RAiM5bMYqxyTdQ==
X-CSE-MsgGUID: PsQj5wBNT/GBYBKLOWWMaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508312"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508312"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:33 -0700
X-CSE-ConnectionGUID: t1LEdCzzRqaKS67hMCNH5Q==
X-CSE-MsgGUID: W0UyEwx9R/+k8ClUtdOS1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769275"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:33 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v6 17/20] KVM: x86: Expose APX foundation feature to userspace
Date: Wed, 29 Jul 2026 19:16:53 +0000
Message-ID: <20260729191656.598771-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
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
V5 -> V6: Add APX leaf 0x29 to cpuid_function_is_indexed() (Sashiko)
---
 arch/x86/include/asm/cpuid/api.h |  1 +
 arch/x86/kvm/cpuid.c             | 10 +++++++++-
 arch/x86/kvm/svm/svm.c           |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 44fa82e1267c..73ebb462ba0e 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -181,6 +181,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1e:
 	case 0x1f:
 	case 0x24:
+	case 0x29:
 	case 0x8000001d:
 		return true;
 	}
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

