Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78897472789
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566681; cv=none; b=fCrD6yBWKghZUZZ7xT+uKbo7ZjR1iWzOWcznwwnmN4eae2X0bbPKmB/lBd7bDMSOc4WKDPMqTGwLfOv6wllUWyshOKwrZkBYumKzPYU+TEzonhnxtB98AgG1LYMZEQt0mt8tJrKH5OLu6H9KzmZCm8+ncdwMWrp1JLF/E5xUlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566681; c=relaxed/simple;
	bh=Iv3L3Fv5TuFbAQ5EIXbSziOPY2wPrIySdVhnScRHPuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C04b311RLZPHnCDF/EDJ2JHWH3clntVZRfUSGz6++P21Zx+vu7ESi/ZDPCptRCBmhAmL8ElOrI3q9nIkxsMAAnpfbnQsTmWAdfLXK8wwuo0ZkT1z3X/dMHZSXZ69JdX7to3xUJ/QRynH5A5Nbkeox6A1H+pJjaDMxNwqvf7IpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRmXDL9z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRmXDL9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84725C2BCB3;
	Thu, 30 Apr 2026 16:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777566681;
	bh=Iv3L3Fv5TuFbAQ5EIXbSziOPY2wPrIySdVhnScRHPuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRmXDL9ze57UFB5ftLNSelc0YBrUO2rMtLVtw/bYNdyzIvf68KSXsXLzfAprPSY1L
	 9feOy7Ol3Bz5ZEgmBGa/ik9HWUX+f4BvgSQgzG1g1SzO4zhzG2HvxpHZy3zUhPlzVU
	 uUYjHH/ddhG65Fnd7kBNIVTfD8fFGDw6RSp53P5kSp0Iaj9qdG97uaIsWlDMYhNYj0
	 9aaszEJXP1OeCd+igZsJv3Kz8YoNzcss0SH0+oEn1SN9SDssrhCtlzw8fyF/e+EAQJ
	 iy1cieG6sqqSTuyYEHxupkOH3YgEjfi16dHeZkpjXQ60BEt/x/VN29qUventbpL0mF
	 DGqJbIilE+wUQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A8B88F40074;
	Thu, 30 Apr 2026 12:31:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 12:31:19 -0400
X-ME-Sender: <xms:14PzacrrwtON1yjcKkHqjhYD5_ZyLi0uektR0gTruZ3RAu0alNWqDA>
    <xme:14PzaQRsw_D1Rtc3w2KwhsZbBFWRBu1Wjpy7tBCyedKRjY-P8qqR3RbF7wVontDIx
    yTx-1CW2hJt6PbojNxkZT7GtDMSYqi-Qr3PlRCA8HmXCxBxfmx0h5A>
X-ME-Received: <xmr:14PzaWxbZ3k8n--2DJVyDupDgdj8iRHDm2z5c1RJMekfSEDPbHqHCvMDstSIfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeekudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepmfhirhihlhcuufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgv
    lhdrohhrgheqnecuggftrfgrthhtvghrnhepgeetuedtjefhkeeuiefgudduvdfgvdeiue
    eigeehheehudetuedtkeelhfeihedunecuffhomhgrihhnpehsrghshhhikhhordguvghv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    peiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:14PzaXgIkjN7mK-fjcY706fwrz34-Ahwp02JR4jen55dAGcmCdVQDg>
    <xmx:14Pzaa-6tSttwWx5_yzu6zpee2_fEMQUz_YmR6HeBD9hIba83taKQg>
    <xmx:14PzacPSNH9QdmMtow4Im83_MG0PzApP08Qypc6jwjNiSkI7XGyOwg>
    <xmx:14PzaYp9tbkkl3MsmSVsT-k9R6f18Cpq29ks3ImM29YVih2hdMIrTQ>
    <xmx:14PzaUeCoc1c_e-3GNtWQckdtgj4i48depaB46OtGpW4HRn9e3DmbxP1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 12:31:18 -0400 (EDT)
Date: Thu, 30 Apr 2026 17:31:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 07/14] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Message-ID: <afODmDGimJ4QUkkv@thinkstation>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-8-kas@kernel.org>
 <afOCAZ-dTQiLFN0y@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afOCAZ-dTQiLFN0y@thinkstation>

