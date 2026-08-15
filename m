Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7B2E7365
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778977; cv=none; b=WjyzgkxjNg2X16avEpnnExiFxKpRq6ldP5d/E6RAVrXfrNYyxaG9EIBDr58oAma2WmMXpzNINtPBqA5MEy06xnGmgNo/RG/1//J8MQfP0nTr8dZ8Gklj+DAmBCtC/rl8PlWXe41aa/BCY8wKyKfd8VdzxtY3Sl2Pr1iGtAqQ+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778977; c=relaxed/simple;
	bh=M3NDv+x65KDnT+fyooE4mFl+iOHZlvut6v7EdEf5YOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UjEG6Hia5HfXUFz6LC4ElrfL5+Ds0rNGl9boyjW6aPb4WAh+9Vy9owO1/JaitpQu/dhPRI05bxN72RQ9BSC51fvXb2vrTyFW4pW4mDPXSzGu0B/OGopdOZEEpw67k0IMVSjH7257u1PDwMDGlc26Jjt+HWr+k5w1qWvyqHuUbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BndW216Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BndW216Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410ED1F000E9;
	Sat, 15 Aug 2026 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786778975;
	bh=B7f13ZE13TphPS0p90URwBWMsCtcJ0oWVfEByaNokWE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BndW216Ydi7OrJB6r0ul5t41Fjwvo/lD8x6F1nqXlnghLvuVOALOHkbv066I4mmdF
	 PZXJoGHSGxDlO8GrLVol7yKIK64En2CHWkhtBQ2XYFQJuwpEvtxlCpVQ0hPR3osRCH
	 EI1dCTl1p6giqFGWa5+1eJtBjkREKwZSJsQNs07BrtvmAbWOEIKKbPEjWFDVzJfY17
	 8gr/rKdHhGmqs+fk8vSqmiOnT+qjnn0kKhbDnX/m9aW1feOLc0iXwwj54w+UBDz9pH
	 lF3sWxq4OgtajuXytxGl7ZRJSTDFe4v5NoDBbRzOg2a7iRfl3ETpYSW1eXVItklqaz
	 4mG95YB/5virg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] vhost: add helper to clear device IOTLB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814072903.124991-2-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 07:29:34 +0000
Message-Id: <20260815072935.410ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Setting `d->iotlb =3D NULL` before acquiring `vq->mutex` in `vhost=
_clear_device_iotlb` creates a race condition with active vhost worker thre=
ads. This exposes the host kernel to a NULL pointer dereference or an IOMMU=
 bypass (TOCTOU vulnerability) leading to arbitrary host memory corruption.
--

--- Patch [1]: [PATCH v4 1/3] vhost: add helper to clear device IOTLB ---
commit 721258d5c0d5f3c1aeaefcc8dc997b5bbedcd9c1
Author: Jia Jia <physicalmtea@gmail.com>

vhost: add helper to clear device IOTLB

This patch adds a common helper for tearing down the device IOTLB shared
by vhost backends. It drops each virtqueue's IOTLB pointer and metadata
cache before freeing the old table.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index a0c1d54019aac..0861406f3246f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
[ ... ]
> @@ -2298,6 +2298,30 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *arg
>  }
>  EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
> =20
> +/* Caller must hold the device mutex. */
> +void vhost_clear_device_iotlb(struct vhost_dev *d)
> +{
> +	struct vhost_iotlb *iotlb;
> +	int i;
> +
> +	iotlb =3D d->iotlb;
> +	d->iotlb =3D NULL;
> +
> +	for (i =3D 0; i < d->nvqs; ++i) {

[Severity: High]
Does setting d->iotlb =3D NULL before acquiring vq->mutex create a race
condition with active vhost worker threads?

If a worker thread is concurrently executing vhost_copy_to_user() while
holding vq->mutex, it could call translate_desc(), which locklessly
reads dev->iotlb:

    struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;

Since d->iotlb was already set to NULL by vhost_clear_device_iotlb(),
the worker thread might mistakenly fall back to a potentially NULL
dev->umem.=20

This could bypass the IOTLB translation and expose the host to memory
corruption via forged GIOVAs or result in a NULL pointer dereference.

> +		struct vhost_virtqueue *vq =3D d->vqs[i];
> +
> +		mutex_lock(&vq->mutex);
> +		vq->iotlb =3D NULL;
> +		__vhost_vq_meta_reset(vq);
> +		mutex_unlock(&vq->mutex);
> +	}
> +
> +	vhost_clear_msg(d);
> +	vhost_iotlb_free(iotlb);
> +	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814072903.1249=
91-1-physicalmtea@gmail.com?part=3D1
