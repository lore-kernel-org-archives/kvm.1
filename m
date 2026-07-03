Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5943E0C4C
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088821; cv=none; b=qKzRHB0dQgNH+UwVJ+ceykaPTver+a3OZQwCL6izrUIkZ03lZKhe8k1mz6p5OCIfxqeP8x0GCDJ2mey2yroqjXYXiXXfokPQy+GAWXJ8jq45wuho7CzfyeVhsC3NR5KbkMkwpgRWjokpwYPukE46SS9fY1K6IgQWIgt+QHcw4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088821; c=relaxed/simple;
	bh=OtSwbxhYeXVvt44Is+Eqwg4eri1903TyhY2EAttyot4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OyG3A6ORSbHM0QeOxSeXKTi705j5BBxDhYuRlmm1R8JyLwexBHApU2eK4wl0FALhO66rjE4qV7IGcsD3z++Dr+3BH2nYAF3NICM4XIYMQ8YPr9HPaexdoLoL8bZrcsaoI4LSkT000scWF8UpJlTE8zEJjjgPEE88FzTdn8thSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5B72iH6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5B72iH6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59C21F00A3A;
	Fri,  3 Jul 2026 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088817;
	bh=4xzvcE29UuB6YIW6C+WTDiBkpAN9rUuaQd4CIz4d9Ag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5B72iH6r7OvS/OCpAyjUnPI+4TWovPFHG+Ro5B9lLQ1u6d2FDtms0mD9FHyDY8RY
	 99wxl+hyCiibmRUyIkTVEHKZpCx619akt31ZvYXhsk8uutFOimzb7tDaKzZ2/lDbOd
	 ZTf9Sv8ferjeK8ZH3wo69qoBCHn8urPHvUKRnuhN7NQBtDOoc2AYgKchB5+o41vsvj
	 3FhvwVEtVCV80m2I4SZN4lGgdbrg1/k2/FKD79WNy31FfheVkcPcRmz1577FlXhflX
	 A6Ukoim/P22TUkIjwzbEBb6gIsF83/T7Lg8gDYNHJx6a5rO3VcN37ZFM8U955YeoRD
	 E9IcmoePN/rqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap,
 and GUP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-9-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-9-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:26:56 +0000
Message-Id: <20260703142656.C59C21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Per-PTE RWP tracking state is silently destroyed for file-backed m=
emory during page eviction, page fault, and fork because the PTE marker inf=
rastructure does not support VM_UFFD_RWP.
- [High] FOLL_FORCE accesses (e.g., via /proc/pid/mem) silently bypass user=
faultfd RWP monitors on inaccessible VMAs due to an incorrect assumption in=
 gup_can_follow_protnone().
--

commit a8febd9860609da477330a270aa0cc307fe15024
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP

Three mm paths outside the fault handler gate on the uffd PTE bit
today: khugepaged (skip collapse on ranges carrying markers), rmap
(cap unmap batching), and GUP (force a fault through
gup_can_follow_protnone). Extend each to treat VM_UFFD_RWP the same
as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
bypassed.

> Extend each to treat VM_UFFD_RWP the same
> as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
> bypassed.

[Severity: High]
The commit message states the intention is to prevent per-PTE RWP state from
being silently destroyed or bypassed. Does this patch miss the PTE marker
infrastructure required for file-backed memory?

For example, during page eviction, try_to_unmap_one() relies on
pte_install_uffd_wp_if_needed(), but that function explicitly requires
userfaultfd_wp(vma):

include/linux/mm_inline.h:pte_install_uffd_wp_if_needed() {
    ...
    if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
        return false;
    ...
}

This causes RWP VMAs to lose their tracking state entirely upon eviction.

Similarly, vmf_orig_pte_uffd_wp() in mm/memory.c ignores markers for RWP
VMAs during page faults, copy_pte_marker() drops markers during fork(),
and change_pte_range() in mm/mprotect.c skips unpopulated PTEs when
UFFDIO_RWPROTECT is called.

Are updates to the PTE marker infrastructure needed to fully support
VM_UFFD_RWP?

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3d4d5f9a6f1bf..da8a07cd49a14 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4644,11 +4644,25 @@ static inline int vm_fault_to_errno(vm_fault_t vm=
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
> +	 *
> +	 * Only do so while the VMA is accessible. If it has been made
> +	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
> +	 * below: forcing a fault there would loop, as handle_mm_fault() makes
> +	 * no progress on protnone in an inaccessible VMA, and the access is
> +	 * denied regardless of RWP anyway.
> +	 */
> +	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
> +		return false;

[Severity: High]
Does this logic allow FOLL_FORCE accesses to silently bypass the RWP
monitor?

The comment assumes access is denied regardless of RWP when the VMA is
inaccessible, but FOLL_FORCE (e.g., from ptrace or /proc/pid/mem)
explicitly bypasses VMA access permissions.

If an RWP VMA is made PROT_NONE, and FOLL_FORCE is used, this check
returns true because vma_is_accessible() is false. GUP will then follow
the PROT_NONE PTE and extract the page, bypassing the userfaultfd fault
path entirely.

> +
>  	/*
>  	 * If callers don't want to honor NUMA hinting faults, no need to
>  	 * determine if we would actually have to trigger a NUMA hinting fault.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D8
