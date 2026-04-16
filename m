Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0213D3338
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347364; cv=none; b=bDslN/RGLikzFatB6XkDIMrs0P45/241Tk9T4e8JG4Q2knGY6wxUXQfrywlfC1ttr4DOu7vZ245zf5rqIEx1+wEgDdrfDZmUApiJ/POIx31ICcSo/gOfqPV1n+GX/KIRfn85E6TpnXWRkngx6PlyDUy7tY0yJYwCsmtnQG/oQ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347364; c=relaxed/simple;
	bh=s3RYvsEfI9ZdxhsabL5/svtqvt3W5lr9R3yghTmr/gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7aLUMrjCyDNWwaBqvR4YH7afctyod7OpCmDPCPYdoV1lf+skfeYOM47eJANTaTsyfuyZvhN3K7xacj7TvqKkLZ5gR3jrCplioKhOE3gzXnGnC3R1N6/pZDfCD4ASaOgWOETr7OuK+PF82PHbE1s4TEhkP74j0LIVIFgpV6+dJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqlOLz/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqlOLz/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6DFC2BCAF;
	Thu, 16 Apr 2026 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347363;
	bh=s3RYvsEfI9ZdxhsabL5/svtqvt3W5lr9R3yghTmr/gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AqlOLz/HXz7hqXJps/IG3FaK45yw4Z0YqpDgxczLEUlMgLP/IaXrmJbUuoShfRQLv
	 vftvKRCapRZ2NnHiAPar2EyWyd1TLgt1Ko3HP26W9UXE3KJe6nOTTqAu5ayiqwWDuc
	 XpRqOEFJHtFkpoOhcRVFGqeTGm9UPhn1W3sRBs3gJTk8qtriK2XhdZZeKMO8eAnMRX
	 RrWZK4z6KQSDAFWR9ri0eyK6s9sh+oS1BWmgHMXfV+x8F0JKGr4LT1pzYeU6dSS+QX
	 NTH+dc5QJnfsEaf5J7JTMdMnLxrBMEYV49XhLFbHvE6l6N4y5OIU6WW/oMpYggnVxf
	 X/zDR59vHkmWA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 10D1DF4006A;
	Thu, 16 Apr 2026 09:49:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Apr 2026 09:49:22 -0400
X-ME-Sender: <xms:4ejgaSIYoDKvzxgPhCYw9DPRyWu3jwC0TpDUBp2Y_WPBEvYW4NkgmQ>
    <xme:4ejgaZZzLX6dOeyn967dwC6gkgLyv9vcgNA6uPCwoD_vHRVb7RcfCwDmoAjJ9YVqE
    08pcZZq3c1LOn1mJr8ufEayJfWseVOwMDmPX8U7mXRxDeX49F70Dak>
X-ME-Received: <xmr:4ejgae6P2292B6joISlFkUr1uSQIblLQ826adWwScn_jixogzy7A9WlfZMDvEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgeehudelheevjefftdeuheegudfhieeutdegjedukeefffeugeevvefhteejuefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeef
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhr
    ghdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplh
    hjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvh
    gsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvght
    thesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:4ejgaSJVJZNJGoZKWD6T5M5NCXLkDUW8HAqvk7UxjtI2XNWxSUR8Nw>
    <xmx:4ujgacZ3_iV3ApOrNQMeV55o3dk_kAFG7wtgo-r3D52O-xdB1xB3sg>
    <xmx:4ujgaSwCvAmjEpSOSI1Euf8uiFljZZ1F2wZxHEPu8tpaRo64t5cn4w>
    <xmx:4ujgaQV7QWSdaLPXVIHy_TozBtgAeyudvkqy14pgSHWIZEzajtLLfQ>
    <xmx:4ujgaeYmb7YFAUc8ewO2iFBH8S_30cSSVTvrTPJ_T_QqPAxdKtfbGI7L>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 09:49:20 -0400 (EDT)
Date: Thu, 16 Apr 2026 14:49:14 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aeDoqFWPFxkkNB26@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad50rPOseVa-SP_s@thinkstation>

On Tue, Apr 14, 2026 at 06:10:44PM +0100, Kiryl Shutsemau wrote:
> On Tue, Apr 14, 2026 at 05:37:50PM +0200, David Hildenbrand (Arm) wrote:
> > On 4/14/26 16:23, Kiryl Shutsemau (Meta) wrote:
> > > This series adds userfaultfd support for tracking the working set of
> > > VM guest memory, enabling VMMs to identify cold pages and evict them
> > > to tiered or remote storage.
> > > 
> > > == Problem ==
> > > 
> > > VMMs managing guest memory need to:
> > > 1. Track which pages are actively used (working set detection)
> > > 2. Safely evict cold pages to slower storage
> > > 3. Fetch pages back on demand when accessed again
> > > 
> > > For shmem-backed guest memory, working set tracking partially works
> > > today: MADV_DONTNEED zaps PTEs while pages stay in page cache, and
> > > re-access auto-resolves from cache. But safe eviction still requires
> > > synchronous fault interception to prevent data loss races.
> > > 
> > > For anonymous guest memory (needed for KSM cross-VM deduplication),
> > > there is no mechanism at all — clearing a PTE loses the page.
> > > 
> > > == Solution ==
> > > 
> > > The series introduces a unified userfaultfd interface that works
> > > across both anonymous and shmem-backed memory:
> > > 
> > > UFFD_FEATURE_MINOR_ANON: extends MODE_MINOR registration to anonymous
> > > private memory. Uses the PROT_NONE hinting mechanism (same as NUMA
> > > balancing) to make pages inaccessible without freeing them.
> > 
> > I would rather tackle this from the other direction: it's another form
> > of protection (like WP), not really a "minor" mode.
> > 
> > Could we add a UFFDIO_REGISTER_MODE_RWP (or however we would call it)
> > and support it for anon+shmem, avoiding the zapping for shmem completely?
> 
> I like this idea.
> 
> It should be functionally equivalent, but your interface idea fits
> better with the rest.
> 
> Thanks! Will give it a try.

Here is an updated version:

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/log/?h=uffd/rfc-v2

will post after -rc1 is tagged.

I like it more. It got substantially cleaner.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
