Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1B3E9C1F;
	Wed, 20 May 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290644; cv=none; b=ifozwnB0ZnmWUDy0CCUEo/bd8m4Px9A2cDvaHxiA9ZNjcGwozr7eTGwxlpF0jtv2h3pRtuJr+RGNiAt+ZUkgRNSI/uDiPL1I2q9Ur1NbhbOhmRB6rViYbgVJnIHl7NB0NF4RdjNdKASHrZRcDIdZLdZvzEUu4+7gj99mOCz4hWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290644; c=relaxed/simple;
	bh=J1Sg/9mFLTkNGvw1ZNWf/BPPEMfKYcH9OSOouWb68L8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnoSU2NVM02JlJW6lNA7lePl3iOZa/y43gtGtyLNbgaP1m7M8n9+lQPGE6tlBtKD47sUK5OXlr4ZOZcMXTACXOG9XjigCKsrExoDHwgEfAthtuxD8zpej75nloqwHCxtqbuc1Zx/EiGKTvM4NCBCZEI3R6giIV3MKZhgP69x5cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YZnsArVi; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YZnsArVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/z
	kQTR9t64J9IX8/nWNTNSFT80BAb+Oq9++KrZ9yIJA=; b=YZnsArVi0ik5XMVehW
	D3S00NvrGi2rRl7o+pj0D4YTL13SSCsvYJnI4wINGNRhbZwARx+VN+/+oZAN+1Ho
	Aw3f5U3Lc7YACS3QAvoN/AyPhKdk6uMh76uTDDdJfPoSro0n3pt/2kpaZKa/cYqP
	0pfG2IHIf0VbVl/3qBP7YFbHo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAnt1md0Q1qGHMGCg--.33359S4;
	Wed, 20 May 2026 23:22:11 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <apatel@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm <kvm@vger.kernel.org>,
	kvm-riscv <kvm-riscv@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
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
Subject: [PATCH 2/3] KVM: riscv: Check hugetlb block mappings against memslot bounds
Date: Wed, 20 May 2026 23:21:47 +0800
Message-ID: <20260520152148.131272-3-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520152148.131272-1-tjytimi@163.com>
References: <20260520152148.131272-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnt1md0Q1qGHMGCg--.33359S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF4fXF17JF4kZF1ftryxKrg_yoWrGFW5pF
	WUGa15Cw45Kry3Kr1fJw1DZ3s0vws5W3WUAFyfJa90vrnxJayaga98Xa45XrWrArn3XFWI
	vFsxZrWDurZ0g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziQJ5rUUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8gN68moN0aMcwAAA3w

RISC-V KVM has used the hugetlb VMA size directly as the G-stage
mapping size since stage-2 page table support was added. That is safe
only if the block covered by the fault is fully contained in the
memslot and the userspace address has the same offset as the GPA
within that block.

The THP path already checks those constraints before installing a PMD
block mapping. The hugetlb path did not, so an unaligned memslot could
make KVM install a PMD or PUD sized G-stage block that covers memory
outside the slot or maps the wrong host pages.

Select hugetlb mapping sizes through the same memslot-boundary check,
falling back from PUD to PMD to PAGE_SIZE. When a smaller hugetlb
mapping size is selected, fault the GFN aligned to that selected size
instead of the original VMA size.

Also keep hugetlb mappings out of transparent_hugepage_adjust(). Once
the hugetlb path has chosen PAGE_SIZE, promoting it again through the
THP helper would miss the hugetlb fallback decision.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Signed-off-by: Jinyu Tang <tjytimi@163.com>
---
 arch/riscv/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 10be8f683..d2378bb1f 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -423,12 +423,33 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 	return PAGE_SIZE;
 }
 
+static unsigned long hugetlb_mapping_size(struct kvm_memory_slot *memslot,
+					  unsigned long hva,
+					  unsigned long map_size)
+{
+	switch (map_size) {
+	case PUD_SIZE:
+		if (fault_supports_gstage_huge_mapping(memslot, hva, PUD_SIZE))
+			return PUD_SIZE;
+		fallthrough;
+	case PMD_SIZE:
+		if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE))
+			return PMD_SIZE;
+		fallthrough;
+	case PAGE_SIZE:
+		return PAGE_SIZE;
+	default:
+		return map_size;
+	}
+}
+
 int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      gpa_t gpa, unsigned long hva, bool is_write,
 		      struct kvm_gstage_mapping *out_map)
 {
 	int ret;
 	kvm_pfn_t hfn;
+	bool is_hugetlb;
 	bool writable;
 	short vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
@@ -462,16 +483,23 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		return -EFAULT;
 	}
 
-	if (is_vm_hugetlb_page(vma))
+	is_hugetlb = is_vm_hugetlb_page(vma);
+	if (is_hugetlb)
 		vma_pageshift = huge_page_shift(hstate_vma(vma));
 	else
 		vma_pageshift = PAGE_SHIFT;
 	vma_pagesize = 1ULL << vma_pageshift;
 	if (logging || (vma->vm_flags & VM_PFNMAP))
 		vma_pagesize = PAGE_SIZE;
+	else if (is_hugetlb)
+		vma_pagesize = hugetlb_mapping_size(memslot, hva, vma_pagesize);
 
+	/*
+	 * For hugetlb mappings, vma_pagesize might have been reduced from the
+	 * VMA size to a smaller safe mapping size.
+	 */
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
-		gfn = (gpa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
+		gfn = ALIGN_DOWN(gpa, vma_pagesize) >> PAGE_SHIFT;
 
 	/*
 	 * Read mmu_invalidate_seq so that KVM can detect if the results of
@@ -513,8 +541,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (mmu_invalidate_retry(kvm, mmu_seq))
 		goto out_unlock;
 
-	/* Check if we are backed by a THP and thus use block mapping if possible */
-	if (!logging && (vma_pagesize == PAGE_SIZE))
+	/*
+	 * Check if we are backed by a THP and thus use block mapping if
+	 * possible. Hugetlb mappings already selected their target size above,
+	 * so do not promote them through the THP helper.
+	 */
+	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
 		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
 
 	if (writable) {
-- 
2.43.0

