Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B943DE448
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169838; cv=none; b=BFIVxTTNX2teWvyLQKKAu8ljanJo51p4/KIEIqtVO04Bc5tGRDxahO+whk7Ag1F9Yb0xS3GrB23cRgU3Bf/XGwQEHemgAiVjXsRaNSr3h9Yt/F/isrVfjmucQTKKPCih3zWsyYWhxrtyXBhgfWVBz5HEMzo3jL75HGOZ2LEtZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169838; c=relaxed/simple;
	bh=6iqRS8NrkRxUEAo9Fy6sF38iwf00Gdcf5Zv761u3V0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P1jvxIiUSfb8BF4G8RbIwG0IRd43Hig4o5+OBVGQS2+zs5k0wczizKQx3awhm0S2zURsY71jxmXicRrxkTifYgJRM0rR7x0nNRWrVlFUbPB7EuN9+3EPkUTMVhHGENE2WzVz/rt344kswc0r7PSlUshwZv9yNYsbMatNiJ9ZA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bUuYQWL/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bUuYQWL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0xfRL2t6JZRX1O04TLg/PYuth66Qab2+IwifkRuSGu0=;
	b=bUuYQWL/c6Onr2swck03kCs4zfCVdJjBFp21msxL1m3NcmvoLOhXBp2DvHWDUH
	J8HQUPPm0HldqqKpt5yw5sAi3ujd5JDXlH4t16WA+vRBo8owYTa7t6REsFyfevY3
	WoAXkY1TysumnOQjJE24pEQe6RHcdptJAcKGxZXcdYPTg=
