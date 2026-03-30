Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3813CD8C5;
	Mon, 30 Mar 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873602; cv=none; b=eu9eHcjPxE4O1NgaCYaYiAx3Vthf2GYMwXpr5oUAMghjii9qMbLA52LGPvtX0Pf1hNQRtHSpsvDwzWBQVzLnUbFS/fLFw1sJiyA4RVIguWnQ3izuFbRmHzDm6aZg9pxxP/Vv0Z7XIjSwQ/PiFIFE47bd/l4tnMtc3eUNd1ksRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873602; c=relaxed/simple;
	bh=4UX4zR/SoyFBXcevu5BS/rR4BpG0cIklXlPJTft38QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ngi0UUxjgIueidswIVoN5v23UW3bHVfyIUIv3rIYla4Ekdex71j510M4UIF95QwHfbBcU3YCQBFNs9fz8XGJ8gmO527fWmlTWmsRviSIroqcoWZDGSxoaCdzcX3KH0yOwut+RIRvI5GZ2qE/TrjGtc9kNcBYvrvGImWai7XL5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GD+8srE7; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GD+8srE7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774873592; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zoncOzDn/GwxdQdnVQulFi3wkN3Paqj7D9C+6rwYdQM=;
	b=GD+8srE7DgEnpbtQo1/tVXKTYfOlU7hYcLNLSGOyCdPlH7CGJT9nt09LVbrTsAt5KZyepUKNcwH8wdwgs3mOCphHeukMgnw/QwlJa2oLYpoToXic00Y7sjVIk42PbepSCe7eoBUokErHf0lEc5kSSzgs5cv52eZIu+ju6SX+qC8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X.zfcIY_1774873590;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X.zfcIY_1774873590 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Mar 2026 20:26:30 +0800
From: fangyu.yu@linux.alibaba.com
To: pbonzini@redhat.com,
	corbet@lwn.net,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	skhan@linuxfoundation.org
Cc: guoren@kernel.org,
	radim.krcmar@oss.qualcomm.com,
	andrew.jones@oss.qualcomm.com,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v6 2/4] RISC-V: KVM: Cache gstage pgd_levels in struct kvm_gstage
Date: Mon, 30 Mar 2026 20:25:59 +0800
Message-Id: <20260330122601.22140-3-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
References: <20260330122601.22140-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

Gstage page-table helpers frequently chase gstage->kvm->arch to
fetch pgd_levels. This adds noise and repeats the same dereference
chain in hot paths.

Add pgd_levels to struct kvm_gstage and initialize it from kvm->arch
when setting up a gstage instance. Introduce kvm_riscv_gstage_init()
to centralize initialization and switch gstage code to use
gstage->pgd_levels.

Suggested-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/include/asm/kvm_gstage.h | 10 ++++++
 arch/riscv/kvm/gstage.c             | 10 +++---
 arch/riscv/kvm/mmu.c                | 50 ++++++-----------------------
 3 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 5aa58d1f692a..70d9d483365e 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -15,6 +15,7 @@ struct kvm_gstage {
 #define KVM_GSTAGE_FLAGS_LOCAL		BIT(0)
 	unsigned long vmid;
 	pgd_t *pgd;
+	unsigned long pgd_levels;
 };
 
 struct kvm_gstage_mapping {
@@ -92,4 +93,13 @@ static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_levels)
 	}
 }
 
