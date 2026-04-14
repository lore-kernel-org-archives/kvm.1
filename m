Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72C3E95B5;
	Tue, 14 Apr 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176647; cv=none; b=chhNczqt1XNMjAQEFBouhwxFkuyDZRMC5INyXa4G4ccoeRlgLM+h5sOU5orxrSNKpYQVIjYePjnGBEJXJpPxLEvJttiDHv/0RWl3DD5F24f9SFK7wP5Tff0yQuNPKWC3TYYkQOMt9rFETrJRwNR4L3pJNU2zIiBDs5KXxrhj4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176647; c=relaxed/simple;
	bh=5Usv13hgiZWkYNFHt4wKn/lAN0ONPFvR4TE1gP6n6Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5T7vnOxnOkQkylg03YX0Zez9uXnfuoiHDzxCHCujunRtC19u8yX03zPZSUEcNvWPADGeHNVJo6eoRjeta8Gnas3QBm4zLxIikIGgRascuc47j+gSmUAS2wHI+MCeawdk0v4V3DHJE4vs7OlOTWK3H8yY/RHPtRwhOj/JdG/feU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTwu+LuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTwu+LuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA05C4AF09;
	Tue, 14 Apr 2026 14:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176647;
	bh=5Usv13hgiZWkYNFHt4wKn/lAN0ONPFvR4TE1gP6n6Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTwu+LuVInhTD0gzfbmW0BI/pLWYkLdmEIijmTh9hjyjP6B4BRP1EyKvPZAUTpWij
	 Q/mk2vLzyrkJfnkjXUbi6AUpx9aH24+ljP1FWMHildA/TrYPbZKYt/FuaMiAEWfUCk
	 6t2PKsFSC8Ur/86zTDhf8UYrPbY7DVKdiaIypsI8gRmtU35+lr7c0mGFes5+N1TcnG
	 ZGFwx5ecVjPJAdHGefNqJZj08a6dzFZxsnuOJ250KOgl6fPceMDbWoxMJWsuNxvtCI
	 uu6ZDAOiq36aseciDqaANjbJZRTHTJ5HipmwLsi77rbyw+SOd5aVTut1pNoIN10mmS
	 gCTBkgHcC1iHQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2042F40068;
	Tue, 14 Apr 2026 10:24:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 10:24:05 -0400
X-ME-Sender: <xms:BU7eaV3BLPfXH2by1zXfjmiSp6_laxquzR4SzwXFsbsmI_L5y2dylw>
    <xme:BU7eaTBAZ3CSB16J7-Hd8aMVYsmQsRWDw-jpNxyse50MTG84PJTAsNX6Iu151TU5J
    6Ym6pGNdV0sZ_Pl7fmwWTJqPmZjTq6UMK3H3lNZv0if7dRxDdLxmA>
X-ME-Received: <xmr:BU7eaa_G0B3kgnmbQvvYeXFJslH-DLSR-Z6p5L05Pm9rHRhFrWT7VfbBwRKEcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhephfdujeefvdegkefffedvkeehkeekueevfedtleehgeetlefg
    feevveeukefhtdetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilh
    hfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqddu
    ieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghessh
    hhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
    rghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    rhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:BU7eaZ8KcFTV2hgqr5DKmuMlkAu8QRQ-JlYF1cAzNEZMeQtd5DsIZA>
    <xmx:BU7eaS1UMmQ2oPWk4aVQ0wQ3kT6SiTutxnzDQ62abmwCqYf_2ye-6w>
    <xmx:BU7eaZ8cXP2ouJZnk7NNqnR6Hd6b1ycF4WapTNSLueXQLLor_CoTog>
    <xmx:BU7eaTdSzxmMqURIZ_ZXugPBWJfoAQlz9Tfklh_OIbWXpshzh0QEUQ>
    <xmx:BU7eaVG62pk9VDMt8QjiSNF3lBAyddI2HITsjSZPuKn0eigfnh3_t7gp>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:05 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [RFC, PATCH 05/12] mm: intercept protnone faults on VM_UFFD_MINOR anonymous VMAs
