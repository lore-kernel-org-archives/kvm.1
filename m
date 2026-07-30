Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F80F35F16B
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439065; cv=none; b=QDKRwxjxHdgVOOar0Db+UbPtQsa0jioodOerjDf1vVrWmJPkGrpenfts6kJ4R+gRXv44y0IV07Aubt6RaB2S3OQpm5f0Oz0iRlGqXJXGBqRLUd+0lbkw8GGs7PjThZd5jsYiSppC+qGr9poJ102F+M1oBS9kmdH7XBLt8Wd+EQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439065; c=relaxed/simple;
	bh=O3VLCigkZRqdSyeGJeShG1WEpuehRYXFqti2sTi3Ko8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uF4St0HhhgwH4wtsCkV17FuPyN9jjHh3iOgdU+o/FGO7J19Ly/5TlvF6wA044k+QEu6eEWsHLeRJZxb4RkmC4/hXTuMPQiXoBDnpnudqhoFkQcMS4HhaQPOln4KREJq4I5ec3Z/lu+So9RSYF/KYayAzXwqckSev9uToiKXB/vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2O3Rlwe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2O3Rlwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68921F000E9;
	Thu, 30 Jul 2026 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439063;
	bh=LBI/PmvjgBgLgVwfjYs9ZNOzWWMtHljixKJsJ+fLGgA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E2O3RlweAJPjJE5rC3PXM6J698URruPEjUrXKFa8tQEPRdg8Rw/2zuPS+2EKNI7Dx
	 enskVzuQ2FlP7vuAtsJO9Tkeks/9vTqJRglUtSPoXAIZQg5Z/1ByWvw0y9UNFnLLP5
	 hqdYKy3DnWRtiE/rJgFQj1t2eCX+eOsb7bbio+WV9dN7BPkHhtR5UVkMVJfrBStuXt
	 3fgc0/jwytS8xQcOBBUfTU9UzrOttldFzH02Yn4U0EOWQmpDll8nXoUDJqm0FLmWcS
	 /LpOFWGjh4NfVMDl3E2Z42kjiQ3lpFWwNXk0Bzrjw2gMNwZcaWmv5waxjO3uU1yRfs
	 3vN0kGZ6pVdQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue after
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
References: <20260729185831.3247971-1-bestswngs@gmail.com>
 <cover.1785352330.git.bestswngs@gmail.com>
 <f9c8c1d64cad9d262f305d02ffe164c2f900fadf.1785352330.git.bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 19:17:43 +0000
Message-Id: <20260730191743.A68921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect `flush_work` ordering in `virtio_vsock_remove()` allows =
`virtio_transport_rx_work` to execute after the `vsock` object has been fre=
ed.
--

--- Patch [2]: [PATCH v3 2/2] vsock/virtio: avoid refilling the RX queue af=
ter teardown ---
commit e28975cab51c80e977d0774ef653bc9c4660fff0
Author: Weiming Shi <bestswngs@gmail.com>

vsock/virtio: avoid refilling the RX queue after teardown

Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
made the RX worker jump to its common exit when rx_run is clear.  That
exit still refills the RX queue when the buffer count is low, so work
queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
have been deleted.

Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 57f2d6ec3ffc6..96c9fe8d357c6 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c

[ ... ]

> @@ -634,12 +635,12 @@ static void virtio_transport_rx_work(struct work_st=
ruct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
> =20
> -	vq =3D vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
> =20
>  	if (!vsock->rx_run)
> -		goto out;
> +		goto out_nofill;

[Severity: High]
This is a pre-existing issue, but I have a question about the workqueue
teardown logic that can still trigger a use-after-free for vsock.

In virtio_vsock_remove(), the workqueues are flushed in this order:

net/vmw_vsock/virtio_transport.c:virtio_vsock_remove() {
	...
	flush_work(&vsock->rx_work);
	flush_work(&vsock->tx_work);
	flush_work(&vsock->event_work);
	flush_work(&vsock->send_pkt_work);
	...
}

However, virtio_transport_send_pkt_work() can queue rx_work without holding
locks if restart_rx is true:

net/vmw_vsock/virtio_transport.c:virtio_transport_send_pkt_work() {
	...
out:
	mutex_unlock(&vsock->tx_lock);

	if (restart_rx)
		queue_work(virtio_vsock_workqueue, &vsock->rx_work);
}

If a worker executing virtio_transport_send_pkt_work() is preempted just
before calling queue_work(), and a concurrent virtio_vsock_remove() flushes
rx_work and then blocks flushing send_pkt_work, couldn't the preempted
worker then resume and queue a new rx_work?

This newly queued rx_work would be left pending after virtio_vsock_remove()
completes, causing a use-after-free when the vsock structure is freed.

Should virtio_vsock_remove() flush send_pkt_work before rx_work to prevent
this race?

> +
> +	vq =3D vsock->vqs[VSOCK_VQ_RX];
> =20
>  	do {
>  		virtqueue_disable_cb(vq);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785352330.gi=
t.bestswngs@gmail.com?part=3D2
