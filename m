Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F6D39A078;
	Mon, 31 Aug 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212239; cv=none; b=NbteSpqFnwoQ58al8OtmGc7Vjo/3szCONLTBI77e9+rh8knlQVf/d6u3ccjFQUI9jhC8XMcXDg3QVc8fbz/ol0X+0iGRipcyMmGV2ujg/5gxxWS5GjL/nK3loBrPJ/bhW/nPGS6dt/ellSuh1LpQ1d7wEqPQyLYXALfB3LSaLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212239; c=relaxed/simple;
	bh=mIoSbXsgmV0UfJV0KMv5aYsVqiZtmxH7/v8TpoBpVrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvuYpUbwgNBJz1QAOW/yUDMHNcXnx9qUsfHalXX1WikyCM1fq+dGGj3tZMtw67qi04zGUiU2myVjxsxQp4YC3jxgp0KKqqAqFKN4dkKMal+s2iQW5z3iqdR+CGYmZ/BwKtedX91wrKbIixSf40eJD4QXdC9taW6jTwYY7vIWU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aRqhzwxt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aRqhzwxt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2aE8PktB4XRPnNZDvEsBwnr9d906dfIxeEgOUFvgdtg=; b=aRqhzwxtrajXjeXLqOfTIRY9UP
	wz6ZWIRaOcr3FzUKvAxjBuiv3oXz0uG1jPzi3/cVmgPDAo39aJYsICx6Vctqq3NkVBWXy6CJhDnsg
	Sdr6w2a3tEigURB1CrI9TkEreVvqNrB00GYevWZg9/gRgPRoUCRp+h9XIVwXdulEhDJVDzIQcLfOb
	NyKTzCGAgDHLeRiAN/FKZ5EttdEaz+O1ERQXxaQFZJ0vKrhaR1pY3i2EUPHgWg8w8MwMxsgynf5bK
	kUAHvW6oIc9DvXKijKmz4ltN2yodRNrwlYX0gXZYjqs98nBkGpIS+uK1rv5lddHi+16joaDsd1hiE
	WSrBazwA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x19gE-00000003svA-3BmA;
	Mon, 31 Aug 2026 21:36:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LDO-2N8N;
	Mon, 31 Aug 2026 22:36:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 12/13] KVM: pfncache: use a dedicated invalidation sequence for cache refresh
Date: Mon, 31 Aug 2026 22:26:43 +0100
Message-ID: <20260831213632.81023-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The gfn_to_pfn_cache refresh path guards against mmu notifier
invalidations which complete while it has dropped gpc->lock for the
HVA->PFN lookup: hva_to_pfn_retry() samples kvm->mmu_invalidate_seq
and retries if it changed, or if mn_active_invalidate_count is still
elevated.

That is insufficient for HVA-based caches. mmu_invalidate_seq is only
advanced by kvm_mmu_invalidate_end() when the invalidated range
overlaps a memslot, and an HVA-based cache (e.g. the Xen shared_info
page mapped with KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA) need not be backed
by any memslot at all. An invalidation of the cached HVA which starts
and ends entirely within the lookup window is thus invisible to the
retry check: mn_active_invalidate_count is back to zero and the
sequence never moved. The refresh then publishes a mapping of a page
which has already been freed, and the next reader dereferences it:

  BUG: KASAN: use-after-free in kvm_xen_shared_info_init+0x3c6/0x440
  Read of size 4 at addr ffff8880599c2900 by task syz.2.383/7257

Since gfn_to_pfn_cache_invalidate_start() deliberately skips caches
which are not currently valid (including one whose refresh is in
progress, as the refresh clears the valid flag before dropping the
lock), the retry check is the only line of defence, and it must fire
for *any* invalidation, not just those hitting a memslot.

Add a dedicated kvm->gpc_invalidate_seq, incremented by every
kvm_mmu_notifier_invalidate_range_end() under mn_invalidate_lock
before mn_active_invalidate_count is decremented, and check it in
hva_to_pfn_retry() instead of mmu_invalidate_seq. Incrementing in
range_end() in the same critical section as the in-progress count
also closes the variant where the cache is activated with the
contested HVA only after invalidate_range_start() has run.

The same bug is also reachable through the per-vCPU vcpu_info cache
(KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA), where the stale mapping is
then dereferenced by kvm_setup_guest_pvclock() on the next KVM_RUN:

  BUG: KASAN: use-after-free in kvm_setup_guest_pvclock+0x5bf/0x660

This intentionally makes refresh retry on *unrelated* mmu notifier
events; restoring precision (and reworking the GPC locking more
generally) is left for a subsequent series.

