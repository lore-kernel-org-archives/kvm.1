Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818D73D0922
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778108175; cv=none; b=CRSO42OA1/7vWoZOlSOZl84iJieWAFGmT5t5YfkIe2vkezM1ZVYsmicvghuyBrAZl7ujvKAzKy5xjaSrH2cnzrCELOuw8K0FcikZ4zEgJJtSS9LaEP5NJ3nPDgWW7tNEufudnXxHfweL4U4Ov+xD3vDLOVCsNAZ+Sf4ywJPQOo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778108175; c=relaxed/simple;
	bh=dM3TlIQgVWr1xfD/Lm0b3bvPVHqNBiyinGy2WrAxOQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpdVnDC0VNuA0JBm01Lgphc61ZL2g+9nyeD9tbVFg8hzb4SrfErndI5qhmyxK5p93cN0vuOcliE20IB+EQh86VUCZnaR+5IJen6OVHsGcC9yvkjfB5u+sXYXDR11XkcZCthy+YEyaWrRmqk+0JMBhzPRugPqahOijDfh3lzB4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gDnYxgLa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mbuV+gN+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDnYxgLa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mbuV+gN+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778108171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
	b=gDnYxgLaTSuQ++xAxp+kved5m7CVgjJ055l5LdYbc/iGde8NrVFMD4R3wbzwE5QM8bX+9X
	sqINbg2NYGk53gEu/uMcKlz6MIFbUSd3AaNMs0EuDo2ITwqm5hxOdbm6roD9TIe7w9ipBk
	AM1fFzy2WNdagfaZa4P2q8D+Irotyac=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-tpcQS3LwOG-8BjeS_17Eqw-1; Wed, 06 May 2026 18:56:10 -0400
X-MC-Unique: tpcQS3LwOG-8BjeS_17Eqw-1
X-Mimecast-MFC-AGG-ID: tpcQS3LwOG-8BjeS_17Eqw_1778108169
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso779065e9.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778108169; x=1778712969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
        b=mbuV+gN+cVPTm4ABHHEl10zFZKjUYLfTVBqpjiW5lsPQHREPJqYmXpqLK0aMnirTwR
         T2Iz9KkiP+OnxFqcNZIWJLjrrXVCXjO/jILjlpwkWCIZfGrRk1cEPwnapIHozQ/ppFPs
         W+XrGRA511j5E0MJ40qzn6zhOnsPRKFwGG4IMSFMHZPEnVyaAQCh3Oz7q6Zu8VgGa1QV
         StMWlaTqR4EArphUqG38U0/Y/Pz8xwEiNFoE4KAiBz9OzdrkLMdrTyksFYFi1gFqSd2M
         /fosXbO5rIYzk+YaC4iMlWI2itbYyuy9NkhRr8rr1ZcyO6qOvlRklczCkTv0SWTC1XC5
         WiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778108169; x=1778712969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrLMs5/3pE8k0d8D7czaQla4yNq4KH+KGMukbjP7+Io=;
        b=YLGcq6PhLh7f0txwkHwO6V5EThmQd7uTTsGPnDnLtSbZpdFDMpCT1wDQL9uPbr95fb
         WGr+fuzC2U4RdnFccZRH5TbMRNlSBRwCTRharXLou0riUsJrPrVOqrTDfnwpudLBFzAG
         7hRH8kjxytW6nQ/MamWnkciZsqt//65qFLugg9EsySsHLZjmp2gjFTAwztGU3N3BH1Mq
         zJktRXkDSOQGBIg5puezlAgL4feOR7ReKXj1kfDoEH/MZnVAokfHviKrRSUZN9UDF8Q9
         wCgOSv/6QjgBzncqRYzE7WrqMimBCr/lzy84lr34HDWWKNACRdXBtHsvrMQfUyQHwniw
         A7Cw==
X-Forwarded-Encrypted: i=1; AFNElJ+U+CN4xUEG2H+JxhtZlyIN5RJd4mXu68haV0L2n8CaQZwOCsBakgdwzn7ZXqBwDcpD52c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt27MoyOUgEq6SChAlbbnJ7oxV9a3wSKZzGvACfwf4WpYavjjK
	N8eg9f/sxnMdAU+GIIlKOAknSnAvdGp2mdmhqETpBsCnsmwicn95jedUH/0YC5yr9J0rugzlFLZ
	8Yrg7SQfzZwwZs6UuJTYQyppQbLn/GyELT8BR/jBh1lt9OITLn2gPLA==
X-Gm-Gg: AeBDievFqnQBEar0V49YQLCNPGpSSIJutAM6P/NbfKeAbMTKAkOXhZoGpLLBgsICOQb
	bKuFbgP/rTtgh7nMZnXpuC45tSzDLDLUzjasdCzbOSjFdsKpPbjmbIzQCsiCKlhlGfxs8TFKb0U
	D+oRGGix5zmgcz73MslCBGB2EeKTb7NeTF7NZz3e8R3hnJBHAAjz3x9I/VyTqsn4dcPWsk5Wt7S
	MPtai+wsU/1HtZ+NLJrqttbCfHIJD1sPFM56i7ebcbXcpTYGZX8juxZbjIS1/mlo2IDYUvW4T8w
	QNx/Cftn210K8fl0H4sR/sp3vA6iQqBLmlQC5NLI21HFiQN1E7WDrksCulpYDdalUJT095PKxnl
	mIQeGnYi+ZiJ5hrfe1pZ5NIc2Wpxx1wfFEcMZgyi1s5uF4cydBy0dq/7Q9402+g==
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87550005e9.16.1778108168903;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
X-Received: by 2002:a05:600c:46d2:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-48e51f32aebmr87549685e9.16.1778108168416;
        Wed, 06 May 2026 15:56:08 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm16159726f8f.14.2026.05.06.15.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:56:07 -0700 (PDT)
