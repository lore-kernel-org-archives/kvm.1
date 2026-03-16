Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD8347539;
	Mon, 16 Mar 2026 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773642041; cv=none; b=gDqEZiVQFKOL6dlW4QH/IQdHUwNxYW1U95LoSVM3Mi4+PxurFTVqpeLb5HgMEaMQI8x5u1Z1KKdHPBjFZziQaSggwa1FJIuR8Qo3ZOWEPBT6t32mOzfM02kSHOgTpXQTkFPKbPEhL9AtsdEpm2Hq86wAGMdHIouYcLcBAzXfS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773642041; c=relaxed/simple;
	bh=pIiG3gYC+85imL5s+0StsEq2xk/YgHx5+4NdYmXiKts=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=qFoQJTobjNRDEfq/RfwsWuZiRZMmoEe3FtDvCXufqb3G3D76wUgikxCjjSob4PsZ2d3oJg2x4hdXdjzOKJpgBwJOyRL9pPKpd+eZt8pF35vYNcBwwgzyZnhYWhyAYceLuY2+7qLxNopsZBpESKCLkPmc3rMWjmphoc3pKPfFVLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fZ4hc4nwkz51Sdl;
	Mon, 16 Mar 2026 14:20:32 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 62G6KF36004235;
	Mon, 16 Mar 2026 14:20:15 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 16 Mar 2026 14:20:17 +0800 (CST)
X-Zmail-TransId: 2b0669b7a121451-2263c
X-Mailer: Zmail v1.0
Message-ID: <20260316142017362R7MOT-xQWGMPiGnD0zuht@zte.com.cn>
In-Reply-To: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn>
References: 20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn
Date: Mon, 16 Mar 2026 14:20:17 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDMvM10gUklTQy1WOiBLVk06IFNwbGl0IGh1Z2UgcGFnZXMgZHVyaW5nIGZhdWx0IGhhbmRsaW5nIGZvciBkaXJ0eSBsb2dnaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 62G6KF36004235
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 16 Mar 2026 14:20:32 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B7A130.002/4fZ4hc4nwkz51Sdl

From: Wang Yechao <wang.yechao255@zte.com.cn>

During dirty logging, all huge pages are write-protected. When the guest
writes to a write-protected huge page, a page fault is triggered. Before
recovering the write permission, the huge page must be split into smaller
pages (e.g., 4K). After splitting, the normal mapping process proceeds,
allowing write permission to be restored at the smaller page granularity.

If dirty logging is disabled because migration failed or was cancelled,
only recover the write permission at the 4K level, and skip recovering the
huge page mapping at this time to avoid the overhead of freeing page tables.
The huge page mapping can be recovered in the ioctl context, similar to x86,
in a later patch.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/gstage.c | 56 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 5356abb18932..4bee042f3c7f 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -163,6 +163,21 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 	return 0;
 }

+static int kvm_riscv_gstage_update_pte_prot(pte_t *ptep, pgprot_t prot)
+{
+	pte_t new_pte;
+
+	if (pgprot_val(pte_pgprot(ptep_get(ptep))) == pgprot_val(prot))
+		return 0;
+
+	new_pte = pfn_pte(pte_pfn(ptep_get(ptep)), prot);
+	new_pte = pte_mkdirty(new_pte);
+
+	set_pte(ptep, new_pte);
+
+	return 1;
+}
+
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
@@ -171,6 +186,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 {
 	pgprot_t prot;
 	int ret;
+	pte_t *ptep;
+	u32 ptep_level;
+	bool found_leaf;

 	out_map->addr = gpa;
 	out_map->level = 0;
@@ -203,6 +221,44 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 		else
 			prot = PAGE_WRITE;
 	}
+
+	found_leaf = kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &ptep_level);
+	if (found_leaf) {
+		/*
+		 * ptep_level is the current gstage mapping level of addr, out_map->level
+		 * is the required mapping level during fault handling.
+		 *
+		 * 1) ptep_level > out_map->level
+		 * This happens when dirty logging is enabled and huge pages are used.
+		 * KVM must track the pages at 4K level, and split the huge mapping
+		 * into 4K mappings.
+		 *
+		 * 2) ptep_level < out_map->level
+		 * This happens when dirty logging is disabled and huge pages are used.
+		 * The gstage is split into 4K mappings, but the out_map level is now
+		 * back to the huge page level. Ignore the out_map level this time, and
+		 * just update the pte prot here. Otherwise, we would fall back to mapping
+		 * the gstage at huge page level in `kvm_riscv_gstage_set_pte`, with the
+		 * overhead of freeing the page tables(not support now), which would slow
+		 * down the vCPUs' performance.
+		 *
+		 * It is better to recover the huge page mapping in the ioctl context when
+		 * disabling dirty logging.
+		 *
+		 * 3) ptep_level == out_map->level
+		 * We already have the ptep, just update the pte prot if the pfn not change.
+		 * There is no need to invoke `kvm_riscv_gstage_set_pte` again.
+		 */
+		if (ptep_level > out_map->level) {
+			kvm_riscv_gstage_split_huge(gstage, pcache, gpa,
+						    out_map->level, true);
+		} else if (ALIGN_DOWN(PFN_PHYS(pte_pfn(ptep_get(ptep))), page_size) == hpa) {
+			if (kvm_riscv_gstage_update_pte_prot(ptep, prot))
+				gstage_tlb_flush(gstage, ptep_level, out_map->addr);
+			return 0;
+		}
+	}
+
 	out_map->pte = pfn_pte(PFN_DOWN(hpa), prot);
 	out_map->pte = pte_mkdirty(out_map->pte);

-- 
2.27.0
