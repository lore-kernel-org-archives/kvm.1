Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B990634BA42
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785534035; cv=none; b=raAbWB1+n2p8yjhKRJqws0UUZ9quG5ykUT4o0CvaEnXd4Z1vkRGLuoUrE3KJkOb1di5yjG3RN7zwVFZc3fyPMbu+XNTJZ8UH93fTmWRpPybZcHmBnO8GyQSGcYj2XXMLCX38xS2nH/AreqjvknBOGPGk2orssQwNNyoM3s4Jwos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785534035; c=relaxed/simple;
	bh=BYd/CsxkHI/N8BhTkG62vFSX36773eqe0Cd2UNwFDb8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+5in84eJ16Y/CGnH97+uWch7M0S0Tl/Larqn8r94HJsEmBkJq/PERM9pvMtQ7C4C1mJyJG5wkZROBo98CmZNiQ3lJQckf1hZwUOk4unFBO738kKiySwNIHbH/IB/aeXtQQOTG8Sw9F1qV9urZ5+vO8wOFA/bjFiqAiHb4GyhnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtYEa/PM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtYEa/PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415AC1F00ACA;
	Fri, 31 Jul 2026 21:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785534034;
	bh=JesnD1pz0ilAiH6tiDanTJC6XZRUmZCg5XkeF4q4TvU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dtYEa/PMUKE3WtmB2xAyoe/eLnav5vnWMVG9mZhO9yifgKVsxn4LEj9v7VcY9/Qdg
	 O7R0OwBgns6dCHfX/DFQ/1rdddyC4uH6mzNrBbKBrmpc1+7NtS6yw0HX2UvPVyHAWL
	 GaAjYHWOpOfnBsF7qYRF35kU7ZFpD0vRgN31NPOfZYgibGKBuecetNM+GtU5E9KlQs
	 W1M64Gw78SEwHPk4qfGfdktEkkdRnWTE6yfVYN6ZT98CDxk4fzisESl0rJlcnQDwvY
	 ZdrDYAYsQLRK6v+jvn768QuvkvEEc3AGp1n4VVW5hKfKR6FCx4EEM7ynerQ1E/0k5T
	 l1cxz8nGo5DXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v13 2/5] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260730213639.726381-3-simon.schippers@tu-dortmund.de>
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
 <20260730213639.726381-3-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:40:33 +0000
Message-Id: <20260731214034.415AC1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] vhost-net bypasses the new queue wakeup logic (`tun_ring_consume`)=
, leading to a permanent TX queue stall when IFF_BACKPRESSURE is used.

Pre-existing issues:
- [High] A structural flaw in `tun_set_iff` allows changing a non-multiqueu=
e persistent TUN device into a multiqueue device, leading to out-of-bounds =
accesses on the `dev->_tx` array via the newly introduced `__tun_wake_queue=
`.
--

--- Patch [2]: [PATCH net-next v13 2/5] tun/tap: add ptr_ring consume helpe=
r with netdev queue wakeup ---
commit 537cb0b1726915d53bc505e79f9dac64d03106a9
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

tun/tap: add ptr_ring consume helper with netdev queue wakeup

Introduce tun_ring_consume() that wraps ptr_ring_consume() and calls
__tun_wake_queue(). The latter wakes the stopped netdev subqueue once
half of the ring capacity has been consumed, tracked via the new
cons_cnt field in tun_file.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ea8573efb8489..d9db6d2e4c56a 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -2117,13 +2142,50 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
>  	return total;
>  }
> =20
> -static void *tun_ring_recv(struct tun_file *tfile, int noblock, int *err)
> +/* Callers must hold ring.consumer_lock */
> +static void __tun_wake_queue(struct tun_struct *tun,
> +			     struct tun_file *tfile, int consumed)
> +{
> +	struct netdev_queue *txq;
> +
> +	if (!(tun->flags & IFF_BACKPRESSURE))
> +		return;
> +
> +	txq =3D netdev_get_tx_queue(tun->dev, tfile->queue_index);

[Severity: High]
This is a pre-existing issue, but can this lead to an out-of-bounds access
on the dev->_tx array?

If a persistent TUN device is initially created without IFF_MULTI_QUEUE, the
underlying net_device is allocated with only 1 TX queue. If the file
descriptor is closed and TUNSETIFF is called again with IFF_MULTI_QUEUE
enabled, tun_set_iff() allows the change but the net_device still only has
a single queue.

When a second file descriptor is attached, it receives a queue_index of 1.
Will this cause netdev_get_tx_queue() to access dev->_tx[1], resulting in
a heap out-of-bounds access when evaluated here?

> +
> +	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
> +	smp_mb();
> +	if (netif_tx_queue_stopped(txq)) {
> +		tfile->cons_cnt +=3D consumed;
> +		if (tfile->cons_cnt >=3D tfile->tx_ring.size / 2 ||
> +		    __ptr_ring_empty(&tfile->tx_ring)) {
> +			netif_tx_wake_queue(txq);
> +			tfile->cons_cnt =3D 0;
> +		}
> +	}
> +}
> +
> +static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *t=
file)
> +{
> +	void *ptr;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr =3D __ptr_ring_consume(&tfile->tx_ring);
> +	if (ptr)
> +		__tun_wake_queue(tun, tfile, 1);

[Severity: High]
Will this cause a permanent TX queue stall when IFF_BACKPRESSURE is used
with vhost-net?

vhost-net directly accesses the transmit ring via tun_get_tx_ring() and
consumes packets natively, completely bypassing tun_ring_recv() and
tun_ring_consume().

Since the queue wakeup logic is exclusively placed here inside
tun_ring_consume(), does this mean the netdev subqueue will never be woken
up when vhost-net is consuming the packets?

> +
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +	return ptr;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730213639.7263=
81-1-simon.schippers@tu-dortmund.de?part=3D2
