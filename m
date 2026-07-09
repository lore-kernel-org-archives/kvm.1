Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DF322097
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602049; cv=none; b=s9j59Dbs1pLGeLbgfk973E15+Hsw0tmDiPdh+91AJoD0uDUUXdH3Mj3aXpAdn0TPz0kqbJ+9qHyAZOSpRu2zMScyUONOIyP1MT+UGVHrUJAn0cr/+amxnlPa6drSCSLoosoMG3koeoE+WG5Sex/Oo5tO8KCiCRmv0bsD3S/aR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602049; c=relaxed/simple;
	bh=qkZ4bFaTj9nADHrRBNOrsMdxxe1M/59ocYmYF8Is0cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVO1NMvJpe7I5NSld/3eVbw/nEHcJL06rCE9bEgNncOAfsAfkmVte6eGPXz+xuHI20e6jhWmtjQP+AglvIUKSJxk1uTbAEyjz1XpSGpZaqRPa186juScWMhvWMLVZB3Aww7jJtmZjksSPQzOtL0pe7KwP7/r6LvQedq31MMr6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ksx4DxZX; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ksx4DxZX"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c8c1ebd68a1so595537a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 06:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783602047; x=1784206847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wAaThcX990kSRtqjacNAU5n1AediKM/mHhnlqDicCA=;
        b=Ksx4DxZXpttn05J1689jPI9az7V6jHiLO7JR/PIYhXuktxhbmV/RjPA+oknohLuzFE
         LLdenCFIfWMnlG9O31Uu46vh6U5mDfoZXvspwyZAKh/QoUzJB1VoGyARQca3IWJDp0fr
         YSWRuTZ2IelPy/seQj+2yOVN41/viUXCoxm5+l4bG1DThe4ZupF/mfgJghSjCHO9S7Ct
         VD+cQs8ENyS3HWL4pQMKd2RuM/5kn4q/rLACahUtoMXJjryTw7atS+8ZLCbxsG3o9yS2
         KxM/f21DEHjiiIRp7sRLjdIRtAYXBo6+MtVrYjODdvcrTIrEmB53L393JPytgLCNtoQI
         uQ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602047; x=1784206847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wAaThcX990kSRtqjacNAU5n1AediKM/mHhnlqDicCA=;
        b=tXdtHTmw4XgnRp5QpLnJw2+Jsw1uS73UqZqEc1ELJlorZ8cexg4W3LuSRxpFM05uDV
         K8hAPA75QCBRtSfsJGrPsliLco6Xedt/n/UGHbGTamm11oqHORTK4BsZAvSA/B/NGcZD
         2mCs10kHXowqJO6plua1zjq2GA7q1hUZMUOxRd90LLieFPCdCOsJNwmTbbZkyqtXMJIx
         vhs1DL8YwJdurybo5/6RN2kq7GMz7VCbOj2WujqxM4dEi29Izy6AM8yQFImOoN4z1MEs
         ebEJPbJnaMHnBcKsYFFGjiLn94ZC6fp7UbR+TKiSm/WlC2cgowOv1WeiNMZIrKVmRcke
         QRow==
X-Forwarded-Encrypted: i=1; AHgh+Rqi9wo0Utu5G2oGH2/yjEXddRcxMVYR1X1pV0LjfC6si9UEpM0TVPTqaou7JSk1KGWZZCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZIybFQ6iGDsqMyo4HfLlFa1vQW9O9Fqbr3N6n2rUpM5xXPza
	6VG2wpdxbIelTey9xbLJq4VSKwOKb3BRNqBYzMM+oXPYP1V8XK7OlsBdU/B2cLzBuEKBCP/lNqQ
	=
