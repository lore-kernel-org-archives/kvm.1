Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2A8403AF2;
	Wed,  1 Jul 2026 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907875; cv=none; b=f2pkkxi6221nLK6eSMBzQshFAdIfvlGS0pi8b47zUJUimecA5MRQ/2WEPmpuoqCbvJCKvLvL4JzxY60G5o03un2KGqOZEJX7nYx9zBOA2Q3n/Fi5BNYaqZehovOCiOjbJeXywA78Ut3Wr1Je7+OjaV/ssbkuY40774QXLKxnyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907875; c=relaxed/simple;
	bh=HfXFd+sKdxRM0krh62Y3GZbPl7Y4VeHijBN6ZhJeXtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmgMtbD3ByYCOKFmleCjr1XCqf8FBjSh2cMF09IAxtx4MxWH+kbET129LGDnoS+UtMFwP7dmyGMocGTroD29BNs+J7OcM+N2YWsQ+4GZ3lvU+oB8pLQ9s7csEJHeuFZnjo4iLFgB8eMYZeKCLpi4sZv7qMYwUMBrp+KIAA/uztQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gqzPd5qrbz55RJ3;
	Wed, 01 Jul 2026 20:11:01 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 661CAubo077460;
	Wed, 1 Jul 2026 20:10:56 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Wed, 1 Jul 2026 20:10:59 +0800
X-Zmail-TransId: 3e816a4503d3008-1d5d8
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
Subject: [PATCH v4 2/5] RISC-V: KVM: Split huge pages when dirty logging is enabled
Date: Wed,  1 Jul 2026 20:09:45 +0800
Message-ID: <20260701120954.129873-3-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260701120954.129873-1-wang.yechao255@zte.com.cn>
References: <20260701120954.129873-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 661CAubo077460
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 01 Jul 2026 20:11:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4503D5.001/4gqzPd5qrbz55RJ3

Split huge pages eagerly when enabling dirty logging. The goal is to
avoid doing it while faulting on write-protected pages, which
negatively impacts guest performance.

The benefits of eager page splitting are the same as in x86 and arm64,
added with commit a3fe5dbda0a4 ("KVM: x86/mmu: Split huge pages mapped
by the TDP MMU when dirty logging is enabled") and commit e7bf7a490c68
("KVM: arm64: Split huge pages when dirty logging is enabled")

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |  6 +--
 arch/riscv/kvm/gstage.c             | 23 ++++++---
 arch/riscv/kvm/mmu.c                | 76 +++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 21e2019df0cf5..f726279780177 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -64,9 +64,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      bool page_rdonly, bool page_exec,
 			      struct kvm_gstage_mapping *out_map);
 
-int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
-				struct kvm_mmu_memory_cache *pcache,
-				gpa_t addr, u32 target_level, bool flush);
+bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
+				 struct kvm_mmu_memory_cache *pcache,
+				 gpa_t addr, u32 target_level, bool flush);
 
 enum kvm_riscv_gstage_op {
 	GSTAGE_OP_NOP = 0,	/* Nothing */
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index c4c3b79567f10..4815233f9788d 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -303,19 +303,20 @@ static inline unsigned long make_child_pte(unsigned long huge_pte, int index,
 	return child_pte;
 }
 
-int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
-				struct kvm_mmu_memory_cache *pcache,
-				gpa_t addr, u32 target_level, bool flush)
+bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
+				 struct kvm_mmu_memory_cache *pcache,
+				 gpa_t addr, u32 target_level, bool flush)
 {
 	u32 current_level = gstage->pgd_levels - 1;
 	pte_t *next_ptep = (pte_t *)gstage->pgd;
 	unsigned long huge_pte, child_pte;
 	unsigned long child_page_size;
+	bool need_flush = false;
 	pte_t *ptep;
 	int i, ret;
 
 	if (!pcache)
-		return -ENOMEM;
+		return false;
 
 	while(current_level > target_level) {
 		ptep = (pte_t *)&next_ptep[gstage_pte_index(gstage, addr, current_level)];
@@ -333,27 +334,35 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 
 		ret = gstage_level_to_page_size(gstage, current_level - 1, &child_page_size);
 		if (ret)
-			return ret;
+			return need_flush;
 
 		next_ptep = kvm_mmu_memory_cache_alloc(pcache);
 		if (!next_ptep)
-			return -ENOMEM;
+			return need_flush;
 
 		for (i = 0; i < PTRS_PER_PTE; i++) {
 			child_pte = make_child_pte(huge_pte, i, child_page_size);
 			set_pte((pte_t *)&next_ptep[i], __pte(child_pte));
 		}
 
+		/*
+		 * Ensure the writes to the child PTEs are visible before
+		 * linking the new page table to the parent PTE.
+		 */
+		smp_wmb();
+
 		set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
 				__pgprot(_PAGE_TABLE)));
 
 		if (flush)
 			gstage_tlb_flush(gstage, current_level, addr);
