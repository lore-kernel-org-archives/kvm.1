Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590026;
	b=XKbkbV/V5irm6FCc77jy/hByq4sSOUVif33wMBDgPVMCC0yrlRAwSvB+g7RrGfkfAtqj
	 ldAnYT/vncw75FjHgjn0sT6OFtW/NDXIN8V6IW4+CG3GTCPP8SkLLIS64COhdArfR4Lb6
	 MPeysUU9dEVYXIryR5TkNAQBMSBTppaedeH1OiG8gwmbdWKj1w0NJH/BQU9UqCipAtA9f
	 qntkWt6BhgqPFQEnrtMCPs2EEs98oa90mTw6k4uFs6HFfPQEI909/biIFC6SLJgMCq4Sv
	 Wo4K89Vbm6tZo8F8pZhtSnEQKMxGfI4EdeQQFwcxynakmNi7iKD5INpEI1W8+ufI1eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590026;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=v4va9Y5M33M5N028eR9n6cjuUyjrrJSfdUg8KICOamA=;
	b=Ef31YdWkrq/OvmuIjsTkZ39+xetHCIWfxNL68t7NJNXkr/WI81u/SuCng2tKE1QBBr6l
	 XeXgz0aO7Uun55/ArtHUUanWRgWB7sJQuhOg+fI02s0LYJ/8WKFnryA9l71mMYY+s/DE1
	 +nE85H/ny6qsqkHIl492v7yNFOszNCDSq0oA8XZTYqxmRk2slPOwOzXCRFuhuvqiZAbF6
	 g2ZDm8ztXVWt/41iiZoOwVvbqNIG2veLPS9oWTBkVxSemUx25fkXBITslXB7p2Spiz7S2
	 5atDvaZMlBHkMPgiiGhCreaEyOTb13SJFvLT+4t7iHunzvMHg6i+bgYddL5I5ENgvLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4qAP7qT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="S8/c5dvm";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8260A2605
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD8260A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h4qAP7qT;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=S8/c5dvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794590024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4va9Y5M33M5N028eR9n6cjuUyjrrJSfdUg8KICOamA=;
	b=h4qAP7qT5aB0itqPVmEfP6cZ/h2qIAV7gdlLCbPp+e+vQQCcBIHvlbEt7FHQb02IMrmdSB
	CvXqZvQWL6yiDnftvE5G8TxlPj1jc+DvRY5OLoRkjZZrPSBsirfNyuBPjWwyEKqe7MeCei
	8GK07FnP9PQUi3fKi1Z1dvwZbUSFRE8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-zsguSN2jOO6vPZLfF0dMaw-1; Fri, 13 Nov 2026 12:13:42 -0500
X-MC-Unique: zsguSN2jOO6vPZLfF0dMaw-1
X-Mimecast-MFC-AGG-ID: zsguSN2jOO6vPZLfF0dMaw_1794590022
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337b591609so15450071cf.3
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794590022; x=1795194822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v4va9Y5M33M5N028eR9n6cjuUyjrrJSfdUg8KICOamA=;
        b=S8/c5dvm5FTSJfNMVJAbjbq9EvYBImZm8l3EkWVNoSAtMvjmSoklQBGSr1c1IExn1q
         AGCKj/TdYOFXug9IFHXLmDgoFBAPLBGFvgGsCvClsJeh6BXTb/wzwA5gW5cbw8J/0LLh
         WGGb4ZZQIUsG8Ei9jusAhCWTo15tiHCEFDWtRwF/O4ow+IRHcQ2c5s81vd9rdx8261N8
         f1elKNoDVaAAbsWWs/wuFe9LK4c8W3693gGDjy535XJLaEKqLSG/hbQVjriT//o3Qiy6
         lh4gnyZ3RAWHRA6Z0/saw442kIIc67zFgq2BEDu5Fxl/ixGFzDOH2FJGGEUqO2Y8y+Tc
         fjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590022; x=1795194822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4va9Y5M33M5N028eR9n6cjuUyjrrJSfdUg8KICOamA=;
        b=qh97KATj6bovGJ3WWTaP3VvupOAZBcR0BRzkCyro/PDxeoWmZEhAxp2HEg6DcfcwUA
         zKdVrchFrAg/CKKgYZfxdh2sJL1BAN/2NtQ7xCq3chnqzIRCo3oGXpXcpe0XXbL4V3ph
         VfQYLsWs7g659wj4Q2A5fE3I9IpO6XQrgJoz9LvAqIpqU6Bm2aBaeFwRc1mmZ7EtjoTG
         DC9P4MYYq2Jd8U9IHm8jXmFNG4eYJ+DUO1tlI8/kxMiEGYyo4UQI9/52QBO6D3CfruUY
         Q7Bc2JTD0S5V2GAlCWvcBhLH6Wifks6J4dgtt9l2viWXLMosc+dq9FP82pK9cJGcP7C9
         cgjA==
