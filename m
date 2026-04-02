Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75C223D7F0
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167513; cv=none; b=jg6JbNpe7L31sdudaWGtH34QUHMF34SWocH5MGN2s1W/bmiEj7GsMV0qsybc6ICAgdXKIwBFoSSwaUcn38D/sjWdm6sQZ2TWdZ24xwGo1E648YariEIQu68/0bSovWa+u0dILkg36Y1Y0dY1/VDjHJcnWHyFBQceCydgmI+OR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167513; c=relaxed/simple;
	bh=SS6jjGPBwaueBbnxFbbb7srYdRNYvKMgLh1APPuzumM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DHolCy4e1u9Mgwkj7XM49jBnrjkgan3wXGjH8Mj2pFFnUaVQYwNEySv1CAkHAqMT+1uQcja4apx52RMWcUfeqKQzwSMSvidWg7K0BzxM9FR3OuGFZC8/raE06vPWgS7NwO0Eklfb502GDAAMM7OzDpWNnbzLWX7IUx1WHg7VYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iyblPQ0k; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyblPQ0k"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c63f85c84so705765b3a.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775167509; x=1775772309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAv8DE2ZjSrMzBslXDcHnw4ArEUIbJuoraduZwQc4zU=;
        b=iyblPQ0k9bdv7ke5MRGQa8+hbD2hPUZSPCLNOGKuA01vS5Ed4/QSTM1CI2pebMcnIw
         wyF4o9xplITELDwCxmi4wlQoyJW3M7AsmqTQN1MwaWJTmDkz3pLBQyY5sv6cqXvDRBJs
         FUutVOxI/uGNvdjQESZbeHjzg2FpZTpKvB/jNBayon0Ee58ipxS5A8KUrn5tVDcSQ8HW
         2Y3+3ylxBiCRaDv/sOovGdz0zqQWi8v+DNfaYasMNCif72fdx8ILI9dXDJEQCQXiY58i
         5zpvz0qhFHglbSx/iqs4DPlVVSdCW6RXKB6k0qwcASP9Je/0syJZHw9moMhSQ7w9CsCO
         b7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775167509; x=1775772309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cAv8DE2ZjSrMzBslXDcHnw4ArEUIbJuoraduZwQc4zU=;
        b=WiwTm2GDTWtPQbnaRpeHLSj9JSqAxr4jDlnIVxqeSmgXxHEySWAKdRSBGj0IKFFa6W
         5SY+6EMMrkgOM3UVCsQmOHdNJf6aC/uN4huPt5giRgmTpS+wjeZAj/nxbnL4fxn6Fi/g
         eUVXK9qlwI38cU3EOBQ+mCuOTywb6dVMhtcUeqI7/XN3C1IEv07SZnnEG/DAsO74HvNl
         TpYoRIUWrGyT3XRLl4S3D6gN7HH147kNFso+P38hRLQJRgTo4iXZ2bCgC4Umueu/h1ne
         xSIOY0VTk9ptBr2v7vhl4qe/R2uSMZ+SnybWcHwIBHmC2dSY4QTJ0MRV+tmxjHSL/J1S
         WN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnnhgGeYtF2JVidW0XVTEd7/db0Cf24sOqU/SsAOKPQxY+3zAnT5bH0dOngLFUhv3N9rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPVn4VKBgiu52dSdsDzJ/3BJHK4P5vOX4oZEi000W+wB/84fq
	jNuherive1XMvIqswzwN4XCRyNoMIw0eb5tezRuKLbaUay/k2mFZ8Ow51xnTsPdyy4ALGvkY41C
	zEGkQqw==
X-Received: from pfnd12.prod.google.com ([2002:aa7:814c:0:b0:829:7eec:794])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cd3:b0:82c:dc9c:e759
 with SMTP id d2e1a72fcca58-82d0dbaec93mr645760b3a.42.1775167508647; Thu, 02
 Apr 2026 15:05:08 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:05:07 -0700
In-Reply-To: <20260402041156.1377214-14-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402041156.1377214-1-rppt@kernel.org> <20260402041156.1377214-14-rppt@kernel.org>
Message-ID: <ac7oE_1j6gxf8OKT@google.com>
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd operations
From: Sean Christopherson <seanjc@google.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>, 
	James Houghton <jthoughton@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Oscar Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, Mike Rapoport wrote:
