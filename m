Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A283400DE8
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736942; cv=none; b=jqo3sQUnJP3aN3qgLBHzDGj+zaYb5LQVpcIzctHdJ6ZSbkdXJEkfkOlGz4aHe4FbEHF3kVzrSwljKdh2vcjDK20wsq5mr/8mMUoVZAq24SZpumPc9ToZHx+WbMaJftcdrrefif7H6MFbE1x2qNJo0owmfHCi9978B3YtlUqoVMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736942; c=relaxed/simple;
	bh=KSWe46LtRgPR6Jvo6bu006fjeB+IfNARujZdjmozaeY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bwgNNwlN4zTZjASUA7S42jzhAGl6UxHA5pbl3Lgy+/D+uEmRD2P2QQvVZC9cEstimJY0otcLvDnQAoUnY2rtkfh3zHd9mITawkVOaJfQztZxUCrCjMG69p80gwQ+Z1imJg0KIgC37AUU/tbRJfBn6yWbhA/q9b16ZkpBlmkIZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc625Sui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc625Sui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119C31F000E9;
	Mon, 29 Jun 2026 12:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782736941;
	bh=OfXFk2RjvFAMxv8j+ObIRPHGP7ORj42DiFfAv2I5O8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dc625SuipVz2mrtPlLNO4YQhlRsT9ZwyIDgfdciJA5j9I8m/BXH8RAdCi2pT7+6N1
	 +ctH8Hkx1q59DyE5eYwsO3O5lIjns2cwRmHuTw3OpTIhjw8efN2JB7BOS05KFzaM7T
	 UHJUJWMGSNR82Lx2VNcoI6dwV8p9X4HCK6wJvvaFvliTqPKHzTMV2DSHqRi5WdgCSk
	 /QGXMYXruhuiWAFZyEWKFVlUfQpgzxPL06y3/as9HyAlglwb3GyVhZPpIaCiTEkeLo
	 bAC2RyveanSsU7IGfRx6DJep7rSTiKHi1PXMtuPUCIZFzapBOops5dprmXwGIAWs0o
	 0lVf1OEz5KLAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/15] mm/userfaultfd: add RWP fault delivery and
 expose UFFDIO_REGISTER_MODE_RWP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-11-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-11-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:42:20 +0000
Message-Id: <20260629124221.119C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] RWP fault resolution creates invalid clean+writable PTEs.
- [High] Ambiguous PTE encoding between UFFD_RWP and NUMA hinting on UFFD_W=
P pages causes spurious RWP faults and WP security bypass.
- [High] FOLL_FORCE accesses (e.g., via /proc/pid/mem) silently bypass UFFD=
_RWP tracking.
- [High] UFFDIO_RWPROTECT skips unmapped PTEs, leaving them completely unpr=
otected upon subsequent population.
--

commit 0937077addf68b8c5ba299257ab75ab0a674a8cd
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

    mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_=
RWP

    This patch wires up the fault delivery side of read-write protection (R=
WP)
    tracking for userfaultfd and exposes the UFFDIO_REGISTER_MODE_RWP inter=
face.
    It updates page fault handlers to intercept PROT_NONE PTEs with the uff=
d bit
    set and route them to userfaultfd, falling back to NUMA hinting otherwi=
se.

> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index d65e1833f08d6..8d5d6ca60b671 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
[ ... ]
> @@ -236,6 +236,18 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm=
_area_struct *vma,
>  	return userfaultfd_wp(vma) && pmd_uffd(pmd);
>  }
> =20
> +static inline bool userfaultfd_pte_rwp(struct vm_area_struct *vma,
> +				       pte_t pte)
> +{
> +	return userfaultfd_rwp(vma) && pte_uffd(pte);
> +}

[Severity: High]
Could FOLL_FORCE accesses bypass UFFD_RWP tracking entirely?

When a VMA is made inaccessible (e.g., via mprotect(PROT_NONE)), GUP checks
accessibility in gup_can_follow_protnone(). Because FOLL_FORCE overrides VMA
accessibility restrictions, GUP successfully extracts the page.

When verifying write permissions, can_follow_write_pte() checks
userfaultfd_pte_wp() but appears to omit checking userfaultfd_pte_rwp():

mm/gup.c:can_follow_write_pte() {
    ...
    return !userfaultfd_pte_wp(vma, pte);
}

Does this allow local privileged processes to read or write RWP-protected
memory without triggering the userfaultfd handler?

[ ... ]
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfa=
ultfd.h
> index 7b78aa3b5318c..d803e76d47adc 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
[ ... ]
> @@ -54,13 +56,15 @@
>  	 (__u64)1 << _UFFDIO_MOVE |		\
>  	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
>  	 (__u64)1 << _UFFDIO_CONTINUE |		\
> -	 (__u64)1 << _UFFDIO_POISON)
> +	 (__u64)1 << _UFFDIO_POISON |		\
> +	 (__u64)1 << _UFFDIO_RWPROTECT)

[Severity: High]
Does UFFDIO_RWPROTECT skip unmapped PTEs during registration?

