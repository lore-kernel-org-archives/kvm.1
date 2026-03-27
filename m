Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AD3A7590;
	Fri, 27 Mar 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642480; cv=none; b=a/RzB48TvOiywzCZ/i2un0/Jp3kLGAb+VITXNsUpFGVdydwwEnutkYC42/zskwh49sPVGwFPcsavtXu9z8uq7FHhpY2XcW1+rPiuSczzB+O4qcgUQXM54SXVJp7fPlHhh+peA2EU4FzHXXgUnyLbbSlCMjWBRZvbjS+oqk6BTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642480; c=relaxed/simple;
	bh=TYJivbcKhjb/nvi/CHJdsi2LPDmaHOBx57XRPI/8FxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DIfeqskL8KGeDIwVP8jzX8GzxsYxs7wpHXt9zj4e2aKq2pPynKN50t0QdQVoVEBGvPFxRTmERiC5P3KhVcijBG9Rscs3OkXb/sFysROKtj1iZz4CbD5YWo2QZ9i9jRpLhEB6Mmq0ybWu8opbr7UZdw9bSH1jraPp7zzKx4UWmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOsdaJxu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOsdaJxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642479; x=1806178479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYJivbcKhjb/nvi/CHJdsi2LPDmaHOBx57XRPI/8FxI=;
  b=ZOsdaJxuD373osB3dWqYS26kestkv6cpWpsue2T1lmDYxlouzp6CziP9
   yS3hpYQdqIg8ofHtQ59jwUVhHN9r3kMzfDLXSXGql4J8fvKOehbRBZrAT
   Y+K7wOe/zkX0UpNIR80XEuMY1BpHbeVleMRNTZYvfc7Kj5aMtL1M6V5iD
   6gZns/uTAJKAfXvQYjW+/D0Todvx3IAaCy7GOKHVkheAziD11TAP8H37A
   9UNgvvgVtO/Em3KetW6rNb62ENePmvYMt+oUFuYr/j9Y4kMFzmx3pGIfr
   ojYYoqqiwqua/f7ZuF8I86N99sqF3eRwrSKbZMIwxoC/kPRSq85+JeHQK
   g==;
X-CSE-ConnectionGUID: lSxPk6BbR32LcH4p4FQOGQ==
X-CSE-MsgGUID: MhYCCz0TR5KKyK6GEZ8CNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182762"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182762"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: UHdMoRA3TMGfvACAK4rYiA==
X-CSE-MsgGUID: t9z75IxZRlm0NzkgwmgGMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922938"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 17/17] KVM: TDX: Move external page table freeing to TDX code
Date: Fri, 27 Mar 2026 13:14:21 -0700
Message-ID: <20260327201421.2824383-18-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Move the freeing of external page tables into the reclaim operation that
lives in TDX code.

The TDP MMU supports traversing the TDP without holding locks. Page
tables needs to be freed via RCU to prevent walking one that gets
freed.

While none of these lockless walk operations actually happen for the
mirror EPT, the TDP MMU none-the-less frees the mirror EPT page tables in
the same way, and because it’s a handy place to plug it in, the external
page tables as well.

However, the external page tables definitely can’t be walked once they are
reclaimed from the TDX module. The TDX module releases the page for the
host VMM to use, so this RCU-time free is unnecessary for external page
tables.

So move the free_page() call to TDX code. Create an
tdp_mmu_free_unused_sp() to allow for freeing external page tables that
have never left the TDP MMU code (i.e. don’t need freed in a special way.

Link: https://lore.kernel.org/kvm/aYpjNrtGmogNzqwT@google.com/
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Based on a diff by Sean, added log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 16 +++++++++++-----
 arch/x86/kvm/vmx/tdx.c     | 11 ++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 575033cc7fe4..18e11c1c7631 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -53,13 +53,18 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	rcu_barrier();
 }
 
-static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
+static void __tdp_mmu_free_sp(struct kvm_mmu_page *sp)
 {
-	free_page((unsigned long)sp->external_spt);
 	free_page((unsigned long)sp->spt);
 	kmem_cache_free(mmu_page_header_cache, sp);
 }
 
+static void tdp_mmu_free_unused_sp(struct kvm_mmu_page *sp)
+{
+	free_page((unsigned long)sp->external_spt);
+	__tdp_mmu_free_sp(sp);
+}
+
 /*
  * This is called through call_rcu in order to free TDP page table memory
  * safely with respect to other kernel threads that may be operating on
@@ -73,7 +78,8 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
 	struct kvm_mmu_page *sp = container_of(head, struct kvm_mmu_page,
 					       rcu_head);
 
-	tdp_mmu_free_sp(sp);
+	WARN_ON_ONCE(sp->external_spt);
+	__tdp_mmu_free_sp(sp);
 }
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
@@ -1261,7 +1267,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * failed, e.g. because a different task modified the SPTE.
 		 */
 		if (r) {
-			tdp_mmu_free_sp(sp);
+			tdp_mmu_free_unused_sp(sp);
 			goto retry;
 		}
 
@@ -1571,7 +1577,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 	 * installs its own sp in place of the last sp we tried to split.
 	 */
 	if (sp)
-		tdp_mmu_free_sp(sp);
+		tdp_mmu_free_unused_sp(sp);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d064b40a6b31..1346e891ca94 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1782,7 +1782,16 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 	 */
 	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
 	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
-		sp->external_spt = NULL;
+		goto out;
+
+	/*
+	 * Immediately free the S-EPT page as the TDX subsystem doesn't support
+	 * freeing pages from RCU callbacks, and more importantly because
+	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding readers.
+	 */
+	free_page((unsigned long)sp->external_spt);
+out:
+	sp->external_spt = NULL;
 }
 
 static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-- 
2.53.0

