Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E9391E7E
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382547; cv=none; b=uqXCnstJJMXZDgMigZprqH9cqO+OGy6AuR1Hbxs7xLhXgqMAODpSZ7EKbmniVAR8QYreO8x3bhob5JoChtlNvYwH7ptkUcEN63CD9NroS7qwrq/N3PAnOVwTSk9ipAtOdLXj3UW6iOf0SugvtHed0yonWCYiOg3o/MydU/pV3dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382547; c=relaxed/simple;
	bh=2BB9SsZnD1oUi/iZNMFAyjkEk2+CmkyVl1grdupCgZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkQIgrsTxYZPq+cJ5CUVCvFB3ljkQZLV0xnGSQ2M/dyNwJMu539gHh7R8UbHEhEGcOF1gCEpQ4GgS/1NsEmEa0nx3Y1PuvDPU2rSWT6sdmx9KosCToSk6aucW3HUo505GgAeiE2sdI7i9DMgq2kONWnLHhfKixjAZzd5PadLwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CW3N0LnN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Plia3UEQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CW3N0LnN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Plia3UEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
	b=CW3N0LnNC6+6cOFiYMTVycjQQLjMUZWnx/xplMwsG/er5Z/2SkF5X69nObHsCV6qwPvSX3
	bfi1cAz6QIxg7I+6Ltt+Nuw6TrkU1B3+I4+Ir4TbfbOIIDUFYGd9x+hd05/Q20EXbUhJYd
	bZwZrV0Lj6a5QtPsHKZcB5/1aDrC2fU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-M-vJFtlIPYe4j9NlibWtSw-1; Tue, 28 Apr 2026 09:22:22 -0400
X-MC-Unique: M-vJFtlIPYe4j9NlibWtSw-1
X-Mimecast-MFC-AGG-ID: M-vJFtlIPYe4j9NlibWtSw_1777382541
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso1644866f8f.1
        for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 06:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382541; x=1777987341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
        b=Plia3UEQ4mI+kXP9VPN2wF1Qt8sFJiL6IwR59KVfHkQ9FlQ6wpFbq7vsg9BuqwcKkz
         rw3F+as7zn863kFscIDhgODcpxC8D4I/j8mEGTmb7FjWpd3z8Zh4n6XhU6llxkPNMv6W
         UpzUsyZJwgQwIuhvR8/WU7JKcvSmTd/+uRtT9ahEvyQ16wnjBS7nlOLrn4oMzl12/9e3
         V3Va78AigXvYCvLvm9w5JtSkQGvEJcZMY5lBpqKVW/cCbpjrtm5m9Zmc4sF0lg6y+N16
         byRSDtCOUcjKo3TSl94CPbDLuklnhROSMpDJOtDyht8gOtsuSBQf9vGtJ05i7EwfgA9U
         0iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382541; x=1777987341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voE5hj3Jt4qgd9THMxCkOfk/n2r5u/BP+6aC7p7RNyk=;
        b=fVOakpaSw0XX7a20Amddbb8FptlUDLI3kDo5XzwJyM7bJG4USKSXU5VYd5fLagyavG
         R/bWK6W3tN7zHl29nvqOmGxhdIx4O1fvnPJYaon1TLRQMUN3eTY6XGf2QPSLF3x6Dfrx
         ANcGPaUPyrwX8SQgIJKvNKNdi67zgQwkp8DF8fJalH95Cj1ZuOW9G8opk+wv/3EefLwt
         z8sL49LWul5EKaltk0BJTS4x9eLQtEGgaa+gxpJiDVSRfNHKnq3dFGbwIjcDk7A37Cq5
         YRFsKhtPPGydN8rtbtU/RbetJRKEUa/G2RrCVvijQvg76li5w+SA33VSrX+rYmT7QTX3
         brzg==
X-Forwarded-Encrypted: i=1; AFNElJ/p9Zb9SNjyX9P3uKoM5VwKTmzSx74MWSMfSmCs9CXrMJkT9THr7TEO4+0ewVLegXfkuJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAnW4D8gwSxB7mHCfcTLAxPK3lAwrrArH5SjY8n9L5TkGeUa8/
	KnpBfHcsHygBbb4lWQ/sArb4ukAWu95TKcwkKx3fNmZr0OAQVni5AMLe1s8HsKXqyBL2gd8IDB/
	VkWYZt7/KIiQN9JISoFBNWxXim0JrHN+dimeTnAF7Pgqt4F8+Y1cfWw==
