Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6439377014
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411156; cv=none; b=rOygvHjQgFjpvuEfFKfm6n7pkt45rWlfkMhJb1tfjQqBImE+ro4qm7LkQo51tgYl3hV47pWA2umUSBGIyo/HSc/C6JiPi/ub26rjh5jX0jkmvevZwO3Gi5z+YU8pGTVaJJV1mCZ4Jtg7RehytNDAWfowlfdGNFxUKJOUhTfeN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411156; c=relaxed/simple;
	bh=09D9UYLGnEeh5HWeq7QmkvRjIi3d3GsoY98KaCYaH8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGlICza8IcBPiE69BrlORoSuRCDqZd8G+AO2+bEdtrdGMTKyhZoaEynq+DsnctSypWtYD85DlkQD9T7dF2v03C++A+aGR/3P77PBCaKyspeho3W0WaSb/VzvUNbCHOzQXDmJM2MVUqCOUNx0BuKtEoc8QGDYW3Bj/qebHdZ27DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RTFNJd/c; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RTFNJd/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411155; x=1807947155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=09D9UYLGnEeh5HWeq7QmkvRjIi3d3GsoY98KaCYaH8g=;
  b=RTFNJd/cnZdRp3Us+911vMK7r4Wl2eKFF4n+bmjOXvDagl+r7zcHNO9d
   O8c066EigmUzK2lHK48VIvBt9ig8LMkJWo42JD6VxKY7gwV0zpI6yqoPt
   e61/KZc7izB1PYN3LCQKdYyOMqPxxigrcO4wQHD8vWL4lmTXP999ncbcT
   wPAyAcaQACfjmuHjMKkCJHwvH2BXXLFlKmhTVgBTnyIMvD1/1VXbAVPpG
   FAymd3a4quwmD1qZ/J6gG+BGofV+8LWnXBZs4vDEj+9cV0C7LTtRpG3Ug
   mycWStZfMal8fHEaseaktHHev3uhK7TTUFATeIvJ6QUfgNWTcHv7Zy9YG
   A==;
X-CSE-ConnectionGUID: 7jU6MoA8RPGoZInpmxGWlQ==
X-CSE-MsgGUID: qj9uEX1QTkCg38nLQ9VQJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070227"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070227"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:34 -0700
X-CSE-ConnectionGUID: pPL5ZYglSgOLjBT0+SYJ9g==
X-CSE-MsgGUID: J0/8PiRPR2u3Q8LFLO2CFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284964"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:31 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 14/27] KVM: x86: Add a helper to init multiple feature bits based on raw CPUID
Date: Fri, 17 Apr 2026 15:35:57 +0800
Message-ID: <20260417073610.3246316-15-binbin.wu@linux.intel.com>
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

Add kvm_cpu_cap_check_and_init_mf() to initialize KVM-only CPUID leafs
whose allowed feature bits needs to be intersected with the raw host
CPUID value for CPUID paranoid verification.

Use it instead of kvm_cpu_cap_init() to avoid adding new X86 feature bit
definitions in the common x86 header.

Move raw_cpuid_get() to cpuid.h since kvm_cpu_cap_check_and_init_mf()
will be called in vendor module.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 23 -----------------------
 arch/x86/kvm/cpuid.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 78d8f89d6079..3bd9608770a9 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -672,29 +672,6 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
-{
-	struct kvm_cpuid_entry2 entry;
-	u32 base;
-
-	/*
-	 * KVM only supports features defined by Intel (0x0), AMD (0x80000000),
-	 * and Centaur (0xc0000000).  WARN if a feature for new vendor base is
-	 * defined, as this and other code would need to be updated.
-	 */
-	base = cpuid.function & 0xffff0000;
-	if (WARN_ON_ONCE(base && base != 0x80000000 && base != 0xc0000000))
-		return 0;
-
-	if (cpuid_eax(base) < cpuid.function)
-		return 0;
-
-	cpuid_count(cpuid.function, cpuid.index,
-		    &entry.eax, &entry.ebx, &entry.ecx, &entry.edx);
-
-	return *__cpuid_entry_get_reg(&entry, cpuid.reg);
-}
-
 /*
  * For kernel-defined leafs, mask KVM's supported feature set with the kernel's
  * capabilities as well as raw CPUID.  For KVM-defined leafs, consult only raw
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index ea8ff5210e4a..0b90344a8b98 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -259,6 +259,29 @@ static __always_inline void kvm_cpu_cap_check_and_set(unsigned int x86_feature,
 		kvm_cpu_cap_set(x86_feature, overlay_mask);
 }
 
+static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
+{
+	struct kvm_cpuid_entry2 entry;
+	u32 base;
+
+	/*
+	 * KVM only supports features defined by Intel (0x0), AMD (0x80000000),
+	 * and Centaur (0xc0000000).  WARN if a feature for new vendor base is
+	 * defined, as this and other code would need to be updated.
+	 */
+	base = cpuid.function & 0xffff0000;
+	if (WARN_ON_ONCE(base && base != 0x80000000 && base != 0xc0000000))
+		return 0;
+
+	if (cpuid_eax(base) < cpuid.function)
+		return 0;
+
+	cpuid_count(cpuid.function, cpuid.index,
+		    &entry.eax, &entry.ebx, &entry.ecx, &entry.edx);
+
+	return *__cpuid_entry_get_reg(&entry, cpuid.reg);
+}
+
 static __always_inline void kvm_cpu_cap_init_mf(u32 leaf, u32 features, u32 overlay_mask)
 {
 	WARN_ON_ONCE(!kvm_is_configuring_cpu_caps);
@@ -270,6 +293,16 @@ static __always_inline void kvm_cpu_cap_init_mf(u32 leaf, u32 features, u32 over
 	}
 }
 
+static __always_inline void kvm_cpu_cap_check_and_init_mf(u32 leaf, u32 features, u32 overlay_mask)
+{
+	reverse_cpuid_check(leaf);
+	/* This function is used for kvm only cpuid leafs. */
+	BUILD_BUG_ON(leaf < NCAPINTS);
+	features &= raw_cpuid_get(reverse_cpuid[leaf]);
+
+	kvm_cpu_cap_init_mf(leaf, features, overlay_mask);
+}
+
 static __always_inline bool guest_pv_has(struct kvm_vcpu *vcpu,
 					 unsigned int kvm_feature)
 {
-- 
2.46.0

