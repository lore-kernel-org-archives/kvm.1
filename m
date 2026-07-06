Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F783DEFFC
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328780; cv=none; b=ej3JtF5wi2kMyUFJFLghDv+PkHkiif91BRSYV1qUCphIUTUd0YGY//ssrvBbbnurvYPagOlDerCByYPFMbJOuzdHxztExxRVewpepthhWsdGrGrs/KO9JXiLLpiNBf0EzitwahZic+ByjSmgiBClIs2PjV8n0XMk1KPmifE8SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328780; c=relaxed/simple;
	bh=kS92vDMVfrYq6f0tZBkh/mCE/rDrZb8bpIM0bllBrV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=elIGfn7GlT2YJ8FNPoGJz3yE3VnzehHINtwepxIY/Gp66ZLPtcEHSEoqj72aKVHeYK7GpzNmpnIOX9d1NhdHwkAtKlY4+VPUl8/I6poECn71MORHWGh5M0tvxdFADHDho8wcwMebxKFRS3FkadL+h0hwoakjakyrdWqccikRAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcxtixIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcxtixIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22751F000E9;
	Mon,  6 Jul 2026 09:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783328770;
	bh=wNM0e91oeRIgIhnNDSrcV8zZBgZCkbjB/lr6bWF7Jkc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VcxtixIu1VwzdwJm19l5BwtV+NqUKZstJI0ClqpQ2F0N6XG0PIj/Ipy5ZEwsgvPDf
	 kRhR8F5zwOhk0HpbNxaHLm5U9KMdUu89liVebfqg1k6sqVUHEeiUpg8W5gNKOU+IBF
	 Lyzyi70gvR5/dS24WFdhc8GGqrkJGarJqNcQfw95YuXsssqBLcZ9WwP9OYlRuHIyp6
	 Ltk+6hp7N7CFsnT3/ydGSqSvc+Bk8hUSMpR9vr7aqsNxM1biuVO7Bf4H7b1O3gXDg6
	 Dfu0kdysTh8VizfEuy0FYgLeVMInBfP2WxgB8KUpYScpcmf2k38SDbEametRxVkCUh
	 DLBnjSO87/oXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/15] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-10-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-10-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:06:09 +0000
Message-Id: <20260706090609.E22751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] userfaultfd_clear_vma() accesses page tables under mmap_write_=
lock without calling vma_start_write(), creating a race condition with per-=
VMA lock readers.
- [High] Page table protections are irreversibly removed before VMA modific=
ation in userfaultfd_clear_vma(), leading to silent protection bypass if th=
e VMA split fails.
- [High] UFFDIO_MOVE silently drops userfaultfd-wp state when moving presen=
t PTEs, allowing write-protection bypass.
--

commit 779f7c298ffcc5e60ea489eabca7842a2492efa5
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing

This patch adds the userspace interface for read-write protection tracking
via userfaultfd. It introduces the UFFDIO_REGISTER_MODE_RWP register mode
and the UFFDIO_RWPROTECT ioctl.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2204,9 +2273,22 @@ static struct vm_area_struct *userfaultfd_clear_vm=
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
This is a pre-existing issue, but does this code race with per-VMA lock
readers?

When userfaultfd_unregister() iterates over VMAs under mmap_write_lock and
calls userfaultfd_clear_vma(), it accesses and modifies page tables via
change_protection() without first isolating the VMA using vma_start_write().

Because vma_start_write() is missing, the mmap_write_lock holder does not
wait for concurrent per-VMA lock readers, like MADV_DONTNEED, to finish.

This can result in a use-after-free if the reader frees the PTE page while
change_protection() is active.

> +		tlb_finish_mmu(&tlb);
> +	}
> =20
>  	ret =3D vma_modify_flags_uffd(vmi, prev, vma, start, end,
>  				    &new_vma_flags, NULL_VM_UFFD_CTX,

[Severity: High]
This isn't a bug introduced by this patch, but could this sequence lead to
silent protection bypass if the VMA split fails?

Because change_protection() unconditionally strips the userfaultfd markers
from the PTEs before calling vma_modify_flags_uffd(), if the modification
fails, for example by returning -ENOMEM from hitting the max_map_count limi=
t,
the ioctl will abort with an error.

The PTEs are left fully accessible while the VMA still retains its tracking
flags, silently breaking the memory tracking.

[ ... ]

> @@ ... @@ move_present_ptes(...)
> {
> [ ... ]
> 	orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot);
> 	/* Set soft dirty bit so userspace can notice the pte was moved */
> 	if (pgtable_supports_soft_dirty())
> 		orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
> 	if (pte_dirty(orig_src_pte))
> 		orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
> 	orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);

[Severity: High]
This is a pre-existing issue, but does UFFDIO_MOVE silently drop the
userfaultfd-wp state here?

When moving a present PTE, the destination PTE is made writable via
pte_mkwrite() without checking if the source PTE was uffd_wp protected.

Because it does not apply pte_mkuffd() for WP ranges, the destination
page becomes fully writable and loses its tracking marker.

This allows subsequent writes to bypass the userfaultfd WP trap.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D9
