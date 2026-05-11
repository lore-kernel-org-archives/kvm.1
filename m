Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD46284682
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503589; cv=none; b=Dw0cYL48gVFPEwJ2E4bklmcURiwNM+uiW8M2wlXdIfkLOfxQRxb9Q99JWLUnFYIP9H2f3EPMM9rw25QOZl3OEY2kIqnOI5a6tz9tvO1BNyGeEuAYs4a6QMQkzc51/ox3HrWub/fFg4KOxxYDYRsxXuWAumXWsyvMAo3TWABiHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503589; c=relaxed/simple;
	bh=Ugs/xjDpsbPmanWITKMhKdhwotw3HHy735HCKeIxttI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLCBaB0TeFRUAh2LdtQ7xApgHeiGoq76x1e1f9DhZ/rXgAP1TZhiNyrVxtobWg+fZwgjWuXQRcwUdqWuRX/BMM157OCX7S80UBNXyI/Alqvc95beYrHF7Et0FmjPjI7OI4wzoar4+7P8mmr9L5VgpReh0Fz9O1C5+GAFEfgI0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0LRcqN4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnHpC4b+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0LRcqN4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnHpC4b+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778503587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
	b=W0LRcqN4gs+qriITT1SBBCYAF8XmdmAqHbtHRjo3uf+IxcIkGa+Ael6YZdL7IlDaONSKrH
	rbaICpPr3YnxRt0gty1vhtP8pbI444BrJBY6Tx3/xicmB0QprEADnYMmSGLl9Tez66WRgb
	n6hsmJUL2n7+nkH+CvGYFknHB9oDHSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-LNxvLMp7PwCUcZAUogi9ZA-1; Mon, 11 May 2026 08:46:26 -0400
X-MC-Unique: LNxvLMp7PwCUcZAUogi9ZA-1
X-Mimecast-MFC-AGG-ID: LNxvLMp7PwCUcZAUogi9ZA_1778503585
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso25976005e9.2
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778503585; x=1779108385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
        b=UnHpC4b+7TUffE5IDNk7xeMSjwd43jGXFzk27dViG4rr5UzG/qZhfZ0xmCoRIWNg3m
         csyybr9JbsWRzpVdpFVmAtPRwX81HdJRkfHZZ86AElC4UyyeTgTe4Tz18Nihz5h9CE8T
         7ld3BIjTK+lQCfMaMwa3m6hqdNTqrJ0GyFe6uH7C7PyPSekcXj9Jlc55tInX2gIuG/IZ
         lYlzo70cWp7D6GWlJfCsSL53Qa16iCxu6aATknXh8ElIWLK6g8gfr8f9SLrkg9UxZYN1
         FqYR+JZdNQXCz3kkQNk8A4Ie1335Ye4xU3B1qNVZUNO7na/irlrcha3En2KPGIacy68H
         2j/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778503585; x=1779108385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Xz/1zJ+MWlJ9Av9Kr7QaYQGfRn7oNzrnu40h3srvyM=;
        b=YbqDxFYMfGEAWYcnqnvqXcpvRbbhRZZQmBieW4qVuHIerI+O0RP83kYIe/l8rcQ1Qs
         n3n9/mkNJ1TFJCMDqK/R3LB5VMNPhAcxc+A4Bq5Ip4IqmLamTS7moQ9/U8maExpvbNh/
         wMNDM02QdPtiI3VXOesaDcrsVfoJXgYbq4g3QlExGtbR+TuIBy5XS2qkvY9s/jrab04Y
         9tvtEuO723Rbq34Krtt4mV37BcX8U+29MVl3Jl6ou+UnN9Q8U5KAuonXXnY6ISnyWlak
         ZsrOs5kFuYH73yxBOHCdrlNwLLh986XUzXw+2WDBAgoxn5bVgywIusksMNyAdC8awev5
         QAhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QTBSrg2M/uN2Y+eODHkFYcpaXMew4o/wLQNxfaMRcKARLQ2XLyswjFH+V5McxpH3++Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcRsVRbnwhHzAjluqOOSV9LgRYN5jm6BOyF7krKRfqTPZUmaZ
	i7r7lW2te/I9lnJmqrxyf3fu36bX/uqFXl9hRhJHeizbXP1VdtLpzyZ0u9CTvbmbS3akOdGVZtK
	hmsTi4xUvBezsC6p4R0LZyPt/iA8SFkb4IIcmljYNjWdWMzlfi2ODRg==
