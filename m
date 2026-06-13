Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718973F44FF
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369866; cv=none; b=RhoyO1P6ZMOjW3HJHiMn9HQryFslZA3mSvkDxD0k5jnxV3T51JiW+Yo92zS0LHBw15LLbOQygCELw9RrguO676dQ2HWcnvLY/HD5GSEsZ8Y4HsoCkp18EhMyv2nrIaPtOplRyb1WWl3KHrVk8yNDi00P6xTJN+azCxOb9gkyNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369866; c=relaxed/simple;
	bh=uVx+O1zJyx9kU/RD794J/wVuxnmd6WtrXdey8iXy5Ko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eY2KkLSMU/V9xpL9DgDxCRmHqGi1RFeriav6qnqEN440hPWLa1bk/6nVv0OOy3hv2jsULSiacQiqITccFBTt1QKRqs9cXJUrLR1FZlIlxrM/oSZcFTlN6volmL5lvHxgdPpP+0Ow0lsHUcGoLbSHdO/cFimlqzet2yhSwTDlCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xuy707Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xuy707Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212911F00A3D;
	Sat, 13 Jun 2026 16:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369865;
	bh=QpKHuO1UHHoVJUpMm3Z6UQZUF2fTt/uko3GCpvBn2eI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xuy707UuXIb1WmoD0FrZb0CN9GJriiTmJkvZ/Jw4dHvkSjkwj8s8G1LTHKya8o6we
	 u9G4hRJtOWAIP9EltlmnkWIUoWjiAB9aAhBmna46S+kWkk2vUy1wD2kba1afeD5FIE
	 vhr+W5ufmY7eWIfGIbuxLsFqevz4WwwXkFM1wFpTrloRCnxChX6GAhpOXtKhQTuIzw
	 zOowhGIh6Ll5Ae0iDZLwXbiagLd65JP+o/zqvIrZXD/d8yy33slyi7jy9wqCLJneri
	 jmXSZwq1gZFcvP96w/fVjm9cSCBRbiUvu3xzqHsvAQjNLsB3I8Rgv1uLUSZX/MPGaf
	 GAQj4y45HA5ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:57:44 +0000
Message-Id: <20260613165745.212911F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Concurrent host network traffic can trigger a Use-After-Free o=
f `vhost_worker` during VHOST_RESET_OWNER.
- [High] Pending network work becomes permanently disabled if queued to a d=
estroyed worker during VHOST_RESET_OWNER.
- [Medium] Useless O(N) system-wide socket iteration in `vhost_vsock_reset_=
owner` causing dead code and lock contention.
--

commit fe82b486d339416d80c28b16f13b7f0d1014a742
Author: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

vhost/vsock: add VHOST_RESET_OWNER ioctl

This ioctl is needed for QEMU's CPR (checkpoint-restore) migration of
the guest with vhost-vsock device.  For this to work, we need to reset
the device ownership on the source side by calling RESET_OWNER, and then
claim it on the dest side by calling SET_OWNER.  We expect not to lose any
AF_VSOCK connection while this happens.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index b12221ce6faf2..e629886e5cf84 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c

[ ... ]

> @@ -894,6 +894,32 @@ static int vhost_vsock_set_features(struct vhost_vso=
ck *vsock, u64 features)
>  	return -EFAULT;
>  }
> =20
> +static int vhost_vsock_reset_owner(struct vhost_vsock *vsock)
> +{
> +	struct vhost_iotlb *umem;
> +	long err;
> +
> +	mutex_lock(&vsock->dev.mutex);
> +	err =3D vhost_dev_check_owner(&vsock->dev);
> +	if (err)
> +		goto done;
> +	umem =3D vhost_dev_reset_owner_prepare();
> +	if (!umem) {
> +		err =3D -ENOMEM;
> +		goto done;
> +	}
> +	/* Follows vhost_vsock_dev_release closely except for guest_cid drop */
> +	vsock_for_each_connected_socket(&vhost_transport.transport,
> +					vhost_vsock_reset_orphans);

[Severity: Medium]
Is this iteration necessary?

Unlike the release path, this ioctl deliberately keeps vsock->guest_cid
in vhost_vsock_hash to preserve connections across QEMU CPR.

Because the CID remains valid, when vhost_vsock_reset_orphans() iterates ov=
er
each system socket and calls:

  vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk))

it will successfully find the vsock and immediately return without performi=
ng
any cleanup.

Does this perform a useless system-wide traversal over all vsock connections
under the vsock_table_lock spinlock, unnecessarily wasting CPU cycles and
causing lock contention?

> +	vhost_vsock_drop_backends(vsock);
> +	vhost_vsock_flush(vsock);
> +	vhost_dev_stop(&vsock->dev);
> +	vhost_dev_reset_owner(&vsock->dev, umem);

[Severity: Critical]
Can concurrent host network traffic trigger a use-after-free of the
vhost_worker here?

Since vsock intentionally remains in vhost_vsock_hash to preserve connectio=
ns
across CPR, a concurrent thread sending a packet can still resolve the vsock
object.

If the network thread reads vq->worker under the RCU read lock in
vhost_vq_work_queue() just before vhost_dev_reset_owner() calls
vhost_workers_free(), could we see a sequence like this:

Thread 1 (network):
vhost_transport_send_pkt()
  vhost_vq_work_queue()
    worker =3D rcu_dereference(vq->worker);

Thread 2 (ioctl):
vhost_vsock_reset_owner()
  vhost_dev_reset_owner()
    vhost_dev_cleanup()
      vhost_workers_free()
        kfree(worker);

Thread 1:
    vhost_worker_queue(worker, work); // use-after-free

Since vhost_workers_free() frees the worker without waiting for an RCU grace
period via synchronize_rcu(), does this leave a window for the network
thread to dereference the freed worker?

[Severity: High]
Does this sequence permanently disable pending network work if queued to a
destroyed worker?

If vhost_transport_send_pkt() races with vhost_vsock_reset_owner(), it calls
vhost_vq_work_queue() which sets the VHOST_WORK_QUEUED flag:

  if (!test_and_set_bit(VHOST_WORK_QUEUED, &work->flags)) {
      ...
  }

If this happens right after vhost_vsock_flush() finishes, but before
vhost_workers_free() destroys the worker, the old worker thread is stopped
before it can process the list and clear the VHOST_WORK_QUEUED flag.

When the VM is resumed and a new worker is created, vhost_vsock_start() kic=
ks
the worker by calling:

  vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);

Because the VHOST_WORK_QUEUED flag is still set to 1 from the destroyed wor=
ker,
test_and_set_bit() returns true. Will the work be skipped instead of being
added to the new worker's list, causing packets in send_pkt_queue to
permanently stall?

> +done:
> +	mutex_unlock(&vsock->dev.mutex);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612165718.4335=
46-1-andrey.drobyshev@virtuozzo.com?part=3D2
