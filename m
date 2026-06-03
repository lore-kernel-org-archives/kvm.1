Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C343DA21;
	Wed,  3 Jun 2026 09:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480497; cv=none; b=in+1CwuX26sTD6L4gv0LdtIp8s5dD+0mdB0IwcA7lagRcuOrlO14V2AJ2yyQrz6E9+0q3yjqOX2oNJliOLXS9fWN0HAL+JeEaeHPcP2wXrCBzo/U5LtQeBI2FZd7TkCnYM8FHtVKNBTPcuAoNcAGpR8POjVUJ6paf63SvLkZgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480497; c=relaxed/simple;
	bh=gSrTZC9jxZlCwuNQlqtPIqst/+5F47exvCrWQ/CL/ms=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=BaAIeuWrTnJ1Il1o62EqkXiSUpRPaSv78cQyErkyiIEz8BRZGy97aRRZiNWo0esd+bqf34yYxnr2OyRcOIM+rPFUoS/Zs6PKZErkplk+RbPaBWddPTPTCl1/KMPNrAWkSKExON+ik3C86khYycLtiBGa6dd+uxPhsLNMtASe2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gVjjH10FWz58fdM;
	Wed, 03 Jun 2026 17:54:43 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 6539sa0H073074;
	Wed, 3 Jun 2026 17:54:36 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 3 Jun 2026 17:54:39 +0800 (CST)
X-Zmail-TransId: 2b046a1ff9df49a-28dd2
X-Mailer: Zmail v1.0
Message-ID: <20260603175439237VrPTLz6fG79fXRYAu-JFW@zte.com.cn>
In-Reply-To: <20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn>
References: 20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn
Date: Wed, 3 Jun 2026 17:54:39 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNF0gUklTQy1WOiBLVk06IEFkZCB0aGUgc3BsaXQgcGFnZSBjYWNoZSBmb3IgaW9jdGwgY29udGV4dA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6539sa0H073074
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 03 Jun 2026 17:54:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1FF9E3.000/4gVjjH10FWz58fdM

From: Wang Yechao <wang.yechao255@zte.com.cn>

Add the split page cache for dirty logging enablement and the
KVM_CLEAR_DIRTY_LOG ioctl.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c1bc..0ee778f0f086 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -84,6 +84,7 @@ struct kvm_arch {
 	pgd_t *pgd;
 	phys_addr_t pgd_phys;
 	unsigned long pgd_levels;
+	struct kvm_mmu_memory_cache pgd_split_page_cache;

 	/* Guest Timer */
 	struct kvm_guest_timer timer;
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..0676937bd9a1 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -549,6 +549,7 @@ int kvm_riscv_mmu_alloc_pgd(struct kvm *kvm)
 	kvm->arch.pgd = page_to_virt(pgd_page);
 	kvm->arch.pgd_phys = page_to_phys(pgd_page);
 	kvm->arch.pgd_levels = kvm_riscv_gstage_max_pgd_levels;
+	kvm->arch.pgd_split_page_cache.gfp_zero = __GFP_ZERO;

 	return 0;
 }
@@ -572,6 +573,8 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)

 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
+
+	kvm_mmu_free_memory_cache(&kvm->arch.pgd_split_page_cache);
 }

 void kvm_riscv_mmu_update_hgatp(struct kvm_vcpu *vcpu)
-- 
2.43.5
