Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847682E424F
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712941; cv=none; b=KBJbIl9TnkWJibIlzw9h8rhFORShgXhnr/l4+ENseIWulyAZLIO/9YJQ0BrkbRjX5CgxmgX/HdbE/VY9sArCMbHOdoWtk9KmlXCCqERzp7c1dvDyeRhIB+Apw5YEr+khRJGGRK5TC39gXH3intwA6HiQ9nLAgKWVUXy/9YokFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712941; c=relaxed/simple;
	bh=Wo/OCnbAQcg/PLrRNrWwi39n2yBTXFGefhQCqORglwM=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DAF3J4CcTeeeGCiSG64pLBK1NkeTBHiUVHd+5NCm5amKy3W1wA845kC19KWK28kWlnNw0y2yMIwLVy1lF1P8IGdE8nB1F6p+/ea2CBlKRZVk2YudOAJvUyOAS4lyBrRvc2+ZsjDn4s5xXu+MvyqoIWsGKxrhseFYxnLHIw/wIZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WH2MIt63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WH2MIt63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5336F1F00A3A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712940;
	bh=gvIPoNXrTi2uVXmW3mMo6pW5mG91lBhuVwWsnt9m+OE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WH2MIt63NS19FABn4rEJHHYe8R5lSAOizkkRfS67NBraE0xSIutn3I2cX37y2ilyc
	 0iy2PKZYVrWISm4s1+B5OxNxh7G3D5phsmCTmvcyjg3Rw+MGQmhzil7cAo7h0bQeEd
	 a49xWObAPCmaaVWTOAxqXePsBVE9dpyGfTiUBcCnWppBtPLWXIN8Cl5Ux0N2Wiu8dm
	 1owlKtoMQYRzqL/VsGLA2IRrP4GytYtdoGUeOXp85szFN26yo3mEhHa+q5lxRCXte6
	 dPZpScWrTZi+nKdRtU5DUTduwOcoavurOx6Oltcdeg6V2aQBohVyAd82K2TW1ykbtz
	 ZJiH//HIHWR7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/14] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-13-kas@kernel.org>
References: <20260525113737.1942478-13-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:42:20 +0000
Message-Id: <20260525124220.5336F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The userfaultfd_set_mode function iterates over an external mm_str=
uct's VMAs without verifying address space stability.
- [Low] Lockless read of ctx->features races with its own WRITE_ONCE update=
, causing a data race.
--

commit 6988a435b501422279701e12a0fb8f5c3d604468
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle

This commit adds an ioctl to toggle UFFD_FEATURE_RWP_ASYNC on an active=20
userfaultfd context. It handles synchronization by acquiring the mmap_write=
_lock,
draining in-flight faults via vma_start_write(), and waking pending sync
waiters to retry.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 20478bb373111..680ef9bd57fd6 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -4261,6 +4271,109 @@ static int userfaultfd_rwprotect(struct userfault=
fd_ctx *ctx,
>  	return ret;
>  }
> =20

[ ... ]

> +static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
> +				unsigned long arg)
> +{
> +	struct uffdio_set_mode mode;
> +	struct mm_struct *mm =3D ctx->mm;
> +
> +	if (copy_from_user(&mode, (void __user *)arg, sizeof(mode)))
> +		return -EFAULT;
> +
> +	/* enable and disable must not overlap */
> +	if (mode.enable & mode.disable)
> +		return -EINVAL;
> +
> +	/* only toggleable features that this kernel/arch actually supports */
> +	if ((mode.enable | mode.disable) &
> +	    ~(uffd_api_available_features() & UFFD_FEATURE_TOGGLEABLE))
> +		return -EINVAL;
> +
> +	/* RWP_ASYNC can only be enabled on contexts that negotiated RWP */
> +	if ((mode.enable & UFFD_FEATURE_RWP_ASYNC) &&
> +	    !(ctx->features & UFFD_FEATURE_RWP))

[Severity: Low]
Is it possible for a concurrent UFFDIO_SET_MODE call to trigger a data race
here?

Because ctx->features is updated with WRITE_ONCE() later in this function,
reading it locklessly without the new userfaultfd_features() helper
(or READ_ONCE) might cause KCSAN warnings, even though the UFFD_FEATURE_RWP
bit itself doesn't change.

> +		return -EINVAL;
> +
> +	if (!mmget_not_zero(mm))
> +		return -ESRCH;
> +
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
Does this iteration code need to verify address space stability before
walking the VMAs?

Since ctx->mm can belong to a different process, it might be marked
MMF_UNSTABLE if the target process encountered a dup_mmap() failure or
was reaped by the OOM killer.

If the address space is unstable, the maple tree might contain XA_ZERO_ENTRY
markers, which could cause a kernel panic when dereferencing
vma->vm_userfaultfd_ctx.ctx.

Would it be appropriate to call check_stable_address_space(mm) right after
acquiring the mmap_write_lock?

> +			if (vma->vm_userfaultfd_ctx.ctx =3D=3D ctx)
> +				vma_start_write(vma);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D12
