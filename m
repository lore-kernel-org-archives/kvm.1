Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320B03E0C42;
	Fri, 29 May 2026 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063238; cv=none; b=siVu2C1bQc94Xs5sAhqTGSVww3c48q9ixdDZlfWDMxEyCUDQrcqW6YR7E1FPe8fWERblbCxpAB68/K0et7XC1Km21vMtvh8hFSa0HflcsuNdu5E2LG8nJ4zh7NTZ4zAJGVepW9sZLzhV0h49X5fMjWygWZjHF8Ov6dhSNCIngvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063238; c=relaxed/simple;
	bh=35aOUUiajUr3730X7VPLCbJ3Dh+SamSQ3owDNCblHHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoRH5IoDQorXg4/HMKyUgTRo29IQ0L1LMjjJc1EAmARrasY/PVO4o91zbs36qTTJLvmogoV2WpNhXOXTYWj1FqcFfAwyPQMyw/KmoMh3ZnPVXlNdGvQGqWg1+sfdMixY/PGGgYY7JZe+fYXptYYAaY9T09uvI9fXMx5Ui0FjZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENTBUfU9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENTBUfU9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02E91F00893;
	Fri, 29 May 2026 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780063236;
	bh=OPcYymHmOJpRusLXuWmZNY6VFZDOtwyJMTAW5ccYu6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ENTBUfU9LnD7fAI5xU/4xcee1oNGvdMfii+swBtlaOam7bQBWxeIDOcQ+dZCC37zt
	 J4YgC4T2udD2L+XartNxejOiyD//y1noIpU3Y2VRbyqp9b+vTeOU8NNufBHz8d3x6G
	 0KG6KFuEG/duwIK/5kbXC0tsVQ/UVxdIVqNLQc1dE6AL63h5zyAYhW6daDHS35wlPJ
	 ZlC8eGvlxFfTIhfMgFktuFDMgy6JacSo6F+mMFk3V8tEN0KHkwdbeQ2mkoPkKOI9n9
	 zPG1YyhGatWfCJ548U9tm9hFuEKAYLkn/Jhlr78Djv5nCWrYlvLKIUCDa1da7WpLDa
	 GEZZm6tokEFTA==
Date: Fri, 29 May 2026 15:00:28 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 08/18] mm: add VM_UFFD_RWP VMA flag
Message-ID: <ahmQCwG2xCSwO29k@lucifer>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-9-kirill@shutemov.name>
 <ahk60ViRq4q2g4uz@lucifer>
 <ahmM8LzrzX-qP_5s@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmM8LzrzX-qP_5s@thinkstation>

On Fri, May 29, 2026 at 02:07:16PM +0100, Kiryl Shutsemau wrote:
> On Fri, May 29, 2026 at 08:24:55AM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 26, 2026 at 02:04:56PM +0100, Kiryl Shutsemau wrote:
> > > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> > >
> > > Preparatory patch for userfaultfd read-write protection (RWP). RWP
> > > extends userfaultfd protection from plain write-protection (WP) to
> > > full read-write protection: accesses to an RWP-protected range --
> > > reads as well as writes -- trap through userfaultfd.
> > >
> > > Reserve VM_UFFD_RWP, add the userfaultfd_rwp() and
> > > userfaultfd_protected() helpers, and wire up the smaps "ur" entry and
> > > the trace-flag table the rest of the series will use. The flag is
> > > gated on CONFIG_USERFAULTFD_RWP, which is introduced together with the
> > > UAPI in a later patch; until then VM_UFFD_RWP aliases VM_NONE and
> > > every downstream check folds to dead code.
> > >
> > > Nothing sets or queries the flag yet.
> > >
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > Assisted-by: Claude:claude-opus-4-6
> >
> > Hm, if you've just used claude to bounce ideas off, I'm really not sure if
> > it's necessary to disclose, though I respect your thoroughness for doing so
> > :)
>
> I've elaborated on how I used Claude in reply to Andrew:
>
> https://lore.kernel.org/all/af5eALk9yO8pPcHv@thinkstation
>
> It is more than bouncing ideas.

Ah interesting! Fair enough then.

>
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 71b11945e4fc..6499cfb61dc4 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -362,6 +362,7 @@ enum {
> > >  #endif
> > >  	DECLARE_VMA_BIT(UFFD_MINOR, 41),
> > >  	DECLARE_VMA_BIT(SEALED, 42),
> > > +	DECLARE_VMA_BIT(UFFD_RWP, 43),
> >
> > I'm guessing CONFIG_USERFAULTFD_RWP is predicated on CONFIG_64BIT?
>
> Yes:
> 	depends on 64BIT && ARCH_HAS_PTE_PROTNONE && HAVE_ARCH_USERFAULTFD_WP
> >
> > It's a silly situation and once my VMA flags stuff is done it'll be
> > eliminated but for now... :)
>
> Yeah. I actually would appreciate your take on 04/18. It is related.

I'll reply there.

>
> > > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > > index f4cf5763f92c..0aef628514df 100644
> > > --- a/include/linux/userfaultfd_k.h
> > > +++ b/include/linux/userfaultfd_k.h
> > > @@ -21,10 +21,11 @@
> > >  #include <linux/hugetlb_inline.h>
> > >
> > >  /* The set of all possible UFFD-related VM flags. */
> > > -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> > > +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_MINOR | \
> > > +			 VM_UFFD_WP | VM_UFFD_RWP)
> > >
> > >  #define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
> > > -				      VMA_UFFD_MINOR_BIT)
> > > +				      VMA_UFFD_MINOR_BIT, VMA_UFFD_RWP_BIT)
> > >
> > >  /*
> > >   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> > > @@ -178,7 +179,7 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> > >   */
> > >  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
> > >  {
> > > -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> > > +	return vma->vm_flags & (VM_UFFD_MINOR | VM_UFFD_WP | VM_UFFD_RWP);
> >
> > While we're here we might as well switch to using the new API?
> >
> > Can do:
> >
> > 	return vma_test_any_mask(vma, __VMA_UFFD_FLAGS);
> >
> > One unfortunate thing is using bit values means we can't do the VM_NONE
> > trick, but if !CONFIG_USERFAULTFD_RWP then VMA_UFFD_RWP_BIT wouldn't be set
> > anyway, same for minor so this should be fine?
>
> I think we need to decide first if the 04/18 direction is right.
> We can define VMA_UFFD_RWP_BIT to VMA_NO_BIT if !CONFIG_USERFAULTFD_RWP.

Yeah I don't think that approach is workable unfortunately (see my reply
there).

But I suggest some workarounds there with VMA_UFFD_RWP.

>
> > >  }
> > >
> > >  /*
> > > @@ -208,6 +209,16 @@ static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> > >  	return vma->vm_flags & VM_UFFD_MINOR;
> > >  }
> > >
> > > +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> > > +{
> > > +	return vma->vm_flags & VM_UFFD_RWP;
> > > +}
> >
> > Can be:
> >
> > 	return vma_test(vma, VMA_UFFD_RWP_BIT);
>
> Yep.

With the approach suggested in 04/18 we could do this as:

	return vma_test_any_mask(vma, VMA_UFFD_RWP);

Which is a bit fugly but will work.

>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo
