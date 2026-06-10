Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD383BF673;
	Wed, 10 Jun 2026 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781084374; cv=none; b=gTDdb9YzgKOdXuDDcnonec17Z5dqdPaVCFJ5Ge2OcCHIAPOBZ6EmuvPlb9ayUqH0q23t2m+eLDsm0XWtBqG0xKbTY+S3xQS9Trzu0w9Fs1DpdwTv1ZxgojkRG3JV1gDwA23XvIX3aAyBl+YMAX/yGtRW9FF6ZCZFcorCmAqF8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781084374; c=relaxed/simple;
	bh=/ACs5XlOKyM+BfoVbEzTJw0dXS+KAUDDkfk99T76FH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AeGBuCmWb6jksCMUmJoDNBx9LTzkWHq79Qzl3qo+r8Oe9yj1R0Tml4uO7aoHC95ew8ahRy1fb74WcnV8oFpm8LxiF9IIkLNIzlGr6+10cT/M7BrQhzE3U2luk7gHDYiCoXaeOmj+Ep21ZoXQSPA+GFq7MVtTxXuWPq/i6Blu/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RyYOTxAr; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RyYOTxAr"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781084369; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=GyfQE1u5dCjMDM2v0WiYWSshT6A2JnI5znH7LSfoXSk=;
	b=RyYOTxArk44QVjCovbVPNWgm17eRPTJis3D0ij3NNCYOYYYCscDzvFwnOnkjUq6ysZIn4Rj6GT1pkyBhopDfw52iajP/oYfnhov1XcHHNQ2f1oP8tSN42x0NTErTvQekATobvn/wQbnhO3sImdPenESEKi3zu+sE35iNEh5Mf34=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X4aGPG._1781084366;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X4aGPG._1781084366 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Jun 2026 17:39:28 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>
Cc: guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH] RISC-V: KVM: Avoid redundant page-table allocations in ioremap topup
Date: Wed, 10 Jun 2026 17:39:22 +0800
Message-Id: <20260610093922.51617-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

kvm_riscv_mmu_ioremap() currently tops up its on-stack page-table
cache via kvm_mmu_topup_memory_cache(), which allocates up to
KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE (32) objects per topup.

ioremap only consumes non-leaf page-table pages, at most
pgd_levels - 1 (1 to 4) per call, and for contiguous mappings
within the same huge page the non-leaf pages are allocated once
and reused by subsequent pages. Topping up to 32 objects therefore
triggers many unnecessary GFP_KERNEL_ACCOUNT allocations on every
call, all of which are freed when the function returns. In hot
paths (such as vCPU migration), this creates avoidable allocator
churn and wastes CPU cycles.

Use __kvm_mmu_topup_memory_cache() with a capacity of pgd_levels so
the on-stack cache is sized to the maximum demand of a single
mapping. This removes the redundant allocations and reduces per-call
overhead without changing behavior.

Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..873a5dde4b92 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -39,6 +39,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 	pgprot_t prot;
 	unsigned long pfn;
 	phys_addr_t addr, end;
+	unsigned long pgd_levels = kvm->arch.pgd_levels;
 	struct kvm_mmu_memory_cache pcache = {
 		.gfp_custom = (in_atomic) ? GFP_ATOMIC | __GFP_ACCOUNT : 0,
 		.gfp_zero = __GFP_ZERO,
@@ -61,7 +62,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 		if (!writable)
 			map.pte = pte_wrprotect(map.pte);
 
-		ret = kvm_mmu_topup_memory_cache(&pcache, kvm->arch.pgd_levels);
+		ret = __kvm_mmu_topup_memory_cache(&pcache, pgd_levels, pgd_levels);
 		if (ret)
 			goto out;
 
-- 
2.50.1

