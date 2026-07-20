Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8044D01F;
	Mon, 20 Jul 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569608; cv=none; b=X/ZXNB34zmJGLGps4CU8eOoNeMdQCNsaJ1RXY6Y3yuG9H1ov+0D1CaRaE4tuGDrQGGFM7sY0vusNWyhyprQ4kwG3Eyksvt7rFxAj3fGRJB5BU9+JzrRC/IhIC3a6Bl9TujkhR5FJ8/D9Pnxms2vqQjh2AeXcqOtYWNSUqYmsxHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569608; c=relaxed/simple;
	bh=bqZmDjqMzToiwaBoty66E+PLAi3LUEdaxonitqJz6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDARohwyF2JWY+1H5oUD8ZtwSTh8+cdP0GzMaXuDBcInZlhGkmoeG15UpNpRum+eJ71zodCJguuW8SqfgESey9RWOuYZqca9SvOKEcWZGTOEAwUx0w9tL1EqWLxwNLsgpnBjUj2GLSrskEude3lWAp6kx1NpSI1TUClIm4coCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8uhSxve; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8uhSxve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569606; x=1816105606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bqZmDjqMzToiwaBoty66E+PLAi3LUEdaxonitqJz6L0=;
  b=T8uhSxveX1nUugxj8HdcoVCBxgVoL6l8nwTmFaQLgr5VcPSDifRYPA8g
   z7g5+ZjQBwi8pbxBC5fNhitYz4oxOkYKANlCil9yrTf7M66La1x+cCUAQ
   bKDX4gqtp0QAIKqp6LiBD0YVZF9J+yD7NXYD4qV/xy+G1p+Aj5Uu8fwDa
   QrPcb++7q4a6JFKly+6B45tz4UlcT4QYswJbzehfu6+sl0HHoP770mQB0
   Yt4yCwJkXA0wQp82f2Of7GBlcUaUGCQNB1KuaK+Oe0WUPn0Dha3AaAUKk
   M2OBCKnRnzmuh0uJmr5SbXFBrpZ8LleIu3/W+qMlpw5trvDdQXEIIEyJ4
   w==;
X-CSE-ConnectionGUID: TMNxXey0RGa+lz1hlhEtzg==
X-CSE-MsgGUID: UJZ29HHmRImCqzKcU4qFdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691716"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691716"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:46:13 -0700
X-CSE-ConnectionGUID: SNT/Mzj7QVKL0sGwAdLiSg==
X-CSE-MsgGUID: qktTMKeHTNembi/YB89CKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575399"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:46:12 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 18/20] KVM: x86: Expose APX sub-features to userspace
Date: Mon, 20 Jul 2026 17:19:47 +0000
Message-ID: <20260720171949.498680-19-chang.seok.bae@intel.com>
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
index 48547842d9fa..7df964f32ba0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -868,6 +868,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_29_0_EBX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index db95f6b578d0..0339700e885d 100644
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
@@ -1719,7 +1723,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
2.53.0

