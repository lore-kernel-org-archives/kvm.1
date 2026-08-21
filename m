Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43399424668
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299559; cv=none; b=nCPmc0S9IjYn/R+9C5Xhn+vQLWToW5i1rvLMCNRv/DN7qJ6HMfQY6eP+fjHGGV/5lia3juA4lCb2lAnQhuXe+bKpGAYL976M1f+9DORBp65U2N7DLhaTIAd3n0k116mrmIRIGa4eX8JfBV87zxsEFCk+I9AE7Q6fZUUM4KJhKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299559; c=relaxed/simple;
	bh=eKxqiVHocHMhMZbfh180IY3at4gahT2VHqZBaTrUUlA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVU3WwrmG6Y33uFk7V7TvXppwi9PryMQ2pBY4m1iISNL3HO1VqzkVD+qCAkFc392eofmFlduzn2JmJbPoCdaU4jSqL7s5RhkIBKPr9wWLdndohPcWUKgXQN3xXvNT3dllF5rsv3cM1iyY8r3yEn03/7C8xDhQiwDWKJ8CdyB4as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYh3+CUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYh3+CUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A911F000E9;
	Fri, 21 Aug 2026 08:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787299557;
	bh=oO+Xi+A6BDAVMWaSTpa9SRxz3BOVZfDa3jrW54YyEX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EYh3+CUtW3zjZjJyJGB29acZ70NNOgY7lLXeYMQ2xXw0pKK8WIUGAOlYi/rx6p4sh
	 iAgNxK6EEhDHGB4O+mo4tUpVBcEYTOdOsXPV2HLChMpW5BAii2omwo4I+iKwSkSwJ/
	 MV/DsOxELLCq9JhyiIDxDVy/R6PxeNqlKQbcS4cFyQ/BnQYO/l6nV0qvrwPR74No7O
	 Frc1BNL5aRhQodUfmx5kZVGjNWnkUpRobwAhG4tgJ96UzEZvFIZEA1E46oJfo16a3K
	 tb+ADbNqckBAdgd2QfozNah7RnLfP2IIZL849aDjo2BSkrkWojhIoZvmkV8hgzQwp+
	 ViuMi/Gq/F6Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB
 transitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260820080332.313933-2-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:05:57 +0000
Message-Id: <20260821080557.A6A911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition in vhost_clear_device_iotlb() causes NULL pointer d=
ereference or IOMMU bypass
--

--- Patch [1]: [PATCH v7 1/3] vhost: invalidate vring access on IOTLB trans=
itions ---
commit da0274e257afa43e8d844051613c8dcc1f9d744f
Author: Jia Jia <physicalmtea@gmail.com>

vhost: invalidate vring access on IOTLB transitions

When ACCESS_PLATFORM changes, the addresses cached in desc, avail, and
used change meaning with the address space. Clear the cached vring access
state when the device IOTLB is installed or removed so stale IOVAs cannot
be reused as direct userspace addresses.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 14637cff0bd46..31fff98000450 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
[ ... ]
> @@ -2287,11 +2301,48 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *arg
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

[Severity: High]
Does clearing d->iotlb here without holding vq->mutex introduce a race
condition with the vhost worker thread?

If a userspace process dynamically clears the VIRTIO_F_ACCESS_PLATFORM
feature, this function clears d->iotlb without synchronization against
concurrent vhost worker threads.

Meanwhile, an active worker thread holding vq->mutex might be calling
translate_desc():

drivers/vhost/vhost.c:translate_desc() {
    ...
    struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
    ...
}

Because there is no READ_ONCE() or other synchronization on dev->iotlb, cou=
ld
the compiler double-read dev->iotlb, observing a non-NULL value for the
condition but NULL for the assignment, leaving umem =3D NULL?

Alternatively, if dev->umem was never populated, reading dev->iotlb as NULL
also leaves umem as NULL.  The worker then calls vhost_iotlb_itree_first()
which dereferences umem->root, potentially causing a host kernel panic.

> +
> +	for (i =3D 0; i < d->nvqs; ++i) {
> +		struct vhost_virtqueue *vq =3D d->vqs[i];
> +
> +		mutex_lock(&vq->mutex);
> +		vq->iotlb =3D NULL;
> +		vhost_vq_invalidate_access(vq);
> +		mutex_unlock(&vq->mutex);
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820080332.3139=
33-1-physicalmtea@gmail.com?part=3D1
