Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502933E5A3B;
	Wed,  3 Jun 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491159; cv=none; b=cS6OaBA9572ADdM2Xi12oFpZHwuvM7cH3yHPxt/EViHsSKL98/CFGG1gteb1HXA2XeH/DOVZSKcggsBtsAo4JiX2G6d7LHLGfWnDFDCNL9w/Q/EvsQta5Bm24urxAFt8jDFeJrZ7aRt++F1YDj8pxF1X4qJZh2ziXSyKPxoI05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491159; c=relaxed/simple;
	bh=Gr44DUW06UdtKWBivhleKE9FnImixVTRebq0KkXDbNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2YX3pHFyaC9fawEFZX5oysVX3QPdUvia8jurXRzOeoD8LjYw6KO5XsRIV9kp+PIHppKdeBIkEJBf1SbI2zrtbdxyHAN3sSxZGA54gO+EFfEGOhKG1fPFHhB5Z327/gEH1oEG8b5yJy+ey682x/k3RpDEIjqWn+13GIhZlQnVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxE84y/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxE84y/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C301F00893;
	Wed,  3 Jun 2026 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491158;
	bh=0LBDQdj4F5kgJaAQzgzgFyrow/wV0tNWGh6dD2EJJzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UxE84y/SQr+Ii1ViKjtRb3BuCRGqaGkaWPvqmeNItatBpBRy2egqMlF8q0R+Afnlm
	 aIJvGnoVppn2Ztfjum15r/IfatCP60OgPE1RQLGSg1/vE6vPWM7JFMcpAJwBSh1h4a
	 OTP4FoJtBEJPKx/moY4kwKnpx1fwVGop1QtB46OfoajTIV944jKax0L5UvIZ4ppd3y
	 YkyuK86FXEGHzW0YCwaJb9aE6YXGGMmB1+the+/g+XMBUDgCUoaLdfuFrKaxG8ojV/
	 rQuwKnVYebmd0NG2W/6GhjynF0XnjXzgs4xeNvr8h/R8pSjrahk+X5odQmHzKeM0dh
	 FFSjGT3X1Tjow==
Date: Wed, 3 Jun 2026 13:52:29 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 05/15] mm: add VM_UFFD_RWP VMA flag
Message-ID: <aiAiTuzRrIvc93m8@lucifer>
References: <20260529172716.357179-1-kas@kernel.org>
 <20260529172716.357179-6-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172716.357179-6-kas@kernel.org>

