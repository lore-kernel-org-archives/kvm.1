Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686343D4EC;
	Mon,  6 Jul 2026 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327727; cv=none; b=AHZjGn0AKAaL6m7c02h4EXk6Emf/thRKtKQ9kozaTK4Gkoz5xzKh1MFztQgnudxfWaGoLjB+41SVwOEY9q/ZqZ7EWLrKAuy8uxBP1OBAGEbh/hzLkhv6uAAVDzQWvWm4iVlypG00TjjISDsltGgF9+UjSIBcXLkXMRSAVQSngS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327727; c=relaxed/simple;
	bh=ynRt20ojTwgC1xSz9+MtM3Su88iWdHbqc2V+Bs5+RQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjmcixCWq1whzoVHQhutbB+ToxffMRWSL/Md1um7fkCALaVs6iIvK4ohK6w10faYUccqYRL0Ibgyu8pAXLX63VSwf5MUtKV1ANc51L9DSLNv56ILSrbSYd+cZvHl+qM4GAcX3BqD4R3t1jMU4Hhv/krCnqNHn5rhTR39PzwNYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=yEapPVJ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YDL0FsCV; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="yEapPVJ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YDL0FsCV"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ACCCA7A010C;
	Mon,  6 Jul 2026 04:48:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 04:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1783327714; x=1783414114; bh=/owKw67slbmz+kM6pq+eZ3iOuhO9tzES
	4mJVldhVi5k=; b=yEapPVJ0jpVEaxsdG1FZfsuxeel/cXAORbKSJm9VtM4HYWXE
	C+pQF5AR1lEyvteUVcQhspUtHmsHYVWbboFcyKTFagrL87vS8yKFT6DqrBJ0DQos
	zsaiMMEmWd9VHLsE70otEwSSW6QKhatgo0U9iXqlM4O15ga7t6g0gYfmDsoxmdz5
	gwntSkFa8Zrc1db4ZNNDzNovsYmyWRpabxO8JUkTUvHiWWn9Qb5XOgLjJ82TX0KG
	la9+0Gew/vOQz41METRkF6uugmG/LCeSA5kUlOZT/7ZN8NYN9b95PWAkGDXEyl3e
	PyxbTAe1D6p/MovjPKPTnZoVQxOwoL0BuN/W3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783327714; x=
	1783414114; bh=/owKw67slbmz+kM6pq+eZ3iOuhO9tzES4mJVldhVi5k=; b=Y
	DL0FsCVuZpZv3ngZQOxuC1WLWYiLgdC92kYyIYP7gV3n56nNo8UPFBpBSKZsETJr
	AvXswTa9OlMEedA3sNNiQPYeBCYIlb7FJ1yyuqr+y5ORb5WUxXNmYenvfZhUZvrV
	JadA9Kk1U6eiAwOTXDN42GalUXLCcRZ7/vFln2I/Tg5dE4T13ItapQn00FHj5s+T
	8mC3OWncTFK2RxoSMkPOIup/MGFHmdg0vnKH3LfYvsHkmHkxIgMH77eUhwPHdCjq
	fP7sg5QkB2RSGCdLciLiPDYNgMUP/yuz039qGxnY1k0K2rzKfBXoIYGhblSqR6rU
	ihESvBfL+VmPAYXbEXzCA==
X-ME-Sender: <xms:4mtLarHeq6G-ikBD4clyo2aylJaCeUGN61jTZgauBdGWYUogLl22Ig>
    <xme:4mtLasQel9dRMJ0DdMVpyk62U82hPnOrMS9anxzLj9Bb75_n59zFflUSwbBIWSZCL
    JX0GP-8gk0wSr-9elJPnu7m0Xc6Q55mo-wuYW9PX0LbLT3-MyCRVm6z>
