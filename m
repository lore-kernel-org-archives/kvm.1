Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4513C818B;
	Tue, 12 May 2026 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604549; cv=none; b=Yp3BIdAcgqfkDtoy4PCKrmx/lDhb7Ji6TQx1dnK3olBPcCblsizO08Gv8ZXeNHjJ7yH2VAFFiiJ1vLCI3f7ZdC9t8HAgaZ0syzyZtVSuFNfaSYJwF9wD/ItuxFATJjgR/4rxcs+yQVzQTEu70JG7PJAlRh2O39dq7KnZiDkfBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604549; c=relaxed/simple;
	bh=dTqLTRTuoCK+qHQVUE3hzoOV3vNVfAyMSu0DEB6GkGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVH/EHkbGi1exixN53+Au87VAdmrf5AaSZQrRbXtVryf51SN0IpwI8irbmMK8RfBNeBsU9OdTpO6Y69VoKkvZU++RNUlfWNkQyrO+I82u6cfhKPuVBwxdM+lKYpAUBd3Gs4KWnx+vwafk1uq38EbV1LgTXD8nr0j5jm0af8O2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzBrj4kc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzBrj4kc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C3C2BCB0;
	Tue, 12 May 2026 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604548;
	bh=dTqLTRTuoCK+qHQVUE3hzoOV3vNVfAyMSu0DEB6GkGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzBrj4kcyWoKsuKzpstlzcU9JRKNFW/UT44aiyBR/6bdKiWSpT+YoWi+lwMwJ2jJ9
	 6W+7jtJf8HYcEbT+KtAcOQkqAo3Pdt8S6OrREAb3p7sNYhkvmjzhl2gvwjvpxLiFCo
	 8aCTAMU3kex41W3c34J7VapJ5ZugDRebFlz6yKUTYTOVh6k3k2wB/u2I832xsiDm+K
	 ofteUGekKc8t3phkpRuJugVkM954ouM2tk5iH91EKA8iIhTyH3WMmnDxsyK9hQ3nan
	 bGzbO27RQlDinIWLGHSWDfJk89tUYWL2wXsWNrTBZxIqqESBSvYMFVULsG0p7oD2hd
	 CpK31d9RCu+YQ==
Date: Tue, 12 May 2026 19:48:57 +0300
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
Subject: Re: [PATCH v2 04/14] mm: add VM_UFFD_RWP VMA flag
Message-ID: <agNZ-Q7A0rfY66gj@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <b47d8d5681fd8730f6090ebfdb72f219a8edef1e.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b47d8d5681fd8730f6090ebfdb72f219a8edef1e.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:16PM +0100, Kiryl Shutsemau (Meta) wrote:
> Preparatory patch for userfaultfd read-write protection (RWP). RWP
> extends userfaultfd protection from plain write-protection (WP) to
> full read-write protection: accesses to an RWP-protected range --
> reads as well as writes -- trap through userfaultfd.
> 
> RWP marks ranges by combining PAGE_NONE with the uffd PTE bit, so
> the flag is only meaningful when both primitives exist. A new
> CONFIG_USERFAULTFD_RWP Kconfig symbol auto-selects when CONFIG_64BIT,
> CONFIG_ARCH_HAS_PTE_PROTNONE, and CONFIG_HAVE_ARCH_USERFAULTFD_WP
> are all set; call sites that gate on the flag depend on the symbol.
> Elsewhere VM_UFFD_RWP aliases VM_NONE and every downstream check
> folds to dead code.
> 
> Nothing sets the flag yet.

And nothing check for it as well, am I right?
Worth noting here, IMHO.
 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 28 +++++++++++++++++----------
>  include/linux/userfaultfd_k.h      | 31 +++++++++++++++++++++++++-----
>  include/trace/events/mmflags.h     |  7 +++++++
>  mm/Kconfig                         |  9 +++++++++
>  6 files changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 98f546e83cd2..fcf308dba311 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -21,10 +21,11 @@
>  #include <linux/hugetlb_inline.h>
>  
>  /* The set of all possible UFFD-related VM flags. */
> -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR | \
> +			 VM_UFFD_RWP)

Nit: can we keep mode bits together and protection bits together here and
in the below changes?

Otherwise looks good to me

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  #define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
> -				      VMA_UFFD_MINOR_BIT)
> +				      VMA_UFFD_MINOR_BIT, VMA_UFFD_RWP_BIT)
>  
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -192,7 +193,7 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>   */
>  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>  {
> -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR | VM_UFFD_RWP);
>  }
>  
>  /*
> @@ -222,6 +223,16 @@ static inline bool userfaultfd_minor(struct vm_area_struct *vma)
>  	return vma->vm_flags & VM_UFFD_MINOR;
>  }
>  
> +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & VM_UFFD_RWP;
> +}
> +
> +static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> +{
> +	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
> +}
> +
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
>  				      pte_t pte)
>  {

-- 
Sincerely yours,
Mike.