Date: Wed, 6 May 2026 18:56:04 -0400
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
Message-ID: <20260506185515-mutt-send-email-mst@kernel.org>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
 <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
 <20260506181909-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506181909-mutt-send-email-mst@kernel.org>

On Wed, May 06, 2026 at 06:28:06PM -0400, Michael S. Tsirkin wrote:
> On Wed, May 06, 2026 at 04:10:33PM +0200, Simon Schippers wrote:
> > This commit prevents tail-drop when a qdisc is present and the ptr_ring
> > becomes full. Once an entry is successfully produced and the ptr_ring
> > reaches capacity, the netdev queue is stopped instead of dropping
> > subsequent packets. If no qdisc is present, the previous tail-drop
> > behavior is preserved.
> > 
> > If producing an entry fails anyways due to a race, tun_net_xmit() drops
> > the packet. Such races are expected because LLTX is enabled and the
> > transmit path operates without the usual locking.
> > 
> > The __tun_wake_queue() function of the consumer races with the producer
> > for waking/stopping the netdev queue, which could result in a stalled
> > queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
> > with the smp_mb() of the consumer. It follows the principle of store
> > buffering described in tools/memory-model/Documentation/recipes.txt:
> > 
> > - The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
> >   followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
> >   ring with __ptr_ring_produce_peek().
> > 
> > - The consumer in __tun_wake_queue() first writes zero to the ring in
> >   __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
> >   status with netif_tx_queue_stopped().
> > 
> > => Following the aforementioned principle, it is impossible for the
> >    producer to see a full ring (and therefore not wake the queue on the
> >    re-check) while the consumer simultaneously fails to see a stopped
> >    queue (and therefore also does not wake it).
> > 
> > Benchmarks:
> > The benchmarks show a slight regression in raw transmission performance
> > when using two sending threads. Packet loss also occurs only in the
> > two-thread sending case; no packet loss was observed with a single
> > sending thread.
> > 
> > Test setup:
> > AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
> > Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
> > mitigations disabled.
> > 
> > Note for tap+vhost-net:
> > XDP drop program active in VM -> ~2.5x faster; slower for tap due to
> > more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 1 thread                 | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > +--------------------------+--------------+----------------+----------+
> > | 2 threads                | Stock        | Patched with   | diff     |
> > | sending                  |              | fq_codel qdisc |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
> > |            +-------------+--------------+----------------+----------+
> > |            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > | TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
> > |            +-------------+--------------+----------------+----------+
> > | +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
> > +------------+-------------+--------------+----------------+----------+
> > 
> > Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > ---
> >  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index fc358c4c355b..d9ffbf88cfd8 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct netdev_queue *queue;
> >  	struct tun_file *tfile;
> >  	int len = skb->len;
> > +	int ret;
> >  
> >  	rcu_read_lock();
> >  	tfile = rcu_dereference(tun->tfiles[txq]);
> > @@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	nf_reset_ct(skb);
> >  
> > -	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> > +	queue = netdev_get_tx_queue(dev, txq);
> > +
> > +	spin_lock(&tfile->tx_ring.producer_lock);
> > +	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
> > +	if (!qdisc_txq_has_no_queue(queue) &&
> > +	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
> > +		netif_tx_stop_queue(queue);
> > +		/* Paired with smp_mb() in __tun_wake_queue() */
> > +		smp_mb__after_atomic();
> > +		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> > +			netif_tx_wake_queue(queue);
> > +	}
> > +	spin_unlock(&tfile->tx_ring.producer_lock);
> > +
> 
> There's a weird corner case here when tx_queue_len is 0
> but a qdisc has been configured - it looks like that
> currently it just drops all packets, with this change,
> the qdisc will get stuck permanently.
> 
> I suspect just checking tx_ring.size should fix it.
> Or if you feel adventurous, change return code for __ptr_ring_produce
> to distinguish between "no ring" and "no space".


__ptr_ring_produce_peek really.


> 
> > +	if (ret) {
> > +		/* This should be a rare case if a qdisc is present, but
> > +		 * can happen due to lltx.
> > +		 * Since skb_tx_timestamp(), skb_orphan(),
> > +		 * run_ebpf_filter() and pskb_trim() could have tinkered
> > +		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
> > +		 * we must drop instead.
> > +		 */
> >  		drop_reason = SKB_DROP_REASON_FULL_RING;
> >  		goto drop;
> >  	}
> >  
> >  	/* dev->lltx requires to do our own update of trans_start */
> > -	queue = netdev_get_tx_queue(dev, txq);
> >  	txq_trans_cond_update(queue);
> >  
> >  	/* Notify and wake up reader process */
> > -- 
> > 2.43.0

