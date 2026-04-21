Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155F3A1E6C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776763522; cv=none; b=E6fC9N1Hb5pTGEc+3pg8qLRJILtq/9h9i+VLdRqJvup62yT+yD90ilKYJ4bowCwESJgGcAU9qCvmA3ac00OoNPDTsoiBgqVIk4fdE8+Se/x7HsInd1Rw9Vw6SrHsrfUu2p5Q+qX1DBC+sgExnCetPgLd1W4fA5XfoR5sDO3U/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776763522; c=relaxed/simple;
	bh=6O9w10R9PumjBOXlRGOZcGuAOn27IfvE7Y5dMyNW/9E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JImAjMkW6cvIUDJ2BaQsf17UByd60oBJR5JvIU9bdGyB8yI+ZVFSuHB2H6hiNWrUFaPjrLGarPdHEhVaJt3dpEqoMAy7ohsCB2fWTHPoZgxKoArdfiRveAJ1P561l99OshaQtAVZ1Yg8voTXv4e6FcoHQaTp2NyvItEKXLn3+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HtR2eQnv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HtR2eQnv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b24fdac394so38162555ad.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776763520; x=1777368320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQRro4iFet5g6RlukJUR9qjzAO0LrmO0ikVc7Fh+rVg=;
        b=HtR2eQnv7/B0c9HHAvYO7J7Yyo9UA5/tOYscCx+Pw8s+g7SDtwkSpqheO95yZWvTBo
         fkeRGZgBXR81MKu2ZDMklv1xEa26t7gvRhqIvTk9ZileGUY3JoQR6EelaIGlDDs/2AUc
         3+p+u0h7M8EOpPTUde8Hlu8nexjU6qeABsfvm+pP8u4pprXPYpjKWaYqy0FWRszyfKJC
         R0JY+hTteMhHdEdxDI4qNmamKo7MVXo7HFZob9fNMnTpYSci6ztGrcsXoLF98tX0736s
         0+B14WPiETfmEx0rqUh9jrvJNN9AsXSQor1pJY8HJoJOGo7l5z75/tqZuQBcVrabWaX1
         2ZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776763520; x=1777368320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jQRro4iFet5g6RlukJUR9qjzAO0LrmO0ikVc7Fh+rVg=;
        b=sQyQhz6qRwilWnOSGlEUuSSMjTP3H8K23nRvEWVghY225mxQy2FNaqB58DUzHCaY1R
         BgFuVJFWiR7GlpmAE9TOf2ujDHu3P05ViFR/cYV1lmxOCMJAr1VWvk/8+t0JHBruxphk
         WqYqBh/VdupQwkOCvlb7gxIT011fzUxYMRpBd4IYSGPLd9tmt3J1Z+EfRsUgs6TYuP9F
         1P8Xe/Z7JWUwWeY24kY5/799upVSlO94OfSUpn59PhzPYBAE0IQTUGZnG4fkoRAcdDH/
         MQTkCDP6qasc8mxvTItCHKobTrxa6KFiNL+qLCIiGxWhzC/L8TkiU2AM4xQL0IkkkwJv
         R9Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+CWHhKSFaNEdoUjUTQa+fitkSAo5S+5MW58QIJtdLWShX4qqrizT5VhHn8gO9bl3o8bOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0kTD+iwmwj8hd+pLHoICAggBiYbx/com1rFJCjPZ/tzfrZq9
	RzRYeDlZLH7LWuZ6KXvhuj0NY6hbhca4PBsVT5z+KbJMsRosjnY9m/Mlz4Rj71v17wQ=
X-Gm-Gg: AeBDiet3uydHEZtP/jMSaQoR4vHtAJVBd+beDF5FQIyyrhy2K+Qu2mUzhGNMtne/dPd
	VJDq7+BNKdIbtBSWHWqRb939RfyaKUx4bVXzf+KK8zLc+JepVOfxhZoB1KICsTPR8QZhD41GzAO
	YSwF7NvLdNQRwfUEnC9rbtnqhOiD7SbutdXbBaekNtXxM6G3Io2Joki+bbV0l5GQcy2v166v+yU
	F1czmx1+KsETXZorXvEezIhTwChKfiyqOn4oUUsA5a4jqBZQ1m88S3Jq1OhT/xNfrb4kuDmNm1k
	+wmttA+s3runk9Rtc/lICfUW1GD9lLX3H908YhsUCheJJJTZOjHnS9GDbluIm3Gw19QPCdN5ApG
	XYxsc7vCFgStK2Ucnd3JFbqoZ6Fdwjh3Sq/2Wf0fxhjZ1UGTytWQGynP6VhBP8+Ppgw7caDGJBQ
	AHK67i0WLQ9C2PRZ3BjxtzKYpCUKvy66ccaiMA8XPTtfu+7x1sOQpLpvCi+1gWTR79h/MX
