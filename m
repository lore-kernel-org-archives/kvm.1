Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED63FCB2C;
	Tue, 26 May 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800755; cv=none; b=NkYaIIfNRv9W/rZBJy23d3s7Y0DhfSpLvUMsIa3kjkZodf6A/SREvJZSWvJawf5PCQoLEDlNrdLsCcnX0VlUharmrxHWEsRHvyB1tK9VnjCT+66xECBH2Zs4wKvC8dWI8IwBfxCWDcexrH8Fg08cRcjRT6lYU6k91J+AtY30MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800755; c=relaxed/simple;
	bh=k8FwSeBgzlZlmMDe++ZeoffIVutmaiubqEM1iO0Babg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy+UXGN4NsZxPgFYGxEix0VhSur6VRskj85sfGz52GCmr0U7niEu+x307Toz0pTZ10JITGc+3JbMLI90TLuKhIv5Jm3fPMQl+O6INrZ1n6NWac1ktd4Ex0gfFDgCvykcqnuPtiKaa1ZRdDrjcYP1OPnoDuuMM7Cvylt7Lrk3hkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=c12QtxIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vgPihFIx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="c12QtxIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vgPihFIx"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B95997A019A;
	Tue, 26 May 2026 09:05:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 09:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779800752; x=
	1779887152; bh=5z/AbsTF67VwOQ5tREysiGeDZVwyPpbI1FBFpn7cWY8=; b=c
	12QtxIRUXdGwwH8jwQTu6QrV/eh/GCx01CfBPzMDOlbUVbgEsUA4pjDq3GF6yK1b
	Yio6zurc/imnGWOjZfVC3dGc298KJ7lHmZnQVnOv3yTqAxNOAHlloA6neF9VzYIW
	JAke4CQ/o94SNqQi46MYuCYjpckrZoUxtEmDBvIrGcn+3oaBWoLdl7ClRcd7yHce
	o9enHlZEpwRs7UN2/ED8nGWxqBu/LBDTPWnZG4KhgMRYmR7SBLV9j1yfuYjC9hib
	CHd82YqYIUdHCmed6OZwcTRHIYKvAoCqSD9AiuQSjQDt7ZAYD/PvYZxvNmxt6hyZ
	PNMr2BNAw7sMRUrn0YLCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779800752; x=1779887152; bh=5
	z/AbsTF67VwOQ5tREysiGeDZVwyPpbI1FBFpn7cWY8=; b=vgPihFIxeDNsX/e2V
	xHtU6g4fiaARF74+PzI0CHIl10Lxyv+Xd6t6Ix6Blq4+skZl3ORHEGa5DULsRFrO
	BizCuusCSgaDhy1HX7QyrF4niSdK+1c0bQmAje6MmfMPfhmMtbemr66gYIg/uqWG
	e81AP/akoBVGuiru93u0MytZiBYYVxZIvEEsUxzBJMtbnPdApckZspxNuagYE1T0
	7dPHdt/dIFonWl3DgqFaB859zPlhXYTUNmhU6l+LYc2HB/De1k7v/s6Qg6Vmyjrm
	sZWqK9X1CLSXYdiE25+lcSQwNoOAw662ToCG69e/9gAzQ1jsJl8uE3JhErIXg9Di
	jsbOQ==
X-ME-Sender: <xms:sJoVaopw4DmGFrngpPo90VFUVexHbOehVmaAjqDx2xa7V41HpOsKuQ>
    <xme:sJoVaikuDoMAUVsA2tz1-lI-bkVgd200lQMFBYOPuvOZkR70qJUTmDQALmkKaI_lN
    kuzgZO7WX0Xr1V9yTpeK-jQvYfmm-G9PNWh0aKEGjObteP6VNsikTU>
