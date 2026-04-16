Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96041333426;
	Thu, 16 Apr 2026 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371126; cv=none; b=eRdvZCQPiy7lexJ9fCydDcUg7+JMTsIYBXzKQlPkaAIXQWZxfnNGj0XohbkwgquVha3IuTwhs0uyQjW4DrbrU/z3XGRtM+DMJAtlvO/6xy4AJxML2tm0BIAzLjz1WM16iis8CPuSTEY66ZkihzZXm5OQhFHGFn2xbQhoX7ZO3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371126; c=relaxed/simple;
	bh=YuGyZSQWXwJBjPNCgqxfSOMDACX3rZbbFaPcf0aYw8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfKq+Qq+IGMaQhTOPVtwlQDc6O9cZExIksDtWcXG+Ab17Q05eTlMa3faugzB/Cyv6jaOtTbrU3jL8Zus9S0P/WdlSOboQdu8Iy5FWG4OTI3BgrYu5gQBy00hGeKrrQmrnyusQphWRGPfSo+laOYwrta37Wiw1AMWI4YJi5hE1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHR6wvMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHR6wvMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1628C2BCAF;
	Thu, 16 Apr 2026 20:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776371126;
	bh=YuGyZSQWXwJBjPNCgqxfSOMDACX3rZbbFaPcf0aYw8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHR6wvMJSPQziXvXkRhq2b73yD39kZq7xOmRYPKBBJHyQCyjzW3a58ni5DbmGCU9y
	 faTQaZRae+k2FeGGwyULIzMYtauY/sqSrHFBP861J94RupvPyd1LsVdnbaCefbHYSu
	 U9o8DMuscsRo0V81GCEMLqarGAwRvan92kfBulq08DXw/j5lWXmCaA3p3a+BKzIQCs
	 PPSTsloFBjzQVIXNb0cKaUZ6FXmZN+eXtHtgJ5amp4HpZE92faZzB+5CgDbsHJopWI
	 Cz0+68dtBVMYDqnmMDfv80gr++e7iXQIzK0mhO2q5ofFMlbf0hCimcFD/Uuf+QwHwM
	 ehFk3mzRpSlrg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB387F4006A;
	Thu, 16 Apr 2026 16:25:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 16:25:24 -0400
X-ME-Sender: <xms:tEXhaRRjgnic9kXj4-ktDIZ8mxwigb8jHg90P2SdyP_0oHetYLFDkQ>
    <xme:tEXhaaDI9IHztK1haGXz6MAE6VXMXCUTSV3hvscQ2HtkH0U4eteDT3tDyQYyuCneB
    9V-EdrskKuQzgjToOGhs7XJlkhfteH9m0OC9bK5kt4Kkc3bY_Kr>
X-ME-Received: <xmr:tEXhaTDBWTM1AZiHj6lR-OxcHgzF3tZMT50MSVNcEsNu233_tYTr5Hspwb7eWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeffffekgeffjefgkedvjeeggedttdeljeekhffhudeiudfhiefgudeugffhheffuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehljh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsg
    grsghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthht
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:tEXhaTya-dTGLZO7X9ydBulSk16fEfuIUebJmFUXbpajHv8TChFFlg>
    <xmx:tEXhadg_bSOFD8qQFOKcr-OI4jIhE-0ucPAuKHqmcr68YCpAyi6eSw>
    <xmx:tEXhadZdP4aWhcB2xoH8SmkZ0_21LgPTS4AKrj5HVIceDQhXXIOtvw>
    <xmx:tEXhaWc-QlnTGdPIQKO4bb8vboT9JwNHe7QTK6j2E-jGlj7oiAKAaA>
    <xmx:tEXhaaBjpNEaOlo31je-7SV9sXxnfs1dPMRsLHSevixVPKJU0nVjbN0j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:25:24 -0400 (EDT)
Date: Thu, 16 Apr 2026 21:25:23 +0100
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
Message-ID: <aeFCuLJXT8VOkzH7@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>

On Thu, Apr 16, 2026 at 08:32:19PM +0200, David Hildenbrand (Arm) wrote:
> On 4/16/26 15:49, Kiryl Shutsemau wrote:
> > On Tue, Apr 14, 2026 at 06:10:44PM +0100, Kiryl Shutsemau wrote:
> >> On Tue, Apr 14, 2026 at 05:37:50PM +0200, David Hildenbrand (Arm) wrote:
> >>>
> >>> I would rather tackle this from the other direction: it's another form
> >>> of protection (like WP), not really a "minor" mode.
> >>>
> >>> Could we add a UFFDIO_REGISTER_MODE_RWP (or however we would call it)
> >>> and support it for anon+shmem, avoiding the zapping for shmem completely?
> >>
> >> I like this idea.
> >>
> >> It should be functionally equivalent, but your interface idea fits
> >> better with the rest.
> >>
> >> Thanks! Will give it a try.
> > 
> > Here is an updated version:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/log/?h=uffd/rfc-v2
> > 
> > will post after -rc1 is tagged.
> > 
> > I like it more. It got substantially cleaner.
> 
> I don't have time to look into the details just yet, but my thinking was
> that
> 
> a) It would avoid the zap+refault

Yep.

> b) We could reuse the uffd-wp PTE bit + marker to indicate/remember the
>    protection, making it co-exist with NUMA hinting naturally.
> 
> b) obviously means that we cannot use uffd-wp and uffd-rwp at the same
> time in the same uffd area. I guess that should be acceptable for the
> use cases we you should have in mind?

I took a different path: I still use PROT_NONE PTEs, so it cannot
co-exist with NUMA balancing [fully], but WP + RWP should be fine. I
need to add a test for this.

I didn't give up on NUMA balancing completely. task_numa_fault() is
called on RWP fault. So it should help scheduler decisions somewhat.

I think an RWP user might want to use WP too.

Do you see this trade-off as reasonable?

> But I also haven't taken a closer look at this patch set, whether you
> would already be using a PTE bit somehow (I suspect not :) )

No. I didn't want to allocate a new bit or invent some arch-specific
trick for this. This functionality is available everywhere where
PAGE_NONE exists.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
