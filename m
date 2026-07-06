Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15E642252B
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329666; cv=none; b=ZAnhSE2/6kDG/pI7/7/jK/mfJvwdYP331w+Mi9qyJqLKKzwWnq3A8W+VzXz7jhcWJo9ld65LxjWtzqDvDV2uPt0nxc5p8BbsS8CLOrNBj0LaKnFrxoWk1sjZ/CTpbMqqqQ39SHUfAZH9GzLSW119BVGoM7HNjQk93oJBVMrmdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329666; c=relaxed/simple;
	bh=NT7pTF8uimt9yGCLuRWY0XlMvb8xAXaesTzvNM9iTIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qck+Y6mFaWXQFHjEzgWgBaP17qJZJD/EuxzguFWeUmGNQIWjxgMjtSw8WDl2usRLADOZo6n3GAIm6PXAgvrvmEFp7TNjA5wuV1rQGb+NtFe8WEnMamzBzpPciezom4KCvGxhYGW8PFuVj8rXKVIBEMQADw23Nqm+Sc9GNxJA9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWDTyCds; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWDTyCds"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A9D1F000E9;
	Mon,  6 Jul 2026 09:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329660;
	bh=fHIjsPcgsECV6q3QOI8aRuQSr0Bi+MUklKNvIxVnG4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWDTyCdsxySeYWlvmuizDEZz/OvQupz5OkUNAAMQVMr8VIJ3ovq0MVneHtE/FfRwb
	 phJZQXbYTNBY9RvF/Lu5S/q6hoDAnj643En+9wkzm6Dg34hvXFlhDtIuVcbB53jCLH
	 atFJ/sypO9/g31QBoTyqF0eMpa5gsNeKVg8Ho2DAO6qyv1gqB1EX8tn/r7ExexhW0s
	 mtOLz9vDaxkohPIuyWpp6bl86hZeizm3U+Uo5oUqZSKdfu82JGvnyQWU79uXaAfzW6
	 Ghg4+ECOcL3pQkJVmCLtBUQ57KRCQR6rzSMe6P7RtlIMfKA4wlyPycYi+H+5LRWeEY
	 MFkNU37HDWhuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/15] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-14-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-14-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:20:59 +0000
Message-Id: <20260706092100.61A9D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly introduced UFFDIO_SET_MODE ioctl iterates over the VMA t=
ree of an external mm_struct without calling check_stable_address_space(mm)=
, risking crashes if the VMA tree has been destabilized by an OOM reap or f=
ailed dup_mmap().
--

commit b1666c80355a8be527727cc3ee914087739f01c2
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_SET_MODE for runtime sync/async toggle

This commit adds a UFFDIO_SET_MODE ioctl to toggle UFFD_FEATURE_RWP_ASYNC
on an existing userfaultfd at runtime. It synchronizes the mode switch by
taking the mmap write lock and calling vma_start_write() on all armed VMAs.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 763897f596783..c96cfe0871dd0 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
[ ... ]
> @@ -4299,6 +4309,109 @@ static int userfaultfd_rwprotect(struct userfault=
fd_ctx *ctx,
[ ... ]
> +static int userfaultfd_set_mode(struct userfaultfd_ctx *ctx,
> +				unsigned long arg)
> +{
[ ... ]
> +	mmap_write_lock(mm);
> +	{
> +		struct vm_area_struct *vma;
> +		VMA_ITERATOR(vmi, mm, 0);
> +
> +		for_each_vma(vmi, vma) {
> +			if (vma->vm_userfaultfd_ctx.ctx =3D=3D ctx)

[Severity: High]
Does this code need to call check_stable_address_space(mm) before traversing
the VMA tree?

Since this iterates over the VMA tree of an external mm_struct, if the VMA
tree has been destabilized by an OOM reap or a failed dup_mmap() (which
inserts XA_ZERO_ENTRY markers and sets MMF_UNSTABLE), iterating the maple t=
ree
might cause an illegal pointer dereference when accessing
vma->vm_userfaultfd_ctx.ctx.

> +				vma_start_write(vma);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D13
