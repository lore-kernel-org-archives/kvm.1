Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3430EF91;
	Tue, 26 May 2026 02:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762935; cv=none; b=Xi6PvoAau2ANmp4RxSzrZ7VUEWIxkYVbefObWRN+lX1hdC3cCdI3gN4isEKImZv3pVjtZX+tWPLJxjU8GETAwpRElNZK7pTDjtByCKsm6R64k5yu7ccvRD6zvXWdJNxXBxeLd3bVDz4hN5r77yCrfUK38nWAzQNZ86NAIBbgksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762935; c=relaxed/simple;
	bh=roAtp1tb8HH5eiV2GjzKq9nl3/PGnRumHdTZNS+LIaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Em35Rh2p77c+IAME85WYh70mEQn1ANl71e0jjAAwXkLNaKMt7KwNp5P5QhE68qdMTBnLi4J4FVA+DjES6cX1kgp6FIhj99gi5cb5h8bFcOuEDW9VckzrgKKQv0geQ0C5vpiyD7F/9IHtxaR7PEwpyUQ/QO7WLc0ouUHYLvduUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bo4iO5eR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bo4iO5eR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762931; x=1811298931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=roAtp1tb8HH5eiV2GjzKq9nl3/PGnRumHdTZNS+LIaM=;
  b=bo4iO5eRUVhzdwP+goukSM/fq+j/XyeqsSl9qZ/0mlXTg7e5+xTtZ9x+
   nuALd1XZrUY+pYBlErIcYIbRBke7qpLbZyrjO2jLgAASA2DOGkzMZ5tZs
   Obic+Yjfr1JvcUQYLiunKOjO+rBIFCgGd1OEaMjqYrdNdLBrpIculYsrr
   ffqtF4tMTUPfDL4Q1Cs63k72LjfVQGWVSXnafgJqpu5TECjJCSogklexm
   IqQVy87ieR6y/T7VgqdGj3cxugztuwxO4uWlTon0QFez3SXq1k8JZJMN/
   TztoU0GPoAJu4uVnTacUG9knMV6hvZnzDs4yX0hZihXTIwvAuujhcrJ/w
   w==;
