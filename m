Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531F530E858;
	Sat, 25 Jul 2026 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939016; cv=none; b=DFSDFDNOJN5A2L0y+i6Re91qD3zJFkBc5SZeJvNu1XpAqDilG+MZlkx3QUiCez7e1nPnweGqhIRXpacBkbudsE/nSxcRda3Xo0LLPBP7gLjdajQKPnC9pMnXm4+nTpWQ9M3sXx4pM1oD6pChM1OlW85bAy1BPPDgT0kWWnOTTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939016; c=relaxed/simple;
	bh=GDjJDtPFw1gzL4FEMikUOtBAoPhxMjF7n8+ZP4xhlEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpoU/k80NFkM7PD8sEUlPz89JJbCpv3Yum2JJbz/UcHWrJ3dssxwZb8hspthErim2UxMJ6WC/bTe1zUjbIblG9JNtvhvaYQrgsllvZWgOJ9qzkqVrpyIbWy8LL9WoKsTQLdTbN81SCyME5ewIoKHC9YFuw/bSumoq/UrLK50r2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nb8JW3bH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nb8JW3bH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784939009; x=1816475009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDjJDtPFw1gzL4FEMikUOtBAoPhxMjF7n8+ZP4xhlEQ=;
  b=nb8JW3bHzFJ+ysbZedVWLUYSemynhNvqR/7pQACGBWjmYmmH45DvoyCM
   JuNF79LHvP9BtaSLKB2UAPxNNbGyIrkv2i3Dm33iLvToFI1EuDplGBZzf
   YMX/uWXMd4kZMTESUAhoBiOLt3byNKw2UHFjzOdaheQFtUzp2gbaHd2hA
   gLfHtwb7xShKZXnsSixve0GRRDu5fGh3rPwXjldwUnB7b+r6DPiv6nPZl
   4cYOSWoE6ZQT4Tl703OZ8CrzCkOP2r3XZ76AwxhE0TCkflMNWm7oYB8UL
   OfwLAMPIutlNDvntr8PE2nTQii3JZI7Sa73YUCb8Xq/j95sHbGn9ifSsN
   Q==;
X-CSE-ConnectionGUID: 1NCG63FoSuWqsDel80FsDQ==
X-CSE-MsgGUID: R1oG0UxHRBaFm/fTXnlj0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726194"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
X-CSE-ConnectionGUID: cF/iYneMSQONkUi5tT0M7Q==
X-CSE-MsgGUID: CizVDwgcTA2QcmFkr0v4HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359280"
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
Subject: [PATCH v8 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Date: Fri, 24 Jul 2026 17:23:01 -0700
Message-ID: <20260725002302.3337017-12-rick.p.edgecombe@intel.com>
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

The Dynamic PAMT get/put helpers use a global spinlock to serialize all
refcount updates and SEAMCALL invocations. This gives correct behavior for
concurrent callers, but leads to contention. It is especially bad from the
KVM side, which is designed to allow faulting in EPT under a shared lock.
With the global spinlock, not only is the lock an exclusive one, but it is
for all TDs instead of just a single one.

But taking the global lock each time is actually unnecessary. Only the 0->1
and 1->0 refcount transitions actually need the lock (to pair with
SEAMCALLs that actually add and remove with the Dynamic PAMT pages). The
common case of incrementing or decrementing a non-zero refcount can be
done locklessly.

So create a fast and slow path. Check the refcount outside the lock and
only take it for the slow path (0->1 and 1->0 transitions).

On the put side make the refcount adjustment and lock taking atomic so if
a 'get' happens between them, it doesn't cause the Dynamic PAMT to be
freed incorrectly. On the get side there is no technique for doing the
refcount adjustment and lock atomically, so check the refcount again
inside the lock.

AI was used under supervision to collect/apply feedback, review code and
workshop logs. It assisted in identifying/evaluating the stale
conditionals for the races resolved from the atomic_dec_and_lock() change.
Separate from atomic_dec_and_lock() fallout, it suggested to change
atomic_inc() to atomic_set(pamt_refcount, 1) in the put error path for the
sake of being more precise, which Kiryl had also suggested in the past.
The model also suggested updated comments following the
atomic_dec_and_lock() change based on some directed prompting. The
comments were subsequently edited or further prompted for fine tuning.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v7:
 - Drop Assisted-by tag and cover AI use in log (Dave)
 - Move to end of the series
 - Use atomic_inc_not_zero() in this patch inside the spin_lock(), as
   suggested on non-optimized patch by. (Dave)

v6:
 - Fix "tdx_pamt_add()" typo to "tdx_pamt_get()" in lost-race comment
 - Fix error path bug: set ret = -EIO and use WARN_ON_ONCE() instead of
   pr_err() for unexpected PAMT.ADD failures (Sean)
 - Use "set the refcount 0->1" wording to match atomic_set() usage
 - Wrap comments to 80 columns
 - Switch to atomic_dec_and_lock() and remove handling of races that are
   no longer needed as a result. Adjust comments as appropriate. (Dave)
 - Adjustments from dropping error helper patches
---
 arch/x86/virt/vmx/tdx/tdx.c | 44 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f2ea034773bb2..dec45709e454a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2166,28 +2166,41 @@ int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return 0;
 
-	ret = alloc_pamt_array(pamt_pages, cache);
-	if (ret)
-		return ret;
-
 	pamt_refcount = tdx_find_pamt_refcount(pfn);
 
-	spin_lock(&pamt_lock);
-
 	/*
 	 * If the pamt page is already added (i.e. refcount >= 1),
 	 * then just increment the refcount.
 	 */
+	if (atomic_inc_not_zero(pamt_refcount))
+		return 0;
+
+	ret = alloc_pamt_array(pamt_pages, cache);
+	if (ret)
+		return ret;
+
+	spin_lock(&pamt_lock);
+
+	/*
+	 * Unlike tdx_pamt_put() which uses atomic_dec_and_lock() to
+	 * atomically handle the 1->0 transition, the get side has no
+	 * equivalent combined primitive for 0->1. Recheck under the
+	 * lock since another get may have already done the 0->1
+	 * transition after both saw atomic_inc_not_zero() fail.
+	 */
 	if (atomic_inc_not_zero(pamt_refcount))
 		goto out_free;
 
-	/* Try to add the PAMT page and take the refcount 0->1. */
 	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
 	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
 		ret = -EIO;
 		goto out_free;
 	}
 
+	/*
+	 * The refcount is zero, and this locked path is the
+	 * only way to increase it from 0->1.
+	 */
 	atomic_set(pamt_refcount, 1);
 	spin_unlock(&pamt_lock);
 	return 0;
@@ -2212,17 +2225,13 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 
 	pamt_refcount = tdx_find_pamt_refcount(pfn);
 
-	spin_lock(&pamt_lock);
 	/*
 	 * If there is more than 1 reference on the pamt page, don't
 	 * remove it yet. Just decrement the refcount.
 	 */
-	if (atomic_read(pamt_refcount) > 1) {
-		atomic_dec(pamt_refcount);
-		goto out_unlock;
-	}
+	if (!atomic_dec_and_lock(pamt_refcount, &pamt_lock))
+		return;
 
-	/* Try to remove the pamt page and take the refcount 1->0. */
 	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
 
 	/*
@@ -2232,10 +2241,15 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 	 * failure indicates a kernel bug, memory is being leaked, and
 	 * the dangling PAMT entry may cause future operations to fail.
 	 */
-	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
+		/*
+		 * atomic_dec_and_lock() already decremented it to 0,
+		 * but the PAMT entry still exists since REMOVE failed.
+		 */
+		atomic_set(pamt_refcount, 1);
 		goto out_unlock;
+	}
 
-	atomic_set(pamt_refcount, 0);
 	spin_unlock(&pamt_lock);
 	free_pamt_array(pamt_pages);
 	return;
-- 
2.54.0

