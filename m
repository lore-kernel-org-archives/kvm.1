Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CF53D3013
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808069; cv=none; b=HI4KYe5ZExb2m6oGMM5USW/yREo6lqcagUkaRoHJm/ZDg0S7RIcxZKFIB8YIVMlI8KTloavMwuK0ePZ0sbVwLdhWVNVS+IfPLlrva7eeYXJjtSyHYFEao0ctu5jxi0Ut8x3M9VfIaGIpTxMVcLV+Ibb+ykwNASP+Xt6S8YmF1Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808069; c=relaxed/simple;
	bh=yqLbdx2+N1IWN/d2ABHcFLi0HIPvSwmquQjRkB57Tik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J+4XkjHD4IlL/evS8xYEf/JgIER66jmLSqXNOyxwbtKQDJLp/n/4EODleoBjYgBJ+VF0KUJKVZ09pHAJbX8n2Vsroa2fRdAbWX02oG7Jf0dqWFq9OjYMkUZb1r9ff66YyrM4D6keQ2r+hBS5Oya0uuaY0ngZSpyt84pdLnRRMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WErBmgR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WErBmgR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040591F000E9;
	Tue, 26 May 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808068;
	bh=4L8oWOAAvrwgxYb5nCo0l9//fCw1V4yTY54rwbsXAgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WErBmgR+Z06vZXtdr8WDQ+hKaYn40/aeCkP+k+OxEk4l0bSk9cwug7sVTPerpt9sE
	 eRiqo+Fku+ckNfiMxCZjYAFIOnLC5ID6Hxi/GId6F67WqO0HRK3b0eyJofVwE6038W
	 cCNvT0DwVQ4mIR2T4bi1KTCrznj5l+/Cqozh/4Bnwo/HA/hUVkKgEmki5ydPlR37bN
	 NXTjB96jDLnUgKtS8W8oXeP0qdDqRUF+VLtu+PsjJKCo/f0k2+faPU9b2iTGWiUUlF
	 rnaQhWbpeiPtIeOzojur7FoMdo8JBj+uoKv0kSxJ/D8RALdULGvu0F2NKtRQi3ycGW
	 rRdWNPJP5qggA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/18] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-17-kirill@shutemov.name>
References: <20260526130509.2748441-17-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 15:07:47 +0000
Message-Id: <20260526150748.040591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Iterating over VMAs on a potentially unstable mm_struct withou=
t calling check_stable_address_space(mm) beforehand.
--

commit 8f453481752954b7331f26ca18fe64760d20297c
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle

This commit adds an ioctl to toggle userfaultfd async mode at runtime witho=
ut
re-registering. It updates the context features locklessly for readers, whi=
le
draining in-flight faults by acquiring the mmap_write_lock and calling
vma_start_write() on all armed VMAs.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index f40bf473a6f68..f172ec14a6c84 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c

[ ... ]

> @@ -4290,6 +4300,109 @@ static int userfaultfd_rwprotect(struct userfault=
fd_ctx *ctx,
>  	return ret;
>  }

[ ... ]

> +static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
> +				unsigned long arg)
> +{
> +	struct uffdio_set_mode mode;
> +	struct mm_struct *mm =3D ctx->mm;

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

[Severity: Critical]
Does this VMA iteration need to verify the address space is stable?

Since the mm here is accessed via the userfaultfd context (and could be an
external mm_struct), iterating over it without calling
check_stable_address_space(mm) after acquiring the mmap lock might encounter
XA_ZERO_ENTRY markers in the maple tree if the mm was flagged MMF_UNSTABLE
(e.g., from a dup_mmap() failure or the OOM reaper). Accessing
vma->vm_userfaultfd_ctx.ctx on a zero entry could cause a kernel panic.

> +			if (vma->vm_userfaultfd_ctx.ctx =3D=3D ctx)
> +				vma_start_write(vma);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D16
