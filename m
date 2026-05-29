Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087782D063E;
	Fri, 29 May 2026 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060047; cv=none; b=TGUGyBHbTPF4DXOLgak9Xlli6r3gffYUmescT74mUNYPA1SbtIqvukwnMTz7tbDd+GMSGy0lMohVtRmG10yY8fS37B3CnFVT5uxDkeTCQsqdbE/1jHH93phohKefyJ3i+qz2Q9Mc0OFrYHpbUNBFBdoDhlFlcpPic9vJ2qlBABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060047; c=relaxed/simple;
	bh=4qsrnF1RfP3MZMjilFLq+zuqdzdWfUpno/MtBeqXYOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOUmetAB9hhqWt2x4gnF1fF4nHP5PJVNwGHFvNqvpxwFdwZYA34eAqL1Q0LEcqy4rEcTYJCR8SBxLI8aiDPtpv+HURv/dwg1NEQSL36DYKhOXxwHZ2+4rT1WksaFqvRxuotGuj4Lid4iBmlfg/qPXg4Xl3guUhXHj6xZUujJzmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Aqlkbu3n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vz88yi8a; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Aqlkbu3n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vz88yi8a"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailflow.stl.internal (Postfix) with ESMTP id B4CE51300170;
	Fri, 29 May 2026 09:07:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 29 May 2026 09:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1780060043; x=
	1780067243; bh=eJMpW2hSB+jc3Eyo7jLlqbS5uTNSQSSe1MRVXWkIVGI=; b=A
	qlkbu3ntW3+2ZuNtKSO9TYVsaJmJi2Ts/rEd0kAc1N8RQX9IuuBlKtz0SW3t85S7
	5vJQsuzoYGLFukh74IlIeL0+PfIl8ARzT5hamXc8GL9cgN41FhalybVKK8EgiwKV
	ltRKlnSYzCKg4e+QU5gkmSHIU0/ULvKzkm2Dtft00GP6P5m7UGqkXUuG/eJx3rYq
	nVcFCsObnUzGIFcBm/ty7CjlXecbWP7efkd+wWv/9+a1+vEHm4hCUgcW4KpJxTLr
	kOB+bnKC3c4gWhJPhgKJR/kvQfm6FjPEyWepoMJ13pf+V0u50R2+3p4sHn6TAFxa
	Oe6EPRRmNX+1vFDNmCafw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780060043; x=1780067243; bh=eJMpW2hSB+jc3Eyo7jLlqbS5uTNSQSSe1MR
	VXWkIVGI=; b=Vz88yi8asPzEYqiaJPJVw5TGNG4OkQzmQ6/u5BNSo4OxHHqt8j6
	9lYO7byEMoTTbVcbVSsuBLfCJL4YZ+AtVuJKOxysLbzNlQ19sMwM4GFavLo0fRpY
	hvjBDVCtg3wP4i+dgyLka4Q7lBs47wxwvLkH0Kn8dvyj6RE9vnoWSiITgD9Xb63I
	BEE+hORe7Xf6rchGwZa/2sdHG/Mf7wpN0n+tMk5mc/2CREAyRAJ4g3SqpknFv11r
	QcZ+lJZq3oh9lB7bmbU8fTvimeQnOjGe+WUCHf24JeUOb/+B4ouzrztbCz+xrel+
	GboHAMUT7O6m6JYNaZa07kOLMzXF2CoJbXg==
X-ME-Sender: <xms:i48ZamiyR4TJFCKeETpK0fupcUSI48U-aKFcwl8hdc-yadXIIcEDgQ>
    <xme:i48ZakrxZYHuxXFFTf-wEY9LtxmweZa-ycUy7qdfvVA6tYbg-xz1fSKYCMvpBPSYh
    ex_DIgVl-5ECEjySy8bVx1vVcDckjER-U9zV88SDEnWcow3JQ9jKQ4>
X-ME-Received: <xmr:i48Zajr-3qIMUyu-uNsOwWWoSqBazgcXkx5WnJ2jq80zD419GT_ybLALc1Ho7Q>
X-ME-Proxy-Cause: dmFkZTFAXH2AA1V/nISjcsAHVnuN9A/cQtlMi1fzE7O/cA4ypeDmxnBZg5TurfVPS8S9kH
    Idl7mOQ4mUWF2+2rvs6jrb6+USWJ0MtALSt9jwsgBx77XOdTRlP7hRKPWBegpWUy5GnWer
    4+wQXjC8oPOgHVotJfpOUQ16S/F9UDKdcLc/fcMT0mWO/KXvKDKqsLRI+8X2bYSzRnmDOU
    Sq5ftV09IsALoNh+0FN2cRDZLExI+uJ2rexuYMdXqXaZkXoXNhectZPiD8FLweTqpPjgsk
    ko2t82X3OzqjmCYsiBobOxzorIkY2aqwC64JMJjxNPUrstmZdeTN7JV5Tu5xu2AwEUfnqT
    nX93nkxbELa2TRjXls66dn/U8GzhVZw8Nl8f67bc/BtP5PSMQv+GHqYmSSGi/043BQMQId
    xviimONmYUxkj1LxzIOFcW3J6AqfcXotjvb6Dmw+kKPejcc8njSynM/VUy4TsZo1pmQ/Zm
    4f4aodsJY6KcIAtsyx2DqkFHVrh7np8+yISvUWnMyQ0xQcVuP4A4J4LUTmuY9Gyh7Q77g8
    z4VXYmgF/P4qRCns/dVxXMygSMcnkeZMslpOssUT0pCxbHbGVkUavIfAKVe9WbAXp0BTJN
    2RYrh2aEmIJuHgsmd2q/gmZU0hfplp9qFxauv/2ylXJoaNEYkSjb+N47tY8w
