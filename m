Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D23FD15F;
	Tue, 26 May 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800758; cv=none; b=URnImXEeZX3SNLk7ZsPCAIwvFG9Yu+rSmE8d7y+p2QEHJyTmdm9Lb4GuxxZBfaARj7bV7IAz3o8U72fDCfSIdQL6i3882ilu1DfsR89HpPd55qQJAiMGzZHtKlQvt52Zhnj414HEQS0nvzkS5kbWF54PflmZ5e3u1dOzDY84hOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800758; c=relaxed/simple;
	bh=ve9QEfvYm0bCiD3Zi1eIbqx9x62ji4OWuE1qXAX7kjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGT27Qf4L+K4vTsguKF1KjN0iAc1rtfaFUPWOD4ZQeVIMAsJJp5TIv1kuErkYVblHigwFpRhxvQ3IrbKHmPGFVgZwji/0Y4M/LzotXBsaj6X+XJP6uXdzFrFdT8gFc7xMvli5kqqwj3Li3P0UKzdORzDDuo/voY2xHOYHKrwTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vLST9AFF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c3ogybA3; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="vLST9AFF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c3ogybA3"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62AE67A019F;
	Tue, 26 May 2026 09:05:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 26 May 2026 09:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779800755; x=1779887155; bh=V7U0e8pmOCDRB+w7Ki4npwjrymHShsCq
	vi0HnvAdmrM=; b=vLST9AFF4jFVcywiNhRXckCFD2nnGmFtYy0JuMVjHLgK7r97
	kdzuZGmNkeTiUMZxYbImCxvrMPhJXtQRm1xLm5ZzP0/jY2Psvle6t20lef/jbM2m
	df6Sv+xyva4ph5cWGglHdEKKcTdqIywRCNH4gas/qTqS/su4O/BpMlCbhQwIHq3+
	cqTi7mn0B/SRe1IZ+cf5bA7GuAMkRauNUvlK908vDx/ecqRV+tch8mdHjBPPhsmc
	UZlZTkgDmt0cJdCyjo1LXD4zogdJtnNM3JMyUdk4QzGUPo3efAqwBbVaGgaquhEJ
	omR1+YsKViRDt1BW24cqnHqtTOoVMgh01yREIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779800755; x=
	1779887155; bh=V7U0e8pmOCDRB+w7Ki4npwjrymHShsCqvi0HnvAdmrM=; b=c
	3ogybA3pWTT7lOT0cKabVoApt9YWbqnqSlvLHgBmfRTUTJNaqrtMZ+aHqwGSSYJy
	/fln4P7yAV+EM7MQbr9fUX3tKrkXBD0adYECZrKbe06Q9g/ruMw03oVxz7Ujmxme
	w0hUgfCpNVGmOLODV4dqLrUAPbgd9TuFXU4iDKOSJwdKSSf9MB29nUIraeSdRbZC
	RdLDKDSWTuQwKEtfhExHjH3tl8wCFbm/GGIfMp1oMCqsZ4p+7Q+Fil+cy3XTzVRY
	y/1OVeOmK5BdfzD+eLc9gK5mjh8X/qczlrNFazCxxcLVt0YCnLsR6WkJw9tsNPQv
	5OyEHXV5AXSR7MGhzjyXw==
X-ME-Sender: <xms:s5oVarkx9odHDZJEPcoe0X885HQDsJxZpZ3dm1mCKsKpBqzz8V-7TQ>
    <xme:s5oVaiypNScmWT85kumELkhKtuf01ySofvvLIWSi-9e3wERx6R-Gtn_aGs9RM6q-O
    LvGcFqlIo5gDTe8PSRFATwBkNDioLC6q4l397b7jnMG4jzzQl7UKiA>
X-ME-Received: <xmr:s5oVaqLPI016m-WIHh3_Rpl1OjpxJKdmQZgmVnaYAhsKBJuTr5_tOr5pCcuUEA>
X-ME-Proxy-Cause: dmFkZTFRxKInQFecwZPuEt+LuNBlOJGP8RsxGpm588gQviVhNq1Pa+AqWD7JQeVUR2Swte
    eyzLZOEYFGJPBoftF7cmhN7hkCk3wRua/o4v8Bw72KaC1CFplNf1sAsIMRN76GRZVrrXJo
    4g3If4FQDoPgtrZ9saDLAexzQgvrfsTwQ3/KP0AGKCFmLiVvQMOmXCsts9ZOCGk1E95eOU
    mgzRkXibxyISOqgf2hZqBdgrV6ktnG5u3x8/zXY22S6cQZP9xSB0eE/pqpJrpVnOId2p4l
    G0binpu+ah/FFZH0esjGo/wTdPAqY9SKUVzl+zWcrHaZzSyBzEWlNRkrUo/n9HkffJzpDJ
    RadNWjUYf05V4NClhmxfTiFz7mqn4CmgNeoF+o5VwMXR+lDZSJhql8M/tys2jB+a0Zeqq1
    bu73w/0D8yuFUdQC97NuG73B8GkWe/dqnrTl4GCqO8Ue7YttD9BD/SzihZRsSPdFVPDk+Y
    jYkL8fugK6WenVTJFiKKh3L9J/loaS7yJvBGhOyt+dZ6EuRO6ZYAZJ586Opw270rs3vBWU
    b4bkzWE1tnalYCButGLiNmmU54wvpEzxJyj6Nby8S3goSjxIN1uptIsFfk+QDMex02FHUl
    wbSVXZ9lU78ZgImB99l6sxpzQWYjerHc08+RgKqGJ4ItmlNzLwaws+P5BPpg