X-ME-Received: <xmr:4mtLalpxaS4Qt6TJ0ZH2JUr5aLXZh4qdJs1EeA0utQD-To25gGGHl-_VCNzQ_g>
X-ME-Proxy-Cause: dmFkZTEdicl3dVcL9amANwuNwQ4B/LJ3AGF1IsDGz3aHorST7YhCfwWdaoJhyFHnoWYf2z
    91HVmiSdMMHUBIp4DD88nbW8shxrcjtAZdfXT6m9vc2Tcww7aeCMA9Pb6AAq1YaCWmAxgi
    ArVIEIXgIinNiSvhXTjw+kvcHF73HamoSly6f2up0otjPkEsXMk2c6+qcLC+kg/EfYu9ll
    NC++3n7OIxXkJRlDO8fi1mHoFiMP7TF8KdSUZCebtKSLPWyVmZPfwelqwDaz0Kv1dWgagF
    Ckmrl0e7yag/Y6YlOJb9G2EtlAUAhQvoJLw6xbBcQqHVWMSCgJsGTVd3gdpaGhlRuslVrb
    dYosKGdA0fuAVGpW+6aAVmcw5BiPKvEZ7v8BqW+jpBT6rQw0NN4yWxFzvk0nCill1wu2jy
    2LPb/B0wAVfX4u9Xtn1E5O9SuxrAhMc7KICTOozvnkADq43opKNbN9XUMrDwDasQT4wbUP
    4oFEvU3ewhwXWSfI6ynUR0oMK+mO0WgFv+/qwBlmU52ZOMadZqQCS/RLDwQNH7ctJ0kiNz
    VkBnikeFBlu61Xd+Us2ZnSudbotI4aLz6XCoiitGQA4CNfZJSOaaxJLbdfCs8kCPqbAx3m
    Dyhc3FR8TVqeaGcN0J6WBVE2TN1d4gNQcrOtct3t6hBxiZxODDMhhMcE68GQ
X-ME-Proxy: <xmx:4mtLaiowkHuvo7LLeDjMIuhq90GDCk75_YikV5R-0gAuR9jdI3UaaQ>
    <xmx:4mtLao2QKskmfTv0UWBFzhFjaJdBBmIgRk5cNm7HPsjHoibvzjZM3Q>
    <xmx:4mtLauhLQ2xdNsNiL-Eb6kijDMHRX8E-T-SExqLAKPwk10Gpp9Yc3w>
    <xmx:4mtLavnnqgjOYPxxX7pT69gN7m-Sto-OPodftDBuQQ-R6VgsgR1lLQ>
    <xmx:4mtLaklOjRf6UNjNFsJVsmGe1GjWr-cFKVwuBiNU_JR-eRAl3-YdXVaw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 04:48:34 -0400 (EDT)
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
Subject: [PATCH v9 11/15] mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking
Date: Mon,  6 Jul 2026 09:48:00 +0100
Message-ID: <20260706084805.8400-12-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706084805.8400-1-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

PAGEMAP_SCAN already reports PAGE_IS_WRITTEN from the inverted uffd
PTE bit, targeting the UFFDIO_WRITEPROTECT workflow. UFFDIO_RWPROTECT
reuses the same PTE bit as a marker for read-write protection, but
"has been written" and "has been accessed" are distinct semantic
signals — they happen to share one PTE bit today only because the two
implementations share infrastructure.

Give RWP its own pagemap category so the UAPI does not conflate them:

  PAGE_IS_WRITTEN   reported on VM_UFFD_WP VMAs,  !pte_uffd(pte)
  PAGE_IS_ACCESSED  reported on VM_UFFD_RWP VMAs, !pte_uffd(pte)

Both still read the same PTE bit today, but each is scoped to the VMA
whose registered mode makes the bit meaningful. If a future
implementation moves RWP to a separate PTE bit, only PAGE_IS_ACCESSED
switches over.

This is a UAPI narrowing. Outside VM_UFFD_WP VMAs the uffd bit is
always clear, so PAGEMAP_SCAN used to flag PAGE_IS_WRITTEN on every
present PTE there — a meaningless duplicate of PAGE_IS_PRESENT. Now
PAGE_IS_WRITTEN fires only inside VM_UFFD_WP VMAs.

