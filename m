Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF42A3F8257
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428492; cv=none; b=ag/0L0eIYCK47K+SAC1YQs91bxnNWKkEcgoYef4Wih2YsHqTYcREXsfWnHtT/zvJEOGS214xTT3yH8sJANYgrRoTtLT/Hj49UiN0of6FaV3pKYIE3ilGWaW19cksx58cxdfm3vvCyXkKSfdRm11tj0qvzJ08Rsn2hzJTQKtcv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428492; c=relaxed/simple;
	bh=kwPXLciepFTHMGucgjkbdKBlHyTNcmb8hHo4UrC6Brs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f6L9056SzkJEJZsH9utni0fio09m3vcCW6IkLVo93TMjiwoTRtaQOqwWXV6xsgmnA08lVdkyLCumUNE0f2ee1hb4qJ0OgNWPU/3b4Q55zsmf6nlG543k3XrBKtSNul10zBG72riCyc/yeW9sNhtoMFaWellPvYYRRLJxGNfQPP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBawzre6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBawzre6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE0C1F000E9;
	Thu,  3 Sep 2026 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788428490;
	bh=1dSjH87HzEyPHLuuAz/RaJGGEfWgS1h7TOGrmPAAJAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBawzre6I6URrR2+4rw4PX0s0rS8t6Vrv7bsjdHEPDwODOzhonofdb2oOkymUiUUl
	 E+wTdigsFmoJOv+fgF+S941pl3Uwj+joSSoe0mL/RiSb4dwNXSyE7SuMEkuOPDWIgU
	 IwU6ZCkuy4iGA6cTnCmO03uqg3bXDyhArUcgurkuRhvq8J7RJX0rkSIXF3DJTPaWaI
	 S40TT82R6Y17oHmD2XspNxYaMo5V/5XOsXjJRFVGQQX5JoMucSkT0A8UtqMLHuhI3o
	 JJEuVGWRM2zNTa+uzpLBoA/mSOLnwbFgNcTQqD9xq43foZk0T2Ac363qSp6Oc5nP/J
	 1slONufDv4bXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260903092922.470-1-suruurism@gmail.com>
References: <20260903092922.470-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:41:29 +0000
Message-Id: <20260903094130.4FE0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fails =
to address the exact same bug in the `vfio/cdx` and `vfio/platform` drivers=
. Both of these drivers continue to explicitly overwrite `vma->vm_pgoff` wi=
th the physical frame number before calling `io_remap_pfn_range()` / `remap=
_pfn_range()`. This places the VMA into the device file's mapping's interva=
l tree using the physical PFN as the offset, rather than the logical file o=
ffset that VFIO expects. This breaks VMA revocation because `unmap_mapping_=
range()` uses the logical offset.
--

commit 197a05c45992dc952a1309de2d91157e917cb701
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap

This commit modifies the VFIO fsl-mc driver to pass the physical PFN direct=
ly
to remap_pfn_range() instead of overwriting vma->vm_pgoff. Overwriting
vma->vm_pgoff broke the ability of unmap_mapping_range() to find and revoke
mappings because the VMA was inserted into the interval tree using the wrong
coordinate space.

> diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio=
_fsl_mc.c
> index b4c3958201b25..9fc6f9136e01f 100644
> --- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> +++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
> @@ -369,9 +369,8 @@ static int vfio_fsl_mc_mmap_mmio(struct vfio_fsl_mc_r=
egion region,
>  	if (!region_cacheable)
>  		vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> =20
> -	vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;
> -
> -	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
logical offset clobbering issue in the fsl-mc driver, should the exact same
issue be fixed in the vfio/cdx and vfio/platform drivers as well?

Looking at drivers/vfio/cdx/main.c in vfio_cdx_mmap_mmio():

    vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

And similarly in drivers/vfio/platform/vfio_platform_common.c in
vfio_platform_mmap_mmio():

    vma->vm_pgoff =3D (region.addr >> PAGE_SHIFT) + pgoff;

Both of these drivers continue to explicitly overwrite vma->vm_pgoff
with the physical frame number before mapping. Doesn't this also break
VMA revocation during device detach for these drivers, since
unmap_mapping_range() won't be able to find the mappings in the interval
tree?=20

Could this leave stale MMIO mappings behind and allow userspace to retain
unrevoked access to hardware resources after a device is unbound?

> +	return remap_pfn_range(vma, vma->vm_start,
> +			       (region.addr >> PAGE_SHIFT) + pgoff,
>  			       size, vma->vm_page_prot);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903092922.470-=
1-suruurism@gmail.com?part=3D1
