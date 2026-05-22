Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E068B3E9F93;
	Fri, 22 May 2026 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779450614; cv=none; b=RBWg9vHtMYQRPivB2/X6HGjKphunhdGeNPNb0L8Jx63mnNX6S1EOqWNTM4THliIWyjUuVQK8IVlJesfzQCf4997iciY7yQkB8fp4ykLY0eolXq+fNaSEDfvq8SlL8+Gg3mmiLjzX2p9CKeTxEGNj44FYSg2byYn/hbtQ9koJLOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779450614; c=relaxed/simple;
	bh=eId48uiccv8Rjl3uAZ1YzghxWgp48Xvi7OeNP6O7Q+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3INOqoWj7CZgBOc7dHkfMBVRTqV9GTPna1e53tmrFRaQ8ac3uALiv5DhIcqTsLi2F+6V0bVV5I6RsxTLybMQUBUQCPpm3w77Hjj+1qJmzAAk1iDCZVHn/e2D2WcNcC50oMTB8ssduQZ3gZy7f3yBA5AStKTNJL7WNyViPiNW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqZ2x3oR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqZ2x3oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C241F00A3F;
	Fri, 22 May 2026 11:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779450612;
	bh=j2vayHA2pDYFLAPbwncK84YIqa/P2SCX3YMOZE3SU/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lqZ2x3oR9rvIWIKTvs3eEJaZM0B1KUAu4MCMIakAcS/alZOSObzCDlnUZ0Cxdb6Ao
	 X3RsxPYdk7CPteE3Hso5TxN7XTq/Y+icwtTtIJ94cGlq/Z1x1K9YpJBPA+grthrsNU
	 wg3hvnQQ3B9jP6UU5k/6k6MIjf71IeMklo17xWj1Y3tPFTzq14T3Wk5N6LMiKuEuLD
	 Du90KIDZxlAEtjZwjzRTOFiVnAxYLc3QcWEcXsiQkGsluAUcJaIO25cGbUYEa4aoSe
	 wK/Y21iFl47Fl+lvhNZFQEcdPdhfP+Q5RbgSQyKhV3pUMKtV13z5EHEWYyXLsO4m11
	 y0ljwU2dFR1iQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 39114F40072;
	Fri, 22 May 2026 07:50:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 07:50:11 -0400
X-ME-Sender: <xms:80IQarAYM2hvp8HOxoSyg_dyVjc5Wt-pWnG1AdvbNg-UIgPAiKWGRg>
    <xme:80IQavIt5cSIYHdgCxwi29nUMzhqmZtqUuUIc-WBzgJnq-MSu6V4EvOW2JE779Kx5
    TiV4ufezWK8EkMhF6nV8dNC1dnR8bp772KizyMt2_zBCfbHuxnBTJ4>
X-ME-Received: <xmr:80IQasLBakt9LIZBvflPkG368oH48F3Em1fyF1r0mAhxVzm86T0-eEpBjZtOwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedttdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefmihhrhihlucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhn
    vghlrdhorhhgqeenucggtffrrghtthgvrhhnpeeuieejieffkeehfeffffdtkeelfeelhe
    fhfefhudehjeehvdffleeuvddufefgkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhn
    vghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeegiedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvihgu
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepvhgsrggs
    khgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:80IQahbfPZhjnJhAJa_Xr8W7MnZI55cKDzodtxt87Y6Tes50KPGfWA>
    <xmx:80IQavUPWkle32wivFkV2vO6nM6nrI1RBrW-cJyTUthQmGuQb_2S0g>
    <xmx:80IQapEFUhOq6OEHMuX7-Tlph8vWPArIVADbLzuXugJfBybAWKygfQ>
    <xmx:80IQakAzsX97XJsDNs4Lo25QO2tceqg08I7lNDTlGG2YkKV7EvthKA>
    <xmx:80IQasVk15a2dTKbMQ2Z6YCmmFN3MKLygFdAS1GK3EX5mqkutuyw41Kq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 07:50:09 -0400 (EDT)
