Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413141;
	b=T8ByngYLiwUhHFKvrxFRwLe5B3Vfrchrcexu2stdHCM2K+nKGteaqJTDFs/fcq55Z2NI
	 Nr3UI7UpXdGMyDy4pBrDgdDwfanmlO7gZohhTHaU+MyAJeoNO1X74j010ocbjP7M04b7t
	 fTggCzZVLAMd7lz39QxFaYntmzgN5CtvVNuWeNxS27OPWAlvZpf11Uy6mxvVSfIlSVG7d
	 cpoJK3U2f4Ek31DI+qMjNXwiy2aHnB4NDktVEO9E8XN+3sSI5OgAkkCSl/s96piHCA4fU
	 B5cNV8RRCUxG18AFT4PIZikyXWs3OBA1/93gQLySDN5suNFchMDdNH8YzRY/4quT8Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413141;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=PEpLyYGaW8XTvipr4v9SRAOm8z54JI15yo3XGY9QH44=;
	b=Woz7NKoP6G1mRqqRrHhiFkqsKxQ48P+4dTDjlHhVRJfHXvQ63mk1U0GemD10t5K19j3R
	 zaIi4Ym54UcsCkNJpvHSTF30Jc5fDwrilp2RoQplAp84AYXcB3JQT832UVeaWJoTPsLV0
	 yKjUwvTpRcxeV233O5Oa/zFmT2XYviwglQvM9sD5raKyhQDQLImZH33abxQBtsQ2WW3Jj
	 SIv41+QXWZbde081EoDkJ5bNEHcB+B4RUT0Th+I4aeVXXQHAhqEuDDd9jstOwr/+p6tWG
	 Q8ZnfFvpRamMj+FH2jVJ+EqUWFClYdj7qALONZEjdoEatcgikmuEjGdF4NrQnWUwj3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LQkGug8+;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2F606A31F;
	Mon, 23 Nov 2026 05:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4C2F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LQkGug8+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=PE
	pLyYGaW8XTvipr4v9SRAOm8z54JI15yo3XGY9QH44=; b=LQkGug8+0JPFJAMCan
	TIARoMeKaZ3kaT0JrlPmJRQ6jxXC2IYxMnOSYwtZzNzs7XL1PhFwYFbfJOpsgWgs
	wSqYrDti7yVcitB9goa/28sBKjRYYW/JG1X5i4Tgus6DvVMfIDJmpT90XeVNIZUk
	f/MpNvJmSqUmk3O64BPGq7DJg=
Received: from leoqi-System-Product-Name.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD33xEs1ANrqn5EKQ--.4784S2;
	Mon, 23 Nov 2026 13:50:45 +0800 (CST)
From: Can Qi <qican5708@163.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: riscv: Allow rescheduling during G-stage unmap
Date: Mon, 23 Nov 2026 13:50:36 +0800
Message-Id: <20261123055036.1554937-1-qican5708@163.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33xEs1ANrqn5EKQ--.4784S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJF17CF1fKF4xurWxGr48Zwb_yoW8GF1DJo
	W0va1rWF48ury0yFy8Aw17tFyjqrW0krZxXF15XFWYqryjq348uryjkrZ8Ja47Wr1UuFyf
	ZFWfXr17XF18G3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUoKZXDUUUU
X-CM-SenderInfo: ptlft0avxqmqqrwthudrp/xtbCzhXdm2sD1DV4kgAA3+

Removing a populated memslot or destroying a VM can require walking a
large G-stage range while holding mmu_lock. Let these callers use the
existing write-lock reschedule helper to bound the time spent holding
the lock continuously.

Snapshot the shared root under mmu_lock and stop the walk if the root
has been detached while the lock was dropped. Flush pending batches
before yielding so a concurrent invalidation cannot miss PTEs cleared
by the current walker. Finish memslot invalidation under the write
lock and synchronize the VM before releasing a detached root.

Free the VM-owned split-page cache in kvm_arch_destroy_vm(), after
notifier callbacks have completed. Notifier release can be invoked
by both address-space teardown and notifier unregister.

Validated with RISC-V KVM selftests in QEMU TCG, including MMU stress
with two vCPUs, KASAN and lockdep runs, and traces of rescheduling and
remote TLB request handling.

Codex assisted with implementation and validation. Sashiko identified
the pending-flush ordering concern in an earlier revision.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Can Qi <qican5708@163.com>
---
 arch/riscv/include/asm/kvm_gstage.h | 10 ++-
 arch/riscv/kvm/gstage.c             | 29 +++++++--
 arch/riscv/kvm/mmu.c                | 95 ++++++++++++++---------------
 arch/riscv/kvm/vm.c                 |  3 +
 4 files changed, 83 insertions(+), 54 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1..0df2c2a54 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -104,13 +104,21 @@ static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_levels)
 	}
 }
 