Date: Tue, 14 Apr 2026 15:23:39 +0100
Message-ID: <20260414142354.1465950-6-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a protnone PTE/PMD fault occurs on a VMA with VM_UFFD_MINOR,
dispatch to the userfaultfd minor fault path instead of NUMA balancing.
Async: restore permissions inline. Sync: deliver via handle_userfault().

Feed NUMA locality stats from the fault path via task_numa_fault()
so the scheduler retains placement data even though NUMA scanning
is skipped on these VMAs.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 include/linux/huge_mm.h |  6 +++++
 mm/huge_memory.c        | 24 +++++++++++++++++++
 mm/memory.c             | 51 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a4d9f964dfde..a900bb530998 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -519,6 +519,7 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 }
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
+vm_fault_t do_huge_pmd_uffd_minor(struct vm_fault *vmf);
 
 vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf);
 
@@ -707,6 +708,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
+static inline vm_fault_t do_huge_pmd_uffd_minor(struct vm_fault *vmf)
+{
+	return 0;
+}
+
 static inline vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
 {
 	return 0;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ad736ff007c..264c646a8573 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2181,6 +2181,30 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	return pmd_dirty(pmd);
 }
 
+vm_fault_t do_huge_pmd_uffd_minor(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+
+	if (userfaultfd_minor_async(vma)) {
+		pmd_t pmd;
+
+		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+		if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
+			spin_unlock(vmf->ptl);
+			return 0;
+		}
+		pmd = pmd_modify(vmf->orig_pmd, vma->vm_page_prot);
+		pmd = pmd_mkyoung(pmd);
+		set_pmd_at(vma->vm_mm, vmf->address & HPAGE_PMD_MASK,
+			   vmf->pmd, pmd);
+		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
+
+	return handle_userfault(vmf, VM_UFFD_MINOR);
+}
+
 /* NUMA hinting page fault entry point for trans huge pmds */
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 {
diff --git a/mm/memory.c b/mm/memory.c
index c65e82c86fed..f068ff4027e8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6045,6 +6045,47 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 	}
 }
 
+static void uffd_minor_feed_numa_fault(struct vm_fault *vmf)
+{
+	struct folio *folio;
+
+	folio = vm_normal_folio(vmf->vma, vmf->address, vmf->orig_pte);
+	if (folio) {
+		int nid = folio_nid(folio);
+		int flags = 0;
+
+		if (nid == numa_node_id())
+			flags |= TNF_FAULT_LOCAL;
+		task_numa_fault(folio_last_cpupid(folio), nid, 1, flags);
+	}
+}
+
+static vm_fault_t do_uffd_minor_anon(struct vm_fault *vmf)
+{
+	/* Feed NUMA stats even though we skip NUMA scanning on this VMA */
+	uffd_minor_feed_numa_fault(vmf);
+
+	if (userfaultfd_minor_async(vmf->vma)) {
+		pte_t pte;
+
+		spin_lock(vmf->ptl);
+		if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+			pte_unmap_unlock(vmf->pte, vmf->ptl);
+			return 0;
+		}
+		pte = pte_modify(vmf->orig_pte, vmf->vma->vm_page_prot);
+		pte = pte_mkyoung(pte);
+		set_pte_at(vmf->vma->vm_mm, vmf->address, vmf->pte, pte);
+		update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+
+	/* Sync mode: unmap PTE and deliver to userfaultfd handler */
+	pte_unmap(vmf->pte);
+	return handle_userfault(vmf, VM_UFFD_MINOR);
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -6319,8 +6360,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
-	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
+	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
+		if (userfaultfd_minor(vmf->vma))
+			return do_uffd_minor_anon(vmf);
 		return do_numa_page(vmf);
+	}
 
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
@@ -6434,8 +6478,11 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		return 0;
 	}
 	if (pmd_trans_huge(vmf.orig_pmd)) {
-		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma))
+		if (pmd_protnone(vmf.orig_pmd) && vma_is_accessible(vma)) {
+			if (userfaultfd_minor(vma))
+				return do_huge_pmd_uffd_minor(&vmf);
 			return do_huge_pmd_numa_page(&vmf);
+		}
 
 		if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
 		    !pmd_write(vmf.orig_pmd)) {
-- 
2.51.2

