Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996453F5BDB
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428497; cv=none; b=Z3cG3/01giugD2W879ce+LPm3wXYUqfIjKCO732y9PhxbKXqhq9MhQrCUATVusqQvejlnwVxiuguQXoP8VureJFa0mttvm8MzrxlkFkzZdMXdWxvZGxRasjI1CwtkT+pYYe9cCg0PIyfKwvoIrRpz+7iyb8wQInEyZCNMg1JSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428497; c=relaxed/simple;
	bh=663MAugiNUrzPMLNiZ7LYAmjdXt+gtqvsYLnDz9zhV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lgMfT93iBuvVwXDBKuvbf2bifyeGzIMIdg7iH+hIpVkPGaO0SsyZ2k81LOHzQKp2gKCLRelWYvHKPBHMHlu6vDvDGBOMyK8rVVk3JA4xEhRKw2VTo9r+Cko0dt7yf3ZkT+uacfzwtVjQqWldb9evFyQS/fJpaofuQV5T6TUfrcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAwwtoiN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAwwtoiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E01F000E9;
	Thu,  3 Sep 2026 09:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428496;
	bh=ixH0ImIKZgyB3WnRFRxtcWYkqOSQ4JZpKjXnDlzkfIQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAwwtoiNASc/HG2TGblqKUMqd0CFRSPiIgcyhCUIsTxUukOEJTbqCOQMJqAu3BLbW
	 JyoRXuV+vyjMbkD3rCWEZCGCd0OCOFOV9hgkFls/cIsN9VGzcUWnfBRM/81FjhwRyz
	 xneT1LP2niSb/soDj3pcI+53Ht/6eDnSE6wWK8QJUQ0nx4MkGU5zWcQzUNhqZtUviN
	 Ji6EiTcksMzCg0qJ8XKCOzg+ripAsYVXyhBBPlKA40bJrdgGu1uEgi1dShn0A0ENvf
	 WzEAbr/tuKqlb28bVGQ6Bp8tF1twENb2EHJIWY/fUqGJAjQyfpdnqzukTFiGF16Dbf
	 tGIxsvYrJM1cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/cdx: keep logical vm_pgoff in MMIO region mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903092932.526-1-suruurism@gmail.com>
References: <20260903092932.526-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:41:35 +0000
Message-Id: <20260903094136.076E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical logical offset corruption bug exists in other VFIO d=
rivers and was missed by this patch.
- [High] vfio_cdx_mmap() lacks a check for VM_SHARED, allowing MAP_PRIVATE =
mappings to trigger COW logic in remap_pfn_range() which silently overwrite=
s vma->vm_pgoff.
--

commit 45f024cf47848e30b98e2a95c27f35dd87c7eb98
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/cdx: keep logical vm_pgoff in MMIO region mmap

vfio_cdx_mmap_mmio() overwrites vma->vm_pgoff with the physical frame number
of the MMIO region and passes it to io_remap_pfn_range(). This causes the
interval tree entry to land in the wrong coordinate space, leaving stale
MMIO mappings behind during revocation.

> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index b31ed4be7bdc1..53d916cfcb8e8 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -254,10 +254,10 @@ static int vfio_cdx_mmap_mmio(struct vfio_cdx_regio=
n region,
>  	if (base + size > region.size)
>  		return -EINVAL;
> =20
> -	vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;
>  	vma->vm_page_prot =3D pgprot_device(vma->vm_page_prot);
> =20
> -	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +	return io_remap_pfn_range(vma, vma->vm_start,
> +				  (region.addr >> PAGE_SHIFT) + pgoff,
>  				  size, vma->vm_page_prot);

[Severity: High]
This is a pre-existing issue, but does vfio_cdx_mmap() lack a check for
VM_SHARED?

When userspace requests a MAP_PRIVATE mapping of a CDX device region,
vma_is_cow_mapping() evaluates to true. Inside core MM's
io_remap_pfn_range() -> get_remap_pgoff(), the COW mapping check explicitly
executes *vm_pgoff_p =3D pfn;

Since this silently overwrites vma->vm_pgoff with the physical PFN, an
unprivileged user mapping the device via MAP_PRIVATE could retain access
after device revocation, defeating the core VFIO security boundary.
Does vfio_cdx_mmap() need to validate !(vma->vm_flags & VM_SHARED) to
prevent this?

[Severity: High]
This isn't a bug introduced by this patch, but does the identical logical
offset corruption bug exist in other VFIO drivers?

For instance, drivers/vfio/fsl-mc/vfio_fsl_mc.c in vfio_fsl_mc_mmap_mmio()
overwrites vm_pgoff:
    vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

Similarly, drivers/vfio/platform/vfio_platform_common.c in
vfio_platform_mmap_mmio() does the same:
    vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

Because these drivers place the VMA in the device inode's interval tree
under the wrong coordinate space, wouldn't unmap_mapping_range() revocation
fail for them as well? Should these drivers be updated similarly to maintain
the VFIO security boundary?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092932.526-=
1-suruurism@gmail.com?part=3D1
