Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AA3D9524;
	Fri,  3 Jul 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085783; cv=none; b=bjyhSaFxjoMPIb+9nCuKOXI2HidhZmyG6jjDiJEb3O75Y9a1QGxuxNqlr3A4gD708EXxdoPMCuJuBwPmCsav09ygtXqa6qcwaeNFLKH4sG0aFXjFP6WwFKry/Nt1J+VYKqZPKkWcHTr4M5ocmUXtKBkpBt56qoGjCzOJGtNTX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085783; c=relaxed/simple;
	bh=Wphw/xM3JWkgSFPDSUY+6ReJTUh4aFWBzgmDJhsMifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pv7jiPkhThZiIMjHQnvwGGSlWCvdZeKfli1xIs0L2oDb2WcanymKqmVA7wczRgbvfj96ERP9czm+/AdbfYTssDUbLtGBq2LdG0uaQW6Hguy24hsfF9V5giwVamNnuYu9ecUnM2Fdixw4OwM8CPcF/85lp4KZXslb7xLNvcak0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=cEWqsNwp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnpHHU46; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="cEWqsNwp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnpHHU46"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EFFFF1D00063;
	Fri,  3 Jul 2026 09:36:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 09:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783085779; x=
	1783172179; bh=Bi6ZCi9/zUIsKmhwfb8Lt5NG7YE3vAzXLT8nxhhcSmo=; b=c
	EWqsNwpuWgYI2mhIATMJUHlb/yrsBvg7HBJ6XTUNIjrHq1YasYQzgTBUMov9ZrSc
	Lrop/FRBspkP0p7mhm+mC5fs2XtbiDsuEEyQ5pIvruGxn9VVXGDbhBSDOLUrv47J
	SiB+hhirLCvMOXOsz7naX765oqxj4dGbk45DnB9E2hYIRzAm1I4nwqiQ7+bE6l2N
	zKehP/sF5lDZgdHTbj0VfHjP1v8Jv33zw7Mj4qqHfzsdOp2d7+q6cDAx6KRh4Kip
	nHvFaYmt6mo5qA6stVnITBdAnruhFfg09Ta7/n3tCohsPlzvWEN+FLSK28JlrmDe
	tIHfnQ23qKPz3+9fLSLsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783085779; x=1783172179; bh=B
	i6ZCi9/zUIsKmhwfb8Lt5NG7YE3vAzXLT8nxhhcSmo=; b=gnpHHU46zQmc3tAkH
	lT5xmFWV7YsArW2jTVqyhf4pXOmxmnmfs6C/vRCkyEpEZ7n0jgzpKtIfPcUTfKJE
	JjfaaAt0LHMOIIHHhju1ymmoYu5XN4fn6B49gHlj3yns+wP4T19yK1QJdNZjgUj/
	MtzReoPvChahmSCZO6ktEmLTnlPEUHCs3a7KMkyLHudrnp2iiTklMS151Ha1JMwo
	VfTY4eJpKJPIck70Wg3vlM2cCfksEVtOn3x18F5S1KaUId98H93jewTQz/l0TuFv
	+nSpdvSsfU4M9zC3c0yqO6Ji8MFWwuvAGOQvEJC87XVb0a4Y1L2+ggTk6OLPeMNt
	+W45g==
X-ME-Sender: <xms:07pHamgE9jHllx26HvJEk5XNi0157uO-RIBrMxQeS7dulOxjw72JNA>
    <xme:07pHaq-Xv1tCwaRjb_0lVAJN9ODdrGnEi9DcNzj4wp9rIZL5fHTorTXIhKPEOuvLh
    UYcB0cFb0fQfEsTicEzGr-aXGv-3gv__pRHWSIlk-8T5LKlNl8DPWk>
