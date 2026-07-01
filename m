Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B21A42DFEC;
	Wed,  1 Jul 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907882; cv=none; b=V4fqVzMW/Q2JfSN+BXn1kuylustBjblbqk2FQOsYyJ7zeSGr1eGrC2O8d2NAPeOo6LeEcQn2QAykCWArzm3bCBxH0QQf6jaePsR3drpoxio20gjDF6e4m7EeBJZwAJ+TPPrTa0XWTtPZ1HQ+HXykyDfhbV1e5ACF475Up8kTVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907882; c=relaxed/simple;
	bh=7x9fbQ6I3ER0Okq5YSTROPh4J5oktLssGMXIFBjxl3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7BO3ZLkYJq0iQd/SJCBPsr0iY4vnaZFJgodH0mRzYwmSOpd38EYZpUj42GJpeZKMuoxghsJKGq3vnqDHbpOMwh1I0R2PMQRRsWJLP+CHmYmkQcow6q2aNUw2jooHu+ZocwqzSzGthe6zLlBdzoXoPnSxAPQ0IBUr8rJUkc+M9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gqzPw0jlrz55RJV;
	Wed, 01 Jul 2026 20:11:16 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 661CAxLr077498;
	Wed, 1 Jul 2026 20:10:59 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Wed, 1 Jul 2026 20:11:01 +0800
X-Zmail-TransId: 3e816a4503d5008-1d5ea
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
Subject: [PATCH v4 3/5] RISC-V: KVM: Remove redundant TLB flush operations
Date: Wed,  1 Jul 2026 20:09:46 +0800
Message-ID: <20260701120954.129873-4-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 661CAxLr077498
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 01 Jul 2026 20:11:16 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4503E4.000/4gqzPw0jlrz55RJV

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
---
 arch/riscv/kvm/mmu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 363238efaedb4..056c0abe278af 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -162,14 +162,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
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
 }
 
 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
-- 
2.43.5