Date: Fri, 22 May 2026 12:50:04 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org, 
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Message-ID: <ahBC1PV5Bk0_nZkv@thinkstation>
References: <cover.1778254670.git.kas@kernel.org>
 <1ad0cb61a7b5a33a5375baadbd0720ba2ba43d2f.1778254670.git.kas@kernel.org>
 <agNhTvqeOD1eo8mD@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNhTvqeOD1eo8mD@kernel.org>

On Tue, May 12, 2026 at 08:20:14PM +0300, Mike Rapoport wrote:
> On Fri, May 08, 2026 at 04:55:20PM +0100, Kiryl Shutsemau (Meta) wrote:
> > Add the userspace interface for read-write protection tracking:
> > 
> >   - UFFDIO_REGISTER_MODE_RWP      register a range for RWP tracking
> >   - UFFD_FEATURE_RWP              capability bit
> >   - UFFDIO_RWPROTECT              install / remove RWP on a range
> > 
> > Registration sets VM_UFFD_RWP on the VMA. Combining MODE_WP with
> > MODE_RWP is rejected because both modes claim the uffd PTE bit.
> > 
> > UFFDIO_RWPROTECT is the bidirectional counterpart of
> > UFFDIO_WRITEPROTECT:
> > 
> >   - MODE_RWP              change_protection() with MM_CP_UFFD_RWP
> >                           installs PAGE_NONE and sets the uffd bit on
> >                           present PTEs
> >   - !MODE_RWP             change_protection() with MM_CP_UFFD_RWP_RESOLVE
> >                           restores vma->vm_page_prot and clears the bit
> > 
> > userfaultfd_clear_vma() runs the same resolve pass on unregister so
> > RWP state cannot outlive the uffd.
> > 
> > Re-registering a range must not drop a mode that installs per-PTE
> > markers (WP or RWP); doing so returns -EBUSY. This also closes a
> > pre-existing window where re-registering without MODE_WP would strand
> > uffd-wp markers: before, those caused extra write-faults but were
> > otherwise benign; with RWP preservation in place, a subsequent
> > mprotect() on a VM_UFFD_RWP VMA would silently promote the stale
> > markers to RWP.
> > 
> > The feature is not yet advertised. UFFDIO_REGISTER_MODE_RWP,
> > UFFD_FEATURE_RWP, and _UFFDIO_RWPROTECT are intentionally absent from
> > UFFD_API_REGISTER_MODES, UFFD_API_FEATURES, and UFFD_API_RANGE_IOCTLS,
> > so UFFDIO_API masks them out and the register-mode validator rejects
> > the bit. The follow-up patch adds fault dispatch and exposes the UAPI.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > Assisted-by: Claude:claude-opus-4-6
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks!

> 
> with a comment below
> 
> > ---
> >  Documentation/admin-guide/mm/userfaultfd.rst | 10 ++
> >  fs/userfaultfd.c                             | 84 +++++++++++++++++
> >  include/linux/userfaultfd_k.h                |  2 +
> >  include/uapi/linux/userfaultfd.h             | 19 ++++
> >  mm/userfaultfd.c                             | 97 +++++++++++++++++++-
> >  5 files changed, 209 insertions(+), 3 deletions(-)
> > 
> > +	/*
> > +	 * Pre-scan the range: validate every spanned VMA before applying
> > +	 * any change_protection() so a partial failure cannot leave the
> > +	 * process with only a prefix of the range re-protected.
> > +	 */
> > +	err = -ENOENT;
> > +	for_each_vma_range(vmi, dst_vma, end) {
> > +		if (!userfaultfd_rwp(dst_vma))
> > +			return -ENOENT;
> > +
> > +		if (is_vm_hugetlb_page(dst_vma)) {
> > +			unsigned long page_mask;
> > +
> > +			page_mask = vma_kernel_pagesize(dst_vma) - 1;
> > +			if ((start & page_mask) || (len & page_mask))
> > +				return -EINVAL;
> > +		}
> > +		err = 0;
> > +	}
> > +	if (err)
> > +		return err;
> 
> It's an interesting way to say "no VMA found in range" :)
> I think bool found and
> 	
> 	if (!found)
> 		return -ENOENT;
> 
> looks more readable.

Fair enough. Will do.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