X-ME-Received: <xmr:07pHamkP7BKJ8XESeWzHPMYNfEkcU8elhDebsj7KPFi9fR1ECVNDrW4ERJqFHA>
X-ME-Proxy-Cause: dmFkZTFugVRxFdH0dMt22KIYT6S26SSG98N0sz+ys09Hlr+AnmeajYF1RN40hpGypUpqlJ
    Zy5d5jLGARuczyZO1OdMXn8vTiUEU5e041N3yfZtKjqAJ2fvSnwYTcPKrlQ8VpRdJVBZzT
    zWez++VZ8twwgwYUntmWOLuiz+JddIPneaaJpHaGxbGUweQl93yRdt1mLP1v11JzYxL0TR
    PjwvC7VHBsh+pFBwV52NT5Wi2gI/nElrIms2Df5C0iyrzcKgELK3rpQpBE9FsReh7PU8JH
    HSiQWhouKdXxBitqX30HTHdkATiOG+IvrpxSrzooOF/Wd6aJR6SYeTFYyzuXA81DmL1FsX
    zI0OhvIwTYEyKnq8SR9zj6QtozsczHyCDod6QqELmzsddMQR0oE7a7sAnFPypXvKHlkpZj
    c6v7ZOcaIvZ/N7S/+DfXNYJcq2isbww4LTVJvxMvZYKyEWxrcdpPoRXUm8eB7CiwexeKw4
    l4xUE1j0v0Q4c+TOFppUqd7DPLN1F3W3QjcEOj5sL95u1E3R3avQqlkwbzOt2UQ7LLgFMY
    sCxQpsZfBNEx3A8jhO8caWXZyPk/s1p2LZCwxXuC7f+YS2vFY9RgPO0I2bcPFNVnge5lH9
    BGJ/1+e9a30zj68+u/XOvP6/ckbi3b8TtiJ43NYRxTA8cccIWo37cNra2Y1g
X-ME-Proxy: <xmx:07pHao32Atka82vc3QabYz--XEI09owvJcob-Z9D8dFo9cr3scKCkw>
    <xmx:07pHarT6iW5KcKC1EONrhycrcCEKvxq8vEOvwe0cZidyRJYHvF84zg>
    <xmx:07pHaoOINj2txG6BFmdccGs_8uyvA5VoPgwDaOYacnwW3mQapVVmbg>
    <xmx:07pHavj3ktHW-OCQouJaMSyIYML2BDPsqIKoppUV34OUaBQIuC-Xhg>
    <xmx:07pHakgjdwh7hch50ae09b-_K41gzkNXAQ5Cg7JtnLl87JwgR3e620Ik>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 09:36:18 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	kas@kernel.org
Subject: [PATCH v8 01/15] mm: decouple protnone helpers from CONFIG_NUMA_BALANCING
Date: Fri,  3 Jul 2026 14:36:00 +0100
Message-ID: <20260703133615.1039465-2-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703133615.1039465-1-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

pte_protnone() and pmd_protnone() detect present-but-inaccessible page
table entries. This capability is useful beyond NUMA balancing -- for
example, userfaultfd working set tracking uses protnone PTEs to track
page access without unmapping pages.

Introduce CONFIG_ARCH_HAS_PTE_PROTNONE to decouple the protnone PTE
infrastructure from CONFIG_NUMA_BALANCING. The six architectures that
support protnone PTEs (x86_64, arm64, powerpc, s390, riscv, loongarch)
now select this option, and CONFIG_NUMA_BALANCING depends on it.

No functional change -- the same set of architectures continues to have
working protnone support, but the infrastructure is now available
independently of NUMA balancing.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Acked-by: SeongJae Park <sj@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/Kconfig                           |  1 +
 arch/arm64/include/asm/pgtable.h             |  7 ++---
 arch/loongarch/Kconfig                       |  1 +
 arch/loongarch/include/asm/pgtable.h         |  4 +--
 arch/powerpc/include/asm/book3s/64/pgtable.h |  8 ++---
 arch/powerpc/platforms/Kconfig.cputype       |  1 +
 arch/riscv/Kconfig                           |  1 +
 arch/riscv/include/asm/pgtable.h             |  7 ++---
 arch/s390/Kconfig                            |  1 +
 arch/s390/include/asm/pgtable.h              |  4 +--
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/pgtable.h               |  8 ++---
 include/linux/pgtable.h                      | 32 ++++++++++++++------
 init/Kconfig                                 |  8 +++++
 mm/debug_vm_pgtable.c                        |  4 +--
 15 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3afe0688919..6e123adca29b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -78,6 +78,7 @@ config ARM64
 	select ARCH_SUPPORTS_CFI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
