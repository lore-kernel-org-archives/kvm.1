Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777593AB294
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317214; cv=none; b=Zxw94huq8ZVZKTDb7S8O4T6TTL3YH104YFlK3cGF/EWFqXUrGXU8NTRYPpTvVIz3y25eYHOPi+1z2I3onqqRj0hrqG/kkhVz6taot+UcZZXv7leQ4cke8+HYsIplUasmgVE9Qvi1XP2sd4smr6tF3VU12C2JJa6Yc1tuY2TKuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317214; c=relaxed/simple;
	bh=lAiSdgLH/UQAMX8px/AsCDtcxYYEjx31tzWUWXyQKio=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=asnwvq1gWXpBLR3aqrSWHAuVwBE0OyFq7IJBEj0K4ab0LRCXUfrH1YQFyJw/6LrrPw9txPcgSzUpdokebdwG0yBdGfaexNRLOeBOepLgWKU2H6eHrYsgR3EoGzhu+j+ime83Ynqkvf+5A6zh1QkPIvx6oTwPMrbC7rZjtxlV6qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDLakvoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDLakvoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50E41F00A3A;
	Wed, 29 Jul 2026 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785317213;
	bh=eyktFMtjXy9p0+UXHWQDLosQ6cIwGcFuNvS4uDI72/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZDLakvoCpQBYrznBSPUx0RoPUIEgKTddAJw1bswuvq50EYYInrPATV/MIG1DfgEz9
	 wLsFf6kfLuOOugR1Wsm3TariQIioBRPo7rFQKOGYQQlWvxiWxeYMQUHinMkiG/zpT7
	 7V4nrt918ZZn05zgwj++KrUI7Wz2X0PuFTRxoqb5oLXPkZGgdxLdMAGlNShYiFjVG2
	 8W7J9R9pKDu8N5vCtiXVtQ5iKp2L6+hZgwZ7DHrBlPO2DUUBXGKm1G2Xo2/ZFvsjmY
	 /IbkcH5oKfWYAsFoSBvd3IWKK0isInMdyHeyR3UpVDbQQwZmohfQGc2RMTA+9XVW+G
	 Q99psouqztdVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/4] Revert "tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Schippers" <simon.schippers@tu-dortmund.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728092240.250257-2-simon.schippers@tu-dortmund.de>
References: <20260728092240.250257-1-simon.schippers@tu-dortmund.de>
 <20260728092240.250257-2-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 09:26:52 +0000
Message-Id: <20260729092652.C50E41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete Revert / Orphaned Memory Barrier
--

--- Patch [1]: [PATCH net 1/4] Revert "tun/tap & vhost-net: avoid ptr_ring =
tail-drop when a qdisc is present" ---
commit 18e68b71511b6b4155def5921c5f149c1b6e74e9
Author: Simon Schippers <simon.schippers@tu-dortmund.de>

Revert "tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is prese=
nt"

This commit reverts a previous change that stopped the netdev queue when the
ptr_ring is full. It goes back to dropping packets instead, resolving a rep=
orted
performance regression in a multicast testcase.

Link: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index ffbe6f13fb1fa..ec5573f545af6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
[ ... ]
> @@ -1073,33 +1072,13 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> =20
>  	nf_reset_ct(skb);
> =20
> -	queue =3D netdev_get_tx_queue(dev, txq);
> -
> -	spin_lock(&tfile->tx_ring.producer_lock);
> -	ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> -	if (!qdisc_txq_has_no_queue(queue) &&
> -	    __ptr_ring_check_produce(&tfile->tx_ring) =3D=3D -ENOSPC) {
> -		netif_tx_stop_queue(queue);
> -		/* Paired with smp_mb() in __tun_wake_queue() */
> -		smp_mb__after_atomic();

[Severity: Medium]
Does this revert leave an orphaned memory barrier in __tun_wake_queue()?

Since the producer-side queue stopping logic and smp_mb__after_atomic() were
removed here in tun_net_xmit(), the consumer-side logic in __tun_wake_queue=
()
now executes an unconditional full memory barrier on every consumed packet:

drivers/net/tun.c:__tun_wake_queue() {
    ...
    /* Paired with smp_mb__after_atomic() in tun_net_xmit() */
    smp_mb();
    if (netif_tx_queue_stopped(txq)) {
    ...
}

Should the corresponding wakeup logic and smp_mb() in __tun_wake_queue() al=
so
be removed to complete the revert and avoid unnecessary overhead?

> -		if (!__ptr_ring_check_produce(&tfile->tx_ring))
> -			netif_tx_wake_queue(queue);
> -	}
> -	spin_unlock(&tfile->tx_ring.producer_lock);
> -
> -	if (ret) {
> -		/* This should be a rare case if a qdisc is present, but
> -		 * can happen due to lltx.
> -		 * Since skb_tx_timestamp(), skb_orphan(),
> -		 * run_ebpf_filter() and pskb_trim() could have tinkered
> -		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> -		 * we must drop instead.
> -		 */
> +	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
>  		drop_reason =3D SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728092240.2502=
57-1-simon.schippers@tu-dortmund.de?part=3D1
