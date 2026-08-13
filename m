Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5546B417D99
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786633214; cv=none; b=U5XHw1DhIV74ci78p/0C7jq1UFlJLea2ON+Kc+XOSyJLf9XG8kHBd1Wq8Yx7YcRR27cpAketwjLmX2V0Y/oAH/E/3B2a/myFFn+OT1us6W3HZpTq1c/NxjmM3p/OToH0FPAE6aN1Ua4xU5+HuVzO77qBC50Eq2IpHe8XXMSC1eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786633214; c=relaxed/simple;
	bh=OdszaCZfnZUJEmN7Qe5Cs1Ewj/Cu5urowp4nqy8qHhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ct3qS5uaAYi/glANNjfIJjDAvE8+uhZTmgNyCzLp7AWwgbDDJDYRpRnaizS33BpnnbuiDgxbx7Ne/Ss1SpVmhKI3MM7zGOxVAAjpLpyGYI9EmKyFbamvVOAgXKt6sRWlr9S5KwOAXF6MRQjLj63ljEimoGoYxtOJtAUZoIYYDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxHrTq6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxHrTq6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADE11F00A3A;
	Thu, 13 Aug 2026 15:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786633207;
	bh=kTNMfuHz4bxjv2UYGVkBMZL4xQ6gifTYlTCYto9HMqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lxHrTq6zUezztKYEPO8v9btx9gAJ1KAkhAkUvOXHA1DijyXJPcO0Y1vY2w877mnie
	 +Gf52l37WwxYuQxyN6ENB1lsf+3qCeCSFjedBPnGrm4N1Fd5fSEo9dpg0huXxSqDqX
	 TuikgYtAVssMAXCqtZY1ffD3W7Y7R3KP3/kb0kitvPoiNry31aVFRwltonKX4qtk3D
	 9ShSbkyN50McvtBtuoi7NurCsgSPUAEzOQHeWvIVHdFMx1FA2UG0EMl/xTMiBsj16Y
	 o6q8SwJNmKHzhwVf7N8n3q4sn3WTu8SMUXY+tI63N1rTxTuBB2dWEv/FQaI+JzBzFH
	 TIS3Lkm4HlpHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/10] vfio: selftests: Allow drivers to specify
 required region size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
References: <6-v4-021df3fb5a3f+98e-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 15:00:07 +0000
Message-Id: <20260813150007.9ADE11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The DMA region sizes provided by the driver ops are not page-ali=
gned, causing the IOMMU mapping ioctls to fail with -EINVAL and crashing th=
e selftests.
--

--- Patch [6]: [PATCH v4 06/10] vfio: selftests: Allow drivers to specify r=
equired region size ---
commit 4f2bbead708ec429c301f599e1115b9b6e4e3c22
Author: Jason Gunthorpe <jgg@ziepe.ca>

vfio: selftests: Allow drivers to specify required region size

This patch adds a region_size field to struct vfio_pci_driver_ops, allowing
drivers to declare their needed DMA-mapped region size. It replaces the
hardcoded SZ_2M value with the exact sizes of the drivers' state structures.

> diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/=
testing/selftests/vfio/vfio_pci_driver_test.c
> index 761bf117d624f..2bd949aafd731 100644
> --- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
> +++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
[ ... ]
> @@ -87,7 +87,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
>  	driver =3D &self->device->driver;
> =20
>  	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, S=
Z_1G);
> -	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
> +	region_setup(self->iommu, self->iova_allocator, &driver->region,
> +		     driver->region.size);

[Severity: Medium]
Since the drivers populate region_size with the exact struct size (such as
sizeof(struct dsa_state) or sizeof(struct igb)), will this cause IOMMU
mapping ioctls to fail?

IOMMU mapping ioctls generally require the requested DMA mapping length to =
be
an exact multiple of the minimum IOMMU page size. Passing this unaligned
size to region_setup() sets the region size to the unaligned value.

When iommu_map() later issues the VFIO_IOMMU_MAP_DMA or IOMMU_IOAS_MAP
ioctl, could the kernel reject the unaligned size with -EINVAL and crash
the test suite?

Does region_size need to be page-aligned before being used for DMA mappings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/0-v4-021df3fb5a3f+9=
8e-mlx5st_jgg@nvidia.com?part=3D6
