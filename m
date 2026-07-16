Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB526738C
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171532; cv=none; b=Dn4rEvmy3Gu8ZS+dCmcnLqcRN9goJ9gtLw0Gef8pRE0lHuipp2Ix10xuVSdpJ+oL4FbOyHtkL2YGz5gysBv+5wiYxMJO23InuHfCsZWpJSJ20fxUyNSFzuVy5moF1RPuebRxoHCwFZ+/K8EV26ByVl0LC+SYGAFXvGI7fQBoOiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171532; c=relaxed/simple;
	bh=T8YizExBAgnXwce39MQlZxgK33iUkkmLN60IlCcFBT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZO2lj0gmWlJfAA++V3+yv9b/lcRqcqqhhoWfRKMmLkdPIBC2a7vwI2AvFjydJkNR9mdxIEy9+Q2NRjZh4ho2M+nyPAv/PQbxBjWEFR+G0fqlIlHTyT6TlFKiq1VQrVZlXV8WcYai88yqLZ7O+mVh+50HTFegFx+NFvw+/yb6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6oOQ4mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6oOQ4mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976121F000E9;
	Thu, 16 Jul 2026 03:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784171530;
	bh=vc6KhTZOo3QuS5PdZ3u8SXWTB7wHLAmWJdXDFPGFsCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j6oOQ4mT7yAD9YL5GLlHTBmYApP0/hiWw9o6fDXwJtr7i1AUsSgBdbkV8FDfdvmnx
	 fHzGaZDfC62Zlzv2EEie0tEtRSPZ5VNpk3KRy7PQLvYUxCQTo3zabeZ4mEv3SSTv6L
	 a6j/c17X9MN1mDtJD+DCirdpOKcmk15j0qL1QLUQ0Wc4TEhyXMYds7sBxPm8NzgXro
	 tjjPTW7tvzK+WjDHuoIBsQxtFVh2FmRZG9xLI5oRIvxPlsw3m/AxAEKkdD47QJSeg9
	 ix3sdbodRvKwnsL/0Qq5w56wMKueoqp9YIKYOVxD+/3obtSODZinvnJyukbzg/wYak
	 iKsEFf+dO1pnw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix MR state corruption on
 setup_vq_resources failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weimin Xiong" <xiongwm2026@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716030241.124412-1-xiongwm2026@163.com>
References: <20260716030241.124412-1-xiongwm2026@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 03:12:10 +0000
Message-Id: <20260716031210.976121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving the MR update to the end of mlx5_vdpa_change_map() causes h=
ardware virtqueues to be programmed with the old Memory Region (MR) keys in=
stead of the new ones, leading to device malfunction and hardware faults.
--

--- Patch [1]: [PATCH] vdpa/mlx5: fix MR state corruption on setup_vq_resou=
rces failure ---
commit 0e93d2962a61c5461c3028e043cb48591fa19ebe
Author: xiongweimin <xiongweimin@kylinos.cn>

vdpa/mlx5: fix MR state corruption on setup_vq_resources failure

This commit defers mlx5_vdpa_update_mr() until after setup_vq_resources()
and resume_vqs() to prevent MR state corruption if resource setup fails.

> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index ad0d5fbbbca84..8a6ddc00b8e07 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3067,24 +3067,28 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_=
dev *mvdev,
>  		teardown_vq_resources(ndev);
>  	}
> =20
> -	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
> -
>  	for (int i =3D 0; i < mvdev->max_vqs; i++)
>  		ndev->vqs[i].modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY=
 |
>  						MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
> =20
>  	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
> -		return 0;
> +		goto done;
> =20
>  	if (teardown) {
>  		restore_channels_info(ndev);
>  		err =3D setup_vq_resources(ndev, true);
>  		if (err)
> -			return err;
> +			goto out_err;

[Severity: High]
Does deferring the MR update cause the hardware virtqueues to be programmed
with the old MR keys?

setup_vq_resources() eventually calls create_virtqueue(), which reads the MR
keys from the mvdev->mres.mr array before it has been updated:

drivers/vdpa/mlx5/net/mlx5_vnet.c:create_virtqueue() {
    ...
    vq_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VDPA_DATAVQ_GROUP]=
];
    if (vq_mr)
        MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
    ...
}

>  	}
> =20
>  	resume_vqs(ndev, 0, ndev->cur_num_vqs);

Similarly, resume_vqs() modifies virtqueues using the stale MR keys:

drivers/vdpa/mlx5/net/mlx5_vnet.c:fill_modify_virtqueue_cmd() {
    ...
    vq_mr =3D mvdev->mres.mr[mvdev->mres.group2asid[MLX5_VDPA_DATAVQ_GROUP]=
];
    if (vq_mr)
        MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
    ...
}

> +	goto done;
> =20
> +out_err:
> +	return err;
> +
> +done:
> +	mlx5_vdpa_update_mr(mvdev, new_mr, asid);

Since mlx5_vdpa_update_mr() happens here at the end, does it destroy the ol=
d MR
while the hardware is actively configured to use it?

Could this lead to IOMMU faults and memory corruption when the memory
map changes?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716030241.1244=
12-1-xiongwm2026@163.com?part=3D1
