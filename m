Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F348226158B;
	Sat, 18 Jul 2026 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339129; cv=none; b=RD3W+6BbNiFc3RIiVT9EkfeEPM2BiSljUQCx3zSJG/r+W/N2CAPfHGUsDqouU85Lk0iOPZgwdSV5i6188dGGj9HJMm57xkN9//wnMLqKx1ibRHPPxc4VzY9O+Dz2DZBDlIEmLxo6t+AALDfwFBM08JtUF56GqzvPL1SenvL/+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339129; c=relaxed/simple;
	bh=nn84tB7jb4o5ROXYXo2hi61apKafyqMBLrSLmPKEziY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inr/eHYwD1nIDbC0QgTJw9JwrPiushp5vEgvQf35ydGtn2FhOmqjmoJtoj1ImZmZDIWAGlGxj5EQVvePpwcTp+kzXRGvVHXn0DtEICb1hlgiGKDoslErOJNV6XhSaz8J947kw93w1eIzXgzll1bfj0eUyuGJjzHIFUjWYnf76rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dct5vA4+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dct5vA4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784339127; x=1815875127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nn84tB7jb4o5ROXYXo2hi61apKafyqMBLrSLmPKEziY=;
  b=dct5vA4+u0SMdXS0Sf3ou+G2PRE+uivK3uk2QUoFIAEXplF8O1JakA0+
   msk96i0zpgx8k12SPRkGfClvRORK6+QQbEfMYvkss/IOB27+TWMROA13X
   W5steKnIWNtdoQftuvE568vLh1/1TqJp3LRoT9+BK3jXII7nCvQF5xAeP
   BiCRt4SW95tO108jTSYvEJAVWwFapezUmsdA73PW/i6JzbJSD9r5KPnue
   XQwglSwHi8h25LvGZZ6N24A47ObX+bJgYV7rzAs9IDA73uGVE2Nvzip4v
   cTPoeS8SK8aMOHDgqZmnUCPrsXAZncWud8lMidBkToaWhDV+TNLRomGL0
   Q==;
X-CSE-ConnectionGUID: aFUuBDhmSTeyUCRbGJtqfg==
X-CSE-MsgGUID: 1jH+bh91SjOMpU8rjJfVcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96377173"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96377173"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:17 -0700
X-CSE-ConnectionGUID: ixcNeQuFQFWUEBYqbOz/VQ==
X-CSE-MsgGUID: keLndSSYTOeiMTLPlw5s1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254296285"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:10 -0700
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
	binbin.wu@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v7 09/11] x86/virt/tdx: Enable Dynamic PAMT
Date: Fri, 17 Jul 2026 18:44:58 -0700
Message-ID: <20260718014500.2231262-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
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
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v7:
 - Add kernel parameter following some twists and turns, derriving
   originally from a comment by (Chao)

v6:
 - After Nikolai pointed out that the TDX docs actually have the Dynamic
   PAMT pages-per-2MB region fixed at 2 instead of variable sized, I
   checked over the docs more closely looking for anything else that might
   have been missed. Spotted this 48 bit physical address bit check in the
   docs, so added it.
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 arch/x86/include/asm/tdx.h                    |  1 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 21 +++++++++++++++++--
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f228..be4928489b02f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1321,6 +1321,13 @@ Kernel parameters
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	tdx_dpamt=
+			[X86] Controls whether TDX will use Dynamic PAMT
+			to save memory, when supported.
+
+			Valid parameters: "on", "off"
+			Default: "off"
+
 	reg_file_data_sampling=
 			[X86] Controls mitigation for Register File Data
 			Sampling (RFDS) vulnerability. RFDS is a CPU
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
index 61f48fff69df6..f397ea17248e3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -47,6 +47,8 @@
 #include "seamcall_internal.h"
 #include "tdx.h"
 
+bool tdx_enable_dpamt __ro_after_init;
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

