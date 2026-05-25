Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61532AE78
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711557; cv=none; b=TQS2GmLwTmoUM/qIHpgiUrWMZcMTaBfVNL3GOyTvAsyl24jr+MgTls/7FZxx+mX3b4AhLc5ukRkgU3o0x3uIe5PwemWQ5JQpnTxCMF+BnU+KBJePuomDP2T/YvI9hgHVFF6pjE/CrZTDCEZ1mT6qBqSgo3LhgTCMeksa9IOMr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711557; c=relaxed/simple;
	bh=8j7IOFAtL9gTm/LpPNiRRFdWGXf7hGmm53I4IhEHygU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pkG9E8+ElcJPi8nLqkU++ZFhzgyl1zKkXHiezHR8v0Jk2XI3N5VSKyClcsCiAnmlHtHMdDfHuYp9Udgf/hXDaiaI8zLUpUnGpbPLBppdJSEZYKgaZfgwFxm0v5kss39wvtfs9P4zMrVL6/fhcBRLFu1rlCFQOtAenyFaaidLY/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIDWMlI8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIDWMlI8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831DA1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779711556;
	bh=HK4ixZK+YJAXQj7ZNUhL4S6QabfZInMaQnVNsf+ZnZY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=oIDWMlI8GErbx7MxChMUdS0fQ9ANsBIfCNTooA4/r6NI8RtBnEtCfQTx8wYwmycn/
	 qsL3SdZe8PqmwaFnNNEXEI3/igYLNRBcszLDRfUo4vnNVyRoWR/aIzi84Ei/QZm/dO
	 YDP5xUWpXcgwwrQZO5bWRm6VT979foZAcAW5n6XmKbAhmw3lD25BQ/85+wJV0sTE88
	 K1htelF5RthwHkeeiJIY8b8zFeQ4pQ0W4mEEQhQTeRgb4PZj8PfeXLfnbpty4miXAe
	 ZKUgPj1y6yvPu78FT3v8I/9ZgqoOwLNHsO1tAChR5Lo77tfJw3D6EB5bYaWzEPyngR
	 MObvYxh+RgpTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/14] mm: add VM_UFFD_RWP VMA flag
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-5-kas@kernel.org>
References: <20260525113737.1942478-5-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:19:16 +0000
Message-Id: <20260525121916.831DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] VM_UFFD_RWP is missing from VM_COPY_ON_FORK, causing silent loss o=
f read-write protection during fork.

Pre-existing issues:
- [Critical] Evaluating __VMA_UFFD_FLAGS causes a stack buffer overflow on =
32-bit architectures.
--

commit 536d8ac75bb2e8e900819fb7cdfb4b146e00c606
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: add VM_UFFD_RWP VMA flag

Preparatory patch for userfaultfd read-write protection (RWP). RWP
extends userfaultfd protection from plain write-protection (WP) to
full read-write protection.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0f2612a70fb1e..3d0a5ac3c717c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -633,22 +639,24 @@ enum {
>   * reconsistuted upon page fault, so necessitate page table copying upon=
 fork.
>   *
>   * Note that these flags should be compared with the DESTINATION VMA not=
 the
> - * source, as VM_UFFD_WP may not be propagated to destination, while all=
 other
> - * flags will be.
> + * source: VM_UFFD_WP and VM_UFFD_RWP may be cleared on the destination
> + * (dup_userfaultfd() -> userfaultfd_reset_ctx() when the parent context=
 did
> + * not negotiate UFFD_FEATURE_EVENT_FORK), while all other flags propaga=
te.
>   *
>   * VM_PFNMAP / VM_MIXEDMAP - These contain kernel-mapped data which cann=
ot be
>   *                           reasonably reconstructed on page fault.
>   *
>   *              VM_UFFD_WP - Encodes metadata about an installed uffd
> - *                           write protect handler, which cannot be
> - *                           reconstructed on page fault.
> - *
> - *                           We always copy pgtables when dst_vma has uf=
fd-wp
> - *                           enabled even if it's file-backed
> - *                           (e.g. shmem). Because when uffd-wp is enabl=
ed,
> - *                           pgtable contains uffd-wp protection informa=
tion,
> - *                           that's something we can't retrieve from pag=
e cache,
> - *                           and skip copying will lose those info.
> + *              VM_UFFD_RWP  write- or read-write-protect handler, which
> + *                           cannot be reconstructed on page fault.
> + *
> + *                           We always copy pgtables when dst_vma has the
> + *                           uffd PTE bit in use even if it's file-backed
> + *                           (e.g. shmem). Because when the uffd bit is
> + *                           in use, the pgtable contains the protection
> + *                           information, that's something we can't
> + *                           retrieve from page cache, and skip copying
> + *                           will lose those info.

[Severity: High]
The comment mentions we must copy page tables when VM_UFFD_RWP is in use,
but it looks like VM_UFFD_RWP is not added to VM_COPY_ON_FORK in
include/linux/mm.h.

Will this cause vma_needs_copy() to return false for file-backed VMAs that
only have VM_UFFD_RWP set, and result in a silent loss of read-write
protection during fork() since the page tables won't be copied?

> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index f4cf5763f92cc..87a8cebd59387 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -21,10 +21,11 @@
>  #include <linux/hugetlb_inline.h>
> =20
>  /* The set of all possible UFFD-related VM flags. */
> -#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_WP | VM_UFFD_MINOR)
> +#define __VM_UFFD_FLAGS (VM_UFFD_MISSING | VM_UFFD_MINOR | \
> +			 VM_UFFD_WP | VM_UFFD_RWP)
> =20
> -#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_=
BIT, \
> -				      VMA_UFFD_MINOR_BIT)
> +#define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_MIN=
OR_BIT, \
> +				      VMA_UFFD_WP_BIT, VMA_UFFD_RWP_BIT)

[Severity: Critical]
This is a pre-existing issue, but does evaluating __VMA_UFFD_FLAGS cause a
stack buffer overflow on 32-bit architectures?

The mk_vma_flags() helper creates a temporary vma_flags_t struct and sets
the given bits. On 32-bit architectures, NUM_VMA_FLAG_BITS is defined as
BITS_PER_LONG (32), so vma_flags_t contains an array of exactly one
unsigned long.

Since VMA_UFFD_RWP_BIT is 43 and VMA_UFFD_MINOR_BIT is 41, does calling
__set_bit() with these values calculate an array index of 1, writing
out-of-bounds to bitmap[1] and corrupting the stack unconditionally?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D4