On Thu, Apr 30, 2026 at 05:28:17PM +0100, Kiryl Shutsemau wrote:
> sashiko.dev -- https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org -- wrote:
> > > @@ -1084,9 +1092,29 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
> > >  		pte_t pte, unsigned long addr, int nr)
> > >  {
> > >  	struct mm_struct *src_mm = src_vma->vm_mm;
> > > +	bool writable;
> > > +
> > > +	/*
> > > +	 * Snapshot writability before the RWP-disarm rewrite below: when the
> > > +	 * child is not RWP-armed, pte_modify(pte, dst_vma->vm_page_prot) can
> > > +	 * silently drop _PAGE_RW from a resolved (no-marker) writable PTE,
> > > +	 * so a later pte_write(pte) check would skip the COW wrprotect and
> > > +	 * leave the parent writable over a folio shared with the child.
> > > +	 */
> > > +	writable = pte_write(pte);
> > > +
> > > +	/*
> > > +	 * Child is not RWP-armed: restore accessible protection so the
> > > +	 * inherited PAGE_NONE does not cost a fault on first read.
> > > +	 */
> > > +	if (!userfaultfd_protected(dst_vma)) {
> > > +		if (userfaultfd_rwp(src_vma))
> > > +			pte = pte_modify(pte, dst_vma->vm_page_prot);
> > > +		pte = pte_clear_uffd(pte);
> > > +	}
> > Does this unconditional pte_modify() create invalid clean and writable PTEs
> > for shared mappings?
> >
> > Without checking pte_uffd(pte) first, this blindly modifies every present PTE
> > if the source VMA had RWP enabled. For shared writable mappings, vm_page_prot
> > includes _PAGE_RW. If a PTE was clean and mapped read-only to intercept the
> > first write for filesystem dirty-tracking, pte_modify() forces the write bit
> > on while preserving the clean state.
> 
> Two reasons this is safe in practice:
> 
> 1. RWP cannot reach a backing that uses the clean-RO + page_mkwrite()
>    dirty-tracking pattern. vma_can_userfault() admits RWP only on anon,
>    shmem and hugetlbfs (the ones with vm_uffd_ops); regular file-backed
>    shared mappings are rejected at register time.
> 
> 2. For backings that *do* support shared writable + dirty tracking (i.e.
>    the ones RWP isn't enabled on), the fs sets vma->vm_page_prot to RO
>    precisely so the first write traps page_mkwrite(). pte_modify(pte,
>    dst_vma->vm_page_prot) would not add _PAGE_RW in that configuration
>    either.
> 
> > Hardware writes could then bypass page_mkwrite(), leaving the filesystem
> > unaware that the page is dirty, and potentially causing silent data loss
> > upon reclaim.
> > Could this also overwrite other important PTE states like NUMA hinting
> > or soft-dirty tracking?
> 
> pte_modify() on the supported architectures preserves _PAGE_CHG_MASK,
> which covers _PAGE_DIRTY, _PAGE_ACCESSED, _PAGE_SOFT_DIRTY, and the PFN.
> NUMA hinting is encoded in the protection bits, so a transient hint
> state on a resolved (no-marker) PTE would be lost across this rewrite,
> but that's just a re-prime on the next NUMA scan, not a correctness
> issue.
> 
> > @@ -298,6 +298,16 @@ static __always_inline void change_present_ptes(struct mmu_gather *tlb,
> >      else if (uffd_wp_resolve || uffd_rwp_resolve)
> >          ptent = pte_clear_uffd(ptent);
> >
> > +    /*
> > +     * The uffd bit on a VM_UFFD_RWP VMA carries PROT_NONE
> > +     * semantics. If mprotect() or NUMA hinting changed the
> > +     * base protection, restore PAGE_NONE so the PTE still
> > +     * traps on any access. pte_modify() preserves
> > +     * _PAGE_UFFD.
> > +     */
> > +    if (userfaultfd_rwp(vma) && pte_uffd(ptent))
> > +        ptent = pte_modify(ptent, PAGE_NONE);
> >
> > For VMAs registered with both UFFD WP and RWP, could this silently upgrade
> > Write-Protected pages to Read-Write-Protected?
> 
> VM_UFFD_WP and VM_UFFD_RWP are mutually exclusive per VMA. The combination
> is rejected at registration time:
> 
>   fs/userfaultfd.c, userfaultfd_register():
>         if ((vm_flags & VM_UFFD_WP) && (vm_flags & VM_UFFD_RWP))
>                 goto out;       /* -EINVAL */
> 
> and re-registration cannot drop either bit (also -EBUSY in the same
> function), so a PTE in a WP-armed VMA can never satisfy
> userfaultfd_rwp(vma); the new branch never fires there.
> 
> [ ... ]
> > +        /* Re-arm RWP on the moved PTE if dst_vma is RWP-registered. */
> > +        if (userfaultfd_rwp(dst_vma)) {
> > +            orig_dst_pte = pte_modify(orig_dst_pte, PAGE_NONE);
> > +            orig_dst_pte = pte_mkuffd(orig_dst_pte);
> > +        }
> > +
> >          set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> >
> > Could applying PAGE_NONE unconditionally to newly moved pages trap
> > applications in an infinite fault loop?
> 
> No -- the post-MOVE access is delivered as a normal RWP fault. In sync
> mode it goes to the registered handler, which resolves it with
> UFFDIO_RWPROTECT clearing MODE_RWP; in async mode the kernel resolves
> it in-kernel and the faulting thread continues. There is no loop.
> 
> The semantics here are intentional: a VM_UFFD_RWP VMA has the contract
> that every present PTE is either an active marker or a tracked-and-
> resolved PTE whose next access will re-trap. UFFDIO_MOVE into such a
> VMA must keep that contract, otherwise the moved-in page would be a
> silent hole in the working-set view. UFFDIO_MOVE has no mode flag for
> "skip protection", by design -- the same way it has no flag to skip
> WP arming if dst_vma were WP-armed (and the equivalent could be added
> there if we ever decide UFFDIO_MOVE should preserve markers in WP
> VMAs too).
> 

Oopsie. 

I put it in reply to the wrong patch. It suppose to be for 06/14.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
