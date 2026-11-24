Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506489;
	b=azKRThUDhxZbTvuxbGaZFRfEzATyDlU/hTY+LbQCGx144hFbmLVHO7jxKMWS8hxFTgnb
	 Q+NnzGTOgXFerON5sd4nZKC0/rUAUDpOuOhN5DjhXnyOBhBNcuMl9Dx8rDevJ04A1QHew
	 qbJKYjJb2nVD3WZEHmG9K0z6yKNS7h4a5kd3QWIL+UZPbUT7rvUdnBrVD7e8u4LkEGVSx
	 j5VqsePmMvVMGcS2QD0fHnK0AYvTCowIl32Qp+odURPMTABT60n0KdtVqFkaf9tE6L0v/
	 nE5yFMNX2Ept92rF7cfo3gQKS9CS4652SSaxuZHtiuQd+rFZ47YggWzk8zqB4Rf9+MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506489;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+8PHhOsJsCl3Mvvh7yQ7C1KrzlKZwSld0TIJonePQBA=;
	b=tfX1d2n/szcjqc6ndE2D81pkbij57Kz03UOjDcl0bHxDY5F8SG+RBgxUyu36r9cN6MDh
	 fuGWn0PjioUPqwwmhG1tzRT+8ZqcNtOdJ0/PDHFCbAg052mIpQ1oSHegfboijGANvHyIB
	 5gh80Prccfq6Ij5UQnmkeYBsgdgLsWr+9Cwck2njdl8jEuGe5fKdceK3flr1z5UA60RU3
	 iAKTyGz6g1rVta64W8Q8hwcCWUEqohvMwbzzXu38H6ntzPKg4beB8NnRUA90n3dVXYlK0
	 8L+7RCVm+LAZPdNKWGSqjUAhRCtrCjCb/TvjGsJVfGwNwzWKgHr7gFHJJCyPoWpT6Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJpnLfnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A8606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJpnLfnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B351F000C4;
	Tue, 24 Nov 2026 07:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795506489;
	bh=+8PHhOsJsCl3Mvvh7yQ7C1KrzlKZwSld0TIJonePQBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJpnLfnXxbOYHCIgsosqPGD0QXu5msaAetm/pgTe/DdmYM/OrqzscJ54pHPGvYbXi
	 C0h5zxCH0g6+cf+e0l306caAGkeiHltzleD0PngqkG0rvVKBeDAAsOGr8OUynosUKF
	 BpDUw0tQPEJmlClyBPdBHUU1N9S8rzJ2qggCO8KF4ZtOgGDOey5z1N3PPj/vUXLeRy
	 e4BguelkdPrxH/s5o2yGxfpmTpVQXFguHbIrecrzJ05ToRQRrQ1RPcU5yYxbgyiolT
	 lEz3Zkn1XEuNpiDIeXp81NoQQhL6MHEg597BYk1sf/Ft/tozpNfVZtDW6qXX8i4jDt
	 TeNZqVMCVUawA==
Message-ID: <sashiko-outbox-230674@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] vfio: Add get_unmapped_area callback to
 vfio_device_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261124073048.268988-2-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124073048.268988-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 07:48:08 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] vfio: MAP_FIXED mappings reach
  device->ops->get_unmapped_area()
--

commit c2dec2a94cdf65407cd97caccc3240752b010cec
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio: Add get_unmapped_area callback to vfio_device_ops

This commit adds an optional get_unmapped_area callback to vfio_device_ops
and dispatches to it from vfio_device_fops so bus drivers can align VMA
virtual addresses for huge pfnmaps.

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 4e5d738ccf4be..edf9eb4cd4778 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
[ ... ]
> @@ -1431,6 +1432,36 @@ static int vfio_device_fops_mmap(struct file *file=
p, struct vm_area_struct *vma)
>  	return device->ops->mmap(device, vma);
>  }
> =20
> +#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> +/*
> + * Give the bus driver a chance to request a virtual address that allows=
 the
> + * mapping to be backed by huge pages, fex. a PCI BAR mapping that could=
 be
> + * faulted in with PMD or PUD sized pfnmaps.  Anything the driver cannot
> + * handle, including devices without huge mapping support, falls back to=
 the
> + * generic address selection, which is also what happens without this
> + * callback.
> + */
> +static unsigned long vfio_device_fops_get_unmapped_area(struct file *fil=
ep,
> +							unsigned long addr,
> +							unsigned long len,
> +							unsigned long pgoff,
> +							unsigned long flags)
> +{
> +	struct vfio_device_file *df =3D filep->private_data;
> +	struct vfio_device *device =3D df->device;
> +
> +	/* Paired with smp_store_release() following vfio_df_open() */
> +	if (!smp_load_acquire(&df->access_granted))
> +		goto out;
> +
> +	if (device->ops->get_unmapped_area)
> +		return device->ops->get_unmapped_area(device, filep, addr, len,
> +						      pgoff, flags);
> +out:
> +	return mm_get_unmapped_area(filep, addr, len, pgoff, flags);
> +}
> +#endif

[Severity: Medium]
Should vfio_device_fops_get_unmapped_area() bail out to out when
flags & MAP_FIXED is set?

The commit message states that a MAP_FIXED mapping never reaches the hook,
however do_mmap() and __get_unmapped_area() invoke
file->f_op->get_unmapped_area() unconditionally even when MAP_FIXED or
MAP_FIXED_NOREPLACE is set (the MAP_FIXED check only happens inside
generic_get_unmapped_area() / generic_get_unmapped_area_topdown() via
mm_get_unmapped_area()).  If a bus driver implements get_unmapped_area()
by only checking whether addr is non-zero (like dax_get_unmapped_area()),
a MAP_FIXED request at addr =3D=3D 0 with an unaligned file offset can have=
 its
fixed address shifted to a non-zero aligned offset, violating MAP_FIXED
semantics and overwriting mappings at the shifted address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124073048.2689=
88-1-guanghuifeng@linux.alibaba.com?part=3D1