pagemap_hugetlb_category() now takes the vma like its PTE/PMD peers.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/admin-guide/mm/pagemap.rst | 13 +++--
 fs/proc/task_mmu.c                       | 63 +++++++++++++++++-------
 include/uapi/linux/fs.h                  |  1 +
 tools/include/uapi/linux/fs.h            |  1 +
 4 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index c57e61b5d8aa..ffa690a171c8 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -19,8 +19,11 @@ There are four components to pagemap:
     * Bit  55    pte is soft-dirty (see
       Documentation/admin-guide/mm/soft-dirty.rst)
     * Bit  56    page exclusively mapped (since 4.2)
-    * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
-      Documentation/admin-guide/mm/userfaultfd.rst)
+    * Bit  57    pte is tracked by userfaultfd (since 5.13) — in a
+      ``VM_UFFD_WP`` VMA this indicates a write-protected PTE; in a
+      ``VM_UFFD_RWP`` VMA it indicates an RWP-protected PTE. WP and
+      RWP are mutually exclusive per VMA, so the meaning is
+      unambiguous. See Documentation/admin-guide/mm/userfaultfd.rst.
     * Bit  58    pte is a guard region (since 6.15) (see madvise (2) man page)
     * Bits 59-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
@@ -244,7 +247,8 @@ in this IOCTL:
 Following flags about pages are currently supported:
 
 - ``PAGE_IS_WPALLOWED`` - Page has async-write-protection enabled
-- ``PAGE_IS_WRITTEN`` - Page has been written to from the time it was write protected
+- ``PAGE_IS_WRITTEN`` - Page in a ``UFFDIO_REGISTER_MODE_WP`` VMA has been
+  written to since it was write-protected. Only reported inside such VMAs.
 - ``PAGE_IS_FILE`` - Page is file backed
 - ``PAGE_IS_PRESENT`` - Page is present in the memory
 - ``PAGE_IS_SWAPPED`` - Page is in swapped
@@ -252,6 +256,9 @@ Following flags about pages are currently supported:
 - ``PAGE_IS_HUGE`` - Page is PMD-mapped THP or Hugetlb backed
 - ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
 - ``PAGE_IS_GUARD`` - Page is a part of a guard region
