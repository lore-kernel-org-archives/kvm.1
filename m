Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D15377EBA
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211105; cv=none; b=pGidWcOzY7cWxBqAYJBdDdJiQ/jZTjcMUU1mDTQF4ooCnaHMjQHHo8YHePZO4mWL1mCL2REVLi8+IMp5S3n9+G9xbQBi3V5ooXdN1tpcn98+/VxFYz5mHgYbIbrwIzwQ/N+zzYCPrMAmThaEYIk9qAF5bFb92avg1KNcUgJM2Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211105; c=relaxed/simple;
	bh=FeLJKfyKVvxcJl1Tr+USSUCHl+JDyYl+zGjEauuecFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O4JXhDZ0/tkXB2S9Ejb4DdDqoyDoQBmEqD69MOTaL2wvNw+DUKSE3VXHQuYihSOm8YfxXyuiEauenqBJXVF5IEVKuRlwoaAG+yzjTryRY6Fc9AoHOKPyZFFPOqo3Y7er0BIakHAr8DScUhVqEQKzjKfWGbiObkMLU+SCc6HjhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJpoWou0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJpoWou0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC051F000E9;
	Tue, 28 Jul 2026 03:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211103;
	bh=VUY3OtPrDjV2vDFTVd3tvcDHPkpWj/qE2a6d5m9vWoQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VJpoWou0J+yYRoH0m3OKobdsMkLYtB1YTYhvcYcQEVPohSkEr1k8Fbq3YdfkchHuS
	 VrRb6N1g46h9F+WFU6LvbxDTMDjJ1wpZb8ZTfFuNrGI47TpYB7GmIr10E3fcXYWuNB
	 4WbVeRy7GZRkN/iTQP8P+Q7SsU7qUWNEFTMzkB1Q8vap/vcd3oC8DoQE+/6gtjxpzS
	 6DFKzhDQ9unS21E0GkwIYNRAvKmy+FdDo5ofTtqm3YRcBsnSriNdfF8v9N++66it6E
	 zyhAhkYeK5+aNs1heh7l5NGe2Kr6Xu3L9nnYXKIdd6+D7EPjcs9UNOrw1wZVHIJWwa
	 fhbqIyyeLnadQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 03:58:23 +0000
Message-Id: <20260728035823.AFC051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect flush_work() ordering in virtio_vsock_remove() allows rx=
_work to be queued by a delayed send_pkt_work after rx_work has already bee=
n flushed, leading to a use-after-free when vsock is destroyed.
--

--- Patch [1]: [PATCH] vsock/virtio: prevent workers from using deleted vir=
tqueues ---
commit fac9b600b273994b7593c604a6d3d0352d8dbee3
Author: Weiming Shi <bestswngs@gmail.com>

vsock/virtio: prevent workers from using deleted virtqueues

The RX, TX and event workers read their virtqueue pointers before taking
the mutex that protects the queue and its run flag. This patch reads each
worker's virtqueue under its mutex after confirming the queue is running,
preventing use-after-free of deleted virtqueues.

Cc: stable@vger.kernel.org

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 57f2d6ec3ffc6..79cf19f589439 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
[ ... ]
> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_stru=
ct *work)
>  	} while (!virtqueue_enable_cb(vq));
> =20
>  out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +	if (vsock->rx_run &&
> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  	mutex_unlock(&vsock->rx_lock);
>  }

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk in
virtio_vsock_remove() due to the flush_work() ordering?

In virtio_vsock_remove(), the flush sequence drains rx_work before
send_pkt_work:

    flush_work(&vsock->rx_work);
    flush_work(&vsock->tx_work);
    flush_work(&vsock->event_work);
    flush_work(&vsock->send_pkt_work);
    ...
    kfree(vsock);

Meanwhile, virtio_transport_send_pkt_work() can queue rx_work outside
the tx_lock:

out:
    mutex_unlock(&vsock->tx_lock);

    if (restart_rx)
        queue_work(virtio_vsock_workqueue, &vsock->rx_work);

If virtio_vsock_remove() flushes rx_work (which returns immediately if it
has not been queued yet), and then blocks waiting on send_pkt_work to finis=
h,
could send_pkt_work queue rx_work just before completing?

This would leave rx_work pending in the workqueue after virtio_vsock_remove=
()
frees the vsock object, leading to memory corruption when the work executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727035804.1860=
862-1-bestswngs@gmail.com?part=3D1
