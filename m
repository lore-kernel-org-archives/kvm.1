Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71E22B8DF
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237536; cv=none; b=VPwLIFI+Qn82q9ZIO7r+Ty3vv6gbYeFUGoEHuMjPM3RZe3ijAG6sNMlUGMofwP5lIIZqMOCYLTOg8d7nOzPHdGiq9gRqPxagJClTZoJn1ha+y6eHOQHsSCSzDeEE066dgImSg0zDzugRO0TZYU2LF1bvWCUOoTw8S2V2gfoqZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237536; c=relaxed/simple;
	bh=dJZKj4Y5Mp/hdCAOMTmRM5msT+HJ3ixnEAyD8OjT+jI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WLXcRCrpp2Dm7Yte0Gb5DRBXZ5qpRGkIy11k561xXRNeaiVLM+GaizGwfZOSCYmRza9nTLOzsC6laKURrU6rBe1qjkDHsF27dfAxoVeBB9Y3U9tZm4JMaTtw62TWP72kSqRzocXCRegeMJW7yXvCf+FXOYXTh6s7XGVTuLGMR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THc5R3+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THc5R3+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6231F000E9;
	Tue, 23 Jun 2026 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782237535;
	bh=3MShGS2HoVryOPv1dqGkt+YLx8uqW/W9QBppRdCUtG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THc5R3+JZ+cJouTGw87coNUtVyOAGyk1uZ0b24aOcn5Tlx2hjq6xjP9MJHwk9nxuc
	 gXdBSbSblq3OEsEg2K/fvwld9gIL2JcMT4rp0xu5cRGyA9bn80664mB6fHaSSIsiP1
	 TnCkoCUsxGcBSm3XF2tx7eEwlW5NcqOUP4imeHY/70Y3Fdu11Bv4ViaPkIb81aatgX
	 WAyNfOY7GgVCHlpKJy7cU2GF+BRMSkquu7V48gR0H12ppMK8zGpnY5tC9kdomXBDim
	 SwbCe6jYe+Vmll7TS63F06FJu2QgMs4XThiQ+UxU5zoJEpW0tm52OQMrftA338EV35
	 Op2rCouKsVagg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] vhost/vsock: add VHOST_RESET_OWNER ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260622175808.508084-5-andrey.drobyshev@virtuozzo.com>
References: <20260622175808.508084-1-andrey.drobyshev@virtuozzo.com>
 <20260622175808.508084-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 17:58:55 +0000
Message-Id: <20260623175855.7A6231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing backend check in `vhost_transport_cancel_pkt()` leads to a=
 Use-After-Free of `vq->worker` and/or a permanently stuck `VHOST_WORK_QUEU=
ED` flag during `VHOST_RESET_OWNER`.
--

commit 1246364b7bca9df01b3f2315a384db215bb18763
Author: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

vhost/vsock: add VHOST_RESET_OWNER ioctl

This patch adds the VHOST_RESET_OWNER ioctl for QEMU CPR migration of a
guest with a vhost-vsock device. It fences the send path around the teardown
by adding a backend check in vhost_transport_send_pkt() to prevent using
the worker after it is freed.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 81d4f72097191..7d0146cd38d26 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c

[ ... ]

> @@ -903,6 +910,36 @@ static int vhost_vsock_set_features(struct vhost_vso=
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
> +	vhost_vsock_drop_backends(vsock);
> +
> +	/* Let in-flight send_pkt() callers stop touching the worker before the
> +	 * flush + free below. Pairs with the backend check in
> +	 * vhost_transport_send_pkt().
> +	 */
> +	synchronize_rcu();

[Severity: High]
Does vhost_transport_cancel_pkt() also need a backend check similar to the
one added in vhost_transport_send_pkt()?

Since VHOST_RESET_OWNER leaves the vsock hashed so connections survive,
a concurrent socket close can still look up the vsock and call
vhost_transport_cancel_pkt().

If this happens after the synchronize_rcu() call finishes,
vhost_transport_cancel_pkt() can conditionally call
vhost_poll_queue(&tx_vq->poll). This unconditionally queues work without
checking if the backend is alive, which dereferences vq->worker.

Because vhost_workers_free() frees the worker synchronously via kfree()
during teardown, could this lead to a use-after-free of the worker
or a permanently stuck VHOST_WORK_QUEUED flag?

> +
> +	vhost_vsock_flush(vsock);
> +	vhost_dev_stop(&vsock->dev);
> +	vhost_dev_reset_owner(&vsock->dev, umem);
> +done:
> +	mutex_unlock(&vsock->dev.mutex);
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622175808.5080=
84-1-andrey.drobyshev@virtuozzo.com?part=3D4