During UFFDIO_RWPROTECT, change_pte_range() iterates over the VMA's page
tables. When it encounters pte_none entries, it skips them unless uffd_wp is
true:

mm/mprotect.c:change_pte_range() {
    ...
    } else if (pte_none(oldpte)) {
        /*
         * Nobody plays with any none ptes besides
         * userfaultfd when applying the protections.
         */
        if (likely(!uffd_wp))
            continue;
    ...
}

Because RWP has no marker for unmapped pages, the entries remain empty. When
a page fault subsequently occurs, do_anonymous_page() populates the page us=
ing
the default VMA permissions without PROT_NONE or the _PAGE_UFFD bit.

Could this leave previously unmapped or zapped pages within an RWP-protected
range completely unprotected?

[ ... ]
> diff --git a/mm/memory.c b/mm/memory.c
> index 978ead28c6d15..16b7596625abd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -6126,6 +6126,16 @@ static void numa_rebuild_large_mapping(struct vm_f=
ault *vmf, struct vm_area_stru
>  		if (!pte_present(ptent) || !pte_protnone(ptent))
>  			continue;
> =20
> +		/*
> +		 * RWP-armed PTEs are also protnone but carry _PAGE_UFFD as a
> +		 * marker. Leave them alone -- rewriting to vm_page_prot would
> +		 * stop the RWP trap. Gate on userfaultfd_rwp(vma) too:
> +		 * NUMA balancing preserves _PAGE_UFFD on UFFD_WP-marked PTEs
> +		 * when applying PROT_NONE, and those still need rebuilding.
> +		 */
> +		if (userfaultfd_rwp(vma) && pte_uffd(ptent))
> +			continue;

[Severity: High]
Does this logic correctly differentiate between RWP and NUMA hinted pages?

When a VMA has both UFFD_WP and UFFD_RWP enabled, NUMA balancing modifies P=
TEs
to PROT_NONE while preserving the _PAGE_UFFD bit (used by UFFD_WP). Because
UFFD_RWP uses the same PROT_NONE + _PAGE_UFFD encoding, it appears a
NUMA-hinted WP page would be falsely identified as an RWP page here.

Could this skip rebuilding NUMA mappings for WP pages when the VMA also has
RWP enabled?

> +
>  		if (pfn_folio(pte_pfn(ptent)) !=3D folio)
>  			continue;
> =20
[ ... ]
> @@ -6141,6 +6151,12 @@ static void numa_rebuild_large_mapping(struct vm_f=
ault *vmf, struct vm_area_stru
>  	}
>  }
> =20
> +static vm_fault_t do_uffd_rwp(struct vm_fault *vmf)
> +{
> +	pte_unmap(vmf->pte);
> +	return handle_userfault(vmf, VM_UFFD_RWP);
> +}

[Severity: Critical]
Is it possible for do_uffd_rwp() to create an invalid clean and writable PT=
E?

When an RWP fault is resolved on a private anonymous exclusive page,
can_change_pte_writable() can return true. The PTE is then upgraded to writ=
able
using pte_mkwrite():

mm/memory.c:do_uffd_rwp() {
    ...
    if (!pte_write(pte) &&
        vma_wants_manual_pte_write_upgrade(vmf->vma) &&
        can_change_pte_writable(vmf->vma, vmf->address, pte))
            pte =3D pte_mkwrite(pte, vmf->vma);
    ...
}

It seems this fails to pair pte_mkwrite() with pte_mkdirty(). According to
the MM subsystem invariants, a clean and writable PTE is invalid. On
architectures that trap invalid PTE combinations, could this cause a kernel
crash or silent data loss when data is dropped instead of being written bac=
k?

> +
>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
[ ... ]
> @@ -6416,8 +6432,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault=
 *vmf)
>  	if (!pte_present(vmf->orig_pte))
>  		return do_swap_page(vmf);
> =20
> -	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
> +	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma)) {
> +		/*
> +		 * RWP-protected PTEs are protnone plus the uffd bit. On a
> +		 * VM_UFFD_RWP VMA, a protnone PTE without the uffd bit is
> +		 * NUMA hinting and must still fall through to do_numa_page().
> +		 */
> +		if (userfaultfd_pte_rwp(vmf->vma, vmf->orig_pte))
> +			return do_uffd_rwp(vmf);

[Severity: High]
Could this intercept NUMA hinting faults on UFFD_WP pages and route them
incorrectly to the RWP handler?

As noted above, NUMA hinting preserves the _PAGE_UFFD bit. If a VMA has both
UFFD_WP and UFFD_RWP enabled, userfaultfd_pte_rwp() will return true for a
NUMA-hinted UFFD_WP page because it relies on the same _PAGE_UFFD encoding.

This routes the fault to do_uffd_rwp() instead of the NUMA handler, which
clears the UFFD bit and destroys the WP protection. Could this silently
allow unauthorized writes to write-protected memory?

>  		return do_numa_page(vmf);
> +	}
> =20
>  	spin_lock(vmf->ptl);
>  	entry =3D vmf->orig_pte;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D10