X-Forwarded-Encrypted: i=1; AL+hErHxKgY4Eo7YkkVqpVYWmt2V4LyErzwiNq8gaSyZek08TxuZNX+6n1aYCG4YEUU1U9wqT8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yWYh0KIp/ahEQzkx8/TadbChvpghBErbyMsW1h4Q6zHZwhneZ
	CZZZL1ibTNY5pRlflOR3sFZ4OubeA7Fi6WKHC7liHysbAbdnRVsXRFNGVwH3iRORhVxwsCCxAha
	vtKJ9tQPnOUa1ytOCLpwJeAJqkVQbVzmptjzv0YdRD6qfQhuTdntY5Q==
X-Gm-Gg: AYBFou1cERy4u84i/ez8fmLYXjnlDke1suiSdzJHXR1L/XsMJYB6RWkh1s4ERFTY97Y
	LXVSYo4hMqCGHDv80+yy5m7jjziF75qj3toMLATfXK9vpLjWk5LOk4OxeJ4FSb1X46qBDhiEYPF
	/nDGQfvcoHt/po/Hp65tGfG4MvgdPt73G4MHoFthnOE/MWv1Fa5WWOpmWuhNokU2d6Tyz956Nty
	xPrbmCrx9+VX4FyButj38/oEXzvMpRhrDr4byPfuRZApykMnKO3q9Lh0nSJ05H97JQNaBjVdjd2
	NLCo8or9qjPtORs9GiHwMB4Y4OL3xfmrG0+y9FMv4rkRhc3F3j87qnj8DyHpO16rB8bvB22eXZo
	qpoCRZScHu52Bs+iWDKOYXTNvptltxLDZHLm5dTebaRDM56ERM/PP
X-Received: by 2002:a05:622a:754a:b0:55b:9573:e89e with SMTP id d75a77b69052e-55b9573eb16mr22751061cf.74.1794590021935;
        Fri, 13 Nov 2026 09:13:41 -0800 (PST)
X-Received: by 2002:a05:622a:754a:b0:55b:9573:e89e with SMTP id d75a77b69052e-55b9573eb16mr22750321cf.74.1794590021191;
        Fri, 13 Nov 2026 09:13:41 -0800 (PST)
