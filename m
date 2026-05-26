Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DA3FD14D
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806228; cv=none; b=BmmXtGCWNZFlEzNwNP0o0c7V6XL88Vl8SOiEdpm1J8ZagIItDhPhKP1xC9mfk0HG5UqE6h2omIBmw6aDoXNqee2V4MfB1CorUos7ag6Hu7CzWyDiU4ek2P5vE6plfXzvH3IzY/4n4xpE6QkZpz6C6A5/qq+C1hb7hryOcLQmPtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806228; c=relaxed/simple;
	bh=I/Mr+p3mZhc/k6kuBenv+v8TS7coU8nZvi9WTG9ba9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sx23YN4zDTTKmdctGPycr4ivNSRH+r+3dZUFmUt8wkk09QwcrxQtR9Ce50s6NzCfVZ0/ifP8fzr+NbFwLWEvJ46H1cVNQiV8xp/QAMUZXnpDlp73SQZ64rnna/Iwxbtz5gzqhmnzYSZTdO6LMXCZhqMKDturEL4JRgwm/nsrFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkCUqnwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkCUqnwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA6F1F00A3A;
	Tue, 26 May 2026 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806227;
	bh=Yq1l8cFd9YhBoBMdFDfq16H/m9C3qVbfofJdM40Sf7I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkCUqnwtaXXN54gym5/m0UUcOD9N1WclQkQF/FSA8FfjbVBF89m5tGHPRjSy0SQYn
	 8LYZaVfj5cCOlApyOPfdXYRC3jDT4CSDJ+Y8K49x5mt7d2rrVGw7YGSjbNjCNSAiE+
	 SMGuojs24ZXBRXPcpCrjuZWaRRLyzYn+aLDDou9LCzotMMuxqpOhS4HhInWaR/ed3v
	 hGeSlw+jZ5dKrbnsMwx2m+RpRR1/k09DIY9Az9ieqoX1nQBtO0lPfsUnVmJcFN5PmE
	 EhSLcZ9hCzFPNDd2tA8mwhFHloGCpxOr0CsHGbRO3GPZwXcdHnxtLsu3UkynRYHdzI
	 LGn5G/oC+qV0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/18] mm: add VM_UFFD_RWP VMA flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-9-kirill@shutemov.name>
References: <20260526130509.2748441-9-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:37:06 +0000
Message-Id: <20260526143707.1CA6F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] VM_UFFD_RWP is omitted from the VM_COPY_ON_FORK macro, causing a s=
ilent loss of read-write protection on fork().
- [High] uffd_disable_fault_around() does not disable fault-around for VM_U=
FFD_RWP, allowing protection bypass.
- [High] Writenotify tracking functions (vma_wants_writenotify and userfaul=
tfd_set_vm_flags) were not updated for VM_UFFD_RWP.
--

commit 1a72a826ec6ad5940fb59c87116744dd2190e095
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
Subject: mm: add VM_UFFD_RWP VMA flag

This commit reserves the VM_UFFD_RWP flag and adds helpers like
userfaultfd_rwp() and userfaultfd_protected() to prepare for userfaultfd
read-write protection (RWP). It also updates the smaps output and trace-flag
tables.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 71b11945e4fc0..6499cfb61dc4b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -642,22 +648,24 @@ enum {
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
>   *
>   *          VM_MAYBE_GUARD - Could contain page guard region markers whi=
ch
>   *                           by design are a property of the page tables

[Severity: High]
Does this code silently lose read-write protection on fork() for file-backed
mappings?

The documentation above explicitly states that VM_UFFD_RWP requires page ta=
ble
copying. However, it seems VM_UFFD_RWP was not added to the VM_COPY_ON_FORK
macro in include/linux/mm.h:

#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_MAYBE_GU=
ARD)

Without VM_UFFD_RWP in this macro, vma_needs_copy() will return false during
fork(). The child process will skip copying the page tables and instead fau=
lt in
fully accessible PTEs directly from the page cache, bypassing RWP tracking.
Should VM_UFFD_RWP be included in VM_COPY_ON_FORK?

> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index f4cf5763f92cc..0aef628514df2 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
[ ... ]
> @@ -178,7 +179,7 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(st=
ruct vm_area_struct *vma,
>   */
>  static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vm=
a)
>  {
> -	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
> +	return vma->vm_flags & (VM_UFFD_MINOR | VM_UFFD_WP | VM_UFFD_RWP);
>  }

[Severity: High]
Is it possible for fault-around to bypass RWP tracking here?

Just below this function in include/linux/userfaultfd_k.h, there is
uffd_disable_fault_around(), which was not updated to include VM_UFFD_RWP:

static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
{
	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
}

If a read fault occurs on a file-backed VMA with RWP enabled, it seems the
kernel will still trigger do_fault_around() and prepopulate surrounding pag=
es
with accessible PTEs without notifications. Subsequent reads and writes to
these pages would not trap. Does uffd_disable_fault_around() need to check =
for
VM_UFFD_RWP as well?

[ ... ]
> @@ -208,6 +209,16 @@ static inline bool userfaultfd_minor(struct vm_area_=
struct *vma)
>  	return vma->vm_flags & VM_UFFD_MINOR;
>  }
> =20
> +static inline bool userfaultfd_rwp(struct vm_area_struct *vma)
> +{
> +	return vma->vm_flags & VM_UFFD_RWP;
> +}
> +
> +static inline bool userfaultfd_protected(struct vm_area_struct *vma)
> +{
> +	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
> +}

[Severity: High]
Does writenotify tracking miss write accesses for RWP-protected shared
mappings?

This patch introduces the userfaultfd_protected() helper, but it appears so=
me
critical tracking functions were not updated to use it or check for
userfaultfd_rwp().

In mm/vma.c:vma_wants_writenotify(), only userfaultfd_wp() is checked:

	/* Do we need write faults for uffd-wp tracking? */
	if (userfaultfd_wp(vma))
		return true;

Similarly, mm/userfaultfd.c:userfaultfd_set_vm_flags() only recalculates VMA
protections when VM_UFFD_WP changes:

	const bool uffd_wp_changed =3D (vma->vm_flags ^ vm_flags) & VM_UFFD_WP;
	...
	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
		vma_set_page_prot(vma);

Without updating these to include VM_UFFD_RWP, won't newly faulted pages
in an RWP-protected shared mapping be mapped as writable, thus bypassing RW=
P?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D8
