Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940346;
	b=p6e9cur7kpqC0EfNn3KN5pum/E4f3gn+mYr0L0ZZ7mnCbgW+ZTpo+f/fLSyZAwI3pLrl
	 0ldImO90oQk3tBqAq1tVmpw/+Y5gDHxvpam6mcj8tUZwc0FQVLrsWbfsPW/YFvv7K6+gj
	 Euw+/NYHqq+u0EZFID7XL7qvhQu8M5I6xQ9QEUQrQbNwX2m0GDiPpKOFsdnUyPY5lUfEb
	 Efh93rnJuf6c9EI0EG78eaJD6emdCAs6dWs0o5+jJGEs9tf5xPJ0NkItvmxWnJbnmyReN
	 etSwosUYTeclK5PN2k4Gq5LmZift29nlBbGzTKuvbnfO9J79Me+Eg05lItOcQSgTYoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fXw+LB6eG9yx6O1pdvXBcm5moMPileAQ+PkQxmHtDFo=;
	b=pXby8G6d6le5TBKIf8t0TNQUpt3dAQgXMLlzSAtZAljVlaITYawTmUsUnF/QmT7OJU8G
	 g9mGvntUQP9qnBiJsn4QjlV0sE6ZHg+PSHxoft+ykcc6umrK4+TULpd0stdEYmd0QLRiy
	 Qym+Fht1g4c/8r2qqIMgQxJO/nN5xpNuumTghz6MZCdwhbJu6BILBks0b4p6aP6OZJ71Q
	 QfxwC8g8FbDjF1FyRtoBHradWljzWq6ga9K5nfpOE/drkV8KoK3fMDhz9D3tBHsv6XLCO
	 yB8NXAIZw+VwXuQ0iZvbj/jCmL5A5g5XgwibRRa9HivyI4Z8pRm0xTOjQD+vhkA4GTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JSkcPI77;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533460A261F;
	Tue, 17 Nov 2026 18:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4533460A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JSkcPI77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940346; x=1826476346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PsNlEn7LaIv9GsNpcpduwlDDySvS9Zu9lSvLlLrel3Y=;
  b=JSkcPI77LFFzLzhxpTOhIBrRoTMEyGh1ZUEIUAmyf2ARXEgRrqK9WX66
   NyFRw7Dv8V5trP/9+3AwNK7BuxyZ/ccbwNPKurZJKu9lvo1Ei/CypDAIY
   VUTwZSryv3qqmAfKsUSdKDx3GyO+n+PrU2VuhGvtkaS/5A7wTBvJmNd2W
   pIcDpdDYeWMxTYEetA6Dg9AQn3i/yik61rpRH2/PWGJa0U9DqaBhJ+qGp
   COgJIFXrGktbgtW3zRyXYZf3Bip4OsZ9QBO9qt6nf63+8BBpG3pRi2vAR
   OoLkK6UwjwwpVKmMwSBsmG0Kk/I1D5kw4uMmOxiqfsCA7mZGoIp6xbeEs
   A==;
X-CSE-ConnectionGUID: Y9CWYuX1QbmEJh0DTItSxQ==
X-CSE-MsgGUID: HhUqZmO9T+e76LF1WHEydA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607376"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607376"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:31:04 -0800
X-CSE-ConnectionGUID: o4XarOoLSNWLVnMz4ere/Q==
X-CSE-MsgGUID: rNbRQvvURZiyBQ73SxS1Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775095"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:31:05 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 18/20] KVM: x86: Expose APX feature to userspace
Date: Tue, 17 Nov 2026 18:03:08 +0000
Message-ID: <20261117180310.921701-19-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose the APX feature and its sub-features to userspace. Add support for
CPUID leaf 0x29, sub-leaf 0, to enumerate the APX sub-features.

On SVM or when using eVMCS, do not advertise APX, as EGPR support is not
implemented yet.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V8 -> V9:
 * Add CPUID filtering and merge both exposure (Jim Mattson)
 * Hide when using eVMCS (Jim Mattson)
