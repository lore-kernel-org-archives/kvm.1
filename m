Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBC413249
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807894; cv=none; b=onhwyIJqY1NqA3dVF2biFWk0fIilTF3AO7fF439Zbfz8nh550wMpVSKaToStLCmuCE4Xn5/ZX93hIQw3z4ncrIV8snA4FGtZiWKqDvi4E+3m52RefLDe5rmHJ4X+b0bGh6tUGt5PgPdcmr8kF5xOKf5ZhoOHECOJzTfl/iFRtdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807894; c=relaxed/simple;
	bh=kN6DSOVVay1sWBF7Mg4fh0cQ7Cz+GyVINDudfhkC2z4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=srwlgTzY/gOXxrAp4+qhzxrbnIiqTQJ4z8aHm0r0yne0Dw71D0+y6wHLmVB0n4eQm2ToRK8+eXFeQ3+aO7mgPRaECUR9SkSH4do194Mw2f8FufsOLuAZIuna52ASIeHgppLRnD7XD9blHTQYBBzE+1hy1yorbt5/Ert3qSbaSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5VeSZ1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5VeSZ1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E11F000E9;
	Tue, 26 May 2026 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807892;
	bh=bmP7ThFkeB5LHXx44zfBcbMh10XKtFBUl/4E5uCU05k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5VeSZ1JBJL6boa1n8qms6ruh9IWO0ma5FEZ+lEKVltRlhxo98P1YACfVUhumOTbt
	 j4tJZm/dKlZPbqLh1p8hpD6KDRZM1VA+n3mMxADhWo7VWUO+VfjNy+vv9RT83UF1/E
	 gZ0LQLv8fp79fKuKpIhtY0OAHe26QzulxNYgt4QLwzHYBCaWOk0h4mSQyIDvcC15kJ
	 3T5uHQvr5S46FJxS+XFRoZ5mxMIrylSLgNe08C3f0aUrqMsY7RnqEepV6a4Lm526wu
	 6TY/T0QQId1JagDyDiQHyA6/6sY+O2TLRXlIkIfCkvgKatz3+NV+hTpvnVY+w5IF10
	 Lg5sbSqdHpBsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/18] mm: handle VM_UFFD_RWP in khugepaged, rmap,
 and GUP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-12-kirill@shutemov.name>
References: <20260526130509.2748441-12-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:04:51 +0000
Message-Id: <20260526150452.529E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The core PTE marker and page table zapping infrastructure relies o=
n `userfaultfd_wp()`, failing to handle `VM_UFFD_RWP`. This silently destro=
ys per-PTE RWP state on page eviction, zapping, unpopulated ranges, and for=
k().
- [High] VM_UFFD_RWP faults are silently intercepted and neutralized by the=
 NUMA hinting fault path, completely bypassing userfaultfd for both normal =
faults and GUP.
--

commit 4688bfa88370018fed03e894adb7bc1c3b2fc6b0
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP

This commit extends khugepaged, rmap, and GUP to treat the VM_UFFD_RWP
flag the same as VM_UFFD_WP, ensuring per-PTE RWP state is not destroyed
or bypassed.

>     Three mm paths outside the fault handler gate on the uffd PTE bit
>     today: khugepaged (skip collapse on ranges carrying markers), rmap
>     (cap unmap batching), and GUP (force a fault through
>     gup_can_follow_protnone). Extend each to treat VM_UFFD_RWP the same
>     as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
>     bypassed.

[Severity: High]
Does the core PTE marker and page table zapping infrastructure also need to
be updated?

It appears functions like userfaultfd_wp_use_markers() still check
userfaultfd_wp(vma) instead of userfaultfd_protected(vma). Could this cause
the RWP protection state to be silently dropped when file-backed pages are
evicted or zapped, potentially breaking fork(), page faults on markers, and
unpopulated page tracking?

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9e62946af6549..87db714e13646 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4611,11 +4611,19 @@ static inline int vm_fault_to_errno(vm_fault_t vm=
_fault, int foll_flags)
> =20
>  /*
>   * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> - * a (NUMA hinting) fault is required.
> + * a (NUMA hinting or userfaultfd RWP) fault is required.
>   */
>  static inline bool gup_can_follow_protnone(const struct vm_area_struct *=
vma,
>  					   unsigned int flags)
>  {
> +	/*
> +	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
> +	 * NUMA hinting. GUP must always take a fault so the access is
> +	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
> +	 */
> +	if (vma->vm_flags & VM_UFFD_RWP)
> +		return false;
> +

[Severity: High]
Can VM_UFFD_RWP faults be silently intercepted and neutralized by the NUMA
hinting fault path?

Since VM_UFFD_RWP uses PROT_NONE PTEs, it seems these would unconditionally
route to do_numa_page() or do_huge_pmd_numa_page() in the fault handler. Do
we need to integrate userfaultfd with the NUMA fault handlers to prevent the
permissions from being restored and the tracking state permanently lost
without notifying userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D11
