Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610982D7DD7
	for <kvm@vger.kernel.org>; Sat, 22 Aug 2026 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390511; cv=none; b=RG/Otm+xS58VCMhkYB41IfUpgmBLJYu9fv2JGbpQS5SjcSNRq5Onkza5pyYGm1aL8Hkl0HKbQN5aiA69ctbZeeViLEPIjWoKQ3BjC7/EznEMS/agWdLzbOqO/OtVgsEu6/XdTnAHQp2aoGoNy2TKl9VVBmhr8OjyZZs/s6F+j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390511; c=relaxed/simple;
	bh=Nwl3NJ5VLelJPc10R28/98BnrHsaGC4VibfekGp/awY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j7ARuptbUdnNz/Q9fETPN9epyd5OIua2qLA+rDTbLXSHY7Jp4dS1k/m5zUV1YiaivfirrrsaKAbGidYDTLrN9vJQSih15tICrk/XUes0OdGOQuNhQF+/kaTc1vMFN9BqL/HKEU5WdVIUyewNWU/yju2ukf6vny1qxqikFmJk32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq2IE0lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq2IE0lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85491F000E9;
	Sat, 22 Aug 2026 09:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787390509;
	bh=Df3N/F9PSLeINUKzvYfK/zOoGVyOrF/yh60AlMkwVa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pq2IE0lqxnMclg16S8GOooG0dwYmDM5FNgdW+vH+FvbeoQzsZtG+KIsBgWhB0BfkV
	 T6KK6Tb/v4pT5GWghxL7wJShRVyBmDzjH042T/g4ORoryikm05YYBJv/9+9QLiR7ek
	 /xJtcTlthTiAyU1SVUZE3twv4/uGCPTzE4evzJ/NC2OkppXjZ/JTuWYinZeZzYuo6x
	 XMz4F4csadRfw7Tu9exxLDEN2ZT/rq/km0AUzLJaRBcruLXHDICiBeqkCz7STDo/Ui
	 y0ekyjIj5M9GxeKTN36y3d+rCVyQ0EKWei+X0yfR0bTR9t4sia3QC+nTFZoiRA9qkW
	 IX3JARCkydizw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] vhost: invalidate vring access on IOTLB transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260821092108.334318-1-physicalmtea@gmail.com>
References: <20260821092108.334318-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:21:49 +0000
Message-Id: <20260822092149.B85491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Concurrent execution of `vhost_clear_device_iotlb()` and a vho=
st worker thread calling `translate_desc()` results in a NULL pointer deref=
erence or arbitrary host memory access due to lockless clearing of `dev->io=
tlb`.
--

--- Patch [1]: [PATCH v8] vhost: invalidate vring access on IOTLB transitio=
ns ---
commit 601cfcb65f9457e49ce60311ed18a7ca3496a8ba
Author: Jia Jia <physicalmtea@gmail.com>

vhost: invalidate vring access on IOTLB transitions

This commit introduces a helper to clear the device IOTLB when the
VIRTIO_F_ACCESS_PLATFORM feature is cleared. It drops the device-wide
view first and then drops the per-VQ views under their respective mutexes.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
>
[ ... ]
>
> +/* Caller must hold the device mutex. */
> +void vhost_clear_device_iotlb(struct vhost_dev *d)
> +{
> +	struct vhost_iotlb *iotlb;
> +	int i;
> +
> +	iotlb =3D d->iotlb;
> +	if (!iotlb)
> +		return;
> +
> +	/*
> +	 * Drop the device-wide view first.  Each VQ then drops its
> +	 * per-VQ view and its cached ring access under its own mutex.
> +	 * Keep the old table alive until every VQ has completed this
> +	 * handoff, since a worker may still be using it while waiting
> +	 * for its VQ mutex.
> +	 */
> +	d->iotlb =3D NULL;

[Severity: Critical]
Could setting d->iotlb =3D NULL here race with a running vhost worker threa=
d?

While this update is protected by dev->mutex, it does not hold vq->mutex.
If a worker thread is concurrently calling translate_desc(), it evaluates
the device IOTLB locklessly:

drivers/vhost/vhost.c:translate_desc() {
    ...
    struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
    ...
}

Since dev->iotlb is cleared without vq->mutex, could the worker erroneously
fall back to dev->umem?

If dev->umem is NULL, this looks like it could trigger a NULL pointer
dereference when accessing umem->root. If dev->umem is populated, could
it map GIOVAs using the GPA table and lead to arbitrary host memory access?

> +
> +	for (i =3D 0; i < d->nvqs; ++i) {
> +		struct vhost_virtqueue *vq =3D d->vqs[i];
> +
> +		mutex_lock(&vq->mutex);
> +		vq->iotlb =3D NULL;
> +		vhost_vq_invalidate_access(vq);
> +		mutex_unlock(&vq->mutex);
> +	}
> +
> +	vhost_clear_msg(d);
> +	vhost_iotlb_free(iotlb);
> +	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
> +}
> +EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821092108.3343=
18-1-physicalmtea@gmail.com?part=3D1
