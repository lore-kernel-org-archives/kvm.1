Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38B53ABD8D
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895057; cv=none; b=GHQa1AUdLyDSjJfqI/wcZCFwc2SSpggpdb4YWLwmTfnSSxgWK3mbkoxoP2tX1Epm4uLll3/tgGBKbCwWliluoPjotw1DwQTKQriHnNk38Frp+WzdnKRXGsshWMBTztyqCrGC6saKxTR54eKjmXvIjLX+AtjiK6Hotdy8wBdZKsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895057; c=relaxed/simple;
	bh=4dg4aN5zIBQ01vy8bhcHcq199eZSsrkzK2+fuG8Hgdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A47b/b2HnL4gyt/yCHamA43apFdBHqm/TL7VxmNwmmSDnSUyorXnNi2S/Yj3O45yZPPPnvCgYTOXITP86SyIWNlpfvXTq8C82tzZGv9VLDPDTlOt+NRGhHautu8hvFnWBfusRKRFCymcHTJsF+DAm/B9a7cvKfFL2kSw2TTjf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqMC9amm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqMC9amm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8021F00A3E;
	Wed,  5 Aug 2026 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895056;
	bh=ZxIP/V2oKRY9O3BTpGFRJIfKd64VViT4u/2uJ4A4C/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bqMC9ammrQ0DRBbUDaA6Psrp8MbKw5hKowHrmBlzKYFJoKfG4ABnbB8T1abnOVOMN
	 m0f1YZe4U3Kl284V5dydEXYwZ+IrV2PvQrPBUgLsCe5pDWwWpmTtSkUo0bJIwii4VO
	 R/lLv7dV92yhVOLURHrLOqEhHkJWl+C9wo/scv/SCXmkg2/nLj23Ex2dl4lt/BiJ03
	 V7UBXvqcW7L1/zxRukNaB3w4VyMiouxixZ/lrby5r6pI1gIW4zanJVOoZxIJTg+/1B
	 n6iMJC2Qi3CcOXG/gQp1X1kSl2St1LfJ6MSzNLehOCyrw5JAA2g3s4ME7iJ29fcjMu
	 7rQKiEv9AHSng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v14 2/5] tun/tap: add ptr_ring consume helper
 with netdev queue wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260803183641.96882-3-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
 <20260803183641.96882-3-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 01:57:35 +0000
Message-Id: <20260805015736.3A8021F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vhost-net bypasses `tun_ring_consume()`, causing permanent TX qu=
eue stalls when `IFF_BACKPRESSURE` is used.
--

--- Patch [2]: [PATCH net-next v14 2/5] tun/tap: add ptr_ring consume helpe=
r with netdev queue wakeup ---
commit 751c5819e676787b1b9d745ec0ad8353ee77415e
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

tun/tap: add ptr_ring consume helper with netdev queue wakeup

This commit introduces tun_ring_consume() that wraps ptr_ring_consume() and
calls __tun_wake_queue(). The queue is woken up when the ring is half empty
or entirely empty to support traffic shaping with IFF_BACKPRESSURE.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 51e80000bd0ed..d49b6bfd104db 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
[ ... ]
> @@ -2116,13 +2171,61 @@ static ssize_t tun_put_user(struct tun_struct *tu=
n,
[ ... ]
> +static void *tun_ring_consume(struct tun_struct *tun, struct tun_file *t=
file)
> +{
> +	void *ptr;
> +
> +	spin_lock(&tfile->tx_ring.consumer_lock);
> +	ptr =3D __ptr_ring_consume(&tfile->tx_ring);
> +	if (ptr)
> +		__tun_wake_queue(tun, tfile, 1);
> +
> +	spin_unlock(&tfile->tx_ring.consumer_lock);
> +	return ptr;
> +}

[Severity: Medium]
Will vhost-net bypass this wrapper and cause permanent TX queue stalls when
IFF_BACKPRESSURE is enabled?

Looking at vhost_net_buf_produce() in drivers/vhost/net.c, vhost-net consum=
es
packets directly from the tun ring:

drivers/vhost/net.c:vhost_net_buf_produce() {
    ...
	rxq->tail =3D ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
					      VHOST_NET_BATCH);
    ...
}

Because vhost-net uses ptr_ring_consume_batched() directly, it bypasses
tun_ring_consume() and prevents __tun_wake_queue() from being called. This
leaves the stopped netdev queue permanently stalled.

While IFF_BACKPRESSURE is currently masked out of TUN_FEATURES in this comm=
it
(meaning it cannot be triggered by userspace today), this structural flaw in
the backpressure design will trigger unconditionally once the feature flag =
is
fully enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803183641.9688=
2-1-simon.schippers@tu-dortmund.de?part=3D2
