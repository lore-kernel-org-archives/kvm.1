Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B323E325
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424325; cv=none; b=AmE9YMRBcTrp7sP8YcZQNBBRWOnG+ZOQRSCFnj28coPxXADKw0OO0Mes84W+o2oN3ioYh8drIt03oNvx4HeudD/BPJ1/ZN2SH74sKC5E5WZhjJq7IQfPXPTgF2KAEmjz4eWYAfAWWTMS3L821xrFx4XOzLnce2WwEXL8lmSw8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424325; c=relaxed/simple;
	bh=5YOpagILqInP1FvR3u4NYpzRXerdqu1k470mE0wdMt4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O3q8DYRwadGLXHgmUHjKdEbunB+Q9LL0kS73gg5J5VgpYhMXz/9ynbJ+91iHJWYlJnahNYSSa/Ah5iYjMw6Bq+XCvgeqoTQgAcHqFqY6ST42OXjSJt8NJWQIVz7YC5GBu53Yfkl9N00hcVL0t28z5IXI/PgXnxTWO6wvp5v0s1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV0Ty24M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV0Ty24M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255821F000E9;
	Thu, 25 Jun 2026 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782424324;
	bh=czPd+Ip3VtDlkv9FIOERDtKVGULRk2k+qBSDJdMg4I0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV0Ty24MnERAtrMsu0tm3EaQXX0qRgYTGsGifh7Tez6OE9wIwRvktjobz5/5AME8T
	 YgZVw7q1dsFfOdYLEgX08STbO0B85Vzwx039DJrxbURdc8BlBt09TOspA8OUVh+1/5
	 YpKXaovbXyrWyTId07j986uEyJOdhS9kf9YE6xQxQSHW3gfJzWz2umfbX+HHy9qXDB
	 Tt0DpK7/CkQ9xN3R/IJG30HOATh3abgSCY1DesAImliOaR4FwgC+SLoZ4ya42hJFjx
	 h7s0c6e1cXINtiVZ+ZSyf5YvWdk0uHUZ2f2AUH7Z3PhPZEv1ga+Mz05Qk6PQMQGlFl
	 flKA6hp3Rtwyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
References: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 21:52:03 +0000
Message-Id: <20260625215204.255821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pinned user pages are permanently leaked if an error occurs while =
`nchunks =3D=3D 0`.
- [High] Physical Page Frame Number (PFN) 0 is incorrectly used as an unini=
tialized sentinel, allowing arbitrary unrequested physical memory to be map=
ped for device DMA.
- [High] TOCTOU race in pinned memory accounting allows bypassing RLIMIT_ME=
MLOCK limits.
- [High] Lack of IRQ synchronization when updating eventfd contexts leads t=
o Use-After-Free.
--

commit d1839bff45ce1f59809fef0915e44efced86e1e1
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

[Severity: High]
This is a pre-existing issue, but could this accounting sequence lead to a
Time-Of-Check to Time-Of-Use race allowing users to bypass RLIMIT_MEMLOCK?

Shortly after the page calculation in vhost_vdpa_pa_map, the limit check
reads pinned_vm under a read lock:

    mmap_read_lock(dev->mm);
    lock_limit =3D PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
        ...
    }

Because the lock is taken for reading, concurrent IOTLB update ioctls from
multiple threads sharing the same dev->mm can read the same old value of
pinned_vm and pass the limit check.

The atomic addition happens much later in vhost_vdpa_map:

    atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);

Does this allow the limit to be arbitrarily exceeded, potentially leading to
Out-Of-Memory conditions?

[Severity: High]
This isn't a bug introduced by this patch, but does the physical contiguity
validation in vhost_vdpa_pa_map misbehave if memory maps to physical page 0?

The variable last_pfn is initialized to 0 and used as a boolean flag to det=
ect
physical contiguity breaks:

    if (last_pfn && (this_pfn !=3D last_pfn + 1)) { ... }

If a user successfully pins a memory region that maps to physical page 0,
this_pfn becomes 0 and last_pfn is updated to 0. On the next iteration,
the check evaluates to false because last_pfn is 0, bypassing the contiguity
break entirely.

Could this cause PFN 0 and subsequent disjoint PFNs to be merged into a
single contiguous chunk, potentially allowing the device to perform DMA into
unrequested physical memory?

[Severity: High]
This is a pre-existing issue, but do we leak pinned physical memory if an
error occurs while nchunks is 0?

In vhost_vdpa_pa_map, nchunks tracks if there are outstanding pages to unpin
on the error path. If the inner loop encounters a non-contiguous page, it m=
aps
the chunk and resets nchunks:

    if (last_pfn && (this_pfn !=3D last_pfn + 1)) {
        ...
        map_pfn =3D this_pfn;
        iova +=3D csize;
        nchunks =3D 0;
    }

The loop then continues processing the remaining pinned pages in the current
batch. Because nchunks is only incremented at the start of the outer while
loop, it remains 0 for the rest of the batch.

If pin_user_pages fails on the next iteration, the goto out path is taken:

    if (sz2pin !=3D pinned) {
        ...
        goto out;
    }

The error handler checks if (nchunks) and skips unpinning the outstanding
pages from map_pfn to last_pfn. Can this permanently leak the pinned pages?

[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
risk when replacing eventfd contexts in the same subsystem?

When the VHOST_VDPA_SET_CONFIG_CALL ioctl is executed, it replaces the
existing eventfd context and drops the reference to the old one:

drivers/vhost/vdpa.c:vhost_vdpa_set_config_call() {
    ...
    if (!IS_ERR_OR_NULL(ctx))
        eventfd_ctx_put(ctx);
    ...
}

However, hardware interrupt handlers locklessly dereference these context
pointers:

drivers/vhost/vdpa.c:vhost_vdpa_config_cb() {
    ...
    if (config_ctx)
        eventfd_signal(config_ctx);
    ...
}

If the ioctl frees the context concurrently while the interrupt handler is
running on another CPU, the handler could access freed memory. Since there
is no synchronize_irq() or RCU mechanism here, can this result in a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CAMuQ4bURwyoJtKUskz=
XpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com?part=3D1
