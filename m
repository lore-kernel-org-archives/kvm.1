Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A13E4507
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048386; cv=none; b=aDQc0DfIck6siaIo3VDXxApRZRXZ/z2JORn7xn/jKkC4Ga56ASyDS56WTbzlL+YFB4OzotZZiUr8VSnWuzn/eMb4JSAPTBpqNI9ENuiRA+gZyTCv42DgWVEpAEiWf7fMcZ/wv//RK3HVSAbVE/D4C/J+1EEY1QK7Y5vu61uk8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048386; c=relaxed/simple;
	bh=kcPUZ5eiOoAzvasf3OefSNL8/YTmZwksTutd/Njvswc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SjDUfek4DZMquQsIlHtJ3NymbgLfe9ODlMMML0/uug57p3wB5hXtQMzXKgH4uadoQVMaT7znyjfG+d1U9E0CPapi4zW2c0n4NbSrn7dGqwASXPZsKsjWcXcezRlc24Vl4Xbd+/xz6/J6Fwsq2GpxEVxnl59cbyFlhXmQLVQo5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KloReEsz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KloReEsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8241F00893;
	Tue,  9 Jun 2026 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781048385;
	bh=EryzOurH4/IpRkErU2l/uRftgN61Ko592Wb8BdLkwp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KloReEsz6TiaAgN3yqTgj+XO/kxXJNh1c9oqJGUt0syxW7IJqCD3w3rGvGQlAQlQt
	 wfmDlJ4mG2BrXoXMhLU/73F9FWKWtINmPAzYTYwwOL1M/byKglaQ3pvlUDGc5gYYND
	 9V5KsZ5bD4aa38xD0EG29E+ugrmNvQcsyJwelgvEkjOYiP8YKp6o2hvuuGkFHNM6hs
	 XA1EVQyKDK9gezHEevrwvj9SvFlbzBLQs1kWGDcXeOE2BjYaRWlcMc8Ixlq5OUQ0Ep
	 vHXJ+IYxPVQK35n2jiDplZAnIT844BohQ5cKvptRKbhJJNuND/xvmYGFWeApvmShNQ
	 EyIzjSb8nwO/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 4/4] vfio: selftests: Add NVIDIA Falcon driver for
 DMA testing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rubin Du" <rubind@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260609232855.3808971-5-rubind@nvidia.com>
References: <20260609232855.3808971-5-rubind@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 23:39:44 +0000
Message-Id: <20260609233944.EC8241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Double fetch of the NV_PMC_BOOT_0 register leads to unvalidated =
array index and out-of-bounds access.
- [Medium] Missing 4-byte alignment validation for source and destination a=
ddresses causes an assertion crash.
--

commit 50161cb43066f380e2c0477f9ea68885628a0a3b
Author: Rubin Du <rubind@nvidia.com>

vfio: selftests: Add NVIDIA Falcon driver for DMA testing

This patch adds a new VFIO PCI driver for NVIDIA GPUs to enable DMA
testing via Falcon microcontrollers within the existing VFIO selftest
framework.

> diff --git a/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon=
.c b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c
> new file mode 100644
> index 0000000000000..c08aa81c44f41
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c

[ ... ]

> +static void nv_falcon_init(struct vfio_pci_device *device)
> +{
> +	struct gpu_device *gpu =3D to_gpu_device(device);
> +	const struct gpu_properties *props;
> +	u32 pmc_boot_0;
> +	int ret;
> +
> +	VFIO_ASSERT_GE(device->driver.region.size, sizeof(*gpu));
> +
> +	/* Read PMC_BOOT_0 register from BAR0 to identify GPU */
> +	pmc_boot_0 =3D readl(device->bars[0].vaddr + NV_PMC_BOOT_0);
> +
> +	/* Look up GPU architecture */
> +	gpu->arch =3D nv_gpu_arch_lookup(pmc_boot_0);
> +
> +	props =3D &gpu_properties_map[gpu->arch];

[Severity: Medium]
Since the NV_PMC_BOOT_0 register is re-read from MMIO here rather than
reusing the validated value from nv_falcon_probe(), could a hardware state
change cause nv_gpu_arch_lookup() to return GPU_ARCH_UNKNOWN (-1)?

If so, this would use -1 as an out-of-bounds index into gpu_properties_map.
Would it be safer to store the validated architecture in the device struct
during probe, or validate the return value of nv_gpu_arch_lookup() here?

[ ... ]

> +static void nv_falcon_memcpy_start(struct vfio_pci_device *device,
> +				   iova_t src, iova_t dst, u64 size, u64 count)
> +{
> +	struct gpu_device *gpu =3D to_gpu_device(device);
> +
> +	VFIO_ASSERT_EQ(count, 1);
> +	VFIO_ASSERT_EQ(size & (NV_FALCON_DMA_MIN_TRANSFER_SIZE - 1), 0,
> +		       "size 0x%lx must be %u-byte aligned\n",
> +		       (unsigned long)size, NV_FALCON_DMA_MIN_TRANSFER_SIZE);
> +
> +	gpu->memcpy_src =3D src;
> +	gpu->memcpy_dst =3D dst;

[Severity: Medium]
Does this function also need to validate that the src and dst addresses
are 4-byte aligned?

If an unaligned address is passed (e.g., offset by 1 byte),
dma_block_remain() in nv_falcon_memcpy_wait() will yield a chunk size of 1.
This invalid size is then passed to nv_falcon_dma(), which triggers the
VFIO_ASSERT_GE(size, NV_FALCON_DMA_MIN_TRANSFER_SIZE) assertion in
size_to_dma_encoding() and crashes the test framework.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609232855.3808=
971-1-rubind@nvidia.com?part=3D4
