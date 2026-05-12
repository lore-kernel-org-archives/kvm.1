Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036E314A6B;
	Tue, 12 May 2026 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550042; cv=none; b=ckKTpVVd+IDpvolfDFVMQ/pMVA4N2+sLEn6aY1Vb7/p5a4C1rsjwClXu3wOyk36kqBj3qCfGO/rzd3mPfTPQktt1PKFc/cgVHWVH78fQ7TQKirLMXJLhI8daE45La4jT/1ZGh08yHnGbTcnIQdtMpwmJm+ReKax4eLmRSbD95cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550042; c=relaxed/simple;
	bh=IFs7raVRlz6MfOCkvw6GAvEiddY/1kgglL22vGA0GeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGeMUw1Ru0Z44++dBKJ30P+9EwSR8XdtZkI+JJuAouD/FCEs+RQtoKyxG+qVM55zz/m+7i851p20cIqEPzjwAtOu4ZIXvQVZcTDfFp9Alue2hVktYdSVlxNkHosUCARyduV3TBZuLkUv1JshWchIukzxAm+xqFvpx7DlgDPjQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv2qnfoT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv2qnfoT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550041; x=1810086041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFs7raVRlz6MfOCkvw6GAvEiddY/1kgglL22vGA0GeU=;
  b=mv2qnfoTZd8NnSeskGIgqJxvwtOs3wzLEDga51GB122P6s9E2OGClP5Y
   bU22EbPgUMpp90Kxth2avGUxx83LOLF1e9nEhjnLHPGokTpvLDDx7xFve
   AQuH/Ud0wSSXJy+QUJBHUopHDKFhfoIIsJLObu3OwgWM+ObJxZnRjSdvR
   3GEnYpr6HRX4fAysWfAdtmt8O7kNlghFLU1uoSEVH9GbgJsYpvoLaDDk2
   FoS2jSqXQ2JToy86A9PetV8AVy7B3ZKxHFa0cvvlppS1GIgP1carTJQKN
   hIDbruFEEYigSuiEgZ5hrQGMTvj1rZH/iWsHB27uIl46f3srUJdNZR6ue
   Q==;
X-CSE-ConnectionGUID: kmLhvTyoQkCFI3zJM/IPug==
X-CSE-MsgGUID: bn5tItu+SwK4cY0fA82zDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322192"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322192"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:32 -0700
X-CSE-ConnectionGUID: pFAxI7n9T7K++OihSZ1M7g==
X-CSE-MsgGUID: 4s+1vI0KR5KDkVFcF0XTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572832"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:32 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 19/21] KVM: x86: Expose APX sub-features to guests
Date: Tue, 12 May 2026 01:15:00 +0000
Message-ID: <20260512011502.53072-20-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
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
 arch/x86/kvm/cpuid.c            | 9 ++++++++-
 arch/x86/kvm/reverse_cpuid.h    | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 76c91efca722..05b7a68b2708 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -824,6 +824,7 @@ enum kvm_only_cpuid_leafs {
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

