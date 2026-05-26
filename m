Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D02EC0A7
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806757; cv=none; b=ECKCTF2ENQIQJ6KxdlaJYv/kCTLcWEq9ZdSlgi8pe6ZJv7siEftWr8CZBk74w9+t2Xry5/xAUwiSuL3hXdRABACb8lzSEgXHtfXrFajKFq3orv96jKHOJgDdEKEI0gLmy3JV73gWLI6wsW9cPF6i2QCPip7enyB171Ep+WpBGcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806757; c=relaxed/simple;
	bh=OlSoUjKfAjCpA3JDq+ut7pnwGBv17WrFcd4nQT+Obs8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KIi/ci18C/BWUclX1hD1f2tMQJS+CFetJPMppDTR934gvTPMnBCr+ytT5TThL8VxRD1ElBnrtqy6kVqpSw+WWLAVqOCDv+GxtxFmIG0ZtQRkkkeLqkPvCPzEFylZulYnGlQV7YApSunfWIEGrzikig2xP0vD3d+nOoKgNyJvttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOooOXdD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOooOXdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBFB1F000E9;
	Tue, 26 May 2026 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779806755;
	bh=JBcN9ySn5SxC5lBGBuTXVocLiccR0HRM192BPePEywA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cOooOXdDEpwzXldqjH4aSbJgD/nf1GXbf2Ydv5KkLem1JWaF6K81sQgx361glnBBw
	 NXHNLIDTBY2V81+5QxphNquWIXVEwslc5+lFVR2gYCdQCcLV00JIhLekwrHXAE4hJm
	 WjDvzo3FPzqpGTIOdUqINAWWNCcRF7YOJ2WuKYfwhUHhLaP/5NygXcaljh1VqxsNnC
	 z1ubdCv+OtckqbfjcB73RmazTmxItbwcuoMmJ8mQxfSKzVWuaoD/C9YZQznq4aLAJY
	 IMPRU8dmT4esiR5nKMCAq/sdbAeLF+uTb9lOyoRPVAn39WLyrM0e+bMMCA+fLbKszy
	 mSqKN5dQofg5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/18] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-13-kirill@shutemov.name>
References: <20260526130509.2748441-13-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:45:55 +0000
Message-Id: <20260526144555.8BBFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Returning -EBUSY on mode demotion during UFFDIO_REGISTER break=
s backward compatibility.
- [High] mprotect(PROT_NONE) on a VM_UFFD_RWP VMA bypasses the FOLL_FORCE i=
nfinite loop protection.

Pre-existing issues:
- [High] Missing vma_start_write() before modifying page tables under mmap_=
write_lock() in userfaultfd_clear_vma().
- [High] Pending WP, MINOR, and RWP userfaults are not woken up during unre=
gister if the VMA lacks the MISSING mode.
- [High] PTE protections are cleared before VMA split in userfaultfd_clear_=
vma(), leading to permanent tracking loss on OOM.
--

commit 42707bcfe209a2103539574f22c32a359491aca6
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing

This patch introduces the userspace API for read-write protection tracking
(UFFD_FEATURE_RWP and UFFDIO_RWPROTECT). It adds registration logic to set
VM_UFFD_RWP and bidirectional mechanics to install or remove protection on a
range. The patch also modifies registration to reject dropping PTE marker
modes to prevent stranding markers.

> diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation=
/admin-guide/mm/userfaultfd.rst
> index e5cc8848dcb39..1e533639fd509 100644
> --- a/Documentation/admin-guide/mm/userfaultfd.rst
> +++ b/Documentation/admin-guide/mm/userfaultfd.rst
> @@ -131,6 +131,16 @@ userfaults on the range registered. Not all ioctls w=
ill necessarily be
>  supported for all memory types (e.g. anonymous memory vs. shmem vs.
>  hugetlbfs), or all types of intercepted faults.
> =20
> +.. note::
> +
> +   Re-registering an already-registered range must not drop any of the
> +   modes that install per-PTE markers =E2=80=94 currently
> +   ``UFFDIO_REGISTER_MODE_WP`` and ``UFFDIO_REGISTER_MODE_RWP``. Doing
> +   so would strand markers with no flag to describe them, so the call
> +   is rejected with ``-EBUSY``; userspace must issue
> +   ``UFFDIO_UNREGISTER`` first. This differs from older kernels, which
> +   silently replaced the mode bits on re-registration.

[Severity: Critical]
Could this behavior change break existing applications?

Older kernels allowed userspace to atomically drop tracking modes (like
VM_UFFD_WP) by re-registering the range with a smaller set of modes, silent=
ly
replacing the mode bits. Returning -EBUSY on mode demotion alters this
established behavior. Does this violate the kernel rule against breaking
backward compatibility for existing applications that rely on UFFDIO_REGIST=
ER?

[ ... ]

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e30878e4e00b7..c07e3232a01a8 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
[ ... ]
> @@ -2145,6 +2214,15 @@ static bool vma_can_userfault(struct vm_area_struc=
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
Can userspace bypass this check and cause an infinite loop?

While this prevents registering VM_UFFD_RWP directly on a PROT_NONE VMA,
userspace could register VM_UFFD_RWP on a readable VMA and subsequently call
mprotect() with PROT_NONE. Since mprotect() preserves the VM_UFFD_RWP flag,=
 a
later FOLL_FORCE access would bypass the VMA permission check, and the fault
handler would skip resolving the fault because vma_is_accessible() is false.
Would this repeatedly set the young bit and retry, resulting in an unkillab=
le
loop?

[ ... ]
> @@ -2197,9 +2275,22 @@ static struct vm_area_struct *userfaultfd_clear_vm=
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
This is a pre-existing issue, but does this require draining per-VMA locks
first?

Calling change_protection() here under mmap_write_lock without explicitly
calling vma_start_write() does not exclude concurrent per-VMA read locks.
Could a concurrent VMA-locked operation like MADV_DONTNEED trigger PT_RECLA=
IM
and free PTE pages while change_protection() is accessing them, leading to a
use-after-free?

> +		tlb_finish_mmu(&tlb);
> +	}
> =20
>  	ret =3D vma_modify_flags_uffd(vmi, prev, vma, start, end,
>  				    &new_vma_flags, NULL_VM_UFFD_CTX,
>  				    give_up_on_oom);

[Severity: High]
This isn't a bug introduced by this patch, but can an out-of-memory error h=
ere
result in permanent tracking loss?

The PTE-level userfault protections are stripped by change_protection() rig=
ht
before calling vma_modify_flags_uffd(). If vma_modify_flags_uffd() needs to
split the VMA but fails with -ENOMEM, it returns the error and leaves the V=
MA
unmodified with the tracking flags still set. Since userspace receives -ENO=
MEM
and the underlying PTEs have already been unprotected, does this allow sile=
nt,
unfaulted accesses to monitored memory?

[Severity: High]
This is a pre-existing issue, but is it possible for threads to hang
indefinitely during unregistration?

When unregistering ranges, the wake_userfault() call designed to prevent
pending threads from hanging is gated behind a check for
userfaultfd_missing(vma). If a VMA is registered purely for MODE_WP,
MODE_MINOR, or MODE_RWP (meaning VM_UFFD_MISSING is not set), that check
fails. Will threads currently blocked on a waitqueue for these fault types
hang indefinitely after the unregister operation completes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D12
