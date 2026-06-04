Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE713B293;
	Thu,  4 Jun 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583309; cv=none; b=BWISr4vqRztIEacG6suYkE+/QzNuZwc61lqNSs5S1X10BJzIthVb8mVUEZblBbMl7897ub34KIimwYi10clYbt3Hh143FIXz7N9Usis8vQiJAcAzQz2f5Uunn4Ny5/HDH6JvRiMu4W/upIDXHKYqUOQ6xnAQsJ1lQFFAnrRCTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583309; c=relaxed/simple;
	bh=ivHNBQTGnEQXFYnN8jBy21wmCGtuGwbD5xr0g6kS38w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0I1Eb4sssOrYL8lUugGbGUobE5hcpXc4OEbm+5zwzBRqQepzY8js6PoqZgG7KFaDLtfoD9iLSSWUe6XRZ0oUaBg1abGIK5+Aa4hw1PfariX2jgsymFEEIGCZ0owb/Ke1yxM7tNdwSuzbVaQ75oB/27GMuSTEehge8ocpQ3r84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=azP3yeTY; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="azP3yeTY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4z
	HbRJ4AiR5mFPQ8rQUHGwM8CN+rCT/lxSBfEBPuX4s=; b=azP3yeTYBfb5P9yAXH
	C5vss+RW1tu0+rguZUXsYXjj3LYYwAfmmmuVqkb3szJmBGjJL1CgUEHCa5Pd4ggY
	62HPkR/6lO5TZwCJMmO5LFJuihkBLpZ3iYkLTptXcgjtw/oiScERGM864Ne9QSKF
	ROqFfqC27mjslfOYiSitC4qvU=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3VJAIiyFqSKmLAQ--.50067S3;
	Thu, 04 Jun 2026 22:26:20 +0800 (CST)
From: Jinyu Tang <tjytimi@163.com>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jinyu Tang <tjytimi@163.com>
Subject: [PATCH v2 1/2] KVM: riscv: Check hugetlb block mappings against memslot bounds
Date: Thu,  4 Jun 2026 22:26:01 +0800
Message-ID: <20260604142602.3582602-2-tjytimi@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604142602.3582602-1-tjytimi@163.com>
References: <20260604142602.3582602-1-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3VJAIiyFqSKmLAQ--.50067S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFy7ZF1rAw4Dtw43Gr4fuFg_yoWxJw1DpF
	47Ga15CrW5try3Kr4xAwnru345Zw4rW34UAFyfJa90vrsxKFyagaykAay5XrWrZrn3XF4x
	ZFsxZFWUurZ0g3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_AwI7UUUUU=
X-CM-SenderInfo: xwm13xlpl6il2tof0z/xtbC8QzIQWohiwxZhQAA3k

RISC-V KVM has used the hugetlb VMA size directly as the G-stage
mapping size since stage-2 page table support was added. That is safe
only if the block covered by the fault is fully contained in the
memslot and the userspace address has the same offset as the GPA
within that block.

The THP path already checks those constraints before installing a PMD
block mapping. The hugetlb path did not, so an unaligned memslot could
make KVM install a PMD or PUD sized G-stage block that covers memory
outside the slot or maps the wrong host pages.

Pass the target mapping size into fault_supports_gstage_huge_mapping().
The same helper can be used for both THP PMD mappings and hugetlb
PMD/PUD mappings.

Select hugetlb mapping sizes through the same memslot-boundary check,
falling back from PUD to PMD to PAGE_SIZE. When a smaller hugetlb
mapping size is selected, fault the GFN aligned to that selected size
instead of the original VMA size.

Also keep hugetlb mappings out of transparent_hugepage_adjust(). Once
the hugetlb path has chosen PAGE_SIZE, promoting it again through the
THP helper would miss the hugetlb fallback decision.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Signed-off-by: Jinyu Tang <tjytimi@163.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
v1 -> v2:
  - Squash the helper parameterization into this hugetlb fix.
  - Use the ALIGN()/ALIGN_DOWN() form suggested by Nutty Liu and Anup
    for the memslot boundary check.

 arch/riscv/kvm/mmu.c | 54 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024..0adf017a2 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -286,7 +286,8 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 }
 
 static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
-					       unsigned long hva)
+					       unsigned long hva,
+					       unsigned long map_size)
 {
 	hva_t uaddr_start, uaddr_end;
 	gpa_t gpa_start;
@@ -300,8 +301,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 
 	/*
 	 * Pages belonging to memslots that don't have the same alignment
-	 * within a PMD for userspace and GPA cannot be mapped with g-stage
-	 * PMD entries, because we'll end up mapping the wrong pages.
+	 * within a huge page for userspace and GPA cannot be mapped with
+	 * g-stage block entries, because we'll end up mapping the wrong pages.
 	 *
 	 * Consider a layout like the following:
 	 *
@@ -321,7 +322,7 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 *   e -> g
 	 *   f -> h
 	 */
-	if ((gpa_start & (PMD_SIZE - 1)) != (uaddr_start & (PMD_SIZE - 1)))
+	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
 		return false;
 
 	/*
@@ -336,7 +337,8 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 * userspace_addr or the base_gfn, as both are equally aligned (per
 	 * the check above) and equally sized.
 	 */
-	return (hva >= ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DOWN(uaddr_end, PMD_SIZE));
+	return (hva >= ALIGN(uaddr_start, map_size)) &&
+	       (hva < ALIGN_DOWN(uaddr_end, map_size));
 }
 
 static int get_hva_mapping_size(struct kvm *kvm,
@@ -404,7 +406,7 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 	 * sure that the HVA and GPA are sufficiently aligned and that the
 	 * block map is contained within the memslot.
 	 */
-	if (fault_supports_gstage_huge_mapping(memslot, hva)) {
+	if (fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE)) {
 		int sz;
 
 		sz = get_hva_mapping_size(kvm, hva);
@@ -421,12 +423,33 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
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
@@ -460,16 +483,23 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
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
@@ -511,8 +541,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
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

