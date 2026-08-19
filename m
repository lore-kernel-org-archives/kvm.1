Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022ED423E98
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129600; cv=none; b=Hi41zhOhnCtJ4cWwIH7SEHR25uTMQP9cDflff+eSGMBoySIPS5RffTJPfAveBwmaRQKE/a5VUzqWXTmSFm3VAYn8VOVqM3lHAxdmdpKzKdoueNSBX/fG22eDhn0E/+jJmzSHdAUiqAo3zPfyKvxrQfRAteE3sampyZPuy7TgbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129600; c=relaxed/simple;
	bh=8kX2SgTmNGKbBJW+0Na53YgsfOZs0RaiT0Vq63emP/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NQ2yWSUpg8g71tLaDzDWtG227vANPNMxH1WeS8QEtUMDEz9MU/Lo1YcEMl4oK+BTG2TLX0DRwQouPy60+/xhRGOG9jvwRshWh2lTujyhGeE2k1n0deUZyk4nWJgZvqZYJtycPs7LUhKNAUo58wOXU43GV+zHA6/cVRlsjdXVio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c44T+8vo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c44T+8vo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740D81F000E9;
	Wed, 19 Aug 2026 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787129598;
	bh=mn8mt6JopBAtfpDjhAKy8kclygDXR2sSeyxS+1DLpRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c44T+8voV4nNR1/SFaEiEByCoUtgF2/PSttpV3r/9cssx9+MHMv9l8D/+fvVwW5+I
	 bYKwdNZee6jGK6r40uz81O24c+47GIeBu/YYMKllLywq3XNyqX+6KC8nodtGmfkmsk
	 tOFmjtQJ2x9gPPAqYuPUVBZ9KY6iWYusCePiLYKOx33C8FfjdS17AKUVQ2ntgpED06
	 1OALOdyWDdeHuQV/WXAI4a73tL90yTnSyF8SGk1x5n390aTQV95VzqPohOK8CJ9rTu
	 cd8XOy3mBtB5bdWnDBugevdE6FlEwAI8rvCTc0djejHk9QZ9f3jqWw9iQtXkW4h1wB
	 LMgVIVKXmPXmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/platform: prevent read-only region mappings from
 becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260819083940.1374-1-suruurism@gmail.com>
References: <20260819083940.1374-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 08:53:17 +0000
Message-Id: <20260819085318.740D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch addresses CVE-2026-68445 for vfio/platform by preven=
ting read-only mappings from being upgraded to writable, but identically vu=
lnerable code remains in vfio/cdx and vfio/fsl-mc.
- [High] Concurrent calls to vfio_platform_read_mmio() or vfio_platform_wri=
te_mmio() on an unmapped region can leak ioremap allocations due to unprote=
cted lazy initialization.
--

--- Patch [1]: [PATCH] vfio/platform: prevent read-only region mappings fro=
m becoming writable ---
commit 229b89b6deb9e0fe81d355a6a2b3effcd15a2dd9
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/platform: prevent read-only region mappings from becoming writable
   =20
This commit prevents userspace from using mprotect() to upgrade read-only
VFIO platform region mappings to writable. It achieves this by clearing the
VM_MAYWRITE flag for regions that lack the VFIO_REGION_INFO_FLAG_WRITE flag.

> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/=
platform/vfio_platform_common.c
> index c72db5a99ebda..20d87c244ca28 100644
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -595,6 +595,10 @@ int vfio_platform_mmap(struct vfio_device *core_vdev=
, struct vm_area_struct *vma
>  			&& (vma->vm_flags & VM_WRITE))
>  		return -EINVAL;
> =20
> +	/* Prevent read-only region mappings from being upgraded with mprotect(=
) */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +

[Severity: Critical]
This is a pre-existing issue, but does this same missing check exist in oth=
er
VFIO drivers? Looking at vfio_cdx_mmap() in drivers/vfio/cdx/main.c:

	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
	    (vma->vm_flags & VM_WRITE))
		return -EPERM;

	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);

And similarly in vfio_fsl_mc_mmap() in drivers/vfio/fsl-mc/vfio_fsl_mc.c:

	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
			&& (vma->vm_flags & VM_WRITE))
		return -EINVAL;

	vma->vm_private_data =3D mc_dev;

Are these mappings also susceptible to being upgraded to writable using
mprotect() because VM_MAYWRITE is not cleared?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing
vfio_platform_common.c, could concurrent accesses leak ioremap allocations?=
=20

In vfio_platform_read_mmio() and vfio_platform_write_mmio():

	if (!reg->ioaddr) {
		reg->ioaddr =3D
			ioremap(reg->addr, reg->size);

		if (!reg->ioaddr)
			return -ENOMEM;
	}

If two threads concurrently execute pread() or pwrite() on the same unmapped
region, could both observe !reg->ioaddr as true and independently call
ioremap(), resulting in the slower thread overwriting reg->ioaddr and
leaking the mapped memory?

>  	vma->vm_private_data =3D vdev;
> =20
>  	if (vdev->regions[index].type & VFIO_PLATFORM_REGION_TYPE_MMIO)
>  		return vfio_platform_mmap_mmio(vdev->regions[index], vma);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819083940.1374=
-1-suruurism@gmail.com?part=3D1
