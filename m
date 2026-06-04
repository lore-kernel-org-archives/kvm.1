Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D938886D;
	Thu,  4 Jun 2026 02:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540189; cv=none; b=OlPc80GLgvAnx5qzqcr4lLQyWA3PJDZIe4ZmIqAGt0OktufnHmEycAadgEihCGHQVG4axP+TkAZB7zoVccv+iVeWSS/RflzYFIgd0IOS+wks2xfIw8Ump0mqJBmWf/ySvnLX/jPDjE58SrXVC1HLodq4IYNi4+uMzQccofsVfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540189; c=relaxed/simple;
	bh=xwK68B92/UflQqs5aToPfmv//wqYugSBt/mfmPvl6mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjNDwCsyXdiGqsaVKfiJ9F6ku5JiFZCoM/OZxRyARU9UtbyDPyBymvehvE7WtT0td4vrYRuhIQsymTP42eLwvzicUDbRl6W+mtoNFb9RtKNxnzO3iHziOx82u2xQ+c6MyRd6P5+MdPyCGjKC19Q5wv89q/PzFIhDL0phP7FTySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixEHIjUd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixEHIjUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540189; x=1812076189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xwK68B92/UflQqs5aToPfmv//wqYugSBt/mfmPvl6mE=;
  b=ixEHIjUdNvxdNd3BfMcCwzwrENpAMy3xTl868oybD22LCn0/4tpdpZoX
   e0/P6na+JXcC0pEAxXkY2zq/5psE77jetIsm9t4iRCe6BCBZP2pZv5lMW
   8FEubfQHLkAYerRu2OzjTfWmtACZ/iqZcZ1U/mAiYYTZkDFmCjV0turf+
   5pBJPzl7SaiY4HJlYnrkGMXAuaAcKBDLpV64nJEQLpFGXxe3qbpbW/DjQ
   S7V+5wivD+zB1S0v9nKJr9ZwPvvg8s7ql2uwUm7QB8PgcSAOZIL0HKbb4
   NSHuDPb35QWlWcoz9dQ+S+iAnj4TAcuW0UYsaio490RrydGUvgdUld9Xs
   Q==;
X-CSE-ConnectionGUID: NZcQ7cvsSryeiNDj38oWCg==
X-CSE-MsgGUID: z4Zo8pkYSCWDWXJ6ZrQ9Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045246"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045246"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:48 -0700
X-CSE-ConnectionGUID: o9Wkyo8vSFKf8Bamzdmmgg==
X-CSE-MsgGUID: ePxGMzYTRa6m2/QGV7P+rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239940494"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:46 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH v2 2/4] KVM: x86: TDX: Hide unsupported configurable CPUID bits
Date: Thu,  4 Jun 2026 10:33:12 +0800
Message-ID: <20260604023314.3907511-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filter the CPUID capabilities reported by KVM_TDX_CAPABILITIES through
KVM's supported TDX configurable CPUID allowlist.

The TDX module reports all configurable CPUID bits it supports for a TD,
but KVM must not expose bits to userspace that it doesn't support.
Blindly exposing unsupported features could lead to host state corruption.

Add a helper get_supported_cfg_cpuid() to retrieve KVM's supported TDX
configurable CPUID bit mask for a given leaf, subleaf, and register.
Additionally, add a comment explicitly noting that the allowlist array
must remain sorted by CPUID function. This allows the helper's linear
search to safely terminate early once it iterates past the target leaf,
optimizing the lookup process.

Replace the existing hardcoded denylist with a secure-by-default approach.
By using the get_supported_cfg_cpuid() helper, KVM now strictly reports
only the configurable CPUID bits it explicitly supports. This ensures
any newly introduced configurable CPUID bits are automatically hidden from
userspace until KVM specifically opts in.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e0567088ebf5..e6bfec87a484 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -64,6 +64,8 @@ struct tdx_supported_cpuid_reg {
 /*
  * Multi-bit fields are statically initialized, feature bits are initialized
  * in tdx_initialize_cpu_cfg_caps().
+ *
+ * Keep the list sorted by CPUID function.
  */
 static struct tdx_supported_cpuid_reg tdx_kvm_supported_cpuid[] __ro_after_init = {
 	{ 0x1, 0, 0, CPUID_EAX, GENMASK_U32(27, 16) | GENMASK_U32(13, 0) },
@@ -300,34 +302,31 @@ static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
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
+static u32 get_supported_cfg_cpuid(u32 function, u32 index, u8 reg)
 {
-	if (has_tsx(entry))
-		clear_tsx(entry);
+	for (int i = 0; i < ARRAY_SIZE(tdx_kvm_supported_cpuid); i++) {
+		struct tdx_supported_cpuid_reg *r = &tdx_kvm_supported_cpuid[i];
 
-	if (has_waitpkg(entry))
-		clear_waitpkg(entry);
-}
+		if (r->function > function)
+			break;
 
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
-{
-	return has_tsx(entry) || has_waitpkg(entry);
+		if (r->function == function && r->reg == reg &&
+		    (r->index == index || (r->flags & TDX_CPUID_IGNORE_INDEX)))
+			return r->mask;
+	}
+
+	return 0;
 }
 
 #define KVM_TDX_CPUID_NO_SUBLEAF	((__u32)-1)
@@ -353,8 +352,6 @@ static void td_init_cpuid_entry2(struct kvm_cpuid_entry2 *entry, unsigned char i
 	 */
 	if (entry->function == 0x80000008)
 		entry->eax = tdx_set_guest_phys_addr_bits(entry->eax, 0xff);
-
-	tdx_clear_unsupported_cpuid(entry);
 }
 
 #define TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT	BIT(1)
@@ -377,8 +374,16 @@ static int init_kvm_tdx_caps(const struct tdx_sys_info_td_conf *td_conf,
 	caps->user_tdvmcallinfo_1_r11 =
 		TDVMCALLINFO_SETUP_EVENT_NOTIFY_INTERRUPT;
 
-	for (i = 0; i < td_conf->num_cpuid_config; i++)
-		td_init_cpuid_entry2(&caps->cpuid.entries[i], i);
+	for (i = 0; i < td_conf->num_cpuid_config; i++) {
+		struct kvm_cpuid_entry2 *e = &caps->cpuid.entries[i];
+
+		td_init_cpuid_entry2(e, i);
+		/* Only report the configurable bits supported by KVM. */
+		e->eax &= get_supported_cfg_cpuid(e->function, e->index, CPUID_EAX);
+		e->ebx &= get_supported_cfg_cpuid(e->function, e->index, CPUID_EBX);
+		e->ecx &= get_supported_cfg_cpuid(e->function, e->index, CPUID_ECX);
+		e->edx &= get_supported_cfg_cpuid(e->function, e->index, CPUID_EDX);
+	}
 
 	return 0;
 }
-- 
2.46.0

