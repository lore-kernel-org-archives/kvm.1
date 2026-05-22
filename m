Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C45B356756;
	Fri, 22 May 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447287; cv=none; b=LvQMkq1ufZNIt9hSFVa1mzkQGojmUQsxlIGs1t9uaxzfARtc7GoGVQtyNJFJoyQgSr5yOcenFXSrdBbZ3o11+NgS60Xt3iKn6sn0zE0lkHnBPJ9oMEK65cDRhTOUssqcXXxmOPY1+2wJANN+zn3Yod1iD6bULEhu94of8ek0ZJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447287; c=relaxed/simple;
	bh=b3P2hBjSQh19IUuIUM2fF0JGVEHnP7/F+/Pk0IYDPiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLbw9phdb18zyiRNKpD8iMztnowjAnjTvQ0+yWgPnQ5iS/FNUEwk7UfLHnfxPOuI/iAdNmFajG7sB9OeTxC5YFgk3iUkYgWg4aACFHbLlz6K+1cKxnuQdEBYApexCNWhXfGk9O9UVzHT0H+OnE+m5hRyjctdtkJ6NcUBmdPghlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcayLb8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcayLb8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB61F00A3E;
	Fri, 22 May 2026 10:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779447286;
	bh=I485ulN9sXiuaxr3hxPza2zN7Bv6l4bsoi/xIZYLS2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fcayLb8mD9Bodq9rqnJKCW5J/CYwMkGahp883O2LFlT7soZPV8M3KIGbp3jrIiFMp
	 kIIiJbrpRj8pc7ZhCAcZ0Qzqqhjp/1G5xc1j8E+scvDoy1aIfkxKzG+zJUlonHhs3o
	 Md4jR7za4bQkYIOA1c9aku3LIY8YRaum4vvVb8AO1193uC/ZvAt2nZNIlftNcIYO1d
	 7mBMNZISoTGnxzj6kZYrR2AwJ3invVFqui8UKCJAALyz/qtajJRfmdliTOGJAscYQV
	 SU/24I0DnSXW8jvOayHuuFzW2HNQ3QUcZmvs71lYpuqjRodehb1jJI5SCnuMN4OZYO
	 KixTHkG7OfGqQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAAF0F4007C;
	Fri, 22 May 2026 06:54:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 06:54:44 -0400
X-ME-Sender: <xms:9DUQatKIw8pHtuL_uqOaivYUQcb6w8lDWDXW4u2T4qRJnm98l2gfiQ>
    <xme:9DUQaiKzPJe6e9bA5ywcoJ5ZRy-ppHZ2O5X-CHMV23TgVx94H6cZSLVahiyeltw2R
    IhajtMUfA0Hs3m8RqK1WuIusqANdavHKiMZPeSLe8TzWkcoazhAIw>
X-ME-Received: <xmr:9DUQavbk_UOPlqFSDOiCbSnF83Zth4S2PpnwOncelc7CbcknO2le0z71kCk3CA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhn
    vghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeuieejieffkeehfeffffdtkeelfeelhe
    fhfefhudehjeehvdffleeuvddufefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhn
    vghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeegiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshhjsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:9DUQalXQ45nNeLCORY2mKnQqw6SnE982YJ4qYQ2t6SoOeMI2y0BbBg>
    <xmx:9DUQanEuT7mr9cBWathBzxbeRi39QSnTdc0DqsHOhyvnzvLZtl0uyA>
    <xmx:9DUQaqDatI1DSjaKH9-vRnSfjvKFSWa1lGXfYaszChiPPIrjcIbqnQ>
    <xmx:9DUQaqXoRWOs6Pe2jV5X2u3ECEO_XG2VZUU8UrJ5LBmWlfWPZQSSHg>
    <xmx:9DUQai6GZOnuhag9McN737qpIDRxxOugkk-glWd-hou_D78sncHzieP5>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 06:54:43 -0400 (EDT)
Date: Fri, 22 May 2026 11:54:41 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 04/14] mm: add VM_UFFD_RWP VMA flag
Message-ID: <ahAzY0CKNzE-SOd2@thinkstation>
References: <b47d8d5681fd8730f6090ebfdb72f219a8edef1e.1778254670.git.kas@kernel.org>
 <20260515002932.124892-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515002932.124892-1-sj@kernel.org>

On Thu, May 14, 2026 at 05:29:31PM -0700, SeongJae Park wrote:
> On Fri,  8 May 2026 16:55:16 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:
> 
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
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> 
> A silly but loud thought.  Would it make more sense to put Signed-off-by: after
> Assisted-by: ?

I am not sure. I see it both ways in git log. And I don't have strong
opinion on the order here. Keeping as is.

> > ---
> >  Documentation/filesystems/proc.rst |  1 +
> >  fs/proc/task_mmu.c                 |  3 +++
> >  include/linux/mm.h                 | 28 +++++++++++++++++----------
> >  include/linux/userfaultfd_k.h      | 31 +++++++++++++++++++++++++-----
> >  include/trace/events/mmflags.h     |  7 +++++++
> >  mm/Kconfig                         |  9 +++++++++
> >  6 files changed, 64 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index db6167befb7b..db28207c5290 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -607,6 +607,7 @@ encoded manner. The codes are the following:
> >      um    userfaultfd missing tracking
> >      uw    userfaultfd wr-protect tracking
> >      ui    userfaultfd minor fault
> > +    ur    userfaultfd read-write-protect tracking
> 
> Yet another silly but loud thought.  My first feeling on this was that this
> reads like 'u'serfaultfd 'r'ead-protect.  And was further thinking 'uf' for
> just 'u'seffaultfd 'f'ault or 'up' for 'u'serfault-'p'rotect might make sense.
> But ended up thinking this is too trivial and ain't really matter.

I will keep it. It's "u" + the first distinguishing letter of the mode
name. r distinguishes RWP from WP cleanly.

> [...]
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index e8bf1e9e6ad9..ccf534a8cbc9 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1347,6 +1347,15 @@ config HAVE_ARCH_USERFAULTFD_MINOR
> >  	help
> >  	  Arch has userfaultfd minor fault support
> >  
> > +config USERFAULTFD_RWP
> > +	def_bool y
> > +	depends on 64BIT && ARCH_HAS_PTE_PROTNONE && HAVE_ARCH_USERFAULTFD_WP
> > +	help
> > +	  Userfaultfd read-write protection (UFFDIO_RWPROTECT) delivers a
> 
> Seems UFFDIO_RWPROTECT will be introduced later.  Would it make more sense to
> add this config together with the patch?


Okay, I will move later in the patchset.

> > +	  userfaultfd notification on every access -- read or write -- to a
> > +	  protected range, letting userspace observe the working set of a
> > +	  process.
> > +
> >  menuconfig USERFAULTFD
> >  	bool "Enable userfaultfd() system call"
> >  	depends on MMU
> > -- 
> > 2.51.2
> > 
> > 
> 
> None of my comments is a blocker.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
