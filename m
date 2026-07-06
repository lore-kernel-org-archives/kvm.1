Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4662414DC9
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329770; cv=none; b=lEdyXTl9fkCMRruvjck6md8+g7akkbWfqJdE73/Q1/OeHa1CalPYMHYdlpAurGV8w9rNgqt1I+vw3NcU3jkevHTSLb2/FIJB1U9if6bwRdL73ouz6FyiSG8uWExrK4FS5dZhwH8GA4HhUhQCJ6eBEwJaUUmUR1ORWM+i3Ah/1sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329770; c=relaxed/simple;
	bh=IQ7XOzWDJEYXuo72dKFOcCwKx3Z3lPqd2Dcr6RBptGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l8HhYgAvHeV77qL3bsBa9w/ZigdOMawHcIHyZPs+1/eMP4AgyI+keur6/iyxLgnUELgNMtcWfsL10vePR0VGSg7m8HV0fIaMMAu1zCujgGmhbx/FmVBzHfJn4ty1lVOS37Xqj8/PzyR9Xq+WW1xbsI7vv/axWl+MduXgP+6AmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6T9AwMF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6T9AwMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044C21F000E9;
	Mon,  6 Jul 2026 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329766;
	bh=JydAGFfZTn41KL+mVKfc9IteaVSXeBfqSkK6fNhObxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C6T9AwMFu9g2t9y7jP+OyXjDdVVTPML9YjrOjRsDhByUpKYAcfvtwbefnjBqeTSLT
	 nTuixg0vTUXK0SQxlxL5uN67W1V9LdPKhO0D99q/bZ4/jTeu2x9/LGyygw6JC+idMn
	 bYTh+Ou2W+uWZvJDCIMyOVj/KSsQCFEcrTTC1Hs37ezhxQ1iMv2t6E+MPEaSDmVn0A
	 CDcLeb4t4/Zx/rfk4iAFfSymUPhvTz36ag3wEgHFTyWxXP/ePH+KRKcH5R3sTjIZ85
	 emjVtrbsAT0DKzdqG5Z+3bzltVtAvBa0zLkBy54b+jlmIN2O/mLKgofcJ5my/KbOi0
	 JM1dvprPPMCsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/15] mm/userfaultfd: add RWP fault delivery and
 expose UFFDIO_REGISTER_MODE_RWP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-11-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-11-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:22:45 +0000
Message-Id: <20260706092246.044C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Infinite page fault loop (livelock) on hugetlb VMAs containing sta=
le RWP or WP markers after UFFDIO_UNREGISTER.
--

commit 53f1ffbd6e1b1ae6560601d75e0a8a5ad93e1aa3
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm/userfaultfd: add RWP fault delivery and expose UFFDIO_REGISTER_MODE_RWP

This commit adds read-write protection (RWP) fault tracking to userfaultfd.
It introduces the UFFDIO_REGISTER_MODE_RWP flag and handles RWP faults at t=
he
PTE, PMD, and hugetlb levels by delivering UFFD_PAGEFAULT_FLAG_RWP messages.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4d0b6d7d9842f..f0ce2e9d4ba2d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6063,6 +6063,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,
>  		goto out_mutex;
>  	}
> =20
> +	/*
> +	 * Protnone hugetlb PTEs with the uffd bit are used by
> +	 * userfaultfd RWP for access tracking. Plain PROT_NONE (without the
> +	 * marker) is not an RWP fault and is not expected on hugetlb (no
> +	 * NUMA hinting), so let normal hugetlb fault handling proceed.
> +	 */
> +	if (pte_protnone(vmf.orig_pte) && vma_is_accessible(vma) &&
> +	    userfaultfd_rwp(vma) && huge_pte_uffd(vmf.orig_pte)) {

[Severity: High]
Can this code cause an infinite page fault loop if the VMA is unregistered?

If an unprivileged user registers a hugetlb VMA with UFFDIO_REGISTER_MODE_R=
WP,
allows PTE markers to be placed, and then unregisters it via UFFDIO_UNREGIS=
TER,
the PTE markers are not cleared. Subsequent memory accesses will trigger a =
page
fault, but since userfaultfd_rwp(vma) evaluates to false, this check is
bypassed.

For read faults, hugetlb_fault() falls through, marks the PROT_NONE PTE as
young, and returns 0 without restoring accessibility. Because the fault han=
dler
continuously returns 0 without making the PTE accessible, the CPU retries t=
he
instruction endlessly, resulting in a local denial of service.

This is a pre-existing issue for write faults via WP, but does this patch
introduce the same livelock for read faults via RWP? For WP, write faults s=
kip
the UFFD_WP check and hugetlb_wp() catches the stale marker:

mm/hugetlb.c:hugetlb_wp() {
...
	if (!unshare && huge_pte_uffd(pte))
		return 0;
...
}

Because it returns 0 without upgrading the PTE to writable, the CPU retries
the instruction endlessly. Can a similar infinite loop occur here for RWP?

> +		return hugetlb_handle_userfault(&vmf, mapping, VM_UFFD_RWP);
> +	}
> +
>  	/*
>  	 * If we are going to COW/unshare the mapping later, we examine the
>  	 * pending reservations for this page now. This will ensure that any

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D10
