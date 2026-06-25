Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D162FD681
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424930; cv=none; b=hsejRPJI/Hvb9+x7AIWCBNSEXwhzG74OjwigPZoJqnD+r9aH1bW5EFGTgybKqSRjQLHhQu5OHEWqE0si39pARN17nYaWPWy+E67W1GOMxlvQdWUNRvMJiLOYQ/9OV75R/IzKM4Duo8fqzKA6u8j3o7Fmc2Y7b2Vev1crweeKboc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424930; c=relaxed/simple;
	bh=P8X5DY/xMR61a7jQLP+6iJOPvTAGO6SzWsPxwoVYUWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OLydqWVfbwOyVceN+w+s4SX7JlswmvWh/YyF9J/TP9RUJJSm6ND+3f+BPkLlwubdrRrgMEvZTsOvHsoUN9H9/baIogzrEcs4bFKVnfODKKN3kQ2i1Xla9PLuewv+EuFhKyZaoiTv0TRCP9bioos9CUgxZ1QLBEDwQ3hTTNXLBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL/A72XZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL/A72XZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0357E1F000E9;
	Thu, 25 Jun 2026 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782424929;
	bh=tdfiWQLium3Q68cqCP+Jciszqw+WjbC5BVZ8MUbUoRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LL/A72XZqMwN5rNuNTPKBX4Y8EloID7yC2K07WhElqKV2YkQZrSr+AqFBOqIybpY8
	 ia0hISrARXxXuyK7jPlofqMSHBjxktbyhHfi9BCEHPddIMs8RUKjS3xixvMByGKtvj
	 a2twXw4P2b5rKAVOp4FzxlDdroWwrBcyBRHyC59FL+RYCSvVZfoof18B8EwCypys/k
	 X0YBoZ//ajoMffLTsuEKXU6tylhHnZCmWUT+I9KymPmM96t8TV7M8IS+xJsxcViser
	 ZILt1nyJjDEz0nkW23/IZbopsJUAeZd2jk2esH+HkePWR2cZcI+Zlw3PlGGmryvGVG
	 Lqej39VG06ZvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
References: <CAMuQ4bX-iDvcUOPPY+NLz95tkRJYwWqvzAr=U48uNaub_HZLGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:02:08 +0000
Message-Id: <20260625220209.0357E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `vhost_vdpa_va_map` incorrectly maps unmapped memory holes, al=
lowing arbitrary file offset access via integer underflow.
- [Critical] Silent truncation of 64-bit IOVAs using `PAGE_MASK` on 32-bit =
systems causes hardware IOMMU aliasing and resource leaks.
- [High] Pinned user pages are leaked in `vhost_vdpa_pa_map()` error paths =
due to incorrect `nchunks` state tracking when encountering discontiguous p=
ages.
- [High] The use of `last_pfn =3D=3D 0` as a sentinel value allows an attac=
ker to bypass contiguity checks if PFN 0 is pinned, granting unauthorized D=
MA access.
--

commit 0a3bc0166bfe3b923420026de613987f2ecc8f2a
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

vhost/vdpa: reject overflowing PA map page counts on 32-bit

vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
size before computing the number of pages to pin. On 32-bit systems,
where unsigned long is narrower than u64, that addition can overflow and
the code can pin and map fewer pages than the requested IOTLB range.
Reject sizes that overflow the unsigned long page-count calculation.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa0d0a..ed47b1140703e 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags =3D FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn =3D 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start =3D iova;
>  	long pinned;
>  	int ret =3D 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |=3D FOLL_WRITE;
> =20
> -	npages =3D PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset =3D iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret =3D -EINVAL;
> +		goto free;
> +	}
> +
> +	npages =3D PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret =3D -EINVAL;
>  		goto free;

[Severity: Critical]
This is a pre-existing issue, but does PAGE_MASK silently truncate 64-bit
IOVAs on 32-bit systems?

Looking further down in vhost_vdpa_pa_map():

	cur_base =3D uaddr & PAGE_MASK;
	iova &=3D PAGE_MASK;
	nchunks =3D 0;

And in the error path:

		vhost_vdpa_unmap(v, iotlb, start, size);

Since PAGE_MASK is a 32-bit unsigned long on 32-bit architectures, won't
the bitwise AND zero-extend the mask and silently clear the upper 32 bits
of the 64-bit iova?

If so, wouldn't the unmap path fail to find the truncated entries using the
original start variable, leaving the memory permanently pinned?

[Severity: High]
This isn't a bug introduced by this patch, but is it possible to leak
pinned user pages in the error paths?

When a discontiguous page is encountered, nchunks is reset to 0:

		if (last_pfn && (this_pfn !=3D last_pfn + 1)) {
			/* Pin a contiguous chunk of memory */
			csize =3D PFN_PHYS(last_pfn - map_pfn + 1);
			ret =3D vhost_vdpa_map(v, iotlb, iova, csize,
					     PFN_PHYS(map_pfn),
					     perm, NULL);
			if (ret) {
				...
				goto out;
			}

			map_pfn =3D this_pfn;
			iova +=3D csize;
			nchunks =3D 0;
		}

		last_pfn =3D this_pfn;

If an error occurs after nchunks is reset to 0, but before it is incremented
in the outer loop, the error cleanup path evaluates if (nchunks) as false:

out:
	if (ret) {
		if (nchunks) {
			unsigned long pfn;
			...
			for (pfn =3D map_pfn; pfn <=3D last_pfn; pfn++)
				unpin_user_page(pfn_to_page(pfn));
		}

Does this skip unpinning the pages held in the map_pfn to last_pfn range?

[Severity: High]
This is a pre-existing issue, but does the use of last_pfn =3D=3D 0 as a
sentinel value allow bypassing contiguity checks?

In vhost_vdpa_pa_map(), last_pfn is initialized to 0 and checked here:

	for (i =3D 0; i < pinned; i++) {
		unsigned long this_pfn =3D page_to_pfn(page_list[i]);
		u64 csize;

		if (last_pfn && (this_pfn !=3D last_pfn + 1)) {
			/* Pin a contiguous chunk of memory */

If a user process is able to pin physical frame 0 (PFN 0), last_pfn
remains 0. On the next page, the contiguity check silently skips.

Would this treat PFN 0 and the subsequent page as contiguous, mapping all
memory in between into the IOMMU?

[Severity: Critical]
This isn't a bug introduced by this patch, but does vhost_vdpa_va_map()
incorrectly map unmapped memory holes?

In vhost_vdpa_va_map(), find_vma() returns the first VMA with vm_end > uadd=
r:

		vma =3D find_vma(dev->mm, uaddr);
		if (!vma) {
			ret =3D -EINVAL;
			break;
		}
		map_size =3D min(size, vma->vm_end - uaddr);
		...
		offset =3D (vma->vm_pgoff << PAGE_SHIFT) + uaddr - vma->vm_start;

If a user passes a uaddr in an unmapped hole before a valid file-backed VMA,
uaddr can be less than vma->vm_start.=20

Without a check for uaddr >=3D vma->vm_start, won't the offset calculation
underflow and produce a massive out-of-bounds offset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CAMuQ4bX-iDvcUOPPY+=
NLz95tkRJYwWqvzAr=3DU48uNaub_HZLGw@mail.gmail.com?part=3D1
