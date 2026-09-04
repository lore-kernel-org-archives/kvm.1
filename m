Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90851D519;
	Fri,  4 Sep 2026 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559215; cv=none; b=Bedw1VHTFjIIof7RKbitKEF4h3a0UeZ4PGu44qxSY9DBAV0Vqzctpm8zU7ra9r4CZ35eY0EZgzhmCX4aNiVs76MkbgSTOFOYjqWXe7PYz/Ba7VwGYsyHcMv953lQ02nU+uifX4h69wxIJnVY28ZNVM6elwYxUHWDaX9sBw8P06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559215; c=relaxed/simple;
	bh=rFBjumOEfR3sI+SrOouN6uOyXLX1L3bxGoKNn3A0B08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AmbGjkLaJOfitgY0V5UvdmoylrDUNxfObAifP5k2RT4VWjyEVwBD3qVPyEFf5bQp9PVa3mUu1XBEils4xE5Lf+tPtqrbU88vGyKaynv1eRNTDsZa64Z+q3Igj0iKC6BLlHFCYuh4gxKbICeyEMxcT5Lw2y39ZDwI37r+Bj4HioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOsRI4DO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOsRI4DO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559210; x=1820095210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFBjumOEfR3sI+SrOouN6uOyXLX1L3bxGoKNn3A0B08=;
  b=hOsRI4DO/kRialfxbHB1Akf+iq0FWX6kySzoBVw7tdG6CDH+arVdDTXP
   tINcQLLk/3fMLGIOw63vwm1McFW5zxmqJB/sDIUKiC/lbRpAvXE8LNZ4v
   EVUmIw80+mtmAXPojXJweaf95CMUqjVRxnOFgc1o0/XO+lbgfMC81BmqY
   Fq3f+AGiIvYiIh0SM9ae68QBNyzi7ZVKyRdkyCQHWYBlojjrxnWwgI8rL
   j3T1NQY272ELJ/LsbtoXih/oKGR+nZ+ZadhwEjJyPrWKnwxZ4nWeiH7Hz
   7ZISaVr/gXquNRlEaY9vAeaReIk2qEseXZdp4OtkPFD5xSFINtaxaqrYJ
   w==;
X-CSE-ConnectionGUID: CepZYchlT/KIpeE/dXMqjA==
X-CSE-MsgGUID: W+XSnD2hQTOo8aXRA+aQEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224888"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224888"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: 7Osb9NKzRouxTvfOXDAo2A==
X-CSE-MsgGUID: sarni4mRSA6WuEfF9Xm9ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675056"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
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
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v11 11/11] x86/virt/tdx: Optimize tdx_pamt_get/put()
Date: Fri,  4 Sep 2026 14:58:41 -0700
Message-ID: <20260904215841.303070-12-rick.p.edgecombe@intel.com>
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

The Dynamic PAMT (DPAMT) get/put helpers use a global spinlock to
serialize all refcount updates and SEAMCALL invocations. This gives correct
behavior for concurrent callers, but leads to contention. It is especially
bad from the KVM side, which is designed to allow faulting in EPT under a
shared lock. With the global spinlock, not only is the lock an exclusive
one, but it is for all TDs instead of just a single one.

But taking the global lock each time is actually unnecessary. Only the 0->1
and 1->0 refcount transitions actually need the lock (to pair with
SEAMCALLs that actually add and remove with the DPAMT pages). The common
case of incrementing or decrementing a non-zero refcount can be done
locklessly.

So create a fast and slow path. Check the refcount outside the lock and
only take it for the slow path (0->1 and 1->0 transitions).

On the put side make the refcount adjustment and lock taking atomic so if
a 'get' happens between them, it doesn't cause the DPAMT to be freed
incorrectly. On the get side there is no technique for doing the refcount
adjustment and lock atomically, so check the refcount again inside the
lock.

AI was used under supervision to collect/apply feedback, review code and
workshop logs. It assisted in identifying/evaluating the stale
conditionals for the races resolved from the atomic_dec_and_lock() change.
Separate from atomic_dec_and_lock() fallout, it suggested to change
atomic_inc() to atomic_set(pamt_refcount, 1) in the put error path for the
sake of being more precise, which Kiryl had also suggested in the past.
The model also suggested updated comments following the
atomic_dec_and_lock() change based on some directed prompting. The
comments were subsequently edited or further prompted for fine tuning.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Change "Dynamic PAMT" to "DPAMT" in comments. (Dave)

v7:
 - Drop Assisted-by tag and cover AI use in log. (Dave)
 - Move to end of the series.
 - Use atomic_inc_not_zero() in this patch inside the spin_lock(), as
   suggested on the non-optimized patch by (Dave).

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
index 063574ed86254..7891e42b27508 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2171,28 +2171,41 @@ int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return 0;
 
-	ret = alloc_pamt_array(pamt_pages, cache);
-	if (ret)
-		return ret;
-
 	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
 
-	spin_lock(&dpamt_lock);
-
 	/*
 	 * If the DPAMT entry is already added (i.e. refcount >= 1),
 	 * then just increment the refcount.
 	 */
+	if (atomic_inc_not_zero(dpamt_refcount))
+		return 0;
+
+	ret = alloc_pamt_array(pamt_pages, cache);
+	if (ret)
+		return ret;
+
+	spin_lock(&dpamt_lock);
+
+	/*
+	 * Unlike tdx_pamt_put() which uses atomic_dec_and_lock() to
+	 * atomically handle the 1->0 transition, the get side has no
+	 * equivalent combined primitive for 0->1. Recheck under the
+	 * lock since another get may have already done the 0->1
+	 * transition after both saw atomic_inc_not_zero() fail.
+	 */
 	if (atomic_inc_not_zero(dpamt_refcount))
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
 	atomic_set(dpamt_refcount, 1);
 	spin_unlock(&dpamt_lock);
 	return 0;
@@ -2217,17 +2230,13 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 
 	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
 
-	spin_lock(&dpamt_lock);
 	/*
 	 * If there is more than 1 reference on the DPAMT entry, don't
 	 * remove it yet. Just decrement the refcount.
 	 */
-	if (atomic_read(dpamt_refcount) > 1) {
-		atomic_dec(dpamt_refcount);
-		goto out_unlock;
-	}
+	if (!atomic_dec_and_lock(dpamt_refcount, &dpamt_lock))
+		return;
 
-	/* Try to remove the pamt page and take the refcount 1->0. */
 	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
 
 	/*
@@ -2237,10 +2246,15 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 	 * failure indicates a kernel bug, memory is being leaked, and
 	 * the dangling DPAMT entry may cause future operations to fail.
 	 */
-	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
+		/*
+		 * atomic_dec_and_lock() already decremented it to 0,
+		 * but the DPAMT entry still exists since REMOVE failed.
+		 */
+		atomic_set(dpamt_refcount, 1);
 		goto out_unlock;
+	}
 
-	atomic_set(dpamt_refcount, 0);
 	spin_unlock(&dpamt_lock);
 	free_pamt_array(pamt_pages);
 	return;
-- 
2.55.0

