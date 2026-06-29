Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF03FF8A5
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736027; cv=none; b=TI9hDMbX/UQfURAzUgILHgiyVvzu2L7uqWo9+/LNMP3qfLfYSmbuju4JBG3ZfRjVK6vEC0wO5YIrTgDS0ncG2I/MQhe+qMqk5FyFJ2Q//zC8PpcdI+pR9VaryHeSIDVrY+iV0wL37ETFBQ8sWgk2tKsa3aW9/ndNm2A0/seVN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736027; c=relaxed/simple;
	bh=fq3QHl6LOU6sBnJEipFxZptWAGxX5hThavrcW/0yXmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SifVbscPFbfdsgPWnHcFFGbUEWUR9Yat/MZzuw09w/3WLNrwa7hyPBh/iU4nzyerXAgIyDAiWFJJueIr0oUMx8euW8t4JetwFbtk2zkZwcTZBvl9+obZNlOja6dUqEUqMg5Zw62SrHMoITYGl5edONqMLliPmL1n2vY/YykJ/to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBmdsBrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBmdsBrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484661F000E9;
	Mon, 29 Jun 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782736026;
	bh=WplG5+78J+M+vCWucjxaHpcu2g5pV58NrkHIGlZ+LCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CBmdsBrFPQtdafQtddWhCHvB11Njqy2/n/zhJjLjmH5AD2jwncNQpIGIa1HTBceP/
	 lGubS7d05nysjEiEFVySrIP4IrKisCWLho71vR8zUeJ8V+0/ff+X6aoWkoqzWaVv0I
	 vAwEi056lMqt4qAv9vEA2t8NlR3ZRe0eaPN8NmsrizmwwD0d0x3YDAMojo2qeYBsXl
	 DRJ4nFEgazhDgNiMISg6al/AH9oSbnl9QzbjFrbTXezh58lWPmNC6AkQ/wUcak9IUT
	 l+g5QDFKTSw6XK2ltK44lRufvjqX13Ujq8+Q2xUUsuthfa+B4LPu28Yrl68VW5OZma
	 K+Qx29h6zv2hA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/15] mm: add MM_CP_UFFD_RWP change_protection()
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-7-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-7-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:27:05 +0000
Message-Id: <20260629122706.484661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] MM_CP_UFFD_RWP silently destroys RWP protection and unmaps file-ba=
cked THPs.
--

commit 82229f238feb5343260ad7c878148b9a54c5893a
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: add MM_CP_UFFD_RWP change_protection() flag

This patch introduces the MM_CP_UFFD_RWP and MM_CP_UFFD_RWP_RESOLVE flags
for userfaultfd RWP. The flags are wired through change_pte_range,
change_huge_pmd, and hugetlb_change_protection to install PROT_NONE with
a userfaultfd marker.

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8340c8b228c67..7dcc94e7bfd60 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
[ ... ]
> @@ -428,7 +441,7 @@ pgtable_split_needed(struct vm_area_struct *vma, unsi=
gned long cp_flags)
>  	 * (e.g. 2M shmem) because file thp is handled differently when
>  	 * split by erasing the pmd so far.
>  	 */
> -	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
> +	return (cp_flags & (MM_CP_UFFD_WP | MM_CP_UFFD_RWP)) && !vma_is_anonymo=
us(vma);
>  }

[Severity: High]
When a file-backed THP is split because pgtable_split_needed() returns true
here, __split_huge_pmd() clears the PMD and change_pmd_prepare() allocates
an empty PTE table with all none PTEs.

Then change_pte_range() processes these none PTEs, but it has this check:

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

Since uffd_wp is false during an MM_CP_UFFD_RWP operation, won't this cause
the none PTEs resulting from the THP split to be silently skipped?

This would leave the previously populated file-backed THP pages unmapped and
without any RWP protection markers. When they are accessed again, they might
fault back in with default permissions, bypassing the requested RWP trackin=
g.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D6