X-ME-Received: <xmr:sJoValu9C-9iJJXGzbgSSEQxWAUhuKg-UAvQM9yCiI6oDwa9scc3yeh7zxdWgA>
X-ME-Proxy-Cause: dmFkZTEJiC033GhjL2GdnX/sXIn31a6xYH9Q9kJLS3tMsbkgwO/cImnHqXQKfEc55wOLx4
    i2tqVUZQjDS/XsxdV1Neul2ks/uVgINeMKnTDgBTDd49K013fUhaa7mbXp5KOF+CzusOdT
    UiYD/yezdXIvKfe8z5w2tcDXcgJNRSU5eSwZFLQl4UtnpivyD/d0gOKuFq22BcEw4tqdAi
    ZrLfx6gsOEL+8JLB9yUFNWntFWViMy1Q2hMU0QsTFycK4r8MnF1MjvTDo2QKxDh/PpEdKA
    ZnnGzw8DPiuoI+QbA8cmDBSDEJ+Eojxn1EXRLRmRJNLXOxLbY2LwfoxO6aBp6BbF/3ourF
    UdEs5iVYJELfn9jpGI6iEoj+FoWdfm+tCA0vZfRqLV/kb/KnjWDMDsmj3WHNWInthvIGhP
    ehMVkALa/wNbA80mZf3/CwuB1yO+poNoZmaX/e6UNakIyclAenqv3BoYRoLXeIh6KqJFem
    GneTl3f6iVrJduldKxMMXmxBbMHZdJYHAv1qz0/ksxx/q4Zy98sPRUG+ndsiVhD3sqBaT6
    d65Z4dAsrjpt+j3NH7uU4QsuNFTn619dClPX3yqNBaPqk1RRe8oQg5Ob9xcK0+fUyRCUS6
    duUeT/Nr5sKUj7wjw84K/uMwB7ccaM1IISzH9N9CYuR5YuEfYkGphW25mshQ
X-ME-Proxy: <xmx:sJoVapdy3z-AIgBAOM7Z5kJzI5NhHfwkRIno4o_dIF5gIXgIsLsU_Q>
    <xmx:sJoVavbGE1cBrS63Hg0kaAaUqs3ytPIuH6Qq3Z_FqdvqpaFowdlxsA>
    <xmx:sJoVap3MPZYdRv_WqGBwEDl2dEtuCLurplMY7xkEiY_Ccju2TVmwVg>
    <xmx:sJoVagpT0pTlxSESQGhDCToKirPeBlMV2bset6W8h3mq-q-12lEIwQ>
    <xmx:sJoValqk7-HAKguLA7dsfNwsRal6SVev-LZwn-dx8912I9V-ou96X3vN>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:52 -0400 (EDT)
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
Subject: [PATCH v5 13/18] mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP
Date: Tue, 26 May 2026 14:05:01 +0100
Message-ID: <20260526130509.2748441-14-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526130509.2748441-1-kirill@shutemov.name>
References: <20260526130509.2748441-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Wire the fault side of read-write protection tracking and turn the
userspace interface on.

An RWP-protected PTE is PAGE_NONE with the uffd bit set. The
PROT_NONE triggers a fault on any access; the uffd bit distinguishes
it from plain mprotect(PROT_NONE) or NUMA hinting.

Fault dispatch, per level:

  PTE     handle_pte_fault()    -> do_uffd_rwp()
  PMD     __handle_mm_fault()   -> do_huge_pmd_uffd_rwp()
  hugetlb hugetlb_fault()       -> hugetlb_handle_userfault()

The RWP branches gate on userfaultfd_pte_rwp() / userfaultfd_huge_pmd_rwp()
(VM_UFFD_RWP plus the uffd bit) and fall through to do_numa_page() /
do_huge_pmd_numa_page() otherwise. Each delivers a
UFFD_PAGEFAULT_FLAG_RWP message through handle_userfault(); the handler
resolves it with UFFDIO_RWPROTECT clearing MODE_RWP.

userfaultfd_must_wait() and userfaultfd_huge_must_wait() add matching
protnone+uffd waiters so sync-mode fault handlers block correctly.

Expose the UAPI:

  UFFDIO_REGISTER_MODE_RWP   -> UFFD_API_REGISTER_MODES
  UFFD_FEATURE_RWP           -> UFFD_API_FEATURES
  _UFFDIO_RWPROTECT          -> UFFD_API_RANGE_IOCTLS
                                UFFD_API_RANGE_IOCTLS_BASIC

