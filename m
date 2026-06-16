Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDBE35AC28
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781609341; cv=none; b=CjDbEvv6045YgenhYxHtrpEAEIdQ5CtdKu5PYM+E2f3oigdGvMOFU4YueYnCpQsf32otcO3xWnmNPJLw6eDP/3QaOOvsYLAmyCfEFyfg7UwLG7+Pxg5TItVhZMw6EbYJVw+8Rvt+bA9+vyjxSMOvGGLJH6WGTp2/PNp6eb3jzyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781609341; c=relaxed/simple;
	bh=1EzbNr1ZXdN6z+5Hqm5DaY/gwHHDl9++uGjSSbOc/Z0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C0c+rGM+SwQVcg4g5FqT3LXjsGZnlHVHlKkA5tGxN0yvq2vmb5pzObwSXbuM84EVWBP1zL26ZkoEf/1Mfw194vAMExKbndfzMU3//hyKePCLfElUEwBi8CH8ReuEyowF7WhnaRkOLlnal7rdcUH8uGG2tyto82k9nKmfE7szk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk5tJtC9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk5tJtC9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E45A1F000E9;
	Tue, 16 Jun 2026 11:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781609339;
	bh=BVJ5UzA+Kq0Nc+eTjvyn1SPWvxKjpb9Rc4Rw8EYRZXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk5tJtC9M450+eq0YZ1XM8QW66uZ1ZjCbK7vxpxXFiLX/CFYr19qWf+eZqvM9j5BS
	 A7rN6rxuqIxrwPmNWwpVYgBVata4ZQY1Wr4+OhaTFCIRuVsl2rgl92bTUSvC2+K79y
	 NZmoqntOBxKoyXaBUhze9a3C2/sTTzgnu0YVYOPhYZwcO0z5An3sx5uwHCrswCeX4V
	 xuG+/BjQ0SkfPvh5b8qqjZ/K8PbJOIVzraJDhXvI93QjtFOJUn61pTLdvKRhUpZqxc
	 rcvvZIT3H2HUcPTXr57+GP0+uordWu9sElXMH46lyzEi2AaYQCT1bSkYOn+2127g/C
	 2RavjJIJFsFag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vfio: Validate that bitmap.pgsize is a power-of-2 in
 vfio_iommu_type1_unmap_dma
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616111733.1810-1-lirongqing@baidu.com>
References: <20260616111733.1810-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:28:57 +0000
Message-Id: <20260616112859.8E45A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch correctly addresses undefined behavior by validating tha=
t user-provided bitmap.pgsize is a power-of-2 before passing it to __ffs() =
in vfio_iommu_type1_unmap_dma(). However, it completely misses identical vu=
lnerabilities in vfio_iommu_type1_dirty_pages() where unvalidated user inpu=
ts are also passed to bit-scanning functions.
--

commit 6fe55d8211a4934baec28340932ad6ce53984ed4
Author: Li RongQing <lirongqing@baidu.com>

vfio: Validate that bitmap.pgsize is a power-of-2 in vfio_iommu_type1_unmap=
_dma

In vfio_iommu_type1_unmap_dma(), the user-supplied bitmap.pgsize is
passed directly to __ffs() without sufficient validation.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..b05fde8d87c65 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
[ ... ]
> @@ -2949,6 +2950,9 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_i=
ommu *iommu,
>  		if (!access_ok((void __user *)bitmap.data, bitmap.size))
>  			return -EINVAL;
> =20
> +		if (unlikely(!is_power_of_2(bitmap.pgsize)))
> +			return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but while this check addresses the problem
here, does the exact same problem exist in vfio_iommu_type1_dirty_pages()
in the same file?

If userspace passes dirty.flags =3D=3D 0, the invalid flag check is bypasse=
d,
and both macros are invoked with 0, which triggers undefined behavior:

drivers/vfio/vfio_iommu_type1.c:vfio_iommu_type1_dirty_pages() {
    ...
	/* only one flag should be set at a time */
	if (__ffs(dirty.flags) !=3D __fls(dirty.flags))
		return -EINVAL;
    ...
}

Similarly, when VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP is requested,
range.bitmap.pgsize is passed to __ffs() without checking for 0 or
non-power-of-2:

drivers/vfio/vfio_iommu_type1.c:vfio_iommu_type1_dirty_pages() {
    ...
		pgshift =3D __ffs(range.bitmap.pgsize);
		ret =3D verify_bitmap_size(size >> pgshift,
					 range.bitmap.size);
    ...
}

Since providing 0 triggers undefined behavior, and a non-power-of-2 value
distorts the subsequent verify_bitmap_size() logic exactly as described in
the commit message, would it be better to add the same validation to
vfio_iommu_type1_dirty_pages() as well?

>  		pgshift =3D __ffs(bitmap.pgsize);
>  		ret =3D verify_bitmap_size(unmap.size >> pgshift,
>  					 bitmap.size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616111733.1810=
-1-lirongqing@baidu.com?part=3D1