---
 arch/x86/include/asm/cpuid/api.h |  1 +
 arch/x86/include/asm/kvm_host.h  |  1 +
 arch/x86/kvm/cpuid.c             | 21 ++++++++++++++++++++-
 arch/x86/kvm/reverse_cpuid.h     |  4 ++++
 arch/x86/kvm/svm/svm.c           |  1 +
 arch/x86/kvm/vmx/vmx.c           |  4 ++++
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 759b12d94bbf..80402959804f 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -183,6 +183,7 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 	case 0x1f:
 	case 0x23:
 	case 0x24:
+	case 0x29:
 	case 0x8000001d:
 		return true;
 	}
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7db87bc99f4a..f3380fbc4694 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -723,6 +723,7 @@ enum kvm_only_cpuid_leafs {
 	CPUID_7_1_ECX,
 	CPUID_1E_1_EAX,
 	CPUID_24_1_ECX,
+	CPUID_29_0_EBX,
 	NR_KVM_CPU_CAPS,
 
 	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f476a78a570a..2fa48efb1caa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1049,8 +1049,12 @@ void kvm_initialize_cpu_caps(void)
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
@@ -1095,6 +1099,10 @@ void kvm_initialize_cpu_caps(void)
 		F(AVX10_V1_AUX),
 	);
 
+	kvm_cpu_cap_init(CPUID_29_0_EBX,
+		F(APX_NCI_NDD_NF),
+	);
+
 	kvm_cpu_cap_init(CPUID_8000_0001_ECX,
 		F(LAHF_LM),
 		F(CMP_LEGACY),
@@ -1463,7 +1471,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 	switch (function) {
 	case 0:
 		/* Limited to the highest leaf implemented in KVM. */
-		entry->eax = min(entry->eax, 0x24U);
+		entry->eax = min(entry->eax, 0x29U);
 		break;
 	case 1:
 		cpuid_entry_override(entry, CPUID_1_EDX);
@@ -1734,6 +1742,17 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		}
 		break;
 	}
+	/* APX sub-features */
+	case 0x29:
+		if (!kvm_cpu_cap_has(X86_FEATURE_APX)) {
+			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
+			break;
+		}
+		cpuid_entry_override(entry, CPUID_29_0_EBX);
+		entry->eax = 0;
+		entry->ecx = 0;
+		entry->edx = 0;
+		break;
 	case KVM_CPUID_SIGNATURE: {
 		const u32 *sigptr = (const u32 *)KVM_SIGNATURE;
 		entry->eax = KVM_CPUID_FEATURES;
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index 1ff87fe63c3c..9a4445138a8f 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -69,6 +69,9 @@
 /* Intel-defined sub-features, CPUID level 0x00000024:1 (ECX) */
 #define X86_FEATURE_AVX10_V1_AUX	KVM_X86_FEATURE(CPUID_24_1_ECX, 2)
 
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
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5ef785811e3f..074c8dab7420 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5730,6 +5730,7 @@ static __init void svm_set_cpu_caps(void)
 	 * but that require explicit SVM support (that isn't yet implemented).
 	 */
 	kvm_cpu_cap_clear(X86_FEATURE_MSR_IMM);
+	kvm_cpu_cap_clear(X86_FEATURE_APX);
 
 	/*
 	 * LBR Virtualization must be enabled to support BusLockTrap inside the
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ce6024a19cb3..390afa8015c5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8023,6 +8023,10 @@ static __init void vmx_set_cpu_caps(void)
 	 */
 	kvm_cpu_cap_set(X86_FEATURE_EFER_LMSLE_MBZ);
 
+	/* eVMCS isn't prepared yet for APX */
+	if (kvm_is_using_evmcs())
+		kvm_cpu_cap_clear(X86_FEATURE_APX);
+
 	kvm_setup_xss_caps();
 	kvm_finalize_cpu_caps();
 }
-- 
2.53.0

