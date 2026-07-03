Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A7035AC20
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089973; cv=none; b=dxsqTPMFwiDfX+ATxskZkzu7OVgLa+V4e6eYmG+F4Kpo+xQ8y6infuQW0CpFrsGI6k6PfUIPIP/4kb5hw8GEuFtje1FyIbJcwvvm//QyrsuB8upb6f63ZvMsqT2NLgppWZC+lPknsP/73eAXuNsU327/lJ7rwMIhDSpY53H4HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089973; c=relaxed/simple;
	bh=QV9m4XZupIM7CGvfquodn6Gtb712uh5IHaJDerE5BgY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YVtK3KDjceCuy0c2cjtorUEjXLJ2tjELxbtxt5zWtN5rop41oo4v96DGeUMDCULYZ2zfAc1k2LMaltra9/f2WHM+7wJkmeEJELP3mqGxEN3m/LlCcHY+PmHqq1y6mqYbsHXleLXJC+Kh7eYcT3s6K1PD2YY5HdCLnzanp353Z00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bboPjLGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bboPjLGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993FD1F000E9;
	Fri,  3 Jul 2026 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783089971;
	bh=3WnINcswkSZwoLEzgPqbgPG9jAVfmL05EC6BQLMOUAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bboPjLGgvucv17C0g24yi2E7ie/LLvuzrs5EIvFQWdiqf+f/AUtDq+f+g0UojSDNn
	 2+ycNPTKemb5vU/FUXCP+a6gwhskdpFCKevbElf223u64MEsM/clIfw09W6uP8kqjS
	 QYNK3qGLJzBFrYV8YDbY65mNXsO4ItlmlykdsyUwsu79llzELeyG2jiJF63VshPigY
	 4a93uSbgbvd/nQaQuBWP9X3INQr7j+yqwZmwMvHEQCJ8RBsXqbhF8779XdP5B69fxS
	 DgMmVrfjj/4bX1h/Hy2FwkTyxqXQUJmsqZNbguOUkUvT0XNyT8pzt9qiWCShBVA02E
	 bP2F2QtI/79Ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/15] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-14-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-14-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:46:10 +0000
Message-Id: <20260703144611.993FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The userfaultfd_set_mode ioctl iteratively traverses the VMA tree =
of a potentially external mm_struct without explicitly validating address s=
pace stability.
- [Medium] The UFFDIO_SET_MODE ioctl mutates ctx->features concurrently wit=
h userfaultfd_register() reading it locklessly.

Pre-existing issues:
- [High] Page tables are accessed and modified in userfaultfd_clear_vma bef=
ore draining per-VMA lock readers.
--

commit f2f2d67be0ee3504658c8376634c7b20b76102e1
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle
   =20
This patch adds a new ioctl, UFFDIO_SET_MODE, to toggle userfaultfd features
at runtime, specifically the asynchronous mode for read-write protection (R=
WP).
It implements the logic to update context features under mmap_write_lock and
wakes pending faults so they retry under the new mode.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 1a3504c635972..a7659b0a1147e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -4297,6 +4307,109 @@ static int userfaultfd_rwprotect(struct userfault=
fd_ctx *ctx,
>  	return ret;
>  }
> =20
> +/* Subset of UFFD_API_FEATURES actually supported by this kernel/arch */
> +static __u64 uffd_api_available_features(void)

[ ... ]

> +static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
> +				unsigned long arg)
> +{

[ ... ]

> +	/*
> +	 * Drain in-flight faults before flipping features. mmap_write_lock()
> +	 * blocks new mmap_read_lock() callers, but per-VMA locked faults
> +	 * (lock_vma_under_rcu() + FAULT_FLAG_VMA_LOCK) that acquired before
> +	 * this point keep running. Calling vma_start_write() on each UFFD-
> +	 * armed VMA waits for those readers to drop, so no in-flight fault
> +	 * can observe the old features after mmap_write_unlock().
> +	 */
> +	mmap_write_lock(mm);
> +	{
> +		struct vm_area_struct *vma;
> +		VMA_ITERATOR(vmi, mm, 0);
> +
> +		for_each_vma(vmi, vma) {

[Severity: High]
Does this code need to call check_stable_address_space(mm) before traversing
the VMA tree? Iterating the VMA tree of a potentially external mm_struct
without validating address space stability could crash the kernel if the mm
is undergoing teardown (like OOM or failed fork) and contains XA_ZERO_ENTRY
markers.

> +			if (vma->vm_userfaultfd_ctx.ctx =3D=3D ctx)
> +				vma_start_write(vma);
> +		}
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the use of
vma_start_write() here, I noticed a pre-existing issue in
userfaultfd_clear_vma():

mm/userfaultfd.c:userfaultfd_clear_vma() {
...
	/* Clear the uffd bit and/or restore protnone PTEs */
	if (userfaultfd_protected(vma)) {
		unsigned int mm_cp_flags =3D 0;
		struct mmu_gather tlb;
...
		tlb_gather_mmu(&tlb, vma->vm_mm);
		change_protection(&tlb, vma, start, end, mm_cp_flags);
		tlb_finish_mmu(&tlb);
	}
...
}

Can accessing and modifying page tables via change_protection() before
calling vma_start_write() (which drains per-VMA lock readers) lead to
data corruption or use-after-free? A concurrent page fault or MADV_DONTNEED
under the per-VMA lock might observe intermediate page table states or
cleared entries.

> +	/*
> +	 * Single WRITE_ONCE so lockless readers (fdinfo, poll/read_iter
> +	 * via userfaultfd_is_initialized(), and the userfaultfd_features()
> +	 * helper used elsewhere) can't observe a mid-RMW intermediate
> +	 * value. Hot-path readers already serialise through the mmap lock
> +	 * + vma_start_write() drain above, so their load doesn't need an
> +	 * annotation.
> +	 */
> +	WRITE_ONCE(ctx->features,
> +		   (ctx->features | mode.enable) & ~mode.disable);

[Severity: Medium]
Could this concurrent write cause a data race with userfaultfd_register()?

userfaultfd_register() currently reads ctx->features natively:

mm/userfaultfd.c:userfaultfd_register() {
...
	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_RWP) {
		if (!pgtable_supports_uffd() || VM_UFFD_RWP =3D=3D VM_NONE)
			goto out;
		if (!(ctx->features & UFFD_FEATURE_RWP))
			goto out;
...
}

Should userfaultfd_register() be updated to use the new userfaultfd_feature=
s(ctx)
helper that safely uses READ_ONCE()?

> +	mmap_write_unlock(mm);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D13
