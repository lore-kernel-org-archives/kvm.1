Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9F30D40F;
	Sat, 25 Jul 2026 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938995; cv=none; b=YEVYlTqxOmZgb5dTELvYDFPCQGneIraRACgZYFrAMATL2g/V7P/eva5JFCBkS5GP0KREmLsJNCKsBNcmxL2ZgqAqzRuGYa1Jgl+3BQIuVKmLyO6ZId7LmowMpXnWanfhQmfDi8np753fgAFNRb4BZydG12NQKvLibTjCwXK86rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938995; c=relaxed/simple;
	bh=DHfhaHj8e5IJt0HA1Kvg9EgSqxcYXt4M2OlHZoydJno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6Rb1U3DKipr3k0cRj8dL+Vsi4s5qD1OB+vkIdDgksYCCKqu0L8v7FGUovEfGFlN9vMRQNZqqRya04C2FBzQCbh3l7J/drMt4OpiBuCH9co6RhJPQCLGKIiUzLBTQsScR77Qd2O/EUmEIdIokIb3dHD4H0M4n3eODSqr0KJG1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbuUi80A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbuUi80A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784938993; x=1816474993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DHfhaHj8e5IJt0HA1Kvg9EgSqxcYXt4M2OlHZoydJno=;
  b=dbuUi80A3SMUxMwEC0aAHic2KVmpyE8ci2CBr8sg+dq7hiZXb+EsNsdz
   WzAwkjf47R7n/4lH+rCg+kMlfnnYFlg2ifsUA95SIqcmPfjK7JTuLneO+
   T57fTgBnv5ono1UFVrYsoq3Th3hJf7BPO/gBkcGQeFVNe4juH4hbkKrsa
   DpQlDHJHD97UCZkjG3SIyY+UDoYLx2xbJr6pTvZYSeaLr5DgyT0pmmSYX
   Y24YPf8HWYPR+KAtW7Z3Oxhxt0HRg5HFc+UNnDnFbb66VBPQInqXpc9+H
   bte/MWiO/v5i5460cO9EJBmCTFZ4Cz1NxCRGCFh8ofnrxb1oJybzYUQUE
   A==;
X-CSE-ConnectionGUID: s7v35CLIRjuYXosg4jnY/w==
X-CSE-MsgGUID: RncHLhirTdOYWz5Y5HPz8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726113"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726113"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
X-CSE-ConnectionGUID: 2QBlkzZHSKC+sYusGHpJIg==
X-CSE-MsgGUID: nQg1apwLSxKmfEboZ4fU4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359250"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
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
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v8 01/11] x86/virt/tdx: Simplify PAMT layout calculation
Date: Fri, 24 Jul 2026 17:22:51 -0700
Message-ID: <20260725002302.3337017-2-rick.p.edgecombe@intel.com>
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

For each memory region that the TDX module might use (called TDMR), three
separate traditional PAMT allocations are needed. There is one for each
supported page size (1GB, 2MB, 4KB). These store information on each page
in the TDMR. In Linux, they are allocated out of one physically contiguous
block, in order to more efficiently use some internal TDX module
bookkeeping resources. So some simple math is needed to break the single
large allocation into three smaller allocations for each page size.

There are some commonalities in the math needed to calculate the base and
size for each smaller allocation, and so an effort was made to share logic
across the three. Unfortunately doing this turned out unnaturally tortured,
with a loop iterating over the three page sizes, only to call into a
function with case statements for each page size. In the future Dynamic
PAMT will add more logic that is special to the 4KB page size, making the
benefit of the math sharing even more questionable.

Three is not a very high number, so get rid of the loop and just duplicate
the small calculation three times. In doing so, setup for future Dynamic
PAMT changes.

Since the loop that iterates over it is gone, further simplify the code by
dropping the array of intermediate size and base storage. Just store the
values to their final locations.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v8:
 - Fix PAMT capitalization in comment (Sohil)
 - Delete stale info in log, that Chao mentioned last time (Binbin)

v7:
 - Remove accidentital whitespace changes (Kiryl)
 - Drop stale sentence in log (Chao)
 - Better patch subject (Yan)
 - Drop Assisted-by tag and cover AI use in log (Dave)
