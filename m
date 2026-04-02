Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E11DF980;
	Thu,  2 Apr 2026 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154204; cv=none; b=YL73ELcQWdDd60rVLmolHckmbw8AGWlqj/B0v/YYFJ03KLb1xlotJbbXklErMNQR3yNvNut/k+gOdM95XaFnMB1M/cfDYkBlKvVon8zqjkiO1WCYodB2+p4xv4o62YngsFkG8Zf3LoY45uaonYxlLxcei/MDg85YEws6zl8tMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154204; c=relaxed/simple;
	bh=tT5VutlhwO4iM0thHkSEj6tGhIceZAxA8rLI/AMmxxM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fn36Iy4dCfgsy70VTOMBJB4D1mBghLLKYL5ILmI+6tGz+dbrkCy4CLNq/qiZlBozuO7d/6HJ4Fnfyeywta6flzQQkbCUEyqSGEdrhUr0G2aPqi11t9+jp3aCWn26SXgV9YZ2LkPglflU0ZCEPudNfTn6iAJ7ugRSlf4J762CiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XGkmHHOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XGkmHHOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838CCC116C6;
	Thu,  2 Apr 2026 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775154203;
	bh=tT5VutlhwO4iM0thHkSEj6tGhIceZAxA8rLI/AMmxxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XGkmHHOzYo7NXSvG/QGEDQpmEfdP3Wlln7IYjc5INODBo1a0TeANXmP6Pje1F3Tca
	 fSywnosUgFj4QgEcI7Hl4ej4d3lyC7m9AcbHzX+e72kJU/I1Vy8wiK2QiPKdzbC3ej
	 uo0VKWNtBy/X3DiG9ujk+UQDD6ZpDOIqQqYrHYxs=
Date: Thu, 2 Apr 2026 11:23:21 -0700
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
Subject: Re: [PATCH v4 11/15] userfaultfd: mfill_atomic(): remove retry
 logic
Message-Id: <20260402112321.65a46fe7be4708e180eb864d@linux-foundation.org>
In-Reply-To: <ac5zcDUY8CFHr6Lw@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
	<20260402041156.1377214-12-rppt@kernel.org>
	<ac5zcDUY8CFHr6Lw@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Apr 2026 16:47:28 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> > Drop the retry logic from mfill_atomic().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/userfaultfd.c | 24 ------------------------
> >  1 file changed, 24 deletions(-)
> 
> After discussion with David Carlier about potential replacement of VMA in
> mfill_copy_folio_retry(), I looked again in the code and realized that
> after all the rebases I didn't remove the bit that temporarily prevented
> returning ENOENT from __mfill_atomic_pte().
> 
> Andrew, can you please fold this into "userfaultfd: mfill_atomic(): remove
> retry logic"?
> 
> For a change it applies cleanly :)

done.

> commit 5173c8f4fd32f314907b3804217ef57d4e3a2220
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Date:   Thu Apr 2 16:38:39 2026 +0300
> 
>     userfaultfd: remove safety mesaure of not returning ENOENT from _copy

s/mesaure/measure/

Was "_copy" intended?

>     
>     Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I instafolded this.  End result:


From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: userfaultfd: mfill_atomic(): remove retry logic
Date: Thu, 2 Apr 2026 07:11:52 +0300

Since __mfill_atomic_pte() handles the retry for both anonymous and shmem,
there is no need to retry copying the date from the userspace in the loop
in mfill_atomic().

Drop the retry logic from mfill_atomic().

[rppt@kernel.org: remove safety measure of not returning ENOENT from _copy]
  Link: https://lkml.kernel.org/r/ac5zcDUY8CFHr6Lw@kernel.org
Link: https://lkml.kernel.org/r/20260402041156.1377214-12-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrei Vagin <avagin@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand (Arm) <david@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Harry Yoo (Oracle) <harry@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/userfaultfd.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

--- a/mm/userfaultfd.c~userfaultfd-mfill_atomic-remove-retry-logic
+++ a/mm/userfaultfd.c
@@ -29,7 +29,6 @@ struct mfill_state {
 	struct vm_area_struct *vma;
 	unsigned long src_addr;
 	unsigned long dst_addr;
-	struct folio *folio;
 	pmd_t *pmd;
 };
 
@@ -531,9 +530,6 @@ err_filemap_remove:
 		ops->filemap_remove(folio, state->vma);
 err_folio_put:
 	folio_put(folio);
-	/* Don't return -ENOENT so that our caller won't retry */
-	if (ret == -ENOENT)
-		ret = -EFAULT;
 	return ret;
 }
 
@@ -899,7 +895,6 @@ static __always_inline ssize_t mfill_ato
 	VM_WARN_ON_ONCE(src_start + len <= src_start);
 	VM_WARN_ON_ONCE(dst_start + len <= dst_start);
 
-retry:
 	err = mfill_get_vma(&state);
 	if (err)
 		goto out;
@@ -926,26 +921,6 @@ retry:
 		err = mfill_atomic_pte(&state);
 		cond_resched();
 
-		if (unlikely(err == -ENOENT)) {
-			void *kaddr;
-
-			mfill_put_vma(&state);
-			VM_WARN_ON_ONCE(!state.folio);
-
-			kaddr = kmap_local_folio(state.folio, 0);
-			err = copy_from_user(kaddr,
-					     (const void __user *)state.src_addr,
-					     PAGE_SIZE);
-			kunmap_local(kaddr);
-			if (unlikely(err)) {
-				err = -EFAULT;
-				goto out;
-			}
-			flush_dcache_folio(state.folio);
-			goto retry;
-		} else
-			VM_WARN_ON_ONCE(state.folio);
-
 		if (!err) {
 			state.dst_addr += PAGE_SIZE;
 			state.src_addr += PAGE_SIZE;
@@ -960,8 +935,6 @@ retry:
 
 	mfill_put_vma(&state);
 out:
-	if (state.folio)
-		folio_put(state.folio);
 	VM_WARN_ON_ONCE(copied < 0);
 	VM_WARN_ON_ONCE(err > 0);
 	VM_WARN_ON_ONCE(!copied && !err);
_

