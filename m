Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B94252AE
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129914; cv=none; b=EtOWabHJ1SKgcWvQNXtrhkCOW41QYVTmW1pMUK6wL6Fay+IJWtRo6vya/UO4Nvp1kQ5PIZBKScMXpEielvyPY//Hd+/mGpp1dBMS9MzAQk4QktUdx6queTpPLRrtRucsL4S3JZONh/QNssIipBYM4vbmQN1sWvmL3KZe4eXbrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129914; c=relaxed/simple;
	bh=NLA0oEIStuijrXkDQ+k3yxoZbOd3WSIefAgzTFybCuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MAyDzuDkOnvas8dvpwj2kizPfy4dXbW9m4x916B9EIUGhXqsiKbEaGqRUpUky3L5Jle/8oPSZEz7cfYvOyEub6/NfUOmVMDr2CJBHdBa5svca2dRVeJLqS0xzZJtNLG7z3HefYMgyWU2ME75Bq3g304ySdw1g9zheQ83M5GbvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR4J7XiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR4J7XiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D5F1F000E9;
	Wed, 19 Aug 2026 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787129910;
	bh=BjLDL62i2Ubj1WiDIz4ErpM8SSGzoZ+TMkij8zP+KL8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oR4J7XiVwdlJaLmcERoSDYu4puoanVCe/aloYhfY5w1W7UvlFwaMbupgzdlTzsvdv
	 oFB0L7GDyMv4eGGlXBHWp+q96zhPaxXyWDOaOY5bK/Nwt1F37dl8FFSfdfX9wr9InU
	 RAzfBt0JpAyYd61ndMGsdUizUiIefq3R/82DP1mRA6Vj4xk5+My/PrCbL5WAqGQlgb
	 rZQ9QQobCMZA8m4/yoRYmA8osmecdQggKl2epMF1+vSqdkEFCsUFfIC48Vm4t9Euqz
	 Q2G1RXzURxAayHaoBleT07FiCvbUztKRdrTHoNL6/ghd5a0njKK0tZD7CNlpFbg3D+
	 ls2zrJOQGER1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/cdx: prevent read-only region mappings from
 becoming writable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdifatah Suruur" <suruurism@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260819084203.1526-1-suruurism@gmail.com>
References: <20260819084203.1526-1-suruurism@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 08:58:29 +0000
Message-Id: <20260819085830.21D5F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing VM_SHARED check in vfio_cdx_mmap allows COW on device MMIO=
 memory.
- [High] Missing VM_MAYWRITE clearing allows read-only VFIO platform and fs=
l-mc regions to be upgraded to writable via mprotect.
--

--- Patch [1]: [PATCH] vfio/cdx: prevent read-only region mappings from bec=
oming writable ---
commit 83f86639f8fdaf3a6302850a1c0944c947af0f5c
Author: Abdifatah Suruur <suruurism@gmail.com>

vfio/cdx: prevent read-only region mappings from becoming writable

This commit clears the VM_MAYWRITE flag in vfio_cdx_mmap() for regions
without the WRITE flag. This prevents userspace from upgrading read-only
mappings to writable using mprotect().

Cc: stable@vger.kernel.org

> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> index b31ed4be7bdc1..b6b17a6a46811 100644
> --- a/drivers/vfio/cdx/main.c
> +++ b/drivers/vfio/cdx/main.c
> @@ -285,6 +285,10 @@ static int vfio_cdx_mmap(struct vfio_device *core_vd=
ev,
>  	    (vma->vm_flags & VM_WRITE))
>  		return -EPERM;

[Severity: High]
This is a pre-existing issue, but does vfio_cdx_mmap() also need to reject
mappings that lack VM_SHARED?

If a user maps the region with MAP_PRIVATE, a write fault will trigger a
Copy-On-Write (COW). The COW reads from the device MMIO using bulk memory
instructions (via __wp_page_copy_user()), which could cause unsupported bus
transactions (like SError on ARM64) and crash the system. Additionally,
writes to the mapping will quietly hit RAM instead of the device, breaking
MMIO semantics.

Unlike other VFIO bus drivers, this function appears to be missing a
validation check to reject private mappings. Could the absence of a
`(vma->vm_flags & VM_SHARED) =3D=3D 0` check here allow users to inadverten=
tly
trigger these COW crashes?

> =20
> +	/* Prevent read-only region mappings from being upgraded with mprotect(=
) */
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE))
> +		vm_flags_clear(vma, VM_MAYWRITE);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the same vulnerability
exist in other vfio drivers?

Looking at vfio_platform_mmap() in drivers/vfio/platform/vfio_platform_comm=
on.c
and vfio_fsl_mc_mmap() in drivers/vfio/fsl-mc/vfio_fsl_mc.c, both check for
VM_WRITE but neither explicitly clears VM_MAYWRITE.

If those drivers leave VM_MAYWRITE set, could they also allow users to upgr=
ade
read-only regions to writable via mprotect() in the same way being fixed he=
re?

>  	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819084203.1526=
-1-suruurism@gmail.com?part=3D1
