Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913843AA1B8;
	Fri, 31 Jul 2026 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489371; cv=none; b=biLe8CKkeW8GGtEXR6eEVlPa/1ULnfgex7+fhDsHO1PuH/njl0BYTtopmn+evfOKgIQ4ksOhF0Pa4Dpy7qx3XLZyjtxeDjH6oTl4FmIQ2A+j7ESVhsyWQK6oPd46ckiV3GvuEMhhtX5v5Vaz6MaH6w0jLmTSRwIZdsmBhMa1nXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489371; c=relaxed/simple;
	bh=0pD2O5ILyVl2jiaArY9AYOfqYCR0C+6Xaf5xqUPWbMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4VpPvGnG+p/qyLZMysQiXs1cRyYKRHLW5U4jq2FlV/KX4kwZhPMFSLIuzWHEKBAR4imgAVNa6iKoRi1WZiYVGnyFH6EJq/AL8pcBB4FgtY4LvrFbtRfUuUm9JYG6olbWug/h7Af2kd8/xOjqGF12N5zfvIfb9vQiKy07sJJKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hBL5s0h1gz8Xrrj;
	Fri, 31 Jul 2026 17:16:01 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 66V9Foe5064452;
	Fri, 31 Jul 2026 17:15:50 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 31 Jul 2026 17:15:52 +0800
X-Zmail-TransId: 3e816a6c67c8010-3c14a
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
Subject: [PATCH v5 1/5] RISC-V: KVM: Add the split page cache for ioctl context
Date: Fri, 31 Jul 2026 17:12:06 +0800
Message-ID: <20260731091215.1549430-2-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 66V9Foe5064452
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 31 Jul 2026 17:16:01 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C67D1.000/4hBL5s0h1gz8Xrrj

Add the split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index e2d5808169e44..71e455d166905 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -86,6 +86,7 @@ struct kvm_arch {
 	pgd_t *pgd;
 	phys_addr_t pgd_phys;
 	unsigned long pgd_levels;
+	struct kvm_mmu_memory_cache pgd_split_page_cache;
 
 	/* Guest Timer */
 	struct kvm_guest_timer timer;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 8a0aa5e0e216e..2017d292f4ca7 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -677,6 +677,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 	kvm->arch.pgd = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
 	kvm->arch.pgd_levels = kvm_riscv_gstage_max_pgd_levels;
+	kvm->arch.pgd_split_page_cache.gfp_zero = __GFP_ZERO;
 
 	return 0;
 }
@@ -704,6 +705,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 
 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
+
+	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }
 
 void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
-- 
2.39.3