X-Gm-Gg: AeBDietLFFKOG4trm5IhSzL44dU9bhXMMIxxQLwRWNmXoz7PJAiVRPCJBrd7Beo2iK+
	MEmI1OO+BpHB+xIqpUJYwe6I6S44ajNSDpeL2DswXn3yiu/sLrbtEGK8OvQAO9k/vByc1kbQT3/
	MPRijRM3I2i0OdWE1etra8GnzbyRzNl6NGaYnErFfXNh9q3XnhiFN2n/xWzSFcuOl9TabUKvn5X
	tdRvADLioT/2wJwNkkj45OPM9veFm8nGg5Ao2s0LSG+xlDOP/lz5vzL7SPgotK9cs0rUkmzwxG7
	vlbqdB87Ctuv2CsE2f/doCr3tCfvIm5LfMVMoBr4sMoejYVQ3tyCvJxeF27y1RkHlqbkaWLvxzp
	TN75NfbG/ZHOKi98lRDnohCzrn/5JCkzr2koj9YiAnn3m1GWQXwtiwoK8
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626378f8f.27.1777382540728;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2c01:b0:43d:773d:78ff with SMTP id ffacd0b85a97d-4464a1684bdmr5626286f8f.27.1777382540032;
        Tue, 28 Apr 2026 06:22:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-47-179.inter.net.il. [80.230.47.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f6a1sm6487599f8f.13.2026.04.28.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:22:18 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:22:14 -0400
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
Message-ID: <20260428092150-mutt-send-email-mst@kernel.org>
References: <20260428123859.19578-1-simon.schippers@tu-dortmund.de>
 <20260428123859.19578-5-simon.schippers@tu-dortmund.de>
 <20260428084851-mutt-send-email-mst@kernel.org>
 <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdc3cbc8-cf6a-437c-b34c-dd8ced65d7f8@tu-dortmund.de>

On Tue, Apr 28, 2026 at 03:10:44PM +0200, Simon Schippers wrote:
> On 4/28/26 14:50, Michael S. Tsirkin wrote:
> > On Tue, Apr 28, 2026 at 02:38:59PM +0200, Simon Schippers wrote:
> >> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> >> becomes full. Once an entry is successfully produced and the ptr_ring
> >> reaches capacity, the netdev queue is stopped instead of dropping
> >> subsequent packets.
> >>
> >> If producing an entry fails anyways due to a race, tun_net_xmit returns
> >> NETDEV_TX_BUSY, again avoiding a drop. Such races are expected because
> >> LLTX is enabled and the transmit path operates without the usual locking.
> >>
> >> If no qdisc is present, the previous tail-drop behavior is preserved.
> >>
> >> The existing __tun_wake_queue() function of the consumer races with the
> >> producer for waking/stopping the netdev queue: the consumer may drain
> >> the ring just as the producer stops the queue, leading to a permanent
> >> stall. To avoid this, the producer re-checks the ring after stopping
> >> and wakes the queue itself if space was just made. An
> >> smp_mb__after_atomic() is required so the re-peek of the ring sees any
> >> drain that the consumer performed.
> >> smp_mb__after_atomic() pairs with the test_and_clear_bit() inside of
> >> netif_wake_subqueue():
> >>
> >> Consumer CPU                  Producer CPU
> >> ========================      =========================
> >> __ptr_ring_consume()
> >> netif_wake_subqueue()         netif_tx_stop_queue()
> >>           /\                  smp_mb__after_atomic()
> >>           ||                  __ptr_ring_produce_peek()
> >> contains RMW operation
> >>  test_and_clear_bit()
> >>           /\
> >>           ||
> >>  "Fully ordered RMW:
> >> smp_mb() before + after"
> >>     - atomic_t.txt
> >>
> >> Benchmarks:
> >> The benchmarks show a slight regression in raw transmission performance,
> >> though no packets are lost anymore.
> > 
> > Could you include the packets received as well?
> > To demonstrate the gains/lack of loss. 
> > 
> 
> Do you mean the number of packets received by the VM?
> They should just be the same as the number sent (shown below), right?

Minus the loss? Which this is about, right?

> I assume they would be visible as RX-DRP for TAP.
> For TAP + vhost-net I would have to rewrite the XDP drop
> program to count the number of dropped packets...
> And I would have to automate it...
> 
> >>
> >> The previously introduced threshold to only wake after the queue stopped
> >> and half of the ring was consumed showed to be a descent choice:
> >> Waking the queue whenever a consume made space in the ring strongly
> >> degrades performance for tap, while waking only when the ring is empty
> >> is too late and also hurts throughput for tap & tap+vhost-net.
> >> Other ratios (3/4, 7/8) showed similar results (not shown here), so
> >> 1/2 was chosen for the sake of simplicity for both tun/tap and
> >> tun/tap+vhost-net.
> >>
> >> Test setup:
> >> AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> >> Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> >> mitigations disabled.
> >>
> >> Note for tap+vhost-net:
> >> XDP drop program active in VM -> ~2.5x faster, slower for tap due to
> >> more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 1 thread                 | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.136 Mpps   | 1.130 Mpps     | -0.6%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 3.758 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.858 Mpps   | 3.816 Mpps     | -1.1%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 789.8 Kpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> +--------------------------+--------------+----------------+----------+
> >> | 2 threads                | Stock        | Patched with   | diff     |
> >> | sending                  |              | fq_codel qdisc |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 1.117 Mpps   | 1.087 Mpps     | -2.7%    |
> >> |            +-------------+--------------+----------------+----------+
> >> |            | Lost/s      | 8.476 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >> | TAP        | Transmitted | 3.679 Mpps   | 3.464 Mpps     | -5.8%    |
> >> |            +-------------+--------------+----------------+----------+
> >> | +vhost-net | Lost/s      | 5.306 Mpps   | 0 pps          |          |
> >> +------------+-------------+--------------+----------------+----------+
> >>
> >> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >> ---
> >>  drivers/net/tun.c | 30 ++++++++++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >> index efe809597622..c2a1618cc9db 100644
> >> --- a/drivers/net/tun.c
> >> +++ b/drivers/net/tun.c
> >> @@ -1011,6 +1011,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  	struct netdev_queue *queue;
> >>  	struct tun_file *tfile;
> >>  	int len = skb->len;
> >> +	bool qdisc_present;
> >> +	int ret;
> >>  
> >>  	rcu_read_lock();
> >>  	tfile = rcu_dereference(tun->tfiles[txq]);
> >> @@ -1065,13 +1067,37 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >>  
> >>  	nf_reset_ct(skb);
> >>  
> >> -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> >> +	queue = netdev_get_tx_queue(dev, txq);
> >> +	qdisc_present = !qdisc_txq_has_no_queue(queue);
> >> +
> >> +	spin_lock(&tfile->tx_ring.producer_lock);
> >> +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> >> +	if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> >> +		netif_tx_stop_queue(queue);
> >> +		/* Re-peek and wake if the consumer drained the ring
> >> +		 * concurrently in a race. smp_mb__after_atomic() pairs
> >> +		 * with the test_and_clear_bit() of netif_wake_subqueue()
> >> +		 * in __tun_wake_queue().
> >> +		 */
> >> +		smp_mb__after_atomic();
> >> +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> >> +			netif_tx_wake_queue(queue);
> >> +	}
> >> +	spin_unlock(&tfile->tx_ring.producer_lock);
> >> +
> >> +	if (ret) {
> >> +		/* If a qdisc is attached to our virtual device,
> >> +		 * returning NETDEV_TX_BUSY is allowed.
> >> +		 */
> >> +		if (qdisc_present) {
> >> +			rcu_read_unlock();
> >> +			return NETDEV_TX_BUSY;
> >> +		}
> >>  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >>  		goto drop;
> >>  	}
> >>  
> >>  	/* dev->lltx requires to do our own update of trans_start */
> >> -	queue = netdev_get_tx_queue(dev, txq);
> >>  	txq_trans_cond_update(queue);
> >>  
> >>  	/* Notify and wake up reader process */
> >> -- 
> >> 2.43.0
> > 

