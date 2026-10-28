Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178867;
	b=LY8/BsNB8t246YDoucVd2BuZhCePGNBMasq25nYraBendNAGwiakcJmw1SLrA2ZNxoR8
	 fgr+DgkQXuaP01O7IIzJv0hKoj0w6QwAO3JUQytLv+nu3J3Z4/7iCWd5fJ9B4hiGgiNrl
	 TrVDPni7YZE7Z/gucqQpfhEWfM2XhAYmjMnZGixS0034G2DhouWnewNXPAsuLne41G3kr
	 gXgmt5xRb7RRyA+fRJyGCsACAunKo6AxgWE33nWKGyHi9KuL9epVcDtnrXqgQAiG65vSc
	 ZzoIy6r3SxiwcuJTcrc+bvkobRfcwfdPpFGPBJOLXrScxK9IiBWNsVQxniqf9qBdPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LhfiB4JoGhLDOo4pwrAolURHxE6t8PTwF0oLC1Q1bAo=;
	b=gtwdhOzGZdPGlvzw3DqmeHY7z3UTcugb8no3KXxzdlZgRCvOq9XS3hXBJCAd5BlidLkX
	 d46UppQlYFjQ03BcDGpR6rC4fWdTyeYjuPh5rtYU2eoPVbjAY5G0j4/dIvBEpyFaZyZnc
	 Qd8tZnE6JxLCbX3w0auEh8Gg1oAHGMAf3o/MJDVsYi1quDySrw3S47Hha9C0ybGOMAVnS
	 VaLlxDvGsO9DanSI/28V3XINN1RhVjiSJSPLrXUnGKbftI9lfpW9jQ9ptQ2pu6qf+QH5K
	 5xtDVZd6E1OtJI6mnJmMgCTFI9rvQdLuS3XiuNoVUGSS4ImCexVu1DlzpY4YUT7E3pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lfl6rmtb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425EA606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lfl6rmtb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41F41F01825;
	Wed, 28 Oct 2026 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793178866;
	bh=LhfiB4JoGhLDOo4pwrAolURHxE6t8PTwF0oLC1Q1bAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lfl6rmtbLBaDLRSmFxb31UTv8N9IauTBAa6Do3gg4shugcI1ltKAEdG59ad+t6luJ
	 x8N55O0NBcEMdPp1PIt/d0am7YzhVp9/O+xF/8e+VAHWFfbZLJoAaPAp/ijzZEegHD
	 OHpiEJo7ecjnZP31VVCuwpJ3UuUlbvTv5pSZS8IS+KpUhPG/DIcGN9SoyVlnSe5HwB
	 5es47lOPCDZTN7/whvY8UMzj81agygnM5N31BB7jAO9ed6FhdIfJND4RmousXVJ4v4
	 GGJLRGgqFQX+7ExOrLSvMruKLzAzXtgB8EsPgtbSW5P1pr1utuOMwM0otFeO3ajNG4
	 YIDkzP1zTYKBw==
Message-ID: <sashiko-outbox-187660@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/3] iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261028090453.2392991-4-guanghuifeng@linux.alibaba.com>
References: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-4-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 09:14:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommufd: off-by-one ULONG_MAX check in iommufd_ioas_reserve_iova=
s()
--

commit 0ed118205dea2d86a2a0d60398112fcc9b0dd85e
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl

This commit adds the IOMMU_IOAS_RESERVE_IOVAS ioctl to allow userspace to
reserve IOVA ranges in an IOAS so that they are excluded from
IOMMU_IOAS_IOVA_RANGES and rejected by mapping operations.

> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 8fb5271a95060..1a2361850bd2c 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -183,6 +183,57 @@ int iommufd_ioas_allow_iovas(struct iommufd_ucmd *uc=
md)
>  	return rc;
>  }
> =20
> +int iommufd_ioas_reserve_iovas(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_reserve_iovas *cmd =3D ucmd->cmd;
> +	struct iommu_iova_range __user *ranges;
> +	struct iommufd_ioas *ioas;
> +	u32 i;
> +	int rc;
> +
> +	if (cmd->flags)
> +		return -EOPNOTSUPP;
> +
> +	ioas =3D iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	ranges =3D u64_to_user_ptr(cmd->ranges);
> +
> +	down_write(&ioas->iopt.iova_rwsem);
> +	for (i =3D 0; i < cmd->num_ranges; i++) {
> +		struct iommu_iova_range range;
> +
> +		rc =3D copy_from_user(&range, &ranges[i], sizeof(range));
> +		if (rc) {
> +			rc =3D -EFAULT;
> +			goto out_unlock;
> +		}
> +		if (range.last < range.start) {
> +			rc =3D -EINVAL;
> +			goto out_unlock;
> +		}
> +		if (range.start >=3D ULONG_MAX || range.last >=3D ULONG_MAX) {
> +			rc =3D -EOVERFLOW;
> +			goto out_unlock;
> +		}

[Severity: Medium]
Should the check in iommufd_ioas_reserve_iovas() in
drivers/iommu/iommufd/ioas.c use > ULONG_MAX instead of >=3D ULONG_MAX?

struct iommu_iova_range represents an inclusive [start, last] interval, and
iopt_reserve_iova() supports inclusive bounds up to ULONG_MAX, as seen in
drivers/iommu/iommufd/io_pagetable.c:iopt_table_add_domain():

	if (geometry->aperture_end !=3D ULONG_MAX) {
		rc =3D iopt_reserve_iova(iopt, geometry->aperture_end + 1,
				       ULONG_MAX, domain);

The UAPI comment for struct iommu_ioas_reserve_iovas in
include/uapi/linux/iommufd.h also notes:

 * A range with last < start fails with -EINVAL.  On 32-bit kernels
 * a range exceeding the native address width fails with -EOVERFLOW.

With >=3D ULONG_MAX, any range starting or ending at ULONG_MAX (such as a
32-bit PCI host bridge MMIO window ending at 0xffffffff on a 32-bit kernel,
or a reservation reaching U64_MAX on a 64-bit kernel) is rejected with
-EOVERFLOW.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028090453.2392=
991-1-guanghuifeng@linux.alibaba.com?part=3D3
