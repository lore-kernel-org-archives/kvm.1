Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D81378821;
	Tue, 28 Apr 2026 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354000; cv=none; b=CTUKXMxsX3MI1TO7PQ3gc/22tE6EnuYxLvFu91MCJxuhAcN67C7H9Vvbl3c3e4Ex91MN3+Wedr+4MId1u4BcK2oFPvp4/LWljIKvNy8HqikCVff8juq7kF6X4mXzwySuAxf9UIixfMyih7CO93mUDMU+V9KY6F9M+OQxqo69btI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354000; c=relaxed/simple;
	bh=X2Yv6l6w9yMljlsKPHwIuMguBYQNJkXSCzQ7xbjw2xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaZY7byAGXRlvAANRN00/pe2y4c7NvkhEHGNPzopHnJjKaqIcL1+shFVSzgjgPSI5wNLx3lLCxLdhBsJqr4Myt8pLmyxMK62G+bLBE0BAfu/rO9l5weTZfcwH+/eFjmrzDWh/eWI5RQtrpH+/ltXxB9J5WKj+kE6wXno+WWhdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDcy82eg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDcy82eg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353998; x=1808889998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X2Yv6l6w9yMljlsKPHwIuMguBYQNJkXSCzQ7xbjw2xY=;
  b=fDcy82egYe7SQVA5pIN4yEIm6YYZBnwrqTJTh35zsZExt8EDaW8C9rr1
   2gmuW6BmLkwjwx/fgFlGbXVjy/DDhTyPkA4nlPDP9p2antejRLZ9XmhBm
   soLwpC24Ywlm/fsALIXzcWyOchSNY/c9hrztsjSIVGRLb62AmYa0vGuqV
   bRKxeJ5kPvs8OjgPcYYn+gIgmTuE4fawilQ+LoJUdr8+y744d5hHTTzHK
   HQuMioizHUuSotfpCWxhLHZDv9GAYzFVjQKummdJUpgBoxF+oKE8I2yo4
   VPJGKGhB/3gaYXe3axdZUP2VsOtc9+loG4FB+AxaT1N83rp5KMXM/cT5X
   w==;
X-CSE-ConnectionGUID: 8YNWi8kKRX6R/tNgYHeWOw==
X-CSE-MsgGUID: h6WFDtI5QFms7JiI/fFasg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131749"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131749"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:35 -0700
X-CSE-ConnectionGUID: kn+Cjd78R7Otm2D/4rm7hA==
X-CSE-MsgGUID: Uyk4+JaIRx+To/hu38Zxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130232"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:35 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 18/20] KVM: x86: Expose APX sub-features to guests
Date: Tue, 28 Apr 2026 05:01:09 +0000
Message-ID: <20260428050111.39323-19-chang.seok.bae@intel.com>
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

Add CPUID leaf 0x29 sub-leaf 0 to expose these APX sub-features, if the
APX foundation is available:

  * New Conditional Instructions (NCI)
  * New Data Destination (NDD)
  * Flags Suppression (NF)

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: Gate by APX foundation instead of XCR0
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 9 ++++++++-
 arch/x86/kvm/reverse_cpuid.h    | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 707d7b032a44..bb1112d40bee 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -810,6 +810,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_29_0_EBX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 21dd3dac4211..e570411f3a43 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1111,6 +1111,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX10_VNNI_INT),
 	);
 
+	kvm_cpu_cap_init(CPUID_29_0_EBX,
+		F(APX_NCI_NDD_NF),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
 		F(LAHF_LM),
 		F(CMP_LEGACY),
@@ -1718,7 +1722,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	}
 	/* APX sub-features */
 	case 0x29: {
-		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		if (!kvm_cpu_cap_has(X86_FEATURE_APX)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
 		break;
 	}
 	case KVM_CPUID_SIGNATURE: {
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index de90697c4e5a..cff071ccf926 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -67,6 +67,9 @@
 /* Intel-defined sub-features, CPUID level 0x00000024:1 (ECX) */
 #define X86_FEATURE_AVX10_VNNI_INT	KVM_X86_FEATURE(CPUID_24_1_ECX, 2)
 
+/* Intel-defined sub-features, CPUID level 0x00000029:0 (EBX) */
+#define X86_FEATURE_APX_NCI_NDD_NF	KVM_X86_FEATURE(CPUID_29_0_EBX, 0)
+
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
@@ -110,6 +113,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
 	[CPUID_24_1_ECX]      = {      0x24, 1, CPUID_ECX},
+	[CPUID_29_0_EBX]      = {      0x29, 0, CPUID_EBX},
 };
 
 /*
-- 
2.51.0

