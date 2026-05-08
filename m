Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B43FE34C;
	Fri,  8 May 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255784; cv=none; b=dTVLAOW9+bkL3vHYGxXRjAnsiQaUJT4+lXFDngrYl+mSoMNigAquvWU981rn51RB8CoRNCTiT0qLntTfqsusOagDp/j4MlCG/pibdPlimqk7Ksq9DmgPES/xRbRWsPlRnbahUM17cupzYwmyx+pylc5S7qXYSqzhS3HlsW7wNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255784; c=relaxed/simple;
	bh=6KqTjREg/f3OEz7aTNTkTQsj2SxH2HMauSfeIrq1M7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PS7HoPPr3zOsys7JFKzWJ8XZd71WPQ9CWUrFAbpw119+owutLhmm5gZUVw0CoyeqoOQwkFCgN+on5nGHL6m4WxTzPD9MHGxpQAzdcE75SfIwsfcWiwhJAzfHTHJv5beQFDoYpGS5KxZVI2d/8rS+Q1C/GmIj4jPnyqp4v0drZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq7GB9Y/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq7GB9Y/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A332C2BCC7;
	Fri,  8 May 2026 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778255783;
	bh=6KqTjREg/f3OEz7aTNTkTQsj2SxH2HMauSfeIrq1M7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq7GB9Y/mPGmmUIZ8OMYVHnKyW2HZUxrCi1Do4lh1sDWkrzv7UppUITyXEAotQI0J
	 HXYzkTm+QpSEumf7DL621tPS7jyDSs/CDjlbWDJqgyYAB4EMKFWOrzDH/1C95FO13l
	 mExhP64fTGIZIlLhORxN9SKNg5mQjoXpSAEM5QPCpBzpsbR2Gddd0KW/qWRQ8eh/a5
	 2v2tB5B772x6H8R2UEN8UQqwv6eegITlb83U8KMa1bTUyJ7uiLuib2Dv584s7Ig3rL
	 A+0CB6AKORyj5+CqdrvZrKdXBscKo/e++iTJZOYhb8qZwTf2eraeG1UkOkC1bMtMEL
	 op9Ppq/cC0tEQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 998A3F4006B;
	Fri,  8 May 2026 11:56:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 08 May 2026 11:56:22 -0400
X-ME-Sender: <xms:pgf-aRgHrQQko-378y0Ec2Qm8PKo_owtGpXIMP_K4iuOoNt5mC10LQ>
    <xme:pgf-aZ_cVZr06qmrgqf3Dl1X7SW9wYKrXCvtBHve5gSHBwty4WZO0AFFU0UoMb-QQ
    9UPTk7rRTiD6xJjtHXCmWnezNI-TttHfQDWzagVBYGqHOyHWS_hECM>
X-ME-Received: <xmr:pgf-aZkJF2jBcxrd4gQw-9Yx4P9CIRyAFkv70Op6jD88EhjfrKhemBfihXTdtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfgggtgfesthekre
    dtredtjeenucfhrhhomhepfdfmihhrhihlucfuhhhuthhsvghmrghuucdlofgvthgrmddf
    uceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpefhvdefvdevje
    evhefhhfevudefudejfeduvdekheeludfhiefhhedujeffffeigfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmth
    hprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdek
    qdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprh
    gtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrphhptheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmh
    drhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihgu
    ihgrrdgtohhm
X-ME-Proxy: <xmx:pgf-af2cVv1YDLY0wYSuJEG7PjzYgcouZVaTCfOdqLWKx2GXKXvddg>
    <xmx:pgf-aWR48JyQ5uYqVH0VqoiAO4x-djJMf5bLZAyz3iVhDE_E6Klnjw>
    <xmx:pgf-aXMsBpJJlF4fCyePGvrYT2CPkCxaTaY6sH7Lq7-LTZE1fC9hng>
    <xmx:pgf-aShlhbx0iwB3sJB7cn9jiGyxu_ewa23B-NUaqkqioKTyzjSO1w>
    <xmx:pgf-afIwMGd5pR5wygvD5TL1mzyWJnUd44cs5vKZxbnIbgjs_xr3uMTj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 11:56:22 -0400 (EDT)
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
Subject: [PATCH v2 07/14] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Fri,  8 May 2026 16:55:19 +0100
Message-ID: <c88e78ffb2cc5ca81f5a6319b7e3c4ffd8baefe1.1778254670.git.kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1778254670.git.kas@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
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
---
 include/linux/mm.h | 10 +++++++++-
 mm/khugepaged.c    | 18 +++++++++++-------
 mm/rmap.c          |  2 +-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f2b6c6cc572..675480c760a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4605,11 +4605,19 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 
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
index de0644bde400..a798c542c849 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1532,8 +1532,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
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
@@ -1746,13 +1749,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
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
index 05056c213203..1426d1ece917 100644
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
2.51.2

