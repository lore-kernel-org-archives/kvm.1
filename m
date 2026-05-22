Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25F38F251
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453477; cv=none; b=mcAssCUqKeiwS4iTnOF82s6MDkSp+MZefLTCh6VaVV4nGJdEk7IV0p3NtsroiSZ/Z9isQY+dOP+P9+JEzsEfch/+8ITJRKWGVAOHw70PwZFwye02GnHRVnYltyakk0HtpzA66OMhnO0uB9K0/ghWhNHpvuQWQ5zkO+dkJpHFv6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453477; c=relaxed/simple;
	bh=1dYX8tbLLyGkhDsYQMCL1WiRzG/6nIwJxxVuUr18V3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/j1GzO22L052H/Dd+FcPD+8xjeioPsp8YuGkbaQCXSWvoBTmLFb0D8YcyutsLys7yIYkySDY/HHfCMkZNRuEoZJuzxktErnTJNhCRAMMMGEg1fTBIhfEopzybmWPd53Lqbo1fhKFcoPiZEQKyvPD9fzxe4OZPs3OLmoP3F2RkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJA7Ko6M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJA7Ko6M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8411F00A3E;
	Fri, 22 May 2026 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453474;
	bh=oiJv/a8IQvKH3BGEIllrwFReWEQqkFFSGDh6mgtKt0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WJA7Ko6MEnn/NoFQ65dN1/M8ZExiJ8RoGFC656Dd+5KAHsEI9+U9A6OZLTONMFbsw
	 tIcZw2dbzydgoAb2nNDFzgAnIa9WHQL5usPWgbDf7hjEdGHPcoMKBeFoEirX5A8pmJ
	 ++dqGyVU3992xYuBmJbB3lUCrzfbX3bv3mkb2QxRAVM8D+a6eIp4cSjeD1LYSFLVbt
	 7Uc9z8L9JX2JVczmO8z4BsgP9yfQISz6JGBbf8QnqX41pbtp5WwAfQJI5qDHSGy7ql
	 Vs2g5fwJx5y42SZbgMFgjrI+t04zWsIc670pSnjHrsiQNuvYtirMevCR5OFH2pzEcC
	 S6U+pyJ7WJDJA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3CE66F40089;
	Fri, 22 May 2026 08:37:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 08:37:53 -0400
X-ME-Sender: <xms:IU4QaphcTgCOcXPDNUt_nU2yvQjDK1DSI5aLupDUWdyiUIP4dQU-4A>
    <xme:IU4QarqHY9EXT-cMd_Yb4B8Z6Vfh07DrBKfo76qpyv_lguSTG4xL0TwSiGFRTwUSW
    a6_wpWSM2V9fUugVLQiNr5mJzi1JGNfIva61MQGnPywtXp6IFeIn_uH>
X-ME-Received: <xmr:IU4QauqrQFYvgB7RUMJQ9bvgzYGn68sFNbAuV1EfSfCLLEk3QTrEMLpE6fbjhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomhepmfhirhihlhcuufhhuhhtshgvmhgruhcuoehkrghssehkvghr
    nhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepiefgvddtkeevjefhhedtudeuueeike
    ejkedvgffgtdekgeeiveejvdegtedvhefgnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvghr
    nhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepgeeipd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprh
    gtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhi
    ugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsggr
    sghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthhtse
    horhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:IU4Qah6CkvLPQpsYe3YHk8keE6O6mSJBIUzG29b5c9n-vbt1f0DrUQ>
    <xmx:IU4Qal2qPAW53qP3BFrBIcKEsvbumY4Ft0Fv0lpYzmEbtWoFHk0z9Q>
    <xmx:IU4QatkzZzFw_sbV_Vq6K-aF99ZCGWjQNWu0Wmkva9773VHZfhqIsw>
    <xmx:IU4QauiXqnAnp1CnDIsvgg4CDgPdcglFJ35pWva-S2styYPJYqXDLQ>
    <xmx:IU4Qak0wVrxnos-gIhB6hx6oacQXSfR35IiG2bd6-lIRpSHDEvwgQrKj>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 08:37:52 -0400 (EDT)
Date: Fri, 22 May 2026 13:37:51 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org, 
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 14/14] Documentation/userfaultfd: document RWP working
 set tracking
Message-ID: <ahBMtyua-5v8GyxS@thinkstation>
References: <cover.1778254670.git.kas@kernel.org>
 <0b6f87fd4809245f9eebee73f34e2fb14230330c.1778254670.git.kas@kernel.org>
 <agQZiTUQNviaGIim@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agQZiTUQNviaGIim@kernel.org>

On Wed, May 13, 2026 at 09:26:17AM +0300, Mike Rapoport wrote:
> On Fri, May 08, 2026 at 04:55:26PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Add an admin-guide section covering UFFDIO_REGISTER_MODE_RWP:
> > 
> >   - sync and async fault models;
> >   - UFFDIO_RWPROTECT semantics;
> >   - UFFD_FEATURE_RWP_ASYNC;
> >   - UFFDIO_SET_MODE runtime mode flips.
> > 
> > It also covers typical VMM working-set-tracking workflow from detection
> > loop through sync-mode eviction and back to async.
> 
> We'd also need man page update at some point :)

