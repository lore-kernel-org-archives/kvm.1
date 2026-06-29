Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E45360EEA;
	Mon, 29 Jun 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734892; cv=none; b=KlDR3ZCxmx022w5Q4mf+LKKz3cAVNSvfA2jz66hXpftkqnAqnUIZgTfcKsvS1B15cVOcglR7kjmudHwjvPDXxG7lfjlbiGYWI6T1smgfTSe5eR7owCHgDRiyVtGN7xwsYT14+7Y6xQ6R9Q24WWUn8nryN1KM5jGhgYjZKiEhU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734892; c=relaxed/simple;
	bh=KFFpEjN/ywV5dMnHVG+4DsmF8cpDvplAJnlVzGgQ1f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AwKgqBFjdRyFKPXSKgXYiHjnhzqBNl9sDwIIYyJI768jhQP9H7tOGoqoEpD504RiciZ/jLyfzJOMrpLbU/peRBJEnsmMGj++wdIufwp/blMlpohHzgxBp6pFZMmQ8E+F6LgbcsxisMEsgK+xJRm5oBpFtD6Je5cRiBHj+Pw+aeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OojZ8jkz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2AeDfGX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OojZ8jkz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2AeDfGX"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 817ACEC0136;
	Mon, 29 Jun 2026 08:08:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 29 Jun 2026 08:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782734887; x=1782821287; bh=85dlYldMrNgF2zIT9pjGLNO/irueGh3B
	4Qs719th2NU=; b=OojZ8jkzd1/EWL8x1NbaW8P5fTSkJoEqEhoW/REqhH+X74eh
	NblxKiMB8mVFgR6Ymd1ZLN7lql05tpBg/7AW+w9krNZr5NjQlTAL6ubjTOIQPKeY
	FhXOBt3rk/FByGJ48Q15ZiBBbx3klddkpunhIxWHHTImv/9NYRwKRH+GXnQ3M1oL
	6x1IEv+bYQ7ezPpJp5GRLVdyHzy3bHc83qrLMgbY6d9L2+jaoJsC/Mpb9VjMiQBs
	+UYcfbOyJUySNZTJXVrjSeIhOO9url1wU9tMm1V4Eh47HDh07fZXdAG/stejgfKB
	TP37FAavfRd3uKAnymnRfGyrA6vHZUmA8UPkgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782734887; x=
	1782821287; bh=85dlYldMrNgF2zIT9pjGLNO/irueGh3B4Qs719th2NU=; b=S
	2AeDfGX2eK7RBw0nI4biUTwX9TEhBKnLI9R9ynYPgNNT9Q+GJrFRFlNca8HFqXKQ
	TaD4jdkxSVtp6nztoI+97Rvhdn0/JLhznVZXPaCBxOuzSdVEnilVnfQ4A81WvjMs
	P6KMT2zLnclB82ozJmsjn266PIM1w1F4Wgqr9jeUjJDIwygu+25TwRagd43Q5ZZT
	00mnuaq/n/kWiY2G+YuMff7JICQDcrRiEb8vd6psjl3YRic0P1+HVpmsK0DmoFLM
	oZoP4h9ZvmxNuEwwd1vyAjqN3wIZnKyXK7asA4AL8PevUuHmDduLWs/eRLHbnmf4
	M/uBko6TC2+BwfDU4KGMA==
X-ME-Sender: <xms:J2BCavOwJspu1cAIExpLGeMBNLmm2-Zzh07lHe5V_gwa2cq7924P1w>
    <xme:J2BCat7woX034NyaEF96geMPYiprOToOVsJFR9nqfnlCac2xNBZ6HxeMg0v5FfTId
    m5BdesGxFOesyGWTE2SiZjmX0LVebqBvbPDSQJFbGOrxBoFo6cFfY9L>
X-ME-Received: <xmr:J2BCamxCwNXyf8KzaAw5IKJm9B7vO4htvDy6DGc0bqyaTEbddMdpLvQJxJOE3w>
X-ME-Proxy-Cause: dmFkZTFY9msGIGksnyHNhpdpiL2Ew5X29ZHd8bcNS69STRb5aokGzn5HjcNIwS0kCdENba
    6SlKS6wYtn0p71nlzYZOVLykStl3Q2hkfL2qEQk188rowBgd6iJn4CFsTORvSWNVZxRMM1
    nHLQZ85PvsMHeuBoK4lGcoG7ioTf2JyHtEmBF8if6Po43U8CzIy3EHWnFatxau8M1EpHaG
    Q/+3pCc92/T9ahokkjka/kvSk9kXBX9TD1WGRiS0Ovdl5ja+ZagisFwLuB77wgF7Biblu4
    rAPyGMWqZ/uXWIWLV+CKn7ltXGkWhTX9CZOX94EvsXkl37bIkkGVOUTt/qEVtY95e0K8CR
    7rXL50PYjc5UZSG3m5lcv/79CBAcRj9L5I1NBPAX0/YNQ0ipBJUanFW5am9AqIz6rTVTwG
    TdJ15oQV5ngaQXeAPWvLRfJMs57+C5BzhxfOgxl8EmHaiOs1HQKNSHXbxMJ/DlJS9fSL1z
    4ontkQZaZH3ktLVyz/1HJXt0M+RKF6Il2rsAZImyV/q3D1kIWBUO/8uTEzzZMr3TPAoApr
    VEXUqYxEqym6Q459vQiH4cgXrCgXVct8JxUp26LtzrLAT4yYuFUWAQF6zqW3wxlIfAazkJ
    hmbkQz0QShDrevFarI8/1CNOn0lDu2B6id6bpuEgDbDFYKiOV5RcJWggevYA
X-ME-Proxy: <xmx:J2BCatRg9RNAoJGwB6khhoRfnuPs16otS3u69OoymeVqQJNlBB0ubA>
    <xmx:J2BCau8Esd7kkXsKCJyWimwzsQ9bTBtmhbrVBjlTWLpvvWLWNYL7HA>
    <xmx:J2BCaqLlaqmOdb1IcIB716xElR5osjOTuQx1fbkH1WSZoQmNSsd1Gw>
    <xmx:J2BCait4HKrVhKBj_LhPjBYXb-7TW0gOhoA50TEPtcogq7eKcAA82w>
    <xmx:J2BCantkNt0bANbn9F_KL7kgKtRr2Uo1AmeOJaKoektnYG3dnrnI7GbA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 08:08:06 -0400 (EDT)
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
Subject: [PATCH v7 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Mon, 29 Jun 2026 13:07:39 +0100
Message-ID: <20260629120749.566063-9-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629120749.566063-1-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
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
index 3d4d5f9a6f1b..da8a07cd49a1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4644,11 +4644,25 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 
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
index 9eb03f1d1f1d..483bcebd6977 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1892,8 +1892,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
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
@@ -2106,13 +2109,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
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
index 546bc1cf9391..9fb733489898 100644
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

