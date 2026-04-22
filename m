Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012F3C1991;
	Wed, 22 Apr 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850026; cv=none; b=GzUfucn9zL7cpX/ldSUxDNejFZCS38B89tBhq6A2qmKB/ssTflg4XS1I4GHqXggoFNBgocO918zvxUs1L7/31RNc1K8mMOvXQtUWn48kOnNhbj3cKB7GHq0imgXXMtQR4q1NnKtNvwIbaWlPMy2AT9GOIfpb7BwCAnlCZPfXrHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850026; c=relaxed/simple;
	bh=XSXtvCEOw1rXi02T2nIM3gho4XRJ3rOy8aCyH/Flzh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpFpJp03Owt5eJQthBn1Wm3m0UbDfxZDBxjw6Y1rrAyp6Gjamlw6RZynrnINh9mdtBVtj/BgjxChGLcq63VUVX9E624f3DtcieS3npg8tqm0YrS+mfKMC/pv09PD2uwI2d6i8n3fQmPCtDJyB9b9PBdy/NGXfOkSvuBgO1ib1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW8rW8oH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW8rW8oH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300A4C19425;
	Wed, 22 Apr 2026 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776850025;
	bh=XSXtvCEOw1rXi02T2nIM3gho4XRJ3rOy8aCyH/Flzh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW8rW8oH3Zc32i8I3WGhWbQgmqOQKPT6gmk4fL2A7usxNc9F5NFFDRh4v+xNfaQkQ
	 sh5xmCFr7QeNBkx1UZEBXgjEQnmllo3w7bxebHJ41r/S380l5A4Lnq6z78cfADpCHf
	 JvONOpjWbbGLy87jnRV99MswY6ifyOlCnJe5Rrr5rOV25RC7VbomMVCFAcCbyvU4hn
	 1QCqqks9KBG3Ah3iBAeJlBBr4fSZdxfSbI0DamZu75Ld1yt86YzUbOGFW5YYhiS4m3
	 7z8qA7SgDS+aQm/+5cTNVdO8XtiIC7TAPZtT1AmObHBUUEjx0t53Aa5XfsthRa9gvS
	 8/8ikfI0ZNuqQ==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 375E6F40069;
	Wed, 22 Apr 2026 05:27:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 22 Apr 2026 05:27:04 -0400
X-ME-Sender: <xms:aJToaeGii4IM0oL6w5d9DlxZY3J34dusHidJOAQXLgxR_JTVDGQCyg>
    <xme:aJToad0Ul418c1XPvY5j--gNP5mTl49gtqYfgphTeOn1ICkf_UmQy3NXxAS3wq9BG
    NJ99eKbxEncWGVE7MVsMuCQMSN12LZk5LZkSG7ZLzIQZqixnHUxC_c>
X-ME-Received: <xmr:aJToaeWov4PpwQe5q92KBYrsgst-IOJcGq9KUBqEPWgZnkyw2V4ddXjAIzZCzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeuieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    iihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:aJToac1TuZDXfFwGRdKOtg1b447Z32xwhaJLPFiNfasgDF-0BKtUBg>
    <xmx:aJToaSf7bUXXrkiDOgQqd6YfId5bSLgjAU5kG26CSzkCZ7t6PKo1ew>
    <xmx:aJToaeT_HeYfJdQGHfRSP2cjHnz9A1PvUdNFY3H4v5as0SDQQ5z40A>
    <xmx:aJToadkTSABajhQ1iNy4XkkRzKKnBSjuz186wCOy5HZsK4bzmG2-_g>
    <xmx:aJToaapUOmAHDxHH5oNJEiX7nbl8UAhRgZuVgIHxUCaomgEUar_uEr38>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 05:27:03 -0400 (EDT)
Date: Wed, 22 Apr 2026 10:27:02 +0100
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
Message-ID: <aeiUGtFgmYB9M18L@thinkstation>
References: <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aed6fHLrIdahbdY3@thinkstation>

On Tue, Apr 21, 2026 at 03:33:27PM +0100, Kiryl Shutsemau wrote:
> > 3) Some other stuff needs a second thought, like
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 8e7dc2c6ee738..08fc18f1290d4 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -695,7 +695,8 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
> >  	/* ... and a write-fault isn't required for other reasons. */
> >  	if (pmd_needs_soft_dirty_wp(vma, pmd))
> >  		return false;
> > -	return !userfaultfd_huge_pmd_wp(vma, pmd);
> > +	return !userfaultfd_huge_pmd_wp(vma, pmd) &&
> > +	       !userfaultfd_huge_pmd_rwp(vma, pmd);
> >  }
> > 
> > How can a pte be writable and prot_none at the same time? Maybe just confused AI
> > output that you should carefully double check before sending that out officially.
> 
> Note that this path is for !pmd_write() case to begin with. It serves
> FOLL_FORCE case. I believe this check is correct: we don't want to allow
> to write to such pages even with FOLL_FORCE.
> 
> But looking around, I missed gup_can_follow_protnone() modification. It
> has to return false for RWP.

With gup_can_follow_protnone() fixed, the checks in
can_follow_write_pmd/pte() are redundant. Will drop them.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