UFFD_FEATURE_RWP is masked out at UFFDIO_API time when PROT_NONE is
not available or VM_UFFD_RWP aliases VM_NONE (32-bit), so userspace
never sees an advertised-but-broken feature.

Works on anonymous, shmem, and hugetlb memory.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/huge_mm.h          |  7 +++++++
 include/linux/userfaultfd_k.h    | 24 ++++++++++++++++++++++++
 include/uapi/linux/userfaultfd.h | 12 ++++++++----
 mm/huge_memory.c                 |  5 +++++
 mm/hugetlb.c                     | 11 +++++++++++
 mm/memory.c                      | 29 +++++++++++++++++++++++++++--
 mm/userfaultfd.c                 | 32 ++++++++++++++++++++++++++++++--
 7 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index edece3e26985..fe48d76957fb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -529,6 +529,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
+vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf);
+
 vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf);
 
 extern struct folio *huge_zero_folio;
@@ -716,6 +718,11 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	return NULL;
 }
 
+static inline vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf)
+{
+	return 0;
+}
+
 static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
 	return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 28fc44733302..332fad1560ec 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -233,6 +233,18 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
 	return userfaultfd_wp(vma) && pmd_uffd(pmd);
 }
 
+static inline bool userfaultfd_pte_rwp(struct vm_area_struct *vma,
+				       pte_t pte)
+{
+	return userfaultfd_rwp(vma) && pte_uffd(pte);
+}
+
+static inline bool userfaultfd_huge_pmd_rwp(struct vm_area_struct *vma,
+					    pmd_t pmd)
+{
+	return userfaultfd_rwp(vma) && pmd_uffd(pmd);
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & __VM_UFFD_FLAGS;
@@ -363,6 +375,18 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
 	return false;
 }
 
+static inline bool userfaultfd_pte_rwp(struct vm_area_struct *vma,
+				       pte_t pte)
+{
+	return false;
+}
+
+static inline bool userfaultfd_huge_pmd_rwp(struct vm_area_struct *vma,
+					    pmd_t pmd)
+{
+	return false;
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 7b78aa3b5318..d803e76d47ad 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -25,7 +25,8 @@
 #define UFFD_API ((__u64)0xAA)
 #define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
 				 UFFDIO_REGISTER_MODE_WP |	\
-				 UFFDIO_REGISTER_MODE_MINOR)
+				 UFFDIO_REGISTER_MODE_MINOR |	\
+				 UFFDIO_REGISTER_MODE_RWP)
 #define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
 			   UFFD_FEATURE_EVENT_FORK |		\
 			   UFFD_FEATURE_EVENT_REMAP |		\
@@ -42,7 +43,8 @@
 			   UFFD_FEATURE_WP_UNPOPULATED |	\
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
-			   UFFD_FEATURE_MOVE)
+			   UFFD_FEATURE_MOVE |			\
+			   UFFD_FEATURE_RWP)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -54,13 +56,15 @@
 	 (__u64)1 << _UFFDIO_MOVE |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 #define UFFD_API_RANGE_IOCTLS_BASIC		\
 	((__u64)1 << _UFFDIO_WAKE |		\
 	 (__u64)1 << _UFFDIO_COPY |		\
 	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
 	 (__u64)1 << _UFFDIO_CONTINUE |		\
-	 (__u64)1 << _UFFDIO_POISON)
+	 (__u64)1 << _UFFDIO_POISON |		\
+	 (__u64)1 << _UFFDIO_RWPROTECT)
 
 /*
  * Valid ioctl command number range with this API is from 0x00 to
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6417d883d2e4..72cb44332004 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2289,6 +2289,11 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	return pmd_dirty(pmd);
 }
 
+vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf)
+{
+	return handle_userfault(vmf, VM_UFFD_RWP);
+}
+
 /* NUMA hinting page fault entry point for trans huge pmds */
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0d8d39cd8888..d4da39d698b8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6062,6 +6062,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_mutex;
 	}
 
