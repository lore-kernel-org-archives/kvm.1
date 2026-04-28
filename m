Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52341B37A
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380635; cv=none; b=s7tdzpskSsHoeGxa6/eBVs1y+wbebU2ZUCeICmtRUciBxiTOCY8SWhA0W5njsmkqSZE8U0vkvd3+olgHn9+5KHZGrSCI3pRtJkkwOzxxTynV2DlP43yQID4GMcm6QdQMIa3p/dkgvmTTpuhsRF2t7GJgRgTLcg7B0oIZifxEcV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380635; c=relaxed/simple;
	bh=4jJGYQxHBlAYam3pVZa37i0ecAp+T4koXg6IlslsR5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY/kayJjhAAqaF6PbqkOW1pRJahbjifCma9tDNW9D42ludqa5NS03f97vGjPV4UBQYYXKODfQX8O/oN9TBYsL8LQ08oNYCzv74llXJ/YpNl6k/fxUiCvXnJvT+Bx8O+nMdgzE+BVzZnKr7wFjJQ45eaVHOhhwh3OrElny/e+eUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqRP7aBp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyBKqpUT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqRP7aBp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyBKqpUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777380630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0i0+P4zaB64MHfqqKp5K0u0CNckDs52Y4/4I9jpSM2g=;
	b=fqRP7aBp3huqueXMATc7HgXUyfJvvlPH8ufZCIuH2gOCjwuX3gk/8cJuT7JB4cDhPyaYI7
	nf5iUP5yzkpo+Y27G4efsD1BlDlJjhobw9t45ZGiRluv/Ay66m1FKEtWOweNADA8NA6yw6
	i36E34i/ykqMD9uGW/StEW5+jlpoBI0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-AoLIGkYEM4q04S9XW6_rSg-1; Tue, 28 Apr 2026 08:50:28 -0400
X-MC-Unique: AoLIGkYEM4q04S9XW6_rSg-1
X-Mimecast-MFC-AGG-ID: AoLIGkYEM4q04S9XW6_rSg_1777380627
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48906aa28cbso74689345e9.0
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 05:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777380627; x=1777985427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0i0+P4zaB64MHfqqKp5K0u0CNckDs52Y4/4I9jpSM2g=;
        b=YyBKqpUTEyJUbOIhjYXOalFjzrgDYhTWgD18QlIHJ20uQnyJTSdj4uNJjlGL0z+E2s
         4GfI/aM+q3f2azv3UcARJfnusQb70GyUj14JUCV7YMctqX42LgOh6NWz7btluquyQN/y
         AE/sVJEKd/W9wXg2OgRVphLKF0fgKlBf6k2sApVsPP2dWzMdsWAt2mh1VkPfSSmiqv5X
         mpT1i0ZYeEdkt3uFUGY/K/PEM0GELA5KdpfHZlW2D8wy/qDPCKK/1KnCU4aoDtDY53Qd
         5uHFVZJIT1wapl971//3tEmOoWl+uWuZ1wKFKpC1KviloFQcHuwr/5HOq5Qq/+mDgsLV
         7l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380627; x=1777985427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0i0+P4zaB64MHfqqKp5K0u0CNckDs52Y4/4I9jpSM2g=;
        b=k+ldwXZCbeI7LBxfXqy9iXNVgpEdLeqPngjGHZm47xAKzAljljBy/xdcmV1zhPTrQt
         JTP4a91vS7b7Qa24f/TOZiVkjqjGKW6X3FSDOUT716dm4GnMewXU6gDlb25vi5HyvtJL
         n29jWCYWJnjtM2Foy00qEVai+KY1rTtDjC8awSHMM7z5meFJYhTG3fdPV3N/Zy60HYce
         cPznk06D9e60upB/197+KlnlQCGztmKfI2U7cqdIvoskSTcOtzHE7sAMeU99ktk/Wc/u
         Lac83f7qxKlLvJK7tZNqvLYK/pyLaEjJC16xziIUesbHfjpykshtMZ6uylmSS/WqBSC9
         dzgg==
X-Forwarded-Encrypted: i=1; AFNElJ/egcS+eXtWKwTyGMFbWCkmqUv1zf8AakLzFl93XpNf0I+HX05Qiy8+rNP8Nedh03fMekg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV94QEy9DjuIMCCPDK7xZYzGn6ZYI0VeivtvIiizVKWfA2UiGW
	CM/LbkHXK/57E9XKpBEUxqK0YDnDqJL5n7VKfEkOwWiWIWFi2zbR553RB69ObldD6rAQdMosc7L
	aDRyoBEPwjJr6xSBX/1KsNo+UI2s2qouOcnyXoTgby4oCljmKZdgwNw==
