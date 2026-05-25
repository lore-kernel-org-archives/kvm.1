Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705263090C6;
	Mon, 25 May 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709132; cv=none; b=LEjUfYuwIhzpxRq/dOnJyu2NjA1BPXpGYK5BaAEDu9xL2Vtz2cQmSUEGb3T4ucnujB3s4fMvpPFl87pWnRak/0Evv7iOk4pmg3eOSRchyYL19cTYYQNkUCZNpqO2m/nXLgNym3zI0Nyv5yBor+VqqQJOETC/6ZxgZPvWrYScL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709132; c=relaxed/simple;
	bh=u3dPUTchYjuZGOdBM6mVzH4C5Zzq6kXfnLj6+3I0za8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew6XMD+Ox0UXsTXtfH6C++16HQvflmCqGWJINBrmmauWnLWFPsOSAqmBNrtVpfsaqJOiyYTKwH8ihCNY/OHT+iMBj0meK2IuZJCY2BK+qok8OF3ab8deJps3LRNh+BoPIBfQS5VUktsAjALEvsLWgTQyrC4slYGSLk0jPugJ6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkBJOnaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkBJOnaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13911F00A3A;
	Mon, 25 May 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779709131;
	bh=Ps0N9FhSg2WInzdVQ3glYAf7iP/rHFVJxbQNtaX3gcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkBJOnaFtPJHLE94XqDZFU860sPGU7UzqZ0m6KATTLDfn97gNkoyhMMGP3n8BUDdf
	 yStaI0Zj9oe/YyTCO46KyUf2YrQOFc+RbTr5Kscr3wEQ/ZRzGssPHhDEZqa+ikY/hV
	 O/gnXnAnHs6fDoXFFXOmzL96PSb1hAOXEjsHLnmdSZKIj6yrZ8C6wqL/Fdsh/E7g/I
	 K/SOZJbGzjeWiUYiOoUepHv+IkntOZFO3WmXkOWSqRZUNq3hTbsl1imM54fX3vSEo+
	 BELRoFfFt9w89ZbcpZYyfiqvi1dmsREfIzeLwnb1sGMjzRv+xNHudvCqctojOUahB5
	 iUFaSHNAFqfEw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B394F40082;
	Mon, 25 May 2026 07:38:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 25 May 2026 07:38:50 -0400
X-ME-Sender: <xms:yjQUanH5l21ui60CT81whN-ivvEDqs95Je949U64XpoWDK_Uc6DRUg>
    <xme:yjQUaoQCJ_TDYdo-4ViE6BK6ydWzVA2P8KbA7axeOaWBw6UPCo8rwJ4qArS2eSc8d
    ItzcDEyVu3JxyzVYtKN-jG6rSZydTLrmLPwzZ_5MFu1vlqtCx8pTg>
X-ME-Received: <xmr:yjQUahrqSxOxePBbrU_ukRcNMwAY1XZBeo22zDEEfAcXDc1-W5h4kVW31KcOqA>
X-ME-Proxy-Cause: dmFkZTEfoRdVBJYWBUADV7d9kIV+Nxm/pVUcgu2VEqiWnj8eQrxuVRmWJvpc9q3Oqv2JCI
    in3fN4Zd8kb+AIzxXT1aE8XhYzXjllPczHZpsDuave1RqUEJt2aM8NK4F+1xGB1lHbYgSB
    4+lR3LF0kMycZigQtO5w6VfLN0Aex+LApk+NDe4mN/AQtgEH82UY4yLdpanr1nUEhfYRPX
    qXaeB8tr6YycPJO/GKcHBfWh4XfvSwFXkiL84UUAHkAJqW6Bc0LpWOIYef91VRiFvO85Cg
    Xd8jmXx4jYBCkCANHtSsVLhpCbXIiIojLruOFr51QxylDrx8yfg2/g0kqIsUfNxsLFZyNP
    nEjj3iDx3Pih6xK1tSzuV2TKDG9t7caUpsOxcJHSxNo/j6vMD5+xZJdixPCSN5F5VW5BpS
    CMhUff1ycXkGeotLXYjcA7XaRuiwzGRJJYP1CiWCis02P2P2D+sbk/R6Vq3YcOpvx+7NVY
    02CdvOeg4gtHAIdwNDSdP6hvITAphIltUDsfDNLu1gKBL4QkleYh63JZk6PEiUDceeiqTk
    pjg5DSe82vF51LR2ATCUKQH7BsFFjuliK5Avxdd8WLkHY6w4J3QIZyAaJgZHBy+Rd9+8bN
    1XCHyZJhWdnxFkS1nrcinn/kw+oCB9wEdzzkHbYBwGwNowh5hGHHYdqYGn2Q
X-ME-Proxy: <xmx:yjQUauoZejke7cUDVFyqgSWZtEJZbPrMgza4v4f7qzWHAYDMkXiV-A>
    <xmx:yjQUak2XxcoFHFheX56Q5ui38MoWnc6tTGZiO2v5F2n__ZX6M1cjUw>
    <xmx:yjQUaqirVRwOz3EsiwQF5w4KM26OzLChgdT_NJk2fqhpyu0a3RsyLg>
    <xmx:yjQUarkshEdqK5I_GJo0hLKmU3u_XucSeTX6F2p06ds4TKl8WaPwTg>
    <xmx:yjQUaq9vozRPkAE8dAOEcF9hZTm7Uah3DKosBWDbC5e4wMOjpCS1SlQr>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 07:38:48 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
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
Subject: [PATCH v4 07/14] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Mon, 25 May 2026 12:37:21 +0100
Message-ID: <20260525113737.1942478-8-kas@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525113737.1942478-1-kas@kernel.org>
References: <20260525113737.1942478-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 include/linux/mm.h | 10 +++++++++-
 mm/khugepaged.c    | 18 +++++++++++-------
 mm/rmap.c          |  2 +-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5953106758fa..f72bf5ccf72c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4600,11 +4600,19 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 
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
+	 */
+	if (vma->vm_flags & VM_UFFD_RWP)
+		return false;
+
 	/*
 	 * If callers don't want to honor NUMA hinting faults, no need to
 	 * determine if we would actually have to trigger a NUMA hinting fault.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index afa218be15de..4f3fedcd75cf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1895,8 +1895,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
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
@@ -2109,13 +2112,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
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