+- ``PAGE_IS_ACCESSED`` - Page in a ``UFFDIO_REGISTER_MODE_RWP`` VMA has been
+  accessed since RWP was applied. Only reported inside such VMAs. See
+  Documentation/admin-guide/mm/userfaultfd.rst for the RWP workflow.
 
 The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5b55c59573a3..2d724156763d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2283,7 +2283,7 @@ static const struct mm_walk_ops pagemap_ops = {
  * Bits 5-54  swap offset if swapped
  * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
  * Bit  56    page exclusively mapped
- * Bit  57    pte is uffd-wp write-protected
+ * Bit  57    pte is tracked by userfaultfd (uffd-wp or RWP)
  * Bit  58    pte is a guard region
  * Bits 59-60 zero
  * Bit  61    page is file-page or shared-anon
@@ -2418,7 +2418,7 @@ static int pagemap_release(struct inode *inode, struct file *file)
 				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
 				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
 				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY |	\
-				 PAGE_IS_GUARD)
+				 PAGE_IS_GUARD | PAGE_IS_ACCESSED)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
 
 struct pagemap_scan_private {
@@ -2443,8 +2443,12 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
 		categories = PAGE_IS_PRESENT;
 
-		if (!pte_uffd(pte))
-			categories |= PAGE_IS_WRITTEN;
+		if (!pte_uffd(pte)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			page = vm_normal_page(vma, addr, pte);
@@ -2461,8 +2465,12 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
 		categories = PAGE_IS_SWAPPED;
 
-		if (!pte_swp_uffd_any(pte))
-			categories |= PAGE_IS_WRITTEN;
+		if (!pte_swp_uffd_any(pte)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 
 		entry = softleaf_from_pte(pte);
 		if (softleaf_is_guard_marker(entry))
@@ -2511,8 +2519,12 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 		struct page *page;
 
 		categories |= PAGE_IS_PRESENT;
-		if (!pmd_uffd(pmd))
-			categories |= PAGE_IS_WRITTEN;
+		if (!pmd_uffd(pmd)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			page = vm_normal_page_pmd(vma, addr, pmd);
@@ -2526,8 +2538,12 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 			categories |= PAGE_IS_SOFT_DIRTY;
 	} else {
 		categories |= PAGE_IS_SWAPPED;
-		if (!pmd_swp_uffd(pmd))
-			categories |= PAGE_IS_WRITTEN;
+		if (!pmd_swp_uffd(pmd)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 		if (pmd_swp_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
 
@@ -2560,7 +2576,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HUGETLB_PAGE
-static unsigned long pagemap_hugetlb_category(pte_t pte)
+static unsigned long pagemap_hugetlb_category(struct vm_area_struct *vma,
+					      pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
@@ -2575,8 +2592,12 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	if (pte_present(pte)) {
 		categories |= PAGE_IS_PRESENT;
 
-		if (!huge_pte_uffd(pte))
-			categories |= PAGE_IS_WRITTEN;
+		if (!huge_pte_uffd(pte)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 		if (!PageAnon(pte_page(pte)))
 			categories |= PAGE_IS_FILE;
 		if (is_zero_pfn(pte_pfn(pte)))
@@ -2586,8 +2607,12 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
 	} else {
 		categories |= PAGE_IS_SWAPPED;
 
-		if (!pte_swp_uffd_any(pte))
-			categories |= PAGE_IS_WRITTEN;
+		if (!pte_swp_uffd_any(pte)) {
+			if (userfaultfd_wp(vma))
+				categories |= PAGE_IS_WRITTEN;
+			if (userfaultfd_rwp(vma))
+				categories |= PAGE_IS_ACCESSED;
+		}
 		if (pte_swp_soft_dirty(pte))
 			categories |= PAGE_IS_SOFT_DIRTY;
 	}
@@ -2863,7 +2888,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 		goto flush_and_return;
 	}
 
-	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
+	if (userfaultfd_wp(vma) && !p->arg.category_anyof_mask &&
+	    !p->arg.category_inverted &&
 	    p->arg.category_mask == PAGE_IS_WRITTEN &&
 	    p->arg.return_mask == PAGE_IS_WRITTEN) {
 		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
@@ -2938,7 +2964,8 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 		/* Go the short route when not write-protecting pages. */
 
 		pte = huge_ptep_get(walk->mm, start, ptep);
-		categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+		categories = p->cur_vma_category |
+			     pagemap_hugetlb_category(vma, pte);
 
 		if (!pagemap_scan_is_interesting_page(categories, p))
 			return 0;
@@ -2950,7 +2977,7 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
 
 	pte = huge_ptep_get(walk->mm, start, ptep);
-	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+	categories = p->cur_vma_category | pagemap_hugetlb_category(vma, pte);
 
 	if (!pagemap_scan_is_interesting_page(categories, p))
 		goto out_unlock;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bd87262f2e34..34c6f219462a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -471,6 +471,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
 #define PAGE_IS_GUARD		(1 << 8)
+#define PAGE_IS_ACCESSED	(1 << 9)
 
 /*
  * struct page_region - Page region with flags
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 24ddf7bc4f25..f0a26309b6d5 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -364,6 +364,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_HUGE		(1 << 6)
 #define PAGE_IS_SOFT_DIRTY	(1 << 7)
 #define PAGE_IS_GUARD		(1 << 8)
+#define PAGE_IS_ACCESSED	(1 << 9)
 
 /*
  * struct page_region - Page region with flags
-- 
2.54.0

