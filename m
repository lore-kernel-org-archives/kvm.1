Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA86378D8D;
	Wed,  2 Sep 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317108; cv=none; b=gX6S+DAd+OOocPJ0W3b8Bov6nbOAJY3KexJAOIsLAQJOoedOg7pbRoLXKenvTpQevPlYPRZArK2xr3+QyJ8HZhdVj0hGottSF+GrrGiCEn/LbbLFXTjTUH0DnpaHrHHJSQfxJZJUlCTe+b63L1moCtfnbHdD7jLwJ2FbMmo345M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317108; c=relaxed/simple;
	bh=sQ9ZwXSxElKmgkXdb5Gcnm9DHXKelRbqWnWmrRqwyiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXAsjkhn7rO4yJ3mfYH+1WjzboeY6OtV/k7+5aKOgAHWcLSs0Ia8kDoVTMFhrRj0a39OsyyjZGhA3p6JcdUFYGfIG6Ak1DN7snHNZcvOxsN297Pr5L0czCj1C1Zf1MJgUIMjNa2r5a969yoK0T0H/6CKzCIdFh24Ie9tn6HzYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXwfebxp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXwfebxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317107; x=1819853107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQ9ZwXSxElKmgkXdb5Gcnm9DHXKelRbqWnWmrRqwyiw=;
  b=YXwfebxp6iX5epOEaDtCsLWY9aefYt31TTEZi9IKikF1+w8ZU1ePc3ye
   Ms6S0ixuahxPRGdqIiMxoO8DvFCNlcNZaFeWUuPfmTxGzOQMn0yeQC+g+
   /At5V10cMMrL/gZyCrMY6N1dQVempo7//Z5dzV/DZyPUfQZxY1gIorlcE
   fBujL0KyFIkdD6cq3yc+Um43D7LNXanRQNTmZXXdhA4B8mexTw70/8S/b
   MSrdUNi1QWo4ZrXOeb2AVI8D8ZHiJPxplNsI+9yPPstKMw5+m/z4UV88s
   hR1NRwWMTMpTsLj6Ah2HTtuWY0H8YneDGtjNoZdvGodZEzINFeYjuXPua
   g==;
X-CSE-ConnectionGUID: AMpwMN3ZRVC7/EbXDf7/vw==
X-CSE-MsgGUID: IVaNoYwtSKegImrig5Mtcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282985"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:45:03 -0700
X-CSE-ConnectionGUID: OSG3NSI4RiybSmLnrNNyMA==
X-CSE-MsgGUID: LOhl4iO+Q9Opa+C3+y17bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775555"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:45:03 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com,
	Peter Fang <peter.fang@intel.com>
Subject: [PATCH v7 17/20] KVM: x86: Expose APX foundation feature to userspace
Date: Wed,  2 Sep 2026 02:18:01 +0000
Message-ID: <20260902021804.718676-18-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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

