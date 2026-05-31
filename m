Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951A35675D
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222362; cv=none; b=DRY3SEvGLL5dYiXcOk1FmCS62XxFwNh+ww2eHOLnqKwCiQFbhfNcoSRJa+/EHCUkqEGKlfKQLjaM0+ohweOYxNB83muxOkhSoINHEwq5u84A21Yyw31jm9Rfz+gkRToPhVS2x/O6rsa10rrX6H72ummG1dq0qjTjB0JCY3dyvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222362; c=relaxed/simple;
	bh=K/NFNyHG6s3MI6iPrDktwhpoSgx16iCrMr+9GdStMJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sb4uk4JIJ7lgO5+dUhmLmqImxYkhKe+KnfiFoyNoqIY1teFgUcgRiYBw7eR4rAflOcuQNXo+uMiiLK1s4LeRyRBdqsgwJtrVb2/3TEnUcETMPFcIeDuu6nrWVxgZK5xlMbdXW5EFYnTvhXdMjOoXiGLwjwGwChP6weBwhPiP82g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3loHZ+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3loHZ+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156381F00893;
	Sun, 31 May 2026 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222361;
	bh=lQCHJc5jwwLznhZC0J9EELkq1E9q/IyhnFxhj8/KKCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3loHZ+ArH4ci4aVnjja9Q+uCICT41bTGpeRVWedef3VfDkck/HVJ74KxsK9Gt6Nm
	 sdPdmCLtkNxlb1UiJfyN2nxejUG472AUnTiHcK97351VZYNyMGfFtreZ+5uYSPb5qa
	 MioiNJSGJF9qvMzBtTMNE3pdKHHeVf3a+212ThBROmt7uyF/Kja4Q0cbkfJ7z6cmLO
	 WVHsuA81dgltP+k04WYyIrssrn8rI1iPr6xcHamHS9k9DuzU/y1ea28BzGqGZPcAqX
	 rTDJqrbDB525X8YSs0SFndbPeyDGVP+2tARBBw9W4ufny9NE5k3JRbAcQGyJDP1qcH
	 SsOVscI4uEpPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] iommu/generic_pt: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-4-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 10:12:40 +0000
Message-Id: <20260531101241.156381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Direct calls to `ops->iova_to_phys` in the iommufd selftests will =
cause a NULL pointer dereference because `IOMMU_PT_DOMAIN_OPS` no longer in=
itializes this function pointer.
--

commit 3d28cd1b26aa1da26180cde7d750a84030c72a61
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/generic_pt: implement iova_to_phys_length

Extend the Generic Page Table framework to implement iova_to_phys_length
by determining the PTE block size during the page table walk. This also
updates the IOMMU_PT_DOMAIN_OPS macro to configure the new function.

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

[Severity: High]
Will removing .iova_to_phys here cause a NULL pointer dereference in the
iommufd selftests?

The amdv1_mock_ops in drivers/iommu/iommufd/selftest.c uses this macro,
so its .iova_to_phys field will now be implicitly NULL.

However, the selftest directly dereferences this function pointer without
checking:

drivers/iommu/iommufd/selftest.c:iommufd_test_md_check_pa() {
    ...
    io_phys =3D mock->domain.ops->iova_to_phys(&mock->domain, iova);
    ...
}

While I understand this is addressed later in the patch series when the
code properly switches to using the iommu_iova_to_phys() wrapper, will
this intermediate state break git bisect by crashing the kernel during
testing?

>  #define IOMMU_PT_DIRTY_OPS(fmt) \
>  	.read_and_clear_dirty =3D &pt_iommu_##fmt##_read_and_clear_dirty
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D3
