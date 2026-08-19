Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25EF426D2E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130159; cv=none; b=euluK05o4QKoeEVeDRrao2nn7moSaDISqHtM4pomdFupbRcyllUdBuHKAVDqoQAuZfZvLRwqlzbT3c0z8rV4TLvlGkpZ23nyOHK+Nm+QWfDkrz6WRtzUAe/QHtexVCAjdBBpbWJNTV7zrtrg7YOA0n3EwwXPa582EGi1SFBibKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130159; c=relaxed/simple;
	bh=QmhQr2xcQbKQAsMCvhPRs4bA9oY6g3JCL/vka6gZVeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JS1bfrIDf018GmwC363c3u0UVlh0A8B7ZQbBHJGFpOHIs/3PLRcBtUu1/AFhDB2LIq974sZMuWE1Xe3NvSjGPy2zGAkD3uO+VLByLP2SdBt1Fv106Rf156/0sE5r02bCPz30ypGpgxOLPw7G5u4tGnjpgfnnspl5HRi+WGtBbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiCJqnhZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiCJqnhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BAB1F000E9;
	Wed, 19 Aug 2026 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130157;
	bh=NliqhL1NKZ1aeqiMsO6Q3DUZ7a6Ag7s6dtweRDyxLrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OiCJqnhZwAIlnAbaQ99IU5vDzIW4jv8GUGm+iuFDQG62VrpP/BhcozT+mptb4OzAZ
	 u0h3pBJIC3GhBJ/bJAjNF5YlBrHqoDhbfbZbrzCweFAUT/XnRZt80z0rFj+n/fDh21
	 YXWViqNSefUXouKbYBgpENAKxn/irq4bUm//TBOkWxSNxrhZWiWdxBBcqiJExR58/H
	 Yk8LjoS3i5mVtKJjYisScYJMdeaFyUtDE84N7/ebi5S5cfgCnCUxV4ZEsRodYvWKU5
	 kNWJjfKV6zbftS3hvvvrSHIlul/7NJhkzIEMHCuJrgX8cBTig3XAR9mtHs1gzOZOdP
	 LtYXxji3S7jqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/fsl-mc: prevent read-only region mappings from
 becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260819084209.1543-1-suruurism@gmail.com>
References: <20260819084209.1543-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:02:37 +0000
Message-Id: <20260819090237.62BAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Modifying VMA flags (`vm_flags_clear(vma, VM_MAYWRITE)`) inside the=
 `f_op->mmap()` handler violates the VMA flags modification API guidelines =
regarding merging.

Pre-existing issues:
- [High] The patch fixes a vulnerability where read-only region mappings ca=
n be upgraded to writable via mprotect(), but misses identical pre-existing=
 vulnerabilities in sibling drivers vfio_cdx and vfio_platform.
--

--- Patch [1]: [PATCH] vfio/fsl-mc: prevent read-only region mappings from =
becoming writable ---
commit f3aa2053ad6dcc721a152db22b46cec93266b9df
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/fsl-mc: prevent read-only region mappings from becoming writable

This commit clears VM_MAYWRITE for regions without the WRITE flag.
It prevents userspace from mapping read-only regions and upgrading them
to writable using mprotect().

Fixes: fb1ff4c194157 ("vfio/fsl-mc: Add VFIO framework skeleton for fsl-mc =
devices")
Cc: stable@vger.kernel.org

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

[Severity: Low]
Does clearing VMA flags directly inside the f_op->mmap() handler violate the
VMA merge rules? Modifying flags post-merge can silently break future merge=
s.

While remap_pfn_range() later adds VM_DONTEXPAND (making these VMAs
unmergeable anyway), is this still the correct place to modify the flags, or
should this be handled earlier via a .mmap_prepare() callback?

[Severity: High]
This isn't a bug introduced by this patch, but it appears sibling drivers
have this exact same vulnerability.

For example, in drivers/vfio/cdx/main.c:vfio_cdx_mmap():

    if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
        (vma->vm_flags & VM_WRITE))
        return -EPERM;

And in drivers/vfio/platform/vfio_platform_common.c:vfio_platform_mmap():

    if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
            && (vma->vm_flags & VM_WRITE))
        return -EINVAL;

Both drivers reject PROT_WRITE but fail to clear VM_MAYWRITE. Could
unprivileged userspace map read-only regions as PROT_READ and then use
mprotect() to add PROT_WRITE, allowing unauthorized writes to device MMIO?

>  	vma->vm_private_data =3D mc_dev;
> =20
>  	return vfio_fsl_mc_mmap_mmio(vdev->regions[index], vma);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819084209.1543=
-1-suruurism@gmail.com?part=3D1
