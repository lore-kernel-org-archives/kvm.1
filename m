Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5142388E5A;
	Thu, 27 Aug 2026 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800447; cv=none; b=p7am6IEnzFgKlupUtWpWGQk7SQNmmfD+ThHKGOgWbUTJpzIeBB0sBcKUgmKO8PuBgNZTxBDjxzRnhdpa99WmhyQjsGtowcqGhDCPdAmRRC6OJF3XEi5pyFOlP2uFHX0C++Z+DgpgeNfzJNwLQmSBlP7yAvNv2JjBO1pRWvoW7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800447; c=relaxed/simple;
	bh=RRvUbCKMXF9daTfoWlWbm9gI2Ol0koeM0rWJjlqFPi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SetpxHVxHvxAqJu+2Mop+OA/GEWhU5+boY0Vl8cKuHACAM+ZXYDPmT4xVcqmJCtMXE25owIqTnvTR8rtJEr6mWuoH3O6T/V/VkIQUh/W8OOnDlZ3V5ynA6dGC/5k1AmpXa6nvZ5p0kUJYEPvKqGlEWhXhkoB/y7n4UN3ojk/tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnnnlh5f; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnnnlh5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800445; x=1819336445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RRvUbCKMXF9daTfoWlWbm9gI2Ol0koeM0rWJjlqFPi4=;
  b=lnnnlh5fwMafHErvcpN5oS1pP0vqgu5PHN5trXinuGUYFf3cTwAckdjz
   E06jNLggLi25BG0h4dBd+ggmArvCUlO5N7Jaif7voBk5S1WQTV45KCrzn
   DT/BomY89veDZYSzsIXmwmGY2C3sDI9J2Kv5SoiqNEeVdVUCRS+vq3iWy
   RCcIua3jQBJGYO0cycrWKBmw+nkt661tQmBsgE/BHjbRPgEvyaHsXKCzA
   cw7LP65fEmJntJzvp34I/ph3JJoDMhcG82SCeX036pS3JwZOMHI9XYQTy
   wFUPswuNol04pL7Heb5g62j5XlK/TSguKIZz2DlkcAomELlEcYMtEEwmD
   g==;
X-CSE-ConnectionGUID: 3aDMmY1lTdWkoGXWuBjdKg==
X-CSE-MsgGUID: Y/eSgohfRw2+6WvAJzrWwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98964554"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98964554"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:14:04 -0700
X-CSE-ConnectionGUID: AVa4WG41TQeLLte1G3pa/w==
X-CSE-MsgGUID: ccUGhdnuT9OXcFeoFoLmKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="271264065"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:14:01 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
Date: Thu, 27 Aug 2026 11:18:36 +0800
Message-ID: <20260827031837.2863609-4-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filter the directly configurable CPUID bits reported through
KVM_TDX_CAPABILITIES against KVM's TDX allowlist, and drop the hardcoded
denylist based filtering.

The TDX module reports all directly configurable CPUID bits that it
supports for a TD, but KVM must not expose bits that it doesn't support,
as blindly exposing a host state clobbering feature can lead to host state
corruption.  The existing denylist, which clears only TSX and WAITPKG, is
not fail-safe.

Add tdx_get_allowed_cfg_cpuid_mask() to get the mask of directly
configurable bits allowed by KVM for a given CPUID register, covering both
feature bits, which come from tdx_cpu_cfg_caps[], and non-feature bits,
which are enumerated at runtime.  Apply the mask to every CPUID register
reported through KVM_TDX_CAPABILITIES.

With the allowlist in place, newly introduced TDX directly configurable
CPUID bits stay hidden from userspace until KVM explicitly opts in.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v3:
- Handle non-feature leafs at runtime. (Sean)
- Add CPUID.0x24.0.EBX[7:0] into allow list. There is a mismatch of the
  description about CPUID.0x24.0.EBX[7:0], which is listed as
  "XFAM & CPUID_Enabled & Native" but should be "XFAM & CPUID_Enabled &
  Configured & Native".
