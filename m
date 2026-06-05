Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0E4611C7;
	Fri,  5 Jun 2026 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646687; cv=none; b=kaU9tXvAXChQJWCHsUi6Vs0lRtsc4J1rNh/kA55PubRaNW8w9yEdHsDr4Oah6v++ARz7V0fc/fsLvClAjlP9V5MgVUlOD5nXa1r2sMonG9CqdRxzr5p6v7WNmXcky5l6HrAGtCrN2F8H7evQY80EiqZZ/TfSqKXEtcxT1aX7ebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646687; c=relaxed/simple;
	bh=lx0fTrUP1V/O2Ki2Cv8xfJwKL6bNs6LRmzHCDVWbC84=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=dDuSXGhPIc93ifwaVGTx1qcVtGDkjqbzythneJIHZ6CpgPpCtm9gqCSZpUHLUd0T8uaIOV57EpqXiGnhwAoGQXqZNCNCQoEiC5eBL2k0fAvNFa4ckUwlmuQSdBQDdMOldzD5+u1BPGidpUWVwoLcIsc3h/A3FPyHhc8XA7DMysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gWv9S36x6z8XrrZ;
	Fri, 05 Jun 2026 16:04:44 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 65584aXL038080;
	Fri, 5 Jun 2026 16:04:36 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Fri, 5 Jun 2026 16:04:38 +0800 (CST)
X-Zmail-TransId: 2b036a228316065-0e5ca
X-Mailer: Zmail v1.0
Message-ID: <202606051604386666MCW-cbGqPCadNZW8w_Q5@zte.com.cn>
In-Reply-To: <20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn>
References: 20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn
Date: Fri, 5 Jun 2026 16:04:38 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggdjMgMy8zXSBSSVNDLVY6IEtWTTogUmVjb3ZlciBnc3RhZ2UgaHVnZSBwYWdlIG1hcHBpbmdzIGR1cmluZyBkaXNhYmxlLWRpcnR5LWxvZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65584aXL038080
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 05 Jun 2026 16:04:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A22831C.001/4gWv9S36x6z8XrrZ

From: Wang Yechao <wang.yechao255@zte.com.cn>

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages. If the migration fails or is canceled,
in order to keep the VM's performance consistent with that before
dirty logging was enabled, the gstage huge page mappings are recoverd
when dirty logging is disabled.

With this patch, dirty_log_perf_test shows a decrease in the number of
vCPU faults:

$ perf stat -e kvm:kvm_page_fault \
/dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G

Before: 524,819      kvm:kvm_page_fault
After : 262,685      kvm:kvm_page_fault

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |   4 ++
 arch/riscv/kvm/gstage.c             |  61 ++++++++++++++++
 arch/riscv/kvm/mmu.c                | 105 ++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 21e2019df0cf..bef1d4f11564 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -68,6 +68,10 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 				struct kvm_mmu_memory_cache *pcache,
 				gpa_t addr, u32 target_level, bool flush);

+void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
+				   unsigned long taget_page_size,
+				   unsigned long *page_size);
+
 enum kvm_riscv_gstage_op {
 	GSTAGE_OP_NOP = 0,	/* Nothing */
 	GSTAGE_OP_CLEAR,	/* Clear/Unmap */
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index b83b85d1c016..11d4062fdd22 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -356,6 +356,67 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 	return 0;
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
+void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
+				   unsigned long target_page_size,
+				   unsigned long *page_size)
+{
+	u32 current_level = gstage->pgd_levels - 1;
+	pte_t *next_ptep = (pte_t *)gstage->pgd;
+	u32 target_level, out_level;
+	pte_t *ptep, *child_ptep;
+	unsigned long huge_pte;
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
+		if (gstage_pte_leaf(ptep))
+			goto out;
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
+
+		break;
+	}
+
+out:
+	gstage_level_to_page_size(gstage, out_level, page_size);
+}
+
 bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 5645e247e198..990fc483a765 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -16,6 +16,8 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>

+static void mmu_recover_huge_pages(struct kvm *kvm, int slot);
+
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
@@ -170,6 +172,26 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
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

@@ -689,3 +711,86 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_gstage_vmid_bits())
 		kvm_riscv_local_hfence_gvma_all();
 }
+
+static void mmu_recover_huge_pages_range(struct kvm_gstage *gstage,
+					 unsigned long *page_size,
+					 gpa_t range_start,
+					 gpa_t range_end)
+{
+	phys_addr_t start = range_start;
+	phys_addr_t end = range_end;
+	unsigned long pg_sz = 0;
+
+	/*
+	 *  Phase 1: recover 2MB hugepages mapping within the range.
+	 */
+	while (start < end) {
+		kvm_riscv_gstage_recover_huge(gstage, start, PMD_SIZE, &pg_sz);
+		start += pg_sz;
+	}
+
+	/*
+	 * Phase 2: if 1GB hugepages are desired, try to recover the whole range
+	 * as one 1GB hugepages mapping.
+	 */
+	if (*page_size == PUD_SIZE) {
+		start = range_start;
+		kvm_riscv_gstage_recover_huge(gstage, start, PUD_SIZE, &pg_sz);
+	}
+
+	*page_size = pg_sz;
+}
+
+static void mmu_recover_huge_pages(struct kvm *kvm, int slot)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	phys_addr_t addr = start;
+	struct kvm_gstage gstage;
+	unsigned long page_size;
+	phys_addr_t range_start;
+	phys_addr_t range_end;
+	unsigned long hva;
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
+		mmu_recover_huge_pages_range(&gstage, &page_size,
+					     range_start, range_end);
+
+		addr = range_start + page_size;
+	}
+
+	write_unlock(&kvm->mmu_lock);
+}
-- 
2.43.5
