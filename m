Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E5405C35
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807076; cv=none; b=rJgba8o5u8jVQ+WCCG1F2ankZTAFB7e951mFsX83f8P3BgcDfYk1jbN1I+jRVJCwoCWJJuL6uyWoVtM+wbAqyBVkq6k/RnDN26oo/JN8L/JD/dI2m5x5dih/Eprla0YpALCXyrdUIRkNRZXEOtYpaZuHnfR7/IwL3CaS30n90/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807076; c=relaxed/simple;
	bh=IbTrIZF6Ndkp8aSiz3TmUAj8p+B4S7hQykuiXmkbKi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pgvJ1nch3RGidjKlo1tHdD3LFlAz+BVhh/MM2pTPJbNoFw9F+QRAZQpq2Lj4E3mggysRTPd52/txU0/8p7gbvOsLjFhwa6a4f69xU2PG1XD6Yv0i+q4MVuIBTX9hJYZfLz+pOBE6wL2xRioRCeY9S94KvnX/QbXzTJMpfCblh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXyvZ7hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXyvZ7hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F551F000E9;
	Tue, 26 May 2026 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807075;
	bh=G+lUy/RZr9GW+5HdYAeGYtYwkbe9LjwxVwwMo6R2fWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fXyvZ7hw2JXSZUcHSzhRMNcAz/D2GnpcyMZ5k+AGat37mzMEp52ZYyfK+sqtvfw3O
	 tW5SXhxqaUjiR08X1F/5DgdgI6Mj635BEC8Ect3JJeN8DbqNzYKbgmeKaMUotv3jDe
	 qeyhIXhN9LXT36/7QbvmBKPwpwR7JPWUIA/SdNEFvsUH5fLLSUNi7MfaCFIPbBg1dC
	 fDrHyqz7rkJwP1stN2DqZQ5WutesDNM7RUSlPxtrhYIUOED9TQURMQzm8l+24Gz5Ac
	 AyXzoWqhAuYvIEtgI9PJdlaXx4wUEQvFaG3bljlqNQlzRUlGGgQG7UGh6xU88YoVAZ
	 ol5tkJLlIMYiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/18] Documentation/userfaultfd: document RWP
 working set tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-19-kirill@shutemov.name>
References: <20260526130509.2748441-19-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:51:14 +0000
Message-Id: <20260526145115.12F551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] PAGEMAP_SCAN example matches unpopulated pages as "cold", leadin=
g to an infinite loop of evicting memory holes.
- [Medium] The documentation falsely claims that UFFDIO_API does not fail w=
hen unsupported features are requested.
--

commit a8b39975821d1562e1c0e6bd26ea6ff5f6e32ba6
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

Documentation/userfaultfd: document RWP working set tracking

This patch adds an admin-guide section covering UFFDIO_REGISTER_MODE_RWP.
It details sync and async fault models, UFFDIO_RWPROTECT semantics, and
covers a typical VMM working-set-tracking workflow.

> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation=
/admin-guide/mm/userfaultfd.rst
> index 1e533639fd509..1db99b5355f71 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst

[ ... ]

> +Feature availability:
> +
> +RWP is built on top of two kernel primitives: a spare PTE bit owned by
> +userfaultfd (CONFIG_HAVE_ARCH_USERFAULTFD_WP) and architecture support
> +for present-but-inaccessible PTEs (CONFIG_ARCH_HAS_PTE_PROTNONE). When b=
oth
> +are available on a 64-bit kernel, the build selects
> +CONFIG_USERFAULTFD_RWP=3Dy and the VM_UFFD_RWP VMA flag becomes
> +available.
> +
> +UFFD_FEATURE_RWP and UFFD_FEATURE_RWP_ASYNC are masked out of the
> +features returned by UFFDIO_API when the running kernel or architecture
> +cannot support them =E2=80=94 for example 32-bit kernels (where VM_UFFD_=
RWP is
> +unavailable), kernels built without CONFIG_USERFAULTFD_RWP, and
> +architectures whose ptes cannot carry the uffd bit at runtime (e.g. riscv
> +without the SVRSW60T59B extension). UFFDIO_API does not fail;
> +unsupported bits are simply absent from uffdio_api.features on return.

[Severity: Medium]
Is this description of UFFDIO_API behavior accurate?

Looking at userfaultfd_api() in mm/userfaultfd.c, the kernel validates
the requested features against what is supported, and branches to an
error path returning -EINVAL if unsupported features are requested:

	if (features & ~uffdio_api.features)
		goto err_out;

Because the ioctl fails, the userfaultfd context remains uninitialized,
and any subsequent ioctls on that fd (such as UFFDIO_REGISTER) will fail.
Should the documentation advise users to first query available features
with a zero-feature UFFDIO_API call rather than assuming it will not fail?

[ ... ]

> +Cold Page Detection with PAGEMAP_SCAN:
> +
> +RWP-protected PTEs carry the uffd PTE bit; the fault-resolution path
> +clears it. PAGEMAP_SCAN reports PAGE_IS_ACCESSED once the bit is
> +clear on a VM_UFFD_RWP VMA, so inverting it efficiently reports the
> +still-protected (cold) pages::
> +
> +    struct pm_scan_arg arg =3D {
> +        .size =3D sizeof(arg),
> +        .start =3D guest_mem_start,
> +        .end =3D guest_mem_end,
> +        .vec =3D (uint64_t)regions,
> +        .vec_len =3D regions_len,
> +        .category_mask =3D PAGE_IS_ACCESSED,
> +        .category_inverted =3D PAGE_IS_ACCESSED,
> +        .return_mask =3D PAGE_IS_ACCESSED,
> +    };

[Severity: Medium]
Will this configuration also match unpopulated pages (memory holes) as
"cold" regions?

Since pagemap_page_category() returns 0 for unpopulated pages, evaluating
(0 ^ PAGE_IS_ACCESSED) & PAGE_IS_ACCESSED inside=20
pagemap_scan_is_interesting_page() results in true.=20

Later in the documentation, the VMM loop example uses this same mask:

[ ... ]

> +        /* 3. Find cold pages (uffd bit still set) */
> +        ioctl(pagemap_fd, PAGEMAP_SCAN, &(struct pm_scan_arg){
> +            .category_mask =3D PAGE_IS_ACCESSED,
> +            .category_inverted =3D PAGE_IS_ACCESSED,
> +            .return_mask =3D PAGE_IS_ACCESSED,
> +            ...
> +        });
> +
> +        /* 4. Evict cold pages (vCPU faults block on guest_mem) */
> +        for each cold range:
> +            /* Read from io_mem -- bypasses RWP, no fault. */
> +            pwrite(storage_fd, (char *)io_mem + cold_offset,
> +                   len, cold_offset);
> +            /* Drop the page from the shared file. */
> +            fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +                      cold_offset, len);

If unpopulated ranges are included in the results, does this create an
infinite loop where the VMM continually reads zeroes from io_mem (allocating
new zero pages), writes them to storage, and calls fallocate() on an existi=
ng
hole?=20

Since a hole never acquires the PAGE_IS_ACCESSED bit, the next scan would
find the exact same ranges. Should PAGE_IS_PRESENT be included in
category_mask (but not category_inverted) to safely skip memory holes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D18
