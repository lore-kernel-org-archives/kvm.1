Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5D29DB6C
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379517; cv=none; b=XHqCgr88h72Xote2RmxPq3TnmflWAISKaF6ZJfJRxLlXq5Hbe05IKmW4Va/oydbz+ijCHqddQIf2/C3hWaGI8GcQlZsCI+YFjRQrlK7kuXl83Dgi67ttB1SloyBxNX8cr1bI3ytn/3Cchcfs/5B6rNme6YhD/nxGxggI6kKD6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379517; c=relaxed/simple;
	bh=CZ2rrIc94GJdpkfHUQSCzR62mwlcDJg4NwjiezgSD08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=We+RxGIvIGbXOvBvMNJIv2s0/Rn/AbMk8kGC9NTExuBVX9CBdRFFW8QRYnOFE3U1kTvgtM6aYSnw1SxV+q++O4rh2E29A+eTeaJJXikF+7k0TeqvED6gVlzY/Uot/YGBFzYPC7wcoFGD0nim6Hfi3O+8b+AXO0nK9r78mio9O0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYzoQtcg; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYzoQtcg"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so1003568a91.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785379515; x=1785984315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=meJSQ04WBiDIRj28ufTGbhmrt28uHJ+jjo+yeu158ak=;
        b=XYzoQtcgfLGrYVPAWqty7lilSN+5kgz87dS32OHaP3DMB6FapRMoinrxcLLj/v/wzN
         PFzJCJ/dDliXMbIATQnYe1/4f+kr3VWZwOh1/7Ad+9PiaaJe1d/qhJRwpFetYNX4TGmN
         zO5F/AARxYQsjt3R2O/qey9NYTo2R4VWyc1D8kvCP3DLq/AjSE/Ey+RitTRqWu38Di6e
         yb2slQLgzRFmGpDSy85snMINGcWf8EHKtZqhABlYPs6xfh+IF9YjcfQw1l1+HYvIfv0Q
         80hs8jpg2+wicVsFwJTUe1AzneVGWn2Cg6e8ayVFvFYxu8JuhGW9CZ0HO6tNt+OqBw3Q
         Mxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785379515; x=1785984315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=meJSQ04WBiDIRj28ufTGbhmrt28uHJ+jjo+yeu158ak=;
        b=WRI5iMepmWVgOmjN6DhhTP5lApm6Io3dVAPq1X9d0hz6T/FBDIP7M6v2uOk/aKfRvW
         Wi1rN8mNIbFY7RYeSGclz9Q83WjvLWjmztEEliHf7Jt73Gc+E74kM7mKix5nOWc1UXKQ
         CrVgvIZKu0Ikw9EOXK2tbuGBpU37hFM1BIfcAi11UYvFeKg/d6ZkFvJipWi49EbWVOHx
         vqMsdM5T9C5RHKxbshizDGTmNQxTnjenLmX4baha59fCQRctUTwPHRhIXVMjgQJevTTp
         YoBQ1J+aW1WR1z+H4/hoNf4txaiIZWXFjj54hNqkg4CgUQ5rxI6blI/zah+Od2jT8GSL
         bu4A==
X-Gm-Message-State: AOJu0Yy7k+9ZcaY4XiV9XPGnCanp0B0qFX7VzNOSQpVz5Uhb4SOHz4d8
	2/fPwT7TBZbTxXU5NEYMnZOLMLEX+JTKCIPMEUlCgRuNBOHp5aSOpPW81CUcEzY9308=
