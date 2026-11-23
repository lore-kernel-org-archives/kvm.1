Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795419068;
	b=bRb74VGw7BUUZO84f3jlDHHQdQz0VnS30rxFV3hntzJUQIZStYwwN92P2dgoho4vYhwe
	 0aubBBNAYe/sBkWz/34TakoaRzuqJTH4x/KURZ2Zji6lngSHhrWeSFrbNvg4glTGukVYT
	 M64rR+cOXhkqHrwrtw8BkvkXLn02thGzVQMOCxBcT2qpgdVP8i78GREk4z+fnmu1X9oja
	 z+Glg/tiAAdAxn6HliuzduQbKmeyUWgrdiF9exBkhPFAtHatNCmPL79o2rUSRp9zlM4Lc
	 Ij9DpsmcGkY0KzkzgJyHSlBC+ZB6ZIZHEeCQZyvlP5tuBmozeEYkq1u1otLyerJxwFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795419068;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=EMgFF2FML6uL9zrt5WHLoYV9AIrdLm8XoVsSXqWQsaA=;
	b=CrRrVA8qH1+ozVsgBMr8ND8IgOEALFWNF0fAlQznJCdPXdf9yShLY8GTY3VI8lHsfLpT
	 k8GE8KZSQJUoV/HRnNPcvJW6YoWBQcTTaS3xUlpyuAw+b1JjskbxmZAUPs54dq/Bn+Fyq
	 pSXzDRawG6ePI8wRGWYI5nazp1OWxU2iudKeJA06qCa8QPmCryRluHOkuXnv4lIxDnO8x
	 rkbHJiNMXWWbuxwsbZ8SO3ep73m8MBObgsGKdNq6Cr6bzA9RAaOfoiFHir4Kf4CXBFb/a
	 ZxFLO0uv+MFJgLD5MYPNQZGdj1wmMG6g7+bWC9jpg5ntyzy/u6gMUudDEIVib+NiN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=J+tqSZIi;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997F606A31A;
	Mon, 23 Nov 2026 07:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C997F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=J+tqSZIi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EM
	gFF2FML6uL9zrt5WHLoYV9AIrdLm8XoVsSXqWQsaA=; b=J+tqSZIidsHfJ48Dl3
	aRUspqFOZ+HSZ9KHTOqWhu91prGQMExnakg26C2fpeENLfIDW+PwA0J+3KZyXELV
	6Wmp+7fNaV+qDMWHRzopAHfHy6VInr2Ne6FRr3G7WkLGkLP9JJYoG9DpcsRwe+yZ
	sl/13ptJAAkJpHdaAch4ZiUBA=
Received: from leoqi-System-Product-Name.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHUn9h6wNrVnuZHg--.56083S2;
	Mon, 23 Nov 2026 15:29:43 +0800 (CST)
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
Subject: [PATCH v3] KVM: riscv: Allow rescheduling during G-stage unmap
Date: Mon, 23 Nov 2026 15:29:37 +0800
Message-Id: <20261123072937.1655496-1-qican5708@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123064935.1608890-1-qican5708@163.com>
References: <20261123064935.1608890-1-qican5708@163.com>
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
X-CM-TRANSID:PygvCgBHUn9h6wNrVnuZHg--.56083S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3CrW5uFyUAFyDuw1fXryxZrb_yoW8Wr45Go
	W0ya1rWF48ury0yFyIyw17tFyjqFW0krZrWF15XFWYqryjq34rurWjkrZ8Ja47Wr1UWFyf
	ZFWSqr9rXF18G3Wxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUFGQDUUUUU
X-CM-SenderInfo: ptlft0avxqmqqrwthudrp/xtbC8AiwbmsD62iR1wAA3L

Removing a populated memslot or destroying a VM can require walking a
large G-stage range under mmu_lock. Allow these paths to drop the write
lock and reschedule during the walk.

Snapshot the shared root under mmu_lock and verify it before walking
again after a yield. Flush each pending batch before dropping the lock
so another invalidator cannot miss PTEs that the walker cleared.

Return the number of pages in the trailing range that still needs a
flush. The memslot and MMU notifier paths can then flush just that
range while holding mmu_lock. Detaching the root still requires a
full VM flush before freeing it, even when the last batch was empty.

Free the VM-owned split-page cache in kvm_arch_destroy_vm(), after MMU
notifier callbacks have completed. Both address-space teardown and
notifier unregister can invoke the release callback.

Codex assisted with implementation and validation. Sashiko identified
the redundant final range flush during review.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Can Qi <qican5708@163.com>
---
Changes in v3

- Carry the unflushed tail length back to the memslot and MMU notifier
  callers. A v2 trace showed a final request for all 262144 pages of a
  memslot when only 255 pages remained after the last batch.

Changes in v2

- Skip the final range flush when the walk has already synchronized
  every cleared PTE. Keep the full flush when detaching the root.

Testing

