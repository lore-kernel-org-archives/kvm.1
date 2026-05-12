Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AC3C416B;
	Tue, 12 May 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605157; cv=none; b=VzDt936DPLXuiMA9w/P/rbxVwxKCX8sAt1rXD87lSwYY/725n0jZ5VhKzFaTDgbvwfifF1SfSKS57yKac0eGQW2yPoasZliFRcS5+fwu6ob1+Q9n5KIOOzfs1GlQHvK5Ox6SsD6f6t1z3sa8Sd6IZQXaWGv2tpx8Eqz9AaqIOjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605157; c=relaxed/simple;
	bh=6gCNGvciQzZwGHqAygXudz2Ik6trRiCjCYuMDC1DRqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9dqYQLEEymYSfI/Nzq4tq86lqiw+i7IrtfjECJOXM3wHJCvEfCutHJtgwQd/RX9m3O15xjTX6cIRs088zAX34pvG2NGJNvpZMQKdfRYypM+jJ+lMWLH4rRA76lI5NLbSVQuhr/+8NZ8H2TScydPNEA7EdnZROn21QL2EKI1AxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5XpMV+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5XpMV+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49C3C2BCB0;
	Tue, 12 May 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605156;
	bh=6gCNGvciQzZwGHqAygXudz2Ik6trRiCjCYuMDC1DRqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5XpMV+TvoWyI5gdUlzINx6yhtCYFQclHKyxzwVDwcilYTFr0VfzwOYwy0J8ORMLh
	 EC9e3ggrzGdqNkeJ2fYFElamu/WcZ5Swxy33tf2mxb+xzgpAXMP9O0jkiXf5CLlsQI
	 HLYIBqSkpcj6D6uNuw4odNi9aIVCL6gw6kLLwgEjEosu+ZC6vBX9e51kBkviEkSX5d
	 Br6KdEJXjcyw6Q47SPmHaVOnCbefRS4dP2/E0eHglKjfxmCKrFz8v3NDubpP3oPdyH
	 dYN8HpXHYKjaqaIJE7qSy6IxCu7YlffTryv6eTZUM6pgxTUpVcvFCqrknWVWaT54QM
	 jU6Xtn8v003gg==
Date: Tue, 12 May 2026 19:59:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 06/14] mm: preserve RWP marker across PTE rewrites
Message-ID: <agNcWW58T-rB-1PD@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <197efcdbb1ba5be7911afdccfd0b5a0610d9497f.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197efcdbb1ba5be7911afdccfd0b5a0610d9497f.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:18PM +0100, Kiryl Shutsemau (Meta) wrote:
> The uffd PTE bit must survive any kernel path that rewrites a PTE
> on a VM_UFFD_RWP VMA, otherwise the marker that carries PAGE_NONE
> semantics is silently dropped and the next access leaks past RWP
> tracking. Wire the preservation through every path that rewrites a
> VM_UFFD_RWP PTE.
> 
> Swap and device-exclusive: do_swap_page(), restore_exclusive_pte(),
> and unuse_pte() (swapoff()) re-apply PAGE_NONE when the swap PTE
> carries the uffd bit and the VMA has VM_UFFD_RWP.
> 
> Migration: remove_migration_pte() and remove_migration_pmd() do the
> same after the migration entry is replaced with a real PTE/PMD.
> 
> Fork: __copy_present_ptes(), copy_present_page(), copy_nonpresent_pte(),
> copy_huge_pmd(), copy_huge_non_present_pmd(), and
> copy_hugetlb_page_range() keep the uffd bit on the child when the
> destination VMA has VM_UFFD_RWP, matching the existing VM_UFFD_WP
> handling. Add VM_UFFD_RWP to VM_COPY_ON_FORK so the flag itself
> propagates.
> 
> mprotect(): change_pte_range() and change_huge_pmd() restore PAGE_NONE
> after pte_modify()/pmd_modify() have recomputed the base protection
> from a (possibly user-changed) vm_page_prot. pte_modify() preserves
> _PAGE_UFFD, so the bit stays; we just have to force PAGE_NONE back
> on top.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm.h |  3 ++-
>  mm/huge_memory.c   | 47 ++++++++++++++++++++++++++++++++++++++++++----
>  mm/hugetlb.c       | 40 ++++++++++++++++++++++++++++++---------
>  mm/memory.c        | 47 +++++++++++++++++++++++++++++++++++++++-------
>  mm/migrate.c       |  8 ++++++++
>  mm/mprotect.c      | 10 ++++++++++
>  mm/mremap.c        | 13 +++++++++++--
>  mm/swapfile.c      |  5 +++++
>  mm/userfaultfd.c   | 14 ++++++++++++++
>  9 files changed, 164 insertions(+), 23 deletions(-)
> 

-- 
Sincerely yours,
Mike.
