Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414C37419D
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369865; cv=none; b=DqPQsNqV2X41z50bu92w/e7y/dYQUdt1PS6BKKvMzui/CngVDUt/b5gSH06i5KTd1umEcnL8BmAjiRc9elH1gIpb8ucibNJkUvhy1SJLWx6nbNg95a5kunOjKrdrl3mdxUp7dTk8OOd4b2TTZgUkko+Jp7eNk47L14607hagjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369865; c=relaxed/simple;
	bh=px25azgNld7E17MCp8I2WlC/1wFwjIi1aWC8na/MqUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=toHClwM6IBpxQ13aBQVTGdc0yJwIhInZK6Y6zZBe6OIDH/u+nkeZuZivWWUe8ENcSjtgjlLg5jZqN6r82X21QR1JzqGm63SAtwXD4FUbYo5hHJA75noRYQoZa6hDlWytwWRssZflr1tWEPwLomK2ADMeqC3TPEd0KdPRgdqBCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL/ibwIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL/ibwIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7359A1F000E9;
	Sat, 13 Jun 2026 16:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369864;
	bh=QATNaGWSRwKP+aEIIwKXbWIFWf59joWoGuRfZxnQUn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QL/ibwIOjfYBP0u72Cq/rmVKAcaiDRN7cgh8SNqjuLI6gMjRa9FwhKiXZ+HaTmxN2
	 Etv22ujDfsh+Ju1KEatFEl5G+Kve4pjjlMv5+d0GFfFoUMhkdYv4N18BKl9qGwcXEU
	 lAfQY9zProTFGFoy4HQImv2OL5Z3FmGnZtK5SFYKTZ8PDoWLW7guPqqj9nO0yQSj80
	 lyT5SKhLR84lwNAur02z95MM9oZTjscpqXGqS2PHHiYcbTKnkG3kvX04OxpeznwQZW
	 YHHZHtuQ9GDsHMSQ55wJ8yUvIiHxPZOoE02FJe2bchiOMoRYDWdtHe2KeaT5T0rX/d
	 OGIHBpl0K5Otg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] vhost/vsock: re-scan TX virtqueue on device start
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Drobyshev" <andrey.drobyshev@virtuozzo.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
References: <20260612165718.433546-5-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 16:57:44 +0000
Message-Id: <20260613165744.7359A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Host memory allocation failure incorrectly triggers a fatal virtqu=
eue error and leaks descriptors, causing a guest vsock DoS.
- [High] TOCTOU race in `vhost_transport_send_pkt()` can erroneously drop p=
ackets during QEMU CPR live migration.
--

commit 917560a155f52870e04784955e886f79d44169bb
Author: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

vhost/vsock: re-scan TX virtqueue on device start

This commit addresses a deadlock during QEMU CPR live-update where a TX kick
is lost because the backend is temporarily NULL. It updates vhost_vsock_sta=
rt()
to queue a TX poll and rescan buffers enqueued while paused.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index bcaba36becd79..1fcfe71d18bec 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -655,6 +655,12 @@ static int vhost_vsock_start(struct vhost_vsock *vso=
ck)
>  	 */
>  	vhost_vq_work_queue(&vsock->vqs[VSOCK_VQ_RX], &vsock->send_pkt_work);
> =20
> +	/*
> +	 * Some packets might've also been queued in TX VQ.  Re-scan it here,
> +	 * mirroring the RX send-worker kick above.
> +	 */
> +	vhost_poll_queue(&vsock->vqs[VSOCK_VQ_TX].poll);
> +
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does this allocation failure handling
correctly manage the descriptor?

In vhost_vsock_handle_tx_kick(), if vhost_vsock_alloc_skb() fails due to
transient host memory pressure:

drivers/vhost/vsock.c:vhost_vsock_handle_tx_kick() {
        ...
		skb =3D vhost_vsock_alloc_skb(vq, out, in);
		if (!skb) {
			vq_err(vq, "Faulted on pkt\n");
			continue;
		}
        ...
}

It looks like this skips the vhost_add_used() call, triggering a device err=
or
via vq_err() and permanently leaking the descriptor.

Should a transient host memory allocation failure drop the packet and clean=
ly
return or discard the descriptor instead of breaking the virtqueue?


[Severity: High]
This isn't a bug introduced by this patch, but is there a race condition
during live migration in vhost_transport_send_pkt() that could drop packets?

Looking at vhost_transport_send_pkt():

drivers/vhost/vsock.c:vhost_transport_send_pkt() {
        ...
	if (unlikely(!data_race(vhost_vq_get_backend(&vsock->vqs[VSOCK_VQ_RX])))) {
		smp_rmb();	/* pairs with smp_wmb() in start/drop_backends */
		if (!READ_ONCE(vsock->cpr_paused)) {
			rcu_read_unlock();
			kfree_skb(skb);
			return -EHOSTUNREACH;
		}
	}
        ...
}

If a reader observes the backend is NULL, gets preempted, and then the writ=
er
in vhost_vsock_start() sets the backend to non-NULL and cpr_paused to false,
could the reader wake up and incorrectly conclude the device is permanently
uninitialized?

If this sequence occurs, it returns -EHOSTUNREACH and drops the packet. Wou=
ld
it be safer to re-verify the backend is still NULL after observing
cpr_paused =3D=3D false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612165718.4335=
46-1-andrey.drobyshev@virtuozzo.com?part=3D4
