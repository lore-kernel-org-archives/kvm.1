Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF136212C
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106492; cv=none; b=C2nEN1Uf5VNxJTQWjDHVzDftScAMUHgZd9thgoSRR9/cqTMsAtMI2ru1OcKAjU6zQuDLLg22evbB4lZPi9jwxoW+z5WntpArXYVMRmAZxswkRarYuryigr1IRkR5HVI/F7tEmj8L3GslcOjowBIoE8QWmUN9tcJbL++EP0T1JCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106492; c=relaxed/simple;
	bh=rtVwk1ax2o4nJ4GXyKTejUp5AmKhUCVDmo4YRJ3ERHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMrXRIE9wgCS7gJ5CMRLvHmYYyrdW6B0ZMCKEw4a/tz+wFbWDqWIAP3OdSaHSHgqhz7HG/95RXVri9OZfcwXMQBWZjlFrDM7tF0A9hh+KLDmflG3RRMmqVU8lUo9YUn91uvs2f3GjWAjQQFV0EzBhkKeULOZcR3JN/jDAwJ1xuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUjfmNVI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7JIkOfA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUjfmNVI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7JIkOfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778106490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
	b=MUjfmNVII8pyesxkNhTQ+aYy8V7AIgF+SkfNbZXDw0DiOWopUsR9+kjQtwCg6zKpiBpc6K
	bI1SX+9HLspDdk0JXPWQKJeruKV5FTJSYbwaLSG1Ek93pEjKlmj26bBKuhXb1QlvlZ+gdz
	i5nVMmC7GzQv1LcnejeGQAezQR33FiM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-7GjYfRhpPQ-mi-Nnt00i0w-1; Wed, 06 May 2026 18:28:08 -0400
X-MC-Unique: 7GjYfRhpPQ-mi-Nnt00i0w-1
X-Mimecast-MFC-AGG-ID: 7GjYfRhpPQ-mi-Nnt00i0w_1778106487
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44a122a5128so136802f8f.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778106487; x=1778711287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
        b=T7JIkOfA6LbehnvBkk0609D5QbeP0HnzceqdAojuDwtCVjAcVhTFLIVvYYQu400PFJ
         iT6iTcvEK+l1WVKMU7J+LpSLVdWwTFYCO59KthyikifuNBCeKAKh6oIsWmLvw/scTFcv
         f2v31Ds7CwBq+6cKpkhV40tsSNLLuKtBX6aCs5Ka9cTE8bRt5M8aN2kUFNAk6WoI40IP
         XaNNH2A2w2RFnkJGs363Bxla86nrcpQr1Hhgn0Z5JOy87HCYkbBwddikygWd9lc4b9I7
         DrN+pFOOVLsWnX/Zl8Qb8Qw1fBXgqgwXuGJ3oSqY/btk0zXApynMWU6zXELRvxMAso4p
         OghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778106487; x=1778711287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8i9O8vJ9NfXLrrn+cYRMOYCqXIwE6jcbZ+nzxxFXS0=;
        b=YUj/0V3orbXCvqqsQZh1XZbojQ/M4aJzCd4+Ppl9mY4KUwzcc7CL/O6jRGA6PlL76P
         9cBBGvz4MnJV7CrgmIDtSoNMAiE1aNhf/AaOp0dy9q1hR6S5A+FXXJp9yiiMXRGJP7FE
         Sq6ZE5HDTMiLPm9WpPYMsBKkELzH5uaNNtCnFmsbG/QsSX7w1EPlLRf7DmEisRAwbgJ/
         epBbQo798fTMeDrKMrnoAhY+Bm+Z4JuMcwmLsRhLGBeSSWk+7RrL38zqUctnFVdeNZCf
         yGoUpg6HeIQH5ZDXN9xnMJkPaI4nCvG+khVUDnoNDIZEjYzRuwxFORS9zWvyxoLFU3Yr
         FKpg==
X-Forwarded-Encrypted: i=1; AFNElJ/MzchsOtzaWYd1jHVGUrDWWl4jlz12u8q7idwgWkbyAX2KgJzwPPTaJB3kOjt3hs9VK5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAy7T5/SVI9euYyDzSNL7pOrvPlgC1NiVpekH+kQymesZnpIn
	JfLqht9aBgeYqRuHS6WqNC3B1KZ9zEVe8ns+4YxtUvttoUW+fwWStNEWBeTPHB9K+oVei5IF5tG
	vcj1OJ0/uH6pVFHwBx/20IhmUjUwcoKRlm2Jfclw60jUT1oLuDDZ2/Q==