On Fri, May 29, 2026 at 06:26:34PM +0100, Kiryl Shutsemau (Meta) wrote:
> Preparatory patch for userfaultfd read-write protection (RWP). RWP
> extends userfaultfd protection from plain write-protection (WP) to
> full read-write protection: accesses to an RWP-protected range --
> reads as well as writes -- trap through userfaultfd.
>
> Reserve VM_UFFD_RWP, add the userfaultfd_rwp() and
> userfaultfd_protected() helpers, and wire up the smaps "ur" entry and
> the trace-flag table the rest of the series will use. The flag is
> gated on CONFIG_USERFAULTFD_RWP, which is introduced together with the
> UAPI in a later patch; until then VM_UFFD_RWP aliases VM_NONE and
> every downstream check folds to dead code.
>
> Nothing sets or queries the flag yet.
>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: SeongJae Park <sj@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 41 ++++++++++++++++++++----------
>  include/linux/userfaultfd_k.h      | 32 +++++++++++++++++++----
>  include/trace/events/mmflags.h     |  7 +++++
>  5 files changed, 65 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index db6167befb7b..db28207c5290 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -607,6 +607,7 @@ encoded manner. The codes are the following:
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
>      ui    userfaultfd minor fault
> +    ur    userfaultfd read-write-protect tracking
>      ss    shadow/guarded control stack page
>      sl    sealed
>      lf    lock on fault pages
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 939657aa334a..ca0f69b347e8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1237,6 +1237,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> +#ifdef CONFIG_USERFAULTFD_RWP
> +		[ilog2(VM_UFFD_RWP)]	= "ur",
> +#endif
>  #ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..5ac31fbadeef 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -353,6 +353,7 @@ enum {
>  #endif
>  	DECLARE_VMA_BIT(UFFD_MINOR, 41),
>  	DECLARE_VMA_BIT(SEALED, 42),
> +	DECLARE_VMA_BIT(UFFD_RWP, 43),
>  	/* Flags that reuse flags above. */
>  	DECLARE_VMA_BIT_ALIAS(PKEY_BIT0, HIGH_ARCH_0),
>  	DECLARE_VMA_BIT_ALIAS(PKEY_BIT1, HIGH_ARCH_1),
> @@ -496,12 +497,17 @@ enum {
>  #else
>  #define VM_UFFD_MINOR	VM_NONE
>  #endif
> +#ifdef CONFIG_USERFAULTFD_RWP
> +#define VM_UFFD_RWP		INIT_VM_FLAG(UFFD_RWP)
> +#else
> +#define VM_UFFD_RWP		VM_NONE
> +#endif
>
>  /*
> - * vma_flags_t masks for the userfaultfd VMA flags. VMA_UFFD_MINOR is gated on
> - * the same config as VM_UFFD_MINOR -- which implies 64BIT, where the bit fits
> - * -- so an out-of-range bit is never fed to mk_vma_flags() on a build whose
> - * bitmap cannot hold it.
> + * vma_flags_t masks for the userfaultfd VMA flags. The two high-bit modes are
> + * gated on the same configs as their VM_* flags above -- both of which imply
> + * 64BIT -- so an out-of-range bit is never fed to mk_vma_flags() on a build
> + * whose bitmap cannot hold it.
>   */
>  #define VMA_UFFD_MISSING	mk_vma_flags(VMA_UFFD_MISSING_BIT)
>  #define VMA_UFFD_WP		mk_vma_flags(VMA_UFFD_WP_BIT)
> @@ -510,6 +516,11 @@ enum {
>  #else
>  #define VMA_UFFD_MINOR		EMPTY_VMA_FLAGS
>  #endif
> +#ifdef CONFIG_USERFAULTFD_RWP
> +#define VMA_UFFD_RWP		mk_vma_flags(VMA_UFFD_RWP_BIT)
> +#else
> +#define VMA_UFFD_RWP		EMPTY_VMA_FLAGS
> +#endif
>
>  #ifdef CONFIG_64BIT
>  #define VM_ALLOW_ANY_UNCACHED	INIT_VM_FLAG(ALLOW_ANY_UNCACHED)
> @@ -648,22 +659,24 @@ enum {
>   * reconsistuted upon page fault, so necessitate page table copying upon fork.
>   *
>   * Note that these flags should be compared with the DESTINATION VMA not the
> - * source, as VM_UFFD_WP may not be propagated to destination, while all other
> - * flags will be.
> + * source: VM_UFFD_WP and VM_UFFD_RWP may be cleared on the destination
> + * (dup_userfaultfd() -> userfaultfd_reset_ctx() when the parent context did
> + * not negotiate UFFD_FEATURE_EVENT_FORK), while all other flags propagate.
>   *
>   * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cannot be
>   *                           reasonably reconstructed on page fault.
>   *
>   *              VM_UFFD_WP - Encodes metadata about an installed uffd
> - *                           write protect handler, which cannot be
> - *                           reconstructed on page fault.
> + *              VM_UFFD_RWP  write- or read-write-protect handler, which
> + *                           cannot be reconstructed on page fault.
>   *
> - *                           We always copy pgtables when dst_vma has uffd-wp
> - *                           enabled even if it's file-backed
> - *                           (e.g. shmem). Because when uffd-wp is enabled,
> - *                           pgtable contains uffd-wp protection information,
> - *                           that's something we can't retrieve from page cache,
> - *                           and skip copying will lose those info.
> + *                           We always copy pgtables when dst_vma has the
> + *                           uffd PTE bit in use even if it's file-backed
> + *                           (e.g. shmem). Because when the uffd bit is
> + *                           in use, the pgtable contains the protection
> + *                           information, that's something we can't
> + *                           retrieve from page cache, and skip copying
> + *                           will lose those info.
>   *
>   *          VM_MAYBE_GUARD - Could contain page guard region markers which
>   *                           by design are a property of the page tables
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c4f2cc6dfcf0..f3b2db27989b 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -21,10 +21,11 @@
>  #include <linux/hugetlb_inline.h>
>
>  /* The set of all possible UFFD-related VM flags. */
> -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_MINOR | \
> +			 VM_UFFD_WP | VM_UFFD_RWP)
>
>  #define __VMA_UFFD_FLAGS mk_vma_flags_from_masks(VMA_UFFD_MISSING, VMA_UFFD_WP, \
> -						 VMA_UFFD_MINOR)
> +						 VMA_UFFD_MINOR, VMA_UFFD_RWP)
>
>  /*
>   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -179,7 +180,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma,
> -		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
> +		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR,
> +					VMA_UFFD_RWP));

Wonder if a vma_test_any_masks() is worth adding now :) [will do separately though]

>  }
>
>  /*
> @@ -210,6 +212,16 @@ static inline bool userfaultfd_minor(struct vm_area_struct *vma)
>  	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
>  }
>
> +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +{
> +	return vma_test_any_mask(vma, VMA_UFFD_RWP);

NIT: You could use vma_flags_test_single_mask() just to make it clear it's a single
flag. It's not a big deal though really.

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
> @@ -330,6 +342,16 @@ static inline bool userfaultfd_minor(struct vm_area_struct *vma)
>  	return false;
>  }
>
> +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
> +static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
>  				      pte_t pte)
>  {
> @@ -423,8 +445,8 @@ static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
>  }
>
>  /*
> - * Returns true if this is a swap pte and was uffd-wp wr-protected in either
> - * forms (pte marker or a normal swap pte), false otherwise.
> + * Returns true if this swap pte carries uffd-tracked state in either
> + * form (pte marker or a normal swap pte), false otherwise.
>   */
>  static inline bool pte_swp_uffd_any(pte_t pte)
>  {
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index a6e5a44c9b42..bfface3d0203 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -194,6 +194,12 @@ IF_HAVE_PG_ARCH_3(arch_3)
>  # define IF_HAVE_UFFD_MINOR(flag, name)
>  #endif
>
> +#ifdef CONFIG_USERFAULTFD_RWP
> +# define IF_HAVE_UFFD_RWP(flag, name) {flag, name},
> +#else
> +# define IF_HAVE_UFFD_RWP(flag, name)
> +#endif
> +
>  #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
>  # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
>  #else
> @@ -215,6 +221,7 @@ IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
>  	{VM_PFNMAP,			"pfnmap"	},		\
>  	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
>  	{VM_UFFD_WP,			"uffd_wp"	},		\
> +IF_HAVE_UFFD_RWP(VM_UFFD_RWP,		"uffd_rwp"	)		\
>  	{VM_LOCKED,			"locked"	},		\
>  	{VM_IO,				"io"		},		\
>  	{VM_SEQ_READ,			"seqread"	},		\
> --
> 2.54.0
>