Reproducers: https://david.woodhou.se/xen_shinfo_race.c
             https://david.woodhou.se/vcpu_info_race.c

Suggested-by: Sean Christopherson <seanjc@google.com>
Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com/
Tested-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Reported-by: syzbot+fb7c2dd166d3ea63df2a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a426dd2.854d4ab9.360e1d.0008.GAE@google.com/
Fixes: b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
Cc: stable@vger.kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 10 ++++++++++
 virt/kvm/pfncache.c      | 18 +++++++++---------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 03bfc92864b6..3dd04605f2e5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -855,6 +855,8 @@ struct kvm {
 	gfn_t mmu_invalidate_range_start;
 	gfn_t mmu_invalidate_range_end;
 
+	unsigned long gpc_invalidate_seq;
+
 	struct list_head devices;
 	u64 manual_dirty_log_protect;
 	struct dentry *debugfs_dentry;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65eb26a0520d..108d42c5c1d6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -813,6 +813,16 @@ static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
 
 	/* Pairs with the increment in range_start(). */
 	spin_lock(&kvm->mn_invalidate_lock);
+	kvm->gpc_invalidate_seq++;
+
+	/*
+	 * As with the MMU sequence counter and mmu_invalidate_in_progress, the
+	 * GPC sequence increase must be visible before the invalidate count
+	 * goes to zero.  Pairs with the smp_rmb() in
+	 * mmu_notifier_retry_cache().
+	 */
+	smp_wmb();
+
 	if (!WARN_ON_ONCE(!kvm->mn_active_invalidate_count))
 		--kvm->mn_active_invalidate_count;
 	wake = !kvm->mn_active_invalidate_count;
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 728d2c1b488a..3659686b97c2 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -124,7 +124,7 @@ static void gpc_unmap(kvm_pfn_t pfn, void *khva)
 #endif
 }
 
-static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_seq)
+static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long gpc_seq)
 {
 	/*
 	 * mn_active_invalidate_count acts for all intents and purposes
@@ -136,20 +136,20 @@ static inline bool mmu_notifier_retry_cache(struct kvm *kvm, unsigned long mmu_s
 	 * Note, it does not matter that mn_active_invalidate_count
 	 * is not protected by gpc->lock.  It is guaranteed to
 	 * be elevated before the mmu_notifier acquires gpc->lock, and
-	 * isn't dropped until after mmu_invalidate_seq is updated.
+	 * isn't dropped until after gpc_invalidate_seq is updated.
 	 */
 	if (kvm->mn_active_invalidate_count)
 		return true;
 
 	/*
 	 * Ensure mn_active_invalidate_count is read before
-	 * mmu_invalidate_seq.  This pairs with the smp_wmb() in
-	 * mmu_notifier_invalidate_range_end() to guarantee either the
+	 * gpc_invalidate_seq.  This pairs with the smp_wmb() in
+	 * kvm_mmu_notifier_invalidate_range_end() to guarantee either the
 	 * old (non-zero) value of mn_active_invalidate_count or the
-	 * new (incremented) value of mmu_invalidate_seq is observed.
+	 * new (incremented) value of gpc_invalidate_seq is observed.
 	 */
 	smp_rmb();
-	return kvm->mmu_invalidate_seq != mmu_seq;
+	return kvm->gpc_invalidate_seq != gpc_seq;
 }
 
 static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
@@ -158,7 +158,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	void *old_khva = (void *)PAGE_ALIGN_DOWN((uintptr_t)gpc->khva);
 	kvm_pfn_t new_pfn = KVM_PFN_ERR_FAULT;
 	void *new_khva = NULL;
-	unsigned long mmu_seq;
+	unsigned long gpc_seq;
 	struct page *page;
 
 	struct kvm_follow_pfn kfp = {
@@ -181,7 +181,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 	gpc->valid = false;
 
 	do {
-		mmu_seq = gpc->kvm->mmu_invalidate_seq;
+		gpc_seq = gpc->kvm->gpc_invalidate_seq;
 		smp_rmb();
 
 		write_unlock_irq(&gpc->lock);
@@ -232,7 +232,7 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn_cache *gpc)
 		 * attempting to refresh.
 		 */
 		WARN_ON_ONCE(gpc->valid);
-	} while (mmu_notifier_retry_cache(gpc->kvm, mmu_seq));
+	} while (mmu_notifier_retry_cache(gpc->kvm, gpc_seq));
 
 	gpc->valid = true;
 	gpc->pfn = new_pfn;
-- 
2.55.0