X-Gm-Gg: Acq92OHvPT0jXxZyIQG/fYb2d+P93gFSjwejN5B6YnyfoHLEQHB1HG4uzRxRfc9PfQF
	TGNvhgxESg4Ob4T7/KEXlh77lxF7+Eg6YWqgsjvha7fRHzG+lA+z7C+WYanGjAoR6I4jI0J2Kn5
	4ALQpkbx3lyhA/4uG2sSSWHbhVT531msYKLzXXBrJGft/FO+7/NTUH+G5vqUYccEz2kzBY3pfoU
	eYZ89WsA2vcOXNPdVhlPKKtCVVt52kLaP3T4iZLqhRvngpKNdUuksUxABFYn1ltuNTQJHnTnqK7
	x8bq0k0NasIJBCj1tzWxXBVFL06eJnwlbHFuZokfDyzb8o/GNK/KVvF+HBk32XmLFVVH7CpBQLo
	sSK0LnNSSygtbwzM4urKdsvCW9Nt4PVE7GM0MV9pZ
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271700125e9.2.1778503584624;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
X-Received: by 2002:a05:600c:1da8:b0:48e:635a:18d2 with SMTP id 5b1f17b1804b1-48e635a1b95mr271699365e9.2.1778503584063;
        Mon, 11 May 2026 05:46:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d895781sm114542925e9.0.2026.05.11.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:46:23 -0700 (PDT)
Date: Mon, 11 May 2026 08:46:20 -0400
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
Message-ID: <20260511084551-mutt-send-email-mst@kernel.org>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat>
 <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>

On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com> 
> wrote:
> >
> > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >> > >
> > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > >> > > effective receive buffer below what the user configured via
> > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > >> > > silently dropped and applications that rely on the full buffer size
> > >> > > to deadlock.
> > >> > >
> > >> > > Also, the reduced space is not communicated to the remote peer, so
> > >> > > its credit calculation accounts more credit than the receiver will
> > >> > > actually accept, causing data loss (there is no retransmission).
> > >> > >
> > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > >> > >
> > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > >> > >     Resource temporarily unavailable
> > >> > >
> > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > >> > > check, the advertised buf_alloc, and the credit update decision.
> > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > >> > > The function returns buf_alloc as long as overhead fits within the
> > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > >> > > slow down.
> > >> > >
> > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >> >
> > >> >
> > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > >> > it helps.
> > >>
> > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > >>
> > >> >
> > >> > a spec violation because the spec says:
> > >> > Only payload bytes are counted and header bytes are not
> > >> > included
> > >> >
> > >> > and the implication is that a side can not reduce its own buf_alloc.
> > >> >
> > >> > no guarantee because the other side is not required to process your
> > >> > packets, so it might not see your buf alloc reduction.
> > >> >
> > >> > as designed in the current spec, you can only increase your buf alloc,
> > >> > not decrease it.
> > >>
> > >> We never enforced this, currently an user can reduce it by
> > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > >> introduced, should we update the spec?
> > >
> > >
> > >it's not that we need to enforce it, it's that all synchronization
> > >assumes this. as in, anyone can use an old copy until they run out
> > >of credits.
> > >
> > >
> > >> >
> > >> > what can be done:
> > >> > - more efficient storage for small packets (poc i posted)
> > >> > - reduce buf alloc ahead of the time
> > >>
> > >> That's basically what I'm doing here: I'm using twice the size of
> > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > >> the other peer just `buf_alloc`.
> > >>
> > >> But then, somehow, we have to let the other person know that we're running
> > >> out of space. With this patch that only happens when the other peer isn't
> > >> behaving properly, sending so many small packets that the overhead exceeds
> > >> `buf_alloc`.
> > >>
> > >> Stefano
> > >
> > >what is "not proper" here, it is up to the application what to send.
> >
> > Sure, but here we're just slowing down the application by telling it we
> > don't have any more space.
> >
> > Again, without this patch we are just dropping data, which IMO is even
> > worse.
> >
> > So I think we should merge this for now, while we handle better the EOM.
> > If you prefer, I can drop the part where we reduce the buf_alloc
> > advertised to the other peer, but at least we should drop data after
> > `buf_alloc * 2` IMO.
> 
> Okay, I thought it over over the weekend, and I agree that this patch 
> still doesn't solve the problem and would still result in packet loss.
> So, until we resolve the issue permanently, and since 059b7dbd20a6 is 
> coming to stable, I'd like to rework this patch so that we only start 
> dropping packets when the overhead plus the queued bytes exceeds 
> `buf_alloc * 2`.
> Removing the other changes to reduce the buf_alloc advertised, but 
> terminating the connection so that both peers are aware that something 
> went wrong.
> 
> Any objections?
> 
> Stefano

Let's try to first fix it upstream properly please. Discuss backporting
later.

-- 
MST

