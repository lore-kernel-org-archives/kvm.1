Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAD37F743
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710715; cv=none; b=Sc6EXbGT3EuxYGiqc5lmZD9vIhpPXtQSq/qY6keOAqUZNq0KQZFrcfegvXtfatYo+5bQ+oOxTKMN7vGKuyt8wHHmncTMsOS90FrA+yB2KzzPbjE6iOovMSgCvqrtEdl8+Gr/QWFL4E9I7pZeZlv8shVo/bLnyJ3zqOcQ2HOgI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710715; c=relaxed/simple;
	bh=wd07kg8HNWKGPcyGelYTYyyevX6+yGCy6qsI0FkkcZs=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=is5bybzAjEyOhzpyFTawUzhZaQPsU0yFhSsKhW1ltdvKGtqWz9AS/lSfYKOZNKsHfW2iuxeBMq9SDL2EPeR/HKQ5LDx9McU4OlhZQiKjjXl8FYhfHVGpAji6o63HrVjcH7zweUTVqzV8cpAMPQljLWssPDauWaQbgV3v/kHrrro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzqkJc7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzqkJc7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E91F00A3A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779710714;
	bh=yPs034zydrHpAtoeOTtgBr8hiPVQ6YKFkzravdsh6OY=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZzqkJc7u/i4x7g2AxTZeycwj6nh9AyjHNEWttvvHFdrOwpCzfM/uDNmK7Rm6MU/j4
	 MoeVs6PX9+6PDIHJGvSWIEmWTLUvCZK08pFy0KbyQaIsXrVji7r2+msY+2NF3EjCq+
	 ISeBFp4oGwIx9fBG1OBnC5ENukYl9LLkjHLHeID7H+PXcKbGwPoFZMaorhL406+c6D
	 oajiHJ01RrLX+xH8xr30eGDun5RvmBAfyi5hQc/3muE8f4qzmMc94OB8LlIExVG0+f
	 ZKf5EYGvUUxMdJk6y806wKF9zU4YeV90lrFrht4lZMn9t+4tyFve2U1uaqT2P4QMyU
	 WMYXhRO11vpog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/14] mm: rename uffd-wp PTE accessors to uffd
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-4-kas@kernel.org>
References: <20260525113737.1942478-4-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:05:13 +0000
Message-Id: <20260525120513.C51E91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] make_uffd_wp_huge_pte() modifies a present HugeTLB PTE without fir=
st using huge_ptep_modify_prot_start() to atomically clear it.
--

commit 61d6f87823653be9ecc3927f774b67e53241d193
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: rename uffd-wp PTE accessors to uffd

This commit mechanically renames the uffd-wp PTE, PMD, and huge_pte accesso=
rs
to just "uffd", as the bit's meaning now depends on the VMA flag rather than
its name. It updates the pgtable capability queries and the khugepaged enum
accordingly, while preserving the ftrace string for trace-based tooling.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 1e3a15bf46f4e..cbd164f4928f0 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
[ ... ]
> @@ -2612,10 +2612,10 @@ static void make_uffd_wp_huge_pte(struct vm_area_=
struct *vma,
> =20
>  	if (softleaf_is_migration(entry))
>  		set_huge_pte_at(vma->vm_mm, addr, ptep,
> -				pte_swp_mkuffd_wp(ptent), psize);
> +				pte_swp_mkuffd(ptent), psize);
>  	else

[Severity: High]
This is a pre-existing issue, but does this code risk losing hardware updat=
es
to the Dirty or Accessed bits?

When applying the userfaultfd WP bit to a present HugeTLB PTE, the code cal=
ls
huge_ptep_modify_prot_commit() using a ptent value that was fetched earlier
without holding an exclusive lock or clearing the PTE. Because it doesn't u=
se
huge_ptep_modify_prot_start() to atomically clear the entry before committi=
ng,
the hardware could concurrently set the Dirty or Accessed bits.

The subsequent set_huge_pte_at() inside huge_ptep_modify_prot_commit() will
overwrite the PTE with the old snapshot, silently discarding these hardware
updates. The standard PTE counterpart, make_uffd_wp_pte(), correctly uses
ptep_modify_prot_start() to avoid this race.

>  		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
> -					     huge_pte_mkuffd_wp(ptent));
> +					     huge_pte_mkuffd(ptent));
>  }
>  #endif /* CONFIG_HUGETLB_PAGE */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D3