---
 arch/x86/kvm/vmx/tdx.c | 84 +++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b020518717ac..e8951353de73 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -277,34 +277,76 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
 	       (entry->ebx & TDX_FEATURE_TSX);
 }
 
-static void clear_tsx(struct kvm_cpuid_entry2 *entry)
-{
-	entry->ebx &= ~TDX_FEATURE_TSX;
-}
-
 static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
 {
 	return entry->function == 7 && entry->index == 0 &&
 	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
 }
 
-static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
+static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
 {
-	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
+	return has_tsx(entry) || has_waitpkg(entry);
 }
 
-static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
+#define TDX_CPUID_ALL_ALLOWED_MASK	GENMASK_U32(31, 0)
+
+static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
 {
-	if (has_tsx(entry))
-		clear_tsx(entry);
+	/*
+	 * For a leaf/subleaf/register that will never be repurposed to hold
+	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
+	 * leave the TDX module's CPUID config mask intact.
+	 */
+	switch (function) {
+	case 1:
+		if (reg == CPUID_EAX || reg == CPUID_EBX)
+			return TDX_CPUID_ALL_ALLOWED_MASK;
+		return 0;
+	case 4:
+	case 0x18:
+	case 0x1f:
+		return TDX_CPUID_ALL_ALLOWED_MASK;
+	case 0x24:
+		if (index == 0 && reg == CPUID_EBX)
+			return GENMASK_U32(7, 0);
+		return 0;
+	case 0x80000008:
+		if (reg == CPUID_EAX)
+			return TDX_CPUID_ALL_ALLOWED_MASK;
+		return 0;
+	default:
+		return 0;
+	}
+}
 
-	if (has_waitpkg(entry))
-		clear_waitpkg(entry);
+static u32 tdx_cfg_feature_mask(u32 function, u32 index, int reg)
+{
+	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
+		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
+
+		if (!cpuid->function)
+			continue;
+
+		if (cpuid->function == function && cpuid->index == index &&
+		    cpuid->reg == reg)
+			return tdx_cpu_cfg_caps[i];
+	}
+
+	return 0;
 }
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
+static u32 tdx_get_allowed_cfg_cpuid_mask(u32 function, u32 index, int reg)
 {
-	return has_tsx(entry) || has_waitpkg(entry);
+	u32 non_feature_mask = tdx_cfg_non_feature_mask(function, index, reg);
+
+	if (non_feature_mask == TDX_CPUID_ALL_ALLOWED_MASK)
+		return TDX_CPUID_ALL_ALLOWED_MASK;
+
+	/*
+	 * It's possible that a CPUID register contains both feature and
+	 * non-feature bits.
+	 */
+	return non_feature_mask | tdx_cfg_feature_mask(function, index, reg);
 }
 
 #define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
@@ -330,8 +372,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	 */
 	if (entry->function == 0x80000008)
 		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
-
-	tdx_clear_unsupported_cpuid(entry);
 }
 
 #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
@@ -354,8 +394,16 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 	caps->user_tdvmcallinfo_1_r11 =
 		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
 
-	for (i = 0; i < td_conf->num_cpuid_config; i++)
-		td_init_cpuid_entry2(&caps->cpuid.entries[i], i);
+	for (i = 0; i < td_conf->num_cpuid_config; i++) {
+		struct kvm_cpuid_entry2 *e = &caps->cpuid.entries[i];
+
+		td_init_cpuid_entry2(e, i);
+		/* Only report the configurable bits allowed by KVM. */
+		e->eax &= tdx_get_allowed_cfg_cpuid_mask(e->function, e->index, CPUID_EAX);
+		e->ebx &= tdx_get_allowed_cfg_cpuid_mask(e->function, e->index, CPUID_EBX);
+		e->ecx &= tdx_get_allowed_cfg_cpuid_mask(e->function, e->index, CPUID_ECX);
+		e->edx &= tdx_get_allowed_cfg_cpuid_mask(e->function, e->index, CPUID_EDX);
+	}
 
 	return 0;
 }
-- 
2.46.0

