Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E63BB9F5;
	Fri, 24 Apr 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030658; cv=none; b=ZeP2Nxtm43kKSj65ASdwrYOenym/rwN8yDUuyZF8No32bgxJyoZ1eO+aWI0WZW7zgG4RG3rU5MTc4h51aiTEu6K2gdLuuZcvgiLyKICoOtMIJ/QzTFsYCkgYOSMSW4JDxH740qhThzgXviGM2plmtVjzaQ7Jz6YDMR2fVMr+B7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030658; c=relaxed/simple;
	bh=pQAkkgwBTm0wMFjEsUuolfLk3Se7Aw+kEEZDfgUAj2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVUlTr/jduy9ar+CxpA1sfRTBB7gTikudGshU8p4zldZysfF77X3nVpH7/H9xamTYi5xgveidcj1TyP2KRS80S6BB/V9dS299b0BZVMGl8nVCKP8z50D6Sp1F4crz1jWzOUIqpc6bqyQEkKuwiC8/yikRd9iI0gJpQGo5RRv3iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzBIP5ab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzBIP5ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41103C2BCB2;
	Fri, 24 Apr 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030658;
	bh=pQAkkgwBTm0wMFjEsUuolfLk3Se7Aw+kEEZDfgUAj2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzBIP5abjjPiZZKk8KmpEKOCx55UR2CcQo4kIqsUQXfA5UyKUBcFG6fL+eKBcY8h+
	 Z/IfrfmDAAZ1oTeJyQgyK7Tne3nUUZDa89ct2P6caB9rXKFqCCe4EcsScpHzDGFzeY
	 ZOr9zDzVzse/BEdiDRVjawbGvPPmtHFoHnJfkatWPHbyZr0JPu6QKpCbMJTeGj3Feh
	 ZyVyaI03ezjru7DS4fm2FbV7yfpGkqG79XotEA98ZaMGW//j2ekaeioZXvojXXT9g9
	 MVCJK/66fQqSt2ToUupcd7+2VDC/LsTQhO8gEr6GA/W3ei3jI14fr6IZXuhXPmP0Tg
	 G9IeHmtC0ynOQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45D00F40068;
	Fri, 24 Apr 2026 07:37:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 24 Apr 2026 07:37:37 -0400
X-ME-Sender: <xms:AVbraWr5w8IN3pcVGoXPYYrMPDysCLNSoP-_ZN9t0HOo2Qko1JiDbg>
    <xme:AVbraT4POzjwfmz4bT4yoZElgbWGQUHeFUgunMRWU2Ng-pHHGGDRmMhmkiPRm26SJ
    sVpYz2SFbvKgtSkjzeY7zEIW244lEasDLHm0ADNoc4lJACEkWDdwWU>
X-ME-Received: <xmr:AVbraXbGXxDYOWhmrT7HaBaIytopftSXGzadskJ8-cynWYp8WJVqyh8cEZsWkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephfffieehtdegkeelkeegkeeijefhieeitdevledujeeuteekgfetveejjeeiteek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrth
    drtghomhdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplh
    hjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvh
    gsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvght
    thesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:AVbraQq9zuliAnRVDPxVtBQJGJxFL_QUAhEOzsJ1QnuDy8699f1iyw>
    <xmx:AVbraY4lWjncW9FwD2xl5yl8EK0PYAnkDSbFag9Yr96vAKFnGgQudA>
    <xmx:AVbraVSwRkroFnFwWJ0ASMKYBKsCFLz4T3EDzFpRp6go0R1lLWqdLA>
    <xmx:AVbraQ2SpbTiy1zowaVMJ8EHvAfhpIeWkeiS40LSPhc1Gdn3NRXYIA>
    <xmx:AVbraU4lHgmjedtxDgLxYgfTvjFaJxZKG-9HWwH7MyOScA--VfxBgiGu>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 07:37:36 -0400 (EDT)
Date: Fri, 24 Apr 2026 12:37:35 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aetHWMZyEEIEzsJZ@thinkstation>
References: <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <17b0dc02-eee3-46d6-9afb-5f81a3a20216@kernel.org>
 <aep8tsYFfr_Xe54q@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aep8tsYFfr_Xe54q@x1.local>

On Thu, Apr 23, 2026 at 04:10:30PM -0400, Peter Xu wrote:
> On Thu, Apr 23, 2026 at 09:25:30PM +0200, David Hildenbrand (Arm) wrote:
> > > 
> > > The other thing is, as I mentioned in the other email, I still don't know
> > > how the current RW protection would work for anonymous.  I don't yet think
> > > the user swapper can read the anon page with RW-protected pgtables.  So far
> > > my understanding is maybe you only care about shmem so it's fine, but it'll
> > > always be great to confirm with you.


That's true. We use vhost and therefore shmem in our setup.

One idea I had about how to make atomic eviction for anon is extending
process_vm_read() and process_madvise():

- Add a flag to process_vm_read() to bypass the protnone check on
  accessible (or only RWP?) VMAs.

- Allow process_madvise(MADV_DONTNEED) when the caller already has
  ptrace write access to the target.

The standing objection to remote DONTNEED has been "destructive", but
process_vm_writev() already lets a ptrace-capable caller overwrite
arbitrary anon with attacker-chosen content. DONTNEED is strictly
weaker — it zeroes, it does not inject — so the trust model is already
established.

> > I wonder if uffdio_move could be used for a swapper implementation instead?

I considered it. UFFDIO_MOVE can in principle relocate the cold folio
into a staging VMA inside the VMM, which then reads it and drops it.
The downside is the VMM has to maintain a second address range and
serialise eviction through it. A purpose-built primitive — something
like UFFDIO_EVICT that zaps the PTE and returns the folio contents
(optionally to an fd for io_uring) — seems cleaner.


> If RW is justified to be useful first, maybe.
> 
> I had a gut feeling Kirill's use case doesn't use anon at all, then if
> nobody needs it we can still decide to not support anon.
> 
> > 
> > If we ever have to read from a protnone page, maybe we could teach ptrace access
> > to do it, or have something that can read from prot_none areas -- like
> > uffdio_copy, which can write to prot-none areas.
> 
> Somethinig like swap_access() in my proposal can also partly achieve that.
> 
> https://lore.kernel.org/all/aYuad2k75iD9bnBE@x1.local/

A maccess()-style primitive that reads through PROT_NONE is a reasonable
building block and overlaps with part of what UFFDIO_EVICT would need.

> There, it was only about reading from swap so far, though.  But that one
> might be easier to be extended to read PROT_NONE and directly put data into
> buffer user specified (ps: in my local tree impl I named it maccess() to
> pair with mincore(), but it doesn't really matter; it doesn't even need to
> be a syscall..).
> 
> To me, the interfacing is not a major issue.  The major question I have is
> why RW protection can help in swap system impl when we already have uffd-wp.
> 
> So I want to make sure the use case can't be implemented by uffd-wp already.
> Because that's really what we might do for QEMU.

Race-free eviction can definitely be implemented with uffd-wp already.
But not proper working set discovery.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
