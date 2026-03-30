Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEA346766;
	Mon, 30 Mar 2026 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900465; cv=none; b=gJEqLAwb0VI//+7PSA9O7XL270ZQEk3WnswsAhzalSoQqlgQYJ7mg2nnAD8vxvqclUH43XQF/3m+9XALXF5H9N7aMZmqerJhpYrwXflNhyPoodTNCx1BEk8v7zPgNwjgVGv0ybuDL/R1fPMGLrNuvi85SDraalTDm1B/bxgXOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900465; c=relaxed/simple;
	bh=PVggmHFroeTCysyxMzuB1gpR33ZPKG+IwSLIbZBkreE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NtdJmi9cLT+qJ4CGTTp6h98mokn3Etkn6vCsq9VRc8zypEkJp4iBhPMEtGlmLB/g1cxkE+1rwW7MDJK8R0XDiMKjGFG23kZEuKd5ZuC3pcNN0RQ0qls6ViZMatFv/bB5nCskOdcDdOik0iqP5vqB59+8J0xp8agzBZVEJeJF98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mmH6caD6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mmH6caD6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19772C4CEF7;
	Mon, 30 Mar 2026 19:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774900464;
	bh=PVggmHFroeTCysyxMzuB1gpR33ZPKG+IwSLIbZBkreE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mmH6caD6cf5ZzhC0rQz1KMrVf2wx+yEwqntoWzM87S8JUIu+KlW5rT2ui/qXnKvz5
	 GGCdaqeYY+TcWZ7rJNCO7bjpaNo8naiq2FqdOn63pssh5xZlFSNEP0PUjY8dVIZd9b
	 ZInP9Szdi2A1JQQXjXLO2fJ1oCYmTHfcC/voVBJQ=
Date: Mon, 30 Mar 2026 12:54:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Andrei Vagin
 <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>,
 Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, James
 Houghton <jthoughton@google.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin
 <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 00/15] mm, kvm: allow uffd support in guest_memfd
Message-Id: <20260330125423.90bc3c6b0e9164d19e8a3995@linux-foundation.org>
In-Reply-To: <20260330101116.1117699-1-rppt@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 13:11:01 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> These patches enable support for userfaultfd in guest_memfd.

Thanks, I've updated mm.git's mm-unstable branch to this version.  I
added a little note-to-self to keep tabs on willy's [07/15] comment.

The series seems to be converging nicely.  Several of the patches
aren't showing R-b/A-b at this time.

I've moved this series even further down-queue, so it's definitely in
the second-week-of-merge-window batch.  So I'll be looking to move it
into mm-stable around Monday of that week (Apr 27?).  Four weeks for
testing, review and little touchups.

> v3 changes:
> * add fixes from Harry and Andrei
> * fix handling of WP-only mode for WP_ASYNC contexts in vma_can_userfault()
> * address David's comments about mfill_get_pmd() and rename it to
>   mfill_establish_pmd()
> * add VM_WARN()s for unsupported operations (James)
> * update comments using James' suggestions

Here's how v3 altered mm.git:


 include/linux/userfaultfd_k.h |    6 +++---
 mm/memory.c                   |    2 +-
 mm/userfaultfd.c              |   12 ++++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

--- a/include/linux/userfaultfd_k.h~b
+++ a/include/linux/userfaultfd_k.h
@@ -96,14 +96,14 @@ struct vm_uffd_ops {
 	struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
 	/*
 	 * Called during resolution of UFFDIO_COPY request.
-	 * Should allocate and return a folio or NULL if allocation
-	 * fails.
+	 * Should allocate and return a folio or NULL if allocation fails.
 	 */
 	struct folio *(*alloc_folio)(struct vm_area_struct *vma,
 				     unsigned long addr);
 	/*
 	 * Called during resolution of UFFDIO_COPY request.
-	 * Should lock the folio and add it to VMA's page cache.
+	 * Should only be called with a folio returned by alloc_folio() above.
+	 * The folio will be set to locked.
 	 * Returns 0 on success, error code on failure.
 	 */
 	int (*filemap_add)(struct folio *folio, struct vm_area_struct *vma,
--- a/mm/memory.c~b
+++ a/mm/memory.c
@@ -5493,7 +5493,7 @@ static vm_fault_t __do_fault(struct vm_f
 	}
 
 	/*
-	 * If this is an userfaultfd trap, process it in advance before
+	 * If this is a userfault trap, process it in advance before
 	 * triggering the genuine fault handler.
 	 */
 	ret = __do_userfault(vmf);
--- a/mm/userfaultfd.c~b
+++ a/mm/userfaultfd.c
@@ -502,7 +502,7 @@ static int __mfill_atomic_pte(struct mfi
 	} else if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		clear_user_highpage(&folio->page, state->dst_addr);
 	} else {
-		VM_WARN_ONCE(1, "unknown UFFDIO operation");
+		VM_WARN_ONCE(1, "Unknown UFFDIO operation, flags: %x", flags);
 	}
 
 	/*
@@ -612,8 +612,10 @@ static int mfill_atomic_pte_continue(str
 	struct page *page;
 	int ret;
 
-	if (!ops)
+	if (!ops) {
+		VM_WARN_ONCE(1, "UFFDIO_CONTINUE for unsupported VMA");
 		return -EOPNOTSUPP;
+	}
 
 	folio = ops->get_folio_noalloc(inode, pgoff);
 	/* Our caller expects us to return -EFAULT if we failed to find folio */
@@ -864,6 +866,7 @@ static __always_inline ssize_t mfill_ato
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
 		return mfill_atomic_pte_zeropage(state);
 
+	VM_WARN_ONCE(1, "Unknown UFFDIO operation, flags: %x", flags);
 	return -EOPNOTSUPP;
 }
 
@@ -2044,8 +2047,9 @@ bool vma_can_userfault(struct vm_area_st
 		return false;
 
 	/*
-	 * File backed memory with PTE level mappigns must implement
-	 * ops->get_folio_noalloc()
+	 * File backed VMAs (except HugeTLB) must implement
+	 * ops->get_folio_noalloc() because it's required by __do_userfault()
+	 * in page fault handling.
 	 */
 	if (!vma_is_anonymous(vma) && !is_vm_hugetlb_page(vma) &&
 	    !ops->get_folio_noalloc)
_

