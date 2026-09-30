Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3376452121D;
	Wed, 30 Sep 2026 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804121; cv=none; b=b7jrHPYMXSB8dedthwuWGQoqhYpXLNx4foVGqbl4b6q3w0zGa1A05aa2MpjbdtDd8ztWRDdk948JpSp4Ne8Cblof8e0n4gGGEFdGdsOsVw/qZtW9AMCydgNoegPWnaCDxigNivRp3SgewL/Y0BmVvYdcEbdKqQJuacmXr62JUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804121; c=relaxed/simple;
	bh=9Pr/OqWlwJ65nJGUf3sYVS+zij7kk926t84rIvRKQps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtkYG5VFlLRADAHWvrnbKEaKZc0kXQyJrfqJS/d6fOJWwvVEGl+ACaJqzZiUpU2rML+Plgs1YTQTWLm9u5LyAH7GXyjrRaeFpnIpb+3nNbOVzWfdgYYNXvQ17xXZlew8laShB2QJuoauRGdHcZAkGx9IKOLMRItgOBL5IariLfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXu+otXY; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXu+otXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804120; x=1822340120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Pr/OqWlwJ65nJGUf3sYVS+zij7kk926t84rIvRKQps=;
  b=eXu+otXYQ+P7DX3Jjj9P1YBgT/Qxpg7sHlBf3hUhAPg5L005Q+pBw1sO
   yLSZnks92WZN6TDNU4lN27uB8bpzvj/IhvbFdO+6HPykQu7wqcOqBF26K
   7F2a1wm7Lgxax+Nter8Q9mg9OGOkRTt2tgq8T71Mxe0S0L5MMq9I5Z0HY
   RcRWb64RkWr90pdK+VtgZpU0EYtAGCU4C1Y3hJse1OWMI7fkZncMBHX4O
   bFAFqaBSe6fln8x2oXKEsbZeOdl0E33I3CtaAVgRpr1aBuxeHPjRJqAga
   6Gb9dTmN6GZYaECK0QNtHNy12uvYApQNOB2ZEBZG07Z1rGN3ggwi1/51y
   Q==;
X-CSE-ConnectionGUID: x82FdXoNSKeNtm8MtxTWgQ==
X-CSE-MsgGUID: oDhedq1QRJ62vXUye5ZLvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432733"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:35:19 -0700
X-CSE-ConnectionGUID: JHC8QxgERJSWHRVfAhJsdg==
X-CSE-MsgGUID: b9rfxG6tTZiz+quJlMTVfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867401"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:35:19 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 18/20] KVM: x86: Expose APX sub-features to userspace
Date: Wed, 30 Sep 2026 21:07:48 +0000
Message-ID: <20260930210750.1487547-19-chang.seok.bae@intel.com>
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

Add CPUID leaf 0x29 sub-leaf 0 to expose these APX sub-features, if the
APX foundation is available:

  * New Conditional Instructions (NCI)
  * New Data Destination (NDD)
  * Flags Suppression (NF)

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 7 ++++++-
 arch/x86/kvm/reverse_cpuid.h    | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 690de9606d6d..f1e51c055c0f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -729,6 +729,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_29_0_EBX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 990ad7ea4818..6c47e0ffedd8 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1112,6 +1112,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX10_VNNI_INT),
 	);
 
+	kvm_cpu_cap_init(CPUID_29_0_EBX,
+		F(APX_NCI_NDD_NF),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
 		F(LAHF_LM),
 		F(CMP_LEGACY),
@@ -1733,7 +1737,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	}
 	/* APX sub-features */
 	case 0x29:
-		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+		if (!kvm_cpu_cap_has(X86_FEATURE_APX))
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 80b41d5559da..b20c8be4fea6 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -69,6 +69,9 @@
 /* Intel-defined sub-features, CPUID level 0x00000024:1 (ECX) */
 #define X86_FEATURE_AVX10_VNNI_INT	KVM_X86_FEATURE(CPUID_24_1_ECX, 2)
 
+/* Intel-defined sub-features, CPUID level 0x00000029:0 (EBX) */
+#define X86_FEATURE_APX_NCI_NDD_NF	KVM_X86_FEATURE(CPUID_29_0_EBX, 0)
+
 /* CPUID level 0x80000007 (EDX). */
 #define KVM_X86_FEATURE_CONSTANT_TSC	KVM_X86_FEATURE(CPUID_8000_0007_EDX, 8)
 
@@ -112,6 +115,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
 	[CPUID_7_1_ECX]       = {         7, 1, CPUID_ECX},
 	[CPUID_1E_1_EAX]      = {      0x1e, 1, CPUID_EAX},
 	[CPUID_24_1_ECX]      = {      0x24, 1, CPUID_ECX},
+	[CPUID_29_0_EBX]      = {      0x29, 0, CPUID_EBX},
 };
 
 /*
-- 
2.53.0

