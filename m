Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB114657F2
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420989; cv=none; b=rVIEbkXi8i/c+UpBnVZH8x0VHT+frzMsZSXU8H68OwC5vGjMGUWg6CorQogKMJPyftzDBpuU/6X4JYZf89Ftksz0FQ8Qkru7NFJjs/cHK6u/Mhp/+uDP0BbwWyoyQ7Qegal6JWU7Bi4TDgFwIwxI6qqROgW6gcyrCKK0nw54VmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420989; c=relaxed/simple;
	bh=i4Cu9JmulRLZ7zOZ49AsCIyor5qAZJVTjjC0K2Z0/2U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Difl0nVTUhGLcBaupOgz8E9TG5zkktxR1oaQ7CnmU3kpukDnb97Q8ySbVX18jMekkK1au9XNtnBWsbO44sHLP4CzcZnzvGnC4ofGvXEgknmngCG6bUQni+zNDgvyBiaW2twqdGdmR9/m6D41d/MLk+MJInV/9yDjH5EkhcArw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgAyxNat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgAyxNat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3721F000E9;
	Thu,  3 Sep 2026 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788420988;
	bh=RsehaBE0rhwIYeRhUI0S2dbcfG2qxdnfJz5rYREL2dA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TgAyxNatdqechzzomJv14w1StiKcgLP9dCFbbgBoxnNd16Zwz8qPD4X01Bq90vha7
	 cQSasJkIs+sG2Kpno2C0BhpgsCQ2NoPozg17KhjMO6sj34abLvUo4+PyVnA2UHpTGI
	 V36A9qn1JOJW4YaJJ7CA7wN9KC5Tx2q26uVLgMKANmuubDK5QLlAVFukZm0sX3QKXs
	 bUpWOEVWBE/Ttdc/BG4j2hDNkoXB0/ElDCLv3nUlKbmZHPbzbOPDf+M7q8mFoP9wRw
	 jNMRM32Bpbs+yT71tuWe45+t73uPlPdWkYK4fAQCoFD5+NNvyR5y0CcMmwzQxlPy7k
	 P4vDgjauMqPZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903071946.13116-1-suruurism@gmail.com>
References: <20260903071946.13116-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:36:27 +0000
Message-Id: <20260903073628.0B3721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Raw PFN assigned to `vma->vm_pgoff` breaks VMA interval tree t=
racking, preventing mapping revocation.
--

commit 6ac5ec709c08089fbe1017cf464e9e2bf97e612e
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/fsl-mc: prevent read-only region mappings from becoming writable

This commit clears VM_MAYWRITE for regions without the WRITE flag to prevent
user-space from upgrading read-only mappings to writable via mprotect(). Th=
is
hardens the interface in case read-only regions are introduced, aligning
fsl-mc with other VFIO drivers.

> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio=
_fsl_mc.c
> index b4c3958201b25..85f479db936c6 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -407,6 +407,10 @@ static int vfio_fsl_mc_mmap(struct vfio_device *core=
_vdev,
[ ... ]
> +	/* Prevent read-only region mappings from being upgraded with mprotect(=
) */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +
>  	vma->vm_private_data =3D mc_dev;
> =20
>  	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);

[Severity: Critical]
This isn't a bug introduced by this patch, but looking at=20
vfio_fsl_mc_mmap_mmio() called here, does it incorrectly assign a physical
frame number (PFN) to the VMA's logical page offset?

In vfio_fsl_mc_mmap_mmio():

    vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

    return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
                           size, vma->vm_page_prot);

The VMA subsystem relies on vma->vm_pgoff to represent the logical file
offset so the VMA is correctly inserted into the file's mapping->i_mmap
interval tree. By replacing the logical offset with a raw PFN, the VMA is
inserted into the interval tree in the wrong coordinate space.

When VFIO attempts to revoke the mapping (e.g., upon device unbind, reset,
or close) using unmap_mapping_range() on the device file, won't the
traversal fail to find the VMA because it searches using the logical file
offset?=20

This would leave the hardware page table entries intact, allowing user-space
to continue accessing device memory after it has been revoked or reassigned.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903071946.1311=
6-1-suruurism@gmail.com?part=3D1