+	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 27689c62bd25..83eb707508cc 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -553,10 +553,7 @@ static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * See the comment in include/linux/pgtable.h
- */
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pte_protnone(pte_t pte)
 {
 	/*
@@ -575,7 +572,7 @@ static inline int pmd_protnone(pmd_t pmd)
 {
 	return pte_protnone(pmd_pte(pmd));
 }
-#endif
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_present(pmd)	pte_present(pmd_pte(pmd))
 #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d8d252325017..177fb9dc6432 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -67,6 +67,7 @@ config LOONGARCH
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	select ARCH_HAS_PTE_PROTNONE if 64BIT
 	select ARCH_SUPPORTS_NUMA_BALANCING if NUMA
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_RT
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 223528c04d73..1952e34bc8ee 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -623,7 +623,7 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-#ifdef CONFIG_NUMA_BALANCING
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline long pte_protnone(pte_t pte)
 {
 	return (pte_val(pte) & _PAGE_PROTNONE);
@@ -633,7 +633,7 @@ static inline long pmd_protnone(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _PAGE_PROTNONE);
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index e67e64ac6e8c..53a0c5892548 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -490,13 +490,13 @@ static inline pte_t pte_clear_soft_dirty(pte_t pte)
 }
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
-#ifdef CONFIG_NUMA_BALANCING
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pte_protnone(pte_t pte)
 {
 	return (pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE | _PAGE_RWX)) ==
 		cpu_to_be64(_PAGE_PRESENT | _PAGE_PTE);
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 static inline bool pte_hw_valid(pte_t pte)
 {
@@ -1067,12 +1067,12 @@ static inline pte_t *pmdp_ptep(pmd_t *pmd)
 #endif
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
-#ifdef CONFIG_NUMA_BALANCING
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pmd_protnone(pmd_t pmd)
 {
 	return pte_protnone(pmd_pte(pmd));
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index bac02c83bb3e..36b64a24cf30 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -87,6 +87,7 @@ config PPC_BOOK3S_64
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	select ARCH_SUPPORTS_HUGETLBFS
+	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3f0a647218e4..58c12f4fac66 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -71,6 +71,7 @@ config RISCV
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS if 64BIT && MMU
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
+	select ARCH_HAS_PTE_PROTNONE if MMU
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
 	select ARCH_SUPPORTS_SCHED_MC if SMP
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5d5756bda82e..8139e0b2f008 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -534,10 +534,7 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 					PAGE_SIZE)
 #endif
 
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * See the comment in include/asm-generic/pgtable.h
- */
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pte_protnone(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE)) == _PAGE_PROT_NONE;
@@ -547,7 +544,7 @@ static inline int pmd_protnone(pmd_t pmd)
 {
 	return pte_protnone(pmd_pte(pmd));
 }
-#endif
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 /* Modify page protection bits */
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..ad56daa6f874 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -148,6 +148,7 @@ config S390
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && CC_IS_CLANG
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
+	select ARCH_HAS_PTE_PROTNONE
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
 	select ARCH_SUPPORTS_PER_VMA_LOCK
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 859ce7c7d454..0689dfdba407 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -842,7 +842,7 @@ static inline int pte_same(pte_t a, pte_t b)
 	return pte_val(a) == pte_val(b);
 }
 
-#ifdef CONFIG_NUMA_BALANCING
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pte_protnone(pte_t pte)
 {
 	return pte_present(pte) && !(pte_val(pte) & _PAGE_READ);
@@ -853,7 +853,7 @@ static inline int pmd_protnone(pmd_t pmd)
 	/* pmd_leaf(pmd) implies pmd_present(pmd) */
 	return pmd_leaf(pmd) && !(pmd_val(pmd) & _SEGMENT_ENTRY_READ);
 }
-#endif
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 static inline bool pte_swp_exclusive(pte_t pte)
 {
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..380c4aacd42a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -124,6 +124,7 @@ config X86
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	select ARCH_SUPPORTS_HUGETLBFS
 	select ARCH_SUPPORTS_PAGE_TABLE_CHECK	if X86_64
+	select ARCH_HAS_PTE_PROTNONE		if X86_64
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
 	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_SUPPORTS_CFI		if X86_64
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ac295ca6c92f..36c44350f843 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -985,11 +985,7 @@ static inline int pmd_present(pmd_t pmd)
 	return pmd_flags(pmd) & (_PAGE_PRESENT | _PAGE_PROTNONE | _PAGE_PSE);
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-/*
- * These work without NUMA balancing but the kernel does not care. See the
- * comment in include/linux/pgtable.h
- */
+#ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
 static inline int pte_protnone(pte_t pte)
 {
 	return (pte_flags(pte) & (_PAGE_PROTNONE | _PAGE_PRESENT))
@@ -1001,7 +997,7 @@ static inline int pmd_protnone(pmd_t pmd)
 	return (pmd_flags(pmd) & (_PAGE_PROTNONE | _PAGE_PRESENT))
 		== _PAGE_PROTNONE;
 }
-#endif /* CONFIG_NUMA_BALANCING */
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 static inline int pmd_none(pmd_t pmd)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2981e386da7b..7d3dc8abc6c8 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2129,18 +2129,26 @@ static inline int pud_trans_unstable(pud_t *pud)
 	return 0;
 }
 