+static inline void kvm_riscv_gstage_init(struct kvm_gstage *gstage, struct kvm *kvm)
+{
+	gstage->kvm = kvm;
+	gstage->flags = 0;
+	gstage->vmid = READ_ONCE(kvm->arch.vmid.vmid);
+	gstage->pgd = kvm->arch.pgd;
+	gstage->pgd_levels = kvm->arch.pgd_levels;
+}
+
 #endif
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 4beb9322fe76..7c4c34bc191b 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -26,7 +26,7 @@ static inline unsigned long gstage_pte_index(struct kvm_gstage *gstage,
 	unsigned long mask;
 	unsigned long shift = HGATP_PAGE_SHIFT + (kvm_riscv_gstage_index_bits * level);
 
-	if (level == gstage->kvm->arch.pgd_levels - 1)
+	if (level == gstage->pgd_levels - 1)
 		mask = (PTRS_PER_PTE * (1UL << kvm_riscv_gstage_pgd_xbits)) - 1;
 	else
 		mask = PTRS_PER_PTE - 1;
@@ -45,7 +45,7 @@ static int gstage_page_size_to_level(struct kvm_gstage *gstage, unsigned long pa
 	u32 i;
 	unsigned long psz = 1UL << 12;
 
-	for (i = 0; i < gstage->kvm->arch.pgd_levels; i++) {
+	for (i = 0; i < gstage->pgd_levels; i++) {
 		if (page_size == (psz << (i * kvm_riscv_gstage_index_bits))) {
 			*out_level = i;
 			return 0;
@@ -58,7 +58,7 @@ static int gstage_page_size_to_level(struct kvm_gstage *gstage, unsigned long pa
 static int gstage_level_to_page_order(struct kvm_gstage *gstage, u32 level,
 				      unsigned long *out_pgorder)
 {
-	if (gstage->kvm->arch.pgd_levels < level)
+	if (gstage->pgd_levels < level)
 		return -EINVAL;
 
 	*out_pgorder = 12 + (level * kvm_riscv_gstage_index_bits);
@@ -83,7 +83,7 @@ bool kvm_riscv_gstage_get_leaf(struct kvm_gstage *gstage, gpa_t addr,
 			       pte_t **ptepp, u32 *ptep_level)
 {
 	pte_t *ptep;
-	u32 current_level = gstage->kvm->arch.pgd_levels - 1;
+	u32 current_level = gstage->pgd_levels - 1;
 
 	*ptep_level = current_level;
 	ptep = (pte_t *)gstage->pgd;
@@ -127,7 +127,7 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 			     struct kvm_mmu_memory_cache *pcache,
 			     const struct kvm_gstage_mapping *map)
 {
-	u32 current_level = gstage->kvm->arch.pgd_levels - 1;
+	u32 current_level = gstage->pgd_levels - 1;
 	pte_t *next_ptep = (pte_t *)gstage->pgd;
 	pte_t *ptep = &next_ptep[gstage_pte_index(gstage, map->addr, current_level)];
 
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index fbcdd75cb9af..2d3def024270 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -24,10 +24,7 @@ static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	spin_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_wp_range(&gstage, start, end);
@@ -49,10 +46,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	struct kvm_gstage_mapping map;
 	struct kvm_gstage gstage;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
 	pfn = __phys_to_pfn(hpa);
@@ -89,10 +83,7 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
 {
 	struct kvm_gstage gstage;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	spin_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
@@ -109,10 +100,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	kvm_riscv_gstage_wp_range(&gstage, start, end);
 }
@@ -141,10 +129,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	phys_addr_t size = slot->npages << PAGE_SHIFT;
 	struct kvm_gstage gstage;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	spin_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
@@ -250,10 +235,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	if (!kvm->arch.pgd)
 		return false;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 	mmu_locked = spin_trylock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, range->start << PAGE_SHIFT,
 				     (range->end - range->start) << PAGE_SHIFT,
@@ -275,10 +257,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
 				       &ptep, &ptep_level))
 		return false;
@@ -298,10 +277,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 
 	WARN_ON(size != PAGE_SIZE && size != PMD_SIZE && size != PUD_SIZE);
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 	if (!kvm_riscv_gstage_get_leaf(&gstage, range->start << PAGE_SHIFT,
 				       &ptep, &ptep_level))
 		return false;
@@ -463,10 +439,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	struct kvm_gstage gstage;
 	struct page *page;
 
-	gstage.kvm = kvm;
-	gstage.flags = 0;
-	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-	gstage.pgd = kvm->arch.pgd;
+	kvm_riscv_gstage_init(&gstage, kvm);
 
 	/* Setup initial state of output mapping */
 	memset(out_map, 0, sizeof(*out_map));
@@ -587,10 +560,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 
 	spin_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
-		gstage.kvm = kvm;
-		gstage.flags = 0;
-		gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
-		gstage.pgd = kvm->arch.pgd;
+		kvm_riscv_gstage_init(&gstage, kvm);
 		kvm_riscv_gstage_unmap_range(&gstage, 0UL,
 			kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
 		pgd = READ_ONCE(kvm->arch.pgd);
-- 
2.50.1

