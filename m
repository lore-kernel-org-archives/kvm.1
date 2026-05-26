Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6F30E83A;
	Tue, 26 May 2026 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762935; cv=none; b=CSDfJy1AT9EKDov9P3x2sJ97zznZ0wvEiVhbT3ovrgTkFA6BYMJtZzBbkL4oAIH+kbcrfFR0eKwGBm785MmnGDEYiH5/NLevy9D7cDRyIEh0wZr30liHnkw4S0aFp9bbUfMRUj2HTpX3I5VsZSq3bRuNb1fKUQVgwumscpATEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762935; c=relaxed/simple;
	bh=KfOA9v5revpQ6S9OEYf7TOeMIGkHMH0/KABda7h4XWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHKmhdP+yQ4jG+TQCxFp0q6NPTUXElo/WRp6wM0dbhnFdb1fEVvi1RTauNrc/neNI+xv8jTST2rl08o7EWvdGLJdluLEEFhBwcUv3ICOfLvbqO/nNH3At+t9hYrAkCMQ+HKiOdydKpnBIG1K348BaWiitztLB2qXO8M9eqHvubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyVdth+L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyVdth+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762931; x=1811298931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KfOA9v5revpQ6S9OEYf7TOeMIGkHMH0/KABda7h4XWg=;
  b=SyVdth+LrKZSt+6Expgeor/iqNMY9pcrxiypazut4o9+hzB6HXBy0XET
   JURCx64kKAEqmhU+9XHmskQGPjbTJVcrL0ezHoTSwb0+ucVAk3xwRmTlU
   52Y66TJN8wJRt6loSR0dcCImvAtHFS52w67YRPUwKWAnYtvWcoIFpy5xc
   8RzQF9Zsb/tbjkRiOyo0f8nO91Ido1f5vNGKonpdxY93i0wwzW3tE2I0y
   9Fu6Zhpvnz4ahdsF5ZMwptQCmlZ5/N0QziGkjZsJCyu0waSBO5GiOL8j4
   36aMIuIEB+jVWOzoVIbLzcoeD/QDj0KTfwzCdfUty95+UlbQrSRNmH54S
   g==;
X-CSE-ConnectionGUID: oYDCcmohSLSrnuN/iZXyLw==
X-CSE-MsgGUID: c+JPMJRoS7a5Ef2/2mQi7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677813"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677813"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: 3StM9WuITROPZGtD6Gu2xQ==
X-CSE-MsgGUID: hOWx9LOoTyas3tLOdjWQ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878302"
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 05/11] x86/virt/tdx: Handle concurrent callers in tdx_pamt_get/put()
Date: Mon, 25 May 2026 19:35:09 -0700
Message-ID: <20260526023515.288829-6-rick.p.edgecombe@intel.com>
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

tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
backing for the 2MB region covering the passed pfn. However, multiple
callers can concurrently operate on 4KB pages that fall within the same
2MB region. When this happens only one Dynamic PAMT page pair needs to be
installed to cover the 2MB range. And when one page is freed, the Dynamic
PAMT backing cannot be freed until all pages in the range are no longer in
use. Make the helpers handle these races internally.

Use the per-2MB refcounts from previous changes to track how many 4KB
pages are in use within each region. Gate the actual Dynamic PAMT add and
remove on refcount transitions (0->1 and 1->0). Serialize the refcount
check and SEAMCALL with a global spinlock so the read-decide-act sequence
is atomic. This also avoids TDX module BUSY errors, as Dynamic PAMT add
and remove SEAMCALLs take an internal TDX module locks at 2MB granularity,
so simultaneous attempts on the same region would conflict.

The lock is global and heavyweight. Use simple conditional logic to keep
correctness obvious. This will be optimized in a later change.

Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - Split from "x86/virt/tdx: Add tdx_alloc/free_control_page() helpers"
 - Return 0 instead of ret to be clearer (Binbin)
 - Clarify log (Nikolay)
 - Justify why the patch is not optimized in response to comments by
   (Nikolay)
 - Move tdx_find_pamt_refcount() to faciliate patch re-order
 - Adjustments from dropping error helper patches
 - Log tweaks
---
 arch/x86/virt/vmx/tdx/tdx.c | 72 ++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 16 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6658a6be6697c..50333eb96efa6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2043,10 +2043,14 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 	return 0;
 }
 
-/* Allocate PAMT memory for the given page */
+/* Serializes adding/removing PAMT memory */
+static DEFINE_SPINLOCK(pamt_lock);
+
+/* Bump PAMT refcount for the given page and allocate PAMT memory if needed */
 static int tdx_pamt_get(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
+	atomic_t *pamt_refcount;
 	u64 tdx_status;
 	int ret;
 
@@ -2057,10 +2061,26 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	if (ret)
 		return ret;
 
-	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
-	if (tdx_status != TDX_SUCCESS) {
-		ret = -EIO;
-		goto out_free;
+	pamt_refcount = tdx_find_pamt_refcount(pfn);
+
+	scoped_guard(spinlock, &pamt_lock) {
+		/*
+		 * If the pamt page is already added (i.e. refcount >= 1),
+		 * then just increment the refcount.
+		 */
+		if (atomic_read(pamt_refcount)) {
+			atomic_inc(pamt_refcount);
+			goto out_free;
+		}
+
+		/* Try to add the pamt page and take the refcount 0->1. */
+		tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
+		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
+			ret = -EIO;
+			goto out_free;
+		}
+
+		atomic_set(pamt_refcount, 1);
 	}
 
 	return 0;
@@ -2069,26 +2089,46 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	return ret;
 }
 
-/* Free PAMT memory for the given page */
+/*
+ * Drop PAMT refcount for the given page and free PAMT memory if it is no
+ * longer needed.
+ */
 static void tdx_pamt_put(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
+	atomic_t *pamt_refcount;
 	u64 tdx_status;
 
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return;
 
-	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
+	pamt_refcount = tdx_find_pamt_refcount(pfn);
 
-	/*
-	 * Don't free pamt_pages as it could hold garbage when
-	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
-	 * there is no risk of data corruption, but do yell loudly as
-	 * failure indicates a kernel bug, memory is being leaked, and
-	 * the dangling PAMT entry may cause future operations to fail.
-	 */
-	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
-		return;
+	scoped_guard(spinlock, &pamt_lock) {
+		/*
+		 * If the there are more than 1 references on the pamt page,
+		 * don't remove it yet. Just decrement the refcount.
+		 */
+		if (atomic_read(pamt_refcount) > 1) {
+			atomic_dec(pamt_refcount);
+			return;
+		}
+
+		/* Try to remove the pamt page and take the refcount 1->0. */
+		tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
+
+		/*
+		 * Don't free pamt_pages as it could hold garbage when
+		 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
+		 * there is no risk of data corruption, but do yell loudly as
+		 * failure indicates a kernel bug, memory is being leaked, and
+		 * the dangling PAMT entry may cause future operations to fail.
+		 */
+		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
+			return;
+
+		atomic_set(pamt_refcount, 0);
+	}
 
 	free_pamt_array(pamt_pages);
 }
-- 
2.54.0

