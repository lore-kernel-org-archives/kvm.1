Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE089424D7C
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299562; cv=none; b=p+NvgkZ77YWbxm7/AWIZ5XLq7bkGQMORRCtDSvtnJqdeIFEfc6V0mGgvy3hLQUlthOav+HD+O67Ifk7ibP12EjFkldAFg1F1WWgUt9y/qkmqtihZ/JljE6baVKcxF9/Mh/C2C4LI24vVUsFLnfX0ouDa0wCm3hhyfYStIc++TqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299562; c=relaxed/simple;
	bh=5NkbCjWFmJ0W0/ayQIBeRwyRU8tmay+LitWNdN+A1kY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iD3NVVKbdYrj58ZFLO28obWjwWjpoIAm0P56lU8BFFu0bV4j6vIodXWwgTlbWk1VUDteXNv5kT0oM1lhiL4t+4U+Cc6IcghbLU5jm4XRpZmAl1u5SgO2MyWMKQ1+UPjOU85P4YV0i9j4uRX3BkzcNzKh6jAGPD7Z3XX2QsiykT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEftFAnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEftFAnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233CE1F00A3D;
	Fri, 21 Aug 2026 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787299559;
	bh=CaBR8Udrv6rWTc+2LWNKWyRQCCqcYVpl3YOiFTbPWwI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEftFAnvKAFSUDUmHL2FcsGFibjyx2MJBb2QU81XJrnljYi7WxVZoYpbqG+mmdWfA
	 4YuQvvOiLdEAuy5Jc9eB5IV7GwHcKCkwXzRFQWCrF27iF1DZtJZCAknY1za7eQtBgM
	 VX2ukDqbzFdGqNgtAJAwPAsbq5TOqbv6peUy4C1xESRY22x/HZmCWsOT0Ad5id9S5k
	 oor/UVVorkWZTK71GoYphyhQ9wpfypw4o8hPtRwEcy13GtfIoAg5l/KpHYpMrEnkyr
	 9RWI7huDoZTDJKTSMTUq9YJ2z4lKVX6l+zr00HtBgbGZQJTQtg/eMb6RtQUTjAX58X
	 W91ncZkXuUSVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260820080332.313933-3-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:05:58 +0000
Message-Id: <20260821080559.233CE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Concurrent lockless clearing of dev->iotlb causes a TOCTOU rac=
e in translate_desc(), leading to a NULL pointer dereference or out-of-boun=
ds memory corruption.
--

--- Patch [2]: [PATCH v7 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFO=
RM is cleared ---
commit feb57c09c27392564744aed50569fa28daa5a083
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared

Clear the device IOTLB when userspace clears VIRTIO_F_ACCESS_PLATFORM.
Otherwise descriptor translation can continue to use mappings installed
before the feature change.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8061c..e1e9d002d6aeb 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -865,9 +865,11 @@ static int vhost_vsock_set_features(struct vhost_vso=
ck *vsock, u64 features)
>  		goto err;
>  	}
> =20
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
> +	} else {
> +		vhost_clear_device_iotlb(&vsock->dev);

[Severity: Critical]
Does this concurrent clearing of the IOTLB introduce a regression with
active backend workers?

Looking at vhost_clear_device_iotlb(), it sets d->iotlb to NULL locklessly
before acquiring the vq->mutex:

drivers/vhost/vhost.c:vhost_clear_device_iotlb() {
    ...
    d->iotlb =3D NULL;

    for (i =3D 0; i < d->nvqs; ++i) {
        struct vhost_virtqueue *vq =3D d->vqs[i];
        mutex_lock(&vq->mutex);
    ...
}

If a virtqueue backend worker is actively processing descriptors via
translate_desc() concurrently, it evaluates dev->iotlb without a READ_ONCE(=
):

drivers/vhost/vhost.c:translate_desc() {
    ...
    struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
    ...
}

Can the compiler emit multiple fetches here, such that the first fetch is
non-NULL but the second fetch returns NULL? If umem becomes NULL, passing it
to vhost_iotlb_itree_first() could cause a NULL pointer dereference.

Additionally, if the worker sees dev->iotlb as NULL immediately, will it
incorrectly fall back to dev->umem and mistakenly translate the IOVA using
the GPA memory map, leading to memory corruption?

>  	}
> =20
>  	vsock->seqpacket_allow =3D features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET=
);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820080332.3139=
33-1-physicalmtea@gmail.com?part=3D2
