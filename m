Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBC2EBDFA;
	Tue, 14 Apr 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186536; cv=none; b=E9HyQcXDpY2SouT7rIO1dLi2RkTfSX0zEU1rb6/aYqB2xpCmtIsg1k7vr4ofgiOKrgaUsz3mdylXpazNFJqlRZLh//jlLDZaBQ+IZxfWlHdWx3HLckxqy5Y+vYT4XRS54q/OZfWcQQwt3dBVd0Z+lGdRX49EnXPBJXLWyOIQBGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186536; c=relaxed/simple;
	bh=lY453RX44XTTijXgcD4/68oGGZh9i3h/OJ7n5a/GWCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXQHlil2tHJrq1H6E5J4cCJazfkH40iyeMIj+BhdSODVOouOv2hTNLMtJcV2Qkd69yPk7p/SxqjA5Wn9k4pyqHT/3C3pYBlgAHVI1yeqXKHxfulTWpDsqBL8QEgT0asUHAXmJK9uVqry+ERrOYnTNbNs7m2Uwx4v6Gl+VaCzekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9JME4SK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9JME4SK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621BAC19425;
	Tue, 14 Apr 2026 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186536;
	bh=lY453RX44XTTijXgcD4/68oGGZh9i3h/OJ7n5a/GWCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9JME4SKocoX0IMhmlHkJJ4CQ8hoNCcqL4GB7WmwUvNaRGpFuo+Qjh459rDgHpHo+
	 zvNmZxXqb24eARm6FCiUKvqQRHhznUOJYNxVNqog9PwwL0qEdtdRpwTdpkeZjAs4+5
	 JwB8ImtxpWwvlBKo1myMhTDOzv5FB5gFfxMBwG7KzMDYKDcZeyEv2sGfQfXUjOp43k
	 cdsbLQrMq39OGjaJlSFagWQGsWZB7Y+rB0zjuDYpFv4xKbnm+GefsWhxZSC+9ZQJqe
	 N/97CfefbRQw7a2Yrh/w9BpFFuD5PF/AGgUYZfpB18P8a02DGZNVg3NgLpgc25O6Ty
	 KOMwJoxGT3jSw==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C69FF40068;
	Tue, 14 Apr 2026 13:08:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Apr 2026 13:08:54 -0400
X-ME-Sender: <xms:pnTeaQmLG9t6qa3ZW6ayk6yh91cIQtUng0jt-yAAsSd6_36m0eyg8w>
    <xme:pnTeabT6Ic7G1IyFxqV0XWZymi9S6Ls3MlocSFq2Cy0BCLK1ry_U00QR2puhYK96x
    KJ4tRoJSLWdna53zDxdOb4tAqNLDQYxBc9Co4xqh6x0ruEOu1dUqhA>
X-ME-Received: <xmr:pnTeaSMMPlJju5y0M4zMCt3becLX0m3LjXujYuz8JoXyF2AdbuUMPSuYyiYkog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvgfdtffejheffleegffetffehkeekteeiheefkeehueejfefhiefhhfdvheeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeegge
    ejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhn
    sggprhgtphhtthhopeegtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvth
    gvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhpphht
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnh
    hvihguihgrrdgtohhm
X-ME-Proxy: <xmx:pnTeaVm8nSBwwzP2sjjkOFZ-FrMo08HgCYElnWaEJjk8kV2OY0TIqQ>
    <xmx:pnTeab-Q4K6SfrNXkq5MKQxSIFWWCb5pBCYijkoX8UIr3qTVlWUpZQ>
    <xmx:pnTeaSDiatwTb6x-Kc3OBlZ6soFjgSEAEbsCXqTL_SQRor5WqUOqXQ>
    <xmx:pnTeaQj4vVipxSChMMzwijHcAIfsmiAZcEbdgniTE5s1L9PtmTO-Tw>
    <xmx:pnTeaWMAyuBorncANJklQ_LNIMqJTPdr87xxnnUhBDt2n63IiOXQ3v8X>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:08:52 -0400 (EDT)
