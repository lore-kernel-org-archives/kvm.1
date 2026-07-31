Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8621DD525
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513927; cv=none; b=L7sQy1WAA6WUEIFX4Xhb3HE5lfcEwUhvt3aXOMivNR0MONY4DVcDwDjlzxIPZezYeD+UDLHt2B6p4o7ZnVU1ZU2o5z0U+JbVjSaOV+FCj3Ta1n2rm4IzCz9giGQihn8vcIOqNDo5pS1jMbxqem5acCiAYfEPuJ+DvXsROG+/upg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513927; c=relaxed/simple;
	bh=FvAJtRZM3oRNkOyl4bjSYZVL2PnR54k3l10zUVMaLZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elp5aT1sYagIeV+hCLY98sqX9dF5swIZxeAN7F1EAYJ4ysLGHKqTPGgXPScroAEBBhuvHQjt6iuiuOthkTDhBuG4T2vRHZ9zStlgZ+dOYOsOkk59V89xd/UMyCydctAQjIjYdWhxKJ1S+q8Bm9hbJogCdP6fD7wAm+88AXRj6ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZraRqmP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Apd+cy6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZraRqmP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Apd+cy6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785513924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
	b=eZraRqmP/NR3igJCpwgUR2H7AKqcXJEAmwyrSqp3xjfUp5NQjp25J8PEAUG8yY6oX6DSBm
	pQgEBmyPed0/yZX6FKd395F6r/F/stAn2s9YhY+1Hp9rnE7AzQUvQt8DAKCIsIAdwSNVqn
	W+kn9qHFJCRak+kA2NDRRq4LV5bxJxw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-4YR8QW2jNYG69UP1sSi94w-1; Fri, 31 Jul 2026 12:05:23 -0400
X-MC-Unique: 4YR8QW2jNYG69UP1sSi94w-1
X-Mimecast-MFC-AGG-ID: 4YR8QW2jNYG69UP1sSi94w_1785513922
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15ce19923fso104794666b.3
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785513922; x=1786118722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
        b=Apd+cy6X19lX3mptmm4bAoQNsUQBUYGkDFEzqMSCnuNnVNr7JHshQGEl8KUAoS9EG0
         lDBxEMArIFlZwSGR0dTIVnrOKTKybzjdVQ5UDasinFpFAXDeFtESsgqvnpvYmDtMRFb2
         3iVL58HN5hRUDP8ldR7xS/lxk5QtUYjoUjumgKx72h7M2nTCqqCkmV2V5s14WDaP3X5j
         AoUTTSMwQTjw4s4VtC3a4mJXSm0kpq3kZep6nly+02+vTqv6usH059F0dpka0qxYcFni
         QugFxP53x3C3xSvTOEbKu/RLHF9SlEXuwudDwVjfKxwj7f0cyVWdMvjl25ODysV0IX7L
         dayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785513922; x=1786118722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryHo/Pk85RB1et4y6uESf2yi2i/ESrF3Kar7ZIFnpUk=;
        b=mzUzUwhfJWnlFcnez0+qxf0THwJdp9nKsro/KAfamRIhvqLt7abAUoimlOc7YQq05+
         hptr/T5Dy5iClA+f9Xj8Qshbn3QyEpcz0wHUm6ZQ0lNaivht4qHDezLCnfJwC0qxECAM
         Ewt741D2iiG0kP52bX8D10xrD5q/+sQwEeWDPmd7rgsZPLhazbT4Ik1/c6dfY8BpL9l6
         d5jzY13PA0e3f9svRGcKSUW3fmQUDZAgiBPQe+9vePvTX+Pi9XJ1c+0bvjLx3XWDjtf3
         SPTVQGu92AnJb5ZpSylllrc0zEVWXsmoKtMro4Rzdjz7okGnCCnJjqukU77uYpZGWY0y
         DPtw==