-#ifndef CONFIG_NUMA_BALANCING
+#ifndef CONFIG_ARCH_HAS_PTE_PROTNONE
 /*
- * In an inaccessible (PROT_NONE) VMA, pte_protnone() may indicate "yes". It is
- * perfectly valid to indicate "no" in that case, which is why our default
- * implementation defaults to "always no".
+ * In an inaccessible (PROT_NONE) VMA, pte_protnone() may indicate "yes". It
+ * is perfectly valid to indicate "no" in that case, which is why our
+ * default implementation defaults to "always no".
  *
- * In an accessible VMA, however, pte_protnone() reliably indicates PROT_NONE
- * page protection due to NUMA hinting. NUMA hinting faults only apply in
- * accessible VMAs.
+ * In an accessible VMA, pte_protnone() reliably indicates a present
+ * PROT_NONE page protection. Today the kernel uses such PTEs for two
+ * purposes: NUMA hinting faults, and userfaultfd RWP tracking on
+ * VM_UFFD_RWP VMAs. The two are distinguished by the uffd PTE bit and
+ * the VMA flag; see include/linux/userfaultfd_k.h.
  *
- * So, to reliably identify PROT_NONE PTEs that require a NUMA hinting fault,
- * looking at the VMA accessibility is sufficient.
+ * So, to reliably identify PROT_NONE PTEs that require kernel handling,
+ * looking at the VMA accessibility (and the uffd bit on RWP VMAs) is
+ * sufficient.
+ *
+ * Architectures without CONFIG_ARCH_HAS_PTE_PROTNONE get the always-zero
+ * stubs below; PAGE_NONE references that survive to runtime fire the
+ * BUILD_BUG() fallback, since callers should have folded such paths to
+ * dead code via IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE).
  */
 static inline int pte_protnone(pte_t pte)
 {
@@ -2151,7 +2159,11 @@ static inline int pmd_protnone(pmd_t pmd)
 {
 	return 0;
 }
-#endif /* CONFIG_NUMA_BALANCING */
+
+#ifndef PAGE_NONE
+#define PAGE_NONE ({ BUILD_BUG(); (pgprot_t){0}; })
+#endif
+#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
 
 #endif /* CONFIG_MMU */
 
diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c..9d91074c5d0a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -944,6 +944,13 @@ config SCHED_PROXY_EXEC
 
 endmenu
 
+#
+# For architectures that support present-but-inaccessible (PROT_NONE) page
+# table entries detectable via pte_protnone() / pmd_protnone():
+#
+config ARCH_HAS_PTE_PROTNONE
+	bool
+
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
@@ -1010,6 +1017,7 @@ config ARCH_WANT_NUMA_VARIABLE_LOCALITY
 config NUMA_BALANCING
 	bool "Memory placement aware NUMA scheduler"
 	depends on ARCH_SUPPORTS_NUMA_BALANCING
+	depends on ARCH_HAS_PTE_PROTNONE
 	depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
 	depends on SMP && NUMA_MIGRATION && !PREEMPT_RT
 	help
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 23dc3ee09561..5e9f3a35f924 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -672,7 +672,7 @@ static void __init pte_protnone_tests(struct pgtable_debug_args *args)
 {
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot_none);
 
-	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE))
 		return;
 
 	pr_debug("Validating PTE protnone\n");
@@ -685,7 +685,7 @@ static void __init pmd_protnone_tests(struct pgtable_debug_args *args)
 {
 	pmd_t pmd;
 
-	if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE))
 		return;
 
 	if (!has_transparent_hugepage())
-- 
2.54.0