Received: from localhost (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAHX69YTpVqPz62PA--.24208S2;
	Mon, 31 Aug 2026 17:50:16 +0800 (CST)
Date: Mon, 31 Aug 2026 17:50:15 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [RFC PATCH v2 1/1] KVM: x86/mmu: Zap empty TDP leaf page tables
Message-ID: <apVOV56MX4p4anIM@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apVNXQMRsW8So53i@192.168.1.215>
X-CM-TRANSID:PygvCgAHX69YTpVqPz62PA--.24208S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WryrCry8tr4UKF1fWF1rWFg_yoW3AFW8pF
	y7ta9IyrWFvw47Wr1rAa1kCw4avw409F48J34rK3yrA3WDtr1vg3W8Ja4SqF98WrySqrWa
	qw4qywn8urW7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRJPEDUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+RipnGqVTlg2WQAA3S

From: Hao Zhang <zhanghao1@kylinos.cn>

KVM's TDP MMU intentionally zaps only leaf SPTEs for some invalidations,
leaving the page table hierarchy intact so that subsequent faults can reuse
the existing shadow pages.

That behavior can be pathological if a later invalidation covers a range
whose retained 4K leaf tables contain only non-present SPTEs.  KVM still
descends into every retained leaf page table and scans all 512 entries even
though there is nothing left to zap.

Add an opt-in TDP iterator event that reports when the walk has finished a
child page table, and use that event in tdp_mmu_zap_leafs() to unlink empty
4K leaf page tables that are fully covered by the zap.

Do not unlink a leaf page table that had a leaf SPTE zapped in the current
pass.  Doing so would add allocation/free churn for rolling invalidation
workloads that refault the same page table.

Because unlinking a shadow page changes the old leaf-only RCU assumption,
flush any pending remote TLBs before dropping RCU protection if a shadow
page was removed.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/mmu/tdp_iter.c | 29 +++++++++++++--
 arch/x86/kvm/mmu/tdp_iter.h | 10 ++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 88 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 109 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 9e17bfa80901..d9be4298410d 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -132,7 +132,8 @@ static bool try_step_side(struct tdp_iter *iter)
  * can continue from the next entry in the parent page table. Returns true on a
  * successful step up, false if already in the root page.
  */
-static bool try_step_up(struct tdp_iter *iter)
+static bool try_step_up(struct tdp_iter *iter,
+			struct tdp_iter_child_event *event)
 {
 	if (iter->level == iter->root_level)
 		return false;
@@ -141,6 +142,14 @@ static bool try_step_up(struct tdp_iter *iter)
 	iter->gfn = gfn_round_for_level(iter->gfn, iter->level);
 	tdp_iter_refresh_sptep(iter);
 
+	if (event && !event->valid) {
+		event->sptep = iter->sptep;
+		event->old_spte = iter->old_spte;
+		event->gfn = iter->gfn;
+		event->level = iter->level;
+		event->valid = true;
+	}
+
 	return true;
 }
 
@@ -160,8 +169,12 @@ static bool try_step_up(struct tdp_iter *iter)
  *    SPTE will have already been visited, and so the iterator must also step
  *    to the side again.
  */
-void tdp_iter_next(struct tdp_iter *iter)
+static void __tdp_iter_next(struct tdp_iter *iter,
+			    struct tdp_iter_child_event *event)
 {
+	if (event)
+		event->valid = false;
+
 	if (iter->yielded) {
 		tdp_iter_restart(iter);
 		return;
@@ -173,7 +186,17 @@ void tdp_iter_next(struct tdp_iter *iter)
 	do {
 		if (try_step_side(iter))
 			return;
-	} while (try_step_up(iter));
+	} while (try_step_up(iter, event));
 	iter->valid = false;
 }
 
+void tdp_iter_next(struct tdp_iter *iter)
+{
+	__tdp_iter_next(iter, NULL);
+}
+
+void tdp_iter_next_post_order(struct tdp_iter *iter,
+			      struct tdp_iter_child_event *event)
+{
+	__tdp_iter_next(iter, event);
+}
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index f898d8d0d93c..b7e2605fbf9e 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -123,6 +123,14 @@ struct tdp_iter {
 	bool yielded;
 };
 
+struct tdp_iter_child_event {
+	tdp_ptep_t sptep;
+	u64 old_spte;
+	gfn_t gfn;
+	int level;
+	bool valid;
+};
+
 /*
  * Iterates over every SPTE mapping the GFN range [start, end) in a
  * preorder traversal.
@@ -145,6 +153,8 @@ tdp_ptep_t spte_to_child_pt(u64 pte, int level);
 void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
 		    int min_level, gfn_t next_last_level_gfn, gfn_t gfn_bits);
 void tdp_iter_next(struct tdp_iter *iter);
+void tdp_iter_next_post_order(struct tdp_iter *iter,
+			      struct tdp_iter_child_event *event);
 void tdp_iter_restart(struct tdp_iter *iter);
 
 #endif /* __KVM_X86_MMU_TDP_ITER_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..82446c4737f7 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -923,6 +923,38 @@ bool kvm_tdp_mmu_zap_possible_nx_huge_page(struct kvm *kvm,
 	return true;
 }
 
+static bool tdp_mmu_zap_completed_empty_leaf_pt(struct kvm *kvm,
+						struct tdp_iter_child_event *event,
+						gfn_t start, gfn_t end,
+						tdp_ptep_t zapped_leaf_pt)
+{
+	struct kvm_mmu_page *child_sp;
+
+	if (event->level != PG_LEVEL_2M ||
+	    !is_shadow_present_pte(event->old_spte) ||
+	    is_last_spte(event->old_spte, event->level))
+		return false;
+
+	if (event->gfn < start ||
+	    event->gfn + KVM_PAGES_PER_HPAGE(event->level) > end)
+		return false;
+
+	/* Leave productive leaf tables in place to avoid refault churn. */
+	if (zapped_leaf_pt == event->sptep)
+		return false;
+
+	child_sp = spte_to_child_sp(event->old_spte);
+	if (is_mirror_sp(child_sp))
+		return false;
+
+	if (child_sp->role.level != PG_LEVEL_4K)
+		return false;
+
+	tdp_mmu_set_spte(kvm, event->sptep, event->old_spte,
+			 SHADOW_NONPRESENT_VALUE, event->gfn, event->level);
+	return true;
+}
+
 /*
  * If can_yield is true, will release the MMU lock and reschedule if the
  * scheduler needs the CPU or there is contention on the MMU lock. If this
@@ -933,7 +965,10 @@ bool kvm_tdp_mmu_zap_possible_nx_huge_page(struct kvm *kvm,
 static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 			      gfn_t start, gfn_t end, bool can_yield, bool flush)
 {
+	struct tdp_iter_child_event event = {};
 	struct tdp_iter iter;
+	tdp_ptep_t zapped_leaf_pt = NULL;
+	bool removed_sp = false;
 
 	end = min(end, tdp_mmu_max_gfn_exclusive());
 
@@ -941,33 +976,56 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 
 	rcu_read_lock();
 
-	for_each_tdp_pte_min_level(iter, kvm, root, PG_LEVEL_4K, start, end) {
+	tdp_iter_start(&iter, root, PG_LEVEL_4K, start,
+		       kvm_gfn_root_bits(kvm, root));
+	while (iter.valid && iter.gfn < end) {
 		if (can_yield &&
 		    tdp_mmu_iter_cond_resched(kvm, &iter, flush, false)) {
 			flush = false;
+			tdp_iter_next(&iter);
 			continue;
 		}
 
-		if (!is_shadow_present_pte(iter.old_spte) ||
-		    !is_last_spte(iter.old_spte, iter.level))
-			continue;
+		if (is_shadow_present_pte(iter.old_spte) &&
+		    is_last_spte(iter.old_spte, iter.level)) {
+			if (iter.level == PG_LEVEL_4K) {
+				struct kvm_mmu_page *sp;
 
-		tdp_mmu_iter_set_spte(kvm, &iter, SHADOW_NONPRESENT_VALUE);
+				sp = sptep_to_sp(rcu_dereference(iter.sptep));
+				zapped_leaf_pt = sp->ptep;
+			}
 
-		/*
-		 * Zappings SPTEs in invalid roots doesn't require a TLB flush,
-		 * see kvm_tdp_mmu_zap_invalidated_roots() for details.
-		 */
-		if (!root->role.invalid)
-			flush = true;
-	}
+			tdp_mmu_iter_set_spte(kvm, &iter,
+					      SHADOW_NONPRESENT_VALUE);
 
-	rcu_read_unlock();
+			/*
+			 * Zappings SPTEs in invalid roots doesn't require a TLB flush,
+			 * see kvm_tdp_mmu_zap_invalidated_roots() for details.
+			 */
+			if (!root->role.invalid)
+				flush = true;
+		}
+
+		tdp_iter_next_post_order(&iter, &event);
+		if (event.valid &&
+		    tdp_mmu_zap_completed_empty_leaf_pt(kvm, &event, start,
+							end, zapped_leaf_pt)) {
+			if (!root->role.invalid)
+				flush = true;
+			removed_sp = true;
+		}
+	}
 
 	/*
-	 * Because this flow zaps _only_ leaf SPTEs, the caller doesn't need
-	 * to provide RCU protection as no 'struct kvm_mmu_page' will be freed.
+	 * If any shadow pages were removed, service pending TLB flushes before
+	 * dropping RCU protection, as required by the TDP MMU iterator.
 	 */
+	if (removed_sp && flush) {
+		kvm_flush_remote_tlbs(kvm);
+		flush = false;
+	}
+
+	rcu_read_unlock();
 	return flush;
 }
 
-- 
2.15.0