> From: Nikita Kalyazin <kalyazin@amazon.com>
> 
> userfaultfd notifications about page faults used for live migration and
> snapshotting of VMs.
> 
> MISSING mode allows post-copy live migration and MINOR mode allows
> optimization for post-copy live migration for VMs backed with shared
> hugetlbfs or tmpfs mappings as described in detail in commit 7677f7fd8be7
> ("userfaultfd: add minor fault registration mode").
> 
> To use the same mechanisms for VMs that use guest_memfd to map their
> memory, guest_memfd should support userfaultfd operations.
> 
> Add implementation of vm_uffd_ops to guest_memfd.
> 
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/filemap.c           |  1 +
>  virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 406cef06b684..a91582293118 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -262,6 +262,7 @@ void filemap_remove_folio(struct folio *folio)
>  
>  	filemap_free_folio(mapping, folio);
>  }
> +EXPORT_SYMBOL_FOR_MODULES(filemap_remove_folio, "kvm");

This can be EXPORT_SYMBOL_FOR_KVM so that the symbol is exported if and only if
KVM is built as a module.

>  /*
>   * page_cache_delete_batch - delete several folios from page cache
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 017d84a7adf3..46582feeed75 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -7,6 +7,7 @@
>  #include <linux/mempolicy.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/pagemap.h>
> +#include <linux/userfaultfd_k.h>
>  
>  #include "kvm_mm.h"
>  
> @@ -107,6 +108,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>  	return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
>  }
>  
> +static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
> +{
> +	return __filemap_get_folio(inode->i_mapping, pgoff,
> +				   FGP_LOCK | FGP_ACCESSED, 0);

Note, this will conflict with commit 6dad5447c7bf ("KVM: guest_memfd: Don't set
FGP_ACCESSED when getting folios") sitting in

  https://github.com/kvm-x86/linux.git gmem

I think the resolution is to just end up with:

static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
{
	return filemap_lock_folio(inode->i_mapping, pgoff);
}

However, I think that'll be a moot point in the end (the conflict will be avoided).
More below.

> +}
> +
>  /*
>   * Returns a locked folio on success.  The caller is responsible for
>   * setting the up-to-date flag before the memory is mapped into the guest.
> @@ -126,8 +133,7 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
>  	 * Fast-path: See if folio is already present in mapping to avoid
>  	 * policy_lookup.
>  	 */
> -	folio = __filemap_get_folio(inode->i_mapping, index,
> -				    FGP_LOCK | FGP_ACCESSED, 0);
> +	folio = kvm_gmem_get_folio_noalloc(inode, index);
>  	if (!IS_ERR(folio))
>  		return folio;
>  
> @@ -457,12 +463,86 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>  }
>  #endif /* CONFIG_NUMA */
>  
> +#ifdef CONFIG_USERFAULTFD
> +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +
> +	/*
> +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
> +	 * This ensures the memory can be mapped to userspace.
> +	 */
> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> +		return false;

I'm not comfortable with this change.  It works for now, but it's going to be
wildly wrong when in-place conversion comes along.  While I agree with the "Let's
solve each problem in it's time :)"[*], the time for in-place conversion is now.
In-place conversion isn't landing this cycle or next, but it's been in development
for longer than UFFD support, and I'm not willing to punt solvable problems to
that series, because it's plenty fat as is.

Happily, IIUC, this is an easy problem to solve, and will have a nice side effect
for the common UFFD code.

My objection to an early, global "can_userfault()" check is that it's guaranteed
to cause TOCTOU issues.  E.g. for VM_UFFD_MISSING and VM_UFFD_MINOR, the check on
whether or not a given address can be faulted in needs to happen in __do_userfault(),
not broadly when VM_UFFD_MINOR is added to a VMA.  Conceptually, that also better
aligns the code with the "normal" user fault path in kvm_gmem_fault_user_mapping().

I'm definitely not asking to fully prep for in-place conversion, I just want to
set us up for success and also to not have to churn a pile of code.  Concretely,
again IIUC, I think we just need to move the INIT_SHARED check to ->alloc_folio()
and ->get_folio_noalloc().  And if we extract kvm_gmem_is_shared_mem() now instead
of waiting for in-place conversion, then we'll avoid a small amount of churn when
in-place conversion comes along.

