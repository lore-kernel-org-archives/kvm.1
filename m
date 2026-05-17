Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B82405C32;
	Sun, 17 May 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032259; cv=none; b=myekS9LcKyP66w957q48fGaVdtyZB5u7gpF8io1LCN7+anBhlkU4e9xRe/3iSR2KSyOPl5wYqCeq/mgE+67+qSaeDvNotqZcT4rL2Js7ppP8eEVidjUpOevyJwx0ni+qOF8edITUJSygBBaFRE7h+HNNWtu0d0bb/+YjZJKvhqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032259; c=relaxed/simple;
	bh=kjWMOo7Pn6qmPuFVc6JV4KnaXbrfUmqodz8+gUYVuFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUXc+Tuzula7R4PyR3EbKSx8apyL/LhueIxUUVZUDCcRWYWbVZpzjFQ8BD1nrKGP5ldW+fas7LpE4n/QbkByfBIU3QIBIuKedlwn4Uz4ffV4crd6fTYVi7w7Y3RvH2h+Iw2IeEF4f9q00EcyDB/lER06O8oM77gbYIjjYJ0WudM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FYbpwpwg; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FYbpwpwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9R
	f9BG0sjCh68FBbnMMLHnS9NUGEPuZsSwjCC3kbcqQ=; b=FYbpwpwgIo0lGzFsbz
	hX6xv1NIJRlP3nRIxVATezqUzgrHq/5A4KXMmIk7VE71SuKpt/Nzxj2A7PWUlEse
	PEr0Mxx1WzszTftHSwhtgQ5/kl7kfwGRTuI7kppv30J+qA3REcVo7NG3BPzHKnFv
	WKsylKbvCCwRW7avekh618u8Y=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S4;
	Sun, 17 May 2026 23:34:55 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH 2/5] KVM: riscv: Use an rwlock for mmu_lock
Date: Sun, 17 May 2026 23:34:24 +0800
Message-ID: <20260517153427.94889-3-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517153427.94889-1-tjytimi@163.com>
References: <20260517153427.94889-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW3uFyfuw1UWw1fXF1DZFb_yoWrZrW7pF
	4q9FZxur1Sqr4kZFZrKF1DZr1DWw4vgw1fJFy5CF95AF4YyrZxZrn29342qr98Jr1xZFZ3
	ZF4DJa45Ar40ywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziGQ6XUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC0B8clGoJ4B+ytQAA3c

RISC-V KVM currently uses a spinlock for mmu_lock. That serializes all
G-stage MMU operations, including permission-only updates that do not
allocate or free page-table pages.

Use KVM's rwlock form of mmu_lock, as x86 and arm64 already do. Keep the
existing map, unmap and teardown paths on the write side. This prepares
RISC-V for read-side handling of G-stage permission updates.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/include/asm/kvm_host.h |  2 ++
 arch/riscv/kvm/gstage.c           |  2 +-
 arch/riscv/kvm/mmu.c              | 24 ++++++++++++------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c..60017ceec 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -48,6 +48,8 @@
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
 
+#define KVM_HAVE_MMU_RWLOCK
+
 #define KVM_DIRTY_LOG_MANUAL_CAPS	(KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
 					 KVM_DIRTY_LOG_INITIALLY_SET)
 
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index d9fe8be2a..6f934cb4a 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -410,7 +410,7 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
 		 * to prevent starvation and lockup detector warnings.
 		 */
 		if (!(gstage->flags & KVM_GSTAGE_FLAGS_LOCAL) && may_block && addr < end)
-			cond_resched_lock(&gstage->kvm->mmu_lock);
+			cond_resched_rwlock_write(&gstage->kvm->mmu_lock);
 	}
 }
 
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 0197e41fc..48f16e52f 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -26,9 +26,9 @@ static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_wp_range(&gstage, start, end);
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 	kvm_flush_remote_tlbs_memslot(kvm, memslot);
 }
 
@@ -65,9 +65,9 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
 		if (ret)
 			goto out;
 
-		spin_lock(&kvm->mmu_lock);
+		write_lock(&kvm->mmu_lock);
 		ret = kvm_riscv_gstage_set_pte(&gstage, &pcache, &map);
-		spin_unlock(&kvm->mmu_lock);
+		write_unlock(&kvm->mmu_lock);
 		if (ret)
 			goto out;
 
@@ -85,9 +85,9 @@ void kvm_riscv_mmu_iounmap(struct kvm *kvm, gpa_t gpa, unsigned long size)
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 }
 
 void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
@@ -131,9 +131,9 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 	kvm_riscv_gstage_unmap_range(&gstage, gpa, size, false);
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 }
 
 void kvm_arch_commit_memory_region(struct kvm *kvm,
@@ -504,7 +504,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (logging && !is_write)
 		writable = false;
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 
 	if (mmu_invalidate_retry(kvm, mmu_seq))
 		goto out_unlock;
@@ -527,7 +527,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 out_unlock:
 	kvm_release_faultin_page(kvm, page, ret && ret != -EEXIST, writable);
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
 
@@ -556,7 +556,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 	struct kvm_gstage gstage;
 	void *pgd = NULL;
 
-	spin_lock(&kvm->mmu_lock);
+	write_lock(&kvm->mmu_lock);
 	if (kvm->arch.pgd) {
 		kvm_riscv_gstage_init(&gstage, kvm);
 		kvm_riscv_gstage_unmap_range(&gstage, 0UL,
@@ -566,7 +566,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
 		kvm->arch.pgd_phys = 0;
 		kvm->arch.pgd_levels = 0;
 	}
-	spin_unlock(&kvm->mmu_lock);
+	write_unlock(&kvm->mmu_lock);
 
 	if (pgd)
 		free_pages((unsigned long)pgd, get_order(kvm_riscv_gstage_pgd_size));
-- 
2.43.0

