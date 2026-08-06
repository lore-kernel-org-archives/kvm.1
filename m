Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975713B8BCC;
	Thu,  6 Aug 2026 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982147; cv=none; b=GB2sP896/Q/kab2qqa+pTEWwwCwMG0Q3iMJHJ/889ygexbAnsi7RAZoh10NHkF7xn1TU3aoWFwkLo7we972PdSs6zBd4vdKfJ7Dap4BQfEhXbMDyP6UyofOk6pHDsZegP84UbYI5XZ+twkMACeTaOh9hIFrzximw2M7Qm251DSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982147; c=relaxed/simple;
	bh=fKK1buH5etXgIhWe8UlmdLstculZgbsfwR/TMeBFV5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7ZwOYhm/dKtLNQkBlSxi465Sb9HlGSWEcPnO3bM83oax2nTTCIjRgG/fdc6Pomn85Ny2CCmDL9v9nrQFU9cmOudyV83pzSLPVHWTdbXLWNDwRmzRvIUQF2rFjTa93bptDcuwKnXbNaA986nxLMMHUkM8BuYcpQ5J3DrEJ/dExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UU+PoSh5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UU+PoSh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982145; x=1817518145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fKK1buH5etXgIhWe8UlmdLstculZgbsfwR/TMeBFV5k=;
  b=UU+PoSh5WX50Rdl15hHLWlvM6YgUhLPcUupC5C6TtKarbYwQRAskxRsT
   6Qs186lZWXtlvCiXb9br4U/PK0RWLfH5MEhr0MhfoaxpR8KQpY6C8uR/C
   T0tkw4aUhNpvtWV9KaxBwVI3UeF2m9wB9pRAE5NJ4aXtcagSmTSNq7aXr
   LKmups9wlmF8p3INX8u5+V0aqqfporwHSoTDgpLy49+yjTJB0XMg81oPr
   y23d1w2bpwgR/UGUCe7GQB8yHUqtcjhWwv6a+VJmVZFqdSle06cqwlzBd
   YPAj9RLkB/Jb/AdEY9Al/ofGuec1PFUagWRTgu1uwvY8wuFnV2G51v6y3
   g==;
X-CSE-ConnectionGUID: rFktpL/QQcucWy7OfrZ96A==
X-CSE-MsgGUID: YIoAfbHoRx64mkhkI0WcPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86422867"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86422867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:03 -0700
X-CSE-ConnectionGUID: CeazlCzTThWmnGe56ywyCw==
X-CSE-MsgGUID: U2jqE+ViSPuxj/pS2uYA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="258639873"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:03 -0700
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
Subject: [PATCH v9 05/11] x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
Date: Wed,  5 Aug 2026 19:08:44 -0700
Message-ID: <20260806020850.1221381-6-rick.p.edgecombe@intel.com>
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

tdx_pamt_get()/tdx_pamt_put() unconditionally add or remove Dynamic PAMT
backing for the 2MB region covering the passed page. However, multiple
callers can add or remove 4KB pages that fall within the same 2MB region
and in that scenario only a single PAMT entry is required.

Make the helpers handle only adding/removing Dynamic PAMT backing when
required, by refcounting each 2MB range. Gate the actual Dynamic PAMT add
and remove on refcount transitions (0->1 and 1->0). Serialize the refcount
check and SEAMCALL with a global spinlock so the read-decide-act sequence
is atomic. This also avoids TDX module BUSY errors, as the Dynamic PAMT add
and remove SEAMCALLs take internal TDX module locks for the 2MB ranges of
the specified PFN and the PAMT page pair PFNs. So simultaneous attempts on
the same 2MB ranges of the PFNs would otherwise encounter an error, which
would not be handleable in the put case.

The lock is global and heavyweight. Use simple conditional logic to keep
correctness obvious. This will be optimized in a later change.