X-CSE-ConnectionGUID: vbLtjpxqTua9PB8Gj/Mzlw==
X-CSE-MsgGUID: ooncipFgT7WICKu458f5Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677821"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: XLpXVkV6Qqy1ryRRTsYHTA==
X-CSE-MsgGUID: qeATd1qGR++QxJFsCxh8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878308"
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
Subject: [PATCH v6 06/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Date: Mon, 25 May 2026 19:35:10 -0700
Message-ID: <20260526023515.288829-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
only take it for the slowpath (0->1 and 1->0 transitions).

On the put side make the refcount adjustment and lock taking atomic so if
a 'get' happens between them, it doesn't cause the Dynamic PAMT to be
freed incorrectly. On the get side there is no technique for doing the
refcount adjustment and lock atomically, so check the refcount again
inside the lock.

Assisted-by: GitHub Copilot:claude-opus-4-6
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - Fix "tdx_pamt_add()" typo to "tdx_pamt_get()" in lost-race comment
 - Fix error path bug: set ret = -EIO and use WARN_ON_ONCE() instead of
   pr_err() for unexpected PAMT.ADD failures (Sean)
 - Use "set the refcount 0->1" wording to match atomic_set() usage
 - Wrap comments to 80 columns
 - Switch to atomic_dec_and_lock() and remove handling of races that are
   no longer needed as a result. Adjust comments as appropriate. (Dave)
 - Adjustments from dropping error helper patches
v4:
 - Use atomic_set() in the HPA_RANGE_NOT_FREE case (Kiryl)
 - Log, comment typos (Binbin)
 - Move PAMT page allocation after refcount check in tdx_pamt_get() to
   avoid an alloc/free in the common path.

v3:
 - Split out optimization from “x86/virt/tdx: Add tdx_alloc/free_page() helpers”
 - Remove edge case handling that I could not find a reason for
 - Write log
---
 arch/x86/virt/vmx/tdx/tdx.c | 102 +++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 41 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 50333eb96efa6..c41c632a4cdf2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2057,32 +2057,50 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return 0;
 
+	pamt_refcount = tdx_find_pamt_refcount(pfn);
+
+	/*
+	 * If the pamt page is already added (i.e. refcount >= 1),
+	 * then just increment the refcount.
+	 */
+	if (atomic_inc_not_zero(pamt_refcount))
+		return 0;
+
 	ret = alloc_pamt_array(pamt_pages);
 	if (ret)
 		return ret;
 
-	pamt_refcount = tdx_find_pamt_refcount(pfn);
+	spin_lock(&pamt_lock);
 
-	scoped_guard(spinlock, &pamt_lock) {
-		/*
-		 * If the pamt page is already added (i.e. refcount >= 1),
-		 * then just increment the refcount.
-		 */
-		if (atomic_read(pamt_refcount)) {
-			atomic_inc(pamt_refcount);
-			goto out_free;
-		}
-
-		/* Try to add the pamt page and take the refcount 0->1. */
-		tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
-		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
-			ret = -EIO;
-			goto out_free;
-		}
-
-		atomic_set(pamt_refcount, 1);
+	/*
+	 * Unlike tdx_pamt_put() which uses atomic_dec_and_lock() to
+	 * atomically handle the 1->0 transition, the get side has no
+	 * equivalent combined primitive for 0->1. Recheck under the
+	 * lock since another get may have already done the 0->1
+	 * transition after both saw atomic_inc_not_zero() fail.
+	 */
+	if (atomic_read(pamt_refcount)) {
+		atomic_inc(pamt_refcount);
+		spin_unlock(&pamt_lock);
+		goto out_free;
 	}
 
+	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
+	if (tdx_status == TDX_SUCCESS) {
+		/*
+		 * The refcount is zero, and this locked path is the
+		 * only way to increase it from 0->1.
+		 */
+		atomic_set(pamt_refcount, 1);
+	} else {
+		WARN_ON_ONCE(1);
+		ret = -EIO;
+		spin_unlock(&pamt_lock);
+		goto out_free;
+	}
+
+	spin_unlock(&pamt_lock);
+
 	return 0;
 out_free:
 	free_pamt_array(pamt_pages);
@@ -2104,32 +2122,34 @@ static void tdx_pamt_put(kvm_pfn_t pfn)
 
 	pamt_refcount = tdx_find_pamt_refcount(pfn);
 
-	scoped_guard(spinlock, &pamt_lock) {
+	/*
+	 * If there is more than 1 reference on the pamt page, don't
+	 * remove it yet. Just decrement the refcount.
+	 */
+	if (!atomic_dec_and_lock(pamt_refcount, &pamt_lock))
+		return;
+
+	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
+
+	/*
+	 * Don't free pamt_pages as it could hold garbage when
+	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
+	 * there is no risk of data corruption, but do yell loudly as
+	 * failure indicates a kernel bug, memory is being leaked, and
+	 * the dangling PAMT entry may cause future operations to fail.
+	 */
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
 		/*
-		 * If the there are more than 1 references on the pamt page,
-		 * don't remove it yet. Just decrement the refcount.
+		 * atomic_dec_and_lock() already decremented it to 0,
+		 * but the PAMT entry still exists since REMOVE failed.
 		 */
-		if (atomic_read(pamt_refcount) > 1) {
-			atomic_dec(pamt_refcount);
-			return;
-		}
-
-		/* Try to remove the pamt page and take the refcount 1->0. */
-		tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
-
-		/*
-		 * Don't free pamt_pages as it could hold garbage when
-		 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
-		 * there is no risk of data corruption, but do yell loudly as
-		 * failure indicates a kernel bug, memory is being leaked, and
-		 * the dangling PAMT entry may cause future operations to fail.
-		 */
-		if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
-			return;
-
-		atomic_set(pamt_refcount, 0);
+		atomic_set(pamt_refcount, 1);
+		spin_unlock(&pamt_lock);
+		return;
 	}
 
+	spin_unlock(&pamt_lock);
+
 	free_pamt_array(pamt_pages);
 }
 
-- 
2.54.0

