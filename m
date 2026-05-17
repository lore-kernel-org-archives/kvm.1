Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01C2853E9;
	Sun, 17 May 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032260; cv=none; b=pLv7wORvkzIuFB4gahXkA/bVRFrJafJBm/ZE26JOwJmachMZJnVLI1K5AKae10ZNg0m62gT9QbT9ZQKIViakDeKefZEUe7SgVJyeDMsH8i9rXGzcCBcHlSsAowdQVBQmfSNgMpLh6G7EB0+VThQQ0fHkN5YvNY30s0uWj5YAGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032260; c=relaxed/simple;
	bh=Smt2GzPh5jZaZuZCiDYsUpqYPYFg1Ugjk2i2kU/2gqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekFa/vYLQgoAlRnlunQudrbEoBR1u18QelpdboBpd4hcpo71e/id4oUM+9rPujP03O7OoApGgRpHnuZ7CZAvO3/e9lAqnn5f3Z8dyU5oPmlk6+1zyjLfzAaJzWF9BD8SjoyJgAMeGi0SlMQB62sm2oD7Ffj33jMJdm3Qlto5huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XCIRvp6+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XCIRvp6+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lw
	tr9qnrBOw3mc+mOndsjvgIabpD1HP/zVbnoBZ8j0o=; b=XCIRvp6+25uqtelPhd
	08Wy2KLUDrQSxNSIHUpvOigbgi3wUDyDFiKJW51hkakkAyQJ04RJWSmC3e0+T8zb
	q6MvZAApfU9ESbGtt5zdIHnBQWHtX46dU98CWhsvJ6fUa83f7mE/s4eXt6nbcxbl
	khO7+/FtNysW2p0FwdtnQkjYM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wA3ylwO4AlqyKW7Bw--.10227S7;
	Sun, 17 May 2026 23:35:01 +0800 (CST)
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
Subject: [PATCH 5/5] KVM: riscv: Fast-path dirty logging write faults
Date: Sun, 17 May 2026 23:34:27 +0800
Message-ID: <20260517153427.94889-6-tjytimi@163.com>
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
X-CM-TRANSID:_____wA3ylwO4AlqyKW7Bw--.10227S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4UKw1kCF4Uuw4rZryrJFb_yoW5uF1xpF
	W7K3yY9rWFqF17W34ftwn2vr1Ygws7Wr17JrW3twn8Zrsrtr1Dua1kW347ZF15Jry8Zayf
	ZFs8KrWUCrW093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEmFAXUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8gUelmoJ4CU-TgAA3o

With dirty logging enabled, guest writes often fault on an existing 4K
G-stage leaf that was write-protected only for dirty tracking. The slow
path still performs the full fault handling flow and takes mmu_lock for
write, even though the page-table shape does not change.

x86 handles the analogous case in its fast page fault path by atomically
making a writable SPTE writable again when the fault is only a
write-protection fault. Add the same style of fast path for RISC-V. If a
write fault hits an existing 4K leaf in a writable dirty-log memslot,
mark the page dirty and atomically set the PTE writable and dirty under
the read side of mmu_lock.

The dirty bitmap is updated before the PTE becomes writable again. The
PTE D bit is also set so systems that trap on a clear D bit do not fall
back to the slow path for a writable but clean PTE.

Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/kvm/mmu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 48f16e52f..980059e09 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -419,6 +419,77 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 	return PAGE_SIZE;
 }
 
+static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
+						     struct kvm_memory_slot *memslot,
+						     gpa_t gpa,
+						     struct kvm_gstage_mapping *out_map)
+{
+	struct kvm_gstage gstage;
+	unsigned long mmu_seq;
+	pte_t old_pte, new_pte;
+	pte_t *ptep;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	u32 ptep_level;
+	bool dirty_marked = false;
+	bool ret;
+
+	kvm_riscv_gstage_init(&gstage, kvm);
+	mmu_seq = kvm->mmu_invalidate_seq;
+
+	read_lock(&kvm->mmu_lock);
+
+	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
+		ret = false;
+		goto out_unlock;
+	}
+
+	if (!kvm_riscv_gstage_get_leaf(&gstage, gpa, &ptep, &ptep_level) ||
+	    ptep_level) {
+		ret = false;
+		goto out_unlock;
+	}
+
+	for (;;) {
+		old_pte = ptep_get(ptep);
+		if (!(pte_val(old_pte) & _PAGE_LEAF)) {
+			ret = false;
+			break;
+		}
+
+		if (!dirty_marked) {
+			mark_page_dirty_in_slot(kvm, memslot, gfn);
+			dirty_marked = true;
+		}
+
+		if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) ==
+		    (_PAGE_WRITE | _PAGE_DIRTY)) {
+			new_pte = old_pte;
+			ret = true;
+			break;
+		}
+
+		new_pte = pte_mkdirty(pte_mkwrite_novma(old_pte));
+
+		if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, gpa,
+						    ptep, old_pte, new_pte)) {
+			ret = true;
+			break;
+		}
+		cpu_relax();
+	}
+
+out_unlock:
+	read_unlock(&kvm->mmu_lock);
+
+	if (ret) {
+		out_map->addr = gpa & PAGE_MASK;
+		out_map->level = 0;
+		out_map->pte = new_pte;
+	}
+
+	return ret;
+}
+
 int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      gpa_t gpa, unsigned long hva, bool is_write,
 		      struct kvm_gstage_mapping *out_map)
@@ -442,6 +513,10 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	/* Setup initial state of output mapping */
 	memset(out_map, 0, sizeof(*out_map));
 
+	if (is_write && logging &&
+	    kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map))
+		return 0;
+
 	/* We need minimum second+third level pages */
 	ret = kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
 	if (ret) {
-- 
2.43.0