X-Gm-Gg: AR+sD115txducc3uoaIRD9PBrEPPIkPLFIZAQm3h1FYMK3OUgSJj+9udp1bXmKgK6KL
	QeqlRv/TfNU84Rj8skl2Z5Qq3q4qQaGmtmRni0mAFM5T8zkyBpofKLIzFYrHrdmIgLSZcXBzt2q
	uMtgBlpZziLY4+AG46DRkc5mhtI90ZN++X0lTMTzI23JoQO/1INCtVTWQzbdHO/9VFpmUeXnMFy
	z/S2N3HjwMVgMgaGOqVGCtiBJk0J9ppLgPjM8frTAxWw4fWg5JTeiO0/DpfcAf52qx/efSBY282
	0k3Lub4tVroHZ3nwYRkEOsbwBTZgKXzFmwZl8wd1Zfo6uAk6sPpK1SS0qqDRoJNslDGv2hdXADK
	7AIDiQvinZSX8VVL8a4heyIm34h+9tEB6AJ49n6T9e4Fdjn61qgwirD9ENB0Wf6V5gJVF2F7i/F
	n8DhJIVp0pXF3vDTNchvxLw+FsfQ486EotCauj7H2G1otXHyXUnA2aU1zNwcuBKqilMxqi3RxSh
	xo=
X-Received: by 2002:a17:90b:52cc:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38f9bef3409mr874083a91.24.1785379514730;
        Wed, 29 Jul 2026 19:45:14 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9babbf90sm221489a91.14.2026.07.29.19.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:45:14 -0700 (PDT)
From: "Bingyu.Xian" <shanbeeyoo@gmail.com>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: linux-riscv@lists.infradead.org,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH v2] RISC-V: KVM: Add minimal guest_memfd support
Date: Thu, 30 Jul 2026 10:45:10 +0800
Message-ID: <20260730024510.1063290-1-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729070756.730312-1-shanbeeyoo@gmail.com>
References: <20260729070756.730312-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal guest_memfd support for RISC-V KVM, following the same

pattern as x86 and arm64.

1. Select KVM_GUEST_MEMFD in Kconfig

2. In kvm_riscv_mmu_map(), check kvm_slot_has_gmem() early, before

   taking mmap_read_lock(). For gmem memslots, resolve the PFN via

   kvm_gmem_get_pfn(), then acquire kvm->mmu_lock and jump to G-stage

   mapping, bypassing vma_lookup()/__kvm_faultin_pfn(). The gmem PFN

   is resolved before mmap_read_lock() so the mmu_lock taken for the

   mapping is never held while waiting for mmap_lock, which would

   deadlock against mmu_notifier invalidation (mmu_lock -> mmap_lock).

3. Skip kvm_release_faultin_page() for gmem pages; their lifetime is

   managed by the gmem inode and invalidation notifier.

4. Skip hva lookup and validity check in gstage_page_fault() for gmem,

   which does not have a userspace VMA backing it.

Changes since RFC v1:

  - Add vcpu_exit.c hva lookup bypass for gmem slots

  - Call kvm_prepare_memory_fault_exit() on gmem fault failure

  - Respect KVM_MEM_READONLY for gmem slot writability

  - Skip THP adjustment for gmem (only PAGE_SIZE supported)

  - Skip dirty tracking for gmem (handled by gmem notifier)

  - Replace goto with is_gmem variable for cleaner flow


Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu.Xian <shanbeeyoo@gmail.com>
---
 arch/riscv/kvm/Kconfig     |   1 +
 arch/riscv/kvm/mmu.c       | 134 +++++++++++++++++++++++--------------
 arch/riscv/kvm/vcpu_exit.c |  17 ++++-
 3 files changed, 99 insertions(+), 53 deletions(-)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..77121100579f 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_GUEST_MEMFD
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d2a06a54be17..5d37d8a93a1d 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -551,6 +551,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	unsigned long vma_pagesize, mmu_seq;
 	struct kvm_gstage gstage;
 	struct page *page;
+	int max_order;
+	bool is_gmem;
 
 	kvm_riscv_gstage_init(&gstage, kvm);
 
@@ -568,60 +570,79 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		return ret;
 	}
 