+		else
+			need_flush = true;
 
 		current_level--;
 	}
 
-	return 0;
+	return need_flush;
 }
 
 bool kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 9cf69bc28b9c5..363238efaedb4 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -97,6 +97,62 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
 					    size >> PAGE_SHIFT);
 }
 
+static bool need_topup_split_caches_or_resched(struct kvm *kvm, int count)
+{
+	struct kvm_mmu_memory_cache *cache;
+
+	if (need_resched() || rwlock_needbreak(&kvm->mmu_lock))
+		return true;
+
+	cache = &kvm->arch.pgd_split_page_cache;
+	return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
+}
+
+static bool mmu_split_huge_pages(struct kvm_gstage *gstage,
+				 phys_addr_t start, phys_addr_t end)
+{
+	struct kvm *kvm = gstage->kvm;
+	struct kvm_mmu_memory_cache *pcache = &kvm->arch.pgd_split_page_cache;
+	phys_addr_t addr = ALIGN_DOWN(start, PMD_SIZE);
+	phys_addr_t last_flush_gfn = addr >> PAGE_SHIFT;
+	int count = gstage->pgd_levels;
+	bool flush = false;
+	int ret;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	while (addr < end) {
+		if (need_topup_split_caches_or_resched(kvm, count)) {
+			if (flush) {
+				kvm_flush_remote_tlbs_range(kvm, last_flush_gfn,
+					  (addr >> PAGE_SHIFT) - last_flush_gfn);
+				last_flush_gfn = addr >> PAGE_SHIFT;
+				flush = false;
+			}
+
+			write_unlock(&kvm->mmu_lock);
+			cond_resched();
+
+			ret = kvm_mmu_topup_memory_cache(pcache, count);
+			if (ret) {
+				kvm_err("Failed to toup split page cache\n");
+				write_lock(&kvm->mmu_lock);
+				return flush;
+			}
+			write_lock(&kvm->mmu_lock);
+		}
+
+		if (!kvm->arch.pgd)
+			return flush;
+
+		flush |= kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, false);
+
+		addr += PMD_SIZE;
+	}
+
+	return flush;
+}
+
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					     struct kvm_memory_slot *slot,
 					     gfn_t gfn_offset,
@@ -151,6 +207,25 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 					    size >> PAGE_SHIFT);
 }
 
+static void mmu_split_memory_region(struct kvm *kvm, int slot)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	struct kvm_gstage gstage;
+	bool flush;
+
+	kvm_riscv_gstage_init(&gstage, kvm);
+
+	write_lock(&kvm->mmu_lock);
+	flush = mmu_split_huge_pages(&gstage, start, end);
+	write_unlock(&kvm->mmu_lock);
+
+	if (flush)
+		kvm_flush_remote_tlbs_memslot(kvm, memslot);
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
@@ -164,6 +239,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
+		mmu_split_memory_region(kvm, new->id);
 	}
 }
 
-- 
2.43.5

