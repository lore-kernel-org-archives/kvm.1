Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC7F38C2DB;
	Thu,  4 Jun 2026 02:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780540191; cv=none; b=e7IeQlKbxQWmmohpfyNH9M9660LuRR/dPEqRz0cVzAw1qiMGMuI6jbGqbTJSuM304DK+o8pCDlbkRoFGKkNvFvlEBCOkDdeUWSKXHr0YggrGFBt3Z5vLOreIIktXnEap1rc7coR4Exaqc/VLiUweSPu3rn711s6x+O58GtkyeBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780540191; c=relaxed/simple;
	bh=64YjlntfLLkE9KZvhKTh5VtVwDl+Pva8cUIUnqi30Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4T0VleLtXHx61IOjawbLx/oWXtmx2De2tRi3HX4YZ7oW0CMQnpqfy3KgZCeB7/W8QlLwma0KkqnzQnPq5pgURWbVc8LhhhoAzi+/8Dt9xEgsvdLoCreyI1U/OnocaI/VgVWppAEdZ2V52PCyIDzsP7h2lgo+cEXJ7mR9gTzGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DId0EZx1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DId0EZx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780540191; x=1812076191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=64YjlntfLLkE9KZvhKTh5VtVwDl+Pva8cUIUnqi30Ew=;
  b=DId0EZx1sccNlcRcraWNBTD+0ZQ74BEtubqp2g28wHm4DPJkXRYuY5uC
   Iwdyt61Bhd4PobPLyvP6Cznb4Vgr6Tabi2HJ0Px6E/jwXLEPIWcGbSx8u
   WVK8+unnteCz+J0VYjXAdDJdBTMSwjxL2dxJArL+rJlb3V8LIgeeNH0oG
   TmiZYXee1qPQFJzeXedxV3EA9lftIer2FEtr5UaI03KeMa16edmEYUsgg
   /HDvm3VVbOGxeZAA6Ye6G+7v6BBWRPFBc6XSXhoO1eUMKKkYlPjbJgcMF
   DmLr0sL9XZqT/kW4mM/Pyrz1ZI+ZvaScRPWq0DEoYyo2YZii+LYSRcGcE
   w==;
X-CSE-ConnectionGUID: aVtYjn22SpKMaBtOTcof3A==
X-CSE-MsgGUID: zE3veM3rQzaKlYRkgFvOmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92045252"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92045252"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:50 -0700
X-CSE-ConnectionGUID: usI6NYpmToe35ZiTJc7jqg==
X-CSE-MsgGUID: 1eJeIqaCRWGZnHihpYExSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="239940503"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:29:48 -0700
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
Subject: [RFC PATCH v2 3/4] KVM: x86: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
Date: Thu,  4 Jun 2026 10:33:13 +0800
Message-ID: <20260604023314.3907511-4-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
References: <20260604023314.3907511-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reject unsupported TDX configurable CPUID bits provided by userspace
during KVM_TDX_INIT_VM.

While the TDX module allows the VMM to configure certain CPUID
features for a TD during initialization, KVM must strictly govern
which features are actually enabled. Allowing userspace to blindly
enable features that KVM does not yet support—particularly those
involving host state clobbering MSRs—could lead to host state
corruption, as KVM is not prepared to manage the associated
architectural state across host/guest transitions.

Replace the hardcoded denylist with a robust validation mechanism. By
leveraging the get_supported_cfg_cpuid() helper, KVM now explicitly
rejects the input if userspace attempts to set any TDX configurable bit
that is not present in KVM's allowlist.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index e6bfec87a484..e44a862c6219 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -294,25 +294,6 @@ static u32 tdx_set_guest_phys_addr_bits(const u32 eax, int addr_bits)
 	return (eax & ~GENMASK(23, 16)) | (addr_bits & 0xff) << 16;
 }
 
-#define TDX_FEATURE_TSX (__feature_bit(X86_FEATURE_HLE) | __feature_bit(X86_FEATURE_RTM))
-
-static bool has_tsx(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ebx & TDX_FEATURE_TSX);
-}
-
-static bool has_waitpkg(const struct kvm_cpuid_entry2 *entry)
-{
-	return entry->function == 7 && entry->index == 0 &&
-	       (entry->ecx & __feature_bit(X86_FEATURE_WAITPKG));
-}
-
-static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
-{
-	return has_tsx(entry) || has_waitpkg(entry);
-}
-
 static u32 get_supported_cfg_cpuid(u32 function, u32 index, u8 reg)
 {
 	for (int i = 0; i < ARRAY_SIZE(tdx_kvm_supported_cpuid); i++) {
@@ -2526,6 +2507,15 @@ static int setup_tdparams_eptp_controls(struct kvm_cpuid2 *cpuid,
 	return 0;
 }
 
+static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *e,
+				  const struct kvm_cpuid_entry2 *mask)
+{
+	return ((e->eax & mask->eax & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EAX))) ||
+		(e->ebx & mask->ebx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EBX))) ||
+		(e->ecx & mask->ecx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_ECX))) ||
+		(e->edx & mask->edx & (~get_supported_cfg_cpuid(e->function, e->index, CPUID_EDX))));
+}
+
 static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 				 struct td_params *td_params)
 {
@@ -2549,7 +2539,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
 		if (!entry)
 			continue;
 
-		if (tdx_unsupported_cpuid(entry))
+		if (tdx_unsupported_cpuid(entry, &tmp))
 			return -EINVAL;
 
 		copy_cnt++;
-- 
2.46.0

