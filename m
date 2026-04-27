Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA90305E3B;
	Mon, 27 Apr 2026 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285394; cv=none; b=EBmni8ea/2CI2c0Lcz7PSs0m6iKN9vJmmZAW7jtj/eM+uCrjVvQMurBMzTqNW01DSCx00fl6KRGXs4FZOPXtTJRPSGV9onNxInUXlGCvGBOdLSvIwAKxGMD4+AOaHrWvLacp8e1+h6yLb/cYcQ5OK/gQ8M5b0KPZpJXQaM4IIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285394; c=relaxed/simple;
	bh=fUpg5gsOkSvFFfXQrHt3olWMMe5hz0pDIK5bBl+Z4nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ1PxqfTvuYAdEGWBIJq3M9+50SmFQFXRvHrw4b4z0hmcwHtcoNaw+CQjsY437OEHmi/UL2JLIiT5gHj+JiMBQnl3WeDHTWE/L6oHs/fmV09VbtmOelOGwqv9pgSZ3c7eSebQbmWB92KkZZUas/EdYfnotGUlSfwH/pj5O+CQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q53B/wDn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q53B/wDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A44DC2BCB6;
	Mon, 27 Apr 2026 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285394;
	bh=fUpg5gsOkSvFFfXQrHt3olWMMe5hz0pDIK5bBl+Z4nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q53B/wDnwzeVo4lRh05DTg7drzUct4zy+D6ard5OgdVJy7Jz1RQF1/zm6N4h0Lqzh
	 v46K+wEI/XGqlmLe0UPUEgNf+kbOTUJWjAeigI84HIY99I0QLvaQs4D7iLH+jxw/hP
	 z8sFdNEZnB05fIoGqDm7Uoo8a7ZZ2raE2MX7ik6PzEoDsHQETMWrvACW/S3nW6SUpP
	 3Lb3NEJtzR0R36dqyVe7GebvpMIpkiAe8gM57BOFIKTGa9PgAvwe4iX2s+Ter7f9R/
	 WNdq5RSGjWuRlUBYZ3k6T6FucEcqJiYIiVhusrr7DyiEGEQysQUnF+TE9oTLhsGS8w
	 QlW+YYOWaAIMA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A0F32F4007D;
	Mon, 27 Apr 2026 06:23:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 27 Apr 2026 06:23:12 -0400
X-ME-Sender: <xms:EDnvaQSASUKodycG1gWLUkRqBODcT9UusFWuy84vdI-C3EVmYufugQ>
    <xme:EDnvadC6-xz2k5ijqgWULOeGYjGZQeVdWEsjAwSBx7fPDGqKpEse8NdnwVpj6k7UF
    C2NIWcQpqiuYJJHhT9ZBPjSrZN1DtvYfXGE5uHo4X5ks1osi0kPtCo>
X-ME-Received: <xmr:EDnvaaD_JVeCq3t-d_gtRzhqKeED6OUKcSkXYaJOJcQ3nfi7DWy9HbSPTRXHdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeuieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhigsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    iihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:EDnvaezPSEKdvW2LemvwhYxKBhVJcmT29F55rubrnyv9XDy2vahUyg>
    <xmx:EDnvacg7o_b0HkyUZlruDqdALLMJrZk0a42P7vq1OIA2_qb-I6p_3A>
    <xmx:EDnvaQZD1VWHhFcIoaSbSMel-FmR9c7XKvLPVZFQH_m0L40votz4Zg>
    <xmx:EDnvadfzPVAnKIroABNUL3__tR9HwN84QFfqdRDcRujfhZimidzqOw>
    <xmx:EDnvaVBEE4PfygYDF4d5N4qsl8ds4iUS0KIA0ls_UKoIIIdgGgsVhP9M>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 06:23:11 -0400 (EDT)
Date: Mon, 27 Apr 2026 11:23:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <ae82JuqoHfgk1_I5@thinkstation>
References: <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
 <aeo5IPpQi7onyjTF@thinkstation>
 <aeprnnccJeyHB2rt@x1.local>
 <aes7b17nG0cXrtEd@thinkstation>
 <aetZUOINzfTXChLL@x1.local>
 <aetyhki-UD70dyRL@thinkstation>
 <652b4a01-2382-4faf-bc1c-f127ee0b2c75@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652b4a01-2382-4faf-bc1c-f127ee0b2c75@kernel.org>

On Sat, Apr 25, 2026 at 08:05:16AM +0200, David Hildenbrand (Arm) wrote:
> On 4/24/26 15:49, Kiryl Shutsemau wrote:
> > On Fri, Apr 24, 2026 at 07:51:44AM -0400, Peter Xu wrote:
> >> On Fri, Apr 24, 2026 at 11:34:48AM +0100, Kiryl Shutsemau wrote:
> >>> Both page_idle and the LRUs (legacy or MGLRU) track accesses on physical
> >>> memory. We need visibility in the virtual address space domain.
> >>
> >> Yes they are, but ACCESS bit isn't.
> > 
> > A-bit is not a reliable signal for userspace working-set tracking
> > because the kernel itself is a concurrent consumer. 
> Right, I don't think we want to rely on either the A bit just like we don't want
> to rely on the Dirty bit in other code. (and even SoftDirty bit is a flawed concept)
> 
> I do see some value in a reliable RWP mechanism based on uffd. The real question
> is, how much benefit it would bring (which other use cases could benefit from it).

I have not put much thought into use-cases beyond VMs, but I think other
mmap-heavy loads (databases, GC'd runtimes, etc) can make a use in a
similar way: workset tracking and organizing userspace-driven memory
tiering based on the workset data.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
