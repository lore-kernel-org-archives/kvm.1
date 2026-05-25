Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF2381AFB
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712021; cv=none; b=exUDiKdDxJboh1qant2SjoXMCVEhrFH296xKOG11avQUF7BSe1Zzv/QaU354PhPDv8le6DMDZuxo18Ji0/t9VHpm50kXZpc1hb/hOSdiYP7Mz/+evLqHJo4xJhu0WG/g3i5tHPBp6VZBXfSEP9qncUWiC0n2xmq5Xcur0t5UdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712021; c=relaxed/simple;
	bh=wzzxE3ElEPh4t/hZcWRoHwnWTzETpyI2inciqI/lKLk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JwmkmYtMDEC6WW6OsFRtCck4qnmbnemHMy0SjzR7ErsT39XOshKo0TJobMbHKS3WUi5Xzenw0MZlhmIPXAhgbbSxqmt/qaMsxP4fChboAqLfS2gowtsOGV231BLVZLu1KPDpv5maw5K/da8Neyf8ffXwUfLmiJ1gOyNrdCxFk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQrHLitq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQrHLitq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB52A1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712019;
	bh=nw9ZiQVgsCSdq9/PpzJyAPDIgCXze0I/9yllX5fNG4o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OQrHLitqUr1Si1+hwSQjs+BF/TrXAaQNPFizeowWeSMxW/lrX5oau2VRlWan1fHmE
	 8lPR5cvWlc0+R/obH84I/4NAs8Xcxw7sV9miNaR3Ih1b+W2p+G6mTz/AcnyvvJtl9Q
	 ohJ9I1eim22N5xfsp+yu4VnTynQKDM4tMlecl1VpuHMdcXSlSmLpwGx3UVK1tMXWW4
	 Zi9S/ho8mrTh7pu+Wm/l5dnZiNbBULp4z6ioMHjFe8GEzwegN+9Bvs8c6XSI8zRsyz
	 QmaHqPLurYOM7T4Wb6QDkbuszX3FuFL3b39LW14R7RnA7kSSE1QOdAaIVYb9x8ReZL
	 Q2e88S2GVMVjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/14] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-11-kas@kernel.org>
References: <20260525113737.1942478-11-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:26:59 +0000
Message-Id: <20260525122659.BB52A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -EINVAL from pagemap_scan_test_walk() aborts the scan de=
structively, permanently losing read results for already write-protected pa=
ges in preceding VMAs.
--

commit e1f82a8dd146299570ad05611dbcb66ad50b9415
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking

This commit introduces PAGE_IS_ACCESSED to pagemap to report read-write
protected pages under UFFDIO_RWP. It separates the "has been written" and
"has been accessed" signals into distinct categories depending on the VMA's
registered userfaultfd mode.

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5e74dadfb1cb7..97fb941871a33 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

[ ... ]

> @@ -2673,6 +2698,16 @@ static int pagemap_scan_test_walk(unsigned long st=
art, unsigned long end,
>  	bool wp_allowed =3D userfaultfd_wp_async(vma) &&
>  	    userfaultfd_wp_use_markers(vma);
> =20
> +	/*
> +	 * PM_SCAN_WP_MATCHING is the atomic read-and-reset flavour of the
> +	 * scan and is implemented for the WP marker only. Reject it on
> +	 * VM_UFFD_RWP VMAs explicitly so userspace gets a clear error
> +	 * instead of a silently-skipped range; re-arming is done with
> +	 * UFFDIO_RWPROTECT(MODE_RWP).
> +	 */
> +	if (userfaultfd_rwp(vma) && (p->arg.flags & PM_SCAN_WP_MATCHING))
> +		return -EINVAL;
> +

[Severity: High]
Does returning -EINVAL here destructively abort the scan and permanently lo=
se
read results for already write-protected pages in preceding VMAs?

When a scan covers multiple VMAs, do_pagemap_scan() calls walk_page_range(),
which processes VMAs in sequence. If the first VMA is a VM_UFFD_WP VMA,
walk_page_range() successfully processes it, atomically reading the dirty
state and modifying the page tables to write-protect them.

When the walk reaches the next VMA, if it is a VM_UFFD_RWP VMA, this new
check returns -EINVAL, which causes walk_page_range() to immediately break
its loop and return -EINVAL.

Then do_pagemap_scan() receives -EINVAL, breaks its loop, and eventually
returns -EINVAL to the ioctl. The ioctl call returns -1 to userspace with
errno set to EINVAL.

Because the call failed with a standard error code and the walk end is not
updated accurately to reflect the exact failure point, userspace will likely
discard the output buffer.

However, the first VMA's pages have already been persistently
write-protected. The read state indicating which pages were written is
permanently lost, which destroys the atomic read-and-reset guarantee of
PAGEMAP_SCAN and corrupts the userspace application's state tracking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D10
