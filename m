Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9A3AB291;
	Sun, 13 Sep 2026 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283501; cv=none; b=nEB8v94Et4J641KWLaTQjQ72BHWXhPmFevmgDhZoWZiWKGI6hl+D2awjRbsEJUBK61ZnHrDwzD6MgcSkqoFD1m/dxJdS2o5cdvPCwVaOKTMvUGRrwkW77T9sAOiC7T94NYsPWP5QZadEYcPXYj+/tFaTtTI15zbrX8e7IFaT2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283501; c=relaxed/simple;
	bh=UqnuHJXHWmCJR9jckes7oRYAQp8pIgHbcaQXxcTl5pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/eTIQ5V2Y/2ZTKCfPkuaMnzPw8QbgfNX27I6UkmiSr569BZKGH73NzBfDc4XWE7Lw/fAYTLXO9frf5/rLhKo7tWrUumhteURWxWnbdBN0w1nniY7CazEwSPVI2EUXB3AqX6YeXwai9wrBjb4pSdaBS7/ayGD3/6laHAvOE6qpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hjKFw0Zwgz5B12h;
	Sun, 13 Sep 2026 15:11:32 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 68D7BRXe059926;
	Sun, 13 Sep 2026 15:11:27 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Sun, 13 Sep 2026 15:11:29 +0800
X-Zmail-TransId: 3e816aa64ca101c-64950
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH v4 2/2] RISC-V: KVM: Recover gstage huge page mappings during disable-dirty-log
Date: Sun, 13 Sep 2026 15:03:46 +0800
Message-ID: <20260913070352.3626956-3-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260913070352.3626956-1-wang.yechao255@zte.com.cn>
References: <20260913070352.3626956-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 68D7BRXe059926
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 13 Sep 2026 15:11:32 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AA64CA4.000/4hjKFw0Zwgz5B12h

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages. If the migration fails or is canceled,
in order to keep the VM's performance consistent with that before
dirty logging was enabled, the gstage huge page mappings are recoverd
when dirty logging is disabled.

With this patch, dirty_log_perf_test shows a decrease in the number of
vCPU faults:

$ perf stat -e kvm:kvm_page_fault \
./dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G

Before: 1,574,460    kvm:kvm_page_fault
After : 788,048      kvm:kvm_page_fault

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |   4 +
 arch/riscv/kvm/gstage.c             |  67 +++++++++++++++
 arch/riscv/kvm/mmu.c                | 127 +++++++++++++++++++++++++++-
 3 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b77a..6dd0a96b336f4 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -68,6 +68,10 @@ bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 				 struct kvm_mmu_memory_cache *pcache,
 				 gpa_t addr, u32 target_level, bool flush);
 
+bool kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
+				   unsigned long target_page_size,
+				   unsigned long *page_size);
+
 enum kvm_riscv_gstage_op {
 	GSTAGE_OP_NOP = 0,	/* Nothing */
 	GSTAGE_OP_CLEAR,	/* Clear/Unmap */
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef1..b9414a62c3e04 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -369,6 +369,73 @@ bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 	return need_flush;
 }
 
+static inline unsigned long make_huge_pte(unsigned long child_pte, int index,
+					  unsigned long child_page_size)
+{
+	unsigned long huge_pte = child_pte;
+	unsigned long child_pfn_offset;
+
+	child_pfn_offset = index * (child_page_size / PAGE_SIZE);
+	huge_pte -= pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));
+
+	return huge_pte;
+}
+
+bool kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
+				   unsigned long target_page_size,
+				   unsigned long *page_size)
+{
+	u32 current_level = gstage->pgd_levels - 1;
+	pte_t *next_ptep = (pte_t *)gstage->pgd;
+	u32 target_level, out_level;
+	pte_t *ptep, *child_ptep;
+	unsigned long huge_pte;
+	bool recovered = false;
+	int ret, i;
+
+	out_level = 0;
+	ret = gstage_page_size_to_level(gstage, target_page_size, &target_level);
+	if (ret)
+		goto out;
+
+	while (current_level >= target_level) {
+		ptep = (pte_t *)&next_ptep[gstage_pte_index(gstage, addr, current_level)];
+
+		out_level = current_level;
+		if (!pte_val(ptep_get(ptep)))
+			goto out;
+
+		/* The mapping is already a huge page mapping. */
+		if (gstage_pte_leaf(ptep)) {
+			recovered = true;
+			goto out;
+		}
+
+		next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+		current_level--;
+	}
+
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		child_ptep = (pte_t *)&next_ptep[i];
+		if (!gstage_pte_leaf(child_ptep))
+			continue;
+
+		huge_pte = make_huge_pte(pte_val(ptep_get(child_ptep)),
+					 i, target_page_size / PTRS_PER_PTE);
+		set_pte(ptep, __pte(huge_pte));
+		gstage_tlb_flush(gstage, target_level, addr);
+		put_page(virt_to_page(next_ptep));
+		recovered = true;
+
+		break;
+	}
+
+out:
+	gstage_level_to_page_size(gstage, out_level, page_size);
+
+	return recovered;
+}
+
 bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6035b5ec95039..8e76187abd89a 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -19,6 +19,8 @@
 static bool __read_mostly eager_page_split = true;
 module_param(eager_page_split, bool, 0644);
 