+	/*
+	 * Protnone hugetlb PTEs with the uffd bit are used by
+	 * userfaultfd RWP for access tracking. Plain PROT_NONE (without the
+	 * marker) is not an RWP fault and is not expected on hugetlb (no
+	 * NUMA hinting), so let normal hugetlb fault handling proceed.
+	 */
+	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
+	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {
+		return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
+	}
+
 	/*
 	 * If we are going to COW/unshare the mapping later, we examine the
 	 * pending reservations for this page now. This will ensure that any
diff --git a/mm/memory.c b/mm/memory.c
index 06473285c0dc..111fdae14120 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6122,6 +6122,14 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 		if (!pte_present(ptent) || !pte_protnone(ptent))
 			continue;
 
+		/*
+		 * RWP-armed PTEs are also protnone but carry _PAGE_UFFD as a
+		 * marker. Leave them alone -- rewriting to vm_page_prot would
+		 * stop the RWP trap.
+		 */
+		if (pte_uffd(ptent))
+			continue;
+
 		if (pfn_folio(pte_pfn(ptent)) != folio)
 			continue;
 
@@ -6137,6 +6145,12 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 	}
 }
 
+static vm_fault_t do_uffd_rwp(struct vm_fault *vmf)
+{
+	pte_unmap(vmf->pte);
+	return handle_userfault(vmf, VM_UFFD_RWP);
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -6412,8 +6426,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		/*
+		 * RWP-protected PTEs are protnone plus the uffd bit. On a
+		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
+		 * NUMA hinting and must still fall through to do_numa_page().
+		 */
+		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
+			return do_uffd_rwp(vmf);
 		return do_numa_page(vmf);
+	}
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
@@ -6527,8 +6549,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return 0;
 	}
 	if (pmd_trans_huge(vmf.orig_pmd)) {
-		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
+			if (userfaultfd_huge_pmd_rwp(vma, vmf.orig_pmd))
+				return do_huge_pmd_uffd_rwp(&vmf);
 			return do_huge_pmd_numa_page(&vmf);
+		}
 
 		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 		    !pmd_write(vmf.orig_pmd)) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index c07e3232a01a..db3707b9d977 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2668,6 +2668,12 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		return true;
+	/*
+	 * PTE is still RW-protected (protnone with uffd bit), wait for
+	 * resolution. Plain PROT_NONE without the marker is not an RWP fault.
+	 */
+	if (pte_protnone(pte) && huge_pte_uffd(pte) && (reason & VM_UFFD_RWP))
+		return true;
 
 	return false;
 }
@@ -2728,8 +2734,14 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	if (!pmd_present(_pmd))
 		return false;
 
-	if (pmd_trans_huge(_pmd))
-		return !pmd_write(_pmd) && (reason & VM_UFFD_WP);
+	if (pmd_trans_huge(_pmd)) {
+		if (!pmd_write(_pmd) && (reason & VM_UFFD_WP))
+			return true;
+		if (pmd_protnone(_pmd) && pmd_uffd(_pmd) &&
+		    (reason & VM_UFFD_RWP))
+			return true;
+		return false;
+	}
 
 	pte = pte_offset_map(pmd, address);
 	if (!pte)
@@ -2765,6 +2777,13 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	 */
 	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
 		goto out;
+	/*
+	 * PTE is still RW-protected (protnone with uffd bit), wait for
+	 * userspace to resolve. Plain PROT_NONE without the marker is not
+	 * an RWP fault.
+	 */
+	if (pte_protnone(ptent) && pte_uffd(ptent) && (reason & VM_UFFD_RWP))
+		goto out;
 
 	ret = false;
 out:
@@ -4506,6 +4525,15 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
 		uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
 	}
+	/*
+	 * RWP needs both PROT_NONE support and the uffd-wp PTE bit. The
+	 * VM_UFFD_RWP check covers compile-time unavailability; the
+	 * pgtable_supports_uffd() check covers runtime (e.g. riscv
+	 * without the SVRSW60T59B extension) where the PTE bit is declared
+	 * but not actually usable.
+	 */
+	if (VM_UFFD_RWP == VM_NONE || !pgtable_supports_uffd())
+		uffdio_api.features &= ~UFFD_FEATURE_RWP;
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
-- 
2.54.0

