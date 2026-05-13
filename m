Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2443D6CAE;
	Wed, 13 May 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658097; cv=none; b=rJhzI68U7RpUszE+DPeSBx4m4m7opRTovIi4Lcoe0dO1coQg8OWcY/bG8JyCM/F22FknR8s4IC1nvGHcz5Tu+70+8WfP4Gu7rSFJ0yZsrvwFuprAdHB/ll8JLMO0YiYUWOqhvDH8Ova/5WV4oWkdVG3xLM98dVKp9TGzukM9XCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658097; c=relaxed/simple;
	bh=ueZ/oET2+Kl1fM7gHo3GZCfnAHIqGlrK7bXx78z9Q8k=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=tAlkf312GMvL9MfAmTt6tBNBJt2iJL01rMuT0z9gbBvOeOC1nrhFGcnr+3F0g5O2xlBcODI2eMBUR0fT3uNY2c9MOPuwODuQINA1oNGgagBGSXeR/dv94e+wQsfuwHwSfR75EOupEyoyiOq2l6kU45k8WUrZylokJnIDVEPsZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gFllL0ctXz8Xs6v;
	Wed, 13 May 2026 15:41:34 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 64D7fMim055036;
	Wed, 13 May 2026 15:41:22 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 13 May 2026 15:41:25 +0800 (CST)
X-Zmail-TransId: 2b036a042b2582b-ace00
X-Mailer: Zmail v1.0
Message-ID: <20260513154125023xfKNqfea7TklqO9_RRrkt@zte.com.cn>
In-Reply-To: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn>
References: 20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn
Date: Wed, 13 May 2026 15:41:25 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNF0gUklTQy1WOiBLVk06IFNwbGl0IGh1Z2UgcGFnZXMgd2hlbiBkaXJ0eSBsb2dnaW5nIGlzwqBlbmFibGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 64D7fMim055036
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 13 May 2026 15:41:34 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A042B2E.000/4gFllL0ctXz8Xs6v

From: Wang Yechao <wang.yechao255@zte.com.cn>

Split huge pages eagerly when enabling dirty logging. The goal is to
avoid doing it while faulting on write-protected pages, which
negatively impacts guest performance.

The benefits of eager page splitting are the same as in x86 and arm64,
added with commit a3fe5dbda0a4 ("KVM: x86/mmu: Split huge pages mapped
by the TDP MMU when dirty logging is enabled") and commit e7bf7a490c68
("KVM: arm64: Split huge pages when dirty logging is enabled")

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/mmu.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 85a3fb2622a4..14c558ee5f15 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -90,6 +90,50 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
 	spin_unlock(&kvm->mmu_lock);
 }

+static bool need_topup_split_caches_or_resched(struct kvm_mmu_memory_cache *cache,
+					       int count)
+{
+	if (need_resched())
+		return true;
+
+	return kvm_mmu_memory_cache_nr_free_objects(cache) < count;
+}
+
+/* the caller must held mmu lock */
+static void kvm_riscv_split_huge_pages(struct kvm_gstage *gstage,
+				       phys_addr_t start, phys_addr_t end,
+				       bool flush)
+{
+	struct kvm *kvm = gstage->kvm;
+	struct kvm_mmu_memory_cache *pcache = &kvm->arch.split_page_cache;
+	int count = gstage->pgd_levels;
+	phys_addr_t addr = start;
+	int ret;
+
+	while (addr < end) {
+		if (need_topup_split_caches_or_resched(pcache, count)) {
+			spin_unlock(&kvm->mmu_lock);
+			cond_resched();
+
+			ret = kvm_mmu_topup_memory_cache(pcache, count);
+			if (ret) {
+				kvm_err("Failed to toup split page cache\n");
+				spin_lock(&kvm->mmu_lock);
+				return;
+			}
+			spin_lock(&kvm->mmu_lock);
+		}
+
+		ret = kvm_riscv_gstage_split_huge(gstage, pcache, addr, 0, flush);
+		if (ret != 0) {
+			kvm_err("split huge page for addr(0x%llx) failed %d\n", addr, ret);
+			break;
+		}
+
+		addr += PMD_SIZE;
+	}
+}
+
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					     struct kvm_memory_slot *slot,
 					     gfn_t gfn_offset,
@@ -136,6 +180,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	spin_unlock(&kvm->mmu_lock);
 }

+static void kvm_riscv_split_memory_region(struct kvm *kvm, int slot)
+{
+	struct kvm_memslots *slots = kvm_memslots(kvm);
+	struct kvm_memory_slot *memslot = id_to_memslot(slots, slot);
+	phys_addr_t start = memslot->base_gfn << PAGE_SHIFT;
+	phys_addr_t end = (memslot->base_gfn + memslot->npages) << PAGE_SHIFT;
+	struct kvm_gstage gstage;
+
+	kvm_riscv_gstage_init(&gstage, kvm);
+
+	spin_lock(&kvm->mmu_lock);
+	kvm_riscv_split_huge_pages(&gstage, start, end, false);
+	spin_unlock(&kvm->mmu_lock);
+
+	kvm_flush_remote_tlbs_memslot(kvm, memslot);
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
@@ -150,6 +211,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
+		kvm_riscv_split_memory_region(kvm, new->id);
 	}
 }

-- 
2.27.0