The bonus side effect is that dropping guest_memfd's more "complex"
can_userfault means the only remaining check is constant based on the backing
memory vs. the UFFD flags.  If we want, the indirect call to a function can be
replace with a constant vm_flags_t variable that enumerates the supported (or
unsupported if we're feeling negative) flags, e.g.

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 6f33307c2780..8a2d0625ffa3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -82,8 +82,8 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* VMA userfaultfd operations */
 struct vm_uffd_ops {
-       /* Checks if a VMA can support userfaultfd */
-       bool (*can_userfault)(struct vm_area_struct *vma, vm_flags_t vm_flags);
+       /* What UFFD flags/modes are supported. */
+       const vm_flags_t supported_uffd_flags;
        /*
         * Called to resolve UFFDIO_CONTINUE request.
         * Should return the folio found at pgoff in the VMA's pagecache if it

with usage like:

static const struct vm_uffd_ops shmem_uffd_ops = {
	.supported_uffd_flags	= __VM_UFFD_FLAGS,
	.get_folio_noalloc	= shmem_get_folio_noalloc,
	.alloc_folio		= shmem_mfill_folio_alloc,
	.filemap_add		= shmem_mfill_filemap_add,
	.filemap_remove		= shmem_mfill_filemap_remove,
};

[*] https://lore.kernel.org/all/acZuW7_7yBdVsJqK@kernel.org

> +	return true;
> +}

...

> +static const struct vm_uffd_ops kvm_gmem_uffd_ops = {
> +	.can_userfault     = kvm_gmem_can_userfault,
> +	.get_folio_noalloc = kvm_gmem_get_folio_noalloc,
> +	.alloc_folio       = kvm_gmem_folio_alloc,
> +	.filemap_add       = kvm_gmem_filemap_add,
> +	.filemap_remove    = kvm_gmem_filemap_remove,

Please use kvm_gmem_uffd_xxx().  The names are a bit verbose, but these are waaay
to generic of names as-is, e.g. kvm_gmem_folio_alloc() has implications and
restrictions far beyond just allocating a folio.

All in all, somelike like so (completely untested):

---
 include/linux/userfaultfd_k.h |  4 +-
 mm/filemap.c                  |  1 +
 mm/hugetlb.c                  |  8 +---
 mm/shmem.c                    |  7 +--
 mm/userfaultfd.c              |  6 +--
 virt/kvm/guest_memfd.c        | 80 ++++++++++++++++++++++++++++++++++-
 6 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 6f33307c2780..8a2d0625ffa3 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -82,8 +82,8 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
 
 /* VMA userfaultfd operations */
 struct vm_uffd_ops {
-	/* Checks if a VMA can support userfaultfd */
-	bool (*can_userfault)(struct vm_area_struct *vma, vm_flags_t vm_flags);
+	/* What UFFD flags/modes are supported. */
+	const vm_flags_t supported_uffd_flags;
 	/*
 	 * Called to resolve UFFDIO_CONTINUE request.
 	 * Should return the folio found at pgoff in the VMA's pagecache if it
diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4ada..19dfcebcd23f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -262,6 +262,7 @@ void filemap_remove_folio(struct folio *folio)
 
 	filemap_free_folio(mapping, folio);
 }
+EXPORT_SYMBOL_FOR_MODULES(filemap_remove_folio, "kvm");
 
 /*
  * page_cache_delete_batch - delete several folios from page cache
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 077968a8a69a..f55857961adb 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4819,14 +4819,8 @@ static vm_fault_t hugetlb_vm_op_fault(struct vm_fault *vmf)
 }
 
 #ifdef CONFIG_USERFAULTFD
-static bool hugetlb_can_userfault(struct vm_area_struct *vma,
-				  vm_flags_t vm_flags)
-{
-	return true;
-}
-
 static const struct vm_uffd_ops hugetlb_uffd_ops = {
-	.can_userfault = hugetlb_can_userfault,
+	.supported_uffd_flags = __VM_UFFD_FLAGS,
 };
 #endif
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 239545352cd2..76d8488b9450 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3250,13 +3250,8 @@ static struct folio *shmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
 	return folio;
 }
 
-static bool shmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
-{
-	return true;
-}
-
 static const struct vm_uffd_ops shmem_uffd_ops = {
-	.can_userfault		= shmem_can_userfault,
+	.supported_uffd_flags	= __VM_UFFD_FLAGS,
 	.get_folio_noalloc	= shmem_get_folio_noalloc,
 	.alloc_folio		= shmem_mfill_folio_alloc,
 	.filemap_add		= shmem_mfill_filemap_add,
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 9ba6ec8c0781..ccbd7bb334c2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -58,8 +58,8 @@ static struct folio *anon_alloc_folio(struct vm_area_struct *vma,
 }
 
 static const struct vm_uffd_ops anon_uffd_ops = {
-	.can_userfault	= anon_can_userfault,
-	.alloc_folio	= anon_alloc_folio,
+	.supported_uffd_flags	= __VM_UFFD_FLAGS & ~VM_UFFD_MINOR,
+	.alloc_folio		= anon_alloc_folio,
 };
 
 static const struct vm_uffd_ops *vma_uffd_ops(struct vm_area_struct *vma)
@@ -2055,7 +2055,7 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	    !ops->get_folio_noalloc)
 		return false;
 
-	return ops->can_userfault(vma, vm_flags);
+	return ops->supported_uffd_flags & vm_flags;
 }
 
 static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 462c5c5cb602..e634bf671d12 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -7,6 +7,7 @@
 #include <linux/mempolicy.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
+#include <linux/userfaultfd_k.h>
 
 #include "kvm_mm.h"
 
@@ -59,6 +60,11 @@ static pgoff_t kvm_gmem_get_index(struct kvm_memory_slot *slot, gfn_t gfn)
 	return gfn - slot->base_gfn + slot->gmem.pgoff;
 }
 
+static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
+{
+	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED;
+}
+
 static int __kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				    pgoff_t index, struct folio *folio)
 {
@@ -396,7 +402,7 @@ static vm_fault_t kvm_gmem_fault_user_mapping(struct vm_fault *vmf)
 	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
 		return VM_FAULT_SIGBUS;
 
-	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
+	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
 		return VM_FAULT_SIGBUS;
 
 	folio = kvm_gmem_get_folio(inode, vmf->pgoff);
@@ -456,12 +462,84 @@ static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_USERFAULTFD
+static struct folio *kvm_gmem_uffd_get_folio_noalloc(struct inode *inode,
+						     pgoff_t pgoff)
+{
+	if (!kvm_gmem_is_shared_mem(inode, pgoff))
+		return NULL;
+
+	return filemap_lock_folio(inode->i_mapping, pgoff);
+}
+
+static struct folio *kvm_gmem_uffd_folio_alloc(struct vm_area_struct *vma,
+					       unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	pgoff_t pgoff = linear_page_index(vma, addr);
+	struct mempolicy *mpol;
+	struct folio *folio;
+	gfp_t gfp;
+
+	if (unlikely(pgoff >= (i_size_read(inode) >> PAGE_SHIFT)))
+		return NULL;
+
+	if (!kvm_gmem_is_shared_mem(inode, pgoff))
+		return NULL;
+
+	gfp = mapping_gfp_mask(inode->i_mapping);
+	mpol = mpol_shared_policy_lookup(&GMEM_I(inode)->policy, pgoff);
+	mpol = mpol ?: get_task_policy(current);
+	folio = filemap_alloc_folio(gfp, 0, mpol);
+	mpol_cond_put(mpol);
+
+	return folio;
+}
+
+static int kvm_gmem_uffd_filemap_add(struct folio *folio,
+				     struct vm_area_struct *vma,
+				     unsigned long addr)
+{
+	struct inode *inode = file_inode(vma->vm_file);
+	struct address_space *mapping = inode->i_mapping;
+	pgoff_t pgoff = linear_page_index(vma, addr);
+	int err;
+
+	__folio_set_locked(folio);
+	err = filemap_add_folio(mapping, folio, pgoff, GFP_KERNEL);
+	if (err) {
+		folio_unlock(folio);
+		return err;
+	}
+
+	return 0;
+}
+
+static void kvm_gmem_uffd_filemap_remove(struct folio *folio,
+					 struct vm_area_struct *vma)
+{
+	filemap_remove_folio(folio);
+	folio_unlock(folio);
+}
+
+static const struct vm_uffd_ops kvm_gmem_uffd_ops = {
+	.supported_uffd_flags	= __VM_UFFD_FLAGS,
+	.get_folio_noalloc	= kvm_gmem_uffd_get_folio_noalloc,
+	.alloc_folio		= kvm_gmem_uffd_folio_alloc,
+	.filemap_add		= kvm_gmem_uffd_filemap_add,
+	.filemap_remove		= kvm_gmem_uffd_filemap_remove,
+};
+#endif /* CONFIG_USERFAULTFD */
+
 static const struct vm_operations_struct kvm_gmem_vm_ops = {
 	.fault		= kvm_gmem_fault_user_mapping,
 #ifdef CONFIG_NUMA
 	.get_policy	= kvm_gmem_get_policy,
 	.set_policy	= kvm_gmem_set_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.uffd_ops	= &kvm_gmem_uffd_ops,
+#endif
 };
 
 static int kvm_gmem_mmap(struct file *file, struct vm_area_struct *vma)

base-commit: d63beb006dba56d5fa219f106c7a97eb128c356f
--
