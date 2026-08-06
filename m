Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61BC3BFE5D;
	Thu,  6 Aug 2026 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982151; cv=none; b=pHhZr9psANLABpVo+j13l5q38/1ohjeoCs7xHzs2qhoGXtm9l1Rb67uQcvqyvd1G2zB3f/bCFuax006sSQ+bI3rFxZM14ddESwjs3KffkzH+GvgBZegPF2drpkyOzvyhZHPYxrD5ymT3xet/wsyGb0oR5ZJg6z2qXfs3y7zHXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982151; c=relaxed/simple;
	bh=5fSUSAIcu702iFWknTDZTb3sENCXofYPHa99mjJMKj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gxr6Wyoc4Hch/xjqEMidjOM/23+z/rhUan28KycJu0L5fSEcMFGCHxvJGAusmHdMfMmF3/3ZXjDM00ChymAmgghGzGVv6/dHFkQYWGAxrRi9wGT/c4n6h59djdjk08M0xFnPRUgIU4TGMS3p1fkqqQWqThOFt0Z/jo3WlkPwR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipsDJoz+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipsDJoz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982149; x=1817518149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fSUSAIcu702iFWknTDZTb3sENCXofYPHa99mjJMKj4=;
  b=ipsDJoz+ryxX96h4phawqj9l5HGqksUnRoJMxr54uxhZTHPKBSQe1cRn
   9/WaVZiFiAM5tmHyaMjbH2yvceRS10dCUrrindNfmkL3ISCXJfwQPCOLS
   tHd0WPwFc9mN0IHZTyJcVIzHtp/+RGY0NQG490/Zdb7Xi4OJ71PK84bfz
   KJktEF+cKbkASIA3eWR47agEs5naXXHTUXQSoY56sNFcF1eyEAW1ol0NI
   u1K48t4tbI8OTTCFqRUbxqcrSqycoVDxmYsDIYkZ7SdZuGrfRGK6/2Bfz
   7wHbctN8TL0GtOoX3yHzXvlvJJO3dofrsNj94GMp/svB2LaJ6ihglcYPq
   Q==;
X-CSE-ConnectionGUID: OMbdU5NhRLOy3agAYGnS9A==
X-CSE-MsgGUID: 5hPwjTOLRnO621uRUYy3Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86422902"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86422902"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:05 -0700
X-CSE-ConnectionGUID: 1Xaf+b+3RL+y9/0eK0sKRQ==
X-CSE-MsgGUID: YT3LYD7TTWabovgtAv0YiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="258639889"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:04 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: [PATCH v9 09/11] x86/virt/tdx: Enable Dynamic PAMT
Date: Wed,  5 Aug 2026 19:08:48 -0700
Message-ID: <20260806020850.1221381-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The Physical Address Metadata Table (PAMT) holds TDX metadata for
physical memory and must be allocated by the kernel during TDX module
initialization. Dynamic PAMT is a TDX module feature that can reduce this
memory use by allocating part of the PAMT dynamically.

The TDX module exposes whether Dynamic PAMT is supported via a bit in the
'features0' metadata. Unfortunately, the TDX module exposes the feature as
supported even when it does not support using it with the number of keyids
currently configured in the BIOS. Since no TDX modules exist today with
that issue fixed, make the feature default off to prevent users from
upgrading their kernel and encountering TDX erroring out when trying to
enable Dynamic PAMT.

For the decision of whether to make it a boot time option and/or compile
time option, consider that Dynamic PAMT's memory savings are significant
enough to make it a good default configuration. That is most TDX users
should want it unless they have strange keyid configurations.

The feature increases the kernel size by 2KB (when TDX is configured in the
build).

All pieces are in place to enable Dynamic PAMT if it is supported and the
user passes a kernel parameter.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v8:
 - Order tdx_dpamt in kernel-parameters.txt (Sohil)
 - Make tdx_enable_dpamt static (Sashiko)

v7:
 - Add kernel parameter following some twists and turns, derriving
   originally from a comment by (Chao)
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 arch/x86/include/asm/tdx.h                    |  1 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 21 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f228..49bcd7798876c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7512,6 +7512,13 @@ Kernel parameters
 
 	tdfx=		[HW,DRM]
 
+	tdx_dpamt=
+			[X86] Controls whether TDX will use Dynamic PAMT
+			to save memory, when supported.
+
+			Valid parameters: "on", "off"
+			Default: "off"
+
 	test_suspend=	[SUSPEND]
 			Format: { "mem" | "standby" | "freeze" }[,N]
 			Specify "mem" (for Suspend-to-RAM) or "standby" (for
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9cbd250bbd39b..7910901a7ba21 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7fd427174b8b6..f2ea034773bb2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -47,6 +47,8 @@
 #include "seamcall_internal.h"
 #include "tdx.h"
 
+static bool tdx_enable_dpamt __ro_after_init;
+
 struct tdx_module_state {
 	bool initialized;
 	bool sysinit_done;
@@ -1028,6 +1030,8 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+#define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
@@ -1056,6 +1060,12 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
+
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		pr_info("Enable Dynamic PAMT\n");
+		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
+	}
+
 	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
 
 	/* Free the array as it is not required anymore. */
@@ -2041,8 +2051,8 @@ EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_DYNAMIC_PAMT &&
+	       tdx_enable_dpamt;
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_supports_dynamic_pamt);
 
@@ -2300,6 +2310,13 @@ void tdx_free_control_page(struct page *page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
 
+static int __init tdx_dpamt_setup(char *str)
+{
+	return kstrtobool(str, &tdx_enable_dpamt) == 0;
+}
+
+__setup("tdx_dpamt=", tdx_dpamt_setup);
+
 void tdx_sys_disable(void)
 {
 	struct tdx_module_args args = {};
-- 
2.54.0