Date: Tue, 14 Apr 2026 18:08:48 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <ad5hAVuRwa_0VNPf@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <ad5dIUpAMs4MuBvV@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5dIUpAMs4MuBvV@x1.local>

On Tue, Apr 14, 2026 at 11:28:33AM -0400, Peter Xu wrote:
> Hi, Kiryl,
> 
> On Tue, Apr 14, 2026 at 03:23:34PM +0100, Kiryl Shutsemau (Meta) wrote:
> > This series adds userfaultfd support for tracking the working set of
> > VM guest memory, enabling VMMs to identify cold pages and evict them
> > to tiered or remote storage.
> 
> Thanks for sharing this work, it looks very interesting to me.
> 
> Personally I am also looking at some kind of VMM memtiering issues.  I'm
> not sure if you saw my lsfmm proposal, it mentioned the challenge we're
> facing, it's slightly different but still a bit relevant:
> 
> https://lore.kernel.org/all/aYuad2k75iD9bnBE@x1.local/

Thanks will read up. I didn't follow userfultfd work until recently.

> Unfortunately, that proposal was rejected upstream.

Sorry about that. We can chat about in hall track, if you are there :)

> > == VMM Workflow ==
> 
> AFAIU, this workflow provides two functionalities:
> 
> > 
> >     UFFDIO_DEACTIVATE(all)            -- async, no vCPU stalls
> >     sleep(interval)
> >     PAGEMAP_SCAN                      -- find cold pages
> 
> Until here it's only about page hotness tracking.  I am curious whether you
> evaluated idle page tracking.  Is it because of perf overheads on rmap?

I didn't gave idle page tracking much thought. I needed uffd faults to
serialize reclaim against memory accesses. If use it for one thing we
can as well try to use it for tracking as well. And it seems to be
fitting together nicely with sync/async mode flipping.

> To
> me, your solution (until here.. on the hotness sampling) reads more like a
> more efficient way to do idle page tracking but only per-mm, not per-folio.
> 
> That will also be something I would like to benefit if QEMU will decide to
> do full userspace swap.  I think that's our last resort, I'll likely start
> with something that makes QEMU work together with Linux on swapping
> (e.g. we're happy to make MGLRU or any reclaim logic that Linux mm
> currently uses, as long as efficient) then QEMU only cares about the rest,
> which is what the migration problem is about.
> 
> The other issue about idle page tracking to us is, I believe MGLRU
> currently doesn't work well with it (due to ignoring IDLE bits) where the
> old LRU algo works.  I'm not sure how much you evaluated above, so it'll be
> great to share from that perspective too.  I also mentioned some of these
> challenges in the lsfmm proposal link above.
> 
> >     UFFDIO_SET_MODE(sync)             -- block faults for eviction
> >     pwrite + MADV_DONTNEED cold pages -- safe, faults block
> >     UFFDIO_SET_MODE(async)            -- resume tracking
> 
> These operations are the 2nd function.  It's, IMHO, a full userspace swap
> system based on userfaultfd.

Right. And we want to decide where to put cold pages from userspace. 

> Have you thought about directly relying on userfaultfd-wp to do this work?
> The relevant question is, why do we need to block guest reads on pages
> being evicted by the userapp?  Can we still allow that to happen, which
> seems to be more efficient?  IIUC, only writes / updates matters in such
> swap system.

But we do care about about read accesses. We don't want to swap out
pages that got read-touched. And we cannot in practice switch to WP mode
after PAGEMAP_SCAN: it would require a lot of UFFDIO_WRITEPROTECT calls
with TLB flushing each.

With my approach switching tracking and reclaiming is single bit flip
under mmap lock.

> Also, I'm not sure if you're aware of LLNL's umap library:
> 
> https://github.com/llnl/umap
> 
> That implemnted the swap system using userfaultfd wr-protect mode only, so
> no new kernel API needed.

Will look into it. Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