X-Gm-Gg: AeBDies382eM7H2ZkGXl+NbAgq4D+eeaop3wc7G81xorxug52lo5wx4YjfI12EkSiJ0
	venvdLH7Y1WtsxVibbUkhByKmIKqql3jqCama+tAVRy6S5FXaCKlFCnJ0z9vW+Eft9ZfW0FW4/Z
	YOy2yZYYnmRcTQmPA1Xp0eZ+O9GYhp8p5kILOABLx9/t817m5s8Kr/RBictu6JveJvpwt+0U8oN
	Dd+RZ0BVL5f9/JmWeGE+rEh3cE0XdT+D0kMzDLjrrRiLuiJIyfHe+kR1+qNL3rTP7lQJ9OcB3bI
	mruF0sSfJtHwXIjoi84lvjLSJwQUm63AOgfjB9xzO8XpNKWmsic4LyRN6EP4hlU0pqYLCluIvP9
	hXMVu1bVqrdhmbkCemhJ0Ze+UeoPe/6ZuHz63cqdXHkX5Ws5e+ws=
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48e51f24340mr59778975e9.8.1778106487228;
        Wed, 06 May 2026 15:28:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8908:b0:48a:5821:5ff2 with SMTP id 5b1f17b1804b1-48e51f24340mr59778725e9.8.1778106486686;
        Wed, 06 May 2026 15:28:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm97231005e9.7.2026.05.06.15.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:28:06 -0700 (PDT)
Date: Wed, 6 May 2026 18:28:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v10 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
Message-ID: <20260506181909-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506141033.180450-5-simon.schippers@tu-dortmund.de>

On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets. If no qdisc is present, the previous tail-drop
> behavior is preserved.
> 
> If producing an entry fails anyways due to a race, tun_net_xmit() drops
> the packet. Such races are expected because LLTX is enabled and the
> transmit path operates without the usual locking.
> 
> The __tun_wake_queue() function of the consumer races with the producer
> for waking/stopping the netdev queue, which could result in a stalled
> queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
> with the smp_mb() of the consumer. It follows the principle of store
> buffering described in tools/memory-model/Documentation/recipes.txt:
> 
> - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
>   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
>   ring with __ptr_ring_produce_peek().
> 
> - The consumer in __tun_wake_queue() first writes zero to the ring in
>   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
>   status with netif_tx_queue_stopped().
> 
> => Following the aforementioned principle, it is impossible for the
>    producer to see a full ring (and therefore not wake the queue on the
>    re-check) while the consumer simultaneously fails to see a stopped
>    queue (and therefore also does not wake it).
> 
> Benchmarks:
> The benchmarks show a slight regression in raw transmission performance
> when using two sending threads. Packet loss also occurs only in the
> two-thread sending case; no packet loss was observed with a single
> sending thread.
> 
> Test setup:
> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> mitigations disabled.
> 
> Note for tap+vhost-net:
> XDP drop program active in VM -> ~2.5x faster; slower for tap due to
> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> 
> +--------------------------+--------------+----------------+----------+
> | 1 thread                 | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
> +------------+-------------+--------------+----------------+----------+
> 
> +--------------------------+--------------+----------------+----------+
> | 2 threads                | Stock        | Patched with   | diff     |
> | sending                  |              | fq_codel qdisc |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
> |            +-------------+--------------+----------------+----------+
> |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
> +------------+-------------+--------------+----------------+----------+
> | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
> |            +-------------+--------------+----------------+----------+
> | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
> +------------+-------------+--------------+----------------+----------+
> 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index fc358c4c355b..d9ffbf88cfd8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct netdev_queue *queue;
>  	struct tun_file *tfile;
>  	int len = skb->len;
> +	int ret;
>  
>  	rcu_read_lock();
>  	tfile = rcu_dereference(tun->tfiles[txq]);
> @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	nf_reset_ct(skb);
>  
> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +	queue = netdev_get_tx_queue(dev, txq);
> +
> +	spin_lock(&tfile->tx_ring.producer_lock);
> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> +	if (!qdisc_txq_has_no_queue(queue) &&
> +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
> +		netif_tx_stop_queue(queue);
> +		/* Paired with smp_mb() in __tun_wake_queue() */
> +		smp_mb__after_atomic();
> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +			netif_tx_wake_queue(queue);
> +	}
> +	spin_unlock(&tfile->tx_ring.producer_lock);
> +

There's a weird corner case here when tx_queue_len is 0
but a qdisc has been configured - it looks like that
currently it just drops all packets, with this change,
the qdisc will get stuck permanently.

I suspect just checking tx_ring.size should fix it.
Or if you feel adventurous, change return code for __ptr_ring_produce
to distinguish between "no ring" and "no space".


> +	if (ret) {
> +		/* This should be a rare case if a qdisc is present, but
> +		 * can happen due to lltx.
> +		 * Since skb_tx_timestamp(), skb_orphan(),
> +		 * run_ebpf_filter() and pskb_trim() could have tinkered
> +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> +		 * we must drop instead.
> +		 */
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

