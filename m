Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CA3CFF5F
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236402; cv=none; b=i7tDMc75CIcZj8pqmExmNoggkZztB6k6sLilcR6vyrEl6jP9WaCdIGaZjz6pCMdmUdfEHrX//0ob8coNK9zBPT2N3jZGdh0eWgL+rX5e2ljCIj/vByNs8sSNVJcUUQcik0UOHxbQSvilkO81LOXkOESqPVbbJf5NraoYYlIHEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236402; c=relaxed/simple;
	bh=qol90EnXXDrSrjd/vykAjPr3QHnGmGUfUyYQ32R9u4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA+JA4r2KHQyNNDTUIvmMgO9vV0oI2NimSiZkF5kVFL7d6XuBKEuZ0TDmQ9pGQmMO4eB1IGSCT2iQly6zlhF64P5zIIvte6bsLgfeYo9tA1loI6wotHn6pR/53X2/UQT44pZWlvXQSKXxTmJtnq1nIuFFJ7VJM2bh2tb5UwQcus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrXJBym0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQPQ8TFT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrXJBym0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQPQ8TFT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778236399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ju82bmy4dZEitjOvynFPa4kwr04F31Fyfwzj/fLoDtk=;
	b=RrXJBym0ZPT4XzfAYV1QAPQnT3MYo+yQgchYvEBQ5L2Ko/Diazp0Lm+XhChW/lyAnRRVYn
	B2vyPRIEFwYIyrCeUJINrCcqU8x1JfwJgKu0Ir1LT6Dl10lHIOp5i3hXDSR6M/SWRDtiac
	e7zc4s/YbEpp34TEfrQX1qBwynk5iT4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-wnqgQ8RAOM6VGUdZsqM54Q-1; Fri, 08 May 2026 06:33:18 -0400
X-MC-Unique: wnqgQ8RAOM6VGUdZsqM54Q-1
X-Mimecast-MFC-AGG-ID: wnqgQ8RAOM6VGUdZsqM54Q_1778236397
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d789cebcfso1975783f8f.1
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 03:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778236397; x=1778841197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ju82bmy4dZEitjOvynFPa4kwr04F31Fyfwzj/fLoDtk=;
        b=HQPQ8TFT0J2hvuT2Ng3zOPGNQcN7s5yoSCBL1XBJhRUp9jPPlr6aIlUZn7Ab6LB3wA
         Xoa7JZf5rcb0tmuyycRaFx8OCBtTJ6501wMZOSeZDID/fAmrMD17yuFM/Ya341c6tn/T
         G1pBrHUDcxd6oEfgL4igrqTh/IlckitaPA/i/RIvN2R8m2SLKy0NfFX5+5805MCC7xHK
         FZVA133U+6Bwt26REx4mF+a8s5kBG/rso81s1+2n8nFdywBMYtJZ7s4BXSJvxTT3Q8Uu
         ig1FK3h795Z9tOMOBxBGrw6m9baMwymDIcdNNIGVDh7RLzn8dRGcnLeT+Q39CTqvtzAP
         +suQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236397; x=1778841197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ju82bmy4dZEitjOvynFPa4kwr04F31Fyfwzj/fLoDtk=;
        b=GEi0Wuy0DI+04bWARhG5FIPdflopIXorCdvFrsPQIsVPAO93qTc9DIGUZZRxL0N+8k
         8Pe8FhuvC4VncSCINmaCZk78MpGwOrjfon6BqvqsGRMH7gOCg8CuPVrE+8TbDaSMMN5s
         icXfGSaQC5JfmX5XO4C5Izpo+9qHSQ7tpw/Rcv5upJaimEyRoe5jMLSBbtPNhBfYJKK9
         TyPib2YAw8q/WCQn3K4fTMw4y433yaQ/t0MhMQUkpZjM7vk8huplYJ0dWgWJbaoytSti
         xKxUcuyjD8hgGgj4JPxtlRVKZu2mq5QnJRQrKRTYDxr9slXNecpKPd8Fp7FsZSPrCk0o
         mMdA==
X-Forwarded-Encrypted: i=1; AFNElJ+XrtE5qVR4lKGwtO/PhSMXRocLSMIZuvpMrkgUIGRDbfARQ3BRQhdZ9W2/Jn1tVRbyzlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sQveF3R189Sta/RidlieeThSSa3zNo59WFqo8EXv17+uxbVP
	Fe03LYprUhZR11BjOPw6LXe+ANyUB4aX0lEsEpOuHYMaM+oMlAPKGM6w83JaizRT3T8lMufa8sD
	rNPZg2L7EXcOiOJ8PJ36tcI+CPKsBQDPVStdew0lfK3In1rF7g2hTCQ==
