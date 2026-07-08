Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE679434E40;
	Wed,  8 Jul 2026 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783509282; cv=none; b=AiXuKpHmD9Adr+PQa5BgAE/Gf9Z19zOUlhMdqidgMfuVYQd9UIiNwkLFnZPt+/epf3Tpj3um7/0o+g6p7UloShqnnl8cQQjD11zSFy5Qf1SzGF/Jz5CZp7biXHPMVuDKhsB1HV/J0x21ibebhd0XzLK8Wc7mB/nLqx6QkPx9OdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783509282; c=relaxed/simple;
	bh=JR9iLmtMfblaYLOiNA6wy9WdU0oKCKRKTF14IebmDu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8fK9jzscaJqRv2XoWuqIX03wxhBnz/zDn847ZzW7HPH7Q/OMdvRcGQW2UN/dTR7oofEv6jMIwcBQJFbXjeone+rytj5h9KnXOKtbALqSbOostBse1cffzYAZkNVHEKsf/RbJ3sbdwQaI6YTgDaQTS8o6zR2cVJ89BsgH0Iszqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=CQwaAHuS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LbGmPZjh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="CQwaAHuS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LbGmPZjh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B488F7A0136;
	Wed,  8 Jul 2026 07:14:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1783509279; x=1783595679; bh=sgEQDNZMG8LOJs71RlvC9k9z+2y//F67
	c9j+0IEQFTk=; b=CQwaAHuSTBQGHUTATnFRu8i0nA7v++EzLF31DwjFOUDyBEFI
	kWGM8NtlCwYYv//2FZgrucEH3/gcnHAnBsRaIp8QqDDbQzl3eNnFRhCCK2Skg/6H
	yhkf/p0aaagKq6U2DCd3XAyfj0N0z3SHU4TvpD6FxE/6KCaFkF26M9K+2uqcv+jU
	NKR0612lUoceuFOG9ogi04Z3rJFI5UpIo06hcq8ctGc1yz0RPWGQdeaZOA/jH/e4
	LZ+7McM3eFdElWqPMfISz2Yb6x1zkhi7093/rQe8y+UqNuE04Xd3wUK+ketxXd+m
	eX+xhRc1HHugbJLVOm874vZv/G7QdgrBG8n99A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783509279; x=
	1783595679; bh=sgEQDNZMG8LOJs71RlvC9k9z+2y//F67c9j+0IEQFTk=; b=L
	bGmPZjhMpVpnYMGtyHi2lqD2Ipt3HFE04s8wOhYyhwJvo+tpTrbspNbQx+tXWtx1
	9maRK3ZzuRTefEhfBZXDivtc+X5WHTJlLWVA3gntlQ75lms/PiC1nDeufwyk2yJl
	pquEkVGFl2DpCoLwXMUJxQj/tjZ5fiTkqfwnTlK+6Dycw7khZ+y/NhXntJ+u1SLC
	TQnNaxtoDhm8L2HLb/3iq3QVaOoHs02buvff+MZcWrNzQmoeHJ9r8i3xgI9QC/11
	4WdzKZL59Z9d8sc0Icgm4DOptWASNXbkdRjhoiiPAisXVJwbrnupdrKC0yj8kgom
	G2GwnWb+gQhoKvckoDbZA==
X-ME-Sender: <xms:HzFOalEtY84ArZnB1TiCDOFZZh9QNOz3AEwLXR0us7COZ2GC2nRiOg>
    <xme:HzFOauRYx80oytOBYfrVThrLcWNIvNsa7I0jiXd4ot0vKXm0nZHR8ozO1gIUFuGdG
    bG0FmGEjpV6xWMbJPmO_VfMfhP8xPDoQqKajscXGL_ds9hL4_8xWAg>
X-ME-Received: <xmr:HzFOavrwqqpOXl0X0uriwLT62wAWmwPQuJyIzXKASY6SscVKhwtbfIWE3IFdmA>
X-ME-Proxy-Cause: dmFkZTFUNIYXC0Q5t8iqxsk5x/ZZMsEDxIoZnWAQZPTQe2TvhnM3yGqaiQbzxnqs+7JIiR
    Yq5XhJlRG8HRcn4TzRiv2EKww24qGo2vzTE+dwYEALdjzUu9fkyEySz6S/StK8W84OHvkq
    W9bJFACiywJM+FHRWARKJSxsj/OIv5i/+BUkO9YHMo8DRu+y4pegyGixo+73/KOUD27j6H
    5pOE/wzQGFm6/nPC8g/bDVffg3JUC2YP/n7l/I6zXixgasab/b3ztmwGVl8QyMOBshJvPS
    ED/XZSrmnCYJ6UGjCdjgdYCVYCbIESChWLzOeM4GIrKC6PPK50eSw/FV+ttn4eLfWIUOCa
    reRCximkGMFlBGm4weZjQetcVAsjOt8FNdvwVErFunVSPGvfV+vhgUWKfURCh0nQDWgdyF
    4swX1iI1Bq4Lp8sYYh9nSrtbpAw5syb2yeyWWqEad3Ssb3bvH+1rQcV0GTJ8ymqS3awAro
    juTLspFyAVkEuy0CiRai8zjHduuh23IXs9FpmLnKuxw4ihzIua2iaUdNPHKkpYSyTAQNZT
    znVbu0mQW6RiWukl2Xhvenp09lcdm/H6aGYoTu6LUIVyRVsonsAKLSD4tgsbS9wPg8YiZ9
    rOVyQz7kGSw6l9Fad7BynDc/iO4+H9p1dF/e36E0S4bvdyyfLn8dwgWLqOzg
