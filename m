Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30B37648F
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785386178; cv=none; b=NYf+Q4Cd+1n8j84PLrrILurM/Ib0d3voMSfMgS11P2PO8WLbEB/ma/h8aYhWmErAY/dTSZPB3mbxq2CiRR8aw8OSp2Sgd+EUEahfuj9fJump9DS4S8bLJc97BZpgJQpkyVn7dNN9gbMmT7PgSSDTQVWn36IDMBOQl7pBlPq0wjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785386178; c=relaxed/simple;
	bh=rPbcNrb32F6yUsruYV2myU1kAKUWvTVanCTfy+IBTIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+f5BbuXclhAYxJH/G5yRnoGdoW6qwaSWM1qNPNv2t9OYAA1IjtfjH8m7HdNQgx3OaVXHYg0RnAm+UlEvcnJdZXUY+2iEye/jb+pa455Kukjs3gplDIg8ZNwpq7vi9lRzoXAMCxCHAusH5wdCdCldfQ8NKESPt0b8lIyxEhjapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjxE1ZIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjxE1ZIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E341F000E9;
	Thu, 30 Jul 2026 04:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785386175;
	bh=S7bM067u3+GTVgnb/NKAhCPhdj+oWO4/AMWZIuoqINg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BjxE1ZILnCT/pGpo/kwXl1u654xmnvLAvs8wiBYNWz8xjxT5QjpMDdrTqc5BTlYt5
	 M9DbCSZmZvEXp/RQnuwsEgckZUlxgCBlOTh7OQpd4jSjHyVp0PKdrz+HUyQC3wV1NE
	 +8//4Ogu2Y8yleAxNqizcmfwFuqWTiM8Q5BAM3A35ciJjSIQIv6h/KiEqaNEjZDEZ5
	 4NtzRrVMEMV94ilT9+XdqirrlHyUNovAWEot1YaQkG5pEzEdGw8jRqUp7pKT2f8jdo
	 SBNCWq9gLBql2Z8grDf1zOsAIbdeJxOFZ9V5MfnK/NlbMShCmARLrdmSHGHKPk8JGd
	 KSpynsg3dYnNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730040938.1725757-1-physicalmtea@gmail.com>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 04:36:14 +0000
Message-Id: <20260730043615.52E341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical IOTLB-discarding bug and stale IOTLB UAF vulnerabili=
ty fixed in vhost_vsock remain unpatched in the sibling vhost_net subsystem.
--

--- Patch [1]: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFO=
RM changes ---
commit 6249693cea8dab5e61026ab282a77f329039d592
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM changes

This commit fixes a vulnerability in vhost_vsock where clearing the
VIRTIO_F_ACCESS_PLATFORM feature leaves a stale IOTLB. It also prevents
discarding the current translations during runtime log updates by avoiding
empty IOTLB allocations.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -865,7 +866,14 @@ static int vhost_vsock_set_features(struct vhost_vso=
ck *vsock, u64 features)
>  		goto err;
>  	}
> =20
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		ret =3D -EBUSY;
> +		goto err;
> +	}
> +
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}

[Severity: High]
This is a pre-existing issue, but does the identical bug still exist in the
sibling vhost_net subsystem?

Looking at drivers/vhost/net.c:vhost_net_set_features(), it appears to
still use the unconditional allocation logic:

drivers/vhost/net.c:vhost_net_set_features() {
    ...
    if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
        if (vhost_init_device_iotlb(&n->dev))
            goto out_unlock;
    }
    ...
}

When a virtual machine uses vIOMMU, could a feature update (such as
userspace enabling log access during live migration) cause
vhost_net_set_features() to unconditionally call vhost_init_device_iotlb(),
destroying all current network DMA translations and breaking connectivity?

Additionally, does this function also fail to reject clearing the feature
while an IOTLB exists, leaving the same stale IOTLB vulnerability open for
vhost_net?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730040938.1725=
757-1-physicalmtea@gmail.com?part=3D1