-static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *kvm)
+/* The caller must hold mmu_lock while accessing the shared page tables. */
+static inline bool kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *kvm)
 {
+	lockdep_assert_held(&kvm->mmu_lock);
+
+	if (!kvm->arch.pgd)
+		return false;
+
 	gstage->kvm = kvm;
 	gstage->flags = 0;
 	gstage->vmid = READ_ONCE(kvm->arch.vmid.vmid);
 	gstage->pgd = kvm->arch.pgd;
 	gstage->pgd_levels = kvm->arch.pgd_levels;
+
+	return true;
 }
 
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index be70607a3..ea7a156ec 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -423,9 +423,20 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 	bool found_leaf;
 	unsigned long page_size;
 	gpa_t addr = start, end = start + size;
+	gfn_t last_flush_gfn = start >> PAGE_SHIFT;
 	bool flush = false;
+	bool pending_flush = false;
+
+	if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL))
+		lockdep_assert_held_write(&gstage->kvm->mmu_lock);
 
 	while (addr < end) {
+		/* A concurrent teardown may have freed the root while unlocked. */
+		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) &&
+		    (!gstage->kvm->arch.pgd ||
+		     gstage->pgd != gstage->kvm->arch.pgd))
+			break;
+
 		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
 		ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
 		if (ret)
@@ -434,10 +445,11 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 		if (!found_leaf) {
 			addr = ALIGN(addr + 1, page_size);
 		} else {
-			if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
-				flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+			if (!(addr & (page_size - 1)) && ((end - addr) >= page_size)) {
+				pending_flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
 								 ptep_level, GSTAGE_OP_CLEAR);
-			else {
+				flush |= pending_flush;
+			} else {
 				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %#lx\n",
 						addr, end, page_size);
 			}
@@ -448,9 +460,18 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 		/*
 		 * If the range is too large, release the kvm->mmu_lock
 		 * to prevent starvation and lockup detector warnings.
+		 * Flush first so another invalidator cannot miss cleared PTEs.
 		 */
-		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < end)
+		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < end &&
+		    (need_resched() || rwlock_needbreak(&gstage->kvm->mmu_lock))) {
+			if (pending_flush) {
+				kvm_flush_remote_tlbs_range(gstage->kvm, last_flush_gfn,
+							    (addr >> PAGE_SHIFT) - last_flush_gfn);
+				pending_flush = false;
+			}
+			last_flush_gfn = addr >> PAGE_SHIFT;
 			cond_resched_rwlock_write(&gstage->kvm->mmu_lock);
+		}
 	}
 
 	return flush;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 738d9ee1e..0d0ab1127 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -26,12 +26,11 @@ static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
 	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
-	bool flush;
-
-	kvm_riscv_gstage_init(&gstage, kvm);
+	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
-	flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
+	if (kvm_riscv_gstage_init(&gstage, kvm))
+		flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
 	write_unlock(&kvm->mmu_lock);
 	if (flush)
 		kvm_flush_remote_tlbs_memslot(kvm, memslot);
@@ -44,7 +43,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	pgprot_t prot;
 	unsigned long pfn;
 	phys_addr_t addr, end;
-	unsigned long pgd_levels = kvm->arch.pgd_levels;
+	unsigned long pgd_levels = kvm_riscv_gstage_max_pgd_levels;
 	struct kvm_mmu_memory_cache pcache = {
 		.gfp_custom = (in_atomic) ? GFP_ATOMIC | __GFP_ACCOUNT : 0,
 		.gfp_zero = __GFP_ZERO,
@@ -52,8 +51,6 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	struct kvm_gstage_mapping map;
 	struct kvm_gstage gstage;
 
-	kvm_riscv_gstage_init(&gstage, kvm);
-
 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(hpa);
 	prot = pgprot_noncached(PAGE_WRITE);
@@ -72,7 +69,10 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 			goto out;
 
 		write_lock(&kvm->mmu_lock);
-		ret = kvm_riscv_gstage_set_pte(&gstage, &pcache, &map);
+		if (kvm_riscv_gstage_init(&gstage, kvm))
+			ret = kvm_riscv_gstage_set_pte(&gstage, &pcache, &map);
+		else
+			ret = -EFAULT;
 		write_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
@@ -88,12 +88,11 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
 {
 	struct kvm_gstage gstage;
-	bool flush;
-
-	kvm_riscv_gstage_init(&gstage, kvm);
+	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
-	flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
+	if (kvm_riscv_gstage_init(&gstage, kvm))
+		flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
 	write_unlock(&kvm->mmu_lock);
 
 	if (flush)
@@ -146,7 +145,7 @@ static bool mmu_split_huge_pages(struct kvm_gstage *gstage,
 			write_lock(&kvm->mmu_lock);
 		}
 
-		if (!kvm->arch.pgd)
+		if (!kvm->arch.pgd || gstage->pgd != kvm->arch.pgd)
 			return flush;
 
 		flush |= kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, false);
@@ -167,7 +166,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	kvm_riscv_gstage_init(&gstage, kvm);
+	if (!kvm_riscv_gstage_init(&gstage, kvm))
+		return;
 
 	kvm_riscv_gstage_wp_pt_masked(&gstage, base_gfn, mask);
 
@@ -205,16 +205,15 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	gpa_t gpa = slot->base_gfn << PAGE_SHIFT;
 	phys_addr_t size = slot->npages << PAGE_SHIFT;
 	struct kvm_gstage gstage;
-	bool flush;
-
-	kvm_riscv_gstage_init(&gstage, kvm);
+	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
-	flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
-	write_unlock(&kvm->mmu_lock);
+	if (kvm_riscv_gstage_init(&gstage, kvm))
+		flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, true);
 	if (flush)
 		kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT,
 					    size >> PAGE_SHIFT);