- Built the RV64 kernel image and modules and ran mmu_stress_test
  -c 2 -m 2 -s 1 under QEMU. The trace showed a final memslot flush
  of 154 of 262144 pages and a notifier flush of 506 of 262144
  pages. Root teardown still requested a full flush with an empty tail.

 arch/riscv/include/asm/kvm_gstage.h |  15 +++-
 arch/riscv/kvm/gstage.c             |  35 +++++++--
 arch/riscv/kvm/mmu.c                | 112 ++++++++++++++--------------
 arch/riscv/kvm/vm.c                 |   3 +
 4 files changed, 96 insertions(+), 69 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1..a576940f3 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -77,8 +77,9 @@ enum kvm_riscv_gstage_op {
 bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op);
 
-bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
-				  gpa_t start, gpa_t size, bool may_block);
+/* Return the number of trailing pages to flush, or zero if none remain. */
+u64 kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
+				 gpa_t start, gpa_t size, bool may_block);
 
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
 
@@ -104,13 +105,21 @@ static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_levels)
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
index be70607a3..76a2f7c78 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -414,8 +414,8 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 	return flush;
 }
 
-bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
-				  gpa_t start, gpa_t size, bool may_block)
+u64 kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
+				 gpa_t start, gpa_t size, bool may_block)
 {
 	int ret;
 	pte_t *ptep;
@@ -423,9 +423,19 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 	bool found_leaf;
 	unsigned long page_size;
 	gpa_t addr = start, end = start + size;
-	bool flush = false;
+	gfn_t last_flush_gfn = start >> PAGE_SHIFT;
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
@@ -434,10 +444,10 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 		if (!found_leaf) {
 			addr = ALIGN(addr + 1, page_size);
 		} else {
-			if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
-				flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+			if (!(addr & (page_size - 1)) && ((end - addr) >= page_size)) {
+				pending_flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
 								 ptep_level, GSTAGE_OP_CLEAR);
-			else {
+			} else {
 				WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %#lx\n",
 						addr, end, page_size);
 			}
@@ -448,12 +458,21 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
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
 
-	return flush;
+	return pending_flush ? (end >> PAGE_SHIFT) - last_flush_gfn : 0;
 }
 
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end)
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 738d9ee1e..092376a94 100644
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
@@ -88,12 +88,11 @@ out:
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
+	u64 nr_pages = 0;
 
 	write_lock(&kvm->mmu_lock);
-	flush = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
+	if (kvm_riscv_gstage_init(&gstage, kvm))
+		nr_pages = kvm_riscv_gstage_unmap_range(&gstage, gpa, size, true);
+	if (nr_pages)
+		kvm_flush_remote_tlbs_range(kvm, slot->base_gfn + slot->npages - nr_pages,
+					    nr_pages);
 	write_unlock(&kvm->mmu_lock);
-	if (flush)
-		kvm_flush_remote_tlbs_range(kvm, gpa >> PAGE_SHIFT,
-					    size >> PAGE_SHIFT);
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
@@ -332,20 +330,17 @@ out:
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	struct kvm_gstage gstage;
-	bool flush;
-
-	if (!kvm->arch.pgd)
-		return false;
+	u64 nr_pages;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
-	kvm_riscv_gstage_init(&gstage, kvm);
-	flush = kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
-					     (range->end - range->start) << PAGE_SHIFT,
-					     range->may_block);
-	if (flush)
-		kvm_flush_remote_tlbs_range(kvm, range->start,
-					    range->end - range->start);
+	if (!kvm_riscv_gstage_init(&gstage, kvm))
+		return false;
+	nr_pages = kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
+						(range->end - range->start) << PAGE_SHIFT,
+						range->may_block);
+	if (nr_pages)
+		kvm_flush_remote_tlbs_range(kvm, range->end - nr_pages, nr_pages);
 	return false;
 }
 
@@ -356,12 +351,11 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
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
@@ -376,12 +370,11 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
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
@@ -563,12 +556,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
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
@@ -640,8 +633,6 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	struct kvm_gstage gstage;
 	struct page *page;
 
-	kvm_riscv_gstage_init(&gstage, kvm);
-
 	/* Setup initial state of output mapping */
 	memset(out_map, 0, sizeof(*out_map));
 
@@ -649,8 +640,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	    kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map))
 		return 0;
 
-	/* We need minimum second+third level pages */
-	ret = kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
+	/* Size the cache before acquiring the shared root under mmu_lock. */
+	ret = kvm_mmu_topup_memory_cache(pcache, kvm_riscv_gstage_max_pgd_levels);
 	if (ret) {
 		kvm_err("Failed to topup G-stage cache\n");
 		return ret;
@@ -722,6 +713,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 	write_lock(&kvm->mmu_lock);
 
+	if (!kvm_riscv_gstage_init(&gstage, kvm)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
+
 	if (mmu_invalidate_retry(kvm, mmu_seq)) {
 		unused = true;
 		goto out_unlock;
@@ -829,24 +825,24 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
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

