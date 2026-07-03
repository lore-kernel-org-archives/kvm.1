Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113183E5ED4
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089194; cv=none; b=U4cKzwSE0SE8LC9aerXMuD8L/Z3lB270O3Yv007WZszvpgeA5EJ7gTdFJkK31uGRE0vnGwbgLEpa4SwmHLzL99RvUMHrtVlfUHSjLw8Z9otQnqeHlyGHdcweTdNc1hbGakFrUEng8wnLmBeS1d7sihKb2DLI48e+/T9cAV4z4Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089194; c=relaxed/simple;
	bh=kfzu5/w0txewS+fkDODXWbbqJttEOtC614TdU4ZzB2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJbZhTCtmoNNJgL1LOrbQWkjPn0/83ONS5GBLD+JNLPesjMWCGdsdErTt2O5HRE9E8vQEv7rYTPMgAHquk7MZ3P2OWfmxN1L9slZrcdqxvaTS4UYAAJbsFzCCcu21JWRmQZpxWHCPCqrxin/Rbe7TBX+C/rgGO02XSTWD6JVmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUH21kMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUH21kMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389D61F000E9;
	Fri,  3 Jul 2026 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783089191;
	bh=x1SXw3OaYau9rxzcNPOvcsZSbsqPoQOtn6Grtc3VP5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lUH21kMoJzBHO3ZGf1jCfcJE6xmx6DXZ52LeUgFS1iQDOF7Urp8r0PMgSht6Toj2s
	 QtcOm6oEz7F+gTNZx52w1CedVzNww+gvPO0xpqvoy9RdqdEFJoPLNZKmUMGzP/3aYZ
	 fMyHWIHtRoaIjWeUQZJsCnmG+8CVr7hJB8MnjTgendd7gV28a6g6JJVJYsAaFENd2M
	 8ynoZykU3Ljn1oT+RCaK6qzNaDL01uq+QLA/hiGWx/KSKypQt2jfqOpR6RhzpWsjJz
	 Kdd4HUmqrDqk0u/jKFEM6eKTMh4tkjEWzbHxBmSyII79YaVtV/rYE22/ILpAL2c852
	 v7UII8AeTXZ8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 09/15] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-10-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-10-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:33:10 +0000
Message-Id: <20260703143311.389D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unrestricted mprotect() on RWP-registered VMAs allows userspace to=
 bypass accessibility constraints, leading to UFFDIO_UNREGISTER denial of s=
ervice and FOLL_FORCE infinite loops.

Pre-existing issues:
- [Critical] userfaultfd_clear_vma() modifies page tables under mmap_write_=
lock without first calling vma_start_write(), allowing races with concurren=
t per-VMA read lock operations.
- [High] Incomplete rollback on OOM during partial userfaultfd_unregister l=
eaves VMA and PTE state inconsistent.
--

commit c5a9fac2c85eb7e6b0745bb04ca3c91f8a7a0f38
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing

Add the userspace interface for read-write protection tracking,
including UFFDIO_REGISTER_MODE_RWP, UFFD_FEATURE_RWP, and
UFFDIO_RWPROTECT. Introduces CONFIG_USERFAULTFD_RWP and integrates
RWP handling into userfaultfd core.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -2152,6 +2221,15 @@ static bool vma_can_userfault(struct vm_area_struc=
t *vma, vm_flags_t vm_flags,
>  	    !vma_is_anonymous(vma))
>  		return false;
> =20
> +	/*
> +	 * RWP uses protnone as an access-tracking marker. PROT_NONE VMAs
> +	 * have vm_page_prot =3D=3D PAGE_NONE, so RWP resolution can't make a
> +	 * page accessible -- the next access would fault again. Reject up
> +	 * front instead of letting FOLL_FORCE loop on protnone+uffd PTEs.
> +	 */
> +	if ((vm_flags & VM_UFFD_RWP) && !vma_is_accessible(vma))
> +		return false;
> +

[Severity: High]
Could this accessibility constraint be bypassed by mprotect() after the
VMA is already registered for RWP?

vma_can_userfault() correctly prevents initial RWP registration on
PROT_NONE VMAs. However, mprotect_fixup() preserves VM_UFFD_RWP when
changing a VMA to PROT_NONE later.

If userspace registers a readable VMA for RWP and then calls
mprotect(PROT_NONE), the VMA enters the exact state this check intended
to prevent.

Would a subsequent FOLL_FORCE access (e.g. via /proc/self/mem) skip RWP
resolution in handle_pte_fault(), fail to resolve the PROT_NONE state,
and retry infinitely?=20

If FOLL_WRITE is used, could it trigger do_wp_page() to copy and allocate
new PROT_NONE pages infinitely?

Also, wouldn't this prevent the VMA from being unregistered, since
userfaultfd_unregister() calls vma_can_userfault() which would now reject
the inaccessible VMA?

[ ... ]

> @@ -2204,9 +2282,22 @@ static struct vm_area_struct *userfaultfd_clear_vm=
a(struct vma_iterator *vmi,
>  	if (start =3D=3D vma->vm_start && end =3D=3D vma->vm_end)
>  		give_up_on_oom =3D true;
> =20
> -	/* Reset ptes for the whole vma range if wr-protected */
> -	if (userfaultfd_wp(vma))
> -		uffd_wp_range(vma, start, end - start, false);
> +	/* Clear the uffd bit and/or restore protnone PTEs */
> +	if (userfaultfd_protected(vma)) {
> +		unsigned int mm_cp_flags =3D 0;
> +		struct mmu_gather tlb;
> +
> +		if (userfaultfd_wp(vma))
> +			mm_cp_flags |=3D MM_CP_UFFD_WP_RESOLVE;
> +		if (userfaultfd_rwp(vma))
> +			mm_cp_flags |=3D MM_CP_UFFD_RWP_RESOLVE;
> +		if (vma_wants_manual_pte_write_upgrade(vma))
> +			mm_cp_flags |=3D MM_CP_TRY_CHANGE_WRITABLE;
> +
> +		tlb_gather_mmu(&tlb, vma->vm_mm);
> +		change_protection(&tlb, vma, start, end, mm_cp_flags);

[Severity: Critical]
This is a pre-existing issue, but does userfaultfd_clear_vma() modify
page tables before draining per-VMA readers?

The kernel VMA locking guidelines require that mmap_write_lock() holders
call vma_start_write(vma) before modifying page tables. This excludes
per-VMA lock readers.

Here, change_protection() modifies PTEs before vma_modify_flags_uffd()
is called. Could this race with concurrent per-VMA operations like
MADV_DONTNEED that might modify or free the page tables while
change_protection() is walking them?

> +		tlb_finish_mmu(&tlb);
> +	}
> =20
>  	ret =3D vma_modify_flags_uffd(vmi, prev, vma, start, end,
>  				    &new_vma_flags, NULL_VM_UFFD_CTX,
>  				    give_up_on_oom);

[Severity: High]
This is a pre-existing issue, but what happens if the subsequent VMA split
fails due to OOM?

change_protection() unconditionally resolves the UFFD protection on all
PTEs in the range before vma_modify_flags_uffd() executes.

If vma_modify_flags_uffd() returns -ENOMEM during a partial unregister, it
aborts and the error is returned to userspace.

Does this leave the VMA retaining the VM_UFFD_WP or VM_UFFD_RWP flag,
while the underlying PTEs have been permanently unprotected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D9
