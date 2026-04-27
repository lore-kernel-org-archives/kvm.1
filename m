Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922393B0ACD;
	Mon, 27 Apr 2026 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777287159; cv=none; b=MUzq7F2XPwgjK0SYRTHxeerG/VzhL+p67Hq/Mvq0nlu2ldKOIunFDT7fVe5HGfv5uDeknyvdZtF43aTYbmAqWqgzTu5/dW2eXnzqtTxz6PKsyIlXZfCpI1ToFkB54ckosfE60B1CP7zRT1axsSY96SBhN7CLYcTKUXR/ZgVwsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777287159; c=relaxed/simple;
	bh=IDtaj8qDPCoKLn7FLT5h06j/NwN3NbNxb5XhN240DSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdpogLlSzymZRmCsGCmiw9FzH4aHwuPMed7I0ENoHJXq0ezLuD/w9LG23v1urm9c9wrKL4iAjLrybouJxoykVWUNDYVxSkWBwHMDCKqg79NUtTsQooMx0RlA9j0Y/OzLnESrg+WHqmJOMIl/hqLj1lh0nKrVyYXGiiuQvSq+MUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq5x4RAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq5x4RAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A09C19425;
	Mon, 27 Apr 2026 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777287159;
	bh=IDtaj8qDPCoKLn7FLT5h06j/NwN3NbNxb5XhN240DSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lq5x4RAcNGcgHRuSdZID8zUAfGXoRIuX3BWOQFyvrtUNcoDyDL7F02naaYVkPrZ7t
	 xGBB95QBpgtB7OP6mjMzBXd71/JvQzEbT+1wS0QRkVZozlmkkROCO7Xf78cCsoMROV
	 wYPbZt1Tq+J+2PvLdYpMEc46qkdjeAbQLXE2JvqvAQyJv3ygNl1ftJyAaRS9RbGgc9
	 Yc4ozuNPgRF5Z4Z+G0aHs0u+dcb8StB0C1dCtBZJeY5S6ISRUVfklMVBywjZUU+5Zk
	 DP+6hyITcXfswDoAXrs7BavzyK4kEpPkxIYo3U+35v8C/0Rc2mCAofHVg8nU0xqx7w
	 9pLcQMA3DribA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1727DF4007B;
	Mon, 27 Apr 2026 06:52:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 06:52:38 -0400
X-ME-Sender: <xms:9j_vaRdJxmwAzlw3e7YRcdCjoKb-_iFJeqFWAZ8fjr4r4UILNlAOyw>
    <xme:9j_vaedpSCgjXb6sga0pwzEZOHlKqPy0a4P1RoTWuSseKRZHMNpfvVarTVh516RuO
    VR3QaHGmR8yaysX3QM0NjQqWicfyKjukLfficV3-L0lgKdwxvtBTTfg>
X-ME-Received: <xmr:9j_vaWs2T2cZxQgrpZHUVzdJu7WRmXEdhApgxHcUVNq3NDApwM7IzBPsoojzug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeuieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgusehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    iihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:9j_vaVuGM7jbRtmfRyu7XHUQQBiCllZBLkcJqM_pGtwmxX6PlNmeXQ>
    <xmx:9j_vaQujznu0OONSHzF7EKEFB7xUNcB6dk2WL1O5-rQ7v_QU7ft1_w>
    <xmx:9j_vaY1s2lM14MOre5Tojy0TPvzInCjzWhTU4N5W_l8V5fTMmoWYbA>
    <xmx:9j_vaVLsM3YeHltvz58F_FbLRQyC7AwKgg3jlJT1SVDLqkHjnIHlBQ>
    <xmx:9j_vaa-ScGWQp7fhQ-euoBy97V06vaqH2MA5y9H75sPO8ELbvcKAPCgb>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 06:52:37 -0400 (EDT)
Date: Mon, 27 Apr 2026 11:52:36 +0100
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
Message-ID: <ae85cnYpuKT9lotn@thinkstation>
References: <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <aes7b17nG0cXrtEd@thinkstation>
 <aetZUOINzfTXChLL@x1.local>
 <aetyhki-UD70dyRL@thinkstation>
 <aeuSe0PY-g10KNUF@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeuSe0PY-g10KNUF@x1.local>

On Fri, Apr 24, 2026 at 11:55:39AM -0400, Peter Xu wrote:
> On Fri, Apr 24, 2026 at 02:49:58PM +0100, Kiryl Shutsemau wrote:
> > On Fri, Apr 24, 2026 at 07:51:44AM -0400, Peter Xu wrote:
> > > On Fri, Apr 24, 2026 at 11:34:48AM +0100, Kiryl Shutsemau wrote:
> > > > Both page_idle and the LRUs (legacy or MGLRU) track accesses on physical
> > > > memory. We need visibility in the virtual address space domain.
> > > 
> > > Yes they are, but ACCESS bit isn't.
> > 
> > A-bit is not a reliable signal for userspace working-set tracking
> > because the kernel itself is a concurrent consumer. It is exactly why
> > page_idle needs PG_young on top of the A-bit: PG_young is the "kernel
> 
> I assume you meant PG_idle.  I actually don't know whether PG_young is
> still actively used anywhere in the current code base.
> 
> > ate the A-bit but the page was actually touched" escape hatch. And
> > bringing PG_young into the picture puts us right back into physical-side
> > tracking.
> > 
> > > For migration, see e.g. remove_migration_pte() has:
> > > 
> > > 		if (!softleaf_is_migration_young(entry))
> > > 			pte = pte_mkold(pte);
> > 
> > remove_migration_pte() only propagates young-at-unmap. It does not
> > cover the common case: A-bit cleared by reclaim before migration
> > started. The concurrent-consumer problem is what breaks the signal,
> > not the migration boundary.
> 
> IMHO it's a separate problem, and AFAIU it was well solved at least with
> old LRUs with PG_idle. It's just slightly unfortunate it doesn't yet work
> with MGLRU.  Also, when the extra bit is in folio->flags, it only works if
> both the consumers are reporting per-folio, not per-mm.
> 
> I'm actually curious whether there're numbers or solid proof showing that
> in your case the per-folio perf is too bad already to justify a new per-mm
> API, like RWP. 

Fair ask, and I don't have numbers I can point to right now. But I'd
flag that the case for RWP doesn't rest only on cost:

  - LRU-agnostic. Per-folio approaches are bound to the current
    reclaim backend (legacy, MGLRU, whatever is next);
  - Race-free against reclaim's A-bit consumption;
  - Deterministic preservation across swap and migration.

Numbers would strengthen the cost story but they don't change those
structural points.

> I want to explore if there's something that can still be generic and work
> for per-mm tracking.  I believe if we can have some bit in the ptes, then
> when mm reclaim code walks clearing ACCESS bit and sees some vma is being
> tracked, then instead of setting PG_idle, it can just move the access bit
> over to that special pte bit, and only to this vma this pte.  IIUC that'll
> benefit from both worlds: fast HW-accelerated access bit, and no minor
> faults.
> 
> Would something like that worth exploring?

This can be interesting. But a spare pte bit is high ask.

And when you start tracking, you need to clear A-bit. Where do you move
it? Activate folio?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
