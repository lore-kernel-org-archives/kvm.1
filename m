Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586DC5695
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495827; cv=none; b=CbLZsBooeEwn2nCaG1KvZSIGPrt19rXLNcEGoLa20GBo0VvJMW4piKwCUFHZAVbc8SQ4vkrgucO4wgDkqd5dMuvnrvYupZdolHmew+VzdWr3E0Pd2CcoYkUWe+pHrXYC2OQsxO4U/Zo3ShNTBcBRaM8YVsrl2PdYDAldIUW3s8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495827; c=relaxed/simple;
	bh=Ys1WmtcqC809uPp+pUJeWIjz+4iCNQRa/Bqd/blLp3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oC9GB/9tLd4GgcjqcEaS5Ld2Ih9qUXbsSeGAxkm684VsjpDZ5HKXcFf/MXoNocvjl9odVH27gCpKyy/VrekD+6Z1Qd+XhwQWuXL7V1Tevrp0fCO40X1XxruMg6gwUpSwW53iK7FoOfET/TNthqECLn41LOzvncHG1UaqgGIyWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+9Ji/of; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+9Ji/of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8AF1F000E9;
	Fri, 31 Jul 2026 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785495825;
	bh=tqENAyl+TUJt9LU7Pox+uOdbWhZnSvCknJditIte1Rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R+9Ji/ofhKMT0uOB+JG9Qa1N1/3/bl29bJcDPr1ATwOooqXHcVJM+HCh4koC9ZJwh
	 XZOqbXaZnTdDXcEkkVkMn0G9eSt4otv1lkRRdoRaUeOxxrfwaP55WNkVkEz4pe5ycB
	 0vJzjvrfr4xfbZZ2G33oqe4TmgyRrlnHk0q4leR8qqOAqEvVP/tINvGqKuSrKvr2oy
	 YnsqBotkfAXkOsrrJUmTXbY8Kr2NLt5bW3aZolpSD46eO+kWNYI9dZDXKBtTICp/gL
	 KTplvdScdJ6BBWGrcua5n8gQoswntbkjuxu7hv01UBIsQN2BriwE1JvCa62nu1IniP
	 6IDUC03lJc2Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731103414.1746316-3-physicalmtea@gmail.com>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 11:03:44 +0000
Message-Id: <20260731110345.6C8AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds checking in `vhost_vq_meta_fetch()` combined wi=
th a failure to clear the metadata cache during `VHOST_SET_VRING_ADDR` allo=
ws malicious userspace to achieve arbitrary kernel read/write via vhost wor=
ker threads.
--

--- Patch [2]: [PATCH v2 2/2] vhost/vsock: keep IOTLB across feature update=
s ---
commit f04e21a46c433140a2f8e01687d07519c6aa6866
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: keep IOTLB across feature updates

This commit modifies vhost_vsock_set_features() to only initialize the
device IOTLB when one does not already exist. This prevents dropping
valid translations and forcing avoidable misses when VHOST_SET_FEATURES
is used to update logging while a device is running.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 562b9e139a76f..3703fd219039b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -893,7 +893,8 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
>  		goto err;
>  	}
> =20
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential bounds checking
problem in vhost_vq_meta_fetch() and vhost_vring_set_addr() in
drivers/vhost/vhost.c.

Does vhost_vq_meta_fetch() lack bounds checking on the requested address?

drivers/vhost/vhost.c:vhost_vq_meta_fetch() {
	const struct vhost_iotlb_map *map =3D vq->meta_iotlb[type];

	if (!map)
		return NULL;

	return (void __user *)(uintptr_t)(map->addr + addr - map->start);
}

When VHOST_SET_VRING_ADDR is called, vhost_vring_set_addr() updates the
vring addresses but does not appear to invalidate the meta_iotlb cache
(for example, by calling __vhost_vq_meta_reset()):

drivers/vhost/vhost.c:vhost_vring_set_addr() {
	...
	vq->log_used =3D !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
	vq->desc =3D (void __user *)(unsigned long)a.desc_user_addr;
	vq->avail =3D (void __user *)(unsigned long)a.avail_user_addr;
	vq->log_addr =3D a.log_guest_addr;
	vq->used =3D (void __user *)(unsigned long)a.used_user_addr;

	return 0;
}

Could this allow a crafted, out-of-bounds IOVA for the vring to bypass
access_ok() checks and calculate an arbitrary kernel address if a valid
IOTLB mapping was previously established and cached?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731103414.1746=
316-1-physicalmtea@gmail.com?part=3D2
