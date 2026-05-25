Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776103603D1
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711073; cv=none; b=Z3TD6QIcCQ0iOTVTD+TqEfybr4lBqqEemk/qiRlhylo+bgFlreSsVJpQd7+9w//tnHewkeqcmyeUcv7Eib/ba2fFtS/sDEGdcPz48EB0bW/FSviKXuc5ypt6WhuQQ+eeteSQ11/lEasmf3q7ICtDErHrmywBFSXEMmqLHwPuIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711073; c=relaxed/simple;
	bh=PYEAcqQ1eeQUT0OwhVWZozcIIitR3v/ma5no216lFuE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XzYGZ6hXCpjsWYx72hfndkqZGjjnvV6ls27ndYYDB28lE5DqH9NcVDT5xvsePc7Hdz+5qtlDe+wBoDekbXg4HgF85L0kw49fuIqZ5O8EZV3S+fnFnn/5vYql1P3oBnTfdQQzYD19OeqejUOjQUQQ5EpGjsBXWn4DpyOT/XqYKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOp+FO9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOp+FO9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E857E1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779711072;
	bh=tGWxrp0xROrsdOYPvX1upYI/+Wdm+nEY/SaEKXEfRFo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=lOp+FO9FsWbVfPwTHYBq8JUVW4XCaUlj8+wVXBX7I7Sfkd2RWcCd+gq+UmbSjAQCI
	 2sEdw1y37vZkC1xp6Jrl7EMX8y8xb9xM856QJ6X4witEzDVI0ShpMJsil2Z1B8evD5
	 T2xCgasJnOFU++ZRayafKNl9OE7EbCJBx89OM8nzpDnbpgaRR48NfVdvKqji6QM5aQ
	 3d8VvNR6d/nPQH56Oz9P/atUc6cgbM+rta0OuMtYVN3wN9/6bP/F/Q9mMcyJC2/1qa
	 HQjUg8Wvdp6zDCUWfZWzUyaiYwbK7Udqr777VeDreFlo96SSeHaz3UspGE3LKq5+VC
	 F7jvod30Wf25A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-9-kas@kernel.org>
References: <20260525113737.1942478-9-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:11:11 +0000
Message-Id: <20260525121111.E857E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Page tables are accessed and modified under mmap_write_lock withou=
t first draining per-VMA lock holders via vma_start_write(), risking races =
with concurrent per-VMA readers.
--

commit 070cc4b99f958f7c9362bc8487c25ddf1f1b27e2
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing

This commit adds the userspace interface and plumbing for read-write
protection tracking via userfaultfd. It introduces the capabilities
and hooks necessary to register and protect memory ranges.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -2197,9 +2266,22 @@ static struct vm_area_struct *userfaultfd_clear_vm=
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

[Severity: High]
This isn't a bug introduced by this patch, but does this need a call to
vma_start_write(vma) before initiating page table operations here?

Since userfaultfd_clear_vma() is invoked under mmap_write_lock(), the
lock alone doesn't exclude existing per-VMA read lock holders. Without
draining them first via vma_start_write(), could a concurrent VMA-locked
operation like MADV_DONTNEED execute PT_RECLAIM and free PTE pages while
change_protection() is actively accessing them, resulting in a
use-after-free?

> +		tlb_finish_mmu(&tlb);
> +	}
> =20
>  	ret =3D vma_modify_flags_uffd(vmi, prev, vma, start, end,
>  				    &new_vma_flags, NULL_VM_UFFD_CTX,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D8
