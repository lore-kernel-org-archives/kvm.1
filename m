Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2930D40B;
	Sat, 25 Jul 2026 00:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939016; cv=none; b=KabIfFEfxSDpNY5VBPsN1fEbLA4OWJ55tWzrUiGWOVvj5xOxN9EtCrdmxvYTsGR9SdQaAY3lbyl8O69vdIZY93eJWbi7CJ24VzuXi0VhcM00Djn22MC5sil47wA1rECe19FuR7Vnk6eyZEu8jrC3smhBzh9mlPtQBk87BWL4ltA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939016; c=relaxed/simple;
	bh=5fSUSAIcu702iFWknTDZTb3sENCXofYPHa99mjJMKj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwRypLrQZfhE0gfowM9scirGXvYFK7tdJGHMR95v6LRs0b8mye9SDQSnD0fpZo5z4xE4oKnNgH2J9PYb3zHQrGTH3CFmggkl0DsM0bAdA1UApemX80DcWDo10A8GnyzH2JuOIP1zQ0HQHbzXjBM+rBYWMC3OGNoKTEmcFU20LpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+xrE8uf; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+xrE8uf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784939008; x=1816475008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5fSUSAIcu702iFWknTDZTb3sENCXofYPHa99mjJMKj4=;
  b=H+xrE8ufJMpzZv2NkLInPal/SQPG+Im9++x//8yKLxx+Y7/HWhBSnweg
   qpw/9vHpqerRzHcAnEn1ZFvMOrcTqrGHiU0pm76T7w0eLj+n1/OV4qsd5
   jVRGeat1wAgPV4A3C9oIN7q671z5X59BykM323hqFWfTM/3yE8CNkQI8v
   GLenOp8nXPxNZmJzqPNjeRHFGApDoGUJeZ8sWDYljJvcK6irljHBc6wqy
   uDwwsKARfVw1SMo+NIEY2D6EzHaq69z64pHLr05VsXkht4Q9jcY86t5R1
   tke4aD8bR2hMjnHVchWA2L2QrfCH1T4Bz/4Whll2BIGuvf32yLROgAlZZ
   A==;
X-CSE-ConnectionGUID: F7W3o7UWQxitdoFzkzV4Ug==
X-CSE-MsgGUID: mB4DW4lcQnqyMy8+0sl7Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726182"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726182"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
X-CSE-ConnectionGUID: Pg6436R+QvehyPtovu63MQ==
X-CSE-MsgGUID: B7UoW8Z8R9C534SmzuEz/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359274"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
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
Subject: [PATCH v8 09/11] x86/virt/tdx: Enable Dynamic PAMT
Date: Fri, 24 Jul 2026 17:22:59 -0700
Message-ID: <20260725002302.3337017-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
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