---
 arch/x86/virt/vmx/tdx/tdx.c | 90 ++++++++++++-------------------------
 1 file changed, 28 insertions(+), 62 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea464c47..e00a6c8eda1b9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -514,31 +514,21 @@ static __init int fill_out_tdmrs(struct list_head *tmb_list,
  * Calculate PAMT size given a TDMR and a page size.  The returned
  * PAMT size is always aligned up to 4K page boundary.
  */
-static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz,
-					     u16 pamt_entry_size)
+static __init unsigned long tdmr_get_pamt_sz(struct tdmr_info *tdmr, int pgsz)
 {
 	unsigned long pamt_sz, nr_pamt_entries;
+	const int tdx_pg_size_shift[TDX_PS_NR] = { PAGE_SHIFT, PMD_SHIFT, PUD_SHIFT };
+	const u16 pamt_entry_size[TDX_PS_NR] = {
+		tdx_sysinfo.tdmr.pamt_4k_entry_size,
+		tdx_sysinfo.tdmr.pamt_2m_entry_size,
+		tdx_sysinfo.tdmr.pamt_1g_entry_size,
+	};
 
-	switch (pgsz) {
-	case TDX_PS_4K:
-		nr_pamt_entries = tdmr->size >> PAGE_SHIFT;
-		break;
-	case TDX_PS_2M:
-		nr_pamt_entries = tdmr->size >> PMD_SHIFT;
-		break;
-	case TDX_PS_1G:
-		nr_pamt_entries = tdmr->size >> PUD_SHIFT;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
+	nr_pamt_entries = tdmr->size >> tdx_pg_size_shift[pgsz];
+	pamt_sz = nr_pamt_entries * pamt_entry_size[pgsz];
 
-	pamt_sz = nr_pamt_entries * pamt_entry_size;
 	/* TDX requires PAMT size must be 4K aligned */
-	pamt_sz = ALIGN(pamt_sz, PAGE_SIZE);
-
-	return pamt_sz;
+	return PAGE_ALIGN(pamt_sz);
 }
 
 /*
@@ -576,15 +566,11 @@ static __init int tdmr_get_nid(struct tdmr_info *tdmr, struct list_head *tmb_lis
  * within @tdmr, and set up PAMTs for @tdmr.
  */
 static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
-				   struct list_head *tmb_list,
-				   u16 pamt_entry_size[])
+				   struct list_head *tmb_list)
 {
-	unsigned long pamt_base[TDX_PS_NR];
-	unsigned long pamt_size[TDX_PS_NR];
-	unsigned long tdmr_pamt_base;
 	unsigned long tdmr_pamt_size;
 	struct page *pamt;
-	int pgsz, nid;
+	int nid;
 
 	nid = tdmr_get_nid(tdmr, tmb_list);
 
@@ -592,12 +578,10 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
 	 * Calculate the PAMT size for each TDX supported page size
 	 * and the total PAMT size.
 	 */
-	tdmr_pamt_size = 0;
-	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
-		pamt_size[pgsz] = tdmr_get_pamt_sz(tdmr, pgsz,
-					pamt_entry_size[pgsz]);
-		tdmr_pamt_size += pamt_size[pgsz];
-	}
+	tdmr->pamt_4k_size = tdmr_get_pamt_sz(tdmr, TDX_PS_4K);
+	tdmr->pamt_2m_size = tdmr_get_pamt_sz(tdmr, TDX_PS_2M);
+	tdmr->pamt_1g_size = tdmr_get_pamt_sz(tdmr, TDX_PS_1G);
+	tdmr_pamt_size = tdmr->pamt_4k_size + tdmr->pamt_2m_size + tdmr->pamt_1g_size;
 
 	/*
 	 * Allocate one chunk of physically contiguous memory for all
@@ -606,25 +590,17 @@ static __init int tdmr_set_up_pamt(struct tdmr_info *tdmr,
 	 */
 	pamt = alloc_contig_pages(tdmr_pamt_size >> PAGE_SHIFT, GFP_KERNEL,
 			nid, &node_online_map);
+
+	/*
+	 * tdmr->pamt_4k_base is still zero so the error
+	 * path of the caller will skip freeing the PAMT.
+	 */
 	if (!pamt)
 		return -ENOMEM;
 
-	/*
-	 * Break the contiguous allocation back up into the
-	 * individual PAMTs for each page size.
-	 */
-	tdmr_pamt_base = page_to_pfn(pamt) << PAGE_SHIFT;
-	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
-		pamt_base[pgsz] = tdmr_pamt_base;
-		tdmr_pamt_base += pamt_size[pgsz];
-	}
-
-	tdmr->pamt_4k_base = pamt_base[TDX_PS_4K];
-	tdmr->pamt_4k_size = pamt_size[TDX_PS_4K];
-	tdmr->pamt_2m_base = pamt_base[TDX_PS_2M];
-	tdmr->pamt_2m_size = pamt_size[TDX_PS_2M];
-	tdmr->pamt_1g_base = pamt_base[TDX_PS_1G];
-	tdmr->pamt_1g_size = pamt_size[TDX_PS_1G];
+	tdmr->pamt_4k_base = page_to_phys(pamt);
+	tdmr->pamt_2m_base = tdmr->pamt_4k_base + tdmr->pamt_4k_size;
+	tdmr->pamt_1g_base = tdmr->pamt_2m_base + tdmr->pamt_2m_size;
 
 	return 0;
 }
@@ -655,10 +631,7 @@ static __init void tdmr_do_pamt_func(struct tdmr_info *tdmr,
 	tdmr_get_pamt(tdmr, &pamt_base, &pamt_size);
 
 	/* Do nothing if PAMT hasn't been allocated for this TDMR */
-	if (!pamt_size)
-		return;
-
-	if (WARN_ON_ONCE(!pamt_base))
+	if (!pamt_base)
 		return;
 
 	pamt_func(pamt_base, pamt_size);
@@ -684,14 +657,12 @@ static __init void tdmrs_free_pamt_all(struct tdmr_info_list *tdmr_list)
 
 /* Allocate and set up PAMTs for all TDMRs */
 static __init int tdmrs_set_up_pamt_all(struct tdmr_info_list *tdmr_list,
-					struct list_head *tmb_list,
-					u16 pamt_entry_size[])
+				 struct list_head *tmb_list)
 {
 	int i, ret = 0;
 
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
-		ret = tdmr_set_up_pamt(tdmr_entry(tdmr_list, i), tmb_list,
-				pamt_entry_size);
+		ret = tdmr_set_up_pamt(tdmr_entry(tdmr_list, i), tmb_list);
 		if (ret)
 			goto err;
 	}
@@ -968,18 +939,13 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 				  struct tdmr_info_list *tdmr_list,
 				  struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
-	u16 pamt_entry_size[TDX_PS_NR] = {
-		sysinfo_tdmr->pamt_4k_entry_size,
-		sysinfo_tdmr->pamt_2m_entry_size,
-		sysinfo_tdmr->pamt_1g_entry_size,
-	};
 	int ret;
 
 	ret = fill_out_tdmrs(tmb_list, tdmr_list);
 	if (ret)
 		return ret;
 
-	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list, pamt_entry_size);
+	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list);
 	if (ret)
 		return ret;
 
-- 
2.54.0