X-Forwarded-Encrypted: i=1; AHgh+RoPR63e1ZiW+VGPdbpjnR4fE0Lkoo/i1Uqjv+iEYwYYJsl1Wq0JmYR8isJ53qAM9XhWmN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupwUGaBPSRYqGX3KoQIF7cfta+uTYinxroXqDK3SWrVJnCPfJ
	Ug/ATdN1SvFzx8zQ1mYUQSRVZDthvcQov0K+dhqoDyG6AscP/BYfw1+zlNw9d5dkKx3WcyqBjcw
	MnXcAa9+bzzIDzbcuazXek2xbaM2bD8/XQuD1PRMXu/3hKXPC/oqaGQ==
X-Gm-Gg: AR+sD122JqpPXtXUkPholcmD18C+8FASsxWXpdwEpuUAihdUujs0RgjfmWI/izsqvJ2
	Dy6uwe7yYut1Nm5100xLuEuI4ApBwkcEyY7RwCHDK6PInbCJbtDBnK/aNPFw2zR8iKu9ITHC5U4
	AO5pKMYjHkg3jedcuDqtWqEsj7Zqek35iStpQt6RATcnr0OeCsfqrUnmHK8qin9m8Eld6Tgyua2
	W0Zy+aQcLbwD3Zr5Y74a707j83wDCDFJofUzGETl6+7KZVhyLlbE+HFwvHLPpcuAO2c7s4QIInS
	e3mBU/2kEB9WDComvC8fpAVjET920usKC1Jqmign2MPi0TBeHdIhh4R7UsX1FB/ZOolUsMszyMV
	nYLnwnqv2Dh8e3vZ7YOzPTkvUAd1YkljJHLt4fufEFpjT8rsoSNo0mwVLGRm/DTMqgVayB4wdJK
	WG20c=
X-Received: by 2002:a17:906:ee81:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c1fe8373675mr8933566b.44.1785513921876;
        Fri, 31 Jul 2026 09:05:21 -0700 (PDT)
X-Received: by 2002:a17:906:ee81:b0:c15:9709:fb9b with SMTP id a640c23a62f3a-c1fe8373675mr8929866b.44.1785513921309;
        Fri, 31 Jul 2026 09:05:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd44542d2sm222203766b.35.2026.07.31.09.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:05:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	Fei Li <fei1.li@intel.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	linux-s390@vger.kernel.org,
	linux-mm@kvack.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH] mm: pull writability check to follow_pfnmap_start()
Date: Fri, 31 Jul 2026 18:05:14 +0200
Message-ID: <20260731160514.1101989-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers of follow_pfnmap_start() except s390_pci_mmio_write() are
following it, if they are doing a write, with a check that args.writable
is true; for s390_pci_mmio_write() that's a bug.  Most of them return
-EFAULT if it is not, but because follow_pfnmap_start() returned success,
they do not attempt to upgrade the page from read-only to read-write
with fixup_user_fault().

Pull the check directly into follow_pfnmap_start() through another
input parameter args.write_fault; this eliminates the need to do it in
the caller and, for callers that do use fixup_user_fault(), lets it
attempt to upgrade the page.

The change in return code to -EFAULT is okay:

- s390 is the only one to have a functional change in this respect;
  but EINVAL is only documented for "Invalid length argument", while
  "The address in mmio_addr is invalid" should already return EFAULT
  (https://www.man7.org/linux/man-pages/man2/s390_pci_mmio_read.2.html)

- for VFIO and ACRN, -EFAULT was returned already

- for KVM, -EFAULT is eaten

- for generic_access_phys() the caller is __access_remote_vm()
  which does not care about the error code.

Reported-by: Sergio Lopez <slp@redhat.com>
Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com/
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	Sergio, this is half of the fix for your issue.  Please
	test both patches together if possible.

 arch/s390/pci/pci_mmio.c        |  2 ++
 drivers/vfio/vfio_iommu_type1.c | 17 +++++----
 drivers/virt/acrn/mm.c          | 10 +-----
 include/linux/mm.h              |  3 ++
 mm/memory.c                     | 62 ++++++++++++++++++++-------------
 virt/kvm/kvm_main.c             | 22 ++++++------
 6 files changed, 64 insertions(+), 52 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 51e7a28af899..526f80b8fb3b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -180,6 +180,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	args.address = mmio_addr;
 	args.vma = vma;
+	args.write_fault = true;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, FAULT_FLAG_WRITE, NULL);
@@ -332,6 +333,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 
 	args.vma = vma;
 	args.address = mmio_addr;
