Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379D3E8C4B
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176644; cv=none; b=lG53MG3vyKh7wjcHasJt2crWq2/jkfbPLnTzvrz3osXyxy04L9KbIqE8KLFXDBY7oPkB82KFKyBDkkFZIYdzlk7cK+o5og6Nvg/yNE2J/0sl01Xa/eVpJJJu/CCH0NJA4g4yCTNnJd5Q07cNc1CpjF183f04RkrdIZ7QuFHRDLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176644; c=relaxed/simple;
	bh=Bf327wT/aGKA5T+U97BuB/g1VkBHVQ9CP0E9lDgK+RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBk7B9gj7wD/1DNL2PrJNAwu7oxfde9VCjd/M7c8TZ5puldCCFNlD9/ObxBPEKgoUSzWRp3YiKWzCPqVH/cDcGRLIgaj5c7EDizewL+Dlboi13FnmKIINtaeUMcVG+MalpU97XtFXDU2qIwTB32MghzyS7jvOd1eT2fsi/ni/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ7QSVBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ7QSVBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A20EC4AF09;
	Tue, 14 Apr 2026 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776176643;
	bh=Bf327wT/aGKA5T+U97BuB/g1VkBHVQ9CP0E9lDgK+RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZ7QSVBii/NDuHYMQkacZ1Y8KCdDWZxXO3ZL2KMgu8YzHBKb/nGeZkSuY/kDHTHOk
	 jnQ4kklXRd1ZTfeydzu3wd3q1mp4DtbrSAr6OthEjEEnEyqOyulLnriZQlD2m4tNGS
	 p8IfdmLgeUWhQfxgDNwXEFwHYD+Ul1RMU5t/MBSYpy8lqYmwAAoHkbchLrUXVB7/2q
	 SFUgrx9K2fe8cZTdeP7xcB8WcVELf98aRsfIGmjmdGRUqcnsS5AfcQNBSD54/Zx/kZ
	 Z7W2FX8BF5R7zNb0ZZoWtcBoi3zag6tUNMmHeaAGG9huPPFOPX/NB7oJ2FKMjwoeUW
	 RB9Xu3y0PrTCA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A0E78F40068;
	Tue, 14 Apr 2026 10:24:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 10:24:02 -0400
X-ME-Sender: <xms:Ak7eaRCwQ-joqBPzJ8W6eWkkuuqy8UYBZO6D-bHNDqYwO3qFC0e-QQ>
    <xme:Ak7eaWe0o_g7Ocn3LAAoNecCeR-SstrOEh7ZkOG16GP2f7SrNx2FI1991fRNqObo-
    jBFH4aTs0QyuGs0qet6i-UnM7-tLkAcXcJeYM-LLf4A0MyPmqY4OsE>
X-ME-Received: <xmr:Ak7eaRqsq0SJLE8IxlNyaKgWrjH91s_CSku_VUhsiUXL71dwuPyjADYv_dmrTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepfdfmihhrhihl
    ucfuhhhuthhsvghmrghuucdlofgvthgrmddfuceokhgrsheskhgvrhhnvghlrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhvdefvdevjeevhefhhfevudefudejfeduvdekheeludfh
    iefhhedujeffffeigfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidq
    udeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgse
    hshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    uggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    uhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgt
    ohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:Ak7eaS7bZdKL63upiVCwVw4ytNMGRxQPJz7C6Gkj66CLzvTubpES1Q>
    <xmx:Ak7eaRCbECUjD1_aKfvL_r4egFaSSYWAK2WQPXpY0QR9H0jyeQ1VAQ>
    <xmx:Ak7eaUY99ALMXYv4Z7Ar3HkdJnTLoOSCmSNXThxPGj3pL8YK1jzuhg>
    <xmx:Ak7eaVJD3xRvosivUO_hEm4IXa987qHwVYlmNi95N5vxN_p5859sLA>
    <xmx:Ak7eadCkJoEtWUN7xqwG2Rmzi3STa4Z_TjKM0yzi-MmnVG-MdGfN9fne>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 10:24:01 -0400 (EDT)
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
Subject: [RFC, PATCH 03/12] userfaultfd: implement UFFDIO_DEACTIVATE ioctl
Date: Tue, 14 Apr 2026 15:23:37 +0100
Message-ID: <20260414142354.1465950-4-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414142354.1465950-1-kas@kernel.org>
References: <20260414142354.1465950-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

UFFDIO_DEACTIVATE marks pages as deactivated within a VM_UFFD_MINOR
range:

- Anonymous memory: set protnone via change_protection(MM_CP_UFFD_DEACTIVATE).
  Pages stay resident with PFNs preserved, only permissions removed.
  MM_CP_UFFD_DEACTIVATE is handled independently from MM_CP_PROT_NUMA,
  bypassing folio_can_map_prot_numa() and CONFIG_NUMA_BALANCING guards.

