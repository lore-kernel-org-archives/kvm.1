Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA4415F07
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694157; cv=none; b=MRsrvj3tMHQSzEBpZzATchLZQhlGOlBj1McNp4OAVUL8AeBGuoOYsN5wtRGvXK6CDDTYOpq3gbOxLhUyFJ/DuM25rFIb9jeT6jxSaVJ8KK9GiYPG1MlCmiqHGx/DrtQrSWYy2ZXXNq86lU/n+vVmmbY2NdFXesKvh3MwhXgamk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694157; c=relaxed/simple;
	bh=mbHZ35X9Y2fzQIg/xm4ZcmWUpIoJrOF1+2hPq68yNdk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X1YD/8wjY6+IvNMSSpveYzWaKr3yyg6g9ZPv0G17BFa6FMLfg5R0ZADOr8+ji5Um7JkkNT22V27Avz9z2BhvQyMkID6LTARVNDNuz2rHnV4ogWZjDw80duuUCRPqRglSB92fYxG+cByDkE+JiBqgwHYrdkG/6luxF583pqV5TYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OqCwvJd/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OqCwvJd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=K9g8IYs+lDULZQ4/eMg7+m7oY2J0j27XHHtyi5FkzJU=;
	b=OqCwvJd/jf68BVU/CmHbDVMgSnzJjfF+rK63GljtyK55HXjayo/gMw7Lxb9Iqy
	iq+Q/v1aMvE2nPT4CWORX8UdZWBcQQnDYxp3nItBPwyWw0rGIMnDkQjvc3Nvjxwr
	xGAe0Pp/Ya3faSgE6KhKXyNoWxwGpaBB8fDQ/jQJkyJMk=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBnAYb0yX5qr1kIPQ--.52364S2;
	Fri, 14 Aug 2026 15:55:33 +0800 (CST)
Date: Fri, 14 Aug 2026 15:55:32 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [RFC PATCH 1/1] KVM: x86: Skip empty TDP leaf page tables
Message-ID: <an7J9Gh2DTrtP5vT@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <an7JGuzynPBaYB5t@192.168.1.215>
X-CM-TRANSID:_____wBnAYb0yX5qr1kIPQ--.52364S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKrWxtryDXF43Xw1kJw4xZwb_yoW3GF17pF
	yjy395ZrWFvw47WryDAan7Ar4avr1v9F48Gry8K395A3WDtrnFgw1kJa42qF9xWr9Yqry3
	XF4qvw45ur48AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRunQbUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+RXp3Gp+yfWbxwAA3t

From: Hao Zhang <zhanghao1@kylinos.cn>

When KVM zaps only leaf SPTEs, the TDP page table hierarchy is
intentionally retained so that subsequent faults can reuse it.  However,
a later zap of the same range still descends through retained 4K leaf
page tables whose leaf SPTEs are all non-present.

Track whether a retained 4K leaf page table contains any present leaf
SPTEs.  If a zap fully covers the corresponding 2MiB range and the page
table is known to be empty, skip descending into it.

Keep the page table hierarchy linked so that it can still be reused by
future page faults.  Installing a new leaf SPTE clears the empty hint.
The hint checks are skipped for ranges smaller than a complete 2MiB leaf
page table.

The iterator restarts its walk from the root after yielding.  Allow the
restarted walk to mark an empty leaf page table again instead of
permanently excluding the page table that contained the yield.

Tested on a 4-vCPU, 1GB guest with five repetitions on the same host.
The main improvement is seen for repeated same-range invalidation; rolling
sweep workloads are mostly neutral.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
 arch/x86/kvm/mmu/mmu_internal.h |  2 ++
 arch/x86/kvm/mmu/tdp_iter.c     | 10 +++++-
 arch/x86/kvm/mmu/tdp_iter.h     |  6 ++++
 arch/x86/kvm/mmu/tdp_mmu.c      | 74 ++++++++++++++++++++++++++++++++++++-----
 4 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 73cdcbccc89e..5305aa3e688b 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -95,6 +95,8 @@ struct kvm_mmu_page {
 	};
 
 	bool has_mapped_host_mmio;
