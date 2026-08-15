Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D53D9DAA
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778978; cv=none; b=ojEkTNhe/NP27Xn7ty/eRJG+RxPpIyKBKxoVmdE4Fw26DYFsXbnlTnjNvSSJJ2EG8xaVEkoieGCpZ/oXsiX5wdVVMmL5EBXJilzRmCq1U+eDly4Qn1YjSi1/gaVhg6L3GuGbDrN6Nh5vpj0RyoyaB1QX4IOEh9ZyNuVEl2VZvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778978; c=relaxed/simple;
	bh=LiJGK7aLpISPbAVMdVOA1adYC3lhdu5gmaS1wO70epY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qMOH5faEtgJc364qELfA3uQmQxzWIR0+5/CJ49nir23G7nYRU8Ij6rSqa4CdLX/yY/Pf6QwZc4GL8eycicImnKtViRTmcxQHDybOtwgmG63GhJDboqDK7FpCnSMQbp6rWegfmexpgiolCbW2FEcTe5qWHmfYR5FShVLDy13oKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/nn4bfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/nn4bfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8510A1F00A3D;
	Sat, 15 Aug 2026 07:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786778976;
	bh=24g54HBiC1Rkzs8tWbbVMEMyQ02nkMci8csIFH4VXGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D/nn4bfa5r1/FmxNyvpTTUJpn6chy/KIcvDqbbFdTO8R+uEHdG1EChsuuluu03O6f
	 FJ7NTh3H51oBL1aoCcq+5B80aebuy2dM9M38oahrcBLm7CgB6oHnKbmcttBVAaW/JM
	 2jsfYGqf1+mcabV9bGv3uWOqQKoxp3wQJnvoUS/Ii4b21wsRtlI0X5d+nLDftIxnDi
	 myUHCLFbgGeDZH1PVkELgZ5nzOOU11lc5/Hbj+bJVuhsbZtTEN28gXRvoe9Al17Syj
	 A0aAuEmltosN2idxM6X9qPMNaN5R/Js5j53Q20mXSb89NTTp0XbXkAcwb8IxI9O+WK
	 v/nuDjuVz/3gA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814072903.124991-4-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 07:29:36 +0000
Message-Id: <20260815072936.8510A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fails =
to apply its fixes consistently across the vhost subsystem. The patch corre=
ctly fixes the issue of dropped IOTLB translations and missing cleanup on V=
HOST_SET_FEATURES for vhost-vsock, but completely misses identical bugs in =
vhost-net. Because `vhost_net_set_features()` lacks the `!n->dev.iotlb` exi=
stence check, it continues to unconditionally wipe and reallocate the IOTLB=
 on every feature update when `VIRTIO_F_ACCESS_PLATFORM` is set. Furthermor=
e, it lacks the teardown logic to clear the IOTLB when the feature is dynam=
ically disabled, leaving stale translations active.
--

--- Patch [3]: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature update=
s ---
commit 43e7ccb915735bc2e366b5df4fab08c7d9c89e1e
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: keep IOTLB across feature updates

This commit updates vhost-vsock to only initialize the device IOTLB when one
does not already exist. This prevents dropping valid translations and forci=
ng
avoidable misses when features like logging are updated while the device is
running.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index a18fe1335349b..b5536075fc397 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -886,7 +886,8 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
>  	    vsock->dev.iotlb)
>  		vhost_clear_device_iotlb(&vsock->dev);
> =20
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}

[Severity: High]
This is a pre-existing issue, but should this same fix be applied consisten=
tly
to the rest of the vhost subsystem?

Looking at vhost_net_set_features() in drivers/vhost/net.c, it lacks this
existence check and continues to unconditionally wipe and reallocate the IO=
TLB
on every feature update when VIRTIO_F_ACCESS_PLATFORM is set:

drivers/vhost/net.c:vhost_net_set_features() {
...
	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
		if (vhost_init_device_iotlb(&n->dev))
			goto out_unlock;
	}
...
}

This unconditionally reallocates the IOTLB and drops all valid translations,
which could cause a storm of IOTLB misses and latency spikes during events =
like
live migration when VHOST_F_LOG_ALL is toggled.=20

Additionally, vhost-net appears to be missing the teardown logic to clear t=
he
IOTLB when the feature is dynamically disabled, which could leave stale
translations active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814072903.1249=
91-1-physicalmtea@gmail.com?part=3D3
