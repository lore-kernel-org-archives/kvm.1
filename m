Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02613C98AE;
	Fri, 22 May 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446008; cv=none; b=pRMy+BONDyWphj6rwwCi4ulx9IYOy7kJ86AFbWj9J6wX3ItKgadQ9GDOLEKWirpIqbRr77+mdpi9mM8puyMkozDJpAHHsM9SIuyiaFlxfSG9drLT31b3/U0OhTqPEWNhCkJKiIv7q7lgO+rXt43MSdCDpEJXyduZKBxkMikMoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446008; c=relaxed/simple;
	bh=OC9I9ays2hj7Jffo+4Ohri3Oya/4mlwWbN2Oqlu0vZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2eBmX2ak5uJPeTbxbCVRYWzUtqimHsCokMFw7wQK5weJLck1Su9KoshKH73ia7wmrLtnefsCcoKIX8ZMpkvoM9HjS0KsgT9Qi6qMM2lh3oKAgB+Uxsys7PgvxrDpClU4IP18BkD6aOSiaFf2Ys4aqutED+iRcwXsxkSsk17w+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGKq/CIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGKq/CIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB191F00A3D;
	Fri, 22 May 2026 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779446006;
	bh=fSAKcTCjHEBP0sQv4s+o1EWc5Ccjv9UlLr1FZ7wIvhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gGKq/CIzLxg1eVylTmSsaymkCWKTFGI+O2LCAQD66kFGHuWu7AEA0EJlsvNO0PnQE
	 +sihyb31rGdup1cSzTE35K5odHeZ3/eHCKeOYbV9EbYbbeLlKAny6B5p5VBmDYx2ES
	 GZXeOEgUZAcHnVcNK6M3SVEXt1noKuLnGw0nxC0MojK5TvXJhQ6WEjgAVizgmQLpcI
	 dDsCOpurTMS0gGQCbFYdDq9VDF2/E8KvK+CSXg9xD83/19DHSXkato+MRFH0E4vsWo
	 NTnvBgkTQDRwspvDgy289uUsENhabwbbni7Ifovw2ttOt/+5uVb0/kPNiwfTMRJHVs
	 dZpW2WP7j3/pw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3329CF4008C;
	Fri, 22 May 2026 06:33:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 22 May 2026 06:33:25 -0400
X-ME-Sender: <xms:9TAQanIenWH_ygrOQ6FUHBHioGIwigEJ1_bMwmlkf-_CugjQOnVFyQ>
    <xme:9TAQaoztDcO3aL7ONGNqejCZ6lxgiC2rO1Vx_hOXtziE-Jk9_NpyH4rGCI2sD7hjL
    fZ00HOxyCzB1bqTrz8L27ZkOuzsRdNMUxkEmlzM0tQFZxy688CnJQ>
X-ME-Received: <xmr:9TAQalSy4EwNoMaSIWOw-ZQF4JGjJASlv6y3tByrXHYXi52jPSyjgkhmOvBfPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhn
    vghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeuieejieffkeehfeffffdtkeelfeelhe
    fhfefhudehjeehvdffleeuvddufefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhn
    vghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeegiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepshhjsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:9TAQakB5MJDyeRY_hnhhvRW8ddk9xhB6k169PMZOdmdBLzjNgzWUMA>
    <xmx:9TAQatdv31zZM0M2rGNw6Vf40Z5SRXpwAVIh8GYd_OyXyI_GhgRs6A>
    <xmx:9TAQasvkmJeWjrcPgrWoxeaHPZ0_znuDXuC3yuO7C7vruthndstmNQ>
    <xmx:9TAQavJa5JPR45FttlxYzQlQ3p6Hp2BDqXCthKi8GGTuTo5LyVCc4w>
    <xmx:9TAQao83YRq4gP8_a6IhIK19klW67QorxUepSbRdp0Q2PX13A3GyyW8a>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 06:33:23 -0400 (EDT)
Date: Fri, 22 May 2026 11:33:18 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 03/14] mm: rename uffd-wp PTE accessors to uffd
Message-ID: <ahAwiYBj3V8kV-Ez@thinkstation>
References: <dfda2f55e155b17535ea9fb8330d9fa9afe0c0e1.1778254670.git.kas@kernel.org>
 <20260514013127.148945-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514013127.148945-1-sj@kernel.org>

On Wed, May 13, 2026 at 06:31:27PM -0700, SeongJae Park wrote:
> On Fri,  8 May 2026 16:55:15 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:
> 
> > Userfaultfd RWP will reuse the uffd-wp PTE bit to mark access-tracking
> > PTEs, alongside the write-protected ones it already marks. The bit's
> > meaning now depends on the VMA flag (WP or RWP), not on its name.
> > 
> > Rename the kernel-internal names that describe the bit:
> > 
> >   - pte/pmd/huge_pte accessors (and swap variants)
> >   - pgtable_supports_uffd() capability query
> >   - SCAN_PTE_UFFD khugepaged enum
> > 
> > The ftrace string emitted by mm_khugepaged_scan_pmd for this enum is
> > kept as "pte_uffd_wp" so existing trace-based tooling keeps matching.
> > 
> > Pure mechanical rename -- no behavior change.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks!

> [...]
> > @@ -4934,10 +4934,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >  		softleaf = softleaf_from_pte(entry);
> >  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
> >  			if (!userfaultfd_wp(dst_vma))
> > -				entry = huge_pte_clear_uffd_wp(entry);
> > +				entry = huge_pte_clear_uffd(entry);
> >  			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
> >  		} else if (unlikely(softleaf_is_migration(softleaf))) {
> > -			bool uffd_wp = pte_swp_uffd_wp(entry);
> > +			bool uffd_wp = pte_swp_uffd(entry);
> 
> Just curious.  Is the variable name intentionally kept to avoid unnecessary
> change?

No, I've missed this. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
