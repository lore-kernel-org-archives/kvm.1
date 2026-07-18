Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5133242D88;
	Sat, 18 Jul 2026 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339132; cv=none; b=ZoZClVmAbDNGH9IvwjGazCcXTKNDarfOEhZHoOXyyu9Wj1CUa/llwxzbqxcHT6WYMFr/z45sJZtVyuOhBTtpwXwG7iKS4om5whE8oEGQp089PLzvyJF6hLtowvob4Fkt1iT710kH4G4LuXuf3F9RUW1KeAGfSO9mU1er/qgnyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339132; c=relaxed/simple;
	bh=TWseCZ6THZmQHfEefjWVNRWJtOYBBk9BoZefAGepBbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpbFuSXqp/heksSNbCCdFp+M8XFAjvOY5WWs1FEdLI7AtLO905K0cL/+aCI4LSKvGEu6GPOavZtat7D+/HIxCwyDhc/E5YfpjK/ZXsDM1UehlAD++ZCgda/5Xd4RPDc2cRjXm5uYsNjuogqEX5/cKv58tP+z0tawc+g6RVDwvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fn2qYcNa; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fn2qYcNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784339129; x=1815875129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWseCZ6THZmQHfEefjWVNRWJtOYBBk9BoZefAGepBbA=;
  b=Fn2qYcNascfzbTL3ZB94rpSekvgp2u1seHTmmaci5XW6jFCWMlldJ64h
   gmJR7O9OKc//ZobbG9DyWuMtfHUb3qhLQo8PuEa2iX7ECy4v8Ssqm0pW6
   ZVP28eWwlei0le9vrajHAxIADTQDvrKfW++VFQ+Gzj4JH3RZN4Hz/J7G0
   5VYPiNz1S8vdZGfDlH9XpQugcx5MW8hoH1Nz0gYAPRS0YHlNHKFAyrJaB
   /nXgiqKekopnwEoQSJsxd7zC5kiJy93KqFtU7i5sPoQ56HB+3K+Y+2b/T
   BPDLkPAimtz52GHCLZAdU45mWTwOL+w/hEsJc1O/7NLnOND4xPPQ4jC2Y
   w==;
X-CSE-ConnectionGUID: CyP+riWxS/CxBqO7FSlkpw==
X-CSE-MsgGUID: 55B422EDTWW8p/XQvINycw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96377196"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96377196"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:17 -0700
X-CSE-ConnectionGUID: 3CawfvqsTnirYHNNuaEgFg==
X-CSE-MsgGUID: ayfqzdOBSVKoEFR9Im2fNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254296293"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:11 -0700
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
Subject: [PATCH v7 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Date: Fri, 17 Jul 2026 18:45:00 -0700
Message-ID: <20260718014500.2231262-12-rick.p.edgecombe@intel.com>
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
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
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
index f397ea17248e3..cb0f0ef0dd5f1 100644
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
 
-	/* Try to add the pamt page and take the refcount 0->1. */
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

