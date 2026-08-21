Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF5423780
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299559; cv=none; b=EtYytTtv7tJ4DjbzBo/JFU4LDhPntAcsuC8NEAp12K/pJkUiNzMyaXBsFvsH+efIFBbY2MVFVfMC7sZBPqpVWyz5K54zYr2s0b1yZ+FDVvP6WwkfLTxA3g73ffxjNQT+AFWeS1Q3X54KJatAr/OCF4gBNg0gmish8T9f1bPRfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299559; c=relaxed/simple;
	bh=7kUmpYpaJKZ8KCJu8Dz1RkKvaOdEkyTZBmeZ4I8xcao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nuu3tdKPoAtgtjYrrHmKQQod7/JT59cCuLAMa7h3a0pwS0893A8NAcYI2Xwz/SerUXS/ob8bqoadfDkRO+QfPxLM8Nmy2eT/9yWqgtynCyLknOfOqOuEDTDw6/efEm1JriUbpxnLC7EttRXvhfr+aKRAr09SqjQqYf1c542EuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FajOPMym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FajOPMym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA21F00A3A;
	Fri, 21 Aug 2026 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787299558;
	bh=preWf2tPR4pf8WASxrFhqHTJVTaQNKJrQjZxaTd1084=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FajOPMymKm+eGTywZ0gwbG0siozGuWjNmhmw9RX6xzvtQmSQD4sznnDoR2Bd+N7j7
	 +teXHJFVq0d3rKf184lG8IRxdr7zkmC8OHMm2PN0g3Nzi8uicmGnaIEiN8UFGv0q68
	 piahl0HHdkWXKCq9ywR4/NjccPtxF9MGU0jWwxD8K62iwU5LNj9m7UW78mA8CoF93n
	 20EFJJ/hg1DFJReX4b+07AyNKFJSWhMKQq3VZ0ybSdm1FhR6txptFPQDQmvfoC+qDr
	 yCIGCoh+FuDY1HMEusq4v/9P5cUDC38vfVgU8ZjfLXqihwEjE62TToED/JIBoTrFe1
	 MpF33PBDrEijg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM is
 cleared
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260820080332.313933-4-physicalmtea@gmail.com>
References: <20260820080332.313933-1-physicalmtea@gmail.com>
 <20260820080332.313933-4-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:05:57 +0000
Message-Id: <20260821080558.5AEA21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Concurrent execution of vhost_clear_device_iotlb() and transla=
te_desc() causes the vhost worker thread to mistakenly translate IOVAs usin=
g the guest physical memory map (GPA map), leading to arbitrary guest memor=
y corruption.
--

--- Patch [3]: [PATCH v7 3/3] vhost/net: discard IOTLB when ACCESS_PLATFORM=
 is cleared ---
commit 4247ba53ba530a29217ab642534cab65e8a1846d
Author: Jia Jia <physicalmtea@gmail.com>
vhost/net: discard IOTLB when ACCESS_PLATFORM is cleared

This commit applies common device IOTLB teardown when userspace clears
VIRTIO_F_ACCESS_PLATFORM. This avoids rebuilding an existing IOTLB during
feature updates that keep it enabled, while requiring userspace to
reconfigure vring addresses for the new address mode.

Link: https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gma=
il.com/

> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 38d9c184082d0..4d9d7c2216ed5 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1696,6 +1696,8 @@ static int vhost_net_set_features(struct vhost_net =
*n, const u64 *features)
>  	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
>  		if (vhost_init_device_iotlb(&n->dev))
>  			goto out_unlock;
> +	} else {
> +		vhost_clear_device_iotlb(&n->dev);

[Severity: Critical]
Does this introduce a race condition with the vhost worker thread that
could lead to guest memory corruption?

When userspace clears VIRTIO_F_ACCESS_PLATFORM on a running device, this
code calls vhost_clear_device_iotlb() while the backend remains attached.
Looking at vhost_clear_device_iotlb() in drivers/vhost/vhost.c, it drops
the global device IOTLB pointer before taking the per-VQ mutex:

drivers/vhost/vhost.c:vhost_clear_device_iotlb() {
	...
	d->iotlb =3D NULL;

	for (i =3D 0; i < d->nvqs; ++i) {
		struct vhost_virtqueue *vq =3D d->vqs[i];

		mutex_lock(&vq->mutex);
		vq->iotlb =3D NULL;
	...
}

Concurrently, if the vhost worker thread is active, it will have acquired
vq->mutex and proceed to translate addresses. However, translate_desc()
evaluates the global dev->iotlb pointer rather than the protected
vq->iotlb pointer:

drivers/vhost/vhost.c:translate_desc() {
	...
	struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
	...
}

Since d->iotlb was cleared without the per-VQ mutex, the active worker
thread might observe dev->iotlb as NULL and incorrectly fall back to
dev->umem (the guest physical memory map).

Could this cause IOVAs to be mistakenly translated as GPAs, leading the
kernel to read or write network payloads to the wrong Host Virtual Addresse=
s?

>  	}
> =20
>  	for (i =3D 0; i < VHOST_NET_VQ_MAX; ++i) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820080332.3139=
33-1-physicalmtea@gmail.com?part=3D3
