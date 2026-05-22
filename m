Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640683E9C17;
	Fri, 22 May 2026 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450682; cv=none; b=qdPRfd6RSI50XSdFjjgbUUHvE0TsM78qxA/TEZQ584L3rgy91Hscc7R5VLUiEfLZQSp2wUsLIxsdtqLIzP/GKhJRbXvTka5LLFCJsbDiANqityK54G3f6bILEv/Ur6BWdUsWm7h09B2dcm65ymx+QxfoYeI+CxxtaBj/ybKAdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450682; c=relaxed/simple;
	bh=muRkgjwO38S4SXvbIs3kFYWkJf7gwztLqAjDhEqnass=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcWBs1Dzc3+KJ4pLQCi9yMGTR4t1HGkZPjFH2KmpDynxs2khANehqZ69Cd36pwsmcljLz3IMWLpqC9CtndBC5/IV7Wu/716DD5DBQhdrp8zIQDeoE3P3Yq28LdCg6Bn+NLz5q0nLwHTuLkDEGdI1Y0fgNyUw3nooaVkTj9ShC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8r39tsU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8r39tsU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5665E1F000E9;
	Fri, 22 May 2026 11:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450681;
	bh=Mb5pSbbAGYerWjfqxHgQXJ81h4yET5l0OQn5Vn752FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8r39tsUOsZiZ3xrUObs85x2llNabxk3JqGSy/bSRJ5TsRAjJeLz57TkjBx+Pytna
	 pf55Q+YHegd9pM3Ba7moftSh6I3sZSA2pQNsooV8t4yK4D4qq/9QwJ3EgKFWkWP/ds
	 vyDEvP3KVKp1OCtruDrhNAvAnlt0pe9n3HNJsAr07ONV6iAPXIIukSqqJTSvMrlURg
	 i5WmYJSMCHlQ3sfPOSBM6ZFMibKRsSol5ebrTLaJUd/UjXn8/davE0J1vqxpnqgZrP
	 SxIGYLdIKXsGxKnYeTKwUM3c/hIUn51MB6P5vG+tpXgX3IVgZKcE8bCumT2zpgsZ7k
	 NNgHjyso4sfCw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE3E0F40068;
	Fri, 22 May 2026 07:51:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 07:51:19 -0400
X-ME-Sender: <xms:N0MQapH0gLwDJI__35OKvJth67Ha3nR1wdvsv1zLJL3IWZtweRMw1Q>
    <xme:N0MQanUtxak6SesOPQP3HgcrreB0y8_Xd-dUWqXkHPGdn2yl0GjeMBc4dR8C3r-Wi
    DFgQ3vM_Kgq-ECvNFJNfIwTTU1PGGhhdQTqHkElWB9gH9D8B8w1Wg>
X-ME-Received: <xmr:N0MQak2MhIRZ3lgbP8ND-jp0bHJkZdymfONgudbUgPZJEUx7QW0_TrHSQMiAHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedttdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:N0MQamA6xcPZ2enBG8ATaG1l-44q1U1b_Z8XaC_Y2QWUsJ1Y3MXkLw>
    <xmx:N0MQaiA3s1_YF5dn0lHOrYYa6j-OO5im0VQ1yezOxMfjFu-5krD6_Q>
    <xmx:N0MQaiPHbQnKG_OjOoKC56SQXRkxrPjnxVyHri_a-3dZjsLGi964ug>
    <xmx:N0MQamxORNj8tqUVmusmgUUfz6gouopBZbkbrfW_Gf6roJKMWYB2KA>
    <xmx:N0MQaumlmq4j3in0tsehuAZz0iXPYkizdPmSpbAz-_qNRiDf7e-0-V3N>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 07:51:18 -0400 (EDT)
Date: Fri, 22 May 2026 12:51:16 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org, 
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 09/14] mm/userfaultfd: add RWP fault delivery and
 expose UFFDIO_REGISTER_MODE_RWP
Message-ID: <ahBDF8JMCEIuT-Xa@thinkstation>
References: <cover.1778254670.git.kas@kernel.org>
 <454b3381cb7ead65291b2d7e24c0bff62e55c41b.1778254670.git.kas@kernel.org>
 <agNjXmuEHSaWKrv9@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNjXmuEHSaWKrv9@kernel.org>

On Tue, May 12, 2026 at 08:29:02PM +0300, Mike Rapoport wrote:
> On Fri, May 08, 2026 at 04:55:21PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Wire the fault side of read-write protection tracking and turn the
> > userspace interface on.
> > 
> > An RWP-protected PTE is PAGE_NONE with the uffd bit set. The
> > PROT_NONE triggers a fault on any access; the uffd bit distinguishes
> > it from plain mprotect(PROT_NONE) or NUMA hinting.
> > 
> > Fault dispatch, per level:
> > 
> >   PTE     handle_pte_fault()    -> do_uffd_rwp()
> >   PMD     __handle_mm_fault()   -> do_huge_pmd_uffd_rwp()
> >   hugetlb hugetlb_fault()       -> hugetlb_handle_userfault()
> > 
> > The RWP branches gate on userfaultfd_pte_rwp() / userfaultfd_huge_pmd_rwp()
> > (VM_UFFD_RWP plus the uffd bit) and fall through to do_numa_page() /
> > do_huge_pmd_numa_page() otherwise. Each delivers a
> > UFFD_PAGEFAULT_FLAG_RWP message through handle_userfault(); the handler
> > resolves it with UFFDIO_RWPROTECT clearing MODE_RWP.
> > 
> > userfaultfd_must_wait() and userfaultfd_huge_must_wait() add matching
> > protnone+uffd waiters so sync-mode fault handlers block correctly.
> > 
> > Expose the UAPI:
> > 
> >   UFFDIO_REGISTER_MODE_RWP   -> UFFD_API_REGISTER_MODES
> >   UFFD_FEATURE_RWP           -> UFFD_API_FEATURES
> >   _UFFDIO_RWPROTECT          -> UFFD_API_RANGE_IOCTLS
> >                                 UFFD_API_RANGE_IOCTLS_BASIC
> > 
> > UFFD_FEATURE_RWP is masked out at UFFDIO_API time when PROT_NONE is
> > not available or VM_UFFD_RWP aliases VM_NONE (32-bit), so userspace
> > never sees an advertised-but-broken feature.
> > 
> > Works on anonymous, shmem, and hugetlb memory.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> 
> A small nit below, other than that
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

> > @@ -347,6 +359,14 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
> >  	 */
> >  	if (!pte_write(ptent) && (reason & VM_UFFD_WP))
> >  		goto out;
> > +	/*
> > +	 * PTE is still RW-protected (protnone with uffd bit), wait for
> > +	 * userspace to resolve. Plain PROT_NONE without the marker is not
> > +	 * an RWP fault.
> > +	 */
> > +	if (pte_protnone(ptent) && pte_uffd(ptent) &&
> > +	    (reason & VM_UFFD_RWP))
> 
> Nit: this fits even in 80-chars line

Ack.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
