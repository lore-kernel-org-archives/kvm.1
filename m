Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5410925B091
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788041; cv=none; b=J7NoC62oDkRLOywr2RTFtjrzfy1puYNj9NXA/e+FrqxoJrKbgfGEbh1MJVsmE95D50CA3bI3stsIvdaDjVtqdCrlA95vlA/jcGxFpFbAKXlhFoastk00hl/lFgR/rrjpuGWccFSGnWFc8vns8/GkW+BefHkmD21uqbTdCYx1Avk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788041; c=relaxed/simple;
	bh=yH/agCXDCZtwBki0zGE0wtxh6FsJiZ2Vyl/5PTnHoLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL2CZl50WRhadseHOhMus1+EWWcQlWdwHFmXHsHAHGN9AsWpr/DSrp5WwwOpY4hyRzzAnQbMXcDhw/v+DVsp9m3GvhayuaOH1Llgh44VY61OhGRBycboded4nMpCBOR5gbv1I+lswQE90LllR0QzMNX9yvI7+kdVpX+BF9JpZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e9/WiNEN; arc=none smtp.client-ip=91.218.175.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e9/WiNEN"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yH/agCXDCZtwBki0zGE0wtxh6FsJiZ2Vyl/5PTnHoLo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786788037; v=1; x=1787392837;
 b=e9/WiNENGmBxAg/5/HArMnlaDDJT+xiPLPZ6u64n1ftppJzFlv7lK/DbjdROLa80AeRjID7e
 ICgjODOvLLKRZQoGLKe9tkljWd75zky2p/Ni7bComTFT6V6TvMiIpU/SHFEDiBL2JPmbZ0IDdh+
 vNSVmfF64yMNSexwO1uEXJh4=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id f94fd8e1c06ad179;
	Sat, 15 Aug 2026 10:00:37 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Yifei Jiang <jiangyifei@huawei.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/5] KVM: riscv: Avoid overwriting G-stage tables with huge leaves
Date: Sat, 15 Aug 2026 06:00:15 -0400
Message-ID: <20260815100019.860693-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815095548.860018-1-jinyu.tang@linux.dev>
References: <20260815095548.860018-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V KVM can overwrite an existing G-stage table entry when
installing a huge leaf mapping. If the target huge range already has a
lower-level page table, kvm_riscv_gstage_set_pte() can replace the
non-leaf entry with a leaf PTE and disconnect the lower-level page
table.

Reject replacing a valid table entry with a leaf PTE. If huge-page
installation hits such a conflict, fall back to a 4K mapping for the
original faulting GPA in the MMU fault path, where the original GPA and
HFN are still available.

Suggested-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 arch/riscv/kvm/gstage.c |  6 ++++++
 arch/riscv/kvm/mmu.c    | 24 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index e5002cb9cbef..54d45addf18f 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -174,6 +174,12 @@ int kvm_riscv_gstage_set_pte(struct kvm_gstage *gstage,
 
 	if (pte_val(*ptep) != pte_val(map->pte)) {
 		bool was_invalid = !pte_val(*ptep);
+
+		/* Avoid replacing an existing lower-level table with a leaf mapping. */
+		if (!gstage_pte_leaf(ptep) && !was_invalid &&
+		    gstage_pte_leaf(&map->pte))
+			return -EEXIST;
+
 		set_pte(ptep, map->pte);
 		if (gstage_pte_leaf(ptep) &&
 		    !(was_invalid && riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)))
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 6035b5ec9503..bfd6168ebe30 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -625,10 +625,11 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      struct kvm_gstage_mapping *out_map)
 {
 	int ret;
-	kvm_pfn_t hfn;
+	kvm_pfn_t fault_hfn, hfn;
 	bool is_hugetlb;
 	bool writable;
 	unsigned int vma_pageshift;
+	gpa_t fault_gpa = gpa;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
 	struct kvm *kvm = vcpu->kvm;
@@ -709,6 +710,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	}
 	if (is_error_noslot_pfn(hfn))
 		return -EFAULT;
+	fault_hfn = hfn + ((fault_gpa >> PAGE_SHIFT) - gfn);
 
 	/*
 	 * If logging is active then we allow writable pages only
@@ -734,9 +736,29 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
 						vma_pagesize, false, true, out_map);
+		if (ret == -EEXIST) {
+			/*
+			 * Retry at 4K granularity for the original faulting GPA
+			 * when a huge leaf cannot replace an existing table.
+			 */
+			ret = kvm_riscv_gstage_map_page(&gstage, pcache, fault_gpa,
+							fault_hfn << PAGE_SHIFT,
+							PAGE_SIZE, false, true,
+							out_map);
+		}
 	} else {
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
 						vma_pagesize, true, true, out_map);
+		if (ret == -EEXIST) {
+			/*
+			 * Retry at 4K granularity for the original faulting GPA
+			 * when a huge leaf cannot replace an existing table.
+			 */
+			ret = kvm_riscv_gstage_map_page(&gstage, pcache, fault_gpa,
+							fault_hfn << PAGE_SHIFT,
+							PAGE_SIZE, true, true,
+							out_map);
+		}
 	}
 
 	if (ret)
-- 
2.43.0

