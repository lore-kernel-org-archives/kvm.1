Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9562044B662;
	Wed,  3 Jun 2026 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480642; cv=none; b=cgkgcBA7uJYecilvM0UahU/2wo/m3Co1GCD5uPZVz1efyXLwHjdATVmKPb/tinNZWXg6/WZdr4R6OQ/J4BowILeLoqVpl4UQ6is3gl9qnYrF9zkCn/ZHKP+uVDzfDo7rT4s7P5wjJ7yafr2QzIblVQbO4EIP7vGgE9ugolbNmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480642; c=relaxed/simple;
	bh=a8Q67XcxXFwHTGPmJupeIsx44hqbBlAQPyj5deyfI0k=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=qzQlSQwcWDhT/5z37HmLJeW74SXqNflXTqq7dhoKnz7KhozLGiXFDlJEM0IyidznUFaYot/5HfDGyOPO7wjLeVyK2vrMyjwY9tF8GcEbKgPqQeeI0/2NOlqw4wtE+cIIPwWPZyEcY57PpMdej1BmkfFHD5y52gm01WOY2+oIA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gVjm82XbWz5B100;
	Wed, 03 Jun 2026 17:57:12 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 6539v0K1077047;
	Wed, 3 Jun 2026 17:57:00 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 3 Jun 2026 17:57:02 +0800 (CST)
X-Zmail-TransId: 2b096a1ffa6e59e-e6f17
X-Mailer: Zmail v1.0
Message-ID: <202606031757028642jwiaL-QePBLGAhMW88zw@zte.com.cn>
In-Reply-To: <20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn>
References: 20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn
Date: Wed, 3 Jun 2026 17:57:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNF0gUklTQy1WOiBLVk06IFNwbGl0IGh1Z2UgcGFnZXMgd2hlbiBkaXJ0eSBsb2dnaW5nIGlzwqBlbmFibGVk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6539v0K1077047
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 03 Jun 2026 17:57:12 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1FFA78.001/4gVjm82XbWz5B100

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
 arch/riscv/kvm/mmu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 0676937bd9a1..51bd1db74e1a 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -90,6 +90,52 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
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
+static void mmu_split_huge_pages(struct kvm_gstage *gstage,
+				 phys_addr_t start, phys_addr_t end,
+				 bool flush)
+{
+	struct kvm *kvm = gstage->kvm;
+	struct kvm_mmu_memory_cache *pcache = &kvm->arch.pgd_split_page_cache;
+	int count = gstage->pgd_levels;
+	phys_addr_t addr = start;
+	int ret;
+
+	lockdep_assert_held(&kvm->mmu_lock);
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
@@ -136,6 +182,23 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 	spin_unlock(&kvm->mmu_lock);
 }

+static void mmu_split_memory_region(struct kvm *kvm, int slot)
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
+	mmu_split_huge_pages(&gstage, start, end, false);
+	spin_unlock(&kvm->mmu_lock);
+
+	kvm_flush_remote_tlbs_memslot(kvm, memslot);
+}
+
 void kvm_arch_commit_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *old,
 				const struct kvm_memory_slot *new,
@@ -150,6 +213,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
+		mmu_split_memory_region(kvm, new->id);
 	}
 }

-- 
2.43.5
