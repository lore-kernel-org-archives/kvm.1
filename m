Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456740DFD8;
	Fri, 22 May 2026 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467955; cv=none; b=VTtpbBlVPqCdyDzV3lYYLGnlr1BaJTVoM71On1IOfbkxK00eyokhaEUaxPrRLVwvNUV6mdBG9ZSqDon6nVW6AF3NSG3kXk01kuVmE4TU2XCWIfj7+8D6aajRQrbmf6uwz2ThbW0SIMa4poOA0eBAjnhqTKjTBSlFsA13+qIqk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467955; c=relaxed/simple;
	bh=KZY39TFYMIjAMiOyiY+MYDypBHcVKr5Gmmh9KeAUxkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjVAvGYUFR/mZfUpy7Gr4T22CsEi0RhygkcNEli4tTJnB1OAq38G6lz32wE1EVN/+Fu1GtPGhqhoWHb5ofM/xwUvqCL1n3sOWPmovBIaKVHd6Iffmm9spDWhcPYWe9MdDeBrEQwkr6rji2wWCoK1ybDrJ6YXRRu5F0hGwmoyadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bixTCv2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bixTCv2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F9E1F00A3D;
	Fri, 22 May 2026 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779467953;
	bh=D2Q25sdeLdgF2p/s/jeA5T0pEvWw31HZ2i5F0qGZZn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bixTCv2JqNvWkQEZJwLbgNeSP5qfukU9pO1uH0kTxKyaHjQUK6UtS5FuVdDNvYgFh
	 MsQNlap5xKdHnkwAnrtT5UVwhwCK4pMOe9GGb1/0E1d5r6G0B/6FbIpdHv6KWHDTyv
	 cYJ5bummqGxoxJfP5DqzyVBrRSuKQgOEeTDVsckNX2xv0da6tTbryF099n0Qe6NjTx
	 Sh8duivZPfQTP9vKLdV41XbdhNqZt0+g4pQZp5QUBjBdc53U7hUymPUBID08sQHHMs
	 g52VZMyQ5xfeGosX0EHr/Exbb9OHP0fFVnnqhuVNdHkp0ODRvxIKFwzIrTAR50GOV+
	 mL8k/2yHVmH5Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 641D6F40078;
	Fri, 22 May 2026 12:39:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 22 May 2026 12:39:12 -0400
X-ME-Sender: <xms:sIYQauxOWxNEFJ59q1Cryd4VDApk8LVGYxwpUpbsBhVvXmz9PaWGKw>
    <xme:sIYQal_wW0UMCwokHTV2Vi5hAptYeSnF3bbELHokT_t_SfyyAG9z-iHUiv5AlNoUd
    Cg_5jiEWinUoYkZ321TJ-a72FrqT2ssPxslcN4GOrksTd4cTrwh800>
X-ME-Received: <xmr:sIYQaj9Q6tXY_xCEcyZunghYZ_WoQzYdSs_EZcS9WmOOhUm0awx9lLZr_fI3EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepffffkeegffejgfekvdejgeegtddtleejkefhhfduieduhfeigfduuefghfehffdu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeeg
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephigrnhdrhidriihhrghosehinh
    htvghlrdgtohhmpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhn
    thgvlhdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehtghhl
    gieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepgiekieeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sIYQakyT8iHOZRbipp-hJp9lqQ7gyVAmXfZ775zgodokGFM-ylfi-w>
    <xmx:sIYQauBE1QHAk83HDWeZrf04c4fC2luD0OpnmwLngVLE_Li6WppkGQ>
    <xmx:sIYQatI0XpcaK6_y0gFtfVSjYBelhZPxLXs9aMM-f8Yjx5pEkBmFfA>
    <xmx:sIYQapvAuZ9-lW1nw0FNrRyK71mycPPdvIvDx3UnQot7S_Cn5KL50A>
    <xmx:sIYQam5S4zHS_RWzza3HEQE6Rgjw2S_qjQIBCSKXAUax_5O7VhNAw-8y>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:39:11 -0400 (EDT)
Date: Fri, 22 May 2026 17:39:10 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, seanjc@google.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	kai.huang@intel.com, rick.p.edgecombe@intel.com, yilun.xu@linux.intel.com, 
	vannapurve@google.com, ackerleytng@google.com, sagis@google.com, 
	binbin.wu@linux.intel.com, xiaoyao.li@intel.com, isaku.yamahata@intel.com
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
Message-ID: <ahCGkZFm-XaY1bCU@thinkstation>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
 <20260430014948.24226-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430014948.24226-1-yan.y.zhao@intel.com>

On Thu, Apr 30, 2026 at 09:49:48AM +0800, Yan Zhao wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Remove struct page assumptions/constraints in APIs for unmapping guest
> private memory and have them take physical address directly.
> 
> Having core TDX make assumptions that guest private memory must be backed
> by struct page (and/or folio) will create subtle dependencies on how
> KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
> allocated from core MM, if the memory is refcounted, or if the folio is
> split) that are easily avoided. [1].
> 
> KVM's MMUs work with PFNs. This is very much an intentional design choice.
> It ensures that the KVM MMUs remain flexible and are not too tightly tied
> to the regular CPU MMUs and the kernel code around them. Using
> "struct page" for TDX guest memory is not a good fit anywhere near the KVM
> MMU code [2].
> 
> Therefore, for unmapping guest private memory: export
> tdx_quirk_reset_paddr() for direct KVM invocation, and convert the SEAMCALL
> wrapper API tdh_phymem_page_wbinvd_hkid() to take PFN as input (thus
> updating mk_keyed_paddr() and tdh_phymem_page_wbinvd_tdr()).
> 
> Intentionally have KVM pass PAGE_SIZE (rather than KVM_HPAGE_SIZE(level))
> to tdx_quirk_reset_paddr() in tdx_sept_remove_private_spte() to avoid
> mixing in huge page changes. The KVM_BUG_ON() check for !PG_LEVEL_4K in
> tdx_sept_remove_private_spte() justifies using PAGE_SIZE.
> 
> Do not convert tdx_reclaim_page() to use PFN as input since it currently
> does not remove guest private memory.
> 
> Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
> since APIs tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_paddr() are
> exported to KVM only.
> 
> [Yan: Use kvm_pfn_t,exclude tdx_reclaim_page(),use tdx_quirk_reset_paddr()]
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
> Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]

Acked-by: Kiryl Shutsemau <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
