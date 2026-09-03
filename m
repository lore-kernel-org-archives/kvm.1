Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D03AC0DC
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428461; cv=none; b=N13dV4SD/CJ9tD2g7plaaxZYSr+ZHzs6/kzS87FXifxVvHiZMIm15r3MFvs2fEVB5pYOnvY9qB3Vy+4SXsXVx09X9qsCy//Rh7l+7snfc4GhZindX7mjZAkDJLyIv46Yx6SAL9BE8X6q7xGH87Cr1VIqqqZ91W7jH/amNwL5E6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428461; c=relaxed/simple;
	bh=7yKB4aXctmfqBWO3XwhnU9GprmG2qYW9BJr8rWlnbxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZB9Ac+xXNICRn4aIPIv8mjDVHD2VPlHB8cFjWlDCId9nn6mrRmgDWOtutrmlyrpczAQj7W+JsEXuK1BNqnKc0cvRQu6oVEBWgyLgecxEgjLrOzNu7aJMQgRSvl7B/yterusDlKb8ymPfmZINE8pHfGQZW25vcLABGvZjOodXyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le+VL6pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le+VL6pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FA51F000E9;
	Thu,  3 Sep 2026 09:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428459;
	bh=1dxrcpdTTNysZbTbYq9OX+Q6ggUv1c0UUqydl4xlAZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Le+VL6pMHlYHWDhYKEtqWZV1IyIxul7LySA0NEXWBknMkLY1PQsJlinY6Ney1ACqM
	 9TenoBT27Bh2LyRSFxozYnoc1ekysxh+4ptjPLB6EKkMMRMqbZ4hxxejKlokUa9yAO
	 6ovIGMz8sM1HFs9dGvHkQf+sFE7F1c47I9zmpKfJxkdj8j2sFD8OQOH+oaP/CcEXxM
	 CDxDp+DefCUrbTzDrVS7weLnwzIMAjyJIKvPIfhbWJfe5ElNQSVnVDo/i21VFTZBBT
	 QH7E2iYrgLIfWIzY8cI4dwH6kcPk2q06m7+E1BLsaJAidMd60ANIUM95mHUFnqZpg0
	 ur/jOhIWRfDTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903092912.444-1-suruurism@gmail.com>
References: <20260903092912.444-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:40:59 +0000
Message-Id: <20260903094059.99FA51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the mmap handler=
 corrupts vma->vm_pgoff by assigning it a physical frame number (PFN) inste=
ad of preserving the logical file offset.
--

commit fe80ad0e14281d6649ff304dd40e83fe0649cbb2
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/fsl-mc: prevent read-only region mappings from becoming writable

This commit prevents read-only region mappings from being upgraded to writa=
ble
via mprotect(). It does so by clearing VM_MAYWRITE for regions lacking the
WRITE flag, providing defensive hardening similar to other subsystems.

> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio=
_fsl_mc.c
> index b4c3958201b25..85f479db936c6 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -407,6 +407,10 @@ static int vfio_fsl_mc_mmap(struct vfio_device *core=
_vdev,
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> =20
> +	/* Prevent read-only region mappings from being upgraded with mprotect(=
) */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +
>  	vma->vm_private_data =3D mc_dev;
> =20
>  	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);

[Severity: High]
This isn't a bug introduced by this patch, but the mmap handler corrupts
vma->vm_pgoff by assigning it a physical frame number (PFN) instead of
preserving the logical file offset.

When vfio_fsl_mc_mmap_mmio() is called, it overwrites vma->vm_pgoff:

drivers/vfio/fsl-mc/vfio_fsl_mc.c:vfio_fsl_mc_mmap_mmio() {
	...
	vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
			       size, vma->vm_page_prot);
}

The VMA is inserted into the file's interval tree (mapping->i_mmap) using
the PFN as its key instead of the logical file offset.

If the kernel later attempts to invalidate or unmap this region (e.g., via
unmap_mapping_range() during device removal, reset, or when switching VFIO
modes), it will search the interval tree using the logical file offset, fail
to find the VMA, and leave stale hardware mappings active in userspace.

Can this allow userspace to access hardware after it has been reassigned,
causing serious security and stability issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092912.444-=
1-suruurism@gmail.com?part=3D1