Received: from sgarzare-redhat ([209.52.143.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad1b13917sm22455221cf.29.2026.11.13.09.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:13:40 -0800 (PST)
Date: Fri, 13 Nov 2026 18:13:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: netdev@vger.kernel.org, stefanha@redhat.com, bobbyeshleman@gmail.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/5] vsock/virtio: amortize RX socket locking
 for stream packets
Message-ID: <avdAV2RholA4ana_@sgarzare-redhat>
References: <20261103041134.33310-1-physicalmtea@gmail.com>
 <20261103041134.33310-4-physicalmtea@gmail.com>
 <auxDWISLHB8Ln1x7@sgarzare-redhat>
 <CAJwVaMJbzzK8Sj8DvLjiAyqS8TNgRQ3tjRpGcBNC+anQECg5yw@mail.gmail.com>
 <avXn6E8y5OPtdikQ@sgarzare-redhat>
 <CAJwVaM+SEhbFtORYgVYNayiQED63sCLO5ibwgkcjBRVvMd=KsA@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJwVaM+SEhbFtORYgVYNayiQED63sCLO5ibwgkcjBRVvMd=KsA@mail.gmail.com>

On Fri, Nov 13, 2026 at 04:09:48PM +0800, Jia Jia wrote:
> >
> > On Fri, Nov 06, 2026 at 08:27:51PM +0800, Jia Jia wrote:
> > >>
> > >> On Tue, Nov 03, 2026 at 12:11:32PM +0800, Jia Jia wrote:

[...]

> > >> >+
> > >> >+/* The caller holds sk's socket lock. */
> > >> >+static bool
> > >> >+virtio_transport_rx_batch_can_continue(struct virtio_transport *t,
> > >> >+                                     struct sock *sk, u32 len)
> > >> >+{
> > >> >+      struct virtio_vsock_sock *vvs;
> > >> >+      struct vsock_sock *vsk;
> > >> >+
> > >> >+      vsk = vsock_sk(sk);
> > >> >+      vvs = vsk->trans;
> > >> >+
> > >> >+      /*
> > >> >+       * Keep a connected lookup reference only for the native, established
> > >> >+       * STREAM path. Sockets outside ESTABLISHED can change table membership;
> > >> >+       * a completed or reassigned socket must resume the per-packet path.
> > >> >+       */
> > >> >+      if (sk->sk_state != TCP_ESTABLISHED ||
> > >> >+          sk->sk_type != SOCK_STREAM ||
> > >> >+          sock_flag(sk, SOCK_DONE) ||
> > >> >+          vsk->transport != &t->transport || !vvs)
> > >> >+              return false;
> > >> >+
> > >> >+      /*
> > >> >+       * Do not admit a packet that would hit an existing RX limit while the
> > >> >+       * worker owns the socket lock. The caller holds that lock, so no reader can
> > >> >+       * dequeue until the batch is released.
> > >> >+       */
> > >> >+      return (u64)vvs->buf_used + len <= vvs->buf_alloc &&
> > >> >+             !virtio_transport_rx_buf_full(vvs);
> > >>
> > >
> > >Hi Stefano,
> > >
> > >> I don't understand this. We recently introduce the collapse, so when we
> > >> will call virtio_transport_recv_enqueue(), all the queue will be
> > >> collapsed, including packets in the batch.
> > >>
> > >> Or am I missing something?
> > >>
> > >
> > >Yes, collapse operates on the same receive queue, which also contains
> > >skbs queued earlier in the current batch.
> > >
> > >The rx_buf_full() check is not intended to bypass collapse. It prevents
> > >the batch from retaining the socket lock while processing a packet when
> > >there is no metadata room for another skb. Collapse is best effort:
> > >some skbs cannot be merged, and allocation of a replacement skb can
> >
> > IIUC batches are enabled only for SOCK_STREAM, so, which skbs can't be
> > merged?
> 
> My wording in the previous reply may not have been precise. What I meant
> is that collapse is not guaranteed to free the skb slot needed for the
> incoming packet for every valid receive-buffer configuration.
> 
> With the default 256K receive buffer, a queue of small STREAM skbs will
> normally contain multiple collapse candidates by the time it reaches
> the metadata limit, so collapse will normally make room.
> 
> However, SO_VM_SOCKETS_BUFFER_SIZE is configurable through setsockopt().
> A sufficiently small but valid receive buffer can make queue_max equal
> to one. After the first small packet has been queued, that skb is
> eligible for collapse, but there is no adjacent skb to merge it with.
> virtio_transport_collapse_size() therefore returns only that skb's own
> length, and the skb is kept unchanged.
> 
> The incoming second skb is not in rx_queue yet. Provided that the two
> packets combined payload still fits within buf_alloc, the payload check
> passes, but virtio_transport_inc_rx_pkt() rejects the second packet on
> the metadata check. This happens before the later tail-copy optimization
> is reached.

I'm lost to be honest, why the secondo skb is not collapsed?

> 
> Therefore, this case does not require an ineligible STREAM skb or an
> allocation failure. Collapse simply cannot reduce a one-element queue.
> 
> If my understanding is wrong, please correct me. Thanks.
> 
> >
> > If allocation fails, I guess we have other issues, no?
> >
> 
> Yes. I thought about that again, and allocation failure is not the
> reason for this check. Thanks
> 
> > >fail. If the packet remained in the batch and collapse did not make
> > >enough room, virtio_transport_inc_rx_pkt() would fail and
> > >virtio_transport_recv_connected() would reset the socket with ENOBUFS
> > >while a waiting reader was still unable to drain the queue.
> > >
> > >When the check makes can_continue() return false before the current
> > >packet has been handled, the caller releases the socket lock and passes
> > >the packet to virtio_transport_recv_pkt(). This gives a waiting reader a
> > >chance to make progress. If the queue is still at the metadata limit,
> > >the normal enqueue path attempts collapse. If that still cannot make
> > >enough room, the existing ENOBUFS reset occurs.
> >
> > I really don't see the difference without batching :-(
> >
> > I may be missing something.
> >
> 
> The difference is the release_sock() boundary between packets.
> 
> In the regular per-packet path, the socket lock is released after the
> first packet. A reader woken by that packet can compete for the lock and
> fully dequeue the only skb before RX locks the socket for the second
> packet. If it succeeds, the second packet can be accepted. If it does
> not acquire the lock in time, or only partially consumes the skb, the
> queue length remains one and the regular path can still reach the
> existing ENOBUFS reset.
> 
> Without the rx_buf_full() check, two same-flow packets processed in the
> same active batch remain under one uninterrupted socket-lock ownership
> interval. Once the first packet leaves the only skb in the queue, the
> reader cannot dequeue it before the second packet is processed.

Why?

> Collapse cannot reduce that one-element queue, so the second packet
> fails the metadata check and resets the connection.

What is unclear to me is why this is not happening without batching.

And, why we can't collapse the batch it self...

Thanks,
Stefano

> 
> The check detects this metadata boundary after the first packet and
> finishes the batch. It therefore restores the lock-release opportunity
> that the regular per-packet path had at the same point. It does not
> guarantee that the reader acquires the lock first; it preserves the
> original opportunity to do so.
> 
> Without this check, batching would remove a successful interleaving
> available to the regular path. For this valid receive-buffer
> configuration, when both packets are processed in the same uninterrupted
> batch, an otherwise avoidable reset would become unavoidable. That
> would be a functional regression introduced by batching.
> 
> Thanks,
> Jia
> 
> > Thanks,
> > Stefano
> >
> 

