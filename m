Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524684;
	b=B52xuMp7KVBIp8wK1hAPCQ85NJGrP4B5Wir68/9Pz2HijqzFT1W/vnxO0MSJI2KABVJL
	 klLc0T8v/boQGPTk8ro/d5PfsdFSEh5UyA0CIeZus2oj+spDprMIiJ1sUPc2y+kDnidnD
	 A0uV7PQ2oMzXu5zUfnhDmh4ZZCzUbBOBuJcqVBK2tHa0GEmx4s1JDOLdx80FkFliTKKaI
	 a6GsNwM9U7k5+nGyIIcqLPlKCMSksxPJBQBYrUTMzG0STa6nrls2fkHDrgBfAIZcas9QH
	 JAkE7zMZY+ZtxXEcjJHDwJIxmgibk2SZDePboqaSpK0DuPziYD0KecdoNJQrCihUNdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WisC6D8IzCvZV2wyr056o5vdhSqHDO/mi2StBFVZr3o=;
	b=L7YYNMEsLw0zpUvTp+l1SMwpB1DWhSS+G/YKfM1uXvYVkBWhi38vgHNVppkD5OJ3vMYp
	 /+b2snvYoAntppIrirbuuRyN/ol+fzJBM8Ws8FUj7q26aHmBlGH19TJSR5U4mpJn45QMO
	 dWWHYW0IiuroyJCIe6kyWZkths8sMvmBNo1uuE4I8EycV/jKzZ3XBihmuuLCu8rj6GY0c
	 nkCdCcNEP2DFIJtHO00wCIMXsg2v4Mr5/w1OVccTqE0qQUykqDWMDBTgVgmbFy9M7gai3
	 9ZmOzpbO8pcoEU6n5OlDN5IEJJINu616zFkJC2IAc8pOYVazY6Jsq73OUDwTog1bnBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XO17/8xD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB7A606A32D
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XO17/8xD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67A21F000EB;
	Tue, 24 Nov 2026 12:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524683;
	bh=WisC6D8IzCvZV2wyr056o5vdhSqHDO/mi2StBFVZr3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XO17/8xDC2KpowyO+nUQ63CvULShEhr655W5WDgXZYi4tc/VYJOfb+VMPSWSf+kk1
	 RmrpC78Hm7EYOhn75xOUUUgLo/7UFyZ6HSxPi6nW7JznDOJeo7bBRaMMOVeWFHfqE4
	 CyeJDOZGNnnyxMSniW9gFGvdA2Hn8t56MSSRWMFBszBovTiBdPEw5PbxUTAO/kQ3VO
	 kvz8oFNOfhSJxAR77uGZK+Eq7L8CtkE9zAcDl+0cboYJGUPZFIjneu2YywGxIJxwk3
	 hAonAu/0oXR1xs3D1K3EipyqHYmjAxl411znJd4DExRTo3RjW+Fa41QJI/yHzUJotw
	 6YAZETJ7Oa0oA==
Message-ID: <sashiko-outbox-231182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] vfio: Add get_unmapped_area callback to
 vfio_device_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261124124004.457441-2-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:51:23 +0000
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

commit 0477ef7e38ed92136abaf6feac25d75050278697
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio: Add get_unmapped_area callback to vfio_device_ops

This commit adds an optional get_unmapped_area callback to vfio_device_ops
and a corresponding vfio_device_fops dispatcher so bus drivers can align
mmap virtual addresses for huge pfnmaps.

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
Should vfio_device_fops_get_unmapped_area() skip
device->ops->get_unmapped_area() and fall back to mm_get_unmapped_area()
when flags & MAP_FIXED is set?

The commit message states that a MAP_FIXED mapping never reaches the hook,
which matches dax_get_unmapped_area() only checking whether addr is
non-zero.  However, do_mmap() folds MAP_FIXED_NOREPLACE into MAP_FIXED,
skips round_hint_to_min(addr) when MAP_FIXED is set, and still invokes
__get_unmapped_area() -> file->f_op->get_unmapped_area().  If a driver
implements this callback assuming MAP_FIXED cannot reach it (or checks only
!addr), calling mmap() with addr =3D=3D 0 and MAP_FIXED will run the driver=
's
alignment logic and shift the requested fixed address instead of mapping at
0.

The follow-up commit "vfio/pci: Align BAR mappings for huge page support"
checks flags & (MAP_FIXED | MAP_FIXED_NOREPLACE) in
vfio_pci_core_get_unmapped_area(), but checking flags & MAP_FIXED here in
vfio_device_fops_get_unmapped_area() would enforce the documented contract
for all VFIO bus drivers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124124004.4574=
41-1-guanghuifeng@linux.alibaba.com?part=3D1