X-ME-Proxy: <xmx:HzFOakpHnaOL3GONKx9lDQ9Y4cGO0Mn35Q9EGzYKGKT-ZeM2xZy0ZA>
    <xmx:HzFOai0pBKsnUuHX7w16ZcbMqJzwqnCMd4fBzBPTDJ74t-0LPwcFDA>
    <xmx:HzFOaggIiYgdxyZlb3HvGLhEXIoVrVw6Ai75Te2V-O5wRMoonqP9xw>
    <xmx:HzFOapnB4OZ4tb6J3Zy-3UhODOp_lbtjMh8Nd__tk-rrSXk-4MryFA>
    <xmx:HzFOahiLBlsby5NQwbbY0M9eJ5Y_XQ3dQpVyxRxheLlJZBF2hzwW2CIe>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 07:14:38 -0400 (EDT)
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
Subject: [PATCH v10 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Wed,  8 Jul 2026 12:14:09 +0100
Message-ID: <20260708111417.173443-9-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708111417.173443-1-kirill@shutemov.name>
References: <20260708111417.173443-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Three mm paths outside the fault handler gate on the uffd PTE bit
today: khugepaged (skip collapse on ranges carrying markers), rmap
(cap unmap batching), and GUP (force a fault through
gup_can_follow_protnone). Extend each to treat VM_UFFD_RWP the same
as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
bypassed.

khugepaged: try_collapse_pte_mapped_thp() and
file_backed_vma_is_retractable() already refuse to collapse or
retract page tables on ranges carrying the uffd PTE bit. Broaden the
VMA predicate from userfaultfd_wp() to userfaultfd_protected() so
VM_UFFD_RWP ranges get the same protection. hpage_collapse_scan_pmd()
needs no change — its existing pte_uffd() check already catches an
RWP PTE because it carries the uffd bit.

rmap: folio_unmap_pte_batch() caps batching at 1 for VM_UFFD_RWP so
the restore path handles each PTE with its own marker.

GUP: gup_can_follow_protnone() forces a fault on VM_UFFD_RWP VMAs
regardless of FOLL_HONOR_NUMA_FAULT. RWP uses protnone as an
access-tracking marker, not for NUMA hinting, so any GUP — read or
write — must go through the userfaultfd fault path.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
---
 include/linux/mm.h | 16 +++++++++++++++-
 mm/khugepaged.c    | 18 +++++++++++-------
 mm/rmap.c          |  2 +-
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 012dbb7f4ef0..f62def4fcca9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4670,11 +4670,25 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 
 /*
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
- * a (NUMA hinting) fault is required.
+ * a (NUMA hinting or userfaultfd RWP) fault is required.
  */
 static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
 					   unsigned int flags)
 {
+	/*
+	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
+	 * NUMA hinting. GUP must always take a fault so the access is
+	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
+	 *
+	 * Only do so while the VMA is accessible. If it has been made
+	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
+	 * below: forcing a fault there would loop, as handle_mm_fault() makes
+	 * no progress on protnone in an inaccessible VMA, and the access is
+	 * denied regardless of RWP anyway.
+	 */
+	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
+		return false;
+
 	/*
 	 * If callers don't want to honor NUMA hinting faults, no need to
 	 * determine if we would actually have to trigger a NUMA hinting fault.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0b5fb0d0a0c1..55157567dc4c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1893,8 +1893,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
 		return SCAN_VMA_CHECK;
 
-	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
-	if (userfaultfd_wp(vma))
+	/*
+	 * Keep pmd pgtable while the uffd bit is in use; see comment in
+	 * retract_page_tables().
+	 */
+	if (userfaultfd_protected(vma))
 		return SCAN_PTE_UFFD;
 
 	folio = filemap_lock_folio(vma->vm_file->f_mapping,
@@ -2107,13 +2110,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
 		return false;
 
 	/*
-	 * When a vma is registered with uffd-wp, we cannot recycle
+	 * When a vma is registered with uffd-wp or RWP, we cannot recycle
 	 * the page table because there may be pte markers installed.
-	 * Other vmas can still have the same file mapped hugely, but
-	 * skip this one: it will always be mapped in small page size
-	 * for uffd-wp registered ranges.
+	 * VM_UFFD_RWP ranges similarly rely on per-PTE uffd state
+	 * and cannot be recycled to a shared PMD. Other vmas can still
+	 * have the same file mapped hugely, but skip this one: it will
+	 * always be mapped in small page size for these registrations.
 	 */
-	if (userfaultfd_wp(vma))
+	if (userfaultfd_protected(vma))
 		return false;
 
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 50f973b63f1c..26166a6b8cb9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1965,7 +1965,7 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 	if (pte_unused(pte))
 		return 1;
 
-	if (userfaultfd_wp(vma))
+	if (userfaultfd_protected(vma))
 		return 1;
 
 	/*
-- 
2.54.0