- Shared shmem/hugetlbfs: zap PTEs via zap_page_range_single().
  Pages stay in page cache.

- Private hugetlb: rejected with -EINVAL (zapping would destroy content).

Cleanup on unregister/close: restore protnone PTEs to normal permissions
in userfaultfd_clear_vma(), preventing permanently inaccessible pages.

Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
---
 fs/userfaultfd.c              | 35 ++++++++++++++++
 include/linux/mm.h            |  2 +
 include/linux/userfaultfd_k.h |  2 +
 mm/huge_memory.c              |  9 ++--
 mm/mprotect.c                 |  9 +++-
 mm/userfaultfd.c              | 78 +++++++++++++++++++++++++++++++++--
 6 files changed, 127 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 8d508ad19e89..b317c9854b86 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1441,6 +1441,10 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR))
 			ioctls_out &= ~((__u64)1 << _UFFDIO_CONTINUE);
 
+		/* DEACTIVATE is only supported for MINOR ranges. */
+		if (!(uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR))
+			ioctls_out &= ~((__u64)1 << _UFFDIO_DEACTIVATE);
+
 		/*
 		 * Now that we scanned all vmas we can already tell
 		 * userland which ioctls methods are guaranteed to
@@ -1788,6 +1792,34 @@ static int userfaultfd_writeprotect(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
+static int userfaultfd_deactivate(struct userfaultfd_ctx *ctx,
+				  unsigned long arg)
+{
+	int ret;
+	struct uffdio_range uffdio_range;
+
+	if (atomic_read(&ctx->mmap_changing))
+		return -EAGAIN;
+
+	if (copy_from_user(&uffdio_range, (void __user *)arg,
+			   sizeof(uffdio_range)))
+		return -EFAULT;
+
+	ret = validate_range(ctx->mm, uffdio_range.start, uffdio_range.len);
+	if (ret)
+		return ret;
+
+	if (mmget_not_zero(ctx->mm)) {
+		ret = mdeactivate_range(ctx, uffdio_range.start,
+					uffdio_range.len);
+		mmput(ctx->mm);
+	} else {
+		return -ESRCH;
+	}
+
+	return ret;
+}
+
 static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 {
 	__s64 ret;
@@ -2108,6 +2140,9 @@ static long userfaultfd_ioctl(struct file *file, unsigned cmd,
 	case UFFDIO_POISON:
 		ret = userfaultfd_poison(ctx, arg);
 		break;
+	case UFFDIO_DEACTIVATE:
+		ret = userfaultfd_deactivate(ctx, arg);
+		break;
 	}
 	return ret;
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index abb4963c1f06..fc2841264d56 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3036,6 +3036,8 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
 #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
 					    MM_CP_UFFD_WP_RESOLVE)
+/* Whether this change is for uffd deactivation */
+#define  MM_CP_UFFD_DEACTIVATE             (1UL << 4)
 
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index d1d4ed4a08b0..c94b5c5b5f24 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -130,6 +130,8 @@ extern int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 			       unsigned long len, bool enable_wp);
 extern long uffd_wp_range(struct vm_area_struct *vma,
 			  unsigned long start, unsigned long len, bool enable_wp);
+extern int mdeactivate_range(struct userfaultfd_ctx *ctx, unsigned long start,
+			     unsigned long len);
 
 /* move_pages */
 void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b298cba853ab..2ad736ff007c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2563,6 +2563,7 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	pmd_t oldpmd, entry;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_deactivate = cp_flags & MM_CP_UFFD_DEACTIVATE;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 	int ret = 1;
@@ -2582,8 +2583,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto unlock;
 	}
 
