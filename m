Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FD3DDDD1
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495415; cv=none; b=kzS4PjEXDH/20vn7tP2g4Hq/acq+t6Nlv1nj16bPleEkRD9qXMpXMl3YQO6e17xJGw0HJKgbB1BxIa7PKWhIE26dI9jrlwCzbOkQRMF07THDV6QcB4PVfswWmpMVbq/Aachj4AYRZGHAeiUysLncV6ddcbZ1W6eNH1WnpvR4Sg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495415; c=relaxed/simple;
	bh=PeRYAqus2+M6JWJAuNkFNN/44zcCIlKi1Injq8YFCrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bYzTwunaqvt3wbVSHJhNcaICnCxXMBJ+OuCw5yvRHb7C6tkNBk8EgoLmk+YVyWVCPpHURC753DWGU16oHoSsb8y0DOnT1x65qahVhaZBxWXhIWfU9rywloF4DuWQC4/STF05rxbyRNX9ssOquQcjnYNvwFqDHk3wdD3OiCeVmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DszXdtFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DszXdtFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9B41F000E9;
	Fri, 31 Jul 2026 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785495412;
	bh=Ah1J5E0MOUZ/UorHgO4eNX40THAnw3tFZq5EQ6ZB7xE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DszXdtFIcH2wxM6omk5MC/cbRROOHR+c4DekiInVZDKElbHYgBF0PxdgftOgjMZyi
	 DtsHGvpURyK7Je/oifZgv1GXG+d5hbk1XaOErLE/Hct+nEaZG9ZrcNtYV0fwozyWxe
	 nRO8kj+VOc15sI+f2jLVCSz5R5GGQg+rm+KKAvovXAfG+zV/U1Sc1HzXIzVtH6FaNJ
	 gGRW3cesWNyhw1OJtxP61HrGLhqXRWbxm2JUdU/rATbdZOPAUgHKRTlT41W0ZkiTpk
	 4C67GbcDOMHnb5FOQaalpXjHZCwNvKGBmvohsYxn4DHhj9edKccCjOvbslJsfUdxzR
	 uRQj472BePg4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFORM
 is cleared
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260731103414.1746316-2-physicalmtea@gmail.com>
References: <20260730104857-mutt-send-email-mst@kernel.org>
 <20260731103414.1746316-1-physicalmtea@gmail.com>
 <20260731103414.1746316-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 10:56:51 +0000
Message-Id: <20260731105651.CE9B41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A NULL pointer dereference occurs in translate_desc() if both =
dev->iotlb and dev->umem are NULL when a descriptor is processed.
--

--- Patch [1]: [PATCH v2 1/2] vhost/vsock: discard IOTLB when ACCESS_PLATFO=
RM is cleared ---
commit 711b531d8532907f465c4af9ee082250c352dc13
Author: Jia Jia <physicalmtea@gmail.com>

vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared

This patch detaches the IOTLB before acknowledging a feature mask without
ACCESS_PLATFORM to prevent stale translations. It clears the device and
virtqueue IOTLB pointers while holding virtqueue mutexes to ensure kick
handlers do not observe mixed translation states.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 9aaab6bb8061c..562b9e139a76f 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -851,6 +851,34 @@ static int vhost_vsock_set_cid(struct vhost_vsock *v=
sock, u64 guest_cid)
>  	return 0;
>  }
> =20
> +/* Caller must hold the device mutex. */
> +static void vhost_vsock_clear_iotlb(struct vhost_vsock *vsock, u64 featu=
res)
> +{
> +	struct vhost_iotlb *iotlb;
> +	struct vhost_virtqueue *vq;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++)
> +		mutex_lock_nested(&vsock->vqs[i].mutex, i);
> +
> +	iotlb =3D vsock->dev.iotlb;
> +	vsock->dev.iotlb =3D NULL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vsock->vqs); i++) {
> +		vq =3D &vsock->vqs[i];
> +		vq->iotlb =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but by clearing dev->iotlb and vq->iotlb to
NULL here, does this expose a NULL pointer dereference in translate_desc()
if dev->umem was never initialized?

If userspace configures the vrings and kicks the virtqueue without ever
calling VHOST_SET_MEM_TABLE, dev->umem remains NULL. When
vhost_vsock_clear_iotlb() clears dev->iotlb, the next descriptor
translation could trigger this path:

drivers/vhost/vhost.c:translate_desc() {
	...
	struct vhost_iotlb *umem =3D dev->iotlb ? dev->iotlb : dev->umem;
	...
	while ((u64)len > s) {
		...
		map =3D vhost_iotlb_itree_first(umem, addr, last);

drivers/vhost/iotlb.c:vhost_iotlb_itree_first() {
	return vhost_iotlb_itree_iter_first(&iotlb->root, start, last);
}

Because umem is NULL, taking the address of iotlb->root passes NULL to the
interval tree iterator, which would cause a page fault when dereferenced.

Can a malicious guest or unprivileged userspace process trigger this by
negotiating VIRTIO_F_ACCESS_PLATFORM, avoiding VHOST_SET_MEM_TABLE, and
then clearing the feature bit dynamically?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731103414.1746=
316-1-physicalmtea@gmail.com?part=3D1
