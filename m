Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC30CD80;
	Tue, 26 May 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762931; cv=none; b=M5dQddrLiodD8bm1C3av34Z1OVepwUGzEz43Rf+0gy/1zAtOJjigtHoKKXvI7UgEWUNk7J3AXdrqCeW93LL4bjUfVa7Mxvo+uq1CHFLLzmkRcS6ogYs/qmmunKVMnTT1UhDLIm9MSIbH0IOFxJ7TePk6BXegrATdkum04SvS2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762931; c=relaxed/simple;
	bh=q3F6dFl3Y2R7QdEvWtaNECjX8ekXuQNqhFpzJyLuGX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5EElCxJ/GC0yWw6zjX16OYVv195x1LgWhMz7F9IfnqcOsZ1kNrps9MUZPbFFE8EroTJ/XFIC4cFRtwZCBtl+2VcoZvYMhyJXpM0BN36108M38tu3NMuoIlp7AsyTwFeQKRhbx8yPt0df0FK+8DidlHyU+HVF3KKs46DZycf7vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG/GT1I7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG/GT1I7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762927; x=1811298927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q3F6dFl3Y2R7QdEvWtaNECjX8ekXuQNqhFpzJyLuGX4=;
  b=QG/GT1I7cTRHiInq+ikSxceEoxCaNvZWLuL95krezmbAL6dPJa+VPXTv
   Kf6GVDyzIrL6FuVY4bgvTOHDOqfw/ZWyJSM2FtAcmdcoGaRD4j8P5XiuA
   knnyBNTjJmD2m3+ZadE03KjCqLQspjdW7PKFupvAzUZFaZy0aVbmvA/77
   vHBtcyK+UcA8/piZiMGyFkue+1ceoDYusJLajfTsCtMknZ877fEFLGIGs
   7Xd78NVSL7e0nOOBpWEa6OuqdB9bWFqyVCQ2pLnBLel2+SY8RU/Kgq3T6
   QQOgGkQSCqAVg2+Fyrj+mKidiVHC/KodI5NR/Q0Oi/YJBxyK2d4wvM/CP
   A==;
X-CSE-ConnectionGUID: V+tZFXC1QCSHKc5TO5yEMQ==
X-CSE-MsgGUID: 7r5XPAYDTdmmw58egmoihA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677784"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677784"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: zVeTeqWbS6GVA4HeIOxKVg==
X-CSE-MsgGUID: oZBy9SjWSnOU0uwQtEFuww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878289"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
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
	kai.huang@intel.com
Cc: rick.p.edgecombe@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v6 02/11] x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
Date: Mon, 25 May 2026 19:35:06 -0700
Message-ID: <20260526023515.288829-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

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
Dynamic PAMT. At a high level, Dynamic PAMT still has the 1GB and 2MB
levels allocated on TDX module initialization, but the 4KB level is
allocated dynamically during runtime.

However, in the details, Dynamic PAMT still needs some smaller per 4KB
page scoped data (currently it is 1 bit per page). The TDX module exposes
the number of bits as a separate piece of metadata than the 4KB static
allocation for regular PAMT. Although the size is enumerated differently,
it is handed to the TDX module in the same way the 4KB page size PAMT
allocation is for regular, non-dynamic PAMT.

Begin to implement Dynamic PAMT in the kernel by reading the bits-per-page
needed for Dynamic PAMT. Calculate the size needed for the bitmap,
and use it instead of the 4KB size determined for normal PAMT, in the case
of Dynamic PAMT.

Unlike the existing metadata reading code, this code is not generated by a
script. So adjust the comment to be more generic. Also, start to adopt a
more normal kernel code style without the tenary statements and if
conditionals assignments that the auto generated code has.

Assisted-by: Sashiko:claude-opus-4-6
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - Improve comment (Binbin)
 - Log tweaks
 - Mark tdmr_get_pamt_bitmap_sz() __init in response to upstream
   changes
 - Switch to more normal kernel code style, even though it differs from
   the existing auto generated code.
---
 arch/x86/include/asm/tdx.h                  |  5 +++++
 arch/x86/include/asm/tdx_global_metadata.h  |  3 +++
 arch/x86/virt/vmx/tdx/tdx.c                 | 19 ++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 21 ++++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 503f9a3f46d61..82dc27aecf297 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -149,6 +149,11 @@ static __always_inline u64 sc_retry(sc_func_t func, u64 fn,
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
+static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
+{
+	return false; /* To be enabled when kernel is ready */
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 40689c8dc67eb..88040ddb51af4 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -21,6 +21,9 @@ struct tdx_sys_info_tdmr {
 	u16 pamt_4k_entry_size;
 	u16 pamt_2m_entry_size;
 	u16 pamt_1g_entry_size;
+
+	/* Optional metadata, if Dynamic PAMT is supported */
+	u8  pamt_page_bitmap_entry_bits;
 };
 
 struct tdx_sys_info_td_ctrl {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 487f389f52f4b..9ebd192cb5c17 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -512,6 +512,18 @@ static __init int fill_out_tdmrs(struct list_head *tmb_list,
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
@@ -579,7 +591,12 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
 	 * Calculate the PAMT size for each TDX supported page size
 	 * and the total PAMT size.
 	 */
-	tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		/* With Dynamic PAMT, PAMT_4K is replaced with a bitmap */
+		tdmr->pamt_4k_size = tdmr_get_pamt_bitmap_sz(tdmr);
+	} else {
+		tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
+	}
 	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
 	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
 	tdmr_pamt_size = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c7db393a9cfb1..7e8e913463be1 100644
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
+	ret = read_sys_metadata_field(0x9100000100000013, &val);
+	if (!ret)
+		sysinfo_tdmr->pamt_page_bitmap_entry_bits = val;
+
+	return ret;
+}
+
 static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret = 0;
@@ -116,5 +128,12 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
+	/*
+	 * Don't treat a module that doesn't support Dynamic PAMT
+	 * as a failure. Only read the metadata optionally.
+	 */
+	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
+		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
+
 	return ret;
 }
-- 
2.54.0