X-ME-Proxy: <xmx:s5oVatIE_1vy3RfJLE3kxMC5eYZRQ9tfZIEHcPX4BytZaAEhcV6Rvg>
    <xmx:s5oVahUMSqYvpgcD-rLJtO16Ec5S01kfJWDlb6tnqWTslILNQ1pFJg>
    <xmx:s5oVatAUB62z91MGv7cNgjC_lkfbj9NOSI_4xmBzX4JzTLNRx2U76g>
    <xmx:s5oVasHiZ-hQZRNH94KXjqER-ajLEGeTe4J_9CbzblOC3VdMQ6x6qA>
    <xmx:s5oVaiBx5Y_IHRIfeVhgmoh29qmFrRNd0r0B7X7QISaXn_QJDDCL4j0->
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:54 -0400 (EDT)
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
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v5 14/18] mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking
Date: Tue, 26 May 2026 14:05:02 +0100
Message-ID: <20260526130509.2748441-15-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526130509.2748441-1-kirill@shutemov.name>
References: <20260526130509.2748441-1-kirill@shutemov.name>
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
 Documentation/admin-guide/mm/pagemap.rst | 13 +++-
 fs/proc/task_mmu.c                       | 75 ++++++++++++++++++------
 include/uapi/linux/fs.h                  |  1 +
 tools/include/uapi/linux/fs.h            |  1 +
 4 files changed, 69 insertions(+), 21 deletions(-)

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
index 974c5f4aa533..0db29c3a8639 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2284,7 +2284,7 @@ static const struct mm_walk_ops pagemap_ops = {
  * Bits 5-54  swap offset if swapped
  * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
  * Bit  56    page exclusively mapped
- * Bit  57    pte is uffd-wp write-protected
+ * Bit  57    pte is tracked by userfaultfd (uffd-wp or RWP)
  * Bit  58    pte is a guard region
  * Bits 59-60 zero
  * Bit  61    page is file-page or shared-anon
@@ -2419,7 +2419,7 @@ static int pagemap_release(struct inode *inode, struct file *file)
 				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
 				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
 				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY |	\
-				 PAGE_IS_GUARD)
+				 PAGE_IS_GUARD | PAGE_IS_ACCESSED)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
 
 struct pagemap_scan_private {
@@ -2444,8 +2444,12 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
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
@@ -2462,8 +2466,12 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
 
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
@@ -2512,8 +2520,12 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
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
@@ -2527,8 +2539,12 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
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
 
@@ -2561,7 +2577,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #ifdef CONFIG_HUGETLB_PAGE
-static unsigned long pagemap_hugetlb_category(pte_t pte)
+static unsigned long pagemap_hugetlb_category(struct vm_area_struct *vma,
+					      pte_t pte)
 {
 	unsigned long categories = PAGE_IS_HUGE;
 
@@ -2576,8 +2593,12 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
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
@@ -2587,8 +2608,12 @@ static unsigned long pagemap_hugetlb_category(pte_t pte)
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
@@ -2677,6 +2702,18 @@ static int pagemap_scan_test_walk(unsigned long start, unsigned long end,
 	bool wp_allowed = userfaultfd_wp_async(vma) &&
 	    userfaultfd_wp_use_markers(vma);
 
+	/*
+	 * PM_SCAN_WP_MATCHING is the atomic read-and-reset flavour of the
+	 * scan and is implemented for the WP marker only. Silently skip
+	 * VM_UFFD_RWP VMAs, matching the convention used below for VMAs
+	 * that lack the WP-async capability. Returning -EINVAL here would
+	 * abort the walk after preceding VMAs had already been mutated,
+	 * destroying the atomic read-and-reset guarantee. Re-arming RWP
+	 * is done with UFFDIO_RWPROTECT(MODE_RWP).
+	 */
+	if (userfaultfd_rwp(vma) && (p->arg.flags & PM_SCAN_WP_MATCHING))
+		return 1;
+
 	if (!wp_allowed) {
 		/* User requested explicit failure over wp-async capability */
 		if (p->arg.flags & PM_SCAN_CHECK_WPASYNC)
@@ -2864,7 +2901,8 @@ static int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
 		goto flush_and_return;
 	}
 
-	if (!p->arg.category_anyof_mask && !p->arg.category_inverted &&
+	if (userfaultfd_wp(vma) && !p->arg.category_anyof_mask &&
+	    !p->arg.category_inverted &&
 	    p->arg.category_mask == PAGE_IS_WRITTEN &&
 	    p->arg.return_mask == PAGE_IS_WRITTEN) {
 		for (addr = start; addr < end; pte++, addr += PAGE_SIZE) {
@@ -2939,7 +2977,8 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 		/* Go the short route when not write-protecting pages. */
 
 		pte = huge_ptep_get(walk->mm, start, ptep);
-		categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+		categories = p->cur_vma_category |
+			     pagemap_hugetlb_category(vma, pte);
 
 		if (!pagemap_scan_is_interesting_page(categories, p))
 			return 0;
@@ -2951,7 +2990,7 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
 	ptl = huge_pte_lock(hstate_vma(vma), vma->vm_mm, ptep);
 
 	pte = huge_ptep_get(walk->mm, start, ptep);
-	categories = p->cur_vma_category | pagemap_hugetlb_category(pte);
+	categories = p->cur_vma_category | pagemap_hugetlb_category(vma, pte);
 
 	if (!pagemap_scan_is_interesting_page(categories, p))
 		goto out_unlock;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 13f71202845e..c4aeaa0c31c7 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -455,6 +455,7 @@ typedef int __bitwise __kernel_rwf_t;
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

