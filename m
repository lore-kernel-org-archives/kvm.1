Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B971E492D
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788699188; cv=none; b=jpLut1BiKkLO68S1aaeLte1S+0MrxCVSzKSrms/7nOZwm9lUCDS8ewX80gOSMWkcaBho0lIew1wm8eJE6LDVdJQPdywkRJvtmaFCK/lzewUeEAaR5W+EDwARpB0IxNzZ7kEN3Dy+OMwEhLD1oE+AEVtmdB3tkYGsoFxo8sJXZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788699188; c=relaxed/simple;
	bh=u+C5i0cSq4Uo/ybPC1v4hY1QDoc+l3ES+MEoTARAvCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BQvgcs8V3+jOhVZOdnGjYcDsc4MsIj35h5xUvUPYl6hJOk6ripzcMmxcod6XRB4qNg40KGhGxzTw5v5Z1wZjK+TWRT3D4yolAK1aL/Qjd1cc69Q5JjUje/Oy3mTwi9h4W+tXT3XG1LhUiHtIabUgMlfhHM2zwupHO4oGBEFxL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4nDvZmF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4nDvZmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B79B1F00A3A;
	Sun,  6 Sep 2026 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788699186;
	bh=m1NTHpdUH2uaQ1BD5tmpvUKkl/oZ9EgS7T8ZmmK5Tcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4nDvZmFXPvhrwUX8Oi8UW52G8SQcKElePkUI93Kd+xha0+u7dWjUm4U0wa5r+GE2
	 j5+wDqmHmyTZK8USj4sy1WrV4gaw9kDqXGlaEruVWHjmfgbgIsXNOXAcBfpXf0NYVu
	 GIQiC3OVvepyDPmxH++nz5V4FXA7/wPEpDirjYk4l1bD+BgOMxmDf6VvB050FI3M1a
	 UTa6OF0iF8ucNX86nezQMBqyApxSJnMn5JyQ/daoE4HTmEon5JfAmN8b+fqSUGsm29
	 M0GbY+3eJCC9LdPnn0Q0r1tlhCkb+YYkEJxCGraYm9PwesBoI41/9XepvARtK56NLU
	 FoDwEO4OAe2xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/cdx: reject non-shared MMIO mmaps
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260906123245.10884-1-suruurism@gmail.com>
References: <20260906123245.10884-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 12:53:05 +0000
Message-Id: <20260906125306.6B79B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to prevent interval tree corruption because vfio_c=
dx_mmap_mmio() explicitly overwrites vma->vm_pgoff with a raw physical fram=
e number.
- [High] The mmap handler fails to clear VM_MAYWRITE for read-only regions,=
 allowing unauthorized write access via mprotect().
--

commit a72fc948fdc663ac850e54c9671f37f1c661b655
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/cdx: reject non-shared MMIO mmaps

This commit rejects non-shared mappings in vfio_cdx_mmap to prevent
remap_pfn_range from overwriting the logical offset with a physical
frame number. The core links device mappings to the interval tree using
this offset, so preserving it is necessary for device mapping revocation.

> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index b31ed4be7bdc1..6d208db0896d6 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -271,6 +271,9 @@ static int vfio_cdx_mmap(struct vfio_device *core_vde=
v,
> =20
>  	index =3D vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
> =20
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does this patch fully prevent the interval
tree corruption? The commit message notes that placing a raw physical frame
number into the vm_pgoff field breaks revocation because subsystems like vf=
io
use the logical offset to search the interval tree.

However, if a user maps a region as shared, this check passes and the driver
eventually calls vfio_cdx_mmap_mmio. In that function, the logical offset is
explicitly overwritten with a physical frame number before inserting the vma
into the tree:

drivers/vfio/cdx/main.c:vfio_cdx_mmap_mmio() {
        ...
        vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;
        vma->vm_page_prot =3D pgprot_device(vma->vm_page_prot);

        return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
                                  size, vma->vm_page_prot);
}

Will this cause stale mmio mappings to survive device teardown for shared
mappings as well, potentially leading to a use-after-free of mmio memory?

[Severity: High]
This is also a pre-existing issue, but does the mmap handler leave read-only
mappings vulnerable to an mprotect escalation?

Further down in vfio_cdx_mmap, the driver enforces read-only permissions by
checking if the write flag is set when the region info write flag is absent:

drivers/vfio/cdx/main.c:vfio_cdx_mmap() {
        ...
        if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
            (vma->vm_flags & VM_WRITE))
                return -EPERM;
        ...
}

Since the vfio device file is opened for read and write access, the core mm
layer initially sets the vm_maywrite flag on the vma. If a user maps a
read-only region with read permissions, the check above passes. Because
vm_flags_clear for vm_maywrite is never called, could the user subsequently
call mprotect to add write permissions, bypassing the hardware protection
and gaining write access to the region?

>  	if (index >=3D cdx_dev->res_count)
>  		return -EINVAL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906123245.1088=
4-1-suruurism@gmail.com?part=3D1