-	if (prot_numa) {
+	/* Already protnone — nothing to do for either NUMA or uffd */
+	if ((prot_numa || uffd_deactivate) && pmd_protnone(*pmd))
+		goto unlock;
 
+	if (prot_numa) {
 		/*
 		 * Avoid trapping faults against the zero page. The read-only
 		 * data is likely to be read-cached on the local CPU and
@@ -2592,9 +2596,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		if (is_huge_zero_pmd(*pmd))
 			goto unlock;
 
-		if (pmd_protnone(*pmd))
-			goto unlock;
-
 		if (!folio_can_map_prot_numa(pmd_folio(*pmd), vma,
 					     vma_is_single_threaded_private(vma)))
 			goto unlock;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index c0571445bef7..7c612a680014 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -220,6 +220,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 	long pages = 0;
 	bool is_private_single_threaded;
 	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
+	bool uffd_deactivate = cp_flags & MM_CP_UFFD_DEACTIVATE;
 	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
 	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
 	int nr_ptes;
@@ -245,7 +246,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			pte_t ptent;
 
 			/* Already in the desired state. */
-			if (prot_numa && pte_protnone(oldpte))
+			if ((prot_numa || uffd_deactivate) &&
+			    pte_protnone(oldpte))
 				continue;
 
 			page = vm_normal_page(vma, addr, oldpte);
@@ -255,6 +257,8 @@ static long change_pte_range(struct mmu_gather *tlb,
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
+			 * Skip this filter for uffd deactivation which
+			 * must set protnone regardless of NUMA placement.
 			 */
 			if (prot_numa &&
 			    !folio_can_map_prot_numa(folio, vma,
@@ -651,6 +655,9 @@ long change_protection(struct mmu_gather *tlb,
 	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
 #endif
 
+	if (cp_flags & MM_CP_UFFD_DEACTIVATE)
+		newprot = PAGE_NONE;
+
 	if (is_vm_hugetlb_page(vma))
 		pages = hugetlb_change_protection(vma, start, end, newprot,
 						  cp_flags);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index dba1ea26fdfe..3373b11b9d83 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -775,7 +775,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
+	if (!vma_is_shmem(dst_vma) && !vma_is_anonymous(dst_vma) &&
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
@@ -797,13 +797,16 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		dst_pmdval = pmdp_get_lockless(dst_pmd);
+		if (unlikely(!pmd_present(dst_pmdval))) {
+			err = -EEXIST;
+			break;
+		}
 		/*
 		 * If the dst_pmd is THP don't override it and just be strict.
 		 * (This includes the case where the PMD used to be THP and
 		 * changed back to none after __pte_alloc().)
 		 */
-		if (unlikely(!pmd_present(dst_pmdval) ||
-				pmd_trans_huge(dst_pmdval))) {
+		if (unlikely(pmd_trans_huge(dst_pmdval))) {
 			err = -EEXIST;
 			break;
 		}
@@ -996,6 +999,65 @@ int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 	return err;
 }
 
+int mdeactivate_range(struct userfaultfd_ctx *ctx, unsigned long start,
+		      unsigned long len)
+{
+	struct mm_struct *dst_mm = ctx->mm;
+	unsigned long end = start + len;
+	struct vm_area_struct *dst_vma;
+	long err;
+	VMA_ITERATOR(vmi, dst_mm, start);
+
+	VM_WARN_ON_ONCE(start & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(len & ~PAGE_MASK);
+	VM_WARN_ON_ONCE(start + len <= start);
+
+	guard(mmap_read_lock)(dst_mm);
+	guard(rwsem_read)(&ctx->map_changing_lock);
+
+	if (atomic_read(&ctx->mmap_changing))
+		return -EAGAIN;
+
+	err = -ENOENT;
+	for_each_vma_range(vmi, dst_vma, end) {
+		unsigned long vma_start = max(dst_vma->vm_start, start);
+		unsigned long vma_end = min(dst_vma->vm_end, end);
+
+		if (!userfaultfd_minor(dst_vma)) {
+			err = -ENOENT;
+			break;
+		}
+
+		/*
+		 * Private hugetlb has no page cache to fall back on —
+		 * zapping PTEs would destroy page content.
+		 */
+		if (is_vm_hugetlb_page(dst_vma) &&
+		    !(dst_vma->vm_flags & VM_SHARED)) {
+			err = -EINVAL;
+			break;
+		}
+
+		if (vma_is_anonymous(dst_vma)) {
+			/* Anonymous: set protnone, pages stay resident */
+			struct mmu_gather tlb;
+
+			tlb_gather_mmu(&tlb, dst_mm);
+			err = change_protection(&tlb, dst_vma, vma_start,
+						vma_end,
+						MM_CP_UFFD_DEACTIVATE);
+			tlb_finish_mmu(&tlb);
+			if (err < 0)
+				break;
+		} else {
+			/* Shared shmem/hugetlb: zap PTEs, pages stay in page cache */
+			zap_page_range_single(dst_vma, vma_start,
+					      vma_end - vma_start, NULL);
+		}
+		err = 0;
+	}
+	return err;
+}
 
 void double_pt_lock(spinlock_t *ptl1,
 		    spinlock_t *ptl2)
@@ -1988,6 +2050,16 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	if (userfaultfd_wp(vma))
 		uffd_wp_range(vma, start, end - start, false);
 
+	/* Restore protnone PTEs to normal permissions */
+	if (userfaultfd_minor(vma) && vma_is_anonymous(vma)) {
+		struct mmu_gather tlb;
+
+		tlb_gather_mmu(&tlb, vma->vm_mm);
+		change_protection(&tlb, vma, start, end,
+				  MM_CP_TRY_CHANGE_WRITABLE);
+		tlb_finish_mmu(&tlb);
+	}
+
 	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
 				    vma->vm_flags & ~__VM_UFFD_FLAGS,
 				    NULL_VM_UFFD_CTX, give_up_on_oom);
-- 
2.51.2

