Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B93009E2;
	Thu,  3 Sep 2026 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400289; cv=none; b=L57ntcKBO23Hd3iKAVaFIuIUBjv8Ho+YpTZeWcTL6AX84oRO1fARCLaKuPe3P6mUu0uqUTMikVU1fBmw65MseL/z1s8JZcPvD5g0UVj1grCi/ZkTBan1tMTtvw45+guoIFxidvCQ/qiagBVZC0jNSRAua3Xl4KK+IMGrFE/5/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400289; c=relaxed/simple;
	bh=hvztLrJ4PSwRHtsh0fvfEfYYCEyJ1k5t2jSDdBWb7G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFEZEI33twGZrxic91I1LnZ30m2VmmwtMd+TOnSQiUh3ru9G8DX96SgKgNerzIjYWgI6AH4olNbkE8LduIZYFMqY8m60blSTN+aDQ62rRWXWyWff7KLh2br7SR9YcTLaDbCOvViM9RHN3izvq2p4vB20Scebzr4Of16u5TX0CI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHYU2Wx1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHYU2Wx1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400286; x=1819936286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hvztLrJ4PSwRHtsh0fvfEfYYCEyJ1k5t2jSDdBWb7G0=;
  b=AHYU2Wx1JRGVWjQt3q9PPiDvXedTN5iYc60zimJxAnu+obtCtzDbZ0p9
   SmHN3Hv8FAy5Tp1LFpxdMSR6R6DGyBgbbcddxqTC09DGh2HiQ+5FqCrDf
   UR9HALCo9QOLLA02zjfWA3SmMuELxwD/jNuBm9NnIzmKsKgdR4I3aAGmr
   n8yQ9248GriI1L0SLDcygEB5MgW9Jg8sgmdvnR52ek8kWNKpHqY3tp+1/
   VYIImTYwyyey+fch/m3j3NmeH7/s5775MM0AEDCkkaScX+btXnciOA95o
   DfDE+G/vkSZspSJijO4iGtL+FwQ3mpcOcLEj5w9p2hUXbALSomEaw4cSd
   A==;
X-CSE-ConnectionGUID: BvpQxDKjTayw+jDwODo3Sw==
X-CSE-MsgGUID: 1PrMfPcUR3C1fq8sBAwofQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469124"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469124"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
X-CSE-ConnectionGUID: s2BkgkKHTbq5g/7rHSmwaw==
X-CSE-MsgGUID: Xs/X7ACUTl25VeX6OmP6Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770215"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:21 -0700
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
Subject: [PATCH v10 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
Date: Wed,  2 Sep 2026 18:51:04 -0700
Message-ID: <20260903015113.93343-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
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

