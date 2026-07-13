Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CE35A3BF
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927303; cv=none; b=JFxOTcgoAaLjZJfXSdDCj9AiFLfVBA1CpL+rsymoSalClBBeupwYBCt/IwOkO2iv7e/SWVdb9j0+jXryQL54c7VLVgEKjMw7Iuu+FZ+NVN+HqMTOU1FA4/Io2jq1lvVJ1BVbekkpXSqaTqDuDf3d8vQgBpc7+eGkuWATybqudFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927303; c=relaxed/simple;
	bh=0GN9jdsp5y+GN7usd3hPGt5G7dPiAcDDERv3sy7M2go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkRUNjBbSjP71lpfEwtqBUSEKH6f8wMbKP9uBcwKvQbGgn+IbqQs0DOFFvpP4GT0ZiVbkWL1Yiaj7m1S/lYtjIC9ghNbgx/VI68wJNBYy2ebL8uqbBoYHZL0vc4nGCYqhqiisRwZu7i5ZbrlCiW6yr2Ta9c/V68jiq9RGzjjMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9G8uXF7; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9G8uXF7"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so17232795ad.0
        for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 00:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783927300; x=1784532100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uoXDjnnGnfjdjZLeKSIkqLVfLmi5f0feB1W9q0yXDSk=;
        b=N9G8uXF7PU2YLF4vQNVA1PMnApcytLp4YAhpzUvF9Wllh+9yLFrVBCn+d/2qvFY3TP
         SvIRzhBQdwYCxo3Tg5W6v6FxC9lO/NuTtmFQaZ1gQ3Hk9N9qYZU1f+wOpRfWJceeDapN
         E22Ou/odsDbWuWX+K8BbL61oZpx4g2dwlttTfVKWB1BM1tNTRtuzxsY6Td30PhxTqRSB
         2WQ6pJmx1G7gvC3nsrQxR78kzjHUE5e14xNhyzH3xru7HntkCPfVgLHSD93hLOxODKOK
         p1YMbAk4JwuJmy73HCHcjtPJcj9YS7VHpQT89NV10pf8NbjCyw7blgqQTfZMRabv5RZM
         z72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927300; x=1784532100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uoXDjnnGnfjdjZLeKSIkqLVfLmi5f0feB1W9q0yXDSk=;
        b=Tc6rULMh5r08ka49VN9vVqs7nGxxfL8veQCOMOCX2NSykyUA0FUTvqPze7+TYTxRfP
         Bwt1mfWInpomces5stEUtnjH3hh27eGryFeTf9AO5EG/DKOlCYNg7k00FOKgOMLJsDfm
         1+aRCDt0bZdLiF2nhFnU78wIQVwysjBygx1ZHxaXyUlReLXIna9FUhUcurGuMKgbtqvw
         e6Tp883nfJcG4sDgu6LZjTm3DSQOy8rBMuh9+Aksc4Yx3BijPhN9E8EXRHm86X5lvIQ1
         Nb7fj9nDR/MkodEEjfhdc+wnlBft4t+yL4h428wTFpuWKPLhvZT5MwIAmggbNSuX4+dB
         mwTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2O7uNztmEdCVH3GLrLIrd+5A27SFiu5BL5Itm6eIouBZ0k8pCZHeL+7y9gMrLfIH8ld0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uJncqJ7KnY9/GR0KNj+/q9/mvDgE7X+VkMH2TIV2WmhG7T/j
	36j6QisBOg1Eo8sXndXBrtCSPI5CnkOuZVVpTMGvjAMxwgSadA8GwNc8
X-Gm-Gg: AfdE7cnPTr4HKW6GhcMfO4nTB5BR+ZM8VUWT4t7JnS9rIQIaL/AWlh2tv/xFw7q69ND
	XBiM8pbxzu7vaAh/Kv45jt6QRyMuya6eLzYyQOLFsDr2wy6Xf1dWShHc51UgVsRtFapBGrk9egV
	QA/FGXfkw8O/bT6nnc8fhVL9tht1G963ONldaEQbs3chOIPD84LwSyWmB7ExSZvSFSrcWAmrdk3
	NoDrmiyPxKdsBmtJJKGSV78M68mN5EwyiIkWZy4JBVcTqyaHd91hecGV6gnRFJZ3DUhJKMt9TYn
	xbf0jWnDDLpvc7pD4B74q/pC0EvtNT9cGlnTaX52s0LdfX2gIH/el/ru6vT/7WYqhGN+1PWUI0m
	E1rp81SGTZmv0BYXrrR7LcJ/q7ReD5bXKE/AlFkPOCli2LkwuguYbwELPu9KEafVAfu2czfFBdr
	9J+hwCB+IS28CtC4kvB1LoFPCkHPfQADW0MZMrNg==