+	write_unlock(&kvm->mmu_lock);
 }
 
 static void mmu_split_memory_region(struct kvm *kvm, int slot)
@@ -224,12 +223,11 @@ static void mmu_split_memory_region(struct kvm *kvm, int slot)
 	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
 	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
-	bool flush;
-
-	kvm_riscv_gstage_init(&gstage, kvm);
+	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
-	flush = mmu_split_huge_pages(&gstage, start, end);
+	if (kvm_riscv_gstage_init(&gstage, kvm))
+		flush = mmu_split_huge_pages(&gstage, start, end);
 	write_unlock(&kvm->mmu_lock);
 
 	if (flush)
@@ -334,12 +332,10 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	struct kvm_gstage gstage;
 	bool flush;
 
-	if (!kvm->arch.pgd)
-		return false;
-
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	kvm_riscv_gstage_init(&gstage, kvm);
+	if (!kvm_riscv_gstage_init(&gstage, kvm))
+		return false;
 	flush = kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
 					     (range->end - range->start) << PAGE_SHIFT,
 					     range->may_block);
@@ -356,12 +352,11 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	if (!kvm->arch.pgd)
+	if (!kvm_riscv_gstage_init(&gstage, kvm))
 		return false;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
 
-	kvm_riscv_gstage_init(&gstage, kvm);
 	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
 				       &ptep, &ptep_level))
 		return false;
@@ -376,12 +371,11 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	u64 size = (range->end - range->start) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	if (!kvm->arch.pgd)
+	if (!kvm_riscv_gstage_init(&gstage, kvm))
 		return false;
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
 
-	kvm_riscv_gstage_init(&gstage, kvm);
 	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
 				       &ptep, &ptep_level))
 		return false;
@@ -563,12 +557,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
 	bool dirty_marked = false;
 	bool ret;
 
-	kvm_riscv_gstage_init(&gstage, kvm);
 	mmu_seq = kvm->mmu_invalidate_seq;
 
 	read_lock(&kvm->mmu_lock);
 
-	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
+	if (!kvm_riscv_gstage_init(&gstage, kvm) ||
+	    mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
 		ret = false;
 		goto out_unlock;
 	}
@@ -640,8 +634,6 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	struct kvm_gstage gstage;
 	struct page *page;
 
-	kvm_riscv_gstage_init(&gstage, kvm);
-
 	/* Setup initial state of output mapping */
 	memset(out_map, 0, sizeof(*out_map));
 
@@ -649,8 +641,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	    kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map))
 		return 0;
 
-	/* We need minimum second+third level pages */
-	ret = kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
+	/* Size the cache before acquiring the shared root under mmu_lock. */
+	ret = kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_max_pgd_levels);
 	if (ret) {
 		kvm_err("Failed to topup G-stage cache\n");
 		return ret;
@@ -722,6 +714,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 	write_lock(&kvm->mmu_lock);
 
+	if (!kvm_riscv_gstage_init(&gstage, kvm)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
 	if (mmu_invalidate_retry(kvm, mmu_seq)) {
 		unused = true;
 		goto out_unlock;
@@ -829,24 +826,24 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 	bool flush = false;
 
 	write_lock(&kvm->mmu_lock);
-	if (kvm->arch.pgd) {
-		kvm_riscv_gstage_init(&gstage, kvm);
+	if (kvm_riscv_gstage_init(&gstage, kvm)) {
 		flush = kvm_riscv_gstage_unmap_range(&gstage, 0UL,
-			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
-		pgd = READ_ONCE(kvm->arch.pgd);
-		kvm->arch.pgd = NULL;
-		kvm->arch.pgd_phys = 0;
-		kvm->arch.pgd_levels = 0;
+			kvm_riscv_gstage_gpa_size(gstage.pgd_levels), true);
+		/* Only the caller that still owns the root may detach it. */
+		if (gstage.pgd == kvm->arch.pgd) {
+			pgd = kvm->arch.pgd;
+			kvm->arch.pgd = NULL;
+			kvm->arch.pgd_phys = 0;
+			kvm->arch.pgd_levels = 0;
+		}
 	}
-	write_unlock(&kvm->mmu_lock);
-
-	if (flush)
+	/* Synchronize before another invalidator can observe the detached root. */
+	if (flush || pgd)
 		kvm_flush_remote_tlbs(kvm);
+	write_unlock(&kvm->mmu_lock);
 
 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
-
-	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
 
 void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index 58500a19b..7d467b0c5 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -54,6 +54,9 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);
 
 	kvm_riscv_aia_destroy_vm(kvm);
+
+	/* MMU notifier callbacks have finished before VM destruction. */
+	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
 
 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.34.1

