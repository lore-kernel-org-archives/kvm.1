Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF53B637A
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803027; cv=none; b=FTWJYnppWjEkeL2n1GnWkhoCbFkwhPElYCvigRseG0No2raTcU4ztXnOq/mNOzOrL06auLeydE9QGavhMGRcEujRTDhXvQe6937P5RqNPIPBhLKhcCHR4ANV9PSuXYB2IBXi/Iiln9GmbtKYj1cBzF8G9+Ojsl73kHg/+eiM/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803027; c=relaxed/simple;
	bh=2j3/uGmC8CH6lWFuM4sICqYcy7UXcc4Vt0/IqEYfxm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mHRS/0M0ywkWQuKl7uIyIqct4DpOf9cXpAkAQw8Jl6kW7L2Yk9oReKra5Y1f4+TpUrQfaqfxv1roksdq0uCU/qK3OLzOiejyusGI30WNxUEBX2mD4IPb8OXLDXDac1r5HQyM2BwxaHpZVtwWYP0QvwvuSSAJ02p/KZrDTsWIHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiABYRvL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiABYRvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2611F00ADE;
	Tue, 26 May 2026 13:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779803025;
	bh=cNMmLbWdU8Uv4BOzdVI88U/rKy55zOdnKHbrafzeNb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kiABYRvLFMij0VE/tKc2oNS8HdNLqQGlBMlz9kWBigmPw6DAJ2ogir6jmmkK7ue/C
	 yUMIkmm7Al1iayG3WR4YdxkHTBzG2LarcoJBc1/RXuHPQowFh4wGUPMMT0vC0y0lgg
	 JK1hhOB3KdfGuwTImos3oNmEamL6oaJTKM0TxT2lc1k/nQcqK5JZxw7N7VsRgYTR6Q
	 +VJ4h3P4+B4a0NHrcy4K43C7J0B4tjxnQWZZ1iMlgva8Au11qNIxaZuhnnTXUrpTzk
	 CsU61DaYUEVIaYXCGazbtzo4keXv+PyFzD54DSdWv7jE70r9bE56OmbBkwz0mH5bA6
	 puXDm6STvmpmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/18] mm/huge_memory: preserve pmd_swp_uffd_wp on
 device-private PMD downgrade
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-3-kirill@shutemov.name>
References: <20260526130509.2748441-3-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:43:44 +0000
Message-Id: <20260526134345.AA2611F00ADE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch addresses uffd-wp flag preservation for device-private P=
MDs during permission downgrades, but leaves the exact same vulnerability u=
naddressed for migration entries across PMD, PTE, and hugetlb paths, leadin=
g to silent UFFD-WP bypass.
--

commit 053193c00433ae069a54ed063476afb79e232be6
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm/huge_memory: preserve pmd_swp_uffd_wp on device-private PMD downgrade

This patch fixes an issue where userfaultfd write-protection bits were being
dropped when downgrading the permissions of device-private PMD swap entries.
It modifies change_non_present_huge_pmd() to carry over the pmd_swp_uffd_wp
bit during this transition.

> change_non_present_huge_pmd() rewrites a writable device-private PMD
> swap entry into a readable one without carrying pmd_swp_uffd_wp()
> across. The PTE-level change_softleaf_pte() does this correctly;

[Severity: High]
This isn't a bug introduced by this patch, but is this statement entirely
accurate for migration entries? It appears change_softleaf_pte() only
preserves the soft_dirty bit for migration entries, not the uffd_wp bit.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 42b86e8ab7c03..b7c895b1d3664 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2663,6 +2663,8 @@ static void change_non_present_huge_pmd(struct mm_s=
truct *mm,

[ ... ]

>  	if (softleaf_is_migration_write(entry)) {
>  		/*
>  		 * A protection check is difficult so
>  		 * just be safe and disable write
>  		 */
>  		if (folio_test_anon(folio))
>  			entry =3D make_readable_exclusive_migration_entry(swp_offset(entry));
>  		else
>  			entry =3D make_readable_migration_entry(swp_offset(entry));
>  		newpmd =3D swp_entry_to_pmd(entry);
>  		if (pmd_swp_soft_dirty(*pmd))
>  			newpmd =3D pmd_swp_mksoft_dirty(newpmd);

[Severity: High]
This is a pre-existing issue, but does this migration entry path also need =
to
preserve the uffd_wp bit?

When mprotect(PROT_READ) downgrades writable migration entries to readable,
the uffd_wp bit is lost because swp_entry_to_pmd() discards it, and only
soft_dirty is explicitly restored here.

If a page is migrated concurrently with mprotect(), could this result in
userfaultfd traps being silently bypassed when the migration completes and
remove_migration_pte() restores the page without the uffd_wp bit?

>  	} else if (softleaf_is_device_private_write(entry)) {
>  		entry =3D make_readable_device_private_entry(swp_offset(entry));
>  		newpmd =3D swp_entry_to_pmd(entry);
> +		if (pmd_swp_uffd_wp(*pmd))
> +			newpmd =3D pmd_swp_mkuffd_wp(newpmd);
>  	} else {
>  		newpmd =3D *pmd;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D2