X-Gm-Gg: AeBDietOSIjpPkOhQqq5Z1z6XrvaOxI/rTU4OQm2Abq5ys+eQX9pYy4r0qHbgbibkI6
	zpyTjZ6EunpxTJdV8PMZZHcU8zXPSVnuzZ95OIhUTclPh4FqkBDtaX298sv4XYxD8YRPjiuupzT
	oKfQXXRwAd9JMznx51UGJX4VfKKnQ9hjLzNWWcnJpzi8BI++zDjMn4dGTD6IFM47fFQp2P8Ct8b
	4SZg6wGRcw9OjW9uo63g3OGwkIJF0g6yNW+pJD8oEQuA+LuG77RYOwJ7PiPvv//9i2tZ50hNy5G
	tSmngNihcAsjgZFA6owtw/U/KMkpkushh1eyPW/a02v1gZsYYVsRES7e5xE5GvkbgWSDbil3ky1
	MoJUzxMfJ8ONzOVpEQ0lUoV2AJYMlI/Q3x1HKwPioX9/qQGsTfSY=
X-Received: by 2002:a05:600c:15cc:b0:48e:635a:18c3 with SMTP id 5b1f17b1804b1-48e635a19afmr34049115e9.4.1778236397196;
        Fri, 08 May 2026 03:33:17 -0700 (PDT)
X-Received: by 2002:a05:600c:15cc:b0:48e:635a:18c3 with SMTP id 5b1f17b1804b1-48e635a19afmr34048745e9.4.1778236396605;
        Fri, 08 May 2026 03:33:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68ed0f7csm28272525e9.1.2026.05.08.03.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:33:16 -0700 (PDT)
Date: Fri, 8 May 2026 06:33:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260508063104-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2y2Fyp7H-om-ur@sgarzare-redhat>

On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > effective receive buffer below what the user configured via
> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > silently dropped and applications that rely on the full buffer size
> > > to deadlock.
> > > 
> > > Also, the reduced space is not communicated to the remote peer, so
> > > its credit calculation accounts more credit than the receiver will
> > > actually accept, causing data loss (there is no retransmission).
> > > 
> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > 
> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >     Resource temporarily unavailable
> > > 
> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > > check, the advertised buf_alloc, and the credit update decision.
> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > The function returns buf_alloc as long as overhead fits within the
> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > > slow down.
> > > 
> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > 
> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > it helps.
> 
> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> 
> > 
> > a spec violation because the spec says:
> > Only payload bytes are counted and header bytes are not
> > included
> > 
> > and the implication is that a side can not reduce its own buf_alloc.
> > 
> > no guarantee because the other side is not required to process your
> > packets, so it might not see your buf alloc reduction.
> > 
> > as designed in the current spec, you can only increase your buf alloc,
> > not decrease it.
> 
> We never enforced this, currently an user can reduce it by
> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> introduced, should we update the spec?


it's not that we need to enforce it, it's that all synchronization
assumes this. as in, anyone can use an old copy until they run out
of credits.


> > 
> > what can be done:
> > - more efficient storage for small packets (poc i posted)
> > - reduce buf alloc ahead of the time
> 
> That's basically what I'm doing here: I'm using twice the size of
> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> the other peer just `buf_alloc`.
> 
> But then, somehow, we have to let the other person know that we're running
> out of space. With this patch that only happens when the other peer isn't
> behaving properly, sending so many small packets that the overhead exceeds
> `buf_alloc`.
> 
> Stefano

what is "not proper" here, it is up to the application what to send.


> > 
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
> > >  1 file changed, 27 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 9b8014516f4f..94a4beb8fd61 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  	return ret;
> > >  }
> > > 
> > > +/* vvs->rx_lock held by the caller */
> > > +static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
> > > +{
> > > +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> > > +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > +	 */
> > > +	u64 total_budget = (u64)vvs->buf_alloc * 2;
> > > +
> > > +	/* Overhead within buf_alloc: full buf_alloc available for payload */
> > > +	if (skb_overhead < vvs->buf_alloc)
> > > +		return vvs->buf_alloc;
> > > +
> > > +	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
> > > +	if (skb_overhead < total_budget)
> > > +		return total_budget - skb_overhead;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > >  					u32 len)
> > >  {
> > > -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > +	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
> > > 
> > > -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > +	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
> > >  		return false;
> > > 
> > >  	vvs->rx_bytes += len;
> > > @@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
> > >  	spin_lock_bh(&vvs->rx_lock);
> > >  	vvs->last_fwd_cnt = vvs->fwd_cnt;
> > >  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
> > > -	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
> > > +	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
> > >  	spin_unlock_bh(&vvs->rx_lock);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
> > > @@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  	bool low_rx_bytes;
> > >  	int err = -EFAULT;
> > >  	size_t total = 0;
> > > +	u32 rx_buf_size;
> > >  	u32 free_space;
> > > 
> > >  	spin_lock_bh(&vvs->rx_lock);
> > > @@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> > >  	}
> > > 
> > >  	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> > > -	free_space = vvs->buf_alloc - fwd_cnt_delta;
> > > +	rx_buf_size = virtio_transport_rx_buf_size(vvs);
> > > +	free_space = rx_buf_size > fwd_cnt_delta ?
> > > +		     rx_buf_size - fwd_cnt_delta : 0;
> > >  	low_rx_bytes = (vvs->rx_bytes <
> > >  			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
> > > 
> > > --
> > > 2.54.0
> > 

