Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF932E696
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329157; cv=none; b=LLsNA9xWMygZ6614vkE51xIvTCZlPjIEE83zoYUXNqbctCxvQ8f2PkGf0PjO6+U7aH2n1/0zC0t6Ez8kemoMCgmdui8JP7qnoe1Vrmtp4FQWSy2h9ptuHV1sK7DPs/+UJP3rqjxXx3dq+i2HCYT7rZNxsEY7iFSFRFqtVqz5NXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329157; c=relaxed/simple;
	bh=cIohTVcLidWLHlPEZPwr1wmOWE/nfoyijiRyTjOMNbQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IJ9yI71sX+EVRZhmZTAnJyWll7MA7pb6VsNRagB9ReA0+Zuys3QeOBiGilFDyIIWMzVfpuhKVgmEYesoVxgOqZsV1AALdm6f7oshMSiapU/v9yxitJSf+Jq+Jb44O9dWmeBFpgQzKQCERIDFYjV7dgOdDhNDL9XvUoyk1UoW16A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lp0JbaZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lp0JbaZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669BB1F000E9;
	Wed, 24 Jun 2026 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782329156;
	bh=KJtCOIYM+saS2SGRFU0ClN//azoNatZQRhCsEYMsOyo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lp0JbaZBVmCMh7uDHOeNUpgodintqK2t+Lm+Z3IfTtolegpv4FqKmLOvYZG4NlaUD
	 wN6BqTBXgVim3MjdO+SC/pCXXT4ZPzPZUJVm5w5O32Zsk+S7EaROqeGhzfGV4odPGc
	 hE8gsRs6yzBJxEST1oXHJ9yAXcIn7gnUfqlQYdPMVUOyfSCenvHSQtCiM8MiePRqBt
	 8m7lXn/BbXAlNIET3Yo8RhXlEU9yunk3r/iV848SQlhzSmjHIi2xQEm5IzJxnmkWjj
	 uDiiME+eyfkL2gfC1aFJ0REUvlTFy90r++mWg4iVSKJq3234pKEhoC4sBnn8fEooqp
	 0XmfTNL6ocYLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio/type1: validate dirty bitmap page size before use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624191204.3774-1-alhouseenyousef@gmail.com>
References: <20260624191204.3774-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:25:55 +0000
Message-Id: <20260624192556.669BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `__ffs()` and `__fls()` with an argument of 0 results in u=
ndefined behavior when userspace passes `dirty.flags =3D 0`.
--

commit 38ca5c3a7cef062b9bd643fc4332459f28940553
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

vfio/type1: validate dirty bitmap page size before use

The dirty bitmap ioctl paths derive a shift with __ffs() from the userspace
supplied bitmap page size before comparing it with the IOMMU page size. A z=
ero
page size has undefined behavior, and a non-power-of-2 value makes the bitm=
ap
size check use a different granularity than the page size later accepted by
the ioctl.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..9499381d06a20 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c

[ ... ]

> @@ -3039,6 +3043,9 @@ static int vfio_iommu_type1_dirty_pages(struct vfio=
_iommu *iommu,

[Severity: High]
This isn't a bug introduced by this patch, but does calling __ffs() and
__fls() with an argument of 0 result in undefined behavior when userspace
passes dirty.flags set to 0?

In vfio_iommu_type1_dirty_pages():

	if (dirty.argsz < minsz || dirty.flags & ~mask)
		return -EINVAL;

	/* only one flag should be set at a time */
	if (__ffs(dirty.flags) !=3D __fls(dirty.flags))
		return -EINVAL;

If dirty.flags is 0, the mask check evaluates to 0 and passes, allowing
__ffs(0) and __fls(0) to execute. Since these macros map to __builtin_ctzl
and __builtin_clzl, this results in undefined behavior.

Could this be triggered by userspace to cause a denial of service?

>  			       range.bitmap.size))
>  			return -EINVAL;
> =20
> +		if (!is_power_of_2(range.bitmap.pgsize))
> +			return -EINVAL;
> +
>  		pgshift =3D __ffs(range.bitmap.pgsize);
>  		ret =3D verify_bitmap_size(size >> pgshift,
>  					 range.bitmap.size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624191204.3774=
-1-alhouseenyousef@gmail.com?part=3D1
