Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42559385D69;
	Wed, 24 Jun 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288364; cv=none; b=Py7+vE5VJF0eNDPgsWhZF+x9HSaN6LkUfnTwWPQtayncEn1Z/WQdJLNbNmYJFO0YA10WQcNsJ8zIfSapVt8KWj37JQD8Jsdt3gK7A/LTTdoGQ/uSVPe0QF00D1v3QZXsxcSOzhBhtAR20qv2B/ckrxz6Im3Romrykvn1A+6jJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288364; c=relaxed/simple;
	bh=nalQKdsxlaSVvncWmIaTy5YAULsoICUtn471AcrjqqA=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=VIh4FXg5bRIN+NcEYRCXa92a4aJKFpWbWnnrQrpCzeLAWqMV1Q5J9fEE4cSjcU3HF7Qx3DJ8UspcH6E3Jttn9TSiILBePFCGQi+WKeRT+JJaiiqi3JHrGCPs6OHqMwGu2C76Hoz7O0AqiNKYJUUhs6QARrBtiCgrGvrPB+16FUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4glZJ82GXgz5B11h;
	Wed, 24 Jun 2026 16:06:00 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 65O85pNv082678;
	Wed, 24 Jun 2026 16:05:51 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 24 Jun 2026 16:05:53 +0800 (CST)
X-Zmail-TransId: 2b076a3b8fe19e0-254cf
X-Mailer: Zmail v1.0
Message-ID: <20260624160553981H6ohuNq_2dotOBuS6RYpA@zte.com.cn>
In-Reply-To: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
References: 20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn
Date: Wed, 24 Jun 2026 16:05:53 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@linux.dev>, <alex@ghiti.fr>, <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?wqBbUEFUQ0ggdjMgUkVTRU5EIDEvNV0gUklTQy1WOiBLVk06IEFkZCB0aGUgc3BsaXQgcGFnZSBjYWNoZSBmb3IgaW9jdGwgY29udGV4dA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65O85pNv082678
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 24 Jun 2026 16:06:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B8FE8.000/4glZJ82GXgz5B11h

From: Wang Yechao <wang.yechao255@zte.com.cn>

Add the split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 1 +
 arch/riscv/kvm/vm.c               | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 60017ceec9d2a..69f73fd106a94 100644
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
index 082f9b2617338..9cf69bc28b9c5 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -676,6 +676,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 	kvm->arch.pgd = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
 	kvm->arch.pgd_levels = kvm_riscv_gstage_max_pgd_levels;
+	kvm->arch.pgd_split_page_cache.gfp_zero = __GFP_ZERO;

 	return 0;
 }
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index a9f083feeb767..be38f24a297d6 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -54,6 +54,12 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_destroy_vcpus(kvm);

 	kvm_riscv_aia_destroy_vm(kvm);
+
+	/*
+	 * Free the split page cache after all vCPUs and devices are destroyed.
+	 * At this point, there are no concurrent accesses to the cache.
+	 */
+	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }

 int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irql,
-- 
2.43.5
