Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F113E92B1;
	Wed, 11 Mar 2026 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254952; cv=none; b=L6SZ0Q51A0GP+Y+mPxVFw76XH5VwaoCchvdEeAxoenXBL9xXKFfhhG/bkt439xjSDJZRY/oD7wdh16Fe0WFr3NAbI9qRmSop/1udCsNk8ARpmGBLS2jNTnbkYhLNY4vXLZ2j9q/+wqhW1CvUmpmb9KyoLUrInJgwPvhCq37FOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254952; c=relaxed/simple;
	bh=V6cFeRkZqby++mC9llt12uQIBRckotBb4PevLS2Zh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q57Tse0VKfS9Nzk1UaHKsIOXUuOsRnZmQFJLY9aCbJcldhOrMGFImFUeKoaEbnUHLAydo5t1DClziYrDup5bMjheUxC4N8xDNMvbBkMsKGQzqu0kBMTarhr5O3RbGZVp9JV8b6CfkzpBgwGgMJnYgc2daBAmJ2H9vIFa2t9y4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgEdtbB2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgEdtbB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BED4C19425;
	Wed, 11 Mar 2026 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773254951;
	bh=V6cFeRkZqby++mC9llt12uQIBRckotBb4PevLS2Zh7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgEdtbB2552lw+CZNF+iT4qjBWPNoUdaJrGRaWJeqan1Mdfi5a9y3+1uJSR/wv32s
	 QX4boMvXHOGzj77PQo1BGxHTnoQO0v/eCIx/awqOamXHSnQ99EQsHhBPgznbBS0lWi
	 mCrjHiikGeOlJUuB75XBJmwWEMFGMt9uY1e77zsOHq+K45kQ56DZ7NqDw8GFvVZkL1
	 DYO4WEaT0z6xMrEYBaptEqaIKq/SgXAXI1elpkm3mhjePR1FtlZ+1sJYrAr0FYZ5nl
	 x92uuR21FLfkhDt1132NzhtHFAe4pC6zGlSi1bT1bhetb8YrwM5mbjw20h3PWQcnig
	 aOoRuubqwjihw==
Date: Wed, 11 Mar 2026 20:49:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/15] userfaultfd: introduce vm_uffd_ops
Message-ID: <abG5HFV8yoEHOFkh@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-8-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306171815.3160826-8-rppt@kernel.org>

On Fri, Mar 06, 2026 at 07:18:07PM +0200, Mike Rapoport wrote:
>  bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
>  		       bool wp_async)
>  {
> -	vm_flags &= __VM_UFFD_FLAGS;
> +	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
>  
> -	if (vma->vm_flags & VM_DROPPABLE)
> +	/* only VMAs that implement vm_uffd_ops are supported */
> +	if (!ops)
>  		return false;

Just found out that rejecting a VMA that does not have uffd_ops but was
registered in WP-only mode with WP_ASYNC uffd context breaks
pagemap_ioctl() test and more broadly it breaks tracking of writes in SysV
shared memory areas.

This is weird that it's possible to use uffd with SysV SHM, but it's out
there for some time and I afraid we can't change that :/

Andrew, can you apply this as a fixup please

From 6e3319ceab93d84558e735e1f4f451e80c85b267 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 11 Mar 2026 20:21:38 +0200
Subject: [PATCH 1/1] userfaultfd: allow registration of WP_ASYNC for any VMA

Registration of a VMA with WP_ASYNC userfaulfd context in write-protect
mode does not require any VMA-specific resolution of user faults and
these faults are completely handled by the generic page fault handler.

This functionality existed since the introduction of WP_ASYNC mode and
it allows tracking writes to SysV shared memory mappings (shmget(2) and
shmat(2)).

Move the check for WP mode before checking for presence of ->uffd_ops in a
VMA to restore the original behaviour.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/userfaultfd.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index b55d4a8d88cc..436795bf218e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2044,22 +2044,22 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
-	/* only VMAs that implement vm_uffd_ops are supported */
-	if (!ops)
-		return false;
-
 	vm_flags &= __VM_UFFD_FLAGS;
 
-	if (vma->vm_flags & VM_DROPPABLE)
-		return false;
-
 	/*
-	 * If wp async enabled, and WP is the only mode enabled, allow any
+	 * If WP is the only mode enabled and context is wp async, allow any
 	 * memory type.
 	 */
 	if (wp_async && (vm_flags == VM_UFFD_WP))
 		return true;
 
+	/* For any other mode reject VMAs that don't implement vm_uffd_ops */
+	if (!ops)
+		return false;
+
+	if (vma->vm_flags & VM_DROPPABLE)
+		return false;
+
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
 	 * uffd-wp, then only anonymous memory is supported
-- 
2.51.0

