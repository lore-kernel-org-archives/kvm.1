Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465E1F4634
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783660755; cv=none; b=ZGPWh4fbjlLCbBFyrQYhGQoOg56d5r4s9+BGVQUjqmRW5uMIAQxvg0Vs+HFQqejBYtr3Bby4Z7Yha/guvPzFCA9ZVM2Z6aW9ErUqKi8tm1cxheAUyzX0BHRUmE6APKR0pf4x3XH3BbTfPLEX5VR4Q1hzAv7SpiW6I5aScPshS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783660755; c=relaxed/simple;
	bh=0KSW3zDpc5xjdOZYLS2EKpZnHgDZG7q++I5iUZ66rQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2QqdjRBxfk7ZFptP+RV6xjXZRDVtKFG7hwr3/0nSUbyCBpPWntv2y+3YQ8FRM575jB/cyRpO4PD2OWHv4CWITf6XIs9+KxJk2xPbRrrtWhzrTH9hIUWe+lSk7sfUQqGR6hG1UPWLHfirTFEt7nxQoS+jPAOjaqz5QX5dC1w1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4Q3mXkE; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4Q3mXkE"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c9fe62e0da3so190362a12.1
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 22:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783660753; x=1784265553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eaT2VzoKRrCEsQJsGJsh7iwXPoQA/5ukSwz33vQMgQA=;
        b=s4Q3mXkE+apWitPhjE6XeJUbXF8abS9z0PGyHBnOA16aPJIvXotXD7+T08PyH8ENYX
         pf6KU3UCp4KgECZwrqUviYZvPQDyCrmjff2GVfm789S9zHfLGDDexjZ+vPYWWY9nh597
         NoRs4SKA0pnVytxPqSo4OdG0GqKQe/px+7KH6RehwCgrFgjNmW632d98FwA0rG1x8LHQ
         kxT6ObVeoOnNu5gGIT8EeANVWd5DEy6seHhALA9Gp1EkjLQ3Eb6dQDwtxc8HEinK5fpq
         NkXh3Nrq1YR6EwiN52Ju5cfazI75514RHKFBXpP/dpON+5bX5vSZLlLUbMSxsJC2yn3l
         FelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783660753; x=1784265553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eaT2VzoKRrCEsQJsGJsh7iwXPoQA/5ukSwz33vQMgQA=;
        b=jFa4AvgKra64zpFUNWDsYIlQ2Z71N2GUj5dDT9gMimZSR7rVv/gfgFUU55kTIaRdRs
         FlzRYqMX/kvo9gNyKA+sM9zZB6eLIAkx6g/hGnjy98PZthAqrTbZUQRpHcYtE7IxB3Qi
         tdtbG0tKjXjG1naZ/3j3UPpBqyZ4H4mJjyVHHWNBYSRWJX+ed3YPvrwOYcbMWkCD40cf
         +vt7Y4uqx56qSWSI1/01lAI5lSb4zNS1qmb6gAv3t1Nahh7kgZQn+6IfO8Cpj/+U2dzl
         WGH/UKxcZvDqxtY4//PxdfCBFFXMYQoUcJNVX4DPtsjg26hCgv3voSdejj6e+hZIOgmF
         EDkg==
X-Forwarded-Encrypted: i=1; AHgh+RrO407nL9NnmzD+GFwKD0dvzdmkLm7wF94KwP5WB/G3gb3p70LAzamLDI7NtAAhBxzyksE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1W6F1FT3Bd2s+PfB/XDrQqD4wNrQoM9sBG4HWh//1w0cuYeas
	gIHAPau680qVCCibiRfZrG+lIF9v02rPD8dxe0CJTugafjkI+yEVk79y
X-Gm-Gg: AfdE7ckUpcGKHeYc/EiGhoz2EVTVcrvmTTpdaieJM94t8SA05oHc4Vb5H5VG9vc6gB6
	XkA/srt4heyuIuT1yd7lkTmJisVDG3+2XG76BAlvNlufMN3LRVhX8Qle0s7udgzQKveu1JEbiVj
	q1x5540u1aMvv9CunOejUynvB1lLlDwM+mdcM7i+yvBlnCsNyVrNO19QtqX3AcTbF9SXwrXj/d2
	ALIQQ5vm/gbXMLVtX8wGH4f7+XKNhEmiBumOvPyXemkJ1NTmMDkvVn5Hkvkci7Oq09fYBlLQoLa
	QXsud/X0rE3bOXaHBCjJDBNRRyGAYqT1G0kjAOpfDAHZ4bbeu3oK3AwrLEjk34DhlXFWptb9E/y
	xoAc4n8s3dbi+zhhyNgqsoBBeapk2Sbv8PweHOPyuB+VR0BEtZPLpb1xbiDJqvPAcJG8W+5Vy4j
	KETo13C17JbI4ImQ+IXFN0VWAktunuq168lbqZbQ==
X-Received: by 2002:a05:6a00:451a:b0:842:6a3b:60d1 with SMTP id d2e1a72fcca58-84842f01e28mr10330536b3a.31.1783660752671;
        Thu, 09 Jul 2026 22:19:12 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483dc66f2asm3970019b3a.24.2026.07.09.22.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:19:12 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: anup@brainfault.org
Cc: atish.patra@linux.dev,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	"Bingyu.Xian" <Shanbeeyoo@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	"bingyu.xian" <shanbeenyoo@gmail.com>
Subject: [PATCH RFC v2] KVM: riscv: Allow G-stage PMD block mappings for VM_PFNMAP
Date: Fri, 10 Jul 2026 13:19:03 +0800
Message-ID: <20260710051903.3454598-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Bingyu.Xian" <Shanbeeyoo@gmail.com>

RISC-V KVM currently forces all VM_PFNMAP faults to PAGE_SIZE, so a
256 MB VFIO BAR requires 65 536 G-stage PTEs instead of 128 PMD blocks.
This becomes critical as RISC-V targets server workloads with GPU/NPU
VFIO passthrough and the RISC-V IOMMU nears mainstream support.

Adapt arm64's "stage-2 block mapping for host device MMIO" idea
(commit 2aa53d68cee6) but with a safer approach: instead of deriving
the host physical address from vma->vm_pgoff (unreliable since the
VFIO unmap_mapping_range() changes), pfnmap_mapping_size() walks the
host page tables via get_hva_mapping_size().  If the host mm installed
a PMD leaf, physical contiguity is guaranteed and KVM uses a 2 MB
G-stage block; otherwise it falls back to 4 KB as before.

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

Changed from v1:
- https://lore.kernel.org/kvm/20260709153000.1-1-shanbeenyoo@gmail.com/
1. Drop the cover letter, merge into a single patch
2. Simplify the commit message to focus on functionality
3. Add Co-developed-by and Assisted-by tags
4. Fix the sign-off chain order

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: bingyu.xian <shanbeenyoo@gmail.com>
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

