Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525162;
	b=YiiYXQSBKCkzChofWPb4J2AI59O/0/vHkZfdVMevLJw0kNr7BXovHjNtbweAG8Dg58pv
	 EaW5N7fN9xeFMfB9sSnqHwTOF59NA0kFSUnTd2d7XQWQoB2y+E73L8QjIqm/PBUSgPGLK
	 02tCGQx1V3VOfHyY4Fh1WeImObBMY0cQCvF8ebvLl7pP24ke6HhgYEvP8VcivFmt/mgvN
	 jAAuoHyN8ReLwSpttCvYFADW01SYq/c4CA2gIbgasNgks7aal/79bCy3G3TGCoHnVrbnW
	 r1qG+Hc3uoeE95a4HE3afRXlz3mVBwbSCoL14W1lV+ZByHAsFm8qJY4zLCf/AOnuITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525162;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WDlpkBAU5bWLUwgSalMbLEEAw3Xg/HUJCG3vY+sENKM=;
	b=BzxdHgMdDktF9ZxfzEaaDhYhSceMb6e3kkGTy9LdN7SI2/xnEccf6ONw9Yd3aGqzfePQ
	 ch/OGC1/7uY6G4cRT1Pm4EsaMoiGiNe504Yufvqg/wA9qrnsSN7z38Ah73m9Ymv5RMWcz
	 jiaQyqOFjB8jzLWEyp64Q6148cJWG00a49MbJGUAjiJyCzqR+sRCrQSy8Vn6ARFBZ07je
	 7zj8GI5Orn61te5ZbSGjhB6wG/KIxOWYpnlupcmpEJ/iJJR3KKNVHaUr1bh+c8XfYzjlN
	 8dPCqQUF1KZKP+T3oruuks8DxmCUgH/Kpt6LhUYW9rJ9jEXzKUU3Mqxx2AVndwK4JBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0Zchk9g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F688606A336
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0Zchk9g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D511F000EC;
	Tue, 24 Nov 2026 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525162;
	bh=WDlpkBAU5bWLUwgSalMbLEEAw3Xg/HUJCG3vY+sENKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H0Zchk9gmd3hUDSjrBNwfT9NQu7AStd/smlsWGXqz2WNZ6wIfb2DXtBs4jmXmw9GS
	 HP0cjBTD9Ovlbd1QzZ6qiFfUzvHIa/SjFfrbHt4AJd/GiLskl7FSF9nQN8vtRNLl95
	 0e/fQAkyCdE+SFqbvLUtfgXlUBMnx3+vvdCtflyBVRMWrK6LmhCKg0SAaBSfruwCyy
	 N/+JVaejOFn2XB3lYEs5P6tdWRgeKpqSgmMlTKEAcokUORb+X4J2f8NvyOaiIeTfL6
	 hsV3noPG0GGy0q9O9BAd9l6a1jm9BUBFiXCCkQRo3dmBfjJ5eZCoZRdnVjMkn2sbR2
	 sKGUA2t/6r4Cg==
Message-ID: <sashiko-outbox-231185@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] vfio/pci: Align BAR mappings for huge page
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-3-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:59:21 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio/pci: missing PMD_SIZE fallback in
  vfio_pci_core_get_unmapped_area()
--

commit 3832a7d37e0d4c0624cff5984fcc1260c28a37ab
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio/pci: Align BAR mappings for huge page support

This commit implements vfio_pci_core_get_unmapped_area() to align BAR VMA
addresses to PMD_SIZE or PUD_SIZE and sets VM_HUGEPAGE on BAR mappings so
vfio_pci_mmap_huge_fault() can install huge pfnmaps.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index f2d5b6857925f..a1ccdd5f4657f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1878,12 +1879,106 @@ int vfio_pci_core_mmap(struct vfio_device *core_=
vdev, struct vm_area_struct *vma
[ ... ]
> +unsigned long vfio_pci_core_get_unmapped_area(struct vfio_device *core_v=
dev,
> +					      struct file *filp,
> +					      unsigned long addr,
> +					      unsigned long len,
> +					      unsigned long pgoff,
> +					      unsigned long flags)
> +{
[ ... ]
> +	/*
> +	 * Select the largest huge page size that the BAR physical alignment,
> +	 * mapping length, and arch support can all satisfy.  Only PMD and PUD
> +	 * orders are supported by vfio_pci_vmf_insert_pfn().
> +	 */
> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) &&
> +	    bar_len >=3D PUD_SIZE && len >=3D PUD_SIZE)
> +		align =3D PUD_SIZE;
> +	else if (bar_len >=3D PMD_SIZE && len >=3D PMD_SIZE)
> +		align =3D PMD_SIZE;
> +	else
> +		goto out;
> +
> +	off =3D pgoff << PAGE_SHIFT;
> +	off_end =3D off + len;
> +	if (off_end < off)
> +		goto out;
> +	off_align =3D round_up(off, align);
> +
> +	/* The mapping has to span at least one fully aligned huge page */
> +	if (off_end <=3D off_align || off_end - off_align < align)
> +		goto out;
> +
> +	len_align =3D len + align;
> +	if (len_align < len)
> +		goto out;
> +
> +	/*
> +	 * Find an area that can hold the mapping plus the slack needed to
> +	 * shift it up to the next aligned address, then apply that shift.
> +	 * The shift preserves the relative alignment of the file offset,
> +	 * which is what makes the pfn alignment work out.
> +	 */
> +	addr_align =3D mm_get_unmapped_area(filp, addr, len_align, pgoff, flags=
);
> +	if (!IS_ERR_VALUE(addr_align)) {
> +		addr_align +=3D (off - addr_align) & (align - 1);
> +		return addr_align;
> +	}
> +
> +out:
> +	return mm_get_unmapped_area(filp, addr, len, pgoff, flags);
> +}

[Severity: Medium]
Should vfio_pci_core_get_unmapped_area() fall back to PMD_SIZE when
PUD_SIZE alignment cannot be satisfied?

When CONFIG_ARCH_SUPPORTS_PUD_PFNMAP is enabled and both bar_len and len
are at least PUD_SIZE, align is set to PUD_SIZE before checking whether
[off, off_end) spans a PUD_SIZE-aligned boundary or whether
mm_get_unmapped_area() can find a len + PUD_SIZE range.  If a mapping on a
2 GiB BAR starts at a non-1GiB-aligned offset (for example to skip an
MSI-X table at the start of the BAR) and does not enclose a full 1 GiB
PUD page, or if virtual address space is too fragmented for len + PUD_SIZE,
this jumps straight to out and returns a PAGE_SIZE-aligned VMA.
is_aligned_for_order() in vfio_pci_mmap_huge_fault() then fails for
PMD_ORDER as well, degrading the entire mapping to PAGE_SIZE faults instead
of using PMD huge pfnmaps.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124124004.4574=
41-1-guanghuifeng@linux.alibaba.com?part=3D2