-	mmap_read_lock(current->mm);
-
-	vma = vma_lookup(current->mm, hva);
-	if (unlikely(!vma)) {
-		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
-		mmap_read_unlock(current->mm);
-		return -EFAULT;
-	}
+	is_gmem = kvm_slot_has_gmem(memslot);
+	if (is_gmem) {
+		/*
+		 * For guest_memfd-backed slots, bypass the userspace VMA lookup
+		 * and get the PFN directly from the guest_memfd inode.
+		 */
+		ret = kvm_gmem_get_pfn(kvm, memslot, gfn, &hfn, &page, &max_order);
+		if (ret) {
+			kvm_prepare_memory_fault_exit(vcpu, gpa, PAGE_SIZE,
+						      is_write, false, false);
+			return ret;
+		}
 
-	is_hugetlb = is_vm_hugetlb_page(vma);
-	if (is_hugetlb)
-		vma_pageshift = huge_page_shift(hstate_vma(vma));
-	else
-		vma_pageshift = PAGE_SHIFT;
-	vma_pagesize = 1ULL << vma_pageshift;
-	if (logging || (vma->vm_flags & VM_PFNMAP))
 		vma_pagesize = PAGE_SIZE;
-	else if (is_hugetlb)
-		vma_pagesize = hugetlb_mapping_size(memslot, hva, vma_pagesize);
+		writable = !(memslot->flags & KVM_MEM_READONLY);
+		/* gmem faultin does not go through mmu notifier invalidation */
+		mmu_seq = kvm->mmu_invalidate_seq;
+	} else {
+		mmap_read_lock(current->mm);
 
-	/*
-	 * For hugetlb mappings, vma_pagesize might have been reduced from the
-	 * VMA size to a smaller safe mapping size.
-	 */
-	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
-		gfn = ALIGN_DOWN(gpa, vma_pagesize) >> PAGE_SHIFT;
+		vma = vma_lookup(current->mm, hva);
+		if (unlikely(!vma)) {
+			kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
+			mmap_read_unlock(current->mm);
+			return -EFAULT;
+		}
 
-	/*
-	 * Read mmu_invalidate_seq so that KVM can detect if the results of
-	 * vma_lookup() or __kvm_faultin_pfn() become stale prior to acquiring
-	 * kvm->mmu_lock.
-	 *
-	 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
-	 * with the smp_wmb() in kvm_mmu_invalidate_end().
-	 */
-	mmu_seq = kvm->mmu_invalidate_seq;
-	mmap_read_unlock(current->mm);
+		is_hugetlb = is_vm_hugetlb_page(vma);
+		if (is_hugetlb)
+			vma_pageshift = huge_page_shift(hstate_vma(vma));
+		else
+			vma_pageshift = PAGE_SHIFT;
+		vma_pagesize = 1ULL << vma_pageshift;
+		if (logging || (vma->vm_flags & VM_PFNMAP))
+			vma_pagesize = PAGE_SIZE;
+		else if (is_hugetlb)
+			vma_pagesize = hugetlb_mapping_size(memslot, hva, vma_pagesize);
 
-	if (vma_pagesize != PUD_SIZE &&
-	    vma_pagesize != PMD_SIZE &&
-	    vma_pagesize != PAGE_SIZE) {
-		kvm_err("Invalid VMA page size 0x%lx\n", vma_pagesize);
-		return -EFAULT;
-	}
+		/*
+		 * For hugetlb mappings, vma_pagesize might have been reduced from the
+		 * VMA size to a smaller safe mapping size.
+		 */
+		if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
+			gfn = ALIGN_DOWN(gpa, vma_pagesize) >> PAGE_SHIFT;
 
-	hfn = __kvm_faultin_pfn(memslot, gfn, is_write ? FOLL_WRITE : 0,
-				&writable, &page);
-	if (hfn == KVM_PFN_ERR_HWPOISON) {
-		send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
-				vma_pageshift, current);
-		return 0;
+		/*
+		 * Read mmu_invalidate_seq so that KVM can detect if the results of
+		 * vma_lookup() or __kvm_faultin_pfn() become stale prior to acquiring
+		 * kvm->mmu_lock.
+		 *
+		 * Rely on mmap_read_unlock() for an implicit smp_rmb(), which pairs
+		 * with the smp_wmb() in kvm_mmu_invalidate_end().
+		 */
+		mmu_seq = kvm->mmu_invalidate_seq;
+		mmap_read_unlock(current->mm);
+
+		if (vma_pagesize != PUD_SIZE &&
+		    vma_pagesize != PMD_SIZE &&
+		    vma_pagesize != PAGE_SIZE) {
+			kvm_err("Invalid VMA page size 0x%lx\n", vma_pagesize);
+			return -EFAULT;
+		}
+
+		hfn = __kvm_faultin_pfn(memslot, gfn, is_write ? FOLL_WRITE : 0,
+					&writable, &page);
+		if (hfn == KVM_PFN_ERR_HWPOISON) {
+			send_sig_mceerr(BUS_MCEERR_AR, (void __user *)hva,
+					vma_pageshift, current);
+			return 0;
+		}
+		if (is_error_noslot_pfn(hfn))
+			return -EFAULT;
 	}
