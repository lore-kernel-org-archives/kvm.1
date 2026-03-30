Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5833BE649;
	Mon, 30 Mar 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865567; cv=none; b=CmeMIaOFtR6A4nrLGTe+L7yiMYcMUN7vKTaWpc+rHH4/KxPJYhOuLXi+3NHWKUlRI1m0SXX3klo/EzFUZZDQh8gI4IpqZfe8OD6fNEpQ2C8jIOTzDndNCNoPlI941FdbgpqhJzNxjVWOSQ0EN9Xma+C35hJxWwAhVrENStAIF70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865567; c=relaxed/simple;
	bh=OBbhkJ8YK27hN9vtg3QQXqgXyuXTuw2IdpJE89KAMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYMuU4flt56ppRVpQEmKqNu/r0FrjXmAktWGBgq8JHl4X9yQ+DlTaw7BBCDavWdzaKanERnd+AAtWNAQH0L8MGSBqBReoSYpGa+hmlytsSpO4ZVBnZW6GjD1azEhkTcMuVUnzl4a81pbokjDxO/VsN5dAcUkE+kctYpJm25Lqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgyyW8q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgyyW8q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5F6C4CEF7;
	Mon, 30 Mar 2026 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774865567;
	bh=OBbhkJ8YK27hN9vtg3QQXqgXyuXTuw2IdpJE89KAMWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgyyW8q8iYNIvZzvOQWoy03Lk7pJYY5Q3wOADiHx+O/Cemi7Y4kfbemX9edKP+Ipn
	 SYJmjqhLXwWRpxKtGf8hWgXRI2CsPYArsol3/ezvJcWpv3Ql27Nddo827jppV5PNLa
	 WHWG44EhUI/PgzreVTi/vguFrEesMAyqg6/oEqTwuMLQ2fykrIT1Yw13pSeBHDPJIt
	 sKJf4ah6p9X9s/ypsiSK+oa4nQW+iKKa1L1vfd891+vuzaVF2CT7VNaE/PiMKdkrvm
	 hg+f9cwpSE8m9qDQWFSiQOzSN5skxuMOkUyE1rhucWBqDyTFlRhBYkqDNIcVGulYCJ
	 KumxlfCmzJ/5Q==
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
Subject: [PATCH v3 12/15] mm: generalize handling of userfaults in __do_fault()
Date: Mon, 30 Mar 2026 13:11:13 +0300
Message-ID: <20260330101116.1117699-13-rppt@kernel.org>
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

From: Peter Xu <peterx@redhat.com>

When a VMA is registered with userfaulfd, its ->fault() method should
check if a folio exists in the page cache and call handle_userfault() with
appropriate mode:

- VM_UFFD_MINOR if VMA is registered in minor mode and the folio exists
- VM_UFFD_MISSING if VMA is registered in missing mode and the folio
  does not exist

Instead of calling handle_userfault() directly from a specific ->fault()
handler, call __do_userfault() helper from the generic __do_fault().

For VMAs registered with userfaultfd the new __do_userfault() helper will
check if the folio is found in the page cache using
vm_uffd_ops->get_folio_noalloc() and call handle_userfault() with the
appropriate mode.

Make vm_uffd_ops->get_folio_noalloc() required method for non-anonymous
VMAs mapped at PTE level.

Signed-off-by: Peter Xu <peterx@redhat.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memory.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 mm/shmem.c       | 12 ------------
 mm/userfaultfd.c |  9 +++++++++
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 2f815a34d924..79c5328b26e3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5329,6 +5329,41 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return VM_FAULT_OOM;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static vm_fault_t __do_userfault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode;
+	struct folio *folio;
+
+	if (!(userfaultfd_missing(vma) || userfaultfd_minor(vma)))
+		return 0;
+
+	inode = file_inode(vma->vm_file);
+	folio = vma->vm_ops->uffd_ops->get_folio_noalloc(inode, vmf->pgoff);
+	if (!IS_ERR_OR_NULL(folio)) {
+		/*
+		 * TODO: provide a flag for get_folio_noalloc() to avoid
+		 * locking (or even the extra reference?)
+		 */
+		folio_unlock(folio);
+		folio_put(folio);
+		if (userfaultfd_minor(vma))
+			return handle_userfault(vmf, VM_UFFD_MINOR);
+	} else {
+		if (userfaultfd_missing(vma))
+			return handle_userfault(vmf, VM_UFFD_MISSING);
+	}
+
+	return 0;
+}
+#else
+static inline vm_fault_t __do_userfault(struct vm_fault *vmf)
+{
+	return 0;
+}
+#endif
+
 /*
  * The mmap_lock must have been held on entry, and may have been
  * released depending on flags and vma->vm_ops->fault() return value.
@@ -5361,6 +5396,14 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
+	/*
+	 * If this is a userfault trap, process it in advance before
+	 * triggering the genuine fault handler.
+	 */
+	ret = __do_userfault(vmf);
+	if (ret)
+		return ret;
+
 	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
 			    VM_FAULT_DONE_COW)))
diff --git a/mm/shmem.c b/mm/shmem.c
index 68620caaf75f..239545352cd2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2489,13 +2489,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(inode->i_mapping, index);
-	if (folio && vma && userfaultfd_minor(vma)) {
-		if (!xa_is_value(folio))
-			folio_put(folio);
-		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
-		return 0;
-	}
-
 	if (xa_is_value(folio)) {
 		error = shmem_swapin_folio(inode, index, &folio,
 					   sgp, gfp, vma, fault_type);
@@ -2540,11 +2533,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	 * Fast cache lookup and swap lookup did not find it: allocate.
 	 */
 
-	if (vma && userfaultfd_missing(vma)) {
-		*fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
-		return 0;
-	}
-
 	/* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
 	orders = shmem_allowable_huge_orders(inode, vma, index, write_end, false);
 	if (orders > 0) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 935a3f6ebeed..9ba6ec8c0781 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2046,6 +2046,15 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	    !vma_is_anonymous(vma))
 		return false;
 
+	/*
+	 * File backed VMAs (except HugeTLB) must implement
+	 * ops->get_folio_noalloc() because it's required by __do_userfault()
+	 * in page fault handling.
+	 */
+	if (!vma_is_anonymous(vma) && !is_vm_hugetlb_page(vma) &&
+	    !ops->get_folio_noalloc)
+		return false;
+
 	return ops->can_userfault(vma, vm_flags);
 }
 
-- 
2.53.0

