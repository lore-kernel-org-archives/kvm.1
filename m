Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768342FE58C;
	Tue,  7 Apr 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553407; cv=none; b=L+JiRdyH8Qa7OH5OzCDIBV9Elu8tNaqnuYuZuqWlNcugQbXGRBvBMoppPZLDEGv80XSMsBjkEOFNCElf+mkcoubUIocXq60YOUeaNZ6F3W3yrrUTwbC49+QOPWM4uSWmEPQhWisyGR0DtDm4Akg0B+55bh1B4Kd2CynuEOYihMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553407; c=relaxed/simple;
	bh=C8puQMPeY6aoJLNYF/hlJqKdr+d1hCqlZajadk/FkxE=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=P0fXTIJfuuvbiiwhXreBr+x/mJF5VL1zXrCeEdoDKTEyatqW1nAUAP28q++dvl9CdEYRhc0wiZlI1QW5Hv5F8ed8iLRZPy9IuvGI0x2KTJjFAtRZtp/UnMOkArj0JpteDPaxDDHdcNLf2wozZv17oQ9oA9qfmmBofrFkfLMgoZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fqgYg4SmVz501bD;
	Tue, 07 Apr 2026 17:16:39 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 6379GVZl050576;
	Tue, 7 Apr 2026 17:16:31 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 7 Apr 2026 17:16:33 +0800 (CST)
X-Zmail-TransId: 2b0569d4cb716e6-99116
X-Mailer: Zmail v1.0
Message-ID: <2026040717163343908VqFt1HjxIYObFoWo2Xe@zte.com.cn>
In-Reply-To: <20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn>
References: 20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn
Date: Tue, 7 Apr 2026 17:16:33 +0800 (CST)
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
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gUklTQy1WOiBLVk06IFJlY292ZXIgZ3N0YWdlIGh1Z2UgcGFnZSBtYXBwaW5ncyBkdXJpbmcgZGlzYWJsZS1kaXJ0eS1sb2c=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6379GVZl050576
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 07 Apr 2026 17:16:39 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69D4CB77.000/4fqgYg4SmVz501bD

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
After : 263,211      kvm:kvm_page_fault

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |  4 +++
 arch/riscv/kvm/gstage.c             | 42 ++++++++++++++++++++++++
 arch/riscv/kvm/mmu.c                | 51 +++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 373748c6745e..6e5aaa487adf 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -57,6 +57,10 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
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
index ffec3e5ddcaf..54881a38b363 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -335,6 +335,48 @@ int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
 	return 0;
 }

+void kvm_riscv_gstage_recover_huge(struct kvm_gstage *gstage, gpa_t addr,
+				   unsigned long target_page_size,
+				   unsigned long *page_size)
+{
+	u32 current_level = kvm_riscv_gstage_pgd_levels - 1;
+	pte_t *next_ptep = (pte_t *)gstage->pgd;
+	u32 target_level, out_level;
+	pte_t *ptep, *child_ptep;
+	int ret;
+
+	out_level = 0;
+	ret = gstage_page_size_to_level(target_page_size, &target_level);
+	if (ret)
+		goto out;
+
+	while (current_level >= target_level) {
+		ptep = (pte_t *)&next_ptep[gstage_pte_index(addr, current_level)];
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
+	/* Replace the huge PTE with the first PTE entry of the child page table.*/
+	child_ptep = (pte_t *)&next_ptep[0];
+	set_pte(ptep, __pte(pte_val(ptep_get(child_ptep))));
+
+	gstage_tlb_flush(gstage, target_level, addr);
+
+	put_page(virt_to_page(next_ptep));
+
+out:
+	gstage_level_to_page_size(out_level, page_size);
+}
+
 void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
 {
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d2116c09c589..0b7077946e90 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -16,6 +16,8 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>

+static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot);
+
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
@@ -175,6 +177,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
+	} else {
+		/*
+		 * Recover huge page mappings in the slot now that dirty logging
+		 * is disabled, i.e. now that KVM does not have to track guest
+		 * writes at 4KiB granularity.
+		 *
+		 * Dirty logging might be disabled by userspace if an ongoing VM
+		 * live migration is cancelled and the VM must continue running
+		 * on the source.
+		 */
+		kvm_mmu_recover_huge_pages(kvm, new->id);
 	}
 }

@@ -620,3 +633,41 @@ void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
 	if (!kvm_riscv_gstage_vmid_bits())
 		kvm_riscv_local_hfence_gvma_all();
 }
+
+static void kvm_mmu_recover_huge_pages(struct kvm *kvm, int slot)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
+	unsigned long hva = gfn_to_hva(kvm, memslot->base_gfn);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	phys_addr_t addr = start;
+	struct kvm_gstage gstage;
+	unsigned long page_size;
+
+	if (!fault_supports_gstage_huge_mapping(memslot, hva))
+		return;
+
+	gstage.kvm = kvm;
+	gstage.flags = 0;
+	gstage.vmid = READ_ONCE(kvm->arch.vmid.vmid);
+	gstage.pgd = kvm->arch.pgd;
+
+	spin_lock(&kvm->mmu_lock);
+
+	while (addr < end) {
+		cond_resched_lock(&kvm->mmu_lock);
+
+		if (get_hva_mapping_size(kvm, hva) < PMD_SIZE) {
+			addr += PMD_SIZE;
+			hva  += PMD_SIZE;
+			continue;
+		}
+
+		kvm_riscv_gstage_recover_huge(&gstage, addr, PMD_SIZE, &page_size);
+
+		addr += page_size;
+		hva  += page_size;
+	}
+	spin_unlock(&kvm->mmu_lock);
+}
-- 
2.47.3
