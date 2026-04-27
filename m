Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F543ACA60;
	Mon, 27 Apr 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290464; cv=none; b=GF+h7BbcDwWXNxeg5oQ3vX11UsU84WqzmQmpj6awRLua/PLd9zM1N6ivelqcpcGaU2zE+SeN/weeOA0zyphE0xcU0EV9Yi2fmU7ajKXYOJFOaOs7fUEesmp+du5C9JLeISo5lWEhOLNhU+ays8/iwjnggrcARlwe39v+uco2Bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290464; c=relaxed/simple;
	bh=MmROK3Pdv7PoW41hl/J7s4OwsgZ9V6AbB+xCexOn0wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+xyzPpVwYTSYkoC+hLAs/LRwZzinZrZyHNesXkM8QiaghVPO9nOd962k1RZy8ogXhqzFowTXpZOwcmOGOE4KgPE8slRzLJfsoYM7kCKUB2rmDAu6lYMqdFyrXMXtGAxcQ9b5EL/y/x6p4/UYfClV+AxTTpYMrQ/xGRMtT0pffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKJ7RQR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKJ7RQR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4C8C4AF0B;
	Mon, 27 Apr 2026 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777290463;
	bh=MmROK3Pdv7PoW41hl/J7s4OwsgZ9V6AbB+xCexOn0wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKJ7RQR4AzymM02s037dHuUTjtHIdM8/sdtRMIy6+k41Jc6RD5c75ENpM4nmuJ47p
	 39S/JpBnFMZJGyCj8zNXhqjI0lFSeG/XCAv+eACl5a8Pxa57skbBPYCciQkk2yBKjZ
	 PKiU5AlTS857LIW14mWODWE2cCfEycmncB5SN0c6gMGF4wRU0mNsIACxuRnMp3rWgw
	 AgNCdOsfSPtb69cQivZ3vZcucBvrICr2R6kjgPymIUcNMq/HzvKumXgxzls272+FVX
	 D3TqvqYFdmE+kl+CmiVcCiIQIGTNmk4Za66SfaQeFJePFHfQSUm879zIjyjHOufI1n
	 sqOepouRQfx+A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3EACDF40069;
	Mon, 27 Apr 2026 07:47:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 07:47:42 -0400
X-ME-Sender: <xms:3kzvaeJtSRIIjLgOr4jnX3yckW3--CYu1Yt3MO63lD4jNb7GkHAV-w>
    <xme:3kzvaaEcf9hT1o25wGWy9uo_7ctl8ftBBmrxFlk8-8keYqVQrTts_2reyYSS8fXYZ
    Rboqv6GDpSzv6MiqtMxmedaGIpfjm5kQfQNWQcmkHdSct2-myPRdgQ>
X-ME-Received: <xmr:3kzvaXMWAa2jENeZ3SNQ9_V5uDTeGCZ4Pr2kGYffPCHrq7nET0X2QbHuUF8Zaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertd
    ertdejnecuhfhrohhmpedfmfhirhihlhcuufhhuhhtshgvmhgruhculdfovghtrgdmfdcu
    oehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephfdvfedvveejve
    ehhffhvedufedujeefuddvkeehleduhfeihfehudejffffiefgnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtph
    gruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedq
    khgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtg
    hpthhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrd
    hhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughi
    rgdrtghomh
X-ME-Proxy: <xmx:3kzvac_xgYHqyR08dlkdgB7UdTRMBFZlWeQz8QZCSUfF9-OngdIoNg>
    <xmx:3kzvac5BMB9V3QQxIXVmx5XZPCHBLOYm7_ry498gaeiMx9kRNCo1BQ>
    <xmx:3kzvaZUq3O_1s--8DgcnkUFnlAN4QVbvwYgPbsx8_pWZ7qfKMNFdEg>
    <xmx:3kzvaaIlTbanB03ZiiwyH5h_IdIC90xEyeDJnXgeAAVuaP170NQwrA>
    <xmx:3kzvaeTAonRYJiBr87OcVsqBmUyIYP5m-o1Jk-9YIoweulF7S2D3kJ8M>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 07:47:40 -0400 (EDT)
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
Subject: [PATCH 11/14] userfaultfd: add UFFD_FEATURE_RWP_ASYNC for async fault resolution
Date: Mon, 27 Apr 2026 12:45:59 +0100
Message-ID: <20260427114607.4068647-12-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260427114607.4068647-1-kas@kernel.org>
References: <20260427114607.4068647-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sync RWP delivers a message and blocks the faulting thread until the
handler resolves the fault. For working-set tracking the VMM does not
need the message: it just needs to know, at scan time, which pages
were touched. Async RWP serves that use case — the kernel restores
access in-place and the faulting thread continues without blocking.

