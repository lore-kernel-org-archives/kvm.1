Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0975539021B
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398395; cv=none; b=TPyvsB34u4wW39UuOqlU2/pFYsvUWwkffVGdUCLsKpWHp62MNQJwCEwZjSsDOfFfwTSvxtY/TDvBjQww+6tGAoBl4AkBxpH3AnvZuek03lHtLoeUhJuH8ARcV24O53rr86BVHA90IqTLMnH5qXq1BZq2FIOdkR7Lx7olHUzxfCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398395; c=relaxed/simple;
	bh=GnvaYNsFp1JUd/Hz+57Guo4796jPUKAaGqynntYx2Wc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XbH/DxWSCIv3HPtvvn5NvXl3dVFbp+UdvJh4sHYK1S9lbVV950W2NoQdW4nTn9Ka23oRpuGGcKIgGMbvQm9JDSP1lrAoeswFubTYwacLHDIZq1EZGobNrrNvABXX6vvrTyqvJ91MbSjeOaseUbl0SnvJom21MOY2fJH5191YO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF2Y2gK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF2Y2gK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897331F00893;
	Tue,  2 Jun 2026 11:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398393;
	bh=mZC+XtDYyZN5CJ7psTzIjESCYx9UcJpevL5ep7fOOdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MF2Y2gK58pwXBOLmEQm2W2Md/XlgOPBoI/0vIr9da01LvXAsaUkidf04gX6zeo3Pt
	 ghRsP3+bVMBMBeU0W37DUbzay4TK5mTjBLEeHM74/QqRPB+0CmwtCKBsKxauqdHFPg
	 H9pvUvKhO7tmHXPYYsthWzDiASG9lzIA0QE7J/9EQyekMicQJItckjDIfO7DK3C1yq
	 4rGVL7tNUnMY/YVsLWuo3LKt40ufgaqp0wU6WvdkuBJCeVXdm+r+41CgfaCv8Ts0zz
	 Mert3z0qALMLSbdtvUWPndhzh1+a/EDUSDntcG/pqsR4Cghg8CKBilzOdokM1a2ZNn
	 l6M7IkG4wNCuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/30] iommu/generic_pt: implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-6-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:06:33 +0000
Message-Id: <20260602110633.897331F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing .iova_to_phys in IOMMU_PT_DOMAIN_OPS leads to NULL point=
er dereference in iommufd selftests.
--

commit e2c842a298a80551337d0eb21cf64d10984cc30d
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/generic_pt: implement iova_to_phys_length

Extend the Generic Page Table framework to implement iova_to_phys_length.
Update the IOMMU_PT_DOMAIN_OPS macro to set .iova_to_phys_length instead
of .iova_to_phys.

> diff --git a/include/linux/generic_pt/iommu.h b/include/linux/generic_pt/=
iommu.h
> index dd0edd02a48a2..859b853e9dc7e 100644
> --- a/include/linux/generic_pt/iommu.h
> +++ b/include/linux/generic_pt/iommu.h
[ ... ]
> @@ -267,11 +268,11 @@ struct pt_iommu_cfg {
>  	IOMMU_PROTOTYPES(fmt)
> =20
>  /*
> - * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops fo=
r the
> - * iommu_pt
> + * A driver uses IOMMU_PT_DOMAIN_OPS to populate the iommu_domain_ops for
> + * the iommu_pt
>   */
> -#define IOMMU_PT_DOMAIN_OPS(fmt)                        \
> -	.iova_to_phys =3D &pt_iommu_##fmt##_iova_to_phys
> +#define IOMMU_PT_DOMAIN_OPS(fmt)					\
> +	.iova_to_phys_length =3D &pt_iommu_##fmt##_iova_to_phys_length

[Severity: Medium]
Will this macro change cause a NULL pointer dereference in the iommufd
selftests?

Looking at iommufd_test_md_check_pa() in drivers/iommu/iommufd/selftest.c,
it bypasses the safe iommu_iova_to_phys() wrapper and calls the op directly
without checking for NULL:

drivers/iommu/iommufd/selftest.c:iommufd_test_md_check_pa() {
    ...
    io_phys =3D mock->domain.ops->iova_to_phys(&mock->domain, iova);
    ...
}

Because mock domains in the selftests are initialized using this macro,
their .iova_to_phys function pointer will now be NULL, which causes a crash
when the selftest executes.

I see this issue is fixed later in the series by commit cb17e198ab7d
"vfio/iommufd: use iova_to_phys_length for efficient unmap", but does this
intermediate commit break the build's selftests during bisection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D5