X-Received: by 2002:a17:902:9001:b0:2b4:5893:3f3c with SMTP id d9443c01a7336-2b5f9ef4c3fmr117016875ad.13.1776763519593;
        Tue, 21 Apr 2026 02:25:19 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff39csm131965105ad.4.2026.04.21.02.25.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Apr 2026 02:25:19 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	andrew+kernel@donnellan.id.au,
	andreyknvl@gmail.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	apopple@nvidia.com,
	ardb@kernel.org,
	atish.patra@linux.dev,
	baolin.wang@linux.alibaba.com,
	cuiyunhui@bytedance.com,
	david@kernel.org,
	debug@rivosinc.com,
	djordje.todorovic@htecgroup.com,
	dvyukov@google.com,
	elver@google.com,
	glider@google.com,
	ilias.apalodimas@linaro.org,
	junhui.liu@pigmoral.tech,
	kasan-dev@googlegroups.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	liu.xuemei1@zte.com.cn,
	ljs@kernel.org,
	namcao@linutronix.de,
	osalvador@suse.de,
	palmer@dabbelt.com,
	pjw@kernel.org,
	rmclure@linux.ibm.com,
	rostedt@goodmis.org,
	rppt@kernel.org,
	ryabinin.a.a@gmail.com,
	surenb@google.com,
	vincenzo.frascino@arm.com,
	vishal.moola@gmail.com,
	wangruikang@iscas.ac.cn,
	zhangchunyan@iscas.ac.cn
Subject: [PATCH 1/7] riscv: mm: split raw and public PTE helpers
Date: Tue, 21 Apr 2026 17:24:51 +0800
Message-Id: <20260421092457.37649-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260421092457.37649-1-cuiyunhui@bytedance.com>
References: <20260421092457.37649-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce raw PTE helpers prefixed with double underscores for callers
that need direct access to the underlying PTE encoding. These __* helpers
form private low-level primitives, while the existing helpers remain the
public core-MM-facing API that RISC-V can later wrap with additional
architecture-specific semantics without exposing those details to generic
callers.

Switch kernel internal page table users in early boot, KASAN, EFI,
hibernate and pageattr to use the private raw helpers directly.

No functional change intended.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/kfence.h  |  4 +-
 arch/riscv/include/asm/pgtable.h | 87 ++++++++++++++++++++++++++++----
 arch/riscv/kernel/efi.c          |  4 +-
 arch/riscv/kernel/hibernate.c    |  2 +-
 arch/riscv/mm/fault.c            |  4 +-
 arch/riscv/mm/init.c             |  8 +--
 arch/riscv/mm/kasan_init.c       | 14 ++---
 arch/riscv/mm/pageattr.c         | 12 ++---
 arch/riscv/mm/pgtable.c          | 19 ++++++-
 9 files changed, 117 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/kfence.h b/arch/riscv/include/asm/kfence.h
index d08bf7fb3aee6..2bcaeff1167c6 100644
--- a/arch/riscv/include/asm/kfence.h
+++ b/arch/riscv/include/asm/kfence.h
@@ -18,9 +18,9 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 	pte_t *pte = virt_to_kpte(addr);
 
 	if (protect)
-		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
+		__set_pte(pte, __pte(pte_val(__ptep_get(pte)) & ~_PAGE_PRESENT));
 	else
-		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
+		__set_pte(pte, __pte(pte_val(__ptep_get(pte)) | _PAGE_PRESENT));
 
 	preempt_disable();
 	local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a1a7c6520a095..4de1f40fa77ea 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -602,11 +602,18 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  * a page table are directly modified.  Thus, the following hook is
  * made available.
  */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
+static inline void __set_pte(pte_t *ptep, pte_t pteval)
 {
 	WRITE_ONCE(*ptep, pteval);
 }
 
+#define __set_pte __set_pte
+
+static inline void set_pte(pte_t *ptep, pte_t pteval)
+{
+	__set_pte(ptep, pteval);
+}
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte);
 
 static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
@@ -619,8 +626,8 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pteval, unsigned int nr)
+static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
 
@@ -632,31 +639,61 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
-#define set_ptes set_ptes
+
+#define __set_ptes __set_ptes
+
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, pte_t pteval, unsigned int nr)
+{
+	__set_ptes(mm, addr, ptep, pteval, nr);
+}
+
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
+{
+	__set_pte_at(mm, ptep, __pte(0));
+}
 
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
-	__set_pte_at(mm, ptep, __pte(0));
+	__pte_clear(mm, addr, ptep);
+}
+
+#define __ptep_get __ptep_get
+static inline pte_t __ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
+#define __ptep_get_lockless __ptep_get_lockless
+static inline pte_t __ptep_get_lockless(pte_t *ptep)
+{
+	return __ptep_get(ptep);
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
 extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				 pte_t *ptep, pte_t entry, int dirty);
