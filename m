Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899338423F;
	Fri, 17 Apr 2026 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776428795; cv=none; b=SzwURXzhuVSfrr0V9t1vC/q6gc79croYWIRf2k8TpGkBFQCP2VvlBqiRcMhAnk0qiLwmU33EDf7SIHG9tNGgaHzLAl1edKkZ+VMAau94C8ugV+YVssWR/syMmAjfkuIyolK4/0A9VOMeowiNOOx8pEStnZHCAUK3/oTeKGSLXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776428795; c=relaxed/simple;
	bh=qx+8FJ8jA0NidxGCtpVyMEUiZNEXmPexoJxKiWGCiMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdNu8T7U0ek4k7mPDc8dOKhNdlA04EW7yiyIC6JFHNfnglBu3tZRy4lXWkGiOTvICbTEu/iSQ5HNZzBxcMHCqzCxPQ4NnN+I2HWqsSA/GRI4L47iK/EQbC+X6+9tfBp/JSPe7Z/Ma+/XXgJA986ExW/Abi6QWtSqKFxgDb/qihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz7CRyk1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz7CRyk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CDEC4AF0B;
	Fri, 17 Apr 2026 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776428795;
	bh=qx+8FJ8jA0NidxGCtpVyMEUiZNEXmPexoJxKiWGCiMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz7CRyk10GE9Y73tyozR48+pEWlhyTxRJNmzGuwOCJIU0ALhdbG/0xIphC16F4qBi
	 oNvXvLxKGUSvCthYhOYcgTTgM44BCwhVYpDxXCult6wd7QVmrVTg1Q9qS3JM08i+UR
	 t4DxTL4IozATIHJEWSeyyjwmzG3PPeS5XVYpR9C+MK8uVVLffthgAOojT+B32BwMI/
	 mkSLqyfmDhdrreMbPB0x2ciWtkcSQcPZknPwYwRLS+ZlSgq6k24foxA9GupBuoBDPt
	 YTbnFyMxbphWdD5MF2JflguTTF5gNHe8DlU/7GiDQPx9O5b8zVou9+g0qaO9E2PdzF
	 rP+59js3C17/g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E3072F4006C;
	Fri, 17 Apr 2026 08:26:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 08:26:33 -0400
X-ME-Sender: <xms:-SbiaR_NNX29Fol-5tVyTde8Xan6QF1Ql8exi2WW8gRE9IVJ65OtXQ>
    <xme:-SbiaUPFJt8aEHbBHPLSBJIqS7LkcEfBGX-8lGHKWRz7AXEZntyYOb0qWRrY62iPU
    -tz1eOj0dqZvXmuBBXYwsHydfPqB4rGDPFwpQkZNR2wnWx2CmqN8g>
X-ME-Received: <xmr:-SbiaVNocWi5hTKsgUmcf6e2hhxZtWBRl4gFRinEAU4EfM6UrrnMnQLATOyFJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleekkecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:-SbiaaOpzH-hGXGD8Vnb7wDUjEyPZ2Yzd3P0SNl-CTUuebWkeO-rFw>
    <xmx:-SbiaUXLDyV9Dfmmz-EoGAYXiK572KSYrME9AJ_atGEPxDlDyLiBmQ>
    <xmx:-SbiaaqQpl4u3MiQQmUfZ5k6NA6ZhgCUTEF3_1g-aR1_ldmxlbWGjg>
    <xmx:-SbiaSecBy9UBAKEZg-YbcgBvEHjHQ4PBMISgK9pUxRGppKKv9YiGA>
    <xmx:-SbiaeBxJahyYoFrTpKPYVuki05v4yhgXwmld2lBZ-Pwdx3KjNYQq4Al>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 08:26:32 -0400 (EDT)
Date: Fri, 17 Apr 2026 13:26:25 +0100
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
Message-ID: <aeImfRrrvr3UoKtL@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>

On Fri, Apr 17, 2026 at 01:43:36PM +0200, David Hildenbrand (Arm) wrote:
> On 4/16/26 22:25, Kiryl Shutsemau wrote:
> > On Thu, Apr 16, 2026 at 08:32:19PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/16/26 15:49, Kiryl Shutsemau wrote:
> >>>
> >>> Here is an updated version:
> >>>
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git/log/?h=uffd/rfc-v2
> >>>
> >>> will post after -rc1 is tagged.
> >>>
> >>> I like it more. It got substantially cleaner.
> >>
> >> I don't have time to look into the details just yet, but my thinking was
> >> that
> >>
> >> a) It would avoid the zap+refault
> > 
> > Yep.
> > 
> >> b) We could reuse the uffd-wp PTE bit + marker to indicate/remember the
> >>    protection, making it co-exist with NUMA hinting naturally.
> >>
> >> b) obviously means that we cannot use uffd-wp and uffd-rwp at the same
> >> time in the same uffd area. I guess that should be acceptable for the
> >> use cases we you should have in mind?
> > 
> > I took a different path: I still use PROT_NONE PTEs, so it cannot
> > co-exist with NUMA balancing [fully], but WP + RWP should be fine. I
> > need to add a test for this.
> > 
> > I didn't give up on NUMA balancing completely. task_numa_fault() is
> > called on RWP fault. So it should help scheduler decisions somewhat.
> > 
> > I think an RWP user might want to use WP too.
> > 
> > Do you see this trade-off as reasonable?
> 
> One reason why the PTE bit was added for the WP case was to distinguish
> it from other write faults.
> 
> I assume without a dedicated PTE bit your design will always suffer from
> false positive notifications.
> 
> Leaving NUMA-balancing aside, a simple
> mprotect(PROT_NONE)+mprotect(PROT_READ) would already be problematic to
> distinguish both cases.

Hm. I didn't consider this case (miss some uffd lore). Will rework to
reuse existing PTE bit.

Thanks for the feedback!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