X-Received: by 2002:a17:902:fc45:b0:2ca:e08e:9e70 with SMTP id d9443c01a7336-2ce9f18381dmr80811085ad.46.1783927300494;
        Mon, 13 Jul 2026 00:21:40 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb7e9sm97547295ad.10.2026.07.13.00.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:21:40 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v3] KVM: riscv: Allow G-stage PMD block mappings for VM_PFNMAP
Date: Mon, 13 Jul 2026 15:21:23 +0800
Message-ID: <20260713072123.1591097-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V KVM currently forces all VM_PFNMAP faults to PAGE_SIZE, so a
256 MB VFIO BAR requires 65 536 G-stage PTEs instead of 128 PMD blocks.
This becomes critical as RISC-V targets server workloads with GPU/NPU
VFIO passthrough and the RISC-V IOMMU nears mainstream support.

Adapt arm64's "stage-2 block mapping for host device MMIO" idea from
commit 2aa53d68cee6 ("KVM: arm64: Try stage2 block mapping for host
device MMIO"), but with a safer approach: instead of deriving the host
physical address from vma->vm_pgoff (unreliable since the VFIO
unmap_mapping_range() changes), pfnmap_mapping_size() walks the host page
tables via get_hva_mapping_size().  If the host mm installed a PMD leaf,
physical contiguity is guaranteed and KVM uses a 2 MB G-stage block;
otherwise it falls back to 4 KB as before.

RISC-V has an advantage here: memory type comes from the physical
address PMA, not the G-stage PTE attributes, so 4 KB -> 2 MB promotion
does not alter memory-type semantics.

Also generalize fault_supports_gstage_huge_mapping() to accept a
map_size parameter, fix gfn alignment to use vma_pagesize instead of
huge_page_mask(hstate_vma(vma)) since PFNMAP VMAs are not hugetlb, and
add a kvm_mmu_map tracepoint for debugging.

Conservative for now: only PMD (2 MB), not PUD (1 GB); dirty logging
still forces PAGE_SIZE; falls back whenever contiguity/alignment
cannot be proven.

Tested on QEMU (rv64) with a custom module that installs a PMD leaf
for a VM_PFNMAP VMA: tracepoint confirms 4 KB fallback when host has
no PMD leaf, and 2 MB block mapping when host does.

Assisted-by: YuanSheng:deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu.Xian <shanbeeyoo@gmail.com>
---
Changes from v2:
- https://lore.kernel.org/kvm-riscv/20260710051903.3454598-1-shanbeeyoo@gmail.com/
- Correct the author and Signed-off-by identity to:
  Bingyu.Xian <shanbeeyoo@gmail.com>
- Use the canonical commit-reference and Assisted-by formats.
- No code changes.

 arch/riscv/kvm/mmu.c   | 45 ++++++++++++++++++++++++++++++++++++------
 arch/riscv/kvm/trace.h | 29 +++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..53fb34d4b76d 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -16,6 +16,8 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>
 
+#include "trace.h"
+
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
@@ -286,7 +288,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 }
 
 static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
-					       unsigned long hva)
+					       unsigned long hva, unsigned long map_size)
 {
 	hva_t uaddr_start, uaddr_end;
 	gpa_t gpa_start;
@@ -321,7 +323,7 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 *   e -> g
 	 *   f -> h
 	 */
-	if ((gpa_start & (PMD_SIZE - 1)) != (uaddr_start & (PMD_SIZE - 1)))
+	if ((gpa_start & (map_size - 1)) != (uaddr_start & (map_size - 1)))
 		return false;
 
 	/*
@@ -336,7 +338,7 @@ static bool fault_supports_gstage_huge_mapping(struct kvm_memory_slot *memslot,
 	 * userspace_addr or the base_gfn, as both are equally aligned (per
 	 * the check above) and equally sized.
 	 */
-	return (hva >= ALIGN(uaddr_start, PMD_SIZE)) && (hva < ALIGN_DOWN(uaddr_end, PMD_SIZE));
+	return (hva >= ALIGN(uaddr_start, map_size)) && (hva < ALIGN_DOWN(uaddr_end, map_size));
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
@@ -421,6 +423,31 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
 	return PAGE_SIZE;
 }
 