+	args.write_fault = false;
 	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		fixup_user_fault(current->mm, mmio_addr, 0, NULL);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..9ee92820b4de 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -541,7 +541,11 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			    unsigned long vaddr, unsigned long *pfn,
 			    unsigned long *addr_mask, bool write_fault)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = vaddr,
+		.write_fault = write_fault
+	};
 	int ret;
 
 	ret = follow_pfnmap_start(&args);
@@ -563,15 +567,10 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			return ret;
 	}
 
-	if (write_fault && !args.writable) {
-		ret = -EFAULT;
-	} else {
-		*pfn = args.pfn;
-		*addr_mask = args.addr_mask;
-	}
-
+	*pfn = args.pfn;
+	*addr_mask = args.addr_mask;
 	follow_pfnmap_end(&args);
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 5bca500a83e0..b057e78ef3f4 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -177,7 +177,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
 		unsigned long start_pfn, cur_pfn;
-		bool writable;
 
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
@@ -188,6 +187,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			struct follow_pfnmap_args args = {
 				.vma = vma,
 				.address = memmap->vma_base + i * PAGE_SIZE,
+				.write_fault = !!(memmap->attr & ACRN_MEM_ACCESS_WRITE),
 			};
 
 			ret = follow_pfnmap_start(&args);
@@ -197,16 +197,8 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 			cur_pfn = args.pfn;
 			if (i == 0)
 				start_pfn = cur_pfn;
-			writable = args.writable;
 			follow_pfnmap_end(&args);
 
-			/* Disallow write access if the PTE is not writable. */
-			if (!writable &&
-			    (memmap->attr & ACRN_MEM_ACCESS_WRITE)) {
-				ret = -EFAULT;
-				break;
-			}
-
 			/* Disallow refcounted pages. */
 			if (pfn_valid(cur_pfn) &&
 			    !PageReserved(pfn_to_page(cur_pfn))) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..34c79b5fcb9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
 	 * Inputs:
 	 * @vma: Pointer to @vm_area_struct struct
 	 * @address: the virtual address to walk
+	 * @write_fault: if true, fail with -EFAULT unless the mapping is
+	 * writable
 	 */
 	struct vm_area_struct *vma;
 	unsigned long address;
+	bool write_fault;
 	/**
 	 * Internals:
 	 *
diff --git a/mm/memory.c b/mm/memory.c
index ff338c2abe92..40997a26846f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6786,12 +6786,15 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
-static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
-				     spinlock_t *lock, pte_t *ptep,
-				     pgprot_t pgprot, unsigned long pfn_base,
-				     unsigned long addr_mask, bool writable,
-				     bool special)
+static inline int pfnmap_args_setup(struct follow_pfnmap_args *args,
+				    spinlock_t *lock, pte_t *ptep,
+				    pgprot_t pgprot, unsigned long pfn_base,
+				    unsigned long addr_mask, bool writable,
+				    bool special)
 {
+	if (!writable && args->write_fault)
+		return -EFAULT;
+
 	args->lock = lock;
 	args->ptep = ptep;
 	args->pfn = pfn_base + ((args->address & ~addr_mask) >> PAGE_SHIFT);
@@ -6799,6 +6802,7 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
 	args->pgprot = pgprot;
 	args->writable = writable;
 	args->special = special;
+	return 0;
 }
 
 static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
@@ -6820,8 +6824,9 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  * @args: Pointer to struct @follow_pfnmap_args
  *
  * The caller needs to setup args->vma and args->address to point to the
- * virtual address as the target of such lookup.  On a successful return,
- * the results will be put into other output fields.
+ * virtual address as the target of such lookup, and optionally set
+ * args->write_fault to require a writable mapping.  On a successful
+ * return, the results will be put into other output fields.
  *
  * After the caller finished using the fields, the caller must invoke
  * another follow_pfnmap_end() to proper releases the locks and resources
@@ -6844,7 +6849,8 @@ static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
  *
  * This function must not be used to modify PTE content.
  *
- * Return: zero on success, negative otherwise.
+ * Return: zero on success, -EFAULT if @args->write_fault was set but the
+ * mapping is not writable, -EINVAL if there is no mapping at all.
  */
 int follow_pfnmap_start(struct follow_pfnmap_args *args)
 {
@@ -6857,6 +6863,7 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pud_t *pudp, pud;
 	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
+	int r = -EINVAL;
 
 	pfnmap_lockdep_assert(vma);
 
@@ -6890,10 +6897,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
-				  pud_pfn(pud), PUD_MASK, pud_write(pud),
-				  pud_special(pud));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pud_pgprot(pud),
+				      pud_pfn(pud), PUD_MASK, pud_write(pud),
+				      pud_special(pud));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	pmdp = pmd_offset(pudp, address);
@@ -6911,10 +6920,12 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 			spin_unlock(lock);
 			goto retry;
 		}