-	if (is_error_noslot_pfn(hfn))
-		return -EFAULT;
 
 	/*
 	 * If logging is active then we allow writable pages only
@@ -639,12 +660,20 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	 * Check if we are backed by a THP and thus use block mapping if
 	 * possible. Hugetlb mappings already selected their target size above,
 	 * so do not promote them through the THP helper.
+	 *
+	 * Skip THP adjustment for gmem, which only supports PAGE_SIZE mappings
+	 * and does not have a valid hva for follow_pte().
 	 */
-	if (!logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
+	if (!is_gmem && !logging && !is_hugetlb && vma_pagesize == PAGE_SIZE)
 		vma_pagesize = transparent_hugepage_adjust(kvm, memslot, hva, &hfn, &gpa);
 
 	if (writable) {
-		mark_page_dirty_in_slot(kvm, memslot, gfn);
+		/*
+		 * Skip dirty page tracking for gmem; page dirtying is handled
+		 * via the gmem invalidation notifier and page cache.
+		 */
+		if (!is_gmem)
+			mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
 						vma_pagesize, false, true, out_map);
 	} else {
@@ -658,7 +687,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 		kvm_err("Failed to map in G-stage\n");
 
 out_unlock:
-	kvm_release_faultin_page(kvm, page, ret, writable);
+	/*
+	 * Skip kvm_release_faultin_page() for gmem pages; their lifetime is
+	 * managed by the gmem inode and invalidation notifier.
+	 */
+	if (!is_gmem)
+		kvm_release_faultin_page(kvm, page, ret, writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 28cf9b27bb07..5c381a4f9977 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -26,10 +26,21 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	fault_addr = ((gpa_t)trap->htval << 2) | (trap->stval & 0x3);
 	gfn = fault_addr >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(vcpu->kvm, gfn);
-	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
 
-	if (kvm_is_error_hva(hva) ||
-	    (trap->scause == EXC_STORE_GUEST_PAGE_FAULT && !writable)) {
+	/*
+	 * For guest_memfd-backed slots, bypass the hva lookup and validity check
+	 * since gmem does not have a userspace VMA backing it.
+	 */
+	if (kvm_slot_has_gmem(memslot)) {
+		hva = 0;
+		writable = !(memslot->flags & KVM_MEM_READONLY);
+	} else {
+		hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
+	}
+
+	if (!kvm_slot_has_gmem(memslot) &&
+	    (kvm_is_error_hva(hva) ||
+	     (trap->scause == EXC_STORE_GUEST_PAGE_FAULT && !writable))) {
 		switch (trap->scause) {
 		case EXC_LOAD_GUEST_PAGE_FAULT:
 			return kvm_riscv_vcpu_mmio_load(vcpu, run,
-- 
2.54.0