X-Gm-Gg: AeBDietdHXg4ptYQ9xgk4pvycqdn05z07bdden7ZuUe8AVEA318Qr25RbNGQtbEKj3O
	+CXpl0Ou/aLNezx7CIwu1eYUgRUK9hTpZI2WbZfUbRHmmQi989x4YyWv55SLHAkmz7XKoHdDgHd
	YNW0G8vnfTkfur+ml0GxJMbINI4mdSoqt+HAHUsnpCoXAuUAgFvxegXOM3JH1Wm0/RQeU/fsxeb
	ka3iAFil9x3IB4Jh3XjIShY4x1VJTQU6itZelsl8X6hFNoJjvBVV90TghKhReS5SKq3Gtt92gAL
	6ZGjix6h3smvKxXWCZP52hxfRwNc+xv2Rvls3DzhNuvDVwCQJoZRtUYBKABRyQLplRAipOQ3C81
	2tzza/QXjDXz15D0xWsa5WPb+0XtiNIxJzzzykUCd0mwLgp08uftuLpEz
X-Received: by 2002:a05:600c:609a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a78a33023mr30740345e9.9.1777380627118;
        Tue, 28 Apr 2026 05:50:27 -0700 (PDT)
X-Received: by 2002:a05:600c:609a:b0:48a:5339:a46 with SMTP id 5b1f17b1804b1-48a78a33023mr30739215e9.9.1777380625808;
        Tue, 28 Apr 2026 05:50:25 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773efe38sm72509755e9.13.2026.04.28.05.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:50:24 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:50:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v9 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260428084851-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428123859.19578-5-simon.schippers@tu-dortmund.de>

On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets.
> 
> If producing an entry fails anyways due to a race, tun_net_xmit returns
> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> LLTX is enabled and the transmit path operates without the usual locking.
> 
> If no qdisc is present, the previous tail-drop behavior is preserved.
> 
> The existing __tun_wake_queue() function of the consumer races with the
> producer for waking/stopping the netdev queue: the consumer may drain
> the ring just as the producer stops the queue, leading to a permanent
> stall. To avoid this, the producer re-checks the ring after stopping
> and wakes the queue itself if space was just made. An
> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> drain that the consumer performed.
> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> netif_wake_subqueue():
> 
> Consumer CPU                  Producer CPU
> ========================      =========================
> __ptr_ring_consume()
> netif_wake_subqueue()         netif_tx_stop_queue()
>           /\                  smp_mb__after_atomic()
>           ||                  __ptr_ring_produce_peek()
> contains RMW operation
>  test_and_clear_bit()
>           /\
>           ||
>  "Fully ordered RMW:
> smp_mb() before + after"
>     - atomic_t.txt
> 
> Benchmarks:
> The benchmarks show a slight regression in raw transmission performance,
> though no packets are lost anymore.

Could you include the packets received as well?
To demonstrate the gains/lack of loss. 

> 
> The previously introduced threshold to only wake after the queue stopped
> and half of the ring was consumed showed to be a descent choice:
> Waking the queue whenever a consume made space in the ring strongly
> degrades performance for tap, while waking only when the ring is empty
> is too late and also hurts throughput for tap & tap+vhost-net.
> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> 1/2 was chosen for the sake of simplicity for both tun/tap and
> tun/tap+vhost-net.
> 
> Test setup:
> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> mitigations disabled.
> 
> Note for tap+vhost-net:
> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> 
> +--------------------------+--------------+----------------+----------+
> | 1 thread                 | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> +--------------------------+--------------+----------------+----------+
> | 2 threads                | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index efe809597622..c2a1618cc9db 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
>  	int len = skb->len;
> +	bool qdisc_present;
> +	int ret;
>  
>  	rcu_read_lock();
>  	tfile = rcu_dereference(tun->tfiles[txq]);
> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> +
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> +		netif_tx_stop_queue(queue);
> +		/* Re-peek and wake if the consumer drained the ring
> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> +		 * in __tun_wake_queue().
> +		 */
> +		smp_mb__after_atomic();
> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +			netif_tx_wake_queue(queue);
> +	}
> +	spin_unlock(&tfile->tx_ring.producer_lock);
> +
> +	if (ret) {
> +		/* If a qdisc is attached to our virtual device,
> +		 * returning NETDEV_TX_BUSY is allowed.
> +		 */
> +		if (qdisc_present) {
> +			rcu_read_unlock();
> +			return NETDEV_TX_BUSY;
> +		}
>  		drop_reason = SKB_DROP_REASON_FULL_RING;
>  		goto drop;
>  	}
>  
>  	/* dev->lltx requires to do our own update of trans_start */
> -	queue = netdev_get_tx_queue(dev, txq);
>  	txq_trans_cond_update(queue);
>  
>  	/* Notify and wake up reader process */
> -- 
> 2.43.0

