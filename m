Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED423D283;
	Fri, 17 Jul 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275765; cv=none; b=adWgm3/cAR6HAMwwoQiMhp0Gck/hWplVuk58JVhQWvxLOf9dvmr8xT7ChE97wAUeM4O+kYX92PEadAwhcLEsFc2np8NWpdkuSY+PG+l08KE4ZMu6FXC2mNGt7lUIwZStz7XenyBg7G/00uzwmgmhfrsPCmUk9r1f6xfx+YN/bT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275765; c=relaxed/simple;
	bh=AxM5JgPZ+Po3usv4gS7ne8objY1xdwA4BP0kJWfqnG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mKfgYYcPFukowPSQPQGL4ONwVi3mbZoHa1epmG1h2HNrhvxoXjPTJ5n60ghyiUkQsdJZvWABVPh49Jn3wL5rYTM9yaE6khmsj8ocnykclmxVQggGJgxlyNAMuoejw/vhIS1JU1fEIzQtmMuGvXBjNIPUrxSzHhi+mhYMuwsnMyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h1jHF4n6vz57DCl;
	Fri, 17 Jul 2026 16:09:13 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 66H893dv038215;
	Fri, 17 Jul 2026 16:09:03 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 17 Jul 2026 16:09:05 +0800
X-Zmail-TransId: 3e816a59e32100c-6117a
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
Subject: [PATCH] RISC-V: KVM: Improve dirty log clearing by skipping zero bits in mask
Date: Fri, 17 Jul 2026 16:06:41 +0800
Message-ID: <20260717080654.877151-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 66H893dv038215
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 17 Jul 2026 16:09:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A59E329.001/4h1jHF4n6vz57DCl

The existing kvm_riscv_gstage_wp_range() walks the entire [start, end)
range to apply write protection for dirty log clearing, even when the
provided mask has zero bits (i.e., many GFNs do not need protection).
This leads to unnecessary page table walks when the mask is sparse.

Replace the range-based approach with a new function
kvm_riscv_gstage_wp_pt_masked() that iterates only over the set bits in
the mask. For each set bit, it looks up the leaf PTE and applies write
protection. Once a huge page is encountered, the entire huge-page range
is processed in one go, and the corresponding bits in the mask are cleared
using bitmap_clear().

Performance was measured with KVM selftests dirty_log_perf_test on a
Spacemit k3 host with the following configuration:
- vCPUs: 2 (-v 2)
- Memory: 1GB (-b 1G)
- Iterations: 3 (-i 3)
- Write percentage varied via -w parameter to simulate different
  dirty mask densities.

The following data shows the time spent in the clear-dirty-log phase
(i.e., the KVM_CLEAR_DIRTY_LOG ioctl) under each configuration.

+------------------+------------------+------------------+-------------+
| Write Percentage | Original (s)     | Patched (s)      | Improvement |
+------------------+------------------+------------------+-------------+
| 10%              | 0.012905         | 0.009213         | +28.6%      |
| 30%              | 0.014217         | 0.010287         | +27.6%      |
| 50%              | 0.014606         | 0.011772         | +19.4%      |
| 70%              | 0.014735         | 0.013199         | +10.4%      |
| 100%             | 0.014759         | 0.015294         | -3.6%       |
+------------------+------------------+------------------+-------------+

The performance improvement is most significant when the dirty mask is
sparse (low write percentage), which is common in real-world scenarios
with low to moderate memory write intensity. In the worst-case scenario
where the mask is fully set (100% write), the optimization introduces
a slight 3.6% overhead due to the additional bit operations, which is
acceptable given the substantial gains in common cases.

This change significantly reduces the number of page-table walks when
the dirty mask has many zero bits, improving the efficiency of
KVM_CLEAR_DIRTY_LOG and related ioctls.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_gstage.h |  3 ++
 arch/riscv/kvm/gstage.c             | 59 +++++++++++++++++++++++++++++
 arch/riscv/kvm/mmu.c                |  2 +-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 21e2019df0cf..50c74527ddd2 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -82,6 +82,9 @@ bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 
 bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end);
 
+bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base_gfn,
+				   unsigned long mask);
+
 void kvm_riscv_gstage_mode_detect(void);
 
 static inline unsigned long kvm_riscv_gstage_mode(unsigned long pgd_levels)
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index c4c3b79567f1..9af86b1c5e3c 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -472,6 +472,65 @@ bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 	return flush;
 }
 
+static inline void clear_huge_mask(unsigned long *mask, unsigned long page_size,
+				   gfn_t base_gfn, gpa_t addr)
+{
+	unsigned long start_index = 0;
+	unsigned long end_index = BITS_PER_LONG - 1;
+	unsigned long end_gfn = base_gfn + end_index;
+	unsigned long aligned_start_gfn = addr >> PAGE_SHIFT;
+	unsigned long aligned_end_gfn = aligned_start_gfn + (page_size >> PAGE_SHIFT) - 1;
+	unsigned int nbits = 0;
+
+	if (aligned_start_gfn > base_gfn)
+		start_index = aligned_start_gfn - base_gfn;
+
+	if (aligned_end_gfn < end_gfn)
+		end_index = aligned_end_gfn - base_gfn;
+
+	nbits = end_index - start_index + 1;
+	bitmap_clear(mask, start_index, nbits);
+}
+
+bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t base_gfn,
+				   unsigned long mask)
+{
+	unsigned long page_size;
+	bool flush = false;
+	bool found_leaf;
+	u32 ptep_level;
+	pte_t *ptep;
+	gpa_t addr = 0;
+	int ret;
+
+	while (mask) {
+		addr = (base_gfn + __ffs(mask)) << PAGE_SHIFT;
+
+		found_leaf = kvm_riscv_gstage_get_leaf(gstage, addr, &ptep, &ptep_level);
+		ret = gstage_level_to_page_size(gstage, ptep_level, &page_size);
+		if (ret)
+			break;
+
+		if (found_leaf) {
+			if (ptep_level) {
+				addr = ALIGN_DOWN(addr, page_size);
+				clear_huge_mask(&mask, page_size, base_gfn, addr);
+			}
+
+			flush |= kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+							 ptep_level, GSTAGE_OP_WP);
+
+			if (ptep_level)
+				continue;
+		}
+
+		/* clear the first set bit*/
+		mask &= mask - 1;
+	}
+
+	return flush;
+}
+
 void __init kvm_riscv_gstage_mode_detect(void)
 {
 #ifdef CONFIG_64BIT
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 082f9b261733..7eab58ff63f9 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -110,7 +110,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
-	flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
+	flush = kvm_riscv_gstage_wp_pt_masked(&gstage, base_gfn, mask);
 	if (flush)
 		kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
 					    (end - start) >> PAGE_SHIFT);
-- 
2.27.0

