Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408946A61D;
	Fri,  4 Sep 2026 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559174; cv=none; b=G4C/rgA940/omfex6PlSAeW+H0Z2rRaYGdj8JHQ9x0AABiVwudGtUii4iyh80UI1+l9GtS/6xZolEOsEKxxoB343c03NZPCZtc/l6ZIigcbDYSykhlCabM+05UVjVwAWDLxvBqlUvPYXC4xzJoMbpjJjKbOTe0pzshKhNvqR/OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559174; c=relaxed/simple;
	bh=hvztLrJ4PSwRHtsh0fvfEfYYCEyJ1k5t2jSDdBWb7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5ayK8KlM1D9vZihnDONdJzJY1mqPMiz5nWQ4fzzacUdDIWrqOo5RYClni8D/ESnwNcRq7iuoLRRENST1iLyLB0Sw/yNWOdEoAggip+d+6f88qc+AoRaaBBN7VrdAd9ecyvpmpKV//NhKps3IsCBH1sRlppf+gZus0nLH/iWwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igy9ciFb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igy9ciFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559168; x=1820095168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvztLrJ4PSwRHtsh0fvfEfYYCEyJ1k5t2jSDdBWb7G0=;
  b=igy9ciFbyC7NL3wSsRBAfmJeDn68mHIENLHlxqoL4gWy/eyP5z5dK+g/
   Ayb4WS4ec0oghjkM9lm9fiqqQFiElBc3ycerD+cvc7o9tfsWk8XeEWF4n
   axln1HB4C9Tupu9ag5QrPJEUQpjJfAbcmN4KgKXhEVxsNnfuT1tfH5l81
   aTiTdECsrLqu3n4P5DTMzmBJ0//ZZvSnmEEP1akVlhE03G0ypO4jG4euX
   7Q3EAArywdqLn34yl16pXQV7z+D8v6VpQi8wbwqXPgutq5t6h3ZuMthmz
   2IfzlfZoJU5feO5zsImiOWesabI+lHhKWh4qhkprkcOI0PLhYvIMePPYJ
   g==;
X-CSE-ConnectionGUID: Yh72UnjbQ8Sbe897XqtmEw==
X-CSE-MsgGUID: lI4JNfUUTXiR8vysvfpVRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224814"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224814"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: bAMvgsvlQLivJ43/U3GpYg==
X-CSE-MsgGUID: ZGJ1W0GXQwOPtskIBpaQ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675028"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:23 -0700
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
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v11 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
Date: Fri,  4 Sep 2026 14:58:32 -0700
Message-ID: <20260904215841.303070-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX Physical Address Metadata Table (PAMT) holds data about the
physical memory used by TDX, and must be allocated by the kernel during
TDX module initialization.

The exact size of the required PAMT memory is determined by the TDX module
and may vary between TDX module versions. Currently it is approximately
0.4% of the system memory. This is a significant commitment, especially if
it is not known upfront whether the machine will run any TDX guests.

Each memory region that the TDX module might use needs three separate PAMT
allocations. One for each supported page size (1GB, 2MB, 4KB). The
TDX module supports a new feature designed to reduce PAMT overhead called
Dynamic PAMT (DPAMT). Under DPAMT the 4KB level is allocated dynamically
during runtime, while the 1GB and 2MB levels remain allocated on TDX
module initialization.

However, in the details, DPAMT still needs some smaller per 4KB page
scoped data (currently it is 1 bit per page). The TDX module exposes the
number of bits as a separate piece of metadata than the 4KB static
allocation for normal PAMT. Although the size is enumerated differently,
it is handed to the TDX module in the same way the 4KB page size PAMT
allocation is for normal PAMT.

Begin to implement DPAMT in the kernel by reading the bits-per-page needed
for DPAMT. Calculate the size needed for the bitmap, and use it instead of
the 4KB size determined for normal PAMT, in the case of DPAMT.

The existing metadata reading code was generated by a script, but the
current plan is to stop generating this code, as the script has continued
to need adjustments. So add manually written code and adjust the comment
about it being autogenerated to be more generic. Start to adopt a more
normal kernel code style without the ternary statements and if
conditionals assignments that the auto generated code has.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Remove other "autogenerated" references. (AI nit checker)
 - Change "Dynamic PAMT" to "DPAMT" in comments, and in the second
   reference in the logs. (Dave)

v9:
 - Switch to byte size hint in metadata field id (Sashiko)

