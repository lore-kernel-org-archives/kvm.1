Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A54B3C3F48
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786778977; cv=none; b=r/Qm6zYVpVL4Rxbxj+3/p7uOm+4RkUAefko+PL6Abxos7AY+5AtVuljaNklfyC7iNeDEHLlkJvuG/96nEAaggnj3aet7Xno+966itjfzsrBQJVOeFmeZFOmw1MGZl0uHctN/OQo+wU8d2SHiqdNAZOIKwxmzFRrYA7kjGRs8py8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786778977; c=relaxed/simple;
	bh=tUpc52NXREPkcgOQbXnU8F5jJji0y4IDy9JamqTu+K8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtml/TBPdfFY75s7IMAA2VH0Kr1D3Q3tMGgdD/USara/v1tVttHfFXjdNQybhs+OLVslc2UFFZcf5qh7uAgYoFhfkad7RzwAt4QRhb3fmQM3Uu1nPh7a81qPN6TzZPttZWqGes6vL87Fd6hTnyF6W7xoGggFCbJOyTVw4/pA/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Odvk8OLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Odvk8OLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5831F00A3A;
	Sat, 15 Aug 2026 07:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786778976;
	bh=uS9Gld0DStx3OryVFN7Bx94svooescADcS1Sj5B1vnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Odvk8OLV0XYVkj4d6EtiG+VzmHR4AnZszp1IwkIMnRA7gDZFgzhnfbvvTKA+gTgO7
	 Jo+yo65qnO+X7TLxVVFxueoNLFQfhRnMB/KSZT/fh4OIPHz1bvaFH1SQLXZqTgtQbK
	 7yf+HDxsPQjvdgC06jYnfZgx1ZzSs9iC0+VfGlBNE3lhuXe8GUxI5bc4yzYgNaHShN
	 Q8U94rAgwvdSTy3ElvBBUM8QnHLvuXX6Dg55rVUUmosmcQ9KfnebuThLYFRxdWKXJG
	 R5U3aTonut0DE5TLg8tJigXrC3mWloKHsklyJ0pjTyCY02aDebblQBzZTVbHPhxWfR
	 PvSKJcg6ygGhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260814072903.124991-3-physicalmtea@gmail.com>
References: <20260814072903.124991-1-physicalmtea@gmail.com>
 <20260814072903.124991-3-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 07:29:35 +0000
Message-Id: <20260815072935.DA5831F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Arbitrary kernel write and privilege escalation due to bypasse=
d `access_ok()` bounds checking when VIRTIO_F_ACCESS_PLATFORM is cleared dy=
namically.
- [High] Data race causing NULL pointer dereference in `translate_desc()` d=
ue to lockless `dev->iotlb` teardown.

Pre-existing issues:
- [High] The vhost-net subsystem suffers from the exact same bug that this =
patch fixes in vhost_vsock, but `vhost_net_set_features()` was not updated.
--

--- Patch [2]: [PATCH v4 2/3] vhost/vsock: discard IOTLB when ACCESS_PLATFO=
RM is cleared ---
commit e884f4b90201c9e0d904641890e2f9e4ea704c9a
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared

This commit addresses an issue in vhost_vsock_set_features where the device
iotlb remains attached when userspace clears VIRTIO_F_ACCESS_PLATFORM. It
introduces a call to vhost_clear_device_iotlb to detach the iotlb and clear
the metadata cache for each virtqueue. This prevents descriptors from using
stale translations installed prior to the feature change.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 86f25ff80722d..a18fe1335349b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
[ ... ]
> @@ -882,6 +882,10 @@ static int vhost_vsock_set_features(struct vhost_vso=
ck *vsock, u64 features)
>  		goto err;
>  	}
> =20
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb)
> +		vhost_clear_device_iotlb(&vsock->dev);

[Severity: Critical]
If userspace clears the VIRTIO_F_ACCESS_PLATFORM feature while the device is
running, can this allow arbitrary writes to host kernel memory?

When VIRTIO_F_ACCESS_PLATFORM is enabled, vq_access_ok() intentionally
returns true without validating addresses, deferring validation to the
iotlb.

If userspace provides arbitrary kernel addresses via VHOST_SET_VRING_ADDR,
starts the device, and then dynamically clears the feature,
vhost_clear_device_iotlb() sets vq->iotlb to NULL on the fly.

Since the existing vring addresses are never re-validated, a concurrent
worker thread calling vhost_put_used() -> vhost_copy_to_user() will
observe !vq->iotlb and fall back to __copy_to_user().

Because __copy_to_user() omits bounds checking, it will write to the
previously configured unvalidated kernel addresses.

Should the vring addresses be re-validated, or the device stopped, before
dropping the iotlb?

[Severity: High]
Could clearing the iotlb here create a data race with concurrent worker
threads?

Looking at vhost_clear_device_iotlb() in drivers/vhost/vhost.c, it
locklessly sets d->iotlb to NULL before acquiring vq->mutex for the
virtqueues:

drivers/vhost/vhost.c:vhost_clear_device_iotlb() {
    iotlb =3D d->iotlb;
    d->iotlb =3D NULL;

    for (i =3D 0; i < d->nvqs; ++i) {
        struct vhost_virtqueue *vq =3D d->vqs[i];
        mutex_lock(&vq->mutex);
        ...
}

If a worker thread is concurrently executing vhost_copy_to_user() ->
translate_desc(), it holds vq->mutex. The ioctl thread will block on
the mutex but has already cleared d->iotlb locklessly.

In translate_desc(), the code evaluates the iotlb pointer:

drivers/vhost/vhost.c:translate_desc() {
    ...
    struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
    ...
}

It observes dev->iotlb as NULL and falls back to dev->umem. Since
dev->umem is NULL when using an iotlb, passing umem to
vhost_iotlb_itree_first() will unconditionally dereference iotlb->root,
crashing the host kernel.

Would it be safer to clear d->iotlb after the virtqueues are quiesced?

[Severity: High]
This is a pre-existing issue, but is vhost_net_set_features() in
drivers/vhost/net.c missing the exact same cleanup introduced here?

When userspace clears VIRTIO_F_ACCESS_PLATFORM via the
VHOST_SET_FEATURES ioctl on a vhost-net device, n->dev.iotlb is left
attached. This completely misses the newly introduced
vhost_clear_device_iotlb() cleanup.

Should the identical fix be applied to vhost-net to prevent memory
isolation bypasses via stale translation entries?

> +
>  	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814072903.1249=
91-1-physicalmtea@gmail.com?part=3D2
