Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF731ED68
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411154; cv=none; b=rvRRh2R4+irul7tPP5LvUCTgGYQdU2R2J3cyRVgchaADMXIhYgbPW3xGL56S6AdKXaNMpsbmZE1K46SmO0mxJ36Z3QPjeWzaYN2I7Pu+YUmem2oJEmGkxv86oOmDHzxHVCDmZmsHU06dOLoO+DdFPBd/8/chIduIX/9Gh+/H4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411154; c=relaxed/simple;
	bh=kVvp2lKgv8NhBOXd4Kw2NfIhCOkuTlkvnGrlTnW90dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvNt/clRn8Ged+fyNFfpJGOVDLXM+1dAtowRCyJVV6zBpww6lxH/6TM8juWesmGRz2tWw08js4KUCxlqWhU1Npda3DryfolEKDE21Kvjdk/BshsGlgk4kICmnnN41dDavEA0S/22eudMLpxLQKm7B1MWacisruk+ZxCbFKZwp/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0rrsOfo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0rrsOfo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411154; x=1807947154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kVvp2lKgv8NhBOXd4Kw2NfIhCOkuTlkvnGrlTnW90dw=;
  b=K0rrsOforhReCp4kC4qtRFyPZ4NcGOLk1rFaVRWl/WKwGLyb/i70o6GQ
   tbHmflZ2ZdABXCuP7JUHLAexFGWSkHcOjdTHH5IBvchwYNSWjZxtfQbPo
   gjAhr6W5YRQKWzuDRmUn0I9nXf5+/JFAbTx773ur1OwwcNUWJsOvizPL3
   4JvhC6hdyhirjbbv28JUbwrB3y1PYVj6j3JtPLfZDsca0QcItHZ+I2x/6
   iFwEIOsgznLrWhCHwzuYWQruvNBqU6Una9RQNwyVwRaADOLUNMiY0js4p
   FSntNDCLE8W8hqz84PhYZt3T9RN4RGsGmXB/wjFvuX3G9a1FgAHeaO4Nl
   g==;
X-CSE-ConnectionGUID: Ppfn1q7cR+mxWvFDIDGQbg==
X-CSE-MsgGUID: +6kn+ya3SNimfljmAFFPdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070182"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070182"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:23 -0700
X-CSE-ConnectionGUID: 1xry1muBQUGih2/USOL5gA==
X-CSE-MsgGUID: gaXTioRkS0yWct0k1KOXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284914"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:21 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 09/27] KVM: x86: Use overlays of KVM CPU capabilities
Date: Fri, 17 Apr 2026 15:35:52 +0800
Message-ID: <20260417073610.3246316-10-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select the appropriate CPUID overlay based on the VM type or/and hardware
vendor rather than using CPUID_OL_DEFAULT.

When the KVM CPU capabilities are queried and modified, a CPUID
overlay is used according to the VM type and/or the hardware platform.

For ALIASED_1_EDX_F() use CPUID_OL_SVM instead of CPUID_OL_DEFAULT, since
the aliased 0x8000_0001.EDX features are AMD-defined duplicates of 0x1.EDX
and are only meaningful for SVM guests.

Drop the now-unnecessary CPUID_OL_DEFAULT alias.

Return 0 for emulated CPUIDs when the overlay is TDX, as KVM cannot
emulate the related instruction for TDX guests.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 19 ++++++++++++-------
 arch/x86/kvm/cpuid.h |  9 ++++-----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 20ea483ddc7a..2c4e64aa14c4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -374,6 +374,7 @@ static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
 
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
+	u8 cpuid_overlay = get_cpuid_overlay(vcpu->kvm);
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	struct kvm_cpuid_entry2 *best;
 	struct kvm_cpuid_entry2 *entry;
@@ -404,7 +405,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		 * in guest CPUID.  Note, this includes features that are
 		 * supported by KVM but aren't advertised to userspace!
 		 */
-		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[CPUID_OL_DEFAULT][i];
+		vcpu->arch.cpu_caps[i] = kvm_cpu_caps[cpuid_overlay][i];
 		if (!cpuid.index) {
 			cpuid_func_emulated(vcpu->kvm, &emulated, cpuid.function, true);
 			vcpu->arch.cpu_caps[i] |= cpuid_get_reg_unsafe(&emulated, cpuid.reg);
@@ -806,12 +807,12 @@ do {									\
  * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
  * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
  */
-#define ALIASED_1_EDX_F(name)								\
-({											\
-	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);		\
-	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);		\
-	kvm_cpu_cap_features |= feature_bit(name);					\
-	kvm_cpu_caps[CPUID_OL_DEFAULT][CPUID_8000_0001_EDX] |= feature_bit(name);	\
+#define ALIASED_1_EDX_F(name)							\
+({										\
+	BUILD_BUG_ON(__feature_leaf(X86_FEATURE_##name) != CPUID_1_EDX);	\
+	BUILD_BUG_ON(kvm_cpu_cap_init_in_progress != CPUID_8000_0001_EDX);	\
+	kvm_cpu_cap_features |= feature_bit(name);				\
+	kvm_cpu_caps[CPUID_OL_SVM][CPUID_8000_0001_EDX] |= feature_bit(name);	\
 })
 
 /*
@@ -1414,6 +1415,10 @@ static int cpuid_func_emulated(struct kvm *kvm, struct kvm_cpuid_entry2 *entry,
 	entry->index = 0;
 	entry->flags = 0;
 
+	/* KVM can't do the following emulations for TDX guests. */
+	if (get_cpuid_overlay(kvm) == CPUID_OL_TDX)
+		return 0;
+
 	switch (func) {
 	case 0:
 		entry->eax = 7;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index eae46f37d30f..c3f2417c7980 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -14,9 +14,6 @@ enum kvm_cpuid_overlay {
 	NR_CPUID_OL
 };
 
-/* Temporarily use VMX overlay as the default one */
-#define CPUID_OL_DEFAULT	CPUID_OL_VMX
-
 #define F_CPUID_VMX		BIT(CPUID_OL_VMX)
 #define F_CPUID_SVM		BIT(CPUID_OL_SVM)
 #define F_CPUID_TDX		BIT(CPUID_OL_TDX)
@@ -122,9 +119,10 @@ static __always_inline void cpuid_entry_override(struct kvm *kvm,
 						 unsigned int leaf)
 {
 	u32 *reg = cpuid_entry_get_reg(entry, leaf * 32);
+	u8 cpuid_overlay = get_cpuid_overlay(kvm);
 
 	BUILD_BUG_ON(leaf >= ARRAY_SIZE(kvm_cpu_caps[0]));
-	*reg = kvm_cpu_caps[CPUID_OL_DEFAULT][leaf];
+	*reg = kvm_cpu_caps[cpuid_overlay][leaf];
 }
 
 static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
@@ -245,8 +243,9 @@ static __always_inline void kvm_cpu_cap_set(unsigned int x86_feature, u32 overla
 static __always_inline u32 kvm_cpu_cap_get(struct kvm *kvm, unsigned int x86_feature)
 {
 	unsigned int x86_leaf = __feature_leaf(x86_feature);
+	u8 cpuid_overlay = get_cpuid_overlay(kvm);
 
-	return kvm_cpu_caps[CPUID_OL_DEFAULT][x86_leaf] & __feature_bit(x86_feature);
+	return kvm_cpu_caps[cpuid_overlay][x86_leaf] & __feature_bit(x86_feature);
 }
 
 static __always_inline bool kvm_cpu_cap_has(struct kvm *kvm, unsigned int x86_feature)
-- 
2.46.0