The pamt_refcounts[] are atomic_t's. They do not strictly need to be
because all access is protected by pamt_lock. The overhead of an atomic_t
in this situation is minuscule compared to the global lock. Leave the
atomic_t in place to enable future optimization with minimal churn.

AI was used under supervision to collect/apply feedback, split patches,
review code and workshop logs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v8:
 - Fix PAMT capitalization in comment (Sohil)

v7:
 - Convert scoped_guard() blocks to use normal spin_un/lock() for the
   sake of making next patches diff cleaner
 - Drop __maybe_unused from tdx_find_pamt_refcount() (Binbin)
 - Switch to atomic_inc_not_zero() (Dave)
 - Justify use of atomic_t in log (Sohil)
 - Log/comments (Yan)
 - Drop Assisted-by tag and cover AI use in log (Dave)
---
 arch/x86/virt/vmx/tdx/tdx.c | 48 +++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b0ebd74a69fe2..0e6063c1405bc 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -289,7 +289,7 @@ static __init void free_pamt_refcounts(void)
 	pamt_refcounts = NULL;
 }
 
-static atomic_t * __maybe_unused tdx_find_pamt_refcount(unsigned long pfn)
+static atomic_t *tdx_find_pamt_refcount(unsigned long pfn)
 {
 	/* Find which PMD a PFN is in. */
 	unsigned long index = pfn >> (PMD_SHIFT - PAGE_SHIFT);
@@ -2120,10 +2120,14 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 	return 0;
 }
 
-/* Allocate PAMT memory for the given page */
+/* Serializes adding/removing PAMT memory */
+static DEFINE_SPINLOCK(pamt_lock);
+
+/* Bump PAMT refcount for the given pfn and allocate PAMT backing if needed. */
 static int tdx_pamt_get(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
+	atomic_t *pamt_refcount;
 	u64 tdx_status;
 	int ret;
 
@@ -2134,29 +2138,58 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	if (ret)
 		return ret;
 
+	pamt_refcount = tdx_find_pamt_refcount(pfn);
+
+	spin_lock(&pamt_lock);
+
+	/*
+	 * If the pamt page is already added (i.e. refcount >= 1),
+	 * then just increment the refcount.
+	 */
+	if (atomic_inc_not_zero(pamt_refcount))
+		goto out_free;
+
+	/* Try to add the PAMT page and take the refcount 0->1. */
 	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
-	if (tdx_status != TDX_SUCCESS) {
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
 		ret = -EIO;
 		goto out_free;
 	}
 
+	atomic_set(pamt_refcount, 1);
+	spin_unlock(&pamt_lock);
 	return 0;
 
 out_free:
+	spin_unlock(&pamt_lock);
 	free_pamt_array(pamt_pages);
 
 	return ret;
 }
 
-/* Free PAMT memory for the given page */
+/* Drop PAMT refcount for the given pfn and free PAMT backing if needed. */
 static void tdx_pamt_put(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
+	atomic_t *pamt_refcount;
 	u64 tdx_status;
 
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return;
 
+	pamt_refcount = tdx_find_pamt_refcount(pfn);
+
+	spin_lock(&pamt_lock);
+	/*
+	 * If there is more than 1 reference on the pamt page, don't
+	 * remove it yet. Just decrement the refcount.
+	 */
+	if (atomic_read(pamt_refcount) > 1) {
+		atomic_dec(pamt_refcount);
+		goto out_unlock;
+	}
+
+	/* Try to remove the pamt page and take the refcount 1->0. */
 	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
 
 	/*
@@ -2167,9 +2200,14 @@ static void tdx_pamt_put(kvm_pfn_t pfn)
 	 * the dangling PAMT entry may cause future operations to fail.
 	 */
 	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
-		return;
+		goto out_unlock;
 
+	atomic_set(pamt_refcount, 0);
+	spin_unlock(&pamt_lock);
 	free_pamt_array(pamt_pages);
+	return;
+out_unlock:
+	spin_unlock(&pamt_lock);
 }
 
 /*
-- 
2.54.0