X-ME-Proxy: <xmx:i48Zai5urxGJdMaLkU4r3LI_qyZUePtIDRLjlRTMhsJMgE9KwheOMQ>
    <xmx:i48Zai2NY78TgeDjWcTkzKJi_NDZV648qPCl1wv2L1NcjvJoPX50pA>
    <xmx:i48ZammmfNsu5jHXs56eaiX5cXKHzeNSGPxiHjEPt5RFiwpWZxAbXA>
    <xmx:i48Zaji_eZ0GBm2G6k_pQO8yjvYG3ER1uLLZLiITJ1ZeB0pznqqI7Q>
    <xmx:i48ZajEc6-EeZGZcEN-13USyozFkGPZZ3I05AHPwXixJzrItS6EuK2_K>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:07:21 -0400 (EDT)
Date: Fri, 29 May 2026 14:07:16 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v5 08/18] mm: add VM_UFFD_RWP VMA flag
Message-ID: <ahmM8LzrzX-qP_5s@thinkstation>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-9-kirill@shutemov.name>
 <ahk60ViRq4q2g4uz@lucifer>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahk60ViRq4q2g4uz@lucifer>

On Fri, May 29, 2026 at 08:24:55AM +0100, Lorenzo Stoakes wrote:
> On Tue, May 26, 2026 at 02:04:56PM +0100, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > Preparatory patch for userfaultfd read-write protection (RWP). RWP
> > extends userfaultfd protection from plain write-protection (WP) to
> > full read-write protection: accesses to an RWP-protected range --
> > reads as well as writes -- trap through userfaultfd.
> >
> > Reserve VM_UFFD_RWP, add the userfaultfd_rwp() and
> > userfaultfd_protected() helpers, and wire up the smaps "ur" entry and
> > the trace-flag table the rest of the series will use. The flag is
> > gated on CONFIG_USERFAULTFD_RWP, which is introduced together with the
> > UAPI in a later patch; until then VM_UFFD_RWP aliases VM_NONE and
> > every downstream check folds to dead code.
> >
> > Nothing sets or queries the flag yet.
> >
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> 
> Hm, if you've just used claude to bounce ideas off, I'm really not sure if
> it's necessary to disclose, though I respect your thoroughness for doing so
> :)

I've elaborated on how I used Claude in reply to Andrew:

https://lore.kernel.org/all/af5eALk9yO8pPcHv@thinkstation

It is more than bouncing ideas.

> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 71b11945e4fc..6499cfb61dc4 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -362,6 +362,7 @@ enum {
> >  #endif
> >  	DECLARE_VMA_BIT(UFFD_MINOR, 41),
> >  	DECLARE_VMA_BIT(SEALED, 42),
> > +	DECLARE_VMA_BIT(UFFD_RWP, 43),
> 
> I'm guessing CONFIG_USERFAULTFD_RWP is predicated on CONFIG_64BIT?

Yes:
	depends on 64BIT && ARCH_HAS_PTE_PROTNONE && HAVE_ARCH_USERFAULTFD_WP
> 
> It's a silly situation and once my VMA flags stuff is done it'll be
> eliminated but for now... :)

Yeah. I actually would appreciate your take on 04/18. It is related.

> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index f4cf5763f92c..0aef628514df 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -21,10 +21,11 @@
> >  #include <linux/hugetlb_inline.h>
> >
> >  /* The set of all possible UFFD-related VM flags. */
> > -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> > +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_MINOR | \
> > +			 VM_UFFD_WP | VM_UFFD_RWP)
> >
> >  #define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
> > -				      VMA_UFFD_MINOR_BIT)
> > +				      VMA_UFFD_MINOR_BIT, VMA_UFFD_RWP_BIT)
> >
> >  /*
> >   * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> > @@ -178,7 +179,7 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
> >   */
> >  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
> >  {
> > -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> > +	return vma->vm_flags & (VM_UFFD_MINOR | VM_UFFD_WP | VM_UFFD_RWP);
> 
> While we're here we might as well switch to using the new API?
> 
> Can do:
> 
> 	return vma_test_any_mask(vma, __VMA_UFFD_FLAGS);
> 
> One unfortunate thing is using bit values means we can't do the VM_NONE
> trick, but if !CONFIG_USERFAULTFD_RWP then VMA_UFFD_RWP_BIT wouldn't be set
> anyway, same for minor so this should be fine?

I think we need to decide first if the 04/18 direction is right.
We can define VMA_UFFD_RWP_BIT to VMA_NO_BIT if !CONFIG_USERFAULTFD_RWP.

> >  }
> >
> >  /*
> > @@ -208,6 +209,16 @@ static inline bool userfaultfd_minor(struct vm_area_struct *vma)
> >  	return vma->vm_flags & VM_UFFD_MINOR;
> >  }
> >
> > +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> > +{
> > +	return vma->vm_flags & VM_UFFD_RWP;
> > +}
> 
> Can be:
> 
> 	return vma_test(vma, VMA_UFFD_RWP_BIT);

Yep.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