X-Gm-Gg: AfdE7ckIvlZcUNcj2Dy+q35Q7irpJJVt/uoraJ9AS1mCNi5zcnS6y+5+O5mxfBGfLXl
	P+CydLb2kq8c1AgtgyiM8pkNhjLb7FfHsa+jE+HhYmtDLbFDxt9ygCINciWAzZM2wlOcsP+4ffw
	aBS1PuoY/VT1WkcPkfABcUKjK8y3D2xW6NmxSZMlflFtmYP/prKJqr3axqS+4J/LQzfyc+gLmDa
	YecdgceDsfuNnXf9jCG7jniJ5dTlrvLPwKoFmhFw3rAu5TXLhyL3DuG4zxzSSEq+2jMiyv1pehQ
	26Oz2sIf71KX0gFvcLyt+mN+j/wRanDVpU4UKxsdsDZBXJLlTMK4RFVnNv3YltO/7tKYBHm7r0S
	TwX1cNeFIc7Aj8wbUsomTWotSniHcCzinKwFUNI0LfyDayZeD1+MrWQXoGLTYc9LzYraidz8ixu
	kSJFPaezH8OAoPSQeG7FOBqFB53iM=
X-Received: by 2002:a05:6a00:e8b:b0:847:8b0f:2508 with SMTP id d2e1a72fcca58-84842ed229bmr6425259b3a.13.1783602047269;
        Thu, 09 Jul 2026 06:00:47 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b975a0sm8752976b3a.14.2026.07.09.06.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 06:00:46 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	"Bingyu.Xian" <Shanbeeyoo@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH RFC 1/1] KVM: riscv: Allow safe G-stage PMD block mappings for VM_PFNMAP
Date: Thu,  9 Jul 2026 21:00:36 +0800
Message-ID: <20260709130036.1708586-2-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709130036.1708586-1-shanbeeyoo@gmail.com>
References: <20260709130036.1708586-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bingyu.Xian" <Shanbeeyoo@gmail.com>

RISC-V KVM currently forces all VM_PFNMAP (device MMIO) faults to
PAGE_SIZE, preventing G-stage block mappings for VFIO-assigned device
BARs:

    if (logging || (vma->vm_flags & VM_PFNMAP))
        vma_pagesize = PAGE_SIZE;

A 256 MB VFIO BAR therefore requires 65 536 G-stage PTEs instead of
128 PMD blocks, incurring excessive G-stage faults, page-table memory
and TLB pressure.

The arm64 patch "Try stage2 block mapping for host device MMIO"
(commit 2aa53d68cee6) addressed this by deriving the host physical
address from vma->vm_pgoff.  However, vma->vm_pgoff is unreliable for
VM_PFNMAP since the VFIO unmap_mapping_range() changes discussed on the
RISC-V list in 2025 ("Remove automatic I/O mapping for VM_PFNMAP").

This patch takes a different, more conservative approach:
pfnmap_mapping_size() walks the host page tables via the existing
get_hva_mapping_size().  If the host mm itself installed a PMD leaf,
physical contiguity within that 2 MB block is already guaranteed and
KVM can safely use a G-stage PMD block.  Otherwise it falls back to
PAGE_SIZE, exactly as before.

RISC-V has a natural advantage here: the memory type is derived from
the physical address' PMA (Physical Memory Attribute), independent of
the G-stage PTE size, so promoting 4 KB -> 2 MB does not alter the
memory-type semantics.  arm64 requires extra care with the stage-2
PTE MemAttr field in this situation.

The eligibility helper fault_supports_gstage_huge_mapping() is
generalized to accept a map_size parameter (previously hardcoded to
PMD_SIZE) so it can be reused for both THP and PFNMAP checks.

The gfn alignment calculation is fixed to use vma_pagesize instead of
huge_page_mask(hstate_vma(vma)), since PFNMAP VMAs are not hugetlb.

A new tracepoint kvm_mmu_map is added to aid debugging and performance
analysis, recording GPA, HVA, HFN, mapping size and whether the fault
was a VM_PFNMAP region.

This first version is conservative:
  - Only PMD (2 MB) blocks, not PUD (1 GB)
  - dirty logging still forces PAGE_SIZE
  - falls back to PAGE_SIZE whenever contiguity/alignment cannot be
    proven

Testing: verified on QEMU (rv64, h=true, sstc=true) with a custom
kernel module that installs a PMD leaf in the host page table for a
VM_PFNMAP VMA.  Tracepoint confirms:
  - anonymous memory:   size=4KB   pfnmap=0  (control)
  - /dev/mem (4KB PTE): size=4KB   pfnmap=1  (safe fallback)
  - PMD leaf module:    size=2048KB pfnmap=1 (block mapping success)
  
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu.Xian <Shanbeeyoo@gmail.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org
---
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

