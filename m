Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C113BB119;
	Sun, 17 May 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032269; cv=none; b=Gt4wx9GQqs9+EvIdoIRu10slZHQ0iGf2ocmfYVLhjymvaSCYXcX1GjJIv7/CYZOxAQkoVzRQb7pyYT2U+aO7hfBWGdvh+bzpwJoI2RZUOz4/gIAhwtzlRZKTMlGUtpJm2lrGWelsh64BueIhfv7yoxuLOTv3yeOWUiyspruuFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032269; c=relaxed/simple;
	bh=MvXwo4MOq7Z9CPIBfscObm8YkRPHqvIZywS8JjwD+/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGr+BFbLnHqAo9nQoMs5UoyETX8EuFK1X82l9emKGXGHGkaENdYz5s+k6BXao7T+uP+UV8jh3QsM8l5iveqfMTrtdiSsStigt8suU+Z9ijv18HoJl8OrH0gytK8R8NqkBLUblgY/VLxCiOzpMvZomZcdsHg4j1MeWYOoogGYPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZMfBMTY9; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZMfBMTY9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yv
	8yz9RXAgFGizgcfHyJDXAzm7QLNMoZ9qY4PF80Hvs=; b=ZMfBMTY9h+bhGfNVy8
	LSsyccecgon5/Mc1EVL7Pyr5bDV/K5q2BsgIdXVpw4liSrzx0e1nB/difk+oW1+O
	ARpno5X91vLZz4Zk2VOrWk4fUQ5Rzj8AQ9kD7m9UfVSeO8d8qcfP5kKLYTkM9VGN
	TTbdWwYluw9myipi/e2DMatqc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S5;
	Sun, 17 May 2026 23:34:57 +0800 (CST)
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
Subject: [PATCH 3/5] KVM: riscv: Add a G-stage PTE cmpxchg helper
Date: Sun, 17 May 2026 23:34:25 +0800
Message-ID: <20260517153427.94889-4-tjytimi@163.com>
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
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1UKF1xJF4xWFWDCF1kuFg_yoW8tr4fpF
	ZrCrn3Cr4rWFn3Xr1ay3yq9rn8Ca1vgr13Jr9Fvr98AF1avrW8Xryvg39Ivry5JFyrJay3
	uay5Kr1UCr4vywUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziWE_NUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC0AEdlWoJ4CGzBAAA3M

Permission-only G-stage PTE updates can run in parallel once they are
moved to the read side of mmu_lock. Plain set_pte() is not enough for
that case because another CPU may update the same PTE first.

x86 handles the same class of SPTE races with cmpxchg-based updates in
its fast page fault and TDP MMU paths. Add a small RISC-V helper for
atomic G-stage PTE updates. The helper reports contention to the caller
and flushes the target range only when the PTE value actually changes.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/include/asm/kvm_gstage.h |  4 ++++
 arch/riscv/kvm/gstage.c             | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index 9c908432b..afe80e4bf 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -54,6 +54,10 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 			     struct kvm_mmu_memory_cache *pcache,
 			     const struct kvm_gstage_mapping *map);
 
+bool kvm_riscv_gstage_try_update_pte(struct kvm_gstage *gstage, u32 level,
+				     gpa_t addr, pte_t *ptep,
+				     pte_t old_pte, pte_t new_pte);
+
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 6f934cb4a..d70584b9e 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -123,6 +123,20 @@ static void gstage_tlb_flush(struct kvm_gstage *gstage, u32 level, gpa_t addr)
 					       gstage->vmid);
 }
 
+bool kvm_riscv_gstage_try_update_pte(struct kvm_gstage *gstage, u32 level,
+				     gpa_t addr, pte_t *ptep,
+				     pte_t old_pte, pte_t new_pte)
+{
+	if (cmpxchg(&ptep->pte, pte_val(old_pte), pte_val(new_pte)) !=
+	    pte_val(old_pte))
+		return false;
+
+	if (pte_val(old_pte) != pte_val(new_pte))
+		gstage_tlb_flush(gstage, level, addr);
+
+	return true;
+}
+
 int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 			     struct kvm_mmu_memory_cache *pcache,
 			     const struct kvm_gstage_mapping *map)
-- 
2.43.0

