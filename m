Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BA2C0F84
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804452; cv=none; b=HYh+1HX38yyYOKt78gDTiXalL3ah2PuxJifKWJG9n9tZub2Rk3g2DE4ie2yp91xiPLbBX8EyYMh/DTL9cj0GIEAb8/iHHR8RZLu5IzvzzJTsevfbxsa6SD4KXUn9/XOPLHk+QEfhNXDxW2rL1bT/x+c11XGGiFOW7Oae3AcIpZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804452; c=relaxed/simple;
	bh=jwXx/zOiZLLbaAy6UHJu2HWM2qfFWcVvuxrymwF0GRE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CFjo8VysfnqoaK/3J+FK5uQ71y9XJn6/ls+tsSumd0cgGKF6jBbZAtCheNzrWDm9ZhlLNW4W0IKOl1lydBlbDcnbfmlcGVwQ8i3ii3At4Xal43bvYNNo2lqtb8aicJ5d+788S4CWbW/b4m+5K2P5xfB6iDTBxwgCFO8lBm1Gmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnjZVDAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnjZVDAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24331F000E9;
	Tue, 26 May 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804451;
	bh=cZmKgijx9hEGV4ifuxDFxVrBc+TYtJVpMI9jh+2KcYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QnjZVDAkGiMBC7SMJWLBk3NMuJgM1Emf5TBbxUmH30RRvssG5S3IXFaqTa7ZeZRK8
	 L4boUcE5bGmb9jJ23cIS0OM2poc5LMsjsRclXa9FzPd35beXATq6sWKV7tgClBKyQG
	 BLe3Cugs+QYuvT7ToAryYTQw79wQTPUJQQ/i+cUsfA64ofWsEwJnIQDG3IxnAnnCkE
	 uh92A1coAG1FgZMmQG8di84fBwSyON20hFcVZJCLqoryG+wjaFZDN9dfx3kjmt5xbd
	 0rFT3VRYMm/RnAjCK9MqcTddsn2OmRYvztlL543ipmYUZ2bHodDgZynn65fOCni5iD
	 DQCGiJVxz9Xow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/18] mm: add MM_CP_UFFD_RWP change_protection()
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-10-kirill@shutemov.name>
References: <20260526130509.2748441-10-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:07:29 +0000
Message-Id: <20260526140730.C24331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `pgtable_split_needed()` does not force a split for `MM_CP_UFFD_RW=
P` on file THPs, leading to silent loss of RWP tracking on transparent spli=
t.
--

commit 6bd2366f8f7b6b871a5d79d6481ff66d78832c91
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: add MM_CP_UFFD_RWP change_protection() flag

This commit introduces the MM_CP_UFFD_RWP and MM_CP_UFFD_RWP_RESOLVE
change_protection() flags for userfaultfd RWP. It wires these flags through
change_pte_range(), change_huge_pmd(), and hugetlb_change_protection() to
allow installing PAGE_NONE with the uffd PTE bit set.

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6499cfb61dc4b..f79801816f327 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3297,6 +3297,11 @@ int get_cmdline(struct task_struct *task, char *bu=
ffer, int buflen);
>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>  					    MM_CP_UFFD_WP_RESOLVE)
> +/* Whether this change is for uffd RWP */
> +#define  MM_CP_UFFD_RWP                    (1UL << 4) /* do rwp */
> +#define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
> +#define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
> +					    MM_CP_UFFD_RWP_RESOLVE)

[Severity: High]
Does pgtable_split_needed() need to be updated to force a split for
MM_CP_UFFD_RWP on file THPs?

When MM_CP_UFFD_RWP is applied to a file-backed THP (e.g. shmem),
change_huge_pmd() successfully modifies the PMD to PAGE_NONE and sets the
_PAGE_UFFD bit. However, unlike anonymous THPs, file-backed THPs are split
by completely erasing the PMD (pmdp_huge_clear_flush()), leaving the PTEs
to be re-instantiated from the page cache upon the next page fault.

Because pgtable_split_needed() was not updated to check cp_flags for
MM_CP_UFFD_RWP, it allows RWP to be applied to the huge PMD without forcing
a split first.

If the kernel later splits this THP (e.g., due to memory pressure or a
shrinker), the PMD is erased and the RWP tracking state is irreversibly
lost. The next user access will trigger a standard missing page fault that
maps the file page readable (vma->vm_page_prot), silently bypassing the RWP
tracking for a previously protected, populated page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D9
