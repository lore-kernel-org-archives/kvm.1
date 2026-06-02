Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B925B0A9
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406532; cv=none; b=FsZh1w51NOxqexWR48bL8/bW02875Fht7wr4Ul/ThTjyHQQEeiUDZLlz7ju7Jkg/28EuPLhFkwYcli1ZNmSbrq/14NgiUKXZZVEL40JENm07fNkkAV1YNA7yown3yonfOnnvQsDHgc5pZuOEgeYMpvYatWBBzUuJPJJyyjvNaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406532; c=relaxed/simple;
	bh=or+P+cnNbSJfFu2mc/lNW6IMALG/S+0h8iZ6QcQ5CT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jnpvC0W6lfH1dHgvQq+lglqfpimsyDAsLvlk6DCIUNMwdJAQAZ3zgc1gsoOrqHKN6HcU8tUoHJgfBQFpeH8OknIFzuc7Gk43c1Np0nPIJRwYmewjceMnrPPymoHKUgBtrh7Wx1jSFzr/AermjB6KOH0cuTeSd5dkN4v+MhvhqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgXhNoBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgXhNoBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6868E1F00893;
	Tue,  2 Jun 2026 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780406531;
	bh=+5Lb9sdzc7rIaDIO9oTyxKAwPmXFkEh+Sg27Fr7lEBU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KgXhNoBXbB2MgCGXCu9s64dwpmM13TrIurcPUPX8nuqaobXidF+5UgNU+B5Mvnr1M
	 XyFYEMKM6XcfDYmQAlMGE+TL2Z7+MR9mMjL03IgaDyXYUfh9TIQp1xI3cEQqHglV5b
	 qUEau1iHObFdlH21GcnufTPU9F7dldFi5WW/Idl3mGa980gl20O1OEkYy3fUPFS1sh
	 0ZCR0v8NGBYaDp3zeTBNHJN1BefBuJdPaa8Y4mDaRzIZ+Pe1pOl15c3evuOHnfyXE1
	 h9IDEXtWL4i7mPxtrF3yuh+sUwKMF/hHVPhDrOvUTdL4hL4jrd6Zn7DRownFbKyFeP
	 b4ma8JBMo5jag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/30] iommu/io-pgtable-arm: remove deprecated
 iova_to_phys wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-28-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-28-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 13:22:09 +0000
Message-Id: <20260602132210.6868E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] In `arm_smmu_iova_to_phys_hard`, a hardware translation failur=
e returns `0` instead of `PHYS_ADDR_MAX`. This breaks callers of `iommu_iov=
a_to_phys_length` which expect `PHYS_ADDR_MAX` to detect failures, causing =
them to treat physical address `0` as a valid translation result.
--

commit 17d24f53e1c566320f87a73674b736d336e36024
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/io-pgtable-arm: remove deprecated iova_to_phys wrapper

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM LPAE io-pgtable, as all callers now use iova_to_phys_length.

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 2b94e0563e214..ceea8da8d1fd7 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
[ ... ]
> @@ -999,7 +987,6 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  	data->iop.ops =3D (struct io_pgtable_ops) {
>  		.map_pages	=3D arm_lpae_map_pages,
>  		.unmap_pages	=3D arm_lpae_unmap_pages,
> -		.iova_to_phys	=3D arm_lpae_iova_to_phys,
>  		.iova_to_phys_length	=3D arm_lpae_iova_to_phys_length,

[Severity: Critical]
With the API migration to iova_to_phys_length now complete, does this intro=
duce
a regression in error handling for drivers like arm-smmu?

The old iova_to_phys interface expected 0 on failure, but iova_to_phys_leng=
th
expects PHYS_ADDR_MAX. Looking at drivers/iommu/arm/arm-smmu/arm-smmu.c,
arm_smmu_iova_to_phys_length() can call arm_smmu_iova_to_phys_hard() which
still returns 0 instead of PHYS_ADDR_MAX on runtime PM get failure:

	ret =3D arm_smmu_rpm_get(smmu);
	if (ret < 0)
		return 0;

It also returns 0 on a hardware translation fault:

	if (phys & ARM_SMMU_CB_PAR_F) {
		dev_err(dev, "translation fault!\n");
		dev_err(dev, "PAR =3D 0x%llx\n", phys);
		goto out;
	}

	addr =3D (phys & GENMASK_ULL(39, 12)) | (iova & 0xfff);
out:
	arm_smmu_rpm_put(smmu);

	return addr;

Could callers like vfio_iommu_type1 now treat 0 as a valid physical address,
bypassing the WARN_ON(phys =3D=3D PHYS_ADDR_MAX) check?

If iommu_unmap() unmaps the region, would VFIO use this incorrect physical
address 0 to unpin pages?

This appears to lead to an arbitrary page reference count decrement on PFN =
0,
and could leak the reference count of the actual unmapped physical memory.

>  		.read_and_clear_dirty =3D arm_lpae_read_and_clear_dirty,
>  		.pgtable_walk	=3D arm_lpae_pgtable_walk,
>  	};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D27
