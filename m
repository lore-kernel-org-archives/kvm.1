Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51A42642D;
	Mon,  6 Jul 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327717; cv=none; b=e46YUwNPmLjw5d1itgHd6nr8YM5+5REETWzIMGpOnh92JYq7Oe4SZTRnXRunpK82pNM13ddP5lGyBzgcUvUOd46L1v+h8CJAGdWkzczZCroUwll9aNserQJmDZUP2TWUDGU/+3MtosUvHPzQp6D1jpS3OO47vDzxcnbh5xyWTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327717; c=relaxed/simple;
	bh=KFFpEjN/ywV5dMnHVG+4DsmF8cpDvplAJnlVzGgQ1f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KabhDvx+z+icOcaXGYnwyRfJ7NlTjE/g6ekeVp/MmB5qEkeoJnqkFaUwKWXOcZ8RB8eiufHnnpccw8pJregM0oV68yMnSSRiiryuJMV6JvRUhgBOfKyv9Y/fyTfnVsL4/LRqJjX44FgBk2y8dEA2U1Tmp/bD7S6J1CIuefUge0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=EAxH9UAh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjPN+cIK; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="EAxH9UAh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjPN+cIK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 943687A00F8;
	Mon,  6 Jul 2026 04:48:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 04:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1783327707; x=1783414107; bh=85dlYldMrNgF2zIT9pjGLNO/irueGh3B
	4Qs719th2NU=; b=EAxH9UAhWvZq8KUi4Yf0+Yoczs39dHDOXTPfGTjT8eftHFAa
	0QA5+O+DH5AojbtJSsUFAor0FSGfVkrMFTQaH6M/JE0dAjWwGQEqR91LGWv6SEkN
	tDdcLj1OrsKz53gk3s0RpheMZdy77wQWL5mmInyIz+ol+jnQkSmVHSfEacHQ1Mp0
	+J+R3zvSLk1sTc9CWt2L1JdC9MIvdEtGX5K6YjivGlq+QAUr1ieVVPXu/8ImYsmq
	X3ECJHHZ3b8iYckvaxMQa0wt3AN9TOPcm5xzLR6Z58WkJddnlzo+Rcu0E1G1F8n1
	F9e9HMoTiux1MCg1oNp/DjOJU4WGEA1GkUNliQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783327707; x=
	1783414107; bh=85dlYldMrNgF2zIT9pjGLNO/irueGh3B4Qs719th2NU=; b=Q
	jPN+cIKx5PiypT2ARRNRT572tOK3HxHoH3V8Aa/oI8rGu2d4c8xKEdAP/Li32uoj
	SqL19CC/+IlhX9sQ8bWsftd03XYyktcHIj0bLc68HYaINWUOUnTlElbeC+6oQjhS
	c3LPNp3y2pAEva3e4y8MPgQzy4+EYEZzLh6Ma7vKB2r6eErCJXKl/8Ef1BsoO1E1
	/3iyeOeFlOxdpMND66BkZ7IFl8KNbOL1eH4VY8yJ+DAGE00m7W6VSM6nDjyZT1tS
	lkIEt2t+VgtMxhPACEAHpr2OMCRQMoPfMQUJWM8Y+E/ynbqFXKnJocoAXFB7zDEy
	JfXZq0/eTqWuIJxcb833A==
X-ME-Sender: <xms:22tLarXMt9oYOESL3PNAEhjI27GcUN4cGpW5-pvBNLbE05DsQGsZwA>
    <xme:22tLangOM72Pi4-_hA1kPT5MfBT6Gh2M9qgA4lk_0TF-nVTDgF02-P4FQ-GolaD_R
    7qCRlEx8J6tjqD5RF1THAPyToVVRgBQAOEwwmxzOP_Jgee8W-4zMCE>
X-ME-Received: <xmr:22tLav44Gh0vUjO34Svy5DzAATeg4hTrSp0ImF_aTyGvwf1-vzQ-5lPdzw5Bgg>
X-ME-Proxy-Cause: dmFkZTE1HAxrDWJcKyWNBJ73THul+Pni1RTBd9xrf0khQ62auo02SuQ5gbJLxkQ3Qk71Rt
    f+PGPpiBaizNM2SZ8IrfQsHK3gYtMHoaCLmDTUWsgKKZPvRJtANNe6dp0pRFbSzpZ7Ir68
    3/In0zA3QiBz7VSIJWGJB30Gj5LF7PccEnLnCBfRMAcd0Ruq/WMP2imG8KXscpScOVRs3e
    Q/wFiWTRlZPXmNZzwwnPakhtvrKLPp/eIv/XhxcMzd3pTWLxn9+uixyv/f65anc6A7PACd
    VPXopYse7MIZNJLH0eIKl8RFUktrN1v664xHjciMcFFYVrJqWrPU6fblfiG0/eGu1JYQGe
    +M8lQEJeeJ8BJ3AExmyP5xXBwUmaZmEf1QCUaqg+BaDDLl80kw85fqxz6/DSb2Kr4crD21
    c/s6VUMPwHlxxi6RmfxSpKDUA2ZktaWBzZ9iwh6vPoGVCaDbFwH0vzlYaXwJEp2zelyR9y
    AH56uliHL46u6RsfJ8pkY8NHrOXmftqQ4ha20Z+bQK18Gvsftrf1KgSYyHRabXAhJUYiLs
    OEPqQcwGCxq5vFO9fhjJHFg0CP/cHT0ENivoxsepozBOTPrQfbbGUPIFwiiUT3vsZp8eDV
    Q5klYrgBgDMF9w+pnkkmavOidghARGVqQQnQvm9H9xm+Sa0oldv5n3WgirMA
X-ME-Proxy: <xmx:22tLav6IYjNa83ayTsrwAUwzMd_psGoRALYNRc_MDJ-XVcT8YU-BAw>
    <xmx:22tLatHa-MQnqWfmpCtQZQDtpIEFdcjvRSMAl86WjRloLfS5yQPxQg>
    <xmx:22tLatwCgmi5NiMTIb-i9p37IgNoBGtrY31nECD7PV-YdPzzHXxqpA>
    <xmx:22tLat0Frghtj5KVdnfUgsryMYbQVdcHKqf0IekCvbetQQzxlxtjWg>
    <xmx:22tLai34a4weoVbdtfkHz1Y0zPvvPig0QlTCap_TkblsyYiGpQU_tYyG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 04:48:26 -0400 (EDT)
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
Subject: [PATCH v9 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Mon,  6 Jul 2026 09:47:57 +0100
Message-ID: <20260706084805.8400-9-kirill@shutemov.name>
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