The VMM reconstructs the access pattern after the fact via
PAGEMAP_SCAN: pages whose uffd bit is still set (inverted
PAGE_IS_ACCESSED) were not re-accessed since the last RWP cycle.

Worth calling out: async resolution upgrades writable private anon
PTEs via pte_mkwrite() when can_change_pte_writable() allows, mirroring
do_numa_page(). Without it, every re-access of an RWP'd writable page
would COW-fault a second time.

UFFD_FEATURE_RWP_ASYNC requires UFFD_FEATURE_RWP.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 fs/userfaultfd.c                 | 19 ++++++++++++++++++-
 include/linux/userfaultfd_k.h    |  6 ++++++
 include/uapi/linux/userfaultfd.h | 11 ++++++++++-
 mm/huge_memory.c                 | 25 ++++++++++++++++++++++++-
 mm/hugetlb.c                     | 32 +++++++++++++++++++++++++++++++-
 mm/memory.c                      | 27 +++++++++++++++++++++++++--
 6 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 6e577c4ac4dd..4a701ac830f4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -89,6 +89,11 @@ static bool userfaultfd_wp_async_ctx(struct userfaultfd_ctx *ctx)
 	return ctx && (ctx->features & UFFD_FEATURE_WP_ASYNC);
 }
 
+static bool userfaultfd_rwp_async_ctx(struct userfaultfd_ctx *ctx)
+{
+	return ctx && (ctx->features & UFFD_FEATURE_RWP_ASYNC);
+}
+
 /*
  * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
  * meaningful when userfaultfd_wp()==true on the vma and when it's
@@ -1989,6 +1994,11 @@ bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return userfaultfd_wp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
 }
 
+bool userfaultfd_rwp_async(struct vm_area_struct *vma)
+{
+	return userfaultfd_rwp_async_ctx(vma->vm_userfaultfd_ctx.ctx);
+}
+
 static inline unsigned int uffd_ctx_features(__u64 user_features)
 {
 	/*
@@ -2092,6 +2102,12 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	if (features & UFFD_FEATURE_WP_ASYNC)
 		features |= UFFD_FEATURE_WP_UNPOPULATED;
 
+	ret = -EINVAL;
+	/* RWP_ASYNC requires RWP */
+	if ((features & UFFD_FEATURE_RWP_ASYNC) &&
+	    !(features & UFFD_FEATURE_RWP))
+		goto err_out;
+
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
@@ -2114,7 +2130,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	 * but not actually usable.
 	 */
 	if (VM_UFFD_RWP == VM_NONE || !pgtable_supports_uffd())
-		uffdio_api.features &= ~UFFD_FEATURE_RWP;
+		uffdio_api.features &=
+			~(UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC);
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 37e8d0d29353..777e332edeff 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -295,6 +295,7 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
+extern bool userfaultfd_rwp_async(struct vm_area_struct *vma);
 
 void userfaultfd_reset_ctx(struct vm_area_struct *vma);
 
