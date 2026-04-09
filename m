Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16E27BF7C;
	Thu,  9 Apr 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735420; cv=none; b=po1fdrb4Blx5BdoZh6kmYIATe4aiBaY+YoWVv5Nckc6Tpl/Za/OZWruudgyPjAmTe++8A67lAa4dZ6j/kHdWAW/Vpi3+MyNdGx/JZGMAspnCc89UzLit0mYYttfvUuAf+o28UZF5G7ykIfZTcnOsJHb1ID2HFg5Tub7uV3q5AL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735420; c=relaxed/simple;
	bh=Mp6RwckuLl4IhCOSbAcDzWGzKF26msw1bEgZICRtzsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG1bzDk1NKYVzF0LeRnaaUCMU0O9E/zAq6KiivMi9AO/Kvsa52NUfzG6nhBj9cd5gCnnb95siJya3FeZzgK6Gj0rmltyJ07wiB3a68uNZMSa7cQJEgmnE57kC0h65tlR58gnSVqZnRgB+5VJDZAkQbLQVH5TOQKlRcS257ias4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmYJuWe2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmYJuWe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65794C4CEF7;
	Thu,  9 Apr 2026 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775735420;
	bh=Mp6RwckuLl4IhCOSbAcDzWGzKF26msw1bEgZICRtzsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmYJuWe26QucjVeBfEJK64d0300yIFY4sVeYJz0y2S9j10vPr1gURgmRS8Ra6DVQn
	 ERFOwCI2JbX/w68vXuPOqFaCiPoPYMyXFAZG/ihCG3Rll/8pXDACP+1pmL9vZIMXpl
	 QorYsC/2W7S6sHU8M089LtYemTBnvmBmxrqS9fCP01V/uO3NQCZvIdxV7qCfvQB/Bt
	 z5pkAPxv2by7LKYPskTxZu1Jso5dGDLuapoHcpTFbqadFQyKMVi2BeZ+ygdKRuN5q/
	 G9vghTxT7RFWLEH9Z9q27/eLcfDgOphJtEeVheijmCwkTnV5IACKrEHWY9FjjayVYU
	 gvPchPW2O1lcQ==
Date: Thu, 9 Apr 2026 14:50:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/15] KVM: guest_memfd: implement userfaultfd
 operations
Message-ID: <adeScX-HVYeYufCm@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-14-rppt@kernel.org>
 <ac7oE_1j6gxf8OKT@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac7oE_1j6gxf8OKT@google.com>

Hi Sean,

On Thu, Apr 02, 2026 at 03:05:07PM -0700, Sean Christopherson wrote:
> On Thu, Apr 02, 2026, Mike Rapoport wrote:
>
> > +#ifdef CONFIG_USERFAULTFD
> > +static bool kvm_gmem_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
> > +{
> > +	struct inode *inode = file_inode(vma->vm_file);
> > +
> > +	/*
> > +	 * Only support userfaultfd for guest_memfd with INIT_SHARED flag.
> > +	 * This ensures the memory can be mapped to userspace.
> > +	 */
> > +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> > +		return false;
> 
> I'm not comfortable with this change.  It works for now, but it's going to be
> wildly wrong when in-place conversion comes along.  While I agree with the "Let's
> solve each problem in it's time :)"[*], the time for in-place conversion is now.
> In-place conversion isn't landing this cycle or next, but it's been in development
> for longer than UFFD support, and I'm not willing to punt solvable problems to
> that series, because it's plenty fat as is.

I'm not against solving it as a part of uffd support, but since we are very
close to the merge window, for now I asked Andrew to drop drop guest_memfd
patches from the set and only move forward with the refactoring of uffd and
shmem that has value on its own.
 
> Happily, IIUC, this is an easy problem to solve, and will have a nice side effect
> for the common UFFD code.
> 
> My objection to an early, global "can_userfault()" check is that it's guaranteed
> to cause TOCTOU issues.  E.g. for VM_UFFD_MISSING and VM_UFFD_MINOR, the check on
> whether or not a given address can be faulted in needs to happen in __do_userfault(),
> not broadly when VM_UFFD_MINOR is added to a VMA.  Conceptually, that also better
> aligns the code with the "normal" user fault path in kvm_gmem_fault_user_mapping().
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 6f33307c2780..8a2d0625ffa3 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -82,8 +82,8 @@ extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
>  
>  /* VMA userfaultfd operations */
>  struct vm_uffd_ops {
> -       /* Checks if a VMA can support userfaultfd */
> -       bool (*can_userfault)(struct vm_area_struct *vma, vm_flags_t vm_flags);
> +       /* What UFFD flags/modes are supported. */
> +       const vm_flags_t supported_uffd_flags;

VMA maintainers really didn't like a fields flag in vm_uffd_ops when it was
proposed earlier, but an indirect call may work.

>         /*
>          * Called to resolve UFFDIO_CONTINUE request.
>          * Should return the folio found at pgoff in the VMA's pagecache if it
> 
> with usage like:
> 
> static const struct vm_uffd_ops shmem_uffd_ops = {
> 	.supported_uffd_flags	= __VM_UFFD_FLAGS,
> 	.get_folio_noalloc	= shmem_get_folio_noalloc,
> 	.alloc_folio		= shmem_mfill_folio_alloc,
> 	.filemap_add		= shmem_mfill_filemap_add,
> 	.filemap_remove		= shmem_mfill_filemap_remove,
> };
> 
> All in all, somelike like so (completely untested):
> 
> ---
>  include/linux/userfaultfd_k.h |  4 +-
>  mm/filemap.c                  |  1 +
>  mm/hugetlb.c                  |  8 +---
>  mm/shmem.c                    |  7 +--
>  mm/userfaultfd.c              |  6 +--
>  virt/kvm/guest_memfd.c        | 80 ++++++++++++++++++++++++++++++++++-
>  6 files changed, 87 insertions(+), 19 deletions(-)

Let's revisit after -rc1 :)

-- 
Sincerely yours,
Mike.