+int __ptep_set_access_flags(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep,
+			    pte_t entry, int dirty);
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c */
 bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep);
+bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
+				 unsigned long address, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long address, pte_t *ptep)
+static inline pte_t
+__ptep_get_and_clear(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 #ifdef CONFIG_SMP
 	pte_t pte = __pte(xchg(&ptep->pte, 0));
 #else
 	pte_t pte = *ptep;
 
-	set_pte(ptep, __pte(0));
+	__set_pte(ptep, __pte(0));
 #endif
 
 	page_table_check_pte_clear(mm, address, pte);
@@ -664,9 +701,16 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long address, pte_t *ptep)
+#define __ptep_get_and_clear __ptep_get_and_clear
+
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+				       unsigned long address, pte_t *ptep)
+{
+	return __ptep_get_and_clear(mm, address, ptep);
+}
+
+static inline void
+__ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
 {
 	pte_t read_pte = READ_ONCE(*ptep);
 	/*
@@ -679,6 +723,27 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
+#define __ptep_set_wrprotect __ptep_set_wrprotect
+
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+static inline void ptep_set_wrprotect(struct mm_struct *mm,
+				      unsigned long address, pte_t *ptep)
+{
+	__ptep_set_wrprotect(mm, address, ptep);
+}
+
+static inline pte_t __ptep_clear_flush(struct vm_area_struct *vma,
+				       unsigned long address,
+				       pte_t *ptep)
+{
+	pte_t pte = __ptep_get_and_clear(vma->vm_mm, address, ptep);
+
+	if (pte_accessible(vma->vm_mm, pte))
+		flush_tlb_page(vma, address);
+
+	return pte;
+}
+
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep)
diff --git a/arch/riscv/kernel/efi.c b/arch/riscv/kernel/efi.c
index b64bf1624a052..673eca7705ba5 100644
--- a/arch/riscv/kernel/efi.c
+++ b/arch/riscv/kernel/efi.c
@@ -60,7 +60,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
-	pte_t pte = ptep_get(ptep);
+	pte_t pte = __ptep_get(ptep);
 	unsigned long val;
 
 	if (md->attribute & EFI_MEMORY_RO) {
@@ -72,7 +72,7 @@ static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 		val = pte_val(pte) & ~_PAGE_EXEC;
 		pte = __pte(val);
 	}
-	set_pte(ptep, pte);
+	__set_pte(ptep, pte);
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/hibernate.c b/arch/riscv/kernel/hibernate.c
index 982843828adb7..0360a6f3e1bf2 100644
--- a/arch/riscv/kernel/hibernate.c
+++ b/arch/riscv/kernel/hibernate.c
@@ -186,7 +186,7 @@ static int temp_pgtable_map_pte(pmd_t *dst_pmdp, pmd_t *src_pmdp, unsigned long
 		pte_t pte = READ_ONCE(*src_ptep);
 
 		if (pte_present(pte))
-			set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
+			__set_pte(dst_ptep, __pte(pte_val(pte) | pgprot_val(prot)));
 	} while (dst_ptep++, src_ptep++, start += PAGE_SIZE, start < end);
 
 	return 0;
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 04ed6f8acae4f..fe8b11a8ad143 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -69,7 +69,7 @@ static void show_pte(unsigned long addr)
 	if (!ptep)
 		goto out;
 
-	pte = ptep_get(ptep);
+	pte = READ_ONCE(*ptep);
 	pr_cont(", pte=%016lx", pte_val(pte));
 	pte_unmap(ptep);
 out:
@@ -231,7 +231,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * silently loop forever.
 	 */
 	pte_k = pte_offset_kernel(pmd_k, addr);
-	if (!pte_present(ptep_get(pte_k))) {
+	if (!pte_present(__ptep_get(pte_k))) {
 		no_context(regs, addr);
 		return;
 	}
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index decd7df40fa42..86321b093d252 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -376,9 +376,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	ptep = &fixmap_pte[pte_index(addr)];
 
 	if (pgprot_val(prot))
-		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
+		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
 	else
-		pte_clear(&init_mm, addr, ptep);
+		__pte_clear(&init_mm, addr, ptep);
 	local_flush_tlb_page(addr);
 }
 
@@ -1558,11 +1558,11 @@ static void __meminit remove_pte_mapping(pte_t *pte_base, unsigned long addr, un
 			next = end;
 
 		ptep = pte_base + pte_index(addr);
-		pte = ptep_get(ptep);
+		pte = __ptep_get(ptep);
 		if (!pte_present(*ptep))
 			continue;
 
-		pte_clear(&init_mm, addr, ptep);
+		__pte_clear(&init_mm, addr, ptep);
 		if (is_vmemmap)
 			free_vmemmap_storage(pte_page(pte), PAGE_SIZE, altmap);
 	}
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c4a2a9e5586e7..0c2f5e8e48063 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -39,9 +39,9 @@ static void __init kasan_populate_pte(pmd_t *pmd, unsigned long vaddr, unsigned
 	ptep = pte_offset_kernel(pmd, vaddr);
 
 	do {
-		if (pte_none(ptep_get(ptep))) {
+		if (pte_none(__ptep_get(ptep))) {
 			phys_addr = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
-			set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
+			__set_pte(ptep, pfn_pte(PFN_DOWN(phys_addr), PAGE_KERNEL));
 			memset(__va(phys_addr), KASAN_SHADOW_INIT, PAGE_SIZE);
 		}
 	} while (ptep++, vaddr += PAGE_SIZE, vaddr != end);
@@ -327,8 +327,8 @@ asmlinkage void __init kasan_early_init(void)
 		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
-		set_pte(kasan_early_shadow_pte + i,
-			pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
+		__set_pte(kasan_early_shadow_pte + i,
+			  pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
@@ -523,9 +523,9 @@ void __init kasan_init(void)
 		       kasan_mem_to_shadow((const void *)MODULES_VADDR + SZ_2G));
 
 	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(&kasan_early_shadow_pte[i],
-			mk_pte(virt_to_page(kasan_early_shadow_page),
-			       __pgprot(_PAGE_PRESENT | _PAGE_READ |
+		__set_pte(&kasan_early_shadow_pte[i],
+			  mk_pte(virt_to_page(kasan_early_shadow_page),
+				 __pgprot(_PAGE_PRESENT | _PAGE_READ |
 					_PAGE_ACCESSED)));
 
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 3f76db3d27699..e0271e2a0b295 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -68,10 +68,10 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
 static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
 			      unsigned long next, struct mm_walk *walk)
 {
-	pte_t val = ptep_get(pte);
+	pte_t val = __ptep_get(pte);
 
 	val = __pte(set_pageattr_masks(pte_val(val), walk));
-	set_pte(pte, val);
+	__set_pte(pte, val);
 
 	return 0;
 }
@@ -121,7 +121,7 @@ static int __split_linear_mapping_pmd(pud_t *pudp,
 
 			ptep_new = (pte_t *)page_address(pte_page);
 			for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
-				set_pte(ptep_new, pfn_pte(pfn + i, prot));
+				__set_pte(ptep_new, pfn_pte(pfn + i, prot));
 
 			smp_wmb();
 
@@ -406,14 +406,14 @@ static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
 {
 	int enable = *(int *)data;
 
-	unsigned long val = pte_val(ptep_get(pte));
+	unsigned long val = pte_val(__ptep_get(pte));
 
 	if (enable)
 		val |= _PAGE_PRESENT;
 	else
 		val &= ~_PAGE_PRESENT;
 
-	set_pte(pte, __pte(val));
+	__set_pte(pte, __pte(val));
 
 	return 0;
 }
@@ -466,5 +466,5 @@ bool kernel_page_present(struct page *page)
 		return true;
 
 	pte = pte_offset_kernel(pmd, addr);
-	return pte_present(ptep_get(pte));
+	return pte_present(__ptep_get(pte));
 }
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 9c4427d0b1874..9131a78fe15c4 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -8,6 +8,13 @@
 int ptep_set_access_flags(struct vm_area_struct *vma,
 			  unsigned long address, pte_t *ptep,
 			  pte_t entry, int dirty)
+{
+	return __ptep_set_access_flags(vma, address, ptep, entry, dirty);
+}
+
+int __ptep_set_access_flags(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep,
+			    pte_t entry, int dirty)
 {
 	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SVVPTC)) {
 		if (!pte_same(ptep_get(ptep), entry)) {
@@ -32,11 +39,19 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 bool ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep)
 {
-	if (!pte_young(ptep_get(ptep)))
+	return __ptep_test_and_clear_young(vma, address, ptep);
+}
+EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
+
+bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
+				 unsigned long address, pte_t *ptep)
+{
+	if (!pte_young(__ptep_get(ptep)))
 		return false;
+
 	return test_and_clear_bit(_PAGE_ACCESSED_OFFSET, &pte_val(*ptep));
 }
-EXPORT_SYMBOL_GPL(ptep_test_and_clear_young);
+EXPORT_SYMBOL_GPL(__ptep_test_and_clear_young);
 
 #ifdef CONFIG_64BIT
 pud_t *pud_offset(p4d_t *p4d, unsigned long address)
-- 
2.39.5

