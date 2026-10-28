Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172813;
	b=cZwoK9k/eBIRead27FSVTgiMOdz9yj/frGfPr1FNRaf7SmcrAj2/CxpyHeoz/JKX7Lmv
	 nZ+VbC725vfvWxbiPbsGgYNjmKUShKdgcNJ50qCjWwH4fk3vd8Se6d+mM1d1cQjtBzhrb
	 AfZHSJmg2RqflzggMpC7p0HXSHhknEa9xYw7/5JvfpotwEu8af/PQj3lcGLBtZECYXPnF
	 mZqH52T4qd2dMoLP7S2bDMCOr9/19h9nSvlk8pnSOGPpHKFVlh2SA61k2sJt7+nvC+Hcb
	 tTYDKFdcnP1v6Mex+YGldSKYZFAvI//KVO+8E2EY4brbD+4tWOGMTNNBPMlrToFVUFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tCHH2ocNTR2+1rXUWBXKTRSEf48EU6EMTZZdWFeBzLA=;
	b=YUoLOBSAz/ZeDWG1RP1e4Yh0v7AHZjnpvpxlvQY47q00I82dmaJgMF2Vdkc1jz4kdsY5
	 K7MulBvhRWDn4paFIiLmOee+Nx7AmJ2uDUMgutbE1nvxxIES41MFTHzYSzXnxNKbKXK2A
	 Sm5ROjr1aWGnquDHYJKAIwqaIpC/0PvR2sNTQqGj01fTvSGknXYop8UGA592tK9NoG9kx
	 mnVVl3bhai/WU6RwXaR7zGPETVKlt8r3kR0emBorqbTvXr8/zAYO9lr4QuXqG58p1F259
	 GVvIlpRVGwNo06vv1BatWsgJ7CSufw/Kpv6oQyAHcaykpn4P7tKIPGls4DA8ugpq8AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdidTVHK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5B9606A31A
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VdidTVHK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3851F01828;
	Wed, 28 Oct 2026 07:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793172812;
	bh=tCHH2ocNTR2+1rXUWBXKTRSEf48EU6EMTZZdWFeBzLA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VdidTVHKN6kKGgberodmVQQTNbFmxJVL3iREUPrha1Z29Dztag19F8kkGq51RWwIu
	 mVtnRUDhf2Dl9IuRTMva7YkW+tbRnIBI0ePerTEK0bB3GcH++4TQAyLuBpZ0sgZBg7
	 N6L3NPRoGWgHBKknPK6wEaJauh54bGLIMI1I+aLdOC/dGDjd5QcGpHWs+/fh3eYOoE
	 BbpKomCaAZ/rA0vIXtprHxcBkIUhiXTfIimtn5wznAlTJ5oO5wWQSw4MHpbtDQZVdT
	 VW3wOLSyx5TfKMTlrJmwr+bhzpu/nH57tywhreIrgjDJpzhcQMH6KcA7828G1aVZIM
	 I7pQliW1oo4Tw==
Message-ID: <sashiko-outbox-187579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261028071906.2325378-4-guanghuifeng@linux.alibaba.com>
References: <20261027183418.GJ1685504@ziepe.ca>
 <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
 <20261028071906.2325378-4-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 07:33:31 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] iommufd: 32-bit range truncation in iommufd_ioas_reserve_iovas()
- [Low] iommufd: unnecessary iommufd_ucmd_respond() in iommufd_ioas_reserve=
_iovas()
--

commit c4727e768ae8fb291a064ae74e64f9f8999c92bb
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl

This commit adds the IOMMU_IOAS_RESERVE_IOVAS ioctl to allow userspace to
reserve IOVA ranges in an IOAS, excluding them from IOMMU_IOAS_IOVA_RANGES
and rejecting overlapping mapping operations.

> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 8fb5271a95060..e1ded7e8c5eed 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -183,6 +183,55 @@ int iommufd_ioas_allow_iovas(struct iommufd_ucmd *uc=
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
> +
> +		rc =3D iopt_reserve_iova(&ioas->iopt, range.start, range.last,
> +				       NULL);

[Severity: High]
On 32-bit architectures, can passing 64-bit range.start and range.last into
iopt_reserve_iova() silently truncate the range and corrupt
ioas->iopt.reserved_itree?

In struct iommu_iova_range, start and last are __aligned_u64, whereas
iopt_reserve_iova() in drivers/iommu/iommufd/io_pagetable.c and struct
interval_tree_node take unsigned long:

    int iopt_reserve_iova(struct io_pagetable *iopt, unsigned long start,
                          unsigned long last, void *owner)

Unlike iommufd_ioas_map(), iommufd_ioas_unmap(), and iommufd_ioas_copy(),
which check for ULONG_MAX overflow and return -EOVERFLOW,
iommufd_ioas_reserve_iovas() only checks range.last < range.start in 64-bit
arithmetic before passing them to iopt_reserve_iova().

On 32-bit kernels (for example, a 32-bit PAE/LPAE system where
IOMMU_GET_RECOMMENDED_RESERVATIONS reports a 64-bit PCI host bridge MMIO
window above 4 GiB), ranges with range.last > ULONG_MAX are truncated modulo
2^32, reserving the wrong low IOVA range.

Furthermore, if a range satisfies range.start <=3D range.last in 64-bit
arithmetic but wraps such that (unsigned long)range.last <
(unsigned long)range.start (for example, range.start =3D 0xfffff000ULL and
range.last =3D 0x100000fffULL), iopt_reserve_iova() receives start > last. =
The
overlap checks in iopt_area_iter_first() and iopt_allowed_iter_first() miss
existing ranges, and an inverted node with node.start > node.last is insert=
ed
into iopt->reserved_itree, breaking interval_tree_for_each_span() in
iommufd_ioas_iova_ranges() and interval_tree_for_each_double_span() in
iopt_alloc_iova().

Should iommufd_ioas_reserve_iovas() check range.last > ULONG_MAX (or
range.start >=3D ULONG_MAX) and fail with -EOVERFLOW?

> +		if (rc)
> +			goto out_unlock;
> +	}
> +	up_write(&ioas->iopt.iova_rwsem);
> +
> +	rc =3D iommufd_ucmd_respond(ucmd, sizeof(*cmd));

[Severity: Low]
Is the call to iommufd_ucmd_respond() needed here?

All fields of struct iommu_ioas_reserve_iovas are inputs, and
iommufd_ioas_reserve_iovas() never modifies *cmd. Calling
iommufd_ucmd_respond() performs an unnecessary copy_to_user() back to
userspace, and if the caller passes the input struct in read-only memory, t=
he
ioctl will return -EFAULT after the reservations have already been committed
to ioas->iopt.reserved_itree.

Other input-only handlers in drivers/iommu/iommufd/ioas.c, such as
iommufd_ioas_allow_iovas() and iommufd_ioas_change_process(), return 0
directly without calling iommufd_ucmd_respond().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028071906.2325=
378-1-guanghuifeng@linux.alibaba.com?part=3D3