-		pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
-				  pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
-				  pmd_special(pmd));
-		return 0;
+		r = pfnmap_args_setup(args, lock, NULL, pmd_pgprot(pmd),
+				      pmd_pfn(pmd), PMD_MASK, pmd_write(pmd),
+				      pmd_special(pmd));
+		if (r)
+			spin_unlock(lock);
+		return r;
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, address, &lock);
@@ -6923,14 +6934,16 @@ int follow_pfnmap_start(struct follow_pfnmap_args *args)
 	pte = ptep_get(ptep);
 	if (!pte_present(pte))
 		goto unlock;
-	pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
-			  pte_pfn(pte), PAGE_MASK, pte_write(pte),
-			  pte_special(pte));
+	r = pfnmap_args_setup(args, lock, ptep, pte_pgprot(pte),
+			      pte_pfn(pte), PAGE_MASK, pte_write(pte),
+			      pte_special(pte));
+	if (r)
+		goto unlock;
 	return 0;
 unlock:
 	pte_unmap_unlock(ptep, lock);
 out:
-	return -EINVAL;
+	return r;
 }
 EXPORT_SYMBOL_GPL(follow_pfnmap_start);
 
@@ -6972,7 +6985,11 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
-	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = addr,
+		.write_fault = !!(write & FOLL_WRITE)
+	};
 
 retry:
 	if (follow_pfnmap_start(&args))
@@ -6982,9 +6999,6 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	writable = args.writable;
 	follow_pfnmap_end(&args);
 
-	if ((write & FOLL_WRITE) && !writable)
-		return -EINVAL;
-
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 45e784462ec6..0c4ff223162b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2939,8 +2939,11 @@ static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
 static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
 {
-	struct follow_pfnmap_args args = { .vma = vma, .address = kfp->hva };
-	bool write_fault = kfp->flags & FOLL_WRITE;
+	struct follow_pfnmap_args args = {
+		.vma = vma,
+		.address = kfp->hva,
+		.write_fault = !!(kfp->flags & FOLL_WRITE),
+	};
 	int r;
 
 	/*
@@ -2959,7 +2962,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		 */
 		bool unlocked = false;
 		r = fixup_user_fault(current->mm, kfp->hva,
-				     (write_fault ? FAULT_FLAG_WRITE : 0),
+				     (args.write_fault ? FAULT_FLAG_WRITE : 0),
 				     &unlocked);
 		if (unlocked)
 			return -EAGAIN;
@@ -2967,17 +2970,16 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 			return r;
 
 		r = follow_pfnmap_start(&args);
-		if (r)
+		if (r) {
+			if (r == -EFAULT) {
+				*p_pfn = KVM_PFN_ERR_RO_FAULT;
+				return 0;
+			}
 			return r;
-	}
-
-	if (write_fault && !args.writable) {
-		*p_pfn = KVM_PFN_ERR_RO_FAULT;
-		goto out;
+		}
 	}
 
 	*p_pfn = kvm_resolve_pfn(kfp, NULL, &args, args.writable);
-out:
 	follow_pfnmap_end(&args);
 	return r;
 }
-- 
2.55.0

