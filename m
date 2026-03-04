Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1937F00D;
	Wed,  4 Mar 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616497; cv=none; b=uTc0gH9EKJbKVC98ftcgM/9A4YeoABTkP4Z0v3i6EVdSqyu8Hix75s5XdlcSbyM1PHwFI5sV0MRTozDb5bZ7ZFMm7LbjtzUuBD9KzbLmsxZppmmUxxKBtB76l11WvranVh53ibcPuDoz7zuOPgThogirRi7hmspN0zRw4v9A9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616497; c=relaxed/simple;
	bh=GX4yyBupfhHLTcqmX4PbBwngjcpIJzWsD9aEmQP7gN0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=HiYYDtxInGH7euvNtACSuHZKPYjgc4Z3rDgSzXWzioofxOKYebuKMLhjq310s6QioeC5kWNffWM0ZYSfRtyFU4trq1HUvqzHzlWYaGOaFHPGMmQMBy4pFJlSbdapETA16yDe9nKR3J+PHI41O706NNuazGrqy59auUh0T+qm3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fQnQf6wLqz4xPSq;
	Wed, 04 Mar 2026 17:28:10 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 6249S1pZ058883;
	Wed, 4 Mar 2026 17:28:01 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 4 Mar 2026 17:28:03 +0800 (CST)
X-Zmail-TransId: 2b0469a7fb23038-4c136
X-Mailer: Zmail v1.0
Message-ID: <20260304172803832bNWZwe5J-jmNTNt79mGq2@zte.com.cn>
In-Reply-To: <20260304172139131ChDubMSpGDUB03lY4UCbK@zte.com.cn>
References: 20260304172139131ChDubMSpGDUB03lY4UCbK@zte.com.cn
Date: Wed, 4 Mar 2026 17:28:03 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvM10gUklTQy1WOiBLVk06IEFsbG93IHNwbGl0dGluZyBodWdlIHBhZ2VzIHRvIGFyYml0cmFyeQoKIGxldmVs?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6249S1pZ058883
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Mar 2026 17:28:11 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69A7FB2A.000/4fQnQf6wLqz4xPSq

From: Wang Yechao <wang.yechao255@zte.com.cn>

This patch introduces the function kvm_riscv_gstage_split_huge().
It splits the huge page covering a given guest physical address down
to a specified target level (e.g., from 1G to 2M or 4K). The caller
provides a memory cache for allocating any intermediate page tables
and may request a TLB flush after the split.

This functionality will be used by subsequent patches to split huge
pages before handling the write-protection fault, or for other operations
that require page-level granularity.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |  4 ++
 arch/riscv/kvm/gstage.c             | 69 +++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 595e2183173e..373748c6745e 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -53,6 +53,10 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      bool page_rdonly, bool page_exec,
 			      struct kvm_gstage_mapping *out_map);

+int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
+                                struct kvm_mmu_memory_cache *pcache,
+                                gpa_t addr, u32 target_level, bool flush);
+
 enum kvm_riscv_gstage_op {
 	GSTAGE_OP_NOP = 0,	/* Nothing */
 	GSTAGE_OP_CLEAR,	/* Clear/Unmap */
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index d2001d508046..92331e9b0bb8 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -209,6 +209,75 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 	return kvm_riscv_gstage_set_pte(gstage, pcache, out_map);
 }

+static inline unsigned long make_child_pte(unsigned long huge_pte, int index,
+					   unsigned long child_page_size)
+{
+	unsigned long child_pte = huge_pte;
+	unsigned long child_pfn_offset;
+
+	/*
+	 * The child_pte already has the base address of the huge page being
+	 * split. So we just have to OR in the offset to the page at the next
+	 * lower level for the given index.
+	 */
+	child_pfn_offset = index * (child_page_size / PAGE_SIZE);
+	child_pte |= pte_val(pfn_pte(child_pfn_offset, __pgprot(0)));
+
+	return child_pte;
+}
+
+int kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
+				struct kvm_mmu_memory_cache *pcache,
+				gpa_t addr, u32 target_level, bool flush)
+{
+	u32 current_level = kvm_riscv_gstage_pgd_levels - 1;
+	pte_t *next_ptep = (pte_t *)gstage->pgd;
+	pte_t *ptep;
+	unsigned long huge_pte, child_pte;
+	unsigned long child_page_size;
+	int i, ret;
+
+	while(current_level > target_level) {
+		ptep = (pte_t *)&next_ptep[gstage_pte_index(addr, current_level)];
+
+		if (!pte_val(ptep_get(ptep)))
+			break;
+
+		if (!gstage_pte_leaf(ptep)) {
+			next_ptep = (pte_t *)gstage_pte_page_vaddr(ptep_get(ptep));
+			current_level--;
+			continue;
+		}
+
+		huge_pte = pte_val(ptep_get(ptep));
+
+		ret = gstage_level_to_page_size(current_level - 1, &child_page_size);
+		if (ret)
+			return ret;
+
+		if (!pcache)
+			return -ENOMEM;
+		next_ptep = kvm_mmu_memory_cache_alloc(pcache);
+		if (!next_ptep)
+			return -ENOMEM;
+
+		set_pte(ptep, pfn_pte(PFN_DOWN(__pa(next_ptep)),
+				__pgprot(_PAGE_TABLE)));
+
+		for (i = 0; i < PTRS_PER_PTE; i++) {
+			child_pte = make_child_pte(huge_pte, i, child_page_size);
+			set_pte((pte_t *)&next_ptep[i], __pte(child_pte));
+		}
+
+		if (flush)
+			gstage_tlb_flush(gstage, current_level, addr);
+
+		current_level--;
+	}
+
+	return 0;
+}
+
 void kvm_riscv_gstage_op_pte(struct kvm_gstage *gstage, gpa_t addr,
 			     pte_t *ptep, u32 ptep_level, enum kvm_riscv_gstage_op op)
 {
-- 
2.47.3
