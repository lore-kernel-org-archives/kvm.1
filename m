Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD540DFC3;
	Tue, 14 Apr 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186644; cv=none; b=Lo41BjdEmOten4s2CYJwqg0nll/xkKgijME0pBYASN+yeieiUuJB482VRVHcxwrzgH+MkuX7+/kdWKC1a/UyIoLk8zbPijBOw6Qg7R5TGGFK/K562iVK378yITOg8MyqpicJwdOXFGxS6FmHdFQVsWWcXAQIGRMFCLxfEbIRdRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186644; c=relaxed/simple;
	bh=s+QTe/HNNToEvnbjZtLRr7wE8J02Yjv4qBKvWU9mj5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKVQJh5cl1eypI0aWN6YqzstRLm2mDuJOkbb06C6n5sQzrHiPT46LrukHg1g741MUuen8/zO0cPo3iciAbiJ29MDx0PRd+tnV/76uJQUkW3zHLmjBMCCrKnKqCPinxKGmjXEytnA9cPyzOhYM6CnvS4eUPe6fRGGIZszNi8piA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vc83Ub+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vc83Ub+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37938C2BCB4;
	Tue, 14 Apr 2026 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186644;
	bh=s+QTe/HNNToEvnbjZtLRr7wE8J02Yjv4qBKvWU9mj5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vc83Ub+g+fxbkXM9UT9gsGjGiQ5Ew4laYT/Xisg9xvz9lrO+kquxrkCw/2mxw4RDf
	 KUnL23Usknw2gscy25a0LBhRrWVEN0fhmbY1PSLDhyaUApW6GbsHdNzRTBMqNvSrPT
	 Um9tUqXcPVKm9wnwkdWQYqQiwIEwS4nXMQP8iFG/l2F1JYzAWaua92O6jgYj9XaPCD
	 KFP12+hafmqDwSugEHadJ4D48AumOpXQ7c86Z6tEk20zqUC0+gdW6DJRcYY+7h+9qp
	 MhMGAdI6Vn5S4UehtI3WChotYnx2gDCjOkKl5zkGhIoeGcaxKVsfpI+U+bPm+dj7DE
	 7X24HRKoJHVWg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 60742F40069;
	Tue, 14 Apr 2026 13:10:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 13:10:43 -0400
X-ME-Sender: <xms:E3XeaclU1hOUQVScQjcFL_wMZCO0EPk_hn-zmthT-QgwpfIJv5Rsjg>
    <xme:E3XeabFQt9jPiH84YamCrBopt0yMXjeqIqqK_3We_NbhrwfouzbzixGo-vSVDiTlS
    RvA7_1-teAZp-78CFnoYvjEjSWLulzJhTg-korgqTTQekkeeX_H_Q>
X-ME-Received: <xmr:E3XeaW32GBhscU1pZcTOa17a6W4EZrK2zmb4vYpgcTvybuOOtRNwdz1AWtrdhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepiefgvddtkeevjefhhedtudeuueeikeejkedvgffgtdekgeeiveejvdegtedvhefg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvihgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepphgvthgvrhigsehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehljhhssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrphhptheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    peiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:E3XeaTUTdP55Go8VslarUZuoqPZz4YL8as_sP6mXkhr5yXhya2C90A>
    <xmx:E3Xead13zkizWwxD7-gYrYiQv3a1rHEFbkshVNwKQ7jOkYUL3zeMyg>
    <xmx:E3Xeafe1lMPPzmmITOqd1yg1UzrDo56nDeKqrucMispG9u1-o4O3jg>
    <xmx:E3XeaXRqMgCQWib69_21sotjZiw0kuyhhzwcRcJLx2K31nF6_aSefg>
    <xmx:E3XeaSnTdo9l6Ht8KS523XOzLkNK992JU69CjdoVw-Ys0-M2RLdkY9dy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:10:40 -0400 (EDT)
Date: Tue, 14 Apr 2026 18:10:35 +0100
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
Message-ID: <ad50rPOseVa-SP_s@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>

On Tue, Apr 14, 2026 at 05:37:50PM +0200, David Hildenbrand (Arm) wrote:
> On 4/14/26 16:23, Kiryl Shutsemau (Meta) wrote:
> > This series adds userfaultfd support for tracking the working set of
> > VM guest memory, enabling VMMs to identify cold pages and evict them
> > to tiered or remote storage.
> > 
> > == Problem ==
> > 
> > VMMs managing guest memory need to:
> > 1. Track which pages are actively used (working set detection)
> > 2. Safely evict cold pages to slower storage
> > 3. Fetch pages back on demand when accessed again
> > 
> > For shmem-backed guest memory, working set tracking partially works
> > today: MADV_DONTNEED zaps PTEs while pages stay in page cache, and
> > re-access auto-resolves from cache. But safe eviction still requires
> > synchronous fault interception to prevent data loss races.
> > 
> > For anonymous guest memory (needed for KSM cross-VM deduplication),
> > there is no mechanism at all — clearing a PTE loses the page.
> > 
> > == Solution ==
> > 
> > The series introduces a unified userfaultfd interface that works
> > across both anonymous and shmem-backed memory:
> > 
> > UFFD_FEATURE_MINOR_ANON: extends MODE_MINOR registration to anonymous
> > private memory. Uses the PROT_NONE hinting mechanism (same as NUMA
> > balancing) to make pages inaccessible without freeing them.
> 
> I would rather tackle this from the other direction: it's another form
> of protection (like WP), not really a "minor" mode.
> 
> Could we add a UFFDIO_REGISTER_MODE_RWP (or however we would call it)
> and support it for anon+shmem, avoiding the zapping for shmem completely?

I like this idea.

It should be functionally equivalent, but your interface idea fits
better with the rest.

Thanks! Will give it a try.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