@@ -492,6 +493,11 @@ static inline bool userfaultfd_wp_async(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_rwp_async(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
 {
 	return false;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index d803e76d47ad..c10f08f8a618 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -44,7 +44,8 @@
 			   UFFD_FEATURE_POISON |		\
 			   UFFD_FEATURE_WP_ASYNC |		\
 			   UFFD_FEATURE_MOVE |			\
-			   UFFD_FEATURE_RWP)
+			   UFFD_FEATURE_RWP |			\
+			   UFFD_FEATURE_RWP_ASYNC)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -243,6 +244,13 @@ struct uffdio_api {
 	 * UFFDIO_REGISTER_MODE_RWP for read-write protection tracking.
 	 * Pages are made inaccessible via UFFDIO_RWPROTECT and faults
 	 * are delivered when the pages are re-accessed.
+	 *
+	 * UFFD_FEATURE_RWP_ASYNC indicates asynchronous mode for
+	 * UFFDIO_REGISTER_MODE_RWP.  When set, faults on read-write
+	 * protected pages are auto-resolved by the kernel (PTE
+	 * permissions restored immediately) without delivering a message
+	 * to the userfaultfd handler.  Use PAGEMAP_SCAN with inverted
+	 * PAGE_IS_ACCESSED to find pages that were not re-accessed.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -262,6 +270,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_WP_ASYNC			(1<<15)
 #define UFFD_FEATURE_MOVE			(1<<16)
 #define UFFD_FEATURE_RWP			(1<<17)
+#define UFFD_FEATURE_RWP_ASYNC			(1<<18)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 631e0355919f..d49facfdb16b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2266,7 +2266,30 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 
 vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf)
 {
-	return handle_userfault(vmf, VM_UFFD_RWP);
+	struct vm_area_struct *vma = vmf->vma;
+	pmd_t pmd;
+
+	if (!userfaultfd_rwp_async(vma))
+		return handle_userfault(vmf, VM_UFFD_RWP);
+
+	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd))) {
+		spin_unlock(vmf->ptl);
+		return 0;
+	}
+	pmd = pmd_modify(vmf->orig_pmd, vma->vm_page_prot);
+	/* pmd_modify() preserves _PAGE_UFFD; drop it on resolution */
+	pmd = pmd_clear_uffd(pmd);
+	pmd = pmd_mkyoung(pmd);
+	if (!pmd_write(pmd) &&
+	    vma_wants_manual_pte_write_upgrade(vma) &&
+	    can_change_pmd_writable(vma, vmf->address, pmd))
+		pmd = pmd_mkwrite(pmd, vma);
+	set_pmd_at(vma->vm_mm, vmf->address & HPAGE_PMD_MASK,
+		   vmf->pmd, pmd);
+	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
+	spin_unlock(vmf->ptl);
+	return 0;
 }
 
 /* NUMA hinting page fault entry point for trans huge pmds */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bac9aa852f6b..dc581adcb0ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6075,7 +6075,37 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 */
 	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
 	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {
-		return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
+		spinlock_t *ptl;
+		pte_t pte;
+
+		/* Sync: drop hugetlb locks before blocking in handle_userfault() */
+		if (!userfaultfd_rwp_async(vma))
+			return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
+
+		ptl = huge_pte_lock(h, mm, vmf.pte);
+		pte = huge_ptep_get(mm, vmf.address, vmf.pte);
+		if (pte_protnone(pte) && huge_pte_uffd(pte)) {
+			unsigned int shift = huge_page_shift(h);
+
+			pte = huge_pte_modify(pte, vma->vm_page_prot);
+			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
+			/* huge_pte_modify() preserves _PAGE_UFFD; drop it on resolution */
+			pte = huge_pte_clear_uffd(pte);
+			pte = pte_mkyoung(pte);
+			/*
+			 * Unlike do_uffd_rwp(), do not upgrade to writable
+			 * here. Hugetlb lacks a can_change_huge_pte_writable()
+			 * equivalent, so a write access will take a separate
+			 * COW fault — acceptable for the rare private hugetlb
+			 * case.
+			 */
+			set_huge_pte_at(mm, vmf.address, vmf.pte, pte,
+					huge_page_size(h));
+			update_mmu_cache(vma, vmf.address, vmf.pte);
+		}
+		spin_unlock(ptl);
+		ret = 0;
+		goto out_mutex;
 	}
 
 	/*
diff --git a/mm/memory.c b/mm/memory.c
index e0dcf2c28d9d..bfe6f218fb16 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6174,8 +6174,31 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
 
 static vm_fault_t do_uffd_rwp(struct vm_fault *vmf)
 {
-	pte_unmap(vmf->pte);
-	return handle_userfault(vmf, VM_UFFD_RWP);
+	pte_t pte;
+
+	if (!userfaultfd_rwp_async(vmf->vma)) {
+		/* Sync mode: unmap PTE and deliver to userfaultfd handler */
+		pte_unmap(vmf->pte);
+		return handle_userfault(vmf, VM_UFFD_RWP);
+	}
+
+	spin_lock(vmf->ptl);
+	if (unlikely(!pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		return 0;
+	}
+	pte = pte_modify(vmf->orig_pte, vmf->vma->vm_page_prot);
+	/* pte_modify() preserves _PAGE_UFFD; drop it on resolution */
+	pte = pte_clear_uffd(pte);
+	pte = pte_mkyoung(pte);
+	if (!pte_write(pte) &&
+	    vma_wants_manual_pte_write_upgrade(vmf->vma) &&
+	    can_change_pte_writable(vmf->vma, vmf->address, pte))
+		pte = pte_mkwrite(pte, vmf->vma);
+	set_pte_at(vmf->vma->vm_mm, vmf->address, vmf->pte, pte);
+	update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
 }
 
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
-- 
2.51.2

