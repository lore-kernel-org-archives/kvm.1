Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE73D9680
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087712; cv=none; b=kj8wZrMl53YLmxEu1dtzidoub+KasULZkN1PKDvDkPkh2qO3z10AxJAa8A4VQMzJbU5JE8nv2toMLM6Z6PvpZwnVuuZbvHvH/jhsG9GHuWnujhsOk+M9Kz2k+U/gQ6hFI3j9stPkdDX1VdhqbzuwlljAMKgcXSJOT8sOu5hT5Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087712; c=relaxed/simple;
	bh=kurBb7c8egPJ3ZTdPXHdEuTgPJAOoy7LiZfVrGQ4zSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBsStDfsc1uACXVle8T2Qj/BRcRA+NqDX2QtwChyJ5v7vE2pdtMpM7UQeW99lBkQ5W1e+72oSV5r9DLX0aPBEIQ06klNhtbww+XjhG11mD4ZaKztGaJWkkc6JU8YjYsauebNhy+gjc/m9peREO0zDD6C7WpP/U7I1NoI3H5QB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJhBW5T8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJhBW5T8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9B91F000E9;
	Fri,  3 Jul 2026 14:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087711;
	bh=OsJmokvtfskMQWKTZMQXrYDbzsarKKTkkdH0cFFxMkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJhBW5T8p0mZGKyUQZIhgd0OuWSl2Fo5aw8X+5al7GidF2Y547/GLwwuJ0L2q9VGQ
	 NDlG59aPewzPlBhoHWXgGQRqF2voeGa1G/bGLrFHq+6zkqj3RJlT4M64Mm1cLoJwE2
	 h06zE44K/xUIpAWxqgav4LIx9MIQ3/nZo18z0mkrkhHMpctzs0jYp4K85+HWf99Zfu
	 q+a9PJkD/RMNvLtTmE8GXVlTZmzLRRIpf7nZAeovJmjMKXM84an+sZ5OCIZDUYzJdA
	 MP/AdOlhejqMZ8jby97dl0eBS8eL0OBkHQl0SWIszBJj5tVBCQIqKHZ5l7LJiAQSyD
	 oqYmVPH1cq2rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/15] mm: add VM_UFFD_RWP VMA flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-6-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-6-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:08:30 +0000
Message-Id: <20260703140831.1C9B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] uffd_disable_fault_around() does not disable fault-around for VM_U=
FFD_RWP, allowing silent bypass of read-write protection.
--

commit ed61c5fa2ad8a9cc1e93f82dbad086bff3df2b4c
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: add VM_UFFD_RWP VMA flag

Preparatory patch for userfaultfd read-write protection (RWP). RWP
extends userfaultfd protection from plain write-protection (WP) to
full read-write protection: accesses to an RWP-protected range --
reads as well as writes -- trap through userfaultfd.

> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c4f2cc6dfcf01..61ea83dbd0268 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h

[ ... ]

> @@ -179,7 +180,8 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(st=
ruct vm_area_struct *vma,
>  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vm=
a)
>  {
>  	return vma_test_any_mask(vma,
> -		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
> +		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR,
> +					VMA_UFFD_RWP));
>  }
> =20
>  /*

[Severity: High]
Should VMA_UFFD_RWP also be added to uffd_disable_fault_around() which is
defined just below this function?

Looking at uffd_disable_fault_around() in include/linux/userfaultfd_k.h:

static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
{
	return vma_test_any_mask(vma,
		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_MINOR));
}

If VMA_UFFD_RWP is missing from this check, will it allow filemap_map_pages=
()
to bypass the read-write protection?

When a VMM registers a file-backed or shmem VMA with UFFDIO_REGISTER_MODE_R=
WP
and a guest accesses a missing page, do_read_fault() calls
should_fault_around().

Because VMA_UFFD_RWP is not checked in uffd_disable_fault_around(),
it proceeds to do_fault_around().

This allows filemap_map_pages() to preemptively install up to 15 neighboring
PTEs with standard readable permissions and no _PAGE_UFFD marker.=20

Subsequent accesses to the fault-around populated pages will succeed native=
ly
without delivering a message to the userfaultfd handler, which causes a
regression in the RWP sync trap guarantee.

In async mode, PAGEMAP_SCAN will falsely report these unaccessed pages as
PAGE_IS_ACCESSED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D5
