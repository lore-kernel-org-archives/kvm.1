Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DE93BA257;
	Mon, 30 Mar 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865514; cv=none; b=AHbggwK/TXNitVplLvxIWfnMb/H75GR8Rkgzu7RxDg6zA54He4NfTFSC1axhRvr+PKbN4hP/4XaevgSD3VFGdfSBnhnsKZL+F4NlquvwH19962PPxHRa7Xa0iGmlfEGBAw/xi7STVn0GrUB0uk2wuGWehrn3vVneVKWhz9amJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865514; c=relaxed/simple;
	bh=ynjTmCe+1IWEv5uzQ9YDrK1M2CISmsrzcaIqVGmX5v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD8cRdoDkqMyVTXjnBmq+ceBZm93e1eH6Q/grDNfdh99sldkTFLjFgzeXKCWyIvKlyRq0ptwngL75ZKGyjW6uD4PKZPNiY6R9Df7FIWKIOlc6UwaxJY8gU+2pDA0RxCdey2BpbJnUZm4vA6Jws6t8yOKytqv8JLYdyGMYBowd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9PBouR4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9PBouR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9232FC2BCB5;
	Mon, 30 Mar 2026 10:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865513;
	bh=ynjTmCe+1IWEv5uzQ9YDrK1M2CISmsrzcaIqVGmX5v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9PBouR46yBSGMp/xczSDwNBSz01ILMMSUj54LcWOXbIqNAWCWDiQOgfDL2mOpJeX
	 jWmG3aMQSTYTPDkRqV982sQciqG5TEdyiaeAEcRpBwctsK1vNMR8kLvjmKH+OTaMh8
	 ZXPPiEZPMEfVIIMFDVu/qYHj/2MLKn7dwA3DEdchKRyf2i77SsBedtIGw2xcPwO4fw
	 YgMb4eBrNILU5qOsa8Au+P2E4ooFL2zy8mIGhp+S7Anm6rAiRfKpcXiCw8L/gYdBge
	 Ata/+5uKD1wBFajLa+AtZtMH42pL7iE6FbyBqGi+1qfJDSK3Z0NwCVZnovq4SmH0T7
	 KWc50FhDtW59A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 04/15] userfaultfd: introduce mfill_get_vma() and mfill_put_vma()
Date: Mon, 30 Mar 2026 13:11:05 +0300
Message-ID: <20260330101116.1117699-5-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330101116.1117699-1-rppt@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Split the code that finds, locks and verifies VMA from mfill_atomic() into
a helper function.

This function will be used later during refactoring of
mfill_atomic_pte_copy().

Add a counterpart mfill_put_vma() helper that unlocks the VMA and releases
map_changing_lock.

[avagin@google.com: fix lock leak in mfill_get_vma()]
Link: https://lkml.kernel.org/r/20260316173829.1126728-1-avagin@google.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 mm/userfaultfd.c | 126 ++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 51 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 291e5cfed431..c6a38db45343 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -157,6 +157,75 @@ static void uffd_mfill_unlock(struct vm_area_struct *vma)
 }
 #endif
 
+static void mfill_put_vma(struct mfill_state *state)
+{
+	if (!state->vma)
+		return;
+
+	up_read(&state->ctx->map_changing_lock);
+	uffd_mfill_unlock(state->vma);
+	state->vma = NULL;
+}
+
+static int mfill_get_vma(struct mfill_state *state)
+{
+	struct userfaultfd_ctx *ctx = state->ctx;
+	uffd_flags_t flags = state->flags;
+	struct vm_area_struct *dst_vma;
+	int err;
+
+	/*
+	 * Make sure the vma is not shared, that the dst range is
+	 * both valid and fully within a single existing vma.
+	 */
+	dst_vma = uffd_mfill_lock(ctx->mm, state->dst_start, state->len);
+	if (IS_ERR(dst_vma))
+		return PTR_ERR(dst_vma);
+
+	/*
+	 * If memory mappings are changing because of non-cooperative
+	 * operation (e.g. mremap) running in parallel, bail out and
+	 * request the user to retry later
+	 */
+	down_read(&ctx->map_changing_lock);
+	state->vma = dst_vma;
+	err = -EAGAIN;
+	if (atomic_read(&ctx->mmap_changing))
+		goto out_unlock;
+
+	err = -EINVAL;
+
+	/*
+	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
+	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
+	 */
+	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
+	    dst_vma->vm_flags & VM_SHARED))
+		goto out_unlock;
+
+	/*
+	 * validate 'mode' now that we know the dst_vma: don't allow
+	 * a wrprotect copy if the userfaultfd didn't register as WP.
+	 */
+	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+		goto out_unlock;
+
+	if (is_vm_hugetlb_page(dst_vma))
+		return 0;
+
+	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
+		goto out_unlock;
+	if (!vma_is_shmem(dst_vma) &&
+	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		goto out_unlock;
+
+	return 0;
+
+out_unlock:
+	mfill_put_vma(state);
+	return err;
+}
+
 static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
 {
 	pgd_t *pgd;
@@ -767,8 +836,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		.src_addr = src_start,
 		.dst_addr = dst_start,
 	};
-	struct mm_struct *dst_mm = ctx->mm;
-	struct vm_area_struct *dst_vma;
 	long copied = 0;
 	ssize_t err;
 
@@ -783,57 +850,17 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
 retry:
-	/*
-	 * Make sure the vma is not shared, that the dst range is
-	 * both valid and fully within a single existing vma.
-	 */
-	dst_vma = uffd_mfill_lock(dst_mm, dst_start, len);
-	if (IS_ERR(dst_vma)) {
-		err = PTR_ERR(dst_vma);
+	err = mfill_get_vma(&state);
+	if (err)
 		goto out;
-	}
-
-	/*
-	 * If memory mappings are changing because of non-cooperative
-	 * operation (e.g. mremap) running in parallel, bail out and
-	 * request the user to retry later
-	 */
-	down_read(&ctx->map_changing_lock);
-	err = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
-		goto out_unlock;
-
-	err = -EINVAL;
-	/*
-	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
-	 * it will overwrite vm_ops, so vma_is_anonymous must return false.
-	 */
-	if (WARN_ON_ONCE(vma_is_anonymous(dst_vma) &&
-	    dst_vma->vm_flags & VM_SHARED))
-		goto out_unlock;
-
-	/*
-	 * validate 'mode' now that we know the dst_vma: don't allow
-	 * a wrprotect copy if the userfaultfd didn't register as WP.
-	 */
-	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
-		goto out_unlock;
 
 	/*
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
-	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
+	if (is_vm_hugetlb_page(state.vma))
+		return  mfill_atomic_hugetlb(ctx, state.vma, dst_start,
 					     src_start, len, flags);
 
-	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
-		goto out_unlock;
-	if (!vma_is_shmem(dst_vma) &&
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
-		goto out_unlock;
-
-	state.vma = dst_vma;
-
 	while (state.src_addr < src_start + len) {
 		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
 
@@ -852,8 +879,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 		if (unlikely(err == -ENOENT)) {
 			void *kaddr;
 
-			up_read(&ctx->map_changing_lock);
-			uffd_mfill_unlock(state.vma);
+			mfill_put_vma(&state);
 			VM_WARN_ON_ONCE(!state.folio);
 
 			kaddr = kmap_local_folio(state.folio, 0);
@@ -882,9 +908,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 	}
 
-out_unlock:
-	up_read(&ctx->map_changing_lock);
-	uffd_mfill_unlock(state.vma);
+	mfill_put_vma(&state);
 out:
 	if (state.folio)
 		folio_put(state.folio);
-- 
2.53.0