Will add a patch for man-pages in v3.

> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> > ---
> >  Documentation/admin-guide/mm/userfaultfd.rst | 226 ++++++++++++++++++-
> >  1 file changed, 220 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
> > index 1e533639fd50..5ac4ae3dff1b 100644
> > --- a/Documentation/admin-guide/mm/userfaultfd.rst
> > +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> > @@ -275,16 +275,16 @@ tracking and it can be different in a few ways:
> >    - Dirty information will not get lost if the pte was zapped due to
> >      various reasons (e.g. during split of a shmem transparent huge page).
> >  
> > -  - Due to a reverted meaning of soft-dirty (page clean when uffd-wp bit
> > -    set; dirty when uffd-wp bit cleared), it has different semantics on
> > -    some of the memory operations.  For example: ``MADV_DONTNEED`` on
> > +  - Due to a reverted meaning of soft-dirty (page clean when the uffd bit
> > +    is set; dirty when the uffd bit is cleared), it has different semantics
> > +    on some of the memory operations.  For example: ``MADV_DONTNEED`` on
> >      anonymous (or ``MADV_REMOVE`` on a file mapping) will be treated as
> > -    dirtying of memory by dropping uffd-wp bit during the procedure.
> > +    dirtying of memory by dropping the uffd bit during the procedure.
> >  
> >  The user app can collect the "written/dirty" status by looking up the
> > -uffd-wp bit for the pages being interested in /proc/pagemap.
> > +uffd bit for the pages being interested in /proc/pagemap.
> >  
> > -The page will not be under track of uffd-wp async mode until the page is
> > +The page will not be under track of userfaultfd-wp async mode until the page is
> >  explicitly write-protected by ``ioctl(UFFDIO_WRITEPROTECT)`` with the mode
> >  flag ``UFFDIO_WRITEPROTECT_MODE_WP`` set.  Trying to resolve a page fault
> >  that was tracked by async mode userfaultfd-wp is invalid.
> > @@ -307,6 +307,220 @@ transparent to the guest, we want that same address range to act as if it was
> >  still poisoned, even though it's on a new physical host which ostensibly
> >  doesn't have a memory error in the exact same spot.
> >  
> > +Read-Write Protection
> > +---------------------
> > +
> > +``UFFDIO_REGISTER_MODE_RWP`` enables read-write protection tracking on a
> > +memory range. It is similar to (but faster than) ``mprotect(PROT_NONE)``
> > +combined with a signal handler; unlike ``mprotect(PROT_NONE)``, RWP only
> > +traps accesses to *present* PTEs, so accesses to unpopulated addresses in a
> > +protected range fall through to the normal missing-page path. It uses the
> > +PROT_NONE hinting mechanism (same as NUMA balancing) to make pages
> > +inaccessible while keeping them resident in memory. Works on anonymous,
> > +shmem, and hugetlbfs memory.
> > +
> > +This is designed for VM memory managers that need to track the working set
> 
> This feature? Or RWP mode?

RWP.

> > +of guest memory for cold page eviction to tiered or remote storage.
> > +
> > +**Setup:**
> > +
> > +1. Open a userfaultfd and enable ``UFFD_FEATURE_RWP`` via ``UFFDIO_API``.
> > +   Optionally request ``UFFD_FEATURE_RWP_ASYNC`` as well — it requires
> > +   ``UFFD_FEATURE_RWP`` to be set in the same ``UFFDIO_API`` call.
> > +
> > +2. Register the guest memory range with ``UFFDIO_REGISTER_MODE_RWP``
> > +   (and ``UFFDIO_REGISTER_MODE_MISSING`` if evicted pages will need to be
> > +   fetched back from storage).
> > +
> > +**Feature availability:**
> > +
> > +RWP is built on top of two kernel primitives: a spare PTE bit owned by
> > +userfaultfd (``CONFIG_HAVE_ARCH_USERFAULTFD_WP``) and arch support for
> 
> Please spell out architecture.

Ack.

> > +present-but-inaccessible PTEs (``CONFIG_ARCH_HAS_PTE_PROTNONE``). When both
> > +are available on a 64-bit kernel, the build selects
> > +``CONFIG_USERFAULTFD_RWP=y`` and the ``VM_UFFD_RWP`` VMA flag becomes
> > +available.
> > +
> > +``UFFD_FEATURE_RWP`` and ``UFFD_FEATURE_RWP_ASYNC`` are masked out of the
> > +features returned by ``UFFDIO_API`` when the running kernel or architecture
> > +cannot support them — for example 32-bit kernels (where ``VM_UFFD_RWP`` is
> > +unavailable), kernels built without ``CONFIG_USERFAULTFD_RWP``, and
> > +architectures whose ptes cannot carry the uffd bit at runtime (e.g. riscv
> > +without the ``SVRSW60T59B`` extension). ``UFFDIO_API`` does not fail;
> > +unsupported bits are simply absent from ``uffdio_api.features`` on return.
> > +VMMs should inspect the returned ``features`` after ``UFFDIO_API`` and fall
> 
> Lets s/VMM/Callers/.
> Although RWP is designed for VMMs, it's not limited to them and I expect
> other use-cases will be coming along.

Okay.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