v7:
 - Re-order pamt size calculations for greater readability (Kiryl)
 - Move comment to its own line in tdx_supports_dynamic_pamt() (Yan,
   Sohil)
 - Log tweak (Sohil)
 - Make comment in metadata reading more appropriate (Sohil)
 - Drop Assisted-by tag and cover AI use in log (Dave)
 - Move tdx_supports_dynamic_pamt() to not static inline to reduce
   churn in later changes

v6:
 - Improve comment (Binbin)
 - Log tweaks
 - Mark tdmr_get_pamt_bitmap_sz() __init in response to upstream
   changes
 - Switch to more normal kernel code style, even though it differs from
   the existing auto generated code.
---
 arch/x86/include/asm/tdx.h                  |  2 ++
 arch/x86/include/asm/tdx_global_metadata.h  |  9 ++++---
 arch/x86/virt/vmx/tdx/tdx.c                 | 29 +++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 23 +++++++++++++++-
 4 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d89..d414064436221 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -118,6 +118,8 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
+bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo);
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 41150d546589c..8a3cc1a2a41e2 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Automatically generated TDX global metadata structures. */
-#ifndef _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
-#define _X86_VIRT_TDX_AUTO_GENERATED_TDX_GLOBAL_METADATA_H
+/* TDX global metadata structures. */
+#ifndef _X86_VIRT_TDX_TDX_GLOBAL_METADATA_H
+#define _X86_VIRT_TDX_TDX_GLOBAL_METADATA_H
 
 #include <linux/types.h>
 
@@ -21,6 +21,9 @@ struct tdx_sys_info_tdmr {
 	u16 pamt_4k_entry_size;
 	u16 pamt_2m_entry_size;
 	u16 pamt_1g_entry_size;
+
+	/* Optional metadata, if DPAMT is supported */
+	u8  pamt_page_bitmap_entry_bits;
 };
 
 struct tdx_sys_info_td_ctrl {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 51b191bf12258..54074ddcce858 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -510,6 +510,18 @@ static __init int fill_out_tdmrs(struct list_head *tmb_list,
 	return 0;
 }
 
+static __init unsigned long tdmr_get_pamt_bitmap_sz(struct tdmr_info *tdmr)
+{
+	unsigned long pamt_sz, nr_pamt_entries;
+	int bits_per_entry;
+
+	bits_per_entry = tdx_sysinfo.tdmr.pamt_page_bitmap_entry_bits;
+	nr_pamt_entries = tdmr->size >> PAGE_SHIFT;
+	pamt_sz = DIV_ROUND_UP(nr_pamt_entries * bits_per_entry, BITS_PER_BYTE);
+
+	return PAGE_ALIGN(pamt_sz);
+}
+
 /*
  * Calculate PAMT size given a TDMR and a page size.  The returned
  * PAMT size is always aligned up to 4K page boundary.
@@ -578,9 +590,16 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
 	 * Calculate the PAMT size for each TDX supported page size
 	 * and the total PAMT size.
 	 */
-	tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
-	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
 	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
+	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
+
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		/* With DPAMT, PAMT_4K is replaced with a bitmap */
+		tdmr->pamt_4k_size = tdmr_get_pamt_bitmap_sz(tdmr);
+	} else {
+		tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
+	}
+
 	tdmr_pamt_size = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;
 
 	/*
@@ -1971,6 +1990,12 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
+bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
+{
+	/* To be enabled when kernel is ready. */
+	return false;
+}
+
 void tdx_sys_disable(void)
 {
 	struct tdx_module_args args = {};
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e49c300f23d43..98ebf17aab1ce 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Automatically generated functions to read TDX global metadata.
+ * Functions to read TDX global metadata.
  *
  * This file doesn't compile on its own as it lacks of inclusion
  * of SEAMCALL wrapper primitive which reads global metadata.
@@ -33,6 +33,18 @@ static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinf
 	return ret;
 }
 
+static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *sysinfo_tdmr)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x9100000000000013, &val);
+	if (!ret)
+		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;
+
+	return ret;
+}
+
 static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret = 0;
@@ -129,5 +141,14 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
+	/*
+	 * The kernel supports using TDX without DPAMT, so
+	 * avoid reporting failure if it's not supported. Don't
+	 * try to support buggy TDX modules that advertise
+	 * DPAMT but don't expose the metadata.
+	 */
+	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
+		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
+
 	return ret;
 }
-- 
2.55.0