+static void mmu_recover_huge_pages(struct kvm *kvm, int slot);
+
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
@@ -241,17 +243,44 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
+
 	/*
 	 * At this point memslot has been committed and dirty pages will be
 	 * tracked while the memory slot is write protected.
 	 */
-	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+	if (log_dirty_pages) {
+		if (change == KVM_MR_DELETE)
+			return;
+
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
+
 		mmu_wp_memory_region(kvm, new->id);
 
 		if (READ_ONCE(eager_page_split))
 			mmu_split_memory_region(kvm, new->id);
+
+	} else {
+		/*
+		 * Only when change == KVM_MR_FLAGS_ONLY, this branch handles the
+		 * disable-dirty-log case. For other changes (KVM_MR_CREATE,
+		 * KVM_MR_DELETE, KVM_MR_MOVE), there is no need to recover
+		 * huge pages.
+		 */
+		if (change != KVM_MR_FLAGS_ONLY)
+			return;
+
+		/*
+		 * Recover huge page mappings in the slot now that dirty logging
+		 * is disabled, i.e. now that KVM does not have to track guest
+		 * writes at 4KiB granularity.
+		 *
+		 * Dirty logging might be disabled by userspace if an ongoing VM
+		 * live migration is cancelled and the VM must continue running
+		 * on the source.
+		 */
+		mmu_recover_huge_pages(kvm, new->id);
 	}
 }
 
@@ -810,3 +839,99 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_gstage_vmid_bits())
 		kvm_riscv_local_hfence_gvma_all();
 }
+
+static unsigned long mmu_recover_huge_pages_range(struct kvm_gstage *gstage,
+						  unsigned long page_size,
+						  gpa_t range_start,
+						  gpa_t range_end)
+{
+	phys_addr_t start = range_start;
+	phys_addr_t end = range_end;
+	unsigned long out_sz = 0;
+	bool recovered = true;
+
+	/*
+	 *  Recover 2MB hugepages mapping within the range.
+	 */
+	while (start < end) {
+		recovered &= kvm_riscv_gstage_recover_huge(gstage, start,
+							   PMD_SIZE, &out_sz);
+		start += out_sz;
+	}
+
+	/*
+	 * If 1GB hugepages are desired, try to recover the whole range
+	 * as one 1GB hugepages mapping.
+	 */
+	if (recovered && (page_size == PUD_SIZE)) {
+		start = range_start;
+		kvm_riscv_gstage_recover_huge(gstage, start, PUD_SIZE, &out_sz);
+	}
+
+	return out_sz;
+}
+
+static void mmu_recover_huge_pages(struct kvm *kvm, int slot)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
+	unsigned long hva = gfn_to_hva(kvm, memslot->base_gfn);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	phys_addr_t addr = start;
+	struct kvm_gstage gstage;
+	unsigned long page_size;
+	unsigned long out_size;
+	phys_addr_t range_start;
+	phys_addr_t range_end;
+
+	if (!(fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE) ||
+	    fault_supports_gstage_huge_mapping(memslot, hva, PUD_SIZE)))
+		return;
+
+	kvm_riscv_gstage_init(&gstage, kvm);
+
+	write_lock(&kvm->mmu_lock);
+
+	while (addr < end) {
+		/*
+		 * If a very large memslot is mapped exclusively with
+		 * 4KB host pages, or too many hugepages need to recover,
+		 * release the kvm->mmu_lock to prevent starvation and
+		 * lockup detector warnings.
+		 */
+		cond_resched_rwlock_write(&kvm->mmu_lock);
+
+		if (!kvm->arch.pgd)
+			break;
+
+		hva = gfn_to_hva(kvm, addr >> PAGE_SHIFT);
+		page_size = get_hva_mapping_size(kvm, hva);
+		if (page_size == PAGE_SIZE) {
+			addr += page_size;
+			continue;
+		}
+
+		range_start = ALIGN_DOWN(addr, page_size);
+		range_end = range_start + page_size;
+
+		/*
+		 * Make sure the recover range [range_start, range_end)
+		 * is within the slot range.
+		 */
+		if (range_start < start || range_end > end) {
+			addr = range_end;
+			continue;
+		}
+
+		out_size = mmu_recover_huge_pages_range(&gstage, page_size,
+							range_start, range_end);
+
+		if (out_size > page_size)
+			page_size = out_size;
+
+		addr = range_start + page_size;
+	}
+
+	write_unlock(&kvm->mmu_lock);
+}
-- 
2.39.3

