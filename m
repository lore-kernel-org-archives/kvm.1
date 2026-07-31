Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D853B27F7;
	Fri, 31 Jul 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489374; cv=none; b=JgnSu5xEgJmn1W/SEyQMcWAqzXNnkWrf3/+1vXxpaLgz9jSE0wSUHmWPFHyVl0hUbUQ9Y7IMovmpxSW/r1NH3qZT6aVbgwozEIvy5HXFAVGnpGdCegfJ73tAvwe7HZ/OMDulcNImeWIgsHL9ttj1T1hM68Z5Wl6it1nAP3u810w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489374; c=relaxed/simple;
	bh=Cyta+rVK/Or3/NdrZhNGcMVhyiJUOjlkGQGciqPITB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGKAWLXAmFGuDizQMwVTUaH1AqXg3huPDg7GFLSj1atWi2+d5+8TmdguHyjl/h248jsk8qWj4nZsjqT1a6t6EHHNPQ645xhsr26xCyZXhzDSu3otWjQzeYZ62auXYd5y+4lhQUC02Eq6Y/btPu+JVhhlbcEr3LZadaXsnLLZ5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hBL5z5jTnz57HS5;
	Fri, 31 Jul 2026 17:16:07 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 66V9Fsox003236;
	Fri, 31 Jul 2026 17:15:54 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 31 Jul 2026 17:15:56 +0800
X-Zmail-TransId: 3e816a6c67cc010-3c182
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
Subject: [PATCH v5 3/5] RISC-V: KVM: Remove redundant TLB flush operations
Date: Fri, 31 Jul 2026 17:12:08 +0800
Message-ID: <20260731091215.1549430-4-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
References: <20260731091215.1549430-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 66V9Fsox003236
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 31 Jul 2026 17:16:07 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C67D7.001/4hBL5z5jTnz57HS5

The function kvm_arch_mmu_enable_log_dirty_pt_masked() is invoked from
two distinct call paths:

kvm_clear_dirty_log_protect()
  kvm_arch_mmu_enable_log_dirty_pt_masked()

kvm_vm_ioctl_reset_dirty_pages()
  kvm_dirty_ring_reset()
    kvm_reset_dirty_gfn()
        kvm_arch_mmu_enable_log_dirty_pt_masked()

In both scenarios, the caller already performs a remote TLB flush after
dirty logging is enabled, so the TLB flush inside
kvm_arch_mmu_enable_log_dirty_pt_masked() is unnecessary. Remove it.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/mmu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2362eeb6c08a5..5a93cffa9ad7f 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -163,14 +163,15 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	phys_addr_t start = (base_gfn +  __ffs(mask)) << PAGE_SHIFT;
 	phys_addr_t end = (base_gfn + __fls(mask) + 1) << PAGE_SHIFT;
 	struct kvm_gstage gstage;
-	bool flush;
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
-	flush = kvm_riscv_gstage_wp_range(&gstage, start, end);
-	if (flush)
-		kvm_flush_remote_tlbs_range(kvm, start >> PAGE_SHIFT,
-					    (end - start) >> PAGE_SHIFT);
+	kvm_riscv_gstage_wp_range(&gstage, start, end);
+
+	/*
+	 * remote TLB flush is not needed here since callers of
+	 * kvm_arch_mmu_enable_log_dirty_pt_masked() already do it.
+	 */
 }
 
 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
-- 
2.39.3