+/*
+ * Determine the G-stage mapping size for a VM_PFNMAP (e.g. host device
+ * MMIO) fault.  Unlike arm64's original implementation, we never derive the
+ * host physical address from vma->vm_pgoff (which is unreliable since the
+ * VFIO unmap_mapping_range() changes).  Instead we walk the host page tables
+ * via get_hva_mapping_size(): if the host itself installed a leaf block for
+ * this address, physical contiguity within that block is already guaranteed
+ * by the host mm.  The memory type stays correct because RISC-V derives it
+ * from the physical address' PMA, independent of the G-stage PTE size.
+ *
+ * Be conservative for now and only promote to PMD-sized blocks; PUD-sized
+ * device blocks are left as future work.  Fall back to PAGE_SIZE whenever
+ * contiguity or HVA/GPA alignment cannot be proven.
+ */
+static unsigned long pfnmap_mapping_size(struct kvm *kvm,
+					 struct kvm_memory_slot *memslot,
+					 unsigned long hva)
+{
+	if (get_hva_mapping_size(kvm, hva) >= PMD_SIZE &&
+	    fault_supports_gstage_huge_mapping(memslot, hva, PMD_SIZE))
+		return PMD_SIZE;
+
+	return PAGE_SIZE;
+}
+
 int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		      gpa_t gpa, unsigned long hva, bool is_write,
 		      struct kvm_gstage_mapping *out_map)
@@ -465,11 +492,14 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	else
 		vma_pageshift = PAGE_SHIFT;
 	vma_pagesize = 1ULL << vma_pageshift;
-	if (logging || (vma->vm_flags & VM_PFNMAP))
+
+	if (logging)
 		vma_pagesize = PAGE_SIZE;
+	else if (vma->vm_flags & VM_PFNMAP)
+		vma_pagesize = pfnmap_mapping_size(kvm, memslot, hva);
 
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
-		gfn = (gpa & huge_page_mask(hstate_vma(vma))) >> PAGE_SHIFT;
+		gfn = (gpa & ~(vma_pagesize - 1)) >> PAGE_SHIFT;
 
 	/*
 	 * Read mmu_invalidate_seq so that KVM can detect if the results of
@@ -515,6 +545,9 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (!logging && (vma_pagesize == PAGE_SIZE))
 		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
 
+	trace_kvm_mmu_map(gpa, hva, hfn, vma_pagesize,
+			  !!(vma->vm_flags & VM_PFNMAP));
+
 	if (writable) {
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
diff --git a/arch/riscv/kvm/trace.h b/arch/riscv/kvm/trace.h
index 3d54175d805c..db2d28f1d714 100644
--- a/arch/riscv/kvm/trace.h
+++ b/arch/riscv/kvm/trace.h
@@ -56,6 +56,35 @@ TRACE_EVENT(kvm_exit,
 		__entry->htinst)
 );
 
+TRACE_EVENT(kvm_mmu_map,
+	TP_PROTO(unsigned long gpa, unsigned long hva, unsigned long hfn,
+		 unsigned long map_size, bool is_pfnmap),
+	TP_ARGS(gpa, hva, hfn, map_size, is_pfnmap),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, gpa)
+		__field(unsigned long, hva)
+		__field(unsigned long, hfn)
+		__field(unsigned long, map_size)
+		__field(bool, is_pfnmap)
+	),
+
+	TP_fast_assign(
+		__entry->gpa		= gpa;
+		__entry->hva		= hva;
+		__entry->hfn		= hfn;
+		__entry->map_size	= map_size;
+		__entry->is_pfnmap	= is_pfnmap;
+	),
+
+	TP_printk("GPA:0x%lx, HVA:0x%lx, HFN:0x%lx, size:%luKB, pfnmap:%d",
+		__entry->gpa,
+		__entry->hva,
+		__entry->hfn,
+		__entry->map_size >> 10,
+		__entry->is_pfnmap)
+);
+
 #endif /* _TRACE_RSICV_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.54.0
