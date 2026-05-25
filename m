Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188D38423D
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715164; cv=none; b=QRKIqJcs9usXw9Bw5SSMqA4b4eh6QmthN7qiwMR+xDL5IrXx9r/IgKWzmEr2WpZwYfk1Sy3A5HCOHakhlnQwneNsMBD5P3cBI8F/x6NYxf/KaHbNrXVDDJYqtNXTfVi7IHvLcU2/9rv8TPluzXw/NuxZ2Yfpsv4nGwo0rdzrAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715164; c=relaxed/simple;
	bh=IPBAVzJ/QMtkuSlHtAYDRvppZMbcIpl+plV8HcRmDsY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dkKF04nklWGnBXqt7nFzm+xf1Roi5p6iyKPSA8kkLL7ss4B+9eM59CAPhck1ahL5sscsErWaiM+86Yv+cUlp0OApdD7zZ39EkQm2OEvoBtFpdE+xQBJmW0VGhZlC7Ace2/p3nh9hg1zGvTeVqTGIIcd5FRGv6p/wGIRPVyRV6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4nX1sEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4nX1sEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A1B1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779715163;
	bh=xdYEUKAdBHdKepHptIZgRNcPgi7wCF5RVJ2oERJT8jk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=E4nX1sEA01D2b/gU7SAwu9Qo31h8DnxMLm+VgHLnzA7fHhyoqvjMcu1T/dLKGncm6
	 yWXHYO3vBJdD1UbdfEvqy47jyg/vsgTM1ry8S9RBwbTM10rgFKA/YlhsX3A/ZyjV3u
	 bH0YkvccpwmBSFCkPAL0xdAd5c8CBq5WtVdcXLNn+aP5wtzP72MAkg2nI9RBPEwZ+3
	 dOIeP3fTNkCIktioMsT/XvOU2PN7+Zhn9jtjqILJSZh5496LwsAY2vHU45SSdRahHe
	 e+qwx7rZcGD6ddjSovLeTU3/B8iMI9mgDMCsTsQ0fxHVwLLBRRLwSp0CayodllBoVm
	 Hkfo0PKFSdZmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/14] mm: handle VM_UFFD_RWP in khugepaged, rmap,
 and GUP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-8-kas@kernel.org>
References: <20260525113737.1942478-8-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 13:19:22 +0000
Message-Id: <20260525131923.11A1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] GUP enters an infinite loop when using FOLL_FORCE on an inaccessib=
le (PROT_NONE) VMA that has VM_UFFD_RWP enabled.
--

commit 4dac97d12abaa9b69ebb25fda63dafc4aafce286
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP

This commit updates khugepaged, rmap, and GUP to handle VM_UFFD_RWP
similarly to VM_UFFD_WP. It adds checks for userfaultfd_protected()
in khugepaged and rmap, and modifies gup_can_follow_protnone() to
force a fault on VM_UFFD_RWP VMAs.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5953106758fa5..f72bf5ccf72c9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4600,11 +4600,19 @@ static inline int vm_fault_to_errno(vm_fault_t vm=
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
Can this cause an infinite loop in GUP when using FOLL_FORCE on an
inaccessible VMA?

If a user registers memory with userfaultfd RWP, calls mprotect(PROT_NONE)
to make the VMA inaccessible, and then reads it via /proc/self/mem, GUP
will use FOLL_FORCE and hit this check.

Because gup_can_follow_protnone() returns false, GUP falls back to
faultin_page() and calls handle_mm_fault() then handle_pte_fault().

In handle_pte_fault(), there is an accessibility check:

    if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
        return do_numa_page(vmf);

Since vma_is_accessible() is false here, it skips the resolution and simply
returns 0 without upgrading the permissions of the PROT_NONE PTE.

When faultin_page() returns 0, GUP loops and retries follow_page_mask(),
hitting the exact same PROT_NONE PTE and repeating the process endlessly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D7