+	/* TDP MMU only: no present leaf SPTEs exist in this leaf page table. */
+	bool tdp_mmu_empty_leaf_pt;
 
 	union {
 		/* These two members aren't used for TDP MMU */
diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index 9e17bfa80901..1d87db14a6ae 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -23,6 +23,7 @@ static void tdp_iter_refresh_sptep(struct tdp_iter *iter)
 void tdp_iter_restart(struct tdp_iter *iter)
 {
 	iter->yielded = false;
+	iter->skip_child = false;
 	iter->yielded_gfn = iter->next_last_level_gfn;
 	iter->level = iter->root_level;
 
@@ -167,9 +168,11 @@ void tdp_iter_next(struct tdp_iter *iter)
 		return;
 	}
 
-	if (try_step_down(iter))
+	if (!iter->skip_child && try_step_down(iter))
 		return;
 
+	iter->skip_child = false;
+
 	do {
 		if (try_step_side(iter))
 			return;
@@ -177,3 +180,8 @@ void tdp_iter_next(struct tdp_iter *iter)
 	iter->valid = false;
 }
 
+void tdp_iter_skip_child(struct tdp_iter *iter)
+{
+	WARN_ON_ONCE(iter->yielded);
+	iter->skip_child = true;
+}
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 364c5da6c499..47ac8bd43794 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -114,6 +114,11 @@ struct tdp_iter {
 	 * level instead of advancing to the next entry.
 	 */
 	bool yielded;
+	/*
+	 * True if tdp_iter_next() should skip the child page table referenced by
+	 * the current SPTE, instead of descending into it.
+	 */
+	bool skip_child;
 };
 
 /*
@@ -139,5 +144,6 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
 		    int min_level, gfn_t next_last_level_gfn, gfn_t gfn_bits);
 void tdp_iter_next(struct tdp_iter *iter);
 void tdp_iter_restart(struct tdp_iter *iter);
+void tdp_iter_skip_child(struct tdp_iter *iter);
 
 #endif /* __KVM_X86_MMU_TDP_ITER_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c1cbae65d239..84e18bd6e777 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -238,6 +238,7 @@ static void tdp_mmu_init_sp(struct kvm_mmu_page *sp, tdp_ptep_t sptep,
 	sp->gfn = gfn;
 	sp->ptep = sptep;
 	sp->tdp_mmu_page = true;
+	sp->tdp_mmu_empty_leaf_pt = false;
 
 	trace_kvm_mmu_get_page(sp, true);
 }
@@ -527,6 +528,10 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	if (is_leaf)
 		check_spte_writable_invariants(new_spte);
 
+	if (is_leaf && !was_leaf && sp->tdp_mmu_page &&
+	    sp->role.level == PG_LEVEL_4K)
+		WRITE_ONCE(sp->tdp_mmu_empty_leaf_pt, false);
+
 	/*
 	 * The only times a SPTE should be changed from a non-present to
 	 * non-present state is when an MMIO entry is installed/modified/
@@ -923,6 +928,39 @@ bool kvm_tdp_mmu_zap_possible_nx_huge_page(struct kvm *kvm,
 	return true;
 }
 
+static bool tdp_mmu_range_covers_leaf_pt(struct tdp_iter *iter,
+					 gfn_t start, gfn_t end)
+{
+	struct kvm_mmu_page *sp;
+
+	sp = sptep_to_sp(rcu_dereference(iter->sptep));
+	return sp->gfn >= start &&
+	       sp->gfn + KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) <= end;
+}
+
+static bool tdp_mmu_can_skip_leaf_pt(struct tdp_iter *iter,
+				     gfn_t start, gfn_t end)
+{
+	struct kvm_mmu_page *child_sp;
+
+	if (iter->level != PG_LEVEL_2M ||
+	    !is_shadow_present_pte(iter->old_spte) ||
+	    is_last_spte(iter->old_spte, iter->level))
+		return false;
+
+	if (iter->gfn < start ||
+	    iter->gfn + KVM_PAGES_PER_HPAGE(PG_LEVEL_2M) > end)
+		return false;
+
+	/*
+	 * Skip retained empty 4K leaf page tables without unlinking them, so
+	 * future faults can reuse the paging structure.
+	 */
+	child_sp = spte_to_child_sp(iter->old_spte);
+	return child_sp->role.level == PG_LEVEL_4K &&
+	       READ_ONCE(child_sp->tdp_mmu_empty_leaf_pt);
+}
+
 /*
  * If can_yield is true, will release the MMU lock and reschedule if the
  * scheduler needs the CPU or there is contention on the MMU lock. If this
@@ -934,8 +972,10 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 			      gfn_t start, gfn_t end, bool can_yield, bool flush)
 {
 	struct tdp_iter iter;
+	bool may_skip_leaf_pts;
 
 	end = min(end, tdp_mmu_max_gfn_exclusive());
+	may_skip_leaf_pts = end - start >= KVM_PAGES_PER_HPAGE(PG_LEVEL_2M);
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
@@ -948,18 +988,34 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 			continue;
 		}
 
-		if (!is_shadow_present_pte(iter.old_spte) ||
-		    !is_last_spte(iter.old_spte, iter.level))
+		if (may_skip_leaf_pts &&
+		    tdp_mmu_can_skip_leaf_pt(&iter, start, end)) {
+			tdp_iter_skip_child(&iter);
 			continue;
+		}
 
-		tdp_mmu_iter_set_spte(kvm, &iter, SHADOW_NONPRESENT_VALUE);
+		if (is_shadow_present_pte(iter.old_spte) &&
+		    is_last_spte(iter.old_spte, iter.level)) {
+			tdp_mmu_iter_set_spte(kvm, &iter,
+					      SHADOW_NONPRESENT_VALUE);
 
-		/*
-		 * Zappings SPTEs in invalid roots doesn't require a TLB flush,
-		 * see kvm_tdp_mmu_zap_invalidated_roots() for details.
-		 */
-		if (!root->role.invalid)
-			flush = true;
+			/*
+			 * Zappings SPTEs in invalid roots doesn't require a TLB flush,
+			 * see kvm_tdp_mmu_zap_invalidated_roots() for details.
+			 */
+			if (!root->role.invalid)
+				flush = true;
+		}
+
+		if (may_skip_leaf_pts &&
+		    iter.level == PG_LEVEL_4K &&
+		    spte_index(rcu_dereference(iter.sptep)) == SPTE_ENT_PER_PAGE - 1 &&
+		    tdp_mmu_range_covers_leaf_pt(&iter, start, end)) {
+			struct kvm_mmu_page *sp;
+
+			sp = sptep_to_sp(rcu_dereference(iter.sptep));
+			WRITE_ONCE(sp->tdp_mmu_empty_leaf_pt, true);
+		}
 	}
 
 	rcu_read_unlock();

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.15.0

