Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8673C3434
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446369; cv=none; b=dlIaGBo9J1vz+BitCnXEHEO5N4qs7/nnmiZ37aVXmSGz72P8KDV8fno7fp205y5U7ni4fH/q7z+oLlvblejYmbSSPJtmrxGSgzUv4Gu0Ld+H8m4Xmffq58HQTOr0re+oKqceK75VzUJ2YfU5z9tQ8fl8QtiWdq8G9fdzKDbRK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446369; c=relaxed/simple;
	bh=Lp2DFMVZZ2LIg+5yBW61mVfXozZ8FXQIJ//FRu28MlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmlsxI3Gsa9kwqiGyhUW0e3CEzxumXv8G9vB6hOyKoCQxxqpe/xuzuf9xwpQNJSA6YEBItxuTFh4CzQrlbfNQIr2bHRU+nt7ZpBuEYXI9kxrMsDmIFEovrq4fcZOI/UrKDsfAJNQUY5ov76QCiLrKlr/zZ6N7KA1+FTK7G1LgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHN19uyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHN19uyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC4E1F00A3F;
	Fri, 22 May 2026 10:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779446367;
	bh=4NxXDgmDh5gdIC5I+pvVGey45/SptOwTKY3Xe/oPM8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cHN19uyRm0ruaaAYX1vW4SYPDJL3lao6OM6rC/lqGi2/e015UROFRf8Tm+5uv74Qo
	 RLYnnRSuJo2i+wvSu9qGgfofuey4gOYEpSbNvcu9+NUUQrHRN7h0Q1ejoVj2Gd09fw
	 Q9OITveyzlLV3D7B4JyfbK8DTZHwoRz8ekoE/YlVENh1QHxD64apgYacn+J8UIdQqk
	 GFGE+HU3wllQY0jhbHNuHI3ADgEWdH7HjGj/12xgW8wHpsywFwleuomGOrZ3JIXmVI
	 FixQ30IIm28wQAc9XENDY5Ma8FdhdlVn2/938h5xkP7zuud0JqSPu5ZjYEQ0LqM/+U
	 zNCXvIr+PlCsA==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 55952F4007D;
	Fri, 22 May 2026 06:39:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 22 May 2026 06:39:26 -0400
X-ME-Sender: <xms:XjIQarcPGd0KcLIn7ByKSGmsBvBduZwAoCon-v81S_57tc-ixd-tMw>
    <xme:XjIQau2lM_ONkO2P_VJDU4UKEAqfT5jNsYKLFR6UnwZFZHx-OXB8_DJdbP76oGEBr
    HqSOX0FljYTdgdAoQd2Wuf-8PCPDvOxY_xjfC9-PENRZjpNVpHmKYU>
X-ME-Received: <xmr:XjIQaqFZA8jkRZ6bM-5RB8ZxqdxDgrza4v2o44U6obd0rAuJPstU33eKWQYolQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhn
    vghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeuieejieffkeehfeffffdtkeelfeelhe
    fhfefhudehjeehvdffleeuvddufefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhn
    vghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeegiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgu
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggs
    khgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:XjIQagnjPCEd1HBxfr8_6Dg_JGB53H-2w1mNhd_TH3wkltSn8bMbEw>
    <xmx:XjIQamwQfxnPvHmPnd-idkkMAdTG4CeKkEvXUN_7YewnFPp1yFfBBw>
    <xmx:XjIQajwiMpHAgQ110eV1LQruVLJ0nl0vXEe14pcURqFdruDWfhMrvg>
    <xmx:XjIQag8Kgyk-Z2Q7bDef-xUTwQIyou1bNhATsCS0R9eSOhNQQkB6dg>
    <xmx:XjIQaujUAfXJ9kMzePTYIwGwvI7PVZr9yKB9L3lmklEg8TA1PKP-pUFz>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 06:39:24 -0400 (EDT)
Date: Fri, 22 May 2026 11:39:20 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org, 
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 04/14] mm: add VM_UFFD_RWP VMA flag
Message-ID: <ahAxEW7VcfaVKxN7@thinkstation>
References: <cover.1778254670.git.kas@kernel.org>
 <b47d8d5681fd8730f6090ebfdb72f219a8edef1e.1778254670.git.kas@kernel.org>
 <agNZ-Q7A0rfY66gj@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNZ-Q7A0rfY66gj@kernel.org>

On Tue, May 12, 2026 at 07:48:57PM +0300, Mike Rapoport wrote:
> On Fri, May 08, 2026 at 04:55:16PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Preparatory patch for userfaultfd read-write protection (RWP). RWP
> > extends userfaultfd protection from plain write-protection (WP) to
> > full read-write protection: accesses to an RWP-protected range --
> > reads as well as writes -- trap through userfaultfd.
> > 
> > RWP marks ranges by combining PAGE_NONE with the uffd PTE bit, so
> > the flag is only meaningful when both primitives exist. A new
> > CONFIG_USERFAULTFD_RWP Kconfig symbol auto-selects when CONFIG_64BIT,
> > CONFIG_ARCH_HAS_PTE_PROTNONE, and CONFIG_HAVE_ARCH_USERFAULTFD_WP
> > are all set; call sites that gate on the flag depend on the symbol.
> > Elsewhere VM_UFFD_RWP aliases VM_NONE and every downstream check
> > folds to dead code.
> > 
> > Nothing sets the flag yet.
> 
> And nothing check for it as well, am I right?

Yep.

> Worth noting here, IMHO.

Will do.

>  
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  Documentation/filesystems/proc.rst |  1 +
> >  fs/proc/task_mmu.c                 |  3 +++
> >  include/linux/mm.h                 | 28 +++++++++++++++++----------
> >  include/linux/userfaultfd_k.h      | 31 +++++++++++++++++++++++++-----
> >  include/trace/events/mmflags.h     |  7 +++++++
> >  mm/Kconfig                         |  9 +++++++++
> >  6 files changed, 64 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 98f546e83cd2..fcf308dba311 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -21,10 +21,11 @@
> >  #include <linux/hugetlb_inline.h>
> >  
> >  /* The set of all possible UFFD-related VM flags. */
> > -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> > +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR | \
> > +			 VM_UFFD_RWP)
> 
> Nit: can we keep mode bits together and protection bits together here and
> in the below changes?

Yep, make sense.

> Otherwise looks good to me
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
