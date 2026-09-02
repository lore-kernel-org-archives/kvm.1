Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C9F37DEBB;
	Wed,  2 Sep 2026 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317113; cv=none; b=jRBD9ehVxQcOyxSMzYdWkshpyXs+RHsHpprS1q2PvFp2+7n1JRyrTTKh3z0esOJTimHTY8VltA72QUuvGTsafYbBO6iYVKJaBKPg0WBJamRdQx0TSqY+A29h8WsHHN3sB8Qd7AaAsp8jubQO7HtVzxYxwPJbHWANrx7XnCbEmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317113; c=relaxed/simple;
	bh=Wkl9YcbLjBd3uwGaprj7Yoe1Fj0KHiEEL4E6bkRFBuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDsODb/dHWwRmrmdkfYmwN7HBmLN/jvPkIYIy4CpI7Qh3xZW3qSjvqgje0/BZPc7PuvNlWubp/yac7pTV2pZLM5v0G6LFOju83JVJwRsVEldZ1mkqwQQYXC5nQqN+n90dqtFbOnv3XGze8AyYWHsBpAuJ5A+217N66rntgEvTME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8BIbpwj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8BIbpwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317111; x=1819853111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wkl9YcbLjBd3uwGaprj7Yoe1Fj0KHiEEL4E6bkRFBuw=;
  b=g8BIbpwjhVOD8mSYh2jMIlquCytY1GAUkSdq2jKspFoGJ26Hn7AjpsGk
   0mmJT4lSISsl3u6hoKpoLZ82ald0oMDt3xRCu8WMYnHBrLt/OyiXs3iAv
   KM/s5g08q3dEudOGmZJYFTSNhWXZW3Qg3TancC+DUAWvvpytggZoYkuOQ
   ijZsyCJGqfMtuTE8XQOa0TU/y+Z/eBquBN/PRDHUKMdQY5UCmmx1oQ8l2
   sHDPoj4toQ6rmGrU5UU0CpfZ7K4nOStmVtHTz8bc+4aqyNp006qFbGXSM
   2bumUUfVWHCM7USZOYLcHGCoMLvANG3tB6bmGs3ksN4AlTDNZanZbiA09
   w==;
X-CSE-ConnectionGUID: dq9eiLoaRAed/OTkVWM0MQ==
X-CSE-MsgGUID: rCbrVDbsRt+aekKwZ+5aLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282994"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282994"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:45:04 -0700
X-CSE-ConnectionGUID: HI48lWegT4iWegmmW15cpw==
X-CSE-MsgGUID: U8Xz6itLRU2O7hyU6sGjIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775570"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:45:04 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 18/20] KVM: x86: Expose APX sub-features to userspace
Date: Wed,  2 Sep 2026 02:18:02 +0000
Message-ID: <20260902021804.718676-19-chang.seok.bae@intel.com>
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

Add CPUID leaf 0x29 sub-leaf 0 to expose these APX sub-features, if the
APX foundation is available:

  * New Conditional Instructions (NCI)
  * New Data Destination (NDD)
  * Flags Suppression (NF)

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/cpuid.c            | 7 ++++++-
 arch/x86/kvm/reverse_cpuid.h    | 4 ++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8a0de8b847ea..7da85bea0076 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -728,6 +728,7 @@ enum kvm_only_cpuid_leafs {
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

